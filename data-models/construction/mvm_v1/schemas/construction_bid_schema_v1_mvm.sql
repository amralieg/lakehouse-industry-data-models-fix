-- Schema for Domain: bid | Business: Construction | Version: v1_mvm
-- Generated on: 2026-05-07 09:27:04

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `construction_ecm`.`bid` COMMENT 'Pre-award commercial pipeline domain owning RFP/RFQ responses, tender submissions, BOQ pricing, project estimation data, win/loss records, bid bond management, and GMP/lump-sum bid preparation. Integrates with Salesforce CRM for opportunity tracking and pipeline forecasting. Tracks bid-to-award conversion rates across market segments.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `construction_ecm`.`bid`.`trade_package` (
    `trade_package_id` BIGINT COMMENT 'Unique identifier for the trade package. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Package Allocation Report requires linking each trade package to its master agreement to track contract value per package.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Trade packages are awarded by a specific legal entity for contract execution and financial reporting. In multi-entity construction groups, the awarding company code determines the intercompany account',
    `construction_project_id` BIGINT COMMENT 'Reference to the parent construction project to which this trade package belongs.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Trade packages are awarded against specific cost codes for committed cost tracking and budget control. Construction cost managers require trade_package→cost_code linkage to report subcontract commitme',
    `package_id` BIGINT COMMENT 'Foreign key linking to design.package. Business justification: Trade packages are scoped against design packages — the design package defines what drawings and specs are included in the trade scope. Named process: design package to trade package scoping. Procur',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Trade packages (electrical, demolition, earthworks) require specific permits before subcontract award. Procurement teams must verify permit status when awarding trade packages. This link supports the ',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Trade packages are scoped to specific project phases (e.g., civil, MEP, finishing). Construction procurement managers plan and award trade packages by phase to align with project schedule gates. This ',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Associates each trade package with its budget line, supporting budget control and earned value analysis.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to project.site. Business justification: Trade packages are executed at specific construction sites. Site managers and procurement teams need site-level trade package reporting for resource coordination, access management, and site-specific ',
    `skill_trade_id` BIGINT COMMENT 'Foreign key linking to workforce.skill_trade. Business justification: Trade packages are organized by construction trade discipline. Linking to skill_trade drives workforce planning, staffing plan development, and labor resource loading per package. trade_discipline_cod',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Trade packages reference the governing technical specification defining quality and workmanship requirements for the scope. Named process: specification-driven trade package scoping. Construction pr',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element that this trade package is associated with for cost and schedule control.',
    `wbs_node_id` BIGINT COMMENT 'Foreign key linking to schedule.wbs_node. Business justification: Trade packages are scoped and budgeted against WBS nodes — procurement planners link each trade package to its WBS node for cost-schedule integration, earned value reporting, and subcontract progress ',
    `actual_completion_date` DATE COMMENT 'Actual date when the subcontractor completed all work under this trade package.',
    `actual_start_date` DATE COMMENT 'Actual date when the subcontractor commenced work on this trade package.',
    `award_date` DATE COMMENT 'Date when the trade package was formally awarded to the selected subcontractor.',
    `awarded_value` DECIMAL(18,2) COMMENT 'Final contract value at which the trade package was awarded to the subcontractor.',
    `bid_closing_date` DATE COMMENT 'Deadline date by which subcontractors must submit their bids for this trade package.',
    `bid_out_date` DATE COMMENT 'Date when the trade package was issued to subcontractors for competitive bidding.',
    `bonding_required` BOOLEAN COMMENT 'Indicates whether performance and payment bonds are required from the subcontractor for this trade package.',
    `budget_allowance` DECIMAL(18,2) COMMENT 'Budget allocation reserved for this trade package in the project cost plan.',
    `contract_type` STRING COMMENT 'Type of contract pricing mechanism for this trade package (Lump Sum, Unit Price, Cost Plus, Guaranteed Maximum Price, Time and Materials).. Valid values are `lump_sum|unit_price|cost_plus|gmp|time_and_materials`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade package record was first created in the system.',
    `csi_masterformat_code` STRING COMMENT 'CSI MasterFormat classification code for the scope of work (e.g., 03 30 00 for Cast-in-Place Concrete).. Valid values are `^[0-9]{2}s[0-9]{2}s[0-9]{2}(.[0-9]{2})?$`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this trade package (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `duration_days` STRING COMMENT 'Planned duration in calendar days for the execution of this trade package.',
    `estimated_value` DECIMAL(18,2) COMMENT 'Pre-bid estimated value of the trade package based on quantity take-offs and market rates.',
    `insurance_requirements` STRING COMMENT 'Summary of insurance coverage requirements that the awarded subcontractor must maintain (e.g., general liability, professional indemnity, workers compensation).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade package record was last updated.',
    `liquidated_damages_rate` DECIMAL(18,2) COMMENT 'Daily rate of liquidated damages applicable if the subcontractor fails to complete the trade package by the planned completion date.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this trade package.',
    `number_of_bidders_invited` STRING COMMENT 'Count of subcontractors invited to submit bids for this trade package.',
    `number_of_bids_received` STRING COMMENT 'Count of valid bids received from subcontractors by the bid closing date.',
    `package_priority` STRING COMMENT 'Priority level of this trade package relative to other packages in the project (Critical, High, Medium, Low).. Valid values are `critical|high|medium|low`',
    `package_reference_number` STRING COMMENT 'Externally-known unique reference number for the trade package used in bidding and contract documents.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `package_status` STRING COMMENT 'Current lifecycle status of the trade package in the bidding and award process.. Valid values are `draft|bid_out|evaluation|awarded|closed|cancelled`',
    `payment_terms_days` STRING COMMENT 'Number of days within which payment is due to the subcontractor after invoice approval.',
    `planned_completion_date` DATE COMMENT 'Scheduled date for the subcontractor to complete all work under this trade package.',
    `planned_start_date` DATE COMMENT 'Scheduled date for the subcontractor to commence work on this trade package.',
    `prequalification_required` BOOLEAN COMMENT 'Indicates whether subcontractors must be prequalified before being invited to bid on this trade package.',
    `procurement_method` STRING COMMENT 'Method used to procure this trade package (Open Tender, Selective Tender, Negotiated, Single Source, Framework Agreement).. Valid values are `open_tender|selective_tender|negotiated|single_source|framework`',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of each payment withheld as retention until satisfactory completion of the trade package.',
    `risk_level` STRING COMMENT 'Overall risk assessment level for this trade package based on complexity, value, and schedule criticality.. Valid values are `high|medium|low`',
    `scope_narrative` STRING COMMENT 'Detailed textual description of the scope of work included in this trade package, including deliverables, exclusions, and boundaries.',
    `uniformat_code` STRING COMMENT 'UniFormat II classification code for elemental cost planning (e.g., B2010 for Exterior Walls).. Valid values are `^[A-Z][0-9]{2}[0-9]{2}$`',
    `warranty_period_months` STRING COMMENT 'Duration in months of the defects liability period (DLP) or warranty period after completion.',
    CONSTRAINT pk_trade_package PRIMARY KEY(`trade_package_id`)
) COMMENT 'Defines a discrete scope-of-work package to be competitively bid and awarded to a subcontractor — e.g., structural steel erection, HVAC installation, electrical fit-out, piling works, or facade cladding. Captures trade discipline code, CSI MasterFormat/UniFormat classification, package reference number, associated WBS elements, scope narrative, estimated value, budget allowance, bid-out date, bid closing date, number of bidders invited, award date, and package status (draft, bid-out, evaluation, awarded, closed). The SSOT for trade package definitions that drive the subcontractor bidding and award process.';

CREATE OR REPLACE TABLE `construction_ecm`.`bid`.`bid_opportunity` (
    `bid_opportunity_id` BIGINT COMMENT 'System-generated unique identifier for the bid opportunity record.',
    `account_id` BIGINT COMMENT 'Unique identifier of the client organization that the opportunity targets.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Bid opportunities are pursued by a specific legal entity (company code) — critical for multi-entity construction groups for financial reporting, bonding capacity, and legal compliance. Construction gr',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for Cost Allocation Report: tracks which finance cost center funds bid preparation expenses, essential for budgeting and profitability analysis of each bid opportunity.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Bid opportunities are pursued by a specific profit center — go/no-go decisions and pipeline revenue forecasting are reported by profit center in construction business development. A construction BD ma',
    `bid_bond_amount` DECIMAL(18,2) COMMENT 'Financial guarantee amount required to submit the bid.',
    `bid_decision` STRING COMMENT 'Decision on whether to submit a bid for the opportunity.. Valid values are `bid|no_bid`',
    `bid_due_date` DATE COMMENT 'Final date by which the bid must be submitted.',
    `country_code` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code of the project location.. Valid values are `[A-Z]{3}`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bid opportunity record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the estimated contract value.. Valid values are `[A-Z]{3}`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount applied to the estimated contract value during bid preparation.',
    `estimated_contract_value` DECIMAL(18,2) COMMENT 'Projected total contract value before any adjustments.',
    `expected_end_date` DATE COMMENT 'Planned completion date of the project if the bid is won.',
    `expected_start_date` DATE COMMENT 'Planned start date of the project if the bid is won.',
    `gmp_type` STRING COMMENT 'Type of pricing model used in the bid (e.g., Guaranteed Maximum Price).. Valid values are `gmp|lump_sum|cost_plus`',
    `is_joint_venture` BOOLEAN COMMENT 'Indicates whether the bid is being submitted as a joint venture.',
    `market_segment` STRING COMMENT 'Business segment or market category the opportunity belongs to.. Valid values are `infrastructure|energy|commercial|residential|industrial`',
    `net_estimated_value` DECIMAL(18,2) COMMENT 'Estimated contract value after discounts and adjustments.',
    `notes` STRING COMMENT 'Free‑form text for any supplemental information about the opportunity.',
    `opportunity_name` STRING COMMENT 'Descriptive name of the bid opportunity, typically reflecting the project or client.',
    `opportunity_number` STRING COMMENT 'External reference number assigned to the opportunity, used in client communications and reporting.',
    `pipeline_forecast_category` STRING COMMENT 'Classification used for forecasting and reporting of the opportunity.. Valid values are `pipeline|forecast|committed|won|lost`',
    `probability_of_win` DECIMAL(18,2) COMMENT 'Estimated likelihood of winning the opportunity expressed as a percentage.',
    `project_type` STRING COMMENT 'Classification of the project type for the opportunity.. Valid values are `highway|airport|bridge|power_plant|residential_development|commercial_building`',
    `source_channel` STRING COMMENT 'Origin channel through which the opportunity was generated.. Valid values are `salesforce|referral|partner|website|event`',
    `stage` STRING COMMENT 'Current lifecycle stage of the opportunity within the sales pipeline.. Valid values are `lead|qualified|proposal|submitted|awarded|lost`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the bid opportunity record.',
    `win_loss_status` STRING COMMENT 'Outcome of the opportunity after the bid process concludes.. Valid values are `won|lost|withdrawn|pending`',
    CONSTRAINT pk_bid_opportunity PRIMARY KEY(`bid_opportunity_id`)
) COMMENT 'Master record for each pre-award commercial opportunity tracked in Salesforce CRM. Captures the full pipeline entry from initial lead through bid submission, representing a potential project the business is pursuing. Stores opportunity name, client reference, market segment, project type, estimated contract value, probability of win, bid/no-bid decision, opportunity stage, source channel, geographic region, and pipeline forecast category. SSOT for commercial opportunity identity in the bid domain.';

