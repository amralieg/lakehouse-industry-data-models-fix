-- Schema for Domain: quality | Business: Construction | Version: v1_mvm
-- Generated on: 2026-05-07 09:27:06

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `construction_ecm`.`quality` COMMENT 'QA/QC (Quality Assurance/Quality Control) domain managing ITP (Inspection and Test Plans), NCR (Non-Conformance Reports), inspection checklists, material test certificates, weld records, FAT (Factory Acceptance Test), SAT (Site Acceptance Test), and defect tracking through DLP. Ensures construction deliverables meet specifications and ISO 9001 standards.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `construction_ecm`.`quality`.`itp` (
    `itp_id` BIGINT COMMENT 'Unique identifier for the Inspection and Test Plan record. Primary key for the ITP entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Contract‑Based QA: ITPs are defined per contract to ensure compliance; linking to agreement enables contract‑level audit and performance tracking.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: ITPs are contractual quality deliverables formally submitted to and approved by the client in construction. Client account FK on ITP enables client-specific ITP register, approval workflow tracking, a',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Construction contracts nominate a specific client contact as the inspector/witness representative for ITP hold and witness points. Replacing the denormalized text field client_inspector_responsible_pa',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this ITP applies. Links the quality control framework to the parent project.',
    `package_id` BIGINT COMMENT 'Foreign key linking to design.package. Business justification: An ITP is scoped to a design/work package defining which drawings and specs govern inspection. QA managers use this link to pull all ITP requirements for a package during pre-construction quality plan',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: ITPs are scoped and approved against active compliance permits — work packages cannot be inspected outside permit boundaries. QA managers link each ITP to the governing permit for permit-milestone sig',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: ITPs are scoped to specific project phases (civil, structural, MEP, commissioning). Phase-specific ITP registers are a standard QMS requirement; quality managers assign and approve ITPs per phase gate',
    `plan_id` BIGINT COMMENT 'Foreign key linking to quality.quality_plan. Business justification: An ITP (Inspection and Test Plan) is a subordinate document that implements the quality strategy defined in the Project Quality Plan (PQP). The quality_plan table has itp_register_reference (STRING) c',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to project.site. Business justification: ITPs are scoped to a specific site in multi-site construction programs. Site-specific ITP registers are a standard QMS requirement; site quality managers maintain and approve ITPs per site independent',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: ITPs for safety-critical activities reference the risk assessment to ensure hold points and witness points align with identified risk controls. Required for integrated QA-HSE plan development and clie',
    `scope_id` BIGINT COMMENT 'Foreign key linking to contract.contract_scope. Business justification: ITPs are prepared per contract scope/work package in the Quality Plan per Scope process. Construction QA requires each ITP to reference the specific contract scope item it covers, enabling scope-bas',
    `subcontract_id` BIGINT COMMENT 'Foreign key linking to contract.subcontract. Business justification: Subcontractor ITP: Subcontractors submit ITPs under a specific subcontract; FK ties ITP to the subcontract for responsibility and schedule management.',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: ITPs for high-risk work activities must reference the applicable SWMS to ensure safety controls are embedded in hold points and witness points. Construction QA managers develop ITPs and SWMS concurren',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: ITPs are created from specific technical specifications; FK ensures correct acceptance criteria.',
    `trade_package_id` BIGINT COMMENT 'Foreign key linking to bid.trade_package. Business justification: ITPs are prepared per trade package scope in construction — the ITP governs the inspection regime for a specific subcontractors work. This is a fundamental QC-procurement interface used in subcontrac',
    `acceptance_criteria` STRING COMMENT 'Detailed acceptance criteria and tolerances that must be met for the work to pass inspection. Defines the pass/fail thresholds for quality verification.',
    `applicable_standards` STRING COMMENT 'Comma-separated list of applicable quality, design, and construction standards governing this ITP (e.g., ISO 9001, ACI 318, ASME B31.3, IBC 2018). Defines the regulatory and technical framework.',
    `approval_date` DATE COMMENT 'Date on which the ITP was formally approved by the client or authorized party. Marks the effective date for use in quality control.',
    `approval_status` STRING COMMENT 'Current approval status of the ITP document in the quality management workflow. Governs whether the ITP can be used for active inspections. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|superseded|obsolete — 7 candidates stripped; promote to reference product]',
    `approved_by` STRING COMMENT 'Name of the individual or role who granted final approval for the ITP document, authorizing its use for quality control activities.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ITP record was first created in the system. Part of the audit trail for data governance.',
    `defect_liability_period_days` STRING COMMENT 'Duration in days of the defects liability period applicable to work covered by this ITP. Defines the warranty period for quality defects.',
    `discipline` STRING COMMENT 'Engineering discipline or trade to which this ITP applies. Enables filtering and assignment of ITPs by technical specialty. [ENUM-REF-CANDIDATE: civil|structural|mechanical|electrical|plumbing|hvac|instrumentation|piping|architectural|geotechnical — 10 candidates stripped; promote to reference product]',
    `document_storage_location` STRING COMMENT 'Physical or digital location where the ITP document and related inspection records are stored (e.g., Aconex folder path, SharePoint URL, physical file reference).',
    `effective_date` DATE COMMENT 'Date from which this ITP becomes effective and must be applied to the specified work activities. May differ from approval date.',
    `expiry_date` DATE COMMENT 'Date on which this ITP expires or is superseded by a new revision. Nullable for ITPs that remain valid until explicitly superseded.',
    `fat_required` BOOLEAN COMMENT 'Indicates whether a Factory Acceptance Test is required as part of this ITP. Applicable to equipment and prefabricated components.',
    `hold_point_required` BOOLEAN COMMENT 'Indicates whether this ITP includes mandatory hold points where work cannot proceed until inspection approval is obtained. Critical for compliance and risk management.',
    `inspection_frequency` STRING COMMENT 'Frequency or sampling rate for inspections defined in this ITP (e.g., 100% inspection, Every 10th unit, Daily, Per shift). Defines the intensity of quality control.',
    `inspection_scope` STRING COMMENT 'Detailed scope of inspection activities covered by this ITP, including specific items, locations, and phases to be inspected.',
    `itp_number` STRING COMMENT 'Business identifier for the ITP document, typically following a project-specific numbering convention. Used for external reference and document control.. Valid values are `^ITP-[A-Z0-9]{4,12}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this ITP record was last modified in the system. Tracks the most recent update for audit and version control purposes.',
    `material_test_certificate_required` BOOLEAN COMMENT 'Indicates whether material test certificates must be submitted and verified as part of this ITP. Common for structural materials and critical components.',
    `ndt_method_required` STRING COMMENT 'Type of non-destructive testing method required by this ITP, if applicable. Critical for structural integrity verification in construction. [ENUM-REF-CANDIDATE: none|visual|ultrasonic|radiographic|magnetic_particle|liquid_penetrant|eddy_current — 7 candidates stripped; promote to reference product]',
    `prepared_by` STRING COMMENT 'Name of the individual or role who prepared the ITP document. Part of the document control and accountability trail.',
    `qc_inspector_responsible_party` STRING COMMENT 'Name or role of the contractor QC inspector responsible for verifying compliance with this ITP before submission to the client.',
    `remarks` STRING COMMENT 'Additional remarks, notes, or special instructions related to this ITP. Captures context or clarifications not covered in other fields.',
    `review_point_required` BOOLEAN COMMENT 'Indicates whether this ITP includes review points where inspection records and test results must be submitted for review by the client or engineer.',
    `reviewed_by` STRING COMMENT 'Name of the individual or role who reviewed the ITP document for technical accuracy and completeness before submission for approval.',
    `revision_date` DATE COMMENT 'Date of the current revision of the ITP document. Used for version control and ensuring the latest approved version is in use.',
    `revision_number` STRING COMMENT 'Revision number or letter of the ITP document, tracking version history and changes. Critical for document control and traceability.. Valid values are `^[A-Z0-9]{1,3}$`',
    `sat_required` BOOLEAN COMMENT 'Indicates whether a Site Acceptance Test is required as part of this ITP. Applicable to installed equipment and systems commissioning.',
    `test_method_reference` STRING COMMENT 'Reference to the standard test methods or procedures to be used for testing under this ITP (e.g., ASTM E165, ISO 9712, ACI 318 Section 5.6).',
    `title` STRING COMMENT 'Descriptive title of the ITP defining the scope of work or activity being inspected (e.g., Structural Steel Welding ITP, Concrete Pour ITP - Foundation Slab).',
    `wbs_code` STRING COMMENT 'Hierarchical code identifying the work package or activity within the project WBS that this ITP governs. Enables traceability from quality plans to project scope.. Valid values are `^[A-Z0-9]{2,6}(.[A-Z0-9]{2,6}){0,5}$`',
    `witness_point_required` BOOLEAN COMMENT 'Indicates whether this ITP includes witness points where the client or third-party inspector must be notified and given the opportunity to witness the inspection.',
    `work_package_description` STRING COMMENT 'Detailed description of the construction work package, activity, or deliverable that this ITP covers. Defines the scope of inspection and testing.',
    CONSTRAINT pk_itp PRIMARY KEY(`itp_id`)
) COMMENT 'Inspection and Test Plan (ITP) master record defining the structured quality control framework for a construction work package or activity. Captures the inspection scope, hold/witness/review points, applicable standards (ISO 9001, IBC, ACI), responsible parties, acceptance criteria, and linkage to the WBS. Serves as the authoritative QA/QC planning document governing all inspection activities on a project.';

CREATE OR REPLACE TABLE `construction_ecm`.`quality`.`itp_line` (
    `itp_line_id` BIGINT COMMENT 'Unique identifier for the ITP line item. Primary key for the ITP line entity.',
    `checklist_id` BIGINT COMMENT 'Foreign key linking to quality.checklist. Business justification: Each ITP line item specifies a particular inspection or test activity, and that activity is typically governed by a specific checklist template. The itp_line table has inspection_method, inspection_st',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: ITP line execution is assigned to a specific worker; required for execution accountability.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Each ITP line item references the governing drawing for that inspection activity. QA engineers pull the correct drawing during field inspection to verify work against design intent — a fundamental con',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: ITP lines carry a plain denormalized cost_code text attribute. Replacing with a proper FK to finance.cost_code enables accurate cost allocation of inspection hold-point and witness-point activities ',
    `itp_id` BIGINT COMMENT 'Reference to the parent ITP document that contains this line item. Links the line to its header ITP.',
    `material_catalog_id` BIGINT COMMENT 'Foreign key linking to procurement.material_catalog. Business justification: ITP lines specify inspection activities for specific materials (rebar, concrete, structural steel). Linking ITP lines to the material catalog enforces material-specific inspection requirements during ',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Individual ITP hold/witness points are mandated by specific permit conditions (e.g., third-party witness required per permit condition 7). QA engineers must trace each inspection stage to the permit',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: ITP line often executed by a crew; linking crew provides crew‑level accountability.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: ITP line items for safety-critical inspection steps reference the risk assessment to confirm residual risk is acceptable before proceeding. Required for integrated QA-HSE reporting and client hold-poi',
    `skill_trade_id` BIGINT COMMENT 'Foreign key linking to workforce.skill_trade. Business justification: Trade-specific inspection planning: itp_line has responsible_discipline as plain text. Normalizing to skill_trade_id enables workforce-quality alignment reports showing which trades have the most hold',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: Individual ITP line items for high-risk work steps reference the SWMS to confirm safety controls are active before the quality inspection step proceeds. Construction site supervisors check SWMS curren',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Individual ITP line items reference the specific technical specification section defining acceptance criteria for that activity. Different lines within one ITP can reference different spec sections — ',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Each ITP line item is associated with the WBS element where the activity occurs.',
    `wbs_node_id` BIGINT COMMENT 'Foreign key linking to schedule.wbs_node. Business justification: ITP lines are scoped to WBS nodes; linking via wbs_node_id replaces denormalized wbs_code for accurate WBS‑based inspection planning.',
    `acceptance_criteria` STRING COMMENT 'The specific criteria, tolerances, or standards that must be met for the inspection or test to pass. Defines what constitutes acceptable quality.',
    `activity_description` STRING COMMENT 'Detailed description of the specific inspection or test activity to be performed at this hold point, witness point, or review point.',
    `applicable_standard` STRING COMMENT 'The industry standard, code, or specification that governs this inspection activity (e.g., ASTM, ASME, ACI, AISC, BS, EN, ISO standard reference).',
    `approved_by` STRING COMMENT 'Name or identifier of the quality manager, project manager, or authorized person who approved this ITP line item for use.',
    `approved_date` DATE COMMENT 'The date on which this ITP line item was formally approved for implementation.',
    `calibration_required` BOOLEAN COMMENT 'Indicates whether the test equipment used for this inspection must have valid calibration certificates before use.',
    `client_witness_required` BOOLEAN COMMENT 'Indicates whether the client or their representative must be present to witness this inspection activity before work can proceed.',
    `consultant_witness_required` BOOLEAN COMMENT 'Indicates whether the consultant or engineer must be present to witness this inspection activity before work can proceed.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this ITP line item record was first created in the system.',
    `critical_path_flag` BOOLEAN COMMENT 'Indicates whether this inspection activity is on the project critical path and delays would impact overall project schedule.',
    `effective_date` DATE COMMENT 'The date from which this ITP line item version becomes effective and must be followed for inspections.',
    `environmental_conditions` STRING COMMENT 'Any specific environmental conditions or constraints that must be met during inspection (e.g., temperature range, humidity limits, weather restrictions, lighting requirements).',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'The estimated time in hours required to complete this inspection or test activity, including setup, execution, and documentation.',
    `hold_point_type` STRING COMMENT 'Classification of the inspection point. Hold: work cannot proceed without approval. Witness: client/consultant must be present. Review: documentation review only. Surveillance: periodic monitoring.. Valid values are `hold|witness|review|surveillance`',
    `inspection_frequency` STRING COMMENT 'How often or at what stage the inspection must be performed (e.g., 100%, first and last, every 10th unit, per batch, continuous).',
    `inspection_method` STRING COMMENT 'The method or technique to be used for performing the inspection or test (e.g., visual inspection, ultrasonic testing, dimensional check, pressure test, material sampling).',
    `inspection_stage` STRING COMMENT 'The construction or manufacturing stage at which this inspection must be performed (e.g., pre-pour, during installation, post-weld, before backfill, at completion).',
    `itp_line_status` STRING COMMENT 'Current status of this ITP line item in its lifecycle. Planned: not yet ready. Ready: prerequisites met. In Progress: inspection underway. Completed: inspection finished. Waived: inspection waived by authority. Cancelled: no longer required.. Valid values are `planned|ready|in_progress|completed|waived|cancelled`',
    `line_number` STRING COMMENT 'Sequential line number within the parent ITP document. Defines the order of inspection activities.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this inspection is mandatory per contract requirements or regulatory compliance, or if it is optional/recommended.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this ITP line item record was last modified or updated.',
    `ncr_trigger_criteria` STRING COMMENT 'The specific conditions or findings that would trigger the issuance of a Non-Conformance Report (NCR) if this inspection fails.',
    `notification_lead_time_hours` STRING COMMENT 'The minimum advance notice in hours that must be given to client, consultant, or third-party witnesses before performing this inspection.',
    `reference_document` STRING COMMENT 'The specification, drawing, standard, or procedure document that governs this inspection activity (e.g., drawing number, specification code, industry standard reference).',
    `remarks` STRING COMMENT 'Additional notes, clarifications, or special instructions related to this inspection line item that do not fit in other structured fields.',
    `required_documentation` STRING COMMENT 'List of documents, certificates, or records that must be produced as evidence of inspection completion (e.g., test certificates, inspection reports, material certificates, calibration records).',
    `responsible_discipline` STRING COMMENT 'The engineering or construction discipline responsible for performing or coordinating this inspection (e.g., Civil, Mechanical, Electrical, Piping, QA/QC, MEP).',
    `revision_number` STRING COMMENT 'The revision number of this ITP line item. Increments when inspection requirements, acceptance criteria, or other details are changed.',
    `safety_requirements` STRING COMMENT 'Specific health, safety, and environment (HSE) requirements, personal protective equipment (PPE), or permits required for performing this inspection activity.',
    `sampling_plan` STRING COMMENT 'The statistical sampling plan or sample size requirements for this inspection activity (e.g., AQL levels, sample quantity, sampling method).',
    `sequence_dependency` STRING COMMENT 'Description of any prerequisite inspections or activities that must be completed before this inspection can be performed.',
    `superseded_date` DATE COMMENT 'The date on which this ITP line item version was superseded by a newer revision. Null if this is the current active version.',
    `test_equipment_required` STRING COMMENT 'List of specialized test equipment, instruments, or tools required to perform this inspection or test (e.g., ultrasonic tester, pressure gauge, theodolite, concrete slump cone).',
    `third_party_witness_required` BOOLEAN COMMENT 'Indicates whether a third-party inspector, certification body, or regulatory authority must witness this inspection activity.',
    CONSTRAINT pk_itp_line PRIMARY KEY(`itp_line_id`)
) COMMENT 'Individual inspection or test activity line item within an ITP. Defines a specific hold point, witness point, or review point with its activity description, inspection method, acceptance criteria, frequency, responsible discipline, and required documentation. Each line drives a discrete inspection event on site.';

