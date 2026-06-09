-- Schema for Domain: quality | Business: Genomics Biotech | Version: v1_ecm
-- Generated on: 2026-05-06 13:04:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `genomics_biotech_ecm`.`quality` COMMENT 'Enterprise-wide quality management system encompassing QC testing, QA oversight, CAPA, deviation management, audit trails, SOP management, document control, training qualification tracking, and regulatory inspection readiness. Integrates Veeva Vault and MasterControl for controlled document management. Ensures compliance with GxP, ISO 13485, FDA 21 CFR Part 11, CLIA, and CAP requirements.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`quality`.`capa` (
    `capa_id` BIGINT COMMENT 'Unique identifier for the CAPA record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: CAPAs originating from customer complaints or field failures require tracking the affected account for customer notification workflows, impact analysis, and regulatory reporting (MDR/vigilance). Stand',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: CAPAs arising from FDA 483 observations, notified body audit findings, or post-market surveillance requirements are tied to specific product approvals. Tracking which approval triggered the CAPA is es',
    `audit_id` BIGINT COMMENT 'Foreign key linking to quality.audit. Business justification: CAPAs are often initiated from audit findings. One CAPA can be initiated from one audit; one audit can generate multiple CAPAs. Standard 1:N relationship. Note: initiation_source and source_reference_',
    `employee_id` BIGINT COMMENT 'User identifier of the person who created this CAPA record. Part of the audit trail required for FDA 21 CFR Part 11 electronic signature and record integrity.',
    `capa_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who last modified this CAPA record. Part of the audit trail required for FDA 21 CFR Part 11 electronic signature and record integrity.',
    `capa_quality_approver_employee_id` BIGINT COMMENT 'Identifier of the Quality Assurance personnel who reviewed and approved the CAPA investigation, action plan, and closure. Part of the approval chain required for GxP compliance.',
    `controlled_document_id` BIGINT COMMENT 'Foreign key linking to quality.controlled_document. Business justification: CAPAs often reference controlled documents (SOPs, procedures) that need to be updated as part of corrective/preventive action. One CAPA can reference one primary controlled document; one document can ',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: CAPAs requiring capital investment (equipment upgrades, facility modifications, system implementations) are tracked via internal orders for budget control, cost accumulation, and capitalization decisi',
    `owner_employee_id` BIGINT COMMENT 'Identifier of the employee assigned as the CAPA owner, responsible for coordinating investigation, action implementation, and closure. Links to workforce/employee master data.',
    `quality_issue_id` BIGINT COMMENT 'Foreign key linking to data.quality_issue. Business justification: CAPAs addressing data quality problems (e.g., LIMS validation failures, metadata gaps, data integrity issues) link to originating data quality issues. Required for root cause documentation and effecti',
    `quality_training_curriculum_id` BIGINT COMMENT 'Foreign key linking to quality.training_curriculum. Business justification: CAPAs can require creation or update of training curricula as part of preventive action. One CAPA can affect one curriculum; one curriculum can be affected by multiple CAPAs. Standard 1:N relationship',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to quality.risk_assessment. Business justification: CAPA references a risk assessment via a free‑text field; adding a proper FK enables traceability and eliminates the siloed risk_assessment table.',
    `action_plan_approved_date` DATE COMMENT 'Actual date when the corrective and preventive action plan was formally approved by Quality Assurance.',
    `action_plan_due_date` DATE COMMENT 'Target date by which the corrective and preventive action plan must be developed and approved.',
    `affected_product_lines` STRING COMMENT 'Comma-separated list or narrative description of product lines, SKUs, or lot numbers affected by the quality issue. Used for impact assessment and product disposition decisions.',
    `capa_description` STRING COMMENT 'Detailed narrative describing the quality issue, nonconformance, or improvement opportunity that triggered the CAPA initiation.',
    `capa_number` STRING COMMENT 'Business-facing unique identifier for the CAPA, typically formatted per organizational numbering scheme (e.g., CAPA-2024-001). Used for external communication and regulatory submissions.',
    `capa_status` STRING COMMENT 'Current lifecycle status of the CAPA record. Tracks progression from initiation through investigation, action implementation, effectiveness verification, and closure. [ENUM-REF-CANDIDATE: open|investigation|action_plan|implementation|effectiveness_check|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `capa_type` STRING COMMENT 'Classification of the CAPA as corrective (addressing an existing nonconformance), preventive (preventing potential nonconformance), or combined (both corrective and preventive actions).. Valid values are `corrective|preventive|combined`',
    `closed_date` DATE COMMENT 'Date when the CAPA was formally closed after successful completion of all actions and effectiveness verification. Marks the end of the CAPA lifecycle.',
    `closure_comments` STRING COMMENT 'Final comments and summary provided at CAPA closure, documenting the overall outcome, lessons learned, and any residual risks or follow-up actions.',
    `corrective_action_plan` STRING COMMENT 'Detailed description of the corrective actions planned or implemented to address the identified root cause and prevent recurrence of the nonconformance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CAPA record was first created in the system. Part of the audit trail required for FDA 21 CFR Part 11 compliance.',
    `effectiveness_check_completed_date` DATE COMMENT 'Actual date when the effectiveness verification was completed and results documented.',
    `effectiveness_check_criteria` STRING COMMENT 'Defined measurable criteria and acceptance thresholds used to verify that the implemented corrective and preventive actions have been effective in resolving the issue and preventing recurrence.',
    `effectiveness_check_due_date` DATE COMMENT 'Target date by which the effectiveness verification of implemented actions must be completed. Typically scheduled after a defined monitoring period post-implementation.',
    `effectiveness_check_result` STRING COMMENT 'Outcome of the effectiveness verification assessment, indicating whether the implemented actions successfully resolved the issue and met the defined effectiveness criteria.. Valid values are `effective|ineffective|pending`',
    `gxp_classification` STRING COMMENT 'Classification of the CAPA under applicable Good Practice regulations (GMP for manufacturing, GLP for laboratory, GCP for clinical, GDP for distribution, or non-GxP for non-regulated activities).. Valid values are `gmp|glp|gcp|gdp|non_gxp`',
    `implementation_completed_date` DATE COMMENT 'Actual date when all planned corrective and preventive actions were fully implemented and verified.',
    `implementation_due_date` DATE COMMENT 'Target date by which all corrective and preventive actions must be fully implemented.',
    `initiated_date` DATE COMMENT 'Date when the CAPA was formally initiated in the quality system. Marks the start of the CAPA lifecycle and is used for turnaround time (TAT) tracking and regulatory reporting.',
    `initiation_source` STRING COMMENT 'The triggering event or source that initiated the CAPA. Identifies the quality system input that identified the need for corrective or preventive action. [ENUM-REF-CANDIDATE: deviation|audit_finding|customer_complaint|oos_result|regulatory_inspection|management_review|risk_assessment|supplier_issue — 8 candidates stripped; promote to reference product]',
    `investigation_completed_date` DATE COMMENT 'Actual date when the root cause investigation was completed and documented. Used for TAT metrics and compliance tracking.',
    `investigation_due_date` DATE COMMENT 'Target date by which the root cause investigation must be completed. Driven by priority, severity, and regulatory requirements.',
    `mastercontrol_record_reference` STRING COMMENT 'Unique identifier of the CAPA record in MasterControl document control and training management system, used for SOP update tracking and training workflow integration.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this CAPA record was last modified. Part of the audit trail required for FDA 21 CFR Part 11 compliance and change control.',
    `preventive_action_plan` STRING COMMENT 'Detailed description of the preventive actions planned or implemented to eliminate potential causes of nonconformance and prevent occurrence in other areas or products.',
    `priority` STRING COMMENT 'Business priority level assigned to the CAPA based on risk assessment, regulatory impact, and business criticality. Determines resource allocation and response timeline.. Valid values are `critical|high|medium|low`',
    `product_impact` STRING COMMENT 'Indicates whether the quality issue has confirmed or potential impact on released product quality, safety, or performance. Drives product disposition and recall assessment.. Valid values are `yes|no|under_investigation`',
    `regulatory_impact` STRING COMMENT 'Indicates whether the underlying quality issue requires regulatory reporting to FDA, EMA, or other governing bodies per applicable regulations (e.g., MDR, field alert, recall).. Valid values are `reportable|non_reportable`',
    `root_cause_analysis_method` STRING COMMENT 'The structured methodology used to identify the root cause of the quality issue (e.g., 5-Why, Fishbone/Ishikawa, Fault Tree Analysis, FMEA, Pareto analysis).. Valid values are `five_why|fishbone|fault_tree_analysis|fmea|pareto|other`',
    `root_cause_summary` STRING COMMENT 'Narrative summary of the identified root cause(s) of the quality issue, documenting the outcome of the root cause analysis investigation.',
    `severity` STRING COMMENT 'Severity classification of the underlying quality issue based on potential impact to product quality, patient safety, regulatory compliance, or business operations.. Valid values are `critical|major|minor`',
    `sop_updates_required` BOOLEAN COMMENT 'Boolean flag indicating whether the CAPA requires updates to existing SOPs or creation of new SOPs to prevent recurrence. Triggers document control workflow in MasterControl.',
    `source_reference_number` STRING COMMENT 'Reference identifier of the originating quality event (e.g., deviation number, audit finding ID, complaint number, OOS investigation number) that triggered this CAPA.',
    `title` STRING COMMENT 'Brief descriptive title summarizing the quality issue or improvement opportunity addressed by this CAPA.',
    `training_required` BOOLEAN COMMENT 'Boolean flag indicating whether the CAPA requires personnel training or retraining as part of the corrective or preventive action plan. Triggers training management workflow.',
    `veeva_vault_document_reference` STRING COMMENT 'Unique identifier of the CAPA record in Veeva Vault quality management system, used for controlled document linkage and audit trail integration.',
    CONSTRAINT pk_capa PRIMARY KEY(`capa_id`)
) COMMENT 'Corrective and Preventive Action (CAPA) master record tracking the full lifecycle of quality issues requiring systematic investigation and remediation. Captures CAPA initiation trigger (deviation, audit finding, complaint, OOS result), root cause analysis methodology (5-Why, Fishbone, FTA), effectiveness check criteria, GxP classification, regulatory impact assessment, and closure approval chain. Integrates with Veeva Vault for controlled document linkage and MasterControl for associated SOP updates. Supports FDA 21 CFR Part 820, ISO 13485 Clause 8.5.2, and ICH Q10 CAPA system requirements.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`quality`.`deviation` (
    `deviation_id` BIGINT COMMENT 'Unique identifier for the quality deviation record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Deviations affecting shipped reagents, kits, or instruments require customer notification and potential recall. Tracking the affected account enables targeted communication, regulatory compliance (21 ',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Deviations impacting released genomics products are assessed for regulatory reportability by approval/jurisdiction. FDA field alert reports, EU vigilance reports are approval-specific. Direct link ena',
    `asset_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_asset. Business justification: Genomics labs track deviations by instrument for trending, root cause analysis, and regulatory reporting. Replaces denormalized serial_number with structured FK for CAPA effectiveness tracking and ins',
    `audit_finding_id` BIGINT COMMENT 'Foreign key reference to an internal audit, external audit, or regulatory inspection finding that identified this deviation or is related to the same systemic issue.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to quality.audit. Business justification: Quality deviations can be identified during audits. One deviation can be identified in one audit; one audit can identify multiple deviations. Standard 1:N relationship.',
    `capa_id` BIGINT COMMENT 'Foreign key reference to the CAPA record initiated as a result of this deviation, if capa_required_flag is true. Establishes traceability between deviation and corrective action.',
    `controlled_document_id` BIGINT COMMENT 'Foreign key linking to quality.controlled_document. Business justification: Quality deviations reference the SOP or procedure that was deviated from. One deviation references one primary document; one document can be deviated from multiple times. Standard 1:N relationship. No',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Deviation investigations require resource allocation (QA time, laboratory analysis, documentation) charged to cost centers for quality cost tracking, budget variance analysis, and cost-of-quality repo',
    `employee_id` BIGINT COMMENT 'Identifier of the Quality Assurance or subject matter expert employee assigned to lead the deviation investigation and root cause analysis.',
    `deviation_qa_reviewer_employee_id` BIGINT COMMENT 'Identifier of the Quality Assurance reviewer who approved the deviation investigation, impact assessment, and disposition decision. Required for GxP compliance.',
    `deviation_reported_by_employee_id` BIGINT COMMENT 'Identifier of the employee who initially reported the deviation. Links to workforce management system for accountability and training tracking.',
    `quality_issue_id` BIGINT COMMENT 'Foreign key linking to data.quality_issue. Business justification: Deviations caused by data integrity issues (e.g., audit trail gaps, invalid entries, system validation failures) link to data quality issue records. Required for root cause documentation and regulator',
    `affected_batch_lot_number` STRING COMMENT 'Manufacturing batch or lot number of the product, reagent, or consumable affected by the deviation. Critical for traceability and potential recall decisions.',
    `affected_product_sku` STRING COMMENT 'Stock Keeping Unit identifier of the product impacted by the deviation. Used to assess commercial impact and customer notification requirements.',
    `affected_sop_number` STRING COMMENT 'Document control number of the Standard Operating Procedure that was not followed or was inadequate, leading to the deviation.. Valid values are `^SOP-[A-Z]{2,4}-[0-9]{4}$`',
    `capa_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the deviation investigation identified a systemic root cause requiring formal CAPA workflow to prevent recurrence. True triggers CAPA initiation.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the deviation was formally closed following QA approval of the investigation, impact assessment, and disposition decision. Represents lifecycle completion.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this deviation record was first created in the quality management system. Audit trail field for record lifecycle tracking.',
    `customer_notification_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether affected customers must be notified of the deviation due to potential impact on product performance, safety, or data quality. Triggers customer communication workflow.',
    `deviation_description` STRING COMMENT 'Detailed narrative description of what occurred, including the specific departure from the approved procedure, specification, or regulatory requirement. Must be sufficiently detailed for regulatory inspection review.',
    `deviation_number` STRING COMMENT 'Externally-known unique business identifier for the deviation, typically system-generated and used in regulatory submissions and audit trails.. Valid values are `^DEV-[0-9]{8}$`',
    `deviation_status` STRING COMMENT 'Current lifecycle state of the deviation: open (newly reported), under_investigation (root cause analysis in progress), pending_approval (awaiting QA sign-off), closed (investigation complete and approved), cancelled (determined not to be a deviation).. Valid values are `open|under_investigation|pending_approval|closed|cancelled`',
    `deviation_type` STRING COMMENT 'Classification of the deviation by operational category: process (procedure departure), equipment (instrument malfunction), material (reagent/consumable issue), environmental (cleanroom/storage condition), documentation (record error), or personnel (training/qualification gap).. Valid values are `process|equipment|material|environmental|documentation|personnel`',
    `disposition_decision` STRING COMMENT 'Final quality decision on the affected batch, lot, or data: accept (meets specifications despite deviation), reject (does not meet specifications), rework (reprocess to meet specifications), retest (repeat testing), use_as_is (acceptable with justification), scrap (destroy).. Valid values are `accept|reject|rework|retest|use_as_is|scrap`',
    `facility_location_code` STRING COMMENT 'Code identifying the manufacturing site, laboratory, or clinical facility where the deviation occurred. Used for site-level trending and regulatory inspection readiness.',
    `gxp_classification` STRING COMMENT 'Regulatory framework under which the deviation occurred: GMP (Good Manufacturing Practice), GLP (Good Laboratory Practice), GCP (Good Clinical Practice), or non-GxP (research use only operations).. Valid values are `GMP|GLP|GCP|non-GxP`',
    `immediate_action_taken` STRING COMMENT 'Description of containment actions taken immediately upon discovery of the deviation to prevent further impact, such as quarantine of affected materials, equipment shutdown, or process halt.',
    `investigation_due_date` DATE COMMENT 'Target completion date for the deviation investigation and root cause analysis, typically driven by internal quality metrics or regulatory inspection readiness requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this deviation record was last updated. Audit trail field for change tracking and regulatory inspection readiness.',
    `mastercontrol_record_reference` STRING COMMENT 'External system identifier linking this deviation to the corresponding record in MasterControl document control and training management system for cross-system traceability.',
    `occurrence_timestamp` TIMESTAMP COMMENT 'Date and time when the deviation actually occurred or was discovered during operations. May differ from reported_timestamp if deviation was identified retrospectively.',
    `product_impact_assessment` STRING COMMENT 'Quality assessment determining whether the deviation affected product quality, safety, efficacy, or data integrity. Includes scientific justification for disposition decision.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Boolean indicator of whether the deviation meets criteria for mandatory reporting to regulatory authorities such as FDA (Field Alert Report, Medical Device Report) or EMA (Vigilance Report).',
    `repeat_deviation_flag` BOOLEAN COMMENT 'Boolean indicator of whether this deviation is a recurrence of a previously identified and closed deviation, suggesting ineffective CAPA or systemic quality system weakness.',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the deviation was first reported into the quality management system. Represents the business event timestamp for deviation initiation.',
    `root_cause_analysis_summary` STRING COMMENT 'Summary of the investigation findings identifying the underlying systemic cause of the deviation. May reference formal RCA methodologies such as 5-Why, Fishbone, or Fault Tree Analysis.',
    `severity_grade` STRING COMMENT 'Risk-based severity classification of the deviation impact: critical (patient safety or data integrity risk), major (significant quality impact or regulatory non-compliance), minor (limited impact with no patient or product risk).. Valid values are `critical|major|minor`',
    `turnaround_time_days` STRING COMMENT 'Calculated number of calendar days from reported_timestamp to closed_timestamp. Key performance indicator for quality system responsiveness and regulatory inspection readiness.',
    `veeva_vault_document_reference` STRING COMMENT 'External system identifier linking this deviation record to the controlled document in Veeva Vault quality management system, ensuring 21 CFR Part 11 electronic signature and audit trail compliance.',
    CONSTRAINT pk_deviation PRIMARY KEY(`deviation_id`)
) COMMENT 'GxP deviation record capturing any unplanned departure from an approved procedure, specification, or regulatory requirement during manufacturing, laboratory, or clinical operations. Tracks deviation type (process, equipment, material, environmental), GMP/GLP/GCP classification, severity grading, immediate containment actions, affected batch/lot numbers, product impact assessment, and disposition decision. Feeds into CAPA workflow when systemic root cause is identified. Supports FDA 21 CFR Part 211, ISO 13485, and GxP deviation management requirements.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`quality`.`audit` (
    `audit_id` BIGINT COMMENT 'Unique identifier for the quality audit record. Primary key for the audit entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Customer audits (pre-qualification, ongoing surveillance, regulatory co-inspections) are standard in genomics-biotech supplier relationships. Tracking the customer account enables audit scheduling, re',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: FDA pre-approval inspections, notified body surveillance audits, and competent authority inspections are conducted against specific product approvals. Audit findings directly impact approval status. E',
    `employee_id` BIGINT COMMENT 'Identifier of the qualified lead auditor responsible for planning, conducting, and reporting the audit. Must be a trained and qualified auditor per ISO 19011 or equivalent.',
    `channel_partner_id` BIGINT COMMENT 'Foreign key linking to commercial.channel_partner. Business justification: Quality audits of distribution partners are standard in regulated genomics (ISO 13485, CLIA). Linking enables supplier qualification, CAPA tracking for channel partners, and distributor performance mo',
    `controlled_document_id` BIGINT COMMENT 'Foreign key linking to quality.controlled_document. Business justification: Audits reference audit protocols or checklists which are controlled documents. One audit uses one primary protocol; one protocol can be used by multiple audits. Removes audit_plan_id and audit_checkli',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Audits consume resources (auditor time, travel, documentation, follow-up activities) charged to cost centers for compliance cost tracking, audit program budget management, and quality assurance expens',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: GMP/ISO 13485 audits are conducted at registered manufacturing establishments. FDA establishment inspections, notified body audits, and competent authority inspections are tied to specific facility re',
    `primary_lead_auditor_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `audit_program_id` BIGINT COMMENT 'Identifier of the overarching audit program or annual audit plan to which this audit belongs. Links to the audit program master for strategic audit planning and coverage tracking.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier being audited, applicable for supplier qualification or surveillance audits. Null for internal audits.',
    `actual_end_date` DATE COMMENT 'Actual date the audit fieldwork concluded. May differ from scheduled end date due to scope changes or findings requiring additional investigation.',
    `actual_start_date` DATE COMMENT 'Actual date the audit fieldwork commenced. May differ from scheduled start date due to operational changes or delays.',
    `applicable_standards` STRING COMMENT 'Comma-separated list of regulatory standards, frameworks, or requirements against which the audit is conducted. Examples: ISO 13485, FDA 21 CFR Part 820, CLIA 42 CFR Part 493, CAP accreditation requirements, GMP, ISO 15189.',
    `audit_number` STRING COMMENT 'Business-facing unique audit identifier used in quality management systems and regulatory documentation. Format: AUD-NNNNNN.. Valid values are `^AUD-[0-9]{6,10}$`',
    `audit_scope` STRING COMMENT 'Detailed description of the audit scope including processes, departments, systems, or standards being audited. Defines boundaries and focus areas for the audit activity.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit. Tracks progression from planning through execution to closure. Planned indicates scheduled but not started; in_progress indicates active fieldwork; fieldwork_complete indicates data collection done; report_draft indicates findings being documented; report_final indicates report approved; closed indicates all follow-up actions complete; cancelled indicates audit was terminated before completion. [ENUM-REF-CANDIDATE: planned|in_progress|fieldwork_complete|report_draft|report_final|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `audit_type` STRING COMMENT 'Classification of the audit based on its purpose and scope. Includes internal GMP (Good Manufacturing Practice) audits, ISO 13485 compliance audits, CLIA (Clinical Laboratory Improvement Amendments) and CAP (College of American Pathologists) readiness audits, supplier qualification audits, regulatory inspection readiness audits, and process-specific audits.. Valid values are `internal_gmp|internal_iso_13485|clia_cap_readiness|supplier_qualification|regulatory_inspection_readiness|process_audit`',
    `auditee_department_head` STRING COMMENT 'Name or identifier of the department head or process owner responsible for the audited area. Primary contact for audit findings and corrective actions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was first created in the quality management system. Audit trail for record creation.',
    `critical_findings_count` STRING COMMENT 'Number of critical or major nonconformities identified during the audit. Critical findings require immediate corrective action and may impact product quality or regulatory compliance.',
    `department_scope` STRING COMMENT 'Comma-separated list of departments or functional areas included in the audit scope. Examples: Manufacturing, Quality Control, Research and Development, Regulatory Affairs.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the audit fieldwork in hours. Used for resource planning and audit efficiency metrics.',
    `follow_up_due_date` DATE COMMENT 'Target date by which follow-up audit or verification of corrective actions must be completed. Null if no follow-up is required.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether follow-up audit or verification activities are required. True indicates that corrective actions must be verified through a subsequent audit or review.',
    `inspection_authority` STRING COMMENT 'Name of the regulatory authority or certification body for which this audit serves as readiness preparation. Examples: FDA, EMA, CAP, CLIA, Notified Body. Null for internal audits not tied to external inspection.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified the audit record. Audit trail for accountability and traceability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was last modified. Audit trail for record changes.',
    `notes` STRING COMMENT 'Free-text field for additional audit context, observations, or administrative notes not captured in structured fields. May include logistical details, scope changes, or special circumstances.',
    `outcome` STRING COMMENT 'Overall outcome or conclusion of the audit. Conforming indicates no major findings and compliance with applicable standards; nonconforming indicates critical findings requiring corrective action; needs_improvement indicates opportunities for enhancement without critical nonconformities; not_applicable indicates audit was cancelled or scope changed.. Valid values are `conforming|nonconforming|needs_improvement|not_applicable`',
    `regulatory_inspection_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this audit is a regulatory inspection readiness audit or mock inspection. True indicates the audit simulates or prepares for an FDA, EMA, or other regulatory body inspection.',
    `report_date` DATE COMMENT 'Date the final audit report was issued or approved. Marks the formal completion of audit documentation.',
    `risk_level` STRING COMMENT 'Risk-based classification of the audit based on the criticality of the audited area, prior audit history, and potential impact on product quality or regulatory compliance. Used for audit prioritization and frequency determination.. Valid values are `low|medium|high|critical`',
    `scheduled_end_date` DATE COMMENT 'Planned date for the audit fieldwork to conclude. Used for audit scheduling and resource planning.',
    `scheduled_start_date` DATE COMMENT 'Planned date for the audit to commence. Used for audit scheduling and resource planning.',
    `team_members` STRING COMMENT 'Comma-separated list of audit team member names or identifiers. Includes all auditors, technical experts, and observers participating in the audit.',
    `total_findings_count` STRING COMMENT 'Total number of audit findings (observations, nonconformities, opportunities for improvement) identified during the audit. Detailed findings are tracked in the audit_finding product.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created the audit record. Audit trail for accountability and traceability.',
    CONSTRAINT pk_audit PRIMARY KEY(`audit_id`)
) COMMENT 'Quality audit master record for internal, supplier, and regulatory inspection audits. Captures audit type (internal GMP, ISO 13485, CLIA/CAP, supplier qualification, regulatory inspection readiness), audit scope, lead auditor, audit team, scheduled and actual dates, facility/department scope, applicable regulatory standards, and overall audit outcome (conforming, nonconforming, needs improvement). SSOT for audit identity and scheduling — individual observations are tracked in audit_finding. Supports FDA 21 CFR Part 820, ISO 13485 Clause 9.2, and CAP/CLIA inspection readiness.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'Unique identifier for the audit finding record. Primary key.',
    `audit_id` BIGINT COMMENT 'Reference to the parent audit event during which this finding was identified.',
    `capa_id` BIGINT COMMENT 'Reference to the CAPA record initiated in response to this finding, if applicable. Links finding to formal corrective and preventive action process.',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.change_control. Business justification: Audit findings often trigger change controls to address systemic issues. One audit finding can trigger one change control; one change control can address multiple findings. This is a standard 1:N rela',
    `previous_finding_audit_finding_id` BIGINT COMMENT 'Reference to the earlier audit finding that this current finding repeats, if applicable. Used to track recurrence patterns.',
    `quality_issue_id` BIGINT COMMENT 'Foreign key linking to data.quality_issue. Business justification: Audit findings related to data integrity issues (e.g., audit trail gaps, metadata incompleteness) link to tracked data quality issues for remediation. Required for CAPA closure evidence and effectiven',
    `inspection_id` BIGINT COMMENT 'Reference to the regulatory inspection event if this finding originated from an external regulatory audit (FDA, EMA, Notified Body, CAP, CLIA).',
    `affected_department` STRING COMMENT 'Organizational department or business unit responsible for the process or area where the finding was identified.',
    `affected_procedure_sop` STRING COMMENT 'Specific SOP, work instruction, or controlled document that is the subject of the finding. References document control system identifier.',
    `affected_process` STRING COMMENT 'Business process or functional area impacted by the finding (e.g., Library Preparation, Sequencing QC, Document Control, Training Management, CAPA Process).',
    `affected_site_location` STRING COMMENT 'Physical site, facility, or laboratory location where the finding was observed. Relevant for multi-site organizations.',
    `audit_finding_status` STRING COMMENT 'Current lifecycle status of the audit finding. Tracks progression from identification through response, verification, and closure. [ENUM-REF-CANDIDATE: open|under_investigation|response_submitted|pending_verification|verified_closed|rejected|reopened — 7 candidates stripped; promote to reference product]',
    `closure_comments` STRING COMMENT 'Final comments or notes documenting the closure decision, verification results, and any residual considerations.',
    `closure_date` DATE COMMENT 'Date when the finding was formally closed after successful verification of corrective actions.',
    `created_by_user` STRING COMMENT 'Username or identifier of the auditor or quality professional who created this finding record.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this audit finding record was first created in the quality management system.',
    `customer_complaint_related_flag` BOOLEAN COMMENT 'Indicates whether this finding is related to or triggered by customer complaints, product quality issues, or field performance problems.',
    `data_integrity_issue_flag` BOOLEAN COMMENT 'Indicates whether the finding involves data integrity concerns such as incomplete records, missing audit trails, unauthorized data modification, or non-compliance with FDA 21 CFR Part 11 electronic records requirements.',
    `fda_warning_letter_related_flag` BOOLEAN COMMENT 'Indicates whether this finding is related to or triggered by an FDA Warning Letter, 483 observation, or other regulatory inspection finding. Requires expedited response and executive visibility.',
    `finding_classification` STRING COMMENT 'Severity classification of the finding. Critical: immediate risk to product safety or regulatory compliance; Major: significant GxP or quality system deviation; Minor: isolated procedural deviation; Observation: opportunity for improvement without regulatory impact.. Valid values are `critical|major|minor|observation`',
    `finding_description` STRING COMMENT 'Detailed narrative description of the nonconformance, deficiency, or observation. Describes what was found, the gap between actual and expected state, and the potential impact.',
    `finding_number` STRING COMMENT 'Business identifier for the finding, typically formatted as audit number plus sequential finding number (e.g., AUD-2024-001-F01).',
    `finding_type` STRING COMMENT 'Type of finding identified. Nonconformance: failure to meet a specified requirement; Deficiency: gap in system or process; Observation: noted condition without immediate action; Opportunity for improvement: proactive enhancement suggestion.. Valid values are `nonconformance|deficiency|observation|opportunity_for_improvement`',
    `gxp_impact_flag` BOOLEAN COMMENT 'Indicates whether the finding has direct impact on GxP-regulated activities (GMP, GLP, GCP). GxP findings require heightened scrutiny and formal quality system response.',
    `identified_date` DATE COMMENT 'Date when the finding was first identified during the audit. Represents the business event timestamp for the finding discovery.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this finding record. Part of the electronic audit trail.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this audit finding record was last updated. Supports audit trail and change tracking requirements.',
    `objective_evidence` STRING COMMENT 'Factual, verifiable evidence supporting the finding. May reference documents reviewed, records examined, observations made, interviews conducted, or data analyzed during the audit.',
    `regulatory_citation` STRING COMMENT 'Specific regulatory requirement, standard clause, or guideline that the finding relates to (e.g., FDA 21 CFR 820.30, ISO 13485:2016 Section 7.3.2, CLIA 493.1256).',
    `repeat_finding_flag` BOOLEAN COMMENT 'Indicates whether this finding is a repeat of a previously identified and supposedly corrected issue. Repeat findings indicate ineffective CAPA and require escalation.',
    `required_response_type` STRING COMMENT 'Type of response action required to address the finding. CAPA required: formal corrective and preventive action; Correction only: immediate fix without preventive action; Observation acknowledgment: awareness without formal action; No action required: informational only.. Valid values are `capa_required|correction_only|observation_acknowledgment|no_action_required`',
    `response_due_date` DATE COMMENT 'Target date by which the auditee must submit a formal response to the finding. Typically 30 days for major findings, 60 days for minor findings, per organizational policy.',
    `response_overdue_flag` BOOLEAN COMMENT 'Indicates whether the response submission is past the due date. Calculated field for tracking compliance with response timelines.',
    `response_submitted_date` DATE COMMENT 'Actual date when the auditee submitted their formal response to the finding.',
    `responsible_person_email` STRING COMMENT 'Email address of the individual responsible for the finding response. Used for notification and communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_person_name` STRING COMMENT 'Name of the individual assigned responsibility for responding to and resolving the finding. Typically a manager or process owner in the affected department.',
    `risk_level` STRING COMMENT 'Risk assessment of the finding based on potential impact to product quality, patient safety, regulatory compliance, or business operations. High: immediate threat; Medium: significant concern; Low: minimal impact.. Valid values are `high|medium|low`',
    `root_cause_required_flag` BOOLEAN COMMENT 'Indicates whether formal root cause analysis is required for this finding. Typically true for critical and major findings, false for minor findings and observations.',
    `verification_date` DATE COMMENT 'Date when the effectiveness of corrective actions was verified and the finding was confirmed as resolved.',
    `verification_method` STRING COMMENT 'Method used to verify that corrective actions have been implemented and are effective. Document review: examination of updated procedures; Follow-up audit: re-audit of the process; Process observation: direct observation of corrected process; Data analysis: review of performance metrics; Management review: executive assessment.. Valid values are `document_review|follow_up_audit|process_observation|data_analysis|management_review`',
    `verification_required_flag` BOOLEAN COMMENT 'Indicates whether formal verification of corrective action effectiveness is required before the finding can be closed. Typically true for critical and major findings.',
    `verified_by_name` STRING COMMENT 'Name of the quality professional or auditor who performed the verification and approved closure of the finding.',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Individual observation or nonconformance identified during a quality audit. Captures finding classification (critical, major, minor, observation), regulatory citation, affected process or procedure, finding description, objective evidence, required response type (CAPA, correction, observation acknowledgment), response due date, and closure verification status. Links to parent audit record and may trigger CAPA initiation. Supports FDA Warning Letter response tracking, ISO 13485 nonconformance management, and CAP/CLIA deficiency resolution.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` (
    `controlled_document_id` BIGINT COMMENT 'Unique identifier for the controlled document record. Primary key. Inferred role: MASTER_RESOURCE (represents a managed document asset with lifecycle, classification, and regulatory tracking).',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Quality documents (SOPs, specifications, IFUs) are approval-specific in genomics. Different CE-IVD vs FDA versions, market-specific labeling, approval-specific manufacturing procedures. Version contro',
    `employee_id` BIGINT COMMENT 'Identifier of the authorized individual who approved the document for release. Links to workforce master data. Supports electronic signature traceability per 21 CFR Part 11.',
    `family_id` BIGINT COMMENT 'Identifier of the product line or product family to which this document applies. Nullable for enterprise-wide documents. Links to product hierarchy master data.',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: SOPs and protocols for genomic assays must specify the reference genome version for alignment, variant calling, and interpretation. Essential for GxP compliance, method transfer between sites, and reg',
    `metadata_schema_id` BIGINT COMMENT 'Foreign key linking to data.metadata_schema. Business justification: SOPs and protocols in genomics biotech must comply with metadata schemas for FAIR principles and regulatory submissions (FDA 21 CFR Part 11, CDISC). Document metadata validation requires schema linkag',
    `org_unit_id` BIGINT COMMENT 'Identifier of the organizational department or functional area that owns or is primarily responsible for this document. Links to organizational hierarchy master data.',
    `price_book_id` BIGINT COMMENT 'Foreign key linking to commercial.price_book. Business justification: SOPs, specifications, and CoA templates define testing/documentation requirements that drive COGS and pricing. Linking enables cost-based pricing for tiered service levels (e.g., standard vs. expedite',
    `primary_controlled_employee_id` BIGINT COMMENT 'Identifier of the employee responsible for the content accuracy, maintenance, and periodic review of the document. Links to workforce master data.',
    `submission_id` BIGINT COMMENT 'Identifier of the regulatory submission dossier or application with which this document is associated. Nullable if not part of a submission.',
    `superseded_document_controlled_document_id` BIGINT COMMENT 'Identifier of the previous version of this document that this version replaces. Enables version lineage tracking. Nullable for initial versions.',
    `variant_database_version_id` BIGINT COMMENT 'Foreign key linking to reference.variant_database_version. Business justification: Clinical interpretation SOPs must reference specific variant database versions (ClinVar, HGMD) to ensure consistency in variant classification and regulatory traceability. Required for CAP/CLIA compli',
    `approval_date` DATE COMMENT 'Date on which the document was formally approved by the designated approver. Distinct lifecycle event from effective date.',
    `archived_date` DATE COMMENT 'Date on which the document was moved to archival storage. Nullable if not yet archived.',
    `archived_flag` BOOLEAN COMMENT 'Indicates whether the document has been moved to long-term archival storage. True if archived, False if active or accessible.',
    `change_control_number` STRING COMMENT 'Identifier of the change control request or deviation that authorized the creation or revision of this document version. Links to CAPA or change management system.',
    `confidentiality_level` STRING COMMENT 'Data classification level of the document content. Determines access controls and distribution restrictions.. Valid values are `Public|Internal|Confidential|Restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this document record was first created in the system. Audit trail field supporting FDA 21 CFR Part 11 compliance.',
    `distribution_list` STRING COMMENT 'Comma-separated list of roles, departments, or individuals authorized to access or receive this document. Supports controlled distribution per ISO 13485.',
    `document_category` STRING COMMENT 'High-level functional category grouping for the document. Supports cross-functional document organization and retrieval. [ENUM-REF-CANDIDATE: Quality|Manufacturing|R&D|Regulatory|Clinical|IT|Safety|Environmental|HR — 9 candidates stripped; promote to reference product]',
    `document_format` STRING COMMENT 'File format or media type of the controlled document. Supports format-specific rendering and archival strategies. [ENUM-REF-CANDIDATE: PDF|Word|Excel|PowerPoint|HTML|XML|Other — 7 candidates stripped; promote to reference product]',
    `document_number` STRING COMMENT 'Externally-known unique document identifier assigned per document control numbering scheme. Typically follows format PREFIX-TYPE-SEQUENCE (e.g., SOP-QC-001234). Business identifier for the document.. Valid values are `^[A-Z]{2,4}-[A-Z]{2,4}-[0-9]{4,6}$`',
    `document_status` STRING COMMENT 'Current lifecycle state of the controlled document. Tracks progression through authoring, review, approval, activation, and retirement stages. [ENUM-REF-CANDIDATE: Draft|In Review|Approved|Effective|Superseded|Obsolete|Archived — 7 candidates stripped; promote to reference product]',
    `document_title` STRING COMMENT 'Full descriptive title of the controlled document. Human-readable identity label.',
    `document_type` STRING COMMENT 'Classification of the controlled document by its functional purpose within the quality management system. Categorical field that segments the document population. [ENUM-REF-CANDIDATE: SOP|Work Instruction|Specification|Validation Protocol|Batch Record|Form|Policy|Procedure|Test Method|Quality Manual — 10 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'Date on which the document version becomes binding and enforceable within the quality management system. Marks the start of the documents active lifecycle.',
    `electronic_signature_applied_flag` BOOLEAN COMMENT 'Indicates whether an FDA 21 CFR Part 11 compliant electronic signature was applied to this document. True if electronically signed, False otherwise.',
    `expiration_date` DATE COMMENT 'Date on which the document version is scheduled for review or retirement. Nullable for documents without a defined review cycle end date.',
    `external_reference_number` STRING COMMENT 'Reference identifier from an external system or regulatory authority (e.g., FDA submission number, ISO standard number, customer specification reference).',
    `gxp_classification` STRING COMMENT 'Classification of the document under applicable Good Practice regulations. Determines the rigor of controls and audit trail requirements.. Valid values are `GMP|GLP|GCP|GDP|Non-GxP`',
    `keywords` STRING COMMENT 'Comma-separated list of searchable keywords or tags associated with the document. Enhances discoverability in document management systems.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the primary language of the document content (e.g., en, de, fr, es).. Valid values are `^[a-z]{2}$`',
    `last_review_date` DATE COMMENT 'Date on which the document was last formally reviewed for accuracy and continued applicability. Distinct from approval date; supports periodic review tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this document record was last modified. Audit trail field supporting FDA 21 CFR Part 11 compliance.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the document. Calculated from last_review_date plus review_cycle_months.',
    `page_count` STRING COMMENT 'Total number of pages in the document. Used for completeness verification and printing logistics.',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Indicates whether this document is part of a regulatory submission package (e.g., FDA 510(k), CE-IVD technical file). True if submitted to regulatory authority, False otherwise.',
    `retention_period_years` STRING COMMENT 'Number of years the document must be retained after obsolescence per regulatory and business requirements. Typical values: 5, 7, 10, or indefinite (represented as NULL or 9999).',
    `review_cycle_months` STRING COMMENT 'Periodic review interval in months. Defines how frequently the document must be re-evaluated for continued accuracy and relevance. Typical values: 12, 24, 36 months.',
    `revision_summary` STRING COMMENT 'Brief narrative summary of changes made in this version compared to the previous version. Supports change traceability and impact assessment.',
    `source_system` STRING COMMENT 'Name of the operational system of record from which this document metadata was sourced. Supports data lineage and reconciliation.. Valid values are `Veeva Vault|MasterControl|SharePoint|Manual`',
    `source_system_document_reference` STRING COMMENT 'Unique identifier of the document in the source system (Veeva Vault or MasterControl). Enables traceability back to the operational system of record.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether personnel must complete formal training on this document before performing related tasks. True if training is mandatory, False otherwise.',
    `version_number` STRING COMMENT 'Sequential version identifier for the document. Increments with each revision. Supports major.minor versioning (e.g., 1.0, 2.1).. Valid values are `^[0-9]{1,3}(.[0-9]{1,2})?$`',
    CONSTRAINT pk_controlled_document PRIMARY KEY(`controlled_document_id`)
) COMMENT 'Master record for all GxP-controlled documents managed through Veeva Vault and MasterControl — including SOPs, work instructions, specifications, validation protocols, batch records, and forms. Tracks document number, version, effective date, review cycle, document owner, approval workflow status, training requirement flag, superseded version linkage, and regulatory submission association. Enforces FDA 21 CFR Part 11 electronic signature requirements and ISO 13485 Clause 7.5 document control requirements. SSOT for document identity and version lifecycle across the quality management system.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`quality`.`training_record` (
    `training_record_id` BIGINT COMMENT 'Unique identifier for the individual training record. Primary key for the training record entity.',
    `capa_id` BIGINT COMMENT 'Unique identifier of the Corrective and Preventive Action (CAPA) that triggered this training requirement. Links training to quality event remediation.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Customer user training on sequencing instruments, bioinformatics software, or assay protocols is tracked for qualification, certification, and technical support. Links training records to customer con',
    `controlled_document_id` BIGINT COMMENT 'Unique identifier of the controlled document, Standard Operating Procedure (SOP), or work instruction that is the subject of this training. Links to document control system.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Training activities incur costs (trainer time, materials, facilities, external providers) allocated to cost centers for workforce development expense tracking, training budget management, and GxP comp',
    `deviation_id` BIGINT COMMENT 'Unique identifier of the quality deviation or non-conformance that triggered retraining. Links training to quality event root cause analysis.',
    `metadata_schema_id` BIGINT COMMENT 'Foreign key linking to data.metadata_schema. Business justification: Training on data standards and metadata requirements (e.g., CDISC, FAIR principles) links to specific schema versions for compliance tracking. Required for 21 CFR Part 11 training documentation and de',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee who completed or is assigned this training. Links to workforce management system.',
    `quality_training_curriculum_id` BIGINT COMMENT 'Unique identifier of the role-based or regulatory training curriculum to which this training record belongs. Supports competency matrix management.',
    `tertiary_training_assessor_employee_id` BIGINT COMMENT 'Unique identifier of the qualified assessor who evaluated the trainee competency. May differ from trainer for on-the-job training (OJT) practical assessments.',
    `workforce_assignment_id` BIGINT COMMENT 'Unique identifier of the training assignment that triggered this training record. Links to training curriculum or assignment management.',
    `assessment_attempts` STRING COMMENT 'Number of attempts the trainee made to pass the assessment. Used for identifying training effectiveness issues and retraining needs.',
    `assessment_required_flag` BOOLEAN COMMENT 'Indicates whether a formal assessment (test, quiz, practical demonstration) is required to complete this training per Good Practice (GxP) requirements.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numerical score achieved by the trainee on the training assessment, expressed as a percentage. Used to determine qualification status and identify retraining needs.',
    `assessor_name` STRING COMMENT 'Full name of the qualified assessor who evaluated trainee competency. Required for regulatory inspection readiness and audit trail.',
    `certificate_issued_date` DATE COMMENT 'Date on which the training certificate was formally issued to the trainee. Used for external certifications and regulatory inspection documentation.',
    `certificate_number` STRING COMMENT 'Unique certificate number issued upon successful completion of the training. Used for external training providers and regulatory-mandated certifications.',
    `completion_date` DATE COMMENT 'Date on which the trainee successfully completed the training and any required assessment. Critical for demonstrating personnel qualification and regulatory compliance.',
    `completion_timestamp` TIMESTAMP COMMENT 'Precise date and time when the training was completed. Used for e-learning systems and detailed audit trails per FDA 21 CFR Part 11 electronic record requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this training record was first created in the system. Part of the audit trail required by FDA 21 CFR Part 11 for electronic records.',
    `document_number` STRING COMMENT 'Human-readable document control number for the training material (e.g., SOP number, work instruction code). Used for traceability and regulatory inspection.',
    `document_revision` STRING COMMENT 'Revision or version number of the controlled document at the time of training. Critical for demonstrating training currency and compliance with current procedures.',
    `document_title` STRING COMMENT 'Title of the controlled document or Standard Operating Procedure (SOP) for which training was completed.',
    `due_date` DATE COMMENT 'Date by which the training must be completed to maintain compliance and personnel qualification status. Used for escalation and management reporting.',
    `external_training_provider` STRING COMMENT 'Name of the external training organization or vendor that delivered the training. Required for externally-sourced regulatory or technical training.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this training record was last modified. Part of the audit trail required by FDA 21 CFR Part 11 for electronic records.',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to successfully complete the training and achieve qualified status. Defined per training curriculum or regulatory requirement.',
    `qualification_effective_date` DATE COMMENT 'Date from which the trainee is considered qualified to perform the trained activity. Used for personnel authorization and access control.',
    `qualification_expiry_date` DATE COMMENT 'Date on which the qualification expires and retraining or requalification is required. Used for proactive retraining scheduling and compliance monitoring.',
    `qualification_status` STRING COMMENT 'Current qualification status of the trainee for the trained procedure or competency. Determines authorization to perform Good Practice (GxP) activities.. Valid values are `qualified|not_qualified|pending|expired|revoked`',
    `regulatory_requirement_reference` STRING COMMENT 'Citation of the specific regulatory requirement or standard that mandates this training (e.g., FDA 21 CFR Part 211.25, ISO 13485 Clause 6.2, Clinical Laboratory Improvement Amendments (CLIA) personnel requirements). Used for regulatory inspection readiness.',
    `retraining_due_date` DATE COMMENT 'Date by which periodic retraining or refresher training must be completed to maintain qualification status. Calculated based on training frequency requirements.',
    `scheduled_date` DATE COMMENT 'Date on which the training was originally scheduled or assigned to the trainee. Used for tracking training compliance and overdue assignments.',
    `trainee_employee_number` STRING COMMENT 'Human-readable employee number or badge identifier for the trainee. Used for regulatory inspection readiness and audit documentation.',
    `trainer_name` STRING COMMENT 'Full name of the qualified trainer or assessor. Used for training certificate generation and regulatory inspection documentation.',
    `training_category` STRING COMMENT 'Functional or regulatory category of the training content. Used for curriculum planning and regulatory inspection readiness. [ENUM-REF-CANDIDATE: gmp|gcp|glp|quality_system|safety|technical|regulatory|compliance|software_validation — 9 candidates stripped; promote to reference product]',
    `training_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for this training event, including external provider fees, materials, and internal resource costs. Used for training budget management and cost analysis.',
    `training_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the training cost amount. Supports multi-currency training cost tracking for global operations.. Valid values are `^[A-Z]{3}$`',
    `training_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the training session in hours. Used for training cost analysis, resource planning, and regulatory documentation.',
    `training_location` STRING COMMENT 'Physical or virtual location where the training was conducted (e.g., training room, manufacturing floor, online platform). Required for classroom and on-the-job training (OJT) documentation.',
    `training_method` STRING COMMENT 'Method by which the training was delivered to the trainee. Determines assessment and documentation requirements per Good Practice (GxP) regulations.. Valid values are `read_and_understand|classroom|on_the_job|e_learning|webinar|simulation`',
    `training_notes` STRING COMMENT 'Free-text notes or comments from the trainer or assessor regarding trainee performance, special circumstances, or follow-up actions required.',
    `training_type` STRING COMMENT 'Classification of the training event indicating the business driver or trigger for the training requirement. [ENUM-REF-CANDIDATE: initial|refresher|requalification|change_control|capa_driven|role_based|regulatory_mandated — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_training_record PRIMARY KEY(`training_record_id`)
) COMMENT 'Individual employee training qualification record tracking completion of GxP-required training assignments against controlled documents, SOPs, and regulatory curricula. Captures trainee identity, training assignment source (document revision, role-based curriculum, CAPA-driven retraining), training method (read-and-understand, classroom, OJT, e-learning), completion date, assessment score, trainer/assessor identity, qualification status, and retraining due date. Integrates with MasterControl training management module and Oracle Cloud HCM for workforce linkage. Supports FDA 21 CFR Part 211.68, ISO 13485 Clause 6.2, and CLIA personnel qualification requirements.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` (
    `quality_training_curriculum_id` BIGINT COMMENT 'Unique identifier for the training curriculum record. Primary key.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Training requirements for genomics diagnostics are approval-specific. CLIA complexity (waived/moderate/high) determines training depth, CE-IVD requires specific competencies, FDA-approved tests requir',
    `channel_partner_id` BIGINT COMMENT 'Foreign key linking to commercial.channel_partner. Business justification: Partner certification programs require specific training curricula (instrument operation, assay protocols, regulatory compliance). Linking enables partner qualification tracking, authorized reseller m',
    `applicable_departments` STRING COMMENT 'Comma-separated list of departments or organizational units to which this curriculum applies (e.g., Manufacturing, Quality Control, Research and Development).',
    `applicable_job_roles` STRING COMMENT 'Comma-separated list or description of job roles, titles, or functions to which this curriculum applies (e.g., Manufacturing Operator, Quality Control Analyst, Laboratory Technician).',
    `approval_authority` STRING COMMENT 'Role or individual authorized to approve this training curriculum (e.g., Quality Assurance Manager, Training Director).',
    `approval_date` DATE COMMENT 'Date on which this curriculum version was formally approved by the designated approval authority.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved this curriculum version.',
    `assessment_required_flag` BOOLEAN COMMENT 'Indicates whether a formal assessment (test, practical demonstration, competency evaluation) is required upon completion of this curriculum.',
    `assessment_type` STRING COMMENT 'Type of assessment method used to evaluate trainee competency for this curriculum.. Valid values are `written_exam|practical_demonstration|competency_observation|quiz|simulation|peer_review`',
    `cap_applicable_flag` BOOLEAN COMMENT 'Indicates whether this curriculum is required to meet CAP accreditation standards for laboratory personnel training.',
    `clia_applicable_flag` BOOLEAN COMMENT 'Indicates whether this curriculum is required to meet CLIA personnel standards for clinical laboratory operations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this training curriculum record was first created in the system.',
    `curriculum_code` STRING COMMENT 'Unique business identifier for the training curriculum, used for external reference and system integration.. Valid values are `^[A-Z0-9]{6,20}$`',
    `curriculum_description` STRING COMMENT 'Detailed description of the training curriculum purpose, scope, and learning objectives.',
    `curriculum_name` STRING COMMENT 'Descriptive name of the training curriculum (e.g., GMP Manufacturing Operator Qualification, CLIA Laboratory Personnel Training).',
    `curriculum_owner` STRING COMMENT 'Name or identifier of the individual or department responsible for maintaining and updating this curriculum.',
    `curriculum_type` STRING COMMENT 'Classification of the curriculum by its organizational scope and purpose.. Valid values are `role_based|department_based|regulatory_qualification|product_specific|process_specific|safety_compliance`',
    `curriculum_version` STRING COMMENT 'Version number of the training curriculum, incremented upon revision or update.. Valid values are `^[0-9]+.[0-9]+$`',
    `delivery_method` STRING COMMENT 'Primary method by which the training curriculum is delivered to trainees. [ENUM-REF-CANDIDATE: classroom|online|blended|on_the_job|self_paced|instructor_led|virtual_classroom — 7 candidates stripped; promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date on which this curriculum version is superseded or retired. Null if currently active.',
    `effective_start_date` DATE COMMENT 'Date from which this curriculum version becomes effective and applicable for training assignments.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Estimated total time in hours required to complete all training modules and assessments in this curriculum.',
    `gxp_applicable_flag` BOOLEAN COMMENT 'Indicates whether this curriculum is subject to Good Practice regulations (GMP, GLP, GCP) and requires enhanced documentation and audit trail.',
    `iso_13485_applicable_flag` BOOLEAN COMMENT 'Indicates whether this curriculum is required to meet ISO 13485 quality management system requirements for medical device personnel.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this training curriculum record was most recently modified.',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of this curriculum for accuracy and regulatory compliance.',
    `linked_document_revision_trigger_flag` BOOLEAN COMMENT 'Indicates whether a revision to any linked controlled document automatically triggers retraining for personnel assigned to this curriculum.',
    `mastercontrol_training_reference` STRING COMMENT 'External identifier linking this curriculum to its training record in MasterControl document control and training management system.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this curriculum.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or special instructions related to this training curriculum.',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score or percentage required to pass the assessment and complete the curriculum. Null if no formal scoring applies.',
    `prerequisite_curriculum_list` STRING COMMENT 'Comma-separated list of training curriculum codes that must be completed before this curriculum can be assigned.',
    `qualification_level` STRING COMMENT 'The competency or qualification level this curriculum is designed to achieve or maintain.. Valid values are `entry_level|intermediate|advanced|expert|supervisor|manager`',
    `quality_training_curriculum_status` STRING COMMENT 'Current lifecycle status of the training curriculum.. Valid values are `draft|active|under_review|superseded|retired|suspended`',
    `regulatory_basis` STRING COMMENT 'Regulatory requirement or standard that mandates this training curriculum (e.g., FDA 21 CFR Part 211.25, CLIA Personnel Standards 42 CFR 493.1489, ISO 13485:2016 Section 6.2).',
    `required_document_list` STRING COMMENT 'Comma-separated list of controlled document identifiers (SOPs, work instructions, policies) that are part of this training curriculum.',
    `retraining_interval_months` STRING COMMENT 'Number of months between required retraining cycles. Null if training is initial-only or event-driven.',
    `review_frequency_months` STRING COMMENT 'Number of months between required periodic reviews of this curriculum to ensure continued relevance and compliance.',
    `revision_reason` STRING COMMENT 'Business or regulatory reason for the most recent revision of this curriculum (e.g., Updated SOP reference, New regulatory requirement, Process change).',
    `training_frequency` STRING COMMENT 'Frequency at which this curriculum must be completed or refreshed (initial, annual, event-driven upon document revision, etc.).. Valid values are `initial_only|annual|biannual|quarterly|event_driven|continuous`',
    `veeva_vault_document_reference` STRING COMMENT 'External identifier linking this curriculum to its controlled document record in Veeva Vault regulatory document management system.',
    CONSTRAINT pk_quality_training_curriculum PRIMARY KEY(`quality_training_curriculum_id`)
) COMMENT 'Role-based GxP training curriculum definition specifying required training assignments for each job function, department, or regulatory qualification level. Captures curriculum name, applicable job roles, required controlled document list, training frequency (initial, annual, event-driven), assessment requirements, and regulatory basis (FDA 21 CFR Part 211.68, CLIA personnel standards). SSOT for training requirements by role — serves as the authoritative template from which individual training_record assignments are generated. Triggers automatic retraining upon linked controlled_document revision.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` (
    `nonconformance_id` BIGINT COMMENT 'Unique identifier for the nonconformance record (NCR). Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: NCRs for finished genomics products (sequencing kits, reagents, arrays) shipped to customers require traceability to affected accounts for recall execution, customer notification, and regulatory repor',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: NCRs for released genomics products (sequencing kits, reagents) are tracked by approval/market for regulatory reporting obligations. Disposition decisions consider approval-specific specifications. Es',
    `asset_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_asset. Business justification: Manufacturing QC tracks instrument-related nonconformances for defect trending, supplier quality analysis, and calibration/maintenance correlation. Essential for GxP-regulated production environments ',
    `audit_id` BIGINT COMMENT 'Foreign key linking to quality.audit. Business justification: Nonconformances can be identified during audits. One NCR can be identified in one audit; one audit can identify multiple NCRs. Standard 1:N relationship.',
    `batch_id` BIGINT COMMENT 'Foreign key linking to supply.batch. Business justification: NCRs for out-of-spec batches, contamination, or labeling errors must link to the affected batch for disposition decisions, quarantine management, and CAPA investigations. Critical for GMP traceability',
    `capa_id` BIGINT COMMENT 'Foreign key reference to the associated CAPA record if corrective or preventive action was initiated.',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.change_control. Business justification: Nonconformances can trigger change controls to prevent recurrence. One NCR can trigger one change control; one change control can address multiple NCRs. Standard 1:N relationship.',
    `controlled_document_id` BIGINT COMMENT 'Foreign key linking to quality.controlled_document. Business justification: Nonconformances reference the specification or procedure that was not met. One NCR references one primary document; one document can be referenced by multiple NCRs. Standard 1:N relationship. Note: sp',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: NCR investigations and rework activities consume resources (labor, materials, retesting) charged to cost centers for quality cost accounting, scrap/rework variance analysis, and cost-of-poor-quality (',
    `complaint_id` BIGINT COMMENT 'Foreign key reference to the originating customer complaint record if the nonconformance was detected post-sale.',
    `deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: Nonconformances can be linked to quality deviations when the NCR is caused by a deviation from procedure. One NCR can be related to one deviation; one deviation can result in multiple NCRs. Standard 1',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Nonconformances in genomic testing (incorrect variant calls, alignment failures) must document the genome build to assess root cause and determine if reference data version contributed to the failure.',
    `inbound_delivery_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_delivery. Business justification: Cold chain excursions, carrier damage, or customs delays detected at delivery trigger NCRs. Link required for temperature log review, carrier claims, and supplier performance impact assessment.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to commercial.opportunity. Business justification: NCRs may be raised against products sold via specific opportunities (custom orders, beta units). Linking enables warranty claim tracking, customer-specific quality issue analysis, and opportunity-leve',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: NCRs for incoming material defects (wrong spec, damaged goods, missing CoA) must trace to the originating PO for supplier notification, debit memos, and supplier performance scorecards.',
    `qc_result_id` BIGINT COMMENT 'Foreign key linking to quality.qc_result. Business justification: Nonconformances are often triggered by failing QC results. One NCR can be triggered by one QC result; one QC result can trigger multiple NCRs if multiple parameters fail. Standard 1:N relationship.',
    `quality_issue_id` BIGINT COMMENT 'Foreign key linking to data.quality_issue. Business justification: NCRs for data-related nonconformances (e.g., missing metadata, failed validation, data integrity issues) link to data quality issue tracking. Required for disposition decisions and demonstrating corre',
    `supplier_id` BIGINT COMMENT 'Foreign key reference to the supplier or vendor if the nonconformance originated from externally sourced material.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse_location. Business justification: Storage condition deviations (temperature excursion, humidity breach) are location-specific. NCR must reference warehouse_location for calibration verification, environmental monitoring review, and im',
    `capa_required_flag` BOOLEAN COMMENT 'Indicates whether this nonconformance triggers a formal CAPA investigation and action plan.',
    `closed_by` STRING COMMENT 'Name or identifier of the quality professional who closed the nonconformance record after verification of completion.',
    `closure_date` DATE COMMENT 'Date when the nonconformance record was formally closed after all disposition and corrective actions were completed.',
    `containment_action` STRING COMMENT 'Immediate containment actions taken to prevent further use or distribution of the nonconforming material.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the nonconformance record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the financial impact amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `detected_by` STRING COMMENT 'Name or identifier of the person or system that detected the nonconformance.',
    `detected_date` DATE COMMENT 'Date when the nonconformance was first identified and documented.',
    `detection_source` STRING COMMENT 'Origin point where the nonconformance was identified: incoming inspection, in-process QC, final release testing, customer complaint, supplier notification, or internal audit.. Valid values are `incoming_inspection|in_process_qc|final_release|customer_complaint|supplier_notification|internal_audit`',
    `disposition_approved_by` STRING COMMENT 'Name or identifier of the quality authority who approved the disposition decision.',
    `disposition_date` DATE COMMENT 'Date when the disposition decision was finalized and approved.',
    `disposition_decision` STRING COMMENT 'Final decision on how to handle the nonconforming material: use as-is (with concession), rework, reject, scrap, return to supplier, or quarantine pending further investigation.. Valid values are `use_as_is|rework|reject|scrap|return_to_supplier|quarantine`',
    `disposition_justification` STRING COMMENT 'Detailed rationale and technical justification for the disposition decision, including risk assessment and impact analysis.',
    `failure_mode` STRING COMMENT 'Description of how the material or product failed to meet specifications (e.g., out-of-specification result, physical defect, labeling error, contamination).',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial impact of the nonconformance, including scrap cost, rework cost, and potential liability exposure.',
    `inspection_lot_number` STRING COMMENT 'SAP QM inspection lot number associated with the quality control testing that identified the nonconformance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the nonconformance record, supporting audit trail requirements.',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number of the nonconforming material for traceability.',
    `material_description` STRING COMMENT 'Textual description of the affected material, product, reagent, or component.',
    `material_number` STRING COMMENT 'SAP material master number or SKU of the affected nonconforming item.',
    `measured_value` DECIMAL(18,2) COMMENT 'Actual measured or observed value that triggered the nonconformance, stored as string to accommodate various data types.',
    `ncr_number` STRING COMMENT 'Business identifier for the nonconformance report, typically formatted as NCR-YYYYNNNN for external reference and traceability.. Valid values are `^NCR-[0-9]{8}$`',
    `ncr_type` STRING COMMENT 'Classification of the nonconforming item: material, product, component, reagent, instrument, or raw material.. Valid values are `material|product|component|reagent|instrument|raw_material`',
    `nonconformance_status` STRING COMMENT 'Current lifecycle status of the nonconformance record: open, under investigation, pending disposition, closed, or cancelled.. Valid values are `open|under_investigation|pending_disposition|closed|cancelled`',
    `plant_code` STRING COMMENT 'SAP plant or manufacturing site code where the nonconformance was detected or where the material was produced.',
    `quality_notification_number` STRING COMMENT 'SAP QM notification number linking this NCR to the SAP Quality Management module for integrated workflow.',
    `quantity_affected` DECIMAL(18,2) COMMENT 'Numeric quantity of nonconforming material or units identified, expressed in the materials base unit of measure.',
    `regulatory_report_number` STRING COMMENT 'Reference number of the regulatory report filed (e.g., MDR report number, field safety notice number) if reportable.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this nonconformance requires reporting to regulatory authorities (FDA, EMA, notified body) per applicable regulations.',
    `root_cause_summary` STRING COMMENT 'Summary of the root cause analysis findings, identifying the underlying reason for the nonconformance.',
    `specification_limit` STRING COMMENT 'Acceptance criteria or specification limit that was not met (e.g., ≥95%, 7.0-7.5, <10 CFU/mL).',
    `specification_parameter` STRING COMMENT 'Specific quality parameter or attribute that was out of specification (e.g., purity, concentration, pH, sterility).',
    `specification_reference` STRING COMMENT 'Reference to the quality specification, acceptance criteria, or SOP that the material failed to meet.',
    `supplier_notification_date` DATE COMMENT 'Date when the supplier was formally notified of the nonconformance, if applicable.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the affected quantity (e.g., EA for each, L for liters, KG for kilograms).',
    CONSTRAINT pk_nonconformance PRIMARY KEY(`nonconformance_id`)
) COMMENT 'Nonconforming material or product record (NCR) capturing instances where a product, reagent, instrument component, or raw material fails to meet defined specifications or acceptance criteria. Tracks nonconformance source (incoming inspection, in-process QC, final release, customer complaint), affected material/lot/batch, failure mode, quantity affected, disposition decision (use-as-is, rework, reject/scrap, return to supplier), and regulatory reportability assessment. Distinct from deviation (process departure) — NCR is material/product-focused. Supports SAP QM module integration and ISO 13485 Clause 8.3 nonconforming product control.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`quality`.`qc_result` (
    `qc_result_id` BIGINT COMMENT 'Unique identifier for the quality control test result record.',
    `asset_id` BIGINT COMMENT 'Identifier of the analytical instrument or equipment used to perform the QC test.',
    `gene_annotation_track_id` BIGINT COMMENT 'Foreign key linking to reference.gene_annotation_track. Business justification: QC results for gene expression assays and panel sequencing must reference the annotation track used for feature counting, coverage metrics, and transcript quantification. Essential for result interpre',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: QC results for genomic assays (NGS, arrays) must reference the genome build used for alignment and variant calling. Critical for regulatory submissions, result interpretation, and traceability. Requir',
    `lot_id` BIGINT COMMENT 'FK to reagent.lot.lot_id — QC results for reagent lots must reference the reagent.lot entity — this was the consolidation path when qc_test_result was merged into qc_result. Enables lot-level quality trending and release decisi',
    `material_id` BIGINT COMMENT 'Identifier of the material, reagent, consumable, or instrument being tested.',
    `employee_id` BIGINT COMMENT 'Identifier of the laboratory technician or quality control analyst who performed the test.',
    `sample_specimen_id` BIGINT COMMENT 'Identifier of the physical sample or specimen that was tested.',
    `stability_study_id` BIGINT COMMENT 'Foreign key linking to quality.stability_study. Business justification: QC results are generated as part of stability studies at various time points. One QC result can be part of one stability study; one stability study generates multiple QC results over time. Standard 1:',
    `validation_study_id` BIGINT COMMENT 'Foreign key linking to quality.validation_study. Business justification: QC results can be part of validation studies (method validation, assay validation). One QC result can be part of one validation study; one validation study generates multiple QC results. Standard 1:N ',
    `variant_database_version_id` BIGINT COMMENT 'Foreign key linking to reference.variant_database_version. Business justification: QC results for variant detection assays must reference the specific variant database version (ClinVar, gnomAD, COSMIC) used for annotation and clinical interpretation. Essential for result reproducibi',
    `calibration_status` STRING COMMENT 'Indicates whether the instrument used for testing was in a valid calibration state at the time of the test.. Valid values are `calibrated|expired|pending|not_required`',
    `coa_included_flag` BOOLEAN COMMENT 'Indicates whether this QC result is included in the official Certificate of Analysis for the lot.',
    `comments` STRING COMMENT 'Free-text field for analyst observations, notes, or contextual information about the test execution or result.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this QC result record was first created in the system.',
    `deviation_number` STRING COMMENT 'Reference number of any deviation or non-conformance associated with this QC result, if applicable.',
    `expiration_date` DATE COMMENT 'The expiration or retest date assigned to the material lot based on stability data and QC results.',
    `inspection_lot_number` STRING COMMENT 'The lot number assigned to the batch of material or product being inspected. Links to the manufacturing lot or batch under quality control.',
    `laboratory_location` STRING COMMENT 'The physical laboratory or testing facility where the QC test was performed.',
    `lot_disposition` STRING COMMENT 'The final quality decision for the lot based on cumulative QC results: released for use, rejected, or held in quarantine.. Valid values are `released|rejected|quarantine|conditional_release|pending_investigation`',
    `lower_specification_limit` DECIMAL(18,2) COMMENT 'The minimum acceptable value for the test characteristic as defined in the product specification or quality standard.',
    `measured_value` DECIMAL(18,2) COMMENT 'The quantitative result obtained from the QC test or inspection.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this QC result record was last modified.',
    `out_of_specification_flag` BOOLEAN COMMENT 'Boolean indicator that this result exceeded specification limits and triggered an OOS investigation.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this result must be reported to regulatory authorities (e.g., FDA, EMA) as part of compliance obligations.',
    `replicate_number` STRING COMMENT 'The replicate or repeat number when multiple measurements are taken from the same sample for statistical validity.',
    `result_status` STRING COMMENT 'The disposition of the QC test result indicating whether the measured value meets acceptance criteria.. Valid values are `pass|fail|conditional|pending|retest|out_of_specification`',
    `retest_required_flag` BOOLEAN COMMENT 'Indicates whether this result requires retesting due to inconclusive or borderline results.',
    `review_timestamp` TIMESTAMP COMMENT 'The date and time when the QC result was reviewed and approved by quality assurance.',
    `sop_number` STRING COMMENT 'The controlled document number of the SOP that governed the execution of this test.',
    `sop_version` STRING COMMENT 'The version of the SOP that was in effect when the test was performed.',
    `specification_version` STRING COMMENT 'Version identifier of the product specification or quality standard applied to evaluate this result.',
    `target_value` DECIMAL(18,2) COMMENT 'The ideal or nominal value for the test characteristic, representing the center of the specification range.',
    `test_category` STRING COMMENT 'The analytical category or discipline of the QC test method.. Valid values are `chemical|physical|microbiological|molecular|functional|performance`',
    `test_characteristic` STRING COMMENT 'The specific quality characteristic or parameter being measured (e.g., purity, concentration, pH, viscosity, sterility).',
    `test_date` DATE COMMENT 'The calendar date on which the QC test was performed.',
    `test_method_code` STRING COMMENT 'Code identifying the standardized test method or analytical procedure used for this QC measurement.',
    `test_timestamp` TIMESTAMP COMMENT 'The precise date and time when the QC test was executed, supporting audit trail and chronological traceability.',
    `test_type` STRING COMMENT 'Classification of the QC test based on the stage of production or purpose of testing.. Valid values are `raw_material|in_process|finished_product|stability|reference_standard|environmental`',
    `unit_of_measure` STRING COMMENT 'The unit in which the measured value is expressed (e.g., mg/mL, %, pH units, CFU/mL).',
    `upper_specification_limit` DECIMAL(18,2) COMMENT 'The maximum acceptable value for the test characteristic as defined in the product specification or quality standard.',
    CONSTRAINT pk_qc_result PRIMARY KEY(`qc_result_id`)
) COMMENT 'Quality control test result record capturing individual QC measurements and inspection outcomes for reagents, consumables, instruments, and in-process materials — including inspection lot context, test method, measured value, acceptance criteria, and pass/fail disposition';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` (
    `oos_investigation_id` BIGINT COMMENT 'Unique identifier for the OOS investigation record. Primary key.',
    `capa_id` BIGINT COMMENT 'Reference to the associated CAPA record if corrective or preventive actions were initiated.',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.change_control. Business justification: OOS investigations can trigger change controls when systemic issues are identified. One OOS investigation can trigger one change control; one change control can address multiple investigations. Standa',
    `complaint_id` BIGINT COMMENT 'Foreign key linking to quality.complaint. Business justification: OOS investigations can be triggered by customer complaints about product quality. One OOS investigation can be related to one complaint; one complaint can trigger multiple OOS investigations. Standard',
    `deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: OOS investigations can be linked to quality deviations when the OOS result is caused by a procedural deviation. One OOS investigation can be related to one deviation; one deviation can trigger multipl',
    `nonconformance_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance. Business justification: OOS investigations can result in nonconformance records when material is determined to be non-conforming. One OOS investigation can result in one NCR; one NCR can be investigated by multiple OOS inves',
    `employee_id` BIGINT COMMENT 'Reference to the quality assurance or laboratory personnel who initiated the investigation.',
    `qc_result_id` BIGINT COMMENT 'Reference to the originating QC test result that triggered this OOS investigation.',
    `quality_assessment_id` BIGINT COMMENT 'Foreign key linking to data.quality_assessment. Business justification: OOS investigations require data quality assessment to rule out laboratory error vs. true OOS per FDA guidance. Phase I investigation must assess data integrity, calculation errors, and system suitabil',
    `sample_specimen_id` BIGINT COMMENT 'Reference to the sample that was tested and produced the OOS result.',
    `tertiary_oos_qa_reviewer_user_employee_id` BIGINT COMMENT 'Reference to the QA professional who reviewed and approved the investigation findings.',
    `test_method_id` BIGINT COMMENT 'Reference to the analytical test method or assay protocol used when the OOS result was obtained.',
    `capa_required` BOOLEAN COMMENT 'Indicates whether a formal CAPA is required based on investigation findings.',
    `closure_date` DATE COMMENT 'Date when the OOS investigation was formally closed after all required actions were completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this OOS investigation record was first created in the system.',
    `deviation_magnitude` DECIMAL(18,2) COMMENT 'Calculated magnitude of deviation from the specification limit, expressed as absolute difference or percentage.',
    `disposition_decision` STRING COMMENT 'Final disposition decision for the lot or batch under investigation based on investigation findings.. Valid values are `accept|reject|rework|reprocess|quarantine|pending`',
    `impact_assessment` STRING COMMENT 'Assessment of the potential impact on product quality, patient safety, and other released lots or batches.',
    `initiated_date` DATE COMMENT 'Date when the OOS investigation was formally initiated following detection of the out-of-specification result.',
    `invalidation_justification` STRING COMMENT 'Detailed scientific justification for invalidating the OOS result, required when result_invalidated is true. Must demonstrate clear laboratory error per FDA guidance.',
    `investigation_number` STRING COMMENT 'Business identifier for the OOS investigation, typically formatted as OOS-YYYY-NNNNNN for external reference and regulatory reporting.. Valid values are `^OOS-[0-9]{4}-[0-9]{6}$`',
    `investigation_status` STRING COMMENT 'Current lifecycle status of the OOS investigation workflow. [ENUM-REF-CANDIDATE: initiated|phase_i_in_progress|phase_i_complete|phase_ii_in_progress|phase_ii_complete|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `investigation_type` STRING COMMENT 'Classification of the investigation: Out-of-Specification (OOS), Out-of-Trend (OOT), atypical result, or failed specification.. Valid values are `oos_result|oot_result|atypical_result|failed_specification`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this OOS investigation record was last modified.',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number of the product or reagent under investigation.. Valid values are `^[A-Z0-9]{6,20}$`',
    `observed_value` DECIMAL(18,2) COMMENT 'The actual measured or observed test result value that fell outside specification limits.',
    `phase` STRING COMMENT 'Current phase of the investigation: Phase I (laboratory investigation for analyst error, instrument malfunction, calculation error) or Phase II (full investigation for process failure, raw material failure, method failure).. Valid values are `phase_i|phase_ii`',
    `phase_i_assignable_cause_found` BOOLEAN COMMENT 'Indicates whether an assignable laboratory cause was identified during Phase I investigation.',
    `phase_i_completion_date` DATE COMMENT 'Date when Phase I laboratory investigation was completed.',
    `phase_i_findings` STRING COMMENT 'Detailed findings from Phase I laboratory investigation including assessment of analyst error, instrument malfunction, calculation error, or other laboratory-related causes.',
    `phase_ii_assignable_cause_found` BOOLEAN COMMENT 'Indicates whether an assignable manufacturing or process cause was identified during Phase II investigation.',
    `phase_ii_completion_date` DATE COMMENT 'Date when Phase II full investigation was completed.',
    `phase_ii_findings` STRING COMMENT 'Detailed findings from Phase II full investigation including assessment of process failure, raw material failure, method failure, or other manufacturing-related causes.',
    `product_code` STRING COMMENT 'Stock Keeping Unit (SKU) or product identifier for the item under investigation.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `qa_review_date` DATE COMMENT 'Date when the investigation was reviewed and approved by quality assurance.',
    `regulatory_report_date` DATE COMMENT 'Date when the OOS investigation was reported to regulatory authorities, if applicable.',
    `regulatory_reportable` BOOLEAN COMMENT 'Indicates whether the OOS investigation findings require reporting to regulatory authorities (FDA, EMA, etc.).',
    `result_invalidated` BOOLEAN COMMENT 'Indicates whether the original OOS result was invalidated based on investigation findings demonstrating laboratory error.',
    `retest_authorization_date` DATE COMMENT 'Date when retesting was authorized by quality assurance.',
    `retest_authorized` BOOLEAN COMMENT 'Indicates whether retesting of the sample was authorized as part of the investigation.',
    `retest_results_summary` STRING COMMENT 'Summary of retest results including number of retests performed and outcomes.',
    `root_cause_category` STRING COMMENT 'Primary category of the identified root cause for the OOS result. [ENUM-REF-CANDIDATE: analyst_error|instrument_malfunction|calculation_error|process_failure|raw_material_failure|method_failure|environmental_condition|no_cause_identified|other — 9 candidates stripped; promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed description of the identified root cause and supporting evidence.',
    `specification_limit_lower` DECIMAL(18,2) COMMENT 'Lower acceptance criterion or specification limit for the test parameter.',
    `specification_limit_upper` DECIMAL(18,2) COMMENT 'Upper acceptance criterion or specification limit for the test parameter.',
    `unit_of_measure` STRING COMMENT 'Unit of measurement for the observed value and specification limits (e.g., mg/mL, %, CFU/mL, ng/µL).',
    CONSTRAINT pk_oos_investigation PRIMARY KEY(`oos_investigation_id`)
) COMMENT 'Out-of-Specification (OOS) investigation record initiated when a QC result falls outside established acceptance criteria. Captures Phase I (laboratory investigation — analyst error, instrument malfunction, calculation error) and Phase II (full investigation — process failure, raw material failure, method failure) findings, invalidation justification if applicable, retesting authorization, assignable cause determination, and regulatory reportability assessment. Supports FDA OOS guidance (2006) compliance, CLIA proficiency testing failure investigation, and CAP accreditation requirements for laboratory investigations.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`quality`.`complaint` (
    `complaint_id` BIGINT COMMENT 'Unique identifier for the customer complaint record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer (research institution, clinical laboratory, biopharma partner, or agricultural genomics client) who submitted the complaint.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Genomics product complaints are analyzed by regulatory approval/market for vigilance reporting (EU MDR, FDA MDR). Complaint trending by approval is required for periodic safety update reports (PSUR), ',
    `asset_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_asset. Business justification: Customer complaints about instrument performance require structured link for field failure analysis, warranty claim validation, MDR/vigilance reporting, and service contract management. Critical for p',
    `batch_id` BIGINT COMMENT 'Foreign key linking to supply.batch. Business justification: Customer complaints citing performance issues or defects require batch-level traceability for investigation, recall assessment, and MDR/vigilance reporting. Lot_number denormalization replaced by prop',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to commercial.campaign. Business justification: Complaints may surface from campaign-driven purchases (conference demos, promotional trials). Linking enables campaign effectiveness assessment, adverse event tracking for promotional materials, and r',
    `capa_id` BIGINT COMMENT 'Reference to the CAPA record initiated in response to this complaint, if applicable.',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.change_control. Business justification: Customer complaints can trigger change controls to address product or process issues. One complaint can trigger one change control; one change control can address multiple complaints. Standard 1:N rel',
    `employee_id` BIGINT COMMENT 'Reference to the user who created this complaint record.',
    `complaint_employee_id` BIGINT COMMENT 'Reference to the quality assurance or customer service team member assigned to handle this complaint.',
    `complaint_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this complaint record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Complaint investigations incur costs (QA labor, laboratory testing, materials, customer replacements) that must be allocated to responsible cost centers for quality cost accounting, budget variance an',
    `deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: Customer complaints can be linked to quality deviations when the complaint is caused by a deviation from procedure. One complaint can be related to one deviation; one deviation can result in multiple ',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Customer complaints about genomic test results (discrepant variant calls, incorrect annotations) require investigation of genome build version used. Critical for root cause analysis and MDR/vigilance ',
    `investigation_id` BIGINT COMMENT 'Reference to the formal quality investigation record initiated for this complaint, if applicable.',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Complaints reference specific product codes for trend analysis, recall scope determination, and MDR reporting. Material master provides regulatory classification, hazard data, and manufacturer part nu',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to commercial.opportunity. Business justification: Customer complaints often originate from products sold via specific opportunities. Linking enables win/loss analysis, product-market fit assessment for new applications, and sales process quality revi',
    `quality_issue_id` BIGINT COMMENT 'Foreign key linking to data.quality_issue. Business justification: Customer complaints about incorrect test results or data discrepancies link to data quality investigations. Required for MDR reporting, root cause analysis, and demonstrating data integrity in complai',
    `sku_id` BIGINT COMMENT 'Reference to the product implicated in the complaint (sequencing instrument, reagent kit, consumable, software, or service).',
    `support_case_id` BIGINT COMMENT 'Salesforce CRM case identifier linking this complaint to the customer service case management system.',
    `variant_database_version_id` BIGINT COMMENT 'Foreign key linking to reference.variant_database_version. Business justification: Complaints about variant interpretation or classification require tracking which variant database version was used for the reported result. Essential for investigating discrepancies and assessing need',
    `document_id` BIGINT COMMENT 'Reference to the controlled document in Veeva Vault containing the full complaint investigation report and supporting documentation.',
    `closed_date` DATE COMMENT 'Date the complaint was formally closed after resolution and customer response.',
    `closure_notes` STRING COMMENT 'Final notes documenting the closure rationale, resolution summary, and any follow-up actions.',
    `complaint_category` STRING COMMENT 'Primary classification of the complaint type based on the nature of the quality issue reported. [ENUM-REF-CANDIDATE: reagent_performance|instrument_malfunction|sequencing_quality|bioinformatics_pipeline_error|labeling_packaging|documentation|delivery_shipping|customer_service|other — 9 candidates stripped; promote to reference product]',
    `complaint_description` STRING COMMENT 'Detailed narrative description of the complaint as reported by the customer, including symptoms, context, and impact.',
    `complaint_number` STRING COMMENT 'Externally-visible unique complaint tracking number assigned upon receipt. Format: CMP-YYYYNNNN.. Valid values are `^CMP-[0-9]{8}$`',
    `complaint_source` STRING COMMENT 'Channel through which the complaint was received. [ENUM-REF-CANDIDATE: customer_direct|field_service|technical_support|sales_representative|distributor|regulatory_authority|social_media — 7 candidates stripped; promote to reference product]',
    `complaint_status` STRING COMMENT 'Current lifecycle status of the complaint in the quality management workflow. [ENUM-REF-CANDIDATE: new|under_review|investigation_in_progress|pending_customer_info|resolved|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective and preventive action (CAPA) is required based on investigation findings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this complaint record was first created in the quality management system.',
    `customer_response_date` DATE COMMENT 'Date the formal response was sent to the customer.',
    `customer_response_sent` BOOLEAN COMMENT 'Indicates whether a formal response has been sent to the customer regarding the complaint resolution.',
    `customer_response_summary` STRING COMMENT 'Summary of the response provided to the customer, including findings, actions taken, and resolution.',
    `diagnostic_impact_assessment` STRING COMMENT 'Assessment of the complaints impact on diagnostic test results, clinical decision-making, or patient care pathways.',
    `investigation_required` BOOLEAN COMMENT 'Indicates whether a formal quality investigation is required for this complaint.',
    `mdr_reportable` BOOLEAN COMMENT 'Indicates whether the complaint meets FDA Medical Device Reporting (MDR) criteria and requires regulatory submission.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this complaint record was last modified.',
    `patient_safety_impact` BOOLEAN COMMENT 'Indicates whether the complaint has potential or actual impact on patient safety or clinical diagnostic outcomes.',
    `priority` STRING COMMENT 'Priority level assigned to the complaint for workflow management and resource allocation.. Valid values are `urgent|high|medium|low`',
    `received_date` DATE COMMENT 'Date the complaint was first received by the organization.',
    `received_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the complaint was logged into the quality management system.',
    `regulatory_report_number` STRING COMMENT 'Reference number for any regulatory report (MDR, vigilance, or other) submitted to authorities in connection with this complaint.',
    `reported_by_email` STRING COMMENT 'Email address of the individual who reported the complaint.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `reported_by_name` STRING COMMENT 'Full name of the individual who reported the complaint.',
    `reported_by_phone` STRING COMMENT 'Contact phone number of the individual who reported the complaint.',
    `root_cause_summary` STRING COMMENT 'Summary of the root cause identified through investigation, if completed.',
    `severity` STRING COMMENT 'Severity classification based on potential impact to patient safety, diagnostic accuracy, or product performance.. Valid values are `critical|major|moderate|minor`',
    `turnaround_time_days` STRING COMMENT 'Target turnaround time in days for complaint resolution based on severity and regulatory requirements.',
    `vigilance_reportable` BOOLEAN COMMENT 'Indicates whether the complaint meets EU vigilance reporting requirements under IVDR.',
    CONSTRAINT pk_complaint PRIMARY KEY(`complaint_id`)
) COMMENT 'Customer complaint record for quality-related issues reported by research institutions, clinical laboratories, biopharma partners, and agricultural genomics clients. Captures complaint source, product/lot implicated, complaint category (reagent performance, instrument malfunction, sequencing quality, bioinformatics pipeline error, labeling/packaging), patient safety or diagnostic impact assessment, MDR/vigilance reportability determination, investigation findings, and customer response. Integrates with Salesforce CRM case management and Veeva Vault for regulatory reporting. Supports FDA 21 CFR Part 820.198, EU IVDR Article 87, and ISO 13485 Clause 8.2.2 complaint handling requirements.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`quality`.`validation_study` (
    `validation_study_id` BIGINT COMMENT 'Unique identifier for the validation study record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Customer-specific assay validations or instrument qualifications are common in genomics services (CLIA labs, pharma partners). Tracking the customer account enables validation documentation delivery, ',
    `employee_id` BIGINT COMMENT 'Reference to the user who last modified the validation study record.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Genomics assay validations (NGS, microarray, qPCR) are performed to support specific regulatory approvals (FDA 510(k), CE-IVD). Validation reports are approval-specific technical documentation. Essent',
    `asset_id` BIGINT COMMENT 'Reference to the equipment or instrument being qualified. Applicable for equipment qualification studies (IQ/OQ/PQ).',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.change_control. Business justification: Validation studies are often performed as part of change control implementation to verify effectiveness. One validation study can be part of one change control; one change control can require multiple',
    `gene_annotation_track_id` BIGINT COMMENT 'Foreign key linking to reference.gene_annotation_track. Business justification: Assay validation for gene panels and RNA-seq must document the gene annotation version (GENCODE, RefSeq) used for target definition, coverage analysis, and performance metrics. Critical for regulatory',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Assay validation studies must document the reference genome version used for method development and performance characterization. Required for FDA/EMA regulatory submissions and method reproducibility',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Validation studies (IQ/OQ/PQ for equipment, process validation, software validation) are capital projects requiring budget tracking and cost accumulation. Internal orders enable cost center allocation',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Analytical method validations (accuracy, precision, LOD/LOQ) are performed on specific reagents, kits, or controls. Material changes trigger revalidation. Critical for assay qualification and regulato',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to commercial.opportunity. Business justification: Validation studies are often performed to support specific sales opportunities (custom assay development, method transfers, IQ/OQ/PQ for instrument sales). Linking enables project tracking, revenue re',
    `controlled_document_id` BIGINT COMMENT 'Reference to the controlled validation protocol document in Veeva Vault or MasterControl that defines the study design, procedures, and acceptance criteria.',
    `primary_validation_employee_id` BIGINT COMMENT 'Reference to the internal department, project, or business unit sponsoring the validation study.',
    `qualification_protocol_id` BIGINT COMMENT 'Foreign key linking to quality.qualification_protocol. Business justification: Validation studies follow a specific qualification protocol; the FK captures this relationship.',
    `quaternary_validation_regulatory_approver_employee_id` BIGINT COMMENT 'Reference to the regulatory affairs personnel who approved the validation study for regulatory submission purposes.',
    `quinary_validation_created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created the validation study record.',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Validation protocols and reports are core Module 3 technical documentation in eCTD submissions for genomics diagnostics. Direct submission linkage enables tracking which validation studies were includ',
    `tertiary_validation_qa_reviewer_employee_id` BIGINT COMMENT 'Reference to the QA personnel responsible for reviewing and approving the validation study report.',
    `variant_database_version_id` BIGINT COMMENT 'Foreign key linking to reference.variant_database_version. Business justification: Validation studies for variant calling pipelines must document the variant database version used for benchmarking, accuracy assessment, and clinical sensitivity/specificity calculations. Required for ',
    `acceptance_criteria` STRING COMMENT 'Pre-defined acceptance criteria that the validation study must meet to be considered successful. Includes performance specifications, statistical thresholds, and regulatory requirements.',
    `assay_name` STRING COMMENT 'Name of the assay, method, or process being validated. Applicable for method validation and assay validation studies.',
    `assay_version` STRING COMMENT 'Version of the assay or method being validated.',
    `capa_required` BOOLEAN COMMENT 'Indicates whether the validation study results require a CAPA to be initiated (True if CAPA needed, False otherwise).',
    `comments` STRING COMMENT 'Additional comments, notes, or observations related to the validation study.',
    `conclusion_summary` STRING COMMENT 'Detailed summary of the validation study conclusion, including key findings, performance metrics achieved, and any deviations or limitations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the validation study record was first created in the system.',
    `deviation_count` STRING COMMENT 'Number of deviations from the validation protocol that occurred during study execution.',
    `intended_use` STRING COMMENT 'Intended use classification of the validated assay, method, or system: RUO (Research Use Only), IVD (In Vitro Diagnostic - FDA/CE-IVD regulated), LDT (Laboratory Developed Test - CLIA/CAP regulated), clinical_trial (for clinical trial support), manufacturing (for GMP manufacturing process), internal_use (for internal quality control).. Valid values are `RUO|IVD|LDT|clinical_trial|manufacturing|internal_use`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the validation study record was last modified.',
    `process_name` STRING COMMENT 'Name of the manufacturing or laboratory process being validated. Applicable for process validation studies.',
    `protocol_version` STRING COMMENT 'Version number of the validation protocol document being executed.',
    `qa_approval_date` DATE COMMENT 'Date when the QA reviewer approved the validation study report.',
    `regulatory_approval_date` DATE COMMENT 'Date when the regulatory approver signed off on the validation study.',
    `regulatory_standard` STRING COMMENT 'Primary regulatory standard or guideline governing this validation study, such as FDA 21 CFR Part 11, ICH Q2(R1), CLSI EP05-A3, CLSI EP06-A, CLSI EP15-A3, ISO 13485, or CLIA/CAP requirements.',
    `regulatory_submission_type` STRING COMMENT 'Type of regulatory submission this validation study supports, such as FDA 510(k), FDA PMA, CE-IVD Technical File, CLIA/CAP LDT validation, or internal GxP compliance. [ENUM-REF-CANDIDATE: FDA_510k|FDA_PMA|FDA_De_Novo|CE_IVD|CLIA_CAP_LDT|GMP_Process|Internal_GxP|Clinical_Trial_IND — promote to reference product]',
    `report_version` STRING COMMENT 'Version number of the validation report document.',
    `revalidation_due_date` DATE COMMENT 'Date when the next revalidation or periodic review of this validation study is due, based on regulatory requirements or internal quality policies.',
    `sample_size` STRING COMMENT 'Number of samples, replicates, or test runs included in the validation study.',
    `software_system_name` STRING COMMENT 'Name of the software system being validated. Applicable for Computer System Validation (CSV) studies.',
    `software_version` STRING COMMENT 'Version of the software system being validated.',
    `statistical_method` STRING COMMENT 'Statistical approach and methods used for data analysis in the validation study, such as ANOVA, regression analysis, Bland-Altman, or descriptive statistics.',
    `study_end_date` DATE COMMENT 'Date when the validation study execution was completed.',
    `study_number` STRING COMMENT 'Business identifier for the validation study, externally visible and used in regulatory submissions and quality documentation.. Valid values are `^VS-[0-9]{6,10}$`',
    `study_objective` STRING COMMENT 'Detailed objective and purpose of the validation study, including what is being validated and why.',
    `study_phase` STRING COMMENT 'Phase of process validation: phase_1 (process design), phase_2 (process qualification), phase_3 (continued process verification), revalidation (periodic revalidation), ongoing_verification (routine monitoring). Primarily applicable to process validation studies.. Valid values are `phase_1|phase_2|phase_3|revalidation|ongoing_verification`',
    `study_start_date` DATE COMMENT 'Date when the validation study execution began.',
    `study_status` STRING COMMENT 'Current lifecycle status of the validation study: draft (protocol being prepared), protocol_approved (ready to execute), in_progress (study execution underway), data_collection_complete (all testing finished), under_review (analysis and report under QA review), approved (study concluded successfully), rejected (study failed acceptance criteria), cancelled (study terminated before completion). [ENUM-REF-CANDIDATE: draft|protocol_approved|in_progress|data_collection_complete|under_review|approved|rejected|cancelled — 8 candidates stripped; promote to reference product]',
    `study_title` STRING COMMENT 'Descriptive title of the validation study summarizing the scope and purpose.',
    `validation_conclusion` STRING COMMENT 'Overall conclusion of the validation study: passed (all acceptance criteria met), failed (one or more criteria not met), conditional_pass (passed with minor deviations or additional controls), inconclusive (insufficient data or study issues prevent conclusion).. Valid values are `passed|failed|conditional_pass|inconclusive`',
    `validation_subtype` STRING COMMENT 'Further classification of the validation study within the primary type, such as IQ (Installation Qualification), OQ (Operational Qualification), PQ (Performance Qualification) for equipment qualification, or full validation vs partial validation for methods.',
    `validation_type` STRING COMMENT 'Category of validation study being performed: method validation (analytical method), assay validation (clinical assay performance), software validation (CSV - Computer System Validation), equipment qualification (IQ/OQ/PQ - Installation/Operational/Performance Qualification), process validation (manufacturing process), or cleaning validation (equipment cleaning procedures).. Valid values are `method_validation|assay_validation|software_validation|equipment_qualification|process_validation|cleaning_validation`',
    CONSTRAINT pk_validation_study PRIMARY KEY(`validation_study_id`)
) COMMENT 'Analytical and process validation study master record covering method validation, assay validation, software validation (CSV), equipment qualification (IQ/OQ/PQ), and process validation for GxP-regulated activities. Captures validation type, applicable regulatory standard (FDA 21 CFR Part 11, ICH Q2(R1), CLSI EP guidelines), validation protocol document reference, acceptance criteria, study execution dates, statistical analysis approach, validation conclusion, and approval chain. Supports clinical assay analytical validation for CLIA/CAP LDT submissions and IVD performance studies for FDA/CE-IVD submissions.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`quality`.`stability_study` (
    `stability_study_id` BIGINT COMMENT 'Unique identifier for the stability study record. Primary key for the stability study entity.',
    `batch_id` BIGINT COMMENT 'Foreign key linking to supply.batch. Business justification: ICH stability studies are conducted on specific production batches to establish shelf life. Protocol requires batch manufacturing date, storage conditions, and CoA linkage. Essential for regulatory su',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.change_control. Business justification: Stability studies are often performed as part of change control for product formulation or storage changes. One stability study can be part of one change control; one change control can require multip',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Stability studies are multi-year resource commitments (laboratory time, materials, storage, testing) requiring cost center allocation for R&D expense tracking, budget management, and regulatory submis',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Stability protocols are material-specific (each SKU has unique formulation, container closure). Material master holds storage conditions, shelf life, and regulatory status. Replaces denormalized produ',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to commercial.opportunity. Business justification: Stability studies may be commissioned for specific customer opportunities (custom formulations, extended dating for export markets, temperature excursion studies). Linking enables project costing, del',
    `submission_id` BIGINT COMMENT 'Identifier for the regulatory submission (510(k), PMA, CE-IVD technical file) that includes this stability study data. Links stability evidence to market authorization applications.',
    `acceptance_criteria` STRING COMMENT 'Detailed specification of stability-indicating assay acceptance criteria that the product must meet at each time point. Includes parameters such as potency, purity, impurities, pH, appearance, and functional performance thresholds. Failure to meet criteria indicates end of shelf life.',
    `assigned_shelf_life_months` STRING COMMENT 'Shelf life in months assigned to the product based on stability study results. Determined by the longest time point where all acceptance criteria are met with appropriate statistical confidence. Appears on product labeling and Certificate of Analysis (COA).',
    `batch_scale` STRING COMMENT 'Manufacturing scale of the lot enrolled in the stability study. Pilot batches are small-scale development batches; production batches are commercial-scale; validation batches are used for process validation and initial regulatory submission.. Valid values are `pilot|production|validation`',
    `capa_required_flag` BOOLEAN COMMENT 'Indicates whether stability study results triggered a CAPA investigation. True when out-of-specification results, unexpected degradation, or shelf-life failures require root cause analysis and corrective action.',
    `coa_reference_flag` BOOLEAN COMMENT 'Indicates whether this stability study is referenced on the product Certificate of Analysis (COA) for expiry dating justification. True for primary stability studies supporting shelf-life claims.',
    `container_closure_system` STRING COMMENT 'Description of the primary packaging configuration used in the stability study. Includes container type, material, size, and closure mechanism. Must match commercial packaging to ensure representative stability data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the stability study record was first created in the system. Audit trail for data governance and compliance.',
    `deviation_count` STRING COMMENT 'Number of quality deviations recorded during the stability study execution. Includes storage excursions, missed time points, and protocol deviations. Zero indicates study conducted per protocol.',
    `expiry_date_format` STRING COMMENT 'Format specification for expiry date labeling on product packaging. Day-level precision for short shelf-life products; month-level precision for products with shelf life greater than 12 months per regulatory guidance.. Valid values are `yyyy-MM-dd|yyyy-MM|yyyy-MM-dd HH:mm`',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Indicates whether the stability study was conducted under GMP conditions per 21 CFR Part 211. True for studies supporting regulatory submissions and commercial products; false for research-use-only (RUO) product development studies.',
    `ich_climatic_zone` STRING COMMENT 'ICH climatic zone classification for the intended market. Zone I: temperate climate; Zone II: subtropical/Mediterranean; Zone III: hot/dry; Zone IV: hot/humid; Zone IVa: hot/humid with high temperature; Zone IVb: hot/very humid. Determines storage condition requirements.. Valid values are `I|II|III|IV|IVa|IVb`',
    `lims_study_reference` STRING COMMENT 'External identifier for the stability study in LabVantage LIMS. Used for integration with laboratory workflow, sample scheduling, and test result capture.',
    `modified_by` STRING COMMENT 'User identifier of the person who last modified the stability study record. Maintains complete audit trail for regulatory compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the stability study record. Tracks data currency and change history.',
    `principal_investigator` STRING COMMENT 'Name of the scientist or quality professional responsible for stability study design, execution, and data interpretation. Accountable for study integrity and regulatory compliance.',
    `regulatory_purpose` STRING COMMENT 'Regulatory driver for conducting the stability study. Initial registration supports new product approval; post-approval commitment fulfills regulatory agency requirements; annual stability ensures ongoing compliance; change control evaluates impact of manufacturing changes; shelf-life extension supports expiry date extension; market surveillance monitors commercial product stability.. Valid values are `initial-registration|post-approval-commitment|annual-stability|change-control|shelf-life-extension|market-surveillance`',
    `sample_size` STRING COMMENT 'Number of product units enrolled in the stability study. Must be sufficient to support all planned time points and replicate testing per ICH guidelines.',
    `sap_qm_inspection_lot` STRING COMMENT 'SAP QM inspection lot number linked to the stability study. Connects stability data to lot release decisions and quality notifications in SAP S/4HANA QM module.',
    `stability_indicating_assays` STRING COMMENT 'Comma-separated list of analytical test methods used to assess product stability. Examples: HPLC for purity, qPCR for enzyme activity, spectrophotometry for concentration, visual inspection for appearance, pH measurement. These assays must be validated to detect degradation.',
    `storage_condition` STRING COMMENT 'Environmental storage condition specification for the stability study including temperature, relative humidity, and light exposure. Examples: 25°C ± 2°C / 60% RH ± 5%, 40°C ± 2°C / 75% RH ± 5%, -20°C ± 5°C, 2-8°C. Follows ICH climatic zone definitions.',
    `storage_humidity_percent` DECIMAL(18,2) COMMENT 'Target relative humidity percentage for the stability study storage condition. Null for frozen storage conditions where humidity control is not applicable.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Target storage temperature in degrees Celsius for the stability study. Numeric representation extracted from storage condition for analytical purposes.',
    `study_completion_date` DATE COMMENT 'Date when the final time point testing was completed and study data analysis finalized. Null for ongoing studies.',
    `study_duration_months` STRING COMMENT 'Total planned duration of the stability study in months. Typical durations: 12-36 months for real-time studies, 6 months for accelerated studies, 12 months for intermediate studies per ICH guidelines.',
    `study_notes` STRING COMMENT 'Free-text field for additional study information, observations, and context. Includes notes on study design rationale, deviations, special handling requirements, and lessons learned.',
    `study_protocol_number` STRING COMMENT 'Unique protocol identifier assigned to the stability study following ICH Q1A/Q1B guidelines. Used for regulatory submission and traceability.. Valid values are `^[A-Z0-9]{3,20}$`',
    `study_sponsor` STRING COMMENT 'Business unit or department sponsoring the stability study. Typically Quality Assurance, Regulatory Affairs, or Product Development. Responsible for study oversight and funding.',
    `study_start_date` DATE COMMENT 'Date when the stability study was initiated and samples were placed on stability storage. Marks time zero for all time point calculations.',
    `study_status` STRING COMMENT 'Current lifecycle status of the stability study. Planned indicates study design approved but not initiated; active indicates ongoing testing; on-hold indicates temporary suspension; completed indicates all time points tested and data analyzed; cancelled indicates study terminated; under-review indicates final data review and shelf-life determination in progress.. Valid values are `planned|active|on-hold|completed|cancelled|under-review`',
    `study_type` STRING COMMENT 'Classification of the stability study program. Real-time studies establish shelf life under recommended storage conditions; accelerated studies predict shelf life under elevated stress; intermediate studies bridge real-time and accelerated; stress studies determine degradation pathways; in-use studies assess stability after package opening; photostability studies evaluate light exposure effects.. Valid values are `real-time|accelerated|intermediate|stress|in-use|photostability`',
    `time_point_schedule` STRING COMMENT 'Comma-separated list of planned time points in months for sample testing. Example: 0,3,6,9,12,18,24,36 for long-term real-time study. Defines the pull schedule for stability sample testing.',
    `veeva_vault_document_reference` STRING COMMENT 'Document identifier in Veeva Vault for the stability study protocol and final report. Ensures controlled document management and regulatory audit trail.',
    `created_by` STRING COMMENT 'User identifier of the person who created the stability study record. Supports audit trail and accountability requirements.',
    CONSTRAINT pk_stability_study PRIMARY KEY(`stability_study_id`)
) COMMENT 'Stability study master record tracking real-time and accelerated stability programs for reagent kits, consumables, flow cells, and library preparation components. Captures study design (ICH Q1A/Q1B protocol), storage conditions (temperature, humidity, light), time points, acceptance criteria per stability-indicating assay, pull schedule, and shelf-life determination. Tracks ongoing stability commitments for post-market surveillance and supports expiry dating on COAs. Integrates with LabVantage LIMS for stability sample scheduling and SAP QM for lot release decisions.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`quality`.`change_control` (
    `change_control_id` BIGINT COMMENT 'Unique identifier for the change control record. Primary key for the change control entity.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `controlled_document_id` BIGINT COMMENT 'Foreign key linking to quality.controlled_document. Business justification: Change controls often affect controlled documents (SOPs, specifications, protocols). One change control can affect one primary document; one document can be affected by multiple change controls. Stand',
    `gene_annotation_track_id` BIGINT COMMENT 'Foreign key linking to reference.gene_annotation_track. Business justification: Changes to gene annotation versions require change control to assess impact on panel design, coverage metrics, and transcript quantification. Critical for maintaining assay performance and regulatory ',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Changes to reference genome versions in production pipelines require formal change control with validation, impact assessment, and regulatory notification. Critical for maintaining GxP compliance and ',
    `owner_employee_id` BIGINT COMMENT 'Identifier of the employee assigned as the change owner, responsible for coordinating impact assessment, approval routing, and implementation. Links to workforce or employee master data.',
    `primary_change_employee_id` BIGINT COMMENT 'Identifier of the employee who initiated the change control request. Links to workforce or employee master data.',
    `quality_training_curriculum_id` BIGINT COMMENT 'Foreign key linking to quality.training_curriculum. Business justification: Change controls can require training curriculum updates when procedures or processes change. One change control can affect one curriculum; one curriculum can be affected by multiple change controls. S',
    `quaternary_change_initiator_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `tertiary_change_regulatory_approver_employee_id` BIGINT COMMENT 'Identifier of the Regulatory Affairs representative who approved the change control. Links to workforce or employee master data. Null if Regulatory approval is not yet obtained or not required.',
    `variant_database_version_id` BIGINT COMMENT 'Foreign key linking to reference.variant_database_version. Business justification: Updates to variant databases (ClinVar, gnomAD) in clinical pipelines require change control to assess impact on variant interpretation, reclassifications, and patient reporting. Required for CAP/CLIA ',
    `actual_implementation_date` DATE COMMENT 'Actual date on which the change was fully implemented. Null if implementation is not yet complete.',
    `affected_equipment_list` STRING COMMENT 'Comma-separated or structured list of equipment asset IDs or instrument serial numbers impacted by the change. Used for equipment qualification and maintenance planning.',
    `affected_facility_list` STRING COMMENT 'Comma-separated or structured list of facility locations, cleanrooms, or manufacturing sites impacted by the change. Used for facility qualification and environmental monitoring.',
    `affected_product_list` STRING COMMENT 'Comma-separated or structured list of product SKUs, catalog numbers, or product families impacted by the change. Used for traceability and scope definition.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether formal cross-functional approval is required for this change control. True for GxP-impactful changes requiring Quality Assurance, Regulatory Affairs, and functional area approval; False for administrative changes with simplified routing.',
    `approval_routing_path` STRING COMMENT 'Structured representation of the approval workflow path, listing required approvers by role or department (e.g., Quality Assurance, Regulatory Affairs, Manufacturing, Engineering, R&D). May be comma-separated or JSON-encoded.',
    `change_category` STRING COMMENT 'Functional category of the change control request. Defines the operational domain affected by the change: manufacturing process modifications, equipment qualification changes, raw material or reagent changes, software system updates, facility modifications, analytical method validation changes, or controlled document revisions (SOP, specification, protocol). [ENUM-REF-CANDIDATE: manufacturing_process|equipment|material|software|facility|analytical_method|document_revision — 7 candidates stripped; promote to reference product]',
    `change_control_description` STRING COMMENT 'Detailed narrative describing the proposed change, including current state, proposed future state, rationale, and business justification. Provides comprehensive context for impact assessment and approval decision-making.',
    `change_control_number` STRING COMMENT 'Business-facing unique identifier for the change control request, typically formatted as CC-NNNNNN. Used for cross-functional communication and regulatory traceability.. Valid values are `^CC-[0-9]{6,10}$`',
    `change_status` STRING COMMENT 'Current lifecycle status of the change control request. Tracks progression from initiation through approval, implementation, and closure. Draft: initial creation. Submitted: routed for review. Under Review: impact assessment and approval routing in progress. Approved: authorized for implementation. Rejected: not approved. Implementation: change being executed. Completed: implementation finished, awaiting effectiveness check. Closed: effectiveness verified and change control archived. Cancelled: withdrawn before completion. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|implementation|completed|closed|cancelled — 9 candidates stripped; promote to reference product]',
    `change_type` STRING COMMENT 'Classification of the change based on regulatory and business impact. Major: significant process/product changes requiring regulatory submission. Minor: low-impact changes with limited scope. Critical: urgent changes affecting patient safety or product quality. Administrative: documentation-only changes with no GxP impact.. Valid values are `major|minor|critical|administrative`',
    `closure_comments` STRING COMMENT 'Final comments or notes recorded at the time of change control closure, summarizing outcomes, lessons learned, or follow-up actions.',
    `closure_date` DATE COMMENT 'Date on which the change control was formally closed after successful implementation and effectiveness verification. Null if the change control is not yet closed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the change control record was first created in the system. Used for audit trail and lifecycle tracking.',
    `document_impact_flag` BOOLEAN COMMENT 'Indicates whether the change requires updates to controlled documents (SOPs, specifications, protocols, work instructions, batch records, device master records). True if document updates are required; False otherwise.',
    `effectiveness_check_date` DATE COMMENT 'Date on which the post-implementation effectiveness check was completed. Null if effectiveness check is not yet performed or not required.',
    `effectiveness_check_required_flag` BOOLEAN COMMENT 'Indicates whether a post-implementation effectiveness check is required to verify that the change achieved its intended objectives and did not introduce unintended consequences. True if effectiveness check is required; False otherwise.',
    `effectiveness_check_result` STRING COMMENT 'Outcome of the post-implementation effectiveness check. Effective: change achieved intended objectives. Partially Effective: some objectives met, additional action required. Ineffective: objectives not met, corrective action required. Not Applicable: effectiveness check not required or not yet performed.. Valid values are `effective|partially_effective|ineffective|not_applicable`',
    `impact_assessment_summary` STRING COMMENT 'Consolidated summary of cross-functional impact assessment results, covering regulatory, validation, training, documentation, supply chain, and operational impacts. Informs approval decision and implementation planning.',
    `implementation_plan` STRING COMMENT 'Detailed plan describing how the approved change will be executed, including tasks, responsibilities, timelines, resource requirements, and success criteria. May reference linked project plans or work orders.',
    `initiator_department` STRING COMMENT 'Organizational department or functional area of the change initiator (e.g., Manufacturing, Quality Assurance, R&D, Regulatory Affairs, Engineering). Used for cross-functional impact analysis and routing.',
    `justification` STRING COMMENT 'Business and technical rationale for the proposed change. May include quality improvement objectives, cost reduction, regulatory compliance requirements, risk mitigation, process optimization, or corrective action linkage.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the change control record was last modified. Updated on any field change. Used for audit trail and version control.',
    `planned_implementation_date` DATE COMMENT 'Target date for completing the implementation of the approved change. Used for scheduling, resource planning, and tracking.',
    `priority` STRING COMMENT 'Business priority level assigned to the change control request. Critical: immediate action required (safety, regulatory, or business continuity). High: significant impact, expedited review. Medium: standard processing. Low: minimal impact, routine processing.. Valid values are `critical|high|medium|low`',
    `qa_approval_date` DATE COMMENT 'Date on which Quality Assurance approved the change control. Null if QA approval is not yet obtained or not required.',
    `regulatory_approval_date` DATE COMMENT 'Date on which Regulatory Affairs approved the change control. Null if Regulatory approval is not yet obtained or not required.',
    `regulatory_impact_flag` BOOLEAN COMMENT 'Indicates whether the change requires regulatory notification or submission (PAS, CBE-30, CBE-0, annual report). True if regulatory submission is required; False otherwise.',
    `regulatory_submission_type` STRING COMMENT 'Type of regulatory submission required for the change. PAS (Prior Approval Supplement): major changes requiring pre-approval. CBE-30 (Changes Being Effected in 30 Days): moderate changes with 30-day notification. CBE-0 (Changes Being Effected): minor changes with immediate notification. Annual Report: reportable in annual submission. None: no regulatory submission required.. Valid values are `PAS|CBE-30|CBE-0|annual_report|none`',
    `risk_level` STRING COMMENT 'Risk assessment classification based on potential impact to product quality, patient safety, regulatory compliance, and business operations. Determines the rigor of impact assessment and approval routing requirements.. Valid values are `high|medium|low`',
    `title` STRING COMMENT 'Concise, descriptive title summarizing the nature and scope of the proposed change. Used for quick identification in dashboards, reports, and approval workflows.',
    `training_impact_flag` BOOLEAN COMMENT 'Indicates whether the change requires training or retraining of personnel (SOP training, equipment training, software training). True if training is required; False otherwise.',
    `validation_impact_flag` BOOLEAN COMMENT 'Indicates whether the change requires revalidation, requalification, or verification activities (process validation, equipment qualification, software validation, analytical method validation). True if validation activities are required; False otherwise.',
    CONSTRAINT pk_change_control PRIMARY KEY(`change_control_id`)
) COMMENT 'Unified quality change control record governing all GxP-impactful changes — including manufacturing processes, equipment, materials, software, facilities, analytical methods, and controlled document revisions. Manages the complete change lifecycle: initiation, impact assessment (regulatory, validation, training, document), cross-functional approval routing, implementation authorization, and post-change effectiveness verification. Encompasses both document-level changes (SOP revisions, specification updates) and broader operational changes requiring regulatory submission (PAS, CBE-30, CBE-0). Integrates with Veeva Vault for change control workflow, MasterControl for document revision routing, and SAP for ERP-side change implementation. Supports FDA 21 CFR Part 820.40, ICH Q10, and ISO 13485 Clause 7.3.9.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`quality`.`risk_assessment` (
    `risk_assessment_id` BIGINT COMMENT 'Primary key for risk_assessment',
    `controlled_document_id` BIGINT COMMENT 'Reference to the stored assessment report or supporting documentation.',
    `employee_id` BIGINT COMMENT 'Identifier of the person or group responsible for managing the risk.',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the individual who performed the latest review of the assessment.',
    `previous_risk_assessment_id` BIGINT COMMENT 'Self-referencing FK on risk_assessment (previous_risk_assessment_id)',
    `assessment_code` STRING COMMENT 'Business code used to reference the assessment in reports and SOPs.',
    `assessment_date` DATE COMMENT 'Date on which the risk assessment was performed.',
    `assessment_type` STRING COMMENT 'Category of the assessment based on the area of the organization it evaluates.',
    `compliance_status` STRING COMMENT 'Result of the assessment against the referenced regulatory requirement.',
    `control_effectiveness_score` DECIMAL(18,2) COMMENT 'Rating (0‑10) of how effective existing controls are at mitigating the risk.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the assessment record was first created in the system.',
    `effective_date` DATE COMMENT 'Date on which the risk assessment becomes active.',
    `expiry_date` DATE COMMENT 'Date on which the risk assessment expires or is superseded; null if open‑ended.',
    `impact_score` DECIMAL(18,2) COMMENT 'Numeric rating (0‑10) of the expected impact if the risk materialises.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the risk is deemed critical for immediate action.',
    `last_review_date` DATE COMMENT 'Date of the most recent review or update of the assessment.',
    `likelihood_score` DECIMAL(18,2) COMMENT 'Numeric rating (0‑10) of the probability that the risk will occur.',
    `mitigation_plan` STRING COMMENT 'Textual description of actions planned or taken to mitigate the identified risk.',
    `risk_assessment_name` STRING COMMENT 'Human‑readable title of the risk assessment.',
    `next_review_date` DATE COMMENT 'Planned date for the next periodic review of the risk assessment.',
    `notes` STRING COMMENT 'Additional free‑form comments captured by the assessor.',
    `regulatory_reference` STRING COMMENT 'Reference to the specific regulation, guideline, or standard that drives the assessment (e.g., 21 CFR Part 11).',
    `risk_category` STRING COMMENT 'High‑level classification of the risk being assessed.',
    `risk_level` STRING COMMENT 'Overall risk level derived from severity, likelihood and controls.',
    `severity_score` DECIMAL(18,2) COMMENT 'Numeric rating (0‑10) of the potential impact severity.',
    `risk_assessment_status` STRING COMMENT 'Current lifecycle state of the assessment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the assessment record.',
    CONSTRAINT pk_risk_assessment PRIMARY KEY(`risk_assessment_id`)
) COMMENT 'Master reference table for risk_assessment. Referenced by risk_assessment_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`quality`.`qualification_protocol` (
    `qualification_protocol_id` BIGINT COMMENT 'Primary key for qualification_protocol',
    `superseded_qualification_protocol_id` BIGINT COMMENT 'Self-referencing FK on qualification_protocol (superseded_qualification_protocol_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the protocol was approved.',
    `assay_type` STRING COMMENT 'Type of assay the protocol supports.',
    `author` STRING COMMENT 'Name of the person who authored the protocol.',
    `change_control_number` STRING COMMENT 'Identifier of the change control record associated with the protocol revision.',
    `qualification_protocol_code` STRING COMMENT 'Unique business code used to reference the protocol.',
    `compliance_status` STRING COMMENT 'Current compliance status of the protocol with regulatory requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the protocol record was created in the system.',
    `department_responsible` STRING COMMENT 'Department that owns and maintains the protocol.',
    `deviation_allowed` BOOLEAN COMMENT 'Indicates if deviations from the protocol are permitted.',
    `document_format` STRING COMMENT 'File format of the stored protocol document.',
    `document_url` STRING COMMENT 'Link to the stored protocol document.',
    `effective_from` DATE COMMENT 'Date when the protocol becomes effective.',
    `effective_until` DATE COMMENT 'Date when the protocol expires or is superseded.',
    `equipment_required` STRING COMMENT 'List of equipment required to execute the protocol.',
    `is_controlled` BOOLEAN COMMENT 'Indicates whether the protocol is a controlled GxP document.',
    `language` STRING COMMENT 'Language in which the protocol is written.',
    `last_review_date` DATE COMMENT 'Date when the protocol was last reviewed.',
    `qualification_protocol_name` STRING COMMENT 'Human‑readable name of the qualification protocol.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next protocol review.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the protocol.',
    `related_standards` STRING COMMENT 'Standards or guidelines referenced by the protocol.',
    `retention_period_years` STRING COMMENT 'Number of years the protocol must be retained.',
    `retention_policy` STRING COMMENT 'Policy governing the disposition of the protocol after its retention period.',
    `reviewer` STRING COMMENT 'Name of the person who reviewed and approved the protocol.',
    `risk_level` STRING COMMENT 'Risk classification associated with the protocol.',
    `sample_type` STRING COMMENT 'Sample types applicable to the protocol.',
    `qualification_protocol_status` STRING COMMENT 'Current lifecycle status of the protocol.',
    `qualification_protocol_type` STRING COMMENT 'Category of the protocol (e.g., analytical, manufacturing, software, equipment).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the protocol record.',
    `validation_date` DATE COMMENT 'Date when the protocol was validated.',
    `validation_status` STRING COMMENT 'Current status of the protocol validation process.',
    `version_number` DECIMAL(18,2) COMMENT 'Version number of the protocol.',
    CONSTRAINT pk_qualification_protocol PRIMARY KEY(`qualification_protocol_id`)
) COMMENT 'Master reference table for qualification_protocol. Referenced by qualification_protocol_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`quality`.`test_method` (
    `test_method_id` BIGINT COMMENT 'Primary key for test_method',
    `superseded_test_method_id` BIGINT COMMENT 'Self-referencing FK on test_method (superseded_test_method_id)',
    `applicable_sample_type` STRING COMMENT 'Sample matrix(s) the method can analyze.',
    `approved_by` STRING COMMENT 'Name of the individual who approved the method for use.',
    `assay_target` STRING COMMENT 'Gene, protein, or biomarker the assay is designed to detect.',
    `test_method_category` STRING COMMENT 'Higher‑level grouping such as nucleic‑acid, protein, or cell‑based assay.',
    `test_method_code` STRING COMMENT 'Unique business code used to reference the test method in lab systems.',
    `compliance_standards` STRING COMMENT 'List of standards (e.g., GxP, ISO 13485) the method complies with.',
    `cost_per_test` DECIMAL(18,2) COMMENT 'Estimated cost to run a single test using this method.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test method record was first created.',
    `detection_limit` DECIMAL(18,2) COMMENT 'Lowest analyte concentration reliably detected by the method.',
    `documentation_url` STRING COMMENT 'Link to the SOP or validation documentation for the method.',
    `effective_date` DATE COMMENT 'Date the method becomes officially usable.',
    `expiration_date` DATE COMMENT 'Date after which the method is retired or must be re‑validated.',
    `instrument_model` STRING COMMENT 'Model of the instrument required to execute the method.',
    `is_clia_compliant` BOOLEAN COMMENT 'True if the method is CLIA‑certified.',
    `is_fda_compliant` BOOLEAN COMMENT 'True if the method complies with FDA 21 CFR Part 11.',
    `is_gxp_compliant` BOOLEAN COMMENT 'True if the method meets GxP requirements.',
    `last_review_date` DATE COMMENT 'Date the method was last reviewed for relevance and compliance.',
    `lot_number` STRING COMMENT 'Manufacturing lot identifier for the assay kit.',
    `manufacturer` STRING COMMENT 'Company that produces the assay kit or reagents.',
    `manufacturer_part_number` STRING COMMENT 'Vendor‑assigned part number for the assay kit.',
    `method_owner` STRING COMMENT 'Department or team responsible for the method.',
    `method_type` STRING COMMENT 'Category of the method (e.g., PCR, NGS, Microarray).',
    `test_method_name` STRING COMMENT 'Human‑readable name of the test method.',
    `notes` STRING COMMENT 'Free‑form comments or special considerations.',
    `regulatory_approval_number` STRING COMMENT 'Identifier assigned by the regulatory authority for the approved method.',
    `regulatory_body` STRING COMMENT 'Regulatory agency that granted approval.',
    `requires_training` BOOLEAN COMMENT 'Indicates whether personnel must complete specific training to use the method.',
    `review_cycle_months` STRING COMMENT 'Number of months between scheduled method reviews.',
    `risk_level` STRING COMMENT 'Risk classification for using the method in clinical testing.',
    `sensitivity` DECIMAL(18,2) COMMENT 'Proportion of true positives correctly identified (percentage).',
    `specificity` DECIMAL(18,2) COMMENT 'Proportion of true negatives correctly identified (percentage).',
    `test_method_status` STRING COMMENT 'Current lifecycle state of the method.',
    `training_version` STRING COMMENT 'Version of the training curriculum associated with the method.',
    `turnaround_time_hours` DECIMAL(18,2) COMMENT 'Typical time from sample receipt to result reporting.',
    `unit_of_measure` STRING COMMENT 'Unit associated with the detection limit (e.g., copies/mL).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the test method record.',
    `validation_date` DATE COMMENT 'Date the method was last validated.',
    `validation_status` STRING COMMENT 'Current validation state of the method.',
    `version` STRING COMMENT 'Version identifier for the method specification.',
    CONSTRAINT pk_test_method PRIMARY KEY(`test_method_id`)
) COMMENT 'Master reference table for test_method. Referenced by test_method_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`quality`.`audit_report` (
    `audit_report_id` BIGINT COMMENT 'Primary key for audit_report',
    `audit_id` BIGINT COMMENT 'Foreign key linking to quality.audit. Business justification: Audit reports are child records of audits; linking them provides direct access to audit details.',
    `employee_id` BIGINT COMMENT 'Identifier of the auditor who performed the audit.',
    `revised_audit_report_id` BIGINT COMMENT 'Self-referencing FK on audit_report (revised_audit_report_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit report was approved.',
    `approved_by` STRING COMMENT 'Name of the individual who approved the audit report.',
    `audit_date` DATE COMMENT 'Date when the audit was conducted.',
    `audit_methodology` STRING COMMENT 'Methodology used for conducting the audit (e.g., GxP, ISO 13485).',
    `audit_score` DECIMAL(18,2) COMMENT 'Composite score derived from audit criteria (0-100).',
    `audit_type` STRING COMMENT 'Category of audit performed.',
    `auditor_name` STRING COMMENT 'Name of the auditor who performed the audit.',
    `comments` STRING COMMENT 'Additional comments or notes.',
    `confidentiality_level` STRING COMMENT 'Classification level of the audit report content.',
    `corrective_action_due_date` DATE COMMENT 'Due date for implementing corrective actions.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective actions are required based on findings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit report record was created in the system.',
    `department` STRING COMMENT 'Organizational department responsible for the audit.',
    `document_location` STRING COMMENT 'Path or URL to the stored audit report document.',
    `effective_date` DATE COMMENT 'Date from which the audit findings become effective for corrective actions.',
    `expiry_date` DATE COMMENT 'Date after which the audit report is considered archived or superseded.',
    `findings_summary` STRING COMMENT 'High-level summary of audit findings.',
    `regulatory_body` STRING COMMENT 'Regulatory authority relevant to the audit.',
    `report_number` STRING COMMENT 'External reference number assigned to the audit report.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the audit findings.',
    `scope_description` STRING COMMENT 'Narrative describing the scope of the audit.',
    `severity_average` DECIMAL(18,2) COMMENT 'Average severity score of non-conformities (scale 1-5).',
    `audit_report_status` STRING COMMENT 'Current lifecycle status of the audit report.',
    `title` STRING COMMENT 'Descriptive title of the audit report.',
    `total_nonconformities` STRING COMMENT 'Total number of non-conformities identified.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the audit report record.',
    CONSTRAINT pk_audit_report PRIMARY KEY(`audit_report_id`)
) COMMENT 'Master reference table for audit_report. Referenced by report_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`quality`.`audit_program` (
    `audit_program_id` BIGINT COMMENT 'Primary key for audit_program',
    `employee_id` BIGINT COMMENT 'Identifier of the person or organizational unit responsible for the audit program.',
    `parent_audit_program_id` BIGINT COMMENT 'Self-referencing FK on audit_program (parent_audit_program_id)',
    `audit_category` STRING COMMENT 'Primary regulatory or quality category the audit program belongs to.',
    `audit_criteria` STRING COMMENT 'Specific criteria or checklists used during the audit.',
    `audit_criteria_version` STRING COMMENT 'Version identifier for the audit criteria set.',
    `audit_method` STRING COMMENT 'Method used to conduct the audit (e.g., internal team, external auditor, third‑party service).',
    `audit_objectives` STRING COMMENT 'Key objectives and goals that the audit program aims to achieve.',
    `compliance_standards` STRING COMMENT 'List of regulatory or industry standards the audit program addresses. [ENUM-REF-CANDIDATE: GxP|ISO13485|FDA21CFRPart11|CLIA|CAP|HIPAA|GDPR — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit program record was first created in the system.',
    `audit_program_description` STRING COMMENT 'Detailed description of the audit programs purpose and scope.',
    `documentation_url` STRING COMMENT 'Link to the detailed documentation or SOP for the audit program.',
    `effective_end_date` DATE COMMENT 'Date when the audit program expires or is retired (nullable for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the audit program becomes effective.',
    `frequency` STRING COMMENT 'How often the audit program is scheduled to run.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the audit program is currently active (true) or inactive (false).',
    `last_executed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent execution of this audit program.',
    `next_scheduled_timestamp` TIMESTAMP COMMENT 'Planned timestamp for the next execution of the audit program.',
    `program_code` STRING COMMENT 'Business identifier or code used to reference the audit program across systems.',
    `program_duration_days` STRING COMMENT 'Typical duration in days for the audit program execution.',
    `program_name` STRING COMMENT 'Human‑readable name of the audit program.',
    `program_notes` STRING COMMENT 'Free‑form notes or comments about the audit program.',
    `program_owner_role` STRING COMMENT 'Role of the owner within the organization (e.g., Quality Manager, Compliance Lead).',
    `program_type` STRING COMMENT 'Classification of the program indicating whether it is internal, external, or a combination.',
    `risk_level` STRING COMMENT 'Risk classification assigned to the audit program based on impact and likelihood.',
    `scope` STRING COMMENT 'Scope of the audit program – internal, external, or both.',
    `audit_program_status` STRING COMMENT 'Current lifecycle status of the audit program.',
    `status_reason` STRING COMMENT 'Explanation for the current status, such as why a program is retired or pending.',
    `updated_by` STRING COMMENT 'User identifier of the person who last updated the audit program record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the audit program record.',
    `version_number` STRING COMMENT 'Version number of the audit program definition, incremented on each change.',
    `created_by` STRING COMMENT 'User identifier of the person who created the audit program record.',
    CONSTRAINT pk_audit_program PRIMARY KEY(`audit_program_id`)
) COMMENT 'Master reference table for audit_program. Referenced by program_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`quality`.`investigation` (
    `investigation_id` BIGINT COMMENT 'Primary key for investigation',
    `related_investigation_id` BIGINT COMMENT 'Self-referencing FK on investigation (related_investigation_id)',
    `closed_date` DATE COMMENT 'Calendar date when the investigation was closed or resolved.',
    `corrective_action_due_date` DATE COMMENT 'Target date for completion of corrective actions.',
    `corrective_action_plan` STRING COMMENT 'Planned corrective actions to address the root cause.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the investigation record was initially created in the system.',
    `investigation_description` STRING COMMENT 'Detailed narrative of the investigation scope, findings, and context.',
    `investigation_number` STRING COMMENT 'Business-visible identifier assigned to the investigation, used in reports and tracking.',
    `investigation_type` STRING COMMENT 'Category of the investigation indicating its origin or nature.',
    `investigator_email` STRING COMMENT 'Email address of the primary investigator.',
    `investigator_name` STRING COMMENT 'Full name of the primary investigator responsible for conducting the investigation.',
    `is_capitalized` BOOLEAN COMMENT 'Indicates whether the investigation result leads to a capitalized change in the quality system.',
    `notes` STRING COMMENT 'Additional free-text notes captured by investigators.',
    `opened_date` DATE COMMENT 'Calendar date when the investigation was formally opened.',
    `related_batch_number` STRING COMMENT 'Manufacturing batch number linked to the investigation.',
    `related_product_code` STRING COMMENT 'Identifier of the product associated with the investigation (e.g., SKU, catalogue number).',
    `root_cause` STRING COMMENT 'Narrative description of the identified root cause for the issue under investigation.',
    `severity_level` STRING COMMENT 'Impact severity assigned to the investigation based on risk assessment.',
    `investigation_status` STRING COMMENT 'Current lifecycle status of the investigation.',
    `title` STRING COMMENT 'Brief descriptive title summarizing the investigation purpose or issue.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the investigation record.',
    `verification_date` DATE COMMENT 'Date when verification of corrective actions was performed.',
    `verification_status` STRING COMMENT 'Status of verification that corrective actions were effective.',
    CONSTRAINT pk_investigation PRIMARY KEY(`investigation_id`)
) COMMENT 'Master reference table for investigation. Referenced by investigation_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`quality`.`internal_investigation` (
    `internal_investigation_id` BIGINT COMMENT 'Primary key for internal_investigation',
    `parent_internal_investigation_id` BIGINT COMMENT 'Self-referencing FK on internal_investigation (parent_internal_investigation_id)',
    `affected_batch_number` STRING COMMENT 'Batch or lot number of the affected product.',
    `affected_product_code` STRING COMMENT 'Identifier of the product(s) impacted by the issue.',
    `attachment_count` STRING COMMENT 'Number of supporting documents or files attached to the investigation record.',
    `closed_date` DATE COMMENT 'Date the investigation was officially closed.',
    `corrective_action_description` STRING COMMENT 'Description of the action(s) taken to address the root cause.',
    `corrective_action_due_date` DATE COMMENT 'Target date for completion of the corrective action.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the investigation record was first created in the system.',
    `end_date` DATE COMMENT 'Planned or actual completion date of the investigation.',
    `impact_assessment` STRING COMMENT 'Evaluation of the investigations impact on product quality, patient safety, and regulatory compliance.',
    `investigation_number` STRING COMMENT 'Human‑readable unique code assigned to the investigation (e.g., INV‑2024‑001).',
    `investigation_type` STRING COMMENT 'Category of the investigation indicating its origin or purpose.',
    `investigator_email` STRING COMMENT 'Contact email of the primary investigator.',
    `investigator_name` STRING COMMENT 'Full name of the primary investigator responsible for the case.',
    `is_confidential` BOOLEAN COMMENT 'Indicates if the investigation contains confidential information requiring restricted access.',
    `notes` STRING COMMENT 'Free‑form notes captured by investigators during the investigation.',
    `preventive_action_description` STRING COMMENT 'Description of measures implemented to prevent recurrence.',
    `preventive_action_due_date` DATE COMMENT 'Target date for completion of the preventive action.',
    `priority` STRING COMMENT 'Priority assigned to drive resolution speed.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the investigation triggers regulatory reporting obligations.',
    `regulatory_reported` BOOLEAN COMMENT 'True if the investigation has been reported to the appropriate regulatory authority.',
    `reported_date` DATE COMMENT 'Date the issue prompting the investigation was reported.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk rating (e.g., 0.00–10.00) derived from severity, likelihood, and impact.',
    `root_cause_category` STRING COMMENT 'High‑level classification of the underlying cause identified.',
    `root_cause_description` STRING COMMENT 'Detailed narrative describing the root cause of the issue.',
    `severity_level` STRING COMMENT 'Severity rating reflecting potential impact on product quality or compliance.',
    `start_date` DATE COMMENT 'Date when the investigation formally began.',
    `internal_investigation_status` STRING COMMENT 'Current lifecycle status of the investigation.',
    `title` STRING COMMENT 'Brief descriptive title of the investigation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the investigation record.',
    CONSTRAINT pk_internal_investigation PRIMARY KEY(`internal_investigation_id`)
) COMMENT 'Master reference table for internal_investigation. Referenced by internal_investigation_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`audit`(`audit_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_quality_training_curriculum_id` FOREIGN KEY (`quality_training_curriculum_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`quality_training_curriculum`(`quality_training_curriculum_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ADD CONSTRAINT `fk_quality_deviation_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ADD CONSTRAINT `fk_quality_deviation_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`audit`(`audit_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ADD CONSTRAINT `fk_quality_deviation_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ADD CONSTRAINT `fk_quality_deviation_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_audit_program_id` FOREIGN KEY (`audit_program_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`audit_program`(`audit_program_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`audit`(`audit_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_previous_finding_audit_finding_id` FOREIGN KEY (`previous_finding_audit_finding_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ADD CONSTRAINT `fk_quality_controlled_document_superseded_document_controlled_document_id` FOREIGN KEY (`superseded_document_controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ADD CONSTRAINT `fk_quality_training_record_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ADD CONSTRAINT `fk_quality_training_record_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ADD CONSTRAINT `fk_quality_training_record_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ADD CONSTRAINT `fk_quality_training_record_quality_training_curriculum_id` FOREIGN KEY (`quality_training_curriculum_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`quality_training_curriculum`(`quality_training_curriculum_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`audit`(`audit_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`complaint`(`complaint_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_stability_study_id` FOREIGN KEY (`stability_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`stability_study`(`stability_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`complaint`(`complaint_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`test_method`(`test_method_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`investigation`(`investigation_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_qualification_protocol_id` FOREIGN KEY (`qualification_protocol_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qualification_protocol`(`qualification_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_quality_training_curriculum_id` FOREIGN KEY (`quality_training_curriculum_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`quality_training_curriculum`(`quality_training_curriculum_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`risk_assessment` ADD CONSTRAINT `fk_quality_risk_assessment_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`risk_assessment` ADD CONSTRAINT `fk_quality_risk_assessment_previous_risk_assessment_id` FOREIGN KEY (`previous_risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qualification_protocol` ADD CONSTRAINT `fk_quality_qualification_protocol_superseded_qualification_protocol_id` FOREIGN KEY (`superseded_qualification_protocol_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qualification_protocol`(`qualification_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`test_method` ADD CONSTRAINT `fk_quality_test_method_superseded_test_method_id` FOREIGN KEY (`superseded_test_method_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`test_method`(`test_method_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_report` ADD CONSTRAINT `fk_quality_audit_report_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`audit`(`audit_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_report` ADD CONSTRAINT `fk_quality_audit_report_revised_audit_report_id` FOREIGN KEY (`revised_audit_report_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`audit_report`(`audit_report_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_program` ADD CONSTRAINT `fk_quality_audit_program_parent_audit_program_id` FOREIGN KEY (`parent_audit_program_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`audit_program`(`audit_program_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`investigation` ADD CONSTRAINT `fk_quality_investigation_related_investigation_id` FOREIGN KEY (`related_investigation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`investigation`(`investigation_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`internal_investigation` ADD CONSTRAINT `fk_quality_internal_investigation_parent_internal_investigation_id` FOREIGN KEY (`parent_internal_investigation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`internal_investigation`(`internal_investigation_id`);

-- ========= TAGS =========
ALTER SCHEMA `genomics_biotech_ecm`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `genomics_biotech_ecm`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` SET TAGS ('dbx_subdomain' = 'corrective_action');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `capa_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `capa_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `capa_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `capa_quality_approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Approver Employee ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `capa_quality_approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `capa_quality_approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Controlled Document Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'CAPA Owner Employee ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `quality_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Issue Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `quality_training_curriculum_id` SET TAGS ('dbx_business_glossary_term' = 'Training Curriculum Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `action_plan_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Approved Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `action_plan_due_date` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Due Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `affected_product_lines` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Lines');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `capa_description` SET TAGS ('dbx_business_glossary_term' = 'CAPA Description');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `capa_number` SET TAGS ('dbx_business_glossary_term' = 'CAPA Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `capa_status` SET TAGS ('dbx_business_glossary_term' = 'CAPA Status');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `capa_type` SET TAGS ('dbx_business_glossary_term' = 'CAPA Type');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `capa_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|combined');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'CAPA Closed Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `closure_comments` SET TAGS ('dbx_business_glossary_term' = 'CAPA Closure Comments');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `effectiveness_check_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Completed Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `effectiveness_check_criteria` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Criteria');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `effectiveness_check_due_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Due Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `effectiveness_check_result` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Result');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `effectiveness_check_result` SET TAGS ('dbx_value_regex' = 'effective|ineffective|pending');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `gxp_classification` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Classification');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `gxp_classification` SET TAGS ('dbx_value_regex' = 'gmp|glp|gcp|gdp|non_gxp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `implementation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Completed Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `implementation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Due Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'CAPA Initiated Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `initiation_source` SET TAGS ('dbx_business_glossary_term' = 'CAPA Initiation Source');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `investigation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completed Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `investigation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Due Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `mastercontrol_record_reference` SET TAGS ('dbx_business_glossary_term' = 'MasterControl Record ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `preventive_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Plan');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'CAPA Priority');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `product_impact` SET TAGS ('dbx_business_glossary_term' = 'Product Impact Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `product_impact` SET TAGS ('dbx_value_regex' = 'yes|no|under_investigation');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `regulatory_impact` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Classification');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `regulatory_impact` SET TAGS ('dbx_value_regex' = 'reportable|non_reportable');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `root_cause_analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Method');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `root_cause_analysis_method` SET TAGS ('dbx_value_regex' = 'five_why|fishbone|fault_tree_analysis|fmea|pareto|other');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `root_cause_summary` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Summary');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'CAPA Severity');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `sop_updates_required` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Updates Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `source_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Source Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'CAPA Title');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` SET TAGS ('dbx_subdomain' = 'corrective_action');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Deviation Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Asset Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Related Audit Finding Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Controlled Document Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Owner Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `deviation_qa_reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Reviewer Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `deviation_qa_reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `deviation_qa_reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `deviation_reported_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `deviation_reported_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `deviation_reported_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `quality_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Issue Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `affected_batch_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Affected Batch Lot Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `affected_product_sku` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Stock Keeping Unit (SKU)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `affected_sop_number` SET TAGS ('dbx_business_glossary_term' = 'Affected Standard Operating Procedure (SOP) Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `affected_sop_number` SET TAGS ('dbx_value_regex' = '^SOP-[A-Z]{2,4}-[0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `customer_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `deviation_description` SET TAGS ('dbx_business_glossary_term' = 'Deviation Description');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `deviation_number` SET TAGS ('dbx_business_glossary_term' = 'Deviation Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `deviation_number` SET TAGS ('dbx_value_regex' = '^DEV-[0-9]{8}$');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `deviation_status` SET TAGS ('dbx_business_glossary_term' = 'Deviation Status');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `deviation_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|pending_approval|closed|cancelled');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `deviation_type` SET TAGS ('dbx_business_glossary_term' = 'Deviation Type');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `deviation_type` SET TAGS ('dbx_value_regex' = 'process|equipment|material|environmental|documentation|personnel');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'accept|reject|rework|retest|use_as_is|scrap');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `facility_location_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Location Code');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `gxp_classification` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Classification');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `gxp_classification` SET TAGS ('dbx_value_regex' = 'GMP|GLP|GCP|non-GxP');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `immediate_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Immediate Action Taken');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `investigation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Due Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `mastercontrol_record_reference` SET TAGS ('dbx_business_glossary_term' = 'MasterControl Record Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `occurrence_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `product_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Product Impact Assessment');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `repeat_deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Deviation Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `root_cause_analysis_summary` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Summary');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `severity_grade` SET TAGS ('dbx_business_glossary_term' = 'Severity Grade');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `severity_grade` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `turnaround_time_days` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time (TAT) Days');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `channel_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Partner Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Controlled Document Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `primary_lead_auditor_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `audit_program_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Program Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `applicable_standards` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulatory Standards');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_value_regex' = '^AUD-[0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal_gmp|internal_iso_13485|clia_cap_readiness|supplier_qualification|regulatory_inspection_readiness|process_audit');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `auditee_department_head` SET TAGS ('dbx_business_glossary_term' = 'Auditee Department Head');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `department_scope` SET TAGS ('dbx_business_glossary_term' = 'Department Scope');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Audit Duration Hours');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `inspection_authority` SET TAGS ('dbx_business_glossary_term' = 'Inspection Authority');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Audit Outcome');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'conforming|nonconforming|needs_improvement|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `regulatory_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `report_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `team_members` SET TAGS ('dbx_business_glossary_term' = 'Audit Team Members');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `total_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `previous_finding_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Finding Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `quality_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Issue Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `affected_department` SET TAGS ('dbx_business_glossary_term' = 'Affected Department');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `affected_procedure_sop` SET TAGS ('dbx_business_glossary_term' = 'Affected Procedure Standard Operating Procedure (SOP)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `affected_process` SET TAGS ('dbx_business_glossary_term' = 'Affected Process');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `affected_site_location` SET TAGS ('dbx_business_glossary_term' = 'Affected Site Location');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `audit_finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `closure_comments` SET TAGS ('dbx_business_glossary_term' = 'Closure Comments');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `customer_complaint_related_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint Related Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `data_integrity_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Integrity Issue Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `fda_warning_letter_related_flag` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Warning Letter Related Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `finding_classification` SET TAGS ('dbx_business_glossary_term' = 'Finding Classification');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `finding_classification` SET TAGS ('dbx_value_regex' = 'critical|major|minor|observation');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'nonconformance|deficiency|observation|opportunity_for_improvement');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `gxp_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Impact Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Identified Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `objective_evidence` SET TAGS ('dbx_business_glossary_term' = 'Objective Evidence');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `repeat_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Finding Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `required_response_type` SET TAGS ('dbx_business_glossary_term' = 'Required Response Type');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `required_response_type` SET TAGS ('dbx_value_regex' = 'capa_required|correction_only|observation_acknowledgment|no_action_required');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `response_overdue_flag` SET TAGS ('dbx_business_glossary_term' = 'Response Overdue Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Response Submitted Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Email Address');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Name');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `root_cause_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'document_review|follow_up_audit|process_observation|data_analysis|management_review');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `verification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Verification Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ALTER COLUMN `verified_by_name` SET TAGS ('dbx_business_glossary_term' = 'Verified By Name');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` SET TAGS ('dbx_subdomain' = 'training_documentation');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Controlled Document ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Line ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `metadata_schema_id` SET TAGS ('dbx_business_glossary_term' = 'Metadata Schema Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `primary_controlled_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Document Owner ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `primary_controlled_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `primary_controlled_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `superseded_document_controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Document ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `variant_database_version_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Database Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `archived_date` SET TAGS ('dbx_business_glossary_term' = 'Archived Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `archived_flag` SET TAGS ('dbx_business_glossary_term' = 'Archived Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'Public|Internal|Confidential|Restricted');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Distribution List');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `document_category` SET TAGS ('dbx_business_glossary_term' = 'Document Category');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document Format');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[A-Z]{2,4}-[0-9]{4,6}$');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `electronic_signature_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Applied Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `gxp_classification` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Classification');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `gxp_classification` SET TAGS ('dbx_value_regex' = 'GMP|GLP|GCP|GDP|Non-GxP');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Months');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `revision_summary` SET TAGS ('dbx_business_glossary_term' = 'Revision Summary');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Veeva Vault|MasterControl|SharePoint|Manual');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `source_system_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Document ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}(.[0-9]{1,2})?$');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` SET TAGS ('dbx_subdomain' = 'training_documentation');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `training_record_id` SET TAGS ('dbx_business_glossary_term' = 'Training Record Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Controlled Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Deviation Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `metadata_schema_id` SET TAGS ('dbx_business_glossary_term' = 'Metadata Schema Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `quality_training_curriculum_id` SET TAGS ('dbx_business_glossary_term' = 'Training Curriculum Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `tertiary_training_assessor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `tertiary_training_assessor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `tertiary_training_assessor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `workforce_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Training Assignment Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `assessment_attempts` SET TAGS ('dbx_business_glossary_term' = 'Assessment Attempt Count');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `assessment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Assessment Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score Percentage');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Full Name');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `certificate_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Training Certificate Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Control Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `document_revision` SET TAGS ('dbx_business_glossary_term' = 'Document Revision Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Training Due Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `external_training_provider` SET TAGS ('dbx_business_glossary_term' = 'External Training Provider Name');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold Percentage');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `qualification_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `qualification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Personnel Qualification Status');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|not_qualified|pending|expired|revoked');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `regulatory_requirement_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `retraining_due_date` SET TAGS ('dbx_business_glossary_term' = 'Retraining Due Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Training Scheduled Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `trainee_employee_number` SET TAGS ('dbx_business_glossary_term' = 'Trainee Employee Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `trainee_employee_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `trainee_employee_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `trainer_name` SET TAGS ('dbx_business_glossary_term' = 'Trainer Full Name');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `training_category` SET TAGS ('dbx_business_glossary_term' = 'Training Category');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `training_cost` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Amount');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `training_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `training_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `training_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `training_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration in Hours');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `training_method` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Method');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `training_method` SET TAGS ('dbx_value_regex' = 'read_and_understand|classroom|on_the_job|e_learning|webinar|simulation');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `training_notes` SET TAGS ('dbx_business_glossary_term' = 'Training Notes');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` SET TAGS ('dbx_subdomain' = 'training_documentation');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `quality_training_curriculum_id` SET TAGS ('dbx_business_glossary_term' = 'Training Curriculum Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `channel_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Partner Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `applicable_departments` SET TAGS ('dbx_business_glossary_term' = 'Applicable Departments');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `applicable_job_roles` SET TAGS ('dbx_business_glossary_term' = 'Applicable Job Roles');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `assessment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Assessment Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'written_exam|practical_demonstration|competency_observation|quiz|simulation|peer_review');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `cap_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'College of American Pathologists (CAP) Applicable Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `clia_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Applicable Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `curriculum_code` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Code');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `curriculum_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `curriculum_description` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Description');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `curriculum_name` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Name');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `curriculum_owner` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Owner');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `curriculum_type` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Type');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `curriculum_type` SET TAGS ('dbx_value_regex' = 'role_based|department_based|regulatory_qualification|product_specific|process_specific|safety_compliance');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `curriculum_version` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Version');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `curriculum_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration (Hours)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `gxp_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Applicable Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `iso_13485_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 13485 Applicable Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `linked_document_revision_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Linked Document Revision Trigger Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `mastercontrol_training_reference` SET TAGS ('dbx_business_glossary_term' = 'MasterControl Training Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Notes');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `prerequisite_curriculum_list` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Curriculum List');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `qualification_level` SET TAGS ('dbx_business_glossary_term' = 'Qualification Level');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `qualification_level` SET TAGS ('dbx_value_regex' = 'entry_level|intermediate|advanced|expert|supervisor|manager');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `quality_training_curriculum_status` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Status');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `quality_training_curriculum_status` SET TAGS ('dbx_value_regex' = 'draft|active|under_review|superseded|retired|suspended');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `required_document_list` SET TAGS ('dbx_business_glossary_term' = 'Required Controlled Document List');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `retraining_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Retraining Interval (Months)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Months)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `training_frequency` SET TAGS ('dbx_business_glossary_term' = 'Training Frequency');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `training_frequency` SET TAGS ('dbx_value_regex' = 'initial_only|annual|biannual|quarterly|event_driven|continuous');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` SET TAGS ('dbx_subdomain' = 'corrective_action');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Asset Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Controlled Document Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Deviation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `inbound_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Delivery Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `qc_result_id` SET TAGS ('dbx_business_glossary_term' = 'Qc Result Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `quality_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Issue Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `closed_by` SET TAGS ('dbx_business_glossary_term' = 'Closed By');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `containment_action` SET TAGS ('dbx_business_glossary_term' = 'Containment Action');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `detected_by` SET TAGS ('dbx_business_glossary_term' = 'Detected By');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `detected_date` SET TAGS ('dbx_business_glossary_term' = 'Detection Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `detection_source` SET TAGS ('dbx_business_glossary_term' = 'Detection Source');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `detection_source` SET TAGS ('dbx_value_regex' = 'incoming_inspection|in_process_qc|final_release|customer_complaint|supplier_notification|internal_audit');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `disposition_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Disposition Approved By');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'use_as_is|rework|reject|scrap|return_to_supplier|quarantine');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `disposition_justification` SET TAGS ('dbx_business_glossary_term' = 'Disposition Justification');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `ncr_number` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report (NCR) Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `ncr_number` SET TAGS ('dbx_value_regex' = '^NCR-[0-9]{8}$');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `ncr_type` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report (NCR) Type');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `ncr_type` SET TAGS ('dbx_value_regex' = 'material|product|component|reagent|instrument|raw_material');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `nonconformance_status` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Status');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `nonconformance_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|pending_disposition|closed|cancelled');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `quality_notification_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Notification (QM) Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `quantity_affected` SET TAGS ('dbx_business_glossary_term' = 'Quantity Affected');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `regulatory_report_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `root_cause_summary` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Summary');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Specification Limit');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `specification_parameter` SET TAGS ('dbx_business_glossary_term' = 'Specification Parameter');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Specification Reference');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `supplier_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Notification Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` SET TAGS ('dbx_subdomain' = 'quality_testing');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `qc_result_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Result ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `gene_annotation_track_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Annotation Track Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Tested By User ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `sample_specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `stability_study_id` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `validation_study_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Study Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `variant_database_version_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Database Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'calibrated|expired|pending|not_required');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `coa_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Included Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `deviation_number` SET TAGS ('dbx_business_glossary_term' = 'Deviation Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `laboratory_location` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Location');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `lot_disposition` SET TAGS ('dbx_business_glossary_term' = 'Lot Disposition');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `lot_disposition` SET TAGS ('dbx_value_regex' = 'released|rejected|quarantine|conditional_release|pending_investigation');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `lower_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `out_of_specification_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Specification (OOS) Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `replicate_number` SET TAGS ('dbx_business_glossary_term' = 'Replicate Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|pending|retest|out_of_specification');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `retest_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Retest Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `sop_number` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `sop_version` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Version');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `specification_version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `test_category` SET TAGS ('dbx_business_glossary_term' = 'Test Category');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `test_category` SET TAGS ('dbx_value_regex' = 'chemical|physical|microbiological|molecular|functional|performance');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `test_characteristic` SET TAGS ('dbx_business_glossary_term' = 'Test Characteristic');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `test_method_code` SET TAGS ('dbx_business_glossary_term' = 'Test Method Code');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `test_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'raw_material|in_process|finished_product|stability|reference_standard|environmental');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ALTER COLUMN `upper_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` SET TAGS ('dbx_subdomain' = 'quality_testing');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `oos_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Specification (OOS) Investigation ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Deviation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By User ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `qc_result_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Result ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `quality_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Assessment Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `sample_specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `tertiary_oos_qa_reviewer_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Reviewer User ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `tertiary_oos_qa_reviewer_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `tertiary_oos_qa_reviewer_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `test_method_id` SET TAGS ('dbx_business_glossary_term' = 'Test Method ID');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `capa_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Closure Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `deviation_magnitude` SET TAGS ('dbx_business_glossary_term' = 'Deviation Magnitude');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'accept|reject|rework|reprocess|quarantine|pending');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Initiated Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `invalidation_justification` SET TAGS ('dbx_business_glossary_term' = 'Invalidation Justification');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `investigation_number` SET TAGS ('dbx_business_glossary_term' = 'Investigation Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `investigation_number` SET TAGS ('dbx_value_regex' = '^OOS-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `investigation_type` SET TAGS ('dbx_business_glossary_term' = 'Investigation Type');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `investigation_type` SET TAGS ('dbx_value_regex' = 'oos_result|oot_result|atypical_result|failed_specification');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `observed_value` SET TAGS ('dbx_business_glossary_term' = 'Observed Value');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `phase` SET TAGS ('dbx_business_glossary_term' = 'Investigation Phase');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `phase` SET TAGS ('dbx_value_regex' = 'phase_i|phase_ii');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `phase_i_assignable_cause_found` SET TAGS ('dbx_business_glossary_term' = 'Phase I Assignable Cause Found');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `phase_i_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Phase I Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `phase_i_findings` SET TAGS ('dbx_business_glossary_term' = 'Phase I Findings');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `phase_ii_assignable_cause_found` SET TAGS ('dbx_business_glossary_term' = 'Phase II Assignable Cause Found');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `phase_ii_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Phase II Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `phase_ii_findings` SET TAGS ('dbx_business_glossary_term' = 'Phase II Findings');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `product_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `qa_review_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Review Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `regulatory_reportable` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `result_invalidated` SET TAGS ('dbx_business_glossary_term' = 'Result Invalidated');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `retest_authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Authorization Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `retest_authorized` SET TAGS ('dbx_business_glossary_term' = 'Retest Authorized');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `retest_results_summary` SET TAGS ('dbx_business_glossary_term' = 'Retest Results Summary');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `specification_limit_lower` SET TAGS ('dbx_business_glossary_term' = 'Specification Limit Lower');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `specification_limit_upper` SET TAGS ('dbx_business_glossary_term' = 'Specification Limit Upper');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` SET TAGS ('dbx_subdomain' = 'corrective_action');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Asset Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Deviation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `quality_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Issue Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `support_case_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Case Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `variant_database_version_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Database Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Complaint Closed Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_category` SET TAGS ('dbx_business_glossary_term' = 'Complaint Category');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Complaint Description');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_number` SET TAGS ('dbx_business_glossary_term' = 'Complaint Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_number` SET TAGS ('dbx_value_regex' = '^CMP-[0-9]{8}$');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_source` SET TAGS ('dbx_business_glossary_term' = 'Complaint Source');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_status` SET TAGS ('dbx_business_glossary_term' = 'Complaint Status');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action (CAPA) Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `customer_response_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `customer_response_sent` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Sent Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `customer_response_summary` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Summary');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `diagnostic_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Diagnostic Impact Assessment');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `investigation_required` SET TAGS ('dbx_business_glossary_term' = 'Investigation Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `mdr_reportable` SET TAGS ('dbx_business_glossary_term' = 'Medical Device Reporting (MDR) Reportable Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `patient_safety_impact` SET TAGS ('dbx_business_glossary_term' = 'Patient Safety Impact Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Complaint Priority');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'urgent|high|medium|low');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Complaint Received Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Complaint Received Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `regulatory_report_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `reported_by_email` SET TAGS ('dbx_business_glossary_term' = 'Reported By Email Address');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `reported_by_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `reported_by_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `reported_by_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `reported_by_name` SET TAGS ('dbx_business_glossary_term' = 'Reported By Name');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `reported_by_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `reported_by_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `reported_by_phone` SET TAGS ('dbx_business_glossary_term' = 'Reported By Phone Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `reported_by_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `reported_by_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `root_cause_summary` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Summary');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Complaint Severity');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|major|moderate|minor');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `turnaround_time_days` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time (TAT) in Days');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ALTER COLUMN `vigilance_reportable` SET TAGS ('dbx_business_glossary_term' = 'Vigilance Reportable Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` SET TAGS ('dbx_subdomain' = 'quality_testing');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `validation_study_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Study Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `gene_annotation_track_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Annotation Track Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Protocol Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `primary_validation_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Study Sponsor Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `primary_validation_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `primary_validation_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `qualification_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Protocol Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `quaternary_validation_regulatory_approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approver Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `quaternary_validation_regulatory_approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `quaternary_validation_regulatory_approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `quinary_validation_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `quinary_validation_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `quinary_validation_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `tertiary_validation_qa_reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Reviewer Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `tertiary_validation_qa_reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `tertiary_validation_qa_reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `variant_database_version_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Database Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `assay_name` SET TAGS ('dbx_business_glossary_term' = 'Assay Name');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `assay_version` SET TAGS ('dbx_business_glossary_term' = 'Assay Version');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `capa_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Study Comments');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `conclusion_summary` SET TAGS ('dbx_business_glossary_term' = 'Conclusion Summary');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `intended_use` SET TAGS ('dbx_business_glossary_term' = 'Intended Use Classification');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `intended_use` SET TAGS ('dbx_value_regex' = 'RUO|IVD|LDT|clinical_trial|manufacturing|internal_use');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `process_name` SET TAGS ('dbx_business_glossary_term' = 'Process Name');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `qa_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `regulatory_standard` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulatory Standard');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `regulatory_submission_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Type');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `report_version` SET TAGS ('dbx_business_glossary_term' = 'Report Version');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `revalidation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Revalidation Due Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `software_system_name` SET TAGS ('dbx_business_glossary_term' = 'Software System Name');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `statistical_method` SET TAGS ('dbx_business_glossary_term' = 'Statistical Analysis Method');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `study_end_date` SET TAGS ('dbx_business_glossary_term' = 'Study End Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `study_number` SET TAGS ('dbx_business_glossary_term' = 'Validation Study Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `study_number` SET TAGS ('dbx_value_regex' = '^VS-[0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `study_objective` SET TAGS ('dbx_business_glossary_term' = 'Study Objective');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `study_phase` SET TAGS ('dbx_business_glossary_term' = 'Validation Study Phase');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `study_phase` SET TAGS ('dbx_value_regex' = 'phase_1|phase_2|phase_3|revalidation|ongoing_verification');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `study_start_date` SET TAGS ('dbx_business_glossary_term' = 'Study Start Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Study Status');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `study_title` SET TAGS ('dbx_business_glossary_term' = 'Validation Study Title');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `validation_conclusion` SET TAGS ('dbx_business_glossary_term' = 'Validation Conclusion');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `validation_conclusion` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional_pass|inconclusive');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `validation_subtype` SET TAGS ('dbx_business_glossary_term' = 'Validation Subtype');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `validation_type` SET TAGS ('dbx_business_glossary_term' = 'Validation Type');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ALTER COLUMN `validation_type` SET TAGS ('dbx_value_regex' = 'method_validation|assay_validation|software_validation|equipment_qualification|process_validation|cleaning_validation');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` SET TAGS ('dbx_subdomain' = 'quality_testing');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `stability_study_id` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `assigned_shelf_life_months` SET TAGS ('dbx_business_glossary_term' = 'Assigned Shelf Life in Months');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `batch_scale` SET TAGS ('dbx_business_glossary_term' = 'Batch Scale');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `batch_scale` SET TAGS ('dbx_value_regex' = 'pilot|production|validation');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `coa_reference_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Reference Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `container_closure_system` SET TAGS ('dbx_business_glossary_term' = 'Container Closure System');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `expiry_date_format` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date Format');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `expiry_date_format` SET TAGS ('dbx_value_regex' = 'yyyy-MM-dd|yyyy-MM|yyyy-MM-dd HH:mm');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `ich_climatic_zone` SET TAGS ('dbx_business_glossary_term' = 'International Council for Harmonisation (ICH) Climatic Zone');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `ich_climatic_zone` SET TAGS ('dbx_value_regex' = 'I|II|III|IV|IVa|IVb');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `lims_study_reference` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Study Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `principal_investigator` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `regulatory_purpose` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Purpose');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `regulatory_purpose` SET TAGS ('dbx_value_regex' = 'initial-registration|post-approval-commitment|annual-stability|change-control|shelf-life-extension|market-surveillance');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `sap_qm_inspection_lot` SET TAGS ('dbx_business_glossary_term' = 'SAP Quality Management (QM) Inspection Lot');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `stability_indicating_assays` SET TAGS ('dbx_business_glossary_term' = 'Stability Indicating Assays');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `storage_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Storage Relative Humidity Percentage');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `storage_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature in Celsius');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `study_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Study Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `study_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Study Duration in Months');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `study_notes` SET TAGS ('dbx_business_glossary_term' = 'Study Notes');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `study_protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Study Protocol Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `study_protocol_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `study_sponsor` SET TAGS ('dbx_business_glossary_term' = 'Study Sponsor');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `study_start_date` SET TAGS ('dbx_business_glossary_term' = 'Study Start Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'Study Status');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `study_status` SET TAGS ('dbx_value_regex' = 'planned|active|on-hold|completed|cancelled|under-review');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Type');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'real-time|accelerated|intermediate|stress|in-use|photostability');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `time_point_schedule` SET TAGS ('dbx_business_glossary_term' = 'Time Point Schedule');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `veeva_vault_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` SET TAGS ('dbx_subdomain' = 'corrective_action');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Controlled Document Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `gene_annotation_track_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Annotation Track Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Change Owner Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `primary_change_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Change Initiator Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `primary_change_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `primary_change_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `quality_training_curriculum_id` SET TAGS ('dbx_business_glossary_term' = 'Training Curriculum Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `quaternary_change_initiator_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `tertiary_change_regulatory_approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Affairs Approver Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `tertiary_change_regulatory_approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `tertiary_change_regulatory_approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `variant_database_version_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Database Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `actual_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Implementation Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `affected_equipment_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Equipment List');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `affected_facility_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Facility List');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `affected_product_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Product List');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `approval_routing_path` SET TAGS ('dbx_business_glossary_term' = 'Approval Routing Path');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `change_category` SET TAGS ('dbx_business_glossary_term' = 'Change Category');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `change_control_description` SET TAGS ('dbx_business_glossary_term' = 'Change Control Description');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `change_control_number` SET TAGS ('dbx_value_regex' = '^CC-[0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `change_status` SET TAGS ('dbx_business_glossary_term' = 'Change Control Status');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type Classification');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'major|minor|critical|administrative');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `closure_comments` SET TAGS ('dbx_business_glossary_term' = 'Closure Comments');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Change Control Closure Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `document_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Document Impact Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `effectiveness_check_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `effectiveness_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `effectiveness_check_result` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Result');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `effectiveness_check_result` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `impact_assessment_summary` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment Summary');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `implementation_plan` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `initiator_department` SET TAGS ('dbx_business_glossary_term' = 'Initiator Department');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Change Justification');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `planned_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Implementation Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Change Priority');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `qa_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Affairs Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `regulatory_submission_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Type');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `regulatory_submission_type` SET TAGS ('dbx_value_regex' = 'PAS|CBE-30|CBE-0|annual_report|none');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Change Risk Level');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Change Control Title');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `training_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Impact Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ALTER COLUMN `validation_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Validation Impact Flag');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`risk_assessment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`risk_assessment` SET TAGS ('dbx_subdomain' = 'corrective_action');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`risk_assessment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Identifier');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`risk_assessment` ALTER COLUMN `previous_risk_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qualification_protocol` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qualification_protocol` SET TAGS ('dbx_subdomain' = 'quality_testing');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qualification_protocol` ALTER COLUMN `qualification_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Protocol Identifier');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qualification_protocol` ALTER COLUMN `superseded_qualification_protocol_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qualification_protocol` ALTER COLUMN `author` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qualification_protocol` ALTER COLUMN `author` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qualification_protocol` ALTER COLUMN `reviewer` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qualification_protocol` ALTER COLUMN `reviewer` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`test_method` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`test_method` SET TAGS ('dbx_subdomain' = 'quality_testing');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`test_method` ALTER COLUMN `test_method_id` SET TAGS ('dbx_business_glossary_term' = 'Test Method Identifier');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`test_method` ALTER COLUMN `superseded_test_method_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_report` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_report` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_report` ALTER COLUMN `audit_report_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Identifier');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_report` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_report` ALTER COLUMN `revised_audit_report_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_program` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_program` ALTER COLUMN `audit_program_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Program Identifier');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_program` ALTER COLUMN `parent_audit_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`investigation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`investigation` SET TAGS ('dbx_subdomain' = 'corrective_action');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`investigation` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Identifier');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`investigation` ALTER COLUMN `related_investigation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`investigation` ALTER COLUMN `investigator_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`investigation` ALTER COLUMN `investigator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`investigation` ALTER COLUMN `investigator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`investigation` ALTER COLUMN `investigator_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`internal_investigation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`internal_investigation` SET TAGS ('dbx_subdomain' = 'corrective_action');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`internal_investigation` ALTER COLUMN `internal_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Investigation Identifier');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`internal_investigation` ALTER COLUMN `parent_internal_investigation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`internal_investigation` ALTER COLUMN `investigator_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`internal_investigation` ALTER COLUMN `investigator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`internal_investigation` ALTER COLUMN `investigator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`quality`.`internal_investigation` ALTER COLUMN `investigator_name` SET TAGS ('dbx_pii_name' = 'true');