CREATE OR REPLACE TABLE `construction_ecm`.`bid`.`tender` (
    `tender_id` BIGINT COMMENT 'Unique system-generated identifier for the tender record.',
    `account_id` BIGINT COMMENT 'Identifier of the client/owner for whom the tender is prepared.',
    `bid_opportunity_id` BIGINT COMMENT 'Foreign key linking to bid.bid_opportunity. Business justification: A tender is the formal submission package prepared in response to a pre-award commercial opportunity. The bid_opportunity is the master CRM record (Salesforce) that originates the tender. One bid_oppo',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Tenders are submitted by a specific legal entity — determines tax treatment, bonding capacity, and statutory financial reporting obligations. In multi-entity construction groups, the submitting compan',
    `construction_project_id` BIGINT COMMENT 'Foreign key linking to project.construction_project. Business justification: Tender management – each tender is issued for a specific construction project, needed for schedule and cost integration.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Needed for Tender Cost Tracking: associates tender expenses with a finance cost center for accurate cost reporting and compliance with internal budgeting policies.',
    `framework_agreement_id` BIGINT COMMENT 'Foreign key linking to client.client_framework_agreement. Business justification: In construction, tenders are frequently issued as call-offs under a client framework agreement with pre-agreed rates and terms. Linking tender to client_framework_agreement enables framework utilizati',
    `package_id` BIGINT COMMENT 'Foreign key linking to design.package. Business justification: Tenders are issued with a specific design package defining the scope. Named process: tender issued against design package. Construction project managers track which design package was current at ten',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Tender preparation in construction requires verification of permit status before bid submission. Bid teams must confirm that required permits (environmental, planning, building) are obtainable or in p',
    `plan_id` BIGINT COMMENT 'Foreign key linking to quality.plan. Business justification: Tender package requires a Quality Management Plan per client contract; linking ensures plan is attached to each tender.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Tenders are submitted under a profit center for margin tracking and financial reporting by business unit. Construction CFOs report tender pipeline and win rates by profit center — this link is essenti',
    `rfp_issuance_id` BIGINT COMMENT 'Foreign key linking to client.rfp_issuance. Business justification: Tenders are prepared directly against a client RFP issuance document package. This link enables direct RFP-to-tender traceability for bid pipeline reporting, addendum management, and evaluation criter',
    `schedule_baseline_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_baseline. Business justification: Tenders include a schedule baseline as a mandatory deliverable defining project duration, key milestones, and resource plan. Tender evaluators assess the schedule baseline as part of technical scoring',
    `award_decision_date` DATE COMMENT 'Date on which the client communicated the award decision.',
    `award_status` STRING COMMENT 'Final outcome status of the tender.. Valid values are `awarded|not_awarded|pending`',
    `bid_bond_amount` DECIMAL(18,2) COMMENT 'Monetary value of the required bid bond.',
    `bid_bond_expiry` DATE COMMENT 'Expiration date of the bid bond.',
    `bid_bond_required` BOOLEAN COMMENT 'Indicates whether a bid bond must be provided with the tender.',
    `bid_bond_type` STRING COMMENT 'Form of the bid bond provided.. Valid values are `bank|insurance|cash`',
    `bid_type` STRING COMMENT 'Indicates whether the tender is for a new contract, renewal, or extension.. Valid values are `new|renewal|extension`',
    `compliance_requirements_met` BOOLEAN COMMENT 'Indicates whether the tender satisfies all mandatory compliance criteria.',
    `confidentiality_flag` BOOLEAN COMMENT 'Indicates whether the tender information is marked as confidential.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tender record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts. [ENUM-REF-CANDIDATE: many currencies — promote to reference product]',
    `documents_attached` STRING COMMENT 'Number of supporting documents linked to the tender.',
    `estimated_duration_months` STRING COMMENT 'Projected duration of the project in months.',
    `estimated_value` DECIMAL(18,2) COMMENT 'Projected monetary value of the contract if the tender is won.',
    `evaluation_method` STRING COMMENT 'Methodology used by the client to evaluate the tender.. Valid values are `technical|financial|combined`',
    `evaluation_score` DECIMAL(18,2) COMMENT 'Numerical score resulting from the client’s evaluation process.',
    `is_joint_venture` BOOLEAN COMMENT 'Indicates whether the tender is submitted as a joint venture.',
    `joint_venture_partner` STRING COMMENT 'Name of the partner organization in a joint‑venture tender.',
    `notes` STRING COMMENT 'Free‑form comments or remarks related to the tender.',
    `prequalification_status` STRING COMMENT 'Result of the pre‑qualification review for the tendering entity.. Valid values are `qualified|unqualified|pending`',
    `procurement_method` STRING COMMENT 'Method used to procure the project (open, selective, limited).',
    `project_end_date` DATE COMMENT 'Planned completion date of the construction project.',
    `project_location` STRING COMMENT 'Physical location or address of the construction project.',
    `project_start_date` DATE COMMENT 'Planned start date of the construction project.',
    `project_title` STRING COMMENT 'Descriptive title of the construction project associated with the tender.',
    `region_code` STRING COMMENT 'Three‑letter ISO region code for the project location. [ENUM-REF-CANDIDATE: many regions — promote to reference product]',
    `regulatory_approval_required` BOOLEAN COMMENT 'Flag indicating if external regulatory approval is needed for the tender.',
    `regulatory_approval_status` STRING COMMENT 'Current status of any required regulatory approval.. Valid values are `pending|approved|rejected`',
    `risk_rating` STRING COMMENT 'Risk assessment rating assigned to the tender.. Valid values are `low|medium|high|critical`',
    `submission_date` DATE COMMENT 'Actual date the tender was submitted to the client.',
    `submission_deadline` DATE COMMENT 'Last calendar date by which the tender must be submitted.',
    `submission_status` STRING COMMENT 'Current lifecycle status of the tender submission.. Valid values are `draft|submitted|withdrawn|awarded|rejected`',
    `tender_number` STRING COMMENT 'External reference number assigned to the tender by the organization.',
    `tender_type` STRING COMMENT 'Classification of the tender contract model.. Valid values are `lump_sum|gmp|unit_rate|epc|design_build|dbb`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tender record.',
    `validity_end` DATE COMMENT 'Date when the tender expires if not awarded.',
    `validity_start` DATE COMMENT 'Date when the tender becomes officially valid for consideration.',
    CONSTRAINT pk_tender PRIMARY KEY(`tender_id`)
) COMMENT 'Master record representing a formal tender submission package prepared in response to an RFP or RFQ. Captures tender reference number, project title, client/owner identity, tender type (lump-sum, GMP, unit-rate, EPC), submission deadline, tender validity period, submission status, bid bond requirement flag, prequalification status, and the lead estimator assigned. Links to the parent opportunity and the resulting contract upon award. SSOT for tender identity and submission lifecycle.';

CREATE OR REPLACE TABLE `construction_ecm`.`bid`.`estimate` (
    `estimate_id` BIGINT COMMENT 'Unique system-generated identifier for the cost estimate record.',
    `account_id` BIGINT COMMENT 'Identifier of the client or owner for whom the estimate is prepared.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Estimates are prepared for a specific legal entity — affects overhead rate application, tax treatment, and profit margin targets set by company code. Construction estimating standards and overhead rec',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project to which this estimate belongs.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Ensures estimate preparation costs are charged to the appropriate finance cost center, supporting cost control and variance analysis between estimated and actual costs.',
    `env_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.env_impact_assessment. Business justification: Cost estimate incorporates mitigation measures identified in the environmental impact assessment.',
    `labor_cost_code_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_cost_code. Business justification: During bid preparation, estimators apply labor cost codes to estimates to drive burden rates, overtime multipliers, and prevailing wage classifications in the cost buildup. Construction estimators alw',
    `package_id` BIGINT COMMENT 'Foreign key linking to design.package. Business justification: Estimates are prepared against a specific design package (IFC or tender issue package). Named process: package-based estimating. Construction estimators must know which design package revision their',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Construction estimates must include permit fees, compliance costs, and permit-driven scope constraints. Estimators reference specific permits to price compliance line items accurately. This link suppo',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Estimates are prepared per project phase in phased delivery (FEED, detailed design, construction). Construction estimators produce phase-specific cost estimates for gate approvals. This link enables p',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Estimates are prepared within a profit center context for margin analysis and overhead rate application. Construction estimating departments are organized by profit center, and overhead/profit targets',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Infrastructure and energy construction estimates must price regulatory compliance costs (environmental mitigation, local content, safety programs). Linking estimate to regulatory_obligation allows est',
    `schedule_baseline_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_baseline. Business justification: Estimates are built against a specific schedule baseline — durations, resource loading, and productivity assumptions in the baseline directly drive labor hours and cost. Estimators must reference the ',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Estimates are priced against technical specifications — material grades, workmanship standards, and testing requirements directly drive cost. Named process: specification-based cost estimation. Cons',
    `tender_id` BIGINT COMMENT 'Foreign key linking to bid.tender. Business justification: An estimate is the project cost estimate prepared during the bid phase. It is directly associated with a tender submission — the estimate forms the cost basis for the tenders bid price. One tender ca',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the estimate was formally approved for submission.',
    `base_pricing_date` DATE COMMENT 'Date on which the unit rates and cost data were sourced for the estimate.',
    `contingency_percentage` DECIMAL(18,2) COMMENT 'Percentage added to cover unknowns and risks in the estimate.',
    `cost_breakdown_version` STRING COMMENT 'Version identifier for the detailed cost breakdown structure used in the estimate.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the estimate record was first entered into the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the estimate.',
    `document_reference` STRING COMMENT 'Identifier or path to the electronic document containing the full estimate details.',
    `escalation_allowance` DECIMAL(18,2) COMMENT 'Allowance expressed as a percentage to account for price escalation over time.',
    `estimate_category` STRING COMMENT 'Business category indicating the nature of the work the estimate covers.. Valid values are `new_work|renovation|maintenance|expansion|demolition`',
    `estimate_name` STRING COMMENT 'Human‑readable name or title of the estimate for easy identification.',
    `estimate_number` STRING COMMENT 'External reference number assigned to the estimate, used in bid documentation and communications.',
    `estimate_status` STRING COMMENT 'Current lifecycle status of the estimate within the bid process.. Valid values are `draft|submitted|approved|rejected|withdrawn`',
    `estimate_type` STRING COMMENT 'Classification of the estimate based on its level of detail and development stage.. Valid values are `conceptual|schematic|detailed|definitive|preliminary`',
    `estimating_method` STRING COMMENT 'Methodology used to develop the cost estimate.. Valid values are `parametric|unit_rate|first_principles|analogous`',
    `expiration_date` DATE COMMENT 'Date after which the estimate is no longer valid for bid submission.',
    `is_gmp` BOOLEAN COMMENT 'Indicates whether the estimate is prepared as a GMP (True) or not (False).',
    `is_locked` BOOLEAN COMMENT 'True when the estimate is locked from further edits after approval.',
    `is_lump_sum` BOOLEAN COMMENT 'True if the estimate is a lump‑sum price; otherwise False.',
    `notes` STRING COMMENT 'Free‑form comments or remarks added by the estimator.',
    `overhead_percentage` DECIMAL(18,2) COMMENT 'Overhead cost expressed as a percentage of direct costs.',
    `profit_margin_percentage` DECIMAL(18,2) COMMENT 'Desired profit margin expressed as a percentage of total cost.',
    `revision_date` DATE COMMENT 'Date when the current revision of the estimate was created.',
    `revision_number` STRING COMMENT 'Sequential number indicating the version of the estimate.',
    `risk_factor` DECIMAL(18,2) COMMENT 'Numeric factor representing the overall risk level applied to the estimate.',
    `schedule_impact_days` STRING COMMENT 'Estimated impact on project schedule expressed in days if the estimate is accepted.',
    `source_system` STRING COMMENT 'Name of the source application that originated the estimate record (e.g., SAP S/4HANA, Procore).',
    `total_estimated_cost` DECIMAL(18,2) COMMENT 'Aggregated cost of the estimate before taxes, including all cost components.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the estimate record.',
    CONSTRAINT pk_estimate PRIMARY KEY(`estimate_id`)
) COMMENT 'Master record for a project cost estimate prepared during the bid phase. Captures estimate number, estimate type (conceptual, schematic, detailed, definitive), base date of pricing, total estimated cost, contingency percentage, escalation allowance, overhead and profit margin, currency, estimate status, and the estimating method used (parametric, unit-rate, first-principles). Supports multiple estimate revisions per tender. SSOT for pre-award cost estimation data.';

