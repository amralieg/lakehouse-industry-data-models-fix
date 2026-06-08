-- Schema for Domain: project | Business: Mining | Version: v1_ecm
-- Generated on: 2026-05-05 10:54:42

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `mining_ecm`.`project` COMMENT 'Manages capital project lifecycle from feasibility studies through execution, commissioning, and handover. Tracks project schedules, milestones, cost control, risk registers, and stage-gate approvals for mine development, plant expansions, and infrastructure projects.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `mining_ecm`.`project`.`capital_project` (
    `capital_project_id` BIGINT COMMENT 'Unique identifier for the capital project. Primary key for the capital project master record.',
    `business_unit_id` BIGINT COMMENT 'Reference to the sponsoring business unit or division responsible for funding and owning the capital project outcomes.',
    `employee_id` BIGINT COMMENT 'Reference to the employee assigned as the accountable project manager responsible for delivery of scope, schedule, and budget.',
    `capital_sponsor_employee_id` BIGINT COMMENT 'Reference to the senior executive or business leader who sponsors the project and provides strategic direction and funding authority.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: Mining capital projects (mine expansions, processing plants, rail infrastructure) are frequently contracted to EPC contractors, equipment suppliers, or involve joint venture partners who are commercia',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Capital projects roll up to profit centres for segment reporting and JORC reserve category alignment. Mining companies report capex by commodity/site via profit centre hierarchy for investor disclosur',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Capital projects (mine development, processing plants, infrastructure) are executed on specific mining tenements. Project approvals, feasibility, environmental conditions, and regulatory compliance ar',
    `parent_capital_project_id` BIGINT COMMENT 'Self-referencing FK on capital_project (parent_capital_project_id)',
    `actual_completion_date` DATE COMMENT 'Actual date on which the project achieved practical completion and was handed over to operations, marking the end of the execution phase.',
    `actual_start_date` DATE COMMENT 'Actual date on which project execution activities commenced on site, used for schedule performance measurement.',
    `approved_budget_amount` DECIMAL(18,2) COMMENT 'Total capital expenditure budget approved by the board or investment committee for the project, expressed in the reporting currency.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the approved budget amount (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `capex_category` STRING COMMENT 'Financial classification of the project capital expenditure: growth (increase production or reserves), sustaining (maintain current operations), compliance (regulatory or safety mandates), or closure (rehabilitation and post-mining obligations).. Valid values are `growth|sustaining|compliance|closure`',
    `closure_provision_amount` DECIMAL(18,2) COMMENT 'Estimated financial provision for mine rehabilitation and closure obligations associated with the project, required for regulatory compliance and financial reporting.',
    `commissioning_date` DATE COMMENT 'Date on which the project assets were commissioned and began operational testing and ramp-up activities.',
    `commodity` STRING COMMENT 'Primary mineral commodity that the capital project is designed to extract, process, or support. [ENUM-REF-CANDIDATE: iron_ore|copper|coal|lithium|nickel|gold|zinc|lead|bauxite|other — 10 candidates stripped; promote to reference product]',
    `contract_strategy` STRING COMMENT 'Primary contracting and delivery model for the project: EPC (engineering, procurement, construction), EPCM (engineering, procurement, construction management), alliance, construct_only, design_build, or owner_operated.. Valid values are `epc|epcm|alliance|construct_only|design_build|owner_operated`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the capital project record was first created in the system, used for audit trail and data lineage.',
    `design_capacity` DECIMAL(18,2) COMMENT 'Nameplate design capacity of the asset being constructed or expanded, expressed in the appropriate unit of measure for the commodity (e.g., tonnes per annum for processing plants, metres for shafts).',
    `design_capacity_unit` STRING COMMENT 'Unit of measure for the design capacity: tpa (tonnes per annum), mtpa (million tonnes per annum), mw (megawatts), km (kilometres), m (metres), or units (discrete items).. Valid values are `tpa|mtpa|mw|km|m|units`',
    `eis_reference_number` STRING COMMENT 'Official reference number of the environmental impact statement submitted to regulatory authorities for the project.',
    `environmental_approval_status` STRING COMMENT 'Status of environmental impact statement (EIS) and regulatory approvals required for the project to proceed, critical for permitting and compliance.. Valid values are `not_required|pending|approved|conditional|rejected`',
    `forecast_completion_cost` DECIMAL(18,2) COMMENT 'Current forecast of the total cost to complete the project, including all committed and anticipated expenditures, used for variance analysis and cost control.',
    `forecast_completion_date` DATE COMMENT 'Current forecast date for project completion based on progress to date and remaining work, used for schedule variance analysis.',
    `handover_date` DATE COMMENT 'Date on which the completed project was formally handed over from the project team to the operational business unit, transferring accountability for ongoing performance.',
    `irr_percentage` DECIMAL(18,2) COMMENT 'Internal rate of return percentage calculated during feasibility studies, representing the discount rate at which NPV equals zero, used to assess project viability.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the capital project record was last modified, used for change tracking and audit purposes.',
    `life_of_mine_years` DECIMAL(18,2) COMMENT 'Expected operational life of the mine or asset in years, used for project economic modeling and closure planning.',
    `npv_amount` DECIMAL(18,2) COMMENT 'Net present value of the project calculated during feasibility studies, representing the discounted cash flow value used for investment decision-making.',
    `payback_period_years` DECIMAL(18,2) COMMENT 'Number of years required for the project to recover its initial capital investment from net cash flows, used as a simple investment metric.',
    `planned_completion_date` DATE COMMENT 'Scheduled date for project commissioning and handover to operations, as per the approved baseline schedule.',
    `planned_start_date` DATE COMMENT 'Scheduled date for mobilization and commencement of project execution activities, as per the approved project plan.',
    `project_code` STRING COMMENT 'Externally-known unique business identifier for the capital project, used across all project documentation, approvals, and financial systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `project_description` STRING COMMENT 'Detailed narrative description of the project scope, objectives, deliverables, and strategic rationale, used in business cases and governance documentation.',
    `project_name` STRING COMMENT 'Full descriptive name of the capital project as it appears in executive reports and stage-gate documentation.',
    `project_status` STRING COMMENT 'Current lifecycle status of the capital project: concept (initial scoping), pre-feasibility (preliminary economic assessment), feasibility (detailed study), approved (sanctioned for execution), execution (construction underway), commissioning (testing and ramp-up), closed (handed over to operations), cancelled, or on_hold (suspended pending review). [ENUM-REF-CANDIDATE: concept|pre_feasibility|feasibility|approved|execution|commissioning|closed|cancelled|on_hold — 9 candidates stripped; promote to reference product]',
    `project_type` STRING COMMENT 'Classification of the capital project by development approach: greenfield (new mine site), brownfield (existing site development), sustaining capital (maintain current production), expansion (increase capacity), closure (rehabilitation and decommissioning), or infrastructure (roads, power, water).. Valid values are `greenfield|brownfield|sustaining_capital|expansion|closure|infrastructure`',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the project based on aggregated risk register assessments covering technical, commercial, environmental, and execution risks.. Valid values are `low|medium|high|critical`',
    `sanction_date` DATE COMMENT 'Date on which the project received final investment decision (FID) approval from the board or investment committee, authorizing full execution.',
    `stage_gate_phase` STRING COMMENT 'Current stage-gate approval phase in the project governance framework: gate_0 (ideation), gate_1 (scoping), gate_2 (business case), gate_3 (development), gate_4 (testing and validation), gate_5 (launch and review).. Valid values are `gate_0|gate_1|gate_2|gate_3|gate_4|gate_5`',
    `strategic_alignment` STRING COMMENT 'Description of how the project aligns with corporate strategy, business unit objectives, and long-term portfolio plans.',
    CONSTRAINT pk_capital_project PRIMARY KEY(`capital_project_id`)
) COMMENT 'Master record for every capital project in the mining portfolio, covering mine development, plant expansions, shaft sinking, tailings raises, and infrastructure builds. Captures project identity, type (greenfield, brownfield, sustaining capital, closure), site location, sponsoring business unit, project classification (CAPEX category), approved budget, current phase, stage-gate status, project manager, and key lifecycle dates (sanction, mobilisation, commissioning, handover). Serves as the SSOT anchor for all project domain entities.';

CREATE OR REPLACE TABLE `mining_ecm`.`project`.`stage_gate` (
    `stage_gate_id` BIGINT COMMENT 'Unique identifier for the stage gate review point within the capital project lifecycle framework.',
    `capital_project_id` BIGINT COMMENT 'Reference to the capital project to which this stage gate belongs.',
    `competent_person_id` BIGINT COMMENT 'Reference to the qualified competent person who signed off on technical reports and resource/reserve estimates for this stage gate.',
    `ore_reserve_id` BIGINT COMMENT 'Foreign key linking to exploration.ore_reserve. Business justification: Stage gate reviews, particularly FID gates, require reserve estimates to justify project sanction. Reserve confidence (Proved/Probable) is a mandatory gate criterion. Links gate decision to the reserv',
    `primary_next_gate_stage_gate_id` BIGINT COMMENT 'Reference to the subsequent stage gate in the project lifecycle sequence.',
    `resource_estimate_id` BIGINT COMMENT 'Foreign key linking to exploration.resource_estimate. Business justification: Stage gate reviews assess resource confidence as a key decision criterion. Gate criteria include resource classification (Measured/Indicated/Inferred), tonnage, and grade. Decision-makers need to see ',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Stage gate reviews assess tenement-specific factors including resource confidence, tenure security, regulatory approvals, native title status, heritage clearances, and environmental conditions before ',
    `preceding_stage_gate_id` BIGINT COMMENT 'Self-referencing FK on stage_gate (preceding_stage_gate_id)',
    `actual_review_date` DATE COMMENT 'Actual date when the stage gate review meeting was conducted.',
    `approval_conditions` STRING COMMENT 'Specific conditions, requirements, or actions that must be satisfied for conditional approval or before proceeding to the next stage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stage gate record was first created in the system.',
    `decision_authority` STRING COMMENT 'Governance body or role authorized to approve or reject this stage gate (e.g., Board, ExCo, Project Review Committee).. Valid values are `board|executive_committee|project_review_committee|steering_committee|project_director|general_manager`',
    `decision_date` DATE COMMENT 'Date when the formal stage gate decision (approval, rejection, deferral) was made by the decision authority.',
    `decision_outcome` STRING COMMENT 'Final decision outcome from the stage gate review process.. Valid values are `approved|conditional_approval|rejected|deferred|cancelled`',
    `environmental_approval_status` STRING COMMENT 'Status of environmental impact assessment and regulatory approvals required at this stage gate.. Valid values are `not_required|pending|in_progress|approved|rejected`',
    `estimated_capex_usd` DECIMAL(18,2) COMMENT 'Estimated total capital expenditure for the project at this stage gate, expressed in USD.',
    `estimated_irr_percent` DECIMAL(18,2) COMMENT 'Estimated internal rate of return for the project at this stage gate, expressed as a percentage.',
    `estimated_npv_usd` DECIMAL(18,2) COMMENT 'Estimated net present value of the project at this stage gate, used as a key financial decision criterion.',
    `gate_chair_name` STRING COMMENT 'Name of the individual who chaired the stage gate review meeting.',
    `gate_code` STRING COMMENT 'Standardized code identifying the stage gate (e.g., G0, G1, G2, G3, G4, G5).. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `gate_criteria` STRING COMMENT 'Specific evaluation criteria and success metrics that must be met for gate approval (e.g., minimum NPV threshold, IRR target, risk assessment completion, regulatory approvals obtained).',
    `gate_description` STRING COMMENT 'Detailed description of the purpose, scope, and objectives of this stage gate within the project governance framework.',
    `gate_duration_days` STRING COMMENT 'Typical or actual duration in days allocated for completing the stage gate review process from submission to decision.',
    `gate_name` STRING COMMENT 'Descriptive name of the stage gate (e.g., Gate 0 Concept, Gate 1 Pre-Feasibility, Gate 2 Feasibility, Gate 3 Execution Approval, Gate 4 Commissioning, Gate 5 Handover).',
    `gate_sequence` STRING COMMENT 'Sequential order of this gate within the project lifecycle (e.g., 0, 1, 2, 3, 4, 5).',
    `gate_status` STRING COMMENT 'Current status of the stage gate review and decision process. [ENUM-REF-CANDIDATE: pending|in_review|approved|conditional_approval|rejected|deferred|cancelled — 7 candidates stripped; promote to reference product]',
    `gate_type` STRING COMMENT 'Classification of the stage gate within the project lifecycle framework.. Valid values are `concept|pre_feasibility|feasibility|execution_approval|commissioning|handover`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this stage gate record is currently active in the project lifecycle or has been superseded or archived.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this stage gate is mandatory for all projects or optional based on project size, complexity, or risk profile.',
    `regulatory_approval_status` STRING COMMENT 'Status of mining permits, licenses, and other regulatory approvals required at this stage gate.. Valid values are `not_required|pending|in_progress|approved|rejected`',
    `rejection_reason` STRING COMMENT 'Documented rationale for rejecting the stage gate, including key concerns or deficiencies identified during review.',
    `required_deliverables` STRING COMMENT 'Comprehensive list of mandatory deliverables, documents, and artifacts that must be completed and submitted for this stage gate review (e.g., feasibility study, resource estimate, environmental impact statement, financial model).',
    `reserve_estimate_confidence` STRING COMMENT 'Confidence level of the ore reserve estimate at this stage gate, aligned with JORC or NI 43-101 classification (Probable, Proved).. Valid values are `not_applicable|probable|proved`',
    `resource_estimate_confidence` STRING COMMENT 'Confidence level of the mineral resource estimate at this stage gate, aligned with JORC or NI 43-101 classification (Inferred, Indicated, Measured).. Valid values are `inferred|indicated|measured`',
    `review_committee_members` STRING COMMENT 'List of committee members who participated in the stage gate review and decision process.',
    `risk_assessment_summary` STRING COMMENT 'Summary of key risks identified and assessed at this stage gate, including technical, financial, environmental, regulatory, and operational risks.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the project at this stage gate based on risk assessment.. Valid values are `low|medium|high|critical`',
    `scheduled_review_date` DATE COMMENT 'Planned date for the stage gate review meeting and decision.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this stage gate record was last modified.',
    CONSTRAINT pk_stage_gate PRIMARY KEY(`stage_gate_id`)
) COMMENT 'Master record of each formal stage-gate review point within a capital project lifecycle. Defines the gate name (e.g., Gate 0 Concept, Gate 1 Pre-Feasibility, Gate 2 Feasibility, Gate 3 Execution Approval, Gate 4 Commissioning, Gate 5 Handover), required deliverables checklist, decision authority level (Board, ExCo, Project Review Committee), and gate criteria. Acts as the reference framework for project governance and approval sequencing.';