CREATE OR REPLACE TABLE `construction_ecm`.`quality`.`inspection` (
    `inspection_id` BIGINT COMMENT 'Unique identifier for the inspection record. Primary key.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Inspection schedule report ties each inspection to the specific scheduled activity it validates; activity_id provides that link.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Inspection reports are contract‑driven; linking to agreement allows traceability of inspections to contractual obligations.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Equipment inspection process records which specific asset (e.g., crane, excavator) was inspected; required for compliance reports and maintenance scheduling.',
    `checklist_id` BIGINT COMMENT 'Reference to the standardized inspection checklist template used for this inspection. Defines the verification criteria and check items.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Inspection requests originate from a client account; required for client‑billing and inspection tracking reports.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Client contact may attend or request the inspection; needed for audit of client participation.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this inspection is performed.',
    `contract_milestone_id` BIGINT COMMENT 'Foreign key linking to contract.contract_milestone. Business justification: Pre-milestone inspections verify readiness for milestone payment certification in the Milestone Readiness Inspection process. Construction contract administrators require inspection sign-off records',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Inspection logs which craft worker performed the inspection; required for QC audit reports.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Inspections are scheduled for specific crews; needed for crew‑based inspection planning.',
    `daily_log_id` BIGINT COMMENT 'Foreign key linking to site.daily_log. Business justification: Daily QA Reporting: Inspections conducted on site are recorded against the daily log for that date. Superintendents and QA managers reconcile daily inspection counts with the daily log — a standard si',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Inspection reports must reference the exact drawing inspected for traceability and compliance.',
    `drawing_revision_id` BIGINT COMMENT 'Foreign key linking to design.drawing_revision. Business justification: Inspections must record which drawing revision was current at time of inspection — a critical audit and contractual requirement. inspection.drawing_id links to the drawing, but revision-level traceabi',
    `field_progress_id` BIGINT COMMENT 'Foreign key linking to site.field_progress. Business justification: Progress Claim Verification: Field progress measurements require inspection sign-off before being certified for payment. QA managers and quantity surveyors use this link to confirm that claimed progre',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Required for Cost Allocation Report: each inspection activity is charged to a cost code for budgeting and client billing.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Needed to link inspection results to the goods receipt that triggered the inspection, supporting receipt‑inspection traceability.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: When a quality inspection uncovers a safety hazard, an incident is logged; linking inspection to incident supports immediate corrective action and compliance documentation.',
    `itp_line_id` BIGINT COMMENT 'Foreign key linking to quality.itp_line. Business justification: Link inspection to its ITP line for proper hierarchy; inspection may occur multiple times per line.',
    `material_delivery_id` BIGINT COMMENT 'Foreign key linking to site.material_delivery. Business justification: Incoming Material Inspection: Every material delivery requires an incoming inspection per ITP requirements. QA inspectors link the inspection record to the delivery docket to confirm material acceptan',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Permit‑mandated inspections: inspections are scheduled to satisfy conditions of an active permit, linking inspection records to the governing permit.',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: Quality inspections on high-risk work (confined space, hot work, working at height) require a valid PTW to be active before the inspector proceeds. Inspectors must record the PTW reference as a mandat',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Inspections are conducted within a specific project phase. Phase-level inspection pass/fail statistics are reported at phase-gate reviews and are a standard PMO quality KPI in construction programs.',
    `production_entry_id` BIGINT COMMENT 'Foreign key linking to site.production_entry. Business justification: ITP Hold/Witness Point Release: Inspections validate installed quantities recorded in production entries before payment certification. QA engineers link inspections to production entries to confirm IT',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to project.site. Business justification: Inspections are physically conducted at a specific site. Site-level inspection registers and pass/fail statistics are standard construction QA reporting requirements used by site quality managers and ',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Quality inspections on safety-critical activities reference the risk assessment to confirm hazard controls are in place before inspection proceeds. Required for QA-HSE integrated reporting and regulat',
    `submittal_id` BIGINT COMMENT 'Foreign key linking to design.design_submittal. Business justification: Material and equipment submittals require inspection upon delivery or installation. Linking inspection to the approved design submittal enables submittal-to-inspection traceability — a named construct',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: Quality inspectors verify the SWMS is current and approved before commencing inspection on high-risk activities. The inspection record must reference the active SWMS to confirm safety controls were ve',
    `trade_package_id` BIGINT COMMENT 'Foreign key linking to bid.trade_package. Business justification: Inspections are conducted on work performed under a specific trade package. Linking inspection to trade_package enables trade-level quality performance reporting used in subcontractor evaluation, rete',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Inspections are scheduled against specific WBS elements (e.g., structural components); FK supports inspection‑WBS mapping.',
    `attachment_count` STRING COMMENT 'Number of supporting documents, photos, measurements, or other digital attachments linked to this inspection record. Provides evidence trail for QA/QC compliance.',
    `checklist_template_name` STRING COMMENT 'Name of the checklist template used (e.g., Concrete Pour Inspection Checklist, Structural Steel Welding Inspection, MEP Rough-in Checklist). Provides human-readable context.',
    `checklist_version` STRING COMMENT 'Version number of the checklist template used at the time of inspection. Ensures audit trail of which criteria were applied.',
    `corrective_action_required` BOOLEAN COMMENT 'Boolean flag indicating whether corrective action is required to address findings from this inspection. True indicates action needed; false indicates no action required.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this inspection record was first created in the quality management system. Audit trail for data lineage.',
    `defects_identified` STRING COMMENT 'Description of specific defects, non-conformances, or quality issues identified during the inspection. Forms the basis for NCR (Non-Conformance Report) creation and defect tracking through DLP (Defects Liability Period).',
    `end_time` TIMESTAMP COMMENT 'Precise timestamp when the inspection activity was completed and all checklist items verified.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity percentage at the time of inspection. Relevant for coating, painting, and other moisture-sensitive quality checks.',
    `inspection_date` DATE COMMENT 'The calendar date on which the physical inspection was conducted. Principal business event timestamp for this transaction.',
    `inspection_number` STRING COMMENT 'Business-facing unique inspection reference number used in documentation, reports, and correspondence. Typically follows project or organizational numbering conventions.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection. Scheduled indicates planned but not started; in progress indicates active inspection; pass indicates all checks met; fail indicates non-conformance detected; conditional pass indicates minor issues with conditions; cancelled indicates inspection not performed; deferred indicates postponed to later date. [ENUM-REF-CANDIDATE: scheduled|in_progress|pass|fail|conditional_pass|cancelled|deferred — 7 candidates stripped; promote to reference product]',
    `inspection_type` STRING COMMENT 'Classification of the inspection activity. Hold point requires mandatory approval before proceeding; witness point allows client/consultant observation; surveillance is routine monitoring; pre-pour checks concrete readiness; structural verifies load-bearing elements; MEP (Mechanical Electrical and Plumbing) inspects building systems; material test validates material certificates; weld inspects welding quality; FAT (Factory Acceptance Test) is factory verification; SAT (Site Acceptance Test) is on-site verification. [ENUM-REF-CANDIDATE: hold_point|witness_point|surveillance|pre_pour|structural|mep|material_test|weld|fat|sat — 10 candidates stripped; promote to reference product]',
    `inspector_certification` STRING COMMENT 'Professional certification or qualification held by the inspector (e.g., AWS CWI for welding, ACI for concrete, ASNT for NDT). Validates inspector competency.',
    `inspector_signature_captured` BOOLEAN COMMENT 'Boolean flag indicating whether the inspectors digital signature was captured as part of the inspection sign-off. True indicates signature obtained; false indicates signature pending or not required.',
    `items_failed` STRING COMMENT 'Count of checklist items that did not meet acceptance criteria and failed verification. Typically triggers NCR (Non-Conformance Report) creation.',
    `items_not_applicable` STRING COMMENT 'Count of checklist items marked as not applicable to this specific inspection instance due to scope or conditions.',
    `items_passed` STRING COMMENT 'Count of checklist items that met acceptance criteria and passed verification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this inspection record was last updated or modified. Audit trail for change tracking.',
    `location_description` STRING COMMENT 'Detailed description of the specific location where inspection was performed (e.g., Building A Level 3 Column Grid C5, Fabrication Shop Bay 2, Concrete Lab). Provides spatial context for traceability.',
    `location_type` STRING COMMENT 'Classification of where the inspection was physically conducted. Site indicates construction site; factory indicates manufacturer facility for FAT; workshop indicates fabrication shop; laboratory indicates testing facility; warehouse indicates storage location; offsite indicates other external location.. Valid values are `site|factory|workshop|laboratory|warehouse|offsite`',
    `ncr_raised` BOOLEAN COMMENT 'Boolean flag indicating whether a Non-Conformance Report (NCR) was raised as a result of this inspection. True indicates NCR created; false indicates no NCR required.',
    `ncr_reference` STRING COMMENT 'Reference number of the NCR (Non-Conformance Report) raised as a result of this inspection, if applicable. Links inspection to corrective action workflow.',
    `observations` STRING COMMENT 'General observations, notes, and comments recorded by the inspector during the inspection. Captures qualitative findings, context, and professional judgment.',
    `overall_outcome` STRING COMMENT 'Final verdict of the inspection based on aggregated check item results. Pass indicates all critical items met; fail indicates non-conformance requiring corrective action; conditional pass indicates minor issues with conditions for acceptance.. Valid values are `pass|fail|conditional_pass`',
    `photo_count` STRING COMMENT 'Number of photographs captured during the inspection as visual evidence of conditions, defects, or compliance.',
    `reinspection_date` DATE COMMENT 'Scheduled date for follow-up reinspection to verify corrective actions have been implemented and defects resolved.',
    `reinspection_required` BOOLEAN COMMENT 'Boolean flag indicating whether a follow-up reinspection is required after corrective actions are completed. True indicates reinspection needed; false indicates no reinspection required.',
    `specification_reference` STRING COMMENT 'Reference to the technical specification, standard, or code against which the inspection was performed (e.g., ACI 318, AISC 360, project specification section). Defines acceptance criteria.',
    `start_time` TIMESTAMP COMMENT 'Precise timestamp when the inspection activity commenced on site or at the facility.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Ambient temperature in degrees Celsius at the time of inspection. Critical for temperature-sensitive activities such as concrete curing, welding, coating application.',
    `total_check_items` STRING COMMENT 'Total number of individual verification items in the checklist that were evaluated during this inspection.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of inspection (e.g., clear, rainy, windy, temperature). Relevant for outdoor inspections where weather may affect quality or inspection validity.',
    `witness_signature_captured` BOOLEAN COMMENT 'Boolean flag indicating whether the witness partys digital signature was captured. True indicates signature obtained; false indicates signature pending or not required.',
    `work_package_reference` STRING COMMENT 'Reference to the work package, activity, or WBS (Work Breakdown Structure) element being inspected. Links quality verification to project schedule and scope.',
    CONSTRAINT pk_inspection PRIMARY KEY(`inspection_id`)
) COMMENT 'Transactional record of a physical quality inspection or checklist verification event conducted on site, at a factory, or workshop. Captures inspection date, location, inspector identity, ITP line reference, checklist template used, item-level verification results (pass/fail/N/A per check item with remarks), overall outcome (pass/fail/conditional), observations, non-conformances raised, digital sign-off, and attachments (photos, measurements). Covers all inspection types: hold-point inspections, witness-point inspections, pre-pour checks, structural inspections, MEP inspections, and any checklist-based quality verification. Each record serves as the auditable evidence trail for QA/QC compliance and may trigger NCR creation on failure.';

