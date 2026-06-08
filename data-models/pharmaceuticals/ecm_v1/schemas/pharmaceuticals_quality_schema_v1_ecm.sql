-- Schema for Domain: quality | Business: Pharmaceuticals | Version: v1_ecm
-- Generated on: 2026-05-05 17:50:37

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `pharmaceuticals_ecm`.`quality` COMMENT 'Controls quality management system (QMS) including quality control testing, quality assurance oversight, CAPA (corrective and preventive action), deviation management, OOS (out of specification) investigations, OOT (out of trend) analysis, change controls, SOPs, and audit findings. Manages LIMS data, stability studies, method validation, and certificate of analysis (CoA) issuance. Integrates with MasterControl/TrackWise and SAP QM. Implements QbD and PAT principles across GMP, GLP, and GCP quality oversight.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` (
    `quality_capa_id` BIGINT COMMENT 'Unique identifier for the CAPA record. Primary key for the quality_capa data product.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: CAPAs originating from batch-specific manufacturing deviations, OOS results, or process failures require direct batch linkage for root cause analysis, impact assessment, and effectiveness verification',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: CAPAs may result in equipment purchases or facility modifications that become capitalized assets. Tracking CAPA-driven asset acquisitions is essential for capital expenditure justification, asset life',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: CAPAs require dedicated budget tracking for investigation costs, remediation activities, and improvement projects. Internal orders track actual spend against CAPA initiatives, essential for cost manag',
    `master_id` BIGINT COMMENT 'Foreign key linking to hcp.hcp_master. Business justification: CAPAs originate from physician-reported complaints and adverse events. Tracks which HCP initiated the quality investigation for regulatory traceability and trend analysis by reporter.',
    `medicinal_product_id` BIGINT COMMENT 'Identifier of the drug product or drug substance affected by the CAPA, if applicable.',
    `quality_event_id` BIGINT COMMENT 'Reference identifier of the originating QMS event (deviation number, OOS investigation number, audit finding ID, complaint number, etc.) that triggered this CAPA.',
    `inquiry_id` BIGINT COMMENT 'Foreign key linking to medical.medical_inquiry. Business justification: Medical inquiries reporting product quality concerns trigger CAPA investigations. Standard pharma process where medical affairs escalates safety/quality issues to QA for formal investigation and corre',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: CAPAs implementing process changes to patented methods require IP counsel review to ensure corrective actions dont invalidate patent claims or create freedom-to-operate issues. Mandatory for pharmace',
    `primary_quality_employee_id` BIGINT COMMENT 'Identifier of the individual assigned as the owner responsible for managing and completing the CAPA.',
    `quality_change_control_id` BIGINT COMMENT 'Foreign key linking to quality.quality_change_control. Business justification: CAPA records often trigger change controls as part of the corrective/preventive action implementation. One CAPA can trigger one change control (1:N relationship). This FK enables tracking which change',
    `quality_deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: CAPAs are frequently triggered by deviations. This FK provides a typed reference when originating_event_type=DEVIATION. Business case: deviations require corrective and preventive actions; CAPA effe',
    `site_id` BIGINT COMMENT 'Identifier of the manufacturing site, laboratory, or facility where the CAPA originated.',
    `tertiary_quality_closed_by_employee_id` BIGINT COMMENT 'Identifier of the individual who approved and closed the CAPA record.',
    `actual_completion_date` DATE COMMENT 'Actual date when all CAPA actions were completed.',
    `capa_number` STRING COMMENT 'Business identifier for the CAPA record, typically system-generated or following organizational numbering convention. Used for external reference and tracking.. Valid values are `^CAPA-[0-9]{6,10}$`',
    `capa_status` STRING COMMENT 'Current lifecycle status of the CAPA record indicating its progression through the CAPA workflow from initiation through closure. [ENUM-REF-CANDIDATE: initiated|investigation|action_plan|implementation|verification|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `capa_type` STRING COMMENT 'Classification of the CAPA as corrective (addressing existing nonconformance), preventive (preventing potential nonconformance), or combined (both corrective and preventive actions).. Valid values are `corrective|preventive|combined`',
    `closed_by_name` STRING COMMENT 'Full name of the individual who approved and closed the CAPA record.',
    `closure_comments` STRING COMMENT 'Final comments and summary provided at CAPA closure, documenting the rationale for closure and any lessons learned.',
    `closure_date` DATE COMMENT 'Date when the CAPA was formally closed after successful completion and effectiveness verification.',
    `contributing_factors` STRING COMMENT 'Additional contributing factors identified during root cause analysis that may have influenced the occurrence of the issue.',
    `corrective_action_plan` STRING COMMENT 'Detailed plan describing the corrective actions to be taken to address the identified root cause and prevent recurrence.',
    `department` STRING COMMENT 'Department or functional area where the CAPA originated (e.g., Manufacturing, Quality Control, Quality Assurance, Warehouse, R&D).',
    `effectiveness_check_comments` STRING COMMENT 'Detailed comments and findings from the effectiveness check evaluation.',
    `effectiveness_check_criteria` STRING COMMENT 'Defined criteria and metrics to be used to evaluate the effectiveness of the CAPA actions.',
    `effectiveness_check_date` DATE COMMENT 'Date when the effectiveness check was performed to verify CAPA effectiveness.',
    `effectiveness_check_required_flag` BOOLEAN COMMENT 'Indicates whether an effectiveness check is required to verify that the CAPA actions successfully addressed the root cause and prevented recurrence.',
    `effectiveness_check_result` STRING COMMENT 'Result of the effectiveness check indicating whether the CAPA actions were effective in addressing the root cause and preventing recurrence.. Valid values are `effective|ineffective|partially_effective|pending`',
    `immediate_action_taken` STRING COMMENT 'Description of any immediate containment or interim actions taken to address the issue while the full CAPA investigation and implementation are in progress.',
    `initiated_by_name` STRING COMMENT 'Full name of the individual who initiated the CAPA record.',
    `initiated_date` DATE COMMENT 'Date when the CAPA was formally initiated in the quality management system.',
    `originating_event_type` STRING COMMENT 'Type of quality management system event that triggered the CAPA, such as deviation, Out of Specification (OOS), Out of Trend (OOT), audit finding, customer complaint, or change control. [ENUM-REF-CANDIDATE: deviation|oos|oot|audit_finding|complaint|change_control|other — 7 candidates stripped; promote to reference product]',
    `preventive_action_plan` STRING COMMENT 'Detailed plan describing the preventive actions to be taken to eliminate potential causes of nonconformance and prevent occurrence.',
    `quality_capa_description` STRING COMMENT 'Detailed description of the nonconformance, problem, or potential risk that the CAPA addresses, including background context and scope.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory authority to which the CAPA commitment was made, if applicable (e.g., FDA, EMA, MHRA, PMDA).',
    `regulatory_commitment_flag` BOOLEAN COMMENT 'Indicates whether this CAPA is a commitment made to a regulatory authority (FDA, EMA, MHRA, etc.) as part of an inspection response, warning letter response, or regulatory submission.',
    `regulatory_reference_number` STRING COMMENT 'Reference number of the regulatory correspondence, inspection report, or warning letter associated with this CAPA commitment.',
    `risk_level` STRING COMMENT 'Risk level assessment of the issue addressed by the CAPA, considering likelihood and impact.. Valid values are `high|medium|low`',
    `root_cause` STRING COMMENT 'Identified root cause(s) of the nonconformance or issue, documented as the outcome of the root cause analysis investigation.',
    `root_cause_analysis_method` STRING COMMENT 'Methodology used to perform root cause analysis, such as 5-Why, Fishbone (Ishikawa), Failure Mode and Effects Analysis (FMEA), Fault Tree Analysis, or Pareto analysis.. Valid values are `5_why|fishbone|fmea|fault_tree|pareto|other`',
    `severity` STRING COMMENT 'Severity classification of the CAPA based on impact to product quality, patient safety, regulatory compliance, or business operations.. Valid values are `critical|major|minor`',
    `target_completion_date` DATE COMMENT 'Target date by which the CAPA actions are planned to be completed.',
    `title` STRING COMMENT 'Brief descriptive title summarizing the CAPA issue and scope.',
    CONSTRAINT pk_quality_capa PRIMARY KEY(`quality_capa_id`)
) COMMENT 'Corrective and Preventive Action records managing the full CAPA lifecycle from initiation through effectiveness verification. Captures root cause analysis methodology (5-Why, Fishbone, FMEA), assigned owner, due dates, action plan details, regulatory commitment flag, effectiveness check criteria, closure status, and linkage to originating QMS events. Integrates with MasterControl/TrackWise CAPA module and SAP QM.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` (
    `quality_deviation_id` BIGINT COMMENT 'Unique identifier for the quality deviation record. Primary key for the quality deviation entity.',
    `equipment_id` BIGINT COMMENT 'Unique identifier of the equipment or instrument involved in the deviation, if applicable. Links to equipment master data for maintenance and qualification history.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: GMP deviations frequently trigger formal compliance incidents requiring regulatory reporting and escalation. Pharmaceutical operations track which deviations escalated to compliance incidents for root',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Significant deviations trigger investigation projects requiring budget allocation and cost tracking. Internal orders capture investigation costs, testing expenses, and remediation activities, critical',
    `inventory_lot_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_lot. Business justification: Deviations affect specific inventory lots requiring quarantine/disposition decisions. Quality investigations must trace to physical inventory for batch release or rejection. Critical for GMP complianc',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Deviation investigations require assigned ownership for accountability and regulatory traceability. Investigation_owner is currently a plain name field; proper FK enables workload tracking, qualificat',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Deviations affecting patented processes or formulations require IP impact assessment for patent prosecution support, freedom-to-operate analysis, and potential claim amendment decisions. Critical for ',
    `payer_account_id` BIGINT COMMENT 'Foreign key linking to market.payer_account. Business justification: Deviations affecting marketed batches trigger mandatory payer notifications per supply agreements and pharmacovigilance requirements. Pharmaceutical companies must track which payer channels received ',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Links deviations to specific material receipts for batch genealogy, regulatory investigations, and material traceability. Required for FDA 21 CFR Part 11 compliance and deviation investigations.',
    `sop_id` BIGINT COMMENT 'Foreign key linking to quality.sop. Business justification: Deviations reference the SOP that was violated. Currently stored as sop_reference (STRING). Normalizing to FK allows proper referential integrity and enables joining to get full SOP details (title, ve',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Deviations attributed to vendor-supplied materials/services for root cause analysis, supplier performance tracking, and GMP compliance investigations. Critical for vendor quality management and regula',
    `audit_finding_flag` BOOLEAN COMMENT 'Indicates whether the deviation was identified during an internal audit, external audit, or regulatory inspection.',
    `closure_date` DATE COMMENT 'Date when the deviation record was formally closed after completion of investigation, corrective actions, and quality assurance approval.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the deviation record was first created in the quality management system.',
    `customer_complaint_flag` BOOLEAN COMMENT 'Indicates whether the deviation was identified as a result of a customer complaint, linking quality issues to market feedback.',
    `detected_by` STRING COMMENT 'Name or identifier of the individual who discovered the deviation. Used for quality culture assessment and training needs analysis.',
    `detected_date` DATE COMMENT 'Calendar date when the deviation was first identified or discovered. Critical for timeline reconstruction and regulatory reporting.',
    `deviation_category` STRING COMMENT 'Classification of the deviation as either planned (pre-approved departure from standard procedure) or unplanned (unexpected departure discovered during or after execution).. Valid values are `planned|unplanned`',
    `deviation_number` STRING COMMENT 'Business identifier for the deviation, typically system-generated or manually assigned following organizational numbering convention. Used for external reference and regulatory reporting.. Valid values are `^DEV-[0-9]{6,10}$`',
    `deviation_status` STRING COMMENT 'Current lifecycle state of the deviation record in the quality management workflow, from initial detection through investigation, corrective action, and closure.. Valid values are `open|under_investigation|pending_approval|closed|cancelled`',
    `deviation_type` STRING COMMENT 'Functional area or operational domain where the deviation occurred, enabling categorization by business process. [ENUM-REF-CANDIDATE: manufacturing|laboratory|packaging|warehouse|clinical|validation|documentation — 7 candidates stripped; promote to reference product]',
    `disposition_recommendation` STRING COMMENT 'Recommended disposition of the affected batch or material based on investigation findings and quality risk assessment. Subject to quality assurance approval.. Valid values are `release|rework|reprocess|reject|use_as_is|return_to_vendor`',
    `facility_code` STRING COMMENT 'Code identifying the manufacturing site, laboratory, or warehouse where the deviation occurred. Used for site-level quality trending and regulatory reporting.. Valid values are `^[A-Z]{3}[0-9]{2,4}$`',
    `final_disposition` STRING COMMENT 'Approved final disposition of the affected batch or material after quality assurance review and approval.. Valid values are `released|reworked|reprocessed|rejected|used_as_is|returned`',
    `gmp_impact_classification` STRING COMMENT 'Risk-based classification of the deviations impact on product quality, patient safety, and GMP compliance. Critical deviations pose direct risk to patient safety or product efficacy; major deviations may affect product quality; minor deviations have negligible impact.. Valid values are `critical|major|minor`',
    `immediate_action_taken` STRING COMMENT 'Description of containment actions taken immediately upon discovery to prevent further impact, such as quarantine of affected material, equipment shutdown, or process hold.',
    `investigation_completed_date` DATE COMMENT 'Actual date when the deviation investigation was completed and documented, including root cause analysis and corrective action plan.',
    `investigation_due_date` DATE COMMENT 'Target date for completion of the deviation investigation, typically based on GMP impact classification and organizational quality standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the deviation record was last updated, supporting audit trail and change tracking requirements.',
    `occurrence_date` DATE COMMENT 'Estimated or confirmed date when the deviation actually occurred, which may differ from detection date. Used for root cause analysis and impact assessment.',
    `process_step` STRING COMMENT 'Specific manufacturing, testing, or operational step where the deviation occurred. Examples include blending, tablet compression, dissolution testing, or labeling.',
    `product_code` STRING COMMENT 'Identifier of the drug product or drug substance affected by the deviation, linking to master product data.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `qa_approval_date` DATE COMMENT 'Date when the quality assurance reviewer approved the deviation investigation and closure, authorizing final disposition.',
    `qa_reviewer` STRING COMMENT 'Name or identifier of the quality assurance professional who reviewed and approved the deviation investigation and disposition decision.',
    `quality_deviation_description` STRING COMMENT 'Detailed narrative description of the deviation event, including what was observed, what was expected, and the nature of the departure from approved procedures or specifications.',
    `regulatory_notification_date` DATE COMMENT 'Date when the deviation was reported to the relevant regulatory authority, if reportable. Null if not reportable or not yet reported.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether the deviation meets criteria for mandatory reporting to regulatory authorities such as FDA, EMA, or other health authorities per applicable regulations.',
    `root_cause_summary` STRING COMMENT 'Summary of the root cause analysis findings, identifying the underlying reason(s) for the deviation occurrence. Populated after investigation completion.',
    `source_system` STRING COMMENT 'Identifier of the operational quality management system from which the deviation record was sourced, supporting data lineage and reconciliation.. Valid values are `SAP_QM|TrackWise|MasterControl|Veeva_QualityDocs`',
    CONSTRAINT pk_quality_deviation PRIMARY KEY(`quality_deviation_id`)
) COMMENT 'Planned and unplanned deviation records capturing departures from approved procedures, specifications, or GMP requirements during manufacturing, laboratory, or clinical operations. Tracks deviation category (planned/unplanned), GMP impact classification, affected batch/lot, process step, immediate containment actions, disposition recommendation, regulatory notification requirement, and linkage to CAPA. Sourced from SAP QM and TrackWise.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` (
    `oos_investigation_id` BIGINT COMMENT 'Unique identifier for the OOS investigation record. Primary key.',
    `batch_record_id` BIGINT COMMENT 'Reference to the manufacturing batch that produced the OOS result.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: OOS investigations revealing data integrity violations, analyst errors, or GxP non-compliance constitute formal compliance incidents. Pharmaceutical operations require linking OOS events to compliance',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: OOS investigations require documented initiator for regulatory compliance and accountability. Initiated_by is currently a plain name field; proper FK enables qualification verification, workload track',
    `inventory_lot_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_lot. Business justification: OOS investigations determine inventory lot disposition (release/reject/quarantine). Investigation outcomes directly control inventory availability status. Essential for linking quality testing results',
    `lab_test_result_id` BIGINT COMMENT 'Reference to the specific laboratory test result that triggered the OOS investigation.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: OOS investigations require material genealogy to specific PO for Phase II investigations, assignability determination, and regulatory reporting. Critical for batch disposition decisions.',
    `quality_deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: OOS investigations may identify deviations as the root cause of out-of-specification results. This FK links the OOS investigation to the resulting deviation record. Business case: Phase II OOS investi',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: OOS results traced to vendor material quality for assignability determination, supplier performance metrics, and CAPA assignment. Essential for ICH Q7 supplier quality management.',
    `assignability_determination` STRING COMMENT 'Determination of whether the OOS result is assignable to a specific identifiable cause. Assignable means a definitive cause was found; unassignable means no cause could be conclusively determined.. Valid values are `assignable|unassignable`',
    `batch_disposition` STRING COMMENT 'Final disposition decision for the affected batch based on investigation findings (released, rejected, reworked, quarantined, or pending further investigation).. Valid values are `released|rejected|reworked|quarantined|pending`',
    `closed_by` STRING COMMENT 'Name or identifier of the quality professional who formally closed the OOS investigation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the OOS investigation record was first created in the system.',
    `disposition_justification` STRING COMMENT 'Scientific and regulatory justification for the batch disposition decision, including consideration of patient safety and product quality.',
    `initiated_date` DATE COMMENT 'Date when the OOS investigation was formally initiated following detection of the out-of-specification result.',
    `investigation_closed_date` DATE COMMENT 'Date when the OOS investigation was formally closed after all phases completed and disposition determined.',
    `investigation_conclusion` STRING COMMENT 'Final conclusion summary of the OOS investigation, including determination of cause, impact assessment, and corrective actions taken.',
    `investigation_number` STRING COMMENT 'Business identifier for the OOS investigation, typically assigned by the Quality Management System (QMS) or Laboratory Information Management System (LIMS).',
    `investigation_status` STRING COMMENT 'Current lifecycle status of the OOS investigation. Phase I covers laboratory investigation; Phase II covers full-scale investigation if laboratory error is ruled out.. Valid values are `initiated|phase_i_in_progress|phase_i_complete|phase_ii_in_progress|phase_ii_complete|closed`',
    `laboratory_error_description` STRING COMMENT 'Detailed description of the laboratory error identified, if applicable (e.g., instrument malfunction, calculation error, contamination).',
    `laboratory_error_identified` BOOLEAN COMMENT 'Indicates whether a laboratory error was conclusively identified during Phase I investigation that explains the OOS result.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the OOS investigation record was last modified.',
    `observed_result` STRING COMMENT 'Actual test result value that fell outside the specification limit and triggered the OOS investigation.',
    `phase_i_completion_date` DATE COMMENT 'Date when Phase I laboratory investigation was completed.',
    `phase_i_findings` STRING COMMENT 'Summary of findings from the Phase I laboratory investigation, including any identified laboratory errors or anomalies.',
    `phase_i_start_date` DATE COMMENT 'Date when Phase I laboratory investigation began to determine if the OOS result was due to laboratory error.',
    `phase_ii_completion_date` DATE COMMENT 'Date when Phase II full-scale investigation was completed.',
    `phase_ii_findings` STRING COMMENT 'Summary of findings from Phase II investigation, including root cause analysis of manufacturing, material, or process issues.',
    `phase_ii_required` BOOLEAN COMMENT 'Indicates whether Phase II full-scale investigation is required. Phase II is triggered when no laboratory error is found in Phase I.',
    `phase_ii_start_date` DATE COMMENT 'Date when Phase II full-scale investigation began to determine root cause in manufacturing, materials, or process.',
    `qa_review_date` DATE COMMENT 'Date when the Quality Assurance review and approval was completed.',
    `qa_reviewer` STRING COMMENT 'Name or identifier of the Quality Assurance reviewer who approved the investigation findings and conclusions.',
    `regulatory_report_date` DATE COMMENT 'Date when the OOS investigation was reported to regulatory authorities, if required.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether the OOS investigation findings require reporting to regulatory authorities (FDA, EMA, etc.) per applicable regulations.',
    `retest_authorized` BOOLEAN COMMENT 'Indicates whether retesting was authorized following Phase I investigation. Retesting is only appropriate when laboratory error is confirmed.',
    `retest_justification` STRING COMMENT 'Scientific justification for authorizing retesting, including explanation of the laboratory error that invalidates the original result.',
    `retest_result` STRING COMMENT 'Result obtained from authorized retesting, if performed.',
    `root_cause_description` STRING COMMENT 'Detailed description of the root cause identified in Phase II (e.g., equipment malfunction, raw material deviation, process parameter drift).',
    `root_cause_identified` BOOLEAN COMMENT 'Indicates whether a definitive root cause was identified during Phase II investigation.',
    `specification_limit` STRING COMMENT 'Established acceptance criteria or specification limit that the test result failed to meet (e.g., 95.0-105.0%, NMT 0.5%).',
    `test_method` STRING COMMENT 'Analytical test method or procedure used that produced the OOS result (e.g., HPLC, dissolution, assay).',
    `test_parameter` STRING COMMENT 'Specific quality attribute or parameter being tested (e.g., potency, impurity level, dissolution rate).',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the observed result and specification limit (e.g., %, mg/mL, minutes).',
    CONSTRAINT pk_oos_investigation PRIMARY KEY(`oos_investigation_id`)
) COMMENT 'Out-of-Specification (OOS) investigation records for laboratory test results that fall outside established acceptance criteria. Captures Phase I (laboratory investigation) and Phase II (full-scale investigation) findings, assignability determination, retesting authorization, invalidation justification, final disposition, regulatory reporting obligation, and linkage to affected batch and test result. Governed by FDA OOS guidance and 21 CFR 211.192.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` (
    `quality_change_control_id` BIGINT COMMENT 'Unique identifier for the quality change control record. Primary key.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Change controls for equipment purchases, facility modifications, or system implementations create fixed assets. Essential for tracking change-driven capital expenditures, asset capitalization decision',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Change control initiation requires documented personnel for accountability and regulatory traceability. Initiator_name is denormalized; proper FK enables department lookup, qualification verification,',
    `internal_control_id` BIGINT COMMENT 'Foreign key linking to compliance.internal_control. Business justification: GxP change controls often necessitate updates to SOX/GxP internal controls (e.g., system validations, process controls). Pharmaceutical change management requires documenting which internal controls a',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Major changes (equipment upgrades, process modifications, facility improvements) require capital or operational budget tracked via internal orders. Essential for change control project financial manag',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: Changes to licensed manufacturing technology, processes, or formulations require licensor notification and approval per licensing agreement terms. Contractual obligation in pharmaceutical in-licensing',
    `master_batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.master_batch_record. Business justification: Change controls affecting manufacturing process (formulation changes, equipment modifications, parameter adjustments) must link to MBR for version control, validation impact assessment, regulatory not',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Change controls modifying patented manufacturing processes, formulations, or methods require mandatory IP counsel review to ensure changes remain within patent claims scope. Regulatory and legal compl',
    `qms_document_id` BIGINT COMMENT 'Foreign key linking to quality.qms_document. Business justification: Change control records document changes to QMS documents, SOPs, specifications, and other controlled documents. One change control can reference one primary QMS document being changed (1:N relationshi',
    `quality_deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: Change controls can be initiated to address deviations or prevent recurrence. This FK links the change control to the deviation that triggered it. Business case: deviations may require process changes',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Change controls for vendor qualification changes, site transfers, supplier-initiated changes, or vendor process modifications. Required for ICH Q10 pharmaceutical quality system change management.',
    `actual_implementation_date` DATE COMMENT 'Actual date when the change was implemented in production or operational environment.',
    `affected_markets` STRING COMMENT 'Geographic markets or regulatory jurisdictions affected by the change (e.g., USA, EU, Japan, China), relevant for determining regulatory notification requirements.',
    `affected_products` STRING COMMENT 'List or description of drug products (DP), drug substances (DS), or SKUs affected by this change, including product names, NDC codes, or internal product identifiers.',
    `affected_sop_list` STRING COMMENT 'List of SOP numbers or titles that are affected by the change and require revision or replacement.',
    `approval_date` DATE COMMENT 'Date when the change control request received final approval from the Change Control Board or Quality Assurance.',
    `approver_name` STRING COMMENT 'Name of the person or role who provided final approval for the change (typically QA Manager or Change Control Board Chair).',
    `change_category` STRING COMMENT 'Category of the change indicating what is being changed: manufacturing process, equipment, raw material or API, facility or cleanroom, computer system, or controlled document/SOP.. Valid values are `process|equipment|material|facility|system|document`',
    `change_control_number` STRING COMMENT 'Externally-known unique business identifier for the change control request, typically system-generated or following organizational numbering scheme.. Valid values are `^CC-[0-9]{6,10}$`',
    `change_description` STRING COMMENT 'Detailed description of the proposed change including what is being changed, how it will be changed, and the scope of the change.',
    `change_rationale` STRING COMMENT 'Business and technical justification for the proposed change, including drivers such as quality improvement, cost reduction, regulatory compliance, safety enhancement, or obsolescence.',
    `change_status` STRING COMMENT 'Current lifecycle status of the change control request in the approval and implementation workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|implementation|completed|closed|cancelled — 9 candidates stripped; promote to reference product]',
    `change_title` STRING COMMENT 'Brief descriptive title summarizing the proposed change.',
    `change_type` STRING COMMENT 'Classification of the change based on risk and regulatory impact. Minor changes have low risk and no regulatory notification; major changes require validation and may need regulatory notification; critical changes require prior regulatory approval.. Valid values are `minor|major|critical`',
    `closure_date` DATE COMMENT 'Date when the change control was formally closed after successful implementation and completion of post-implementation review.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this change control record was first created in the system.',
    `effectiveness_verified` BOOLEAN COMMENT 'Indicates whether the change effectiveness has been verified through post-implementation review, confirming that the change achieved its intended purpose without adverse impact.',
    `implementation_plan` STRING COMMENT 'Detailed plan describing how the change will be implemented, including steps, responsibilities, timelines, training requirements, and communication plan.',
    `initiated_date` DATE COMMENT 'Date when the change control request was formally initiated and entered into the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this change control record was last modified or updated.',
    `post_implementation_review` STRING COMMENT 'Summary of the post-implementation review conducted to verify that the change was implemented as planned, achieved intended objectives, and did not introduce unintended consequences. Includes effectiveness assessment.',
    `regulatory_impact_assessment` STRING COMMENT 'Assessment of regulatory implications including whether the change requires prior approval, notification, or annual reporting to regulatory authorities (FDA, EMA, PMDA, etc.) and which markets are affected.',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether regulatory notification or prior approval is required for this change based on regulatory impact assessment.',
    `risk_assessment_summary` STRING COMMENT 'Summary of the risk assessment performed to evaluate potential impact on product quality, patient safety, data integrity, and regulatory compliance. Includes risk level determination.',
    `risk_level` STRING COMMENT 'Overall risk level assigned to the change based on risk assessment, determining the level of review and approval required.. Valid values are `low|medium|high|critical`',
    `sop_updates_required` BOOLEAN COMMENT 'Indicates whether existing SOPs need to be revised or new SOPs need to be created as part of the change implementation.',
    `source_system` STRING COMMENT 'Quality management system or application where the change control record originated (e.g., MasterControl, TrackWise, SAP QM module).. Valid values are `MasterControl|TrackWise|SAP_QM|Veeva_Vault|Other`',
    `target_implementation_date` DATE COMMENT 'Planned or target date for implementing the approved change.',
    `training_required` BOOLEAN COMMENT 'Indicates whether personnel training is required before implementing the change to ensure staff competency with new processes, equipment, or procedures.',
    `validation_protocol_reference` STRING COMMENT 'Reference to validation or qualification protocol document(s) required to support the change, including protocol numbers or document identifiers.',
    `validation_required` BOOLEAN COMMENT 'Indicates whether validation or qualification activities are required to demonstrate that the change does not adversely affect product quality, process performance, or system functionality.',
    CONSTRAINT pk_quality_change_control PRIMARY KEY(`quality_change_control_id`)
) COMMENT 'Change control records managing all proposed changes to processes, equipment, materials, facilities, systems, and documents under GMP. Captures change type (minor/major/critical), change rationale, risk assessment, regulatory impact assessment (requires prior approval vs. notification), validation/qualification requirements, implementation plan, affected products and markets, approval workflow status, and post-implementation review. Sourced from MasterControl/TrackWise and SAP QM.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`audit` (
    `audit_id` BIGINT COMMENT 'Primary key for audit',
    `investigator_id` BIGINT COMMENT 'Foreign key linking to hcp.investigator. Business justification: Clinical investigator audits assess individual investigator GCP compliance, protocol adherence, and data integrity. Critical for clinical trial quality assurance, regulatory inspections, and investiga',
    `oos_investigation_id` BIGINT COMMENT 'Foreign key linking to quality.oos_investigation. Business justification: Audits can uncover OOS investigations that require review or follow-up. This FK links audit findings to specific OOS investigation records. Business case: regulatory inspections may review OOS investi',
    `gxp_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.gxp_obligation. Business justification: Quality audits verify compliance with specific GxP obligations (21 CFR Part 211, EU GMP Annex 1, ICH Q7). Pharmaceutical audit programs require mapping audit scope and findings to regulatory obligatio',
    `hco_master_id` BIGINT COMMENT 'Foreign key linking to hcp.hco_master. Business justification: Clinical site audits assess HCO compliance with GCP and protocol requirements. Essential for clinical trial quality assurance, regulatory inspections, and investigator site qualification tracking.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: External audits and regulatory inspections trigger remediation projects requiring dedicated budget allocation. Internal orders track audit response costs, consultant fees, and remediation expenses, cr',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Audit lead assignment requires qualified auditor for GMP compliance and regulatory inspection readiness. Lead_auditor_name is denormalized; proper FK enables auditor qualification verification, indepe',
    `plant_id` BIGINT COMMENT 'Foreign key reference to the master facility or site record in the Master Data domain. Links the audit to the specific manufacturing, warehouse, or laboratory facility.',
    `program_id` BIGINT COMMENT 'Foreign key reference to the annual audit program or audit plan under which this audit was conducted. Links the audit to the strategic quality oversight program and enables tracking of audit plan execution.',
    `qms_document_id` BIGINT COMMENT 'Document identifier in the Quality Management System (QMS) such as MasterControl or Veeva Vault QualityDocs where the audit record and associated documents are stored. Enables traceability to controlled quality documents.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `quality_capa_id` BIGINT COMMENT 'Foreign key linking to quality.quality_capa. Business justification: Audit findings (internal audits, regulatory inspections) trigger CAPA when deficiencies are identified. audit table has capa_required (BOOLEAN) but no FK to the actual CAPA record. One audit can trigg',
    `quality_deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: Audits frequently identify deviations from approved procedures. This FK captures the specific deviation record that was identified during an audit finding. Business case: regulatory inspections (FDA F',
    `sales_rep_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_rep. Business justification: Audits of individual sales rep activities (sample distribution compliance, call documentation accuracy, promotional practices) are mandatory for FDA/PhRMA compliance. Links audit findings to specific ',
    `territory_id` BIGINT COMMENT 'Foreign key linking to commercial.territory. Business justification: Quality audits of commercial operations (sales rep sample accountability, promotional material compliance, PhRMA code adherence) require territory context for geographic compliance reporting and Sunsh',
    `vendor_id` BIGINT COMMENT 'Foreign key reference to the supplier or Contract Manufacturing Organization (CMO) / Contract Development and Manufacturing Organization (CDMO) master record. Populated for supplier qualification audits and CMO audits.',
    `warehouse_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse_receipt. Business justification: GDP audits inspect receiving operations and reference specific receipt transactions for compliance verification. Audit findings cite receipt documentation for temperature excursions or documentation g',
    `agenda` STRING COMMENT 'Detailed agenda or schedule of audit activities including opening meeting, process walkthroughs, document reviews, interviews, sampling activities, and closing meeting. May reference specific Standard Operating Procedures (SOPs) or areas to be assessed.',
    `audit_number` STRING COMMENT 'Business identifier for the audit or inspection, typically assigned by the Quality Management System (QMS) such as MasterControl or TrackWise. Externally visible audit reference number.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `audit_scope` STRING COMMENT 'Detailed description of the audit scope including functional areas, processes, systems, or product lines covered. May include specific GMP (Good Manufacturing Practice) areas such as manufacturing, quality control, quality assurance, warehousing, distribution, or specific therapeutic product lines.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit. Planned indicates scheduled but not yet started; in preparation indicates pre-audit activities underway; in progress indicates on-site audit activities; fieldwork complete indicates audit activities concluded; draft report indicates findings being documented; final report issued indicates official audit report delivered; closed indicates all findings addressed and audit formally closed. [ENUM-REF-CANDIDATE: planned|in_preparation|in_progress|fieldwork_complete|draft_report|final_report_issued|closed — 7 candidates stripped; promote to reference product]',
    `audit_type` STRING COMMENT 'Classification of the audit or inspection. Internal GMP (Good Manufacturing Practice) audits assess company facilities; supplier qualification audits evaluate vendors; CMO (Contract Manufacturing Organization) audits assess outsourced manufacturing partners; regulatory inspections are conducted by agencies such as FDA (Food and Drug Administration), EMA (European Medicines Agency), or MHRA (Medicines and Healthcare products Regulatory Agency); self-inspections are proactive internal reviews; surveillance audits are follow-up assessments.. Valid values are `internal_gmp|supplier_qualification|cmo_audit|regulatory_inspection|self_inspection|surveillance`',
    `capa_required` BOOLEAN COMMENT 'Boolean flag indicating whether formal Corrective and Preventive Action (CAPA) is required to address audit findings. CAPA is a systematic approach to investigate, correct, and prevent recurrence of quality issues per FDA 21 CFR Part 820 and ICH Q10.',
    `closure_verification_date` DATE COMMENT 'Date when closure verification activities were completed and all audit findings were confirmed as effectively resolved. Marks the formal closure of the audit record.',
    `closure_verification_status` STRING COMMENT 'Status of verification activities to confirm that corrective actions have been effectively implemented and findings are resolved. Pending indicates awaiting verification; in verification indicates verification activities underway; verified indicates actions confirmed effective; closed indicates audit formally closed with all findings resolved.. Valid values are `pending|in_verification|verified|closed`',
    `created_by_user` STRING COMMENT 'Username or identifier of the Quality Management System (QMS) user who created the audit record. Required for audit trail and compliance with FDA 21 CFR Part 11 electronic records and signatures requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was first created in the Quality Management System (QMS). Used for audit trail and record lifecycle tracking per FDA 21 CFR Part 11 electronic records requirements.',
    `criteria` STRING COMMENT 'Set of policies, procedures, regulations, or standards against which the audit was conducted. May include specific FDA 21 CFR parts, ICH guidelines, ISO standards, internal SOPs (Standard Operating Procedures), or GMP (Good Manufacturing Practice) requirements.',
    `critical_findings_count` STRING COMMENT 'Number of critical findings identified. Critical findings represent serious GMP (Good Manufacturing Practice) violations or compliance failures that pose significant risk to product quality, patient safety, or data integrity and require immediate corrective action.',
    `end_date` DATE COMMENT 'Date when the on-site audit or inspection activities concluded. For regulatory inspections, this is the last day of fieldwork before the closeout meeting.',
    `form_483_issued` BOOLEAN COMMENT 'Boolean flag indicating whether the FDA (Food and Drug Administration) issued a Form 483 (Inspectional Observations) at the conclusion of the inspection. Form 483 documents objectionable conditions or practices observed during an FDA inspection.',
    `inspection_type` STRING COMMENT 'Specific type of regulatory inspection. PAI (Pre-Approval Inspection) conducted before product approval; routine inspection per agency schedule; for-cause inspection triggered by quality issues; surveillance inspection for ongoing compliance; GMP (Good Manufacturing Practice), GCP (Good Clinical Practice), or GLP (Good Laboratory Practice) focused inspections. [ENUM-REF-CANDIDATE: pai|routine|for_cause|surveillance|pre_approval|gmp|gcp|glp — 8 candidates stripped; promote to reference product]',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the Quality Management System (QMS) user who last modified the audit record. Required for audit trail and compliance with FDA 21 CFR Part 11 electronic records and signatures requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was last updated or modified. Used for audit trail, change tracking, and compliance with FDA 21 CFR Part 11 electronic records requirements.',
    `major_findings_count` STRING COMMENT 'Number of major findings identified. Major findings represent significant compliance gaps or GMP (Good Manufacturing Practice) deviations that could impact product quality or regulatory compliance and require formal corrective and preventive action (CAPA).',
    `methodology` STRING COMMENT 'Methodology used to conduct the audit. On-site indicates physical presence at the facility; remote indicates virtual audit via video conference and electronic document review; hybrid combines on-site and remote elements; desktop review indicates document-only assessment without site visit.. Valid values are `on_site|remote|hybrid|desktop_review`',
    `minor_findings_count` STRING COMMENT 'Number of minor findings identified. Minor findings represent isolated compliance issues or documentation gaps that do not significantly impact product quality but should be addressed to maintain system integrity.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next audit or inspection of this site or supplier based on audit frequency requirements, risk rating, and regulatory expectations. Used for audit planning and compliance tracking.',
    `observations_count` STRING COMMENT 'Number of observations or opportunities for improvement identified. Observations are noted areas for enhancement that do not constitute compliance violations but represent best practice recommendations.',
    `overall_audit_outcome` STRING COMMENT 'Summary conclusion of the audit or inspection. Satisfactory indicates full compliance; acceptable with observations indicates minor issues noted; deficient indicates significant compliance gaps; unacceptable indicates critical failures; Official Action Indicated (OAI) and Voluntary Action Indicated (VAI) are FDA inspection classifications indicating regulatory action required or recommended.. Valid values are `satisfactory|acceptable_with_observations|deficient|unacceptable|official_action_indicated|voluntary_action_indicated`',
    `planned_audit_date` DATE COMMENT 'Originally scheduled date for the audit as defined in the annual audit plan or inspection schedule. Used for tracking schedule adherence and planning purposes.',
    `pre_audit_preparation_status` STRING COMMENT 'Status of pre-audit preparation activities including document review, audit plan development, team briefing, and logistics coordination. Critical for audit readiness and effectiveness.. Valid values are `not_started|in_progress|complete`',
    `regulatory_agency` STRING COMMENT 'Regulatory authority conducting the inspection. FDA (U.S. Food and Drug Administration), EMA (European Medicines Agency), MHRA (Medicines and Healthcare products Regulatory Agency - UK), PMDA (Pharmaceuticals and Medical Devices Agency - Japan), NMPA (National Medical Products Administration - China), WHO (World Health Organization), DEA (Drug Enforcement Administration), or other national competent authority. [ENUM-REF-CANDIDATE: fda|ema|mhra|pmda|nmpa|who|dea|other — 8 candidates stripped; promote to reference product]',
    `report_issue_date` DATE COMMENT 'Date when the final audit report was officially issued to the auditee or facility management. For regulatory inspections, this is the date the Form 483 or Establishment Inspection Report (EIR) was issued.',
    `report_number` STRING COMMENT 'Unique identifier for the formal audit report document. Links to the audit report stored in Veeva Vault QualityDocs or MasterControl document management system.. Valid values are `^[A-Z0-9-]{6,25}$`',
    `response_due_date` DATE COMMENT 'Date by which the auditee must submit formal written responses to audit findings including root cause analysis and corrective and preventive action (CAPA) plans. Typically 15 business days for FDA (Food and Drug Administration) Form 483 responses.',
    `response_submitted_date` DATE COMMENT 'Actual date when the formal written response to audit findings was submitted to the auditor or regulatory agency. Used to track response timeliness and compliance with response deadlines.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the audited site or supplier based on audit findings, compliance history, product criticality, and potential impact to patient safety or product quality. Used for risk-based oversight and audit frequency determination per ICH Q9 Quality Risk Management.. Valid values are `low|medium|high|critical`',
    `start_date` DATE COMMENT 'Date when the on-site audit or inspection activities commenced. For regulatory inspections, this is the first day of the inspection.',
    `team_members` STRING COMMENT 'Comma-separated list or structured text of audit team members including subject matter experts, technical specialists, and observers participating in the audit.',
    `total_findings_count` STRING COMMENT 'Total number of findings, observations, or deficiencies identified during the audit or inspection across all severity classifications.',
    `warning_letter_issued` BOOLEAN COMMENT 'Boolean flag indicating whether a regulatory Warning Letter was issued following the inspection. Warning Letters are official FDA (Food and Drug Administration) correspondence notifying a company of serious violations requiring prompt corrective action.',
    CONSTRAINT pk_audit PRIMARY KEY(`audit_id`)
) COMMENT 'Master record for quality audits and regulatory inspections including internal GMP audits, supplier/CMO qualification audits, and regulatory agency inspections (FDA PAI, EMA GMP, MHRA). Captures audit type, scope, lead auditor, audit team, site/facility audited, audit dates, pre-audit preparation status, audit agenda, overall audit outcome, and individual findings with classification (critical/major/minor/observation), cited regulation, response commitments, response due dates, and closure verification. Integrates with MasterControl and Veeva Vault QualityDocs.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` (
    `lab_test_result_id` BIGINT COMMENT 'Unique identifier for the laboratory test result record. Primary key.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Lab test results for in-process and release testing must link to batch record for COA generation, batch disposition decisions, OOS investigations, and regulatory traceability. Removes denormalized bat',
    `coa_id` BIGINT COMMENT 'Foreign key linking to quality.coa. Business justification: Lab test results are aggregated into Certificates of Analysis (CoA) for batch release. This FK links each test result to the CoA it was included in. Business case: CoA documents reference specific tes',
    `cogs_entry_id` BIGINT COMMENT 'Foreign key linking to finance.cogs_entry. Business justification: Lab testing costs (materials, reagents, labor, overhead) contribute to COGS and must be allocated to batches. Essential for quality testing cost allocation, standard cost variance analysis, and accura',
    `drug_product_id` BIGINT COMMENT 'Identifier for the product (drug substance, drug product, or raw material) being tested. Links to product master.',
    `equipment_id` BIGINT COMMENT 'Identifier for the analytical instrument used to perform the test. Links to equipment master in LIMS or MES (Manufacturing Execution System).',
    `inventory_lot_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_lot. Business justification: Test results determine inventory lot release status and CoA generation. Quality testing directly gates inventory availability for distribution. Critical for batch release workflow and traceability fro',
    `method_validation_id` BIGINT COMMENT 'Identifier for the validated analytical test method used. References the method master in LIMS.',
    `original_test_result_lab_test_result_id` BIGINT COMMENT 'Reference to the original test result if this is a retest. Links to another lab_test_result record.',
    `employee_id` BIGINT COMMENT 'Identifier for the laboratory analyst who performed the test. Links to employee or user master.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Links test results to specific material receipts for COA reconciliation, material release decisions, and batch traceability. Essential for GMP material qualification and release.',
    `quality_deviation_id` BIGINT COMMENT 'Identifier for any deviation record associated with this test result. Links to deviation management system.',
    `sample_id` BIGINT COMMENT 'Unique identifier for the sample tested. Links to the sample master record in LIMS (Laboratory Information Management System).',
    `site_id` BIGINT COMMENT 'Identifier for the manufacturing or laboratory site where the test was performed. Links to site master.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Lab test results are evaluated against product/material specifications. This FK links each test result to the specification that defines the acceptance criteria. Business case: test results must refer',
    `stability_study_id` BIGINT COMMENT 'Identifier for the stability study if this test is part of a stability protocol. Links to stability study master.',
    `tertiary_lab_approved_by_employee_id` BIGINT COMMENT 'Identifier for the QA person who approved the test result. Links to employee or user master.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Test results for incoming inspection and vendor material testing enable vendor performance trending, quality scorecards, and supplier qualification decisions. Core to supplier quality management.',
    `analyst_name` STRING COMMENT 'Full name of the laboratory analyst who performed the test.',
    `approved_by_name` STRING COMMENT 'Full name of the QA person who approved the test result.',
    `approved_date` TIMESTAMP COMMENT 'Date and time when the test result was approved by Quality Assurance.',
    `approved_flag` BOOLEAN COMMENT 'Boolean indicator that the test result has been approved by Quality Assurance (QA) for release or further processing.',
    `coa_inclusion_flag` BOOLEAN COMMENT 'Boolean indicator that this test result is included in the Certificate of Analysis issued for the batch.',
    `comments` STRING COMMENT 'Free-text comments or observations recorded by the analyst or reviewer regarding the test execution or result.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this test result record was first created in the LIMS system. Audit trail field.',
    `instrument_name` STRING COMMENT 'Name or model of the analytical instrument used (e.g., Agilent HPLC 1260, Distek Dissolution Apparatus).',
    `investigation_id` BIGINT COMMENT 'Identifier for OOS or OOT investigation record if this result triggered an investigation. Links to investigation management system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this test result record was last modified. Audit trail field for change tracking.',
    `oos_flag` BOOLEAN COMMENT 'Boolean indicator that the result is out of specification and requires investigation per OOS procedures.',
    `oot_flag` BOOLEAN COMMENT 'Boolean indicator that the result is within specification but outside expected trend limits, requiring investigation.',
    `pass_fail_status` STRING COMMENT 'Determination of whether the test result meets the specification limits. Current lifecycle status of the test result.. Valid values are `pass|fail|inconclusive|pending`',
    `result_text` STRING COMMENT 'Textual or qualitative result for tests that do not produce numeric values (e.g., Pass/Fail, Conforms, Positive/Negative).',
    `result_value` DECIMAL(18,2) COMMENT 'Raw numerical result value obtained from the test. The principal quantitative measurement for this test execution.',
    `retest_flag` BOOLEAN COMMENT 'Boolean indicator that this test is a retest of a previous result. Used to track retesting activities.',
    `reviewed_by_name` STRING COMMENT 'Full name of the person who reviewed the test result.',
    `reviewed_date` TIMESTAMP COMMENT 'Date and time when the test result was reviewed.',
    `reviewed_flag` BOOLEAN COMMENT 'Boolean indicator that the test result has been reviewed by a qualified reviewer (e.g., QC supervisor).',
    `sample_type` STRING COMMENT 'Classification of the sample being tested. Indicates the stage in the manufacturing or quality lifecycle. [ENUM-REF-CANDIDATE: raw_material|in_process|drug_substance|drug_product|stability|reference_standard|retained_sample — 7 candidates stripped; promote to reference product]',
    `stability_timepoint` STRING COMMENT 'Timepoint in the stability study protocol (e.g., Initial, 3 months, 6 months, 12 months, 24 months).',
    `storage_condition` STRING COMMENT 'Storage condition for stability samples (e.g., 25°C/60% RH, 40°C/75% RH, 5°C, -20°C).',
    `test_completion_timestamp` TIMESTAMP COMMENT 'Precise date and time when the test execution was completed and result recorded.',
    `test_date` DATE COMMENT 'Date when the laboratory test was performed. Principal business event timestamp for the test execution.',
    `test_number` STRING COMMENT 'Business identifier for the test execution. Human-readable unique test number assigned by LIMS.',
    `test_parameter` STRING COMMENT 'Specific quality attribute or parameter being measured (e.g., Assay, Impurity A, pH, Dissolution at 30 min, Bioburden).',
    `test_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the test execution started. Used for audit trail and chronological sequencing.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the result value (e.g., mg/mL, %, CFU/g, pH units, minutes).',
    CONSTRAINT pk_lab_test_result PRIMARY KEY(`lab_test_result_id`)
) COMMENT 'Laboratory quality control test results from LIMS (LabWare/SampleManager) capturing analytical testing of raw materials, in-process samples, drug substance, drug product, and stability samples. Records test method, instrument used, analyst, test date, raw result value, unit of measure, specification limit (lower/upper), pass/fail determination, OOS/OOT flag, reviewed/approved status, and CoA inclusion flag. Primary source for OOS and OOT investigations.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` (
    `stability_study_id` BIGINT COMMENT 'Unique identifier for the stability study record. Primary key.',
    `access_strategy_id` BIGINT COMMENT 'Foreign key linking to market.access_strategy. Business justification: Stability data (shelf life, storage conditions, temperature excursions) directly informs market access strategy, HTA submissions, and reimbursement negotiations. Payers evaluate product handling requi',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Stability studies are initiated on specific manufacturing batches; shelf-life determination, regulatory submissions, and retest date assignment require full batch manufacturing context and history. Re',
    `cogs_entry_id` BIGINT COMMENT 'Foreign key linking to finance.cogs_entry. Business justification: Stability testing costs are part of product lifecycle costs and contribute to COGS. Essential for stability testing cost allocation to batches, product lifecycle costing, and accurate COGS calculation',
    `drug_product_id` BIGINT COMMENT 'Reference to the drug product or drug substance under stability evaluation. Links to master product data.',
    `formulation_id` BIGINT COMMENT 'Foreign key linking to product.formulation. Business justification: Stability studies are conducted on specific formulations to establish shelf-life. Formulation composition directly impacts degradation pathways. Essential for regulatory submissions (ICH Q1A) and supp',
    `inventory_lot_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_lot. Business justification: Stability data supports shelf-life and retest date management for inventory lots. Study results inform expiry date extensions or reductions. Essential for inventory aging management and regulatory com',
    `method_validation_id` BIGINT COMMENT 'Foreign key linking to quality.method_validation. Business justification: Stability studies use validated analytical methods to test samples at each time point. Currently test_parameters is stored as STRING. One stability study uses one primary validated method (1:N relatio',
    `packaging_configuration_id` BIGINT COMMENT 'Foreign key linking to product.packaging_configuration. Business justification: Stability studies are conducted in final packaging configurations. Container-closure system is a critical stability study parameter per ICH Q1A. Shelf-life and storage conditions are packaging-specifi',
    `employee_id` BIGINT COMMENT 'Reference to the quality or analytical scientist responsible for managing the stability study and ensuring protocol compliance. Links to employee master data.',
    `qms_document_id` BIGINT COMMENT 'Reference to the stability study protocol document stored in the Quality Management System (MasterControl or TrackWise or Veeva Vault QualityDocs). Links to controlled document repository.',
    `quaternary_stability_responsible_person_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing or testing site where the stability study is conducted. Links to site master data for GMP compliance tracking.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Stability studies test product stability against specifications. This FK links the stability study to the specification that defines the acceptance criteria. Business case: stability testing must refe',
    `tertiary_stability_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified the stability study record. Audit trail for accountability and compliance.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Stability studies on vendor-manufactured drug products or vendor-supplied container/closure systems. Required for regulatory submissions and vendor qualification for commercial manufacturing.',
    `actual_completion_date` DATE COMMENT 'Actual date when the final time-point testing was completed and the study was closed. Null if study is still active.',
    `container_closure_system` STRING COMMENT 'Description of the primary packaging configuration used in the stability study (e.g., HDPE bottle with child-resistant cap, blister pack PVC/PVDC/Aluminum, glass vial with rubber stopper). Critical for assessing packaging compatibility and shelf-life.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the stability study record was first created in the system. Audit trail field for data governance and compliance.',
    `current_time_point_months` STRING COMMENT 'Most recent time point (in months from study start) for which testing has been completed. Used to track study progress.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the stability study record was last updated. Audit trail field for change tracking and compliance.',
    `lims_study_reference` STRING COMMENT 'External identifier from the Laboratory Information Management System (LIMS) stability module (LabWare or Thermo Fisher SampleManager) where detailed time-point test results are stored. Enables traceability to source system.',
    `oot_flag` BOOLEAN COMMENT 'Boolean flag indicating whether any test result at the current time point exhibits an Out of Trend (OOT) condition based on statistical trend analysis, even if within specification. Triggers OOT investigation per quality procedures.',
    `overall_pass_fail_status` STRING COMMENT 'Aggregate pass/fail status for the most recent completed time point. Fail indicates one or more test parameters exceeded specification limits. Triggers Out of Specification (OOS) investigation if fail.. Valid values are `pass|fail|pending|not_tested`',
    `planned_completion_date` DATE COMMENT 'Target date for completion of the final time-point testing and study closure, typically aligned with regulatory commitment timelines (e.g., 36 months for long-term studies).',
    `pull_point_schedule` STRING COMMENT 'Comma-separated list of planned time points (in months) when samples will be pulled and tested (e.g., 0, 3, 6, 9, 12, 18, 24, 36). Defines the study sampling plan per ICH guidelines.',
    `regulatory_commitment_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this stability study is a post-approval regulatory commitment to a health authority (FDA, EMA, PMDA). Requires tracking and timely reporting.',
    `regulatory_submission_reference` STRING COMMENT 'Reference to the regulatory submission (IND, NDA, BLA, MAA, eCTD module) where this stability study data is included or will be included. Links stability data to regulatory dossier.',
    `retest_date_months` STRING COMMENT 'Retest period in months for drug substances (API) derived from stability data. Indicates the time period after which the material must be retested before use in manufacturing.',
    `shelf_life_months` STRING COMMENT 'Approved or proposed shelf-life (expiry period) in months derived from stability data analysis and statistical modeling. Used for regulatory submission and product labeling.',
    `statistical_trend_analysis_method` STRING COMMENT 'Statistical method applied to evaluate stability data trends and support shelf-life determination: linear regression, pooled regression across batches, bracketing design, matrixing design, or none if not yet analyzed.. Valid values are `linear_regression|pooled_regression|bracketing|matrixing|none`',
    `storage_condition` STRING COMMENT 'ICH-defined storage condition for the stability study: 25°C/60%RH (long-term temperate), 30°C/65%RH (long-term subtropical), 30°C/75%RH (intermediate), 40°C/75%RH (accelerated), 5°C (refrigerated), -20°C (frozen), -70°C (ultra-low), photostability chamber, or stress condition (heat, humidity, oxidation). [ENUM-REF-CANDIDATE: 25C_60RH|30C_65RH|30C_75RH|40C_75RH|5C|minus20C|minus70C|photostability|stress_condition — 9 candidates stripped; promote to reference product]',
    `study_notes` STRING COMMENT 'Free-text field for capturing additional study-level observations, deviations from protocol, chamber malfunctions, sample handling issues, or other relevant comments that may impact data interpretation.',
    `study_protocol_number` STRING COMMENT 'Unique protocol identifier assigned to the stability study per internal numbering convention and regulatory submission requirements.. Valid values are `^[A-Z0-9]{2,4}-[A-Z]{2,4}-[0-9]{4,6}(-[A-Z0-9]{1,4})?$`',
    `study_start_date` DATE COMMENT 'Date when the stability study was initiated and samples were placed into controlled storage chambers. Marks time zero for all pull-point calculations.',
    `study_status` STRING COMMENT 'Current lifecycle status of the stability study indicating whether it is planned, actively running, on hold, completed, cancelled, or under quality review.. Valid values are `planned|active|on_hold|completed|cancelled|under_review`',
    `study_type` STRING COMMENT 'Classification of the stability study: registration (for regulatory submission), commitment (post-approval commitment), ongoing (routine monitoring), photostability (ICH Q1B), stress (forced degradation), intermediate, accelerated, or long-term per ICH Q1A. [ENUM-REF-CANDIDATE: registration|commitment|ongoing|photostability|stress|intermediate|accelerated|long_term — 8 candidates stripped; promote to reference product]',
    `test_parameters` STRING COMMENT 'Comma-separated list of analytical test parameters performed at each time point (e.g., assay, degradation products, dissolution, appearance, pH, viscosity, water content, particulate matter). Defines the analytical scope per study protocol.',
    CONSTRAINT pk_stability_study PRIMARY KEY(`stability_study_id`)
) COMMENT 'Stability study records managing ICH-compliant long-term, accelerated, intermediate, and stress stability programs including study design, scheduling, and individual time-point test results. Captures study protocol number, ICH storage conditions (25°C/60%RH, 30°C/65%RH, 40°C/75%RH), container-closure system, study type (registration, commitment, ongoing, photostability), pull-point schedule with actual pull dates, individual test results per time point (assay, degradation products, dissolution, appearance, pH, viscosity), result values against specification limits, pass/fail status, OOT flags, statistical trend analysis, shelf-life determination, and regulatory submission reference. Governed by ICH Q1A-Q1F and WHO stability guidelines. Sourced from LIMS stability module.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` (
    `method_validation_id` BIGINT COMMENT 'Unique identifier for the analytical method validation record. Primary key for the method validation entity. ROLE=MASTER_RESOURCE.',
    `drug_master_file_id` BIGINT COMMENT 'Foreign key linking to intellectual.drug_master_file. Business justification: Analytical methods validated for DMF-covered materials must reference DMF analytical procedures. Required for regulatory submission consistency and demonstrating method equivalence to DMF holder metho',
    `drug_product_id` BIGINT COMMENT 'Reference to the drug product or drug substance for which the method is validated. Links to product master data.',
    `employee_id` BIGINT COMMENT 'Reference to the quality assurance personnel who approved the method validation. Links to employee or user master data.',
    `formulation_id` BIGINT COMMENT 'Foreign key linking to product.formulation. Business justification: Method validations are formulation-specific for non-compendial analytical methods. Formulation changes (excipient type, API particle size) require method revalidation per ICH Q2(R1). Critical for CMC ',
    `analytical_method_id` BIGINT COMMENT 'Reference to the analytical method being validated. Links to the analytical method master data.',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Analytical methods may be patented or patent-protected technology. Link supports IP portfolio management, licensing agreement compliance, and patent prosecution when method innovations are claimed. Co',
    `rd_capitalization_id` BIGINT COMMENT 'Foreign key linking to finance.rd_capitalization. Business justification: Analytical method validation costs during development are typically capitalized as part of R&D under accounting standards. Essential for method validation cost capitalization, linking validation docum',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing or laboratory site where the method validation was performed. Links to site master data.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Analytical method validations are performed to demonstrate that a test method meets the acceptance criteria defined in a specification. One method validation is performed for one specification (1:N re',
    `accuracy_recovery_percent_mean` DECIMAL(18,2) COMMENT 'Mean recovery percentage from accuracy studies, typically expected to be 98-102% for assay methods.',
    `accuracy_result` STRING COMMENT 'Outcome of the accuracy assessment. Pass indicates recovery within predefined acceptance criteria across the method range.. Valid values are `pass|fail|not_assessed`',
    `api_name` STRING COMMENT 'Name of the active pharmaceutical ingredient (API) that the method is designed to measure or detect.',
    `approval_date` DATE COMMENT 'Date when the validation report and method were formally approved by quality assurance.',
    `compendial_method_flag` BOOLEAN COMMENT 'Indicates whether the method is based on a pharmacopeial (compendial) method from USP, EP, JP, or other official compendia. True if compendial, False if proprietary or in-house developed.',
    `compendial_reference` STRING COMMENT 'Reference to the pharmacopeial monograph or general chapter if the method is compendial (e.g., USP <621>, EP 2.2.46, JP 17).',
    `intermediate_precision_rsd_percent` DECIMAL(18,2) COMMENT 'Relative standard deviation (RSD) from intermediate precision studies (inter-assay precision, different days, analysts, equipment), typically expected to be ≤ 3% for assay methods.',
    `linearity_correlation_coefficient` DECIMAL(18,2) COMMENT 'Correlation coefficient (R) from the linearity study, typically expected to be ≥ 0.999 for assay methods.',
    `linearity_range_lower` DECIMAL(18,2) COMMENT 'Lower limit of the concentration range over which linearity was demonstrated.',
    `linearity_range_unit` STRING COMMENT 'Unit of measure for the linearity range (e.g., mg/mL, µg/mL, percent label claim).',
    `linearity_range_upper` DECIMAL(18,2) COMMENT 'Upper limit of the concentration range over which linearity was demonstrated.',
    `linearity_result` STRING COMMENT 'Outcome of the linearity assessment. Pass indicates acceptable correlation coefficient and residuals within acceptance criteria.. Valid values are `pass|fail|not_assessed`',
    `lod_unit` STRING COMMENT 'Unit of measure for the limit of detection (e.g., µg/mL, ppm, percent).',
    `lod_value` DECIMAL(18,2) COMMENT 'Established limit of detection value for the method - the lowest amount of analyte that can be detected but not necessarily quantitated.',
    `loq_unit` STRING COMMENT 'Unit of measure for the limit of quantitation (e.g., µg/mL, ppm, percent).',
    `loq_value` DECIMAL(18,2) COMMENT 'Established limit of quantitation value for the method - the lowest amount of analyte that can be quantitatively determined with suitable precision and accuracy.',
    `method_type` STRING COMMENT 'Classification of the analytical method by its intended purpose (e.g., assay for potency, identification for substance confirmation, impurity for degradation products).. Valid values are `assay|identification|impurity|dissolution|content_uniformity|related_substances`',
    `overall_validation_conclusion` STRING COMMENT 'Final conclusion of the method validation study. Validated indicates the method is fit for its intended purpose; not validated indicates it failed to meet acceptance criteria; conditionally validated indicates it passed with specific limitations or conditions.. Valid values are `validated|not_validated|conditionally_validated`',
    `precision_result` STRING COMMENT 'Outcome of the precision assessment. Pass indicates RSD values within predefined acceptance criteria for repeatability and intermediate precision.. Valid values are `pass|fail|not_assessed`',
    `product_name` STRING COMMENT 'Name of the drug product (DP) or drug substance (DS) being tested by the validated method.',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Indicates whether this method validation is included in a regulatory submission (IND, NDA, BLA, MAA). True if included in regulatory dossier, False otherwise.',
    `regulatory_submission_type` STRING COMMENT 'Type of regulatory submission in which this method validation is included (e.g., IND for Investigational New Drug, NDA for New Drug Application, BLA for Biologics License Application, MAA for Marketing Authorization Application).. Valid values are `IND|NDA|BLA|MAA|ANDA|DMF`',
    `repeatability_rsd_percent` DECIMAL(18,2) COMMENT 'Relative standard deviation (RSD) from repeatability studies (intra-assay precision), typically expected to be ≤ 2% for assay methods.',
    `robustness_result` STRING COMMENT 'Outcome of the robustness assessment. Pass indicates the method is robust to deliberate variations in parameters such as pH, temperature, flow rate, or mobile phase composition.. Valid values are `pass|fail|not_assessed`',
    `specificity_result` STRING COMMENT 'Outcome of the specificity assessment. Pass indicates the method can unequivocally assess the analyte in the presence of impurities, degradation products, and matrix components.. Valid values are `pass|fail|not_assessed`',
    `technique` STRING COMMENT 'Analytical technique or instrumentation used (e.g., HPLC, GC, UV-Vis Spectroscopy, FTIR, Mass Spectrometry, Titration, Dissolution Apparatus).',
    `validation_completion_date` DATE COMMENT 'Date when all validation activities were completed and the method was deemed validated.',
    `validation_protocol_number` STRING COMMENT 'Unique protocol number assigned to the method validation study. Business identifier for the validation activity.. Valid values are `^[A-Z0-9]{3,20}$`',
    `validation_report_number` STRING COMMENT 'Unique document number for the final validation report summarizing all validation activities and results.. Valid values are `^[A-Z0-9]{3,20}$`',
    `validation_start_date` DATE COMMENT 'Date when the method validation activities commenced.',
    `validation_status` STRING COMMENT 'Current lifecycle status of the method validation activity. Tracks progression from draft through approval or rejection.. Valid values are `draft|in_progress|under_review|approved|rejected|superseded`',
    `validation_type` STRING COMMENT 'Type of validation performed: full validation for new methods, partial for minor modifications, revalidation for significant changes, cross-validation for method transfer, or concurrent validation during routine use.. Valid values are `full|partial|revalidation|cross_validation|concurrent`',
    CONSTRAINT pk_method_validation PRIMARY KEY(`method_validation_id`)
) COMMENT 'Analytical method validation records demonstrating that a test method is fit for its intended purpose per ICH Q2(R1). Captures method type (assay, identification, impurity, dissolution), validation parameters assessed (specificity, linearity, accuracy, precision, LOD, LOQ, robustness), validation protocol number, validation report reference, regulatory submission inclusion flag, method transfer status, and compendial method flag. Sourced from LIMS and Veeva Vault.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`coa` (
    `coa_id` BIGINT COMMENT 'Unique identifier for the certificate of analysis record.',
    `batch_record_id` BIGINT COMMENT 'Reference to the manufacturing batch for which this CoA is issued.',
    `business_partner_id` BIGINT COMMENT 'Reference to the customer or recipient organization for whom this CoA is issued (for commercial distribution).',
    `employee_id` BIGINT COMMENT 'Reference to the Quality Assurance personnel who authorized and signed the CoA.',
    `coa_qa_reviewer_employee_id` BIGINT COMMENT 'Reference to the Quality Assurance reviewer who performed the final review before CoA issuance.',
    `cogs_entry_id` BIGINT COMMENT 'Foreign key linking to finance.cogs_entry. Business justification: Certificate of Analysis issuance represents completion of quality testing; costs should be allocated to the batch COGS. Essential for final release testing cost allocation, batch cost finalization, an',
    `contract_account_id` BIGINT COMMENT 'Foreign key linking to commercial.contract_account. Business justification: Certificates of Analysis issued to commercial customers/distributors for batch release documentation. Required for customer quality agreements, regulatory compliance, and commercial shipment authoriza',
    `inventory_lot_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_lot. Business justification: CoA is the quality release document enabling inventory availability for distribution. Each CoA certifies a specific inventory lot for commercial release. Critical for batch release workflow and custom',
    `market_payer_contract_id` BIGINT COMMENT 'Foreign key linking to market.payer_contract. Business justification: Certain payer contracts (specialty, high-value biologics, government) contractually require Certificate of Analysis documentation for each batch supplied. COA must be linked to contract for compliance',
    `master_id` BIGINT COMMENT 'Foreign key linking to hcp.hcp_master. Business justification: Physicians request batch-specific Certificates of Analysis during medical inquiries or complaint investigations. Tracks which HCP requested quality documentation for specific product batches in clinic',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the product (drug substance, drug product, excipient, or raw material) for which this CoA is issued.',
    `named_patient_request_id` BIGINT COMMENT 'Foreign key linking to medical.named_patient_request. Business justification: Certificates of Analysis are issued for compassionate use/named patient programs to document product quality and QP release for regulatory authorities. Required traceability for NPP supply fulfillment',
    `packaging_configuration_id` BIGINT COMMENT 'Foreign key linking to product.packaging_configuration. Business justification: COAs are issued for specific packaging configurations with unique NDC codes. Market-specific release, serialization compliance, and customer-specific COA formats require packaging-level tracking. Esse',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Links COAs to specific PO receipts for material traceability, incoming inspection reconciliation, and GMP material release documentation. Required for batch record completeness.',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing or testing site that issued this CoA.',
    `specification_id` BIGINT COMMENT 'Reference to the quality specification document used for testing this batch.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: COAs for vendor-supplied materials or issued by vendors for incoming materials. Critical for material release, vendor COA reconciliation, and supplier quality agreement compliance.',
    `authorized_signatory_name` STRING COMMENT 'Name of the Quality Assurance personnel who authorized and signed the CoA.',
    `batch_lot_number` STRING COMMENT 'The batch or lot number of the drug substance, drug product, excipient, or raw material covered by this CoA.',
    `coa_number` STRING COMMENT 'Business identifier for the certificate of analysis, typically following a site-specific numbering convention.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this CoA record was first created in the system.',
    `customer_name` STRING COMMENT 'Name of the customer or recipient organization for whom this CoA is issued.',
    `document_version` STRING COMMENT 'Version number of this CoA document, incremented when reissued or revised.',
    `expiry_date` DATE COMMENT 'Date beyond which the material should not be used, based on stability data and regulatory requirements.',
    `glp_compliance_flag` BOOLEAN COMMENT 'Indicates whether testing was conducted under Good Laboratory Practice (GLP) conditions, typically for preclinical materials.',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Indicates whether the batch was manufactured under current Good Manufacturing Practice (cGMP) conditions.',
    `issued_timestamp` TIMESTAMP COMMENT 'Date and time when this CoA was officially issued and made available to the recipient.',
    `issuing_site_name` STRING COMMENT 'Name of the manufacturing or testing site that issued this CoA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this CoA record was last modified or updated.',
    `lims_reference_number` STRING COMMENT 'Reference number or sample ID from the Laboratory Information Management System (LIMS) used for tracking test results.',
    `manufacturing_date` DATE COMMENT 'Date when the batch was manufactured or compounded.',
    `material_type` STRING COMMENT 'Classification of the material covered by this CoA (drug substance, drug product, excipient, raw material, packaging material, or finished dosage form).. Valid values are `drug_substance|drug_product|excipient|raw_material|packaging_material|finished_dosage_form`',
    `qa_reviewer_name` STRING COMMENT 'Name of the Quality Assurance reviewer who performed the final review before CoA issuance.',
    `regulatory_authority` STRING COMMENT 'Regulatory authority governing the market for which this CoA is issued (e.g., FDA, EMA, PMDA, NMPA).',
    `regulatory_market` STRING COMMENT 'Target regulatory market or jurisdiction for which this CoA is applicable (e.g., USA, EU, Japan, China), using 3-letter country codes or regional identifiers.',
    `release_date` DATE COMMENT 'Date when the batch was officially released by Quality Assurance for use or distribution.',
    `release_status` STRING COMMENT 'Overall quality decision for the batch: released for use/distribution, rejected, pending further testing, conditional release, or quarantine.. Valid values are `released|rejected|pending|conditional_release|quarantine`',
    `remarks` STRING COMMENT 'Additional comments, notes, or special instructions related to this CoA, such as conditional release criteria or special handling requirements.',
    `retest_date` DATE COMMENT 'Date by which the material should be retested to confirm continued compliance with specifications, typically applicable to drug substances and excipients.',
    `sap_qm_inspection_lot` STRING COMMENT 'SAP QM inspection lot number associated with this CoA for integration with enterprise resource planning systems.',
    `storage_conditions` STRING COMMENT 'Recommended storage conditions for the material (e.g., temperature range, humidity, light protection) as specified on the CoA.',
    `test_completion_date` DATE COMMENT 'Date when all quality control testing for this batch was completed.',
    `test_method_reference` STRING COMMENT 'Reference to the analytical test methods used (e.g., USP monograph, internal method number, compendial reference).',
    `test_start_date` DATE COMMENT 'Date when quality control testing for this batch commenced.',
    CONSTRAINT pk_coa PRIMARY KEY(`coa_id`)
) COMMENT 'Certificate of Analysis (CoA) records issued for released batches of drug substance, drug product, excipients, and raw materials. Captures CoA number, issuing site, product name, batch/lot number, manufacturing date, expiry date, test parameters with results and specifications, overall release decision, authorized signatory, customer/recipient, and regulatory market applicability. Integrates with SAP QM and LIMS for automated CoA generation.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` (
    `batch_disposition_id` BIGINT COMMENT 'Primary key for batch_disposition',
    `batch_record_id` BIGINT COMMENT 'Reference to the manufacturing batch record subject to disposition decision. Links to the batch master record in SAP QM.',
    `coa_id` BIGINT COMMENT 'Reference to the Certificate of Analysis document that summarizes all quality control test results supporting the disposition decision.',
    `cogs_entry_id` BIGINT COMMENT 'Foreign key linking to finance.cogs_entry. Business justification: Batch disposition decisions (release/reject) directly impact COGS recognition and inventory valuation. Essential for linking disposition status to financial accounting, inventory write-offs for reject',
    `drug_product_id` BIGINT COMMENT 'Reference to the drug product or drug substance master record for which this batch was manufactured.',
    `employee_id` BIGINT COMMENT 'Reference to the Qualified Person or quality unit approver who authorized the batch disposition decision per regulatory requirements.',
    `inventory_lot_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_lot. Business justification: Disposition decisions (release/reject/quarantine) directly control inventory lot status and availability. QP release authorization gates inventory for distribution. Essential for integrating quality d',
    `market_payer_contract_id` BIGINT COMMENT 'Foreign key linking to market.payer_contract. Business justification: Released batches are allocated to specific payer contracts with committed volumes. Batch disposition decisions (release/reject/quarantine) directly impact contract fulfillment obligations, rebate calc',
    `named_patient_request_id` BIGINT COMMENT 'Foreign key linking to medical.named_patient_request. Business justification: Batch disposition decisions for named patient program supply require QP release linked to specific patient request for regulatory traceability. Critical for compassionate use programs where batch allo',
    `packaging_configuration_id` BIGINT COMMENT 'Foreign key linking to product.packaging_configuration. Business justification: Disposition decisions are made at packaging configuration level for market-specific release. Different markets may have different disposition outcomes for the same bulk product. NDC-level disposition ',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing site or facility where the batch was produced. Critical for site-specific regulatory compliance and traceability.',
    `icsr_id` BIGINT COMMENT 'Foreign key linking to pharmacovigilance.icsr. Business justification: Batch disposition decisions (reject/recall/quarantine) are often triggered by adverse event reports linked to specific batches. Business process: when ICSRs identify batch-specific safety issues, disp',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Batch disposition decisions influenced by vendor material quality issues; tracks vendor impact on batch release for supplier performance management and quality agreements.',
    `batch_number` STRING COMMENT 'The unique manufacturing batch or lot number assigned per GMP batch numbering convention. Business identifier for traceability.',
    `batch_size` DECIMAL(18,2) COMMENT 'The total quantity of drug product or drug substance manufactured in this batch, expressed in the primary unit of measure (e.g., kg, liters, units).',
    `batch_size_uom` STRING COMMENT 'The unit of measure for the batch size (e.g., kg, L, units, tablets, vials).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this disposition record was first created in the source system.',
    `disposition_comments` STRING COMMENT 'Additional comments, notes, or observations recorded by the quality unit or QP during the disposition review and approval process.',
    `disposition_date` DATE COMMENT 'The date on which the formal disposition decision was made and approved by the quality unit or Qualified Person (QP).',
    `disposition_rationale` STRING COMMENT 'Detailed justification and reasoning for the disposition decision, including reference to test results, specifications, deviations, and regulatory compliance considerations.',
    `disposition_status` STRING COMMENT 'Current workflow status of the disposition decision: pending review, approved by QP, rejected, on hold pending investigation closure, or completed.. Valid values are `pending|approved|rejected|on_hold|completed`',
    `disposition_timestamp` TIMESTAMP COMMENT 'The precise date and time when the disposition decision was finalized and recorded in the QMS.',
    `disposition_type` STRING COMMENT 'The formal quality unit decision on the batch: release for distribution, reject and destroy, reprocess, rework, retest, or hold in quarantine pending further investigation.. Valid values are `release|reject|reprocess|rework|retest|quarantine`',
    `expiry_date` DATE COMMENT 'The expiration or retest date assigned to the batch based on stability data and shelf-life specifications.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this disposition record was last updated or modified in the source system.',
    `manufacturing_date` DATE COMMENT 'The date on which the batch manufacturing was completed and the batch was released to quality control for testing.',
    `market_applicability` STRING COMMENT 'Comma-separated list of markets or regulatory jurisdictions for which this batch is approved for distribution (e.g., USA, EU, JPN, ROW). Reflects market-specific release requirements.',
    `open_capa_count` STRING COMMENT 'Number of open CAPA records associated with this batch or its manufacturing process that may impact disposition decision.',
    `open_deviation_count` STRING COMMENT 'Number of open quality deviations associated with this batch that must be resolved or justified prior to release per 21 CFR 211.192.',
    `open_oos_count` STRING COMMENT 'Number of open Out of Specification (OOS) investigations linked to this batch that must be closed before disposition can be finalized.',
    `qp_approver_name` STRING COMMENT 'Full name of the Qualified Person or quality unit approver who signed off on the disposition decision.',
    `quarantine_location` STRING COMMENT 'Physical warehouse location or storage area where the batch is held under quarantine pending final disposition.',
    `quarantine_status` STRING COMMENT 'Physical quarantine status of the batch: quarantined pending disposition, released from quarantine for distribution, or rejected and segregated for destruction.. Valid values are `quarantined|released|rejected`',
    `regulatory_hold_flag` BOOLEAN COMMENT 'Indicates whether the batch is under regulatory hold pending resolution of compliance issues, regulatory inspection findings, or authority requests.',
    `regulatory_hold_reason` STRING COMMENT 'Explanation of the regulatory hold, including the authority imposing the hold, the compliance issue, and the resolution path.',
    `regulatory_report_date` DATE COMMENT 'The date on which the disposition decision was reported to the relevant regulatory authority (FDA, EMA, PMDA, etc.).',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether the disposition decision (e.g., rejection, reprocessing) must be reported to regulatory authorities per regional requirements.',
    `rejected_quantity` DECIMAL(18,2) COMMENT 'The quantity of the batch rejected and segregated for destruction or reprocessing due to non-conformance with specifications.',
    `released_quantity` DECIMAL(18,2) COMMENT 'The quantity of the batch approved for release and distribution, which may be less than the total batch size if partial rejection or rework occurred.',
    `retest_date` DATE COMMENT 'The date by which the batch must be retested to confirm continued compliance with specifications, applicable for drug substances and intermediates.',
    `source_system` STRING COMMENT 'The operational system of record from which this disposition record was sourced, typically SAP QM or MasterControl/TrackWise.',
    CONSTRAINT pk_batch_disposition PRIMARY KEY(`batch_disposition_id`)
) COMMENT 'Batch release and disposition decision records capturing the formal quality unit decision to release, reject, reprocess, rework, or retest a manufactured batch per 21 CFR 211.22 and EU GMP Annex 16. Records disposition type, Qualified Person (QP) or quality unit approver, disposition date, disposition rationale, regulatory hold flag, market applicability (US, EU, JP, ROW), quarantine status, and linkage to batch record, CoA, and any open deviations or OOS investigations that must be resolved prior to release. Sourced from SAP QM.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`complaint` (
    `complaint_id` BIGINT COMMENT 'Primary key for complaint',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Product complaint investigations require access to complete batch manufacturing history, deviations, process parameters, and test results for root cause analysis and regulatory reporting. Removes deno',
    `call_activity_id` BIGINT COMMENT 'Foreign key linking to commercial.call_activity. Business justification: Complaints reported during sales calls require linkage for adverse event tracking, PhRMA code compliance, and CRM documentation. Enables traceability from complaint to originating HCP interaction, sup',
    `employee_id` BIGINT COMMENT 'Reference to the Quality Assurance professional who reviewed and approved the closure of the complaint.',
    `complaint_employee_id` BIGINT COMMENT 'Reference to the Quality Assurance professional or team member assigned as the primary owner of the complaint investigation.',
    `hco_master_id` BIGINT COMMENT 'Foreign key linking to hcp.hco_master. Business justification: Hospitals and clinics report institutional product complaints for products administered in their facilities. Tracks originating healthcare organization for complaint investigation and institutional tr',
    `icsr_id` BIGINT COMMENT 'Foreign key linking to pharmacovigilance.icsr. Business justification: Product complaints frequently trigger or correlate with adverse event reports. Regulatory requirement: complaint handling systems must link consumer complaints to ICSRs for signal detection, trend ana',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Product complaints revealing labeling violations, adverse events, or GxP non-compliance trigger formal compliance incidents. Pharmaceutical complaint handling requires escalation to compliance inciden',
    `inquiry_id` BIGINT COMMENT 'Foreign key linking to medical.medical_inquiry. Business justification: Product complaints frequently originate from medical information requests or MSL engagements where HCPs report quality issues. Critical traceability link for complaint handling and regulatory reportin',
    `inventory_lot_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_lot. Business justification: Complaint investigations must trace to specific inventory lots for recall risk assessment and market withdrawal decisions. Critical for linking customer complaints to physical inventory for dispositio',
    `master_id` BIGINT COMMENT 'Foreign key linking to hcp.hcp_master. Business justification: Physicians frequently report product quality complaints and adverse events. Links complaint to reporting HCP for trend analysis, regulatory reporting, and follow-up. Replaces denormalized complainant_',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the pharmaceutical product (Drug Product or Drug Substance) that is the subject of the complaint.',
    `oos_investigation_id` BIGINT COMMENT 'Foreign key linking to quality.oos_investigation. Business justification: Product complaints about quality issues may trigger OOS investigations when retained samples are retested. This FK links the complaint to the resulting OOS investigation. Business case: complaint abou',
    `packaging_configuration_id` BIGINT COMMENT 'Foreign key linking to product.packaging_configuration. Business justification: Complaints reference specific NDC codes and packaging types. Packaging defects (label errors, container integrity, device malfunction) are major complaint categories. Packaging-level traceability is r',
    `adverse_event_id` BIGINT COMMENT 'Foreign key linking to patient.adverse_event. Business justification: Regulatory requirement (FDA 21 CFR 314.80, EMA guidelines) to cross-reference product quality complaints with adverse events for integrated safety/quality signal detection. Real process: complaint int',
    `patient_id` BIGINT COMMENT 'Foreign key linking to patient.patient. Business justification: Product complaints frequently originate from patients reporting quality issues (packaging defects, foreign matter, appearance). Real business process: complaint intake captures patient identity for fo',
    `payer_account_id` BIGINT COMMENT 'Foreign key linking to market.payer_account. Business justification: Product complaints are tracked by originating payer channel (PBM, health system, specialty pharmacy) for trend analysis, contractual quality metrics reporting, and targeted corrective actions. Essenti',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Links complaints to specific material batches via PO for material genealogy, root cause investigation, and potential recall scope determination. Critical for regulatory reporting.',
    `quality_capa_id` BIGINT COMMENT 'Foreign key linking to quality.quality_capa. Business justification: Product quality complaints often trigger CAPA when investigation reveals systemic issues requiring corrective/preventive action. One complaint can trigger one CAPA (1:N relationship). This FK enables ',
    `quality_deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: Product complaints often trigger deviation investigations when the complaint reveals a departure from approved procedures. This FK links the complaint to the resulting deviation record. Business case:',
    `sales_rep_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_rep. Business justification: Product complaints often originate from sales rep territories; tracking originating rep enables follow-up investigation, customer communication, and adverse event reporting. Required for pharmacovigil',
    `territory_id` BIGINT COMMENT 'Foreign key linking to commercial.territory. Business justification: Geographic complaint analysis by territory enables safety signal detection, market surveillance, and targeted corrective actions. Required for FDA adverse event reporting, trend analysis, and territor',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Product complaints traced to vendor-supplied components for root cause analysis, vendor CAPA assignment, and supplier quality agreement enforcement. Required for FDA adverse event reporting.',
    `closure_date` DATE COMMENT 'Date when the complaint investigation and all associated actions were completed and the complaint record was officially closed.',
    `complaint_category` STRING COMMENT 'Primary classification of the complaint type based on the nature of the issue reported.. Valid values are `efficacy|safety|quality_defect|packaging|labeling|contamination`',
    `complaint_description` STRING COMMENT 'Detailed narrative description of the complaint as reported by the complainant, including symptoms, observations, and circumstances.',
    `complaint_number` STRING COMMENT 'Business-facing unique complaint tracking number assigned by the Quality Management System (QMS). Format: CMP-YYYYNNNN.. Valid values are `^CMP-[0-9]{8}$`',
    `complaint_source` STRING COMMENT 'Origin of the complaint indicating who reported the product quality issue. HCP = Healthcare Professional.. Valid values are `hcp|patient|distributor|regulatory_agency|internal|pharmacy`',
    `complaint_status` STRING COMMENT 'Current lifecycle status of the complaint investigation and resolution process.. Valid values are `new|under_investigation|pending_review|closed|cancelled`',
    `corrective_action_taken` STRING COMMENT 'Description of immediate and long-term corrective actions implemented to address the complaint and prevent recurrence.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when the complaint record was first created in the Quality Management System (QMS).',
    `initial_risk_assessment` STRING COMMENT 'Preliminary risk classification assigned upon complaint receipt to prioritize investigation urgency and resource allocation.. Valid values are `critical|major|moderate|minor|negligible`',
    `investigation_findings` STRING COMMENT 'Summary of the investigation results, including laboratory testing, batch record review, and field investigation outcomes.',
    `investigation_required_flag` BOOLEAN COMMENT 'Indicates whether a formal quality investigation is required based on initial assessment and risk classification.',
    `investigation_start_date` DATE COMMENT 'Date when the formal complaint investigation was initiated by the Quality Assurance (QA) team.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when the complaint record was last updated, supporting audit trail and data lineage requirements.',
    `market_of_origin` STRING COMMENT 'Three-letter ISO country code indicating the geographic market where the complaint originated (e.g., USA, GBR, JPN).. Valid values are `^[A-Z]{3}$`',
    `ndc_code` STRING COMMENT 'National Drug Code identifying the specific product, package size, and manufacturer. Format: XXXXX-XXXX-XX.. Valid values are `^[0-9]{5}-[0-9]{4}-[0-9]{2}$`',
    `occurrence_date` DATE COMMENT 'Date when the product quality issue or adverse event allegedly occurred, as reported by the complainant.',
    `patient_impact_flag` BOOLEAN COMMENT 'Indicates whether the complaint involves actual or potential patient harm, safety concern, or adverse event requiring pharmacovigilance assessment.',
    `product_name` STRING COMMENT 'Commercial or International Nonproprietary Name (INN) of the pharmaceutical product involved in the complaint.',
    `received_date` DATE COMMENT 'Date when the complaint was first received by the organization, triggering the complaint handling process.',
    `regulatory_authority` STRING COMMENT 'Three-letter code identifying the regulatory agency to which the complaint was or will be reported (FDA, EMA, MHRA, PMDA, NMPA).. Valid values are `^[A-Z]{3}$`',
    `regulatory_reference_number` STRING COMMENT 'Tracking number or case identifier assigned by the regulatory authority upon submission of the complaint report.',
    `regulatory_report_date` DATE COMMENT 'Date when the complaint was officially reported to the applicable regulatory authority.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether the complaint meets criteria for mandatory reporting to regulatory authorities (FDA MedWatch, EMA, MHRA Yellow Card, etc.).',
    `response_communication` STRING COMMENT 'Summary of the response provided to the complainant, including explanation of findings and actions taken.',
    `response_date` DATE COMMENT 'Date when the formal response was communicated to the complainant.',
    `root_cause` STRING COMMENT 'Identified root cause of the complaint based on investigation findings, using structured root cause analysis methodology.',
    `root_cause_category` STRING COMMENT 'High-level classification of the root cause (e.g., manufacturing process, material defect, human error, equipment failure, environmental condition). [ENUM-REF-CANDIDATE: manufacturing_process|material_defect|human_error|equipment_failure|environmental_condition|design_defect|supplier_issue — promote to reference product]',
    `source_system` STRING COMMENT 'Identifier of the operational Quality Management System from which this complaint record originated (TrackWise, Veeva Vault QualityDocs, MasterControl, SAP QM).. Valid values are `TrackWise|Veeva_Vault|MasterControl|SAP_QM`',
    `subcategory` STRING COMMENT 'Detailed sub-classification providing additional granularity to the complaint category (e.g., foreign particulate matter, incorrect dosage form, damaged container).',
    `trend_flag` BOOLEAN COMMENT 'Indicates whether this complaint is part of an identified trend or cluster of similar complaints requiring aggregate analysis.',
    CONSTRAINT pk_complaint PRIMARY KEY(`complaint_id`)
) COMMENT 'Product quality complaint records from healthcare professionals, patients, distributors, and regulatory agencies regarding marketed pharmaceutical products. Captures complaint source, category (efficacy, safety, quality defect, packaging/labeling), affected product and lot number, market of origin, initial risk assessment, investigation findings, root cause, regulatory reportability determination (MedWatch, MHRA Yellow Card), corrective action taken, response communication, trend flag, and closure status. Integrates with pharmacovigilance domain for safety-related complaints and SAP QM for quality complaints. Sourced from TrackWise/Veeva Vault.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`validation` (
    `validation_id` BIGINT COMMENT 'Primary key for validation',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Validation protocols (process validation, cleaning validation, equipment qualification) executed using specific qualification batches must link to those batches for regulatory traceability, inspection',
    `distribution_network_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_network. Business justification: Equipment validations (cold chain, temperature mapping) support GDP authorization for distribution network nodes. Validation status is required for site qualification and regulatory inspections. Criti',
    `equipment_id` BIGINT COMMENT 'Reference to the specific equipment or asset being validated. Applicable for equipment qualification (IQ/OQ/PQ) and cleaning validation.',
    `formulation_id` BIGINT COMMENT 'Foreign key linking to product.formulation. Business justification: Process validations (IQ/OQ/PQ) qualify manufacturing of specific formulations. Formulation changes trigger revalidation per FDA process validation guidance. PPQ batches and concurrent validation are f',
    `internal_control_id` BIGINT COMMENT 'Foreign key linking to compliance.internal_control. Business justification: Process and system validations serve as key controls in SOX and GxP compliance frameworks. Pharmaceutical operations require linking validation protocols to internal controls for control testing, audi',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Validation projects (equipment qualification, process validation, cleaning validation) require significant budget allocation and cost tracking. Internal orders capture validation costs for financial r',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the drug product or drug substance being validated. Applicable for process validation and product-specific equipment validation.',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Process and equipment validations provide evidence of patented method operability and reproducibility. Critical for patent prosecution support, litigation defense, and demonstrating reduction to pract',
    `quality_change_control_id` BIGINT COMMENT 'Reference to the change control record that triggered or is associated with this validation activity. Links validation to change management process.',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing site or facility where the validation is being performed.',
    `sop_id` BIGINT COMMENT 'Foreign key linking to quality.sop. Business justification: Validation protocols reference the SOP that defines the validation procedure. Currently stored as sop_reference (STRING). Normalizing to FK allows proper referential integrity and enables joining to g',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Validation team lead assignment requires qualified personnel for GMP compliance. Validation_team_lead is currently a plain name field; proper FK enables qualification verification, workload tracking, ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Process validations involving vendor-manufactured materials, vendor equipment qualification, or vendor services (cleaning, calibration). Required for ICH Q7 supplier qualification and technology trans',
    `acceptance_criteria` STRING COMMENT 'Pre-defined acceptance criteria that must be met for the validation to be considered successful. Includes pass/fail thresholds and statistical requirements.',
    `actual_completion_date` DATE COMMENT 'Actual date when the validation was fully completed, including final report approval and closure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this validation record was first created in the source system. Audit trail field for data lineage.',
    `deviation_summary` STRING COMMENT 'Summary description of any deviations encountered during validation execution, including their impact assessment and resolution.',
    `deviations_observed` STRING COMMENT 'Count of deviations or non-conformances observed during validation execution that required documentation and investigation.',
    `execution_end_date` DATE COMMENT 'Date when the validation protocol execution was completed. All test steps and data collection finished by this date.',
    `execution_start_date` DATE COMMENT 'Date when the validation protocol execution commenced. Represents the beginning of actual testing activities.',
    `gmp_classification` STRING COMMENT 'GMP impact classification of the validation: GMP_critical (direct product contact or critical quality impact), GMP_major (indirect product impact), GMP_minor (supporting systems), or non_GMP (non-regulated systems).. Valid values are `GMP_critical|GMP_major|GMP_minor|non_GMP`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this validation record was last updated or modified in the source system. Audit trail field for change tracking.',
    `next_revalidation_due_date` DATE COMMENT 'Scheduled date for the next periodic revalidation activity. Calculated based on revalidation frequency and last validation completion date.',
    `overall_outcome` STRING COMMENT 'Final outcome determination of the validation: pass (all acceptance criteria met), fail (critical criteria not met), conditional_pass (passed with minor observations requiring follow-up), or incomplete (execution not finished).. Valid values are `pass|fail|conditional_pass|incomplete`',
    `planned_completion_date` DATE COMMENT 'Target date for completing the entire validation lifecycle, including execution and final report approval.',
    `protocol_approval_date` DATE COMMENT 'Date when the validation protocol was formally approved by Quality Assurance and authorized for execution.',
    `protocol_approved_by` STRING COMMENT 'Name and title of the Quality Assurance representative who approved the validation protocol for execution.',
    `protocol_author` STRING COMMENT 'Name of the individual who authored or prepared the validation protocol document.',
    `protocol_number` STRING COMMENT 'Business identifier for the validation protocol, typically following site-specific numbering conventions (e.g., VP-FAC001-2024-001).. Valid values are `^VP-[A-Z0-9]{6,12}$`',
    `protocol_objective` STRING COMMENT 'Detailed objective and scope statement describing what the validation protocol intends to demonstrate or verify.',
    `protocol_title` STRING COMMENT 'Descriptive title of the validation protocol, summarizing the scope and objective of the validation activity.',
    `qa_reviewer` STRING COMMENT 'Name and title of the Quality Assurance representative who reviewed and approved the validation report.',
    `regulatory_authority` STRING COMMENT 'Primary regulatory authority with jurisdiction over this validation: FDA (US), EMA (EU), MHRA (UK), PMDA (Japan), NMPA (China), WHO, or multiple authorities. [ENUM-REF-CANDIDATE: FDA|EMA|MHRA|PMDA|NMPA|WHO|multiple — 7 candidates stripped; promote to reference product]',
    `regulatory_impact_flag` BOOLEAN COMMENT 'Indicates whether this validation has regulatory reporting implications or is subject to regulatory inspection (True/False).',
    `report_approval_date` DATE COMMENT 'Date when the final validation report was approved by Quality Assurance, formally closing the validation activity.',
    `report_number` STRING COMMENT 'Document control number of the final validation report that summarizes execution results, data analysis, and conclusions.. Valid values are `^VR-[A-Z0-9]{6,12}$`',
    `revalidation_frequency_months` STRING COMMENT 'Frequency in months at which revalidation must be performed (e.g., 12, 24, 36 months). Applicable when revalidation_required_flag is True.',
    `revalidation_required_flag` BOOLEAN COMMENT 'Indicates whether periodic revalidation is required for this validated system, process, or equipment (True/False).',
    `source_system` STRING COMMENT 'Name of the source system from which this validation record originated (e.g., MasterControl, TrackWise, Kneat, SAP QM).',
    `team_members` STRING COMMENT 'Comma-separated list of team members participating in the validation execution, including their roles (e.g., QA reviewer, process engineer, analyst).',
    `test_runs_completed` STRING COMMENT 'Number of test runs or batches successfully completed during validation execution.',
    `test_runs_planned` STRING COMMENT 'Number of test runs or batches planned for execution as part of the validation protocol (e.g., 3 consecutive batches for process validation).',
    `test_steps_failed` STRING COMMENT 'Number of test steps that did not meet acceptance criteria and failed during validation execution.',
    `test_steps_passed` STRING COMMENT 'Number of test steps that met acceptance criteria and passed during validation execution.',
    `test_steps_total` STRING COMMENT 'Total number of individual test steps or test cases defined in the validation protocol.',
    `validation_category` STRING COMMENT 'High-level category of the validation activity: equipment, process, cleaning, computer system, analytical method, facility, or utility validation. [ENUM-REF-CANDIDATE: equipment|process|cleaning|computer_system|analytical_method|facility|utility — 7 candidates stripped; promote to reference product]',
    `validation_status` STRING COMMENT 'Current lifecycle status of the validation protocol: draft (under development), approved (ready for execution), in_execution (testing underway), on_hold (temporarily suspended), completed (successfully finished), failed (did not meet acceptance criteria), conditional_pass (passed with minor observations), or cancelled. [ENUM-REF-CANDIDATE: draft|approved|in_execution|on_hold|completed|failed|conditional_pass|cancelled — 8 candidates stripped; promote to reference product]',
    `validation_type` STRING COMMENT 'Type of validation being performed: IQ (Installation Qualification), OQ (Operational Qualification), PQ (Performance Qualification), process validation stages 1-3, cleaning validation, CSV (Computer System Validation) per 21 CFR Part 11, concurrent validation, retrospective validation, or CPV (Continued Process Verification). [ENUM-REF-CANDIDATE: IQ|OQ|PQ|process_stage_1|process_stage_2|process_stage_3|cleaning|CSV|concurrent|retrospective|CPV — 11 candidates stripped; promote to reference product]',
    CONSTRAINT pk_validation PRIMARY KEY(`validation_id`)
) COMMENT 'Unified validation records managing the complete lifecycle of process, equipment, cleaning, and computer system validation under GMP — from protocol definition through execution to final report. Captures validation type (IQ/OQ/PQ, process validation stages 1-3, cleaning validation, CSV/21 CFR Part 11), protocol number, acceptance criteria, validation team, execution dates, individual test step results, deviations observed during execution, overall outcome (pass/fail/conditional), validation report reference, and linkage to change control. Supports continued process verification (CPV) as a validation type. Governed by ICH Q8/Q9/Q10, EMA Annex 15, FDA Process Validation Guidance, and GAMP 5. Sourced from MasterControl/Kneat and SAP QM.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`specification` (
    `specification_id` BIGINT COMMENT 'Unique identifier for the quality specification record. Primary key.',
    `analytical_method_id` BIGINT COMMENT 'Foreign key linking to quality.analytical_method. Business justification: Specifications define acceptance criteria and reference the analytical method used for testing. Currently stored as analytical_method_reference (STRING). Normalizing to FK allows proper referential in',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Specification authorship requires qualified personnel for GMP compliance and regulatory traceability. Author_name is denormalized; proper FK enables author qualification verification, workload trackin',
    `drug_master_file_id` BIGINT COMMENT 'Foreign key linking to intellectual.drug_master_file. Business justification: Specifications reference DMF sections for API and excipient quality standards. Required for regulatory filing consistency, DMF cross-referencing in NDAs/ANDAs, and ensuring specification alignment wit',
    `drug_product_id` BIGINT COMMENT 'Reference to the product or material master record this specification applies to. Links to product master data.',
    `drug_substance_id` BIGINT COMMENT 'Foreign key linking to product.drug_substance. Business justification: Drug substance specifications are foundational for API release testing. Pharmacopoeial monographs and in-house impurity limits are substance-specific. Required for regulatory submissions (CTD Module 3',
    `excipient_id` BIGINT COMMENT 'Foreign key linking to product.excipient. Business justification: Excipient specifications define acceptance criteria for incoming materials. Compendial (USP/EP) vs. in-house specifications are excipient-specific. Required for incoming material release, supplier qua',
    `formulation_id` BIGINT COMMENT 'Foreign key linking to product.formulation. Business justification: Specifications are written at formulation level, defining acceptance criteria for CQAs. QbD design space and control strategy link directly to formulation specifications. Formulation-level specs drive',
    `gxp_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.gxp_obligation. Business justification: Specifications implement specific GxP regulatory obligations (USP monographs, CFR requirements, ICH guidelines). Pharmaceutical quality systems require traceability from specifications to regulatory o',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Specifications embody patented formulation ranges, process parameters, and quality attributes claimed in patents. Essential for patent prosecution evidence, regulatory defense of patent scope, and fre',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.approval. Business justification: Quality specifications must link to regulatory approvals to track approved specifications for marketed products. This is critical for regulatory compliance and change control management. The specifica',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing site or facility where this specification is applicable. Links to site master data.',
    `superseded_by_specification_id` BIGINT COMMENT 'Reference to the newer specification version that supersedes this one. Null if this is the current effective version.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Material specifications for vendor-supplied raw materials, APIs, excipients, or packaging components. Core to supplier quality agreements and approved vendor list management.',
    `acceptance_criterion` STRING COMMENT 'The acceptance limit or range for the test parameter, expressed as numeric limits (e.g., 95.0% - 105.0%, NMT 0.5%, pH 6.0 - 8.0) or qualitative criteria (e.g., Conforms, White to off-white powder).',
    `approval_date` DATE COMMENT 'The date on which this specification version was formally approved by the quality unit.',
    `approver_name` STRING COMMENT 'Name of the authorized quality unit representative who approved this specification for use.',
    `cpp_linkage` STRING COMMENT 'Reference to the Critical Process Parameters (CPPs) that impact this CQA, establishing the QbD design space linkage.',
    `cqa_flag` BOOLEAN COMMENT 'Indicates whether this test parameter is designated as a Critical Quality Attribute (CQA) under Quality by Design (QbD) principles. True if CQA, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this specification record was first created in the system.',
    `document_location` STRING COMMENT 'File path or document management system reference where the full specification document is stored (e.g., Veeva Vault document ID, SharePoint URL).',
    `effective_date` DATE COMMENT 'The date on which this specification version becomes effective and must be used for testing and release decisions.',
    `expiry_date` DATE COMMENT 'The date on which this specification version is no longer valid and must be replaced. Null if the specification is open-ended until superseded.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this specification record was last updated in the system.',
    `lower_limit` DECIMAL(18,2) COMMENT 'Numeric lower acceptance limit for quantitative test parameters. Null for qualitative tests or tests with only upper limits.',
    `market_authorization` STRING COMMENT 'Geographic markets or countries where this specification is approved and in effect (e.g., USA, EU, JPN, Global). Multiple markets may be comma-separated.',
    `material_code` STRING COMMENT 'The material number or SKU from the ERP system (SAP material master) identifying the specific drug substance, drug product, or raw material.',
    `material_description` STRING COMMENT 'Full textual description of the material, including strength, dosage form, and presentation (e.g., Ibuprofen 200mg Tablet, Film-Coated).',
    `material_type` STRING COMMENT 'Category of material this specification applies to: drug_substance (DS), drug_product (DP), active pharmaceutical ingredient (API), excipient, packaging_component, raw_material, or intermediate. [ENUM-REF-CANDIDATE: drug_substance|drug_product|api|excipient|packaging_component|raw_material|intermediate — 7 candidates stripped; promote to reference product]',
    `pharmacopoeial_monograph` STRING COMMENT 'Specific monograph or chapter reference from the pharmacopoeia (e.g., USP <711> Dissolution, EP 2.9.1 Disintegration, JP 6.02 Uniformity of Dosage Units).',
    `pharmacopoeial_standard` STRING COMMENT 'The pharmacopoeia standard referenced for this test parameter: USP (United States Pharmacopeia), EP (European Pharmacopoeia), JP (Japanese Pharmacopoeia), BP (British Pharmacopoeia), IP (Indian Pharmacopoeia), ChP (Chinese Pharmacopoeia), or none if not pharmacopoeial. [ENUM-REF-CANDIDATE: USP|EP|JP|BP|IP|ChP|none — 7 candidates stripped; promote to reference product]',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory authority approval for this specification: not_submitted (internal use only), submitted (filed with authority), approved (accepted by authority), rejected (not accepted), or pending_revision (changes requested).. Valid values are `not_submitted|submitted|approved|rejected|pending_revision`',
    `regulatory_authority` STRING COMMENT 'The regulatory body that approved or will approve this specification (e.g., FDA, EMA, PMDA, MHRA, NMPA). Multiple authorities may be comma-separated.',
    `regulatory_submission_reference` STRING COMMENT 'Reference to the regulatory submission (IND, NDA, BLA, MAA, ANDA) in which this specification was filed or approved.',
    `reviewer_name` STRING COMMENT 'Name of the quality assurance reviewer who reviewed this specification prior to approval.',
    `source_system` STRING COMMENT 'The operational system of record from which this specification data originated: SAP_QM (SAP Quality Management), LIMS (Laboratory Information Management System), Veeva_Vault (Veeva QualityDocs), MasterControl, TrackWise, or Manual (manually entered).. Valid values are `SAP_QM|LIMS|Veeva_Vault|MasterControl|TrackWise|Manual`',
    `specification_number` STRING COMMENT 'Business identifier for the specification document, typically following organizational numbering conventions (e.g., SPEC-DS-001, SPEC-DP-045).',
    `specification_status` STRING COMMENT 'Current lifecycle status of the specification: draft (being authored), under_review (in approval workflow), approved (approved but not yet effective), effective (currently in use), superseded (replaced by newer version), obsolete (no longer valid), or withdrawn (removed from use). [ENUM-REF-CANDIDATE: draft|under_review|approved|effective|superseded|obsolete|withdrawn — 7 candidates stripped; promote to reference product]',
    `specification_type` STRING COMMENT 'Classification of the specification based on its intended use: release (batch release testing), shelf-life (end of shelf-life criteria), in-process (during manufacturing), stability (stability study acceptance), reference_standard (for reference materials), or raw_material (incoming material testing).. Valid values are `release|shelf_life|in_process|stability|reference_standard|raw_material`',
    `target_value` DECIMAL(18,2) COMMENT 'The target or nominal value for the test parameter, representing the ideal result within the acceptance range. Used for process capability and quality by design (QbD) analysis.',
    `test_frequency` STRING COMMENT 'The frequency at which this test must be performed (e.g., Every batch, Annual, Quarterly, Skip lot (1 in 3), On change).',
    `test_parameter` STRING COMMENT 'The specific quality attribute or test being specified (e.g., Assay, Dissolution, Impurity A, pH, Moisture Content, Particulate Matter).',
    `unit_of_measure` STRING COMMENT 'The unit in which the test result and limits are expressed (e.g., %, mg/mL, pH units, minutes, CFU/g, ppm).',
    `upper_limit` DECIMAL(18,2) COMMENT 'Numeric upper acceptance limit for quantitative test parameters. Null for qualitative tests or tests with only lower limits.',
    `version` STRING COMMENT 'Version number of the specification document, following organizational versioning conventions (e.g., 1.0, 2.1, 3.0). Incremented with each revision.',
    CONSTRAINT pk_specification PRIMARY KEY(`specification_id`)
) COMMENT 'Product and material quality specification records defining acceptance criteria for drug substances, drug products, raw materials, excipients, packaging components, and in-process controls. Captures specification type (release, shelf-life, in-process), test parameter, acceptance criterion (numeric limit or qualitative), analytical method reference, pharmacopoeial standard (USP, EP, JP), specification version, effective date, and regulatory approval status. Sourced from SAP QM and LIMS.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` (
    `supplier_qualification_id` BIGINT COMMENT 'Unique identifier for the supplier qualification record. Primary key for this entity.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to quality.audit. Business justification: Supplier qualification records track the most recent audit performed on the supplier. This FK links to the specific audit record. Business case: supplier qualification status depends on audit outcomes',
    `drug_master_file_id` BIGINT COMMENT 'Foreign key linking to intellectual.drug_master_file. Business justification: Supplier qualifications verify DMF holder status and Letter of Authorization validity. GMP requirement for pharmaceutical supply chain qualification and regulatory inspection readiness. Ensures DMF cr',
    `drug_substance_id` BIGINT COMMENT 'Foreign key linking to product.drug_substance. Business justification: API suppliers are qualified for specific drug substances. DMF references, GMP audits, and impurity profiles are substance-specific. Essential for API sourcing decisions, supply chain risk management, ',
    `excipient_id` BIGINT COMMENT 'Foreign key linking to product.excipient. Business justification: Supplier qualifications approve specific excipients with defined functional categories and grades. Excipient source changes require supplier requalification and change control. Critical for supply cha',
    `iit_submission_id` BIGINT COMMENT 'Foreign key linking to medical.iit_submission. Business justification: Investigator-initiated trials requiring investigational product supply necessitate supplier qualification when third-party manufacturers or packagers are used for clinical supply. GMP requirement ensu',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Supplier qualification projects (audits, testing, documentation review) require budget allocation and cost tracking. Internal orders capture supplier qualification costs, essential for vendor manageme',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: Supplier qualifications for licensed technology or contract manufacturing under licensing agreements require agreement compliance verification. Ensures licensed manufacturing rights are properly exerc',
    `employee_id` BIGINT COMMENT 'Reference to the user who initiated the supplier qualification record. Typically a Quality Assurance (QA) specialist, procurement specialist, or supplier quality engineer.',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to supply.service_agreement. Business justification: Supplier qualification status gates supply agreement execution and renewal. Qualified suppliers must have approved agreements defining quality requirements. Critical for supplier lifecycle management ',
    `site_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_site. Business justification: Supplier qualifications and approved supplier lists are site-specific; each manufacturing site maintains its own qualified supplier base for raw materials, excipients, and services per site-specific q',
    `supplier_quality_agreement_id` BIGINT COMMENT 'Reference to the formal quality agreement document that defines Good Manufacturing Practice (GMP) responsibilities, quality standards, and regulatory obligations between the pharmaceutical company and the supplier.',
    `third_party_due_diligence_id` BIGINT COMMENT 'Foreign key linking to compliance.third_party_due_diligence. Business justification: Supplier qualification (GMP, quality agreements) must be coordinated with compliance due diligence (sanctions screening, debarment checks, ABAC). Pharmaceutical supply chain management requires single',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier entity in the master data domain. Links to the approved supplier, Contract Manufacturing Organization (CMO), Contract Development and Manufacturing Organization (CDMO), or Contract Research Organization (CRO).',
    `approval_workflow_status` STRING COMMENT 'Current status of the supplier qualification approval workflow. Draft indicates initial creation; pending review indicates awaiting Quality Assurance (QA) review; QA review indicates under active review; QA approved indicates final approval granted; rejected indicates qualification denied.. Valid values are `draft|pending_review|qa_review|qa_approved|rejected`',
    `approved_material_scope` STRING COMMENT 'Detailed description of the materials, drug substances, drug products, or components that the supplier is qualified to provide. Includes specific material codes, grades, and specifications covered under this qualification.',
    `approved_service_scope` STRING COMMENT 'Detailed description of the services that the supplier is qualified to perform. Includes manufacturing operations, testing services, validation activities, clinical trial services, or other contracted services covered under this qualification.',
    `audit_frequency_months` STRING COMMENT 'Frequency in months at which the supplier site must be audited. Determined by risk tier and regulatory requirements. Critical suppliers may require annual audits; low-risk suppliers may be audited every 3-5 years.',
    `capa_count_last_12_months` STRING COMMENT 'Number of Corrective and Preventive Action (CAPA) records initiated for the supplier in the last 12 months. Indicates frequency of quality issues requiring formal corrective action.',
    `comments` STRING COMMENT 'Free-text field for additional comments, notes, or observations related to the supplier qualification. May include audit findings summary, conditional approval terms, or special handling instructions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supplier qualification record was first created in the Quality Management System (QMS). Audit trail field for data lineage and compliance.',
    `deviation_count_last_12_months` STRING COMMENT 'Number of quality deviations reported by or attributed to the supplier in the last 12 months. Used as a key performance indicator for supplier quality oversight.',
    `gmp_compliance_status` STRING COMMENT 'Assessment of the suppliers compliance with current Good Manufacturing Practice (cGMP) regulations. Compliant indicates full adherence to GMP requirements; non-compliant indicates deficiencies identified; conditional indicates compliance with minor observations; under review indicates ongoing assessment.. Valid values are `compliant|non_compliant|conditional|under_review`',
    `gmp_responsibility_matrix` STRING COMMENT 'Detailed allocation of Good Manufacturing Practice (GMP) responsibilities between the pharmaceutical company and the supplier. Defines who is responsible for manufacturing, testing, release, stability, change control, deviation management, Corrective and Preventive Action (CAPA), and regulatory reporting.',
    `initiated_date` DATE COMMENT 'Date on which the supplier qualification process was initiated. Marks the start of the qualification lifecycle.',
    `last_audit_date` DATE COMMENT 'Date of the most recent on-site or remote audit conducted at the supplier facility. Used to track audit schedule compliance and determine next audit due date.',
    `last_audit_outcome` STRING COMMENT 'Result of the most recent supplier audit. Approved indicates no significant findings; approved with observations indicates minor findings that do not impact qualification; conditional indicates findings requiring Corrective and Preventive Action (CAPA) before full approval; failed indicates critical findings resulting in disqualification.. Valid values are `approved|approved_with_observations|conditional|failed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this supplier qualification record was last modified in the Quality Management System (QMS). Audit trail field for data lineage and compliance.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next supplier audit. Calculated based on audit frequency and last audit date.',
    `next_requalification_due_date` DATE COMMENT 'Scheduled date for the next supplier re-qualification activity. Calculated based on re-qualification frequency and last qualification date.',
    `oos_count_last_12_months` STRING COMMENT 'Number of Out of Specification (OOS) results reported for materials or services provided by the supplier in the last 12 months. Critical quality metric for supplier performance.',
    `performance_score` DECIMAL(18,2) COMMENT 'Quantitative performance rating of the supplier based on quality metrics including on-time delivery, Certificate of Analysis (CoA) accuracy, deviation rate, Out of Specification (OOS) incidents, and Corrective and Preventive Action (CAPA) closure timeliness. Typically scored on a scale of 0-100.',
    `qa_review_date` DATE COMMENT 'Date on which the Quality Assurance (QA) review was completed and the supplier qualification was approved or rejected.',
    `qualification_effective_date` DATE COMMENT 'Date on which the supplier qualification became effective and the supplier was approved for use under Good Manufacturing Practice (GMP) operations.',
    `qualification_expiry_date` DATE COMMENT 'Date on which the supplier qualification expires and re-qualification is required. Nullable for suppliers with ongoing qualification subject to periodic review.',
    `qualification_number` STRING COMMENT 'Business identifier for the supplier qualification record. Externally-known unique number assigned by the Quality Management System (QMS) for tracking and audit purposes.',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the supplier qualification. Approved indicates full qualification; conditional indicates limited approval with restrictions; disqualified indicates supplier is not approved for use; pending indicates qualification in progress; suspended indicates temporary hold; expired indicates qualification period has lapsed.. Valid values are `approved|conditional|disqualified|pending|suspended|expired`',
    `qualification_type` STRING COMMENT 'Method used to qualify the supplier. Audit-based indicates on-site or remote audit conducted; questionnaire indicates self-assessment questionnaire; Certificate of Analysis (CoA) review indicates qualification based on CoA evaluation; hybrid indicates combination of methods; risk-based indicates qualification approach scaled to supplier risk tier.. Valid values are `audit_based|questionnaire|coa_review|hybrid|risk_based`',
    `quality_agreement_type` STRING COMMENT 'Classification of the quality agreement. Master indicates overarching agreement covering multiple products or services; product-specific indicates agreement for a single drug product or drug substance; service-specific indicates agreement for defined services; site-specific indicates agreement tied to a particular manufacturing or testing site.. Valid values are `master|product_specific|service_specific|site_specific`',
    `regulatory_inspection_authority` STRING COMMENT 'Name of the regulatory authority that conducted the most recent inspection. Examples include U.S. Food and Drug Administration (FDA), European Medicines Agency (EMA), Medicines and Healthcare products Regulatory Agency (MHRA), Pharmaceuticals and Medical Devices Agency (PMDA).',
    `regulatory_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection conducted by U.S. Food and Drug Administration (FDA), European Medicines Agency (EMA), or other regulatory authority at the supplier facility.',
    `regulatory_inspection_status` STRING COMMENT 'Most recent regulatory inspection classification for the supplier facility. No Action Indicated (NAI) indicates no objectionable conditions; Voluntary Action Indicated (VAI) indicates objectionable conditions that do not meet threshold for regulatory action; Official Action Indicated (OAI) indicates objectionable conditions warranting regulatory action; not inspected indicates no recent regulatory inspection on record.. Valid values are `no_action_indicated|voluntary_action_indicated|official_action_indicated|not_inspected`',
    `regulatory_market_coverage` STRING COMMENT 'List of regulatory markets and jurisdictions for which the supplier is qualified to provide materials or services. Includes U.S. Food and Drug Administration (FDA), European Medicines Agency (EMA), Pharmaceuticals and Medical Devices Agency (PMDA), and other regulatory authorities. Pipe-separated list of market codes.',
    `requalification_frequency_months` STRING COMMENT 'Frequency in months at which the supplier must be re-qualified. Typical values are 12, 24, or 36 months depending on supplier risk tier and regulatory requirements.',
    `risk_tier` STRING COMMENT 'Risk classification of the supplier based on the criticality of materials or services provided, regulatory impact, and supplier performance history. Critical indicates highest risk requiring stringent oversight; high indicates significant risk; medium indicates moderate risk; low indicates minimal risk.. Valid values are `critical|high|medium|low`',
    `source_system` STRING COMMENT 'Operational system of record from which this supplier qualification record originated. Typically MasterControl, TrackWise, or Veeva Vault QualityDocs.. Valid values are `mastercontrol|trackwise|veeva_vault_qualitydocs`',
    `supplier_type` STRING COMMENT 'Classification of the supplier based on the materials or services provided. Contract Manufacturing Organization (CMO) manufactures drug product; Contract Development and Manufacturing Organization (CDMO) provides development and manufacturing; Contract Research Organization (CRO) conducts research and clinical trials; Active Pharmaceutical Ingredient (API) supplier provides drug substance; excipient supplier provides inactive ingredients; packaging supplier provides primary or secondary packaging materials; equipment supplier provides manufacturing equipment; service provider offers validation, testing, or consulting services. [ENUM-REF-CANDIDATE: cmo|cdmo|cro|api_supplier|excipient_supplier|packaging_supplier|equipment_supplier|service_provider — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_supplier_qualification PRIMARY KEY(`supplier_qualification_id`)
) COMMENT 'Quality qualification, agreement, and ongoing oversight records for approved suppliers, CMOs, CDMOs, and CROs providing materials or services under GMP. Captures supplier qualification status (approved/conditional/disqualified), qualification type (audit-based, questionnaire, CoA review), approved material/service scope, quality agreement details (GMP responsibilities matrix, regulatory market coverage, agreement type, effective/expiry dates, review cycle, counterparty obligations), re-qualification schedule, risk tier classification, performance metrics, and approval workflow. Serves as the single quality record for supplier relationships — distinct from procurement vendor master. Sourced from MasterControl/TrackWise and Veeva Vault QualityDocs.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` (
    `product_quality_review_id` BIGINT COMMENT 'Unique identifier for the annual product quality review record. Primary key for the product quality review entity.',
    `access_strategy_id` BIGINT COMMENT 'Foreign key linking to market.access_strategy. Business justification: Annual Product Quality Reviews inform market access strategy updates when quality trends affect value propositions, HTA evidence packages, or payer negotiations. Batch rejection rates, complaint trend',
    `demand_plan_id` BIGINT COMMENT 'Foreign key linking to supply.demand_plan. Business justification: PQR quality trends (batch rejection rates, stability failures, complaint rates) inform demand forecast adjustments and supply planning. Quality performance impacts production capacity assumptions. Ess',
    `drug_product_id` BIGINT COMMENT 'Reference to the marketed drug product that is the subject of this quality review. Links to the master product entity.',
    `formulation_id` BIGINT COMMENT 'Foreign key linking to product.formulation. Business justification: Annual Product Quality Reviews assess formulation performance across batches. Process capability (Cpk), specification trends, and OOS/OOT patterns are formulation-specific. Required by ICH Q10 and FDA',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Annual Product Quality Reviews identify improvement initiatives requiring budget allocation. Internal orders track PQR-driven improvement project costs, essential for continuous improvement financial ',
    `master_batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.master_batch_record. Business justification: Annual Product Quality Reviews analyze all batches manufactured under a specific MBR version; process capability assessment, revalidation triggers, continuous improvement initiatives, and regulatory c',
    `employee_id` BIGINT COMMENT 'Reference to the quality professional responsible for coordinating and authoring the product quality review. Typically a Quality Assurance manager or site quality head.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Annual Product Quality Reviews are GxP regulatory commitments (ICH Q10, EU GMP Chapter 1) tied to compliance programs. Pharmaceutical quality management requires linking PQR findings and action items ',
    `qms_document_id` BIGINT COMMENT 'Document control number or reference in the quality management system (e.g., MasterControl, TrackWise, Veeva QualityDocs) where the full product quality review report is stored.',
    `safety_signal_id` BIGINT COMMENT 'Foreign key linking to pharmacovigilance.safety_signal. Business justification: Annual Product Quality Reviews (APQRs) must integrate safety signal data per ICH Q10 and regulatory expectations. Business process: quality reviewers assess whether manufacturing deviations, OOS event',
    `site_id` BIGINT COMMENT 'Reference to the primary manufacturing site responsible for producing this product during the review period. Links to facility master data.',
    `tertiary_product_management_reviewer_employee_id` BIGINT COMMENT 'Reference to the senior management representative who reviewed the product quality review as part of management review process per ICH Q10.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Annual Product Quality Reviews assess vendor material quality impact on product quality per ICH Q7. Vendor performance is a required PQR element for GMP compliance.',
    `previous_product_quality_review_id` BIGINT COMMENT 'Self-referencing FK on product_quality_review (previous_product_quality_review_id)',
    `action_items` STRING COMMENT 'List of approved action items and improvement initiatives resulting from the product quality review. May include process improvements, investigations, revalidations, or specification updates.',
    `approval_date` DATE COMMENT 'Date when the product quality review was formally approved and finalized. Represents completion of all review and approval workflows.',
    `batch_rejection_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of batches rejected relative to total batches manufactured during the review period. Critical quality performance indicator for process capability assessment.',
    `capa_count` STRING COMMENT 'Total number of CAPA records initiated for this product during the review period. Indicates the volume of quality improvement activities.',
    `change_control_count` STRING COMMENT 'Total number of change control records implemented for this product during the review period. Tracks the volume of process, equipment, or specification changes.',
    `complaint_count` STRING COMMENT 'Total number of product quality complaints received during the review period from customers, patients, or healthcare providers.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this product quality review record was first created in the source system. Part of audit trail for data lineage and compliance.',
    `critical_deviation_count` STRING COMMENT 'Number of critical or major deviations that had significant impact on product quality or GMP compliance. Subset of total deviation count requiring heightened management attention.',
    `deviation_count` STRING COMMENT 'Total number of quality deviations recorded during the review period for this product. Includes GMP deviations, process deviations, and equipment deviations.',
    `dosage_form` STRING COMMENT 'Physical form of the finished drug product (e.g., tablet, capsule, injectable solution, lyophilized powder). Critical for quality assessment as different dosage forms have distinct quality attributes.',
    `due_date` DATE COMMENT 'Target completion date for the product quality review. Typically set based on regulatory requirements (e.g., within 90 days of review period end) or internal quality system procedures.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this product quality review record was last updated in the source system. Tracks data currency and change history for audit purposes.',
    `management_review_date` DATE COMMENT 'Date when senior management completed their review of the product quality review and approved action items and improvement initiatives.',
    `management_reviewer_name` STRING COMMENT 'Full name of the senior management representative who conducted management review. Typically site head, quality head, or operations director.',
    `oos_count` STRING COMMENT 'Total number of out-of-specification test results recorded during the review period. OOS results trigger formal investigations per FDA guidance.',
    `oot_count` STRING COMMENT 'Total number of out-of-trend analytical results identified during the review period. OOT results indicate potential process drift requiring investigation.',
    `open_capa_count` STRING COMMENT 'Number of CAPA records that remain open at the end of the review period. High open CAPA counts may indicate resource constraints or systemic issues.',
    `process_capability_cpk` DECIMAL(18,2) COMMENT 'Process capability index (Cpk) for critical quality attributes during the review period. Cpk >= 1.33 indicates acceptable process capability; Cpk >= 1.67 indicates robust process.',
    `qa_review_date` DATE COMMENT 'Date when the quality assurance reviewer completed their review and approved the product quality review document.',
    `qa_reviewer_name` STRING COMMENT 'Full name of the senior quality assurance reviewer. Denormalized for reporting and signature documentation.',
    `recall_count` STRING COMMENT 'Number of product recalls initiated during the review period. Includes voluntary and regulatory-mandated recalls at all classification levels.',
    `regulatory_authority` STRING COMMENT 'Primary regulatory authority or health agency to which this product quality review may be submitted or referenced (e.g., FDA, EMA, MHRA, PMDA). Relevant for products with regulatory commitments.',
    `regulatory_commitment_flag` BOOLEAN COMMENT 'Indicates whether this product quality review fulfills a specific regulatory commitment made to FDA, EMA, or other regulatory authority in an approval letter or post-approval change.',
    `revalidation_justification` STRING COMMENT 'Business justification and rationale for revalidation requirement or decision to defer revalidation. Documents risk assessment and decision-making process.',
    `revalidation_required_flag` BOOLEAN COMMENT 'Indicates whether process revalidation or requalification is required based on review findings. True if quality trends, changes, or deviations necessitate revalidation.',
    `review_conclusion` STRING COMMENT 'Executive summary and overall conclusion of the product quality review. Synthesizes key findings, trends, and quality performance assessment for management decision-making.',
    `review_number` STRING COMMENT 'Unique business identifier for the annual product quality review, typically following a standardized numbering convention including year and product code.. Valid values are `^PQR-[0-9]{4}-[A-Z0-9]{6,12}$`',
    `review_owner_name` STRING COMMENT 'Full name of the quality professional responsible for the product quality review. Denormalized for reporting and audit trail purposes.',
    `review_period_end_date` DATE COMMENT 'End date of the time period covered by this product quality review. Defines the boundary for data aggregation and trend analysis.',
    `review_period_start_date` DATE COMMENT 'Start date of the time period covered by this product quality review. Typically the beginning of the calendar or fiscal year for annual reviews.',
    `review_status` STRING COMMENT 'Current lifecycle status of the product quality review in the approval workflow. Tracks progression from draft through quality assurance review, management review, approval, and closure.. Valid values are `draft|under_review|qa_review|management_review|approved|closed`',
    `review_type` STRING COMMENT 'Classification of the product quality review type. Annual reviews are standard ICH Q10 requirement; interim reviews may be triggered by significant events; ad-hoc reviews address specific quality concerns.. Valid values are `annual|interim|ad_hoc|regulatory_commitment|post_approval`',
    `source_system` STRING COMMENT 'Name of the operational system from which this product quality review record originated (e.g., MasterControl, TrackWise, SAP QM, Veeva Vault QualityDocs).',
    `stability_failure_count` STRING COMMENT 'Number of stability failures or out-of-specification stability results observed during the review period. Critical indicator of product shelf-life integrity.',
    `stability_study_count` STRING COMMENT 'Number of ongoing stability studies for this product during the review period. Includes registration, commercial, and supporting stability protocols.',
    `strength` STRING COMMENT 'Strength or potency of the active pharmaceutical ingredient (API) in the finished dosage form, including unit of measure (e.g., 50mg, 100mg/mL).',
    `total_batches_manufactured` STRING COMMENT 'Total number of commercial batches manufactured during the review period. Provides denominator for calculating batch-level quality metrics and failure rates.',
    `total_batches_rejected` STRING COMMENT 'Total number of batches rejected during the review period due to quality failures, out-of-specification results, or GMP deviations. Key indicator of manufacturing process capability.',
    `total_batches_released` STRING COMMENT 'Total number of batches released for distribution during the review period. Indicates successful completion of quality control testing and Quality Person (QP) certification.',
    CONSTRAINT pk_product_quality_review PRIMARY KEY(`product_quality_review_id`)
) COMMENT 'Annual Product Quality Review (APQR) / Product Quality Review (PQR) records aggregating quality performance data for each marketed product on an annual cycle as required by ICH Q10, EU GMP Chapter 1, and 21 CFR 211.180(e). Captures review period, product scope, batch analysis summary, deviation/CAPA/OOS trends, stability trending, change control summary, complaint trends, recall history, process capability metrics, revalidation needs, management review conclusions, and approved action items. Serves as the primary input to management review and continual improvement decisions.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` (
    `audit_site_inspection_id` BIGINT COMMENT 'Primary key for the audit_site_inspection association',
    `audit_id` BIGINT COMMENT 'Foreign key linking to the audit record that encompasses this site inspection',
    `quality_capa_id` BIGINT COMMENT 'Foreign key reference to the CAPA record specific to this vendor site inspection',
    `vendor_site_id` BIGINT COMMENT 'Foreign key linking to the specific vendor site being audited',
    `audit_frequency_months` STRING COMMENT 'Required frequency of quality audits for the vendor site, expressed in months. [Moved from vendor_site: While this could remain in vendor_site as a policy attribute, the actual next audit due date is determined by each audit outcome and belongs in the association. Consider whether this is a policy (stays in vendor_site) or an outcome (moves to association).]',
    `auditor_assigned` STRING COMMENT 'Lead auditor or audit team members assigned to this specific vendor site inspection',
    `inspection_date` DATE COMMENT 'Date when this specific vendor site was inspected as part of the audit program. Corresponds to audit_date from detection data.',
    `last_audit_date` DATE COMMENT 'Date of the most recent quality or GMP audit conducted at the vendor site. [Moved from vendor_site: This attribute represents the most recent audit date for the vendor site, which is derivable from the audit_site_inspection association by querying MAX(inspection_date) for the vendor_site_id. It should not be stored redundantly in vendor_site.]',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next quality or GMP audit at the vendor site. [Moved from vendor_site: This attribute is specific to each audit-site relationship and varies based on the outcome of each inspection. It belongs in the association as next_site_audit_due_date, not as a single value in vendor_site.]',
    `next_site_audit_due_date` DATE COMMENT 'Scheduled date for the next audit of this vendor site based on risk assessment and audit outcome. Corresponds to next_audit_due_date from detection data.',
    `site_audit_outcome` STRING COMMENT 'Summary conclusion of the audit for this specific vendor site. Corresponds to audit_outcome from detection data.',
    `site_audit_scope` STRING COMMENT 'Specific scope of audit activities conducted at this vendor site, including functional areas, processes, and systems reviewed. Corresponds to audit_scope from detection data.',
    `site_capa_required` BOOLEAN COMMENT 'Indicates whether formal Corrective and Preventive Action is required for findings at this vendor site. Corresponds to capa_required from detection data.',
    `site_critical_findings` STRING COMMENT 'Number of critical findings identified at this vendor site',
    `site_facility_audited` STRING COMMENT 'Name and location of the site, facility, manufacturing plant, warehouse, or supplier location that is the subject of the audit. May include facility code or site identifier. [Moved from audit: This attribute describes the specific site being audited and should be replaced by the FK relationship to vendor_site. The vendor_site product already contains site_name and location details.]',
    `site_findings_count` STRING COMMENT 'Total number of findings identified at this specific vendor site during the audit. Corresponds to findings_count from detection data.',
    `site_major_findings` STRING COMMENT 'Number of major findings identified at this vendor site',
    `site_minor_findings` STRING COMMENT 'Number of minor findings identified at this vendor site',
    `site_qualification_impact` STRING COMMENT 'Impact of the audit outcome on the vendor sites qualification status for supplying materials or services',
    `site_response_due_date` DATE COMMENT 'Date by which the vendor site must submit formal responses to audit findings',
    `site_response_submitted_date` DATE COMMENT 'Actual date when the vendor site submitted formal responses to audit findings',
    CONSTRAINT pk_audit_site_inspection PRIMARY KEY(`audit_site_inspection_id`)
) COMMENT 'This association product represents the inspection event between audit and vendor_site. It captures the specific audit activities conducted at each vendor site, including audit outcomes, findings classification, CAPA requirements, and follow-up schedules. Each record links one audit to one vendor site with attributes that exist only in the context of this specific site inspection within a broader audit program.. Existence Justification: In pharmaceutical supplier quality management, a single audit program can encompass multiple vendor sites (e.g., a CMO with manufacturing facilities in three countries), and each vendor site undergoes multiple audits over time (initial qualification, annual surveillance, for-cause investigations, pre-approval inspections). The business actively manages each audit-site inspection as a distinct quality event with its own findings, CAPA requirements, and follow-up schedules.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`root_cause_analysis` (
    `root_cause_analysis_id` BIGINT COMMENT 'Primary key for root_cause_analysis',
    `approver_employee_id` BIGINT COMMENT 'Reference to the employee who approved the root cause analysis findings and recommendations.',
    `quality_capa_id` BIGINT COMMENT 'Reference to the CAPA record initiated as a result of this root cause analysis.',
    `employee_id` BIGINT COMMENT 'Reference to the employee responsible for leading the root cause analysis investigation.',
    `investigation_id` BIGINT COMMENT 'Reference to the parent investigation (deviation, OOS, OOT, CAPA) that triggered this root cause analysis.',
    `oos_investigation_id` BIGINT COMMENT 'Foreign key linking to quality.oos_investigation. Business justification: Root cause analysis is performed as part of OOS (Out-of-Specification) investigations. Currently root_cause_analysis has investigation_id (generic BIGINT). Renaming/clarifying this to oos_investigatio',
    `drug_product_id` BIGINT COMMENT 'Reference to the pharmaceutical product affected by the issue under investigation, if applicable.',
    `quality_deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: Root cause analysis can be performed directly on quality deviations (in addition to OOS investigations). One RCA analyzes one deviation (1:N relationship). This FK enables direct linkage between RCA a',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing site or facility where the problem occurred and the root cause analysis was conducted.',
    `parent_root_cause_analysis_id` BIGINT COMMENT 'Self-referencing FK on root_cause_analysis (parent_root_cause_analysis_id)',
    `actual_completion_date` DATE COMMENT 'Date when the root cause analysis was actually completed and findings documented.',
    `analysis_methodology_details` STRING COMMENT 'Detailed description of how the selected root cause analysis methodology was applied, including tools, techniques, and steps followed.',
    `analysis_type` STRING COMMENT 'The methodology or technique used to conduct the root cause analysis (e.g., Fishbone/Ishikawa, 5 Whys, Fault Tree Analysis, Pareto Analysis, Failure Mode and Effects Analysis).',
    `approval_date` DATE COMMENT 'Date when the root cause analysis report was formally approved by Quality Assurance or designated authority.',
    `batch_number` STRING COMMENT 'Specific batch or lot number of the product affected by the issue, if the root cause analysis is batch-specific.',
    `closure_date` DATE COMMENT 'Date when the root cause analysis was formally closed after all corrective and preventive actions were completed and verified.',
    `contributing_factors` STRING COMMENT 'Additional factors or conditions that contributed to the problem but were not the primary root cause.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective actions are required based on the root cause analysis findings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the root cause analysis record was first created in the system.',
    `effectiveness_check_date` DATE COMMENT 'Scheduled or actual date when the effectiveness of corrective and preventive actions was verified.',
    `effectiveness_check_required` BOOLEAN COMMENT 'Indicates whether an effectiveness check is required to verify that implemented corrective and preventive actions successfully addressed the root cause.',
    `evidence_collected` STRING COMMENT 'Summary of the evidence, data, and documentation collected during the investigation to support the root cause determination.',
    `immediate_cause` STRING COMMENT 'The direct or proximate cause that led to the problem or deviation, identified during the investigation.',
    `impact_assessment` STRING COMMENT 'Assessment of the potential or actual impact of the root cause on product quality, patient safety, regulatory compliance, and business operations.',
    `initiated_date` DATE COMMENT 'Date when the root cause analysis was formally initiated.',
    `investigation_team` STRING COMMENT 'Comma-separated list or description of the cross-functional team members involved in the root cause analysis (e.g., Quality, Manufacturing, Engineering, Regulatory).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the root cause analysis record was last updated or modified.',
    `lessons_learned` STRING COMMENT 'Key insights, best practices, and lessons learned from the root cause analysis that can be applied to prevent similar issues in the future.',
    `preventive_action_required` BOOLEAN COMMENT 'Indicates whether preventive actions are required to prevent recurrence of similar issues in other areas or processes.',
    `problem_statement` STRING COMMENT 'Clear and concise description of the problem or deviation being investigated, defining the scope of the root cause analysis.',
    `process_step` STRING COMMENT 'Specific manufacturing or quality process step where the problem occurred (e.g., blending, compression, filling, testing).',
    `qms_system_reference` STRING COMMENT 'Reference identifier or link to the record in the external QMS system (e.g., MasterControl, TrackWise) where the full root cause analysis documentation is maintained.',
    `rca_number` STRING COMMENT 'Business identifier for the root cause analysis, typically system-generated and externally referenced in quality documentation.',
    `regulatory_report_date` DATE COMMENT 'Date when the root cause analysis findings were reported to regulatory authorities, if applicable.',
    `regulatory_reportable` BOOLEAN COMMENT 'Indicates whether the findings of the root cause analysis require reporting to regulatory authorities (e.g., FDA, EMA).',
    `risk_assessment_performed` BOOLEAN COMMENT 'Indicates whether a formal risk assessment was conducted as part of the root cause analysis to evaluate impact and likelihood.',
    `risk_level` STRING COMMENT 'Overall risk level assigned based on the severity and likelihood of the identified root cause, used to prioritize corrective actions.',
    `root_cause` STRING COMMENT 'The fundamental underlying cause(s) identified through systematic analysis that, if corrected, will prevent recurrence of the problem.',
    `root_cause_category` STRING COMMENT 'High-level classification of the root cause (e.g., human error, equipment failure, material defect, process design flaw, environmental factor, procedural inadequacy).',
    `root_cause_analysis_status` STRING COMMENT 'Current lifecycle status of the root cause analysis investigation.',
    `target_completion_date` DATE COMMENT 'Planned date by which the root cause analysis should be completed, typically driven by regulatory timelines or internal quality SLAs.',
    CONSTRAINT pk_root_cause_analysis PRIMARY KEY(`root_cause_analysis_id`)
) COMMENT 'Master reference table for root_cause_analysis. Referenced by root_cause_analysis_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`qms_document` (
    `qms_document_id` BIGINT COMMENT 'Primary key for qms_document',
    `superseded_qms_document_id` BIGINT COMMENT 'Self-referencing FK on qms_document (superseded_qms_document_id)',
    `approval_date` DATE COMMENT 'Date when the document received final approval from the designated approver.',
    `approver_name` STRING COMMENT 'Full name of the individual who provided final approval for the document.',
    `archive_date` DATE COMMENT 'Date when the document was moved to archive status. Nullable if document is still active.',
    `author_name` STRING COMMENT 'Full name of the individual who authored or created the document.',
    `confidentiality_level` STRING COMMENT 'Data classification level indicating the sensitivity and access restrictions for the document: Public, Internal, Confidential, or Restricted.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the document record was first created in the system.',
    `department` STRING COMMENT 'Department or functional area responsible for the document (e.g., Quality Control, Quality Assurance, Manufacturing, Regulatory Affairs).',
    `qms_document_description` STRING COMMENT 'Detailed description of the document purpose, scope, and content.',
    `distribution_list` STRING COMMENT 'Comma-separated list of departments, roles, or individuals who should receive or have access to this document.',
    `document_category` STRING COMMENT 'Functional category of the QMS document within the quality management system (e.g., Quality Control, Quality Assurance, Manufacturing, Validation, CAPA, Deviation, Change Control, Training).',
    `document_number` STRING COMMENT 'Externally-known unique control number assigned to the QMS document following organizational numbering convention (e.g., SOP-001234, WI-005678).',
    `document_type` STRING COMMENT 'Classification of the QMS document type: Standard Operating Procedure (SOP), Work Instruction (WI), Form, Protocol, Report, Policy, Procedure, Specification, Plan, or Manual.',
    `effective_date` DATE COMMENT 'Date when the document becomes effective and enforceable within the organization.',
    `electronic_signature_required_flag` BOOLEAN COMMENT 'Indicates whether electronic signatures are required for approval and execution of this document per 21 CFR Part 11 (True) or not (False).',
    `expiration_date` DATE COMMENT 'Date when the document expires and must be reviewed or retired. Nullable for documents without scheduled expiration.',
    `file_format` STRING COMMENT 'Electronic file format of the document (e.g., PDF, DOCX, XLSX, HTML, XML).',
    `file_size_kb` DECIMAL(18,2) COMMENT 'Size of the document file in kilobytes.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or tags for document search and categorization.',
    `language` STRING COMMENT 'Primary language in which the document is written, using 3-letter ISO 639-2 language codes (e.g., ENG for English, SPA for Spanish).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the document record was last modified or updated.',
    `last_reviewed_date` DATE COMMENT 'Date when the document was last reviewed for accuracy and relevance.',
    `owner_name` STRING COMMENT 'Full name of the individual responsible for maintaining and updating the document.',
    `page_count` STRING COMMENT 'Total number of pages in the document.',
    `regulatory_classification` STRING COMMENT 'Regulatory framework under which the document is controlled: Good Manufacturing Practice (GMP), Good Laboratory Practice (GLP), Good Clinical Practice (GCP), Good Distribution Practice (GDP), or Non-Regulated.',
    `related_change_control_number` STRING COMMENT 'Change control identifier associated with the creation or revision of this document. Nullable if no formal change control was required.',
    `retention_period_years` STRING COMMENT 'Number of years the document must be retained per regulatory and organizational requirements.',
    `review_due_date` DATE COMMENT 'Scheduled date by which the document must undergo periodic review to ensure continued relevance and accuracy.',
    `reviewer_name` STRING COMMENT 'Full name of the individual who performed the most recent review of the document.',
    `revision_number` STRING COMMENT 'Sequential revision count indicating the number of times the document has been revised.',
    `scope` STRING COMMENT 'Defined scope of applicability for the document, including processes, products, or areas covered.',
    `site_location` STRING COMMENT 'Manufacturing site or facility location where the document is applicable.',
    `qms_document_status` STRING COMMENT 'Current lifecycle status of the QMS document: Draft (under creation), In Review (under approval workflow), Approved (approved but not yet effective), Effective (active and in use), Obsolete (no longer valid), Retired (archived), or Superseded (replaced by newer version).',
    `storage_location` STRING COMMENT 'Physical or electronic location where the document is stored (e.g., document management system path, server location, or physical archive location).',
    `superseded_document_number` STRING COMMENT 'Document control number of the previous version that this document replaces. Nullable if this is the first version.',
    `title` STRING COMMENT 'Full descriptive title of the QMS document.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether personnel must complete training on this document before performing related activities (True) or not (False).',
    `version_number` STRING COMMENT 'Current version number of the document following organizational versioning scheme (e.g., 1.0, 2.1, 15.0).',
    CONSTRAINT pk_qms_document PRIMARY KEY(`qms_document_id`)
) COMMENT 'Master reference table for qms_document. Referenced by qms_document_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`sample` (
    `sample_id` BIGINT COMMENT 'Primary key for sample',
    `approved_by_user_employee_id` BIGINT COMMENT 'Reference to the qualified person who approved the sample testing results. Must have appropriate training and authority per Good Manufacturing Practice (GMP) requirements.',
    `batch_record_id` BIGINT COMMENT 'Reference to the manufacturing batch or lot from which this sample was drawn. Links sample to production batch for traceability and Certificate of Analysis (CoA) generation.',
    `created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created this sample record in the system. Required for audit trail and accountability under Good Documentation Practice (GDP).',
    `quality_deviation_id` BIGINT COMMENT 'Reference to a quality deviation record if this sample is associated with a deviation investigation (e.g., Out of Specification result, sampling procedure deviation). Links sample to Corrective and Preventive Action (CAPA) system.',
    `employee_id` BIGINT COMMENT 'Reference to the qualified personnel who physically collected the sample. Required for Good Manufacturing Practice (GMP) traceability and accountability.',
    `material_id` BIGINT COMMENT 'Reference to the raw material, active pharmaceutical ingredient (API), or excipient being sampled. Used for raw material qualification and supplier quality management.',
    `modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this sample record. Required for audit trail and accountability under Good Documentation Practice (GDP).',
    `drug_product_id` BIGINT COMMENT 'Reference to the product or material being sampled. Enables aggregation of sample results by product for trend analysis and Out of Trend (OOT) detection.',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing facility or site where the sample was collected. Enables multi-site quality trending and site-specific compliance reporting.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Samples are tested against specifications. Currently sample has test_specification_id (BIGINT) which should link to specification table. Renaming to specification_id for consistency. One sample is tes',
    `stability_study_id` BIGINT COMMENT 'Reference to the stability study protocol if this sample is part of a formal stability program. Links sample to long-term, accelerated, or stress stability testing programs.',
    `test_specification_id` BIGINT COMMENT 'Reference to the test specification or analytical method that defines the quality control tests to be performed on this sample, including acceptance criteria and test procedures.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the sample testing results were reviewed and approved by qualified personnel. Represents the final disposition decision for the sample and associated batch.',
    `chain_of_custody_verified` BOOLEAN COMMENT 'Indicates whether the chain of custody for the sample has been verified and documented. Critical for regulatory compliance and forensic investigations of Out of Specification (OOS) results.',
    `collection_timestamp` TIMESTAMP COMMENT 'Date and time when the sample was physically collected or drawn from the batch, lot, or source material. This is the principal business event timestamp for the sample lifecycle.',
    `comments` STRING COMMENT 'Free-text field for additional observations, special handling instructions, or contextual information about the sample that may be relevant for testing or investigation.',
    `composite_sample_flag` BOOLEAN COMMENT 'Indicates whether this sample is a composite (pooled from multiple sampling points or containers) or a discrete sample from a single source. Composite sampling is used for homogeneity assessment.',
    `container_type` STRING COMMENT 'Type of container used to store and transport the sample. Must be appropriate for the material type and testing requirements to prevent contamination or degradation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sample record was first created in the system. Part of audit trail for regulatory compliance and data integrity (ALCOA+ principles).',
    `expiration_date` DATE COMMENT 'Date after which the sample is no longer valid for testing due to potential degradation or stability concerns. Calculated based on material stability data and storage conditions.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sample record was last modified. Part of audit trail for regulatory compliance and data integrity (ALCOA+ principles).',
    `priority_level` STRING COMMENT 'Priority classification for sample testing. Urgent and expedited samples receive accelerated testing to support production schedules or regulatory submissions.',
    `registration_timestamp` TIMESTAMP COMMENT 'Date and time when the sample was formally registered in the Laboratory Information Management System (LIMS) or Quality Management System (QMS) and assigned a sample number.',
    `retain_sample_flag` BOOLEAN COMMENT 'Indicates whether this sample must be retained for the regulatory retention period. Retain samples are stored for future investigation of complaints, adverse events, or regulatory inquiries.',
    `retain_until_date` DATE COMMENT 'Date until which the retain sample must be stored. Typically calculated as product expiration date plus one year, or as defined by regulatory requirements.',
    `retest_date` DATE COMMENT 'Date when the sample or associated material must be retested to confirm continued compliance with specifications. Applicable to raw materials and reference standards with limited shelf life.',
    `sample_number` STRING COMMENT 'Externally-known unique business identifier for the sample, typically assigned by Laboratory Information Management System (LIMS) or Quality Management System (QMS). Used for tracking and referencing across quality documentation.',
    `sample_quantity` DECIMAL(18,2) COMMENT 'Numeric quantity of material collected for the sample. Used to ensure sufficient sample volume for all required tests and potential retests.',
    `sample_quantity_unit` STRING COMMENT 'Unit of measure for the sample quantity (grams, kilograms, milligrams, milliliters, liters, units, tablets, vials). Must align with product specification units.',
    `sample_status` STRING COMMENT 'Current lifecycle status of the sample in the quality testing workflow. Tracks progression from collection through testing to final disposition decision.',
    `sample_type` STRING COMMENT 'Classification of the sample based on its purpose and stage in the manufacturing lifecycle. Raw material samples are tested upon receipt, in-process samples during manufacturing, finished product samples before release, stability samples for shelf-life studies, reference standards for calibration, and retain samples for future investigation.',
    `sampling_location` STRING COMMENT 'Physical location or equipment identifier where the sample was collected (e.g., reactor vessel, blending tank, packaging line, warehouse zone). Critical for environmental monitoring and contamination investigation.',
    `stability_timepoint` STRING COMMENT 'Timepoint designation within the stability study protocol (e.g., T0, 3M, 6M, 12M, 24M) indicating when this sample was pulled for testing. Used to track product degradation over time.',
    `storage_condition` STRING COMMENT 'Required storage condition for the sample to maintain integrity until testing is complete. Critical for stability samples and temperature-sensitive materials.',
    `storage_location` STRING COMMENT 'Physical location where the sample is stored (e.g., laboratory refrigerator ID, stability chamber number, quarantine area). Enables sample retrieval and chain of custody tracking.',
    CONSTRAINT pk_sample PRIMARY KEY(`sample_id`)
) COMMENT 'Master reference table for sample. Referenced by sample_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`analytical_method` (
    `analytical_method_id` BIGINT COMMENT 'Primary key for analytical_method',
    `drug_product_id` BIGINT COMMENT 'Reference to the pharmaceutical product for which this method is primarily used. Null if method is applicable across multiple products.',
    `superseded_analytical_method_id` BIGINT COMMENT 'Self-referencing FK on analytical_method (superseded_analytical_method_id)',
    `accuracy_percent` DECIMAL(18,2) COMMENT 'Percent recovery demonstrating the accuracy of the method, typically from validation studies.',
    `analyte` STRING COMMENT 'The specific substance, compound, or parameter being measured or detected by this analytical method.',
    `change_control_number` STRING COMMENT 'Reference to the most recent change control record associated with modifications to this analytical method.',
    `compendial_flag` BOOLEAN COMMENT 'Indicates whether this is a compendial method from an official pharmacopeia (USP, EP, JP) or a proprietary in-house method.',
    `compendial_reference` STRING COMMENT 'Reference to the official pharmacopeia monograph or general chapter if this is a compendial method (e.g., USP <621>, EP 2.2.46).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this analytical method record was first created in the system.',
    `effective_date` DATE COMMENT 'Date from which this analytical method became or will become effective for use in quality control testing.',
    `equipment_required` STRING COMMENT 'List or description of laboratory equipment and instruments required to perform this analytical method.',
    `expiration_date` DATE COMMENT 'Date after which this analytical method is no longer valid for use and must be retired or replaced.',
    `limit_of_detection` DECIMAL(18,2) COMMENT 'Lowest concentration of analyte that can be detected but not necessarily quantified, expressed in the methods unit of measure.',
    `limit_of_quantitation` DECIMAL(18,2) COMMENT 'Lowest concentration of analyte that can be quantitatively determined with suitable precision and accuracy, expressed in the methods unit of measure.',
    `linearity_range_lower` DECIMAL(18,2) COMMENT 'Lower limit of the concentration range over which the method demonstrates linearity.',
    `linearity_range_upper` DECIMAL(18,2) COMMENT 'Upper limit of the concentration range over which the method demonstrates linearity.',
    `matrix` STRING COMMENT 'The type of sample or material to which this method is applied (e.g., tablet, capsule, injectable solution, raw material, bulk drug substance).',
    `method_name` STRING COMMENT 'Descriptive name of the analytical method that clearly identifies its purpose and technique.',
    `method_number` STRING COMMENT 'Unique business identifier for the analytical method, typically following organizational naming conventions (e.g., HPLC-001234, GC-MS-5678).',
    `method_status` STRING COMMENT 'Current lifecycle status of the analytical method indicating its readiness for use in quality control testing.',
    `method_type` STRING COMMENT 'High-level classification of the analytical method based on the primary testing technique employed.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this analytical method record was last modified in the system.',
    `precision_rsd_percent` DECIMAL(18,2) COMMENT 'Relative standard deviation percentage demonstrating the precision of the method, typically from validation studies.',
    `reagent_list` STRING COMMENT 'List of reagents, standards, and consumables required to perform this analytical method.',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Indicates whether this method has been submitted to regulatory authorities as part of a drug application (NDA, ANDA, BLA, MAA).',
    `regulatory_submission_number` STRING COMMENT 'Reference number of the regulatory submission (NDA, ANDA, BLA, MAA) in which this method was included.',
    `revalidation_due_date` DATE COMMENT 'Date by which the method must be revalidated to maintain its validated status, typically based on periodic review cycles.',
    `robustness_verified` BOOLEAN COMMENT 'Indicates whether the method robustness has been evaluated and verified during validation studies.',
    `run_time_minutes` DECIMAL(18,2) COMMENT 'Typical duration in minutes required to complete one analytical run or sample analysis.',
    `sample_preparation_time_minutes` DECIMAL(18,2) COMMENT 'Typical time in minutes required for sample preparation before analysis.',
    `sop_number` STRING COMMENT 'Reference number of the Standard Operating Procedure document that provides detailed instructions for executing this method.',
    `specification_limit_lower` DECIMAL(18,2) COMMENT 'Lower acceptance limit for the test result as defined in the product specification or pharmacopeia monograph.',
    `specification_limit_upper` DECIMAL(18,2) COMMENT 'Upper acceptance limit for the test result as defined in the product specification or pharmacopeia monograph.',
    `stability_indicating` BOOLEAN COMMENT 'Indicates whether the method is stability-indicating, capable of detecting degradation products and changes over time.',
    `technique` STRING COMMENT 'Specific analytical technique or instrument platform used (e.g., HPLC, GC-MS, UV-Vis, FTIR, Karl Fischer, Bioburden).',
    `test_category` STRING COMMENT 'Category of quality control test that this method supports, aligned with regulatory submission requirements.',
    `unit_of_measure` STRING COMMENT 'Unit in which test results are reported (e.g., mg/mL, %, ppm, CFU/g, EU/mL).',
    `validation_date` DATE COMMENT 'Date when the analytical method validation was completed and approved.',
    `validation_protocol_number` STRING COMMENT 'Reference number of the validation protocol document used to validate this analytical method.',
    `validation_report_number` STRING COMMENT 'Reference number of the validation report document that summarizes the validation results for this method.',
    `validation_status` STRING COMMENT 'Status of the method validation process indicating whether the method has been validated per ICH Q2(R1) requirements.',
    CONSTRAINT pk_analytical_method PRIMARY KEY(`analytical_method_id`)
) COMMENT 'Master reference table for analytical_method. Referenced by method_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`quality_event` (
    `quality_event_id` BIGINT COMMENT 'Primary key for quality_event',
    `employee_id` BIGINT COMMENT 'Reference to the employee or quality professional currently assigned to investigate and resolve the quality event.',
    `last_modified_by_employee_id` BIGINT COMMENT 'Reference to the employee who last modified this quality event record.',
    `drug_product_id` BIGINT COMMENT 'Reference to the pharmaceutical product affected by or associated with this quality event.',
    `qa_approved_by_employee_id` BIGINT COMMENT 'Reference to the Quality Assurance professional who approved the quality event closure and corrective actions.',
    `quality_agreement_id` BIGINT COMMENT 'Reference to the quality agreement governing quality responsibilities if the event involves contract manufacturing or third-party suppliers.',
    `reported_by_employee_id` BIGINT COMMENT 'Reference to the employee who reported or initiated the quality event record.',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing facility, laboratory, or site where the quality event occurred.',
    `originating_quality_event_id` BIGINT COMMENT 'Self-referencing FK on quality_event (originating_quality_event_id)',
    `actual_closure_date` DATE COMMENT 'Actual date when the quality event was formally closed after completion of investigation, corrective actions, and quality assurance review.',
    `batch_number` STRING COMMENT 'Manufacturing batch or lot number of the product affected by this quality event. Critical for traceability and potential recall activities.',
    `corrective_action` STRING COMMENT 'Description of corrective actions taken to address the immediate quality event and prevent recurrence.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this quality event record was first created in the system.',
    `customer_complaint_related` BOOLEAN COMMENT 'Indicates whether this quality event is associated with or triggered by a customer complaint.',
    `department` STRING COMMENT 'Specific department or functional unit within the facility where the quality event originated (e.g., Quality Control Lab, Sterile Manufacturing, Packaging).',
    `quality_event_description` STRING COMMENT 'Detailed narrative description of the quality event, including what occurred, when it was discovered, and initial observations. Provides comprehensive context for investigation and resolution.',
    `detected_date` DATE COMMENT 'Date when the quality event was first detected or identified. Critical for timeline analysis and regulatory reporting.',
    `effectiveness_check_date` DATE COMMENT 'Scheduled or completed date for the effectiveness check to verify CAPA implementation success.',
    `effectiveness_check_required` BOOLEAN COMMENT 'Indicates whether a follow-up effectiveness check is required to verify that corrective and preventive actions successfully resolved the quality event.',
    `event_category` STRING COMMENT 'Functional area or category where the quality event originated: manufacturing operations, laboratory testing, validation activities, documentation control, equipment qualification, or material handling.',
    `event_number` STRING COMMENT 'Business identifier for the quality event, typically system-generated or manually assigned following organizational numbering conventions (e.g., DEV-00012345, CAPA-2024-0001, OOS-20240315).',
    `event_type` STRING COMMENT 'Classification of the quality event: deviation (non-conformance to procedures), CAPA (Corrective and Preventive Action), OOS (Out of Specification result), OOT (Out of Trend result), change_control (controlled change to validated state), or audit_finding (observation from internal/external audit).',
    `gmp_impact` STRING COMMENT 'Assessment of the quality events impact on Good Manufacturing Practice compliance and pharmaceutical quality standards.',
    `investigation_required` BOOLEAN COMMENT 'Indicates whether a formal investigation is required for this quality event based on severity, impact, and regulatory requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this quality event record was last updated or modified.',
    `occurred_date` DATE COMMENT 'Actual or estimated date when the quality event occurred. May differ from detection date if the event was discovered retrospectively.',
    `patient_safety_risk` STRING COMMENT 'Assessment of potential risk to patient safety resulting from this quality event, used to prioritize investigation and response activities.',
    `preventive_action` STRING COMMENT 'Description of preventive actions implemented to address systemic issues and prevent similar quality events in the future.',
    `qa_approval_required` BOOLEAN COMMENT 'Indicates whether Quality Assurance management approval is required before closing this quality event.',
    `qa_approval_timestamp` TIMESTAMP COMMENT 'Date and time when Quality Assurance approved the quality event closure.',
    `regulatory_report_date` DATE COMMENT 'Date when the quality event was reported to regulatory authorities, if applicable.',
    `regulatory_reportable` BOOLEAN COMMENT 'Indicates whether this quality event must be reported to regulatory authorities (FDA, EMA, etc.) based on severity, product impact, or regulatory requirements.',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the quality event was formally reported or logged into the quality management system.',
    `root_cause` STRING COMMENT 'Identified root cause of the quality event as determined through investigation methodologies such as 5-Why analysis, fishbone diagrams, or failure mode analysis.',
    `severity` STRING COMMENT 'Severity classification of the quality event based on potential impact to product quality, patient safety, and regulatory compliance. Critical events pose immediate risk to patient safety; major events may impact product quality or compliance; minor events have limited impact.',
    `quality_event_status` STRING COMMENT 'Current lifecycle status of the quality event in the quality management workflow.',
    `target_closure_date` DATE COMMENT 'Planned or target date for completing investigation and closing the quality event, based on severity and regulatory timelines.',
    `title` STRING COMMENT 'Brief descriptive title or summary of the quality event for identification and reporting purposes.',
    CONSTRAINT pk_quality_event PRIMARY KEY(`quality_event_id`)
) COMMENT 'Master reference table for quality_event. Referenced by originating_event_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`sop` (
    `sop_id` BIGINT COMMENT 'Primary key for sop',
    `superseded_sop_id` BIGINT COMMENT 'Self-referencing FK on sop (superseded_sop_id)',
    `approval_date` DATE COMMENT 'Date when the SOP was formally approved by the authorized approver.',
    `approver_name` STRING COMMENT 'Name of the authorized individual (typically QA manager or department head) who approved the SOP for use.',
    `archive_location` STRING COMMENT 'Physical or electronic location where obsolete or superseded versions of this SOP are archived for retention.',
    `author_department` STRING COMMENT 'Department or organizational unit of the SOP author.',
    `author_name` STRING COMMENT 'Name of the individual who authored or drafted the current version of the SOP.',
    `change_control_number` STRING COMMENT 'Reference number of the change control record that authorized the creation or revision of this SOP.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SOP record was first created in the quality management system.',
    `distribution_list` STRING COMMENT 'List of departments, roles, or locations where controlled copies of this SOP must be distributed.',
    `document_owner` STRING COMMENT 'Name or role of the individual responsible for maintaining and ensuring the accuracy of this SOP.',
    `document_type` STRING COMMENT 'Classification of the quality document (SOP, Work Instruction, Policy, Guideline, Form, or Template).',
    `effective_date` DATE COMMENT 'Date when this SOP version becomes effective and enforceable for operations.',
    `electronic_signature_required_flag` BOOLEAN COMMENT 'Indicates whether electronic signatures compliant with 21 CFR Part 11 are required for execution or approval of this SOP.',
    `expiration_date` DATE COMMENT 'Date when this SOP version is scheduled for review or expiration, typically based on periodic review cycles.',
    `functional_area` STRING COMMENT 'Primary functional area or department to which this SOP applies (Quality Control, Quality Assurance, Manufacturing, Validation, Regulatory Affairs, or Laboratory).',
    `gmp_classification` STRING COMMENT 'Classification indicating whether the SOP is GMP-critical, GMP-supporting, or non-GMP in nature.',
    `keywords` STRING COMMENT 'Comma-separated list of searchable keywords and tags to facilitate document retrieval and classification.',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the language in which the SOP is written (e.g., ENG, SPA, FRA).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the SOP record was last modified or updated in the quality management system.',
    `last_reviewed_date` DATE COMMENT 'Date when the SOP was last subjected to periodic review for continued accuracy and relevance.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the SOP (Draft, Under Review, Approved, Active, Superseded, Obsolete, or Retired).',
    `next_review_due_date` DATE COMMENT 'Calculated date when the next periodic review of this SOP is scheduled to occur.',
    `process_category` STRING COMMENT 'Specific process category or sub-domain within the functional area (e.g., CAPA, Deviation Management, Method Validation, Stability Testing).',
    `purpose_description` STRING COMMENT 'Statement of the business purpose and objectives that this SOP is designed to achieve.',
    `regulatory_impact` STRING COMMENT 'Assessment of the SOPs impact on regulatory compliance and inspection readiness (High, Medium, or Low).',
    `regulatory_references` STRING COMMENT 'List of applicable regulatory citations, guidance documents, and standards that this SOP addresses (e.g., 21 CFR Part 211, ICH Q7, ISO 9001).',
    `related_sop_numbers` STRING COMMENT 'Comma-separated list of related or cross-referenced SOP numbers that are associated with this procedure.',
    `retention_period_years` STRING COMMENT 'Number of years that obsolete versions of this SOP must be retained per regulatory and quality system requirements.',
    `review_frequency_months` STRING COMMENT 'Scheduled periodic review interval in months (e.g., 12, 24, 36 months) as per quality management system requirements.',
    `reviewer_name` STRING COMMENT 'Name of the subject matter expert or quality representative who reviewed the SOP for technical accuracy.',
    `revision_number` STRING COMMENT 'Sequential revision count for tracking document changes and updates.',
    `scope_description` STRING COMMENT 'Detailed description of the scope, applicability, and boundaries of the SOP including what is covered and excluded.',
    `sop_number` STRING COMMENT 'Business identifier for the SOP, typically following organizational numbering convention (e.g., SOP-QC-001234).',
    `supersedes_sop_number` STRING COMMENT 'SOP number of the previous version that this current version replaces or supersedes.',
    `title` STRING COMMENT 'Full descriptive title of the standard operating procedure.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether formal training and competency assessment is required before personnel can execute this SOP.',
    `training_type` STRING COMMENT 'Type of training required for this SOP (Initial, Refresher, Read and Understand, Hands-On, or Not Required).',
    `translation_required_flag` BOOLEAN COMMENT 'Indicates whether this SOP requires translation into additional languages for multi-site or global operations.',
    `version_number` STRING COMMENT 'Current version number of the SOP following semantic versioning (e.g., 1.0, 2.3).',
    CONSTRAINT pk_sop PRIMARY KEY(`sop_id`)
) COMMENT 'Master reference table for sop. Referenced by sop_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`quality_agreement` (
    `quality_agreement_id` BIGINT COMMENT 'Primary key for quality_agreement',
    `superseded_quality_agreement_id` BIGINT COMMENT 'Self-referencing FK on quality_agreement (superseded_quality_agreement_id)',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the quality agreement, typically following organizational numbering convention.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the quality agreement indicating its operational state and validity.',
    `agreement_type` STRING COMMENT 'Classification of the quality agreement based on the nature of services or activities covered (e.g., contract manufacturing, quality control testing, distribution services).',
    `approved_by_name` STRING COMMENT 'Name of the quality executive or authorized signatory who approved this quality agreement on behalf of the sponsor organization.',
    `approved_date` DATE COMMENT 'Date when the quality agreement was formally approved by authorized signatories.',
    `audit_frequency_months` STRING COMMENT 'Scheduled frequency in months for conducting quality audits of the counterparty under this agreement.',
    `batch_release_authority` STRING COMMENT 'Designation of which party has authority to release batches for distribution under this agreement.',
    `capa_responsibility` STRING COMMENT 'Designation of which party is responsible for initiating and managing CAPA activities under this agreement.',
    `change_control_required` BOOLEAN COMMENT 'Indicates whether changes to processes, materials, or specifications require formal change control approval under this agreement.',
    `change_notification_days` STRING COMMENT 'Minimum number of days advance notice required for notifying the sponsor of planned changes.',
    `coa_issuance_responsibility` STRING COMMENT 'Designation of which party is responsible for issuing the Certificate of Analysis for products covered by this agreement.',
    `counterparty_id` BIGINT COMMENT 'Reference to the external organization (contract manufacturer, testing laboratory, distributor, or service provider) that is party to this quality agreement.',
    `counterparty_name` STRING COMMENT 'Legal name of the external organization party to the quality agreement.',
    `counterparty_site_id` BIGINT COMMENT 'Reference to the specific manufacturing site, laboratory, or facility of the counterparty covered by this agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this quality agreement record was first created in the system.',
    `deviation_notification_required` BOOLEAN COMMENT 'Indicates whether the counterparty is required to notify the sponsor of quality deviations under this agreement.',
    `deviation_notification_timeframe_hours` STRING COMMENT 'Maximum number of hours within which the counterparty must notify the sponsor of a quality deviation.',
    `document_version` STRING COMMENT 'Version number of the quality agreement document following organizational version control convention.',
    `effective_date` DATE COMMENT 'Date when the quality agreement becomes legally binding and operational.',
    `expiration_date` DATE COMMENT 'Date when the quality agreement terminates or requires renewal. Nullable for evergreen agreements.',
    `gmp_classification` STRING COMMENT 'Classification indicating the applicable quality practice standard (GMP for manufacturing, GCP for clinical, GLP for laboratory, GDP for distribution).',
    `last_audit_date` DATE COMMENT 'Date of the most recent quality audit conducted under this agreement.',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of this quality agreement.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this quality agreement record was last modified or updated.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next quality audit of the counterparty.',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next periodic review of this quality agreement.',
    `owning_organization_id` BIGINT COMMENT 'Reference to the internal business unit or legal entity that owns and manages this quality agreement.',
    `quality_agreement_title` STRING COMMENT 'Descriptive title or name of the quality agreement summarizing its purpose and scope.',
    `quality_metrics_reporting_frequency` STRING COMMENT 'Frequency at which the counterparty must provide quality performance metrics and KPIs to the sponsor.',
    `quality_system_standard` STRING COMMENT 'Quality management system standard or framework that governs this agreement (e.g., ICH Q10, ISO 9001, ISO 13485 for medical devices).',
    `regulatory_authority` STRING COMMENT 'Primary regulatory authority or jurisdiction under which this quality agreement operates (e.g., FDA, EMA, PMDA, Health Canada).',
    `responsible_site_id` BIGINT COMMENT 'Reference to the internal site or facility responsible for oversight and management of this quality agreement.',
    `retention_sample_responsibility` STRING COMMENT 'Designation of which party is responsible for storing and maintaining retention samples.',
    `review_frequency_months` STRING COMMENT 'Scheduled frequency in months for periodic review and update of the quality agreement.',
    `scope_description` STRING COMMENT 'Detailed description of the activities, products, services, and responsibilities covered under this quality agreement.',
    `stability_study_responsibility` STRING COMMENT 'Designation of which party is responsible for conducting and managing stability studies for products under this agreement.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the quality agreement.',
    CONSTRAINT pk_quality_agreement PRIMARY KEY(`quality_agreement_id`)
) COMMENT 'Master reference table for quality_agreement. Referenced by quality_agreement_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ADD CONSTRAINT `fk_quality_quality_capa_quality_event_id` FOREIGN KEY (`quality_event_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_event`(`quality_event_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ADD CONSTRAINT `fk_quality_quality_capa_quality_change_control_id` FOREIGN KEY (`quality_change_control_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_change_control`(`quality_change_control_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ADD CONSTRAINT `fk_quality_quality_capa_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_sop_id` FOREIGN KEY (`sop_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`sop`(`sop_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_lab_test_result_id` FOREIGN KEY (`lab_test_result_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`lab_test_result`(`lab_test_result_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ADD CONSTRAINT `fk_quality_quality_change_control_qms_document_id` FOREIGN KEY (`qms_document_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`qms_document`(`qms_document_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ADD CONSTRAINT `fk_quality_quality_change_control_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_oos_investigation_id` FOREIGN KEY (`oos_investigation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`oos_investigation`(`oos_investigation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_qms_document_id` FOREIGN KEY (`qms_document_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`qms_document`(`qms_document_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_quality_capa_id` FOREIGN KEY (`quality_capa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_capa`(`quality_capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_coa_id` FOREIGN KEY (`coa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`coa`(`coa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_method_validation_id` FOREIGN KEY (`method_validation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`method_validation`(`method_validation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_original_test_result_lab_test_result_id` FOREIGN KEY (`original_test_result_lab_test_result_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`lab_test_result`(`lab_test_result_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_sample_id` FOREIGN KEY (`sample_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`sample`(`sample_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_stability_study_id` FOREIGN KEY (`stability_study_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`stability_study`(`stability_study_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_method_validation_id` FOREIGN KEY (`method_validation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`method_validation`(`method_validation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_qms_document_id` FOREIGN KEY (`qms_document_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`qms_document`(`qms_document_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ADD CONSTRAINT `fk_quality_method_validation_analytical_method_id` FOREIGN KEY (`analytical_method_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`analytical_method`(`analytical_method_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ADD CONSTRAINT `fk_quality_method_validation_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ADD CONSTRAINT `fk_quality_batch_disposition_coa_id` FOREIGN KEY (`coa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`coa`(`coa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_oos_investigation_id` FOREIGN KEY (`oos_investigation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`oos_investigation`(`oos_investigation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_quality_capa_id` FOREIGN KEY (`quality_capa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_capa`(`quality_capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_quality_change_control_id` FOREIGN KEY (`quality_change_control_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_change_control`(`quality_change_control_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_sop_id` FOREIGN KEY (`sop_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`sop`(`sop_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_analytical_method_id` FOREIGN KEY (`analytical_method_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`analytical_method`(`analytical_method_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_superseded_by_specification_id` FOREIGN KEY (`superseded_by_specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`audit`(`audit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ADD CONSTRAINT `fk_quality_product_quality_review_qms_document_id` FOREIGN KEY (`qms_document_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`qms_document`(`qms_document_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ADD CONSTRAINT `fk_quality_product_quality_review_previous_product_quality_review_id` FOREIGN KEY (`previous_product_quality_review_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`product_quality_review`(`product_quality_review_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` ADD CONSTRAINT `fk_quality_audit_site_inspection_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`audit`(`audit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` ADD CONSTRAINT `fk_quality_audit_site_inspection_quality_capa_id` FOREIGN KEY (`quality_capa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_capa`(`quality_capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`root_cause_analysis` ADD CONSTRAINT `fk_quality_root_cause_analysis_quality_capa_id` FOREIGN KEY (`quality_capa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_capa`(`quality_capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`root_cause_analysis` ADD CONSTRAINT `fk_quality_root_cause_analysis_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`oos_investigation`(`oos_investigation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`root_cause_analysis` ADD CONSTRAINT `fk_quality_root_cause_analysis_oos_investigation_id` FOREIGN KEY (`oos_investigation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`oos_investigation`(`oos_investigation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`root_cause_analysis` ADD CONSTRAINT `fk_quality_root_cause_analysis_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`root_cause_analysis` ADD CONSTRAINT `fk_quality_root_cause_analysis_parent_root_cause_analysis_id` FOREIGN KEY (`parent_root_cause_analysis_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`root_cause_analysis`(`root_cause_analysis_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`qms_document` ADD CONSTRAINT `fk_quality_qms_document_superseded_qms_document_id` FOREIGN KEY (`superseded_qms_document_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`qms_document`(`qms_document_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_stability_study_id` FOREIGN KEY (`stability_study_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`stability_study`(`stability_study_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_test_specification_id` FOREIGN KEY (`test_specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`analytical_method` ADD CONSTRAINT `fk_quality_analytical_method_superseded_analytical_method_id` FOREIGN KEY (`superseded_analytical_method_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`analytical_method`(`analytical_method_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_event` ADD CONSTRAINT `fk_quality_quality_event_quality_agreement_id` FOREIGN KEY (`quality_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_agreement`(`quality_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_event` ADD CONSTRAINT `fk_quality_quality_event_originating_quality_event_id` FOREIGN KEY (`originating_quality_event_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_event`(`quality_event_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`sop` ADD CONSTRAINT `fk_quality_sop_superseded_sop_id` FOREIGN KEY (`superseded_sop_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`sop`(`sop_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_agreement` ADD CONSTRAINT `fk_quality_quality_agreement_superseded_quality_agreement_id` FOREIGN KEY (`superseded_quality_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_agreement`(`quality_agreement_id`);

-- ========= TAGS =========
ALTER SCHEMA `pharmaceuticals_ecm`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `pharmaceuticals_ecm`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` SET TAGS ('dbx_subdomain' = 'event_management');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `quality_capa_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Physician Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `quality_event_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Event ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `inquiry_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Medical Inquiry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `inquiry_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `inquiry_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `primary_quality_employee_id` SET TAGS ('dbx_business_glossary_term' = 'CAPA Owner ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `primary_quality_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `primary_quality_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `quality_change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Change Control Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Deviation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `tertiary_quality_closed_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Closed By ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `tertiary_quality_closed_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `tertiary_quality_closed_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `capa_number` SET TAGS ('dbx_business_glossary_term' = 'CAPA Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `capa_number` SET TAGS ('dbx_value_regex' = '^CAPA-[0-9]{6,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `capa_status` SET TAGS ('dbx_business_glossary_term' = 'CAPA Status');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `capa_type` SET TAGS ('dbx_business_glossary_term' = 'CAPA Type');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `capa_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|combined');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `closed_by_name` SET TAGS ('dbx_business_glossary_term' = 'Closed By Name');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `closure_comments` SET TAGS ('dbx_business_glossary_term' = 'Closure Comments');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factors');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `effectiveness_check_comments` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Comments');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `effectiveness_check_criteria` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Criteria');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `effectiveness_check_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `effectiveness_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `effectiveness_check_result` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Result');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `effectiveness_check_result` SET TAGS ('dbx_value_regex' = 'effective|ineffective|partially_effective|pending');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `immediate_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Immediate Action Taken');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `initiated_by_name` SET TAGS ('dbx_business_glossary_term' = 'Initiated By Name');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Initiated Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `originating_event_type` SET TAGS ('dbx_business_glossary_term' = 'Originating Event Type');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `preventive_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Plan');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `quality_capa_description` SET TAGS ('dbx_business_glossary_term' = 'CAPA Description');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `regulatory_commitment_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Commitment Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `root_cause_analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Method');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `root_cause_analysis_method` SET TAGS ('dbx_value_regex' = '5_why|fishbone|fmea|fault_tree|pareto|other');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'CAPA Title');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` SET TAGS ('dbx_subdomain' = 'event_management');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Deviation Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `inventory_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Lot Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Owner Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `payer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Account Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `sop_id` SET TAGS ('dbx_business_glossary_term' = 'Sop Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `audit_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `customer_complaint_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `detected_by` SET TAGS ('dbx_business_glossary_term' = 'Detected By');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `detected_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `detected_date` SET TAGS ('dbx_business_glossary_term' = 'Detected Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `deviation_category` SET TAGS ('dbx_business_glossary_term' = 'Deviation Category');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `deviation_category` SET TAGS ('dbx_value_regex' = 'planned|unplanned');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `deviation_number` SET TAGS ('dbx_business_glossary_term' = 'Deviation Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `deviation_number` SET TAGS ('dbx_value_regex' = '^DEV-[0-9]{6,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `deviation_status` SET TAGS ('dbx_business_glossary_term' = 'Deviation Status');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `deviation_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|pending_approval|closed|cancelled');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `deviation_type` SET TAGS ('dbx_business_glossary_term' = 'Deviation Type');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `disposition_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Disposition Recommendation');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `disposition_recommendation` SET TAGS ('dbx_value_regex' = 'release|rework|reprocess|reject|use_as_is|return_to_vendor');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `facility_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{2,4}$');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `final_disposition` SET TAGS ('dbx_business_glossary_term' = 'Final Disposition');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `final_disposition` SET TAGS ('dbx_value_regex' = 'released|reworked|reprocessed|rejected|used_as_is|returned');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `gmp_impact_classification` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Impact Classification');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `gmp_impact_classification` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `immediate_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Immediate Action Taken');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `investigation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completed Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `investigation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `occurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Process Step');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `product_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `qa_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `qa_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Reviewer');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `qa_reviewer` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `quality_deviation_description` SET TAGS ('dbx_business_glossary_term' = 'Deviation Description');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `root_cause_summary` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Summary');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_QM|TrackWise|MasterControl|Veeva_QualityDocs');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` SET TAGS ('dbx_subdomain' = 'event_management');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `oos_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Specification (OOS) Investigation ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `inventory_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Lot Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `lab_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Deviation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `assignability_determination` SET TAGS ('dbx_business_glossary_term' = 'Assignability Determination');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `assignability_determination` SET TAGS ('dbx_value_regex' = 'assignable|unassignable');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `batch_disposition` SET TAGS ('dbx_business_glossary_term' = 'Batch Disposition');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `batch_disposition` SET TAGS ('dbx_value_regex' = 'released|rejected|reworked|quarantined|pending');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `closed_by` SET TAGS ('dbx_business_glossary_term' = 'Investigation Closed By');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `disposition_justification` SET TAGS ('dbx_business_glossary_term' = 'Disposition Justification');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Initiated Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `investigation_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Closed Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `investigation_conclusion` SET TAGS ('dbx_business_glossary_term' = 'Investigation Conclusion');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `investigation_number` SET TAGS ('dbx_business_glossary_term' = 'Investigation Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'initiated|phase_i_in_progress|phase_i_complete|phase_ii_in_progress|phase_ii_complete|closed');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `laboratory_error_description` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Error Description');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `laboratory_error_identified` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Error Identified');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `observed_result` SET TAGS ('dbx_business_glossary_term' = 'Observed Result');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `phase_i_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Phase I (Laboratory Investigation) Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `phase_i_findings` SET TAGS ('dbx_business_glossary_term' = 'Phase I (Laboratory Investigation) Findings');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `phase_i_start_date` SET TAGS ('dbx_business_glossary_term' = 'Phase I (Laboratory Investigation) Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `phase_ii_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Phase II (Full-Scale Investigation) Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `phase_ii_findings` SET TAGS ('dbx_business_glossary_term' = 'Phase II (Full-Scale Investigation) Findings');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `phase_ii_required` SET TAGS ('dbx_business_glossary_term' = 'Phase II (Full-Scale Investigation) Required');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `phase_ii_start_date` SET TAGS ('dbx_business_glossary_term' = 'Phase II (Full-Scale Investigation) Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `qa_review_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `qa_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Reviewer');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `retest_authorized` SET TAGS ('dbx_business_glossary_term' = 'Retest Authorized');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `retest_justification` SET TAGS ('dbx_business_glossary_term' = 'Retest Justification');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `retest_result` SET TAGS ('dbx_business_glossary_term' = 'Retest Result');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `root_cause_identified` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Identified');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Specification Limit');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `test_parameter` SET TAGS ('dbx_business_glossary_term' = 'Test Parameter');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` SET TAGS ('dbx_subdomain' = 'event_management');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `quality_change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Change Control ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiator Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `internal_control_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Control Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `master_batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Master Batch Record Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `qms_document_id` SET TAGS ('dbx_business_glossary_term' = 'Qms Document Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Deviation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `actual_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Implementation Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `affected_markets` SET TAGS ('dbx_business_glossary_term' = 'Affected Markets');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `affected_products` SET TAGS ('dbx_business_glossary_term' = 'Affected Products');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `affected_sop_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Standard Operating Procedure (SOP) List');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Change Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Change Approver Name');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `approver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `change_category` SET TAGS ('dbx_business_glossary_term' = 'Change Category');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `change_category` SET TAGS ('dbx_value_regex' = 'process|equipment|material|facility|system|document');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `change_control_number` SET TAGS ('dbx_value_regex' = '^CC-[0-9]{6,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `change_rationale` SET TAGS ('dbx_business_glossary_term' = 'Change Rationale');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `change_status` SET TAGS ('dbx_business_glossary_term' = 'Change Control Status');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `change_title` SET TAGS ('dbx_business_glossary_term' = 'Change Control Title');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type Classification');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'minor|major|critical');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Change Control Closure Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `effectiveness_verified` SET TAGS ('dbx_business_glossary_term' = 'Change Effectiveness Verified Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `implementation_plan` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Change Initiated Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `post_implementation_review` SET TAGS ('dbx_business_glossary_term' = 'Post-Implementation Review');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `regulatory_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Assessment');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `risk_assessment_summary` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Summary');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `sop_updates_required` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Updates Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'MasterControl|TrackWise|SAP_QM|Veeva_Vault|Other');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `target_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Target Implementation Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `validation_protocol_reference` SET TAGS ('dbx_business_glossary_term' = 'Validation Protocol Reference');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ALTER COLUMN `validation_required` SET TAGS ('dbx_business_glossary_term' = 'Validation Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` SET TAGS ('dbx_subdomain' = 'compliance_oversight');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Audited Investigator Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `oos_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Oos Investigation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `gxp_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Gxp Obligation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `hco_master_id` SET TAGS ('dbx_business_glossary_term' = 'Audited Hco Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Program Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `qms_document_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Management System (QMS) Document Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `qms_document_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `quality_capa_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Capa Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Deviation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `warehouse_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Receipt Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `agenda` SET TAGS ('dbx_business_glossary_term' = 'Audit Agenda');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal_gmp|supplier_qualification|cmo_audit|regulatory_inspection|self_inspection|surveillance');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `capa_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `closure_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Verification Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `closure_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Closure Verification Status');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `closure_verification_status` SET TAGS ('dbx_value_regex' = 'pending|in_verification|verified|closed');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `criteria` SET TAGS ('dbx_business_glossary_term' = 'Audit Criteria');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit End Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `form_483_issued` SET TAGS ('dbx_business_glossary_term' = 'Form 483 Issued Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Audit Methodology');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `methodology` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid|desktop_review');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `observations_count` SET TAGS ('dbx_business_glossary_term' = 'Observations Count');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `overall_audit_outcome` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `overall_audit_outcome` SET TAGS ('dbx_value_regex' = 'satisfactory|acceptable_with_observations|deficient|unacceptable|official_action_indicated|voluntary_action_indicated');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `planned_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Audit Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `pre_audit_preparation_status` SET TAGS ('dbx_business_glossary_term' = 'Pre-Audit Preparation Status');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `pre_audit_preparation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|complete');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `report_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Report Issue Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `report_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,25}$');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Response Submitted Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `team_members` SET TAGS ('dbx_business_glossary_term' = 'Audit Team Members');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `total_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `warning_letter_issued` SET TAGS ('dbx_business_glossary_term' = 'Warning Letter Issued Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` SET TAGS ('dbx_subdomain' = 'laboratory_testing');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `lab_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Result ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `coa_id` SET TAGS ('dbx_business_glossary_term' = 'Coa Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `cogs_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cogs Entry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `inventory_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Lot Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `method_validation_id` SET TAGS ('dbx_business_glossary_term' = 'Test Method ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `original_test_result_lab_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Original Test Result ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Deviation ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `stability_study_id` SET TAGS ('dbx_business_glossary_term' = 'Stability Study ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `tertiary_lab_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `tertiary_lab_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `tertiary_lab_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `analyst_name` SET TAGS ('dbx_business_glossary_term' = 'Analyst Name');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `analyst_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Approved Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `coa_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) Inclusion Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `instrument_name` SET TAGS ('dbx_business_glossary_term' = 'Instrument Name');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `oos_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Specification (OOS) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `oot_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Trend (OOT) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|inconclusive|pending');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `result_text` SET TAGS ('dbx_business_glossary_term' = 'Result Text');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `result_value` SET TAGS ('dbx_business_glossary_term' = 'Result Value');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `retest_flag` SET TAGS ('dbx_business_glossary_term' = 'Retest Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `reviewed_by_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Name');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `reviewed_by_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `reviewed_flag` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `stability_timepoint` SET TAGS ('dbx_business_glossary_term' = 'Stability Timepoint');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `test_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Completion Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `test_number` SET TAGS ('dbx_business_glossary_term' = 'Test Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `test_parameter` SET TAGS ('dbx_business_glossary_term' = 'Test Parameter');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `test_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Start Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` SET TAGS ('dbx_subdomain' = 'laboratory_testing');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `stability_study_id` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `access_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Access Strategy Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `cogs_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cogs Entry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `inventory_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Lot Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `method_validation_id` SET TAGS ('dbx_business_glossary_term' = 'Method Validation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `packaging_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `qms_document_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Management System (QMS) Document Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `quaternary_stability_responsible_person_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `tertiary_stability_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `tertiary_stability_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `tertiary_stability_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `container_closure_system` SET TAGS ('dbx_business_glossary_term' = 'Container Closure System');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `current_time_point_months` SET TAGS ('dbx_business_glossary_term' = 'Current Time Point (Months)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `lims_study_reference` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Study Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `oot_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Trend (OOT) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `overall_pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Pass Fail Status');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `overall_pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|pending|not_tested');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `pull_point_schedule` SET TAGS ('dbx_business_glossary_term' = 'Pull Point Schedule');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `regulatory_commitment_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Commitment Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `regulatory_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Reference');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `retest_date_months` SET TAGS ('dbx_business_glossary_term' = 'Retest Date (Months)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `shelf_life_months` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Months)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `statistical_trend_analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Statistical Trend Analysis Method');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `statistical_trend_analysis_method` SET TAGS ('dbx_value_regex' = 'linear_regression|pooled_regression|bracketing|matrixing|none');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'International Council for Harmonisation (ICH) Storage Condition');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `study_notes` SET TAGS ('dbx_business_glossary_term' = 'Study Notes');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `study_protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Study Protocol Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `study_protocol_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}-[A-Z]{2,4}-[0-9]{4,6}(-[A-Z0-9]{1,4})?$');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `study_start_date` SET TAGS ('dbx_business_glossary_term' = 'Study Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'Study Status');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `study_status` SET TAGS ('dbx_value_regex' = 'planned|active|on_hold|completed|cancelled|under_review');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Study Type');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `test_parameters` SET TAGS ('dbx_business_glossary_term' = 'Test Parameters');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` SET TAGS ('dbx_subdomain' = 'laboratory_testing');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `method_validation_id` SET TAGS ('dbx_business_glossary_term' = 'Method Validation Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `drug_master_file_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master File Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `analytical_method_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `rd_capitalization_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Capitalization Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `accuracy_recovery_percent_mean` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Mean Recovery Percent');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `accuracy_result` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Result');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `accuracy_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_assessed');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `api_name` SET TAGS ('dbx_business_glossary_term' = 'Active Pharmaceutical Ingredient (API) Name');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `compendial_method_flag` SET TAGS ('dbx_business_glossary_term' = 'Compendial Method Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `compendial_reference` SET TAGS ('dbx_business_glossary_term' = 'Compendial Reference');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `intermediate_precision_rsd_percent` SET TAGS ('dbx_business_glossary_term' = 'Intermediate Precision Relative Standard Deviation (RSD) Percent');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `linearity_correlation_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Linearity Correlation Coefficient (R)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `linearity_range_lower` SET TAGS ('dbx_business_glossary_term' = 'Linearity Range Lower Limit');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `linearity_range_unit` SET TAGS ('dbx_business_glossary_term' = 'Linearity Range Unit of Measure');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `linearity_range_upper` SET TAGS ('dbx_business_glossary_term' = 'Linearity Range Upper Limit');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `linearity_result` SET TAGS ('dbx_business_glossary_term' = 'Linearity Result');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `linearity_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_assessed');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `lod_unit` SET TAGS ('dbx_business_glossary_term' = 'Limit of Detection (LOD) Unit of Measure');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `lod_value` SET TAGS ('dbx_business_glossary_term' = 'Limit of Detection (LOD) Value');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `loq_unit` SET TAGS ('dbx_business_glossary_term' = 'Limit of Quantitation (LOQ) Unit of Measure');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `loq_value` SET TAGS ('dbx_business_glossary_term' = 'Limit of Quantitation (LOQ) Value');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `method_type` SET TAGS ('dbx_business_glossary_term' = 'Method Type');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `method_type` SET TAGS ('dbx_value_regex' = 'assay|identification|impurity|dissolution|content_uniformity|related_substances');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `overall_validation_conclusion` SET TAGS ('dbx_business_glossary_term' = 'Overall Validation Conclusion');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `overall_validation_conclusion` SET TAGS ('dbx_value_regex' = 'validated|not_validated|conditionally_validated');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `precision_result` SET TAGS ('dbx_business_glossary_term' = 'Precision Result');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `precision_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_assessed');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Inclusion Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `regulatory_submission_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Type');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `regulatory_submission_type` SET TAGS ('dbx_value_regex' = 'IND|NDA|BLA|MAA|ANDA|DMF');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `repeatability_rsd_percent` SET TAGS ('dbx_business_glossary_term' = 'Repeatability Relative Standard Deviation (RSD) Percent');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `robustness_result` SET TAGS ('dbx_business_glossary_term' = 'Robustness Result');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `robustness_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_assessed');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `specificity_result` SET TAGS ('dbx_business_glossary_term' = 'Specificity Result');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `specificity_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_assessed');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `technique` SET TAGS ('dbx_business_glossary_term' = 'Analytical Technique');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `validation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `validation_protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Validation Protocol Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `validation_protocol_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `validation_report_number` SET TAGS ('dbx_business_glossary_term' = 'Validation Report Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `validation_report_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `validation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|under_review|approved|rejected|superseded');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `validation_type` SET TAGS ('dbx_business_glossary_term' = 'Validation Type');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `validation_type` SET TAGS ('dbx_value_regex' = 'full|partial|revalidation|cross_validation|concurrent');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` SET TAGS ('dbx_subdomain' = 'release_authorization');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `coa_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `coa_qa_reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Reviewer ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `coa_qa_reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `coa_qa_reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `cogs_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cogs Entry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `contract_account_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Account Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `inventory_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Lot Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `market_payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Physician Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `named_patient_request_id` SET TAGS ('dbx_business_glossary_term' = 'Named Patient Request Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `packaging_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `authorized_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory Name');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `batch_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Batch/Lot Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `coa_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `customer_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Name');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `customer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `customer_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `glp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Laboratory Practice (GLP) Compliance Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issued Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `issuing_site_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Site Name');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `lims_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'drug_substance|drug_product|excipient|raw_material|packaging_material|finished_dosage_form');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `qa_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Reviewer Name');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `regulatory_market` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Market');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `release_status` SET TAGS ('dbx_business_glossary_term' = 'Release Status');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `release_status` SET TAGS ('dbx_value_regex' = 'released|rejected|pending|conditional_release|quarantine');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `sap_qm_inspection_lot` SET TAGS ('dbx_business_glossary_term' = 'SAP Quality Management (QM) Inspection Lot');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `test_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Test Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `test_method_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Method Reference');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `test_start_date` SET TAGS ('dbx_business_glossary_term' = 'Test Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` SET TAGS ('dbx_subdomain' = 'release_authorization');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `batch_disposition_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Disposition Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `coa_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `cogs_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cogs Entry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Qualified Person (QP) Approver ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `inventory_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Lot Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `market_payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `named_patient_request_id` SET TAGS ('dbx_business_glossary_term' = 'Named Patient Request Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `packaging_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `icsr_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Icsr Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `batch_size` SET TAGS ('dbx_business_glossary_term' = 'Batch Size');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `batch_size_uom` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Unit of Measure (UOM)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `disposition_comments` SET TAGS ('dbx_business_glossary_term' = 'Disposition Comments');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `disposition_rationale` SET TAGS ('dbx_business_glossary_term' = 'Disposition Rationale');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `disposition_status` SET TAGS ('dbx_business_glossary_term' = 'Disposition Status');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `disposition_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|on_hold|completed');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `disposition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disposition Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `disposition_type` SET TAGS ('dbx_business_glossary_term' = 'Disposition Type');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `disposition_type` SET TAGS ('dbx_value_regex' = 'release|reject|reprocess|rework|retest|quarantine');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `market_applicability` SET TAGS ('dbx_business_glossary_term' = 'Market Applicability');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `open_capa_count` SET TAGS ('dbx_business_glossary_term' = 'Open Corrective and Preventive Action (CAPA) Count');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `open_deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Open Deviation Count');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `open_oos_count` SET TAGS ('dbx_business_glossary_term' = 'Open Out of Specification (OOS) Count');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `qp_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Qualified Person (QP) Approver Name');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `quarantine_location` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Location');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `quarantine_status` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Status');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `quarantine_status` SET TAGS ('dbx_value_regex' = 'quarantined|released|rejected');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `regulatory_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `regulatory_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Reason');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `rejected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `released_quantity` SET TAGS ('dbx_business_glossary_term' = 'Released Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` SET TAGS ('dbx_subdomain' = 'event_management');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `call_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Call Activity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Closed By Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Owner Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `hco_master_id` SET TAGS ('dbx_business_glossary_term' = 'Complainant Hco Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `icsr_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Icsr Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `inquiry_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Inquiry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `inventory_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Lot Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Complainant Physician Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `oos_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Oos Investigation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `packaging_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `adverse_event_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Adverse Event Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `payer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Account Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `quality_capa_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Capa Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Deviation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_category` SET TAGS ('dbx_business_glossary_term' = 'Complaint Category');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_category` SET TAGS ('dbx_value_regex' = 'efficacy|safety|quality_defect|packaging|labeling|contamination');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Complaint Description');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_number` SET TAGS ('dbx_business_glossary_term' = 'Complaint Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_number` SET TAGS ('dbx_value_regex' = '^CMP-[0-9]{8}$');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_source` SET TAGS ('dbx_business_glossary_term' = 'Complaint Source');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_source` SET TAGS ('dbx_value_regex' = 'hcp|patient|distributor|regulatory_agency|internal|pharmacy');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_status` SET TAGS ('dbx_business_glossary_term' = 'Complaint Status');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_status` SET TAGS ('dbx_value_regex' = 'new|under_investigation|pending_review|closed|cancelled');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `initial_risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Initial Risk Assessment');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `initial_risk_assessment` SET TAGS ('dbx_value_regex' = 'critical|major|moderate|minor|negligible');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `investigation_findings` SET TAGS ('dbx_business_glossary_term' = 'Investigation Findings');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `investigation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Investigation Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `market_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Market of Origin');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `market_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `occurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `patient_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Impact Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Complaint Received Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `response_communication` SET TAGS ('dbx_business_glossary_term' = 'Response Communication');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'TrackWise|Veeva_Vault|MasterControl|SAP_QM');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Complaint Subcategory');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `trend_flag` SET TAGS ('dbx_business_glossary_term' = 'Trend Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` SET TAGS ('dbx_subdomain' = 'compliance_oversight');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `validation_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `distribution_network_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Network Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `internal_control_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Control Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `quality_change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `sop_id` SET TAGS ('dbx_business_glossary_term' = 'Sop Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Team Lead Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Validation Acceptance Criteria');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Validation Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `deviation_summary` SET TAGS ('dbx_business_glossary_term' = 'Validation Deviation Summary');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `deviations_observed` SET TAGS ('dbx_business_glossary_term' = 'Deviations Observed During Validation');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `execution_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Execution End Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `execution_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Execution Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Classification');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_value_regex' = 'GMP_critical|GMP_major|GMP_minor|non_GMP');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `next_revalidation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Revalidation Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `overall_outcome` SET TAGS ('dbx_business_glossary_term' = 'Overall Validation Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `overall_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|incomplete');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Validation Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `protocol_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Protocol Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `protocol_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Protocol Approved By');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `protocol_author` SET TAGS ('dbx_business_glossary_term' = 'Protocol Author');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Validation Protocol Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `protocol_number` SET TAGS ('dbx_value_regex' = '^VP-[A-Z0-9]{6,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `protocol_objective` SET TAGS ('dbx_business_glossary_term' = 'Validation Protocol Objective');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `protocol_title` SET TAGS ('dbx_business_glossary_term' = 'Validation Protocol Title');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `qa_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Reviewer');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `report_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Report Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Validation Report Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `report_number` SET TAGS ('dbx_value_regex' = '^VR-[A-Z0-9]{6,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `revalidation_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Revalidation Frequency in Months');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `revalidation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Revalidation Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `team_members` SET TAGS ('dbx_business_glossary_term' = 'Validation Team Members');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `test_runs_completed` SET TAGS ('dbx_business_glossary_term' = 'Completed Test Runs');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `test_runs_planned` SET TAGS ('dbx_business_glossary_term' = 'Planned Test Runs');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `test_steps_failed` SET TAGS ('dbx_business_glossary_term' = 'Failed Test Steps');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `test_steps_passed` SET TAGS ('dbx_business_glossary_term' = 'Passed Test Steps');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `test_steps_total` SET TAGS ('dbx_business_glossary_term' = 'Total Test Steps');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `validation_category` SET TAGS ('dbx_business_glossary_term' = 'Validation Category');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `validation_type` SET TAGS ('dbx_business_glossary_term' = 'Validation Type');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` SET TAGS ('dbx_subdomain' = 'release_authorization');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `analytical_method_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Author Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `drug_master_file_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master File Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `drug_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Substance Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `excipient_id` SET TAGS ('dbx_business_glossary_term' = 'Excipient Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `gxp_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Gxp Obligation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `superseded_by_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Specification Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `acceptance_criterion` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criterion');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `cpp_linkage` SET TAGS ('dbx_business_glossary_term' = 'Critical Process Parameter (CPP) Linkage');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `cqa_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Quality Attribute (CQA) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `document_location` SET TAGS ('dbx_business_glossary_term' = 'Document Location');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `market_authorization` SET TAGS ('dbx_business_glossary_term' = 'Market Authorization');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `pharmacopoeial_monograph` SET TAGS ('dbx_business_glossary_term' = 'Pharmacopoeial Monograph Reference');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `pharmacopoeial_standard` SET TAGS ('dbx_business_glossary_term' = 'Pharmacopoeial Standard');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|submitted|approved|rejected|pending_revision');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `regulatory_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Reference');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_QM|LIMS|Veeva_Vault|MasterControl|TrackWise|Manual');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `specification_number` SET TAGS ('dbx_business_glossary_term' = 'Specification Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `specification_type` SET TAGS ('dbx_business_glossary_term' = 'Specification Type');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `specification_type` SET TAGS ('dbx_value_regex' = 'release|shelf_life|in_process|stability|reference_standard|raw_material');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `test_frequency` SET TAGS ('dbx_business_glossary_term' = 'Test Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `test_parameter` SET TAGS ('dbx_business_glossary_term' = 'Test Parameter');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` SET TAGS ('dbx_subdomain' = 'compliance_oversight');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `supplier_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Qualification ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `drug_master_file_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master File Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `drug_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Substance Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `excipient_id` SET TAGS ('dbx_business_glossary_term' = 'Excipient Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `iit_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Iit Submission Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By User ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `supplier_quality_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Agreement ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `third_party_due_diligence_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Due Diligence Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `approval_workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Status');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `approval_workflow_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|qa_review|qa_approved|rejected');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `approved_material_scope` SET TAGS ('dbx_business_glossary_term' = 'Approved Material Scope');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `approved_service_scope` SET TAGS ('dbx_business_glossary_term' = 'Approved Service Scope');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency (Months)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `capa_count_last_12_months` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Count (Last 12 Months)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `deviation_count_last_12_months` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count (Last 12 Months)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `gmp_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Status');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `gmp_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditional|under_review');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `gmp_responsibility_matrix` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Responsibility Matrix');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Initiated Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `last_audit_outcome` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `last_audit_outcome` SET TAGS ('dbx_value_regex' = 'approved|approved_with_observations|conditional|failed');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `next_requalification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Re-qualification Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `oos_count_last_12_months` SET TAGS ('dbx_business_glossary_term' = 'Out of Specification (OOS) Count (Last 12 Months)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Performance Score');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `qa_review_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `qualification_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `qualification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_business_glossary_term' = 'Qualification Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'approved|conditional|disqualified|pending|suspended|expired');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'audit_based|questionnaire|coa_review|hybrid|risk_based');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `quality_agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Agreement Type');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `quality_agreement_type` SET TAGS ('dbx_value_regex' = 'master|product_specific|service_specific|site_specific');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `regulatory_inspection_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Authority');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `regulatory_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `regulatory_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Status');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `regulatory_inspection_status` SET TAGS ('dbx_value_regex' = 'no_action_indicated|voluntary_action_indicated|official_action_indicated|not_inspected');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `regulatory_market_coverage` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Market Coverage');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `requalification_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Re-qualification Frequency (Months)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'mastercontrol|trackwise|veeva_vault_qualitydocs');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `supplier_type` SET TAGS ('dbx_business_glossary_term' = 'Supplier Type');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` SET TAGS ('dbx_subdomain' = 'compliance_oversight');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `product_quality_review_id` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Review (PQR) Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `access_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Access Strategy Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `master_batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Master Batch Record Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Review Owner Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `qms_document_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Management System (QMS) Document Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `safety_signal_id` SET TAGS ('dbx_business_glossary_term' = 'Related Safety Signal Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `tertiary_product_management_reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Management Reviewer Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `tertiary_product_management_reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `tertiary_product_management_reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `previous_product_quality_review_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `action_items` SET TAGS ('dbx_business_glossary_term' = 'Action Items');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `batch_rejection_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Batch Rejection Rate Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `capa_count` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Count');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `change_control_count` SET TAGS ('dbx_business_glossary_term' = 'Change Control Count');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `complaint_count` SET TAGS ('dbx_business_glossary_term' = 'Product Complaint Count');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `critical_deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Deviation Count');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `dosage_form` SET TAGS ('dbx_business_glossary_term' = 'Finished Dosage Form (FDF)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `management_review_date` SET TAGS ('dbx_business_glossary_term' = 'Management Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `management_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Management Reviewer Name');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `oos_count` SET TAGS ('dbx_business_glossary_term' = 'Out of Specification (OOS) Count');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `oot_count` SET TAGS ('dbx_business_glossary_term' = 'Out of Trend (OOT) Count');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `open_capa_count` SET TAGS ('dbx_business_glossary_term' = 'Open Corrective and Preventive Action (CAPA) Count');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `process_capability_cpk` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cpk)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `qa_review_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `qa_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Reviewer Name');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `recall_count` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Count');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `regulatory_commitment_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Commitment Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `revalidation_justification` SET TAGS ('dbx_business_glossary_term' = 'Revalidation Justification');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `revalidation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Revalidation Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `review_conclusion` SET TAGS ('dbx_business_glossary_term' = 'Review Conclusion');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Review (PQR) Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `review_number` SET TAGS ('dbx_value_regex' = '^PQR-[0-9]{4}-[A-Z0-9]{6,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `review_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Review Owner Name');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|qa_review|management_review|approved|closed');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'annual|interim|ad_hoc|regulatory_commitment|post_approval');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `stability_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Stability Failure Count');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `stability_study_count` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Count');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `strength` SET TAGS ('dbx_business_glossary_term' = 'Product Strength');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `total_batches_manufactured` SET TAGS ('dbx_business_glossary_term' = 'Total Batches Manufactured');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `total_batches_rejected` SET TAGS ('dbx_business_glossary_term' = 'Total Batches Rejected');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ALTER COLUMN `total_batches_released` SET TAGS ('dbx_business_glossary_term' = 'Total Batches Released');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` SET TAGS ('dbx_subdomain' = 'compliance_oversight');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` SET TAGS ('dbx_association_edges' = 'quality.audit,procurement.vendor_site');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` ALTER COLUMN `audit_site_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Site Inspection - Audit Site Inspection Id');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Site Inspection - Audit Record Id');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` ALTER COLUMN `quality_capa_id` SET TAGS ('dbx_business_glossary_term' = 'Site CAPA ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Site Inspection - Vendor Site Id');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency in Months');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` ALTER COLUMN `auditor_assigned` SET TAGS ('dbx_business_glossary_term' = 'Auditor Assigned');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` ALTER COLUMN `next_site_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Site Audit Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` ALTER COLUMN `site_audit_outcome` SET TAGS ('dbx_business_glossary_term' = 'Site Audit Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` ALTER COLUMN `site_audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Site Audit Scope');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` ALTER COLUMN `site_capa_required` SET TAGS ('dbx_business_glossary_term' = 'Site CAPA Required');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` ALTER COLUMN `site_critical_findings` SET TAGS ('dbx_business_glossary_term' = 'Site Critical Findings');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` ALTER COLUMN `site_facility_audited` SET TAGS ('dbx_business_glossary_term' = 'Site or Facility Audited');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` ALTER COLUMN `site_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Site Findings Count');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` ALTER COLUMN `site_major_findings` SET TAGS ('dbx_business_glossary_term' = 'Site Major Findings');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` ALTER COLUMN `site_minor_findings` SET TAGS ('dbx_business_glossary_term' = 'Site Minor Findings');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` ALTER COLUMN `site_qualification_impact` SET TAGS ('dbx_business_glossary_term' = 'Site Qualification Impact');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` ALTER COLUMN `site_response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Site Response Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` ALTER COLUMN `site_response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Site Response Submitted Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`root_cause_analysis` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`root_cause_analysis` SET TAGS ('dbx_subdomain' = 'event_management');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`root_cause_analysis` ALTER COLUMN `root_cause_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`root_cause_analysis` ALTER COLUMN `oos_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Oos Investigation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`root_cause_analysis` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Deviation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`root_cause_analysis` ALTER COLUMN `parent_root_cause_analysis_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`qms_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`qms_document` SET TAGS ('dbx_subdomain' = 'release_authorization');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`qms_document` ALTER COLUMN `qms_document_id` SET TAGS ('dbx_business_glossary_term' = 'Qms Document Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`qms_document` ALTER COLUMN `superseded_qms_document_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`qms_document` ALTER COLUMN `approver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`qms_document` ALTER COLUMN `author_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`qms_document` ALTER COLUMN `distribution_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`qms_document` ALTER COLUMN `owner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`qms_document` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`sample` SET TAGS ('dbx_subdomain' = 'laboratory_testing');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`sample` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`sample` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`analytical_method` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`analytical_method` SET TAGS ('dbx_subdomain' = 'laboratory_testing');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`analytical_method` ALTER COLUMN `analytical_method_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`analytical_method` ALTER COLUMN `superseded_analytical_method_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_event` SET TAGS ('dbx_subdomain' = 'event_management');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_event` ALTER COLUMN `quality_event_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Event Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_event` ALTER COLUMN `originating_quality_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`sop` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`sop` SET TAGS ('dbx_subdomain' = 'release_authorization');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`sop` ALTER COLUMN `sop_id` SET TAGS ('dbx_business_glossary_term' = 'Sop Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`sop` ALTER COLUMN `superseded_sop_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`sop` ALTER COLUMN `approver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`sop` ALTER COLUMN `author_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`sop` ALTER COLUMN `document_owner` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`sop` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_agreement` SET TAGS ('dbx_subdomain' = 'compliance_oversight');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_agreement` ALTER COLUMN `quality_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Agreement Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_agreement` ALTER COLUMN `superseded_quality_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_agreement` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_agreement` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_confidential' = 'true');