CREATE OR REPLACE TABLE `mining_ecm`.`project`.`gate_decision` (
    `gate_decision_id` BIGINT COMMENT 'Unique identifier for the stage-gate decision record. Primary key for the gate decision entity.',
    `capital_project_id` BIGINT COMMENT 'Reference to the capital project undergoing stage-gate review. Links this decision to the parent project entity.',
    `cost_estimate_id` BIGINT COMMENT 'Foreign key linking to project.cost_estimate. Business justification: Gate decisions are based on specific cost estimates presented at the gate review. Currently gate_decision captures npv_at_decision and irr_at_decision but not which cost_estimate was used. This is a c',
    `feasibility_study_id` BIGINT COMMENT 'Foreign key linking to project.feasibility_study. Business justification: Gate decisions review feasibility studies. The decision is based on the study presented at the gate. Currently no link exists between the decision and the study it reviewed. This is a critical review ',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to project.project_budget. Business justification: Gate decisions approve budgets. When a gate is passed with approval outcome, a project_budget is sanctioned. Currently gate_decision has approved_budget_amount but not a FK to the actual budget record',
    `stage_gate_id` BIGINT COMMENT 'Foreign key linking to project.stage_gate. Business justification: Gate decisions are made AT specific stage gates. Currently gate_decision has gate_code and gate_name (STRING) which duplicate data from stage_gate. Adding stage_gate_id FK allows joining to get gate_c',
    `deferred_gate_decision_id` BIGINT COMMENT 'Self-referencing FK on gate_decision (deferred_gate_decision_id)',
    `approved_budget_amount` DECIMAL(18,2) COMMENT 'Total budget amount approved for the project stage following this gate decision. Represents the Capital Expenditure (CAPEX) authorization for the next phase. Null for Deferred or Rejected outcomes.',
    `approved_budget_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the approved budget amount (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `attendees` STRING COMMENT 'Comma-separated list of names or identifiers of key attendees present at the gate decision meeting. Provides audit trail of decision participants.',
    `compliance_review_status` STRING COMMENT 'Status of regulatory and compliance review at the time of the gate decision. Indicates whether the project meets all applicable legal, environmental, safety, and regulatory requirements.. Valid values are `Passed|Failed|Not Required|Pending`',
    `conditions_attached` STRING COMMENT 'Detailed list of conditions that must be satisfied for a Conditional Approval decision. May include requirements for additional studies, risk mitigation actions, budget adjustments, or stakeholder approvals. Null for Approved, Deferred, or Rejected outcomes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this gate decision record was first created in the system. Audit trail for data lineage.',
    `decision_authority_name` STRING COMMENT 'Full name of the individual or committee who made the gate decision (e.g., Chief Executive Officer, Capital Allocation Committee, Board of Directors).',
    `decision_authority_role` STRING COMMENT 'Role or title of the decision authority (e.g., CEO, CFO, Capital Steering Committee Chair, Board Investment Committee).',
    `decision_date` DATE COMMENT 'Date on which the stage-gate decision was formally made by the decision authority. Represents the official sanction or rejection date for project progression.',
    `decision_notes` STRING COMMENT 'Additional notes, comments, or observations recorded during the gate decision process. Captures context and nuances not covered in other structured fields.',
    `decision_outcome` STRING COMMENT 'Final outcome of the stage-gate review. Approved: project may proceed to next stage unconditionally. Conditional Approval: project may proceed subject to conditions. Deferred: decision postponed pending additional information. Rejected: project not sanctioned to proceed.. Valid values are `Approved|Conditional Approval|Deferred|Rejected`',
    `decision_rationale` STRING COMMENT 'Summary of the business rationale and key considerations that led to the decision outcome. Captures strategic alignment, risk assessment, financial justification, and other factors.',
    `environmental_approval_status` STRING COMMENT 'Status of environmental approvals and Environmental Impact Statement (EIS) at the time of the gate decision. Critical for mining projects requiring regulatory environmental clearance.. Valid values are `Approved|Pending|Not Required|Rejected`',
    `irr_at_decision` DECIMAL(18,2) COMMENT 'Internal Rate of Return (IRR) percentage of the project as presented at the time of the gate decision. Expressed as a percentage (e.g., 15.50 represents 15.50%).',
    `last_modified_by` STRING COMMENT 'User ID or name of the individual who last modified this gate decision record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this gate decision record was last modified. Audit trail for data lineage and change tracking.',
    `meeting_reference` STRING COMMENT 'Reference identifier for the governance meeting or board session at which the gate decision was made (e.g., meeting ID, minutes reference number).',
    `next_gate_code` STRING COMMENT 'Code of the next stage-gate the project will face following this decision. Null if project is rejected or closed out.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `next_gate_target_date` DATE COMMENT 'Target date for the next stage-gate review. Establishes the timeline expectation for project progression. Null if project is rejected or closed out.',
    `npv_at_decision` DECIMAL(18,2) COMMENT 'Net Present Value (NPV) of the project as presented at the time of the gate decision. Key financial metric used in the decision-making process.',
    `payback_period_years` DECIMAL(18,2) COMMENT 'Estimated payback period in years for the project investment as presented at the time of the gate decision.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the project at the time of the gate decision. Reflects aggregated assessment of technical, financial, operational, environmental, and regulatory risks.. Valid values are `Low|Medium|High|Critical`',
    `safety_review_status` STRING COMMENT 'Status of health and safety review at the time of the gate decision. Ensures project design and execution plans meet occupational health and safety standards.. Valid values are `Approved|Conditional|Pending|Not Required`',
    `stakeholder_consultation_status` STRING COMMENT 'Status of stakeholder consultation and engagement activities at the time of the gate decision. Includes community, indigenous groups, government, and other key stakeholders.. Valid values are `Complete|In Progress|Not Required|Pending`',
    `strategic_alignment_score` STRING COMMENT 'Quantitative score (typically 1-10 or 1-100) representing how well the project aligns with the organizations strategic objectives and priorities. Higher scores indicate stronger alignment.',
    `supporting_document_references` STRING COMMENT 'Comma-separated list of document identifiers or file paths referencing supporting materials for the gate decision (e.g., feasibility study reports, financial models, risk registers, environmental impact assessments, board papers).',
    `voting_outcome` STRING COMMENT 'Summary of voting results if the decision was made by committee vote (e.g., 5 for, 1 against, 0 abstentions). Null if decision was made by single authority.',
    `created_by` STRING COMMENT 'User ID or name of the individual who created this gate decision record in the system.',
    CONSTRAINT pk_gate_decision PRIMARY KEY(`gate_decision_id`)
) COMMENT 'Transactional record of each stage-gate review decision made for a capital project. Captures the gate reviewed, decision date, decision outcome (Approved, Conditional Approval, Deferred, Rejected), decision authority name and role, conditions attached to conditional approvals, next gate target date, and supporting documentation references. Provides the formal governance audit trail for project sanction and progression.';

CREATE OR REPLACE TABLE `mining_ecm`.`project`.`feasibility_study` (
    `feasibility_study_id` BIGINT COMMENT 'Unique identifier for the feasibility study record. Primary key.',
    `capital_project_id` BIGINT COMMENT 'Reference to the parent capital project for which this feasibility study was conducted.',
    `competent_person_id` BIGINT COMMENT 'Reference to the competent person (as defined by JORC, NI 43-101, or SAMREC) who signed off on the mineral resource and ore reserve estimates within the study.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Feasibility study costs charge to exploration/evaluation cost centres for IFRS 6 compliance. Mining companies track pre-feasibility and feasibility expenditure via cost centres for capitalization vs e',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: Mining feasibility studies often involve external funding partners, joint venture participants, or strategic offtake partners whose financial participation and commercial terms are documented in the s',
    `laboratory_id` BIGINT COMMENT 'Foreign key linking to laboratory.laboratory. Business justification: Feasibility studies specify which accredited laboratory will perform analytical and metallurgical testwork. Critical for JORC Table 1 documentation, quality assurance, and ensuring analytical data mee',
    `ore_reserve_id` BIGINT COMMENT 'Foreign key linking to exploration.ore_reserve. Business justification: Feasibility studies convert resources to reserves by applying modifying factors. The study output is often a reserve estimate that becomes the basis for project sanction. Links study deliverable to it',
    `resource_estimate_id` BIGINT COMMENT 'Foreign key linking to exploration.resource_estimate. Business justification: Feasibility studies evaluate economic viability of specific resource estimates. Study scope, mine design, and financial models are all built on the resource tonnage and grade. Core business relationsh',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Feasibility studies model production of specific saleable products with defined grades and specifications. NPV calculations, production rate estimates, and marketing studies all reference target produ',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Feasibility studies (PFS, DFS, BFS) evaluate economic viability of mineral resources on specific tenements. Study scope, resource estimates, mining rights, regulatory pathway, and environmental approv',
    `superseded_feasibility_study_id` BIGINT COMMENT 'Self-referencing FK on feasibility_study (superseded_feasibility_study_id)',
    `annual_production_rate` DECIMAL(18,2) COMMENT 'Planned annual production rate of the primary commodity as determined by the feasibility study.',
    `approval_date` DATE COMMENT 'Date when the feasibility study received formal approval from the investment committee or board.',
    `approval_status` STRING COMMENT 'Approval status of the completed feasibility study by the investment committee or board: Pending Approval (submitted awaiting decision), Approved (endorsed for next stage), Rejected (not endorsed), Conditionally Approved (approved with conditions to be met), or Withdrawn (removed from consideration).. Valid values are `Pending Approval|Approved|Rejected|Conditionally Approved|Withdrawn`',
    `capital_cost_class` STRING COMMENT 'AACE International cost estimate classification: Class 5 (order of magnitude, -20% to -50% / +30% to +100%), Class 4 (study or feasibility, -15% to -30% / +20% to +50%), Class 3 (budget authorization or control, -10% to -20% / +10% to +30%), Class 2 (control or bid/tender, -5% to -15% / +5% to +20%), Class 1 (check estimate or bid/tender, -3% to -10% / +3% to +15%).. Valid values are `Class 5|Class 4|Class 3|Class 2|Class 1`',
    `capital_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the capital cost estimate (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `capital_cost_estimate` DECIMAL(18,2) COMMENT 'Total estimated capital expenditure required for the project as determined by the feasibility study, including mine development, plant construction, infrastructure, and pre-production costs.',
    `commodity_price_assumption` DECIMAL(18,2) COMMENT 'Long-term commodity price assumption used in the economic evaluation of the feasibility study.',
    `commodity_price_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the commodity price assumption (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `commodity_price_unit` STRING COMMENT 'Unit of measure for the commodity price assumption: per tonne, per ounce, per pound, or per kilogram.. Valid values are `per tonne|per ounce|per pound|per kilogram`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this feasibility study record was first created in the system.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Discount rate (as a percentage) used in the NPV and DCF calculations, typically representing the weighted average cost of capital (WACC) or hurdle rate.',
    `environmental_approval_status` STRING COMMENT 'Status of environmental approvals and permits required for the project as assessed in the feasibility study: Not Required, Pending (not yet submitted), In Progress (under review by regulatory authorities), Approved (permits granted), or Rejected (permits denied).. Valid values are `Not Required|Pending|In Progress|Approved|Rejected`',
    `exchange_rate_assumption` DECIMAL(18,2) COMMENT 'Foreign exchange rate assumption used in the economic evaluation, if the project operates in a currency different from the reporting currency.',
    `irr` DECIMAL(18,2) COMMENT 'Internal rate of return calculated in the feasibility study, representing the discount rate at which the NPV of the project equals zero.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this feasibility study record was last updated in the system.',
    `lead_consultant` STRING COMMENT 'Name of the primary external consulting firm or engineering company responsible for conducting the feasibility study.',
    `life_of_mine_years` DECIMAL(18,2) COMMENT 'Estimated life of mine in years as determined by the feasibility study, based on the ore reserve estimate and planned production rate.',
    `npv` DECIMAL(18,2) COMMENT 'Net present value of the project calculated in the feasibility study, representing the present value of future cash flows discounted at the specified discount rate.',
    `npv_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the NPV calculation (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `operating_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the operating cost estimate (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `operating_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated annual or life-of-mine average operating expenditure as determined by the feasibility study, including mining, processing, general and administrative costs.',
    `operating_cost_unit` STRING COMMENT 'Unit of measure for the operating cost estimate: per tonne ore processed, per tonne of product, per ounce of metal, per pound of metal, or per annum (annual total).. Valid values are `per tonne ore|per tonne product|per ounce|per pound|per annum`',
    `payback_period_years` DECIMAL(18,2) COMMENT 'Estimated payback period in years, representing the time required to recover the initial capital investment from project cash flows.',
    `production_rate_unit` STRING COMMENT 'Unit of measure for the annual production rate: tonnes, ounces, pounds, or kilograms of the primary commodity.. Valid values are `tonnes|ounces|pounds|kilograms`',
    `risk_assessment_completed` BOOLEAN COMMENT 'Indicates whether a comprehensive risk assessment was conducted as part of the feasibility study, covering technical, financial, environmental, social, and regulatory risks.',
    `sensitivity_analysis_completed` BOOLEAN COMMENT 'Indicates whether sensitivity analysis was performed to assess the impact of key variables (commodity price, operating costs, capital costs, exchange rates) on project economics.',
    `social_impact_assessment_completed` BOOLEAN COMMENT 'Indicates whether a social impact assessment was conducted to evaluate the projects effects on local communities, indigenous peoples, and other stakeholders.',
    `study_completion_date` DATE COMMENT 'Date when the feasibility study was completed and finalized for submission.',
    `study_document_reference` STRING COMMENT 'Reference identifier or file path to the full feasibility study report document stored in the document management system.',
    `study_name` STRING COMMENT 'Descriptive name of the feasibility study, typically including the project name and study type.',
    `study_number` STRING COMMENT 'Externally-known unique business identifier for the feasibility study, typically assigned by the project management office or engineering team.',
    `study_scope` STRING COMMENT 'Detailed description of the scope of work covered by the feasibility study, including technical, economic, environmental, and social aspects evaluated.',
    `study_start_date` DATE COMMENT 'Date when the feasibility study work officially commenced.',
    `study_status` STRING COMMENT 'Current lifecycle status of the feasibility study: Planned (scheduled but not started), In Progress (actively being conducted), Under Review (submitted for internal or external review), Completed (finalized and approved), Cancelled (terminated before completion), or On Hold (temporarily suspended).. Valid values are `Planned|In Progress|Under Review|Completed|Cancelled|On Hold`',
    `study_type` STRING COMMENT 'Classification of the study level: Scoping Study (conceptual), Pre-Feasibility Study (PFS - preliminary economic assessment), Definitive Feasibility Study (DFS - detailed engineering and economics), Bankable Feasibility Study (BFS - investment-grade), Trade-Off Study (comparison of alternatives), or Optimization Study (refinement of existing design).. Valid values are `Scoping Study|Pre-Feasibility Study|Definitive Feasibility Study|Bankable Feasibility Study|Trade-Off Study|Optimization Study`',
    CONSTRAINT pk_feasibility_study PRIMARY KEY(`feasibility_study_id`)
) COMMENT 'Master record for feasibility and pre-feasibility studies conducted for capital projects. Captures study type (Scoping, Pre-Feasibility Study PFS, Definitive Feasibility Study DFS, Bankable Feasibility Study BFS), study scope, lead consultant, study start and completion dates, NPV and IRR outputs, capital cost estimate (Class 1-5 per AACE), operating cost estimate, study status, and approval status. Links to the parent capital project and competent person sign-off.';

CREATE OR REPLACE TABLE `mining_ecm`.`project`.`phase` (
    `phase_id` BIGINT COMMENT 'Unique identifier for the project phase record. Primary key.',
    `capital_project_id` BIGINT COMMENT 'Reference to the parent capital project to which this phase belongs. Links phase to the overall project lifecycle.',
    `employee_id` BIGINT COMMENT 'Reference to the employee responsible for managing and delivering this specific phase. May differ from overall project manager for large multi-phase projects.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Project phases align to WBS hierarchy for phase-gate cost tracking and capitalization decisions. Mining projects capitalize costs by phase (engineering, construction, commissioning) via WBS structure.',
    `predecessor_phase_id` BIGINT COMMENT 'Self-referencing FK on phase (predecessor_phase_id)',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total actual costs incurred to date for this phase, aggregated from all cost elements and work breakdown structure (WBS) elements within the phase.',
    `actual_duration_days` STRING COMMENT 'Actual elapsed duration of the phase in calendar days from actual start to actual finish. Null if phase not yet completed.',
    `actual_finish_date` DATE COMMENT 'Actual date when the phase was completed and formally closed. Null if phase is still in progress or not started.',
    `actual_start_date` DATE COMMENT 'Actual date when work on the phase commenced. Null if phase has not yet started.',
    `baseline_duration_days` STRING COMMENT 'Approved baseline duration for the phase in calendar days, calculated from planned start to planned finish.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total approved budget allocated to this phase in the projects reporting currency. Represents the baseline cost for phase execution including Capital Expenditure (CAPEX) and Operating Expenditure (OPEX) components.',
    `committed_cost` DECIMAL(18,2) COMMENT 'Total committed costs for this phase including purchase orders, contracts, and other financial commitments not yet invoiced.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Current physical completion percentage of the phase based on earned value or milestone achievement. Value between 0.00 and 100.00.',
    `cost_variance_amount` DECIMAL(18,2) COMMENT 'Current cost variance calculated as phase budget minus phase forecast cost. Negative values indicate cost overrun.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this phase record was first created in the system. Audit trail for data lineage.',
    `critical_path_flag` BOOLEAN COMMENT 'Indicates whether this phase is on the projects critical path. True if any delay in this phase will delay overall project completion.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this phase record (e.g., USD, AUD, CAD, ZAR).. Valid values are `^[A-Z]{3}$`',
    `forecast_cost` DECIMAL(18,2) COMMENT 'Current forecast of total cost at completion for this phase, updated regularly based on actuals, commitments, and estimates to complete.',
    `forecast_finish_date` DATE COMMENT 'Current best estimate of when the phase will complete, updated regularly based on progress and risks. Used for schedule variance analysis.',
    `gate_approval_authority` STRING COMMENT 'Name or title of the governance body or individual who granted stage-gate approval (e.g., Executive Committee, Board of Directors, Capital Allocation Committee).',
    `gate_approval_date` DATE COMMENT 'Date when formal stage-gate approval was granted for this phase to proceed. Null if approval not yet obtained or not required.',
    `gate_approval_required` BOOLEAN COMMENT 'Indicates whether formal stage-gate approval is required before this phase can commence. True if governance approval is mandatory.',
    `key_deliverables` STRING COMMENT 'Summary list of major deliverables and outputs expected from this phase (e.g., feasibility study report, detailed engineering drawings, procurement contracts, construction completion certificate).',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, issues, decisions, or commentary related to phase execution and performance.',
    `phase_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the phase type within the organizations project methodology (e.g., CONCEPT, PREFEAS, FEAS, FEED, DETAIL_ENG, PROCURE, CONSTRUCT, COMMISSION, HANDOVER, CLOSEOUT).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `phase_description` STRING COMMENT 'Detailed description of the phase scope, objectives, key deliverables, and success criteria. Provides context for phase execution and governance.',
    `phase_name` STRING COMMENT 'Full descriptive name of the project phase (e.g., Concept Study, Pre-Feasibility Study, Feasibility Study, Front-End Engineering Design, Detailed Engineering, Procurement, Construction, Commissioning, Handover, Project Closeout).',
    `phase_status` STRING COMMENT 'Current execution status of the project phase indicating its lifecycle state.. Valid values are `not_started|in_progress|on_hold|completed|cancelled|deferred`',
    `planned_finish_date` DATE COMMENT 'Scheduled date when the phase is planned to complete according to the baseline project schedule.',
    `planned_start_date` DATE COMMENT 'Scheduled date when the phase is planned to commence according to the baseline project schedule.',
    `record_active_flag` BOOLEAN COMMENT 'Indicates whether this phase record is currently active and valid. False if the record has been logically deleted or superseded.',
    `risk_rating` STRING COMMENT 'Overall risk assessment for this phase based on schedule, cost, technical, and external risk factors. Used for prioritizing management attention.. Valid values are `low|medium|high|critical`',
    `schedule_variance_days` STRING COMMENT 'Current schedule variance in calendar days, calculated as the difference between forecast finish and planned finish. Negative values indicate delay.',
    `sequence` STRING COMMENT 'Ordinal position of this phase within the projects overall phase sequence. Used to enforce phase ordering and dependencies.',
    `updated_by_user` STRING COMMENT 'Username or identifier of the user who last updated this phase record. Supports audit and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this phase record was last modified. Audit trail for change tracking.',
    CONSTRAINT pk_phase PRIMARY KEY(`phase_id`)
) COMMENT 'Defines the discrete execution phases of a capital project (Concept, Pre-Feasibility, Feasibility, FEED, Detailed Engineering, Procurement, Construction, Commissioning, Handover, Closeout). Captures phase name, planned start and finish dates, actual start and finish dates, phase budget allocation, phase status, and responsible project manager. Enables phase-level schedule and cost tracking within a project.';

CREATE OR REPLACE TABLE `mining_ecm`.`project`.`schedule` (
    `schedule_id` BIGINT COMMENT 'Unique identifier for the project schedule record. Primary key.',
    `capital_project_id` BIGINT COMMENT 'Reference to the capital project or phase that this schedule belongs to. Links to the parent project entity.',
    `superseded_schedule_id` BIGINT COMMENT 'Self-referencing FK on schedule (superseded_schedule_id)',
    `actual_completion_date` DATE COMMENT 'Actual date when the project or phase was completed and handed over. Populated upon project closure.',
    `approved_by` STRING COMMENT 'Name or identifier of the project manager, project director, or governance authority who approved this schedule version. Critical for baseline control and change management.',
    `baseline_approval_date` DATE COMMENT 'Date when the schedule baseline was formally approved by the project governance board or steering committee. Critical for earned value management and schedule variance analysis.',
    `completed_activities_count` STRING COMMENT 'Number of activities that have been completed as of the schedule status date. Used to calculate percent complete and progress metrics.',
    `compression_method` STRING COMMENT 'Method applied to compress the schedule and reduce project duration. Fast tracking involves overlapping activities that were originally sequential. Crashing involves adding resources to critical path activities. Both may be applied simultaneously.. Valid values are `none|fast_tracking|crashing|both`',
    `contingency_days` DECIMAL(18,2) COMMENT 'Time buffer or contingency reserve built into the schedule to account for schedule risks and uncertainties. Managed as part of schedule risk management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this schedule record was first created in the system. Used for audit trail and data lineage.',
    `critical_activities_count` STRING COMMENT 'Number of activities on the critical path. Used to assess schedule risk concentration and management focus areas.',
    `critical_path_flag` BOOLEAN COMMENT 'Indicates whether this schedule version identifies activities on the critical path. True if critical path analysis has been performed and critical activities are flagged in the detailed schedule.',
    `data_date` DATE COMMENT 'Status date or as-of date for the schedule. Represents the point in time up to which actual progress has been recorded and from which forecasts are projected. Critical reference point for earned value calculations.',
    `forecast_completion_date` DATE COMMENT 'Current projected completion date based on actual progress, remaining work, and schedule performance trends. Updated regularly as part of schedule control processes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this schedule record was last modified. Used for audit trail and change tracking.',
    `last_update_date` DATE COMMENT 'Date when the schedule was last updated with actual progress and forecast changes. Used to assess schedule data currency.',
    `longest_path_duration_days` DECIMAL(18,2) COMMENT 'Duration in days of the longest path through the schedule network from start to finish. Represents the minimum project duration assuming no resource constraints.',
    `notes` STRING COMMENT 'Free-text notes and comments about the schedule version, including assumptions, constraints, key changes from previous versions, and schedule management decisions.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Overall schedule completion percentage based on completed activities or earned value. Expressed as a value between 0 and 100.',
    `performance_index` DECIMAL(18,2) COMMENT 'Earned value schedule performance index calculated as Earned Value (EV) divided by Planned Value (PV). Values less than 1.0 indicate schedule delays, values greater than 1.0 indicate schedule advancement. Key earned value metric for project control.',
    `performance_index_date` DATE COMMENT 'Date as of which the schedule performance index was calculated. Important for tracking SPI trends over time.',
    `planned_completion_date` DATE COMMENT 'Original baseline completion date for the project as per the approved schedule. Used as the reference point for schedule variance calculations.',
    `prepared_by` STRING COMMENT 'Name or identifier of the project scheduler or planning engineer who prepared this schedule version. Used for accountability and schedule quality assurance.',
    `risk_level` STRING COMMENT 'Overall assessment of schedule risk based on float consumption, critical path stability, resource constraints, and external dependencies. Used for escalation and management attention.. Valid values are `low|medium|high|critical`',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the schedule. Tracks the approval and activation state of the schedule version.. Valid values are `draft|under_review|approved|active|superseded|archived`',
    `schedule_type` STRING COMMENT 'Classification of the schedule record. Baseline represents the approved reference schedule, current is the working schedule, forecast is the projected schedule, what-if is scenario planning, and recovery is a corrective action schedule.. Valid values are `baseline|current|forecast|what_if|recovery`',
    `scheduling_tool` STRING COMMENT 'Software application used to create and maintain the project schedule. Common tools in mining include Primavera P6 for large capital projects, MS Project for smaller projects, and Deswik or Minex for mine-specific scheduling.. Valid values are `primavera_p6|ms_project|deswik|minex|other`',
    `scheduling_tool_file_reference` STRING COMMENT 'File path, document management system reference, or unique identifier for the native schedule file in the scheduling tool. Enables traceability to the source schedule data.',
    `start_date` DATE COMMENT 'Planned or actual start date of the project schedule. Represents the earliest activity start in the schedule network.',
    `total_activities_count` STRING COMMENT 'Total number of activities or tasks in the project schedule. Provides a measure of schedule complexity and granularity.',
    `total_float_days` DECIMAL(18,2) COMMENT 'Total float or slack available in the schedule network. Represents the amount of time an activity can be delayed without delaying the project completion date. Critical for risk management and resource optimization.',
    `update_frequency` STRING COMMENT 'Planned frequency for updating the project schedule with actual progress and forecast changes. Typically defined in the project management plan.. Valid values are `daily|weekly|biweekly|monthly|quarterly|ad_hoc`',
    `variance_days` DECIMAL(18,2) COMMENT 'Difference in days between the planned completion date and the forecast completion date. Negative values indicate schedule delay, positive values indicate schedule advancement. Key metric for schedule performance monitoring.',
    `version` STRING COMMENT 'Version identifier for the schedule baseline or update. Used to track schedule revisions over the project lifecycle.. Valid values are `^[A-Z0-9]{1,20}$`',
    CONSTRAINT pk_schedule PRIMARY KEY(`schedule_id`)
) COMMENT 'Master record of the project schedule baseline and current schedule for a capital project or phase. Captures schedule version, baseline approval date, total float, critical path flag, schedule performance index (SPI), planned completion date, forecast completion date, schedule variance in days, and the scheduling tool reference (Primavera P6, MS Project). Serves as the SSOT for schedule status and earned value schedule metrics.';

CREATE OR REPLACE TABLE `mining_ecm`.`project`.`schedule_activity` (
    `schedule_activity_id` BIGINT COMMENT 'Unique identifier for the schedule activity within the project schedule. Primary key.',
    `calendar_id` BIGINT COMMENT 'Reference to the work calendar applied to this activity, defining working days, shifts, and holidays used for duration calculations.',
    `capital_project_id` BIGINT COMMENT 'Reference to the parent project to which this schedule activity belongs.',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Individual schedule activities occur within specific project phases. Currently schedule_activity links to capital_project and wbs_element but not directly to phase. This enables phase-level schedule r',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element under which this activity is organized.',
    `schedule_id` BIGINT COMMENT 'Foreign key linking to project.project_schedule. Business justification: Schedule activities belong to a project schedule (baseline, current, forecast). Currently schedule_activity has project_id but no FK to project_schedule. This is a critical parent-child relationship -',
    `predecessor_schedule_activity_id` BIGINT COMMENT 'Self-referencing FK on schedule_activity (predecessor_schedule_activity_id)',
    `activity_code` STRING COMMENT 'Unique business identifier for the schedule activity, typically sourced from Primavera P6 or similar scheduling system.',
    `activity_name` STRING COMMENT 'Descriptive name of the schedule activity, clearly identifying the work to be performed.',
    `activity_notes` STRING COMMENT 'Free-text notes and comments related to the activity, capturing progress updates, issues, decisions, or other relevant information.',
    `activity_status` STRING COMMENT 'Current lifecycle status of the schedule activity indicating progress state.. Valid values are `not_started|in_progress|completed|suspended|cancelled`',
    `activity_type` STRING COMMENT 'Classification of the activity type indicating how it is scheduled and tracked. Task Dependent activities have duration and dependencies; Milestones mark key events with zero duration; Level of Effort activities span a time period without discrete deliverables; WBS Summary activities aggregate subordinate tasks.. Valid values are `task_dependent|milestone|level_of_effort|start_milestone|finish_milestone|wbs_summary`',
    `actual_cost` DECIMAL(18,2) COMMENT 'The actual cost incurred for this activity to date, used for cost performance analysis and variance reporting.',
    `actual_duration_days` DECIMAL(18,2) COMMENT 'The actual number of working days taken to complete the activity, calculated from actual start to actual finish dates.',
    `actual_finish_date` DATE COMMENT 'The actual date when work on this activity was completed. Null if activity is not yet finished.',
    `actual_labour_hours` DECIMAL(18,2) COMMENT 'The actual labour hours expended on this activity to date, used for productivity analysis and resource performance tracking.',
    `actual_start_date` DATE COMMENT 'The actual date when work on this activity commenced. Null if activity has not yet started.',
    `budgeted_cost` DECIMAL(18,2) COMMENT 'The total budgeted cost allocated to this activity, representing the planned value for earned value management calculations.',
    `budgeted_labour_hours` DECIMAL(18,2) COMMENT 'The total planned labour hours allocated to this activity across all resources.',
    `constraint_date` DATE COMMENT 'The date associated with the constraint type, defining the earliest, latest, or mandatory date for activity start or finish.',
    `constraint_type` STRING COMMENT 'Type of schedule constraint applied to this activity, restricting when it can be scheduled relative to a constraint date. [ENUM-REF-CANDIDATE: as_soon_as_possible|as_late_as_possible|start_no_earlier_than|start_no_later_than|finish_no_earlier_than|finish_no_later_than|must_start_on|must_finish_on — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this schedule activity record was first created in the system.',
    `data_date` DATE COMMENT 'The status date or as-of date for which the schedule data was current, representing the point in time when progress was last updated.',
    `discipline_code` STRING COMMENT 'Code representing the engineering or operational discipline associated with this activity (e.g., civil, mechanical, electrical, mining, processing).',
    `early_finish_date` DATE COMMENT 'The earliest possible date the activity can finish based on network logic and predecessor constraints, calculated via Critical Path Method (CPM).',
    `early_start_date` DATE COMMENT 'The earliest possible date the activity can start based on network logic and predecessor constraints, calculated via Critical Path Method (CPM).',
    `free_float_days` DECIMAL(18,2) COMMENT 'The amount of time in working days that the activity can be delayed without delaying the early start of any successor activity.',
    `is_critical_path` BOOLEAN COMMENT 'Boolean flag indicating whether this activity is on the critical path (True) or not (False). Critical path activities have zero or negative total float and directly impact project completion date.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this schedule activity record was most recently modified.',
    `late_finish_date` DATE COMMENT 'The latest date the activity can finish without delaying the project finish date, calculated via Critical Path Method (CPM).',
    `late_start_date` DATE COMMENT 'The latest date the activity can start without delaying the project finish date, calculated via Critical Path Method (CPM).',
    `original_duration_days` DECIMAL(18,2) COMMENT 'The initially estimated duration of the activity in working days as defined in the baseline schedule.',
    `percent_complete` DECIMAL(18,2) COMMENT 'The percentage of work completed for this activity, expressed as a value between 0.00 and 100.00, used for progress tracking and earned value calculations.',
    `planned_finish_date` DATE COMMENT 'The originally planned or baseline finish date for the activity as per the approved project schedule.',
    `planned_start_date` DATE COMMENT 'The originally planned or baseline start date for the activity as per the approved project schedule.',
    `priority` STRING COMMENT 'Numeric priority ranking for the activity, used for resource leveling and conflict resolution. Lower numbers typically indicate higher priority.',
    `remaining_duration_days` DECIMAL(18,2) COMMENT 'The estimated number of working days required to complete the activity from the data date, updated during schedule progress updates.',
    `responsible_party` STRING COMMENT 'The organization, contractor, or functional group responsible for executing this activity.',
    `source_system` STRING COMMENT 'The name of the source system from which this schedule activity data originated (e.g., Primavera P6, Microsoft Project, SAP PS).',
    `total_float_days` DECIMAL(18,2) COMMENT 'The amount of time in working days that the activity can be delayed without delaying the project finish date. Calculated as Late Start minus Early Start (or Late Finish minus Early Finish).',
    CONSTRAINT pk_schedule_activity PRIMARY KEY(`schedule_activity_id`)
) COMMENT 'Individual schedule activity (task) within a project schedule, derived from the Primavera P6 WBS. Captures activity ID, activity name, WBS code, activity type (Level of Effort, Milestone, Task Dependent), planned start, planned finish, actual start, actual finish, original duration, remaining duration, percent complete, total float, free float, and critical path flag. Enables granular schedule tracking and critical path analysis.';

CREATE OR REPLACE TABLE `mining_ecm`.`project`.`milestone` (
    `milestone_id` BIGINT COMMENT 'Unique identifier for the project milestone record. Primary key.',
    `capital_project_id` BIGINT COMMENT 'Reference to the parent capital project to which this milestone belongs. Links milestone to the overarching mine development, plant expansion, or infrastructure project.',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Milestones occur within specific project phases. Currently milestone links to capital_project but not to the specific phase, missing a hierarchical relationship. This enables phase-level milestone tra',
    `predecessor_milestone_id` BIGINT COMMENT 'Reference to the milestone that must be completed before this milestone can begin or be achieved. Used for schedule dependency tracking and critical path analysis.',
    `procurement_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Project milestones tied to PO delivery (long-lead equipment arrival gates). Business process: critical path management, schedule risk tracking, milestone payment triggers linked to procurement.',
    `accountable_person` STRING COMMENT 'The name or identifier of the individual who is ultimately accountable for milestone achievement. Typically a project manager, engineering lead, or contractor representative.',
    `actual_date` DATE COMMENT 'The actual date when the milestone was achieved and acceptance criteria were met. Populated only after milestone completion and formal sign-off.',
    `approval_authority` STRING COMMENT 'The governance body, executive role, or regulatory authority that must formally approve or sign off on this milestone achievement. Examples include Project Steering Committee, CEO, Board of Directors, or regulatory agency.',
    `approval_date` DATE COMMENT 'The date when the milestone achievement was formally approved or signed off by the designated approval authority. May differ from actual achievement date if approval process takes time.',
    `baseline_date` DATE COMMENT 'The approved baseline date for the milestone after any formal re-baselining or change control approvals. Used for performance measurement when the original plan has been formally revised.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or context about the milestone status, progress, issues, or achievements. Used for qualitative reporting and knowledge capture.',
    `contractual_obligation_flag` BOOLEAN COMMENT 'Indicates whether this milestone is a contractual obligation with financial or legal consequences. True means the milestone is tied to contract terms, payment schedules, or liquidated damages provisions.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this milestone record was first created in the system. Used for audit trail and data lineage tracking.',
    `criticality_flag` BOOLEAN COMMENT 'Indicates whether this milestone is on the critical path of the project schedule. True means any delay to this milestone will directly impact the overall project completion date.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the milestone payment amount (e.g., USD, AUD, CAD). Used for multi-currency project tracking and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `delay_reason_code` STRING COMMENT 'Standardized code representing the primary reason for milestone delay or at-risk status. Used for root cause analysis and trend reporting across projects. Examples include weather, equipment delivery, design changes, regulatory approval delays, labor shortages.',
    `delay_reason_description` STRING COMMENT 'Detailed narrative explanation of the delay reason, including specific circumstances, contributing factors, and any mitigation actions taken or planned.',
    `evidence_document_reference` STRING COMMENT 'Reference identifier or location of the supporting documentation that provides evidence of milestone completion. May include test reports, inspection certificates, regulatory approvals, or sign-off documents.',
    `forecast_date` DATE COMMENT 'The current projected date when the milestone is expected to be achieved, based on actual progress and updated schedule analysis. Updated regularly during project execution.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this milestone record was most recently modified. Used for change tracking and data currency verification.',
    `milestone_category` STRING COMMENT 'The project phase or functional category to which the milestone belongs. Used for grouping milestones by lifecycle stage for reporting and tracking purposes.. Valid values are `Design|Procurement|Construction|Commissioning|Handover|Approval`',
    `milestone_code` STRING COMMENT 'Business identifier or code for the milestone, often used in project schedules and contractor agreements. May follow organizational or project-specific coding conventions.',
    `milestone_description` STRING COMMENT 'Detailed description of the milestone scope, deliverables, acceptance criteria, and any specific conditions that must be met for the milestone to be considered achieved.',
    `milestone_name` STRING COMMENT 'The descriptive name of the milestone representing a significant deliverable or decision point (e.g., Feasibility Study Approval, First Ore to Mill, Commissioning Complete).',
    `milestone_status` STRING COMMENT 'Current status of the milestone in its lifecycle. Not Started indicates planning phase; In Progress indicates active work toward completion; At Risk indicates potential delay; Achieved indicates successful completion; Missed indicates failure to meet target date; Cancelled indicates milestone no longer required.. Valid values are `Not Started|In Progress|At Risk|Achieved|Missed|Cancelled`',
    `milestone_type` STRING COMMENT 'Classification of the milestone by its nature and purpose. Contractual milestones trigger payment or obligations; Internal milestones support project governance; Regulatory milestones satisfy compliance requirements; Financial milestones align with funding or budget releases; Stage Gate milestones represent formal decision points; Technical milestones mark engineering or construction achievements.. Valid values are `Contractual|Internal|Regulatory|Financial|Stage Gate|Technical`',
    `payment_amount` DECIMAL(18,2) COMMENT 'The contractual payment amount in the project currency that is triggered upon achievement of this milestone. Used for cash flow forecasting and contractor payment processing.',
    `payment_trigger_flag` BOOLEAN COMMENT 'Indicates whether achievement of this milestone triggers a contractual payment to a contractor or vendor. True means milestone completion authorizes invoice submission and payment processing.',
    `planned_date` DATE COMMENT 'The original baseline date when the milestone was planned to be achieved, as established during project planning or contract negotiation. This date remains fixed for variance analysis.',
    `responsible_party` STRING COMMENT 'The organization, contractor, or internal department responsible for delivering this milestone. May be the EPC contractor, owners team, regulatory authority, or specific functional group.',
    `risk_rating` STRING COMMENT 'Current risk assessment for achieving this milestone on time. Based on factors such as technical complexity, resource availability, external dependencies, and historical performance. Used for proactive risk management and escalation.. Valid values are `Low|Medium|High|Critical`',
    `stage_gate_flag` BOOLEAN COMMENT 'Indicates whether this milestone represents a formal stage-gate decision point requiring executive or board approval to proceed to the next project phase. True means formal governance review and approval is required.',
    `updated_by` STRING COMMENT 'The user identifier or name of the person who last updated this milestone record. Used for accountability and audit purposes.',
    `variance_days` STRING COMMENT 'The schedule variance in days between the planned date and the actual or forecast date. Positive values indicate delay; negative values indicate early completion. Used for schedule performance analysis.',
    `wbs_element` STRING COMMENT 'The WBS code or element identifier that this milestone belongs to within the project hierarchy. Used for cost allocation and progress tracking in SAP PS module.',
    `weight_percentage` DECIMAL(18,2) COMMENT 'The relative weight or importance of this milestone as a percentage of total project completion. Used for earned value calculations and overall project progress reporting. Sum of all milestone weights should equal 100%.',
    CONSTRAINT pk_milestone PRIMARY KEY(`milestone_id`)
) COMMENT 'Key project milestone record representing a significant deliverable or decision point within a capital project. Captures milestone name, milestone type (contractual, internal, regulatory, financial), planned date, forecast date, actual achieved date, milestone status (Not Started, At Risk, Achieved, Missed), responsible party, and any delay reason code. Used for executive reporting, contractor performance, and stage-gate readiness tracking.';

CREATE OR REPLACE TABLE `mining_ecm`.`project`.`cost_estimate` (
    `cost_estimate_id` BIGINT COMMENT 'Unique identifier for the capital cost estimate record. Primary key for the cost estimate entity.',
    `capital_project_id` BIGINT COMMENT 'Reference to the capital project or project phase for which this cost estimate was prepared.',
    `feasibility_study_id` BIGINT COMMENT 'Foreign key linking to project.feasibility_study. Business justification: Cost estimates are produced as part of feasibility studies (PFS, DFS estimates). Currently cost_estimate links to capital_project but not to the specific study that produced it. This is a critical lin',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Cost estimates are prepared for specific project phases (Concept, Pre-Feasibility, Feasibility, FEED, Execute). Currently cost_estimate has capex_phase as STRING which should be normalized to FK. This',
    `resource_estimate_id` BIGINT COMMENT 'Foreign key linking to exploration.resource_estimate. Business justification: Capital cost estimates are scaled to resource size. Mining method selection, plant capacity, infrastructure requirements, and workforce sizing all depend on resource tonnage and grade. Direct dependen',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Project cost estimates vary by target product specification and processing route (e.g., DSO vs beneficiated concentrate). Capex estimation requires knowing target product to size processing facilities',
    `superseded_by_estimate_cost_estimate_id` BIGINT COMMENT 'Reference to the subsequent cost estimate that supersedes this version, enabling tracking of estimate evolution and version lineage.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Cost estimates structure to WBS for budget planning and stage-gate approvals. Mining feasibility studies and execution estimates require WBS-level detail for NPV calculations and funding approvals.',
    `superseded_cost_estimate_id` BIGINT COMMENT 'Self-referencing FK on cost_estimate (superseded_cost_estimate_id)',
    `accuracy_range_high` DECIMAL(18,2) COMMENT 'The upper bound of the expected accuracy range for this estimate class, expressed as a positive percentage (e.g., +30 for +30%). Indicates potential overestimation.',
    `accuracy_range_low` DECIMAL(18,2) COMMENT 'The lower bound of the expected accuracy range for this estimate class, expressed as a negative percentage (e.g., -20 for -20%). Indicates potential underestimation.',
    `approval_authority_level` STRING COMMENT 'The organizational authority level required to approve this cost estimate and associated capital expenditure, typically determined by the total estimate amount and project risk profile.. Valid values are `Site Manager|General Manager|Executive Committee|Board of Directors`',
    `approval_date` DATE COMMENT 'The date on which this cost estimate received formal approval from the designated authority.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or committee who formally approved this cost estimate for use in project decision-making and funding allocation.',
    `base_estimate_amount` DECIMAL(18,2) COMMENT 'The total estimated capital cost at the base date, excluding contingency and escalation. Represents the direct and indirect costs for all project scope elements.',
    `capex_category` STRING COMMENT 'Classification of the capital expenditure type for financial reporting and portfolio management. Sustaining CAPEX maintains current production capacity; expansion CAPEX increases capacity or mine life.. Valid values are `Sustaining|Expansion|Greenfield|Brownfield|Infrastructure|Closure`',
    `contingency_amount` DECIMAL(18,2) COMMENT 'The monetary value of contingency allowance included to cover uncertainties, scope changes, and unforeseen conditions within the defined project scope.',
    `contingency_percentage` DECIMAL(18,2) COMMENT 'The contingency amount expressed as a percentage of the base estimate, typically aligned with the estimate class accuracy range.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cost estimate record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the estimate amounts are denominated (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `direct_cost_amount` DECIMAL(18,2) COMMENT 'The portion of the base estimate attributable to direct project costs including materials, equipment, labor, and subcontracts directly tied to physical construction and installation.',
    `escalation_amount` DECIMAL(18,2) COMMENT 'The monetary allowance for cost escalation from the base date to the expected expenditure period, accounting for inflation and market price movements.',
    `escalation_percentage` DECIMAL(18,2) COMMENT 'The escalation amount expressed as a percentage of the base estimate, reflecting anticipated inflation rates over the project execution period.',
    `estimate_base_date` DATE COMMENT 'The reference date for which all cost estimates are stated, representing the pricing basis before escalation adjustments. Critical for comparing estimates prepared at different times.',
    `estimate_basis_narrative` STRING COMMENT 'Detailed textual description of the assumptions, scope boundaries, exclusions, data sources, and key drivers underlying this cost estimate. Provides context for estimate interpretation and comparison.',
    `estimate_class` STRING COMMENT 'AACE International estimate classification indicating the level of project definition and expected accuracy range. Class 5 (concept screening, -20% to -50% / +30% to +100%), Class 4 (feasibility study, -15% to -30% / +20% to +50%), Class 3 (budget authorization, -10% to -20% / +10% to +30%), Class 2 (control/bid, -5% to -15% / +5% to +20%), Class 1 (check estimate, -3% to -10% / +3% to +15%).. Valid values are `Class 5|Class 4|Class 3|Class 2|Class 1`',
    `estimate_confidence_level` STRING COMMENT 'Qualitative assessment of the estimating teams confidence in the accuracy and completeness of this estimate, considering data quality, scope definition, and market conditions.. Valid values are `Low|Medium|High|Very High`',
    `estimate_notes` STRING COMMENT 'Additional comments, clarifications, or special considerations related to this cost estimate that provide context for users and decision-makers.',
    `estimate_number` STRING COMMENT 'Business identifier or document number assigned to this cost estimate for tracking and reference purposes.',
    `estimate_preparation_date` DATE COMMENT 'The date when this cost estimate was prepared or finalized by the estimating team.',
    `estimate_status` STRING COMMENT 'Current lifecycle status of the cost estimate indicating its approval state and usability for decision-making.. Valid values are `Draft|Under Review|Approved|Rejected|Superseded|Baseline`',
    `estimate_version` STRING COMMENT 'Version identifier for this estimate iteration, tracking evolution from initial concept through to final sanction estimate (e.g., V1.0, V2.1, Final).',
    `estimating_methodology` STRING COMMENT 'The primary cost estimating approach or technique used to develop this estimate (e.g., parametric modeling, factored estimates from similar projects, detailed quantity takeoffs and unit rates).. Valid values are `Parametric|Factored|Detailed Bottom-Up|Analogous|Expert Judgment|Hybrid`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied if this estimate was prepared in a currency different from the reporting currency, or if significant foreign currency expenditures are anticipated.',
    `indirect_cost_amount` DECIMAL(18,2) COMMENT 'The portion of the base estimate attributable to indirect project costs including engineering, procurement, construction management, commissioning, owners costs, and other support functions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cost estimate record was most recently updated or modified.',
    `prepared_by` STRING COMMENT 'Name or identifier of the lead estimator or estimating team responsible for preparing this cost estimate.',
    `reviewed_by` STRING COMMENT 'Name or identifier of the individual or team who conducted independent review and validation of this cost estimate prior to approval.',
    `risk_allowance_included` BOOLEAN COMMENT 'Indicates whether a specific risk allowance (beyond standard contingency) has been included in this estimate to address identified project risks from the risk register.',
    `scope_definition_level` STRING COMMENT 'The maturity level of project scope definition at the time this estimate was prepared, indicating the completeness of engineering, design, and planning deliverables.. Valid values are `Concept|Pre-Feasibility|Feasibility|Detailed Design|Construction Ready`',
    `total_estimate_amount` DECIMAL(18,2) COMMENT 'The total estimated capital cost including base estimate, contingency, and escalation. This is the all-in project cost estimate used for funding approvals and financial planning.',
    CONSTRAINT pk_cost_estimate PRIMARY KEY(`cost_estimate_id`)
) COMMENT 'Capital cost estimate record for a project or project phase, representing a point-in-time estimate at a defined accuracy class (AACE Class 1 through Class 5). Captures estimate version, estimate class, base date, total estimated cost, contingency amount, contingency percentage, escalation allowance, estimate basis narrative, estimating methodology (factored, detailed, parametric), and approval status. Tracks estimate evolution from concept through sanction.';

CREATE OR REPLACE TABLE `mining_ecm`.`project`.`project_budget` (
    `project_budget_id` BIGINT COMMENT 'Unique identifier for the project budget record. Primary key.',
    `capital_project_id` BIGINT COMMENT 'Reference to the capital project for which this budget is approved. Links to the parent project entity.',
    `cost_estimate_id` BIGINT COMMENT 'Foreign key linking to project.cost_estimate. Business justification: Approved budgets are based on specific cost estimates (the sanctioned estimate). Currently project_budget has approved_budget_amount but not a FK to the source estimate. This is a critical lineage lin',
    `resource_estimate_id` BIGINT COMMENT 'Foreign key linking to exploration.resource_estimate. Business justification: Project budgets are justified by resource value. NPV calculations, IRR, and payback period all reference the resource estimate that underpins project economics. Essential for budget approval, variance',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Project budgets map to WBS elements for integrated cost control and variance reporting. Mining projects require WBS-level budget tracking for capex governance and financial close processes.',
    `superseded_project_budget_id` BIGINT COMMENT 'Self-referencing FK on project_budget (superseded_project_budget_id)',
    `amendment_date` DATE COMMENT 'The date on which a budget amendment or revision was approved. Null for original budget records.',
    `amendment_reason` STRING COMMENT 'Explanation for any budget revision or amendment. Captures the business justification for changes to the originally approved budget.',
    `approval_date` DATE COMMENT 'The date on which this budget was formally approved and sanctioned by the approving authority. Represents the official authorization date.',
    `approval_gate` STRING COMMENT 'The stage-gate milestone at which this budget was approved. Aligns with the organizations capital project governance framework (e.g., Gate 3 for detailed design approval).. Valid values are `gate_0|gate_1|gate_2|gate_3|gate_4|gate_5`',
    `approved_budget_amount` DECIMAL(18,2) COMMENT 'The total sanctioned capital allocation amount for this project budget. Represents the Authority for Expenditure (AFE) approved by the governing authority.',
    `approving_authority` STRING COMMENT 'The name or title of the governing body, committee, or executive that approved this budget (e.g., Board of Directors, Investment Committee, CFO).',
    `baseline_budget_flag` BOOLEAN COMMENT 'Indicates whether this budget version is the baseline budget used for performance measurement and variance analysis. True if this is the baseline, False otherwise.',
    `budget_category` STRING COMMENT 'High-level classification of the budget based on the nature of the capital project (e.g., sustaining capital, expansion, new mine development). [ENUM-REF-CANDIDATE: sustaining|expansion|new_development|brownfield|greenfield|infrastructure|compliance|safety — 8 candidates stripped; promote to reference product]',
    `budget_number` STRING COMMENT 'The externally-known AFE or budget authorization number assigned to this approved budget. Used for tracking and audit purposes.',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget record indicating its approval and operational state. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|suspended|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `budget_type` STRING COMMENT 'Classification of the budget record indicating whether it is the original sanctioned budget, a revised budget, supplementary allocation, contingency release, or baseline budget.. Valid values are `original|revised|supplementary|contingency|baseline`',
    `capex_phase` STRING COMMENT 'The project phase or stage to which this budget applies. Aligns with stage-gate approval process for capital projects. [ENUM-REF-CANDIDATE: feasibility|pre_feasibility|definitive_feasibility|front_end_engineering_design|detailed_design|procurement|construction|commissioning|closeout — 9 candidates stripped; promote to reference product]',
    `contingency_budget` DECIMAL(18,2) COMMENT 'The portion of the approved budget allocated as contingency reserve to cover identified risks, scope changes, and unforeseen events within the project scope.',
    `contingency_percentage` DECIMAL(18,2) COMMENT 'The contingency budget expressed as a percentage of the total approved budget amount. Typically ranges from 5% to 25% depending on project risk profile.',
    `cost_centre_code` STRING COMMENT 'The cost centre or organizational unit responsible for managing and controlling this project budget.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the approved budget amount (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `direct_cost_budget` DECIMAL(18,2) COMMENT 'The portion of the approved budget allocated to direct project costs including labor, materials, equipment, and subcontractors directly attributable to project deliverables.',
    `effective_from_date` DATE COMMENT 'The date from which this budget becomes effective and expenditure can be authorized against it.',
    `effective_to_date` DATE COMMENT 'The date until which this budget remains valid. Nullable for open-ended budgets or those tied to project completion.',
    `indirect_cost_budget` DECIMAL(18,2) COMMENT 'The portion of the approved budget allocated to indirect costs including project management, administration, overhead, and support services not directly tied to deliverables.',
    `irr_at_approval` DECIMAL(18,2) COMMENT 'The Internal Rate of Return percentage of the project as calculated and presented at the time of budget approval. Used for investment decision tracking.',
    `modified_by` STRING COMMENT 'The user identifier or name of the person who last modified this budget record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional notes, conditions, or commentary related to the budget approval, amendments, or special considerations.',
    `npv_at_approval` DECIMAL(18,2) COMMENT 'The Net Present Value of the project as calculated and presented at the time of budget approval. Used for investment decision tracking and post-implementation review.',
    `owner` STRING COMMENT 'The name or employee identifier of the individual accountable for managing and controlling expenditure against this budget (typically the Project Manager or Project Director).',
    `owner_cost_budget` DECIMAL(18,2) COMMENT 'The portion of the approved budget allocated to owner costs including internal labor, owner-furnished equipment, permits, insurance, and owner-side project management.',
    `payback_period_months` STRING COMMENT 'The expected payback period in months for the capital investment as calculated at the time of budget approval.',
    `profit_centre_code` STRING COMMENT 'The profit centre to which this project budget and its associated capital expenditure will be allocated for financial reporting.',
    `version` STRING COMMENT 'Version identifier for this budget record. Tracks original budget vs. amendments and revisions (e.g., V1.0, V2.0, Amendment 1).',
    `created_by` STRING COMMENT 'The user identifier or name of the person who created this budget record in the system.',
    CONSTRAINT pk_project_budget PRIMARY KEY(`project_budget_id`)
) COMMENT 'Approved project budget record representing the sanctioned capital allocation for a capital project at a given approval date. Captures approved budget amount (AFE — Authority for Expenditure), budget currency, approval date, approving authority, budget breakdown by phase and cost category (direct, indirect, owner costs, contingency), budget version, and any subsequent budget amendments. Distinct from finance.capex_budget which holds GL-level allocations; this is the project-level sanction record.';

CREATE OR REPLACE TABLE `mining_ecm`.`project`.`budget_amendment` (
    `budget_amendment_id` BIGINT COMMENT 'Unique identifier for the budget amendment record. Primary key for the budget amendment entity.',
    `capital_project_id` BIGINT COMMENT 'Reference to the capital project to which this budget amendment applies. Links to the parent project entity.',
    `cost_estimate_id` BIGINT COMMENT 'Foreign key linking to project.cost_estimate. Business justification: Budget amendments are supported by revised cost estimates. When requesting additional funds (AFE variation), a new estimate is prepared to justify the amendment. This links the amendment to its suppor',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to project.project_budget. Business justification: Budget amendments modify approved project budgets. Currently budget_amendment has project_id but no FK to project_budget. This is a parent-child relationship - amendments are changes to a specific bud',
    `superseded_budget_amendment_id` BIGINT COMMENT 'Self-referencing FK on budget_amendment (superseded_budget_amendment_id)',
    `amendment_amount` DECIMAL(18,2) COMMENT 'The incremental budget change requested in this amendment. Positive values indicate budget increases; negative values indicate budget reductions. This is the delta amount, not the new total. Expressed in the projects functional currency.',
    `amendment_date` DATE COMMENT 'The date on which the budget amendment was formally submitted or lodged for approval. This is the principal business event timestamp for the amendment and is distinct from approval date or creation timestamp.',
    `amendment_number` STRING COMMENT 'Business identifier for the budget amendment. Typically follows the pattern AFE-AMD-NNNNNN where AFE is Authorization for Expenditure and AMD is Amendment. This is the externally-known reference number used in approval workflows and audit trails.. Valid values are `^AFE-AMD-[0-9]{6,10}$`',
    `amendment_reason` STRING COMMENT 'Detailed narrative explanation of why the budget amendment is required. Captures the business justification, root cause analysis, and rationale for the budget change. This field provides the audit trail context for the amendment decision.',
    `amendment_status` STRING COMMENT 'Current lifecycle status of the budget amendment. Draft indicates preparation stage; submitted means formally lodged for approval; under review indicates active evaluation by approval authority; approved means amendment is authorized and budget updated; rejected means amendment was declined; withdrawn indicates proponent cancelled the request.. Valid values are `draft|submitted|under_review|approved|rejected|withdrawn`',
    `amendment_type` STRING COMMENT 'Classification of the budget amendment based on the primary driver. Scope change indicates additional work scope; design change reflects engineering modifications; market escalation captures commodity or labor cost increases; risk event represents materialized project risks; schedule delay reflects cost impacts from timeline extensions; regulatory requirement captures compliance-driven changes.. Valid values are `scope_change|design_change|market_escalation|risk_event|schedule_delay|regulatory_requirement`',
    `approval_authority` STRING COMMENT 'The organizational level or role authorized to approve this budget amendment based on the amendment amount and governance thresholds. Reflects the delegation of authority framework for capital expenditure approvals.. Valid values are `project_manager|site_manager|general_manager|cfo|ceo|board`',
    `approval_date` DATE COMMENT 'The date on which the budget amendment was formally approved or rejected by the approval authority. Null if amendment is still in draft, submitted, or under review status.',
    `approver_name` STRING COMMENT 'Full name of the individual who approved or rejected the budget amendment. Populated upon final approval or rejection decision. Provides accountability and audit trail for the amendment decision.',
    `capex_category` STRING COMMENT 'Classification of the capital expenditure type for this amendment. Sustaining CAPEX maintains current production capacity; expansion CAPEX increases capacity; exploration CAPEX supports resource discovery; infrastructure CAPEX builds enabling assets; compliance CAPEX meets regulatory requirements; other captures miscellaneous capital spend.. Valid values are `sustaining|expansion|exploration|infrastructure|compliance|other`',
    `change_order_reference` STRING COMMENT 'Reference to the formal change order document if this budget amendment is associated with a scope or design change. Links the amendment to the change control process and provides traceability to engineering or procurement variations.. Valid values are `^CO-[0-9]{6,10}$`',
    `contingency_amount_used` DECIMAL(18,2) COMMENT 'The amount of project contingency reserve utilized by this amendment if contingency_drawdown_flag is True. Tracks depletion of contingency funds and remaining risk buffer. Expressed in the projects functional currency.',
    `contingency_drawdown_flag` BOOLEAN COMMENT 'Indicates whether this budget amendment is funded from the projects contingency reserve (True) or requires new budget allocation (False). Used for contingency management and budget governance.',
    `cost_centre_code` STRING COMMENT 'The cost centre to which this budget amendment is allocated for financial reporting and cost control purposes. Links to the organizational cost structure in the finance system.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this budget amendment record was first created in the system. Audit trail field for record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this amendment record. Typically matches the projects functional currency (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `impact_on_irr` DECIMAL(18,2) COMMENT 'The estimated change in project Internal Rate of Return (percentage points) resulting from this budget amendment. Positive values indicate IRR improvement; negative values indicate IRR reduction. Used for investment decision analysis and hurdle rate assessment.',
    `impact_on_npv` DECIMAL(18,2) COMMENT 'The estimated change in project Net Present Value resulting from this budget amendment. Positive values indicate NPV improvement; negative values indicate NPV reduction. Used for investment decision analysis and project viability assessment. Expressed in the projects functional currency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this budget amendment record was last updated. Audit trail field for change tracking and data lineage.',
    `original_approved_amount` DECIMAL(18,2) COMMENT 'The total approved project budget amount prior to this amendment. Represents the baseline budget that this amendment is modifying. Expressed in the projects functional currency.',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by the approval authority if the budget amendment was rejected. Captures the rationale for rejection and provides feedback to the project team for potential resubmission. Null if amendment was approved or is still pending.',
    `revised_total_budget` DECIMAL(18,2) COMMENT 'The new total approved project budget after applying this amendment. Calculated as original_approved_amount plus amendment_amount. Represents the updated budget ceiling for the project. Expressed in the projects functional currency.',
    `risk_register_reference` STRING COMMENT 'Reference to the risk register entry if this budget amendment is triggered by a materialized project risk. Links the amendment to the formal risk management process and provides traceability to risk mitigation actions.. Valid values are `^RISK-[0-9]{4,8}$`',
    `schedule_impact_days` STRING COMMENT 'The estimated impact on project schedule in calendar days resulting from this budget amendment. Positive values indicate schedule extension; negative values indicate schedule acceleration; zero indicates no schedule impact. Used for critical path analysis and project timeline management.',
    `stage_gate_phase` STRING COMMENT 'The project stage gate phase during which this budget amendment was submitted. Aligns with the project lifecycle governance framework and stage-gate approval process used in mining capital projects. [ENUM-REF-CANDIDATE: feasibility|pre_feasibility|detailed_design|procurement|construction|commissioning|handover — 7 candidates stripped; promote to reference product]',
    `submission_timestamp` TIMESTAMP COMMENT 'The precise date and time when the budget amendment was formally submitted into the approval workflow. Provides audit trail and supports SLA tracking for approval cycle times.',
    `submitted_by` STRING COMMENT 'Full name or identifier of the individual who submitted the budget amendment for approval. Provides accountability and audit trail for the amendment request origination.',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or file path to supporting documentation for the budget amendment (e.g., cost estimates, engineering drawings, vendor quotes, risk assessments). Provides traceability to the evidence base for the amendment request.',
    `wbs_element` STRING COMMENT 'The specific WBS element within the project structure to which this budget amendment applies. Enables granular tracking of budget changes at the work package or activity level.. Valid values are `^[A-Z0-9.-]{6,20}$`',
    CONSTRAINT pk_budget_amendment PRIMARY KEY(`budget_amendment_id`)
) COMMENT 'Transactional record of each formal amendment to an approved project budget (AFE variation). Captures amendment number, amendment date, reason for amendment (scope change, design change, market escalation, risk event), original approved amount, amendment amount, revised total budget, approval authority, and approval status. Provides the complete audit trail of budget changes throughout the project lifecycle.';

CREATE OR REPLACE TABLE `mining_ecm`.`project`.`cost_commitment` (
    `cost_commitment_id` BIGINT COMMENT 'Unique identifier for the cost commitment record. Primary key for the cost commitment entity.',
    `capital_project_id` BIGINT COMMENT 'Reference to the capital project against which this cost commitment is raised. Links the commitment to the parent project for cost control and reporting.',
    `change_order_id` BIGINT COMMENT 'Foreign key linking to project.change_order. Business justification: Cost commitments are created or modified by change orders. Currently cost_commitment has is_change_order flag and original_commitment_id but not a FK to the change_order that created or modified it. T',
    `original_commitment_cost_commitment_id` BIGINT COMMENT 'Reference to the original cost commitment if this is a change order or amendment. Enables tracking of commitment history and cumulative changes.',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Project cost commitments reference procurement contracts for rate validation. Business need: contract compliance verification, pricing audit, ensuring commitments align with negotiated terms.',
    `procurement_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Cost commitments are backed by purchase orders. Business process: commitment vs actual cost reconciliation, budget tracking, variance analysis, procurement audit trail for capital projects.',
    `procurement_vendor_id` BIGINT COMMENT 'Reference to the vendor or contractor party responsible for fulfilling this commitment. Links to the supplier master data for procurement and payment processing.',
    `project_contract_id` BIGINT COMMENT 'Foreign key linking to project.project_contract. Business justification: Cost commitments are often raised against project contracts (POs, subcontracts). Currently cost_commitment has contract_start_date and contract_end_date but no FK to project_contract. Adding project_c',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Commitments (POs, contracts) post to WBS for accrual accounting and funds reservation. Critical for project cost control and preventing budget overruns in mining capital projects.',
    `revised_cost_commitment_id` BIGINT COMMENT 'Self-referencing FK on cost_commitment (revised_cost_commitment_id)',
    `approval_date` DATE COMMENT 'Date when the cost commitment received final approval to proceed. Represents the stage-gate approval milestone for commitment execution.',
    `approved_by` STRING COMMENT 'Name or identifier of the authority who approved the commitment. Provides governance and audit trail for commitment authorization.',
    `buyer_name` STRING COMMENT 'Name of the procurement buyer or contracts administrator responsible for managing this commitment. Provides procurement accountability and escalation contact.',
    `capex_category` STRING COMMENT 'Classification of the capital expenditure type for financial reporting and investment analysis. Distinguishes between sustaining capital, growth capital, and other CAPEX categories per mining industry standards.. Valid values are `sustaining|expansion|exploration|compliance|infrastructure`',
    `commitment_date` DATE COMMENT 'Date when the cost commitment was formally established. Represents the business event date when the contractual or purchase obligation was created, distinct from system audit timestamps.',
    `commitment_description` STRING COMMENT 'Detailed textual description of the goods, services, or works covered by this cost commitment. Provides business context for the commitment scope and deliverables.',
    `commitment_number` STRING COMMENT 'Business identifier for the cost commitment. Externally-known unique number used for tracking and reference in procurement and project management systems. Typically a purchase order number, contract number, or letter of intent reference.. Valid values are `^[A-Z0-9]{8,20}$`',
    `commitment_status` STRING COMMENT 'Current lifecycle status of the cost commitment. Tracks the commitment from initial creation through approval, execution, invoicing, and closure. [ENUM-REF-CANDIDATE: draft|approved|active|partially_invoiced|fully_invoiced|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `commitment_type` STRING COMMENT 'Classification of the commitment instrument. Indicates the nature of the contractual or purchase obligation that creates the cost commitment.. Valid values are `purchase_order|contract|letter_of_intent|blanket_order|service_agreement|framework_agreement`',
    `committed_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the cost commitment in the commitment currency. Represents the contractual or purchase order obligation amount before any invoicing or payments.',
    `contract_end_date` DATE COMMENT 'Scheduled or contracted end date for the commitment. Defines the completion milestone and close-out timeline for the commitment.',
    `contract_start_date` DATE COMMENT 'Effective start date of the contract or purchase order. Marks the beginning of the commitment period and vendor obligations.',
    `cost_category` STRING COMMENT 'Classification of the commitment by capital project cost discipline. Aligns with standard project cost breakdown structures for mining capital projects including plant construction, infrastructure, and owner costs. [ENUM-REF-CANDIDATE: civil|structural|mechanical|electrical|instrumentation|piping|earthworks|owner_costs|indirect_costs|contingency — 10 candidates stripped; promote to reference product]',
    `cost_centre_code` STRING COMMENT 'Cost centre code for organizational cost allocation. Used when the commitment needs to be tracked against a specific operational or administrative cost centre in addition to the project WBS.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this cost commitment record was first created in the data platform. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the committed amount. Indicates the currency in which the commitment was established.. Valid values are `^[A-Z]{3}$`',
    `expected_delivery_date` DATE COMMENT 'Planned or contracted date for delivery of goods or completion of services. Used for project schedule integration and progress tracking.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'Committed amount converted to the organizations functional reporting currency at the commitment date exchange rate. Used for consolidated project cost reporting and financial analysis.',
    `gl_account_code` STRING COMMENT 'General ledger account code for financial posting classification. Maps the commitment to the appropriate capital expenditure account in the chart of accounts.. Valid values are `^[0-9]{4,10}$`',
    `invoiced_amount` DECIMAL(18,2) COMMENT 'Cumulative amount invoiced against this commitment to date. Tracks the progression from commitment to actual cost as invoices are received and processed.',
    `is_change_order` BOOLEAN COMMENT 'Indicates whether this commitment represents a change order or variation to an existing contract. Used for tracking scope changes and cost overruns.',
    `payment_term_code` STRING COMMENT 'Code representing the payment terms agreed with the vendor. Defines the payment schedule, discount conditions, and due date calculation rules.. Valid values are `^[A-Z0-9]{2,10}$`',
    `remaining_commitment` DECIMAL(18,2) COMMENT 'Uncommitted balance remaining on this commitment. Calculated as committed amount minus invoiced amount, representing the outstanding obligation.',
    `requisitioner_name` STRING COMMENT 'Name of the person or role who initiated the purchase requisition or commitment request. Provides accountability and contact reference for commitment queries.',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of payment withheld as retention until contract completion or defects liability period expiry. Common in construction and engineering contracts for quality assurance.',
    `risk_category` STRING COMMENT 'Risk classification of the commitment based on vendor performance, contract complexity, delivery criticality, or financial exposure. Supports risk-based project management.. Valid values are `low|medium|high|critical`',
    `source_system` STRING COMMENT 'Identifier of the operational system from which this commitment record originated. Supports data lineage and reconciliation across multiple source systems.. Valid values are `SAP_S4HANA|PRONTO_XI|INFOR_EAM|MANUAL_ENTRY`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this cost commitment record was last modified. Audit trail for record changes and data currency tracking.',
    CONSTRAINT pk_cost_commitment PRIMARY KEY(`cost_commitment_id`)
) COMMENT 'Transactional record of each cost commitment raised against a capital project, representing a contractual or purchase order obligation. Captures commitment type (purchase order, contract, letter of intent), commitment number, vendor or contractor name, commitment date, committed amount, currency, cost category (civil, structural, mechanical, electrical, instrumentation, owner costs), WBS element, and commitment status. Feeds the project cost control ledger for committed cost reporting.';

CREATE OR REPLACE TABLE `mining_ecm`.`project`.`expenditure_actual` (
    `expenditure_actual_id` BIGINT COMMENT 'Unique identifier for the actual capital expenditure transaction record. Primary key for the expenditure_actual product.',
    `capital_project_id` BIGINT COMMENT 'Reference to the parent capital project to which this actual expenditure is charged.',
    `cost_commitment_id` BIGINT COMMENT 'Foreign key linking to project.cost_commitment. Business justification: Actual expenditures are posted against cost commitments. Currently expenditure_actual has commitment_item_reference (STRING) which is a text reference. Adding cost_commitment_id FK creates a structure',
    `employee_id` BIGINT COMMENT 'The system user ID of the person or automated process that posted this actual expenditure transaction to the financial system.',
    `procurement_goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Project expenditures tied to goods receipts for material costs. Business process: inventory capitalization, project cost recognition timing, three-way match validation. Removes denormalized goods_rece',
    `procurement_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Project expenditures originate from purchase orders. Business process: three-way match (PO-GR-Invoice), cost allocation to WBS, procurement audit, variance analysis. Removes denormalized purchase_orde',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Actual expenditures post to WBS elements for project accounting integration with general ledger. Enables earned value analysis and capex vs opex classification for mining projects.',
    `reversal_expenditure_actual_id` BIGINT COMMENT 'Self-referencing FK on expenditure_actual (reversal_expenditure_actual_id)',
    `actual_amount` DECIMAL(18,2) COMMENT 'The monetary value of the actual expenditure posted in the transaction currency. This is the gross amount before any adjustments or allocations.',
    `asset_number` STRING COMMENT 'The fixed asset number to which this expenditure was capitalized, if the expenditure resulted in asset creation or enhancement.. Valid values are `^[A-Z0-9]{1,12}$`',
    `business_area_code` STRING COMMENT 'The business area or segment code for internal management reporting and segment analysis of project expenditures.. Valid values are `^[A-Z0-9]{1,4}$`',
    `commitment_item_reference` STRING COMMENT 'Reference to the commitment line item (purchase order or contract line) that this actual expenditure settles or reduces.',
    `company_code` STRING COMMENT 'The SAP company code representing the legal entity that incurred this actual expenditure.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_category_code` STRING COMMENT 'High-level classification of the expenditure as Capital Expenditure (CAPEX), Operating Expenditure (OPEX), sustaining capital, expansion capital, or exploration expenditure.. Valid values are `CAPEX|OPEX|SUSTAINING|EXPANSION|EXPLORATION`',
    `cost_element_code` STRING COMMENT 'The cost element (nature of expense) code that classifies the type of expenditure, such as labor, materials, equipment, or services.. Valid values are `^[A-Z0-9]{1,10}$`',
    `cost_element_description` STRING COMMENT 'The descriptive name of the cost element, providing human-readable classification of the expenditure type.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this expenditure actual record was first created in the source system.',
    `document_date` DATE COMMENT 'The date on the source document (invoice, goods receipt, timesheet) that originated this expenditure transaction.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the transaction currency amount to the local currency amount.',
    `financial_document_number` STRING COMMENT 'The unique financial document number in the general ledger that records this actual expenditure transaction. Provides full audit trail to FI posting.. Valid values are `^[A-Z0-9]{1,10}$`',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or accounting period) within the fiscal year in which this actual expenditure was posted.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this actual expenditure was posted, derived from the posting date.',
    `invoice_reference_number` STRING COMMENT 'The vendor invoice number or reference that supports this actual expenditure posting, providing traceability to the source document.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'The actual expenditure amount converted to the local (company code) currency for consolidated reporting.',
    `local_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code representing the local (company code) currency.. Valid values are `^[A-Z]{3}$`',
    `posting_date` DATE COMMENT 'The date on which the actual expenditure was posted to the financial ledger. This is the accounting date that determines the fiscal period for cost recognition.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of goods or services received or consumed in this expenditure transaction, if applicable and measurable.',
    `record_active_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this expenditure actual record is currently active and valid for reporting, or has been logically deleted or archived.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this expenditure transaction is a reversal or cancellation of a previously posted actual cost.',
    `reversed_document_number` STRING COMMENT 'The financial document number of the original transaction that this reversal posting cancels, if reversal_indicator is true.. Valid values are `^[A-Z0-9]{1,10}$`',
    `source_system_code` STRING COMMENT 'The originating system or module from which this actual expenditure record was sourced, such as SAP PS, SAP FI, SAP MM, or external interface.. Valid values are `SAP_PS|SAP_FI|SAP_MM|INTERFACE|MANUAL`',
    `text_description` STRING COMMENT 'Free-text description or memo field providing additional context or explanation for this actual expenditure transaction.',
    `transaction_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the actual expenditure was originally recorded.. Valid values are `^[A-Z]{3}$`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity field, such as tonnes (T), meters (M), hours (HR), or each (EA).. Valid values are `^[A-Z]{2,3}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this expenditure actual record was last modified in the source system.',
    `vendor_code` STRING COMMENT 'The unique identifier of the vendor or supplier from whom goods or services were procured, if applicable to this expenditure.. Valid values are `^[A-Z0-9]{1,10}$`',
    `vendor_name` STRING COMMENT 'The legal or trading name of the vendor or supplier associated with this expenditure transaction.',
    CONSTRAINT pk_expenditure_actual PRIMARY KEY(`expenditure_actual_id`)
) COMMENT 'Transactional record of actual capital expenditure posted against a project WBS element, sourced from the SAP PS/FI integration. Captures posting date, accounting period, cost element, vendor invoice reference, goods receipt reference, actual amount, currency, cost category, and the originating financial document number. Provides the actuals leg of the project cost control triangle (budget vs committed vs actual).';

CREATE OR REPLACE TABLE `mining_ecm`.`project`.`change_order` (
    `change_order_id` BIGINT COMMENT 'Unique identifier for the project change order record. Primary key for the change order entity.',
    `capital_project_id` BIGINT COMMENT 'Reference to the capital project to which this change order applies. Links the change order to the parent project record.',
    `procurement_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Project change orders trigger PO amendments for scope changes. Business process: procurement impact assessment, cost change tracking, PO modification workflow, change order cost validation.',
    `project_contract_id` BIGINT COMMENT 'Foreign key linking to project.project_contract. Business justification: Change orders are often raised against project contracts (contract variations). Currently change_order has contract_reference (STRING) and contractor_name (STRING). Adding project_contract_id FK creat',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Change orders impact WBS budget baselines and require budget amendment approvals. Mining projects track scope changes against WBS for cost variance analysis and audit trails.',
    `superseded_change_order_id` BIGINT COMMENT 'Self-referencing FK on change_order (superseded_change_order_id)',
    `approval_authority_level` STRING COMMENT 'Hierarchical level of approval authority required for this change order, typically determined by the magnitude of cost and schedule impact. Ensures appropriate governance oversight.. Valid values are `Project Manager|Project Director|Change Control Board|Executive Steering Committee|Board of Directors`',
    `approval_date` DATE COMMENT 'Date when the change order was formally approved by the designated approving authority. Null if the change order is pending, rejected, or withdrawn.',
    `approving_authority` STRING COMMENT 'Name or title of the individual or governance body authorized to approve or reject the change order (e.g., Project Manager, Project Director, Change Control Board, Steering Committee). Reflects delegation of authority based on change order value and impact.',
    `baseline_update_flag` BOOLEAN COMMENT 'Boolean indicator of whether the approved change order has been incorporated into the project baseline (scope, schedule, cost). True indicates baseline has been updated; False indicates pending baseline update.',
    `capex_impact_amount` DECIMAL(18,2) COMMENT 'Portion of the cost impact that affects capital expenditure budget. Used for tracking changes to capitalized project costs and asset valuation.',
    `change_category` STRING COMMENT 'Functional area or discipline impacted by the change order. Identifies which project domain (engineering, procurement, construction, commissioning, health safety environment, regulatory, commercial, or schedule) is primarily affected. [ENUM-REF-CANDIDATE: Engineering|Procurement|Construction|Commissioning|HSE|Regulatory|Commercial|Schedule — 8 candidates stripped; promote to reference product]',
    `change_description` STRING COMMENT 'Detailed narrative description of the proposed change, including technical specifications, scope modifications, rationale, and business justification. Provides comprehensive context for approval decision-making.',
    `change_justification` STRING COMMENT 'Business rationale and justification for the change order. Explains why the change is necessary, the risks of not implementing it, and the expected benefits or risk mitigation achieved.',
    `change_order_number` STRING COMMENT 'Externally-known unique business identifier for the change order, typically following organizational numbering convention (e.g., CO-000123). Used for communication, approvals, and audit trails.. Valid values are `^CO-[0-9]{6,10}$`',
    `change_order_status` STRING COMMENT 'Current lifecycle status of the change order in the approval and implementation workflow. Tracks progression from initial draft through approval to implementation and closure. [ENUM-REF-CANDIDATE: Draft|Submitted|Under Review|Approved|Rejected|Withdrawn|Implemented|Closed — 8 candidates stripped; promote to reference product]',
    `change_title` STRING COMMENT 'Brief descriptive title summarizing the change order for quick identification and reporting purposes.',
    `change_type` STRING COMMENT 'Classification of the nature of the change request. Categorizes whether the change adds scope, reduces scope, modifies design, addresses regulatory requirements, responds to force majeure events, or adjusts schedule without scope impact.. Valid values are `Scope Addition|Scope Reduction|Design Change|Regulatory Requirement|Force Majeure|Schedule Adjustment`',
    `cost_impact_amount` DECIMAL(18,2) COMMENT 'Total financial impact of the change order on the project budget, expressed in the project currency. Positive values indicate cost increases; negative values indicate cost savings. Used for budget amendment and cost control reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the change order record was first created in the system. Used for audit trail and tracking change order lifecycle duration.',
    `critical_path_impact_flag` BOOLEAN COMMENT 'Boolean indicator of whether the change order impacts activities on the project critical path. True indicates the change affects critical path and may delay project completion; False indicates non-critical path impact.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost impact amount (e.g., USD, AUD, CAD). Ensures consistent financial reporting across multi-currency projects.. Valid values are `^[A-Z]{3}$`',
    `hse_impact_assessment` STRING COMMENT 'Assessment of how the change order affects health, safety, and environmental aspects of the project. Identifies new HSE risks, mitigation measures, or improvements to HSE performance.',
    `implementation_date` DATE COMMENT 'Date when the approved change order was implemented and incorporated into the project baseline (scope, schedule, budget). Used for tracking change order execution and project baseline updates.',
    `milestone_impact_description` STRING COMMENT 'Narrative description of how the change order affects key project milestones, including which milestones are impacted and the nature of the impact (delay, acceleration, scope change).',
    `opex_impact_amount` DECIMAL(18,2) COMMENT 'Portion of the cost impact that affects operating expenditure budget. Used for tracking changes to operational costs during commissioning or early operations phases.',
    `originator_name` STRING COMMENT 'Name of the individual or party who initiated the change order request. May be internal project team member, contractor, consultant, or regulatory authority.',
    `originator_organization` STRING COMMENT 'Organization or company that the change order originator represents (e.g., owner, contractor, subcontractor, engineering firm, regulatory body).',
    `priority` STRING COMMENT 'Priority level assigned to the change order for review and approval processing. Critical and High priority changes require expedited review due to schedule or safety impacts.. Valid values are `Critical|High|Medium|Low`',
    `quality_impact_assessment` STRING COMMENT 'Assessment of how the change order affects project quality standards, specifications, or deliverable quality. Identifies any quality improvements or potential quality risks.',
    `rejection_date` DATE COMMENT 'Date when the change order was formally rejected by the approving authority. Null if not rejected.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the approving authority for rejecting the change order. Null if the change order was not rejected. Used for lessons learned and continuous improvement.',
    `required_by_date` DATE COMMENT 'Target date by which the change order decision is required to avoid project delays or other negative impacts. Used for prioritizing review and approval activities.',
    `review_comments` STRING COMMENT 'Comments and feedback provided by reviewers during the change order evaluation process. Captures discussion points, concerns raised, and conditions for approval.',
    `risk_impact_assessment` STRING COMMENT 'Assessment of how the change order affects project risks, including new risks introduced, existing risks mitigated, or changes to risk exposure. Supports risk-informed decision-making.',
    `schedule_impact_days` STRING COMMENT 'Impact of the change order on the project schedule, measured in calendar days. Positive values indicate schedule delays; negative values indicate schedule acceleration. Used for schedule baseline updates and critical path analysis.',
    `scope_impact_description` STRING COMMENT 'Detailed description of how the change order modifies the project scope, including additions, deletions, or modifications to deliverables, specifications, or work breakdown structure elements.',
    `submission_date` DATE COMMENT 'Date when the change order was formally submitted for review and approval. Marks the start of the approval workflow and is used for tracking approval cycle time.',
    `supporting_documents` STRING COMMENT 'References or file paths to supporting documentation for the change order, such as technical drawings, cost estimates, schedule impact analysis, risk assessments, or regulatory correspondence.',
    `updated_by_user` STRING COMMENT 'Username or identifier of the user who last modified the change order record. Used for audit trail and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the change order record was last modified. Used for audit trail and tracking change order progression through workflow stages.',
    `withdrawal_reason` STRING COMMENT 'Explanation provided by the originator for withdrawing the change order before approval decision. Null if the change order was not withdrawn.',
    CONSTRAINT pk_change_order PRIMARY KEY(`change_order_id`)
) COMMENT 'Formal project change order record capturing approved scope, schedule, or cost changes to a capital project. Captures change order number, change type (scope addition, scope reduction, design change, regulatory requirement, force majeure), change description, cost impact, schedule impact in days, originator, approval date, approving authority, and change status (Pending, Approved, Rejected, Withdrawn). Feeds budget amendments and schedule updates.';

CREATE OR REPLACE TABLE `mining_ecm`.`project`.`risk_register` (
    `risk_register_id` BIGINT COMMENT 'Unique identifier for the risk register. Primary key for the risk register master record.',
    `capital_project_id` BIGINT COMMENT 'Identifier of the capital project to which this risk register belongs. Links the risk register to its parent project.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `primary_risk_employee_id` BIGINT COMMENT 'Identifier of the person responsible for maintaining and updating the risk register, typically the project risk manager or project manager.',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Project risk registers track geological risks at prospect level. Resource confidence, exploration upside, and geological uncertainty are assessed per prospect. Risk owners need this link for geologica',
    `stage_gate_id` BIGINT COMMENT 'Identifier of the stage-gate review for which this risk register was prepared, linking the register to project governance milestones.',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Project risk registers track tenement-specific risks including tenure security, renewal obligations, expenditure commitments, native title claims, heritage restrictions, regulatory conditions, and rel',
    `superseded_risk_register_id` BIGINT COMMENT 'Self-referencing FK on risk_register (superseded_risk_register_id)',
    `active_risk_count` STRING COMMENT 'Number of risks currently in active status, excluding closed, retired, or transferred risks.',
    `approval_authority` STRING COMMENT 'Name or title of the governance body or individual who approved this risk register version (e.g., Project Steering Committee, VP Projects).',
    `approval_date` DATE COMMENT 'Date when this risk register version was formally approved by the designated approval authority.',
    `baseline_date` DATE COMMENT 'The date when this risk register was established as the project risk baseline for stage-gate or governance purposes.',
    `confidence_level_percent` DECIMAL(18,2) COMMENT 'Statistical confidence level used for risk quantification and reporting (e.g., 80%, 90%), expressed as a percentage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk register record was first created in the system.',
    `critical_risk_count` STRING COMMENT 'Number of risks classified as critical or high severity requiring executive attention and mitigation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary risk exposure values in this register (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `key_assumptions` STRING COMMENT 'Key assumptions underlying the risk assessment and quantification in this register (e.g., commodity price assumptions, regulatory environment).',
    `last_review_date` DATE COMMENT 'The date when the risk register was last formally reviewed and updated by the project risk management team.',
    `monte_carlo_iterations` STRING COMMENT 'Number of iterations used in Monte Carlo simulation for quantitative risk analysis, if applicable (typically 5,000 to 10,000).',
    `next_review_date` DATE COMMENT 'The scheduled date for the next formal review of the risk register, typically aligned with project milestones or monthly cycles.',
    `project_phase_code` STRING COMMENT 'Code identifying the project phase to which this risk register applies (e.g., FEASIBILITY, DESIGN, CONSTRUCTION, COMMISSIONING).',
    `record_active_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this risk register record is currently active (True) or has been logically deleted or archived (False).',
    `register_code` STRING COMMENT 'Business identifier or code for the risk register, typically following organizational naming conventions (e.g., RR-PROJECT-001).',
    `register_date` DATE COMMENT 'The effective date of this risk register version, representing the baseline date for the risk assessment snapshot.',
    `register_description` STRING COMMENT 'Detailed description of the risk register purpose, scope, and context within the project lifecycle.',
    `register_name` STRING COMMENT 'Descriptive name of the risk register, typically including the project name and version or phase identifier.',
    `register_notes` STRING COMMENT 'Additional notes, comments, or context relevant to this risk register version, including changes from previous versions.',
    `register_status` STRING COMMENT 'Current lifecycle status of the risk register indicating its approval state and usability for decision-making.. Valid values are `draft|active|under_review|approved|superseded|archived`',
    `register_version` STRING COMMENT 'Version number or identifier of the risk register, incremented with each major update or review cycle.',
    `risk_appetite_statement` STRING COMMENT 'Statement describing the organizations risk appetite and tolerance levels applicable to this project and risk register.',
    `risk_framework` STRING COMMENT 'The risk management framework or standard applied (e.g., ISO 31000, COSO ERM, PMI Risk Management).',
    `risk_methodology` STRING COMMENT 'The methodology used for risk quantification and analysis in this register (e.g., Monte Carlo simulation, deterministic analysis, qualitative scoring).. Valid values are `monte_carlo|deterministic|qualitative|quantitative|hybrid`',
    `risk_threshold_cost_usd` DECIMAL(18,2) COMMENT 'The cost impact threshold in USD above which a risk is escalated to executive management for review and decision.',
    `risk_threshold_schedule_days` DECIMAL(18,2) COMMENT 'The schedule impact threshold in days above which a risk is escalated to executive management for review and decision.',
    `total_cost_exposure_p50_usd` DECIMAL(18,2) COMMENT 'Total quantified cost risk exposure at the 50th percentile (P50 or median) in USD, representing the expected cost impact of all risks.',
    `total_cost_exposure_p80_usd` DECIMAL(18,2) COMMENT 'Total quantified cost risk exposure at the 80th percentile (P80) in USD, representing a higher confidence level for cost contingency planning.',
    `total_cost_exposure_p90_usd` DECIMAL(18,2) COMMENT 'Total quantified cost risk exposure at the 90th percentile (P90) in USD, representing a conservative estimate for risk reserves.',
    `total_risk_count` STRING COMMENT 'Total number of individual risk items recorded in this risk register version.',
    `total_schedule_exposure_p50_days` DECIMAL(18,2) COMMENT 'Total quantified schedule risk exposure at the 50th percentile (P50) in days, representing the expected schedule delay impact of all risks.',
    `total_schedule_exposure_p80_days` DECIMAL(18,2) COMMENT 'Total quantified schedule risk exposure at the 80th percentile (P80) in days, used for schedule contingency planning.',
    `total_schedule_exposure_p90_days` DECIMAL(18,2) COMMENT 'Total quantified schedule risk exposure at the 90th percentile (P90) in days, representing a conservative schedule buffer estimate.',
    `updated_by_user` STRING COMMENT 'Username or identifier of the user who last updated this risk register record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk register record was last updated in the system.',
    CONSTRAINT pk_risk_register PRIMARY KEY(`risk_register_id`)
) COMMENT 'Master record of the project risk register for a capital project, representing the current risk management baseline. Captures register version, register date, total number of risks, total quantified risk exposure (P50, P80, P90 cost and schedule), risk methodology (Monte Carlo, deterministic), register owner, and last review date. Parent entity for individual risk items; provides the aggregate risk profile used in stage-gate reviews.';

CREATE OR REPLACE TABLE `mining_ecm`.`project`.`risk_item` (
    `risk_item_id` BIGINT COMMENT 'Unique identifier for the risk or opportunity item within the project risk register. Primary key.',
    `capital_project_id` BIGINT COMMENT 'Reference to the capital project to which this risk item belongs. Links risk to mine development, plant expansion, or infrastructure project.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `procurement_vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Project risks are vendor-specific (delivery risk, performance risk, financial stability). Business need: risk mitigation planning, vendor performance monitoring, contingency planning for vendor failur',
    `risk_register_id` BIGINT COMMENT 'Foreign key linking to project.risk_register. Business justification: Risk items belong to a risk register. Currently risk_item has risk_register_version (STRING) but no FK to risk_register. This is a clear parent-child relationship - risk items are managed within regis',
    `parent_risk_item_id` BIGINT COMMENT 'Self-referencing FK on risk_item (parent_risk_item_id)',
    `affected_disciplines` STRING COMMENT 'Engineering or functional disciplines impacted by this risk (e.g., civil, mechanical, electrical, process, geotechnical, environmental). Supports cross-functional risk coordination.',
    `affected_wbs_elements` STRING COMMENT 'Comma-separated list of Work Breakdown Structure codes or elements that would be impacted by this risk. Links risk to specific project deliverables or work packages.',
    `closure_reason` STRING COMMENT 'Explanation of why the risk was closed. May include risk no longer applicable, risk realized and managed, project phase completed, or risk transferred.',
    `comments` STRING COMMENT 'Additional notes, observations, or context related to the risk item. May include stakeholder feedback, lessons learned, or special considerations.',
    `consequence_rating_post_mitigation` STRING COMMENT 'Qualitative assessment of the severity of impact if the risk event occurs after mitigation actions have been implemented. Represents residual consequence.. Valid values are `insignificant|minor|moderate|major|catastrophic`',
    `consequence_rating_pre_mitigation` STRING COMMENT 'Qualitative assessment of the severity of impact if the risk event occurs before any mitigation actions are applied. Uses five-point scale from insignificant to catastrophic.. Valid values are `insignificant|minor|moderate|major|catastrophic`',
    `contingency_plan` STRING COMMENT 'Documented response plan to be executed if the risk event occurs. Outlines specific actions, resources, and responsibilities for managing the realized risk impact.',
    `cost_impact_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated financial impact of the risk event if it occurs, expressed in US dollars. Used for quantitative risk analysis and contingency budget calculation. Positive value for threats (cost increase), negative value for opportunities (cost savings).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the risk item record was first created in the data platform. Supports data lineage and audit trail.',
    `last_review_date` DATE COMMENT 'Date when the risk item was most recently reviewed and assessed. Used to ensure regular risk monitoring and updates.',
    `likelihood_rating_post_mitigation` STRING COMMENT 'Qualitative assessment of the probability that the risk event will occur after mitigation actions have been implemented. Represents residual likelihood.. Valid values are `rare|unlikely|possible|likely|almost_certain`',
    `likelihood_rating_pre_mitigation` STRING COMMENT 'Qualitative assessment of the probability that the risk event will occur before any mitigation actions are applied. Uses five-point scale from rare to almost certain.. Valid values are `rare|unlikely|possible|likely|almost_certain`',
    `mitigation_actions` STRING COMMENT 'Detailed description of the actions, controls, or strategies implemented or planned to reduce the likelihood or consequence of the risk. May include preventive measures, detective controls, or corrective actions.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of this risk item. Ensures periodic reassessment of risk status and mitigation effectiveness.',
    `probability_percentage` DECIMAL(18,2) COMMENT 'Quantitative probability that the risk event will occur, expressed as a percentage (0.00 to 100.00). Used for Quantitative Risk Analysis (QRA) and Monte Carlo simulation inputs.',
    `record_active_flag` BOOLEAN COMMENT 'Indicates whether this risk item record is currently active (true) or logically deleted (false). Supports soft delete pattern for data retention.',
    `residual_risk_status` STRING COMMENT 'Assessment of whether the post-mitigation risk level is acceptable to the project. Acceptable indicates risk within tolerance, monitor indicates ongoing surveillance required, escalate indicates senior management attention needed, further action required indicates additional mitigation needed.. Valid values are `acceptable|monitor|escalate|further_action_required`',
    `risk_category` STRING COMMENT 'Primary classification of the risk type. Categories include technical (engineering, design), commercial (market, pricing), geotechnical (ground conditions, stability), regulatory (permits, compliance), environmental (impact, rehabilitation), HSE (health, safety, environment), schedule (delays, critical path), and cost (budget overruns, CAPEX). [ENUM-REF-CANDIDATE: technical|commercial|geotechnical|regulatory|environmental|hse|schedule|cost — 8 candidates stripped; promote to reference product]',
    `risk_closed_date` DATE COMMENT 'Date when the risk item was formally closed or retired from active management. Null if risk remains open.',
    `risk_code` STRING COMMENT 'Unique alphanumeric code assigned to the risk item for tracking and reference purposes within the risk register.. Valid values are `^[A-Z0-9]{3,20}$`',
    `risk_description` STRING COMMENT 'Detailed narrative description of the risk event, including causes, potential impacts, and context. Provides comprehensive understanding of the risk scenario.',
    `risk_identified_date` DATE COMMENT 'Date when the risk item was first identified and entered into the risk register. Tracks risk discovery timeline.',
    `risk_proximity` STRING COMMENT 'Timeframe within which the risk event is expected to occur or impact the project. Immediate indicates within current reporting period, near term within 3 months, medium term within 6-12 months, long term beyond 12 months.. Valid values are `immediate|near_term|medium_term|long_term`',
    `risk_response_strategy` STRING COMMENT 'Primary strategy selected for managing the risk. For threats: avoid (eliminate), mitigate (reduce), transfer (shift to third party), accept (acknowledge without action). For opportunities: exploit (ensure realization), enhance (increase probability/impact), share (allocate to partner), accept. [ENUM-REF-CANDIDATE: avoid|mitigate|transfer|accept|exploit|enhance|share — 7 candidates stripped; promote to reference product]',
    `risk_score_post_mitigation` STRING COMMENT 'Numerical risk score calculated from likelihood and consequence ratings after mitigation. Represents residual risk level. Used to assess effectiveness of mitigation strategies.',
    `risk_score_pre_mitigation` STRING COMMENT 'Numerical risk score calculated from likelihood and consequence ratings before mitigation. Typically derived from risk matrix (e.g., 1-25 scale). Used for risk prioritization and Quantitative Risk Analysis (QRA).',
    `risk_status` STRING COMMENT 'Current lifecycle status of the risk item. Open indicates newly identified, active indicates under management, mitigated indicates controls implemented, closed indicates risk no longer applicable, accepted indicates risk acknowledged without mitigation, transferred indicates risk passed to third party.. Valid values are `open|active|mitigated|closed|accepted|transferred`',
    `risk_title` STRING COMMENT 'Concise title or name of the risk or opportunity that summarizes the risk event or condition.',
    `risk_trigger_event` STRING COMMENT 'Description of the early warning indicator or event that signals the risk is about to occur or has increased in likelihood. Enables proactive risk response activation.',
    `risk_type` STRING COMMENT 'Indicates whether the risk item represents a threat (negative impact) or an opportunity (positive impact) to project objectives.. Valid values are `threat|opportunity`',
    `schedule_impact_days` STRING COMMENT 'Estimated impact on project schedule if the risk event occurs, measured in calendar days. Positive value indicates delay, negative value indicates acceleration. Used for Monte Carlo schedule simulation.',
    `updated_by_user` STRING COMMENT 'Username or identifier of the person who last updated this risk item record. Supports accountability and audit trail.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when the risk item record was most recently modified. Tracks data currency and change history.',
    CONSTRAINT pk_risk_item PRIMARY KEY(`risk_item_id`)
) COMMENT 'Individual risk or opportunity item within a project risk register. Captures risk ID, risk title, risk category (technical, commercial, geotechnical, regulatory, environmental, HSE, schedule, cost), risk description, likelihood rating, consequence rating, risk score (pre-mitigation and post-mitigation), risk owner, mitigation actions, contingency plan, residual risk status, and last review date. Supports quantitative risk analysis (QRA) and Monte Carlo simulation inputs.';

CREATE OR REPLACE TABLE `mining_ecm`.`project`.`project_contract` (
    `project_contract_id` BIGINT COMMENT 'Unique identifier for the project contract record. Primary key.',
    `capital_project_id` BIGINT COMMENT 'Reference to the capital project to which this contract belongs.',
    `contractor_id` BIGINT COMMENT 'Reference to the contractor or vendor master record in the supply chain system.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Project contracts commit against cost centre budgets for funds reservation and commitment reporting. Mining projects track contract commitments via cost centres for budget vs actual variance analysis.',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Project execution contracts leverage procurement framework agreements for materials. Business need: accessing negotiated rates, ensuring contract compliance, validating pricing against master agreemen',
    `procurement_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Project contracts generate purchase orders for materials/services procurement. Business process: procurement execution tracking, commitment vs PO reconciliation, contract compliance monitoring, three-',
    `employee_id` BIGINT COMMENT 'Reference to the contract administrator responsible for day-to-day contract management, variations, and claims.',
    `project_contract_employee_id` BIGINT COMMENT 'Reference to the project manager responsible for overseeing this contract on behalf of the mining company.',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Mining construction and services contracts specify which tenement(s) work will be performed on for site access rights, regulatory compliance, heritage clearance requirements, and tenement-specific con',
    `parent_project_contract_id` BIGINT COMMENT 'Self-referencing FK on project_contract (parent_project_contract_id)',
    `actual_completion_date` DATE COMMENT 'Actual date when the contract work was completed and accepted. Null if contract is still in progress.',
    `actual_cost_to_date` DECIMAL(18,2) COMMENT 'Cumulative actual cost incurred to date under this contract, based on invoices received and payments made.',
    `approval_authority` STRING COMMENT 'Name or title of the person or committee that approved the contract (e.g., Board of Directors, CEO, CFO, Delegated Authority).',
    `approval_date` DATE COMMENT 'Date when the contract was internally approved by the appropriate authority (e.g., board, executive committee, delegated authority).',
    `committed_cost` DECIMAL(18,2) COMMENT 'Total cost committed under this contract, including original value and approved variations. Used for project cost control and forecasting.',
    `contract_number` STRING COMMENT 'Externally-known unique contract identifier assigned by the project or procurement team. Used for legal and financial reference.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the contract. Draft (being prepared), Under Review (legal/commercial review), Approved (internally approved), Executed (signed by all parties), Active (work in progress), Suspended (temporarily halted), Completed (work finished), Terminated (ended early), Closed (administratively closed). [ENUM-REF-CANDIDATE: Draft|Under Review|Approved|Executed|Active|Suspended|Completed|Terminated|Closed — 9 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the contract delivery model. EPC (Engineering Procurement Construction), EPCM (Engineering Procurement Construction Management), Lump Sum (fixed price), Reimbursable (cost reimbursable), Alliance (collaborative risk-sharing), Unit Rate (per-unit pricing), Design-Build (integrated design and construction). [ENUM-REF-CANDIDATE: EPC|EPCM|Lump Sum|Reimbursable|Cost Plus|Alliance|Unit Rate|Design-Build — 8 candidates stripped; promote to reference product]',
    `contract_value` DECIMAL(18,2) COMMENT 'Total monetary value of the contract as agreed at execution. Represents the baseline contract sum before variations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the contract value (e.g., USD, AUD, CAD, ZAR).. Valid values are `^[A-Z]{3}$`',
    `defects_liability_end_date` DATE COMMENT 'Date when the defects liability period expires and final retention can be released.',
    `defects_liability_period_days` STRING COMMENT 'Duration in days of the defects liability period (also known as warranty period) during which the contractor is responsible for rectifying defects after completion.',
    `document_reference` STRING COMMENT 'File path, document management system reference, or URL to the executed contract document and associated schedules.',
    `end_date` DATE COMMENT 'Planned or contractual completion date by which all work and deliverables must be finished.',
    `execution_date` DATE COMMENT 'Date when the contract was formally executed (signed) by all parties, making it legally binding.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Minimum insurance coverage amount required from the contractor. Null if no insurance is required.',
    `insurance_required` BOOLEAN COMMENT 'Indicates whether the contractor is required to maintain specific insurance coverage (e.g., public liability, professional indemnity, workers compensation) for this contract.',
    `liquidated_damages_applicable` BOOLEAN COMMENT 'Indicates whether liquidated damages (pre-agreed compensation for delay or non-performance) are applicable under this contract.',
    `liquidated_damages_rate` DECIMAL(18,2) COMMENT 'Daily or weekly rate of liquidated damages payable by the contractor for delay beyond the contract end date. Null if not applicable.',
    `payment_terms` STRING COMMENT 'Description of payment schedule and terms, including milestone-based payments, progress payments, or time-based installments.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Overall percentage completion of the contract scope, based on physical progress, milestones achieved, or earned value.',
    `performance_bond_amount` DECIMAL(18,2) COMMENT 'Monetary value of the performance bond or bank guarantee provided by the contractor. Null if no bond is required.',
    `performance_bond_expiry_date` DATE COMMENT 'Expiry date of the performance bond or bank guarantee. Must be monitored to ensure coverage throughout contract duration.',
    `performance_bond_required` BOOLEAN COMMENT 'Indicates whether a performance bond or bank guarantee is required from the contractor to secure contract performance.',
    `record_active_flag` BOOLEAN COMMENT 'Indicates whether this contract record is currently active in the system. False indicates a logically deleted or archived record.',
    `retention_amount` DECIMAL(18,2) COMMENT 'Total monetary amount currently held as retention under this contract.',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of each payment withheld as retention to ensure contract performance and defect rectification. Typically released after defects liability period.',
    `revised_contract_value` DECIMAL(18,2) COMMENT 'Current total contract value including the original contract value plus all approved variations. Represents the latest forecast final contract sum.',
    `scope_summary` STRING COMMENT 'High-level description of the contract scope, deliverables, and work packages covered by this contract.',
    `start_date` DATE COMMENT 'Effective start date of the contract when work is authorized to commence.',
    `title` STRING COMMENT 'Descriptive title or name of the contract summarizing its purpose.',
    `total_variation_amount` DECIMAL(18,2) COMMENT 'Cumulative monetary value of all approved variations to the original contract value. Can be positive (additions) or negative (omissions).',
    `updated_by_user` STRING COMMENT 'Username or identifier of the user who last updated this contract record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was last modified.',
    `variation_order_count` STRING COMMENT 'Total number of approved variation orders or change orders issued against this contract to date.',
    CONSTRAINT pk_project_contract PRIMARY KEY(`project_contract_id`)
) COMMENT 'Master record of contracts executed for a capital project, covering EPC, EPCM, lump-sum, reimbursable, and alliance contracts with engineering firms, construction contractors, and equipment suppliers. Captures contract number, contract type, contractor name, contract scope summary, contract value, currency, contract start and end dates, payment terms, retention percentage, performance bond details, contract status, and the responsible project manager. Distinct from supply.contract (operational procurement); this is the project-specific capital contract register.';

CREATE OR REPLACE TABLE `mining_ecm`.`project`.`progress_claim` (
    `progress_claim_id` BIGINT COMMENT 'Unique identifier for the progress claim record. Primary key for the progress claim entity.',
    `capital_project_id` BIGINT COMMENT 'Reference to the capital project against which this progress claim is submitted. Links the claim to the parent project entity.',
    `contractor_id` BIGINT COMMENT 'Reference to the contractor or vendor submitting the progress claim for work completed.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Contractor progress claims post to cost centres for accrual accounting and cash flow forecasting. Mining projects accrue contractor liabilities via cost centre for monthly financial close.',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to project.milestone. Business justification: Progress claims are often tied to contractual payment milestones (30% design complete, mechanical completion, substantial completion). Currently progress_claim links to project_contract but not to the',
    `employee_id` BIGINT COMMENT 'Reference to the engineer or project manager responsible for reviewing and certifying the progress claim for payment.',
    `procurement_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Contractor progress claims reference POs for materials supplied. Business process: payment verification, cost reconciliation, ensuring claimed costs match procured materials, audit trail.',
    `project_contract_id` BIGINT COMMENT 'Reference to the project contract under which this progress claim is submitted. Links the claim to the governing contract agreement.',
    `revised_progress_claim_id` BIGINT COMMENT 'Self-referencing FK on progress_claim (revised_progress_claim_id)',
    `certification_date` DATE COMMENT 'Date on which the certifying engineer or project manager certified the progress claim, approving it for payment processing.',
    `certified_amount` DECIMAL(18,2) COMMENT 'Amount certified by the certifying engineer or project manager as valid and payable, after review and verification of work completed. May differ from claimed amount.',
    `claim_notes` STRING COMMENT 'Free-text notes or comments related to the progress claim, capturing additional context, clarifications, or special conditions.',
    `claim_number` STRING COMMENT 'Unique business identifier for the progress claim, typically assigned sequentially within a contract or project. Used for external reference and communication.',
    `claim_period_end_date` DATE COMMENT 'End date of the work period covered by this progress claim. Defines the conclusion of the claim period for which work is being claimed.',
    `claim_period_start_date` DATE COMMENT 'Start date of the work period covered by this progress claim. Defines the beginning of the claim period for which work is being claimed.',
    `claim_sequence` STRING COMMENT 'Sequential number of this claim within the contract lifecycle, indicating the chronological order of claims submitted (e.g., 1st claim, 2nd claim).',
    `claim_status` STRING COMMENT 'Current lifecycle status of the progress claim indicating its position in the review and payment workflow. [ENUM-REF-CANDIDATE: Submitted|Under Review|Certified|Disputed|Approved|Rejected|Paid — 7 candidates stripped; promote to reference product]',
    `claim_type` STRING COMMENT 'Classification of the progress claim indicating the nature of the claim (e.g., regular periodic claim, final claim, variation claim, retention release).. Valid values are `Regular|Interim|Final|Variation|Retention Release|Milestone`',
    `claimed_amount` DECIMAL(18,2) COMMENT 'Total gross amount claimed by the contractor for work completed during the claim period, before any adjustments, certifications, or deductions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this progress claim record was first created in the system, used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this progress claim (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `dispute_reason` STRING COMMENT 'Detailed explanation of the reason for any disputed amount, documenting the basis for disagreement between contractor and project owner.',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Amount in dispute between the contractor and project owner, representing the difference between claimed and certified amounts or specific contested line items.',
    `due_date` DATE COMMENT 'Contractual due date by which the progress claim must be reviewed and certified or disputed, as per contract terms.',
    `invoice_number` STRING COMMENT 'Contractor invoice number associated with this progress claim, used for accounts payable processing and financial reconciliation.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'Net amount payable to the contractor for this claim after deducting retention, previous payments, and any other contractual deductions.',
    `payment_date` DATE COMMENT 'Actual date on which payment was made to the contractor for the certified claim amount.',
    `payment_reference` STRING COMMENT 'Payment transaction reference number or remittance advice number issued when payment was processed, used for financial reconciliation.',
    `payment_terms` STRING COMMENT 'Contractual payment terms applicable to this progress claim, defining the payment schedule and conditions (e.g., Net 30 days from certification).',
    `previous_claims_cumulative_amount` DECIMAL(18,2) COMMENT 'Cumulative total of all certified amounts from previous progress claims under this contract, used to calculate the current claim net amount.',
    `record_active_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this progress claim record is currently active (True) or has been logically deleted or archived (False).',
    `rejection_reason` STRING COMMENT 'Detailed explanation if the progress claim was rejected, documenting the basis for non-certification or non-payment.',
    `retention_amount` DECIMAL(18,2) COMMENT 'Amount withheld from the certified amount as retention, held as security until contract completion or defects liability period expiry, as per contract terms.',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of the certified amount withheld as retention for this claim, typically defined in the contract terms (e.g., 5% or 10%).',
    `submission_date` DATE COMMENT 'Date on which the contractor submitted the progress claim to the project owner or certifying authority for review.',
    `supporting_documents_reference` STRING COMMENT 'Reference identifier or file path to supporting documentation submitted with the progress claim (e.g., timesheets, delivery dockets, photos, inspection reports).',
    `updated_by_user` STRING COMMENT 'User identifier or username of the person who last modified this progress claim record, used for audit trail and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this progress claim record was last modified in the system, used for audit trail and change tracking.',
    `wbs_element` STRING COMMENT 'Work Breakdown Structure element code to which this progress claim is allocated for project cost tracking and reporting.',
    CONSTRAINT pk_progress_claim PRIMARY KEY(`progress_claim_id`)
) COMMENT 'Transactional record of contractor progress claims submitted against a project contract for work completed during a claim period. Captures claim number, claim period, claim submission date, claimed amount, certified amount, disputed amount, retention withheld, net payment amount, claim status (Submitted, Under Review, Certified, Disputed, Paid), certifying engineer, and certification date. Drives project cash flow and contractor payment processing.';

CREATE OR REPLACE TABLE `mining_ecm`.`project`.`issue` (
    `issue_id` BIGINT COMMENT 'Unique identifier for the project issue record. Primary key.',
    `capital_project_id` BIGINT COMMENT 'Reference to the capital project to which this issue belongs.',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Project issues arise during specific phases. Currently issue links to capital_project and project_contract but not to phase. This enables phase-specific issue tracking, phase performance analysis, and',
    `project_contract_id` BIGINT COMMENT 'Foreign key linking to project.project_contract. Business justification: Project issues may be contract-related (contractor performance, contract disputes). Currently project_issue has contract_reference (STRING). Adding project_contract_id FK creates a structured relation',
    `risk_item_id` BIGINT COMMENT 'Reference to a project risk register entry if this issue is the realization of a previously identified risk.',
    `parent_issue_id` BIGINT COMMENT 'Self-referencing FK on issue (parent_issue_id)',
    `actual_resolution_date` DATE COMMENT 'The date on which the issue was actually resolved and solution implemented. Null if not yet resolved.',
    `assigned_owner_name` STRING COMMENT 'Name of the individual assigned responsibility for investigating and resolving the issue.',
    `assigned_owner_organisation` STRING COMMENT 'Organisation or company that the assigned owner represents.',
    `closed_by_name` STRING COMMENT 'Name of the individual who formally closed the issue after verification of resolution.',
    `closure_date` DATE COMMENT 'The date on which the issue was formally closed and verified as resolved, typically after acceptance by the issue raiser or project governance.',
    `corrective_action` STRING COMMENT 'Specific actions taken to address the immediate issue and prevent recurrence.',
    `cost_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial impact of the issue on project cost, expressed in the project currency.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the issue record was first created in the project management system.',
    `critical_path_impact_flag` BOOLEAN COMMENT 'Indicates whether the issue affects activities on the project critical path. True if critical path is impacted, False otherwise.',
    `date_raised` DATE COMMENT 'The date on which the issue was formally identified and logged into the project issue register.',
    `discipline_code` STRING COMMENT 'Engineering or functional discipline associated with the issue (e.g., Civil, Mechanical, Electrical, Process, Instrumentation, Piping).',
    `escalation_date` DATE COMMENT 'The date on which the issue was escalated to a higher authority. Null if not escalated.',
    `escalation_level` STRING COMMENT 'The management level to which the issue has been escalated for decision or resolution: None (no escalation), Project Manager, Program Director, Executive, Board.. Valid values are `None|Project Manager|Program Director|Executive|Board`',
    `hse_incident_flag` BOOLEAN COMMENT 'Indicates whether the issue is related to or resulted from a health, safety, or environmental incident. True if HSE-related, False otherwise.',
    `issue_description` STRING COMMENT 'Detailed narrative description of the issue, including context, observed symptoms, impact, and any relevant background information.',
    `issue_number` STRING COMMENT 'Externally-known unique business identifier for the issue, typically formatted as a sequential or structured code used in project communications and reporting.',
    `issue_status` STRING COMMENT 'Current lifecycle state of the issue: Open (newly raised), In Progress (under investigation or remediation), Resolved (solution implemented), Closed (verified and archived), Escalated (elevated to higher authority), On Hold (temporarily suspended).. Valid values are `Open|In Progress|Resolved|Closed|Escalated|On Hold`',
    `issue_type` STRING COMMENT 'Classification of the issue by functional domain: Technical (engineering, design), Commercial (contract, cost), HSE (Health Safety Environment), Quality (non-conformance), Schedule (delay, milestone), Resource (labour, equipment).. Valid values are `Technical|Commercial|HSE|Quality|Schedule|Resource`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when the issue record was last modified.',
    `lessons_learned` STRING COMMENT 'Key insights, best practices, or preventive measures identified from the issue for future project improvement and knowledge management.',
    `notes` STRING COMMENT 'Additional comments, observations, or supplementary information related to the issue.',
    `priority` STRING COMMENT 'Urgency and importance ranking of the issue: Critical (immediate action required, project-stopping), High (significant impact, near-term action), Medium (moderate impact, scheduled resolution), Low (minor impact, backlog).. Valid values are `Critical|High|Medium|Low`',
    `raised_by_name` STRING COMMENT 'Name of the individual or party who identified and raised the issue.',
    `raised_by_organisation` STRING COMMENT 'Organisation or company that the person who raised the issue represents (e.g., owner, contractor, consultant, vendor).',
    `record_active_flag` BOOLEAN COMMENT 'Indicates whether the issue record is currently active in the system. True if active, False if logically deleted or archived.',
    `regulatory_impact_flag` BOOLEAN COMMENT 'Indicates whether the issue has regulatory or compliance implications (e.g., environmental approval, mining permit, safety regulation). True if regulatory impact exists, False otherwise.',
    `resolution_description` STRING COMMENT 'Detailed narrative of the actions taken, solution implemented, and outcome achieved to resolve the issue.',
    `root_cause` STRING COMMENT 'Identified underlying cause or origin of the issue, determined through investigation or root cause analysis.',
    `schedule_impact_days` STRING COMMENT 'Estimated or actual impact of the issue on project schedule, measured in calendar days of delay.',
    `severity` STRING COMMENT 'Assessment of the potential impact or consequence of the issue on project objectives: Major (significant cost, schedule, or safety impact), Moderate (measurable but manageable impact), Minor (negligible impact).. Valid values are `Major|Moderate|Minor`',
    `target_resolution_date` DATE COMMENT 'Planned or committed date by which the issue is expected to be resolved.',
    `title` STRING COMMENT 'Short descriptive title or summary of the issue for quick identification in registers and dashboards.',
    `updated_by_user` STRING COMMENT 'Username or identifier of the system user who last updated the issue record.',
    `wbs_element` STRING COMMENT 'The WBS code or element to which this issue is associated, linking the issue to a specific scope area or deliverable within the project.',
    CONSTRAINT pk_issue PRIMARY KEY(`issue_id`)
) COMMENT 'Transactional record of project issues, non-conformances, and action items raised during project execution. Captures issue number, issue type (technical, commercial, HSE, quality, schedule), issue description, date raised, raised by, assigned owner, priority, target resolution date, actual resolution date, resolution description, and issue status (Open, In Progress, Resolved, Closed, Escalated). Supports project governance and lessons-learned capture.';

CREATE OR REPLACE TABLE `mining_ecm`.`project`.`commissioning_activity` (
    `commissioning_activity_id` BIGINT COMMENT 'Unique identifier for the commissioning activity record. Primary key for the commissioning activity entity.',
    `capital_project_id` BIGINT COMMENT 'Reference to the parent capital project under which this commissioning activity is executed.',
    `circuit_id` BIGINT COMMENT 'Foreign key linking to processing.processing_circuit. Business justification: Commissioning activities test specific processing circuits (crushing, flotation, etc.). Tracks which circuit is being commissioned for schedule tracking, performance testing, handover readiness assess',
    `employee_id` BIGINT COMMENT 'Reference to the commissioning engineer or technical lead responsible for planning, executing, and signing off this activity.',
    `predecessor_activity_commissioning_activity_id` BIGINT COMMENT 'Reference to the preceding commissioning activity that must be completed before this activity can commence, establishing logical dependencies in the commissioning sequence.',
    `contractor_id` BIGINT COMMENT 'Reference to the contractor or vendor organization responsible for executing the commissioning activity, if applicable.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Commissioning activities consume specific materials (lubricants, consumables, spares). Business need: material planning for commissioning phase, inventory drawdown tracking, procurement lead time mana',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Commissioning activities for mining infrastructure must comply with tenement-specific regulatory conditions, environmental approvals, heritage clearances, and operational permits. Sign-off requires ve',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Commissioning costs capitalize to WBS elements until handover to operations. Mining projects track pre-production costs via WBS for asset capitalization and depreciation start date determination.',
    `prerequisite_commissioning_activity_id` BIGINT COMMENT 'Self-referencing FK on commissioning_activity (prerequisite_commissioning_activity_id)',
    `acceptance_criteria_met_flag` BOOLEAN COMMENT 'Boolean indicator of whether the commissioning activity met all defined acceptance criteria. True indicates criteria met; False indicates criteria not met.',
    `activity_code` STRING COMMENT 'Unique alphanumeric code identifying the commissioning activity within the project commissioning plan. Used for tracking and reporting.. Valid values are `^[A-Z0-9]{4,20}$`',
    `activity_description` STRING COMMENT 'Detailed description of the commissioning activity scope, objectives, and expected outcomes.',
    `activity_name` STRING COMMENT 'Descriptive name of the commissioning activity, clearly identifying the work to be performed.',
    `activity_status` STRING COMMENT 'Current lifecycle status of the commissioning activity: planned (scheduled but not started), in progress (actively being executed), on hold (temporarily suspended), completed (successfully finished and signed off), or cancelled (no longer required).. Valid values are `planned|in_progress|on_hold|completed|cancelled`',
    `activity_type` STRING COMMENT 'Classification of the commissioning activity phase: mechanical completion check (physical installation verification), pre-commissioning test (static testing without process material), cold commissioning (dynamic testing without ore/product), hot commissioning (testing with actual ore/product), performance test (verification against design criteria), or integrated systems test (multi-system coordination testing).. Valid values are `mechanical_completion_check|pre_commissioning_test|cold_commissioning|hot_commissioning|performance_test|integrated_systems_test`',
    `actual_completion_date` DATE COMMENT 'Actual date when the commissioning activity was completed and signed off. Null if activity is not yet completed.',
    `actual_duration_days` STRING COMMENT 'Actual duration of the commissioning activity in calendar days, calculated from actual start to actual completion. Null if activity is not yet completed.',
    `actual_start_date` DATE COMMENT 'Actual date when the commissioning activity commenced execution. Null if activity has not yet started.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or context related to the commissioning activity execution.',
    `commissioning_system` STRING COMMENT 'The specific system or subsystem being commissioned, such as crushing circuit, conveyor system, flotation bank, SAG mill, tailings pipeline, or electrical distribution system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the commissioning activity record was first created in the system.',
    `critical_punch_list_count` STRING COMMENT 'Number of critical or high-priority punch list items that must be resolved before the system can be handed over to operations.',
    `delay_reason_code` STRING COMMENT 'Standardized code identifying the primary reason for any delay in completing the commissioning activity, such as equipment unavailability, weather, resource constraints, or design changes.',
    `delay_reason_description` STRING COMMENT 'Detailed description of the reason for any delay in completing the commissioning activity.',
    `discipline_code` STRING COMMENT 'Engineering discipline responsible for the commissioning activity: mechanical, electrical, instrumentation and control, process, civil, structural, or piping. [ENUM-REF-CANDIDATE: mechanical|electrical|instrumentation|process|civil|structural|piping — 7 candidates stripped; promote to reference product]',
    `forecast_completion_date` DATE COMMENT 'Current forecast or estimated date for activity completion, updated based on progress and constraints. Used for schedule variance analysis.',
    `handover_readiness_flag` BOOLEAN COMMENT 'Boolean indicator of whether the commissioning activity has been completed to a standard that allows handover to operations. True indicates ready for handover; False indicates not ready.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the commissioning activity record was last modified or updated.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Percentage completion of the commissioning activity, expressed as a value between 0.00 and 100.00. Based on physical progress assessment.',
    `planned_completion_date` DATE COMMENT 'Scheduled date when the commissioning activity is planned to be completed and signed off, as per the commissioning schedule baseline.',
    `planned_duration_days` STRING COMMENT 'Planned duration of the commissioning activity in calendar days, from start to completion.',
    `planned_start_date` DATE COMMENT 'Scheduled date when the commissioning activity is planned to commence, as per the commissioning schedule baseline.',
    `priority` STRING COMMENT 'Priority level assigned to the commissioning activity for resource allocation and scheduling: low, medium, high, or critical.. Valid values are `low|medium|high|critical`',
    `punch_list_item_count` STRING COMMENT 'Number of outstanding punch list items or deficiencies identified during commissioning that require resolution before final handover. Zero indicates no outstanding items.',
    `risk_rating` STRING COMMENT 'Risk assessment rating for the commissioning activity based on safety, technical complexity, and schedule impact: low, medium, high, or critical.. Valid values are `low|medium|high|critical`',
    `safety_permit_number` STRING COMMENT 'Work permit or safety authorization number required for executing the commissioning activity, ensuring compliance with Health, Safety, and Environment (HSE) protocols.',
    `sign_off_authority` STRING COMMENT 'Name or role of the person or authority who provided formal sign-off approval for the commissioning activity.',
    `sign_off_date` DATE COMMENT 'Date when the commissioning activity was formally signed off and accepted by the responsible authority. Null if not yet signed off.',
    `sign_off_status` STRING COMMENT 'Approval status of the commissioning activity: not started (activity not yet ready for review), pending review (awaiting sign-off), approved (accepted and signed off), rejected (failed acceptance criteria), or conditional approval (approved with outstanding punch list items).. Valid values are `not_started|pending_review|approved|rejected|conditional_approval`',
    `system_tag_number` STRING COMMENT 'Engineering tag number or identifier for the system or equipment being commissioned, as per Piping and Instrumentation Diagram (P&ID) or asset register.',
    `test_procedure_reference` STRING COMMENT 'Document reference or identifier for the commissioning test procedure or work instruction that governs this activity.',
    `test_result_summary` STRING COMMENT 'Summary of the commissioning test results, including pass/fail status and key observations.',
    `updated_by_user` STRING COMMENT 'Username or identifier of the user who last updated the commissioning activity record.',
    CONSTRAINT pk_commissioning_activity PRIMARY KEY(`commissioning_activity_id`)
) COMMENT 'Transactional record of individual commissioning and pre-commissioning activities executed during the commissioning phase of a capital project. Captures activity name, commissioning system (e.g., crushing circuit, conveyor system, flotation bank), activity type (mechanical completion check, pre-commissioning test, cold commissioning, hot commissioning, performance test), planned date, actual completion date, responsible engineer, sign-off status, and punch list item count. Tracks readiness for handover.';

CREATE OR REPLACE TABLE `mining_ecm`.`project`.`punch_list_item` (
    `punch_list_item_id` BIGINT COMMENT 'Unique identifier for the punch list item. Primary key.',
    `capital_project_id` BIGINT COMMENT 'Reference to the capital project to which this punch list item belongs.',
    `commissioning_activity_id` BIGINT COMMENT 'Foreign key linking to project.commissioning_activity. Business justification: Punch list items are identified during commissioning activities (pre-commissioning checks, system testing, walkdowns). Currently punch_list_item links to capital_project but not to the specific commis',
    `handover_certificate_id` BIGINT COMMENT 'Foreign key linking to project.handover_certificate. Business justification: Punch list items must be closed before handover certificates are issued. Linking punch items to the handover certificate they are blocking enables handover readiness tracking, outstanding deficiency r',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Punch list remediation requires specific materials for defect rectification. Business process: material requisitioning for punch list closure, inventory allocation, procurement urgency flagging.',
    `originated_from_punch_list_item_id` BIGINT COMMENT 'Self-referencing FK on punch_list_item (originated_from_punch_list_item_id)',
    `actual_completion_date` DATE COMMENT 'Date when the responsible contractor completed the work for the punch list item.',
    `area_code` STRING COMMENT 'Code identifying the physical area or location within the project where the punch list item is located (e.g., plant section, building, zone).',
    `closed_date` DATE COMMENT 'Date when the punch list item was formally closed in the system after completion and verification.',
    `comments` STRING COMMENT 'Additional notes, comments, or instructions related to the punch list item, including clarifications, updates, or coordination notes.',
    `cost_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual cost associated with completing the punch list item, including labor, materials, and equipment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the punch list item record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost impact amount.. Valid values are `^[A-Z]{3}$`',
    `days_overdue` STRING COMMENT 'Number of days the punch list item is overdue relative to the target completion date. Negative values indicate items completed early.',
    `drawing_reference` STRING COMMENT 'Reference to the engineering drawing, Piping and Instrumentation Diagram (P&ID), or design document related to the punch list item.',
    `environmental_critical_flag` BOOLEAN COMMENT 'Indicates whether the punch list item is related to environmental controls or compliance that must be resolved before start-up.',
    `identified_by` STRING COMMENT 'Name or identifier of the person or team who identified and raised the punch list item during inspection or walkthrough.',
    `identified_date` DATE COMMENT 'Date when the punch list item was identified and recorded during mechanical completion inspection or commissioning walkthrough.',
    `item_description` STRING COMMENT 'Detailed description of the punch list item, including the deficiency, incomplete work, or issue identified during mechanical completion inspection or commissioning walkthrough.',
    `item_status` STRING COMMENT 'Current lifecycle status of the punch list item indicating progress from identification through closure.. Valid values are `open|in_progress|completed|verified|closed|cancelled`',
    `photo_reference` STRING COMMENT 'Reference or file path to photographic evidence documenting the punch list item before and after completion.',
    `priority` STRING COMMENT 'Priority level assigned to the punch list item for scheduling and resource allocation purposes.. Valid values are `critical|high|medium|low`',
    `punch_list_item_category` STRING COMMENT 'Classification of the punch list item by criticality: A = must complete before start-up, B = complete before handover, C = complete within agreed period post-handover.. Valid values are `A|B|C`',
    `punch_list_number` STRING COMMENT 'Business identifier for the punch list item, typically assigned sequentially or by system/area. Used for tracking and communication.. Valid values are `^[A-Z0-9-]+$`',
    `rejection_reason` STRING COMMENT 'Reason provided if the completed work was rejected during verification and the punch list item was reopened.',
    `responsible_contractor` STRING COMMENT 'Name or identifier of the contractor or subcontractor responsible for completing the punch list item.',
    `responsible_discipline` STRING COMMENT 'Engineering or construction discipline responsible for the work (e.g., civil, mechanical, electrical, instrumentation, piping).',
    `safety_critical_flag` BOOLEAN COMMENT 'Indicates whether the punch list item is related to a safety-critical system or component that must be resolved before start-up for safety reasons.',
    `schedule_impact_days` STRING COMMENT 'Number of days the punch list item impacts the project schedule or delays handover if not completed on time.',
    `specification_reference` STRING COMMENT 'Reference to the technical specification or standard that the punch list item must meet.',
    `system_code` STRING COMMENT 'Code identifying the system or functional area where the punch list item was identified (e.g., electrical, mechanical, piping, instrumentation).',
    `target_completion_date` DATE COMMENT 'Planned or contractually required date by which the punch list item must be completed, based on its category and project schedule.',
    `updated_by_user` STRING COMMENT 'Identifier of the user who last updated the punch list item record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the punch list item record was last modified in the system.',
    `verification_date` DATE COMMENT 'Date when the completed punch list item was verified and signed off as meeting requirements.',
    `verification_required_flag` BOOLEAN COMMENT 'Indicates whether formal verification or inspection is required before the punch list item can be closed.',
    `verified_by` STRING COMMENT 'Name or identifier of the person who performed the verification inspection and signed off on the completed work.',
    `work_order_number` STRING COMMENT 'Reference to the work order or work package created to address and complete the punch list item.',
    CONSTRAINT pk_punch_list_item PRIMARY KEY(`punch_list_item_id`)
) COMMENT 'Individual punch list item raised during mechanical completion inspections and commissioning walkthroughs for a capital project. Captures punch list number, system or area, item description, category (A — must complete before start-up, B — complete before handover, C — complete within agreed period), responsible contractor, target completion date, actual completion date, verification sign-off, and item status. Critical for tracking mechanical completion and handover readiness.';

CREATE OR REPLACE TABLE `mining_ecm`.`project`.`handover_certificate` (
    `handover_certificate_id` BIGINT COMMENT 'Unique identifier for the handover certificate record. Primary key for this entity.',
    `capital_project_id` BIGINT COMMENT 'Identifier of the capital project to which this handover certificate belongs. Links the certificate to the parent project entity.',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to project.milestone. Business justification: Handover certificates are often contractual milestones (mechanical completion, substantial completion, final acceptance). Currently handover_certificate has contract_milestone_reference as STRING whic',
    `plant_id` BIGINT COMMENT 'Foreign key linking to processing.processing_plant. Business justification: Handover certificates transfer processing plants from project to operations. Tracks which plant was handed over for operational readiness gate, asset register transfer, warranty period start, and perf',
    `employee_id` BIGINT COMMENT 'Unique identifier of the operations manager who accepted the handover. Links to the employee or workforce master data.',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Handover of mining assets to operations requires verification of compliance with tenement-specific regulatory conditions, environmental approvals, safety certifications, and operational permits. Opera',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Handover triggers WBS capitalization close-out and asset transfer to fixed asset register. Mining projects use handover certificates to stop cost capitalization and start depreciation.',
    `superseded_handover_certificate_id` BIGINT COMMENT 'Self-referencing FK on handover_certificate (superseded_handover_certificate_id)',
    `area_location` STRING COMMENT 'Physical location or geographic area of the system being handed over within the mine site (e.g., Processing Plant Area, Pit 3 North Wall, ROM Pad 2).',
    `certificate_number` STRING COMMENT 'Unique business identifier for the handover certificate, typically following a project-specific numbering convention (e.g., PRJ-2024-HC-001). Used for external reference and document control.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this handover certificate record was first created in the system. Used for audit trail and data lineage tracking.',
    `critical_punch_items_count` STRING COMMENT 'Number of critical or safety-related punch list items outstanding at handover. Critical items typically require expedited resolution and may impact operational readiness.',
    `design_capacity_achieved_flag` BOOLEAN COMMENT 'Indicates whether the system achieved its design capacity or performance targets during commissioning. True if design capacity was met or exceeded; False otherwise.',
    `documentation_package_complete_flag` BOOLEAN COMMENT 'Indicates whether all required handover documentation has been delivered to operations, including as-built drawings, operating manuals, maintenance procedures, and spare parts lists. True if complete; False if outstanding.',
    `environmental_approval_status` STRING COMMENT 'Status of environmental approvals or permits required for operation of the system. Ensures compliance with Environmental Impact Statement (EIS) requirements and ISO 14001 standards.. Valid values are `Approved|Pending|Conditional|Not Required`',
    `handover_conditions` STRING COMMENT 'Specific conditions, limitations, or constraints attached to the handover. May include restrictions on use, required follow-up actions, or dependencies on other systems.',
    `handover_date` DATE COMMENT 'The official date on which the system or area was formally transferred from the project team to the operations team. This is the principal business event timestamp for the handover transaction.',
    `handover_meeting_date` DATE COMMENT 'Date of the formal handover meeting where the certificate was reviewed and signed by all parties.',
    `handover_notes` STRING COMMENT 'Free-text field for additional comments, observations, or special instructions related to the handover. May include operational constraints, known issues, or recommendations for future improvements.',
    `handover_status` STRING COMMENT 'Current lifecycle status of the handover certificate. Tracks the approval workflow from initial draft through final acceptance or rejection.. Valid values are `Draft|Pending Review|Approved|Rejected|Superseded|Cancelled`',
    `handover_type` STRING COMMENT 'Classification of the handover milestone. Mechanical Completion indicates all equipment installed and tested; Practical Completion indicates the facility is ready for operational use with minor defects; Final Completion indicates all work complete including defects rectification.. Valid values are `Mechanical Completion|Practical Completion|Final Completion|Substantial Completion|Sectional Completion|Provisional Acceptance`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this handover certificate record was last modified. Used for audit trail and change tracking.',
    `operations_acceptance_signoff` STRING COMMENT 'Formal acceptance decision by the operations team. Indicates whether operations has agreed to take ownership of the system or area.. Valid values are `Accepted|Accepted with Conditions|Rejected|Pending`',
    `operations_manager_name` STRING COMMENT 'Full name of the operations manager who signed off on the handover certificate, accepting responsibility for the system or area.',
    `operations_signoff_date` DATE COMMENT 'Date on which the operations manager formally signed the handover certificate.',
    `outstanding_punch_items_count` STRING COMMENT 'Number of open defects, snags, or punch list items remaining at the time of handover. These are typically minor deficiencies that do not prevent operational use but require rectification within an agreed timeframe.',
    `payment_trigger_flag` BOOLEAN COMMENT 'Indicates whether this handover certificate triggers a contractual payment to the contractor or vendor. True if payment is due upon handover; False otherwise.',
    `performance_test_date` DATE COMMENT 'Date on which performance testing or commissioning trials were completed.',
    `performance_test_status` STRING COMMENT 'Status of performance testing or commissioning trials conducted prior to handover. Indicates whether the system met design performance criteria.. Valid values are `Passed|Failed|Waived|Not Required|In Progress`',
    `planned_handover_date` DATE COMMENT 'The originally scheduled date for handover as per the project baseline schedule. Used for variance analysis and schedule performance tracking.',
    `project_manager_name` STRING COMMENT 'Full name of the project manager who signed off on the handover certificate, certifying that the system is ready for operational use.',
    `project_manager_signoff_date` DATE COMMENT 'Date on which the project manager formally signed the handover certificate.',
    `record_active_flag` BOOLEAN COMMENT 'Indicates whether this handover certificate record is currently active. True for active records; False for superseded or cancelled certificates. Used for soft-delete and historical tracking.',
    `safety_certification_status` STRING COMMENT 'Status of safety certification or regulatory approval required before the system can be operated. Ensures compliance with Mine Safety and Health Administration (MSHA) or equivalent regulations.. Valid values are `Certified|Pending|Not Required|Expired`',
    `spare_parts_delivered_flag` BOOLEAN COMMENT 'Indicates whether the required commissioning and initial spare parts inventory has been delivered and transferred to operations. True if delivered; False otherwise.',
    `system_code` STRING COMMENT 'Engineering system or subsystem code being handed over (e.g., ELEC-HV-01 for high voltage electrical system, PROC-CRUSH-01 for crushing plant). Aligns with project Work Breakdown Structure (WBS) and Piping and Instrumentation Diagram (P&ID) tagging conventions.',
    `system_name` STRING COMMENT 'Descriptive name of the system, area, or facility being handed over (e.g., Primary Crushing Plant, Tailings Storage Facility, Mine Dewatering System).',
    `training_completion_status` STRING COMMENT 'Status of operator training and competency assessment for the system being handed over. Ensures operations personnel are qualified to operate the equipment safely and effectively.. Valid values are `Complete|Incomplete|In Progress|Not Required`',
    `updated_by_user` STRING COMMENT 'Username or identifier of the user who last modified this handover certificate record. Used for audit trail and accountability.',
    `warranty_expiry_date` DATE COMMENT 'Date on which the warranty or defects liability period expires. After this date, operations assumes full responsibility for maintenance and repairs.',
    `warranty_period_months` STRING COMMENT 'Duration of the defects liability or warranty period in months, during which the project team or contractor remains responsible for rectifying defects.',
    CONSTRAINT pk_handover_certificate PRIMARY KEY(`handover_certificate_id`)
) COMMENT 'Formal handover certificate record documenting the transfer of a completed project system, area, or the entire project from the project team to the operations team. Captures certificate number, handover type (Mechanical Completion, Practical Completion, Final Completion), system or area handed over, handover date, outstanding punch list items count, operations acceptance sign-off, project manager sign-off, and any conditions or warranties attached to the handover.';

CREATE OR REPLACE TABLE `mining_ecm`.`project`.`team_member` (
    `team_member_id` BIGINT COMMENT 'Unique identifier for the project team member assignment record.',
    `capital_project_id` BIGINT COMMENT 'Reference to the capital project to which this team member is assigned.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Team members charge labor time to cost centres for payroll allocation and project cost recovery. Mining projects track labor costs via cost centre assignments for AISC and unit cost reporting.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or contractor personnel record assigned to the project team.',
    `tertiary_team_functional_manager_employee_id` BIGINT COMMENT 'Reference to the employee who serves as the functional or home department manager for this team member, maintaining the matrix management relationship outside the project structure.',
    `reports_to_team_member_id` BIGINT COMMENT 'Self-referencing FK on team_member (reports_to_team_member_id)',
    `actual_end_date` DATE COMMENT 'The actual date the team member assignment concluded, which may differ from the planned assignment end date due to early termination, extension, or project changes.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the team members working time allocated to this project, expressed as a decimal value between 0 and 100. Used for resource loading and capacity planning. A value of 100 indicates full-time dedication to the project.',
    `approval_date` DATE COMMENT 'The date on which the team member assignment was formally approved by the project authority, establishing the official authorization for the assignment.',
    `approval_status` STRING COMMENT 'The approval workflow status for this team member assignment, tracking whether the assignment has been formally approved by the appropriate project authority.. Valid values are `draft|pending|approved|rejected`',
    `approved_by_user` STRING COMMENT 'The user ID or name of the individual who approved this team member assignment, providing audit trail for assignment authorization.',
    `assignment_end_date` DATE COMMENT 'The planned or actual date on which the team member will complete or completed their role on the project. Null for open-ended assignments.',
    `assignment_notes` STRING COMMENT 'Free-text field for capturing additional context, special conditions, or remarks related to this team member assignment that do not fit structured fields.',
    `assignment_number` STRING COMMENT 'Business identifier for the project team assignment, used for tracking and reporting purposes.',
    `assignment_start_date` DATE COMMENT 'The date on which the team member officially commenced their role on the project, marking the beginning of their assignment period.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the team member assignment. Active indicates the member is currently working on the project, inactive indicates temporary suspension, pending indicates assignment approved but not yet started, suspended indicates on hold, completed indicates assignment finished as planned, terminated indicates assignment ended prematurely.. Valid values are `active|inactive|pending|suspended|completed|terminated`',
    `assignment_type` STRING COMMENT 'Classification of the employment arrangement for this project assignment, distinguishing between full-time dedicated resources, part-time shared resources, external contractors, consultants, internal secondments, and temporary assignments.. Valid values are `full_time|part_time|contractor|consultant|secondment|temporary`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this project team member assignment record was first created in the system, supporting audit trail and data lineage.',
    `daily_rate_amount` DECIMAL(18,2) COMMENT 'The daily billing or cost rate for this team member on the project, used for project cost estimation and tracking. Applicable primarily for contractors and consultants.',
    `demobilization_date` DATE COMMENT 'The date on which the team member demobilized from the project site or ceased active project work, marking the physical conclusion of their project involvement.',
    `discipline_code` STRING COMMENT 'The engineering or functional discipline code representing the team members area of expertise, such as civil, mechanical, electrical, process, instrumentation, or project controls.',
    `hourly_rate_amount` DECIMAL(18,2) COMMENT 'The hourly billing or cost rate for this team member on the project, used for detailed time-based cost tracking and invoicing.',
    `induction_completed_flag` BOOLEAN COMMENT 'Boolean indicator of whether the team member has completed the required project site induction and safety training before commencing work.',
    `induction_completion_date` DATE COMMENT 'The date on which the team member completed the mandatory project induction and safety training, establishing compliance with site access requirements.',
    `is_critical_resource` BOOLEAN COMMENT 'Boolean indicator identifying whether this team member is considered a critical resource for project success, used for resource risk management and succession planning.',
    `location_code` STRING COMMENT 'The physical work location or site where the team member is based for this project assignment, supporting workforce planning and site logistics.',
    `mobilization_date` DATE COMMENT 'The date on which the team member physically mobilized to the project site or commenced active project work, distinct from the formal assignment start date.',
    `project_role_code` STRING COMMENT 'Standardized code representing the role performed by the team member on the project. Common roles include Project Director (PROJ_DIR), Project Manager (PROJ_MGR), Construction Manager (CONSTR_MGR), Commissioning Manager (COMM_MGR), Cost Engineer (COST_ENG), Scheduler (SCHEDULER), Health Safety and Environment (HSE) Lead (HSE_LEAD), Design Manager (DESIGN_MGR), Procurement Manager (PROC_MGR), Quality Assurance/Quality Control (QA/QC) Manager (QA_QC_MGR), Site Engineer (SITE_ENG), Planning Engineer (PLAN_ENG), Contracts Administrator (CONTR_ADM), Environmental Coordinator (ENV_COORD), Commissioning Engineer (COMM_ENG). [ENUM-REF-CANDIDATE: PROJ_DIR|PROJ_MGR|CONSTR_MGR|COMM_MGR|COST_ENG|SCHEDULER|HSE_LEAD|DESIGN_MGR|PROC_MGR|QA_QC_MGR|SITE_ENG|PLAN_ENG|CONTR_ADM|ENV_COORD|COMM_ENG — 15 candidates stripped; promote to reference product]',
    `project_role_name` STRING COMMENT 'Full descriptive name of the role performed by the team member on the project, providing human-readable context for the role code.',
    `rate_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the daily or hourly rate amounts, ensuring accurate financial reporting across multi-currency projects.. Valid values are `^[A-Z]{3}$`',
    `record_active_flag` BOOLEAN COMMENT 'Boolean indicator of whether this project team member assignment record is currently active in the system. False indicates a logically deleted or archived record.',
    `security_clearance_level` STRING COMMENT 'The security clearance level held by the team member for this project, relevant for projects with restricted access requirements or sensitive operations.',
    `termination_reason_code` STRING COMMENT 'Standardized code indicating the reason for early termination of the assignment, if applicable. Used for workforce analytics and project risk management.',
    `termination_reason_description` STRING COMMENT 'Detailed narrative explanation of the reason for early termination of the assignment, providing context beyond the standardized termination reason code.',
    `updated_by_user` STRING COMMENT 'The user ID or name of the individual who last modified this project team member assignment record, providing accountability for data changes.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this project team member assignment record was last modified, enabling change tracking and audit compliance.',
    `wbs_element` STRING COMMENT 'The specific Work Breakdown Structure element or work package to which this team member is assigned, enabling detailed project cost and schedule tracking at the WBS level.',
    CONSTRAINT pk_team_member PRIMARY KEY(`team_member_id`)
) COMMENT 'Association record defining the project team structure for a capital project, linking workforce personnel to their project roles. Captures employee or contractor reference, project role (Project Director, Project Manager, Construction Manager, Commissioning Manager, Cost Engineer, Scheduler, HSE Lead), assignment start date, assignment end date, allocation percentage, reporting line within the project, and assignment status. Enables project org chart and resource loading views.';

CREATE OR REPLACE TABLE `mining_ecm`.`project`.`lessons_learned` (
    `lessons_learned_id` BIGINT COMMENT 'Unique identifier for the lessons learned record. Primary key for the lessons learned entity.',
    `capital_project_id` BIGINT COMMENT 'Reference to the capital project from which this lesson was captured. Links to the parent project entity.',
    `change_order_id` BIGINT COMMENT 'Foreign key linking to project.change_order. Business justification: Lessons learned are captured from change orders (why scope changed, what could have been prevented, how to improve change control). This links lessons to the change events that triggered them for chan',
    `issue_id` BIGINT COMMENT 'Foreign key linking to project.issue. Business justification: Lessons learned are often captured from project issues (what went wrong, root cause, what was learned, how to prevent). Currently lessons_learned links to capital_project and prospect but not to speci',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Lessons learned are captured during specific project phases. Currently has applicable_project_phase as STRING which should be normalized to FK. This enables phase-specific knowledge management and les',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Lessons learned from exploration programs at specific prospects inform future project execution. Drilling results, geological surprises, resource model accuracy, and metallurgical variability are capt',
    `related_lessons_learned_id` BIGINT COMMENT 'Self-referencing FK on lessons_learned (related_lessons_learned_id)',
    `applicable_commodity` STRING COMMENT 'Mining commodity or mineral type for which this lesson is most relevant (e.g., iron ore, copper, coal, lithium, nickel). Enables filtering lessons by commodity context.',
    `applicable_project_type` STRING COMMENT 'Type of capital project for which this lesson is most relevant (e.g., greenfield mine development, brownfield expansion, processing plant upgrade, infrastructure, mine closure).',
    `approval_date` DATE COMMENT 'Date when this lesson learned was formally approved for inclusion in the corporate knowledge base.',
    `approved_by` STRING COMMENT 'Name of the individual or role who approved this lessons learned record for publication.',
    `author_name` STRING COMMENT 'Name of the individual who authored or submitted this lessons learned record.',
    `author_organization` STRING COMMENT 'Organization or company the author represents (e.g., owner, contractor, consultant, vendor).',
    `author_role` STRING COMMENT 'Job title or functional role of the lesson author at the time of capture (e.g., Project Manager, Construction Manager, HSE Advisor).',
    `capture_date` DATE COMMENT 'Date when this lesson learned was formally captured and documented. Represents the business event timestamp for knowledge capture.',
    `confidentiality_level` STRING COMMENT 'Data classification level governing access and sharing restrictions for this lesson. Determines whether the lesson can be shared externally or is restricted to internal use only.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this lessons learned record was first created in the database. Audit trail for record creation.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Quantified financial impact of the issue or opportunity captured in this lesson, expressed in the project currency. Positive values indicate cost savings or value gains; negative values indicate cost overruns or losses.',
    `financial_impact_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `impact_area` STRING COMMENT 'Business area or project dimension most affected by this lesson (e.g., cost, schedule, safety, quality, stakeholder relations, environmental compliance).',
    `implementation_date` DATE COMMENT 'Date when the recommendation was formally implemented into organizational standards or procedures.',
    `implementation_status` STRING COMMENT 'Status tracking whether the recommendation from this lesson has been incorporated into organizational processes, standards, or future project plans.. Valid values are `not_started|planned|in_progress|implemented|not_applicable`',
    `is_active` BOOLEAN COMMENT 'Flag indicating whether this lessons learned record is currently active and available in the knowledge base. Inactive records may be archived or superseded.',
    `keywords` STRING COMMENT 'Comma-separated list of searchable keywords or tags to facilitate discovery and retrieval of this lesson from the knowledge base.',
    `last_modified_by` STRING COMMENT 'User identifier or name of the individual who last modified this lessons learned record. Audit trail for accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this lessons learned record was last updated. Audit trail for record modification.',
    `lesson_category` STRING COMMENT 'Primary classification of the lesson learned by project discipline or knowledge area. Enables filtering and analysis by functional domain. [ENUM-REF-CANDIDATE: engineering|procurement|construction|commissioning|hse|cost_control|schedule_management|stakeholder_management|quality_management|risk_management — 10 candidates stripped; promote to reference product]',
    `lesson_description` STRING COMMENT 'Detailed narrative describing the situation, context, and lesson learned. Captures what happened, what was learned, and why it matters for future projects.',
    `lesson_number` STRING COMMENT 'Business identifier for the lesson learned record, typically following organizational numbering convention (e.g., LL-2024-001).',
    `lesson_subcategory` STRING COMMENT 'Secondary classification providing more granular categorization within the primary lesson category (e.g., under Engineering: design, specifications, technical standards).',
    `lesson_title` STRING COMMENT 'Concise title summarizing the key lesson learned or knowledge transfer point.',
    `lesson_type` STRING COMMENT 'Classification of whether the lesson represents a success to be repeated, a problem to be avoided, or a general observation for awareness.. Valid values are `positive|negative|observation|best_practice|risk_mitigation`',
    `occurrence_date` DATE COMMENT 'Date when the event or situation that generated this lesson actually occurred on the project.',
    `recommendation` STRING COMMENT 'Actionable recommendation or best practice guidance for future projects based on this lesson. Describes what should be done differently or repeated.',
    `related_document_reference` STRING COMMENT 'Reference identifier or hyperlink to supporting documentation, reports, photos, or evidence related to this lesson (e.g., incident reports, design drawings, meeting minutes).',
    `review_status` STRING COMMENT 'Current workflow status of the lessons learned record in the review and approval process.. Valid values are `draft|submitted|under_review|approved|rejected|archived`',
    `root_cause` STRING COMMENT 'Analysis of the underlying root cause or contributing factors that led to the issue or success. Supports deeper understanding beyond symptoms.',
    `schedule_impact_days` STRING COMMENT 'Quantified schedule impact in calendar days. Positive values indicate delays; negative values indicate schedule acceleration or time savings.',
    `severity_rating` STRING COMMENT 'Assessment of the impact severity or importance of this lesson for future project delivery. Critical lessons require mandatory consideration in future projects.. Valid values are `critical|high|medium|low`',
    CONSTRAINT pk_lessons_learned PRIMARY KEY(`lessons_learned_id`)
) COMMENT 'Captures lessons learned and knowledge transfer records from completed or in-progress capital projects. Records lesson category (engineering, procurement, construction, commissioning, HSE, cost control, schedule management), lesson description, root cause, recommendation, applicable project phase, project reference, author, capture date, and implementation status. Feeds the corporate project management knowledge base and improves future project delivery.';

CREATE OR REPLACE TABLE `mining_ecm`.`project`.`document` (
    `document_id` BIGINT COMMENT 'Unique identifier for the project document record. Primary key for the project document master register.',
    `capital_project_id` BIGINT COMMENT 'Reference to the capital project to which this document belongs. Links document to the parent project for lifecycle tracking and portfolio management.',
    `feasibility_study_id` BIGINT COMMENT 'Foreign key linking to project.feasibility_study. Business justification: Documents are produced as part of feasibility studies (study reports, technical appendices, resource models, financial models). Currently document links to capital_project but not to the specific stud',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Project documents are produced during specific phases (feasibility docs, FEED drawings, execution specs, commissioning records). Currently document links to capital_project but not to phase. This enab',
    `primary_superseded_by_document_id` BIGINT COMMENT 'Reference to the newer document that replaces this document. Maintains document lineage and ensures users access the current revision.',
    `superseded_document_id` BIGINT COMMENT 'Self-referencing FK on document (superseded_document_id)',
    `approval_date` DATE COMMENT 'Date when the document received final approval. Marks the transition to authorized-for-use status.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether formal approval is required before the document can be issued for construction or operational use. Determines workflow routing.',
    `approved_by` STRING COMMENT 'Name of the individual who provided final approval for the document. Establishes accountability for document quality and suitability for use.',
    `author_name` STRING COMMENT 'Name of the individual or organization who prepared or authored the document. May be internal staff or external consultant/contractor.',
    `author_organization` STRING COMMENT 'Company or organizational entity responsible for document preparation. Distinguishes between owner-prepared documents and contractor/consultant deliverables.',
    `confidentiality_level` STRING COMMENT 'Data classification level governing access control and distribution restrictions for the document. Aligns with organizational information security policies.. Valid values are `public|internal|confidential|restricted`',
    `contract_deliverable_flag` BOOLEAN COMMENT 'Indicates whether this document is a contractually required deliverable. Used to track compliance with contract obligations and milestone payment triggers.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the document record was first created in the project document register. Supports audit trail and data lineage tracking.',
    `discipline_code` STRING COMMENT 'Engineering or technical discipline responsible for the document. Used for routing documents to appropriate review teams and organizing document repositories by discipline. [ENUM-REF-CANDIDATE: civil|structural|mechanical|electrical|instrumentation|process|piping|architectural|geotechnical|environmental — 10 candidates stripped; promote to reference product]',
    `dms_platform` STRING COMMENT 'Name of the document management system platform where the document is stored. Supports multi-platform document ecosystems in large capital projects.. Valid values are `aconex|procore|sharepoint|documentum|projectwise|other`',
    `dms_reference` STRING COMMENT 'Unique identifier or hyperlink reference to the document in the project document management system such as Aconex, Procore, or SharePoint. Enables direct retrieval of the physical document file.',
    `document_description` STRING COMMENT 'Extended narrative description of the document content, scope, and purpose. Provides additional context beyond the document title for search and retrieval.',
    `document_number` STRING COMMENT 'Unique business identifier for the controlled document. Typically follows organizational document numbering standards and may include project code, discipline code, document type code, and sequential number.',
    `document_status` STRING COMMENT 'Current status of the document in its approval and issuance lifecycle. Controls document usage authorization and indicates whether the document is suitable for construction or operational use. [ENUM-REF-CANDIDATE: draft|issued_for_review|issued_for_approval|issued_for_construction|as_built|superseded|cancelled — 7 candidates stripped; promote to reference product]',
    `document_type` STRING COMMENT 'Classification of the document by its functional type. Determines document handling, review requirements, and retention policies. [ENUM-REF-CANDIDATE: drawing|specification|procedure|report|calculation|vendor_document|manual|schedule|plan|register — 10 candidates stripped; promote to reference product]',
    `drawing_scale` STRING COMMENT 'Scale ratio of the engineering drawing such as 1:100, 1:50, or NTS (Not To Scale). Critical for accurate interpretation of dimensions and spatial relationships.',
    `drawing_size` STRING COMMENT 'Standard sheet size for engineering drawings. Determines plotting and printing requirements. Applicable only to drawing document types. [ENUM-REF-CANDIDATE: A0|A1|A2|A3|A4|ANSI_A|ANSI_B|ANSI_C|ANSI_D|ANSI_E — 10 candidates stripped; promote to reference product]',
    `equipment_tag_number` STRING COMMENT 'Unique equipment tag number to which this document relates. Links document to specific equipment items for maintenance and operational reference.',
    `file_format` STRING COMMENT 'Digital file format of the document. Determines software requirements for viewing and editing, and influences long-term archival strategies. [ENUM-REF-CANDIDATE: pdf|dwg|xlsx|docx|mpp|xml|other — 7 candidates stripped; promote to reference product]',
    `file_size_mb` DECIMAL(18,2) COMMENT 'Size of the document file in megabytes. Used for storage capacity planning and download time estimation.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or tags for document search and retrieval. Enhances discoverability in document management systems.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the document. Captures context not covered by structured fields.',
    `page_count` STRING COMMENT 'Total number of pages in the document. Relevant for printing cost estimation and document complexity assessment.',
    `related_wbs_code` STRING COMMENT 'Work Breakdown Structure code to which this document is associated. Links document to specific project scope elements for cost and schedule integration.',
    `retention_period_years` STRING COMMENT 'Number of years the document must be retained per regulatory, legal, or organizational policy requirements. Drives archival and disposal schedules.',
    `review_date` DATE COMMENT 'Date when the document review was completed. Tracks review cycle duration and compliance with project schedule milestones.',
    `reviewed_by` STRING COMMENT 'Name of the individual or role who performed technical or quality review of the document prior to approval. May include multiple reviewers in practice.',
    `revision_date` DATE COMMENT 'Date when the current revision of the document was issued or approved. Critical for determining the applicable version for construction or operational activities.',
    `revision_number` STRING COMMENT 'Version identifier for the document revision. Tracks document evolution through design iterations and change management cycles. May use alphanumeric schemes such as A, B, C for pre-construction and 0, 1, 2 for post-construction revisions.',
    `title` STRING COMMENT 'Full descriptive title of the project document or deliverable. Provides human-readable identification of the document content and purpose.',
    `transmittal_number` STRING COMMENT 'Reference number of the formal transmittal or submittal package through which the document was issued. Links document to its distribution record.',
    `updated_by_user` STRING COMMENT 'Username or identifier of the user who last updated the document record. Establishes accountability for metadata changes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the document record was last modified. Tracks currency of metadata and supports change detection.',
    `vendor_name` STRING COMMENT 'Name of the equipment vendor or supplier who provided the document. Applicable to vendor documents such as operation and maintenance manuals, data sheets, and certificates.',
    CONSTRAINT pk_document PRIMARY KEY(`document_id`)
) COMMENT 'Master register of controlled project documents and deliverables for capital projects, serving as the project document management index. Captures document number, document title, document type (drawing, specification, procedure, report, calculation, vendor document), revision number, revision date, document status (Issued for Review, Issued for Construction, As-Built, Superseded), discipline (civil, structural, mechanical, electrical, instrumentation, process), author, and document management system reference (Aconex, Procore).';

CREATE OR REPLACE TABLE `mining_ecm`.`project`.`calendar` (
    `calendar_id` BIGINT COMMENT 'Primary key for calendar',
    `base_calendar_id` BIGINT COMMENT 'Self-referencing FK on calendar (base_calendar_id)',
    `calendar_date` DATE COMMENT 'The actual calendar date in yyyy-MM-dd format. Business key for date-based lookups and joins across all transactional and operational data.',
    `calendar_type` STRING COMMENT 'Type of calendar this date belongs to (e.g., Gregorian, fiscal, mining operational, project-specific). Allows for multiple calendar views to support different business processes.',
    `day_of_month` STRING COMMENT 'Day number within the month (1-31). Used for monthly reporting cycles, payroll processing, and contract milestone tracking.',
    `day_of_quarter` STRING COMMENT 'Day number within the fiscal or calendar quarter (1-92). Supports quarterly project tracking and financial reporting.',
    `day_of_week` STRING COMMENT 'Full name of the day of the week. Used for operational scheduling, shift planning, and workforce rostering in mining operations.',
    `day_of_week_number` STRING COMMENT 'Numeric representation of the day of week where 1=Monday through 7=Sunday. Supports sorting and analytics on weekly patterns.',
    `day_of_year` STRING COMMENT 'Day number within the calendar year (1-366). Used for annual production planning, maintenance schedules, and environmental compliance reporting.',
    `days_in_month` STRING COMMENT 'Total number of days in the month (28-31). Used for pro-rata calculations, monthly target normalization, and capacity planning.',
    `calendar_description` STRING COMMENT 'Optional descriptive text for special dates, events, or milestones (e.g., major project milestones, regulatory reporting deadlines, planned shutdowns).',
    `fiscal_period` STRING COMMENT 'Fiscal period number within the fiscal year (1-12 or 1-13 for organizations using 13-period calendars). Used for management accounting and internal reporting.',
    `fiscal_year` STRING COMMENT 'Four-digit fiscal year. May differ from calendar year depending on the organizations fiscal year-end. Used for financial reporting and budgeting.',
    `is_business_day` BOOLEAN COMMENT 'Boolean flag indicating whether the date is a business operating day (excludes weekends and public holidays). Used for SLA calculations, project scheduling, and financial settlement dates.',
    `is_month_end` BOOLEAN COMMENT 'Boolean flag indicating whether the date is the last day of the month. Critical for financial close processes, accruals, and period-end reporting.',
    `is_month_start` BOOLEAN COMMENT 'Boolean flag indicating whether the date is the first day of the month. Used for monthly reporting triggers and period-end processing.',
    `is_public_holiday` BOOLEAN COMMENT 'Boolean flag indicating whether the date is a recognized public holiday. Critical for workforce planning, shift scheduling, and labor cost calculations.',
    `is_quarter_end` BOOLEAN COMMENT 'Boolean flag indicating whether the date is the last day of the fiscal or calendar quarter. Critical for quarterly financial close and regulatory reporting.',
    `is_quarter_start` BOOLEAN COMMENT 'Boolean flag indicating whether the date is the first day of the fiscal or calendar quarter. Used for quarterly planning and reporting cycles.',
    `is_weekday` BOOLEAN COMMENT 'Boolean flag indicating whether the date is a weekday (Monday through Friday). Used for business day calculations and operational planning.',
    `is_weekend` BOOLEAN COMMENT 'Boolean flag indicating whether the date falls on a weekend (Saturday or Sunday). Used for workforce planning and operational scheduling.',
    `is_year_end` BOOLEAN COMMENT 'Boolean flag indicating whether the date is the last day of the calendar or fiscal year. Critical for annual financial close, tax reporting, and year-end audits.',
    `is_year_start` BOOLEAN COMMENT 'Boolean flag indicating whether the date is the first day of the calendar or fiscal year. Used for annual planning and budget initialization.',
    `month_abbreviation` STRING COMMENT 'Three-letter abbreviation of the month name. Used for compact reporting displays and chart labels. [ENUM-REF-CANDIDATE: Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec — promote to reference product]',
    `month_name` STRING COMMENT 'Full name of the month. Used for human-readable reporting and executive dashboards. [ENUM-REF-CANDIDATE: January|February|March|April|May|June|July|August|September|October|November|December — promote to reference product]',
    `month_number` STRING COMMENT 'Numeric month within the year (1-12). Used for monthly financial close, production reporting, and regulatory submissions.',
    `public_holiday_name` STRING COMMENT 'Name of the public holiday if applicable. Null for non-holiday dates. Used for reporting and workforce management.',
    `quarter_name` STRING COMMENT 'Quarter designation (Q1, Q2, Q3, Q4). Used for executive reporting and strategic planning cycles.',
    `quarter_number` STRING COMMENT 'Fiscal or calendar quarter number (1-4). Critical for quarterly financial reporting, board presentations, and investor relations.',
    `region` STRING COMMENT 'Geographic region or jurisdiction for which this calendar date applies. Supports multi-region operations with different holiday calendars and fiscal periods.',
    `season` STRING COMMENT 'Meteorological season classification. Used for seasonal production planning, weather-dependent operations, and environmental monitoring in mining operations.',
    `week_of_month` STRING COMMENT 'Week number within the month (1-5). Supports weekly operational reporting and short-term production tracking.',
    `week_of_year` STRING COMMENT 'ISO week number within the year (1-53). Critical for weekly production reporting, shipment scheduling, and operational KPI tracking.',
    `working_days_in_month` STRING COMMENT 'Total number of business working days in the month (excludes weekends and public holidays). Critical for workforce capacity planning and productivity calculations.',
    `year` STRING COMMENT 'Four-digit calendar year. Foundation for annual reporting, long-term planning, and multi-year project tracking.',
    `year_month` STRING COMMENT 'Year and month in YYYY-MM format. Commonly used for month-level aggregations, time-series analysis, and reporting hierarchies.',
    `year_quarter` STRING COMMENT 'Year and quarter in YYYY-QN format (e.g., 2024-Q1). Used for quarterly trend analysis and executive reporting.',
    `year_week` STRING COMMENT 'ISO year and week number in YYYY-WNN format. Used for weekly production tracking and operational reporting.',
    CONSTRAINT pk_calendar PRIMARY KEY(`calendar_id`)
) COMMENT 'Master reference table for calendar. Referenced by calendar_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `mining_ecm`.`project`.`capital_project` ADD CONSTRAINT `fk_project_capital_project_parent_capital_project_id` FOREIGN KEY (`parent_capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ADD CONSTRAINT `fk_project_stage_gate_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ADD CONSTRAINT `fk_project_stage_gate_primary_next_gate_stage_gate_id` FOREIGN KEY (`primary_next_gate_stage_gate_id`) REFERENCES `mining_ecm`.`project`.`stage_gate`(`stage_gate_id`);
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ADD CONSTRAINT `fk_project_stage_gate_preceding_stage_gate_id` FOREIGN KEY (`preceding_stage_gate_id`) REFERENCES `mining_ecm`.`project`.`stage_gate`(`stage_gate_id`);
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ADD CONSTRAINT `fk_project_gate_decision_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ADD CONSTRAINT `fk_project_gate_decision_cost_estimate_id` FOREIGN KEY (`cost_estimate_id`) REFERENCES `mining_ecm`.`project`.`cost_estimate`(`cost_estimate_id`);
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ADD CONSTRAINT `fk_project_gate_decision_feasibility_study_id` FOREIGN KEY (`feasibility_study_id`) REFERENCES `mining_ecm`.`project`.`feasibility_study`(`feasibility_study_id`);
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ADD CONSTRAINT `fk_project_gate_decision_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `mining_ecm`.`project`.`project_budget`(`project_budget_id`);
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ADD CONSTRAINT `fk_project_gate_decision_stage_gate_id` FOREIGN KEY (`stage_gate_id`) REFERENCES `mining_ecm`.`project`.`stage_gate`(`stage_gate_id`);
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ADD CONSTRAINT `fk_project_gate_decision_deferred_gate_decision_id` FOREIGN KEY (`deferred_gate_decision_id`) REFERENCES `mining_ecm`.`project`.`gate_decision`(`gate_decision_id`);
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ADD CONSTRAINT `fk_project_feasibility_study_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ADD CONSTRAINT `fk_project_feasibility_study_superseded_feasibility_study_id` FOREIGN KEY (`superseded_feasibility_study_id`) REFERENCES `mining_ecm`.`project`.`feasibility_study`(`feasibility_study_id`);
ALTER TABLE `mining_ecm`.`project`.`phase` ADD CONSTRAINT `fk_project_phase_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`project`.`phase` ADD CONSTRAINT `fk_project_phase_predecessor_phase_id` FOREIGN KEY (`predecessor_phase_id`) REFERENCES `mining_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `mining_ecm`.`project`.`schedule` ADD CONSTRAINT `fk_project_schedule_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`project`.`schedule` ADD CONSTRAINT `fk_project_schedule_superseded_schedule_id` FOREIGN KEY (`superseded_schedule_id`) REFERENCES `mining_ecm`.`project`.`schedule`(`schedule_id`);
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ADD CONSTRAINT `fk_project_schedule_activity_calendar_id` FOREIGN KEY (`calendar_id`) REFERENCES `mining_ecm`.`project`.`calendar`(`calendar_id`);
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ADD CONSTRAINT `fk_project_schedule_activity_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ADD CONSTRAINT `fk_project_schedule_activity_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `mining_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ADD CONSTRAINT `fk_project_schedule_activity_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `mining_ecm`.`project`.`schedule`(`schedule_id`);
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ADD CONSTRAINT `fk_project_schedule_activity_predecessor_schedule_activity_id` FOREIGN KEY (`predecessor_schedule_activity_id`) REFERENCES `mining_ecm`.`project`.`schedule_activity`(`schedule_activity_id`);
ALTER TABLE `mining_ecm`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `mining_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `mining_ecm`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_predecessor_milestone_id` FOREIGN KEY (`predecessor_milestone_id`) REFERENCES `mining_ecm`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ADD CONSTRAINT `fk_project_cost_estimate_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ADD CONSTRAINT `fk_project_cost_estimate_feasibility_study_id` FOREIGN KEY (`feasibility_study_id`) REFERENCES `mining_ecm`.`project`.`feasibility_study`(`feasibility_study_id`);
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ADD CONSTRAINT `fk_project_cost_estimate_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `mining_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ADD CONSTRAINT `fk_project_cost_estimate_superseded_by_estimate_cost_estimate_id` FOREIGN KEY (`superseded_by_estimate_cost_estimate_id`) REFERENCES `mining_ecm`.`project`.`cost_estimate`(`cost_estimate_id`);
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ADD CONSTRAINT `fk_project_cost_estimate_superseded_cost_estimate_id` FOREIGN KEY (`superseded_cost_estimate_id`) REFERENCES `mining_ecm`.`project`.`cost_estimate`(`cost_estimate_id`);
ALTER TABLE `mining_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_cost_estimate_id` FOREIGN KEY (`cost_estimate_id`) REFERENCES `mining_ecm`.`project`.`cost_estimate`(`cost_estimate_id`);
ALTER TABLE `mining_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_superseded_project_budget_id` FOREIGN KEY (`superseded_project_budget_id`) REFERENCES `mining_ecm`.`project`.`project_budget`(`project_budget_id`);
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ADD CONSTRAINT `fk_project_budget_amendment_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ADD CONSTRAINT `fk_project_budget_amendment_cost_estimate_id` FOREIGN KEY (`cost_estimate_id`) REFERENCES `mining_ecm`.`project`.`cost_estimate`(`cost_estimate_id`);
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ADD CONSTRAINT `fk_project_budget_amendment_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `mining_ecm`.`project`.`project_budget`(`project_budget_id`);
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ADD CONSTRAINT `fk_project_budget_amendment_superseded_budget_amendment_id` FOREIGN KEY (`superseded_budget_amendment_id`) REFERENCES `mining_ecm`.`project`.`budget_amendment`(`budget_amendment_id`);
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ADD CONSTRAINT `fk_project_cost_commitment_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ADD CONSTRAINT `fk_project_cost_commitment_change_order_id` FOREIGN KEY (`change_order_id`) REFERENCES `mining_ecm`.`project`.`change_order`(`change_order_id`);
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ADD CONSTRAINT `fk_project_cost_commitment_original_commitment_cost_commitment_id` FOREIGN KEY (`original_commitment_cost_commitment_id`) REFERENCES `mining_ecm`.`project`.`cost_commitment`(`cost_commitment_id`);
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ADD CONSTRAINT `fk_project_cost_commitment_project_contract_id` FOREIGN KEY (`project_contract_id`) REFERENCES `mining_ecm`.`project`.`project_contract`(`project_contract_id`);
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ADD CONSTRAINT `fk_project_cost_commitment_revised_cost_commitment_id` FOREIGN KEY (`revised_cost_commitment_id`) REFERENCES `mining_ecm`.`project`.`cost_commitment`(`cost_commitment_id`);
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ADD CONSTRAINT `fk_project_expenditure_actual_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ADD CONSTRAINT `fk_project_expenditure_actual_cost_commitment_id` FOREIGN KEY (`cost_commitment_id`) REFERENCES `mining_ecm`.`project`.`cost_commitment`(`cost_commitment_id`);
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ADD CONSTRAINT `fk_project_expenditure_actual_reversal_expenditure_actual_id` FOREIGN KEY (`reversal_expenditure_actual_id`) REFERENCES `mining_ecm`.`project`.`expenditure_actual`(`expenditure_actual_id`);
ALTER TABLE `mining_ecm`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_project_contract_id` FOREIGN KEY (`project_contract_id`) REFERENCES `mining_ecm`.`project`.`project_contract`(`project_contract_id`);
ALTER TABLE `mining_ecm`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_superseded_change_order_id` FOREIGN KEY (`superseded_change_order_id`) REFERENCES `mining_ecm`.`project`.`change_order`(`change_order_id`);
ALTER TABLE `mining_ecm`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_stage_gate_id` FOREIGN KEY (`stage_gate_id`) REFERENCES `mining_ecm`.`project`.`stage_gate`(`stage_gate_id`);
ALTER TABLE `mining_ecm`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_superseded_risk_register_id` FOREIGN KEY (`superseded_risk_register_id`) REFERENCES `mining_ecm`.`project`.`risk_register`(`risk_register_id`);
ALTER TABLE `mining_ecm`.`project`.`risk_item` ADD CONSTRAINT `fk_project_risk_item_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`project`.`risk_item` ADD CONSTRAINT `fk_project_risk_item_risk_register_id` FOREIGN KEY (`risk_register_id`) REFERENCES `mining_ecm`.`project`.`risk_register`(`risk_register_id`);
ALTER TABLE `mining_ecm`.`project`.`risk_item` ADD CONSTRAINT `fk_project_risk_item_parent_risk_item_id` FOREIGN KEY (`parent_risk_item_id`) REFERENCES `mining_ecm`.`project`.`risk_item`(`risk_item_id`);
ALTER TABLE `mining_ecm`.`project`.`project_contract` ADD CONSTRAINT `fk_project_project_contract_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`project`.`project_contract` ADD CONSTRAINT `fk_project_project_contract_parent_project_contract_id` FOREIGN KEY (`parent_project_contract_id`) REFERENCES `mining_ecm`.`project`.`project_contract`(`project_contract_id`);
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ADD CONSTRAINT `fk_project_progress_claim_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ADD CONSTRAINT `fk_project_progress_claim_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `mining_ecm`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ADD CONSTRAINT `fk_project_progress_claim_project_contract_id` FOREIGN KEY (`project_contract_id`) REFERENCES `mining_ecm`.`project`.`project_contract`(`project_contract_id`);
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ADD CONSTRAINT `fk_project_progress_claim_revised_progress_claim_id` FOREIGN KEY (`revised_progress_claim_id`) REFERENCES `mining_ecm`.`project`.`progress_claim`(`progress_claim_id`);
ALTER TABLE `mining_ecm`.`project`.`issue` ADD CONSTRAINT `fk_project_issue_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`project`.`issue` ADD CONSTRAINT `fk_project_issue_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `mining_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `mining_ecm`.`project`.`issue` ADD CONSTRAINT `fk_project_issue_project_contract_id` FOREIGN KEY (`project_contract_id`) REFERENCES `mining_ecm`.`project`.`project_contract`(`project_contract_id`);
ALTER TABLE `mining_ecm`.`project`.`issue` ADD CONSTRAINT `fk_project_issue_risk_item_id` FOREIGN KEY (`risk_item_id`) REFERENCES `mining_ecm`.`project`.`risk_item`(`risk_item_id`);
ALTER TABLE `mining_ecm`.`project`.`issue` ADD CONSTRAINT `fk_project_issue_parent_issue_id` FOREIGN KEY (`parent_issue_id`) REFERENCES `mining_ecm`.`project`.`issue`(`issue_id`);
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_predecessor_activity_commissioning_activity_id` FOREIGN KEY (`predecessor_activity_commissioning_activity_id`) REFERENCES `mining_ecm`.`project`.`commissioning_activity`(`commissioning_activity_id`);
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_prerequisite_commissioning_activity_id` FOREIGN KEY (`prerequisite_commissioning_activity_id`) REFERENCES `mining_ecm`.`project`.`commissioning_activity`(`commissioning_activity_id`);
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ADD CONSTRAINT `fk_project_punch_list_item_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ADD CONSTRAINT `fk_project_punch_list_item_commissioning_activity_id` FOREIGN KEY (`commissioning_activity_id`) REFERENCES `mining_ecm`.`project`.`commissioning_activity`(`commissioning_activity_id`);
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ADD CONSTRAINT `fk_project_punch_list_item_handover_certificate_id` FOREIGN KEY (`handover_certificate_id`) REFERENCES `mining_ecm`.`project`.`handover_certificate`(`handover_certificate_id`);
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ADD CONSTRAINT `fk_project_punch_list_item_originated_from_punch_list_item_id` FOREIGN KEY (`originated_from_punch_list_item_id`) REFERENCES `mining_ecm`.`project`.`punch_list_item`(`punch_list_item_id`);
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ADD CONSTRAINT `fk_project_handover_certificate_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ADD CONSTRAINT `fk_project_handover_certificate_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `mining_ecm`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ADD CONSTRAINT `fk_project_handover_certificate_superseded_handover_certificate_id` FOREIGN KEY (`superseded_handover_certificate_id`) REFERENCES `mining_ecm`.`project`.`handover_certificate`(`handover_certificate_id`);
ALTER TABLE `mining_ecm`.`project`.`team_member` ADD CONSTRAINT `fk_project_team_member_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`project`.`team_member` ADD CONSTRAINT `fk_project_team_member_reports_to_team_member_id` FOREIGN KEY (`reports_to_team_member_id`) REFERENCES `mining_ecm`.`project`.`team_member`(`team_member_id`);
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ADD CONSTRAINT `fk_project_lessons_learned_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ADD CONSTRAINT `fk_project_lessons_learned_change_order_id` FOREIGN KEY (`change_order_id`) REFERENCES `mining_ecm`.`project`.`change_order`(`change_order_id`);
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ADD CONSTRAINT `fk_project_lessons_learned_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `mining_ecm`.`project`.`issue`(`issue_id`);
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ADD CONSTRAINT `fk_project_lessons_learned_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `mining_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ADD CONSTRAINT `fk_project_lessons_learned_related_lessons_learned_id` FOREIGN KEY (`related_lessons_learned_id`) REFERENCES `mining_ecm`.`project`.`lessons_learned`(`lessons_learned_id`);
ALTER TABLE `mining_ecm`.`project`.`document` ADD CONSTRAINT `fk_project_document_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `mining_ecm`.`project`.`capital_project`(`capital_project_id`);
ALTER TABLE `mining_ecm`.`project`.`document` ADD CONSTRAINT `fk_project_document_feasibility_study_id` FOREIGN KEY (`feasibility_study_id`) REFERENCES `mining_ecm`.`project`.`feasibility_study`(`feasibility_study_id`);
ALTER TABLE `mining_ecm`.`project`.`document` ADD CONSTRAINT `fk_project_document_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `mining_ecm`.`project`.`phase`(`phase_id`);
ALTER TABLE `mining_ecm`.`project`.`document` ADD CONSTRAINT `fk_project_document_primary_superseded_by_document_id` FOREIGN KEY (`primary_superseded_by_document_id`) REFERENCES `mining_ecm`.`project`.`document`(`document_id`);
ALTER TABLE `mining_ecm`.`project`.`document` ADD CONSTRAINT `fk_project_document_superseded_document_id` FOREIGN KEY (`superseded_document_id`) REFERENCES `mining_ecm`.`project`.`document`(`document_id`);
ALTER TABLE `mining_ecm`.`project`.`calendar` ADD CONSTRAINT `fk_project_calendar_base_calendar_id` FOREIGN KEY (`base_calendar_id`) REFERENCES `mining_ecm`.`project`.`calendar`(`calendar_id`);

-- ========= TAGS =========
ALTER SCHEMA `mining_ecm`.`project` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `mining_ecm`.`project` SET TAGS ('dbx_domain' = 'project');
ALTER TABLE `mining_ecm`.`project`.`capital_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`project`.`capital_project` SET TAGS ('dbx_subdomain' = 'portfolio_governance');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `business_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Employee Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `capital_sponsor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Sponsor Employee Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `capital_sponsor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `capital_sponsor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `parent_capital_project_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `capex_category` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Category');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `capex_category` SET TAGS ('dbx_value_regex' = 'growth|sustaining|compliance|closure');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `closure_provision_amount` SET TAGS ('dbx_business_glossary_term' = 'Closure Provision Amount');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `closure_provision_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `commodity` SET TAGS ('dbx_business_glossary_term' = 'Commodity');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `contract_strategy` SET TAGS ('dbx_business_glossary_term' = 'Contract Strategy');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `contract_strategy` SET TAGS ('dbx_value_regex' = 'epc|epcm|alliance|construct_only|design_build|owner_operated');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `design_capacity` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `design_capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity Unit of Measure');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `design_capacity_unit` SET TAGS ('dbx_value_regex' = 'tpa|mtpa|mw|km|m|units');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `eis_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Statement (EIS) Reference Number');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `environmental_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Approval Status');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `environmental_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|conditional|rejected');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `forecast_completion_cost` SET TAGS ('dbx_business_glossary_term' = 'Forecast Completion Cost');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `forecast_completion_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `forecast_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Completion Date');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `handover_date` SET TAGS ('dbx_business_glossary_term' = 'Handover Date');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `irr_percentage` SET TAGS ('dbx_business_glossary_term' = 'Internal Rate of Return (IRR) Percentage');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `irr_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `life_of_mine_years` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Years');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `npv_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Present Value (NPV) Amount');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `npv_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `payback_period_years` SET TAGS ('dbx_business_glossary_term' = 'Payback Period (Years)');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `payback_period_years` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `project_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'greenfield|brownfield|sustaining_capital|expansion|closure|infrastructure');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `sanction_date` SET TAGS ('dbx_business_glossary_term' = 'Sanction Date');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `stage_gate_phase` SET TAGS ('dbx_business_glossary_term' = 'Stage-Gate Phase');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `stage_gate_phase` SET TAGS ('dbx_value_regex' = 'gate_0|gate_1|gate_2|gate_3|gate_4|gate_5');
ALTER TABLE `mining_ecm`.`project`.`capital_project` ALTER COLUMN `strategic_alignment` SET TAGS ('dbx_business_glossary_term' = 'Strategic Alignment');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` SET TAGS ('dbx_subdomain' = 'portfolio_governance');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `stage_gate_id` SET TAGS ('dbx_business_glossary_term' = 'Stage Gate ID');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `competent_person_id` SET TAGS ('dbx_business_glossary_term' = 'Competent Person ID');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `ore_reserve_id` SET TAGS ('dbx_business_glossary_term' = 'Ore Reserve Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `primary_next_gate_stage_gate_id` SET TAGS ('dbx_business_glossary_term' = 'Next Stage Gate ID');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `resource_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Estimate Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `preceding_stage_gate_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `actual_review_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Review Date');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `approval_conditions` SET TAGS ('dbx_business_glossary_term' = 'Approval Conditions');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `decision_authority` SET TAGS ('dbx_business_glossary_term' = 'Decision Authority Level');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `decision_authority` SET TAGS ('dbx_value_regex' = 'board|executive_committee|project_review_committee|steering_committee|project_director|general_manager');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_business_glossary_term' = 'Decision Outcome');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_value_regex' = 'approved|conditional_approval|rejected|deferred|cancelled');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `environmental_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Approval Status');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `environmental_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|approved|rejected');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `estimated_capex_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Capital Expenditure (CAPEX) in United States Dollars (USD)');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `estimated_capex_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `estimated_irr_percent` SET TAGS ('dbx_business_glossary_term' = 'Estimated Internal Rate of Return (IRR) Percentage');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `estimated_irr_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `estimated_npv_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Net Present Value (NPV) in United States Dollars (USD)');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `estimated_npv_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `gate_chair_name` SET TAGS ('dbx_business_glossary_term' = 'Gate Review Chair Name');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `gate_code` SET TAGS ('dbx_business_glossary_term' = 'Gate Code');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `gate_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `gate_criteria` SET TAGS ('dbx_business_glossary_term' = 'Gate Criteria');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `gate_description` SET TAGS ('dbx_business_glossary_term' = 'Gate Description');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `gate_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Gate Review Duration in Days');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `gate_name` SET TAGS ('dbx_business_glossary_term' = 'Gate Name');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `gate_sequence` SET TAGS ('dbx_business_glossary_term' = 'Gate Sequence Number');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `gate_status` SET TAGS ('dbx_business_glossary_term' = 'Gate Status');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `gate_type` SET TAGS ('dbx_business_glossary_term' = 'Gate Type');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `gate_type` SET TAGS ('dbx_value_regex' = 'concept|pre_feasibility|feasibility|execution_approval|commissioning|handover');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Record');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Gate');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|approved|rejected');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `required_deliverables` SET TAGS ('dbx_business_glossary_term' = 'Required Deliverables Checklist');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `reserve_estimate_confidence` SET TAGS ('dbx_business_glossary_term' = 'Reserve Estimate Confidence Level');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `reserve_estimate_confidence` SET TAGS ('dbx_value_regex' = 'not_applicable|probable|proved');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `resource_estimate_confidence` SET TAGS ('dbx_business_glossary_term' = 'Resource Estimate Confidence Level');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `resource_estimate_confidence` SET TAGS ('dbx_value_regex' = 'inferred|indicated|measured');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `review_committee_members` SET TAGS ('dbx_business_glossary_term' = 'Review Committee Members');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `risk_assessment_summary` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Summary');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Risk Rating');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `scheduled_review_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Review Date');
ALTER TABLE `mining_ecm`.`project`.`stage_gate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` SET TAGS ('dbx_subdomain' = 'portfolio_governance');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `gate_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Gate Decision ID');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `cost_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `feasibility_study_id` SET TAGS ('dbx_business_glossary_term' = 'Feasibility Study Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `stage_gate_id` SET TAGS ('dbx_business_glossary_term' = 'Stage Gate Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `deferred_gate_decision_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `approved_budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Currency');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `approved_budget_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `attendees` SET TAGS ('dbx_business_glossary_term' = 'Attendees');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `attendees` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'Passed|Failed|Not Required|Pending');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `conditions_attached` SET TAGS ('dbx_business_glossary_term' = 'Conditions Attached');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `conditions_attached` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `decision_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Decision Authority Name');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `decision_authority_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `decision_authority_role` SET TAGS ('dbx_business_glossary_term' = 'Decision Authority Role');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `decision_notes` SET TAGS ('dbx_business_glossary_term' = 'Decision Notes');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `decision_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_business_glossary_term' = 'Decision Outcome');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_value_regex' = 'Approved|Conditional Approval|Deferred|Rejected');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `environmental_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Approval Status');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `environmental_approval_status` SET TAGS ('dbx_value_regex' = 'Approved|Pending|Not Required|Rejected');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `irr_at_decision` SET TAGS ('dbx_business_glossary_term' = 'Internal Rate of Return (IRR) at Decision');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `irr_at_decision` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `meeting_reference` SET TAGS ('dbx_business_glossary_term' = 'Meeting Reference');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `next_gate_code` SET TAGS ('dbx_business_glossary_term' = 'Next Gate Code');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `next_gate_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `next_gate_target_date` SET TAGS ('dbx_business_glossary_term' = 'Next Gate Target Date');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `npv_at_decision` SET TAGS ('dbx_business_glossary_term' = 'Net Present Value (NPV) at Decision');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `npv_at_decision` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `payback_period_years` SET TAGS ('dbx_business_glossary_term' = 'Payback Period Years');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `payback_period_years` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `safety_review_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Review Status');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `safety_review_status` SET TAGS ('dbx_value_regex' = 'Approved|Conditional|Pending|Not Required');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `stakeholder_consultation_status` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Consultation Status');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `stakeholder_consultation_status` SET TAGS ('dbx_value_regex' = 'Complete|In Progress|Not Required|Pending');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `strategic_alignment_score` SET TAGS ('dbx_business_glossary_term' = 'Strategic Alignment Score');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `supporting_document_references` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document References');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `voting_outcome` SET TAGS ('dbx_business_glossary_term' = 'Voting Outcome');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `voting_outcome` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`gate_decision` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` SET TAGS ('dbx_subdomain' = 'portfolio_governance');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `feasibility_study_id` SET TAGS ('dbx_business_glossary_term' = 'Feasibility Study Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `competent_person_id` SET TAGS ('dbx_business_glossary_term' = 'Competent Person Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `ore_reserve_id` SET TAGS ('dbx_business_glossary_term' = 'Ore Reserve Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `resource_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Estimate Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Target Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `superseded_feasibility_study_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `annual_production_rate` SET TAGS ('dbx_business_glossary_term' = 'Annual Production Rate');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Study Approval Date');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Study Approval Status');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'Pending Approval|Approved|Rejected|Conditionally Approved|Withdrawn');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `capital_cost_class` SET TAGS ('dbx_business_glossary_term' = 'Capital Cost Estimate Classification (AACE)');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `capital_cost_class` SET TAGS ('dbx_value_regex' = 'Class 5|Class 4|Class 3|Class 2|Class 1');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `capital_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Capital Cost Currency Code');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `capital_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `capital_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Cost Estimate');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `commodity_price_assumption` SET TAGS ('dbx_business_glossary_term' = 'Commodity Price Assumption');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `commodity_price_currency` SET TAGS ('dbx_business_glossary_term' = 'Commodity Price Currency Code');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `commodity_price_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `commodity_price_unit` SET TAGS ('dbx_business_glossary_term' = 'Commodity Price Unit of Measure');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `commodity_price_unit` SET TAGS ('dbx_value_regex' = 'per tonne|per ounce|per pound|per kilogram');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Percentage');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `environmental_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Approval Status');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `environmental_approval_status` SET TAGS ('dbx_value_regex' = 'Not Required|Pending|In Progress|Approved|Rejected');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `exchange_rate_assumption` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange Rate Assumption');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `irr` SET TAGS ('dbx_business_glossary_term' = 'Internal Rate of Return (IRR)');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `irr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `lead_consultant` SET TAGS ('dbx_business_glossary_term' = 'Lead Consulting Firm');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `life_of_mine_years` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) in Years');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `npv` SET TAGS ('dbx_business_glossary_term' = 'Net Present Value (NPV)');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `npv` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `npv_currency` SET TAGS ('dbx_business_glossary_term' = 'Net Present Value (NPV) Currency Code');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `npv_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `operating_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Operating Cost Currency Code');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `operating_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `operating_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Cost Estimate');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `operating_cost_unit` SET TAGS ('dbx_business_glossary_term' = 'Operating Cost Unit of Measure');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `operating_cost_unit` SET TAGS ('dbx_value_regex' = 'per tonne ore|per tonne product|per ounce|per pound|per annum');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `payback_period_years` SET TAGS ('dbx_business_glossary_term' = 'Payback Period in Years');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `production_rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Production Rate Unit of Measure');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `production_rate_unit` SET TAGS ('dbx_value_regex' = 'tonnes|ounces|pounds|kilograms');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `risk_assessment_completed` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Completed Flag');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `sensitivity_analysis_completed` SET TAGS ('dbx_business_glossary_term' = 'Sensitivity Analysis Completed Flag');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `social_impact_assessment_completed` SET TAGS ('dbx_business_glossary_term' = 'Social Impact Assessment Completed Flag');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `study_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Study Completion Date');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `study_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Study Document Reference');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `study_name` SET TAGS ('dbx_business_glossary_term' = 'Feasibility Study Name');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `study_number` SET TAGS ('dbx_business_glossary_term' = 'Feasibility Study Number');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `study_scope` SET TAGS ('dbx_business_glossary_term' = 'Study Scope Description');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `study_start_date` SET TAGS ('dbx_business_glossary_term' = 'Study Start Date');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'Study Lifecycle Status');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `study_status` SET TAGS ('dbx_value_regex' = 'Planned|In Progress|Under Review|Completed|Cancelled|On Hold');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Feasibility Study Type');
ALTER TABLE `mining_ecm`.`project`.`feasibility_study` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'Scoping Study|Pre-Feasibility Study|Definitive Feasibility Study|Bankable Feasibility Study|Trade-Off Study|Optimization Study');
ALTER TABLE `mining_ecm`.`project`.`phase` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`project`.`phase` SET TAGS ('dbx_subdomain' = 'portfolio_governance');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Project Phase Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Manager Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `predecessor_phase_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Phase Actual Cost');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `actual_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration (Days)');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `actual_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Date');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `baseline_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Baseline Duration (Days)');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Phase Budget Amount');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `committed_cost` SET TAGS ('dbx_business_glossary_term' = 'Phase Committed Cost');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Phase Completion Percentage');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `cost_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance Amount');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `forecast_cost` SET TAGS ('dbx_business_glossary_term' = 'Phase Forecast Cost');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `forecast_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Finish Date');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `gate_approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Gate Approval Authority');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `gate_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Gate Approval Date');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `gate_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Gate Approval Required Flag');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `key_deliverables` SET TAGS ('dbx_business_glossary_term' = 'Key Deliverables');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Phase Notes');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `phase_code` SET TAGS ('dbx_business_glossary_term' = 'Phase Code');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `phase_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `phase_description` SET TAGS ('dbx_business_glossary_term' = 'Phase Description');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `phase_name` SET TAGS ('dbx_business_glossary_term' = 'Phase Name');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `phase_status` SET TAGS ('dbx_business_glossary_term' = 'Phase Status');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `phase_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|on_hold|completed|cancelled|deferred');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `planned_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Finish Date');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `record_active_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Active Flag');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Phase Risk Rating');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `schedule_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance (Days)');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Phase Sequence Number');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `mining_ecm`.`project`.`phase` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `mining_ecm`.`project`.`schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`project`.`schedule` SET TAGS ('dbx_subdomain' = 'execution_planning');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Project Schedule ID');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `superseded_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `baseline_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Approval Date');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `completed_activities_count` SET TAGS ('dbx_business_glossary_term' = 'Completed Activities Count');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `compression_method` SET TAGS ('dbx_business_glossary_term' = 'Schedule Compression Method');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `compression_method` SET TAGS ('dbx_value_regex' = 'none|fast_tracking|crashing|both');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `contingency_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Contingency (Days)');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `critical_activities_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Activities Count');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `data_date` SET TAGS ('dbx_business_glossary_term' = 'Data Date');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `forecast_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Completion Date');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `last_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Update Date');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `longest_path_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Longest Path Duration (Days)');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `performance_index` SET TAGS ('dbx_business_glossary_term' = 'Schedule Performance Index (SPI)');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `performance_index_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Performance Index (SPI) Calculation Date');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `prepared_by` SET TAGS ('dbx_business_glossary_term' = 'Prepared By');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Schedule Risk Level');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|superseded|archived');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'baseline|current|forecast|what_if|recovery');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `scheduling_tool` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Tool');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `scheduling_tool` SET TAGS ('dbx_value_regex' = 'primavera_p6|ms_project|deswik|minex|other');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `scheduling_tool_file_reference` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Tool File Reference');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Start Date');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `total_activities_count` SET TAGS ('dbx_business_glossary_term' = 'Total Activities Count');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `total_float_days` SET TAGS ('dbx_business_glossary_term' = 'Total Float (Days)');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `update_frequency` SET TAGS ('dbx_business_glossary_term' = 'Schedule Update Frequency');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `update_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|quarterly|ad_hoc');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance (Days)');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version');
ALTER TABLE `mining_ecm`.`project`.`schedule` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` SET TAGS ('dbx_subdomain' = 'execution_planning');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `schedule_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Activity Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Calendar Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Project Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `predecessor_schedule_activity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `activity_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Code');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `activity_name` SET TAGS ('dbx_business_glossary_term' = 'Activity Name');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `activity_notes` SET TAGS ('dbx_business_glossary_term' = 'Activity Notes');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Status');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|suspended|cancelled');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'task_dependent|milestone|level_of_effort|start_milestone|finish_milestone|wbs_summary');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `actual_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration (Days)');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `actual_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Date');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `actual_labour_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Labour Hours');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `budgeted_cost` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Cost');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `budgeted_labour_hours` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Labour Hours');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `constraint_date` SET TAGS ('dbx_business_glossary_term' = 'Constraint Date');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `constraint_type` SET TAGS ('dbx_business_glossary_term' = 'Constraint Type');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `data_date` SET TAGS ('dbx_business_glossary_term' = 'Data Date');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `discipline_code` SET TAGS ('dbx_business_glossary_term' = 'Discipline Code');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `early_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Early Finish Date');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `early_start_date` SET TAGS ('dbx_business_glossary_term' = 'Early Start Date');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `free_float_days` SET TAGS ('dbx_business_glossary_term' = 'Free Float (Days)');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `late_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Late Finish Date');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `late_start_date` SET TAGS ('dbx_business_glossary_term' = 'Late Start Date');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `original_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Original Duration (Days)');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete (%)');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `planned_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Finish Date');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Activity Priority');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `remaining_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Remaining Duration (Days)');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `mining_ecm`.`project`.`schedule_activity` ALTER COLUMN `total_float_days` SET TAGS ('dbx_business_glossary_term' = 'Total Float (Days)');
ALTER TABLE `mining_ecm`.`project`.`milestone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`project`.`milestone` SET TAGS ('dbx_subdomain' = 'execution_planning');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `predecessor_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Milestone Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `accountable_person` SET TAGS ('dbx_business_glossary_term' = 'Accountable Person');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Achievement Date');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone Approval Date');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Milestone Date');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Milestone Comments');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `contractual_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Contractual Obligation Flag');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `criticality_flag` SET TAGS ('dbx_business_glossary_term' = 'Criticality Flag');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `delay_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason Code');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `delay_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason Description');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `evidence_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document Reference');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Milestone Date');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `milestone_category` SET TAGS ('dbx_business_glossary_term' = 'Milestone Category');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `milestone_category` SET TAGS ('dbx_value_regex' = 'Design|Procurement|Construction|Commissioning|Handover|Approval');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_business_glossary_term' = 'Milestone Code');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Description');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|At Risk|Achieved|Missed|Cancelled');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'Contractual|Internal|Regulatory|Financial|Stage Gate|Technical');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Milestone Payment Amount');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `payment_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Trigger Flag');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Milestone Date');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Milestone Risk Rating');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `stage_gate_flag` SET TAGS ('dbx_business_glossary_term' = 'Stage Gate Flag');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `variance_days` SET TAGS ('dbx_business_glossary_term' = 'Milestone Variance in Days');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `mining_ecm`.`project`.`milestone` ALTER COLUMN `weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Milestone Weight Percentage');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` SET TAGS ('dbx_subdomain' = 'financial_control');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `cost_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `feasibility_study_id` SET TAGS ('dbx_business_glossary_term' = 'Feasibility Study Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `resource_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Estimate Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Target Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `superseded_by_estimate_cost_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Estimate Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `superseded_cost_estimate_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `accuracy_range_high` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Range High Percentage');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `accuracy_range_low` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Range Low Percentage');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_value_regex' = 'Site Manager|General Manager|Executive Committee|Board of Directors');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `base_estimate_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Estimate Amount');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `capex_category` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Category');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `capex_category` SET TAGS ('dbx_value_regex' = 'Sustaining|Expansion|Greenfield|Brownfield|Infrastructure|Closure');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_business_glossary_term' = 'Contingency Amount');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contingency Percentage');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `direct_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Direct Cost Amount');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `escalation_amount` SET TAGS ('dbx_business_glossary_term' = 'Escalation Amount');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `escalation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Escalation Percentage');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `estimate_base_date` SET TAGS ('dbx_business_glossary_term' = 'Estimate Base Date');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `estimate_basis_narrative` SET TAGS ('dbx_business_glossary_term' = 'Estimate Basis Narrative');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `estimate_class` SET TAGS ('dbx_business_glossary_term' = 'Association for the Advancement of Cost Engineering (AACE) Estimate Class');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `estimate_class` SET TAGS ('dbx_value_regex' = 'Class 5|Class 4|Class 3|Class 2|Class 1');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `estimate_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Estimate Confidence Level');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `estimate_confidence_level` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Very High');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `estimate_notes` SET TAGS ('dbx_business_glossary_term' = 'Estimate Notes');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `estimate_number` SET TAGS ('dbx_business_glossary_term' = 'Estimate Number');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `estimate_preparation_date` SET TAGS ('dbx_business_glossary_term' = 'Estimate Preparation Date');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `estimate_status` SET TAGS ('dbx_business_glossary_term' = 'Estimate Status');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `estimate_status` SET TAGS ('dbx_value_regex' = 'Draft|Under Review|Approved|Rejected|Superseded|Baseline');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `estimate_version` SET TAGS ('dbx_business_glossary_term' = 'Estimate Version');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `estimating_methodology` SET TAGS ('dbx_business_glossary_term' = 'Estimating Methodology');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `estimating_methodology` SET TAGS ('dbx_value_regex' = 'Parametric|Factored|Detailed Bottom-Up|Analogous|Expert Judgment|Hybrid');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `indirect_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Amount');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `prepared_by` SET TAGS ('dbx_business_glossary_term' = 'Prepared By');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `risk_allowance_included` SET TAGS ('dbx_business_glossary_term' = 'Risk Allowance Included Flag');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `scope_definition_level` SET TAGS ('dbx_business_glossary_term' = 'Scope Definition Level');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `scope_definition_level` SET TAGS ('dbx_value_regex' = 'Concept|Pre-Feasibility|Feasibility|Detailed Design|Construction Ready');
ALTER TABLE `mining_ecm`.`project`.`cost_estimate` ALTER COLUMN `total_estimate_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Estimate Amount');
ALTER TABLE `mining_ecm`.`project`.`project_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`project`.`project_budget` SET TAGS ('dbx_subdomain' = 'financial_control');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget ID');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `cost_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `resource_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Estimate Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `superseded_project_budget_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Amendment Date');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Budget Amendment Reason');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `approval_gate` SET TAGS ('dbx_business_glossary_term' = 'Stage-Gate Approval Gate');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `approval_gate` SET TAGS ('dbx_value_regex' = 'gate_0|gate_1|gate_2|gate_3|gate_4|gate_5');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `baseline_budget_flag` SET TAGS ('dbx_business_glossary_term' = 'Baseline Budget Flag');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_business_glossary_term' = 'Authority for Expenditure (AFE) Number');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'original|revised|supplementary|contingency|baseline');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `capex_phase` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Phase');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `contingency_budget` SET TAGS ('dbx_business_glossary_term' = 'Contingency Budget');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contingency Percentage');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `cost_centre_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Code');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `direct_cost_budget` SET TAGS ('dbx_business_glossary_term' = 'Direct Cost Budget');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective From Date');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective To Date');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `indirect_cost_budget` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Budget');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `irr_at_approval` SET TAGS ('dbx_business_glossary_term' = 'Internal Rate of Return (IRR) at Approval');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `irr_at_approval` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `npv_at_approval` SET TAGS ('dbx_business_glossary_term' = 'Net Present Value (NPV) at Approval');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `npv_at_approval` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `owner_cost_budget` SET TAGS ('dbx_business_glossary_term' = 'Owner Cost Budget');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `payback_period_months` SET TAGS ('dbx_business_glossary_term' = 'Payback Period (Months)');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `payback_period_months` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `profit_centre_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Code');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `mining_ecm`.`project`.`project_budget` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` SET TAGS ('dbx_subdomain' = 'financial_control');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `budget_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Amendment Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `cost_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `superseded_budget_amendment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `amendment_amount` SET TAGS ('dbx_business_glossary_term' = 'Amendment Amount');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_value_regex' = '^AFE-AMD-[0-9]{6,10}$');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|withdrawn');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'scope_change|design_change|market_escalation|risk_event|schedule_delay|regulatory_requirement');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `approval_authority` SET TAGS ('dbx_value_regex' = 'project_manager|site_manager|general_manager|cfo|ceo|board');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `capex_category` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Category');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `capex_category` SET TAGS ('dbx_value_regex' = 'sustaining|expansion|exploration|infrastructure|compliance|other');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `change_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Change Order Reference');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `change_order_reference` SET TAGS ('dbx_value_regex' = '^CO-[0-9]{6,10}$');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `contingency_amount_used` SET TAGS ('dbx_business_glossary_term' = 'Contingency Amount Used');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `contingency_drawdown_flag` SET TAGS ('dbx_business_glossary_term' = 'Contingency Drawdown Flag');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `cost_centre_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Code');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `cost_centre_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `impact_on_irr` SET TAGS ('dbx_business_glossary_term' = 'Impact on Internal Rate of Return (IRR)');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `impact_on_irr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `impact_on_npv` SET TAGS ('dbx_business_glossary_term' = 'Impact on Net Present Value (NPV)');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `impact_on_npv` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `original_approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Approved Amount');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `revised_total_budget` SET TAGS ('dbx_business_glossary_term' = 'Revised Total Budget');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `risk_register_reference` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Reference');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `risk_register_reference` SET TAGS ('dbx_value_regex' = '^RISK-[0-9]{4,8}$');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `stage_gate_phase` SET TAGS ('dbx_business_glossary_term' = 'Stage Gate Phase');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `submitted_by` SET TAGS ('dbx_business_glossary_term' = 'Submitted By');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `mining_ecm`.`project`.`budget_amendment` ALTER COLUMN `wbs_element` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.-]{6,20}$');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` SET TAGS ('dbx_subdomain' = 'financial_control');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `cost_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Commitment Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Change Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `original_commitment_cost_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Commitment Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `procurement_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `project_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Project Contract Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `revised_cost_commitment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer Name');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `capex_category` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Category');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `capex_category` SET TAGS ('dbx_value_regex' = 'sustaining|expansion|exploration|compliance|infrastructure');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `commitment_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Date');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `commitment_description` SET TAGS ('dbx_business_glossary_term' = 'Commitment Description');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `commitment_number` SET TAGS ('dbx_business_glossary_term' = 'Commitment Number');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `commitment_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_business_glossary_term' = 'Commitment Status');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `commitment_type` SET TAGS ('dbx_business_glossary_term' = 'Commitment Type');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `commitment_type` SET TAGS ('dbx_value_regex' = 'purchase_order|contract|letter_of_intent|blanket_order|service_agreement|framework_agreement');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `cost_centre_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Code');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `cost_centre_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `invoiced_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Amount');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `is_change_order` SET TAGS ('dbx_business_glossary_term' = 'Is Change Order Flag');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `payment_term_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Code');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `payment_term_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `remaining_commitment` SET TAGS ('dbx_business_glossary_term' = 'Remaining Commitment');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Name');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|PRONTO_XI|INFOR_EAM|MANUAL_ENTRY');
ALTER TABLE `mining_ecm`.`project`.`cost_commitment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` SET TAGS ('dbx_subdomain' = 'financial_control');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `expenditure_actual_id` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Actual Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `cost_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Commitment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posting User Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `procurement_goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `reversal_expenditure_actual_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,12}$');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `commitment_item_reference` SET TAGS ('dbx_business_glossary_term' = 'Commitment Item Reference');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Category Code');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_value_regex' = 'CAPEX|OPEX|SUSTAINING|EXPANSION|EXPLORATION');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `cost_element_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Code');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `cost_element_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `cost_element_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Description');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `financial_document_number` SET TAGS ('dbx_business_glossary_term' = 'Financial Document Number');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `financial_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `invoice_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Reference Number');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `record_active_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Active Flag');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_PS|SAP_FI|SAP_MM|INTERFACE|MANUAL');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `text_description` SET TAGS ('dbx_business_glossary_term' = 'Text Description');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `vendor_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `mining_ecm`.`project`.`expenditure_actual` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `mining_ecm`.`project`.`change_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`project`.`change_order` SET TAGS ('dbx_subdomain' = 'financial_control');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Change Order Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `project_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Project Contract Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `superseded_change_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_value_regex' = 'Project Manager|Project Director|Change Control Board|Executive Steering Committee|Board of Directors');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Change Order Approval Date');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `baseline_update_flag` SET TAGS ('dbx_business_glossary_term' = 'Baseline Update Flag');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `capex_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Impact Amount');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `change_category` SET TAGS ('dbx_business_glossary_term' = 'Change Category');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Order Description');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `change_justification` SET TAGS ('dbx_business_glossary_term' = 'Change Justification');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Change Order Number');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `change_order_number` SET TAGS ('dbx_value_regex' = '^CO-[0-9]{6,10}$');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `change_order_status` SET TAGS ('dbx_business_glossary_term' = 'Change Order Status');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `change_title` SET TAGS ('dbx_business_glossary_term' = 'Change Order Title');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'Scope Addition|Scope Reduction|Design Change|Regulatory Requirement|Force Majeure|Schedule Adjustment');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Amount');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `critical_path_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Impact Flag');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `hse_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Impact Assessment');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Change Order Implementation Date');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `milestone_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Impact Description');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `opex_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Impact Amount');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `originator_name` SET TAGS ('dbx_business_glossary_term' = 'Change Order Originator Name');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `originator_organization` SET TAGS ('dbx_business_glossary_term' = 'Originator Organization');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Change Order Priority');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `quality_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Quality Impact Assessment');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Change Order Rejection Date');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `required_by_date` SET TAGS ('dbx_business_glossary_term' = 'Change Order Required By Date');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `review_comments` SET TAGS ('dbx_business_glossary_term' = 'Review Comments');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `risk_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Impact Assessment');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact in Days');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `scope_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Impact Description');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Change Order Submission Date');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `supporting_documents` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documents');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`project`.`change_order` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `mining_ecm`.`project`.`risk_register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`project`.`risk_register` SET TAGS ('dbx_subdomain' = 'risk_delivery');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `risk_register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register ID');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `primary_risk_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Owner ID');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `primary_risk_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `primary_risk_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `stage_gate_id` SET TAGS ('dbx_business_glossary_term' = 'Stage Gate ID');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `superseded_risk_register_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `active_risk_count` SET TAGS ('dbx_business_glossary_term' = 'Active Risk Count');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Baseline Date');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `confidence_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level (Percent)');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `critical_risk_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Risk Count');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `key_assumptions` SET TAGS ('dbx_business_glossary_term' = 'Key Assumptions');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `monte_carlo_iterations` SET TAGS ('dbx_business_glossary_term' = 'Monte Carlo Simulation Iterations');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `project_phase_code` SET TAGS ('dbx_business_glossary_term' = 'Project Phase Code');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `record_active_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Active Flag');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `register_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Code');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `register_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Date');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `register_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Description');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `register_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Name');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `register_notes` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Notes');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `register_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Status');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `register_status` SET TAGS ('dbx_value_regex' = 'draft|active|under_review|approved|superseded|archived');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `register_version` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Version');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `risk_appetite_statement` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Statement');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `risk_framework` SET TAGS ('dbx_business_glossary_term' = 'Risk Management Framework');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `risk_methodology` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Methodology');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `risk_methodology` SET TAGS ('dbx_value_regex' = 'monte_carlo|deterministic|qualitative|quantitative|hybrid');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `risk_threshold_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Risk Threshold Cost (United States Dollar)');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `risk_threshold_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `risk_threshold_schedule_days` SET TAGS ('dbx_business_glossary_term' = 'Risk Threshold Schedule (Days)');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `total_cost_exposure_p50_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Cost Exposure P50 (United States Dollar)');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `total_cost_exposure_p50_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `total_cost_exposure_p80_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Cost Exposure P80 (United States Dollar)');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `total_cost_exposure_p80_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `total_cost_exposure_p90_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Cost Exposure P90 (United States Dollar)');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `total_cost_exposure_p90_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `total_risk_count` SET TAGS ('dbx_business_glossary_term' = 'Total Risk Count');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `total_schedule_exposure_p50_days` SET TAGS ('dbx_business_glossary_term' = 'Total Schedule Exposure P50 (Days)');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `total_schedule_exposure_p50_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `total_schedule_exposure_p80_days` SET TAGS ('dbx_business_glossary_term' = 'Total Schedule Exposure P80 (Days)');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `total_schedule_exposure_p80_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `total_schedule_exposure_p90_days` SET TAGS ('dbx_business_glossary_term' = 'Total Schedule Exposure P90 (Days)');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `total_schedule_exposure_p90_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `mining_ecm`.`project`.`risk_register` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `mining_ecm`.`project`.`risk_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`project`.`risk_item` SET TAGS ('dbx_subdomain' = 'risk_delivery');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `risk_item_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Item Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `procurement_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `risk_register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `parent_risk_item_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `affected_disciplines` SET TAGS ('dbx_business_glossary_term' = 'Affected Disciplines');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `affected_wbs_elements` SET TAGS ('dbx_business_glossary_term' = 'Affected Work Breakdown Structure (WBS) Elements');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Closure Reason');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `consequence_rating_post_mitigation` SET TAGS ('dbx_business_glossary_term' = 'Consequence Rating Post-Mitigation');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `consequence_rating_post_mitigation` SET TAGS ('dbx_value_regex' = 'insignificant|minor|moderate|major|catastrophic');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `consequence_rating_pre_mitigation` SET TAGS ('dbx_business_glossary_term' = 'Consequence Rating Pre-Mitigation');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `consequence_rating_pre_mitigation` SET TAGS ('dbx_value_regex' = 'insignificant|minor|moderate|major|catastrophic');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `contingency_plan` SET TAGS ('dbx_business_glossary_term' = 'Contingency Plan');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `cost_impact_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Estimate United States Dollars (USD)');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `cost_impact_estimate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `likelihood_rating_post_mitigation` SET TAGS ('dbx_business_glossary_term' = 'Likelihood Rating Post-Mitigation');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `likelihood_rating_post_mitigation` SET TAGS ('dbx_value_regex' = 'rare|unlikely|possible|likely|almost_certain');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `likelihood_rating_pre_mitigation` SET TAGS ('dbx_business_glossary_term' = 'Likelihood Rating Pre-Mitigation');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `likelihood_rating_pre_mitigation` SET TAGS ('dbx_value_regex' = 'rare|unlikely|possible|likely|almost_certain');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `mitigation_actions` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Actions');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `probability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Probability Percentage');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `record_active_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Active Flag');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `residual_risk_status` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Status');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `residual_risk_status` SET TAGS ('dbx_value_regex' = 'acceptable|monitor|escalate|further_action_required');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `risk_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Closed Date');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `risk_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Code');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `risk_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `risk_identified_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Identified Date');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `risk_proximity` SET TAGS ('dbx_business_glossary_term' = 'Risk Proximity');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `risk_proximity` SET TAGS ('dbx_value_regex' = 'immediate|near_term|medium_term|long_term');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `risk_response_strategy` SET TAGS ('dbx_business_glossary_term' = 'Risk Response Strategy');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `risk_score_post_mitigation` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Post-Mitigation');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `risk_score_pre_mitigation` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Pre-Mitigation');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `risk_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Status');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `risk_status` SET TAGS ('dbx_value_regex' = 'open|active|mitigated|closed|accepted|transferred');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `risk_title` SET TAGS ('dbx_business_glossary_term' = 'Risk Title');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `risk_trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Risk Trigger Event');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `risk_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Type');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `risk_type` SET TAGS ('dbx_value_regex' = 'threat|opportunity');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `mining_ecm`.`project`.`risk_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `mining_ecm`.`project`.`project_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`project`.`project_contract` SET TAGS ('dbx_subdomain' = 'risk_delivery');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `project_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Project Contract Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Administrator Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `project_contract_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `project_contract_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `project_contract_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `parent_project_contract_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `actual_cost_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost to Date');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Approval Date');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `committed_cost` SET TAGS ('dbx_business_glossary_term' = 'Committed Cost');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `contract_value` SET TAGS ('dbx_business_glossary_term' = 'Contract Value');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `defects_liability_end_date` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability End Date');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `defects_liability_period_days` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period (Days)');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Execution Date');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `insurance_required` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `liquidated_damages_applicable` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Applicable Flag');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `liquidated_damages_rate` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Rate');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `performance_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Amount');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `performance_bond_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Expiry Date');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `performance_bond_required` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Required Flag');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `record_active_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Active Flag');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `retention_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Amount');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `revised_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Revised Contract Value');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `scope_summary` SET TAGS ('dbx_business_glossary_term' = 'Scope of Work Summary');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Contract Title');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `total_variation_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Variation Amount');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`project`.`project_contract` ALTER COLUMN `variation_order_count` SET TAGS ('dbx_business_glossary_term' = 'Variation Order Count');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` SET TAGS ('dbx_subdomain' = 'risk_delivery');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `progress_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Progress Claim Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Engineer Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `project_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `revised_progress_claim_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Certification Date');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `certified_amount` SET TAGS ('dbx_business_glossary_term' = 'Certified Amount');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `claim_notes` SET TAGS ('dbx_business_glossary_term' = 'Progress Claim Notes');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Progress Claim Number');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `claim_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Period End Date');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `claim_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Period Start Date');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `claim_sequence` SET TAGS ('dbx_business_glossary_term' = 'Claim Sequence Number');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Progress Claim Status');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Progress Claim Type');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'Regular|Interim|Final|Variation|Retention Release|Milestone');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `claimed_amount` SET TAGS ('dbx_business_glossary_term' = 'Claimed Amount');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Review Due Date');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Payment Date');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `previous_claims_cumulative_amount` SET TAGS ('dbx_business_glossary_term' = 'Previous Claims Cumulative Amount');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `record_active_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Active Flag');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `retention_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Amount Withheld');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Submission Date');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `supporting_documents_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documents Reference');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`project`.`progress_claim` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `mining_ecm`.`project`.`issue` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`project`.`issue` SET TAGS ('dbx_subdomain' = 'risk_delivery');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `issue_id` SET TAGS ('dbx_business_glossary_term' = 'Project Issue Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `project_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Project Contract Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `risk_item_id` SET TAGS ('dbx_business_glossary_term' = 'Related Risk Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `parent_issue_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `assigned_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Owner Name');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `assigned_owner_organisation` SET TAGS ('dbx_business_glossary_term' = 'Assigned Owner Organisation');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `closed_by_name` SET TAGS ('dbx_business_glossary_term' = 'Closed By Name');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Amount');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `critical_path_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Impact Flag');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `date_raised` SET TAGS ('dbx_business_glossary_term' = 'Date Raised');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `discipline_code` SET TAGS ('dbx_business_glossary_term' = 'Discipline Code');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'None|Project Manager|Program Director|Executive|Board');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `hse_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Environment (HSE) Incident Flag');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `issue_description` SET TAGS ('dbx_business_glossary_term' = 'Issue Description');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `issue_number` SET TAGS ('dbx_business_glossary_term' = 'Issue Number');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `issue_status` SET TAGS ('dbx_business_glossary_term' = 'Issue Status');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `issue_status` SET TAGS ('dbx_value_regex' = 'Open|In Progress|Resolved|Closed|Escalated|On Hold');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `issue_type` SET TAGS ('dbx_business_glossary_term' = 'Issue Type');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `issue_type` SET TAGS ('dbx_value_regex' = 'Technical|Commercial|HSE|Quality|Schedule|Resource');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Issue Notes');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Issue Priority');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `raised_by_name` SET TAGS ('dbx_business_glossary_term' = 'Raised By Name');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `raised_by_organisation` SET TAGS ('dbx_business_glossary_term' = 'Raised By Organisation');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `record_active_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Active Flag');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Flag');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Issue Severity');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'Major|Moderate|Minor');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Issue Title');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `mining_ecm`.`project`.`issue` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` SET TAGS ('dbx_subdomain' = 'risk_delivery');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `commissioning_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Activity Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `circuit_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Circuit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `predecessor_activity_commissioning_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Activity Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Contractor Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Material Master Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `prerequisite_commissioning_activity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `acceptance_criteria_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria Met Flag');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `activity_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Code');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `activity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Activity Description');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `activity_name` SET TAGS ('dbx_business_glossary_term' = 'Activity Name');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Status');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|on_hold|completed|cancelled');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'mechanical_completion_check|pre_commissioning_test|cold_commissioning|hot_commissioning|performance_test|integrated_systems_test');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `actual_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration (Days)');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `commissioning_system` SET TAGS ('dbx_business_glossary_term' = 'Commissioning System');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `critical_punch_list_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Punch List Item Count');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `delay_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason Code');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `delay_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason Description');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `discipline_code` SET TAGS ('dbx_business_glossary_term' = 'Discipline Code');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `forecast_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Completion Date');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `handover_readiness_flag` SET TAGS ('dbx_business_glossary_term' = 'Handover Readiness Flag');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `planned_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Duration (Days)');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `punch_list_item_count` SET TAGS ('dbx_business_glossary_term' = 'Punch List Item Count');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `safety_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Permit Number');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `sign_off_authority` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Authority');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Date');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `sign_off_status` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Status');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `sign_off_status` SET TAGS ('dbx_value_regex' = 'not_started|pending_review|approved|rejected|conditional_approval');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `system_tag_number` SET TAGS ('dbx_business_glossary_term' = 'System Tag Number');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `test_procedure_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Procedure Reference');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `test_result_summary` SET TAGS ('dbx_business_glossary_term' = 'Test Result Summary');
ALTER TABLE `mining_ecm`.`project`.`commissioning_activity` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` SET TAGS ('dbx_subdomain' = 'risk_delivery');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `punch_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Punch List Item Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `commissioning_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Activity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `handover_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Handover Certificate Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Material Master Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `originated_from_punch_list_item_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `area_code` SET TAGS ('dbx_business_glossary_term' = 'Area Code');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Amount');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `days_overdue` SET TAGS ('dbx_business_glossary_term' = 'Days Overdue');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `drawing_reference` SET TAGS ('dbx_business_glossary_term' = 'Drawing Reference');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `environmental_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Critical Flag');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `identified_by` SET TAGS ('dbx_business_glossary_term' = 'Identified By');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Identified Date');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `item_status` SET TAGS ('dbx_business_glossary_term' = 'Item Status');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `item_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|verified|closed|cancelled');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `photo_reference` SET TAGS ('dbx_business_glossary_term' = 'Photo Reference');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `punch_list_item_category` SET TAGS ('dbx_business_glossary_term' = 'Punch List Category');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `punch_list_item_category` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `punch_list_number` SET TAGS ('dbx_business_glossary_term' = 'Punch List Number');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `punch_list_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `responsible_contractor` SET TAGS ('dbx_business_glossary_term' = 'Responsible Contractor');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `responsible_discipline` SET TAGS ('dbx_business_glossary_term' = 'Responsible Discipline');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `safety_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Critical Flag');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Specification Reference');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `system_code` SET TAGS ('dbx_business_glossary_term' = 'System Code');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `verification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Verification Required Flag');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `mining_ecm`.`project`.`punch_list_item` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` SET TAGS ('dbx_subdomain' = 'risk_delivery');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `handover_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Handover Certificate ID');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Plant Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operations Manager ID');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `superseded_handover_certificate_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `area_location` SET TAGS ('dbx_business_glossary_term' = 'Area Location');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `critical_punch_items_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Punch Items Count');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `design_capacity_achieved_flag` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity Achieved Flag');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `documentation_package_complete_flag` SET TAGS ('dbx_business_glossary_term' = 'Documentation Package Complete Flag');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `environmental_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Approval Status');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `environmental_approval_status` SET TAGS ('dbx_value_regex' = 'Approved|Pending|Conditional|Not Required');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `handover_conditions` SET TAGS ('dbx_business_glossary_term' = 'Handover Conditions');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `handover_date` SET TAGS ('dbx_business_glossary_term' = 'Handover Date');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `handover_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Handover Meeting Date');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `handover_notes` SET TAGS ('dbx_business_glossary_term' = 'Handover Notes');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `handover_status` SET TAGS ('dbx_business_glossary_term' = 'Handover Status');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `handover_status` SET TAGS ('dbx_value_regex' = 'Draft|Pending Review|Approved|Rejected|Superseded|Cancelled');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `handover_type` SET TAGS ('dbx_business_glossary_term' = 'Handover Type');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `handover_type` SET TAGS ('dbx_value_regex' = 'Mechanical Completion|Practical Completion|Final Completion|Substantial Completion|Sectional Completion|Provisional Acceptance');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `operations_acceptance_signoff` SET TAGS ('dbx_business_glossary_term' = 'Operations Acceptance Sign-off');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `operations_acceptance_signoff` SET TAGS ('dbx_value_regex' = 'Accepted|Accepted with Conditions|Rejected|Pending');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `operations_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Operations Manager Name');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `operations_signoff_date` SET TAGS ('dbx_business_glossary_term' = 'Operations Sign-off Date');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `outstanding_punch_items_count` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Punch Items Count');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `payment_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Trigger Flag');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `performance_test_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Test Date');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `performance_test_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Test Status');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `performance_test_status` SET TAGS ('dbx_value_regex' = 'Passed|Failed|Waived|Not Required|In Progress');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `planned_handover_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Handover Date');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `project_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Name');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `project_manager_signoff_date` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Sign-off Date');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `record_active_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Active Flag');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `safety_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Certification Status');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `safety_certification_status` SET TAGS ('dbx_value_regex' = 'Certified|Pending|Not Required|Expired');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `spare_parts_delivered_flag` SET TAGS ('dbx_business_glossary_term' = 'Spare Parts Delivered Flag');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `system_code` SET TAGS ('dbx_business_glossary_term' = 'System Code');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `system_name` SET TAGS ('dbx_business_glossary_term' = 'System Name');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `training_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Status');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `training_completion_status` SET TAGS ('dbx_value_regex' = 'Complete|Incomplete|In Progress|Not Required');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Date');
ALTER TABLE `mining_ecm`.`project`.`handover_certificate` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period Months');
ALTER TABLE `mining_ecm`.`project`.`team_member` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `mining_ecm`.`project`.`team_member` SET TAGS ('dbx_subdomain' = 'portfolio_governance');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `team_member_id` SET TAGS ('dbx_business_glossary_term' = 'Project Team Member ID');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `team_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `team_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `tertiary_team_functional_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Manager ID');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `tertiary_team_functional_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `tertiary_team_functional_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `reports_to_team_member_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|rejected');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|completed|terminated');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|consultant|secondment|temporary');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `daily_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Daily Rate Amount');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `daily_rate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `demobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Demobilization Date');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `discipline_code` SET TAGS ('dbx_business_glossary_term' = 'Discipline Code');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `hourly_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate Amount');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `hourly_rate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `induction_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Induction Completed Flag');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `induction_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Induction Completion Date');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `is_critical_resource` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Resource Flag');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `mobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Date');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `project_role_code` SET TAGS ('dbx_business_glossary_term' = 'Project Role Code');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `project_role_name` SET TAGS ('dbx_business_glossary_term' = 'Project Role Name');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `record_active_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Active Flag');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `termination_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Description');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `mining_ecm`.`project`.`team_member` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` SET TAGS ('dbx_subdomain' = 'portfolio_governance');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `lessons_learned_id` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned ID');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Change Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `issue_id` SET TAGS ('dbx_business_glossary_term' = 'Issue Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `related_lessons_learned_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `applicable_commodity` SET TAGS ('dbx_business_glossary_term' = 'Applicable Commodity');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `applicable_project_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Project Type');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `author_organization` SET TAGS ('dbx_business_glossary_term' = 'Author Organization');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `author_role` SET TAGS ('dbx_business_glossary_term' = 'Author Role');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `capture_date` SET TAGS ('dbx_business_glossary_term' = 'Capture Date');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `impact_area` SET TAGS ('dbx_business_glossary_term' = 'Impact Area');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Date');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `implementation_status` SET TAGS ('dbx_value_regex' = 'not_started|planned|in_progress|implemented|not_applicable');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `lesson_category` SET TAGS ('dbx_business_glossary_term' = 'Lesson Category');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `lesson_description` SET TAGS ('dbx_business_glossary_term' = 'Lesson Description');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `lesson_number` SET TAGS ('dbx_business_glossary_term' = 'Lesson Number');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `lesson_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Lesson Subcategory');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `lesson_title` SET TAGS ('dbx_business_glossary_term' = 'Lesson Title');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `lesson_type` SET TAGS ('dbx_business_glossary_term' = 'Lesson Type');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `lesson_type` SET TAGS ('dbx_value_regex' = 'positive|negative|observation|best_practice|risk_mitigation');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `occurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Date');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `recommendation` SET TAGS ('dbx_business_glossary_term' = 'Recommendation');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `related_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Related Document Reference');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|archived');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `severity_rating` SET TAGS ('dbx_business_glossary_term' = 'Severity Rating');
ALTER TABLE `mining_ecm`.`project`.`lessons_learned` ALTER COLUMN `severity_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `mining_ecm`.`project`.`document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`project`.`document` SET TAGS ('dbx_subdomain' = 'portfolio_governance');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Project Document Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `feasibility_study_id` SET TAGS ('dbx_business_glossary_term' = 'Feasibility Study Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `primary_superseded_by_document_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Document Identifier (ID)');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `superseded_document_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Document Approval Date');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Document Approved By Name');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Document Author Name');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `author_organization` SET TAGS ('dbx_business_glossary_term' = 'Author Organization Name');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Document Confidentiality Level');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `contract_deliverable_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Deliverable Flag');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `discipline_code` SET TAGS ('dbx_business_glossary_term' = 'Engineering Discipline Code');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `dms_platform` SET TAGS ('dbx_business_glossary_term' = 'Document Management System (DMS) Platform');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `dms_platform` SET TAGS ('dbx_value_regex' = 'aconex|procore|sharepoint|documentum|projectwise|other');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `dms_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Management System (DMS) Reference');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Control Number');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Lifecycle Status');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type Classification');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `drawing_scale` SET TAGS ('dbx_business_glossary_term' = 'Drawing Scale Ratio');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `drawing_size` SET TAGS ('dbx_business_glossary_term' = 'Drawing Sheet Size');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `equipment_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Tag Number');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'Document File Format');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Document File Size in Megabytes (MB)');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Document Search Keywords');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Document Notes and Comments');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Document Page Count');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `related_wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Related Work Breakdown Structure (WBS) Code');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Document Retention Period in Years');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Document Review Date');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Document Reviewed By Name');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Document Revision Date');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Document Revision Number');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `transmittal_number` SET TAGS ('dbx_business_glossary_term' = 'Document Transmittal Number');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`project`.`document` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor or Supplier Name');
ALTER TABLE `mining_ecm`.`project`.`calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`project`.`calendar` SET TAGS ('dbx_subdomain' = 'portfolio_governance');
ALTER TABLE `mining_ecm`.`project`.`calendar` ALTER COLUMN `calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Calendar Identifier');
ALTER TABLE `mining_ecm`.`project`.`calendar` ALTER COLUMN `base_calendar_id` SET TAGS ('dbx_self_ref_fk' = 'true');