CREATE OR REPLACE TABLE `construction_ecm`.`bid`.`boq` (
    `boq_id` BIGINT COMMENT 'System‑generated unique identifier for each BOQ master record.',
    `bim_model_id` BIGINT COMMENT 'Foreign key linking to design.bim_model. Business justification: Required for Quantity Takeoff: BOQ creation uses BIM model geometry to derive quantities; the BOQ must reference the BIM model used.',
    `construction_project_id` BIGINT COMMENT 'Foreign‑key hint referencing the overarching construction project for which the BOQ is prepared.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Links BOQ preparation to a finance cost center, enabling detailed cost center reporting for bill of quantities and supporting budget approvals.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Required for Quantity Takeoff: BOQ lines are derived from construction drawings; linking each BOQ to its source drawing enables traceability.',
    `estimate_id` BIGINT COMMENT 'Foreign key linking to bid.estimate. Business justification: A Bill of Quantities (BOQ) is the structured pricing document attached to a tender, while an estimate is the internal cost build-up. In construction bid practice, the BOQ is typically prepared from or',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: BOQ preparation references technical specifications for measurement rules, material standards, and CSI division alignment. Estimators link each BOQ to the governing spec. specification_standard is a',
    `tender_id` BIGINT COMMENT 'Foreign‑key hint linking the BOQ to the tender (project bid) it supports.',
    `wbs_node_id` BIGINT COMMENT 'Foreign key linking to schedule.wbs_node. Business justification: BOQ sections are mapped to WBS nodes for cost-schedule integration and earned value management — quantity surveyors structure the BOQ against the project WBS to enable BCWP/BCWS calculations. boq has ',
    `approval_date` DATE COMMENT 'Calendar date on which the BOQ was signed off by the project controls authority.',
    `approved_by` STRING COMMENT 'Identifier of the individual who granted final approval to the BOQ.',
    `boq_description` STRING COMMENT 'Narrative field for additional context, special instructions, or remarks from the estimator.',
    `boq_status` STRING COMMENT 'Indicates whether the BOQ is still being edited, has been issued to bidders, approved, revised, or archived.. Valid values are `draft|issued|approved|revised|archived`',
    `boq_type` STRING COMMENT 'Classifies the BOQ as measured (based on take‑off), provisional (estimated), or approximate (high‑level).. Valid values are `measured|provisional|approximate`',
    `contains_confidential_pricing` BOOLEAN COMMENT 'True if the BOQ includes pricing that must be treated as confidential per contract and regulatory policy.',
    `created_timestamp` TIMESTAMP COMMENT 'Exact date‑time the BOQ master record entered the data lake.',
    `currency` STRING COMMENT 'Three‑letter currency identifier (e.g., USD, EUR) used for the total_value field.. Valid values are `^[A-Z]{3}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert the BOQ total_value to the companys reporting currency.',
    `exchange_rate_date` DATE COMMENT 'Effective date for the exchange_rate value.',
    `expiry_date` DATE COMMENT 'Optional end‑date after which the BOQ cannot be used for pricing; null if open‑ended.',
    `issue_date` DATE COMMENT 'Date the BOQ was released to bidders as part of the tender package.',
    `preparation_date` DATE COMMENT 'Calendar date on which the BOQ document was initially compiled.',
    `reference` STRING COMMENT 'Human‑readable code used to identify the BOQ within the tender package.',
    `revision_number` STRING COMMENT 'Incremental integer indicating the version of the BOQ; higher numbers represent later revisions.',
    `source_system` STRING COMMENT 'Indicates which operational system of record supplied the BOQ data.. Valid values are `Procore|SAP S/4HANA|Autodesk BIM 360|Viewpoint Vista`',
    `total_quantity` DECIMAL(18,2) COMMENT 'Aggregate of the quantity field from all BOQ line items, expressed in the unit defined by the specification standard.',
    `total_value` DECIMAL(18,2) COMMENT 'Aggregate price of all line items in the BOQ, expressed in the selected currency.',
    `updated_by` STRING COMMENT 'Login or employee identifier of the last person to modify the BOQ.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to any BOQ field.',
    `version_label` STRING COMMENT 'Human‑readable version identifier shown on the BOQ cover page.',
    `created_by` STRING COMMENT 'Login or employee identifier of the estimator who initially created the BOQ.',
    CONSTRAINT pk_boq PRIMARY KEY(`boq_id`)
) COMMENT 'Bill of Quantities master record defining the structured pricing document attached to a tender. Captures BOQ reference, revision number, BOQ type (measured, provisional, approximate), total BOQ value, currency, preparation date, and the specification standard applied (NRM, POMI, CESMM). Each BOQ is linked to a tender and decomposed into BOQ line items. SSOT for BOQ document identity and header-level pricing data.';

CREATE OR REPLACE TABLE `construction_ecm`.`bid`.`bid_boq_line` (
    `bid_boq_line_id` BIGINT COMMENT 'Unique identifier for the BOQ line item.',
    `asset_category_id` BIGINT COMMENT 'Foreign key linking to equipment.asset_category. Business justification: BOQ plant cost quantification: quantity surveyors classify plant cost BOQ lines by equipment category to apply standard hire rates and benchmark against market rates. Linking bid_boq_line to asset_cat',
    `boq_id` BIGINT COMMENT 'Identifier of the parent BOQ header.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: BOQ lines are allocated to cost centers for budget control and cost reporting. The plain `cost_center_code` on bid_boq_line is a denormalization of finance.cost_center. Construction cost controllers r',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: BOQ lines must be classified against cost codes for budget commitment and cost control reporting. In construction, every BOQ line item maps to a cost code to enable bid-to-budget reconciliation and ea',
    `labor_cost_code_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_cost_code. Business justification: BOQ line items include a labour_cost component requiring a labor cost code for burden rate application, prevailing wage compliance, and cost code alignment between bid BOQ and project cost control. St',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Each BOQ line item is priced against a specification section (CSI division/work section). Named process: specification-referenced BOQ line pricing. work_section is a denormalized text field replac',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: During project execution, BOQ lines are mapped to WBS elements for cost control and EVM. Construction cost engineers routinely reconcile BOQ quantities against WBS actuals for payment certification an',
    `actual_completion_date` DATE COMMENT 'Date when the work was actually completed.',
    `bid_boq_line_description` STRING COMMENT 'Detailed textual description of the work item.',
    `bid_boq_line_status` STRING COMMENT 'Current lifecycle status of the BOQ line.. Valid values are `draft|submitted|approved|rejected|cancelled`',
    `change_order_flag` BOOLEAN COMMENT 'Indicates if the line originated from a change order.',
    `change_order_number` STRING COMMENT 'Reference number of the associated change order, if any.',
    `cost_category` STRING COMMENT 'Classification of cost type for budgeting and reporting.. Valid values are `direct|indirect|overhead|contingency`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the line record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `estimated_completion_date` DATE COMMENT 'Planned date for completing the work represented by the line.',
    `is_critical_path` BOOLEAN COMMENT 'Marks the line as part of the project critical path.',
    `is_gmp_applicable` BOOLEAN COMMENT 'Indicates if the line is included in a Guaranteed Maximum Price bid.',
    `is_lump_sum` BOOLEAN COMMENT 'Indicates if the line is part of a lump‑sum bid component.',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether the line item is subject to tax.',
    `item_code` STRING COMMENT 'Standardized code for the work item as defined in the companys catalog.',
    `labour_cost` DECIMAL(18,2) COMMENT 'Cost component attributable to labour for the line item.',
    `line_sequence` STRING COMMENT 'Sequential order of the line within the BOQ.',
    `material_cost` DECIMAL(18,2) COMMENT 'Cost component attributable to materials.',
    `notes` STRING COMMENT 'Free‑text field for additional remarks or clarifications.',
    `overhead_amount` DECIMAL(18,2) COMMENT 'Allocated overhead amount for the line item.',
    `plant_cost` DECIMAL(18,2) COMMENT 'Cost component attributable to plant/equipment usage.',
    `profit_margin_percent` DECIMAL(18,2) COMMENT 'Target profit margin percentage applied to the line.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of the item required as per take‑off.',
    `revision_number` STRING COMMENT 'Version number of the line item after changes.',
    `risk_level` STRING COMMENT 'Risk classification for the line item.. Valid values are `low|medium|high`',
    `source_system` STRING COMMENT 'System of record from which the line originated (e.g., Procore, SAP).',
    `subcontract_cost` DECIMAL(18,2) COMMENT 'Cost component attributable to subcontracted work.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Calculated tax amount for the line item.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate percentage for taxable items.',
    `total_amount` DECIMAL(18,2) COMMENT 'Calculated total cost for the line (quantity × unit_rate).',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity (e.g., meter, kilogram, piece). [ENUM-REF-CANDIDATE: unit|kg|m|m2|m3|l|pcs|hr — 8 candidates stripped; promote to reference product]',
    `unit_rate` DECIMAL(18,2) COMMENT 'Price per unit of measure for the item.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the line record.',
    CONSTRAINT pk_bid_boq_line PRIMARY KEY(`bid_boq_line_id`)
) COMMENT 'Individual line item within a Bill of Quantities, representing a discrete work item priced during bid preparation. Captures item code, WBS reference, work section, item description, unit of measure, quantity, unit rate, total amount, labour component, plant component, material component, subcontract component, and overhead allocation. Supports MTO-driven quantity take-off and rate build-up analysis. Essential for bid-to-actual cost variance tracking post-award.';

CREATE OR REPLACE TABLE `construction_ecm`.`bid`.`estimate_line` (
    `estimate_line_id` BIGINT COMMENT 'Unique identifier for the estimate line item.',
    `asset_category_id` BIGINT COMMENT 'Foreign key linking to equipment.asset_category. Business justification: Category-level equipment estimating: estimators price plant costs by equipment category (e.g., crawler crane 100T) before specific assets are assigned. estimate_line already has asset_id for specifi',
    `asset_id` BIGINT COMMENT 'Identifier of plant/equipment associated with the line.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project to which the estimate belongs.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Estimate lines are allocated to cost centers for budget planning and cost control. The plain `cost_center_code` on estimate_line is a denormalization of finance.cost_center. Construction estimators as',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Estimate lines are classified by cost code for estimate-vs-actual variance reporting — a core construction cost control process. The plain `cost_code` string on estimate_line is a denormalization of f',
    `estimate_id` BIGINT COMMENT 'Identifier of the parent estimate (transaction header) to which this line belongs.',
    `labor_cost_code_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_cost_code. Business justification: Each labor estimate line must reference a labor cost code to apply the correct burden rate, prevailing wage classification, and overtime multiplier. This is standard construction estimating practice —',
    `labor_rate_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_rate. Business justification: Each estimate line may apply a specific labor rate; linking to workforce.labor_rate enables precise labor cost per line in bid estimates.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: REQUIRED: Estimating uses master material data for unit pricing, compliance and spec reference, essential for accurate bid cost calculations.',
    `resource_id` BIGINT COMMENT 'Identifier of the resource (item, equipment, labour) associated with this line.',
    `skill_trade_id` BIGINT COMMENT 'Foreign key linking to workforce.skill_trade. Business justification: Labor estimate lines are built by trade (ironworker, electrician, pipefitter). Linking to skill_trade enables productivity factor lookup, standard crew size, and prevailing wage classification during ',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Estimate lines are mapped to WBS elements to build the project cost structure during estimating and for post-award cost baseline reconciliation. Construction estimators and cost controllers depend on ',
    `approval_date` TIMESTAMP COMMENT 'Timestamp when the line was approved.',
    `approved_by` STRING COMMENT 'User identifier of the person who approved the line.',
    `baseline_cost` DECIMAL(18,2) COMMENT 'Original cost captured at baseline creation.',
    `change_order_number` STRING COMMENT 'Reference to a change order that modified this line.',
    `cost_category` STRING COMMENT 'Category of cost represented by the line (e.g., labour, material).. Valid values are `labour|material|plant|subcontract|indirect`',
    `cost_variance` DECIMAL(18,2) COMMENT 'Difference between revised and baseline cost.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the estimate line was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.',
    `estimate_line_status` STRING COMMENT 'Current lifecycle status of the estimate line.. Valid values are `draft|submitted|approved|rejected|archived`',
    `estimate_version` STRING COMMENT 'Version identifier of the estimate containing this line.',
    `is_deleted` BOOLEAN COMMENT 'Indicates whether the line has been soft‑deleted.',
    `labor_rate_type` STRING COMMENT 'Basis for labour cost calculation.. Valid values are `hourly|daily|weekly`',
    `line_sequence` STRING COMMENT 'Sequential order of the line within the estimate.',
    `location_code` STRING COMMENT 'Code representing the site or geographic location for the line.',
    `material_type` STRING COMMENT 'Classification of material used for the line.. Valid values are `raw|prefab|recycled|other`',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the line.',
    `productivity_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to account for expected productivity (e.g., 1.05).',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of the resource required.',
    `resource_description` STRING COMMENT 'Human‑readable description of the resource.',
    `retention_status` STRING COMMENT 'Retention state of the line for contractual hold‑backs.. Valid values are `retained|released|pending`',
    `revised_cost` DECIMAL(18,2) COMMENT 'Cost after revisions or updates.',
    `risk_factor` DECIMAL(18,2) COMMENT 'Multiplier reflecting risk or contingency applied to the line.',
    `source_of_rate` DECIMAL(18,2) COMMENT 'Origin of the unit cost used for this line.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Monetary tax amount calculated for the line.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate percentage for the line.',
    `total_cost` DECIMAL(18,2) COMMENT 'Calculated total cost (quantity × unit cost) before adjustments.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of the resource in the selected currency.',
    `unit_of_measure` STRING COMMENT 'Unit used for the quantity (e.g., meters, kilograms).. Valid values are `m|kg|m2|m3|hour|unit`',
    `updated_by` STRING COMMENT 'User identifier who last modified the line.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the line.',
    `variance_reason` STRING COMMENT 'Explanation for the cost variance.',
    `waste_factor` DECIMAL(18,2) COMMENT 'Multiplier to include anticipated material waste.',
    `created_by` STRING COMMENT 'User identifier who created the line.',
    CONSTRAINT pk_estimate_line PRIMARY KEY(`estimate_line_id`)
) COMMENT 'Detailed cost line item within a project estimate, capturing the granular cost build-up for a specific work package or activity. Stores cost code, WBS element, cost category (labour, material, plant, subcontract, indirect), resource description, quantity, unit, unit cost, total cost, productivity factor, waste factor, and source of rate (historical, vendor quote, published index). Enables detailed cost-to-complete analysis and estimate benchmarking.';

