-- Schema for Domain: project | Business:  | Version: v2_ecm
-- Generated on: 2026-06-22 18:57:26

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`project` COMMENT 'Capital improvement program (CIP) and project management including project planning, design management, construction management, contractor coordination, project budgeting and cost control, schedule tracking, change order management, commissioning, and asset handover. Manages infrastructure expansion, rehabilitation, and renewal projects from concept through operational turnover.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`cip_project` (
    `cip_project_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'Cost center',
    `facility_id` BIGINT COMMENT 'Associated facility',
    `fund_id` BIGINT COMMENT 'Fund financing the project',
    `employee_id` BIGINT COMMENT 'Project manager',
    `actual_completion_date` DATE COMMENT 'Actual completion date',
    `actual_start_date` DATE COMMENT 'Actual start date',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `grant_funded_flag` BOOLEAN COMMENT 'Grant funded flag',
    `planned_completion_date` DATE COMMENT 'Planned completion date',
    `planned_start_date` DATE COMMENT 'Planned start date',
    `priority_rank` STRING COMMENT 'Priority ranking',
    `project_category` STRING COMMENT 'Category: treatment, distribution, collection',
    `project_description` STRING COMMENT 'Detailed description',
    `project_name` STRING COMMENT 'Project name',
    `project_number` STRING COMMENT 'Unique project number',
    `project_status` STRING COMMENT 'Status: planning, design, construction, closeout',
    `project_type` STRING COMMENT 'Type: new construction, rehabilitation, expansion',
    `regulatory_driver` STRING COMMENT 'Regulatory driver if applicable',
    `total_actual_cost` DECIMAL(18,2) COMMENT 'Total actual cost to date',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Total approved budget',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_cip_project PRIMARY KEY(`cip_project_id`)
) COMMENT 'Capital Improvement Program project tracking capital investments in water/wastewater infrastructure';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` (
    `wbs_element_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'Parent CIP project',
    `parent_wbs_element_id` BIGINT COMMENT 'Parent WBS element',
    `employee_id` BIGINT COMMENT 'Responsible employee',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost to date',
    `budget_amount` DECIMAL(18,2) COMMENT 'Budget allocated to this element',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `wbs_code` STRING COMMENT 'WBS code',
    `wbs_description` STRING COMMENT 'Description',
    `wbs_level` STRING COMMENT 'Hierarchy level',
    `wbs_name` STRING COMMENT 'WBS element name',
    CONSTRAINT pk_wbs_element PRIMARY KEY(`wbs_element_id`)
) COMMENT 'Work Breakdown Structure element for hierarchical project decomposition';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`milestone` (
    `milestone_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'Parent CIP project',
    `employee_id` BIGINT COMMENT 'Responsible employee',
    `wbs_element_id` BIGINT COMMENT 'Associated WBS element',
    `actual_date` DATE COMMENT 'Actual completion date',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `milestone_description` STRING COMMENT 'Description',
    `milestone_status` STRING COMMENT 'Status: pending, in progress, completed, delayed',
    `milestone_type` STRING COMMENT 'Type: design, permit, construction, commissioning',
    `milestone_name` STRING COMMENT 'Milestone name',
    `planned_date` DATE COMMENT 'Planned completion date',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_milestone PRIMARY KEY(`milestone_id`)
) COMMENT 'Project milestone tracking key deliverables and schedule checkpoints';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`project_budget` (
    `project_budget_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'Parent CIP project',
    `finance_budget_id` BIGINT COMMENT 'Foreign key to the canonical finance_budget record in finance domain',
    `fund_id` BIGINT COMMENT 'Fund',
    `actual_amount` DECIMAL(18,2) COMMENT 'Actual expenditure',
    `budget_category` STRING COMMENT 'Category: design, construction, contingency',
    `budget_status` STRING COMMENT 'Status: proposed, approved, closed',
    `committed_amount` DECIMAL(18,2) COMMENT 'Committed amount',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `fiscal_year` STRING COMMENT 'Fiscal year',
    `original_budget_amount` DECIMAL(18,2) COMMENT 'Original budget amount',
    `revised_budget_amount` DECIMAL(18,2) COMMENT 'Revised budget amount',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_project_budget PRIMARY KEY(`project_budget_id`)
) COMMENT 'Project budget tracking appropriations and allocations [DEPRECATED: Single source of truth is finance.finance_budget]';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` (
    `budget_amendment_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Approving employee',
    `cip_project_id` BIGINT COMMENT 'CIP project',
    `project_budget_id` BIGINT COMMENT 'Parent project budget',
    `amendment_amount` DECIMAL(18,2) COMMENT 'Amendment amount',
    `amendment_date` DATE COMMENT 'Amendment date',
    `amendment_number` STRING COMMENT 'Amendment number',
    `amendment_status` STRING COMMENT 'Status: pending, approved, rejected',
    `amendment_type` STRING COMMENT 'Type: increase, decrease, reallocation',
    `approval_date` DATE COMMENT 'Approval date',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `justification` STRING COMMENT 'Justification',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_budget_amendment PRIMARY KEY(`budget_amendment_id`)
) COMMENT 'Budget amendment tracking changes to project budgets';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`design_contract` (
    `design_contract_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'CIP project',
    `vendor_id` BIGINT COMMENT 'Design firm vendor',
    `contract_amount` DECIMAL(18,2) COMMENT 'Contract amount',
    `contract_end_date` DATE COMMENT 'End date',
    `contract_name` STRING COMMENT 'Contract name',
    `contract_number` STRING COMMENT 'Contract number',
    `contract_start_date` DATE COMMENT 'Start date',
    `contract_status` STRING COMMENT 'Status: draft, executed, active, closed',
    `contract_type` STRING COMMENT 'Type: lump sum, cost plus, time and materials',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `scope_of_work` STRING COMMENT 'Scope of work',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_design_contract PRIMARY KEY(`design_contract_id`)
) COMMENT 'Design and engineering services contract';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` (
    `construction_contract_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'CIP project',
    `vendor_id` BIGINT COMMENT 'Contractor vendor',
    `contract_amount` DECIMAL(18,2) COMMENT 'Contract amount',
    `contract_name` STRING COMMENT 'Contract name',
    `contract_number` STRING COMMENT 'Contract number',
    `contract_start_date` DATE COMMENT 'Start date',
    `contract_status` STRING COMMENT 'Status: bid, awarded, active, closed',
    `contract_type` STRING COMMENT 'Type: lump sum, unit price, GMP',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `final_completion_date` DATE COMMENT 'Final completion date',
    `payment_bond_amount` DECIMAL(18,2) COMMENT 'Payment bond amount',
    `performance_bond_amount` DECIMAL(18,2) COMMENT 'Performance bond amount',
    `retainage_percent` DECIMAL(18,2) COMMENT 'Retainage percentage',
    `substantial_completion_date` DATE COMMENT 'Substantial completion date',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_construction_contract PRIMARY KEY(`construction_contract_id`)
) COMMENT 'Construction services contract';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`change_order` (
    `change_order_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Approving employee',
    `construction_contract_id` BIGINT COMMENT 'Construction contract',
    `design_contract_id` BIGINT COMMENT 'Design contract',
    `amount` DECIMAL(18,2) COMMENT 'Change order amount',
    `approval_date` DATE COMMENT 'Approval date',
    `change_order_date` DATE COMMENT 'Change order date',
    `change_order_number` STRING COMMENT 'Change order number',
    `change_order_status` STRING COMMENT 'Status: pending, approved, rejected, executed',
    `change_order_type` STRING COMMENT 'Type: scope change, time extension, cost adjustment',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `justification` STRING COMMENT 'Justification',
    `time_extension_days` STRING COMMENT 'Time extension in days',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_change_order PRIMARY KEY(`change_order_id`)
) COMMENT 'Contract change order tracking scope and cost changes';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`pay_application` (
    `pay_application_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Approving employee',
    `construction_contract_id` BIGINT COMMENT 'Construction contract',
    `application_date` DATE COMMENT 'Application date',
    `application_number` STRING COMMENT 'Application number',
    `approval_date` DATE COMMENT 'Approval date',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `materials_stored_amount` DECIMAL(18,2) COMMENT 'Materials stored amount',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'Net payment amount',
    `payment_status` STRING COMMENT 'Status: submitted, approved, paid',
    `period_end_date` DATE COMMENT 'Period end date',
    `period_start_date` DATE COMMENT 'Period start date',
    `retainage_amount` DECIMAL(18,2) COMMENT 'Retainage amount',
    `total_earned_amount` DECIMAL(18,2) COMMENT 'Total earned amount',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `work_completed_amount` DECIMAL(18,2) COMMENT 'Work completed amount',
    CONSTRAINT pk_pay_application PRIMARY KEY(`pay_application_id`)
) COMMENT 'Contractor payment application for progress payments';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` (
    `cost_transaction_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'CIP project',
    `general_ledger_id` BIGINT COMMENT 'General ledger entry',
    `vendor_id` BIGINT COMMENT 'Vendor',
    `wbs_element_id` BIGINT COMMENT 'WBS element',
    `cost_category` STRING COMMENT 'Category: labor, material, equipment, overhead',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `cost_transaction_description` STRING COMMENT 'Description',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Transaction amount',
    `transaction_date` DATE COMMENT 'Transaction date',
    `transaction_type` STRING COMMENT 'Type: invoice, payroll, material, equipment',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_cost_transaction PRIMARY KEY(`cost_transaction_id`)
) COMMENT 'Project cost transaction tracking all project expenditures';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`project_permit` (
    `project_permit_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'CIP project',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key to the canonical compliance_permit record in compliance domain',
    `regulatory_agency_id` BIGINT COMMENT 'Regulatory agency',
    `application_date` DATE COMMENT 'Application date',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `expiration_date` DATE COMMENT 'Expiration date',
    `issue_date` DATE COMMENT 'Issue date',
    `permit_description` STRING COMMENT 'Description',
    `permit_fee_amount` DECIMAL(18,2) COMMENT 'Permit fee amount',
    `permit_number` STRING COMMENT 'Permit number',
    `permit_status` STRING COMMENT 'Status: applied, issued, expired, revoked',
    `permit_type` STRING COMMENT 'Type: building, environmental, right-of-way',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_project_permit PRIMARY KEY(`project_permit_id`)
) COMMENT 'Project permit tracking regulatory approvals required for project execution [DEPRECATED: Single source of truth is compliance.compliance_permit]';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` (
    `design_submittal_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'CIP project',
    `design_contract_id` BIGINT COMMENT 'Design contract',
    `employee_id` BIGINT COMMENT 'Reviewer employee',
    `comments` STRING COMMENT 'Review comments',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `review_completion_date` DATE COMMENT 'Review completion date',
    `review_due_date` DATE COMMENT 'Review due date',
    `review_status` STRING COMMENT 'Status: submitted, under review, approved, rejected',
    `submittal_date` DATE COMMENT 'Submittal date',
    `submittal_name` STRING COMMENT 'Submittal name',
    `submittal_number` STRING COMMENT 'Submittal number',
    `submittal_type` STRING COMMENT 'Type: preliminary, 30%, 60%, 90%, final',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_design_submittal PRIMARY KEY(`design_submittal_id`)
) COMMENT 'Design submittal tracking design deliverables and review cycles';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` (
    `construction_submittal_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'CIP project',
    `construction_contract_id` BIGINT COMMENT 'Construction contract',
    `employee_id` BIGINT COMMENT 'Reviewer employee',
    `comments` STRING COMMENT 'Review comments',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `review_completion_date` DATE COMMENT 'Review completion date',
    `review_due_date` DATE COMMENT 'Review due date',
    `review_status` STRING COMMENT 'Status: submitted, approved, approved as noted, rejected',
    `spec_section` STRING COMMENT 'Specification section',
    `submittal_date` DATE COMMENT 'Submittal date',
    `submittal_name` STRING COMMENT 'Submittal name',
    `submittal_number` STRING COMMENT 'Submittal number',
    `submittal_type` STRING COMMENT 'Type: shop drawing, product data, sample',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_construction_submittal PRIMARY KEY(`construction_submittal_id`)
) COMMENT 'Construction submittal tracking shop drawings, product data, and samples';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` (
    `request_for_information_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'CIP project',
    `construction_contract_id` BIGINT COMMENT 'Construction contract',
    `employee_id` BIGINT COMMENT 'Responding employee',
    `request_submitted_by_employee_id` BIGINT COMMENT 'Submitting employee',
    `cost_impact_flag` BOOLEAN COMMENT 'Cost impact flag',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `response_date` DATE COMMENT 'Response date',
    `response_due_date` DATE COMMENT 'Response due date',
    `rfi_number` STRING COMMENT 'RFI number',
    `rfi_question` STRING COMMENT 'RFI question',
    `rfi_response` STRING COMMENT 'RFI response',
    `rfi_status` STRING COMMENT 'Status: open, answered, closed',
    `rfi_subject` STRING COMMENT 'RFI subject',
    `schedule_impact_flag` BOOLEAN COMMENT 'Schedule impact flag',
    `submitted_date` DATE COMMENT 'Submitted date',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_request_for_information PRIMARY KEY(`request_for_information_id`)
) COMMENT 'Request for Information tracking questions and clarifications during construction';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` (
    `inspection_report_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'CIP project',
    `construction_contract_id` BIGINT COMMENT 'Construction contract',
    `employee_id` BIGINT COMMENT 'Inspector employee',
    `contractor_personnel_count` STRING COMMENT 'Contractor personnel count',
    `corrective_action_required` STRING COMMENT 'Corrective action required',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `deficiencies_noted` STRING COMMENT 'Deficiencies noted',
    `inspection_date` DATE COMMENT 'Inspection date',
    `inspection_status` STRING COMMENT 'Status: draft, submitted, approved',
    `inspection_type` STRING COMMENT 'Type: daily, milestone, final',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `weather_conditions` STRING COMMENT 'Weather conditions',
    `work_observed` STRING COMMENT 'Work observed',
    CONSTRAINT pk_inspection_report PRIMARY KEY(`inspection_report_id`)
) COMMENT 'Construction inspection report documenting field observations and quality checks';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` (
    `nonconformance_report_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'CIP project',
    `construction_contract_id` BIGINT COMMENT 'Construction contract',
    `employee_id` BIGINT COMMENT 'Reporting employee',
    `corrective_action_completion_date` DATE COMMENT 'Corrective action completion date',
    `corrective_action_due_date` DATE COMMENT 'Corrective action due date',
    `corrective_action_plan` STRING COMMENT 'Corrective action plan',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `ncr_date` DATE COMMENT 'NCR date',
    `ncr_number` STRING COMMENT 'NCR number',
    `ncr_status` STRING COMMENT 'Status: open, in progress, closed',
    `nonconformance_description` STRING COMMENT 'Nonconformance description',
    `severity` STRING COMMENT 'Severity: minor, major, critical',
    `spec_section_reference` STRING COMMENT 'Specification section reference',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_nonconformance_report PRIMARY KEY(`nonconformance_report_id`)
) COMMENT 'Nonconformance report documenting deviations from specifications';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` (
    `commissioning_activity_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'CIP project',
    `employee_id` BIGINT COMMENT 'Performing employee',
    `commissioning_witnessed_by_employee_id` BIGINT COMMENT 'Witnessing employee',
    `registry_id` BIGINT COMMENT 'Asset being commissioned',
    `activity_date` DATE COMMENT 'Activity date',
    `activity_name` STRING COMMENT 'Activity name',
    `activity_status` STRING COMMENT 'Status: planned, in progress, completed',
    `activity_type` STRING COMMENT 'Type: functional test, performance test, training',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `pass_fail_status` STRING COMMENT 'Pass/fail status',
    `test_results` STRING COMMENT 'Test results',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_commissioning_activity PRIMARY KEY(`commissioning_activity_id`)
) COMMENT 'Commissioning activity tracking startup and performance testing';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` (
    `asset_handover_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Operations manager',
    `asset_project_manager_employee_id` BIGINT COMMENT 'Project manager',
    `cip_project_id` BIGINT COMMENT 'CIP project',
    `registry_id` BIGINT COMMENT 'Asset being handed over',
    `as_built_drawings_provided_flag` BOOLEAN COMMENT 'As-built drawings provided flag',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `handover_date` DATE COMMENT 'Handover date',
    `handover_status` STRING COMMENT 'Status: pending, in progress, completed',
    `handover_type` STRING COMMENT 'Type: substantial completion, final completion',
    `om_manuals_provided_flag` BOOLEAN COMMENT 'O&M manuals provided flag',
    `training_completed_flag` BOOLEAN COMMENT 'Training completed flag',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `warranty_documents_provided_flag` BOOLEAN COMMENT 'Warranty documents provided flag',
    CONSTRAINT pk_asset_handover PRIMARY KEY(`asset_handover_id`)
) COMMENT 'Asset handover from project to operations tracking transfer of completed assets';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`funding_source` (
    `funding_source_id` BIGINT COMMENT 'Primary key',
    `debt_instrument_id` BIGINT COMMENT 'Debt instrument if applicable',
    `fund_id` BIGINT COMMENT 'Fund',
    `grant_id` BIGINT COMMENT 'Grant if applicable',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `restrictions` STRING COMMENT 'Restrictions on use',
    `source_name` STRING COMMENT 'Source name',
    `source_status` STRING COMMENT 'Status: proposed, approved, available, exhausted',
    `source_type` STRING COMMENT 'Type: grant, bond, loan, rate revenue, developer contribution',
    `total_amount` DECIMAL(18,2) COMMENT 'Total amount',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_funding_source PRIMARY KEY(`funding_source_id`)
) COMMENT 'Funding source tracking sources of project financing';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` (
    `funding_allocation_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'CIP project',
    `funding_source_id` BIGINT COMMENT 'Funding source',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Allocated amount',
    `allocation_date` DATE COMMENT 'Allocation date',
    `allocation_status` STRING COMMENT 'Status: proposed, approved, committed, spent',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_funding_allocation PRIMARY KEY(`funding_allocation_id`)
) COMMENT 'Funding allocation linking funding sources to projects';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` (
    `land_acquisition_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'CIP project',
    `parcel_id` BIGINT COMMENT 'Parcel',
    `acquisition_date` DATE COMMENT 'Acquisition date',
    `acquisition_status` STRING COMMENT 'Status: negotiation, appraisal, closing, completed',
    `acquisition_type` STRING COMMENT 'Type: fee simple, easement, right-of-way',
    `appraised_value` DECIMAL(18,2) COMMENT 'Appraised value',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `purchase_price` DECIMAL(18,2) COMMENT 'Purchase price',
    `seller_name` STRING COMMENT 'Seller name',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_land_acquisition PRIMARY KEY(`land_acquisition_id`)
) COMMENT 'Land acquisition tracking real estate purchases for projects';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`risk` (
    `risk_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'CIP project',
    `employee_id` BIGINT COMMENT 'Risk owner employee',
    `cancer_risk_probability` DECIMAL(18,2) COMMENT 'Incremental lifetime cancer risk',
    `risk_category` STRING COMMENT 'Category: technical, schedule, cost, regulatory',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `risk_description` STRING COMMENT 'Risk description',
    `ecological_risk_quotient` DECIMAL(18,2) COMMENT 'Ecological risk quotient (exposure/toxicity)',
    `exposure_pathway_risk` STRING COMMENT 'Exposure pathway: drinking_water, soil, air, food_chain',
    `hazard_quotient` DECIMAL(18,2) COMMENT 'Hazard quotient (exposure/RfD)',
    `impact` STRING COMMENT 'Impact: low, medium, high',
    `mitigation_strategy` STRING COMMENT 'Mitigation strategy',
    `ontology_class` STRING COMMENT 'Ontology: technical, regulatory, financial, environmental, health',
    `pfas_related_risk_flag` BOOLEAN COMMENT 'Risk related to PFAS contamination or treatment',
    `probability` STRING COMMENT 'Probability: low, medium, high',
    `receptor_at_risk` STRING COMMENT 'Receptor: human_population, aquatic_life, terrestrial_wildlife',
    `regulatory_compliance_risk_score` DECIMAL(18,2) COMMENT 'Risk score for regulatory non-compliance (0-10)',
    `risk_number` STRING COMMENT 'Risk number',
    `risk_status` STRING COMMENT 'Status: identified, mitigated, realized, closed',
    `score` DECIMAL(18,2) COMMENT 'Risk score',
    `treatment_technology_failure_risk` STRING COMMENT 'Risk of treatment technology failure (GAC breakthrough, membrane fouling)',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_risk PRIMARY KEY(`risk_id`)
) COMMENT 'Project risk tracking identified risks and mitigation strategies';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`issue` (
    `issue_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'CIP project',
    `employee_id` BIGINT COMMENT 'Assigned employee',
    `issue_reported_by_employee_id` BIGINT COMMENT 'Reporting employee',
    `issue_category` STRING COMMENT 'Category: technical, schedule, cost, safety',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `issue_description` STRING COMMENT 'Issue description',
    `due_date` DATE COMMENT 'Due date',
    `issue_number` STRING COMMENT 'Issue number',
    `issue_status` STRING COMMENT 'Status: open, in progress, resolved, closed',
    `priority` STRING COMMENT 'Priority: low, medium, high, critical',
    `reported_date` DATE COMMENT 'Reported date',
    `resolution_date` DATE COMMENT 'Resolution date',
    `resolution_description` STRING COMMENT 'Resolution description',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_issue PRIMARY KEY(`issue_id`)
) COMMENT 'Project issue tracking problems requiring resolution';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` (
    `closeout_record_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'CIP project',
    `as_built_drawings_received_flag` BOOLEAN COMMENT 'As-built drawings received flag',
    `closeout_date` DATE COMMENT 'Closeout date',
    `closeout_status` STRING COMMENT 'Status: in progress, completed',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `final_completion_date` DATE COMMENT 'Final completion date',
    `final_cost` DECIMAL(18,2) COMMENT 'Final cost',
    `final_payment_made_flag` BOOLEAN COMMENT 'Final payment made flag',
    `lessons_learned` STRING COMMENT 'Lessons learned',
    `om_manuals_received_flag` BOOLEAN COMMENT 'O&M manuals received flag',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `warranties_received_flag` BOOLEAN COMMENT 'Warranties received flag',
    CONSTRAINT pk_closeout_record PRIMARY KEY(`closeout_record_id`)
) COMMENT 'Project closeout record documenting project completion and final deliverables';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`punch_list` (
    `punch_list_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'CIP project',
    `construction_contract_id` BIGINT COMMENT 'Construction contract',
    `employee_id` BIGINT COMMENT 'Identifying employee',
    `punch_verified_by_employee_id` BIGINT COMMENT 'Verifying employee',
    `completion_date` DATE COMMENT 'Completion date',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `due_date` DATE COMMENT 'Due date',
    `identified_date` DATE COMMENT 'Identified date',
    `item_description` STRING COMMENT 'Item description',
    `item_number` STRING COMMENT 'Item number',
    `item_status` STRING COMMENT 'Status: open, in progress, completed, verified',
    `location` STRING COMMENT 'Location',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_punch_list PRIMARY KEY(`punch_list_id`)
) COMMENT 'Punch list tracking minor deficiencies requiring correction before final acceptance';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` (
    `project_schedule_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'CIP project',
    `baseline_flag` BOOLEAN COMMENT 'Baseline flag',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `critical_path_duration_days` STRING COMMENT 'Critical path duration in days',
    `project_finish_date` DATE COMMENT 'Project finish date',
    `project_start_date` DATE COMMENT 'Project start date',
    `schedule_date` DATE COMMENT 'Schedule date',
    `schedule_status` STRING COMMENT 'Status: draft, baseline, current, superseded',
    `schedule_version` STRING COMMENT 'Schedule version',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_project_schedule PRIMARY KEY(`project_schedule_id`)
) COMMENT 'Project schedule tracking project timeline and task dependencies';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_parent_wbs_element_id` FOREIGN KEY (`parent_wbs_element_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ADD CONSTRAINT `fk_project_budget_amendment_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ADD CONSTRAINT `fk_project_budget_amendment_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_design_contract_id` FOREIGN KEY (`design_contract_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`design_contract`(`design_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ADD CONSTRAINT `fk_project_pay_application_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ADD CONSTRAINT `fk_project_project_permit_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ADD CONSTRAINT `fk_project_design_submittal_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ADD CONSTRAINT `fk_project_design_submittal_design_contract_id` FOREIGN KEY (`design_contract_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`design_contract`(`design_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ADD CONSTRAINT `fk_project_construction_submittal_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ADD CONSTRAINT `fk_project_construction_submittal_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ADD CONSTRAINT `fk_project_request_for_information_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ADD CONSTRAINT `fk_project_request_for_information_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ADD CONSTRAINT `fk_project_nonconformance_report_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ADD CONSTRAINT `fk_project_nonconformance_report_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ADD CONSTRAINT `fk_project_funding_allocation_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ADD CONSTRAINT `fk_project_funding_allocation_funding_source_id` FOREIGN KEY (`funding_source_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`funding_source`(`funding_source_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ADD CONSTRAINT `fk_project_land_acquisition_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ADD CONSTRAINT `fk_project_risk_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ADD CONSTRAINT `fk_project_issue_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ADD CONSTRAINT `fk_project_closeout_record_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ADD CONSTRAINT `fk_project_punch_list_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ADD CONSTRAINT `fk_project_punch_list_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ADD CONSTRAINT `fk_project_project_schedule_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`project` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`project` SET TAGS ('dbx_domain' = 'project');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` SET TAGS ('dbx_subdomain' = 'portfolio_planning');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` SET TAGS ('dbx_capital' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` SET TAGS ('dbx_infrastructure' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` SET TAGS ('dbx_planning' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `grant_funded_flag` SET TAGS ('dbx_business_glossary_term' = 'Grant Funded');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `project_category` SET TAGS ('dbx_business_glossary_term' = 'Project Category');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `project_number` SET TAGS ('dbx_business_glossary_term' = 'Project Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `regulatory_driver` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Driver');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `total_actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Actual Cost');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` SET TAGS ('dbx_subdomain' = 'portfolio_planning');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` SET TAGS ('dbx_wbs' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` SET TAGS ('dbx_work_breakdown' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` SET TAGS ('dbx_structure' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'WBS Element ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `parent_wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Parent WBS Element');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'WBS Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_description` SET TAGS ('dbx_business_glossary_term' = 'WBS Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_level` SET TAGS ('dbx_business_glossary_term' = 'WBS Level');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_name` SET TAGS ('dbx_business_glossary_term' = 'WBS Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` SET TAGS ('dbx_subdomain' = 'portfolio_planning');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` SET TAGS ('dbx_milestone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` SET TAGS ('dbx_schedule' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` SET TAGS ('dbx_deliverable' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'WBS Element');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` SET TAGS ('dbx_subdomain' = 'portfolio_planning');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` SET TAGS ('dbx_budget' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` SET TAGS ('dbx_appropriation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` SET TAGS ('dbx_deprecated' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` SET TAGS ('dbx_ssot_reference' = 'finance.finance_budget');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Reference to single source of truth in finance.finance_budget');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `original_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Budget');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `revised_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budget');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` SET TAGS ('dbx_subdomain' = 'portfolio_planning');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` SET TAGS ('dbx_budget' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` SET TAGS ('dbx_amendment' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` SET TAGS ('dbx_change' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `budget_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Amendment ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `amendment_amount` SET TAGS ('dbx_business_glossary_term' = 'Amendment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Justification');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` SET TAGS ('dbx_contract' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` SET TAGS ('dbx_design' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` SET TAGS ('dbx_engineering' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `design_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Design Contract ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `contract_amount` SET TAGS ('dbx_business_glossary_term' = 'Contract Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `scope_of_work` SET TAGS ('dbx_business_glossary_term' = 'Scope of Work');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` SET TAGS ('dbx_contract' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` SET TAGS ('dbx_construction' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` SET TAGS ('dbx_contractor' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Contract ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `contract_amount` SET TAGS ('dbx_business_glossary_term' = 'Contract Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `final_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Final Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `payment_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Bond Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `performance_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `retainage_percent` SET TAGS ('dbx_business_glossary_term' = 'Retainage Percent');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `substantial_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Substantial Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` SET TAGS ('dbx_change_order' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` SET TAGS ('dbx_contract_modification' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` SET TAGS ('dbx_scope_change' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Change Order ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Contract');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `design_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Design Contract');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Change Order Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `change_order_date` SET TAGS ('dbx_business_glossary_term' = 'Change Order Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Change Order Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `change_order_status` SET TAGS ('dbx_business_glossary_term' = 'Change Order Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `change_order_type` SET TAGS ('dbx_business_glossary_term' = 'Change Order Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Justification');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `time_extension_days` SET TAGS ('dbx_business_glossary_term' = 'Time Extension Days');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` SET TAGS ('dbx_payment' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` SET TAGS ('dbx_invoice' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` SET TAGS ('dbx_progress_payment' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `pay_application_id` SET TAGS ('dbx_business_glossary_term' = 'Pay Application ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Contract');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `materials_stored_amount` SET TAGS ('dbx_business_glossary_term' = 'Materials Stored Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `retainage_amount` SET TAGS ('dbx_business_glossary_term' = 'Retainage Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `total_earned_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Earned Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `work_completed_amount` SET TAGS ('dbx_business_glossary_term' = 'Work Completed Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` SET TAGS ('dbx_cost' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` SET TAGS ('dbx_transaction' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` SET TAGS ('dbx_expenditure' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `cost_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Transaction ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'WBS Element');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `cost_transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` SET TAGS ('dbx_permit' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` SET TAGS ('dbx_regulatory' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` SET TAGS ('dbx_approval' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` SET TAGS ('dbx_deprecated' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` SET TAGS ('dbx_ssot_reference' = 'compliance.compliance_permit');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` SET TAGS ('dbx_ssot_entity' = 'permit');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `project_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Project Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Reference to single source of truth in compliance.compliance_permit');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `permit_description` SET TAGS ('dbx_business_glossary_term' = 'Permit Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `permit_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Permit Fee Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` SET TAGS ('dbx_submittal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` SET TAGS ('dbx_design' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` SET TAGS ('dbx_deliverable' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `design_submittal_id` SET TAGS ('dbx_business_glossary_term' = 'Design Submittal ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `design_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Design Contract');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `submittal_date` SET TAGS ('dbx_business_glossary_term' = 'Submittal Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `submittal_name` SET TAGS ('dbx_business_glossary_term' = 'Submittal Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `submittal_number` SET TAGS ('dbx_business_glossary_term' = 'Submittal Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `submittal_type` SET TAGS ('dbx_business_glossary_term' = 'Submittal Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` SET TAGS ('dbx_submittal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` SET TAGS ('dbx_construction' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` SET TAGS ('dbx_shop_drawing' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `construction_submittal_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Submittal ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Contract');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `spec_section` SET TAGS ('dbx_business_glossary_term' = 'Spec Section');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `submittal_date` SET TAGS ('dbx_business_glossary_term' = 'Submittal Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `submittal_name` SET TAGS ('dbx_business_glossary_term' = 'Submittal Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `submittal_number` SET TAGS ('dbx_business_glossary_term' = 'Submittal Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `submittal_type` SET TAGS ('dbx_business_glossary_term' = 'Submittal Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` SET TAGS ('dbx_rfi' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` SET TAGS ('dbx_clarification' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` SET TAGS ('dbx_question' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ALTER COLUMN `request_for_information_id` SET TAGS ('dbx_business_glossary_term' = 'RFI ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Contract');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responded By');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ALTER COLUMN `request_submitted_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ALTER COLUMN `request_submitted_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ALTER COLUMN `request_submitted_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ALTER COLUMN `cost_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ALTER COLUMN `rfi_number` SET TAGS ('dbx_business_glossary_term' = 'RFI Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ALTER COLUMN `rfi_question` SET TAGS ('dbx_business_glossary_term' = 'RFI Question');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ALTER COLUMN `rfi_response` SET TAGS ('dbx_business_glossary_term' = 'RFI Response');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ALTER COLUMN `rfi_status` SET TAGS ('dbx_business_glossary_term' = 'RFI Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ALTER COLUMN `rfi_subject` SET TAGS ('dbx_business_glossary_term' = 'RFI Subject');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ALTER COLUMN `schedule_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Submitted Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` SET TAGS ('dbx_inspection' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` SET TAGS ('dbx_quality' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` SET TAGS ('dbx_field_report' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `inspection_report_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Contract');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `contractor_personnel_count` SET TAGS ('dbx_business_glossary_term' = 'Contractor Personnel Count');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `deficiencies_noted` SET TAGS ('dbx_business_glossary_term' = 'Deficiencies Noted');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `work_observed` SET TAGS ('dbx_business_glossary_term' = 'Work Observed');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` SET TAGS ('dbx_ncr' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` SET TAGS ('dbx_deficiency' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` SET TAGS ('dbx_quality' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'NCR ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Contract');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `ncr_date` SET TAGS ('dbx_business_glossary_term' = 'NCR Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `ncr_number` SET TAGS ('dbx_business_glossary_term' = 'NCR Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `ncr_status` SET TAGS ('dbx_business_glossary_term' = 'NCR Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `nonconformance_description` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `spec_section_reference` SET TAGS ('dbx_business_glossary_term' = 'Spec Section Reference');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` SET TAGS ('dbx_commissioning' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` SET TAGS ('dbx_startup' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` SET TAGS ('dbx_testing' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `commissioning_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Activity ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Performed By');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `commissioning_witnessed_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Witnessed By');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `commissioning_witnessed_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `commissioning_witnessed_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `activity_date` SET TAGS ('dbx_business_glossary_term' = 'Activity Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `activity_name` SET TAGS ('dbx_business_glossary_term' = 'Activity Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `test_results` SET TAGS ('dbx_business_glossary_term' = 'Test Results');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` SET TAGS ('dbx_subdomain' = 'closeout_transition');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` SET TAGS ('dbx_handover' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` SET TAGS ('dbx_turnover' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` SET TAGS ('dbx_closeout' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `asset_handover_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Handover ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operations Manager');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `asset_project_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `asset_project_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `asset_project_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `as_built_drawings_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'As-Built Drawings Provided');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `handover_date` SET TAGS ('dbx_business_glossary_term' = 'Handover Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `handover_status` SET TAGS ('dbx_business_glossary_term' = 'Handover Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `handover_type` SET TAGS ('dbx_business_glossary_term' = 'Handover Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `om_manuals_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'O&M Manuals Provided');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `training_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Completed');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `warranty_documents_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Documents Provided');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` SET TAGS ('dbx_subdomain' = 'portfolio_planning');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` SET TAGS ('dbx_funding' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` SET TAGS ('dbx_finance' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` SET TAGS ('dbx_source' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Source ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `debt_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Instrument');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `restrictions` SET TAGS ('dbx_business_glossary_term' = 'Restrictions');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `source_name` SET TAGS ('dbx_business_glossary_term' = 'Source Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `source_status` SET TAGS ('dbx_business_glossary_term' = 'Source Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Source Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` SET TAGS ('dbx_subdomain' = 'portfolio_planning');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` SET TAGS ('dbx_funding' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` SET TAGS ('dbx_allocation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` SET TAGS ('dbx_appropriation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `funding_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Allocation ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` SET TAGS ('dbx_subdomain' = 'portfolio_planning');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` SET TAGS ('dbx_land' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` SET TAGS ('dbx_acquisition' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` SET TAGS ('dbx_real_estate' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `land_acquisition_id` SET TAGS ('dbx_business_glossary_term' = 'Land Acquisition ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `acquisition_status` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `acquisition_type` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `appraised_value` SET TAGS ('dbx_business_glossary_term' = 'Appraised Value');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `purchase_price` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `seller_name` SET TAGS ('dbx_business_glossary_term' = 'Seller Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` SET TAGS ('dbx_subdomain' = 'portfolio_planning');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` SET TAGS ('dbx_risk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` SET TAGS ('dbx_risk_management' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` SET TAGS ('dbx_mitigation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `risk_id` SET TAGS ('dbx_business_glossary_term' = 'Risk ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `impact` SET TAGS ('dbx_business_glossary_term' = 'Impact');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `mitigation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Strategy');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `probability` SET TAGS ('dbx_business_glossary_term' = 'Probability');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `risk_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `risk_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `treatment_technology_failure_risk` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `treatment_technology_failure_risk` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` SET TAGS ('dbx_subdomain' = 'portfolio_planning');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` SET TAGS ('dbx_issue' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` SET TAGS ('dbx_problem' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` SET TAGS ('dbx_action_item' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `issue_id` SET TAGS ('dbx_business_glossary_term' = 'Issue ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `issue_reported_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `issue_reported_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `issue_reported_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `issue_category` SET TAGS ('dbx_business_glossary_term' = 'Issue Category');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `issue_description` SET TAGS ('dbx_business_glossary_term' = 'Issue Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `issue_number` SET TAGS ('dbx_business_glossary_term' = 'Issue Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `issue_status` SET TAGS ('dbx_business_glossary_term' = 'Issue Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` SET TAGS ('dbx_subdomain' = 'closeout_transition');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` SET TAGS ('dbx_closeout' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` SET TAGS ('dbx_completion' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` SET TAGS ('dbx_final' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `closeout_record_id` SET TAGS ('dbx_business_glossary_term' = 'Closeout Record ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `as_built_drawings_received_flag` SET TAGS ('dbx_business_glossary_term' = 'As-Built Drawings Received');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `closeout_date` SET TAGS ('dbx_business_glossary_term' = 'Closeout Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `closeout_status` SET TAGS ('dbx_business_glossary_term' = 'Closeout Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `final_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Final Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `final_cost` SET TAGS ('dbx_business_glossary_term' = 'Final Cost');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `final_payment_made_flag` SET TAGS ('dbx_business_glossary_term' = 'Final Payment Made');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `om_manuals_received_flag` SET TAGS ('dbx_business_glossary_term' = 'O&M Manuals Received');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `warranties_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranties Received');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` SET TAGS ('dbx_punch_list' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` SET TAGS ('dbx_deficiency' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` SET TAGS ('dbx_completion' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `punch_list_id` SET TAGS ('dbx_business_glossary_term' = 'Punch List ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Contract');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Identified By');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `punch_verified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `punch_verified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `punch_verified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Identified Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `item_number` SET TAGS ('dbx_business_glossary_term' = 'Item Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `item_status` SET TAGS ('dbx_business_glossary_term' = 'Item Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Location');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` SET TAGS ('dbx_subdomain' = 'portfolio_planning');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` SET TAGS ('dbx_schedule' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` SET TAGS ('dbx_timeline' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` SET TAGS ('dbx_gantt' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ALTER COLUMN `project_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Project Schedule ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ALTER COLUMN `baseline_flag` SET TAGS ('dbx_business_glossary_term' = 'Baseline Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ALTER COLUMN `critical_path_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Duration');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ALTER COLUMN `project_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Project Finish Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ALTER COLUMN `schedule_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ALTER COLUMN `schedule_version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
