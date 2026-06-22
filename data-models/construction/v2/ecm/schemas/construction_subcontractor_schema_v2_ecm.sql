-- Schema for Domain: subcontractor | Business:  | Version: v2_ecm
-- Generated on: 2026-06-22 15:33:35

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`subcontractor` COMMENT 'Subcontractor and specialty trade management domain governing relationships with MEP (Mechanical Electrical Plumbing) contractors, civil works subcontractors, and specialty vendors. Owns subcontractor profiles, prequalification records, trade packages, scope-of-work agreements, insurance compliance certificates, performance scorecards, and payment applications. Distinct from procurement which owns the PO/award process.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` (
    `subcontractor_change_order_id` BIGINT COMMENT 'Unique identifier for the subcontractor change order record. Primary key.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this subcontractor change order is issued.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Allocates change order costs to the responsible cost center for accurate cost‑center reporting.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Links change orders to cost codes to capture cost accounting impacts of contract modifications.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Change Order Initiation is recorded by the employee who raises it; required for audit trail and approval workflow.',
    `subcontract_id` BIGINT COMMENT 'Reference to the parent subcontract agreement that this change order modifies.',
    `contract_change_order_id` BIGINT COMMENT 'Reference to the head contract change order that triggered or is linked to this subcontractor change order, where applicable.',
    `subcontractor_contract_change_order_ref_contract_change_order_id` BIGINT COMMENT 'Reference to single source of truth contract.contract_change_order (SSOT duplicate resolution).',
    `project_change_order_id` BIGINT COMMENT '',
    `subcontractor_project_change_order_ref_project_change_order_id` BIGINT COMMENT 'Reference to single source of truth project.project_change_order (SSOT duplicate resolution).',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element under which this change order scope is organized and tracked.',
    `approval_date` DATE COMMENT 'The date on which the change order was formally approved by the approving authority, in yyyy-MM-dd format. Null if not yet approved.',
    `approval_status` STRING COMMENT 'Current lifecycle status of the change order in the approval workflow: draft, submitted, under review, approved, rejected, or withdrawn.. Valid values are `draft|submitted|under_review|approved|rejected|withdrawn`',
    `approving_authority` STRING COMMENT 'Name or title of the individual or role who approved the change order (e.g., Project Manager, Contracts Manager, Client Representative).',
    `change_amount` DECIMAL(18,2) COMMENT 'The net financial impact of this change order on the subcontract value. Positive for additions, negative for reductions, in the contract currency.',
    `change_type` STRING COMMENT 'Classification of the change order by its primary impact: scope addition, scope reduction, acceleration, schedule extension (EOT), rate adjustment, or other.. Valid values are `scope_addition|scope_reduction|acceleration|schedule_extension|rate_adjustment|other`',
    `co_description` STRING COMMENT 'Detailed narrative describing the scope, rationale, and impact of the change order on the subcontract.',
    `co_number` STRING COMMENT 'The externally-known business identifier for this subcontractor change order, typically formatted per project numbering conventions.',
    `co_title` STRING COMMENT 'Short descriptive title summarizing the nature of the change order.',
    `contingency_allocation` DECIMAL(18,2) COMMENT 'Amount of project contingency budget allocated to cover this change order, in the contract currency. Null if not funded from contingency.',
    `cost_code` STRING COMMENT 'Project cost code or cost account to which the change order financial impact is allocated for job costing and financial tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this change order record was first created in the system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this change order.. Valid values are `^[A-Z]{3}$`',
    `subcontractor_change_order_description` STRING COMMENT '',
    `document_reference` STRING COMMENT 'Reference number or identifier of the formal change order document, drawing, or specification that supports this change order.',
    `execution_completion_date` DATE COMMENT 'The date on which work on the change order scope was completed on site, in yyyy-MM-dd format. Null if not yet completed.',
    `execution_start_date` DATE COMMENT 'The date on which work on the change order scope commenced on site, in yyyy-MM-dd format. Null if not yet started.',
    `execution_status` STRING COMMENT 'Current status of the physical execution of the change order work: not started, in progress, completed, or on hold.. Valid values are `not_started|in_progress|completed|on_hold`',
    `is_back_charge` BOOLEAN COMMENT 'Boolean flag indicating whether this change order represents a back charge to the subcontractor for defective work, delays, or other contractual breaches. True if back charge, False otherwise.',
    `is_time_and_material` BOOLEAN COMMENT 'Boolean flag indicating whether this change order is priced on a time-and-material basis rather than lump sum. True if T&M, False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this change order record was last updated in the system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `notes` STRING COMMENT 'Free-text field for additional comments, clarifications, or internal notes related to the change order.',
    `original_completion_date` DATE COMMENT 'The subcontract completion date before this change order is applied, in yyyy-MM-dd format.',
    `original_contract_value` DECIMAL(18,2) COMMENT 'The baseline subcontract value before this change order is applied, in the contract currency.',
    `reason_code` STRING COMMENT 'Standardized code indicating the root cause or reason for issuing the change order: design change, unforeseen site condition, client request, regulatory requirement, error or omission, force majeure, or other.. Valid values are `design_change|site_condition|client_request|regulatory_requirement|error_omission|force_majeure`',
    `reason_description` STRING COMMENT 'Detailed explanation of the circumstances and justification for the change order.',
    `rejection_reason` STRING COMMENT 'Explanation provided when the change order is rejected, detailing the grounds for rejection. Null if not rejected.',
    `remarks` STRING COMMENT '',
    `revised_completion_date` DATE COMMENT 'The updated subcontract completion date after applying this change order, in yyyy-MM-dd format.',
    `revised_contract_value` DECIMAL(18,2) COMMENT 'The updated subcontract value after applying this change order, calculated as original contract value plus change amount, in the contract currency.',
    `schedule_impact_days` STRING COMMENT 'Number of calendar days by which the subcontract completion date is extended (positive) or accelerated (negative) as a result of this change order. Zero if no schedule impact.',
    `subcontractor_change_order_status` STRING COMMENT '',
    `submission_date` DATE COMMENT 'The date on which the change order was formally submitted for review and approval, in yyyy-MM-dd format.',
    `trade_package` STRING COMMENT 'The trade or specialty package to which this change order applies (e.g., MEP, civil works, structural steel, concrete, finishes).',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_subcontractor_change_order PRIMARY KEY(`subcontractor_change_order_id`)
) COMMENT 'Change order records issued to subcontractors modifying the original subcontract scope, value, or schedule. Captures CO number, change type (scope addition, scope reduction, acceleration, EOT), reason code, original contract value, change amount, revised contract value, submission date, approval status, approving authority, and linkage to the head contract CO where applicable. Tracks the full change order lifecycle from initiation through execution. SSOT: authoritative source is contract.contract_change_order.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` (
    `back_charge_id` BIGINT COMMENT 'Primary key for back_charge',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project where the back-charge event occurred. Links to the project master record.',
    `cost_account_id` BIGINT COMMENT 'Reference to the cost account or cost code to which this back-charge is allocated for job costing and financial tracking.',
    `payment_certificate_id` BIGINT COMMENT 'Reference to the payment certificate or payment application in which the back-charge deduction was applied. Links to the subcontractor payment record. Nullable if not yet deducted.',
    `employee_id` BIGINT COMMENT 'Reference to the user (project manager, site manager, or contracts administrator) who issued the back-charge notice. Links to the user or team member record.',
    `subcontract_id` BIGINT COMMENT 'Reference to the subcontract agreement under which this back-charge is raised. Links to the subcontract master record.',
    `approval_date` DATE COMMENT 'Date on which the back-charge was formally approved for deduction by the authorized approver. Nullable if not yet approved.',
    `approved_amount` DECIMAL(18,2) COMMENT 'Final approved amount of the back-charge after any dispute resolution or negotiation. May differ from the total claimed amount if partially accepted or negotiated down.',
    `back_charge_number` STRING COMMENT 'Externally visible unique business identifier for the back-charge record, typically formatted per company standards (e.g., BC-2024-001234). Used in correspondence and payment deductions.',
    `back_charge_status` STRING COMMENT 'Current lifecycle status of the back-charge record. Tracks progression from draft through issuance, dispute resolution, approval, and final deduction or closure. [ENUM-REF-CANDIDATE: draft|issued|acknowledged|disputed|under_review|approved|rejected|deducted|closed|cancelled — 10 candidates stripped; promote to reference product]',
    `charge_amount` DECIMAL(18,2) COMMENT '',
    `charge_reason` STRING COMMENT '',
    `charge_status` STRING COMMENT '',
    `closure_date` DATE COMMENT 'Date on which the back-charge record was closed, indicating that all financial recovery and dispute resolution activities are complete. Nullable if still open.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this back-charge record was first created in the system. Audit trail field for data governance and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this back-charge record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deduction_applied_amount` DECIMAL(18,2) COMMENT 'Actual amount deducted from subcontractor payment certification or final account as a result of this back-charge. Reflects the financial recovery achieved.',
    `deduction_date` DATE COMMENT 'Date on which the back-charge amount was deducted from the subcontractors payment. Nullable if deduction has not yet occurred.',
    `back_charge_description` STRING COMMENT '',
    `dispute_date` DATE COMMENT 'Date on which the subcontractor formally raised a dispute against the back-charge. Nullable if no dispute was raised.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator of whether the subcontractor has formally disputed this back-charge. True indicates an active or resolved dispute; False indicates acceptance or no dispute raised.',
    `dispute_reason` STRING COMMENT 'Subcontractors stated reason for disputing the back-charge. Captures the basis of disagreement (e.g., work was not defective, damage was pre-existing, cost is excessive, liability is disputed).',
    `equipment_cost_amount` DECIMAL(18,2) COMMENT 'Total equipment cost component of the back-charge, representing the cost of equipment usage (owned or rented) deployed to remedy the subcontractor default.',
    `incident_date` DATE COMMENT 'Date on which the event or condition giving rise to the back-charge occurred (e.g., date of damage, date defective work was discovered, date of cleanup failure).',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'Total labor cost component of the back-charge, representing the cost of general contractor or third-party labor deployed to remedy the subcontractor default or defect.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this back-charge record was last updated. Audit trail field for data governance and change tracking.',
    `material_cost_amount` DECIMAL(18,2) COMMENT 'Total material cost component of the back-charge, representing the cost of materials consumed to remedy the subcontractor default or replace damaged materials.',
    `ncr_reference_number` STRING COMMENT 'Reference number of the associated Non-Conformance Report (NCR) that documented the quality defect or deficiency giving rise to this back-charge. Nullable if no formal NCR was raised.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or internal observations related to the back-charge. Used for audit trail and knowledge capture.',
    `notification_date` DATE COMMENT 'Date on which the back-charge notice was formally issued to the subcontractor. Establishes the start of the response period per contract terms.',
    `overhead_cost_amount` DECIMAL(18,2) COMMENT 'Overhead and indirect cost component of the back-charge, including administrative costs, supervision, and markup applied per contract terms.',
    `reason_code` STRING COMMENT 'Categorical code identifying the primary reason for the back-charge. Common reasons include rework due to defective work, damage caused to other trades, failure to perform cleanup, schedule delays caused by subcontractor, safety violations, or third-party cost recovery. [ENUM-REF-CANDIDATE: rework|defective_work|damage_to_other_trades|cleanup_failure|schedule_impact|safety_violation|third_party_recovery|warranty_claim|material_waste|equipment_damage — 10 candidates stripped; promote to reference product]',
    `reason_description` STRING COMMENT 'Detailed narrative explanation of the circumstances and events that led to the back-charge. Includes specifics of the subcontractor default, defective work details, or damage caused.',
    `remarks` STRING COMMENT '',
    `resolution_outcome` STRING COMMENT 'Final outcome of the back-charge after any dispute resolution process. Indicates whether the charge was accepted in full, partially accepted, rejected, settled through negotiation, or resolved via arbitration or litigation. [ENUM-REF-CANDIDATE: accepted_full|accepted_partial|rejected|negotiated_settlement|arbitration_awarded|litigation_settled|withdrawn — 7 candidates stripped; promote to reference product]',
    `response_deadline_date` DATE COMMENT 'Date by which the subcontractor must respond to the back-charge notice, either acknowledging the charge or raising a formal dispute. Typically contractually defined (e.g., 14 days from notification).',
    `site_instruction_number` STRING COMMENT 'Reference number of the site instruction issued to the subcontractor directing remedial action or documenting the default. Nullable if no formal site instruction was issued.',
    `supporting_documentation_path` STRING COMMENT 'File path or document management system reference to supporting documentation for the back-charge (photos, inspection reports, cost breakdowns, correspondence). Typically stored in Aconex or BIM 360 document control.',
    `total_claimed_amount` DECIMAL(18,2) COMMENT 'Total amount claimed in the back-charge, representing the sum of all cost components (labor, material, equipment, overhead) that the general contractor seeks to recover from the subcontractor.',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_back_charge PRIMARY KEY(`back_charge_id`)
) COMMENT 'Back-charge records raised against subcontractors for costs incurred by the general contractor due to subcontractor default, defective work, damage to other trades, cleanup failures, or failure to perform contractual obligations. Captures back-charge number, subcontract reference, reason code (rework, damage, cleanup, schedule impact, third-party recovery), cost breakdown (labor, material, equipment), amount claimed, notification date, response deadline, dispute status, resolution outcome, and deduction applied in payment certification. Enables cost recovery tracking and feeds final account reconciliation.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` (
    `subcontractor_eot_claim_id` BIGINT COMMENT 'Primary key for eot_claim',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project affected by this EOT claim.',
    `delay_event_id` BIGINT COMMENT '',
    `subcontract_id` BIGINT COMMENT 'Reference to the parent subcontract agreement under which this EOT claim is submitted.',
    `contract_eot_claim_id` BIGINT COMMENT 'Reference to single source of truth contract.contract_eot_claim (SSOT dedup).',
    `subcontractor_contract_eot_claim_ref_contract_eot_claim_id` BIGINT COMMENT 'Reference to single source of truth contract.contract_eot_claim (SSOT duplicate resolution).',
    `employee_id` BIGINT COMMENT '',
    `schedule_eot_claim_id` BIGINT COMMENT '',
    `subcontractor_schedule_eot_claim_ref_schedule_eot_claim_id` BIGINT COMMENT 'Reference to single source of truth schedule.schedule_eot_claim (SSOT duplicate resolution).',
    `subcontractor_submitted_by_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: EOT claim submission is logged by the employee who files it; required for claim processing workflow.',
    `approval_date` DATE COMMENT '',
    `approved_amount` DECIMAL(18,2) COMMENT '',
    `approved_days` STRING COMMENT '',
    `assessed_by` STRING COMMENT 'Name and role of the project team member or consultant who conducted the technical assessment of the EOT claim.',
    `assessment_date` DATE COMMENT '',
    `assessment_notes` STRING COMMENT '',
    `assessor_comments` STRING COMMENT '',
    `baseline_schedule_reference` STRING COMMENT 'Reference identifier for the approved baseline schedule used as the basis for delay analysis and EOT assessment.',
    `claim_amount` DECIMAL(18,2) COMMENT '',
    `claim_number` STRING COMMENT '',
    `claim_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this EOT claim for tracking and correspondence purposes.. Valid values are `^EOT-[A-Z0-9]{6,20}$`',
    `claim_status` STRING COMMENT 'Current lifecycle status of the EOT claim in the review and determination workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|assessed|approved|rejected|withdrawn — 7 candidates stripped; promote to reference product]',
    `claim_submission_method` STRING COMMENT 'Method or channel through which the subcontractor submitted the EOT claim to the main contractor.. Valid values are `electronic_portal|email|registered_mail|hand_delivery|courier`',
    `claim_type` STRING COMMENT '',
    `claimed_days` STRING COMMENT '',
    `concurrent_delay_flag` BOOLEAN COMMENT 'Indicates whether the delay event occurred concurrently with other delays for which the subcontractor is responsible, affecting EOT entitlement.',
    `contemporaneous_records_reference` STRING COMMENT 'Reference identifiers or document numbers for contemporaneous project records (daily logs, progress reports, site instructions, correspondence) supporting the EOT claim.',
    `cost_claim_associated_flag` DECIMAL(18,2) COMMENT 'Indicates whether the subcontractor has submitted or intends to submit a separate cost claim for prolongation costs associated with this delay event.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `critical_path_impact_flag` BOOLEAN COMMENT 'Indicates whether the delay event impacted activities on the project critical path, a key determinant of EOT entitlement.',
    `currency_code` STRING COMMENT '',
    `days_approved` STRING COMMENT '',
    `days_assessed` STRING COMMENT 'Number of calendar days of schedule extension determined by the project management team or contract administrator during the assessment process.',
    `days_claimed` STRING COMMENT 'Number of calendar days of schedule extension requested by the subcontractor in the EOT claim submission.',
    `days_granted` STRING COMMENT 'Number of calendar days of schedule extension formally approved and granted to the subcontractor, adjusting the contractual completion date.',
    `decision_date` DATE COMMENT '',
    `delay_cause` STRING COMMENT '',
    `delay_cause_category` STRING COMMENT 'Classification of the root cause of the delay event determining entitlement and risk allocation under the subcontract terms.. Valid values are `employer_risk|force_majeure|concurrent_delay|adverse_weather|design_change|variation_order`',
    `delay_cause_description` STRING COMMENT '',
    `delay_description` STRING COMMENT '',
    `delay_end_date` DATE COMMENT 'Date when the delay event ceased or was resolved, allowing work to resume on the affected activities.',
    `delay_event_description` STRING COMMENT 'Detailed narrative description of the delay event or circumstances that form the basis of the EOT claim, including impact on critical path activities.',
    `delay_start_date` DATE COMMENT 'Date when the delay event commenced and began impacting the subcontractors ability to meet contractual completion dates.',
    `subcontractor_eot_claim_description` STRING COMMENT '',
    `determination_authority` STRING COMMENT 'Name and role of the individual or entity authorized to make the determination decision on the EOT claim (e.g., Project Manager, Contract Administrator, Engineer).',
    `determination_date` DATE COMMENT 'Date when the contract administrator or project management office issued the formal determination decision on the EOT claim.',
    `determination_rationale` DECIMAL(18,2) COMMENT 'Detailed explanation and justification for the determination decision, including reasons for any variance between days claimed and days granted.',
    `dispute_status` STRING COMMENT 'Current status of any dispute arising from disagreement over the EOT claim determination.. Valid values are `no_dispute|under_negotiation|mediation|arbitration|litigation|resolved`',
    `entitlement_basis` STRING COMMENT '',
    `is_concurrent_delay` BOOLEAN COMMENT '',
    `is_critical` BOOLEAN COMMENT '',
    `is_critical_path` BOOLEAN COMMENT '',
    `ld_exposure_impact` STRING COMMENT 'Assessment of how the granted EOT affects the subcontractors exposure to liquidated damages for late completion.. Valid values are `eliminates_ld_exposure|reduces_ld_exposure|no_impact_on_ld|increases_ld_exposure`',
    `notes` STRING COMMENT '',
    `notice_compliance_flag` BOOLEAN COMMENT 'Indicates whether the subcontractor complied with contractual notice requirements and timelines, which may affect claim entitlement.',
    `notice_date` DATE COMMENT 'Date when the subcontractor provided initial notice of the delay event to the main contractor, as required by contract notice provisions.',
    `original_completion_date` DATE COMMENT 'Contractual completion date for the subcontract scope of work prior to any EOT adjustments.',
    `prolongation_cost_amount` DECIMAL(18,2) COMMENT '',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this EOT claim record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this EOT claim record was last modified in the system.',
    `remarks` STRING COMMENT '',
    `revised_completion_date` DATE COMMENT 'Adjusted contractual completion date after granting the EOT, calculated by adding granted days to the original or previously revised completion date.',
    `schedule_analysis_method` STRING COMMENT 'Methodology used to analyze the delay impact and quantify the time extension, following industry-standard delay analysis protocols.. Valid values are `time_impact_analysis|windows_analysis|as_planned_vs_as_built|collapsed_as_built|contemporaneous_period_analysis`',
    `subcontractor_eot_claim_status` STRING COMMENT '',
    `submission_date` DATE COMMENT 'Date when the subcontractor formally submitted the EOT claim to the main contractor or project management office.',
    `supporting_document_refs` STRING COMMENT '',
    `supporting_documentation_count` STRING COMMENT 'Number of supporting documents (schedules, correspondence, photos, reports) attached to the EOT claim submission.',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_subcontractor_eot_claim PRIMARY KEY(`subcontractor_eot_claim_id`)
) COMMENT 'Extension of Time (EOT) claims submitted by subcontractors seeking schedule relief from contractual completion dates due to excusable delay events. Captures claim reference, subcontract reference, delay event description, cause category (employer risk, force majeure, concurrent delay, weather, design change), days claimed, days assessed, days granted, contemporaneous records references, determination date, determination authority, and impact on liquidated damages exposure. Links to schedule domain for programme impact analysis. SSOT: authoritative source is contract.contract_eot_claim.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`final_account` (
    `final_account_id` BIGINT COMMENT 'Primary key for final_account',
    `agreement_id` BIGINT COMMENT '',
    `closeout_id` BIGINT COMMENT '',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this subcontract final account is settled.',
    `employee_id` BIGINT COMMENT '',
    `final_prepared_by_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Final account preparation is done by an employee; linking supports financial audit and sign‑off records.',
    `final_settled_by_employee_id` BIGINT COMMENT '',
    `payment_certificate_id` BIGINT COMMENT '',
    `subcontract_id` BIGINT COMMENT 'Reference to the parent subcontract for which this final account settlement is being prepared. Links to the subcontract master record.',
    `agreed_final_amount` DECIMAL(18,2) COMMENT '',
    `agreement_date` DATE COMMENT '',
    `approval_date` DATE COMMENT 'Date on which the final account was internally approved by the contractor before being presented to the subcontractor for agreement.',
    `approval_status` STRING COMMENT '',
    `approved_by` STRING COMMENT 'Name of the senior manager or project director who approved the final account for signature and settlement.',
    `approved_change_orders_value` DECIMAL(18,2) COMMENT '',
    `back_charge_total` DECIMAL(18,2) COMMENT '',
    `back_charges_value` DECIMAL(18,2) COMMENT '',
    `balance_due_amount` DECIMAL(18,2) COMMENT '',
    `certified_amount` DECIMAL(18,2) COMMENT '',
    `change_order_total` DECIMAL(18,2) COMMENT '',
    `claims_settled_value` DECIMAL(18,2) COMMENT 'Total value of subcontractor claims (for delays, disruptions, variations, or EOT-related costs) that were agreed and settled as part of the final account.',
    `contractor_signatory_name` STRING COMMENT 'Full name of the authorized representative from the general contractor (GC) who signed the final account settlement.',
    `contractor_signatory_title` STRING COMMENT 'Job title or role of the contractor signatory (e.g., Project Manager, Contracts Manager, Commercial Director).',
    `contractor_signature_date` DATE COMMENT 'Date on which the contractor signatory signed the final account document.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this final account record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this final account (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `defects_liability_period_end_date` DATE COMMENT 'The date on which the Defects Liability Period expires. Retention is typically released after this date and any defects are rectified.',
    `final_account_description` STRING COMMENT '',
    `dispute_amount` DECIMAL(18,2) COMMENT '',
    `dispute_flag` BOOLEAN COMMENT '',
    `dispute_reason` STRING COMMENT 'Description of the reason for dispute if the final account status is disputed. Captures the nature of disagreement (e.g., valuation of variations, back-charge validity, claim rejection).',
    `dispute_reference` STRING COMMENT '',
    `dispute_resolution_date` DATE COMMENT 'Date on which the dispute was formally resolved and the final account was agreed, if initially disputed.',
    `dispute_resolution_method` STRING COMMENT 'The method being used or planned to resolve the final account dispute, if applicable. Aligns with contract dispute resolution clauses.. Valid values are `negotiation|mediation|arbitration|litigation|adjudication|none`',
    `document_reference` STRING COMMENT 'Reference to the physical or digital final account settlement document stored in the document management system (e.g., Aconex document ID).',
    `eot_settlement_amount` DECIMAL(18,2) COMMENT '',
    `final_account_number` STRING COMMENT 'Business identifier for the final account settlement document. Typically follows organizational numbering convention (e.g., FA-2024-001234).',
    `final_account_status` STRING COMMENT 'Current lifecycle status of the final account settlement. Tracks progression from draft through agreement to closure or dispute resolution.. Valid values are `draft|under_review|agreed|disputed|closed|cancelled`',
    `final_agreed_value` DECIMAL(18,2) COMMENT 'The final settled contract value after all adjustments: original value plus approved COs plus claims minus back-charges minus LDs plus retention released. Represents the total financial close-out amount.',
    `final_amount` DECIMAL(18,2) COMMENT '',
    `final_payment_due_date` DECIMAL(18,2) COMMENT 'The contractual due date by which the final agreed value must be paid to the subcontractor. Typically defined in payment terms.',
    `final_payment_made_date` DECIMAL(18,2) COMMENT 'Actual date on which the final payment was made to the subcontractor. Confirms financial closure.',
    `final_payment_reference` DECIMAL(18,2) COMMENT 'Payment transaction reference or remittance advice number for the final payment. Links to accounts payable records.',
    `is_disputed` BOOLEAN COMMENT '',
    `is_final` BOOLEAN COMMENT '',
    `is_finalized` BOOLEAN COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this final account record was last updated. Audit trail for record modifications.',
    `ld_deduction_total` DECIMAL(18,2) COMMENT '',
    `liquidated_damages_deducted` DECIMAL(18,2) COMMENT 'Total liquidated damages deducted from the final account for delays or non-performance as per the subcontract terms.',
    `net_payable_amount` DECIMAL(18,2) COMMENT '',
    `notes` STRING COMMENT '',
    `original_contract_value` DECIMAL(18,2) COMMENT 'The initial awarded subcontract value before any change orders, variations, or adjustments. Baseline financial commitment.',
    `original_subcontract_value` DECIMAL(18,2) COMMENT '',
    `paid_to_date_amount` DECIMAL(18,2) COMMENT '',
    `performance_bond_release_date` DATE COMMENT 'Date on which the performance bond was formally released to the subcontractor or their surety.',
    `performance_bond_released` BOOLEAN COMMENT 'Indicates whether the subcontractor performance bond or guarantee has been released as part of the final account settlement. True if released, False if still held.',
    `release_of_retention_amount` DECIMAL(18,2) COMMENT '',
    `remarks` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to the final account settlement. Captures context not covered by structured fields.',
    `retention_balance` DECIMAL(18,2) COMMENT '',
    `retention_held_amount` DECIMAL(18,2) COMMENT '',
    `retention_released` DECIMAL(18,2) COMMENT 'Total retention amount released to the subcontractor upon satisfactory completion and expiry of the Defects Liability Period (DLP). Typically 5-10% of contract value.',
    `retention_released_amount` DECIMAL(18,2) COMMENT '',
    `settlement_date` DATE COMMENT 'The date on which the final account was formally agreed and signed by both parties. Marks the financial close-out milestone.',
    `settlement_status` STRING COMMENT '',
    `subcontractor_signatory_name` STRING COMMENT 'Full name of the authorized representative from the subcontractor who signed the final account settlement.',
    `subcontractor_signatory_title` STRING COMMENT 'Job title or role of the subcontractor signatory (e.g., Managing Director, Commercial Manager, Project Director).',
    `subcontractor_signature_date` DATE COMMENT 'Date on which the subcontractor signatory signed the final account document.',
    `submission_date` DATE COMMENT '',
    `total_approved_change_orders` DECIMAL(18,2) COMMENT 'Cumulative value of all approved change orders that increased or decreased the subcontract scope and value. Sum of all CO amounts.',
    `total_back_charges` DECIMAL(18,2) COMMENT 'Cumulative value of all back-charges levied against the subcontractor for defects, delays, rework, or other contractual breaches. Reduces final payment.',
    `total_certified_to_date` DECIMAL(18,2) COMMENT '',
    `total_paid_to_date` DECIMAL(18,2) COMMENT '',
    `total_variations_amount` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `value` DECIMAL(18,2) COMMENT '',
    `variance_amount` DECIMAL(18,2) COMMENT '',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_final_account PRIMARY KEY(`final_account_id`)
) COMMENT 'Final account settlement records for completed subcontracts, capturing the agreed final contract value after all change orders, back-charges, retention releases, and claims are resolved. Tracks original contract value, total approved change orders, total back-charges, final agreed value, settlement date, signatory details, and final account status (draft, agreed, disputed, closed). Represents the financial close-out milestone for each subcontract.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` (
    `performance_scorecard_id` BIGINT COMMENT '',
    `construction_project_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `performance_scorecard_description` STRING COMMENT '',
    `remarks` STRING COMMENT '',
    `performance_scorecard_status` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_performance_scorecard PRIMARY KEY(`performance_scorecard_id`)
) COMMENT 'performance scorecards evaluate subcontractor/vendor performance post-award, not during bidding';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_profile` (
    `subcontractor_profile_id` BIGINT COMMENT '',
    `construction_project_id` BIGINT COMMENT '',
    `subcontract_id` BIGINT COMMENT '',
    `vendor_id` BIGINT COMMENT '',
    `amount` DECIMAL(18,2) COMMENT '',
    `contact_email` STRING COMMENT '',
    `contact_phone` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `is_approved` BOOLEAN COMMENT '',
    `legal_entity_name` STRING COMMENT '',
    `legal_name` STRING COMMENT '',
    `notes` STRING COMMENT '',
    `prequalification_status` STRING COMMENT '',
    `primary_contact_name` STRING COMMENT '',
    `rating` STRING COMMENT '',
    `record_number` STRING COMMENT '',
    `record_status` STRING COMMENT '',
    `record_type` STRING COMMENT '',
    `registration_number` STRING COMMENT '',
    `subcontractor_profile_status` STRING COMMENT '',
    `tax_identifier` STRING COMMENT '',
    `trade_category` STRING COMMENT '',
    `trade_specialization` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_subcontractor_profile PRIMARY KEY(`subcontractor_profile_id`)
) COMMENT 'Subcontractor management entity.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`subcontract_scope_package` (
    `subcontract_scope_package_id` BIGINT COMMENT '',
    `construction_project_id` BIGINT COMMENT '',
    `subcontract_id` BIGINT COMMENT '',
    `vendor_id` BIGINT COMMENT '',
    `amount` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `notes` STRING COMMENT '',
    `record_number` STRING COMMENT '',
    `record_status` STRING COMMENT '',
    `record_type` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_subcontract_scope_package PRIMARY KEY(`subcontract_scope_package_id`)
) COMMENT 'Subcontractor management entity.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`subcontract_progress_claim` (
    `subcontract_progress_claim_id` BIGINT COMMENT '',
    `construction_project_id` BIGINT COMMENT '',
    `subcontract_id` BIGINT COMMENT '',
    `vendor_id` BIGINT COMMENT '',
    `amount` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `notes` STRING COMMENT '',
    `record_number` STRING COMMENT '',
    `record_status` STRING COMMENT '',
    `record_type` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_subcontract_progress_claim PRIMARY KEY(`subcontract_progress_claim_id`)
) COMMENT 'Subcontractor management entity.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_performance_review` (
    `subcontractor_performance_review_id` BIGINT COMMENT '',
    `construction_project_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `subcontract_id` BIGINT COMMENT '',
    `vendor_id` BIGINT COMMENT '',
    `amount` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `notes` STRING COMMENT '',
    `overall_rating` STRING COMMENT '',
    `quality_score` STRING COMMENT '',
    `record_number` STRING COMMENT '',
    `record_status` STRING COMMENT '',
    `record_type` STRING COMMENT '',
    `review_comments` STRING COMMENT '',
    `review_date` DATE COMMENT '',
    `safety_score` STRING COMMENT '',
    `schedule_score` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_subcontractor_performance_review PRIMARY KEY(`subcontractor_performance_review_id`)
) COMMENT 'Subcontractor management entity.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_prequalification` (
    `subcontractor_prequalification_id` BIGINT COMMENT '',
    `construction_project_id` BIGINT COMMENT '',
    `subcontractor_profile_id` BIGINT COMMENT '',
    `vendor_id` BIGINT COMMENT '',
    `amount` DECIMAL(18,2) COMMENT '',
    `approval_date` DATE COMMENT '',
    `confidentiality_flag` BOOLEAN COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `financial_capacity_amount` DECIMAL(18,2) COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `notes` STRING COMMENT '',
    `prequalification_status` STRING COMMENT '',
    `record_number` STRING COMMENT '',
    `record_status` STRING COMMENT '',
    `record_type` STRING COMMENT '',
    `risk_rating` STRING COMMENT '',
    `subcontractor_prequalification_status` STRING COMMENT '',
    `submission_date` DATE COMMENT '',
    `trade_category` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_subcontractor_prequalification PRIMARY KEY(`subcontractor_prequalification_id`)
) COMMENT 'Subcontractor management entity.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_compliance_record` (
    `subcontractor_compliance_record_id` BIGINT COMMENT '',
    `construction_project_id` BIGINT COMMENT '',
    `subcontract_id` BIGINT COMMENT '',
    `vendor_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `amount` DECIMAL(18,2) COMMENT '',
    `compliance_status` STRING COMMENT '',
    `compliance_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `document_reference` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `is_compliant` BOOLEAN COMMENT '',
    `is_verified` BOOLEAN COMMENT '',
    `issue_date` DATE COMMENT '',
    `notes` STRING COMMENT '',
    `record_number` STRING COMMENT '',
    `record_status` STRING COMMENT '',
    `record_type` STRING COMMENT '',
    `requirement_description` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `verification_date` DATE COMMENT '',
    `verified_date` DATE COMMENT '',
    CONSTRAINT pk_subcontractor_compliance_record PRIMARY KEY(`subcontractor_compliance_record_id`)
) COMMENT 'Subcontractor management entity.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_agreement` (
    `subcontractor_agreement_id` BIGINT COMMENT '',
    `construction_project_id` BIGINT COMMENT '',
    `subcontract_id` BIGINT COMMENT '',
    `subcontractor_profile_id` BIGINT COMMENT '',
    `vendor_id` BIGINT COMMENT '',
    `agreement_number` STRING COMMENT '',
    `agreement_status` STRING COMMENT '',
    `contract_value` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `effective_end_date` DATE COMMENT '',
    `effective_start_date` DATE COMMENT '',
    `notes` STRING COMMENT '',
    `payment_terms` STRING COMMENT '',
    `retention_percentage` STRING COMMENT '',
    `subcontractor_agreement_status` STRING COMMENT '',
    `trade_package` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_subcontractor_agreement PRIMARY KEY(`subcontractor_agreement_id`)
) COMMENT 'Stores subcontractor agreement records including terms, conditions, and contractual details for subcontractor engagements.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_payment_application` (
    `subcontractor_payment_application_id` BIGINT COMMENT '',
    `subcontract_id` BIGINT COMMENT '',
    `vendor_id` BIGINT COMMENT '',
    `application_date` DATE COMMENT '',
    `application_number` STRING COMMENT '',
    `application_status` STRING COMMENT '',
    `approved_date` DATE COMMENT '',
    `certified_amount` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `gross_amount` DECIMAL(18,2) COMMENT '',
    `gross_claimed_amount` DECIMAL(18,2) COMMENT '',
    `is_approved` BOOLEAN COMMENT '',
    `net_amount` DECIMAL(18,2) COMMENT '',
    `net_payable_amount` DECIMAL(18,2) COMMENT '',
    `period_end_date` DATE COMMENT '',
    `period_start_date` DATE COMMENT '',
    `retention_amount` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_subcontractor_payment_application PRIMARY KEY(`subcontractor_payment_application_id`)
) COMMENT 'Records subcontractor payment applications submitted for work completed under subcontract agreements.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_insurance` (
    `subcontractor_insurance_id` BIGINT COMMENT '',
    `subcontract_id` BIGINT COMMENT '',
    `subcontractor_profile_id` BIGINT COMMENT '',
    `compliance_status` STRING COMMENT '',
    `coverage_amount` DECIMAL(18,2) COMMENT '',
    `coverage_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `insurer_name` STRING COMMENT '',
    `is_compliant` BOOLEAN COMMENT '',
    `notes` STRING COMMENT '',
    `policy_number` STRING COMMENT '',
    `subcontractor_insurance_status` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_subcontractor_insurance PRIMARY KEY(`subcontractor_insurance_id`)
) COMMENT 'Records insurance policies and coverage details associated with subcontractors.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_work_package` (
    `subcontractor_work_package_id` BIGINT COMMENT '',
    `subcontract_id` BIGINT COMMENT '',
    `wbs_element_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `package_code` STRING COMMENT '',
    `package_name` STRING COMMENT '',
    `package_status` STRING COMMENT '',
    `package_value` DECIMAL(18,2) COMMENT '',
    `planned_finish_date` DATE COMMENT '',
    `planned_start_date` DATE COMMENT '',
    CONSTRAINT pk_subcontractor_work_package PRIMARY KEY(`subcontractor_work_package_id`)
) COMMENT 'Represents a work package assigned to a subcontractor, detailing scope, schedule, and deliverables for a defined portion of subcontracted work.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_invoice` (
    `subcontractor_invoice_id` BIGINT COMMENT 'Primary key',
    `construction_project_id` BIGINT COMMENT 'Owning construction project',
    `subcontract_id` BIGINT COMMENT 'Link to the owning contract entity',
    `subcontractor_agreement_id` BIGINT COMMENT '',
    `subcontractor_profile_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `due_date` DATE COMMENT '',
    `gross_amount` DECIMAL(18,2) COMMENT '',
    `invoice_date` DATE COMMENT '',
    `invoice_number` STRING COMMENT '',
    `invoice_status` STRING COMMENT '',
    `is_disputed` BOOLEAN COMMENT '',
    `net_amount` DECIMAL(18,2) COMMENT '',
    `notes` STRING COMMENT '',
    `payment_status` STRING COMMENT '',
    `retention_amount` DECIMAL(18,2) COMMENT '',
    `subcontractor_invoice_status` STRING COMMENT '',
    `tax_amount` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `work_progress_percent` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_subcontractor_invoice PRIMARY KEY(`subcontractor_invoice_id`)
) COMMENT 'Subcontractor progress invoice';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_payment_certificate` (
    `subcontractor_payment_certificate_id` BIGINT COMMENT 'Primary key',
    `construction_project_id` BIGINT COMMENT 'Owning construction project',
    `payment_certificate_id` BIGINT COMMENT '',
    `subcontract_id` BIGINT COMMENT 'Link to the owning contract entity',
    `subcontractor_agreement_id` BIGINT COMMENT '',
    `certificate_number` STRING COMMENT '',
    `certification_date` DATE COMMENT '',
    `certified_amount` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `is_retention_applied` BOOLEAN COMMENT '',
    `net_amount_due` DECIMAL(18,2) COMMENT '',
    `notes` STRING COMMENT '',
    `payment_due_date` DATE COMMENT '',
    `payment_status` STRING COMMENT '',
    `retention_amount` DECIMAL(18,2) COMMENT '',
    `subcontractor_payment_certificate_status` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `work_progress_percent` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_subcontractor_payment_certificate PRIMARY KEY(`subcontractor_payment_certificate_id`)
) COMMENT 'Certified payment for subcontractor work';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_scope_package` (
    `subcontractor_scope_package_id` BIGINT COMMENT 'Primary key',
    `construction_project_id` BIGINT COMMENT 'Owning construction project',
    `subcontract_id` BIGINT COMMENT 'Link to the owning contract entity',
    `subcontractor_agreement_id` BIGINT COMMENT '',
    `wbs_element_id` BIGINT COMMENT '',
    `actual_end_date` DATE COMMENT '',
    `actual_start_date` DATE COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `is_critical` BOOLEAN COMMENT '',
    `notes` STRING COMMENT '',
    `package_code` STRING COMMENT '',
    `package_name` STRING COMMENT '',
    `package_status` STRING COMMENT '',
    `package_value` DECIMAL(18,2) COMMENT '',
    `percent_complete` DECIMAL(18,2) COMMENT '',
    `planned_end_date` DATE COMMENT '',
    `planned_start_date` DATE COMMENT '',
    `quantity_unit` STRING COMMENT '',
    `scope_description` STRING COMMENT '',
    `subcontractor_scope_package_status` STRING COMMENT '',
    `total_quantity` DECIMAL(18,2) COMMENT '',
    `trade_discipline` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_subcontractor_scope_package PRIMARY KEY(`subcontractor_scope_package_id`)
) COMMENT 'Scope of work package assigned to subcontractor';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_performance_scorecard` (
    `subcontractor_performance_scorecard_id` BIGINT COMMENT 'Primary key',
    `construction_project_id` BIGINT COMMENT 'Owning construction project',
    `subcontract_id` BIGINT COMMENT 'Link to the owning contract entity',
    `comments` STRING COMMENT '',
    `cost_score` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `evaluation_date` DATE COMMENT '',
    `evaluation_period` STRING COMMENT '',
    `evaluator_name` STRING COMMENT '',
    `is_approved_for_rehire` BOOLEAN COMMENT '',
    `overall_score` DECIMAL(18,2) COMMENT '',
    `quality_score` DECIMAL(18,2) COMMENT '',
    `rating_category` STRING COMMENT '',
    `safety_score` DECIMAL(18,2) COMMENT '',
    `schedule_score` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_subcontractor_performance_scorecard PRIMARY KEY(`subcontractor_performance_scorecard_id`)
) COMMENT 'Post-award subcontractor performance evaluation';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_performance_evaluation` (
    `subcontractor_performance_evaluation_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `subcontract_id` BIGINT COMMENT '',
    `vendor_id` BIGINT COMMENT '',
    `comments` STRING COMMENT '',
    `cost_score` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `evaluation_date` DATE COMMENT '',
    `evaluation_period` STRING COMMENT '',
    `is_recommended` BOOLEAN COMMENT '',
    `overall_score` DECIMAL(18,2) COMMENT '',
    `quality_score` DECIMAL(18,2) COMMENT '',
    `rating_grade` STRING COMMENT '',
    `safety_score` DECIMAL(18,2) COMMENT '',
    `schedule_score` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_subcontractor_performance_evaluation PRIMARY KEY(`subcontractor_performance_evaluation_id`)
) COMMENT 'Records and tracks performance evaluations conducted for subcontractors.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_work_package_assignment` (
    `subcontractor_work_package_assignment_id` BIGINT COMMENT '',
    `crew_id` BIGINT COMMENT '',
    `subcontractor_scope_package_id` BIGINT COMMENT '',
    `work_front_id` BIGINT COMMENT '',
    `actual_quantity` DECIMAL(18,2) COMMENT '',
    `assignment_date` DATE COMMENT '',
    `assignment_status` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `planned_quantity` DECIMAL(18,2) COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_subcontractor_work_package_assignment PRIMARY KEY(`subcontractor_work_package_assignment_id`)
) COMMENT '';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_prequalification` ADD CONSTRAINT `fk_subcontractor_subcontractor_prequalification_subcontractor_profile_id` FOREIGN KEY (`subcontractor_profile_id`) REFERENCES `vibe_construction_v1`.`subcontractor`.`subcontractor_profile`(`subcontractor_profile_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_agreement` ADD CONSTRAINT `fk_subcontractor_subcontractor_agreement_subcontractor_profile_id` FOREIGN KEY (`subcontractor_profile_id`) REFERENCES `vibe_construction_v1`.`subcontractor`.`subcontractor_profile`(`subcontractor_profile_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_insurance` ADD CONSTRAINT `fk_subcontractor_subcontractor_insurance_subcontractor_profile_id` FOREIGN KEY (`subcontractor_profile_id`) REFERENCES `vibe_construction_v1`.`subcontractor`.`subcontractor_profile`(`subcontractor_profile_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_invoice` ADD CONSTRAINT `fk_subcontractor_subcontractor_invoice_subcontractor_agreement_id` FOREIGN KEY (`subcontractor_agreement_id`) REFERENCES `vibe_construction_v1`.`subcontractor`.`subcontractor_agreement`(`subcontractor_agreement_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_invoice` ADD CONSTRAINT `fk_subcontractor_subcontractor_invoice_subcontractor_profile_id` FOREIGN KEY (`subcontractor_profile_id`) REFERENCES `vibe_construction_v1`.`subcontractor`.`subcontractor_profile`(`subcontractor_profile_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_payment_certificate` ADD CONSTRAINT `fk_subcontractor_subcontractor_payment_certificate_subcontractor_agreement_id` FOREIGN KEY (`subcontractor_agreement_id`) REFERENCES `vibe_construction_v1`.`subcontractor`.`subcontractor_agreement`(`subcontractor_agreement_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_scope_package` ADD CONSTRAINT `fk_subcontractor_subcontractor_scope_package_subcontractor_agreement_id` FOREIGN KEY (`subcontractor_agreement_id`) REFERENCES `vibe_construction_v1`.`subcontractor`.`subcontractor_agreement`(`subcontractor_agreement_id`);
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_work_package_assignment` ADD CONSTRAINT `fk_subcontractor_subcontractor_work_package_assignment_subcontractor_scope_package_id` FOREIGN KEY (`subcontractor_scope_package_id`) REFERENCES `vibe_construction_v1`.`subcontractor`.`subcontractor_scope_package`(`subcontractor_scope_package_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`subcontractor` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_construction_v1`.`subcontractor` SET TAGS ('dbx_domain' = 'subcontractor');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` SET TAGS ('dbx_subdomain' = 'change_claims');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` SET TAGS ('dbx_ssot_ref' = 'contract.contract_change_order');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` SET TAGS ('dbx_ssot' = 'reference');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` SET TAGS ('dbx_ssot_canonical' = 'project.project_change_order');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` SET TAGS ('dbx_ssot_status' = 'duplicate');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` SET TAGS ('dbx_ssot_pair_resolved' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` SET TAGS ('dbx_ssot_reference' = 'project.project_change_order');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` SET TAGS ('dbx_ssot_role' = 'duplicate');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` SET TAGS ('dbx_ssot_pair' = 'contract.contract_change_order');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `subcontractor_change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontractor Change Order (CO) ID');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `subcontract_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract ID');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `contract_change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Head Contract Change Order (CO) ID');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `contract_change_order_id` SET TAGS ('dbx_ssot_reference_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `contract_change_order_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `contract_change_order_id` SET TAGS ('dbx_ssot_owner' = 'contract.contract_change_order');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `subcontractor_contract_change_order_ref_contract_change_order_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `project_change_order_id` SET TAGS ('dbx_ssot_reference_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `subcontractor_project_change_order_ref_project_change_order_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `subcontractor_project_change_order_ref_project_change_order_id` SET TAGS ('dbx_ssot_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|withdrawn');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `change_amount` SET TAGS ('dbx_business_glossary_term' = 'Change Amount');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'scope_addition|scope_reduction|acceleration|schedule_extension|rate_adjustment|other');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `co_description` SET TAGS ('dbx_business_glossary_term' = 'Change Order (CO) Description');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `co_number` SET TAGS ('dbx_business_glossary_term' = 'Change Order (CO) Number');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `co_title` SET TAGS ('dbx_business_glossary_term' = 'Change Order (CO) Title');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `contingency_allocation` SET TAGS ('dbx_business_glossary_term' = 'Contingency Allocation');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `cost_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Code');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `execution_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Completion Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `execution_start_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Start Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `execution_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|on_hold');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `is_back_charge` SET TAGS ('dbx_business_glossary_term' = 'Is Back Charge');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `is_time_and_material` SET TAGS ('dbx_business_glossary_term' = 'Is Time and Material (T&M)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `original_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Original Completion Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `original_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Original Contract Value');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'design_change|site_condition|client_request|regulatory_requirement|error_omission|force_majeure');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `revised_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Completion Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `revised_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Revised Contract Value');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_change_order` ALTER COLUMN `trade_package` SET TAGS ('dbx_business_glossary_term' = 'Trade Package');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` SET TAGS ('dbx_subdomain' = 'change_claims');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `back_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Back Charge Identifier');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `cost_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Account Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `payment_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Certificate Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issued By User Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `subcontract_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Back-Charge Approval Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Back-Charge Approved Amount');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `back_charge_number` SET TAGS ('dbx_business_glossary_term' = 'Back-Charge Number');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `back_charge_status` SET TAGS ('dbx_business_glossary_term' = 'Back-Charge Status');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Back-Charge Closure Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `deduction_applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Back-Charge Deduction Applied Amount');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `deduction_date` SET TAGS ('dbx_business_glossary_term' = 'Back-Charge Deduction Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Back-Charge Dispute Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Back-Charge Dispute Flag');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Back-Charge Dispute Reason');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `equipment_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Back-Charge Equipment Cost Amount');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Back-Charge Incident Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Back-Charge Labor Cost Amount');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `material_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Back-Charge Material Cost Amount');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `ncr_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Reference Number');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Back-Charge Notes');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Back-Charge Notification Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `overhead_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Back-Charge Overhead Cost Amount');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Back-Charge Reason Code');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Back-Charge Reason Description');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Back-Charge Resolution Outcome');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `response_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Back-Charge Response Deadline Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `site_instruction_number` SET TAGS ('dbx_business_glossary_term' = 'Site Instruction Number');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `supporting_documentation_path` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Path');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`back_charge` ALTER COLUMN `total_claimed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Back-Charge Claimed Amount');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` SET TAGS ('dbx_subdomain' = 'change_claims');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` SET TAGS ('dbx_ssot_ref' = 'contract.contract_eot_claim');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` SET TAGS ('dbx_ssot' = 'reference');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` SET TAGS ('dbx_ssot_canonical' = 'schedule.schedule_eot_claim');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` SET TAGS ('dbx_ssot_status' = 'duplicate');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` SET TAGS ('dbx_ssot_pair_resolved' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` SET TAGS ('dbx_ssot_reference' = 'contract.contract_eot_claim');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` SET TAGS ('dbx_ssot_role' = 'duplicate');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` SET TAGS ('dbx_ssot_pair' = 'contract.contract_eot_claim');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `subcontractor_eot_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Eot Claim Identifier');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `subcontract_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract ID');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `contract_eot_claim_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `contract_eot_claim_id` SET TAGS ('dbx_ssot_reference_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `contract_eot_claim_id` SET TAGS ('dbx_ssot_owner' = 'contract.contract_eot_claim');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `subcontractor_contract_eot_claim_ref_contract_eot_claim_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `subcontractor_contract_eot_claim_ref_contract_eot_claim_id` SET TAGS ('dbx_ssot_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `schedule_eot_claim_id` SET TAGS ('dbx_ssot_reference_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `subcontractor_schedule_eot_claim_ref_schedule_eot_claim_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `subcontractor_schedule_eot_claim_ref_schedule_eot_claim_id` SET TAGS ('dbx_ssot_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `subcontractor_submitted_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `subcontractor_submitted_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `subcontractor_submitted_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `assessed_by` SET TAGS ('dbx_business_glossary_term' = 'Assessed By');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `baseline_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'Baseline Schedule Reference');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `claim_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Extension of Time (EOT) Claim Reference Number');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `claim_reference_number` SET TAGS ('dbx_value_regex' = '^EOT-[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Extension of Time (EOT) Claim Status');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `claim_submission_method` SET TAGS ('dbx_business_glossary_term' = 'Claim Submission Method');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `claim_submission_method` SET TAGS ('dbx_value_regex' = 'electronic_portal|email|registered_mail|hand_delivery|courier');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `concurrent_delay_flag` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Delay Flag');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `contemporaneous_records_reference` SET TAGS ('dbx_business_glossary_term' = 'Contemporaneous Records Reference');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `cost_claim_associated_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Claim Associated Flag');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `critical_path_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Impact Flag');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `days_assessed` SET TAGS ('dbx_business_glossary_term' = 'Days Assessed');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `days_claimed` SET TAGS ('dbx_business_glossary_term' = 'Days Claimed');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `days_granted` SET TAGS ('dbx_business_glossary_term' = 'Days Granted');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `delay_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Delay Cause Category');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `delay_cause_category` SET TAGS ('dbx_value_regex' = 'employer_risk|force_majeure|concurrent_delay|adverse_weather|design_change|variation_order');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `delay_end_date` SET TAGS ('dbx_business_glossary_term' = 'Delay End Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `delay_event_description` SET TAGS ('dbx_business_glossary_term' = 'Delay Event Description');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `delay_start_date` SET TAGS ('dbx_business_glossary_term' = 'Delay Start Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `determination_authority` SET TAGS ('dbx_business_glossary_term' = 'Determination Authority');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `determination_date` SET TAGS ('dbx_business_glossary_term' = 'Determination Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `determination_rationale` SET TAGS ('dbx_business_glossary_term' = 'Determination Rationale');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'no_dispute|under_negotiation|mediation|arbitration|litigation|resolved');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `ld_exposure_impact` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages (LD) Exposure Impact');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `ld_exposure_impact` SET TAGS ('dbx_value_regex' = 'eliminates_ld_exposure|reduces_ld_exposure|no_impact_on_ld|increases_ld_exposure');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `notice_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Notice Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `notice_date` SET TAGS ('dbx_business_glossary_term' = 'Notice Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `original_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Original Completion Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `revised_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Completion Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `schedule_analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Schedule Analysis Method');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `schedule_analysis_method` SET TAGS ('dbx_value_regex' = 'time_impact_analysis|windows_analysis|as_planned_vs_as_built|collapsed_as_built|contemporaneous_period_analysis');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Submission Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim` ALTER COLUMN `supporting_documentation_count` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Count');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` SET TAGS ('dbx_subdomain' = 'change_claims');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `final_account_id` SET TAGS ('dbx_business_glossary_term' = 'Final Account Identifier');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `final_prepared_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `final_prepared_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `final_prepared_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `final_settled_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `final_settled_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `subcontract_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract ID');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Final Account Approval Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Final Account Approved By');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `claims_settled_value` SET TAGS ('dbx_business_glossary_term' = 'Claims Settled Value');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `contractor_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Contractor Signatory Name');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `contractor_signatory_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `contractor_signatory_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `contractor_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Contractor Signatory Title');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `contractor_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Contractor Signature Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `defects_liability_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period (DLP) End Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'negotiation|mediation|arbitration|litigation|adjudication|none');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Final Account Document Reference');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `final_account_number` SET TAGS ('dbx_business_glossary_term' = 'Final Account Number');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `final_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `final_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `final_account_status` SET TAGS ('dbx_business_glossary_term' = 'Final Account Status');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `final_account_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|agreed|disputed|closed|cancelled');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `final_agreed_value` SET TAGS ('dbx_business_glossary_term' = 'Final Agreed Value');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `final_payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Final Payment Due Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `final_payment_made_date` SET TAGS ('dbx_business_glossary_term' = 'Final Payment Made Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `final_payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Final Payment Reference');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `liquidated_damages_deducted` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages (LD) Deducted');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `original_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Original Contract Value');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `performance_bond_release_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Release Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `performance_bond_released` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Released');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Final Account Remarks');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `retention_released` SET TAGS ('dbx_business_glossary_term' = 'Retention Released');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `subcontractor_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Subcontractor Signatory Name');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `subcontractor_signatory_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `subcontractor_signatory_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `subcontractor_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Subcontractor Signatory Title');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `subcontractor_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Subcontractor Signature Date');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `total_approved_change_orders` SET TAGS ('dbx_business_glossary_term' = 'Total Approved Change Orders (CO)');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`final_account` ALTER COLUMN `total_back_charges` SET TAGS ('dbx_business_glossary_term' = 'Total Back-Charges');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`performance_scorecard` SET TAGS ('dbx_subdomain' = 'vendor_onboarding');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_profile` SET TAGS ('dbx_subdomain' = 'vendor_onboarding');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_profile` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_profile` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_profile` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_profile` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_profile` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_profile` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontract_scope_package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontract_scope_package` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontract_progress_claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontract_progress_claim` SET TAGS ('dbx_subdomain' = 'payment_settlement');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_performance_review` SET TAGS ('dbx_subdomain' = 'vendor_onboarding');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_prequalification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_prequalification` SET TAGS ('dbx_subdomain' = 'vendor_onboarding');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_compliance_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_compliance_record` SET TAGS ('dbx_subdomain' = 'vendor_onboarding');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_compliance_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_compliance_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_agreement` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_payment_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_payment_application` SET TAGS ('dbx_subdomain' = 'payment_settlement');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_insurance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_insurance` SET TAGS ('dbx_subdomain' = 'vendor_onboarding');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_work_package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_work_package` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_invoice` SET TAGS ('dbx_subdomain' = 'payment_settlement');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_payment_certificate` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_payment_certificate` SET TAGS ('dbx_subdomain' = 'payment_settlement');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_scope_package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_scope_package` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_performance_scorecard` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_performance_scorecard` SET TAGS ('dbx_subdomain' = 'vendor_onboarding');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_performance_evaluation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_performance_evaluation` SET TAGS ('dbx_subdomain' = 'vendor_onboarding');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_performance_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_performance_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_work_package_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_construction_v1`.`subcontractor`.`subcontractor_work_package_assignment` SET TAGS ('dbx_subdomain' = 'contract_administration');