CREATE OR REPLACE TABLE `construction_ecm`.`bid`.`submission` (
    `submission_id` BIGINT COMMENT 'Unique identifier for the bid submission event.',
    `account_id` BIGINT COMMENT 'Identifier of the client/owner of the tender.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Bid submissions represent financial commitments by a specific legal entity — bonding, insurance, and financial capacity representations in the submission are made on behalf of a company code. Required',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Assigns a cost center to bid submission expenses, required for post‑submission cost tracking and audit of bid‑related spend.',
    `package_id` BIGINT COMMENT 'Foreign key linking to design.package. Business justification: Tender submissions are made against a specific design package issue. Named process: design package-based tender submission. Construction procurement teams must record which design package revision t',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Bid Submission Compliance Checklist requires attaching the required permit; ensures bid proceeds only when permit is secured.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Bid submissions are tracked against profit centers for win/loss margin analysis by business unit. Construction finance teams produce win-rate and margin-at-award reports by profit center — this FK ena',
    `rfp_issuance_id` BIGINT COMMENT 'Foreign key linking to client.rfp_issuance. Business justification: A submission is the contractors formal response to a specific RFP issuance. Linking submission to rfp_issuance enables submission deadline compliance tracking, bid/no-bid analysis per RFP, and addend',
    `tender_id` BIGINT COMMENT 'Foreign key linking to bid.tender. Business justification: A submission is the transactional record of the formal act of submitting a tender to a client. It belongs to exactly one tender. One tender can have multiple submissions (e.g., initial submission, rev',
    `acknowledgement_reference` STRING COMMENT 'Reference number received from the client confirming receipt.',
    `bid_bond_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the bid bond required for this submission.',
    `bid_bond_expiry` DATE COMMENT 'Expiration date of the bid bond.',
    `bid_bond_type` STRING COMMENT 'Type of bid bond provided.. Valid values are `performance|payment|security|none`',
    `bid_price` DECIMAL(18,2) COMMENT 'Total monetary amount offered in the bid at submission.',
    `bid_price_adjustment` DECIMAL(18,2) COMMENT 'Any adjustment (e.g., discount, fee) applied to the base bid price.',
    `bid_type` STRING COMMENT 'Contractual pricing structure of the bid.. Valid values are `lump_sum|gmp|unit_price|cost_plus`',
    `commercial_score` DECIMAL(18,2) COMMENT 'Score assigned to the commercial portion of the bid.',
    `compliance_requirements_met` BOOLEAN COMMENT 'True if all mandatory compliance items were satisfied.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bid submission record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the bid price.',
    `deadline` DATE COMMENT 'Official deadline date for the tender submission.',
    `documents_attached_count` STRING COMMENT 'Number of supporting documents attached to the submission.',
    `estimated_duration_months` STRING COMMENT 'Projected duration of the project in months as estimated in the bid.',
    `evaluation_method` STRING COMMENT 'Method used to evaluate the bid (e.g., two‑envelope).. Valid values are `two_envelope|single_envelope`',
    `is_joint_venture` BOOLEAN COMMENT 'True if the bid is submitted as a joint venture.',
    `late_submission_flag` BOOLEAN COMMENT 'True if the submission was received after the deadline.',
    `notes` STRING COMMENT 'Free‑form notes entered by the submitter at time of submission.',
    `number_of_copies` STRING COMMENT 'Count of physical copies submitted, if applicable.',
    `project_location` STRING COMMENT 'Free‑form description of the project site location.',
    `reference_number` STRING COMMENT 'External reference number assigned to the bid submission.',
    `region_code` STRING COMMENT 'Three‑letter code representing the geographic region of the project.',
    `risk_rating` STRING COMMENT 'Risk rating assigned to the bid based on evaluation criteria.. Valid values are `low|medium|high`',
    `submission_method` STRING COMMENT 'Method used to deliver the bid submission.. Valid values are `electronic|hard_copy|email`',
    `submission_status` STRING COMMENT 'Current lifecycle status of the bid submission.. Valid values are `draft|submitted|acknowledged|rejected|awarded|cancelled`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the bid was formally submitted.',
    `technical_score` DECIMAL(18,2) COMMENT 'Score assigned to the technical portion of the bid (if two‑envelope).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the bid submission record.',
    CONSTRAINT pk_submission PRIMARY KEY(`submission_id`)
) COMMENT 'Transactional record capturing the formal act of submitting a tender to a client or owner. Records submission timestamp, submission method (electronic portal, hard copy, email), submitted by (person), submission reference number, number of copies submitted, bid price at submission, technical score (if two-envelope), commercial score, submission acknowledgement reference, and late submission flag. Represents the definitive bid submission event for audit and compliance purposes.';

CREATE OR REPLACE TABLE `construction_ecm`.`bid`.`clarification` (
    `clarification_id` BIGINT COMMENT 'System-generated unique identifier for each bid clarification record.',
    `boq_id` BIGINT COMMENT 'Foreign key linking to bid.boq. Business justification: The clarification entity has an explicit impact_flag_boq boolean attribute indicating that a clarification impacts the Bill of Quantities. When this flag is true, the clarification should reference th',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Clarifications with financial impact (impact_amount, impact_flag_price) must be classified by cost code to update the estimate and BOQ. Construction estimators reclassify clarification impacts against',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Tender clarifications frequently concern permit status — bidders ask whether environmental or planning permits are secured before pricing. Linking clarification to compliance_permit allows bid teams t',
    `rfi_id` BIGINT COMMENT 'Foreign key linking to design.rfi. Business justification: Bid clarifications often arise from RFIs; linking a clarification to its originating RFI tracks the source of the question.',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Tender clarifications frequently challenge or seek interpretation of specific specification sections. Named business process: specification clarification during tender. Construction procurement team',
    `tender_id` BIGINT COMMENT 'Foreign key linking to bid.tender. Business justification: Clarifications are formal tender-period communications (RFIs, addenda, scope clarifications) that occur within the context of a specific tender. A clarification belongs to one tender; one tender can h',
    `acknowledgement_status` STRING COMMENT 'Indicates whether the recipient has formally acknowledged receipt.. Valid values are `acknowledged|not_acknowledged`',
    `addendum_number` STRING COMMENT 'Identifier of the addendum referenced, if the communication is an addendum or amendment.',
    `attachment_flag` BOOLEAN COMMENT 'True if supporting files are attached to the clarification.',
    `bid_revision_triggered` BOOLEAN COMMENT 'Indicates whether the clarification caused a formal bid revision.',
    `clarification_number` STRING COMMENT 'External reference number assigned to the clarification by the tendering authority.',
    `clarification_status` STRING COMMENT 'Current lifecycle status of the clarification.. Valid values are `open|answered|closed|incorporated`',
    `communication_type` STRING COMMENT 'Category of the communication exchanged during the tender period.. Valid values are `RFI_issued|RFI_received|addendum|amendment|clarification`',
    `content` STRING COMMENT 'Full text of the original communication request or notice.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the clarification record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the impact amount.',
    `direction` STRING COMMENT 'Indicates whether the communication originated from the client or the contractor.. Valid values are `client_to_contractor|contractor_to_client`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the communication was originally issued.',
    `impact_amount` DECIMAL(18,2) COMMENT 'Estimated monetary impact of the clarification on the bid.',
    `impact_description` STRING COMMENT 'Narrative description of how the clarification affects bid parameters.',
    `impact_flag_boq` BOOLEAN COMMENT 'True if the clarification affects the Bill of Quantities.',
    `impact_flag_price` BOOLEAN COMMENT 'True if the clarification alters the bid price.',
    `impact_flag_schedule` BOOLEAN COMMENT 'True if the clarification changes the project schedule.',
    `impact_flag_scope` BOOLEAN COMMENT 'True if the clarification modifies the project scope.',
    `impact_flag_specifications` BOOLEAN COMMENT 'True if the clarification changes technical specifications or drawings.',
    `is_critical` BOOLEAN COMMENT 'Marks the clarification as critical to bid success.',
    `issuing_authority` STRING COMMENT 'Entity that issued the communication (e.g., client, architect, engineer).',
    `notes` STRING COMMENT 'Free‑form notes or comments added by users.',
    `response_content` STRING COMMENT 'Full text of the response provided to the communication.',
    `response_deadline` DATE COMMENT 'Date by which the recipient must respond to the communication.',
    `response_status` STRING COMMENT 'Current status of the response process.. Valid values are `pending|provided|overdue`',
    `response_timestamp` TIMESTAMP COMMENT 'Date and time when the response was received or recorded.',
    `revised_submission_deadline` DATE COMMENT 'New deadline for bid submission if the clarification triggers a deadline change.',
    `revision_number` STRING COMMENT 'Sequential revision count for the clarification record.',
    `source_system` STRING COMMENT 'Originating source system (e.g., Procore, Aconex).',
    `subject` STRING COMMENT 'Brief summary of the communication subject.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the clarification record.',
    CONSTRAINT pk_clarification PRIMARY KEY(`clarification_id`)
) COMMENT 'Record of all formal tender-period communications and document modifications including RFIs (Requests for Information), clarifications, client-issued addenda, and amendments that modify the RFP/RFQ documents. Captures communication reference, type (RFI_issued, RFI_received, addendum, amendment, clarification), direction, addendum number (where applicable), issuing authority, subject, content, response, impact flags (bid price, schedule, scope, BOQ, specifications, drawings), revised submission deadline (if applicable), acknowledgement status, bid revision triggered, and status (open, answered, closed, incorporated). SSOT for all tender-period correspondence, addenda tracking, and document amendment audit trail ensuring tender compliance.';

CREATE OR REPLACE TABLE `construction_ecm`.`bid`.`bond` (
    `bond_id` BIGINT COMMENT 'Unique identifier for the bid bond record.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project associated with the bid.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Maps bid bond liability to a GL account for proper accounting entry, essential for financial statements and bond guarantee reporting.',
    `tender_id` BIGINT COMMENT 'Reference to the tender to which this bid bond is attached.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value of the bid bond.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the bid bond.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the bid bond was formally approved by the authorized authority.',
    `beneficiary` STRING COMMENT 'Client or project owner that is the beneficiary of the bid bond.',
    `bond_number` STRING COMMENT 'External reference number assigned to the bid bond by the issuing entity.',
    `bond_status` STRING COMMENT 'Current lifecycle status of the bid bond.. Valid values are `issued|submitted|returned|forfeited|extended`',
    `bond_type` STRING COMMENT 'Classification of the bond instrument (e.g., bank guarantee, surety bond, insurance bond).. Valid values are `bank_guarantee|surety_bond|insurance_bond`',
    `compliance_requirements_met` BOOLEAN COMMENT 'True if the bond satisfies all regulatory and client‑specific compliance requirements.',
    `confidentiality_flag` BOOLEAN COMMENT 'Indicates whether the bond details are marked as confidential for internal handling.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bid bond record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which the bond amount is expressed.',
    `documents_attached` BOOLEAN COMMENT 'Indicates whether supporting bond documents have been attached to the record.',
    `expiry_date` DATE COMMENT 'Date the bid bond expires or must be returned.',
    `expiry_place` STRING COMMENT 'Geographic location where the bond is to be returned or expires.',
    `extension_count` STRING COMMENT 'Total count of times the bond expiry has been extended.',
    `guarantee_extension_allowed` BOOLEAN COMMENT 'Indicates whether the bond terms permit extensions.',
    `guarantee_extension_reason` STRING COMMENT 'Reason provided for the most recent bond extension.',
    `issue_date` DATE COMMENT 'Date the bid bond was formally issued.',
    `issue_place` STRING COMMENT 'Geographic location (city/country) where the bond was issued.',
    `issuer_type` STRING COMMENT 'Category of the issuing entity: bank, surety, or insurance.. Valid values are `bank|surety|insurance`',
    `issuing_entity` STRING COMMENT 'Name of the bank, surety, or insurance company that issued the bid bond.',
    `last_extension_date` DATE COMMENT 'Date of the most recent expiry extension.',
    `last_updated_by` STRING COMMENT 'User identifier who performed the most recent update to the record.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the bid bond.',
    `percentage` DECIMAL(18,2) COMMENT 'Bond amount expressed as a percentage of the total tender value.',
    `risk_rating` STRING COMMENT 'Risk assessment rating assigned to the bond based on financial and contractual factors.. Valid values are `low|medium|high`',
    `source_system` STRING COMMENT 'Name of the source operational system that supplied the bond data (e.g., SAP, Procore).',
    `status_date` DATE COMMENT 'Date on which the current status became effective.',
    `total_extension_days` STRING COMMENT 'Cumulative number of days added to the original expiry date through extensions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the bid bond record.',
    CONSTRAINT pk_bond PRIMARY KEY(`bond_id`)
) COMMENT 'Master record for a bid bond (tender guarantee) instrument required as part of a tender submission. Captures bond reference number, issuing bank or surety, bond amount, bond currency, bond percentage of tender value, issue date, expiry date, bond type (bank guarantee, surety bond, insurance bond), beneficiary (client), bond status (issued, submitted, returned, forfeited, extended), and extension history. Tracks bond lifecycle from issuance through return or forfeiture.';

CREATE OR REPLACE TABLE `construction_ecm`.`bid`.`risk` (
    `risk_id` BIGINT COMMENT 'System-generated unique identifier for the bid risk record.',
    `construction_project_id` BIGINT COMMENT 'Foreign key linking to project.construction_project. Business justification: Risk register – risks identified in a bid are tracked against the associated construction project for integrated risk management.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Bid risks with contingency_amount must be classified by cost code for contingency budget allocation and risk-adjusted cost reporting. Construction risk managers assign cost codes to quantified risks t',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Risk register links each risk to a specific permit condition that may trigger compliance penalties.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Bid risks in construction are frequently driven by regulatory obligations — new environmental regulations, safety mandates, or local content requirements create cost and schedule risk. Linking bid_ris',
    `tender_id` BIGINT COMMENT 'Identifier of the tender associated with the risk.',
    `assessment_method` STRING COMMENT 'Methodology used to evaluate the risk.. Valid values are `qualitative|quantitative|mixed`',
    `attached_documents` STRING COMMENT 'Comma‑separated list of document identifiers linked to the risk.',
    `bid_risk_status` STRING COMMENT 'Current lifecycle state of the risk.. Valid values are `identified|mitigated|closed|monitoring`',
    `closed_date` DATE COMMENT 'Date the risk was formally closed.',
    `contingency_amount` DECIMAL(18,2) COMMENT 'Financial reserve allocated to cover the risk in the bid price.',
    `contingency_percentage` DECIMAL(18,2) COMMENT 'Contingency expressed as a percentage of the estimated cost impact.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk record was created in the system.',
    `exposure_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary impact fields.',
    `identified_date` DATE COMMENT 'Date the risk was first recorded.',
    `impact_cost` DECIMAL(18,2) COMMENT 'Estimated monetary impact if the risk materialises, expressed in the project currency.',
    `impact_quality` STRING COMMENT 'Qualitative effect of the risk on project quality standards.. Valid values are `low|medium|high`',
    `impact_schedule_days` STRING COMMENT 'Estimated schedule delay in days caused by the risk.',
    `is_key_risk` BOOLEAN COMMENT 'Flag indicating whether the risk is considered a key risk for the bid.',
    `mitigation_end_date` DATE COMMENT 'Planned or actual completion date for mitigation.',
    `mitigation_start_date` DATE COMMENT 'Planned start date for mitigation activities.',
    `mitigation_strategy` STRING COMMENT 'Planned actions to reduce probability or impact of the risk.',
    `notes` STRING COMMENT 'Free‑form notes or comments added by risk owners.',
    `origin` STRING COMMENT 'Origin of the risk, indicating whether it arises from internal processes or external factors.. Valid values are `internal|external`',
    `priority` STRING COMMENT 'Prioritisation level used for reporting and escalation.. Valid values are `low|medium|high|critical`',
    `probability_rating` STRING COMMENT 'Likelihood of the risk occurring, expressed as a qualitative rating.. Valid values are `low|medium|high`',
    `residual_impact_cost` DECIMAL(18,2) COMMENT 'Estimated monetary impact remaining after mitigation.',
    `residual_probability` STRING COMMENT 'Likelihood of the risk after mitigation actions are applied.. Valid values are `low|medium|high`',
    `residual_risk_score` DECIMAL(18,2) COMMENT 'Risk score after mitigation, used for ongoing monitoring.',
    `review_frequency` STRING COMMENT 'How often the risk is reviewed and re‑assessed.. Valid values are `weekly|monthly|quarterly|ad_hoc`',
    `risk_category` STRING COMMENT 'Primary classification of the risk affecting the bid phase.. Valid values are `commercial|technical|geotechnical|regulatory|supply_chain|force_majeure`',
    `risk_code` STRING COMMENT 'External reference code used by project teams to identify the risk in reports and documents.',
    `risk_description` STRING COMMENT 'Detailed narrative describing the nature, cause and potential consequences of the risk.',
    `score` DECIMAL(18,2) COMMENT 'Composite score derived from probability and impact, used for prioritisation.',
    `source_system` STRING COMMENT 'Originating operational system that supplied the risk data (e.g., Procore, SAP).',
    `title` STRING COMMENT 'Brief human‑readable title that summarises the risk.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the risk record.',
    CONSTRAINT pk_risk PRIMARY KEY(`risk_id`)
) COMMENT 'Risk register entry specific to the bid phase, capturing identified risks and opportunities that influence bid pricing strategy and contingency allocation. Stores risk ID, risk category (commercial, technical, geotechnical, regulatory, supply chain, force majeure), risk description, probability rating, impact rating (cost, schedule, quality), risk score, mitigation strategy, contingency amount allocated, risk owner, and residual risk rating. Feeds bid pricing decisions and GMP contingency calculations.';

