-- Schema for Domain: quality | Business: Pharmaceuticals | Version: v1_mvm
-- Generated on: 2026-05-05 21:11:01

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `pharmaceuticals_ecm`.`quality` COMMENT 'Controls quality management system (QMS) including quality control testing, quality assurance oversight, CAPA (corrective and preventive action), deviation management, OOS (out of specification) investigations, OOT (out of trend) analysis, change controls, SOPs, and audit findings. Manages LIMS data, stability studies, method validation, and certificate of analysis (CoA) issuance. Integrates with MasterControl/TrackWise and SAP QM. Implements QbD and PAT principles across GMP, GLP, and GCP quality oversight.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`capa` (
    `capa_id` BIGINT COMMENT 'Unique identifier for the CAPA record. Primary key for the quality_capa data product.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: CAPAs originating from batch-specific manufacturing deviations, OOS results, or process failures require direct batch linkage for root cause analysis, impact assessment, and effectiveness verification',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: CAPAs triggered by product quality issues are tracked against specific brands for brand-level quality metrics, regulatory commitment tracking, and commercial impact assessment. Annual Product Reviews ',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: Annual Product Reviews (21 CFR 211.180(e)) require CAPA trending by drug product. Regulatory inspections (FDA, EMA) review CAPA effectiveness at the drug product level. quality_capa links to medicinal',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to manufacturing.equipment. Business justification: Equipment failures and qualification gaps are a primary CAPA source in pharma manufacturing. quality_capa has no equipment_id FK. Linking CAPAs to specific equipment enables equipment-level CAPA trend',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: CAPAs may result in equipment purchases or facility modifications that become capitalized assets. Tracking CAPA-driven asset acquisitions is essential for capital expenditure justification, asset life',
    `hco_master_id` BIGINT COMMENT 'Foreign key linking to hcp.hco_master. Business justification: CAPAs arising from audits of HCOs (hospital pharmacies, clinical research sites, contract labs) must reference the institution for regulatory follow-up and effectiveness verification. Pharma QA teams ',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: CAPAs require dedicated budget tracking for investigation costs, remediation activities, and improvement projects. Internal orders track actual spend against CAPA initiatives, essential for cost manag',
    `investigator_id` BIGINT COMMENT 'Foreign key linking to hcp.investigator. Business justification: FDA and EMA inspections of clinical trial sites generate CAPAs assigned to the responsible investigator. Regulatory agencies require direct traceability between the CAPA and the investigator accountab',
    `master_id` BIGINT COMMENT 'Foreign key linking to hcp.hcp_master. Business justification: CAPAs originate from physician-reported complaints and adverse events. Tracks which HCP initiated the quality investigation for regulatory traceability and trend analysis by reporter.',
    `medicinal_product_id` BIGINT COMMENT 'Identifier of the drug product or drug substance affected by the CAPA, if applicable.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: CAPAs are owned and actioned by specific org units in pharma QMS. The department plain attribute is a denormalized org unit reference. GMP CAPA management, effectiveness checks, and regulatory repor',
    `quality_deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: CAPAs are frequently triggered by deviations. This FK provides a typed reference when originating_event_type=DEVIATION. Business case: deviations require corrective and preventive actions; CAPA effe',
    `site_id` BIGINT COMMENT 'Identifier of the manufacturing site, laboratory, or facility where the CAPA originated.',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: CAPAs raised in response to regulatory inspection findings (Form 483, Warning Letter) or submission deficiencies must trace back to the triggering submission. Regulatory commitment CAPAs are tracked a',
    `icsr_id` BIGINT COMMENT 'Foreign key linking to pharmacovigilance.icsr. Business justification: ICSRs reporting product-quality-related adverse events directly trigger CAPAs. FDA/EMA post-market surveillance requires tracing quality corrective actions back to the originating safety report. A pha',
    `actual_completion_date` DATE COMMENT 'Actual date when all CAPA actions were completed.',
    `capa_number` STRING COMMENT 'Business identifier for the CAPA record, typically system-generated or following organizational numbering convention. Used for external reference and tracking.. Valid values are `^CAPA-[0-9]{6,10}$`',
    `capa_status` STRING COMMENT 'Current lifecycle status of the CAPA record indicating its progression through the CAPA workflow from initiation through closure. [ENUM-REF-CANDIDATE: initiated|investigation|action_plan|implementation|verification|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `capa_type` STRING COMMENT 'Classification of the CAPA as corrective (addressing existing nonconformance), preventive (preventing potential nonconformance), or combined (both corrective and preventive actions).. Valid values are `corrective|preventive|combined`',
    `closed_by_name` STRING COMMENT 'Full name of the individual who approved and closed the CAPA record.',
    `closure_comments` STRING COMMENT 'Final comments and summary provided at CAPA closure, documenting the rationale for closure and any lessons learned.',
    `closure_date` DATE COMMENT 'Date when the CAPA was formally closed after successful completion and effectiveness verification.',
    `contributing_factors` STRING COMMENT 'Additional contributing factors identified during root cause analysis that may have influenced the occurrence of the issue.',
    `corrective_action_plan` STRING COMMENT 'Detailed plan describing the corrective actions to be taken to address the identified root cause and prevent recurrence.',
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
    `risk_level` STRING COMMENT 'Risk level assessment of the issue addressed by the CAPA, considering likelihood and impact.. Valid values are `high|medium|low`',
    `root_cause` STRING COMMENT 'Identified root cause(s) of the nonconformance or issue, documented as the outcome of the root cause analysis investigation.',
    `root_cause_analysis_method` STRING COMMENT 'Methodology used to perform root cause analysis, such as 5-Why, Fishbone (Ishikawa), Failure Mode and Effects Analysis (FMEA), Fault Tree Analysis, or Pareto analysis.. Valid values are `5_why|fishbone|fmea|fault_tree|pareto|other`',
    `severity` STRING COMMENT 'Severity classification of the CAPA based on impact to product quality, patient safety, regulatory compliance, or business operations.. Valid values are `critical|major|minor`',
    `target_completion_date` DATE COMMENT 'Target date by which the CAPA actions are planned to be completed.',
    `title` STRING COMMENT 'Brief descriptive title summarizing the CAPA issue and scope.',
    CONSTRAINT pk_capa PRIMARY KEY(`capa_id`)
) COMMENT 'Corrective and Preventive Action records managing the full CAPA lifecycle from initiation through effectiveness verification. Captures root cause analysis methodology (5-Why, Fishbone, FMEA), assigned owner, due dates, action plan details, regulatory commitment flag, effectiveness check criteria, closure status, and linkage to originating QMS events. Integrates with MasterControl/TrackWise CAPA module and SAP QM.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` (
    `quality_deviation_id` BIGINT COMMENT 'Unique identifier for the quality deviation record. Primary key for the quality deviation entity.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: Deviations are tracked against brands for brand-level quality trending, regulatory agency submissions, and commercial supply impact assessment. Annual Product Reviews require brand-level deviation agg',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: Product Quality Reviews (PQR/APR) and regulatory deviation trending require linking deviations to the drug_product master. 21 CFR 211.192 mandates product-level investigation records. product_code and',
    `equipment_id` BIGINT COMMENT 'Unique identifier of the equipment or instrument involved in the deviation, if applicable. Links to equipment master data for maintenance and qualification history.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Significant deviations trigger investigation projects requiring budget allocation and cost tracking. Internal orders capture investigation costs, testing expenses, and remediation activities, critical',
    `inventory_lot_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_lot. Business justification: Deviations affect specific inventory lots requiring quarantine/disposition decisions. Quality investigations must trace to physical inventory for batch release or rejection. Critical for GMP complianc',
    `investigational_site_id` BIGINT COMMENT 'Foreign key linking to clinical.investigational_site. Business justification: IMP quality deviations (temperature excursions, dispensing errors, storage failures) occur at investigational sites and must be linked to the site for GMP/GCP compliance reporting and CAPA management.',
    `line_id` BIGINT COMMENT 'Foreign key linking to manufacturing.line. Business justification: Quality deviations are detected on specific production lines. Line-level deviation trending is a standard pharma QMS requirement for identifying recurring issues on specific equipment trains. quality_',
    `material_id` BIGINT COMMENT 'Foreign key linking to masterdata.material. Business justification: Deviations are material-specific events in GMP manufacturing. The product_code plain attribute is a denormalized material reference. Material-level deviation trending, disposition decisions, and reg',
    `patient_access_program_id` BIGINT COMMENT 'Foreign key linking to market.patient_access_program. Business justification: Patient Access Program Quality Event Notification: a quality deviation affecting product supplied through a compassionate use or named patient program requires immediate program notification and poten',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Deviations are plant-specific GMP events. The facility_code plain attribute is a denormalized plant reference. Site-level quality metrics, regulatory inspection readiness reports, and GMP compliance',
    `treatment_exposure_id` BIGINT COMMENT 'Foreign key linking to patient.treatment_exposure. Business justification: Quality deviations on batches used in clinical trials must be traceable to patient treatment exposures for safety assessment and regulatory reporting. Pharma pharmacovigilance and QA teams require thi',
    `icsr_id` BIGINT COMMENT 'Foreign key linking to pharmacovigilance.icsr. Business justification: Quality deviations (contamination, mislabeling) suspected of causing patient harm must be linked to the originating ICSR for regulatory investigation. ICH Q10 and FDA 21 CFR 314.81 require traceabilit',
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
    `final_disposition` STRING COMMENT 'Approved final disposition of the affected batch or material after quality assurance review and approval.. Valid values are `released|reworked|reprocessed|rejected|used_as_is|returned`',
    `gmp_impact_classification` STRING COMMENT 'Risk-based classification of the deviations impact on product quality, patient safety, and GMP compliance. Critical deviations pose direct risk to patient safety or product efficacy; major deviations may affect product quality; minor deviations have negligible impact.. Valid values are `critical|major|minor`',
    `immediate_action_taken` STRING COMMENT 'Description of containment actions taken immediately upon discovery to prevent further impact, such as quarantine of affected material, equipment shutdown, or process hold.',
    `investigation_completed_date` DATE COMMENT 'Actual date when the deviation investigation was completed and documented, including root cause analysis and corrective action plan.',
    `investigation_due_date` DATE COMMENT 'Target date for completion of the deviation investigation, typically based on GMP impact classification and organizational quality standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the deviation record was last updated, supporting audit trail and change tracking requirements.',
    `occurrence_date` DATE COMMENT 'Estimated or confirmed date when the deviation actually occurred, which may differ from detection date. Used for root cause analysis and impact assessment.',
    `process_step` STRING COMMENT 'Specific manufacturing, testing, or operational step where the deviation occurred. Examples include blending, tablet compression, dissolution testing, or labeling.',
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
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: OOS investigations on commercial batches are tracked at brand level for regulatory reporting (Annual Product Reviews, FDA submissions) and commercial supply impact assessment. Pharma quality experts e',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: OOS trending reports by drug product are a core QC regulatory requirement (FDA OOS Guidance 2006). Direct drug_product link enables product-level OOS rate monitoring for Annual Product Reviews and bat',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: OOS investigations incur significant costs (extended testing, batch rejection, regulatory reporting). Tracking OOS investigation costs against internal orders is standard pharma quality cost accountin',
    `inventory_lot_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_lot. Business justification: OOS investigations determine inventory lot disposition (release/reject/quarantine). Investigation outcomes directly control inventory availability status. Essential for linking quality testing results',
    `lab_test_result_id` BIGINT COMMENT 'Reference to the specific laboratory test result that triggered the OOS investigation.',
    `material_id` BIGINT COMMENT 'Foreign key linking to masterdata.material. Business justification: OOS investigations are always conducted on a specific material/test article per FDA 21 CFR 211.192. LIMS integration, material-level OOS trending, and specification retrieval during Phase I/II investi',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: FDA 21 CFR 211.192 requires laboratory ownership of OOS investigations. The responsible lab org unit must be formally tracked for regulatory inspection readiness, CAPA assignment, and quality metrics ',
    `quality_deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: OOS investigations may identify deviations as the root cause of out-of-specification results. This FK links the OOS investigation to the resulting deviation record. Business case: Phase II OOS investi',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: OOS investigations are by definition triggered when a test result falls outside established specification limits. The specification_limit text field on oos_investigation currently stores this as a fre',
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
    `test_method` STRING COMMENT 'Analytical test method or procedure used that produced the OOS result (e.g., HPLC, dissolution, assay).',
    `test_parameter` STRING COMMENT 'Specific quality attribute or parameter being tested (e.g., potency, impurity level, dissolution rate).',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the observed result and specification limit (e.g., %, mg/mL, minutes).',
    CONSTRAINT pk_oos_investigation PRIMARY KEY(`oos_investigation_id`)
) COMMENT 'Out-of-Specification (OOS) investigation records for laboratory test results that fall outside established acceptance criteria. Captures Phase I (laboratory investigation) and Phase II (full-scale investigation) findings, assignability determination, retesting authorization, invalidation justification, final disposition, regulatory reporting obligation, and linkage to affected batch and test result. Governed by FDA OOS guidance and 21 CFR 211.192.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`change_control` (
    `change_control_id` BIGINT COMMENT 'Unique identifier for the quality change control record. Primary key.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: Change controls affecting commercial products require brand team notification and regulatory variation filings. Brand-level change control tracking is required for lifecycle management and regulatory ',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Change controls have country-specific regulatory notification requirements (EMA, FDA, PMDA). The affected_markets plain attribute is a denormalized country reference. Country-level regulatory impact',
    `drug_master_file_id` BIGINT COMMENT 'Foreign key linking to intellectual.drug_master_file. Business justification: FDA/EMA regulations require DMF amendments when manufacturing process changes affect API or excipient covered by a DMF. Change control records must reference the impacted DMF to manage DMF Amendment ',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: Post-approval CMC change management (FDA CBE-30, Prior Approval Supplements) requires linking change controls to specific drug products. affected_products is a denormalized plain-text field replaced b',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Change controls for equipment purchases, facility modifications, or system implementations create fixed assets. Essential for tracking change-driven capital expenditures, asset capitalization decision',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Major changes (equipment upgrades, process modifications, facility improvements) require capital or operational budget tracked via internal orders. Essential for change control project financial manag',
    `method_validation_id` BIGINT COMMENT 'Foreign key linking to quality.method_validation. Business justification: Change controls that modify analytical test methods require method (re)validation as a prerequisite for implementation. The validation_protocol_reference and validation_required fields on quality_chan',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Change controls are initiated and owned by specific org units (manufacturing, QC, regulatory affairs) in pharma QMS. GMP change management workflows, approval routing, and regulatory impact assessment',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Change controls are plant-specific in GMP environments — process changes, equipment qualifications, and SOP updates are scoped to specific manufacturing plants. Site-level change control reporting and',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Change controls in pharma QMS frequently involve updates to product or material specifications — revising acceptance criteria, adding new test parameters, or changing limits. This FK links a change co',
    `actual_implementation_date` DATE COMMENT 'Actual date when the change was implemented in production or operational environment.',
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
    CONSTRAINT pk_change_control PRIMARY KEY(`change_control_id`)
) COMMENT 'Change control records managing all proposed changes to processes, equipment, materials, facilities, systems, and documents under GMP. Captures change type (minor/major/critical), change rationale, risk assessment, regulatory impact assessment (requires prior approval vs. notification), validation/qualification requirements, implementation plan, affected products and markets, approval workflow status, and post-implementation review. Sourced from MasterControl/TrackWise and SAP QM.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`audit` (
    `audit_id` BIGINT COMMENT 'Primary key for audit',
    `master_id` BIGINT COMMENT 'Foreign key linking to hcp.master. Business justification: Pharma compliance audits of HCP speakers and contractors (not in investigator role) are a named regulatory process. The existing audited_investigator_id covers clinical investigators; this FK covers H',
    `investigator_id` BIGINT COMMENT 'Foreign key linking to hcp.investigator. Business justification: Clinical investigator audits assess individual investigator GCP compliance, protocol adherence, and data integrity. Critical for clinical trial quality assurance, regulatory inspections, and investiga',
    `capa_id` BIGINT COMMENT 'Foreign key linking to quality.quality_capa. Business justification: Audit findings (internal audits, regulatory inspections) trigger CAPA when deficiencies are identified. audit table has capa_required (BOOLEAN) but no FK to the actual CAPA record. One audit can trigg',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.quality_change_control. Business justification: Audit findings (particularly regulatory inspections and internal GMP audits) frequently mandate change control actions. This FK links an audit directly to the change control it triggered or is associa',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Regulatory inspections are jurisdiction-specific — FDA inspects US establishments, EMA inspects EU sites. Country-level audit scheduling, regulatory authority mapping, and inspection frequency complia',
    `distribution_network_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_network. Business justification: EU GDP Guidelines (2013/C 343/01) require periodic audits of distribution network nodes (3PLs, wholesalers, cold chain operators). Audit already links to plant_id for manufacturing sites but lacks a d',
    `oos_investigation_id` BIGINT COMMENT 'Foreign key linking to quality.oos_investigation. Business justification: Audits can uncover OOS investigations that require review or follow-up. This FK links audit findings to specific OOS investigation records. Business case: regulatory inspections may review OOS investi',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: GMP audits routinely inspect specific capitalized equipment and facilities. Linking audit to fixed_asset enables asset-level audit history required for FDA/EMA regulatory inspections and supports the ',
    `hco_master_id` BIGINT COMMENT 'Foreign key linking to hcp.hco_master. Business justification: Clinical site audits assess HCO compliance with GCP and protocol requirements. Essential for clinical trial quality assurance, regulatory inspections, and investigator site qualification tracking.',
    `health_authority_id` BIGINT COMMENT 'Foreign key linking to regulatory.health_authority. Business justification: GMP inspections are conducted by specific health authorities (FDA, EMA, PMDA). Linking audit to health_authority enables inspection history tracking by agency, supports inspection readiness programs, ',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: External audits and regulatory inspections trigger remediation projects requiring dedicated budget allocation. Internal orders track audit response costs, consultant fees, and remediation expenses, cr',
    `investigational_site_id` BIGINT COMMENT 'Foreign key linking to clinical.investigational_site. Business justification: ICH E6 R2 requires sponsors to conduct GCP audits at investigational sites. The audit table has no FK to investigational_site despite audit_type covering GCP site audits. This link enables site-level ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Regulatory inspections (FDA, EMA) are conducted at the legal entity level against the FDA Establishment Identifier. Form 483 issuance, Warning Letters, and consent decrees are legal entity-level regul',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: Pharma companies conduct GMP/quality audits of licensees and CMOs as a contractual obligation under licensing agreements. The audit record must reference the governing licensing agreement for License',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Audits are scoped to specific org units (QC laboratory, manufacturing, regulatory affairs) within a plant. GMP audit scheduling, finding assignment, and CAPA routing require formal org unit scoping be',
    `plant_id` BIGINT COMMENT 'Foreign key reference to the master facility or site record in the Master Data domain. Links the audit to the specific manufacturing, warehouse, or laboratory facility.',
    `pv_agreement_id` BIGINT COMMENT 'Foreign key linking to pharmacovigilance.pv_agreement. Business justification: PV agreements with partners (licensees, co-marketing partners) require periodic compliance audits to verify ICSR exchange timelines and signal management obligations. EMA GVP Module I requires audit o',
    `quality_deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: Audits frequently identify deviations from approved procedures. This FK captures the specific deviation record that was identified during an audit finding. Business case: regulatory inspections (FDA F',
    `sales_rep_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_rep. Business justification: Audits of individual sales rep activities (sample distribution compliance, call documentation accuracy, promotional practices) are mandatory for FDA/PhRMA compliance. Links audit findings to specific ',
    `site_id` BIGINT COMMENT 'Foreign key linking to manufacturing.site. Business justification: GMP regulatory inspections (FDA, EMA) and internal audits are conducted at specific manufacturing sites. audit has plant_id→masterdata.plant but no site_id→manufacturing.site. Pharma compliance teams ',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Pre-Approval Inspections (PAI) are GMP audits directly tied to a pending NDA/BLA submission. Linking audit to submission enables PAI outcome tracking against the submission it supports — a standard re',
    `trial_id` BIGINT COMMENT 'Foreign key linking to clinical.trial. Business justification: GCP audits of clinical trials are mandated by ICH E6 R2 sponsor oversight requirements. Sponsors must track which trials have been audited, audit outcomes, and next audit dates. No existing column on ',
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
    `drug_product_id` BIGINT COMMENT 'Identifier for the product (drug substance, drug product, or raw material) being tested. Links to product master.',
    `drug_substance_id` BIGINT COMMENT 'Foreign key linking to product.drug_substance. Business justification: API release testing and identity/purity testing generate lab results directly against drug substances. ICH Q6A requires substance-level test result records. Direct drug_substance link enables API CoA ',
    `equipment_id` BIGINT COMMENT 'Identifier for the analytical instrument used to perform the test. Links to equipment master in LIMS or MES (Manufacturing Execution System).',
    `inventory_lot_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_lot. Business justification: Test results determine inventory lot release status and CoA generation. Quality testing directly gates inventory availability for distribution. Critical for batch release workflow and traceability fro',
    `material_id` BIGINT COMMENT 'Foreign key linking to masterdata.material. Business justification: Lab test results are always performed on a specific material. LIMS integration, material-level quality trending, OOS rate calculation by material, and specification compliance reporting all require a ',
    `method_validation_id` BIGINT COMMENT 'Identifier for the validated analytical test method used. References the method master in LIMS.',
    `original_test_result_lab_test_result_id` BIGINT COMMENT 'Reference to the original test result if this is a retest. Links to another lab_test_result record.',
    `quality_deviation_id` BIGINT COMMENT 'Identifier for any deviation record associated with this test result. Links to deviation management system.',
    `site_id` BIGINT COMMENT 'Identifier for the manufacturing or laboratory site where the test was performed. Links to site master.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Lab test results are evaluated against product/material specifications. This FK links each test result to the specification that defines the acceptance criteria. Business case: test results must refer',
    `stability_study_id` BIGINT COMMENT 'Identifier for the stability study if this test is part of a stability protocol. Links to stability study master.',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: Lab test results have a unit_of_measure plain attribute that is a denormalized UoM reference. Formal UoM linkage enforces 3NF, enables cross-material result comparison, and supports LIMS-to-ERP inte',
    `analyst_name` STRING COMMENT 'Full name of the laboratory analyst who performed the test.',
    `approved_by_name` STRING COMMENT 'Full name of the QA person who approved the test result.',
    `approved_date` TIMESTAMP COMMENT 'Date and time when the test result was approved by Quality Assurance.',
    `approved_flag` BOOLEAN COMMENT 'Boolean indicator that the test result has been approved by Quality Assurance (QA) for release or further processing.',
    `coa_inclusion_flag` BOOLEAN COMMENT 'Boolean indicator that this test result is included in the Certificate of Analysis issued for the batch.',
    `comments` STRING COMMENT 'Free-text comments or observations recorded by the analyst or reviewer regarding the test execution or result.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this test result record was first created in the LIMS system. Audit trail field.',
    `instrument_name` STRING COMMENT 'Name or model of the analytical instrument used (e.g., Agilent HPLC 1260, Distek Dissolution Apparatus).',
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
    CONSTRAINT pk_lab_test_result PRIMARY KEY(`lab_test_result_id`)
) COMMENT 'Laboratory quality control test results from LIMS (LabWare/SampleManager) capturing analytical testing of raw materials, in-process samples, drug substance, drug product, and stability samples. Records test method, instrument used, analyst, test date, raw result value, unit of measure, specification limit (lower/upper), pass/fail determination, OOS/OOT flag, reviewed/approved status, and CoA inclusion flag. Primary source for OOS and OOT investigations.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` (
    `stability_study_id` BIGINT COMMENT 'Unique identifier for the stability study record. Primary key.',
    `access_strategy_id` BIGINT COMMENT 'Foreign key linking to market.access_strategy. Business justification: Stability data (shelf life, storage conditions, temperature excursions) directly informs market access strategy, HTA submissions, and reimbursement negotiations. Payers evaluate product handling requi',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Stability studies are initiated on specific manufacturing batches; shelf-life determination, regulatory submissions, and retest date assignment require full batch manufacturing context and history. Re',
    `drug_product_id` BIGINT COMMENT 'Reference to the drug product or drug substance under stability evaluation. Links to master product data.',
    `drug_substance_id` BIGINT COMMENT 'Foreign key linking to product.drug_substance. Business justification: ICH Q1A(R2) mandates stability studies for drug substances to establish retest periods. API stability programs are conducted independently of drug product studies. Direct drug_substance link is requir',
    `formulation_id` BIGINT COMMENT 'Foreign key linking to product.formulation. Business justification: Stability studies are conducted on specific formulations to establish shelf-life. Formulation composition directly impacts degradation pathways. Essential for regulatory submissions (ICH Q1A) and supp',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Stability studies are multi-year, high-cost analytical programs with dedicated internal orders for cost tracking in SAP. This link enables quality cost reporting, R&D capitalization decisions, and bud',
    `inventory_lot_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_lot. Business justification: Stability data supports shelf-life and retest date management for inventory lots. Study results inform expiry date extensions or reductions. Essential for inventory aging management and regulatory com',
    `material_id` BIGINT COMMENT 'Foreign key linking to masterdata.material. Business justification: Stability studies are conducted on specific materials per ICH Q1A guidelines. Material-level shelf life determination, retest date calculation, and regulatory submission of stability data require a fo',
    `method_validation_id` BIGINT COMMENT 'Foreign key linking to quality.method_validation. Business justification: Stability studies use validated analytical methods to test samples at each time point. Currently test_parameters is stored as STRING. One stability study uses one primary validated method (1:N relatio',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Stability studies are owned by specific org units (stability lab, regulatory affairs). ICH Q1A-compliant stability program management, study assignment, and regulatory commitment tracking require form',
    `packaging_configuration_id` BIGINT COMMENT 'Foreign key linking to product.packaging_configuration. Business justification: Stability studies are conducted in final packaging configurations. Container-closure system is a critical stability study parameter per ICH Q1A. Shelf-life and storage conditions are packaging-specifi',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing or testing site where the stability study is conducted. Links to site master data for GMP compliance tracking.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Stability studies test product stability against specifications. This FK links the stability study to the specification that defines the acceptance criteria. Business case: stability testing must refe',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Stability data packages are submitted to health authorities as part of NDA/BLA dossiers, annual reports, and post-approval variations. regulatory_commitment_flag and regulatory_submission_reference (p',
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
    `assay_id` BIGINT COMMENT 'Foreign key linking to discovery.assay. Business justification: FDA Bioanalytical Method Validation guidance (BMV) requires validated methods to be traceable to the specific assay they validate. Regulatory-submission-eligible discovery assays (GLP-compliant biomar',
    `drug_master_file_id` BIGINT COMMENT 'Foreign key linking to intellectual.drug_master_file. Business justification: Analytical methods validated for DMF-covered materials must reference DMF analytical procedures. Required for regulatory submission consistency and demonstrating method equivalence to DMF holder metho',
    `drug_product_id` BIGINT COMMENT 'Reference to the drug product or drug substance for which the method is validated. Links to product master data.',
    `drug_substance_id` BIGINT COMMENT 'Foreign key linking to product.drug_substance. Business justification: ICH Q2(R1) method validation for API assay, impurity, and identity methods is conducted at the drug substance level. Regulatory submissions (CTD 3.2.S.4.3) require method validation reports linked to ',
    `formulation_id` BIGINT COMMENT 'Foreign key linking to product.formulation. Business justification: Method validations are formulation-specific for non-compendial analytical methods. Formulation changes (excipient type, API particle size) require method revalidation per ICH Q2(R1). Critical for CMC ',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Analytical method validation projects carry significant lab costs tracked as internal orders in pharma SAP environments. This link enables quality cost reporting and supports R&D capitalization assess',
    `material_id` BIGINT COMMENT 'Foreign key linking to masterdata.material. Business justification: Method validations are material-specific — the analytical method validates testing of a specific drug substance or product. The product_name and api_name plain attributes are denormalized material',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Method validations are performed by specific analytical lab org units per ICH Q2(R1). Lab ownership tracking, validation protocol approval routing, and regulatory submission of validation reports requ',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Analytical methods may be patented or patent-protected technology. Link supports IP portfolio management, licensing agreement compliance, and patent prosecution when method innovations are claimed. Co',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing or laboratory site where the method validation was performed. Links to site master data.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Analytical method validations are performed to demonstrate that a test method meets the acceptance criteria defined in a specification. One method validation is performed for one specification (1:N re',
    `accuracy_recovery_percent_mean` DECIMAL(18,2) COMMENT 'Mean recovery percentage from accuracy studies, typically expected to be 98-102% for assay methods.',
    `accuracy_result` STRING COMMENT 'Outcome of the accuracy assessment. Pass indicates recovery within predefined acceptance criteria across the method range.. Valid values are `pass|fail|not_assessed`',
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
    `regulatory_submission_flag` BOOLEAN COMMENT 'Indicates whether this method validation is included in a regulatory submission (IND, NDA, BLA, MAA). True if included in regulatory dossier, False otherwise.',
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
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.approval. Business justification: Certificates of Analysis for commercial batches must reference the marketing authorization under which the product is approved. regulatory_authority and regulatory_market on coa are plain-text denorma',
    `batch_record_id` BIGINT COMMENT 'Reference to the manufacturing batch for which this CoA is issued.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: COAs are issued per batch for specific brands and provided to commercial customers as proof of quality release. Brand-level COA tracking is standard in pharma quality systems for customer service and ',
    `business_partner_id` BIGINT COMMENT 'Reference to the customer or recipient organization for whom this CoA is issued (for commercial distribution).',
    `contract_account_id` BIGINT COMMENT 'Foreign key linking to commercial.contract_account. Business justification: Certificates of Analysis issued to commercial customers/distributors for batch release documentation. Required for customer quality agreements, regulatory compliance, and commercial shipment authoriza',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: COAs are market-specific documents — different regulatory markets (EU, US, Japan) require different COA formats and test requirements. The regulatory_market plain attribute is a denormalized country',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: Certificate of Analysis is issued per drug product batch for GMP batch release. CoA generation systems require direct drug_product linkage for test method references, specification retrieval, and cust',
    `drug_substance_id` BIGINT COMMENT 'Foreign key linking to product.drug_substance. Business justification: API manufacturers issue CoAs for drug substance batches supplied to drug product manufacturers. ICH Q7 GMP for APIs requires CoA issuance per substance batch. Direct drug_substance link enables API Co',
    `hco_master_id` BIGINT COMMENT 'Foreign key linking to hcp.hco_master. Business justification: COAs are routinely issued to hospital pharmacies and HCOs receiving drug shipments. Linking COA to HCO enables traceability for product release to institutional customers, required for GMP compliance ',
    `inventory_lot_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_lot. Business justification: CoA is the quality release document enabling inventory availability for distribution. Each CoA certifies a specific inventory lot for commercial release. Critical for batch release workflow and custom',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: COAs are issued by a GMP-authorized legal entity (the QP-releasing manufacturer). The issuing_site_name plain attribute is a denormalized legal entity reference. Regulatory market authorization and ',
    `material_id` BIGINT COMMENT 'Foreign key linking to masterdata.material. Business justification: COAs are issued for specific materials/batches. The material_type plain attribute is a denormalized material reference. Customer-facing COA generation, material specification retrieval, and GMP rele',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the product (drug substance, drug product, excipient, or raw material) for which this CoA is issued.',
    `packaging_configuration_id` BIGINT COMMENT 'Foreign key linking to product.packaging_configuration. Business justification: COAs are issued for specific packaging configurations with unique NDC codes. Market-specific release, serialization compliance, and customer-specific COA formats require packaging-level tracking. Esse',
    `payer_contract_id` BIGINT COMMENT 'Foreign key linking to market.payer_contract. Business justification: Certain payer contracts (specialty, high-value biologics, government) contractually require Certificate of Analysis documentation for each batch supplied. COA must be linked to contract for compliance',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: COAs are issued to accompany specific sales orders/shipments. Commercial customers require COAs matched to their purchase orders for GMP compliance. Pharma distribution requires COA-to-sales-order tra',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing or testing site that issued this CoA.',
    `specification_id` BIGINT COMMENT 'Reference to the quality specification document used for testing this batch.',
    `authorized_signatory_name` STRING COMMENT 'Name of the Quality Assurance personnel who authorized and signed the CoA.',
    `batch_lot_number` STRING COMMENT 'The batch or lot number of the drug substance, drug product, excipient, or raw material covered by this CoA.',
    `coa_number` STRING COMMENT 'Business identifier for the certificate of analysis, typically following a site-specific numbering convention.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this CoA record was first created in the system.',
    `document_version` STRING COMMENT 'Version number of this CoA document, incremented when reissued or revised.',
    `expiry_date` DATE COMMENT 'Date beyond which the material should not be used, based on stability data and regulatory requirements.',
    `glp_compliance_flag` BOOLEAN COMMENT 'Indicates whether testing was conducted under Good Laboratory Practice (GLP) conditions, typically for preclinical materials.',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Indicates whether the batch was manufactured under current Good Manufacturing Practice (cGMP) conditions.',
    `issued_timestamp` TIMESTAMP COMMENT 'Date and time when this CoA was officially issued and made available to the recipient.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this CoA record was last modified or updated.',
    `lims_reference_number` STRING COMMENT 'Reference number or sample ID from the Laboratory Information Management System (LIMS) used for tracking test results.',
    `manufacturing_date` DATE COMMENT 'Date when the batch was manufactured or compounded.',
    `qa_reviewer_name` STRING COMMENT 'Name of the Quality Assurance reviewer who performed the final review before CoA issuance.',
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
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.approval. Business justification: Commercial batch release requires confirming the batch meets specifications under a valid marketing authorization. QPs reference the specific approval when releasing batches to market. regulatory_hold',
    `batch_record_id` BIGINT COMMENT 'Reference to the manufacturing batch record subject to disposition decision. Links to the batch master record in SAP QM.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: Batch disposition decisions (release/reject/quarantine) directly affect commercial supply availability per brand. Brand teams monitor batch disposition status for launch readiness and supply continuit',
    `coa_id` BIGINT COMMENT 'Reference to the Certificate of Analysis document that summarizes all quality control test results supporting the disposition decision.',
    `drug_product_id` BIGINT COMMENT 'Reference to the drug product or drug substance master record for which this batch was manufactured.',
    `drug_substance_id` BIGINT COMMENT 'Foreign key linking to product.drug_substance. Business justification: QP batch disposition decisions are made for drug substance batches (API release/rejection) as a distinct GMP process from drug product disposition. ICH Q7 requires documented disposition for each API ',
    `inventory_lot_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_lot. Business justification: Disposition decisions (release/reject/quarantine) directly control inventory lot status and availability. QP release authorization gates inventory for distribution. Essential for integrating quality d',
    `material_id` BIGINT COMMENT 'Foreign key linking to masterdata.material. Business justification: Batch disposition decisions are material-specific — QP release, rejection, or reprocessing decisions are made per material batch. Material-level disposition tracking, regulatory hold management, and s',
    `packaging_configuration_id` BIGINT COMMENT 'Foreign key linking to product.packaging_configuration. Business justification: Disposition decisions are made at packaging configuration level for market-specific release. Different markets may have different disposition outcomes for the same bulk product. NDC-level disposition ',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Batch disposition is a plant-specific GMP activity — QP release authority is granted per manufacturing plant per EU GMP Annex 16. Plant-level disposition reporting, regulatory hold tracking, and relea',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing site or facility where the batch was produced. Critical for site-specific regulatory compliance and traceability.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to masterdata.storage_location. Business justification: Batch disposition references a quarantine storage location for rejected/held batches. The quarantine_location plain attribute is a denormalized storage location reference. GMP quarantine management,',
    `icsr_id` BIGINT COMMENT 'Foreign key linking to pharmacovigilance.icsr. Business justification: Batch disposition decisions (reject/recall/quarantine) are often triggered by adverse event reports linked to specific batches. Business process: when ICSRs identify batch-specific safety issues, disp',
    `safety_signal_id` BIGINT COMMENT 'Foreign key linking to pharmacovigilance.safety_signal. Business justification: Safety signals identifying a product risk can trigger quarantine or rejection of distributed batches before an ICSR is formally filed. QP batch release decisions must reference the safety signal that ',
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
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: Product complaints are filed against specific brands for FDA complaint file maintenance, brand-level quality trending, and commercial brand team escalation. A pharma quality expert expects complaint r',
    `capa_id` BIGINT COMMENT 'Foreign key linking to quality.quality_capa. Business justification: Product quality complaints often trigger CAPA when investigation reveals systemic issues requiring corrective/preventive action. One complaint can trigger one CAPA (1:N relationship). This FK enables ',
    `coa_id` BIGINT COMMENT 'Foreign key linking to quality.coa. Business justification: When a product quality complaint is received, the Certificate of Analysis for the implicated batch is a critical reference document for the investigation — it provides the original release test result',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Complaints have a market_of_origin plain attribute that is a denormalized country reference. Country-level complaint trending, pharmacovigilance signal detection by market, and country-specific regu',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: 21 CFR 211.198 requires complaint files organized by drug product. Product complaint trending by drug_product_id is mandatory for signal detection, Annual Product Reviews, and FDA inspection readiness',
    `hco_master_id` BIGINT COMMENT 'Foreign key linking to hcp.hco_master. Business justification: Hospitals and clinics report institutional product complaints for products administered in their facilities. Tracks originating healthcare organization for complaint investigation and institutional tr',
    `icsr_id` BIGINT COMMENT 'Foreign key linking to pharmacovigilance.icsr. Business justification: Product complaints frequently trigger or correlate with adverse event reports. Regulatory requirement: complaint handling systems must link consumer complaints to ICSRs for signal detection, trend ana',
    `inventory_lot_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_lot. Business justification: Complaint investigations must trace to specific inventory lots for recall risk assessment and market withdrawal decisions. Critical for linking customer complaints to physical inventory for dispositio',
    `investigator_id` BIGINT COMMENT 'Foreign key linking to hcp.investigator. Business justification: Product quality complaints originating from clinical trial sites must be linked to the responsible investigator for FDA MedWatch and EudraVigilance regulatory reporting. This is distinct from the exis',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to finance.invoice. Business justification: Product complaints in pharma trigger credit memos, returns, and invoice adjustments. Tracing complaint to originating invoice is required for financial reconciliation, chargeback processing, and SOX-c',
    `master_id` BIGINT COMMENT 'Foreign key linking to hcp.hcp_master. Business justification: Physicians frequently report product quality complaints and adverse events. Links complaint to reporting HCP for trend analysis, regulatory reporting, and follow-up. Replaces denormalized complainant_',
    `material_id` BIGINT COMMENT 'Foreign key linking to masterdata.material. Business justification: Complaints are material-specific quality events. The product_name and ndc_code plain attributes are denormalized material references. Material-level complaint trending, signal detection, and regul',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the pharmaceutical product (Drug Product or Drug Substance) that is the subject of the complaint.',
    `oos_investigation_id` BIGINT COMMENT 'Foreign key linking to quality.oos_investigation. Business justification: Product complaints about quality issues may trigger OOS investigations when retained samples are retested. This FK links the complaint to the resulting OOS investigation. Business case: complaint abou',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Complaints are handled by specific org units (customer quality, medical affairs, pharmacovigilance). GMP complaint management workflows, investigation assignment, and regulatory response tracking requ',
    `packaging_configuration_id` BIGINT COMMENT 'Foreign key linking to product.packaging_configuration. Business justification: Complaints reference specific NDC codes and packaging types. Packaging defects (label errors, container integrity, device malfunction) are major complaint categories. Packaging-level traceability is r',
    `patient_access_program_id` BIGINT COMMENT 'Foreign key linking to market.patient_access_program. Business justification: Patient Support Program Complaint Management: complaints about hub services, copay assistance failures, or specialty pharmacy issues are categorized against the specific patient access program. Pharma',
    `adverse_event_id` BIGINT COMMENT 'Foreign key linking to patient.adverse_event. Business justification: Regulatory requirement (FDA 21 CFR 314.80, EMA guidelines) to cross-reference product quality complaints with adverse events for integrated safety/quality signal detection. Real process: complaint int',
    `patient_enrollment_id` BIGINT COMMENT 'Foreign key linking to patient.patient_enrollment. Business justification: Product complaints from clinical trial participants must be traceable to their enrollment record to determine regulatory reporting obligations (IND safety reporting, GCP). Pharma QA and pharmacovigila',
    `patient_id` BIGINT COMMENT 'Foreign key linking to patient.patient. Business justification: Product complaints frequently originate from patients reporting quality issues (packaging defects, foreign matter, appearance). Real business process: complaint intake captures patient identity for fo',
    `product_recall_id` BIGINT COMMENT 'Foreign key linking to supply.product_recall. Business justification: Product complaints are a primary recall trigger per FDA 21 CFR 211.198 and EU GMP Chapter 8. Complaint trend analysis drives recall decisions. Pharma QA and regulatory affairs teams require direct tra',
    `protocol_deviation_id` BIGINT COMMENT 'Foreign key linking to patient.protocol_deviation. Business justification: Product complaints from clinical trial sites (e.g., wrong product administered, packaging defect) may be directly associated with a protocol deviation. GCP requires traceability between product qualit',
    `pv_adverse_reaction_id` BIGINT COMMENT 'Foreign key linking to pharmacovigilance.pv_adverse_reaction. Business justification: Product complaints involving patient harm are dual-reported as quality complaints and PV adverse reactions. Complaint handling systems must link to the specific pv_adverse_reaction record for MedDRA c',
    `quality_deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: Product complaints often trigger deviation investigations when the complaint reveals a departure from approved procedures. This FK links the complaint to the resulting deviation record. Business case:',
    `sales_rep_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_rep. Business justification: Product complaints often originate from sales rep territories; tracking originating rep enables follow-up investigation, customer communication, and adverse event reporting. Required for pharmacovigil',
    `sample_request_id` BIGINT COMMENT 'Foreign key linking to hcp.sample_request. Business justification: Product quality complaints (e.g., damaged packaging, suspected contamination) reported by HCPs about samples they received must be traceable to the originating sample request for FDA sample accountabi',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Regulatory-reportable complaints (regulatory_reportable_flag=true) must be linked to the regulatory submission (e.g., safety report, expedited report, annual report) filed with the health authority. T',
    `territory_id` BIGINT COMMENT 'Foreign key linking to commercial.territory. Business justification: Geographic complaint analysis by territory enables safety signal detection, market surveillance, and targeted corrective actions. Required for FDA adverse event reporting, trend analysis, and territor',
    `trademark_id` BIGINT COMMENT 'Foreign key linking to intellectual.trademark. Business justification: Product quality complaints in pharma must be tracked against the specific branded trademark under which the product was sold. Brand protection, regulatory complaint reporting (FDA MedWatch, EMA), and ',
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
    `occurrence_date` DATE COMMENT 'Date when the product quality issue or adverse event allegedly occurred, as reported by the complainant.',
    `patient_impact_flag` BOOLEAN COMMENT 'Indicates whether the complaint involves actual or potential patient harm, safety concern, or adverse event requiring pharmacovigilance assessment.',
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
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: Process validation is a regulatory prerequisite for commercial launch and lifecycle management of a brand. Regulatory submissions for brand approval reference validation status. Brand teams track vali',
    `change_control_id` BIGINT COMMENT 'Reference to the change control record that triggered or is associated with this validation activity. Links validation to change management process.',
    `distribution_network_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_network. Business justification: Equipment validations (cold chain, temperature mapping) support GDP authorization for distribution network nodes. Validation status is required for site qualification and regulatory inspections. Criti',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: FDA Process Validation Guidance (2011) requires process validation linked to specific drug products across all three stages. Validation master plans and regulatory submissions (NDA/BLA CMC sections) r',
    `equipment_id` BIGINT COMMENT 'Reference to the specific equipment or asset being validated. Applicable for equipment qualification (IQ/OQ/PQ) and cleaning validation.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Equipment qualification (IQ/OQ/PQ) in pharma is performed on specific capitalized fixed assets. Linking validation to fixed_asset enables GMP asset qualification lifecycle tracking and supports regula',
    `formulation_id` BIGINT COMMENT 'Foreign key linking to product.formulation. Business justification: Process validations (IQ/OQ/PQ) qualify manufacturing of specific formulations. Formulation changes trigger revalidation per FDA process validation guidance. PPQ batches and concurrent validation are f',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Validation projects (equipment qualification, process validation, cleaning validation) require significant budget allocation and cost tracking. Internal orders capture validation costs for financial r',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: Technology transfer and licensing agreements in pharma mandate specific process validation requirements as license conditions. Validation records must reference the governing licensing agreement for ',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the drug product or drug substance being validated. Applicable for process validation and product-specific equipment validation.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Validations are owned by specific org units (validation group, QA, engineering) in GMP environments. Protocol approval routing, revalidation scheduling, and GMP compliance reporting by organizational ',
    `packaging_configuration_id` BIGINT COMMENT 'Foreign key linking to product.packaging_configuration. Business justification: Packaging validation (container closure integrity, packaging line qualification) is performed for specific packaging configurations per USP <1207> and GMP requirements. Validation protocols must refer',
    `plan_id` BIGINT COMMENT 'Foreign key linking to supply.plan. Business justification: Process validation batches are planned in the supply plan (validation batches consume capacity and materials). FDA Process Validation Guidance (2011) requires validation activities to be integrated wi',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing site or facility where the validation is being performed.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Process validation, cleaning validation, and equipment qualification activities are performed against defined acceptance criteria that are formally captured in specifications. The acceptance_criteria ',
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
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Specifications are market/country-specific — different pharmacopoeial standards (USP, EP, JP) apply per country. The market_authorization plain attribute is a denormalized country reference. Country',
    `drug_master_file_id` BIGINT COMMENT 'Foreign key linking to intellectual.drug_master_file. Business justification: Specifications reference DMF sections for API and excipient quality standards. Required for regulatory filing consistency, DMF cross-referencing in NDAs/ANDAs, and ensuring specification alignment wit',
    `drug_product_id` BIGINT COMMENT 'Reference to the product or material master record this specification applies to. Links to product master data.',
    `drug_substance_id` BIGINT COMMENT 'Foreign key linking to product.drug_substance. Business justification: Drug substance specifications are foundational for API release testing. Pharmacopoeial monographs and in-house impurity limits are substance-specific. Required for regulatory submissions (CTD Module 3',
    `excipient_id` BIGINT COMMENT 'Foreign key linking to product.excipient. Business justification: Excipient specifications define acceptance criteria for incoming materials. Compendial (USP/EP) vs. in-house specifications are excipient-specific. Required for incoming material release, supplier qua',
    `formulation_id` BIGINT COMMENT 'Foreign key linking to product.formulation. Business justification: Specifications are written at formulation level, defining acceptance criteria for CQAs. QbD design space and control strategy link directly to formulation specifications. Formulation-level specs drive',
    `material_id` BIGINT COMMENT 'Foreign key linking to masterdata.material. Business justification: Specifications are defined for specific materials — this is the core of pharma quality control. The material_code, material_description, and material_type plain attributes are denormalized mater',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Specifications are owned and approved by specific org units (QC, regulatory affairs). Specification lifecycle management, approval workflows, and regulatory submission tracking require formal org unit',
    `packaging_configuration_id` BIGINT COMMENT 'Foreign key linking to product.packaging_configuration. Business justification: Packaging specifications (container closure integrity, label dimensions, GTIN) are defined per packaging configuration and submitted in CTD Module 3.2.P.7. Regulatory agencies require packaging specif',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Specifications embody patented formulation ranges, process parameters, and quality attributes claimed in patents. Essential for patent prosecution evidence, regulatory defense of patent scope, and fre',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing site or facility where this specification is applicable. Links to site master data.',
    `superseded_by_specification_id` BIGINT COMMENT 'Reference to the newer specification version that supersedes this one. Null if this is the current effective version.',
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
    `business_partner_id` BIGINT COMMENT 'Foreign key linking to masterdata.business_partner. Business justification: Supplier qualifications are conducted for specific business partners (suppliers, CMOs, CLOs). Approved Vendor List (AVL) management, GMP qualification status tracking, and supplier performance monitor',
    `capa_id` BIGINT COMMENT 'Foreign key linking to quality.quality_capa. Business justification: Supplier qualification failures, performance issues (low performance_score, high capa_count_last_12_months), or audit findings against a supplier frequently trigger formal CAPA processes. This FK link',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.quality_change_control. Business justification: Changes to supplier qualification status, approved material scope, quality agreements, or supplier risk tier must be managed through the formal change control process per GMP requirements. This FK lin',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Supplier qualifications have regulatory_market_coverage plain attribute that is a denormalized country reference. Country-specific supplier approval scope, regulatory authority recognition (FDA, EMA',
    `distribution_network_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_network. Business justification: EU GDP Guidelines require formal qualification of distribution network operators (3PLs, wholesalers, cold chain providers) as approved suppliers. Supplier qualification records must be linked to the s',
    `dmf_id` BIGINT COMMENT 'Foreign key linking to regulatory.dmf. Business justification: API and excipient supplier qualifications are directly tied to Drug Master Files filed with health authorities. QA teams reference the DMF when qualifying suppliers, and DMF status (active/withdrawn) ',
    `drug_master_file_id` BIGINT COMMENT 'Foreign key linking to intellectual.drug_master_file. Business justification: Supplier qualifications verify DMF holder status and Letter of Authorization validity. GMP requirement for pharmaceutical supply chain qualification and regulatory inspection readiness. Ensures DMF cr',
    `drug_substance_id` BIGINT COMMENT 'Foreign key linking to product.drug_substance. Business justification: API suppliers are qualified for specific drug substances. DMF references, GMP audits, and impurity profiles are substance-specific. Essential for API sourcing decisions, supply chain risk management, ',
    `excipient_id` BIGINT COMMENT 'Foreign key linking to product.excipient. Business justification: Supplier qualifications approve specific excipients with defined functional categories and grades. Excipient source changes require supplier requalification and change control. Critical for supply cha',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Supplier qualification projects (audits, testing, documentation review) require budget allocation and cost tracking. Internal orders capture supplier qualification costs, essential for vendor manageme',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: Supplier qualifications for licensed technology or contract manufacturing under licensing agreements require agreement compliance verification. Ensures licensed manufacturing rights are properly exerc',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Supplier qualifications are managed by specific org units (supplier quality, procurement quality). GMP supplier qualification workflows, audit scheduling, and quality agreement management require form',
    `site_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_site. Business justification: Supplier qualifications and approved supplier lists are site-specific; each manufacturing site maintains its own qualified supplier base for raw materials, excipients, and services per site-specific q',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Supplier qualification involves testing incoming drug substances, excipients, and materials against approved specifications. The approved_material_scope text field captures scope broadly, but a direct',
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
    `requalification_frequency_months` STRING COMMENT 'Frequency in months at which the supplier must be re-qualified. Typical values are 12, 24, or 36 months depending on supplier risk tier and regulatory requirements.',
    `risk_tier` STRING COMMENT 'Risk classification of the supplier based on the criticality of materials or services provided, regulatory impact, and supplier performance history. Critical indicates highest risk requiring stringent oversight; high indicates significant risk; medium indicates moderate risk; low indicates minimal risk.. Valid values are `critical|high|medium|low`',
    `source_system` STRING COMMENT 'Operational system of record from which this supplier qualification record originated. Typically MasterControl, TrackWise, or Veeva Vault QualityDocs.. Valid values are `mastercontrol|trackwise|veeva_vault_qualitydocs`',
    `supplier_type` STRING COMMENT 'Classification of the supplier based on the materials or services provided. Contract Manufacturing Organization (CMO) manufactures drug product; Contract Development and Manufacturing Organization (CDMO) provides development and manufacturing; Contract Research Organization (CRO) conducts research and clinical trials; Active Pharmaceutical Ingredient (API) supplier provides drug substance; excipient supplier provides inactive ingredients; packaging supplier provides primary or secondary packaging materials; equipment supplier provides manufacturing equipment; service provider offers validation, testing, or consulting services. [ENUM-REF-CANDIDATE: cmo|cdmo|cro|api_supplier|excipient_supplier|packaging_supplier|equipment_supplier|service_provider — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_supplier_qualification PRIMARY KEY(`supplier_qualification_id`)
) COMMENT 'Quality qualification, agreement, and ongoing oversight records for approved suppliers, CMOs, CDMOs, and CROs providing materials or services under GMP. Captures supplier qualification status (approved/conditional/disqualified), qualification type (audit-based, questionnaire, CoA review), approved material/service scope, quality agreement details (GMP responsibilities matrix, regulatory market coverage, agreement type, effective/expiry dates, review cycle, counterparty obligations), re-qualification schedule, risk tier classification, performance metrics, and approval workflow. Serves as the single quality record for supplier relationships — distinct from procurement vendor master. Sourced from MasterControl/TrackWise and Veeva Vault QualityDocs.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_lab_test_result_id` FOREIGN KEY (`lab_test_result_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`lab_test_result`(`lab_test_result_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_method_validation_id` FOREIGN KEY (`method_validation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`method_validation`(`method_validation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_oos_investigation_id` FOREIGN KEY (`oos_investigation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`oos_investigation`(`oos_investigation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_coa_id` FOREIGN KEY (`coa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`coa`(`coa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_method_validation_id` FOREIGN KEY (`method_validation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`method_validation`(`method_validation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_original_test_result_lab_test_result_id` FOREIGN KEY (`original_test_result_lab_test_result_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`lab_test_result`(`lab_test_result_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_stability_study_id` FOREIGN KEY (`stability_study_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`stability_study`(`stability_study_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_method_validation_id` FOREIGN KEY (`method_validation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`method_validation`(`method_validation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ADD CONSTRAINT `fk_quality_method_validation_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ADD CONSTRAINT `fk_quality_batch_disposition_coa_id` FOREIGN KEY (`coa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`coa`(`coa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_coa_id` FOREIGN KEY (`coa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`coa`(`coa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_oos_investigation_id` FOREIGN KEY (`oos_investigation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`oos_investigation`(`oos_investigation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_superseded_by_specification_id` FOREIGN KEY (`superseded_by_specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`audit`(`audit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);

-- ========= TAGS =========
ALTER SCHEMA `pharmaceuticals_ecm`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `pharmaceuticals_ecm`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `hco_master_id` SET TAGS ('dbx_business_glossary_term' = 'Hco Master Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Investigator Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Physician Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Deviation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `icsr_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Icsr Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `capa_number` SET TAGS ('dbx_business_glossary_term' = 'CAPA Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `capa_number` SET TAGS ('dbx_value_regex' = '^CAPA-[0-9]{6,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `capa_status` SET TAGS ('dbx_business_glossary_term' = 'CAPA Status');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `capa_type` SET TAGS ('dbx_business_glossary_term' = 'CAPA Type');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `capa_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|combined');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `closed_by_name` SET TAGS ('dbx_business_glossary_term' = 'Closed By Name');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `closure_comments` SET TAGS ('dbx_business_glossary_term' = 'Closure Comments');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factors');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `effectiveness_check_comments` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Comments');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `effectiveness_check_criteria` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Criteria');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `effectiveness_check_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `effectiveness_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `effectiveness_check_result` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Result');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `effectiveness_check_result` SET TAGS ('dbx_value_regex' = 'effective|ineffective|partially_effective|pending');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `immediate_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Immediate Action Taken');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `initiated_by_name` SET TAGS ('dbx_business_glossary_term' = 'Initiated By Name');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Initiated Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `originating_event_type` SET TAGS ('dbx_business_glossary_term' = 'Originating Event Type');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `preventive_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Plan');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `quality_capa_description` SET TAGS ('dbx_business_glossary_term' = 'CAPA Description');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `regulatory_commitment_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Commitment Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `root_cause_analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Method');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `root_cause_analysis_method` SET TAGS ('dbx_value_regex' = '5_why|fishbone|fmea|fault_tree|pareto|other');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'CAPA Title');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Deviation Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `inventory_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Lot Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `investigational_site_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Site Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `patient_access_program_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Access Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `treatment_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Exposure Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `treatment_exposure_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `treatment_exposure_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ALTER COLUMN `icsr_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Icsr Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` SET TAGS ('dbx_subdomain' = 'laboratory_control');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `oos_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Specification (OOS) Investigation ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `inventory_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Lot Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `lab_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Deviation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `test_parameter` SET TAGS ('dbx_business_glossary_term' = 'Test Parameter');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Change Control ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `drug_master_file_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master File Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `method_validation_id` SET TAGS ('dbx_business_glossary_term' = 'Method Validation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `actual_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Implementation Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `affected_sop_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Standard Operating Procedure (SOP) List');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Change Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Change Approver Name');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `approver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `change_category` SET TAGS ('dbx_business_glossary_term' = 'Change Category');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `change_category` SET TAGS ('dbx_value_regex' = 'process|equipment|material|facility|system|document');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `change_control_number` SET TAGS ('dbx_value_regex' = '^CC-[0-9]{6,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `change_rationale` SET TAGS ('dbx_business_glossary_term' = 'Change Rationale');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `change_status` SET TAGS ('dbx_business_glossary_term' = 'Change Control Status');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `change_title` SET TAGS ('dbx_business_glossary_term' = 'Change Control Title');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type Classification');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'minor|major|critical');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Change Control Closure Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `effectiveness_verified` SET TAGS ('dbx_business_glossary_term' = 'Change Effectiveness Verified Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `implementation_plan` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Change Initiated Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `post_implementation_review` SET TAGS ('dbx_business_glossary_term' = 'Post-Implementation Review');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `regulatory_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Assessment');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `risk_assessment_summary` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Summary');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `sop_updates_required` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Updates Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'MasterControl|TrackWise|SAP_QM|Veeva_Vault|Other');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `target_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Target Implementation Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `validation_protocol_reference` SET TAGS ('dbx_business_glossary_term' = 'Validation Protocol Reference');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ALTER COLUMN `validation_required` SET TAGS ('dbx_business_glossary_term' = 'Validation Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Audited Hcp Master Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Audited Investigator Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Capa Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Change Control Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `distribution_network_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Network Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `oos_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Oos Investigation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `hco_master_id` SET TAGS ('dbx_business_glossary_term' = 'Audited Hco Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `health_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Health Authority Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `health_authority_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `health_authority_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `investigational_site_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Site Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `pv_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pv Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Deviation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` SET TAGS ('dbx_subdomain' = 'laboratory_control');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `lab_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Result ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `coa_id` SET TAGS ('dbx_business_glossary_term' = 'Coa Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `drug_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Substance Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `inventory_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Lot Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `method_validation_id` SET TAGS ('dbx_business_glossary_term' = 'Test Method ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `original_test_result_lab_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Original Test Result ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Deviation ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `stability_study_id` SET TAGS ('dbx_business_glossary_term' = 'Stability Study ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` SET TAGS ('dbx_subdomain' = 'laboratory_control');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `stability_study_id` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `access_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Access Strategy Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `drug_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Substance Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `inventory_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Lot Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `method_validation_id` SET TAGS ('dbx_business_glossary_term' = 'Method Validation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `packaging_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` SET TAGS ('dbx_subdomain' = 'laboratory_control');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `method_validation_id` SET TAGS ('dbx_business_glossary_term' = 'Method Validation Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `assay_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `drug_master_file_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master File Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `drug_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Substance Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `accuracy_recovery_percent_mean` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Mean Recovery Percent');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `accuracy_result` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Result');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `accuracy_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_assessed');
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
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Inclusion Flag');
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
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` SET TAGS ('dbx_subdomain' = 'batch_release');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `coa_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `contract_account_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Account Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `drug_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Substance Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `hco_master_id` SET TAGS ('dbx_business_glossary_term' = 'Hco Master Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `inventory_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Lot Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `packaging_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `authorized_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory Name');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `batch_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Batch/Lot Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `coa_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `glp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Laboratory Practice (GLP) Compliance Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issued Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `lims_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ALTER COLUMN `qa_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Reviewer Name');
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
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` SET TAGS ('dbx_subdomain' = 'batch_release');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `batch_disposition_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Disposition Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `coa_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `drug_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Substance Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `inventory_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Lot Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `packaging_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `icsr_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Icsr Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ALTER COLUMN `safety_signal_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Safety Signal Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Capa Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `coa_id` SET TAGS ('dbx_business_glossary_term' = 'Coa Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `hco_master_id` SET TAGS ('dbx_business_glossary_term' = 'Complainant Hco Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `icsr_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Icsr Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `inventory_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Lot Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Investigator Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Complainant Physician Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `oos_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Oos Investigation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `packaging_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `patient_access_program_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Access Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `adverse_event_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Adverse Event Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `patient_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Enrollment Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `product_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `protocol_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Deviation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `pv_adverse_reaction_id` SET TAGS ('dbx_business_glossary_term' = 'Pv Adverse Reaction Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Deviation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `sample_request_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `trademark_id` SET TAGS ('dbx_business_glossary_term' = 'Trademark Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `occurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Date');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ALTER COLUMN `patient_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Impact Flag');
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
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` SET TAGS ('dbx_subdomain' = 'batch_release');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `validation_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `distribution_network_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Network Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `packaging_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` SET TAGS ('dbx_subdomain' = 'batch_release');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `drug_master_file_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master File Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `drug_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Substance Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `excipient_id` SET TAGS ('dbx_business_glossary_term' = 'Excipient Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `packaging_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ALTER COLUMN `superseded_by_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Specification Identifier (ID)');
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
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `supplier_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Qualification ID');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Business Partner Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Capa Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Change Control Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `distribution_network_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Network Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `dmf_id` SET TAGS ('dbx_business_glossary_term' = 'Dmf Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `drug_master_file_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master File Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `drug_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Substance Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `excipient_id` SET TAGS ('dbx_business_glossary_term' = 'Excipient Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `requalification_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Re-qualification Frequency (Months)');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'mastercontrol|trackwise|veeva_vault_qualitydocs');
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ALTER COLUMN `supplier_type` SET TAGS ('dbx_business_glossary_term' = 'Supplier Type');