CREATE OR REPLACE TABLE `construction_ecm`.`quality`.`ncr` (
    `ncr_id` BIGINT COMMENT 'Unique identifier for the non-conformance report. Primary key for the NCR entity.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: NCR impact analysis requires knowing which activity triggered the non‑conformance; activity_id records that relationship.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: NCRs affect contract performance and liquidated damages; contract reference is required for claim and settlement processes.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: NCRs are tracked against the client account for contract compliance and client‑specific reporting.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Clients can raise non‑conformances; linking to the reporting client contact enables traceability.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project where the non-conformance was identified.',
    `contract_milestone_id` BIGINT COMMENT 'Foreign key linking to contract.contract_milestone. Business justification: NCRs can trigger milestone holds, blocking payment certification until resolved — the Milestone Hold due to NCR process. Construction contract managers track which milestone is held by an open NCR. ',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: NCR assigns a specific worker to resolve the issue; needed for corrective‑action tracking.',
    `daily_log_id` BIGINT COMMENT 'Foreign key linking to site.daily_log. Business justification: NCR Origin Traceability: NCRs are raised from observations recorded in daily logs. Project managers and QA auditors trace NCRs back to the daily log entry where the non-conformance was first identifie',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: NCRs are raised against a specific drawing; linking enables automated impact analysis.',
    `drawing_revision_id` BIGINT COMMENT 'Foreign key linking to design.drawing_revision. Business justification: An NCR must reference the specific drawing revision in effect when the non-conformance was identified — essential for root cause analysis, contractor liability determination, and legal/contractual dis',
    `env_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.env_impact_assessment. Business justification: Environmental NCRs (spills, emissions exceedances, habitat disturbance) must be reported against the EIA under which the project operates. Environmental managers need direct NCR-to-EIA linkage for EIA',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Needed for Cost Impact Tracking: NCR corrective cost is allocated to a cost code to reflect financial impact in cost reports.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Required for traceability: NCR investigations often trigger safety incident investigations; linking enables root‑cause analysis and regulatory reporting.',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to quality.inspection. Business justification: An NCR is formally raised as a result of a failed inspection event. The inspection table has ncr_raised (BOOLEAN) and ncr_reference (STRING) fields confirming this relationship exists conceptually. Fo',
    `inspection_release_id` BIGINT COMMENT 'Foreign key linking to procurement.inspection_release. Business justification: NCRs raised during material inspection are directly traceable to the inspection release event that triggered the rejection. Construction material rejection workflows require this link for vendor claim',
    `itp_line_id` BIGINT COMMENT 'Foreign key linking to quality.itp_line. Business justification: An NCR is triggered when a specific ITP hold point or witness point fails. The itp_line table has ncr_trigger_criteria field, confirming that individual ITP line items define the conditions under whic',
    `material_delivery_id` BIGINT COMMENT 'Foreign key linking to site.material_delivery. Business justification: Rejected Material NCR: NCRs are raised when delivered materials fail inspection. QA managers and procurement teams use this link to track material rejection NCRs against delivery dockets for supplier ',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Permit Condition Violation NCR tracking: each NCR is raised when a specific permit condition is breached, required for compliance reporting.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: NCRs raised for work performed outside permit scope or violating permit boundaries must reference the governing compliance permit directly — not just a condition. Permit managers need NCR-to-permit tr',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: NCRs raised during permitted work must reference the active PTW for root cause analysis and regulatory reporting. Regulators require traceability between non-conformances and the permit conditions in ',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: NCRs are categorized by project phase (design, construction, commissioning) for root cause analysis and phase-gate quality reporting. Phase-level NCR trend analysis is a standard PMO and quality audit',
    `production_entry_id` BIGINT COMMENT 'Foreign key linking to site.production_entry. Business justification: Rework Quantification: NCRs raised against specific production entries enable rework cost and quantity tracking. QA and commercial teams use this link to quantify rework volumes and costs against orig',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to project.site. Business justification: NCRs are raised at a specific physical site. Site-level NCR tracking is required for HSE reporting, subcontractor performance management, and regulatory compliance audits in construction operations.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: NCRs raised against procured materials or vendor workmanship must trace to the originating PO for cost recovery, back-charge processing, and vendor performance KPI reporting. Construction QA managers ',
    `rfi_id` BIGINT COMMENT 'Foreign key linking to design.rfi. Business justification: NCRs frequently originate from design ambiguities that were the subject of an RFI. Linking NCR to the causative RFI supports root cause analysis reporting and demonstrates whether design clarification',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: NCRs with safety implications (structural defects, material failures) must reference the risk assessment to determine if the residual risk profile has changed and whether a stop-work order is required',
    `subcontract_id` BIGINT COMMENT 'Foreign key linking to contract.subcontract. Business justification: NCRs raised against subcontractor work must be tracked at subcontract level for the Subcontractor Performance Management process. Retention release and subcontract payment decisions depend on NCR cl',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: NCRs on high-risk work activities reference the SWMS active at the time of non-conformance. Root cause analysis requires determining whether the SWMS was inadequate or not followed — standard construc',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Regulatory NCRs often cite the violated technical specification; direct FK supports compliance reporting.',
    `trade_package_id` BIGINT COMMENT 'Foreign key linking to bid.trade_package. Business justification: NCRs in construction are raised against a specific trade package (subcontractor scope). This link enables subcontractor performance tracking, supports contract administration decisions on retention re',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Assigns each NCR to the responsible vendor, essential for vendor performance evaluation and corrective action.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the specific work package or WBS (Work Breakdown Structure) element affected by the non-conformance.',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: NCR Location Tracking: NCRs are raised against specific work fronts where non-conformances occur. QA managers and project engineers use this link to generate work-front-level NCR registers and assess ',
    `client_notification_date` DATE COMMENT 'Date when the client was formally notified of the non-conformance. Null if client notification was not required.',
    `client_notification_required` BOOLEAN COMMENT 'Indicates whether the client must be formally notified of this non-conformance per contract requirements. Typically true for major or critical NCRs.',
    `closed_by` STRING COMMENT 'Name or identifier of the person who authorized closure of the NCR. Typically a QA/QC manager or project quality manager.',
    `closure_date` DATE COMMENT 'Date when the NCR was formally closed after successful completion of corrective action, verification, and effectiveness review. Marks the end of the CAPA cycle.',
    `corrective_action_completion_date` DATE COMMENT 'Actual date when the corrective action was completed. Compared against target date for performance measurement.',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective action(s) to be taken to address the immediate non-conformance. Part of the CAPA (Corrective and Preventive Action) process.',
    `corrective_action_responsible_party` STRING COMMENT 'Name or identifier of the person or organization responsible for implementing the corrective action.',
    `corrective_action_target_date` DATE COMMENT 'Planned target date for completion of the corrective action. Used for tracking and escalation if deadlines are missed.',
    `cost_impact_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated cost impact (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this NCR record was first created in the system. Part of audit trail for record lifecycle tracking.',
    `discipline` STRING COMMENT 'Engineering or construction discipline to which the non-conformance relates. Used for categorization and routing to appropriate technical specialists. [ENUM-REF-CANDIDATE: civil|structural|architectural|mechanical|electrical|plumbing|hvac|instrumentation|piping|welding|painting|insulation|fireproofing|other — 14 candidates stripped; promote to reference product]',
    `disposition` STRING COMMENT 'Formal decision on how the non-conforming work or material will be handled. Disposition determines the corrective action path and may require client approval for concessions.. Valid values are `accept_as_is|rework|repair|reject|scrap|use_as_is_with_concession`',
    `disposition_approved_by` STRING COMMENT 'Name or identifier of the person who approved the disposition decision. Typically a senior QA/QC manager, project manager, or client representative.',
    `disposition_approved_date` DATE COMMENT 'Date when the disposition was formally approved, allowing corrective action to proceed.',
    `disposition_justification` STRING COMMENT 'Technical and business justification for the selected disposition, including engineering analysis, code compliance assessment, and impact on functionality.',
    `effectiveness_review_comments` STRING COMMENT 'Comments from the effectiveness review assessing whether the corrective and preventive actions have successfully addressed the non-conformance and prevented recurrence.',
    `estimated_cost_impact` DECIMAL(18,2) COMMENT 'Estimated financial cost impact of the non-conformance including rework, material replacement, schedule delay, and potential liquidated damages. Used for cost tracking and recovery.',
    `hold_release_date` DATE COMMENT 'Date when the hold was released, allowing work to resume. Null if no hold was placed or if hold is still active.',
    `hold_status` BOOLEAN COMMENT 'Indicates whether a hold has been placed on the affected work or material, preventing further work until the NCR is resolved. True if hold is active, False otherwise.',
    `identified_date` DATE COMMENT 'Date when the non-conformance was first discovered or identified on site. Represents the business event timestamp for the NCR initiation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this NCR record was last modified. Used for audit trail and change tracking throughout the CAPA lifecycle.',
    `location_description` STRING COMMENT 'Detailed description of the physical location where the non-conformance was identified (e.g., Building A Level 3, Grid Line E5, Foundation Block 12).',
    `ncr_category` STRING COMMENT 'High-level classification of the type of non-conformance to support trend analysis and root cause categorization.. Valid values are `material|workmanship|design|documentation|dimensional|procedural`',
    `ncr_description` STRING COMMENT 'Detailed narrative description of the non-conformance, including what was observed, what was expected per specifications, and the extent of the deviation.',
    `ncr_number` STRING COMMENT 'Business identifier for the NCR, typically following a project-specific numbering convention. Externally visible reference number used in correspondence and documentation.. Valid values are `^NCR-[A-Z0-9]{4,20}$`',
    `ncr_status` STRING COMMENT 'Current lifecycle status of the NCR tracking its progression from identification through closure. Reflects the workflow state in the CAPA (Corrective and Preventive Action) cycle. [ENUM-REF-CANDIDATE: draft|open|under_investigation|pending_disposition|corrective_action_in_progress|verification_pending|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `preventive_action_description` STRING COMMENT 'Description of preventive actions to be taken to prevent recurrence of similar non-conformances. Addresses systemic issues identified in root cause analysis.',
    `preventive_action_responsible_party` STRING COMMENT 'Name or identifier of the person or organization responsible for implementing the preventive action.',
    `quantity_affected` DECIMAL(18,2) COMMENT 'Numeric quantity of work, material, or units affected by the non-conformance (e.g., 150 cubic meters of concrete, 25 welds, 500 linear meters of pipe).',
    `reported_by` STRING COMMENT 'Name or identifier of the person who identified and reported the non-conformance. Typically a QA/QC inspector, site engineer, or subcontractor representative.',
    `reported_by_organization` STRING COMMENT 'Organization or company that the reporting person represents (e.g., General Contractor, Subcontractor, Client, Third-Party Inspector).',
    `root_cause_analysis` STRING COMMENT 'Detailed analysis of the underlying root cause(s) of the non-conformance. May reference techniques such as 5 Whys, Fishbone Diagram, or Fault Tree Analysis.',
    `schedule_impact_days` STRING COMMENT 'Estimated number of calendar days of schedule delay caused by the non-conformance and its resolution. Used for schedule recovery planning and EOT (Extension of Time) claims.',
    `severity` STRING COMMENT 'Severity classification indicating the impact of the non-conformance on safety, quality, schedule, and cost. Critical NCRs may trigger work stoppage.. Valid values are `critical|major|minor`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity affected (e.g., m3, kg, linear meter, each, square meter).',
    `verification_date` DATE COMMENT 'Date when the verification of corrective action effectiveness was performed.',
    `verification_method` STRING COMMENT 'Method used to verify that the corrective action was effective and the non-conformance has been resolved. May include re-inspection, testing, or document review. [ENUM-REF-CANDIDATE: visual_inspection|dimensional_check|material_test|functional_test|document_review|third_party_inspection|other — 7 candidates stripped; promote to reference product]',
    `verification_performed_by` STRING COMMENT 'Name or identifier of the person who performed the verification of corrective action effectiveness. Typically a QA/QC inspector or independent verifier.',
    `verification_result` STRING COMMENT 'Outcome of the verification activity indicating whether the corrective action was effective and the non-conformance is resolved.. Valid values are `passed|failed|conditional`',
    CONSTRAINT pk_ncr PRIMARY KEY(`ncr_id`)
) COMMENT 'Non-Conformance Report (NCR) and corrective action record capturing formal documentation of construction deliverables, materials, or workmanship that do not meet specified requirements. Tracks NCR number, description of non-conformance, affected work package, root cause analysis, disposition (accept-as-is, rework, reject, concession), corrective and preventive actions (CAPA) with responsible parties, target and actual completion dates, verification method, effectiveness review, and closure status. Supports hold/release workflow and the full CAPA cycle required under ISO 9001 clause 10.';

CREATE OR REPLACE TABLE `construction_ecm`.`quality`.`corrective_action` (
    `corrective_action_id` BIGINT COMMENT 'Primary key for corrective_action',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Corrective action records the worker responsible for implementing the action; needed for audit trails.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Corrective actions that require design changes (requires_design_change field exists) must reference the affected drawing. This enables QA managers to track which drawings are subject to corrective act',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Allows budgeting of corrective actions: each corrective_action record must be linked to the cost code under which its expense is recorded.',
    `hse_plan_id` BIGINT COMMENT 'Foreign key linking to safety.hse_plan. Business justification: Corrective actions with HSE implications must be tracked against the project HSE plan to ensure they are captured in the HSE management framework and reported in HSE performance metrics — required for',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Corrective actions are frequently triggered by safety incidents where a quality failure contributed (e.g., defective material caused an incident). Linking corrective_action to incident enables inciden',
    `ncr_id` BIGINT COMMENT 'Reference to the parent Non-Conformance Report that triggered this corrective or preventive action.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: CA crew accountability: corrective_action has corrective_action_responsible_party as plain text. A responsible_crew_id FK normalizes which crew executes the corrective action, enabling crew-level CA c',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Corrective actions addressing systemic quality issues must reference the risk assessment to verify residual risk is reduced after implementation. Required for effectiveness review sign-off — standard ',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Corrective actions are tied to a specific WBS element for cost tracking and EVM impact reporting. The actual_cost on corrective_action must be allocated to a WBS cost account; this is a standard const',
    `action_description` STRING COMMENT 'Detailed narrative of the specific remediation steps to be taken, including scope, method, materials, and acceptance criteria.',
    `action_number` STRING COMMENT 'Business-readable identifier for the corrective or preventive action, typically formatted as NCR-XXXX-CA-YY for traceability.',
    `action_status` STRING COMMENT 'Current lifecycle state of the corrective action: open (assigned but not started), in_progress (work underway), pending_verification (awaiting QA/QC review), verified (effectiveness confirmed), closed (completed and accepted), cancelled (no longer required).. Valid values are `open|in_progress|pending_verification|verified|closed|cancelled`',
    `action_type` STRING COMMENT 'Classification of the action: corrective (addresses existing defect), preventive (prevents recurrence), containment (immediate isolation), or interim (temporary measure pending permanent fix).. Valid values are `corrective|preventive|containment|interim`',
    `actual_completion_date` DATE COMMENT 'Date when the corrective action was actually completed and submitted for verification. Null if still in progress.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost incurred to implement the corrective action, captured from job costing and procurement records.',
    `assigned_date` DATE COMMENT 'Date when the corrective action was formally assigned to the responsible party.',
    `client_approval_date` DATE COMMENT 'Date when the client formally approved the corrective action plan. Null if client approval is not required or pending.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost to implement the corrective action, including labor, materials, equipment, and any rework or schedule impact costs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this corrective action record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `document_reference` STRING COMMENT 'Reference to supporting documentation such as inspection reports, test certificates, photographs, or revised drawings stored in the document management system (e.g., Aconex, BIM 360).',
    `effectiveness_review_comments` STRING COMMENT 'Detailed comments from the effectiveness review, including evidence of resolution, lessons learned, and recommendations for process improvement.',
    `effectiveness_review_date` DATE COMMENT 'Date when the effectiveness of the corrective action was formally reviewed, typically 30-90 days after implementation.',
    `effectiveness_review_outcome` STRING COMMENT 'Result of the effectiveness review: effective (action resolved the issue and prevented recurrence), partially_effective (issue partially resolved, additional action required), ineffective (action did not resolve the issue), pending_review (awaiting final assessment).. Valid values are `effective|partially_effective|ineffective|pending_review`',
    `is_systemic_issue` BOOLEAN COMMENT 'Indicates whether the root cause analysis identified this as a systemic issue requiring organization-wide corrective action across multiple projects or processes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this corrective action record was last updated.',
    `lessons_learned` STRING COMMENT 'Summary of lessons learned from this corrective action, including process improvements, training needs, and recommendations for future projects.',
    `priority` STRING COMMENT 'Priority level of the corrective action based on safety impact, schedule criticality, and cost exposure: critical (immediate action required), high (urgent), medium (standard timeline), low (routine).. Valid values are `critical|high|medium|low`',
    `recurrence_prevention_measures` STRING COMMENT 'Specific measures implemented to prevent recurrence of the non-conformance, such as updated work instructions, additional inspections, or supplier quality audits.',
    `requires_client_approval` BOOLEAN COMMENT 'Indicates whether the corrective action requires formal approval from the client or project owner before implementation.',
    `requires_design_change` BOOLEAN COMMENT 'Indicates whether the corrective action requires a formal design change, triggering BIM (Building Information Modeling) revision and engineering approval workflows.',
    `root_cause_analysis` STRING COMMENT 'Summary of the root cause investigation findings that informed this corrective action, often using 5-Why, Fishbone, or Fault Tree Analysis methods.',
    `schedule_impact_days` STRING COMMENT 'Number of calendar days by which the corrective action delayed the project schedule or affected the critical path.',
    `target_completion_date` DATE COMMENT 'Planned date by which the corrective action must be completed to meet project schedule and compliance requirements.',
    `verification_date` DATE COMMENT 'Date when the corrective action was verified by QA/QC personnel or the designated authority.',
    `verification_method` STRING COMMENT 'Method used to verify the effectiveness of the corrective action: inspection (visual check), testing (material or functional test), document_review (record verification), audit (formal QA/QC audit), site_observation (field walkdown), measurement (dimensional or performance measurement).. Valid values are `inspection|testing|document_review|audit|site_observation|measurement`',
    `verified_by_name` STRING COMMENT 'Name of the individual who performed the verification of the corrective action.',
    CONSTRAINT pk_corrective_action PRIMARY KEY(`corrective_action_id`)
) COMMENT 'Corrective and preventive action record linked to an NCR. Tracks the specific remediation steps assigned, responsible party, target completion date, actual completion date, verification method, and effectiveness review outcome. Supports the CAPA (Corrective Action / Preventive Action) cycle required under ISO 9001 clause 10.';

CREATE OR REPLACE TABLE `construction_ecm`.`quality`.`checklist` (
    `checklist_id` BIGINT COMMENT 'Unique identifier for the quality inspection checklist template. Primary key.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this checklist template was created or customized, if project-specific.',
    `env_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.env_impact_assessment. Business justification: Environmental inspection checklists are structured to verify EIA mitigation measures are implemented on-site (e.g., erosion controls, noise barriers). Environmental compliance officers require checkli',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Permit condition compliance checklist: checklists verify that each permit condition is met during construction activities.',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Checklists are version-controlled per project phase (pre-pour checklist for construction phase, commissioning checklist for commissioning phase). Phase-specific checklist libraries are standard QA pra',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Quality checklists for safety-critical activities reference the risk assessment to ensure control measures are embedded as checklist items. Construction QA managers expect this link when developing in',
    `scope_id` BIGINT COMMENT 'Foreign key linking to contract.contract_scope. Business justification: Quality checklists are prepared for specific contract scope items/work packages in the Scope-based Quality Assurance process. Construction QA managers organize checklists by contract scope to ensure',
    `skill_trade_id` BIGINT COMMENT 'Foreign key linking to workforce.skill_trade. Business justification: Trade qualification enforcement: checklist has required_qualifications and discipline as plain text. A skill_trade_id FK normalizes the trade reference, enabling automated validation that only workers',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: Quality checklists for high-risk work activities (concrete pours, structural steel erection) are developed in conjunction with the SWMS. The checklist references the SWMS to ensure safety controls are',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Checklist scope is defined per WBS element for quality control; linking enables WBS‑level checklist tracking.',
    `acceptance_criteria` STRING COMMENT 'Overall acceptance criteria for the checklist (e.g., All critical items must pass, 95% of items must pass with no critical failures).',
    `activity_type` STRING COMMENT 'Classification of the construction activity type that this checklist applies to, aligned with WBS (Work Breakdown Structure) and ITP (Inspection and Test Plan) categories. [ENUM-REF-CANDIDATE: concrete_pour|rebar_placement|formwork_erection|waterproofing|structural_steel_erection|welding|mechanical_installation|electrical_installation|piping_installation|excavation|backfill|piling|painting|insulation|commissioning|other — 16 candidates stripped; promote to reference product]',
    `applicable_standard` STRING COMMENT 'Reference to the governing technical standard, code, or specification that this checklist enforces (e.g., ACI 318, AISC 360, ASME B31.3, IBC 2018, ASTM C39).',
    `approval_status` STRING COMMENT 'Current lifecycle status of the checklist template in the document control workflow, indicating whether it is ready for use in field inspections.. Valid values are `draft|under_review|approved|superseded|obsolete`',
    `approved_by` STRING COMMENT 'Name or identifier of the QA/QC (Quality Assurance/Quality Control) manager or authorized person who approved this checklist template for use.',
    `approved_date` DATE COMMENT 'Date when the checklist template was formally approved for use in quality inspections.',
    `average_pass_rate` DECIMAL(18,2) COMMENT 'Historical average pass rate (percentage) for inspections conducted using this checklist, used to identify problematic activities or checklist items.',
    `checklist_code` STRING COMMENT 'Externally-known unique business identifier for the checklist template, used for reference in inspection documentation and ITP (Inspection and Test Plan) workflows.. Valid values are `^[A-Z0-9]{6,20}$`',
    `checklist_description` STRING COMMENT 'Detailed description of the checklist purpose, scope, and applicability, including any special instructions or prerequisites for use.',
    `checklist_name` STRING COMMENT 'Human-readable name of the checklist template describing the inspection scope (e.g., Concrete Pour Inspection, Rebar Placement Verification, Waterproofing Application Check).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this checklist template record was first created in the system.',
    `critical_items_count` STRING COMMENT 'Number of check items in this checklist that are classified as critical and must pass for overall acceptance.',
    `discipline` STRING COMMENT 'Engineering or construction discipline that this checklist is associated with, used for routing to appropriate QA/QC (Quality Assurance/Quality Control) personnel. [ENUM-REF-CANDIDATE: civil|structural|architectural|mechanical|electrical|plumbing|hvac|instrumentation|piping|geotechnical|environmental|multi_discipline — 12 candidates stripped; promote to reference product]',
    `effective_from_date` DATE COMMENT 'Date from which this checklist template version becomes effective and should be used for new inspections.',
    `effective_to_date` DATE COMMENT 'Date until which this checklist template version remains effective, after which it is superseded by a newer revision.',
    `estimated_duration_minutes` STRING COMMENT 'Estimated time in minutes required to complete the inspection using this checklist, used for resource planning and scheduling.',
    `frequency` STRING COMMENT 'Frequency or trigger for when this checklist should be used (e.g., per concrete pour, daily for ongoing work, per material batch). [ENUM-REF-CANDIDATE: per_occurrence|daily|weekly|monthly|per_batch|per_lot|as_required — 7 candidates stripped; promote to reference product]',
    `hold_point_flag` BOOLEAN COMMENT 'Indicates whether this checklist represents a hold point where work cannot proceed until inspection is completed and accepted.',
    `inspection_stage` STRING COMMENT 'Phase of construction activity when this checklist should be applied, aligned with ITP (Inspection and Test Plan) hold points and witness points.. Valid values are `pre_work|during_work|post_work|hold_point|witness_point`',
    `inspection_type` STRING COMMENT 'Category of inspection method that this checklist governs (e.g., visual inspection, NDT, dimensional verification, functional testing). [ENUM-REF-CANDIDATE: visual|dimensional|non_destructive_testing|destructive_testing|functional|performance|documentation_review — 7 candidates stripped; promote to reference product]',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this checklist is mandatory for the associated activity type per contract requirements, ITP (Inspection and Test Plan), or regulatory compliance.',
    `modified_by` STRING COMMENT 'Name or identifier of the person who last modified this checklist template.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this checklist template record was last modified.',
    `ncr_trigger_threshold` STRING COMMENT 'Criteria that automatically trigger the issuance of an NCR (Non-Conformance Report) when inspection results fail to meet this threshold.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this checklist template.',
    `reference_documents` STRING COMMENT 'List of supporting documents, drawings, specifications, or procedures that inspectors should reference when using this checklist.',
    `required_equipment` STRING COMMENT 'List of tools, instruments, or equipment required to perform the inspection per this checklist (e.g., tape measure, level, ultrasonic thickness gauge, calibrated thermometer).',
    `required_qualifications` STRING COMMENT 'Qualifications, certifications, or competencies required for the inspector who will use this checklist (e.g., AWS CWI, ACI Level 1, ASNT NDT Level II).',
    `revision_date` DATE COMMENT 'Date when the current revision of the checklist was issued, used to ensure inspectors are using the latest approved version.',
    `revision_number` STRING COMMENT 'Version or revision identifier for the checklist template, incremented when checklist content is updated to reflect specification changes or lessons learned.. Valid values are `^[A-Z0-9]{1,10}$`',
    `safety_requirements` STRING COMMENT 'HSE (Health Safety and Environment) requirements and PPE (Personal Protective Equipment) needed when performing inspections using this checklist.',
    `total_check_items` STRING COMMENT 'Total number of individual verification items or questions included in this checklist template.',
    `usage_count` STRING COMMENT 'Number of times this checklist template has been used in actual field inspections, used for analytics and continuous improvement.',
    `witness_point_flag` BOOLEAN COMMENT 'Indicates whether this checklist represents a witness point where the client or third-party inspector must be notified and given opportunity to witness the inspection.',
    `created_by` STRING COMMENT 'Name or identifier of the person who originally created this checklist template.',
    CONSTRAINT pk_checklist PRIMARY KEY(`checklist_id`)
) COMMENT 'Quality inspection checklist template defining the structured set of verification items for a specific construction activity type (e.g., concrete pour, rebar placement, waterproofing, structural steel erection). Captures checklist name, revision, activity type, applicable standard, approval status, and ordered check items with acceptance criteria and inspection method. Used as the governing template when conducting inspections — each inspection references a checklist to ensure consistent verification coverage.';

CREATE OR REPLACE TABLE `construction_ecm`.`quality`.`checklist_execution` (
    `checklist_execution_id` BIGINT COMMENT 'Unique identifier for the completed checklist execution instance. Primary key for this quality inspection record.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Checklist executions are performed on specific equipment assets (daily pre-use inspections, commissioning checklists for generators, cranes). Construction QA operations require checklist executions to',
    `checklist_id` BIGINT COMMENT 'Reference to the master checklist template that was executed. Links to the standard ITP (Inspection and Test Plan) or inspection checklist definition.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Inspector identity normalization: checklist_execution has inspector_name as plain text (denormalized). Replacing with craft_worker_id enables certification validation at execution time, inspector perf',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: A checklist execution is performed against a specific drawing (e.g., verifying rebar placement against structural drawing). Field QA teams reference the drawing during execution. This is a fundamental',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Checklist executions identifying critical failures may trigger or be associated with a safety incident. Linking enables post-incident investigation to trace back to the quality inspection record — req',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to quality.inspection. Business justification: A checklist_execution is the completed on-site instance of a checklist, which is precisely what an inspection event records. The inspection table already references the checklist template (checklist_i',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: A checklist execution that results in a critical failure generates an NCR. The checklist_execution table has ncr_generated_flag (BOOLEAN) confirming this business event occurs. Formalizing checklist_e',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: Checklist execution on site requires a Permit‑to‑Work; linking records the permit governing the execution for safety compliance.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this quality inspection was performed.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to project.site. Business justification: Checklist executions occur at a physical site. The existing site_construction_project_id is project-level only; a direct site FK enables site-level QA execution dashboards used by site quality enginee',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: At execution time, the inspector references the risk assessment to confirm controls are active — distinct from the checklist templates design-time RA reference. Supports runtime verification that res',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: When executing a quality checklist on high-risk work, the inspector verifies the SWMS is current and approved. The execution record must reference the active SWMS — required for post-incident investig',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Execution of a checklist is performed against a specific WBS element on site.',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: ITP Checklist Execution Location: Checklist executions are performed at specific work fronts as part of ITP hold/witness point clearance. QA engineers use this link to report checklist compliance rate',
    `approval_status` STRING COMMENT 'Current approval workflow status of the checklist execution: draft (in progress), submitted (awaiting review), approved (accepted), rejected (not accepted), or revision required.. Valid values are `draft|submitted|approved|rejected|revision_required`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the checklist execution was formally approved by the QA/QC manager.',
    `compliance_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage of checklist items that passed inspection, excluding N/A items. Formula: (pass_count / (total_items - na_count)) * 100.',
    `corrective_action_required` STRING COMMENT 'Description of corrective actions or remediation work required to address failed inspection items.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the checklist execution record was first created in the system.',
    `critical_failure_flag` BOOLEAN COMMENT 'Indicates whether any critical or safety-related inspection items failed, requiring immediate stop-work or remediation.',
    `defects_identified` STRING COMMENT 'Summary description of defects, non-conformances, or quality issues identified during the inspection.',
    `document_reference_number` STRING COMMENT 'Reference number linking this checklist execution to the project document management system for archival and retrieval.',
    `execution_date` DATE COMMENT 'Date when the quality inspection checklist was executed on site.',
    `execution_end_time` TIMESTAMP COMMENT 'Timestamp when the inspector completed the checklist execution and submitted the results.',
    `execution_number` STRING COMMENT 'Business-readable unique identifier for this checklist execution, often formatted as project-discipline-sequence (e.g., PRJ001-QC-0123).',
    `execution_start_time` TIMESTAMP COMMENT 'Timestamp when the inspector began the checklist execution on site.',
    `fail_count` STRING COMMENT 'Number of checklist items that failed inspection criteria and require corrective action.',
    `humidity_percentage` DECIMAL(18,2) COMMENT 'Relative humidity percentage at the time of inspection, relevant for coating, painting, and material testing activities.',
    `inspection_stage` STRING COMMENT 'Project lifecycle stage when the inspection was conducted: pre-construction, during construction, post-construction, commissioning, or DLP (Defects Liability Period).. Valid values are `pre_construction|during_construction|post_construction|commissioning|DLP`',
    `inspection_type` STRING COMMENT 'Category of quality inspection performed: ITP (Inspection and Test Plan), FAT (Factory Acceptance Test), SAT (Site Acceptance Test), material test, weld inspection, concrete test, structural inspection, MEP (Mechanical Electrical Plumbing) inspection, final inspection, or defect inspection. [ENUM-REF-CANDIDATE: ITP|FAT|SAT|material_test|weld_inspection|concrete_test|structural_inspection|MEP_inspection|final_inspection|defect_inspection — 10 candidates stripped; promote to reference product]',
    `inspector_remarks` STRING COMMENT 'General observations, comments, or notes recorded by the inspector during the checklist execution. Provides context for inspection results.',
    `inspector_signature_captured` BOOLEAN COMMENT 'Indicates whether the inspectors digital signature was captured as part of the checklist sign-off process.',
    `inspector_signature_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspector digitally signed off on the completed checklist execution.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the checklist execution record was last updated or modified.',
    `location_description` STRING COMMENT 'Physical location on site where the inspection was performed (e.g., Building A - Level 2 - Grid C3, North Wing Foundation, Substation Area).',
    `na_count` STRING COMMENT 'Number of checklist items marked as not applicable to this specific inspection instance.',
    `ncr_generated_flag` BOOLEAN COMMENT 'Indicates whether this inspection resulted in the generation of one or more NCRs (Non-Conformance Reports) for failed items.',
    `overall_result` STRING COMMENT 'Overall outcome of the checklist execution: pass (all items compliant), fail (one or more critical failures), conditional pass (minor defects requiring remediation), or not applicable.. Valid values are `pass|fail|conditional_pass|not_applicable`',
    `pass_count` STRING COMMENT 'Number of checklist items that passed inspection criteria.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Ambient temperature in Celsius at the time of inspection, critical for concrete curing, welding, and coating applications.',
    `total_items` STRING COMMENT 'Total number of inspection items in the executed checklist.',
    `weather_conditions` STRING COMMENT 'Weather conditions at the time of inspection, relevant for outdoor construction activities and material testing (e.g., Clear, 25°C, Light rain, 18°C).',
    `witness_name` STRING COMMENT 'Full name of the witness who co-signed the inspection for display and reporting purposes.',
    `witness_required_flag` BOOLEAN COMMENT 'Indicates whether this inspection requires a witness signature from client, consultant, or third-party inspector per contract requirements.',
    `witness_signature_captured` BOOLEAN COMMENT 'Indicates whether the witnesss digital signature was captured as part of the checklist sign-off process.',
    `witness_signature_timestamp` TIMESTAMP COMMENT 'Timestamp when the witness digitally signed off on the completed checklist execution.',
    `work_activity_description` STRING COMMENT 'Detailed description of the specific construction work activity or deliverable being inspected (e.g., Foundation concrete pour - Grid A1 to A5, HVAC ductwork installation - Level 3).',
    CONSTRAINT pk_checklist_execution PRIMARY KEY(`checklist_execution_id`)
) COMMENT 'Completed instance of a quality inspection checklist executed on site for a specific work activity. Records the execution date, inspector, work location, WBS reference, each checklist item result (pass/fail/N/A), overall outcome, remarks, and digital sign-off. Provides the auditable evidence trail for QA/QC compliance.';

CREATE OR REPLACE TABLE `construction_ecm`.`quality`.`test_certificate` (
    `test_certificate_id` BIGINT COMMENT 'Primary key for test_certificate',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Material test certificates are contract‑required evidence of compliance; contract link supports audit and payment certification.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Test certificates (load test, pressure test, NDT certificates) are issued for specific pieces of equipment. Construction regulatory compliance requires traceability from test certificates to the speci',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project for which the material was tested. Links the certificate to the project quality records.',
    `contract_milestone_id` BIGINT COMMENT 'Foreign key linking to contract.contract_milestone. Business justification: Test certificates (concrete, structural, material) are required as evidence before milestone sign-off in the Milestone Quality Gate process. Construction contracts mandate test certificate submissio',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Test certificates for materials and equipment reference the drawing specifying the component being tested (e.g., structural steel drawing for mill certificates). Required for material traceability rep',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Test certificates are matched to specific goods receipt batches during incoming material inspection. Construction QA requires direct traceability from test certificate to the delivery batch (heat numb',
    `itp_id` BIGINT COMMENT 'Foreign key linking to quality.itp. Business justification: Test certificates are often issued for ITP items and may be associated with NCRs; linking enables direct lookup.',
    `itp_line_id` BIGINT COMMENT 'Foreign key linking to quality.itp_line. Business justification: A material test certificate satisfies a specific ITP line requirement (e.g., the ITP line for concrete pour requires a compressive strength test certificate). test_certificate already has itp_id -> it',
    `material_catalog_id` BIGINT COMMENT 'Foreign key linking to procurement.material_catalog. Business justification: Links material test certificates to the material master record, enabling traceability of test results to specific catalog items.',
    `material_delivery_id` BIGINT COMMENT 'Foreign key linking to site.material_delivery. Business justification: Material Traceability: Test certificates are issued for specific material deliveries to confirm compliance with specifications. QA managers and client inspectors use this link to verify that every acc',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Test certificates are required as permit milestone evidence — e.g., concrete strength certificates must be accepted before a permit allows structural loading. QA and permit managers need direct test_c',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to project.site. Business justification: Test certificates are issued for materials and work at a specific site. Site-level material test certificate registers are required for regulatory compliance, handover documentation, and client accept',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Test certificates (mill certs, MTRs) are issued for materials delivered under a specific PO. Construction material acceptance requires linking test certs to the originating PO for three-way match and ',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Material test certificates (structural steel, concrete, fire-rated materials) are submitted to regulatory authorities as compliance evidence. The regulatory submission bundles these certificates; link',
    `subcontract_id` BIGINT COMMENT 'Foreign key linking to contract.subcontract. Business justification: Test certificates for materials and workmanship are issued under specific subcontracts in the Subcontractor Material Compliance process. Construction QA requires test certificates to be traceable to',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Test certificates directly reference the technical specification defining test requirements and acceptance criteria. This is a fundamental construction QA traceability link — auditors verify test resu',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Material test certificates are linked to the WBS element using the material, supporting compliance reporting.',
    `accreditation_body` STRING COMMENT 'Name of the accreditation authority that certified the laboratory (e.g., UKAS, A2LA, NABL, NATA).',
    `approval_date` DATE COMMENT 'Date when the test certificate was formally approved and released for use in construction quality records.',
    `approved_by` STRING COMMENT 'Name of the quality manager, engineer, or authorized signatory who reviewed and approved the test certificate.',
    `batch_number` STRING COMMENT 'Manufacturer or supplier batch number identifying the production lot from which the sample was taken. Critical for traceability and recall management.',
    `certificate_expiry_date` DATE COMMENT 'Date when the certificate validity expires, if applicable. Some certificates have time-limited validity for regulatory or contractual reasons.',
    `certificate_issue_date` DATE COMMENT 'Date when the certificate was officially issued by the laboratory or supplier. This is the principal business event timestamp for the certificate lifecycle.',
    `certificate_number` STRING COMMENT 'Externally-known unique certificate number issued by the testing laboratory or supplier. This is the business identifier printed on the physical or digital certificate document.',
    `certificate_status` STRING COMMENT 'Current lifecycle status of the test certificate in the quality management workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|superseded|expired — 7 candidates stripped; promote to reference product]',
    `certificate_type` STRING COMMENT 'Classification of the test certificate indicating the source and nature of testing. MTC (Material Test Certificate) from supplier, laboratory test from independent lab, factory test (FAT - Factory Acceptance Test), site test (SAT - Site Acceptance Test), third-party test from accredited body, or supplier certificate.. Valid values are `MTC|laboratory_test|factory_test|site_test|third_party_test|supplier_certificate`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this test certificate record was first created in the quality management system.',
    `delivery_lot_number` STRING COMMENT 'Delivery or shipment lot number identifying the specific material consignment from which the sample was taken. Links certificate to goods receipt.',
    `document_url` STRING COMMENT 'URL or file path to the digital copy of the test certificate document stored in the document management system (e.g., Aconex, BIM 360, Procore).',
    `heat_number` STRING COMMENT 'Steel mill heat number for steel and rebar materials, identifying the specific furnace melt. Essential for metallurgical traceability.',
    `issuing_laboratory` STRING COMMENT 'Name of the testing laboratory or organization that performed the tests and issued the certificate.',
    `laboratory_accreditation_number` STRING COMMENT 'Accreditation certificate number issued by the national or international accreditation body (e.g., ISO/IEC 17025 accreditation number). Validates the laboratorys competence.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this test certificate record was last updated in the quality management system.',
    `material_description` STRING COMMENT 'Detailed textual description of the material being tested, including grade, specification, and any relevant characteristics (e.g., Grade 60 Rebar, M30 Concrete, AC-20 Bitumen).',
    `material_type` STRING COMMENT 'Category of construction material being tested. Covers primary materials used in infrastructure and building construction projects. [ENUM-REF-CANDIDATE: concrete|steel|aggregate|bitumen|soil|asphalt|geotextile|cement|rebar|structural_steel|weld|paint|coating — 13 candidates stripped; promote to reference product]',
    `pass_fail_status` STRING COMMENT 'Overall determination of whether the tested material meets the specification requirements. Conditional pass indicates minor deviations requiring engineering review.. Valid values are `pass|fail|conditional_pass|pending_review`',
    `remarks` STRING COMMENT 'Additional notes, observations, or comments from the testing laboratory or quality engineer regarding the test results, sample condition, or special circumstances.',
    `sampling_date` DATE COMMENT 'Date when the material sample was collected from the batch, delivery, or construction site for testing.',
    `sampling_location` STRING COMMENT 'Physical location where the material sample was collected (e.g., site name, warehouse, delivery truck, production line, grid reference).',
    `specification_requirement` STRING COMMENT 'Required values or acceptance criteria per project specification, contract, or standard (e.g., minimum compressive strength 30 MPa, yield strength 420 MPa min).',
    `technician_name` STRING COMMENT 'Name of the laboratory technician or engineer who performed the testing and signed the certificate.',
    `test_date` DATE COMMENT 'Date when the laboratory or field testing was performed on the sample.',
    `test_method` STRING COMMENT 'Specific testing procedure or method applied (e.g., compression test, tensile test, slump test, sieve analysis, chemical analysis).',
    `test_parameters` STRING COMMENT 'List of specific properties or characteristics measured during testing (e.g., compressive strength, yield strength, elongation, gradation, moisture content). Stored as structured text or JSON.',
    `test_results` STRING COMMENT 'Measured values and outcomes for each test parameter. Stored as structured text or JSON containing parameter-value pairs with units.',
    `test_standard` STRING COMMENT 'Industry or regulatory test standard followed during testing (e.g., ASTM C39, BS EN 12390, AASHTO T22, ISO 6892). Defines the test methodology and acceptance criteria.',
    `work_package_code` STRING COMMENT 'Work Breakdown Structure (WBS) code or work package identifier indicating where the tested material will be used in the project.',
    CONSTRAINT pk_test_certificate PRIMARY KEY(`test_certificate_id`)
) COMMENT 'Material test certificate and laboratory test result record capturing certified testing outcomes for construction materials (concrete, steel, aggregates, bitumen, soil, asphalt, geotextiles). Stores certificate number, sample ID, material type, batch/heat number, sampling date and location, test standard (ASTM, BS, EN, AASHTO), test parameters and measured values, pass/fail determination, issuing laboratory, laboratory accreditation number, and traceability to purchase order and delivery lot. Covers both third-party MTC documents received from suppliers and in-house/independent lab test results for site-sampled materials.';

CREATE OR REPLACE TABLE `construction_ecm`.`quality`.`defect` (
    `defect_id` BIGINT COMMENT 'Unique identifier for the defect record. Primary key for the defect entity.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Defect tracking links defects to the activity where they were discovered, enabling schedule‑based defect reporting.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Defects are tied to contractual warranty periods and penalties; contract reference enables warranty and LD calculations.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Defects in construction are raised against specific equipment assets (e.g., crane structural defect, generator commissioning failure). Direct asset_id FK on defect enables equipment-specific defect re',
    `closeout_id` BIGINT COMMENT 'Foreign key linking to contract.closeout. Business justification: Defects raised during the Defects Liability Period are tracked against the specific contract closeout that defines the DLP window. The DLP Defect Management process requires linking each defect to i',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project where the defect was identified.',
    `contract_milestone_id` BIGINT COMMENT 'Foreign key linking to contract.contract_milestone. Business justification: Defects are tracked against DLP milestones (Performance Certificate, Final Certificate) in the DLP Defect Tracking process. Construction contracts require all defects to be resolved before the relev',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Defects are logged against the drawing that defines the affected element for corrective action.',
    `drawing_revision_id` BIGINT COMMENT 'Foreign key linking to design.drawing_revision. Business justification: Defects must reference the drawing revision current at identification — critical for DLP (Defect Liability Period) management and contractor liability attribution. defect.drawing_id links to drawing b',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Defect rectification costs must be coded to a finance cost code for job costing, contractor back-charge processing, and defect liability period cost tracking. Construction QA managers and finance cont',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Defects (structural cracks, failed welds, fire protection failures) may directly cause or be caused by a safety incident. Linking defect to incident supports root cause analysis and regulatory reporti',
    `inspection_id` BIGINT COMMENT 'System identifier for the inspection record during which this defect was identified (e.g., ITP inspection, FAT, SAT, DLP walkthrough).',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: Defect may be raised from an NCR; linking provides traceability.',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Defects are tracked by phase (construction vs DLP) for contractual liability and handover gate reporting. The existing identified_phase column is a plain-text denormalization of the phase entity; repl',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to project.site. Business justification: Defects are identified at a specific site. DLP defect tracking by site is a contractual requirement; site-level defect closeout reports are submitted to clients during handover and throughout the defe',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Defect rectification crew assignment: defect has assigned_to as plain text. A responsible_crew_id FK identifies which crew is accountable for rectifying the defect, enabling defect-by-crew performance',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Defects with safety implications must reference the risk assessment to determine if the risk profile has changed and whether a stop-work order is required. Construction QA-HSE managers use this link t',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Defect records often cite the specific spec clause violated; FK enables traceability.',
    `trade_package_id` BIGINT COMMENT 'Foreign key linking to bid.trade_package. Business justification: Defects are attributed to the responsible trade package (subcontractor scope) for defect liability period tracking and rectification accountability. This link drives DLP management reports and subcont',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Defects during DLP (Defect Liability Period) are attributed to responsible vendors/subcontractors for cost recovery and retention release decisions. responsible_contractor_name is a denormalized tex',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Defects are recorded against the WBS element where they occur, enabling root‑cause analysis.',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Defect Location Management: Defects are identified at specific work fronts during inspections and DLP walkovers. Project engineers and QA managers use this link to generate work-front defect registers',
    `actual_rectification_date` DATE COMMENT 'Actual date when the defect rectification work was completed.',
    `assigned_to` STRING COMMENT 'Name of the individual or team currently assigned to manage or rectify the defect.',
    `closure_date` DATE COMMENT 'Date when the defect record was formally closed after successful verification and acceptance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the defect record was first created in the system.',
    `defect_description` STRING COMMENT 'Detailed description of the defect including nature, extent, and any observable symptoms or deviations from specification.',
    `defect_number` STRING COMMENT 'Business-facing unique identifier or reference number for the defect, typically used in correspondence and reporting.',
    `defect_status` STRING COMMENT 'Current lifecycle status of the defect: open (newly identified), assigned (allocated to responsible party), in_progress (rectification underway), rectified (work completed, awaiting verification), verified (inspected and accepted), closed (fully resolved), rejected (not a valid defect). [ENUM-REF-CANDIDATE: open|assigned|in_progress|rectified|verified|closed|rejected — 7 candidates stripped; promote to reference product]',
    `defect_type` STRING COMMENT 'Classification of the defect by nature: workmanship (poor execution), material (defective materials), design (design flaw), installation (incorrect installation), finish (cosmetic/surface defects), structural (load-bearing issues), MEP (Mechanical Electrical Plumbing systems), or other. [ENUM-REF-CANDIDATE: workmanship|material|design|installation|finish|structural|MEP|other — 8 candidates stripped; promote to reference product]',
    `identified_by` STRING COMMENT 'Name of the person or role who identified the defect (e.g., QA/QC inspector, client representative, commissioning engineer, site supervisor).',
    `identified_date` DATE COMMENT 'Date when the defect was first identified or discovered during inspection, commissioning, or DLP (Defects Liability Period) walkthrough.',
    `impact_on_handover` BOOLEAN COMMENT 'Indicates whether the defect impacts project handover or commissioning milestones (True if it blocks handover, False otherwise).',
    `location_building` STRING COMMENT 'Building or structure identifier where the defect is located (e.g., Building A, Main Terminal, Power Block 1).',
    `location_grid_reference` STRING COMMENT 'Grid reference or coordinate system identifier pinpointing the defect location on construction drawings (e.g., Grid A-3, Column Line B/5).',
    `location_level` STRING COMMENT 'Floor or level identifier where the defect is located (e.g., Ground Floor, Level 3, Basement 2, Roof).',
    `location_zone` STRING COMMENT 'Zone, area, or room identifier where the defect is located (e.g., Zone A, Room 301, Lobby, Mechanical Room).',
    `modified_by` STRING COMMENT 'Username or identifier of the person who last modified the defect record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the defect record was last modified or updated.',
    `photo_reference` STRING COMMENT 'Reference or file path to photographic evidence of the defect, typically stored in document management system (e.g., Aconex, BIM 360).',
    `rectification_cost` DECIMAL(18,2) COMMENT 'Estimated or actual cost incurred to rectify the defect, typically borne by the responsible contractor.',
    `rectification_method` STRING COMMENT 'Description of the method or approach used to rectify the defect (e.g., rework, replacement, repair, adjustment, re-finishing).',
    `remarks` STRING COMMENT 'Additional comments, notes, or observations related to the defect, rectification process, or verification outcome.',
    `severity` STRING COMMENT 'Severity classification of the defect: critical (safety/structural risk, immediate action required), major (significant impact on functionality or performance), minor (limited impact, does not affect primary function), cosmetic (aesthetic only, no functional impact).. Valid values are `critical|major|minor|cosmetic`',
    `target_rectification_date` DATE COMMENT 'Target or planned date by which the defect should be rectified, often driven by DLP (Defects Liability Period) expiry or contractual milestones.',
    `title` STRING COMMENT 'Short descriptive title or summary of the defect for quick identification and reporting.',
    `trade_discipline` STRING COMMENT 'Construction trade or discipline responsible for the work where the defect occurred (e.g., Concrete, Steel, MEP, HVAC, Electrical, Plumbing, Finishes, Painting).',
    `verification_date` DATE COMMENT 'Date when the rectified defect was inspected and verified as satisfactorily resolved by QA/QC or client representative.',
    `verified_by` STRING COMMENT 'Name of the person or role who verified the defect rectification (e.g., QA/QC inspector, client representative, project engineer).',
    `created_by` STRING COMMENT 'Username or identifier of the person who created the defect record in the system.',
    CONSTRAINT pk_defect PRIMARY KEY(`defect_id`)
) COMMENT 'Defect record tracking a physical construction defect identified during inspection, commissioning, or the Defects Liability Period (DLP). Captures defect description, location (grid reference, level, zone), severity classification, responsible trade/subcontractor, date identified, target rectification date, rectification method, and closure status. Distinct from NCR in that defects may arise post-handover during DLP.';

CREATE OR REPLACE TABLE `construction_ecm`.`quality`.`punch_list` (
    `punch_list_id` BIGINT COMMENT 'Unique identifier for the punch list record. Primary key for the punch list entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Punch list close‑out is a contractual deliverable; linking to agreement tracks fulfillment of contract milestones.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Client oversees punch‑list during project handover; required for client‑focused punch‑list status reports.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Construction handover requires a named client representative to sign off punch lists. Replacing the denormalized client_representative text field with a FK to client.contact formalizes the handover si',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this punch list belongs.',
    `contract_milestone_id` BIGINT COMMENT 'Foreign key linking to contract.contract_milestone. Business justification: Punch lists are formally tied to contract milestones (Practical Completion, Mechanical Completion) in the Milestone Completion Gate process. Construction contracts require punch list closure before ',
    `handover_package_id` BIGINT COMMENT 'Foreign key linking to design.handover_package. Business justification: Punch lists are directly associated with handover packages — all punch items must be cleared before a handover package is accepted by the client. This is a fundamental construction handover process; Q',
    `hse_plan_id` BIGINT COMMENT 'Foreign key linking to safety.hse_plan. Business justification: Punch lists at project completion/handover must be reviewed against the HSE plan to ensure all safety-related quality items are closed before handover. Construction clients require HSE plan sign-off a',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Permit closeout punch list: punch list items must be resolved before a permit can be closed, linking punch list to its permit.',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Punch lists are compiled at specific phase gates (mechanical completion, pre-commissioning, final handover). Phase-gate punch list closeout is a contractual handover requirement tracked in constructio',
    `plan_id` BIGINT COMMENT 'Foreign key linking to quality.quality_plan. Business justification: A punch list (snagging list) is a quality closeout instrument governed by the Project Quality Plan. The quality_plan defines handover_quality_requirements and defect_liability_period_days, which direc',
    `progress_billing_id` BIGINT COMMENT 'Foreign key linking to finance.progress_billing. Business justification: Punch list closeout status is a contractual prerequisite for progress billing certification and milestone payment release in construction. Finance teams cannot certify a payment application without co',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to project.site. Business justification: Punch lists are compiled per site area during handover. Site-level punch list closeout status is a standard construction handover gate requirement tracked by project managers and client representative',
    `trade_package_id` BIGINT COMMENT 'Foreign key linking to bid.trade_package. Business justification: Punch lists at project closeout are organized by trade package, assigning closeout accountability to the responsible subcontractor. This link supports subcontractor closeout tracking, final payment ce',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Punch lists are generated per WBS element to allocate cost and schedule impacts accurately.',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Handover Punch List Scoping: Punch lists are scoped to specific work fronts/zones for commissioning and handover. Project managers and client representatives use this link to manage handover readiness',
    `actual_closeout_date` DATE COMMENT 'The actual date on which the punch list was fully closed, indicating all items have been resolved and accepted. Nullable until closure is achieved.',
    `closed_items_count` STRING COMMENT 'The current count of punch list items that have been resolved and closed. Indicates progress toward full punch list closure.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'The percentage of punch list items that have been closed, calculated as (closed_items_count / total_items_count) * 100. Provides a quick progress indicator.',
    `contract_reference` STRING COMMENT 'Reference to the contract or contract package under which this punch list is being managed. Links the punch list to contractual obligations and terms.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this punch list record was first created in the system. Part of the audit trail for record lifecycle tracking.',
    `critical_items_count` STRING COMMENT 'The count of items classified as critical or high-priority, typically those that block handover or pose safety/operational risks.',
    `discipline` STRING COMMENT 'The engineering or construction discipline that this punch list primarily covers. Used to route items to the appropriate trade or subcontractor for resolution. [ENUM-REF-CANDIDATE: civil|structural|architectural|mechanical|electrical|plumbing|hvac|instrumentation|piping|general — 10 candidates stripped; promote to reference product]',
    `dlp_commencement_gate` BOOLEAN COMMENT 'Boolean flag indicating whether closure of this punch list triggers the start of the Defects Liability Period (DLP). True means DLP clock starts upon punch list closure.',
    `document_reference` STRING COMMENT 'Reference to the formal punch list document, report, or file stored in the document management system (e.g., Aconex, BIM 360). Enables traceability to the source document.',
    `handover_gate` BOOLEAN COMMENT 'Boolean flag indicating whether closure of this punch list is a contractual gate for project handover. True means handover cannot proceed until this list is closed.',
    `inspection_date` DATE COMMENT 'The date on which the inspection was conducted that resulted in the creation of this punch list. Typically the date of the pre-handover or milestone inspection walk-through.',
    `modified_by` STRING COMMENT 'The username or identifier of the user who last modified this punch list record. Part of the audit trail for accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this punch list record was last modified or updated. Part of the audit trail for record lifecycle tracking.',
    `open_items_count` STRING COMMENT 'The current count of punch list items that remain open or unresolved. Used to track progress toward close-out.',
    `prepared_by` STRING COMMENT 'Name of the individual or role who prepared or compiled the punch list, typically a QA/QC inspector, project engineer, or commissioning manager.',
    `priority` STRING COMMENT 'Overall priority classification for the punch list, reflecting the urgency and impact of the items it contains. Critical punch lists may block handover or commissioning.. Valid values are `critical|high|medium|low`',
    `project_area` STRING COMMENT 'The physical area, zone, building, or section of the project to which this punch list applies (e.g., Building A, Zone 3, East Wing, Substation 2).',
    `punch_list_name` STRING COMMENT 'Descriptive name or title for the punch list, often indicating the milestone, area, or phase it relates to (e.g., Mechanical Completion - Building A, Practical Completion - Zone 3).',
    `punch_list_number` STRING COMMENT 'Business identifier for the punch list, typically a human-readable code or number used for tracking and reference in project documentation and handover processes.',
    `punch_list_status` STRING COMMENT 'Current lifecycle status of the punch list. Indicates whether the list is being compiled, actively worked, under review, or closed out.. Valid values are `draft|open|in_progress|under_review|closed|cancelled`',
    `remarks` STRING COMMENT 'General comments, notes, or observations related to the punch list. May include context on delays, coordination issues, or special conditions affecting close-out.',
    `responsible_party_type` STRING COMMENT 'Classification of the party responsible for punch list resolution. Helps route accountability and track performance by party type.. Valid values are `general_contractor|subcontractor|supplier|joint_venture|client|consultant`',
    `reviewed_by` STRING COMMENT 'Name of the individual or role who reviewed and approved the punch list for issuance, typically a project manager, client representative, or QA/QC manager.',
    `specification_reference` STRING COMMENT 'Reference to the technical specification, design document, or quality standard against which the punch list items are being evaluated.',
    `target_closeout_date` DATE COMMENT 'The planned or contractually required date by which all items on the punch list must be resolved and the list closed. Critical for handover and DLP (Defects Liability Period) commencement.',
    `total_items_count` STRING COMMENT 'The total number of punch list items (defects, incomplete works, commissioning tasks) recorded on this punch list.',
    `created_by` STRING COMMENT 'The username or identifier of the user who created this punch list record in the system. Part of the audit trail for accountability.',
    `creation_date` DATE COMMENT 'The date on which the punch list was initially created or issued. Marks the start of the close-out tracking process for the associated milestone.',
    CONSTRAINT pk_punch_list PRIMARY KEY(`punch_list_id`)
) COMMENT 'Punch list (snagging list) master record grouping outstanding defects, incomplete works, and commissioning items requiring resolution before a project milestone (mechanical completion, practical completion, or handover). Captures punch list number, associated milestone, project area/zone, creation date, total items count, open/closed item counts, target close-out date, responsible party, and overall status. Drives the close-out workflow that gates contractual handover.';

CREATE OR REPLACE TABLE `construction_ecm`.`quality`.`punch_item` (
    `punch_item_id` BIGINT COMMENT 'Unique identifier for the punch list item. Primary key.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Punch list generation ties each punch item to its originating activity for close‑out verification and handover.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Each punch item must be traced to the governing contract for liability and final acceptance.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Punch items at project handover frequently reference specific equipment assets with deficiencies (missing certifications, failed commissioning tests, incomplete installations). Construction handover p',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project where this punch item was identified. Enables project-level defect tracking and close-out reporting.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Punch item assignment to a worker enables tracking of who will close the item.',
    `defect_id` BIGINT COMMENT 'Foreign key linking to quality.defect. Business justification: A punch item often represents a physical defect that needs rectification before project handover. The defect table tracks the technical details of the physical non-conformance, while the punch_item tr',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Punch items track deficiencies on particular drawings; FK enables linkage to BIM models.',
    `drawing_revision_id` BIGINT COMMENT 'Foreign key linking to design.drawing_revision. Business justification: Punch items reference the specific drawing revision identifying the deficiency location and rectification requirement. punch_item.drawing_id links to drawing but revision-level traceability ensures re',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Punch items often generate change order costs; linking each punch_item to a cost code enables precise cost tracking for close‑out.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Punch items arising from safety incidents (damaged safety-critical equipment, failed fire protection) must reference the originating incident. Enables incident-driven punch list tracking and ensures s',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to quality.inspection. Business justification: Punch items are frequently identified during formal inspection events (e.g., pre-handover inspection, commissioning inspection). Linking punch_item.inspection_id -> inspection.inspection_id establishe',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: A punch item can be raised as a result of an NCR disposition (e.g., rework required per NCR). Linking punch_item.ncr_id -> ncr.ncr_id establishes the traceability from the formal non-conformance repor',
    `punch_list_id` BIGINT COMMENT 'Reference to the parent punch list record that contains this item. Links the item to the overall punch list inspection event.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Punch items can be assigned to a crew for coordinated resolution; supports crew workload tracking.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Punch items with safety implications reference the risk assessment to determine priority and whether the area can be handed over. Construction commissioning teams use this link to gate handover on saf',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Punch items may reference a spec clause; FK supports audit of spec compliance.',
    `trade_package_id` BIGINT COMMENT 'Foreign key linking to bid.trade_package. Business justification: Individual punch items are assigned to the responsible trade package for rectification at closeout. This granular trade attribution drives subcontractor closeout accountability, final account settleme',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Construction closeout assigns individual punch items to specific vendors/subcontractors for rectification. Payment holdback and final account settlement depend on tracking which vendor is responsible ',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Each punch item must be tied to its originating WBS element for traceability and cost tracking.',
    `actual_completion_date` DATE COMMENT 'Actual date when the punch item was completed and ready for verification. Used to track schedule performance and close-out progress.',
    `client_representative_name` STRING COMMENT 'Name of the client representative or consultant who witnessed or approved the punch item closure. Provides client acceptance traceability.',
    `closure_status` STRING COMMENT 'Final disposition status of the punch item at project close-out. Accepted indicates satisfactory completion; rejected indicates non-conformance; deferred indicates item moved to DLP (Defects Liability Period) or post-handover.. Valid values are `pending|accepted|rejected|deferred`',
    `corrective_action` STRING COMMENT 'Description of the corrective action taken or required to resolve the punch item. Provides remediation guidance and audit trail.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost impact amount. Enables multi-currency project tracking.. Valid values are `^[A-Z]{3}$`',
    `cost_impact` DECIMAL(18,2) COMMENT 'Estimated or actual cost incurred to rectify the punch item. Used for financial tracking and back-charge to responsible parties.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the punch item record was first created in the system. Provides audit trail for data lineage.',
    `deferred_to_dlp` BOOLEAN COMMENT 'Flag indicating whether the punch item was deferred to the DLP (Defects Liability Period) for post-handover rectification. True if deferred; false otherwise.',
    `dlp_end_date` DATE COMMENT 'End date of the DLP (Defects Liability Period) applicable to this punch item if deferred. Defines the contractual deadline for rectification.',
    `identified_by` STRING COMMENT 'Name of the inspector, quality engineer, or project manager who identified the punch item during the inspection walkthrough.',
    `identified_date` DATE COMMENT 'Date when the punch item was identified during the inspection. Marks the start of the remediation lifecycle.',
    `item_description` STRING COMMENT 'Detailed description of the defect, deficiency, or incomplete work identified during inspection. Provides clear guidance for remediation.',
    `item_number` STRING COMMENT 'Sequential or hierarchical item number within the punch list. Used for tracking and referencing specific defects during close-out inspections.',
    `location` STRING COMMENT 'Physical location or area within the project where the punch item was identified. May reference building, floor, room, grid reference, or zone.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the punch item record was last modified. Tracks data currency and change history.',
    `photo_reference` STRING COMMENT 'Reference or file path to photographic evidence of the punch item. Supports visual documentation and dispute resolution.',
    `priority` STRING COMMENT 'Priority level assigned to the punch item based on impact to project completion, safety, or functionality. Critical items block practical completion; high items affect major systems; medium items are cosmetic or minor; low items are non-essential.. Valid values are `critical|high|medium|low`',
    `punch_item_category` STRING COMMENT 'Classification of the punch item by discipline or trade. Structural covers concrete, steel, and load-bearing elements; MEP (Mechanical Electrical and Plumbing) covers HVAC, electrical, plumbing, and fire protection; Architectural covers doors, windows, ceilings, and interior finishes; Civil covers site work, paving, and drainage; Finishes covers painting, flooring, and decorative elements; Landscaping covers external plantings and hardscapes.. Valid values are `structural|mep|architectural|civil|finishes|landscaping`',
    `punch_item_status` STRING COMMENT 'Current lifecycle status of the punch item. Open indicates newly identified; in_progress indicates work underway; completed indicates work finished awaiting verification; verified indicates inspection passed; closed indicates final acceptance; rejected indicates failed verification requiring rework.. Valid values are `open|in_progress|completed|verified|closed|rejected`',
    `rejection_reason` STRING COMMENT 'Reason provided by the verification inspector if the punch item was rejected after attempted completion. Drives rework and quality improvement.',
    `remarks` STRING COMMENT 'Additional notes, comments, or observations related to the punch item. Captures context, special conditions, or coordination issues.',
    `target_completion_date` DATE COMMENT 'Target date by which the punch item must be rectified. Drives scheduling and resource allocation for close-out activities.',
    `verification_date` DATE COMMENT 'Date when the completed punch item was inspected and verified as satisfactory. Marks the closure of the remediation cycle.',
    `verification_inspector` STRING COMMENT 'Name of the inspector or quality engineer who verified that the punch item was satisfactorily completed. Provides accountability for quality sign-off.',
    CONSTRAINT pk_punch_item PRIMARY KEY(`punch_item_id`)
) COMMENT 'Individual punch list item within a punch list record. Captures item number, description, location, category (structural, MEP, architectural, civil), responsible subcontractor, priority, target completion date, actual completion date, verification inspector, and closure status. Drives the close-out workflow for practical completion.';

CREATE OR REPLACE TABLE `construction_ecm`.`quality`.`plan` (
    `plan_id` BIGINT COMMENT 'Unique identifier for the Project Quality Plan (PQP). Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: A Quality Plan is a contractual deliverable prepared per agreement in the Contract Quality Management Plan process. Construction contracts explicitly require a QMP referencing the specific agreement',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: The Project Quality Plan (PQP) is a contractual deliverable requiring formal client approval in construction. Linking quality_plan to the client account enables client-specific quality plan registers,',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Construction contracts require a named client representative to formally approve the PQP. Replacing the denormalized client_approved_by_name text field with a proper FK to client.contact enables forma',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project this quality plan governs.',
    `package_id` BIGINT COMMENT 'Foreign key linking to design.package. Business justification: A quality plan governs QA requirements for a specific design/work package. Project QA managers use this link to verify that every design package has an approved quality plan before construction commen',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Quality plans are scoped to specific project phases (separate QPs for construction vs commissioning phases). Phase-specific quality plan approval is a standard PMO phase-gate requirement in constructi',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Quality plans define the inspection, testing, and audit regime whose costs are budgeted as a distinct quality cost line in construction project budgets. Finance controllers and quality managers jointl',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Quality Plans are structured to demonstrate compliance with specific regulatory obligations (building codes, ISO standards, environmental regulations). Compliance managers require quality_plan-to-regu',
    `site_id` BIGINT COMMENT 'Foreign key linking to site.site. Business justification: Site-Level Quality Governance: Quality plans are established for specific sites as a contract and regulatory requirement. QA managers and client representatives use this link to confirm a current appr',
    `applicable_standards` STRING COMMENT 'List of quality standards, codes, and specifications applicable to the project (e.g., ISO 9001, ASTM, ACI, AISC, project-specific specifications).',
    `approval_date` DATE COMMENT 'Date when the quality plan was formally approved by authorized personnel.',
    `approval_status` STRING COMMENT 'Approval state of the quality plan by client and internal stakeholders.. Valid values are `pending|approved|rejected|conditional`',
    `approved_by_name` STRING COMMENT 'Name of the individual who formally approved the quality plan for implementation.',
    `approved_by_role` STRING COMMENT 'Organizational role or title of the approver (e.g., Project Director, Quality Director).',
    `audit_schedule_reference` STRING COMMENT 'Reference to the internal and external audit schedule defined for the project.',
    `calibration_procedure_reference` STRING COMMENT 'Reference to the procedure for calibration and maintenance of inspection, measuring, and test equipment.',
    `client_approval_date` DATE COMMENT 'Date when the client formally approved the quality plan.',
    `client_approval_required` BOOLEAN COMMENT 'Indicates whether client approval is contractually required for this quality plan.',
    `continuous_improvement_mechanism` STRING COMMENT 'Description of mechanisms for continuous improvement, including lessons learned, corrective actions, and preventive actions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the quality plan record was first created in the system.',
    `defect_liability_period_days` STRING COMMENT 'Duration in days of the Defects Liability Period during which quality defects must be rectified.',
    `document_control_procedure` STRING COMMENT 'Description of document control procedures for quality records, including numbering, distribution, revision, and archival.',
    `effective_date` DATE COMMENT 'Date when the quality plan becomes binding and operational for the project.',
    `expiry_date` DATE COMMENT 'Date when the quality plan ceases to be active, typically at project completion or handover.',
    `handover_quality_requirements` STRING COMMENT 'Description of quality documentation and completion criteria required for project handover and commissioning.',
    `inspection_regime_summary` STRING COMMENT 'High-level summary of the inspection and testing regime, including hold points, witness points, and surveillance activities.',
    `itp_register_reference` STRING COMMENT 'Reference to the master ITP register that lists all inspection and test plans governed by this quality plan.',
    `material_control_procedure` STRING COMMENT 'Description of procedures for material receipt, inspection, storage, and traceability.',
    `modified_by` STRING COMMENT 'User identifier of the person who last modified the quality plan record in the system.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the quality plan record was last modified in the system.',
    `ncr_procedure_reference` STRING COMMENT 'Reference to the procedure for raising, investigating, and closing Non-Conformance Reports.',
    `organizational_structure` STRING COMMENT 'Description of the project quality organization, including roles, responsibilities, and reporting lines.',
    `plan_number` STRING COMMENT 'Externally-known unique identifier for the quality plan document, typically following organizational numbering conventions.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the quality plan document.. Valid values are `draft|under_review|approved|active|superseded|archived`',
    `prepared_by_name` STRING COMMENT 'Name of the individual or team responsible for preparing the quality plan.',
    `prepared_by_role` STRING COMMENT 'Organizational role or title of the person who prepared the quality plan (e.g., Quality Manager, QA/QC Engineer).',
    `quality_manager_name` STRING COMMENT 'Name of the designated Quality Manager responsible for implementing this plan.',
    `quality_objectives` STRING COMMENT 'Specific, measurable quality objectives defined for the project (e.g., zero NCRs in critical systems, 100% ITP compliance).',
    `quality_policy_reference` STRING COMMENT 'Reference to the organizational quality policy document that this plan implements.',
    `remarks` STRING COMMENT 'Additional notes, comments, or clarifications related to the quality plan.',
    `reviewed_by_name` STRING COMMENT 'Name of the individual who reviewed the quality plan for technical accuracy and completeness.',
    `reviewed_by_role` STRING COMMENT 'Organizational role or title of the reviewer (e.g., Project Manager, Senior QA/QC Manager).',
    `scope_of_work` STRING COMMENT 'Description of the project scope covered by this quality plan, including major deliverables and work packages.',
    `subcontractor_quality_management` STRING COMMENT 'Description of quality management requirements and oversight procedures for subcontractors and suppliers.',
    `title` STRING COMMENT 'Descriptive title of the Project Quality Plan document.',
    `training_requirements` STRING COMMENT 'Description of quality-related training requirements for project personnel, including induction, competency assessments, and certifications.',
    `version` STRING COMMENT 'Version identifier for the quality plan document, incremented with each revision.',
    `created_by` STRING COMMENT 'User identifier of the person who created the quality plan record in the system.',
    CONSTRAINT pk_plan PRIMARY KEY(`plan_id`)
) COMMENT 'Project Quality Plan (PQP) master document defining the overall QA/QC strategy for a specific project. Captures organizational quality responsibilities, applicable standards and codes, inspection regime definitions, document control procedures, audit schedule, NCR procedures, training requirements, and continuous improvement mechanisms. Serves as the top-level quality governance document per ISO 9001 and contract requirements. All ITPs, checklists, and audit programs trace back to this plan.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `construction_ecm`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `construction_ecm`.`quality`.`plan`(`plan_id`);
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `construction_ecm`.`quality`.`checklist`(`checklist_id`);
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `construction_ecm`.`quality`.`itp`(`itp_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `construction_ecm`.`quality`.`checklist`(`checklist_id`);
ALTER TABLE `construction_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_itp_line_id` FOREIGN KEY (`itp_line_id`) REFERENCES `construction_ecm`.`quality`.`itp_line`(`itp_line_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `construction_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `construction_ecm`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_itp_line_id` FOREIGN KEY (`itp_line_id`) REFERENCES `construction_ecm`.`quality`.`itp_line`(`itp_line_id`);
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `construction_ecm`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_checklist_id` FOREIGN KEY (`checklist_id`) REFERENCES `construction_ecm`.`quality`.`checklist`(`checklist_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `construction_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ADD CONSTRAINT `fk_quality_checklist_execution_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `construction_ecm`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `construction_ecm`.`quality`.`itp`(`itp_id`);
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_itp_line_id` FOREIGN KEY (`itp_line_id`) REFERENCES `construction_ecm`.`quality`.`itp_line`(`itp_line_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `construction_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `construction_ecm`.`quality`.`defect` ADD CONSTRAINT `fk_quality_defect_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `construction_ecm`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `construction_ecm`.`quality`.`plan`(`plan_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_defect_id` FOREIGN KEY (`defect_id`) REFERENCES `construction_ecm`.`quality`.`defect`(`defect_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `construction_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `construction_ecm`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_punch_list_id` FOREIGN KEY (`punch_list_id`) REFERENCES `construction_ecm`.`quality`.`punch_list`(`punch_list_id`);

-- ========= TAGS =========
ALTER SCHEMA `construction_ecm`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `construction_ecm`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `construction_ecm`.`quality`.`itp` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`quality`.`itp` SET TAGS ('dbx_subdomain' = 'inspection_planning');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `itp_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection and Test Plan (ITP) ID');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Plan Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `scope_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `subcontract_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `trade_package_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `applicable_standards` SET TAGS ('dbx_business_glossary_term' = 'Applicable Quality Standards');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'ITP Approval Date');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection and Test Plan (ITP) Approval Status');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'ITP Approved By');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `defect_liability_period_days` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period (DLP) Days');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `document_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Location');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'ITP Effective Date');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'ITP Expiry Date');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `fat_required` SET TAGS ('dbx_business_glossary_term' = 'Factory Acceptance Test (FAT) Required Flag');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `hold_point_required` SET TAGS ('dbx_business_glossary_term' = 'Hold Point Required Flag');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `inspection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `inspection_scope` SET TAGS ('dbx_business_glossary_term' = 'Inspection Scope');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `itp_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection and Test Plan (ITP) Number');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `itp_number` SET TAGS ('dbx_value_regex' = '^ITP-[A-Z0-9]{4,12}$');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `material_test_certificate_required` SET TAGS ('dbx_business_glossary_term' = 'Material Test Certificate (MTC) Required Flag');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `ndt_method_required` SET TAGS ('dbx_business_glossary_term' = 'Non-Destructive Testing (NDT) Method Required');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `prepared_by` SET TAGS ('dbx_business_glossary_term' = 'ITP Prepared By');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `qc_inspector_responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Inspector Responsible Party');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'ITP Remarks');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `review_point_required` SET TAGS ('dbx_business_glossary_term' = 'Review Point Required Flag');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'ITP Reviewed By');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Document Revision Date');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Document Revision Number');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `revision_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,3}$');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `sat_required` SET TAGS ('dbx_business_glossary_term' = 'Site Acceptance Test (SAT) Required Flag');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `test_method_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Method Reference');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Inspection and Test Plan (ITP) Title');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `wbs_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}(.[A-Z0-9]{2,6}){0,5}$');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `witness_point_required` SET TAGS ('dbx_business_glossary_term' = 'Witness Point Required Flag');
ALTER TABLE `construction_ecm`.`quality`.`itp` ALTER COLUMN `work_package_description` SET TAGS ('dbx_business_glossary_term' = 'Work Package Description');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` SET TAGS ('dbx_subdomain' = 'inspection_planning');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `itp_line_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection and Test Plan (ITP) Line ID');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Checklist Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `itp_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection and Test Plan (ITP) ID');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `material_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Material Catalog Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Crew Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `skill_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Skill Trade Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `wbs_node_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Node Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Activity Description');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `applicable_standard` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standard');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `calibration_required` SET TAGS ('dbx_business_glossary_term' = 'Calibration Required');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `client_witness_required` SET TAGS ('dbx_business_glossary_term' = 'Client Witness Required');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `consultant_witness_required` SET TAGS ('dbx_business_glossary_term' = 'Consultant Witness Required');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `environmental_conditions` SET TAGS ('dbx_business_glossary_term' = 'Environmental Conditions');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Hours');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `hold_point_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Point Type');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `hold_point_type` SET TAGS ('dbx_value_regex' = 'hold|witness|review|surveillance');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `inspection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `inspection_stage` SET TAGS ('dbx_business_glossary_term' = 'Inspection Stage');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `itp_line_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `itp_line_status` SET TAGS ('dbx_value_regex' = 'planned|ready|in_progress|completed|waived|cancelled');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `ncr_trigger_criteria` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Trigger Criteria');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `notification_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Notification Lead Time Hours');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `reference_document` SET TAGS ('dbx_business_glossary_term' = 'Reference Document');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `required_documentation` SET TAGS ('dbx_business_glossary_term' = 'Required Documentation');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `responsible_discipline` SET TAGS ('dbx_business_glossary_term' = 'Responsible Discipline');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `safety_requirements` SET TAGS ('dbx_business_glossary_term' = 'Safety Requirements');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `sampling_plan` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `sequence_dependency` SET TAGS ('dbx_business_glossary_term' = 'Sequence Dependency');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `superseded_date` SET TAGS ('dbx_business_glossary_term' = 'Superseded Date');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `test_equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment Required');
ALTER TABLE `construction_ecm`.`quality`.`itp_line` ALTER COLUMN `third_party_witness_required` SET TAGS ('dbx_business_glossary_term' = 'Third Party Witness Required');
ALTER TABLE `construction_ecm`.`quality`.`inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`quality`.`inspection` SET TAGS ('dbx_subdomain' = 'inspection_planning');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection ID');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Checklist Template ID');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Milestone Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `daily_log_id` SET TAGS ('dbx_business_glossary_term' = 'Daily Log Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `drawing_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Revision Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `field_progress_id` SET TAGS ('dbx_business_glossary_term' = 'Field Progress Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `itp_line_id` SET TAGS ('dbx_business_glossary_term' = 'Itp Line Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `material_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Material Delivery Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `production_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Production Entry Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `submittal_id` SET TAGS ('dbx_business_glossary_term' = 'Design Submittal Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `trade_package_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `checklist_template_name` SET TAGS ('dbx_business_glossary_term' = 'Checklist Template Name');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `checklist_version` SET TAGS ('dbx_business_glossary_term' = 'Checklist Version');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `defects_identified` SET TAGS ('dbx_business_glossary_term' = 'Defects Identified');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Time');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Humidity Percentage');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `inspector_certification` SET TAGS ('dbx_business_glossary_term' = 'Inspector Certification');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `inspector_signature_captured` SET TAGS ('dbx_business_glossary_term' = 'Inspector Signature Captured Flag');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `items_failed` SET TAGS ('dbx_business_glossary_term' = 'Items Failed');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `items_not_applicable` SET TAGS ('dbx_business_glossary_term' = 'Items Not Applicable');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `items_passed` SET TAGS ('dbx_business_glossary_term' = 'Items Passed');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Inspection Location Description');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Location Type');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'site|factory|workshop|laboratory|warehouse|offsite');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `ncr_raised` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Raised Flag');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `ncr_reference` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Reference');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `observations` SET TAGS ('dbx_business_glossary_term' = 'Inspection Observations');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `overall_outcome` SET TAGS ('dbx_business_glossary_term' = 'Overall Inspection Outcome');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `overall_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `photo_count` SET TAGS ('dbx_business_glossary_term' = 'Photo Count');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `reinspection_date` SET TAGS ('dbx_business_glossary_term' = 'Reinspection Date');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `reinspection_required` SET TAGS ('dbx_business_glossary_term' = 'Reinspection Required Flag');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Specification Reference');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Time');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature in Celsius');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `total_check_items` SET TAGS ('dbx_business_glossary_term' = 'Total Check Items');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `witness_signature_captured` SET TAGS ('dbx_business_glossary_term' = 'Witness Signature Captured Flag');
ALTER TABLE `construction_ecm`.`quality`.`inspection` ALTER COLUMN `work_package_reference` SET TAGS ('dbx_business_glossary_term' = 'Work Package Reference');
ALTER TABLE `construction_ecm`.`quality`.`ncr` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`quality`.`ncr` SET TAGS ('dbx_subdomain' = 'defect_control');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) ID');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Milestone Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `daily_log_id` SET TAGS ('dbx_business_glossary_term' = 'Daily Log Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `drawing_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Revision Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `env_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Env Impact Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `inspection_release_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Release Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `itp_line_id` SET TAGS ('dbx_business_glossary_term' = 'Itp Line Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `material_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Material Delivery Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `production_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Production Entry Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `rfi_id` SET TAGS ('dbx_business_glossary_term' = 'Rfi Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `subcontract_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `trade_package_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Package ID');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `client_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Client Notification Date');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `client_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Client Notification Required');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `closed_by` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Closed By');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Closure Date');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `corrective_action_responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Responsible Party');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `corrective_action_target_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Target Date');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `cost_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Currency');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `cost_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Engineering Discipline');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Disposition');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'accept_as_is|rework|repair|reject|scrap|use_as_is_with_concession');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `disposition_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Disposition Approved By');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `disposition_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Approved Date');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `disposition_justification` SET TAGS ('dbx_business_glossary_term' = 'Disposition Justification');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `effectiveness_review_comments` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Comments');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `estimated_cost_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Impact');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `estimated_cost_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `hold_release_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Date');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Identified Date');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Location Description');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `ncr_category` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Category');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `ncr_category` SET TAGS ('dbx_value_regex' = 'material|workmanship|design|documentation|dimensional|procedural');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `ncr_description` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Description');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `ncr_number` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Number');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `ncr_number` SET TAGS ('dbx_value_regex' = '^NCR-[A-Z0-9]{4,20}$');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `ncr_status` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Status');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `preventive_action_description` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Description');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `preventive_action_responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Responsible Party');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `quantity_affected` SET TAGS ('dbx_business_glossary_term' = 'Quantity Affected');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Reported By');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `reported_by_organization` SET TAGS ('dbx_business_glossary_term' = 'Reported By Organization');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Severity');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `verification_performed_by` SET TAGS ('dbx_business_glossary_term' = 'Verification Performed By');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `verification_result` SET TAGS ('dbx_business_glossary_term' = 'Verification Result');
ALTER TABLE `construction_ecm`.`quality`.`ncr` ALTER COLUMN `verification_result` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` SET TAGS ('dbx_subdomain' = 'defect_control');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Identifier');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `hse_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Plan Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) ID');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Crew Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Number');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_verification|verified|closed|cancelled');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action / Preventive Action (CAPA) Type');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|containment|interim');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Actual Cost');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Action Assigned Date');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `client_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Date');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Cost Estimate');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `effectiveness_review_comments` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Comments');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `effectiveness_review_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Date');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `effectiveness_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Outcome');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `effectiveness_review_outcome` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective|pending_review');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `is_systemic_issue` SET TAGS ('dbx_business_glossary_term' = 'Systemic Issue Flag');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Priority');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `recurrence_prevention_measures` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Prevention Measures');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `requires_client_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Client Approval Flag');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `requires_design_change` SET TAGS ('dbx_business_glossary_term' = 'Requires Design Change Flag');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA)');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'inspection|testing|document_review|audit|site_observation|measurement');
ALTER TABLE `construction_ecm`.`quality`.`corrective_action` ALTER COLUMN `verified_by_name` SET TAGS ('dbx_business_glossary_term' = 'Verified By Name');
ALTER TABLE `construction_ecm`.`quality`.`checklist` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`quality`.`checklist` SET TAGS ('dbx_subdomain' = 'inspection_planning');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Checklist ID');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `env_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Env Impact Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `scope_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `skill_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Skill Trade Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `applicable_standard` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standard');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|superseded|obsolete');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `average_pass_rate` SET TAGS ('dbx_business_glossary_term' = 'Average Pass Rate (Percentage)');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `checklist_code` SET TAGS ('dbx_business_glossary_term' = 'Checklist Code');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `checklist_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `checklist_description` SET TAGS ('dbx_business_glossary_term' = 'Checklist Description');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `checklist_name` SET TAGS ('dbx_business_glossary_term' = 'Checklist Name');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `critical_items_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Items Count');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Discipline');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `estimated_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration (Minutes)');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `hold_point_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Point Flag');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `inspection_stage` SET TAGS ('dbx_business_glossary_term' = 'Inspection Stage');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `inspection_stage` SET TAGS ('dbx_value_regex' = 'pre_work|during_work|post_work|hold_point|witness_point');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `ncr_trigger_threshold` SET TAGS ('dbx_business_glossary_term' = 'NCR (Non-Conformance Report) Trigger Threshold');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `reference_documents` SET TAGS ('dbx_business_glossary_term' = 'Reference Documents');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `required_equipment` SET TAGS ('dbx_business_glossary_term' = 'Required Equipment');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `required_qualifications` SET TAGS ('dbx_business_glossary_term' = 'Required Qualifications');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `revision_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `safety_requirements` SET TAGS ('dbx_business_glossary_term' = 'Safety Requirements');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `total_check_items` SET TAGS ('dbx_business_glossary_term' = 'Total Check Items');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `witness_point_flag` SET TAGS ('dbx_business_glossary_term' = 'Witness Point Flag');
ALTER TABLE `construction_ecm`.`quality`.`checklist` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` SET TAGS ('dbx_subdomain' = 'inspection_planning');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `checklist_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Checklist Execution ID');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Checklist Template ID');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Craft Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|revision_required');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `compliance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Compliance Percentage');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `critical_failure_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Failure Flag');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `defects_identified` SET TAGS ('dbx_business_glossary_term' = 'Defects Identified');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `document_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Number');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `execution_end_time` SET TAGS ('dbx_business_glossary_term' = 'Execution End Time');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `execution_number` SET TAGS ('dbx_business_glossary_term' = 'Execution Number');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `execution_start_time` SET TAGS ('dbx_business_glossary_term' = 'Execution Start Time');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `fail_count` SET TAGS ('dbx_business_glossary_term' = 'Fail Count');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `humidity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Humidity Percentage');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `inspection_stage` SET TAGS ('dbx_business_glossary_term' = 'Inspection Stage');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `inspection_stage` SET TAGS ('dbx_value_regex' = 'pre_construction|during_construction|post_construction|commissioning|DLP');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `inspector_remarks` SET TAGS ('dbx_business_glossary_term' = 'Inspector Remarks');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `inspector_signature_captured` SET TAGS ('dbx_business_glossary_term' = 'Inspector Signature Captured');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `inspector_signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspector Signature Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `na_count` SET TAGS ('dbx_business_glossary_term' = 'Not Applicable (N/A) Count');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `ncr_generated_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Generated Flag');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `overall_result` SET TAGS ('dbx_business_glossary_term' = 'Overall Result');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `overall_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|not_applicable');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `pass_count` SET TAGS ('dbx_business_glossary_term' = 'Pass Count');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Celsius)');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `total_items` SET TAGS ('dbx_business_glossary_term' = 'Total Items');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `witness_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `witness_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Witness Required Flag');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `witness_signature_captured` SET TAGS ('dbx_business_glossary_term' = 'Witness Signature Captured');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `witness_signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Witness Signature Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`checklist_execution` ALTER COLUMN `work_activity_description` SET TAGS ('dbx_business_glossary_term' = 'Work Activity Description');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` SET TAGS ('dbx_subdomain' = 'inspection_planning');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `test_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Test Certificate Identifier');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Milestone Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `itp_id` SET TAGS ('dbx_business_glossary_term' = 'Itp Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `itp_line_id` SET TAGS ('dbx_business_glossary_term' = 'Itp Line Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `material_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Material Master Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `material_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Material Delivery Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `subcontract_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate Status');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Certificate Type');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `certificate_type` SET TAGS ('dbx_value_regex' = 'MTC|laboratory_test|factory_test|site_test|third_party_test|supplier_certificate');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `delivery_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Lot Number');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `heat_number` SET TAGS ('dbx_business_glossary_term' = 'Heat Number');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `issuing_laboratory` SET TAGS ('dbx_business_glossary_term' = 'Issuing Laboratory');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `laboratory_accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Accreditation Number');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|pending_review');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `sampling_date` SET TAGS ('dbx_business_glossary_term' = 'Sampling Date');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `sampling_location` SET TAGS ('dbx_business_glossary_term' = 'Sampling Location');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `specification_requirement` SET TAGS ('dbx_business_glossary_term' = 'Specification Requirement');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `technician_name` SET TAGS ('dbx_business_glossary_term' = 'Technician Name');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `technician_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `test_parameters` SET TAGS ('dbx_business_glossary_term' = 'Test Parameters');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `test_results` SET TAGS ('dbx_business_glossary_term' = 'Test Results');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `test_standard` SET TAGS ('dbx_business_glossary_term' = 'Test Standard');
ALTER TABLE `construction_ecm`.`quality`.`test_certificate` ALTER COLUMN `work_package_code` SET TAGS ('dbx_business_glossary_term' = 'Work Package Code');
ALTER TABLE `construction_ecm`.`quality`.`defect` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`quality`.`defect` SET TAGS ('dbx_subdomain' = 'defect_control');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `defect_id` SET TAGS ('dbx_business_glossary_term' = 'Defect ID');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `closeout_id` SET TAGS ('dbx_business_glossary_term' = 'Closeout Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Milestone Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `drawing_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Revision Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Related Inspection ID');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Crew Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `trade_package_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `actual_rectification_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Rectification Date');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Assigned To');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `defect_number` SET TAGS ('dbx_business_glossary_term' = 'Defect Number');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `defect_status` SET TAGS ('dbx_business_glossary_term' = 'Defect Status');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `defect_type` SET TAGS ('dbx_business_glossary_term' = 'Defect Type');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `identified_by` SET TAGS ('dbx_business_glossary_term' = 'Identified By');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Defect Identified Date');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `impact_on_handover` SET TAGS ('dbx_business_glossary_term' = 'Impact on Handover');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `location_building` SET TAGS ('dbx_business_glossary_term' = 'Location Building');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `location_grid_reference` SET TAGS ('dbx_business_glossary_term' = 'Location Grid Reference');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `location_level` SET TAGS ('dbx_business_glossary_term' = 'Location Level');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `location_zone` SET TAGS ('dbx_business_glossary_term' = 'Location Zone');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `photo_reference` SET TAGS ('dbx_business_glossary_term' = 'Photo Reference');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `rectification_cost` SET TAGS ('dbx_business_glossary_term' = 'Rectification Cost');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `rectification_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `rectification_method` SET TAGS ('dbx_business_glossary_term' = 'Rectification Method');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Defect Severity');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|cosmetic');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `target_rectification_date` SET TAGS ('dbx_business_glossary_term' = 'Target Rectification Date');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Defect Title');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `trade_discipline` SET TAGS ('dbx_business_glossary_term' = 'Trade Discipline');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `construction_ecm`.`quality`.`defect` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` SET TAGS ('dbx_subdomain' = 'defect_control');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `punch_list_id` SET TAGS ('dbx_business_glossary_term' = 'Punch List ID');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Milestone Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `handover_package_id` SET TAGS ('dbx_business_glossary_term' = 'Handover Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `hse_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Plan Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Plan Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `progress_billing_id` SET TAGS ('dbx_business_glossary_term' = 'Progress Billing Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `trade_package_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `actual_closeout_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Close-Out Date');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `closed_items_count` SET TAGS ('dbx_business_glossary_term' = 'Closed Items Count');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `critical_items_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Items Count');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Discipline');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `dlp_commencement_gate` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period (DLP) Commencement Gate');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `handover_gate` SET TAGS ('dbx_business_glossary_term' = 'Handover Gate');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `open_items_count` SET TAGS ('dbx_business_glossary_term' = 'Open Items Count');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `prepared_by` SET TAGS ('dbx_business_glossary_term' = 'Prepared By');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Punch List Priority');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `project_area` SET TAGS ('dbx_business_glossary_term' = 'Project Area');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `punch_list_name` SET TAGS ('dbx_business_glossary_term' = 'Punch List Name');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `punch_list_number` SET TAGS ('dbx_business_glossary_term' = 'Punch List Number');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `punch_list_status` SET TAGS ('dbx_business_glossary_term' = 'Punch List Status');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `punch_list_status` SET TAGS ('dbx_value_regex' = 'draft|open|in_progress|under_review|closed|cancelled');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Type');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_value_regex' = 'general_contractor|subcontractor|supplier|joint_venture|client|consultant');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Specification Reference');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `target_closeout_date` SET TAGS ('dbx_business_glossary_term' = 'Target Close-Out Date');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `total_items_count` SET TAGS ('dbx_business_glossary_term' = 'Total Items Count');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `construction_ecm`.`quality`.`punch_list` ALTER COLUMN `creation_date` SET TAGS ('dbx_business_glossary_term' = 'Punch List Creation Date');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` SET TAGS ('dbx_subdomain' = 'defect_control');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `punch_item_id` SET TAGS ('dbx_business_glossary_term' = 'Punch Item ID');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `defect_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `drawing_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Revision Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `punch_list_id` SET TAGS ('dbx_business_glossary_term' = 'Punch List ID');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Crew Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `trade_package_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `client_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Client Representative Name');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `closure_status` SET TAGS ('dbx_business_glossary_term' = 'Closure Status');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `closure_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|rejected|deferred');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `cost_impact` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `cost_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `deferred_to_dlp` SET TAGS ('dbx_business_glossary_term' = 'Deferred to DLP (Defects Liability Period)');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `dlp_end_date` SET TAGS ('dbx_business_glossary_term' = 'DLP (Defects Liability Period) End Date');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `identified_by` SET TAGS ('dbx_business_glossary_term' = 'Identified By');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Identified Date');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Punch Item Description');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `item_number` SET TAGS ('dbx_business_glossary_term' = 'Punch Item Number');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Punch Item Location');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `photo_reference` SET TAGS ('dbx_business_glossary_term' = 'Photo Reference');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Punch Item Priority');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `punch_item_category` SET TAGS ('dbx_business_glossary_term' = 'Punch Item Category');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `punch_item_category` SET TAGS ('dbx_value_regex' = 'structural|mep|architectural|civil|finishes|landscaping');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `punch_item_status` SET TAGS ('dbx_business_glossary_term' = 'Punch Item Status');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `punch_item_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|verified|closed|rejected');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `construction_ecm`.`quality`.`punch_item` ALTER COLUMN `verification_inspector` SET TAGS ('dbx_business_glossary_term' = 'Verification Inspector');
ALTER TABLE `construction_ecm`.`quality`.`plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`quality`.`plan` SET TAGS ('dbx_subdomain' = 'defect_control');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Plan ID');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `applicable_standards` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standards');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `approved_by_role` SET TAGS ('dbx_business_glossary_term' = 'Approved By Role');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `audit_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Schedule Reference');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `calibration_procedure_reference` SET TAGS ('dbx_business_glossary_term' = 'Calibration Procedure Reference');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `client_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Date');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `client_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Required');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `continuous_improvement_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Continuous Improvement Mechanism');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `defect_liability_period_days` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period (DLP) Days');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `document_control_procedure` SET TAGS ('dbx_business_glossary_term' = 'Document Control Procedure');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `handover_quality_requirements` SET TAGS ('dbx_business_glossary_term' = 'Handover Quality Requirements');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `inspection_regime_summary` SET TAGS ('dbx_business_glossary_term' = 'Inspection Regime Summary');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `itp_register_reference` SET TAGS ('dbx_business_glossary_term' = 'Inspection and Test Plan (ITP) Register Reference');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `material_control_procedure` SET TAGS ('dbx_business_glossary_term' = 'Material Control Procedure');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `ncr_procedure_reference` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Procedure Reference');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `organizational_structure` SET TAGS ('dbx_business_glossary_term' = 'Organizational Structure');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Project Quality Plan (PQP) Number');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|superseded|archived');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `prepared_by_name` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Name');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `prepared_by_role` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Role');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `quality_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Manager Name');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `quality_objectives` SET TAGS ('dbx_business_glossary_term' = 'Quality Objectives');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `quality_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Quality Policy Reference');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `reviewed_by_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Name');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `reviewed_by_role` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Role');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `scope_of_work` SET TAGS ('dbx_business_glossary_term' = 'Scope of Work');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `subcontractor_quality_management` SET TAGS ('dbx_business_glossary_term' = 'Subcontractor Quality Management');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Quality Plan Title');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `training_requirements` SET TAGS ('dbx_business_glossary_term' = 'Training Requirements');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Number');
ALTER TABLE `construction_ecm`.`quality`.`plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