CREATE OR REPLACE TABLE `construction_ecm`.`bid`.`approval` (
    `approval_id` BIGINT COMMENT 'Unique system-generated identifier for the bid approval record.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_assessment. Business justification: Bid approval decisions incorporate results of a compliance assessment report to ensure regulatory fit.',
    `bid_opportunity_id` BIGINT COMMENT 'Foreign key linking to bid.bid_opportunity. Business justification: Bid approval should be linked to the originating bid opportunity for traceability.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Bid approvals (go/no-go) are governed by delegation of authority frameworks defined at company code level. The delegation_of_authority_level on approval maps to company code governance structures — a ',
    `estimate_id` BIGINT COMMENT 'Foreign key linking to bid.estimate. Business justification: An approval event governs a specific bid price and margin (approved_bid_price, approved_margin_pct attributes on approval). These values are derived from and validated against a specific estimate. Lin',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Bid go/no-go approvals are governed by delegation of authority at the profit center level. The decision_authority_role and approved_margin_pct on approval are evaluated against profit center targets —',
    `tender_id` BIGINT COMMENT 'Foreign key linking to bid.tender. Business justification: An approval is a formal bid governance decision event. While approval already links to bid_opportunity (the pipeline-level record), a direct link to the specific tender being approved is essential for',
    `approval_number` STRING COMMENT 'Human‑readable reference number assigned to the approval event per internal governance policy.',
    `approval_status` STRING COMMENT 'Current lifecycle state of the approval record.. Valid values are `pending|approved|rejected|deferred|conditional_approved`',
    `approved_bid_price` DECIMAL(18,2) COMMENT 'Final approved monetary amount for the bid.',
    `approved_margin_pct` DECIMAL(18,2) COMMENT 'Approved profit margin expressed as a percentage of the bid price.',
    `bonding_capacity_score` DECIMAL(18,2) COMMENT 'Score reflecting the companys ability to provide required bid bonds.',
    `client_relationship_score` DECIMAL(18,2) COMMENT 'Score reflecting the strength of the relationship with the client.',
    `conditions_imposed` STRING COMMENT 'Any contractual or operational conditions attached to the approval.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bid approval record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the approved bid price.',
    `deadline` DATE COMMENT 'Date by which the approved bid must be submitted.',
    `decision_authority_name` STRING COMMENT 'Full name of the person or entity authorizing the decision.',
    `decision_authority_role` STRING COMMENT 'Organizational role or title of the decision authority.',
    `decision_outcome` STRING COMMENT 'Result of the approval process (e.g., bid, no_bid, conditional_bid, approved, approved_with_conditions, rejected, deferred). [ENUM-REF-CANDIDATE: bid|no_bid|conditional_bid|approved|approved_with_conditions|rejected|deferred — promote to reference product]',
    `decision_rationale` STRING COMMENT 'Free‑text explanation of the reasoning behind the decision.',
    `decision_stage` STRING COMMENT 'Governance stage at which the decision was taken.. Valid values are `bid_no_bid|estimate_review|commercial_review|risk_review|executive_signoff`',
    `decision_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the approval decision was recorded.',
    `delegation_of_authority_level` STRING COMMENT 'Authorized delegation tier that permitted the decision.. Valid values are `level_1|level_2|level_3|level_4`',
    `is_conditional` BOOLEAN COMMENT 'Indicates whether the approval is subject to conditions.',
    `margin_potential_score` DECIMAL(18,2) COMMENT 'Projected profitability score based on estimated margins.',
    `pursuit_investment_justification` STRING COMMENT 'Business case narrative justifying the investment of resources into the bid pursuit.',
    `resource_availability_score` DECIMAL(18,2) COMMENT 'Score indicating the availability of required resources for the project.',
    `risk_profile_score` DECIMAL(18,2) COMMENT 'Score assessing the risk exposure of the bid.',
    `risk_rating` STRING COMMENT 'Overall risk classification assigned to the bid pursuit.. Valid values are `low|medium|high|critical`',
    `strategic_fit_score` DECIMAL(18,2) COMMENT 'Score measuring alignment of the bid with corporate strategy.',
    `total_governance_score` DECIMAL(18,2) COMMENT 'Aggregated score from all governance criteria used to evaluate the bid.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the bid approval record.',
    `valid_until` DATE COMMENT 'Expiration date of the approval if not acted upon.',
    CONSTRAINT pk_approval PRIMARY KEY(`approval_id`)
) COMMENT 'Transactional record of a formal bid governance decision event within the internal authorization workflow, capturing the complete pursuit lifecycle from initial bid/no-bid decision through estimating review, commercial review, risk review, and executive sign-off. Stores approval stage (bid_no_bid, estimate_review, commercial_review, risk_review, executive_signoff), decision date, decision outcome (bid, no-bid, conditional_bid, approved, approved_with_conditions, rejected, deferred), decision authority (approver name and role), scoring against governance criteria (client relationship, risk profile, resource availability, margin potential, strategic fit, bonding capacity), total governance score, risk rating, approved bid price, approved margin percentage, conditions imposed, decision rationale narrative, delegation of authority level, and pursuit investment justification. SSOT for all bid governance decisions including pursuit authorization, resource allocation, and complete audit trail from opportunity pursuit through final submission authority.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `construction_ecm`.`bid`.`tender` ADD CONSTRAINT `fk_bid_tender_bid_opportunity_id` FOREIGN KEY (`bid_opportunity_id`) REFERENCES `construction_ecm`.`bid`.`bid_opportunity`(`bid_opportunity_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate` ADD CONSTRAINT `fk_bid_estimate_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `construction_ecm`.`bid`.`tender`(`tender_id`);
ALTER TABLE `construction_ecm`.`bid`.`boq` ADD CONSTRAINT `fk_bid_boq_estimate_id` FOREIGN KEY (`estimate_id`) REFERENCES `construction_ecm`.`bid`.`estimate`(`estimate_id`);
ALTER TABLE `construction_ecm`.`bid`.`boq` ADD CONSTRAINT `fk_bid_boq_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `construction_ecm`.`bid`.`tender`(`tender_id`);
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ADD CONSTRAINT `fk_bid_bid_boq_line_boq_id` FOREIGN KEY (`boq_id`) REFERENCES `construction_ecm`.`bid`.`boq`(`boq_id`);
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ADD CONSTRAINT `fk_bid_estimate_line_estimate_id` FOREIGN KEY (`estimate_id`) REFERENCES `construction_ecm`.`bid`.`estimate`(`estimate_id`);
ALTER TABLE `construction_ecm`.`bid`.`submission` ADD CONSTRAINT `fk_bid_submission_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `construction_ecm`.`bid`.`tender`(`tender_id`);
ALTER TABLE `construction_ecm`.`bid`.`clarification` ADD CONSTRAINT `fk_bid_clarification_boq_id` FOREIGN KEY (`boq_id`) REFERENCES `construction_ecm`.`bid`.`boq`(`boq_id`);
ALTER TABLE `construction_ecm`.`bid`.`clarification` ADD CONSTRAINT `fk_bid_clarification_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `construction_ecm`.`bid`.`tender`(`tender_id`);
ALTER TABLE `construction_ecm`.`bid`.`bond` ADD CONSTRAINT `fk_bid_bond_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `construction_ecm`.`bid`.`tender`(`tender_id`);
ALTER TABLE `construction_ecm`.`bid`.`risk` ADD CONSTRAINT `fk_bid_risk_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `construction_ecm`.`bid`.`tender`(`tender_id`);
ALTER TABLE `construction_ecm`.`bid`.`approval` ADD CONSTRAINT `fk_bid_approval_bid_opportunity_id` FOREIGN KEY (`bid_opportunity_id`) REFERENCES `construction_ecm`.`bid`.`bid_opportunity`(`bid_opportunity_id`);
ALTER TABLE `construction_ecm`.`bid`.`approval` ADD CONSTRAINT `fk_bid_approval_estimate_id` FOREIGN KEY (`estimate_id`) REFERENCES `construction_ecm`.`bid`.`estimate`(`estimate_id`);
ALTER TABLE `construction_ecm`.`bid`.`approval` ADD CONSTRAINT `fk_bid_approval_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `construction_ecm`.`bid`.`tender`(`tender_id`);

-- ========= TAGS =========
ALTER SCHEMA `construction_ecm`.`bid` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `construction_ecm`.`bid` SET TAGS ('dbx_domain' = 'bid');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` SET TAGS ('dbx_subdomain' = 'cost_pricing');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `trade_package_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Package ID');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `skill_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Skill Trade Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `wbs_node_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Node Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `awarded_value` SET TAGS ('dbx_business_glossary_term' = 'Awarded Value');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `bid_closing_date` SET TAGS ('dbx_business_glossary_term' = 'Bid Closing Date');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `bid_out_date` SET TAGS ('dbx_business_glossary_term' = 'Bid Out Date');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `bonding_required` SET TAGS ('dbx_business_glossary_term' = 'Bonding Required Flag');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `budget_allowance` SET TAGS ('dbx_business_glossary_term' = 'Budget Allowance');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'lump_sum|unit_price|cost_plus|gmp|time_and_materials');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `csi_masterformat_code` SET TAGS ('dbx_business_glossary_term' = 'Construction Specifications Institute (CSI) MasterFormat Code');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `csi_masterformat_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}s[0-9]{2}s[0-9]{2}(.[0-9]{2})?$');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Duration in Days');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `estimated_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Package Value');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `liquidated_damages_rate` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages (LD) Rate');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `number_of_bidders_invited` SET TAGS ('dbx_business_glossary_term' = 'Number of Bidders Invited');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `number_of_bids_received` SET TAGS ('dbx_business_glossary_term' = 'Number of Bids Received');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `package_priority` SET TAGS ('dbx_business_glossary_term' = 'Package Priority');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `package_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `package_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Package Reference Number');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `package_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `package_status` SET TAGS ('dbx_business_glossary_term' = 'Package Status');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `package_status` SET TAGS ('dbx_value_regex' = 'draft|bid_out|evaluation|awarded|closed|cancelled');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `prequalification_required` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Required Flag');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `procurement_method` SET TAGS ('dbx_business_glossary_term' = 'Procurement Method');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `procurement_method` SET TAGS ('dbx_value_regex' = 'open_tender|selective_tender|negotiated|single_source|framework');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `scope_narrative` SET TAGS ('dbx_business_glossary_term' = 'Scope of Work Narrative');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `uniformat_code` SET TAGS ('dbx_business_glossary_term' = 'UniFormat Code');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `uniformat_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}[0-9]{2}$');
ALTER TABLE `construction_ecm`.`bid`.`trade_package` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period in Months');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` SET TAGS ('dbx_subdomain' = 'pursuit_pipeline');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `bid_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Bid Opportunity Identifier (BID_OPP_ID)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (CLIENT_ID)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `bid_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Amount (BID_BOND_AMT)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `bid_decision` SET TAGS ('dbx_business_glossary_term' = 'Bid Decision (BID_DECISION)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `bid_decision` SET TAGS ('dbx_value_regex' = 'bid|no_bid');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `bid_due_date` SET TAGS ('dbx_business_glossary_term' = 'Bid Due Date (BID_DUE_DATE)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (COUNTRY_CODE)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CODE)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (DISCOUNT_AMT)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `estimated_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Contract Value (EST_CONTRACT_VAL)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `expected_end_date` SET TAGS ('dbx_business_glossary_term' = 'Expected End Date (EXP_END_DATE)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `expected_start_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Start Date (EXP_START_DATE)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `gmp_type` SET TAGS ('dbx_business_glossary_term' = 'GMP Type (GMP_TYPE)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `gmp_type` SET TAGS ('dbx_value_regex' = 'gmp|lump_sum|cost_plus');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `is_joint_venture` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Flag (IS_JV)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment (MARKET_SEG)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'infrastructure|energy|commercial|residential|industrial');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `net_estimated_value` SET TAGS ('dbx_business_glossary_term' = 'Net Estimated Value (NET_EST_VAL)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Name (OPP_NAME)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `opportunity_number` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Number (OPP_NO)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `pipeline_forecast_category` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Forecast Category (PIPELINE_CAT)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `pipeline_forecast_category` SET TAGS ('dbx_value_regex' = 'pipeline|forecast|committed|won|lost');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `probability_of_win` SET TAGS ('dbx_business_glossary_term' = 'Probability of Win (PROB_WIN)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type (PROJECT_TYPE)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'highway|airport|bridge|power_plant|residential_development|commercial_building');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel (SOURCE_CHAN)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'salesforce|referral|partner|website|event');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Stage (OPP_STAGE)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_value_regex' = 'lead|qualified|proposal|submitted|awarded|lost');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `win_loss_status` SET TAGS ('dbx_business_glossary_term' = 'Win/Loss Status (WIN_LOSS_STATUS)');
ALTER TABLE `construction_ecm`.`bid`.`bid_opportunity` ALTER COLUMN `win_loss_status` SET TAGS ('dbx_value_regex' = 'won|lost|withdrawn|pending');
ALTER TABLE `construction_ecm`.`bid`.`tender` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`bid`.`tender` SET TAGS ('dbx_subdomain' = 'pursuit_pipeline');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `tender_id` SET TAGS ('dbx_business_glossary_term' = 'Tender ID');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `bid_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Bid Opportunity Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `framework_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Client Framework Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Plan Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `rfp_issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Rfp Issuance Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `schedule_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Baseline Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `award_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Award Decision Date');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `award_status` SET TAGS ('dbx_business_glossary_term' = 'Award Status');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `award_status` SET TAGS ('dbx_value_regex' = 'awarded|not_awarded|pending');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `bid_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Amount');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `bid_bond_expiry` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Expiry Date');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `bid_bond_required` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Required');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `bid_bond_type` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Type');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `bid_bond_type` SET TAGS ('dbx_value_regex' = 'bank|insurance|cash');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `bid_type` SET TAGS ('dbx_business_glossary_term' = 'Bid Type');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `bid_type` SET TAGS ('dbx_value_regex' = 'new|renewal|extension');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `compliance_requirements_met` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements Met');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `confidentiality_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Flag');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `documents_attached` SET TAGS ('dbx_business_glossary_term' = 'Documents Attached Count');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `estimated_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration (Months)');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `estimated_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Tender Value');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `evaluation_method` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Method');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `evaluation_method` SET TAGS ('dbx_value_regex' = 'technical|financial|combined');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `evaluation_score` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Score');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `is_joint_venture` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Flag');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `joint_venture_partner` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Partner');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tender Notes');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `prequalification_status` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Status');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `prequalification_status` SET TAGS ('dbx_value_regex' = 'qualified|unqualified|pending');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `procurement_method` SET TAGS ('dbx_business_glossary_term' = 'Procurement Method');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `project_end_date` SET TAGS ('dbx_business_glossary_term' = 'Project End Date');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `project_location` SET TAGS ('dbx_business_glossary_term' = 'Project Location');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `project_title` SET TAGS ('dbx_business_glossary_term' = 'Project Title (PROJ_TITLE)');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|withdrawn|awarded|rejected');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `tender_number` SET TAGS ('dbx_business_glossary_term' = 'Tender Number (TENDER_NO)');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `tender_type` SET TAGS ('dbx_business_glossary_term' = 'Tender Type (TENDER_TYPE)');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `tender_type` SET TAGS ('dbx_value_regex' = 'lump_sum|gmp|unit_rate|epc|design_build|dbb');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `validity_end` SET TAGS ('dbx_business_glossary_term' = 'Tender Validity End Date');
ALTER TABLE `construction_ecm`.`bid`.`tender` ALTER COLUMN `validity_start` SET TAGS ('dbx_business_glossary_term' = 'Tender Validity Start Date');
ALTER TABLE `construction_ecm`.`bid`.`estimate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`bid`.`estimate` SET TAGS ('dbx_subdomain' = 'cost_pricing');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Estimate ID');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `env_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `labor_cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `schedule_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Baseline Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `tender_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `base_pricing_date` SET TAGS ('dbx_business_glossary_term' = 'Base Pricing Date');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contingency Percentage');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `cost_breakdown_version` SET TAGS ('dbx_business_glossary_term' = 'Cost Breakdown Version');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `escalation_allowance` SET TAGS ('dbx_business_glossary_term' = 'Escalation Allowance');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `estimate_category` SET TAGS ('dbx_business_glossary_term' = 'Estimate Category');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `estimate_category` SET TAGS ('dbx_value_regex' = 'new_work|renovation|maintenance|expansion|demolition');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `estimate_name` SET TAGS ('dbx_business_glossary_term' = 'Estimate Name');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `estimate_number` SET TAGS ('dbx_business_glossary_term' = 'Estimate Number');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `estimate_status` SET TAGS ('dbx_business_glossary_term' = 'Estimate Status');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `estimate_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|withdrawn');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `estimate_type` SET TAGS ('dbx_business_glossary_term' = 'Estimate Type');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `estimate_type` SET TAGS ('dbx_value_regex' = 'conceptual|schematic|detailed|definitive|preliminary');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `estimating_method` SET TAGS ('dbx_business_glossary_term' = 'Estimating Method');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `estimating_method` SET TAGS ('dbx_value_regex' = 'parametric|unit_rate|first_principles|analogous');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `is_gmp` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Maximum Price Flag');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Estimate Locked Flag');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `is_lump_sum` SET TAGS ('dbx_business_glossary_term' = 'Lump‑Sum Estimate Flag');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Estimate Notes');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `overhead_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overhead Percentage');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `profit_margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Profit Margin Percentage');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `risk_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact (Days)');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `total_estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Cost');
ALTER TABLE `construction_ecm`.`bid`.`estimate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `construction_ecm`.`bid`.`boq` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`bid`.`boq` SET TAGS ('dbx_subdomain' = 'cost_pricing');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `boq_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Quantities ID');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `bim_model_id` SET TAGS ('dbx_business_glossary_term' = 'Bim Model Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Estimate Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `tender_id` SET TAGS ('dbx_business_glossary_term' = 'Tender ID');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `wbs_node_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Node Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'BOQ Approval Date');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `boq_description` SET TAGS ('dbx_business_glossary_term' = 'BOQ Description');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `boq_status` SET TAGS ('dbx_business_glossary_term' = 'BOQ Status');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `boq_status` SET TAGS ('dbx_value_regex' = 'draft|issued|approved|revised|archived');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `boq_type` SET TAGS ('dbx_business_glossary_term' = 'BOQ Type');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `boq_type` SET TAGS ('dbx_value_regex' = 'measured|provisional|approximate');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `contains_confidential_pricing` SET TAGS ('dbx_business_glossary_term' = 'Confidential Pricing Flag');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Currency Exchange Rate');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `exchange_rate_date` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Date');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'BOQ Expiry Date');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'BOQ Issue Date');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `preparation_date` SET TAGS ('dbx_business_glossary_term' = 'BOQ Preparation Date');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'BOQ Reference Number');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'BOQ Revision Number');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Procore|SAP S/4HANA|Autodesk BIM 360|Viewpoint Vista');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total BOQ Quantity');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total BOQ Value');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `total_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `total_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `version_label` SET TAGS ('dbx_business_glossary_term' = 'BOQ Version Label');
ALTER TABLE `construction_ecm`.`bid`.`boq` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` SET TAGS ('dbx_subdomain' = 'cost_pricing');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `bid_boq_line_id` SET TAGS ('dbx_business_glossary_term' = 'BOQ Line ID');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `asset_category_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Category Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `boq_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Quantities ID');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `labor_cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `bid_boq_line_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `bid_boq_line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `bid_boq_line_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|cancelled');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `change_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Change Order Flag');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Change Order Number');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_value_regex' = 'direct|indirect|overhead|contingency');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `estimated_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Date');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `is_gmp_applicable` SET TAGS ('dbx_business_glossary_term' = 'GMP Applicable');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `is_lump_sum` SET TAGS ('dbx_business_glossary_term' = 'Lump Sum Applicable');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Is Taxable');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `item_code` SET TAGS ('dbx_business_glossary_term' = 'Item Code');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `labour_cost` SET TAGS ('dbx_business_glossary_term' = 'Labour Cost');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `material_cost` SET TAGS ('dbx_business_glossary_term' = 'Material Cost');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `overhead_amount` SET TAGS ('dbx_business_glossary_term' = 'Overhead Allocation');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `plant_cost` SET TAGS ('dbx_business_glossary_term' = 'Plant Cost');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `profit_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Profit Margin (%)');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `subcontract_cost` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Cost');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate (%)');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate (Currency per UOM)');
ALTER TABLE `construction_ecm`.`bid`.`bid_boq_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` SET TAGS ('dbx_subdomain' = 'cost_pricing');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `estimate_line_id` SET TAGS ('dbx_business_glossary_term' = 'Estimate Line Identifier');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `asset_category_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Category Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Estimate Identifier');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `labor_cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `labor_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Material Master Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Identifier');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `skill_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Skill Trade Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `baseline_cost` SET TAGS ('dbx_business_glossary_term' = 'Baseline Cost');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Change Order Number');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_value_regex' = 'labour|material|plant|subcontract|indirect');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `cost_variance` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `estimate_line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `estimate_line_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|archived');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `estimate_version` SET TAGS ('dbx_business_glossary_term' = 'Estimate Version');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Is Deleted Flag');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `labor_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Type');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `labor_rate_type` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'raw|prefab|recycled|other');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Line Notes');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `productivity_factor` SET TAGS ('dbx_business_glossary_term' = 'Productivity Factor');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `resource_description` SET TAGS ('dbx_business_glossary_term' = 'Resource Description');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `retention_status` SET TAGS ('dbx_business_glossary_term' = 'Retention Status');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `retention_status` SET TAGS ('dbx_value_regex' = 'retained|released|pending');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `revised_cost` SET TAGS ('dbx_business_glossary_term' = 'Revised Cost');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `risk_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `source_of_rate` SET TAGS ('dbx_business_glossary_term' = 'Source of Rate');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'm|kg|m2|m3|hour|unit');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `waste_factor` SET TAGS ('dbx_business_glossary_term' = 'Waste Factor');
ALTER TABLE `construction_ecm`.`bid`.`estimate_line` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `construction_ecm`.`bid`.`submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`bid`.`submission` SET TAGS ('dbx_subdomain' = 'pursuit_pipeline');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Bid Submission ID (BSID)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (CID)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `rfp_issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Rfp Issuance Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `tender_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `acknowledgement_reference` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Reference Number (ARN)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `bid_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Amount (BBA)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `bid_bond_expiry` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Expiry Date (BBE)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `bid_bond_type` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Type (BBT)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `bid_bond_type` SET TAGS ('dbx_value_regex' = 'performance|payment|security|none');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `bid_price` SET TAGS ('dbx_business_glossary_term' = 'Bid Price (BP)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `bid_price_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Bid Price Adjustment (BPA)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `bid_type` SET TAGS ('dbx_business_glossary_term' = 'Bid Type (BT)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `bid_type` SET TAGS ('dbx_value_regex' = 'lump_sum|gmp|unit_price|cost_plus');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `commercial_score` SET TAGS ('dbx_business_glossary_term' = 'Commercial Evaluation Score (CES)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `compliance_requirements_met` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements Met Indicator (CRMI)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `deadline` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline Date (SDD)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `documents_attached_count` SET TAGS ('dbx_business_glossary_term' = 'Attached Documents Count (ADC)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `estimated_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration (Months) (EDM)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `evaluation_method` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Method (EM)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `evaluation_method` SET TAGS ('dbx_value_regex' = 'two_envelope|single_envelope');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `is_joint_venture` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Indicator (JVI)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `late_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Late Submission Indicator (LSI)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Submission Notes (SN)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `number_of_copies` SET TAGS ('dbx_business_glossary_term' = 'Number of Copies Submitted (NCS)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `project_location` SET TAGS ('dbx_business_glossary_term' = 'Project Location Description (PLD)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Reference Number (SRN)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (RC)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating (RR)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method (SM)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic|hard_copy|email');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Bid Submission Status (BSS)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|acknowledged|rejected|awarded|cancelled');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bid Submission Timestamp (BST)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `technical_score` SET TAGS ('dbx_business_glossary_term' = 'Technical Evaluation Score (TES)');
ALTER TABLE `construction_ecm`.`bid`.`submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`bid`.`clarification` SET TAGS ('dbx_subdomain' = 'pursuit_pipeline');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `clarification_id` SET TAGS ('dbx_business_glossary_term' = 'Bid Clarification Identifier');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `boq_id` SET TAGS ('dbx_business_glossary_term' = 'Boq Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `rfi_id` SET TAGS ('dbx_business_glossary_term' = 'Rfi Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `tender_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `acknowledgement_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Status (ACK_STATUS)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `acknowledgement_status` SET TAGS ('dbx_value_regex' = 'acknowledged|not_acknowledged');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `addendum_number` SET TAGS ('dbx_business_glossary_term' = 'Addendum Number (ADDENDUM_NO)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `attachment_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachment Flag (HAS_ATTACH)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `bid_revision_triggered` SET TAGS ('dbx_business_glossary_term' = 'Bid Revision Triggered (REV_TRIGGER)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `clarification_number` SET TAGS ('dbx_business_glossary_term' = 'Clarification Number (CLARIF_NO)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `clarification_status` SET TAGS ('dbx_business_glossary_term' = 'Clarification Status (STATUS)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `clarification_status` SET TAGS ('dbx_value_regex' = 'open|answered|closed|incorporated');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `communication_type` SET TAGS ('dbx_business_glossary_term' = 'Communication Type (COMM_TYPE)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `communication_type` SET TAGS ('dbx_value_regex' = 'RFI_issued|RFI_received|addendum|amendment|clarification');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `content` SET TAGS ('dbx_business_glossary_term' = 'Communication Content (CONTENT)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Communication Direction (DIR)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'client_to_contractor|contractor_to_client');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Communication Issued Timestamp (ISSUED_TS)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Impact Monetary Amount (IMP_AMT)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `impact_description` SET TAGS ('dbx_business_glossary_term' = 'Impact Description (IMP_DESC)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `impact_flag_boq` SET TAGS ('dbx_business_glossary_term' = 'BOQ Impact Flag (IMP_BOQ)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `impact_flag_price` SET TAGS ('dbx_business_glossary_term' = 'Price Impact Flag (IMP_PRICE)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `impact_flag_schedule` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Flag (IMP_SCHED)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `impact_flag_scope` SET TAGS ('dbx_business_glossary_term' = 'Scope Impact Flag (IMP_SCOPE)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `impact_flag_specifications` SET TAGS ('dbx_business_glossary_term' = 'Specification Impact Flag (IMP_SPEC)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Clarification Indicator (CRIT)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority (ISS_AUTH)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `response_content` SET TAGS ('dbx_business_glossary_term' = 'Response Content (RESP_CONTENT)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `response_deadline` SET TAGS ('dbx_business_glossary_term' = 'Response Deadline (RESP_DEADLINE)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status (RESP_STATUS)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'pending|provided|overdue');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp (RESP_TS)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `revised_submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Revised Submission Deadline (REV_DEADLINE)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Clarification Revision Number (REV_NO)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Subject Line (SUBJ)');
ALTER TABLE `construction_ecm`.`bid`.`clarification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `construction_ecm`.`bid`.`bond` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`bid`.`bond` SET TAGS ('dbx_subdomain' = 'pursuit_pipeline');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `bond_id` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond ID (BB_ID)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (PROJECT_ID)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `tender_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Identifier (TENDER_ID)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Amount (BBA)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (APPROVED_BY)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVED_TS)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `beneficiary` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary (Client)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `bond_number` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Number (BBN)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `bond_status` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Status (BB_STATUS)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `bond_status` SET TAGS ('dbx_value_regex' = 'issued|submitted|returned|forfeited|extended');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `bond_type` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Type (BB_TYPE)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `bond_type` SET TAGS ('dbx_value_regex' = 'bank_guarantee|surety_bond|insurance_bond');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `compliance_requirements_met` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements Met Flag (COMPLIANCE_MET)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `confidentiality_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Flag (CONFIDENTIAL_FLAG)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `documents_attached` SET TAGS ('dbx_business_glossary_term' = 'Documents Attached Flag (DOCS_ATTACHED)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Bond Expiry Date (EXPIRY_DATE)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `expiry_place` SET TAGS ('dbx_business_glossary_term' = 'Bond Expiry Location (EXPIRY_PLACE)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `extension_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Extensions (EXT_COUNT)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `guarantee_extension_allowed` SET TAGS ('dbx_business_glossary_term' = 'Extension Allowed Flag (EXTENSION_ALLOWED)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `guarantee_extension_reason` SET TAGS ('dbx_business_glossary_term' = 'Extension Reason (EXTENSION_REASON)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Bond Issue Date (ISSUE_DATE)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `issue_place` SET TAGS ('dbx_business_glossary_term' = 'Bond Issue Location (ISSUE_PLACE)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `issuer_type` SET TAGS ('dbx_business_glossary_term' = 'Issuer Type (ISSUER_TYPE)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `issuer_type` SET TAGS ('dbx_value_regex' = 'bank|surety|insurance');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `issuing_entity` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank or Surety (Issuer)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `last_extension_date` SET TAGS ('dbx_business_glossary_term' = 'Last Extension Date (LAST_EXT_DATE)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By (LAST_UPDATED_BY)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Percentage of Tender Value (BBP)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating (RISK_RATING)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SOURCE_SYSTEM)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `status_date` SET TAGS ('dbx_business_glossary_term' = 'Status Effective Date (STATUS_DATE)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `total_extension_days` SET TAGS ('dbx_business_glossary_term' = 'Total Extension Days (TOTAL_EXT_DAYS)');
ALTER TABLE `construction_ecm`.`bid`.`bond` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `construction_ecm`.`bid`.`risk` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`bid`.`risk` SET TAGS ('dbx_subdomain' = 'cost_pricing');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `risk_id` SET TAGS ('dbx_business_glossary_term' = 'Bid Risk ID');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `tender_id` SET TAGS ('dbx_business_glossary_term' = 'Related Tender ID');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Method');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'qualitative|quantitative|mixed');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `attached_documents` SET TAGS ('dbx_business_glossary_term' = 'Attached Documents');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `bid_risk_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Status');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `bid_risk_status` SET TAGS ('dbx_value_regex' = 'identified|mitigated|closed|monitoring');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_business_glossary_term' = 'Contingency Amount (USD)');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contingency Percentage');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `exposure_currency` SET TAGS ('dbx_business_glossary_term' = 'Risk Exposure Currency');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Identified Date');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `impact_cost` SET TAGS ('dbx_business_glossary_term' = 'Impact Cost (USD)');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `impact_quality` SET TAGS ('dbx_business_glossary_term' = 'Impact on Quality');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `impact_quality` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `impact_schedule_days` SET TAGS ('dbx_business_glossary_term' = 'Impact Schedule (Days)');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `is_key_risk` SET TAGS ('dbx_business_glossary_term' = 'Key Risk Indicator');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `mitigation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Mitigation End Date');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `mitigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Start Date');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `mitigation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Strategy');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Risk Notes');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `origin` SET TAGS ('dbx_business_glossary_term' = 'Risk Origin');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `origin` SET TAGS ('dbx_value_regex' = 'internal|external');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Risk Priority');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `probability_rating` SET TAGS ('dbx_business_glossary_term' = 'Probability Rating');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `probability_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `residual_impact_cost` SET TAGS ('dbx_business_glossary_term' = 'Residual Impact Cost (USD)');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `residual_probability` SET TAGS ('dbx_business_glossary_term' = 'Residual Probability');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `residual_probability` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Risk Review Frequency');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|ad_hoc');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'commercial|technical|geotechnical|regulatory|supply_chain|force_majeure');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `risk_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Code');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Risk Title');
ALTER TABLE `construction_ecm`.`bid`.`risk` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`bid`.`approval` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`bid`.`approval` SET TAGS ('dbx_subdomain' = 'pursuit_pipeline');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Bid Approval Identifier (BA_ID)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `bid_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Bid Opportunity Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Estimate Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `tender_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `approval_number` SET TAGS ('dbx_business_glossary_term' = 'Bid Approval Number (BAN)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APP_STATUS)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|deferred|conditional_approved');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `approved_bid_price` SET TAGS ('dbx_business_glossary_term' = 'Approved Bid Price (APP_BID_PRICE)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `approved_margin_pct` SET TAGS ('dbx_business_glossary_term' = 'Approved Margin Percentage (APP_MARGIN_PCT)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `bonding_capacity_score` SET TAGS ('dbx_business_glossary_term' = 'Bonding Capacity Score (BC_SCORE)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `client_relationship_score` SET TAGS ('dbx_business_glossary_term' = 'Client Relationship Score (CR_SCORE)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `conditions_imposed` SET TAGS ('dbx_business_glossary_term' = 'Conditions Imposed (CONDITIONS)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO_CURRENCY_CODE)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `deadline` SET TAGS ('dbx_business_glossary_term' = 'Approval Deadline Date (APP_DEADLINE)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `decision_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Decision Authority Name (DEC_AUTH_NAME)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `decision_authority_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `decision_authority_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `decision_authority_role` SET TAGS ('dbx_business_glossary_term' = 'Decision Authority Role (DEC_AUTH_ROLE)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_business_glossary_term' = 'Decision Outcome (DEC_OUTCOME)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Decision Rationale Narrative (DEC_RATIONALE)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `decision_stage` SET TAGS ('dbx_business_glossary_term' = 'Decision Stage (DEC_STAGE)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `decision_stage` SET TAGS ('dbx_value_regex' = 'bid_no_bid|estimate_review|commercial_review|risk_review|executive_signoff');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Timestamp (DECISION_TS)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `delegation_of_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Delegation of Authority Level (DOA_LEVEL)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `delegation_of_authority_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3|level_4');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `is_conditional` SET TAGS ('dbx_business_glossary_term' = 'Is Conditional Approval (IS_CONDITIONAL)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `margin_potential_score` SET TAGS ('dbx_business_glossary_term' = 'Margin Potential Score (MP_SCORE)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `pursuit_investment_justification` SET TAGS ('dbx_business_glossary_term' = 'Pursuit Investment Justification (INVEST_JUST)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `resource_availability_score` SET TAGS ('dbx_business_glossary_term' = 'Resource Availability Score (RA_SCORE)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `risk_profile_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Score (RP_SCORE)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating (RISK_RATING)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `strategic_fit_score` SET TAGS ('dbx_business_glossary_term' = 'Strategic Fit Score (SF_SCORE)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `total_governance_score` SET TAGS ('dbx_business_glossary_term' = 'Total Governance Score (GOV_SCORE_TOTAL)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `construction_ecm`.`bid`.`approval` ALTER COLUMN `valid_until` SET TAGS ('dbx_business_glossary_term' = 'Approval Valid Until Date (APP_VALID_UNTIL)');
