-- Schema for Domain: research | Business: Genomics Biotech | Version: v1_ecm
-- Generated on: 2026-05-06 13:04:45

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `genomics_biotech_ecm`.`research` COMMENT 'Manages R&D project portfolios, experimental designs, molecular biology protocols, gene-editing (CRISPR) development programs, custom assay development, and IP-generating discoveries. Integrates Benchling for electronic lab notebook (ELN) records and molecular design. Tracks R&D spend, milestone achievement, collaboration agreements, IRB approvals, publications, and technology readiness levels.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`project` (
    `project_id` BIGINT COMMENT 'Primary key for project',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Projects track which regulatory approvals enable commercialization (FDA clearance, CE mark). Essential for product lifecycle management and commercial readiness reporting in genomics.',
    `capex_request_id` BIGINT COMMENT 'Foreign key linking to finance.capex_request. Business justification: R&D projects requiring capital investment must link to capex requests for approval workflow, budget authorization, and NPV/ROI tracking. Standard practice for biotech capital planning.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: R&D projects frequently serve specific customer accounts for collaborative research, custom assay development, or evaluation programs. Critical for project planning, resource allocation, IP ownership ',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: R&D projects must specify reference genome (GRCh38, T2T-CHM13) for sequencing pipelines, variant calling, regulatory submissions, and data reproducibility. Essential for genomics operations and FDA/EM',
    `metadata_schema_id` BIGINT COMMENT 'Foreign key linking to data.metadata_schema. Business justification: R&D projects must comply with metadata standards (FAIR, NIH DMSP) for regulatory submissions and data sharing. Projects track which schema governs their data outputs for compliance reporting and inter',
    `employee_id` BIGINT COMMENT 'Reference to the employee record of the Project Manager responsible for schedule, budget, and milestone tracking for the R&D project. Distinct from the Principal Investigator who holds scientific accountability.',
    `project_principal_investigator_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: R&D projects generate regulatory submissions for product approval (IND, BLA, 510(k), PMA). Tracks which submission a project supports - core commercialization pathway in genomics biotech.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: R&D projects frequently contract with specialized suppliers (oligo synthesis, sequencing services, CRISPR reagents) for outsourced work. Tracking primary supplier enables vendor management, IP agreeme',
    `actual_end_date` DATE COMMENT 'Actual date on which the R&D project was completed or closed. Null if the project is still active. Used for schedule performance analysis and lessons-learned reporting.',
    `actual_spend_usd` DECIMAL(18,2) COMMENT 'Cumulative actual expenditure incurred against the R&D project budget to date, in US Dollars, sourced from SAP CO actual cost postings. Used for budget variance analysis, R&D COGS tracking, and financial reporting.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the R&D project received formal gate approval to proceed, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX. Null if the project has not yet been formally approved. Used for governance audit trails and cycle time analysis.',
    `benchling_project_reference` STRING COMMENT 'External identifier linking this R&D project to its corresponding project workspace in Benchling, the electronic lab notebook (ELN) and molecular biology platform. Enables cross-system navigation to experimental protocols, sequences, and notebook entries.',
    `budget_amount_usd` DECIMAL(18,2) COMMENT 'Total approved budget allocated to the R&D project in US Dollars, as recorded in SAP CO internal order or WBS element. Represents the authorized spend ceiling for the project lifecycle. Used for R&D spend tracking and EBITDA impact analysis.',
    `collaboration_type` STRING COMMENT 'Nature of the collaboration model for the R&D project: internal (Genomics Biotech only), academic (university partnership), industry (pharma/biotech partner), government (NIH/DARPA funded), or consortium (multi-party). Drives contract and IP agreement requirements.. Valid values are `internal|academic|industry|government|consortium`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the R&D project record was first created in the system, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail, data lineage, and compliance reporting.',
    `data_sharing_required` BOOLEAN COMMENT 'Indicates whether this R&D project is subject to the NIH Genomic Data Sharing (GDS) Policy or other mandatory data sharing requirements (e.g., GDPR data sharing agreements, EMA data transparency). When true, a data management and sharing plan must be filed.',
    `grant_number` STRING COMMENT 'External funding grant number (e.g., NIH R01, SBIR/STTR, EU Horizon grant) associated with this R&D project. Used for grant compliance reporting, indirect cost recovery, and financial audit trails. Null for internally funded projects.',
    `gxp_applicable` BOOLEAN COMMENT 'Indicates whether Good Practice Regulations (GxP) — including GMP, GLP, or GCP — apply to this R&D project. When true, the project must comply with applicable GxP documentation, validation, and audit trail requirements.',
    `intended_use` STRING COMMENT 'Regulatory intended use classification for the project output: Research Use Only (RUO), In Vitro Diagnostic (IVD), Laboratory Developed Test (LDT), CE-IVD (EU conformity), or research_only. Determines applicable regulatory framework and submission pathway.. Valid values are `RUO|IVD|LDT|CE-IVD|research_only`',
    `ip_classification` STRING COMMENT 'Classification of the intellectual property (IP) status and ownership model for discoveries and innovations generated by this R&D project. Drives IP protection strategy, licensing decisions, and freedom-to-operate assessments.. Valid values are `proprietary|licensed_in|licensed_out|open_source|trade_secret|patent_pending`',
    `irb_approval_number` STRING COMMENT 'Institutional Review Board (IRB) protocol approval number for R&D projects involving human subjects research, clinical samples, or protected health information (PHI). Required for HIPAA compliance and NIH Genomic Data Sharing Policy adherence. Null for non-human-subjects projects.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the R&D project record, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for change tracking, audit trail compliance, and incremental data pipeline processing.',
    `milestone_count` STRING COMMENT 'Total number of defined project milestones registered for this R&D project in the project management system. Used for portfolio progress tracking and gate review scheduling. Not a calculated metric — represents the registered count at the time of record update.',
    `milestones_achieved_count` STRING COMMENT 'Number of project milestones that have been formally completed and signed off as of the last record update. Used alongside milestone_count for portfolio progress reporting and earned value analysis.',
    `patent_application_number` STRING COMMENT 'Official patent application number filed with the USPTO or EPO for inventions arising from this R&D project. Null if no patent has been filed. Used for IP portfolio tracking and freedom-to-operate analysis.',
    `phase` STRING COMMENT 'Current stage in the R&D project lifecycle from ideation through commercialization. Used for portfolio gate reviews, resource allocation, and regulatory readiness tracking. [ENUM-REF-CANDIDATE: ideation|preclinical|pilot|scale-up|clinical|commercialization|sunset — promote to reference product]',
    `phi_involved` BOOLEAN COMMENT 'Indicates whether this R&D project involves the use, processing, or storage of Protected Health Information (PHI) as defined under HIPAA. When true, the project must comply with HIPAA Privacy and Security Rules and applicable data use agreements.',
    `planned_end_date` DATE COMMENT 'Originally planned completion date for the R&D project as established at project initiation or last approved baseline. Used for schedule variance analysis and portfolio planning.',
    `primary_success_metric` STRING COMMENT 'The principal quantitative or qualitative Key Performance Indicator (KPI) used to determine project success (e.g., LOD ≤ 1% VAF, sensitivity ≥ 99%, on-target editing efficiency ≥ 80%). Defined at project initiation and used for go/no-go gate decisions.',
    `project_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the R&D project, used across Benchling ELN, SAP CO cost objects, and internal communications (e.g., CRISPR-20240001, ASSAY-20230042). Serves as the cross-system reference key.. Valid values are `^[A-Z]{2,6}-[0-9]{4,8}$`',
    `project_description` STRING COMMENT 'Free-text narrative description of the R&D project objectives, scientific rationale, and expected outcomes. Provides context for portfolio reviews, regulatory submissions, and cross-functional stakeholder communication.',
    `project_status` STRING COMMENT 'Current lifecycle status of the R&D project record: active (in progress), on_hold (paused), completed (objectives met), cancelled (terminated), or pending_approval (awaiting gate sign-off). Drives portfolio dashboards and resource planning.. Valid values are `active|on_hold|completed|cancelled|pending_approval`',
    `project_type` STRING COMMENT 'Classification of the R&D project by its scientific and business purpose: discovery (early-stage hypothesis), development (product/tool build), validation (clinical or analytical validation), feasibility (proof-of-concept), or translational (bench-to-clinic). Drives workflow routing and milestone templates.. Valid values are `discovery|development|validation|feasibility|translational`',
    `publication_count` STRING COMMENT 'Number of peer-reviewed scientific publications, conference abstracts, or preprints that have been generated from this R&D project. Used for scientific impact tracking, IP disclosure management, and NIH reporting compliance.',
    `regulatory_pathway` STRING COMMENT 'Planned regulatory submission pathway for the project output: 510(k) premarket notification, PMA (Premarket Approval), De Novo classification, CE-IVD (EU conformity), Emergency Use Authorization (EUA), or none for non-regulated outputs. Determines submission strategy and timeline.. Valid values are `510k|PMA|De_Novo|CE-IVD|EUA|none`',
    `regulatory_submission_required` BOOLEAN COMMENT 'Indicates whether this R&D project is expected to result in a regulatory submission to the FDA, EMA, or other governing body (e.g., 510(k), PMA, CE-IVD technical file). Drives regulatory affairs resource planning and submission timeline tracking.',
    `sap_wbs_element` STRING COMMENT 'SAP Work Breakdown Structure (WBS) element code that maps this R&D project to the SAP S/4HANA project system for cost collection, budget control, and financial reporting. Enables drill-through from analytics to source ERP records.',
    `sponsoring_business_unit` STRING COMMENT 'Name of the internal business unit or division that is the primary sponsor and budget owner for the R&D project (e.g., Clinical Genomics, Sequencing R&D, Agricultural Genomics, Instrument Engineering). Maps to SAP CO cost center hierarchy.',
    `start_date` DATE COMMENT 'Planned or actual start date of the R&D project, formatted as yyyy-MM-dd. Used for timeline planning, milestone scheduling, and portfolio Gantt reporting.',
    `strategic_priority` STRING COMMENT 'Business-assigned strategic priority level of the R&D project relative to the corporate portfolio. Drives resource allocation decisions, executive review cadence, and budget protection during planning cycles.. Valid values are `critical|high|medium|low`',
    `target_indication` STRING COMMENT 'The clinical indication, disease area, or application domain that the project is designed to address (e.g., oncology, rare disease, agricultural genomics, infectious disease diagnostics, pharmacogenomics). Informs market segmentation and regulatory pathway selection.',
    `target_product_profile` STRING COMMENT 'Free-text or structured description of the Target Product Profile (TPP) defining the desired performance characteristics, intended use, and clinical/analytical claims for the product or technology being developed. Guides experimental design and success criteria.',
    `technology_area` STRING COMMENT 'Primary genomics technology domain addressed by the project: Next-Generation Sequencing (NGS), array-based genotyping, CRISPR gene-editing, PCR/qPCR, bioinformatics pipeline, reagent/consumable, instrument engineering, or other. Aligns with Genomics Biotech core business processes. [ENUM-REF-CANDIDATE: NGS|array|CRISPR|PCR|bioinformatics|reagent|instrument|other — 8 candidates stripped; promote to reference product]',
    `title` STRING COMMENT 'Full descriptive title of the R&D project as registered in the Benchling electronic lab notebook (ELN) and SAP project system. Used in reporting, publications, and regulatory submissions.',
    `trl` STRING COMMENT 'Technology Readiness Level (TRL) score on the 1–9 scale indicating the maturity of the technology being developed. TRL 1 = basic principles observed; TRL 9 = proven in operational environment. Used for portfolio prioritization and commercialization readiness assessment.',
    `veeva_document_reference` STRING COMMENT 'Reference identifier linking this R&D project to its primary regulatory or quality document package in Veeva Vault (e.g., design history file, validation protocol, regulatory submission dossier). Enables cross-system navigation to controlled documents.',
    CONSTRAINT pk_project PRIMARY KEY(`project_id`)
) COMMENT 'Master record for R&D projects and programs within the research domain — covering CRISPR gene-editing development programs, custom assay development initiatives, novel sequencing chemistry research, and platform innovation projects. Tracks project title, type (discovery, development, validation), technology readiness level (TRL), strategic priority, target indication or application area, project phase, start/end dates, budget allocation, principal investigator, sponsoring business unit, IP classification, and current status. Serves as the authoritative SSOT for all R&D project identity and lifecycle management.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`milestone` (
    `milestone_id` BIGINT COMMENT 'Primary key for milestone',
    `capa_id` BIGINT COMMENT 'Foreign key linking to quality.capa. Business justification: R&D milestones trigger CAPAs when go/no-go decisions identify systemic issues, process gaps, or quality risks requiring corrective action. Essential for linking quality improvements to stage-gate deci',
    `employee_id` BIGINT COMMENT 'Reference to the employee or principal investigator in Oracle Cloud HCM who is formally accountable for achieving this milestone. Used for RACI assignment, performance tracking, and escalation routing.',
    `rd_capitalization_id` BIGINT COMMENT 'Foreign key linking to finance.rd_capitalization. Business justification: Milestone achievements (technical feasibility, regulatory approval) trigger capitalization decisions per ASC 730/IAS 38. Essential for intangible asset recognition and financial statement accuracy in ',
    `project_id` BIGINT COMMENT 'Reference to the parent R&D project to which this milestone belongs. Links the milestone to its governing project portfolio record.',
    `review_board_id` BIGINT COMMENT 'Reference to the scientific or stage-gate review board responsible for evaluating and approving the milestone outcome. Applicable to decision_gate and trl_assessment milestone types.',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Milestones trigger or depend on regulatory submissions (IND filing, BLA submission, 510(k) clearance). Stage-gate process requires linking development milestones to regulatory events.',
    `document_id` BIGINT COMMENT 'Document control number from Veeva Vault associated with the formal milestone deliverable or regulatory submission package. Enables cross-system traceability between the milestone record and the controlled document management system.',
    `actual_completion_date` DATE COMMENT 'Date on which the milestone was formally completed and outcome recorded. Null if the milestone has not yet been completed. Used to calculate schedule variance (actual vs. planned) for R&D performance reporting.',
    `advancement_criteria` STRING COMMENT 'Predefined criteria that must be met to advance to the next TRL level or stage gate. Captures the forward-looking requirements established at the time of assessment (e.g., Demonstrate analytical sensitivity in clinical matrix to advance from TRL 4 to TRL 5). Applicable primarily to trl_assessment and decision_gate milestone types.',
    `assessment_rationale` STRING COMMENT 'Narrative explanation of the outcome determination, including scientific justification, data interpretation, and any deviations from the original success criteria. Required for TRL assessments and go/no-go decision gates. Stored as free text aligned with Benchling ELN entries.',
    `associated_deliverable` STRING COMMENT 'Name or description of the primary tangible deliverable produced at this milestone (e.g., IND Module 2 Toxicology Summary Report, CRISPR Off-Target Analysis Dataset, Assay Validation Protocol v1.0). Links the milestone to its output artifact for portfolio tracking.',
    `benchling_entry_reference` STRING COMMENT 'Identifier of the corresponding Benchling ELN notebook entry or experiment record that documents the scientific work underpinning this milestone. Enables direct traceability from the milestone record to the source ELN data in Benchling.',
    `budget_allocated` DECIMAL(18,2) COMMENT 'Planned budget (in spend_currency_code) allocated to achieve this milestone as defined in the R&D project financial plan. Used for budget vs. actual variance analysis and R&D portfolio financial management.',
    `comments` STRING COMMENT 'Free-text field for additional context, exceptions, risk notes, or stakeholder communications related to the milestone. Captures information not covered by structured fields, such as interim findings, resource constraints, or scientific observations noted during review.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the milestone record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail requirements under 21 CFR Part 11 and GxP electronic records compliance.',
    `data_classification` STRING COMMENT 'Data sensitivity classification of the milestone record per Genomics Biotech data governance policy: restricted (contains PHI/PII or highly sensitive IP), confidential (sensitive business data), internal (general internal use), public (shareable externally). Drives access control and data handling requirements.. Valid values are `restricted|confidential|internal|public`',
    `decision_rationale` STRING COMMENT 'Narrative justification for the go/no-go decision recorded at a decision_gate milestone. Documents the scientific, commercial, and regulatory factors considered by the review board. Required for GxP-compliant stage-gate documentation.',
    `evidence_artifact_reference` STRING COMMENT 'Reference identifier or URL pointing to the supporting evidence artifacts stored in Benchling ELN, Veeva Vault, or MasterControl (e.g., experiment IDs, document control numbers, study report references). Enables traceability from milestone outcome to underlying scientific data.',
    `go_no_go_decision` STRING COMMENT 'Formal decision recorded at a decision_gate milestone: go (proceed to next phase), no_go (terminate or pivot program), conditional_go (proceed with defined conditions), or hold (decision deferred pending additional data). Null for non-decision-gate milestone types.. Valid values are `go|no_go|conditional_go|hold`',
    `irb_approval_number` STRING COMMENT 'IRB protocol approval number associated with this milestone when the underlying research involves human subjects or clinical samples. Required for CLIA/CAP-compliant clinical genomics milestones and NIH Genomic Data Sharing Policy compliance.',
    `is_gxp_relevant` BOOLEAN COMMENT 'Indicates whether this milestone involves GxP-regulated activities (True) — including GMP, GLP, or GCP — requiring formal documentation, audit trails, and quality system controls per applicable regulations. Drives quality oversight and Veeva Vault document control requirements.',
    `is_ip_generating` BOOLEAN COMMENT 'Indicates whether achievement of this milestone is expected to generate patentable intellectual property or trade secrets (True) or not (False). Triggers IP disclosure workflows and patent filing timelines in the R&D IP management process.',
    `is_regulatory_critical` BOOLEAN COMMENT 'Indicates whether this milestone lies on the critical regulatory submission path (True), meaning its delay would directly impact an FDA, EMA, or IVDR submission timeline. Used for regulatory affairs prioritization and risk management.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the milestone record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Required for GxP audit trail compliance and change tracking under 21 CFR Part 11.',
    `milestone_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the milestone within the R&D portfolio management system (e.g., Benchling or SAP PS). Used in project plans, stage-gate reports, and regulatory submissions.. Valid values are `^MS-[A-Z0-9]{4,12}$`',
    `milestone_name` STRING COMMENT 'Human-readable name of the milestone (e.g., IND-Enabling Toxicology Study Completion, Proof-of-Concept CRISPR Readout, TRL-4 Assessment). Used in portfolio dashboards and stage-gate presentations.',
    `milestone_status` STRING COMMENT 'Current workflow state of the milestone: planned (scheduled but not started), in_progress (active work underway), met (successfully completed against success criteria), missed (not completed by planned date), deferred (rescheduled to a future date), or cancelled (removed from scope).. Valid values are `planned|in_progress|met|missed|deferred|cancelled`',
    `milestone_type` STRING COMMENT 'Categorical classification of the milestone: decision_gate (go/no-go stage gate), deliverable (tangible output such as a report or prototype), trl_assessment (Technology Readiness Level evaluation), or regulatory_checkpoint (pre-submission meeting, IND filing, FDA/EMA interaction).. Valid values are `decision_gate|deliverable|trl_assessment|regulatory_checkpoint`',
    `next_review_date` DATE COMMENT 'Date of the next scheduled review or reassessment for milestones with status of in_progress, deferred, or conditional_go. Supports proactive portfolio monitoring and escalation scheduling.',
    `outcome` STRING COMMENT 'Formal recorded outcome of the milestone at its evaluation point: met (all success criteria satisfied), missed (criteria not met by deadline), deferred (evaluation postponed), partial (criteria partially met with documented exceptions), or cancelled (milestone removed from plan).. Valid values are `met|missed|deferred|partial|cancelled`',
    `phase` STRING COMMENT 'R&D program phase during which this milestone occurs: discovery (basic research), lead_optimization (candidate refinement), preclinical (IND-enabling studies), clinical (clinical trial phases), regulatory (submission and approval), or commercialization (product launch readiness). Supports portfolio stage-gating analytics.. Valid values are `discovery|lead_optimization|preclinical|clinical|regulatory|commercialization`',
    `planned_date` DATE COMMENT 'Originally scheduled date by which the milestone was expected to be achieved, as defined in the R&D project plan. Used for schedule variance analysis and portfolio stage-gate tracking.',
    `prior_trl_score` STRING COMMENT 'TRL score recorded at the immediately preceding TRL assessment milestone for the same project. Enables calculation of TRL advancement delta and tracking of technology maturation velocity across the R&D portfolio.',
    `priority` STRING COMMENT 'Business priority classification of the milestone within the R&D portfolio: critical (program-blocking, must not slip), high (significant impact if delayed), medium (important but manageable), low (nice-to-have or supporting). Used for resource allocation and escalation decisions.. Valid values are `critical|high|medium|low`',
    `rd_spend_recognized` DECIMAL(18,2) COMMENT 'Cumulative R&D expenditure (in USD) formally recognized upon achievement of this milestone for financial reporting purposes. Supports milestone-based R&D spend recognition per ASC 730 (R&D accounting) and SOX-compliant financial controls. Null if milestone has not been met.',
    `regulatory_agency` STRING COMMENT 'Regulatory authority associated with a regulatory_checkpoint milestone (e.g., FDA = U.S. Food and Drug Administration, EMA = European Medicines Agency, PMDA = Japan Pharmaceuticals and Medical Devices Agency). Null for non-regulatory milestone types. [ENUM-REF-CANDIDATE: FDA|EMA|PMDA|Health_Canada|TGA|ANVISA|other — 7 candidates stripped; promote to reference product]',
    `regulatory_submission_type` STRING COMMENT 'Type of regulatory submission or interaction associated with a regulatory_checkpoint milestone (e.g., IND = Investigational New Drug application, PMA = Premarket Approval, 510k = 510(k) clearance, CE_IVD = CE-IVD marking, IVDR = EU IVDR submission, pre_sub = FDA Pre-Submission meeting). Null for non-regulatory milestone types. [ENUM-REF-CANDIDATE: IND|PMA|510k|De_Novo|EUA|CE_IVD|IVDR|pre_sub|none — promote to reference product]',
    `review_date` DATE COMMENT 'Date on which the formal milestone review meeting or assessment was conducted by the review board or stage-gate committee. Distinct from actual_completion_date, which records when the work was completed. Used for governance audit trails.',
    `revised_target_date` DATE COMMENT 'Updated target completion date when the original planned date has been formally revised due to scope changes, resource constraints, or scientific findings. Null if no revision has occurred. Supports deferred milestone tracking.',
    `sap_wbs_element` STRING COMMENT 'SAP S/4HANA Work Breakdown Structure element code associated with this milestone for R&D cost tracking and financial recognition. Enables integration between the milestone record and SAP CO/PS project accounting.',
    `schedule_variance_days` STRING COMMENT 'Calculated difference in calendar days between actual_completion_date and planned_date (positive = late, negative = early). Populated upon milestone completion. Used for R&D portfolio schedule performance reporting and KPI dashboards. Note: derived field retained as a persisted business metric for reporting efficiency.',
    `spend_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the rd_spend_recognized amount (e.g., USD, EUR, GBP). Supports multi-currency R&D portfolio financial reporting.. Valid values are `^[A-Z]{3}$`',
    `success_criteria` STRING COMMENT 'Predefined, measurable criteria that must be satisfied for the milestone to be declared met. Examples: LOD ≤ 0.1% VAF confirmed in triplicate, TRL score ≥ 4 validated by independent review board, IND submission package approved by regulatory affairs. Captured from Benchling ELN or project charter.',
    `trl_score` STRING COMMENT 'Numeric Technology Readiness Level score on the 1–9 scale assigned at the time of a trl_assessment milestone. TRL 1 = basic principles observed; TRL 9 = system proven in operational environment. Null for non-TRL milestone types. Enables portfolio stage-gating from basic research through product development readiness.',
    CONSTRAINT pk_milestone PRIMARY KEY(`milestone_id`)
) COMMENT 'Tracks discrete, measurable milestones and formal technology readiness assessments within R&D projects — including go/no-go decision gates, IND-enabling study completions, proof-of-concept readouts, TRL advancement evaluations (TRL 1-9 scale), and regulatory pre-submission milestones. Captures milestone name, type (decision_gate, deliverable, trl_assessment, regulatory_checkpoint), planned date, actual completion date, success criteria, outcome (met/missed/deferred), TRL score (for TRL-type milestones), assessment rationale, evidence artifacts, advancement criteria for next level, accountable owner, and associated deliverable. Enables milestone-based R&D spend recognition, portfolio stage-gating from basic research through product development readiness, and structured progress reporting.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`experiment` (
    `experiment_id` BIGINT COMMENT 'Unique surrogate identifier for each experiment record in the Genomics Biotech research data platform. Primary key for the experiment entity.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_asset. Business justification: Experiments are performed on specific instruments. Essential for data provenance, instrument utilization analysis, qualification status verification, and correlating experiment outcomes with instrumen',
    `crispr_construct_id` BIGINT COMMENT 'Foreign key linking to research.crispr_construct. Business justification: CRISPR gene-editing experiments use specific constructs from the construct registry. Currently experiment has crispr_guide_rna_sequence (STRING) and target_gene_symbol (STRING) but no FK to crispr_con',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Experiments often use customer-provided samples or validate customer-specific protocols. Essential for sample traceability, regulatory compliance (CLIA/CAP/GxP), data ownership determination, and cons',
    `deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: Experiments trigger quality deviations when protocol violations, OOS results, or GxP non-compliance occurs. Required for linking deviation investigations back to originating experimental work and ensu',
    `employee_id` BIGINT COMMENT 'Reference to the primary scientist or researcher responsible for executing and owning this experiment. Used for workload tracking, accountability, and IP attribution.',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Every genomics experiment requires reference genome for read alignment, variant calling, and result interpretation. Core operational dependency for NGS, array, and CRISPR experiments. Ensures reproduc',
    `batch_id` BIGINT COMMENT 'The batch or worklist identifier from LabVantage LIMS linking this experiment to the set of samples processed. Enables bidirectional traceability between the ELN experiment record and the LIMS sample tracking workflow.',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Experiments consume specific materials (reagent kits, enzymes, consumables). Material traceability is GxP-critical for protocol compliance, batch tracking in regulatory submissions, and root-cause ana',
    `project_id` BIGINT COMMENT 'Reference to the parent R&D project under which this experiment is conducted. Links the experiment to its governing project portfolio record for milestone tracking and R&D spend allocation.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Experiments consume specific reagent SKUs (kits, consumables, controls). Lab managers track SKU usage for cost accounting, inventory planning, protocol optimization, and reagent performance evaluation',
    `research_protocol_id` BIGINT COMMENT 'Reference to the approved laboratory protocol or Standard Operating Procedure (SOP) that governs the experimental procedure. Ensures traceability to controlled documents required for GxP compliance.',
    `sample_specimen_id` BIGINT COMMENT 'Foreign key linking to sample.sample_specimen. Business justification: Experiments consume specific specimens as input material. Direct specimen link enables material tracking for experimental reproducibility, chain of custody documentation, consent verification for spec',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Experiments generate analytical/clinical data packages for regulatory submissions. Traceability from raw data to submission is required for GxP compliance and regulatory inspections.',
    `document_id` BIGINT COMMENT 'The document identifier in Veeva Vault for any associated regulatory submission document, quality record, or controlled document linked to this experiment. Supports regulatory traceability for IVD/CE-IVD submissions and GxP quality management.',
    `actual_cost_usd` DECIMAL(18,2) COMMENT 'The actual total cost in US Dollars (USD) incurred to execute this experiment, as recorded in SAP. Compared against estimated_cost_usd for budget variance analysis and R&D spend efficiency reporting.',
    `actual_end_date` DATE COMMENT 'The actual date on which the experiment was completed or terminated. Used to calculate actual Turnaround Time (TAT) and compare against planned duration for R&D efficiency analytics.',
    `actual_start_date` DATE COMMENT 'The actual date on which the experiment commenced. Compared against planned_start_date to measure schedule adherence and identify delays in R&D execution.',
    `benchling_eln_entry_reference` STRING COMMENT 'The unique identifier of the corresponding Electronic Lab Notebook (ELN) entry in Benchling. Provides direct traceability from the data product to the authoritative scientific record in the system of record for R&D documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the experiment record was first created in the data platform, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides the audit trail creation anchor required for GxP data integrity and 21 CFR Part 11 compliance.',
    `crispr_guide_rna_sequence` STRING COMMENT 'The nucleotide sequence of the guide RNA (gRNA) used in CRISPR gene-editing experiments. Captured for IP prosecution, reproducibility, and molecular design traceability. Applicable only to CRISPR experiment types; null for non-CRISPR experiments. Classified as confidential due to IP sensitivity.. Valid values are `^[ACGTUacgtu]{15,25}$`',
    `data_integrity_signature` STRING COMMENT 'Cryptographic hash or electronic signature value applied to the experiment record at the time of ELN entry finalization. Ensures data integrity and non-repudiation of the scientific record as required by 21 CFR Part 11 and GxP data integrity guidelines.',
    `design_type` STRING COMMENT 'The statistical or methodological design framework applied to the experiment (e.g., controlled, factorial, dose-response, observational, screening, comparative). Informs data analysis approach and statistical power assessment.. Valid values are `controlled|factorial|dose_response|observational|screening|comparative`',
    `eln_entry_type` STRING COMMENT 'Categorizes the nature of the ELN entry associated with this experiment record (observation, result, protocol execution, data analysis). Drives downstream data routing and review workflows in Benchling.. Valid values are `observation|result|protocol_execution|data_analysis`',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'The estimated total cost in US Dollars (USD) to execute this experiment, including reagents, consumables, instrument time, and FTE labor. Used for R&D budget planning, ROI analysis, and project financial forecasting.',
    `experiment_code` STRING COMMENT 'Human-readable, externally-known alphanumeric code uniquely identifying the experiment within the organization (e.g., EXP-CRISPR0042). Used in lab notebooks, reports, IP filings, and cross-system references.. Valid values are `^EXP-[A-Z0-9]{4,12}$`',
    `experiment_status` STRING COMMENT 'Current workflow state of the experiment in its lifecycle (planned, in-progress, completed, failed, cancelled, on-hold). Drives operational dashboards, resource planning, and milestone reporting.. Valid values are `planned|in_progress|completed|failed|cancelled|on_hold`',
    `experiment_type` STRING COMMENT 'Classification of the experiment by scientific domain or workflow category (e.g., CRISPR editing efficiency assay, library preparation optimization, sequencing chemistry validation, reagent formulation trial, custom assay development, dose-response). [ENUM-REF-CANDIDATE: crispr_editing|library_prep_optimization|sequencing_chemistry_validation|reagent_formulation|assay_development|dose_response|other — promote to reference product]',
    `failure_reason` STRING COMMENT 'Free-text description of the root cause when an experiment has a status of failed. Captures technical, procedural, or material failure modes for CAPA (Corrective and Preventive Action) analysis and experimental design improvement.',
    `gxp_applicable` BOOLEAN COMMENT 'Indicates whether this experiment is conducted under GxP (Good Laboratory Practice, Good Manufacturing Practice, or Good Clinical Practice) regulatory requirements. Determines the level of documentation, audit trail, and data integrity controls required.',
    `hypothesis` STRING COMMENT 'The scientific hypothesis or research question that the experiment is designed to test. Captured as free text from the ELN entry. Critical for IP prosecution documentation and scientific reproducibility.',
    `ip_disclosure_filed` BOOLEAN COMMENT 'Indicates whether an Intellectual Property (IP) invention disclosure has been filed based on the findings of this experiment. Triggers IP prosecution workflows and ensures novel discoveries are protected prior to publication.',
    `irb_approval_number` STRING COMMENT 'The approval number issued by the Institutional Review Board (IRB) authorizing experiments involving human subjects or human-derived biological materials. Required for clinical genomics and translational research compliance.',
    `lab_location_code` BIGINT COMMENT 'Reference to the physical laboratory facility or room where the experiment is conducted. Supports environmental monitoring, equipment qualification traceability, and site-level compliance reporting.',
    `organism` STRING COMMENT 'The biological organism or model system used in the experiment (e.g., Homo sapiens, Mus musculus, E. coli, cell line HEK293T, in vitro). Required for regulatory submissions, biosafety classification, and cross-species genomics analytics.',
    `outcome_summary` STRING COMMENT 'Free-text narrative summarizing the scientific outcome, key findings, and conclusions of the experiment. Captured from the ELN entry and used for IP documentation, publication preparation, and knowledge management.',
    `planned_end_date` DATE COMMENT 'The scheduled completion date for the experiment. Used for project milestone planning, resource allocation, and Turnaround Time (TAT) target setting.',
    `planned_start_date` DATE COMMENT 'The scheduled start date for the experiment as defined in the project plan. Used for resource scheduling, milestone tracking, and R&D timeline reporting.',
    `primary_result_metric` STRING COMMENT 'The name of the principal quantitative or qualitative metric used to evaluate the experiment outcome (e.g., CRISPR editing efficiency percentage, Phred Score threshold, library yield ng/uL, LOD value). Enables structured result comparison across experiments.',
    `primary_result_unit` STRING COMMENT 'The unit of measure for the primary result value (e.g., percent, ng/uL, copies/mL, Phred score, fold-change). Ensures dimensional correctness in analytics and cross-experiment comparisons.',
    `primary_result_value` DECIMAL(18,2) COMMENT 'The numeric value of the primary result metric for this experiment (e.g., 87.5 for 87.5% editing efficiency, 35.2 for Phred Score). Paired with primary_result_unit for dimensional analysis and cross-experiment benchmarking.',
    `publication_reference` STRING COMMENT 'Digital Object Identifier (DOI) or PubMed ID of the peer-reviewed publication in which the results of this experiment were published. Supports scientific impact tracking, IP citation management, and NIH Genomic Data Sharing compliance.',
    `r_and_d_cost_center` STRING COMMENT 'The SAP cost center code to which R&D expenditure for this experiment is charged. Enables R&D spend tracking, budget vs. actual analysis, and EBITDA reporting at the project and portfolio level.',
    `replicate_count` STRING COMMENT 'The number of technical or biological replicates included in the experimental design. Distinct from sample_count; captures the replication strategy for statistical validity assessment and reproducibility documentation.',
    `review_status` STRING COMMENT 'Scientific review and approval state of the experiment record (unreviewed, peer-reviewed, supervisor-approved, rejected). Required for GxP data integrity compliance and IP prosecution readiness.. Valid values are `unreviewed|peer_reviewed|supervisor_approved|rejected`',
    `sample_count` STRING COMMENT 'The total number of biological samples or replicates processed in this experiment. Used for statistical power assessment, reagent consumption planning, and LIMS sample tracking reconciliation.',
    `target_gene_symbol` STRING COMMENT 'The HGNC-approved gene symbol for the primary gene targeted or studied in this experiment (e.g., BRCA1, TP53, EGFR). Links the experiment to reference genomics data and enables gene-centric analytics across the research portfolio.. Valid values are `^[A-Z][A-Z0-9]{1,15}$`',
    `technology_readiness_level` STRING COMMENT 'Numeric scale (1–9) indicating the maturity of the technology or discovery generated by this experiment, per NASA/DoD TRL framework adapted for genomics product development. Used for R&D portfolio stage-gate decisions and commercialization planning.',
    `title` STRING COMMENT 'Descriptive title of the experiment as recorded in the Electronic Lab Notebook (ELN). Provides a concise human-readable label for search, reporting, and scientific communication.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent modification to the experiment record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Required for change tracking, data lineage, and GxP audit trail completeness.',
    CONSTRAINT pk_experiment PRIMARY KEY(`experiment_id`)
) COMMENT 'Core entity representing individual scientific experiments and their associated electronic lab notebook (ELN) records — including CRISPR editing efficiency assays, library preparation optimization runs, sequencing chemistry validation experiments, and reagent formulation trials. Captures experiment title, hypothesis, experimental design type (controlled, factorial, dose-response), associated protocol reference, Benchling ELN entry ID, assigned scientist, lab location, start/end dates, status (planned, in-progress, completed, failed), outcome summary, ELN entry type (observation, result, protocol execution, data analysis), review status (unreviewed, peer-reviewed, supervisor-approved), and data integrity signature. Serves as the unified scientific record integrating experimental design with auditable notebook documentation required for IP prosecution and GxP compliance.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`research_protocol` (
    `research_protocol_id` BIGINT COMMENT 'Unique surrogate identifier for each protocol record in the master protocol catalog. Primary key for the research.protocol data product.',
    `controlled_document_id` BIGINT COMMENT 'Foreign key linking to quality.controlled_document. Business justification: Research protocols are controlled documents requiring version control, approval workflows, training records, and change control. Fundamental GxP requirement for maintaining protocol integrity and regu',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Custom protocols developed for specific customer applications (clinical validation workflows, custom panels, customer-specific QC thresholds). Required for protocol versioning in customer-specific wor',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Protocols specify required materials by catalog number (e.g., Illumina TruSeq DNA PCR-Free Library Prep Kit). This link enables automated BOM generation, procurement triggering when protocols are sc',
    `metadata_schema_id` BIGINT COMMENT 'Foreign key linking to data.metadata_schema. Business justification: Protocols define data collection methods and must specify metadata schema compliance for regulatory validation (FDA, CLIA) and data interoperability. Essential for assay validation and regulatory subm',
    `quality_training_curriculum_id` BIGINT COMMENT 'Identifier of the associated training curriculum or course in MasterControl that personnel must complete to be qualified to execute this protocol. Populated when training_required is True.',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Validated protocols submitted as analytical methods in regulatory dossiers (IVD submissions, BLA CMC sections). Method validation is core regulatory requirement for genomics assays.',
    `applicable_instruments` STRING COMMENT 'Comma-separated list of instrument platforms or models for which this protocol is validated and applicable (e.g., NovaSeq 6000, NextSeq 2000, MiSeq). Critical for ensuring protocol-instrument compatibility in sequencing and assay workflows.',
    `applicable_sample_types` STRING COMMENT 'Comma-separated list of biological sample types for which this protocol is validated (e.g., FFPE tissue, whole blood, saliva, cell line, cfDNA). Ensures protocol is applied only to compatible sample matrices.',
    `approval_date` DATE COMMENT 'Date on which the protocol received final formal approval from the designated approver(s). Distinct from the effective date; a protocol may be approved before it becomes effective. Required for regulatory audit trails.',
    `approval_status` STRING COMMENT 'Current lifecycle state of the protocol within the document control workflow. draft = under authorship; in_review = submitted for peer/QA review; approved = formally approved for use; superseded = replaced by a newer version; retired = withdrawn from use; on_hold = temporarily suspended pending investigation.. Valid values are `draft|in_review|approved|superseded|retired|on_hold`',
    `approved_by` STRING COMMENT 'Name or employee identifier of the authorized signatory who granted final approval for the protocol. Typically a department head, QA manager, or designated authority. Required for regulatory compliance and audit.',
    `assay_type` STRING COMMENT 'Specific assay or experimental type that the protocol describes (e.g., WGS Library Preparation, WES Capture, SNP Genotyping, CNV Detection, gRNA Efficacy Assay, Cell Viability Assay). Provides finer-grained classification below protocol_category. [ENUM-REF-CANDIDATE: wgs_library_prep|wes_capture|snp_genotyping|cnv_detection|grna_efficacy|cell_viability|variant_calling|methylation|rna_seq|chip_seq — promote to reference product]',
    `authored_by` STRING COMMENT 'Name or employee identifier of the primary author who drafted the protocol. Captured as a display name string for audit trail and document control purposes. Supports accountability and traceability per GxP requirements.',
    `benchling_protocol_reference` STRING COMMENT 'External identifier assigned by Benchling (Electronic Lab Notebook / ELN) to the corresponding protocol entry. Enables bidirectional traceability between the lakehouse catalog and the Benchling R&D system of record.',
    `change_summary` STRING COMMENT 'Brief narrative description of the changes made in this version relative to the superseded version. Captured at the time of approval to support change control documentation and regulatory audit trails. Required for GxP change control.',
    `clia_applicable` BOOLEAN COMMENT 'Indicates whether this protocol is subject to CLIA (Clinical Laboratory Improvement Amendments) requirements, applicable when the protocol is used in a clinical laboratory setting for patient testing.',
    `coverage_depth_target` STRING COMMENT 'Target sequencing coverage depth (in X, i.e., fold coverage) specified by this protocol for NGS applications (e.g., 30 for WGS, 100 for WES, 500 for targeted panels). Null for non-sequencing protocols. Used in run planning and QC acceptance criteria.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this protocol record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides the audit trail creation anchor for the record lifecycle.',
    `effective_date` DATE COMMENT 'Date on which the approved protocol becomes effective and authorized for use in laboratory operations. Marks the start of the protocols active lifecycle period. Required for GxP compliance and audit trail.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Estimated total hands-on and elapsed time required to execute the protocol from start to finish, expressed in decimal hours. Used for laboratory scheduling, resource planning, and Turnaround Time (TAT) estimation.',
    `expiry_date` DATE COMMENT 'Date on which the protocol is scheduled to expire and must be reviewed, renewed, or retired. Supports periodic review cycles mandated by GxP and ISO 13485. Null if the protocol has no defined expiry.',
    `external_reference_standard` STRING COMMENT 'Citation or identifier of the external compendial, regulatory, or industry standard that this protocol is based on or aligned with (e.g., CLSI EP17-A2, ISO 20166-1, FDA Guidance for NGS-Based IVDs, ACMG/AMP Variant Classification Guidelines). Supports regulatory submission traceability.',
    `glp_compliant` BOOLEAN COMMENT 'Indicates whether this protocol has been designed and validated to comply with Good Laboratory Practice (GLP) regulations. True = GLP-compliant protocol; False = not GLP-compliant. Relevant for non-clinical safety studies submitted to regulatory agencies.',
    `ip_generating` BOOLEAN COMMENT 'Indicates whether this protocol is associated with or has generated Intellectual Property (IP) such as a patent application, trade secret, or proprietary method. True = IP-generating; False = no IP association. Classified as confidential to protect competitive information.',
    `irb_approval_number` STRING COMMENT 'Official IRB protocol approval number assigned by the reviewing Institutional Review Board. Required when irb_approval_required is True. Used for regulatory submissions and clinical study documentation.',
    `irb_approval_required` BOOLEAN COMMENT 'Indicates whether Institutional Review Board (IRB) approval is required before this protocol can be executed on human-derived samples. True = IRB approval mandatory; False = IRB approval not required (e.g., non-human samples or RUO context).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this protocol record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Updated on every change to support audit trail and data lineage requirements.',
    `lod` STRING COMMENT 'Limit of Detection (LOD) for the assay or method described by this protocol, expressed as a value with units (e.g., 0.1% VAF, 1 ng/µL, 10 copies/mL). Stored as a string to accommodate varied units across protocol types. Key analytical performance characteristic.',
    `mastercontrol_doc_reference` STRING COMMENT 'Document control identifier assigned by MasterControl, the enterprise document control and training management system. Used to cross-reference the approved controlled document record for audit and regulatory inspection purposes.',
    `owning_department` STRING COMMENT 'Name of the organizational department or team responsible for maintaining and updating the protocol (e.g., Molecular Biology R&D, Genomics Assay Development, Quality Assurance). Determines accountability for periodic review.',
    `patent_reference` STRING COMMENT 'Patent application number or granted patent number associated with the method or invention described in this protocol (e.g., US20230123456A1). Populated when ip_generating is True. Classified as confidential.',
    `principal_scientist` STRING COMMENT 'Name or employee identifier of the principal scientist or subject matter expert (SME) who is the scientific owner of the protocol. Responsible for technical accuracy and scientific validity of the procedure.',
    `protocol_category` STRING COMMENT 'Scientific or operational category of the protocol describing the laboratory discipline it covers (e.g., Library Preparation, CRISPR Gene Editing, PCR/qPCR, Cell Transfection, Sequencing Run Setup, Nucleic Acid Extraction, Variant Calling). [ENUM-REF-CANDIDATE: library_preparation|crispr_gene_editing|pcr_qpcr|cell_transfection|sequencing_run_setup|nucleic_acid_extraction|variant_calling|array_hybridization|cell_culture|bioinformatics_pipeline — promote to reference product]',
    `protocol_number` STRING COMMENT 'Externally-known, human-readable unique document number assigned under the document numbering scheme (e.g., RD-SOP-001234). Used in regulatory submissions, audit trails, and cross-referencing in publications and SOPs.. Valid values are `^[A-Z]{2,6}-[A-Z]{2,8}-[0-9]{4,6}(-[0-9]{1,3})?$`',
    `protocol_type` STRING COMMENT 'Classification of the protocol by document type. SOP = Standard Operating Procedure; method = analytical or experimental method; assay_protocol = specific assay procedure; work_instruction = step-level task instruction; reference_method = compendial or regulatory reference method; study_plan = experimental study design document.. Valid values are `SOP|method|assay_protocol|work_instruction|reference_method|study_plan`',
    `read_length` STRING COMMENT 'Sequencing read length specification for NGS-based protocols (e.g., 2x150 bp, 1x75 bp, 2x250 bp). Applicable only to sequencing run setup and library preparation protocols. Null for non-sequencing protocols.',
    `regulatory_classification` STRING COMMENT 'Regulatory use classification of the protocol indicating the compliance framework under which it operates. GLP = Good Laboratory Practice; GMP = Good Manufacturing Practice; GCP = Good Clinical Practice; RUO = Research Use Only; IVD = In Vitro Diagnostic; LDT = Laboratory Developed Test; CE-IVD = Conformité Européenne In Vitro Diagnostic; non_regulated = no regulatory classification applies. [ENUM-REF-CANDIDATE: GLP|GMP|GCP|RUO|IVD|LDT|CE-IVD|non_regulated — 8 candidates stripped; promote to reference product]',
    `required_reagent_skus` STRING COMMENT 'Comma-separated list of reagent and consumable SKU (Stock Keeping Unit) codes required to execute this protocol. Enables Bill of Materials (BOM) linkage, inventory planning, and reagent lot tracking in SAP MM and LabVantage LIMS.',
    `reviewed_by` STRING COMMENT 'Name or employee identifier of the individual(s) who performed the technical or quality review of the protocol prior to approval. May contain a comma-separated list of reviewers. Required for GxP and ISO 13485 document control.',
    `safety_classification` STRING COMMENT 'Biosafety Level (BSL) classification of the protocol indicating the containment level required for safe execution. BSL1–BSL4 per CDC/NIH biosafety guidelines. Non_hazardous for protocols involving no biological risk agents. Drives laboratory safety requirements and access controls.. Valid values are `BSL1|BSL2|BSL3|BSL4|non_hazardous`',
    `short_name` STRING COMMENT 'Abbreviated or colloquial name for the protocol used in laboratory workflows, LIMS entries, and internal communications (e.g., gRNA Design SOP). Distinct from the full controlled document title.',
    `superseded_version_number` STRING COMMENT 'Version number of the immediately preceding protocol version that this record replaces. Enables forward and backward traceability across the protocol version history chain. Null for the initial version.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `technology_platform` STRING COMMENT 'Primary genomics technology platform that this protocol supports. NGS = Next-Generation Sequencing; array = microarray-based; PCR = Polymerase Chain Reaction; qPCR = Quantitative PCR; CRISPR = gene editing; Sanger = Sanger sequencing; ddPCR = droplet digital PCR. [ENUM-REF-CANDIDATE: NGS|array|PCR|qPCR|CRISPR|Sanger|ddPCR|digital_PCR|other — 9 candidates stripped; promote to reference product]',
    `title` STRING COMMENT 'Full descriptive title of the protocol as it appears on the controlled document (e.g., CRISPR Guide RNA Design and Validation Protocol for Mammalian Cell Lines). Used for search, display, and regulatory document identification.',
    `training_required` BOOLEAN COMMENT 'Indicates whether personnel must complete a formal training and competency assessment before being authorized to execute this protocol. True = training mandatory; False = no formal training requirement. Drives training assignment in MasterControl.',
    `validation_date` DATE COMMENT 'Date on which the protocol validation study was completed and the protocol was formally declared validated. Null if validation has not been completed. Required for IVD and clinical assay protocols.',
    `validation_status` STRING COMMENT 'Current state of analytical or process validation for this protocol. not_validated = no validation performed; in_validation = validation study in progress; validated = full validation completed; qualified = equipment/process qualification completed; transferred = validated and transferred to another site or team.. Valid values are `not_validated|in_validation|validated|qualified|transferred`',
    `version_number` STRING COMMENT 'Current version identifier of the protocol following semantic versioning convention (e.g., 1.0, 2.3, 3.0.1). Incremented upon each approved revision. Critical for ensuring laboratory staff execute the correct version and for regulatory traceability.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    CONSTRAINT pk_research_protocol PRIMARY KEY(`research_protocol_id`)
) COMMENT 'Master catalog of molecular biology and laboratory protocols used in R&D — including CRISPR guide RNA design protocols, library preparation SOPs, PCR/qPCR assay protocols, cell transfection procedures, and sequencing run setup protocols. Tracks protocol name, version, type (SOP, method, assay protocol), author, approval status, effective date, superseded version, associated Benchling protocol ID, applicable instrument platforms, and regulatory classification (GLP, RUO). Serves as the authoritative protocol library for the research domain.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` (
    `crispr_construct_id` BIGINT COMMENT 'Unique identifier for the CRISPR construct record. Primary key for the molecular biology construct registry.',
    `gene_model_id` BIGINT COMMENT 'Foreign key linking to reference.gene_model. Business justification: CRISPR constructs target specific genes; linking to canonical gene model (HGNC symbol, Ensembl ID) ensures design accuracy, regulatory traceability, and replaces denormalized target_gene text field wi',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: CRISPR design requires specific genome build for coordinate validation, PAM site identification, and off-target analysis. Essential for construct design accuracy and regulatory documentation of editin',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: CRISPR constructs synthesized and validated in R&D often become cataloged materials for internal use or commercialization (e.g., guide RNA libraries, editing plasmids). This link tracks construct-to-p',
    `project_id` BIGINT COMMENT 'Identifier of the R&D project or program under which this construct was developed. Links construct to portfolio management.',
    `benchling_entity_reference` STRING COMMENT 'Unique entity identifier in Benchling electronic lab notebook system linking to the molecular design record and sequence data.',
    `cas_protein_variant` STRING COMMENT 'Specific Cas protein variant used in the construct (e.g., Cas9, Cas12a, Cas13, dCas9, base editor variant). Identifies the nuclease or effector protein component.',
    `cell_type` STRING COMMENT 'Specific cell type or tissue targeted by the construct. Defines the cellular context for editing or expression.',
    `construct_code` STRING COMMENT 'Unique alphanumeric code or identifier assigned to the construct for tracking and cataloging purposes within the R&D system.',
    `construct_length_bp` STRING COMMENT 'Total length of the construct sequence measured in base pairs. Defines the size of the molecular construct.',
    `construct_name` STRING COMMENT 'Human-readable name or designation assigned to the CRISPR construct for identification and reference in laboratory workflows and publications.',
    `construct_type` STRING COMMENT 'Classification of the molecular construct type. Defines the category of the construct within the molecular biology design framework.. Valid values are `crispr_grna|cas_variant|plasmid|oligo|gene_fragment|expression_vector`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the construct record was first created in the data system. Audit trail for record lifecycle.',
    `delivery_format` STRING COMMENT 'Method or vehicle used to deliver the CRISPR construct into target cells. Defines the delivery mechanism for the molecular payload.. Valid values are `plasmid|rnp|lnp|aav|lentiviral|electroporation`',
    `design_rationale` STRING COMMENT 'Scientific justification and reasoning behind the construct design choices. Documents the strategic approach and expected outcomes.',
    `design_status` STRING COMMENT 'Current lifecycle status of the construct design. Tracks progression through design review and approval workflow.. Valid values are `draft|reviewed|approved|deprecated|archived`',
    `design_tool` STRING COMMENT 'Software tool or algorithm used to design the construct (e.g., Benchling, CRISPOR, Cas-OFFinder). Documents the computational design methodology.',
    `development_stage` STRING COMMENT 'Current stage of the construct in the R&D pipeline. Tracks progression from discovery through commercialization.. Valid values are `discovery|lead_optimization|preclinical|clinical|commercial`',
    `editing_modality` STRING COMMENT 'Type of genomic editing or modulation intended by the CRISPR construct. Defines the functional outcome of the gene editing strategy.. Valid values are `knockout|knock_in|base_edit|prime_edit|activation|repression`',
    `gc_content_percent` DECIMAL(18,2) COMMENT 'Percentage of guanine and cytosine nucleotides in the construct sequence. Influences stability and expression characteristics.',
    `genomic_coordinates` STRING COMMENT 'Precise genomic coordinates in standard format (chromosome:start-end) based on reference genome assembly GRCh38/hg38.',
    `grna_sequence` STRING COMMENT 'Nucleotide sequence of the guide RNA component that directs Cas protein to the target genomic locus. Proprietary sequence data for CRISPR targeting.',
    `ip_status` STRING COMMENT 'Intellectual property classification and protection status of the construct. Tracks IP rights and licensing obligations.. Valid values are `public|proprietary|patent_pending|patented|licensed_in|licensed_out`',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified the construct record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the construct record. Tracks record update history.',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, or comments related to the construct design, synthesis, or usage.',
    `off_target_score` DECIMAL(18,2) COMMENT 'Computational prediction score for off-target binding potential. Lower scores indicate higher specificity and reduced off-target risk.',
    `on_target_efficiency_score` DECIMAL(18,2) COMMENT 'Predicted or measured efficiency of the construct at the intended target site. Higher scores indicate greater editing efficiency.',
    `pam_sequence` STRING COMMENT 'PAM sequence required for Cas protein recognition and binding adjacent to the target site. Critical for CRISPR targeting specificity.',
    `patent_reference` STRING COMMENT 'Patent application or grant number associated with the construct if applicable. Links to formal IP protection filings.',
    `plasmid_backbone` STRING COMMENT 'Name or identifier of the plasmid backbone vector used for construct assembly. Defines the vector framework for cloning and expression.',
    `principal_investigator` STRING COMMENT 'Name of the principal investigator or lead scientist responsible for the construct design and development.',
    `promoter_element` STRING COMMENT 'Promoter sequence or element driving expression of the construct components. Defines transcriptional regulation of the construct.',
    `quality_control_status` STRING COMMENT 'Quality control verification status for the synthesized construct. Indicates whether sequence verification and purity checks were successful.. Valid values are `pending|passed|failed|not_applicable`',
    `selection_marker` STRING COMMENT 'Antibiotic resistance or fluorescent marker gene included for selection and identification of successfully transformed cells.',
    `sequence_data_reference` STRING COMMENT 'Reference identifier linking to the full sequence data stored in Benchling or other molecular design system. Typically a Benchling entity ID or accession number.',
    `species` STRING COMMENT 'Biological species for which the construct is designed (e.g., Homo sapiens, Mus musculus). Defines the organism context for the construct.',
    `storage_location` STRING COMMENT 'Physical or virtual location where the construct material or data is stored (e.g., freezer location, digital repository).',
    `synthesis_date` DATE COMMENT 'Date when the construct was physically synthesized or assembled. Tracks manufacturing timeline.',
    `synthesis_vendor` STRING COMMENT 'Name of the external vendor or internal facility that synthesized the construct. Tracks manufacturing source.',
    `target_locus` STRING COMMENT 'Genomic coordinates or locus identifier for the target region. Specifies the precise genomic location targeted by the construct.',
    `validation_status` STRING COMMENT 'Experimental validation status of the construct. Indicates whether functional testing has confirmed design performance.. Valid values are `not_tested|in_vitro_validated|in_vivo_validated|failed|inconclusive`',
    `created_by` STRING COMMENT 'Username or identifier of the researcher who created the construct record in the system.',
    CONSTRAINT pk_crispr_construct PRIMARY KEY(`crispr_construct_id`)
) COMMENT 'Master registry for molecular biology constructs and design artifacts developed within R&D programs — including CRISPR guide RNA (gRNA) sequences, Cas protein variants (Cas9, Cas12, Cas13), base editors, prime editors, delivery vector configurations, plasmid maps, oligo/primer designs, gene synthesis constructs, and expression vector configurations. Captures construct name, type (crispr_grna, cas_variant, plasmid, oligo, gene_fragment, expression_vector), target gene or locus, genomic coordinates (GRCh38/hg38), sequence data reference (Benchling entity ID), editing modality (knockout, knock-in, base edit — for CRISPR types), delivery format (plasmid, RNP, LNP, AAV), design tool/algorithm used, Benchling molecular design reference, design status (draft, reviewed, approved, deprecated), IP status, and development stage. Serves as the unified molecular construct registry bridging Benchling ELN with the broader research data model and IP portfolio management.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`assay_development` (
    `assay_development_id` BIGINT COMMENT 'Unique identifier for the assay development project. Primary key.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Tracks which regulatory approvals an assay has received (FDA clearance, CE mark). Essential for commercial status tracking and labeling compliance in genomics diagnostics.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Assay development projects result in commercial catalog items. Product development teams track which assay_development record produced each launched product for regulatory traceability, IP disclosure,',
    `controlled_document_id` BIGINT COMMENT 'Foreign key linking to quality.controlled_document. Business justification: Assay development protocols become controlled documents when transitioning to GxP operations. Required for maintaining version control, training records, and regulatory compliance for diagnostic assay',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Assay development projects require cost center assignment for R&D spend tracking, capitalization decisions per ASC 730, and COGS estimation for commercialization planning.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Assays frequently co-developed with specific customers (custom diagnostic panels, application-specific workflows). Critical for commercialization planning, IP negotiation, regulatory pathway alignment',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Clinical assay design (NGS panels, arrays) must be anchored to specific genome build for probe design, target region definition, FDA/CLIA validation, and regulatory submissions. Critical for diagnosti',
    `irb_submission_id` BIGINT COMMENT 'Foreign key linking to research.irb_submission. Business justification: Assay development projects involving human subjects research require IRB approval tracking. Currently assay_development has irb_approval_number (STRING) and irb_approval_date (DATE) but no FK to irb_s',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Assay development defines material requirements (reagent panels, controls, calibrators) for commercialization. This link supports COGS modeling, supply chain planning for launch, and tech transfer BOM',
    `metadata_schema_id` BIGINT COMMENT 'Foreign key linking to data.metadata_schema. Business justification: Assay development requires metadata schema definition for regulatory submissions (FDA premarket approval, CLIA validation) and data sharing requirements. Critical for commercialization pathway and reg',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to commercial.opportunity. Business justification: Assay development programs directly feed commercial pipeline for diagnostic/genomic assays. Opportunities reference underlying R&D assay program for technical specifications, analytical/clinical valid',
    `pipeline_id` BIGINT COMMENT 'Foreign key linking to bioinformatics.pipeline. Business justification: Assay development projects define the bioinformatics pipeline used for data analysis (variant calling algorithms, coverage thresholds, annotation databases). Direct product relationship - each assay h',
    `rd_capitalization_id` BIGINT COMMENT 'Foreign key linking to finance.rd_capitalization. Business justification: Assay development reaching commercial viability triggers capitalization assessment for intangible asset recognition. Critical for GAAP/IFRS compliance and accurate financial reporting of diagnostic pr',
    `project_id` BIGINT COMMENT 'Reference to the parent R&D project under which this assay development is conducted.',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Assay development culminates in regulatory submission for IVD clearance/approval (510(k), PMA, CE-IVD). Tracks which submission an assay development program targets.',
    `validation_study_id` BIGINT COMMENT 'Foreign key linking to quality.validation_study. Business justification: Assay development culminates in formal validation studies demonstrating analytical performance for regulatory submissions (FDA, CLIA, CE-IVD). Direct business process linking development phase to vali',
    `variant_database_id` BIGINT COMMENT 'Foreign key linking to reference.variant_database. Business justification: Clinical assay development requires variant databases (ClinVar, COSMIC, gnomAD) for pathogenicity classification, analytical validation, and clinical utility assessment. Essential for FDA/CLIA regulat',
    `analytical_sensitivity_percent` DECIMAL(18,2) COMMENT 'The proportion of true positive results correctly identified by the assay, expressed as a percentage.',
    `analytical_specificity_percent` DECIMAL(18,2) COMMENT 'The proportion of true negative results correctly identified by the assay, expressed as a percentage.',
    `assay_code` STRING COMMENT 'Unique alphanumeric code assigned to the assay for internal tracking and reference.',
    `assay_name` STRING COMMENT 'The official name or title of the assay under development.',
    `assay_type` STRING COMMENT 'The technical category or platform type of the assay being developed (e.g., NGS-based panel, qPCR diagnostic, SNP genotyping array, CNV detection, methylation assay, CRISPR editing efficiency readout).. Valid values are `NGS Panel|qPCR|SNP Genotyping Array|CNV Detection|Methylation|CRISPR Editing Efficiency`',
    `commercialization_date` DATE COMMENT 'The date on which the assay was launched for commercial sale or clinical use.',
    `coverage_depth_target` STRING COMMENT 'The target sequencing coverage depth (number of reads per base) required for the assay to achieve specified performance (applicable for NGS assays).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this assay development record was first created in the system.',
    `development_phase` STRING COMMENT 'The current stage of the assay development lifecycle (feasibility, optimization, pre-validation, analytical validation, clinical validation, commercialization).. Valid values are `Feasibility|Optimization|Pre-Validation|Analytical Validation|Clinical Validation|Commercialization`',
    `development_start_date` DATE COMMENT 'The date on which the assay development project officially commenced.',
    `development_status` STRING COMMENT 'The current operational status of the assay development project.. Valid values are `Active|On Hold|Completed|Cancelled|Transferred`',
    `estimated_cogs` DECIMAL(18,2) COMMENT 'The estimated per-test cost of goods sold for the assay, including reagents, consumables, and direct labor.',
    `feasibility_completion_date` DATE COMMENT 'The date on which the feasibility phase of the assay development was completed.',
    `intended_use` STRING COMMENT 'The clinical or research purpose for which the assay is designed, including target population and diagnostic or analytical objective.',
    `ip_status` STRING COMMENT 'The intellectual property protection status for the assay (e.g., patent pending, patent granted, trade secret, no IP, licensed).. Valid values are `Patent Pending|Patent Granted|Trade Secret|No IP|Licensed`',
    `lod_unit` STRING COMMENT 'The unit of measure for the LOD value (e.g., copies/mL, ng/mL, percentage).',
    `lod_value` DECIMAL(18,2) COMMENT 'The lowest quantity of target analyte that can be reliably detected by the assay, expressed in appropriate units.',
    `loq_unit` STRING COMMENT 'The unit of measure for the LOQ value (e.g., copies/mL, ng/mL, percentage).',
    `loq_value` DECIMAL(18,2) COMMENT 'The lowest quantity of target analyte that can be reliably quantified with acceptable precision and accuracy.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this assay development record was last modified.',
    `multiplexing_capacity` STRING COMMENT 'The number of samples that can be processed simultaneously in a single sequencing run or batch (applicable for NGS assays).',
    `panel_size` STRING COMMENT 'The number of genes, variants, or targets included in the assay panel (applicable for NGS panels and genotyping arrays).',
    `patent_number` STRING COMMENT 'The patent number(s) associated with the assay technology or methodology, if applicable.',
    `precision_cv_percent` DECIMAL(18,2) COMMENT 'The coefficient of variation representing the repeatability and reproducibility of the assay, expressed as a percentage.',
    `principal_investigator_name` STRING COMMENT 'The name of the principal investigator or lead scientist responsible for the assay development project.',
    `publication_reference` STRING COMMENT 'Citation or DOI of any peer-reviewed publication(s) resulting from the assay development work.',
    `rd_budget_allocated` DECIMAL(18,2) COMMENT 'The total budget allocated for the assay development project.',
    `rd_spend_to_date` DECIMAL(18,2) COMMENT 'The cumulative R&D expenditure on the assay development project as of the current date.',
    `read_length` STRING COMMENT 'The sequencing read length in base pairs used for the assay (applicable for NGS assays).',
    `regulatory_classification` STRING COMMENT 'The regulatory category under which the assay is being developed: In Vitro Diagnostic (IVD), Research Use Only (RUO), or Laboratory Developed Test (LDT).. Valid values are `IVD|RUO|LDT`',
    `regulatory_pathway` STRING COMMENT 'The regulatory approval route being pursued for the assay (e.g., FDA 510(k), FDA De Novo, CE-IVD, CLIA LDT). [ENUM-REF-CANDIDATE: FDA 510(k)|FDA De Novo|FDA PMA|CE-IVD|CLIA LDT|EMA Approval|Exempt — promote to reference product]',
    `reproducibility_assessment` STRING COMMENT 'Qualitative or quantitative assessment of the assays ability to produce consistent results across different operators, instruments, reagent lots, and time points.',
    `sample_type` STRING COMMENT 'The biological specimen type(s) compatible with the assay (e.g., whole blood, plasma, saliva, tissue, FFPE). [ENUM-REF-CANDIDATE: Whole Blood|Plasma|Serum|Saliva|Buccal Swab|Tissue|FFPE|DNA|RNA — promote to reference product]',
    `target_analyte` STRING COMMENT 'The specific genetic variant, gene, biomarker, or molecular target that the assay is designed to detect or measure.',
    `target_asp` DECIMAL(18,2) COMMENT 'The target average selling price per test for the assay upon commercialization.',
    `target_tat_hours` STRING COMMENT 'The intended turnaround time from sample receipt to result reporting, measured in hours.',
    `technology_platform` STRING COMMENT 'The sequencing or detection platform on which the assay is designed to run (e.g., Illumina NovaSeq, MiSeq, NextSeq, Ion Torrent, qPCR instrument model).',
    `technology_readiness_level` STRING COMMENT 'The technology readiness level of the assay on a scale of 1-9, indicating maturity from basic research (1) to full commercial deployment (9).',
    `validation_completion_date` DATE COMMENT 'The date on which analytical validation of the assay was completed.',
    CONSTRAINT pk_assay_development PRIMARY KEY(`assay_development_id`)
) COMMENT 'Tracks custom assay development projects from feasibility through analytical validation — including NGS-based panel assays, qPCR diagnostic assays, SNP genotyping arrays, CNV detection assays, methylation assays, and CRISPR editing efficiency readouts. Captures assay name, type (IVD, RUO, LDT), target analyte/biomarker, intended use, development phase (feasibility, optimization, pre-validation, analytical validation, clinical validation), performance characteristics (LOD, LOQ, analytical sensitivity/specificity, precision, reproducibility), target TAT, regulatory pathway (FDA 510(k), CE-IVD, CLIA LDT), and parent R&D project. Bridges R&D discovery with clinical/commercial assay deployment.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`spend` (
    `spend_id` BIGINT COMMENT 'Primary key for spend',
    `asset_id` BIGINT COMMENT 'Reference to the laboratory instrument or equipment for which depreciation is being allocated in this spend record, applicable for instrument depreciation cost category.',
    `capex_request_id` BIGINT COMMENT 'Foreign key linking to finance.capex_request. Business justification: R&D capital expenditures originate from approved capex requests for governance, budget control, and audit trail. Required for SOX compliance and capital allocation tracking.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: R&D spend is allocated to develop specific products. Finance and portfolio management track which catalog items consumed which R&D investment for ROI analysis, capitalization decisions, and product pr',
    `collaboration_agreement_id` BIGINT COMMENT 'Reference to the external collaboration or partnership agreement under which this R&D spend is incurred, if applicable.',
    `compute_job_id` BIGINT COMMENT 'Reference to the HPC or cloud compute job for which infrastructure costs are being allocated, applicable for compute infrastructure cost category.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for this R&D expenditure.',
    `employee_id` BIGINT COMMENT 'Reference to the employee whose personnel costs (salary, benefits, FTE allocation) are captured in this spend record, applicable for personnel cost category.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: R&D spend on capital equipment (sequencers, mass specs) must link to fixed assets for depreciation, asset management, and financial statement reporting per GAAP/IFRS.',
    `grant_id` BIGINT COMMENT 'Reference to the research grant or funding award that partially or fully covers this R&D spend, if applicable.',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: R&D purchases of reagents, instruments, and sequencing services generate internal sales orders. Critical for tracking capitalizable R&D spend, project cost accounting, and reconciling research budgets',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: R&D spend often charged to internal orders for project-based cost tracking, settlement to fixed assets, and capitalization workflow. Standard SAP configuration for biotech R&D accounting.',
    `project_id` BIGINT COMMENT 'Reference to the R&D project or program to which this spend is allocated.',
    `supplier_id` BIGINT COMMENT 'Reference to the external vendor or service provider (CRO, CMO, reagent supplier, cloud provider) associated with this spend, if applicable.',
    `amount` DECIMAL(18,2) COMMENT 'The monetary value of the R&D expenditure in the transaction currency.',
    `amount_local` DECIMAL(18,2) COMMENT 'The spend amount converted to the local reporting currency of the business unit or legal entity.',
    `approval_status` STRING COMMENT 'Workflow status of the spend transaction: draft (not yet submitted), pending approval (awaiting manager/finance approval), approved (authorized for posting), rejected (not authorized), or posted (recorded in GL).. Valid values are `draft|pending_approval|approved|rejected|posted`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this R&D spend transaction.',
    `approved_date` DATE COMMENT 'The date on which the spend transaction was approved by the authorized approver.',
    `budget_line_item_code` BIGINT COMMENT 'Reference to the budget line item against which this spend is tracked, enabling budget vs. actuals variance analysis.',
    `capitalization_eligible` BOOLEAN COMMENT 'Indicates whether this R&D spend is eligible for capitalization under accounting standards (ASC 730 for US GAAP or IAS 38 for IFRS). True if eligible, False if expensed immediately.',
    `capitalization_status` STRING COMMENT 'Current capitalization treatment status: expensed (immediately recognized), capitalized (added to intangible asset), pending review (awaiting finance decision), or deferred (to be allocated in future periods).. Valid values are `expensed|capitalized|pending_review|deferred`',
    `cost_category` STRING COMMENT 'Classification of the R&D spend by type: personnel costs (FTE allocation), external CRO/CMO service fees, reagent and consumable purchases, instrument depreciation allocations, HPC/cloud compute costs, facility overhead, travel, or other. [ENUM-REF-CANDIDATE: personnel|external_services|reagents_consumables|instrument_depreciation|compute_infrastructure|facility_overhead|travel|other — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this spend record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the spend amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert the transaction currency to the local reporting currency.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year in which the spend was recorded.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the spend was recorded, used for annual budget tracking and financial reporting.',
    `fte_allocation` DECIMAL(18,2) COMMENT 'The proportion of an employees time allocated to this R&D project, expressed as a decimal (e.g., 0.50 for 50% allocation, 1.00 for full-time).',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this R&D spend is posted, linking to the chart of accounts in the ERP system.',
    `invoice_number` STRING COMMENT 'The vendor invoice number associated with this spend transaction, used for accounts payable reconciliation.',
    `modified_by` STRING COMMENT 'The user or system identifier that last modified this spend record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this spend record was last modified.',
    `notes` STRING COMMENT 'Additional notes or comments related to this R&D spend transaction, used for audit trail and clarification purposes.',
    `payment_date` DATE COMMENT 'The date on which payment was made to the vendor or the spend was settled, if applicable.',
    `payment_status` STRING COMMENT 'Current payment status of the spend transaction: unpaid (invoice received but not paid), partially paid (partial payment made), paid (fully settled), or overdue (past due date).. Valid values are `unpaid|partially_paid|paid|overdue`',
    `purchase_order_number` STRING COMMENT 'The purchase order number associated with this spend, linking to procurement records in the ERP system.',
    `spend_date` DATE COMMENT 'The date on which the R&D expenditure was incurred or posted to the general ledger.',
    `spend_description` STRING COMMENT 'Free-text description of the R&D spend transaction, providing additional context about the nature of the expenditure.',
    `spend_number` STRING COMMENT 'Business identifier for the spend transaction, typically sourced from the ERP system (e.g., SAP document number).',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax amount (VAT, sales tax, GST) associated with this R&D spend, if applicable.',
    `vendor_name` STRING COMMENT 'Name of the external vendor or service provider associated with this R&D spend.',
    `wbs_element` STRING COMMENT 'The WBS element code from the project management system, used for hierarchical project cost tracking and reporting.',
    `created_by` STRING COMMENT 'The user or system identifier that created this spend record.',
    CONSTRAINT pk_spend PRIMARY KEY(`spend_id`)
) COMMENT 'Transactional record of R&D expenditure at the project and cost-center level — capturing actual spend events including personnel costs (FTE allocation), external CRO/CMO service fees, reagent and consumable purchases, instrument depreciation allocations, and HPC/cloud compute costs. Tracks spend date, cost category, cost center, GL account reference, amount, currency, capitalization eligibility (ASC 730 / IFRS IAS 38), and approval status. Enables R&D capitalization decisions, budget vs. actuals tracking, and EBITDA impact reporting. Complements the finance domains general ledger without duplicating it.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` (
    `collaboration_agreement_id` BIGINT COMMENT 'Unique identifier for the R&D collaboration agreement record. Primary key.',
    `project_id` BIGINT COMMENT 'Identifier linking to the associated R&D project in Benchling electronic lab notebook system where collaboration research activities are documented.',
    `channel_partner_id` BIGINT COMMENT 'Foreign key linking to commercial.channel_partner. Business justification: Research collaborations with academic/industry partners frequently evolve into commercial channel partnerships in genomics. Partner transitions from R&D co-development to commercial co-marketing/distr',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Collaboration agreements require cost center assignment for budget tracking, intercompany allocations, and transfer pricing documentation. Essential for cross-border biotech partnerships and financial',
    `employee_id` BIGINT COMMENT 'Identifier of the Genomics Biotech employee responsible for managing the collaboration agreement and partner relationship.',
    `genomic_access_control_id` BIGINT COMMENT 'Foreign key linking to data.genomic_access_control. Business justification: Collaboration agreements define data access policies, consent requirements, and data use limitations for shared genomic datasets. Essential for enforcing contractual data sharing obligations and conse',
    `grant_id` BIGINT COMMENT 'Foreign key linking to research.grant. Business justification: Collaboration agreements may be funded by external grants (NIH, NSF, etc.). Currently collaboration_agreement has grant_number (STRING) and grant_funding_source (STRING) but no FK. Adding grant_id FK ',
    `intercompany_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.intercompany_transaction. Business justification: Cross-border collaborations generate intercompany transactions requiring transfer pricing documentation, elimination entries, and tax compliance. Essential for multinational biotech operations and con',
    `irb_submission_id` BIGINT COMMENT 'Foreign key linking to research.irb_submission. Business justification: Collaboration agreements involving human subjects research (phi_involved=true) must reference the IRB submission for compliance tracking. Currently collaboration_agreement has irb_approval_number (STR',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: External research collaborations (with academic institutions, pharma companies, biotech partners) are with entities tracked as customer accounts. This links research partnerships to the authoritative ',
    `document_id` BIGINT COMMENT 'Identifier linking to the executed agreement document stored in Veeva Vault document management system.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the collaboration agreement, typically formatted with prefix and sequential number (e.g., CDA-20230045, SRA-2024001).. Valid values are `^[A-Z]{2,4}-[0-9]{4,8}$`',
    `agreement_title` STRING COMMENT 'Full descriptive title of the collaboration agreement as stated in the contract document.',
    `agreement_type` STRING COMMENT 'Classification of the collaboration agreement type. Sponsored research: academic institution performs research funded by Genomics Biotech. Co-development: joint R&D with shared IP. Licensing-in: acquiring rights to external technology. Material transfer: exchange of biological materials or reagents. Data sharing: exchange of genomic or clinical datasets. Consortium membership: participation in industry collaborative groups.. Valid values are `sponsored_research|co_development|licensing_in|material_transfer|data_sharing|consortium_membership`',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews upon expiration unless either party provides notice.',
    `collaboration_agreement_status` STRING COMMENT 'Current lifecycle status of the collaboration agreement. Draft: initial preparation. Under negotiation: terms being discussed. Pending approval: awaiting internal or partner sign-off. Active: in force and operational. Suspended: temporarily paused. Terminated: ended before expiration. Completed: successfully concluded. Expired: reached end date. [ENUM-REF-CANDIDATE: draft|under_negotiation|pending_approval|active|suspended|terminated|completed|expired — 8 candidates stripped; promote to reference product]',
    `confidentiality_tier` STRING COMMENT 'Classification of confidentiality requirements for the collaboration. Standard: typical NDA protections. High: enhanced confidentiality with limited disclosure. Critical: highly sensitive strategic partnership with strict access controls.. Valid values are `standard|high|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the collaboration agreement record was first created in the system.',
    `data_sharing_obligation` STRING COMMENT 'Defines data sharing requirements between parties. Full sharing: all research data exchanged. Limited sharing: only specified datasets or summary data. No sharing: data remains with generating party. Upon request: data shared on case-by-case basis.. Valid values are `full_sharing|limited_sharing|no_sharing|upon_request`',
    `data_use_restrictions` STRING COMMENT 'Specific limitations on how shared data may be used, including permitted research purposes, prohibited uses, and requirements for data security and privacy compliance.',
    `effective_date` DATE COMMENT 'Date when the collaboration agreement becomes legally binding and operational activities may commence.',
    `exclusivity_scope` STRING COMMENT 'Defines exclusivity terms. Exclusive: only Genomics Biotech has rights in defined field/territory. Non-exclusive: partner may grant rights to others. Co-exclusive: limited number of licensees. Field-limited exclusive: exclusive within specific application area.. Valid values are `exclusive|non_exclusive|co_exclusive|field_limited_exclusive`',
    `execution_date` DATE COMMENT 'Date when the agreement was signed by all parties.',
    `expiration_date` DATE COMMENT 'Date when the collaboration agreement terminates unless renewed or extended. Nullable for open-ended agreements.',
    `grant_funding_source` STRING COMMENT 'Name of government or foundation grant program funding the collaboration, if applicable (e.g., NIH R01, BARDA contract, DARPA program, Gates Foundation grant).',
    `gxp_applicable` BOOLEAN COMMENT 'Indicates whether the collaboration activities must comply with GxP regulations (GMP, GLP, GCP) due to regulatory intent.',
    `ip_ownership_model` STRING COMMENT 'Framework governing ownership of intellectual property generated under the collaboration. Genomics Biotech owns: all IP vests in Genomics Biotech. Partner owns: all IP vests in partner. Joint ownership: co-ownership with defined exploitation rights. Background-foreground split: each party retains background IP, foreground IP allocated per agreement. Case-by-case: determined per invention.. Valid values are `genomics_biotech_owns|partner_owns|joint_ownership|background_foreground_split|case_by_case`',
    `irb_approval_required` BOOLEAN COMMENT 'Indicates whether the collaboration involves human subjects research requiring IRB approval and oversight.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the collaboration agreement record was last updated.',
    `licensing_rights` STRING COMMENT 'Description of licensing rights granted to Genomics Biotech or partner, including field of use, territory, exclusivity, and sublicensing permissions.',
    `payment_structure` STRING COMMENT 'Financial payment model for the agreement. Lump sum: single upfront payment. Milestone-based: payments tied to achievement of defined milestones. Periodic: regular installments (monthly, quarterly). Cost reimbursement: actual costs plus overhead. Hybrid: combination of structures.. Valid values are `lump_sum|milestone_based|periodic|cost_reimbursement|hybrid`',
    `phi_involved` BOOLEAN COMMENT 'Indicates whether the collaboration involves exchange or use of protected health information subject to HIPAA regulations.',
    `principal_investigator_name` STRING COMMENT 'Name of the lead scientist or principal investigator at the partner organization responsible for the research activities.',
    `publication_embargo_days` STRING COMMENT 'Number of days that publication must be delayed to allow for patent application filing or confidential information review. Typically 30-90 days.',
    `publication_rights` STRING COMMENT 'Terms governing publication of research results. Unrestricted: parties may publish freely. Review required: other party reviews manuscripts before submission. Embargo period: delay publication for patent filing. Restricted: publication requires mutual consent.. Valid values are `unrestricted|review_required|embargo_period|restricted`',
    `regulatory_submission_planned` BOOLEAN COMMENT 'Indicates whether the collaboration is intended to generate data for regulatory submission (FDA, EMA, etc.) for product approval.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiration that either party must provide notice to prevent auto-renewal or to initiate renewal discussions.',
    `research_focus` STRING COMMENT 'Description of the scientific or clinical research focus area of the collaboration (e.g., oncology genomics, rare disease diagnostics, agricultural genomics, population health).',
    `sap_contract_number` STRING COMMENT 'Contract number in SAP S/4HANA system for financial tracking and procurement integration.',
    `sponsoring_business_unit` STRING COMMENT 'Genomics Biotech business unit or division sponsoring and funding the collaboration (e.g., Research Instruments, Clinical Genomics, Agricultural Solutions).',
    `target_indication` STRING COMMENT 'Specific disease, condition, or application area targeted by the collaboration research (e.g., breast cancer, cystic fibrosis, crop yield improvement).',
    `technology_area` STRING COMMENT 'Primary genomics technology focus of the collaboration. NGS: Next-Generation Sequencing. WGS: Whole Genome Sequencing. WES: Whole Exome Sequencing. Array: microarray-based genotyping. CRISPR: gene editing. PCR/qPCR: amplification technologies. Bioinformatics: computational analysis. Clinical assay: diagnostic test development. [ENUM-REF-CANDIDATE: ngs|wgs|wes|array|crispr|pcr|qpcr|bioinformatics|clinical_assay|other — 10 candidates stripped; promote to reference product]',
    `termination_date` DATE COMMENT 'Actual date when the agreement was terminated, if applicable. Populated only for terminated agreements.',
    `total_funding_amount_usd` DECIMAL(18,2) COMMENT 'Total financial commitment from Genomics Biotech to the partner under this agreement, expressed in USD. Includes sponsored research funding, milestone payments, and upfront fees.',
    CONSTRAINT pk_collaboration_agreement PRIMARY KEY(`collaboration_agreement_id`)
) COMMENT 'Master record for external R&D collaboration agreements — including academic partnerships (MIT, Broad Institute, Sanger), biopharma co-development deals, CRO/CDMO service agreements, government grants (NIH, BARDA, DARPA), and industry consortium memberships (GA4GH, ASHG). Captures agreement title, partner organization, agreement type (sponsored research, co-development, licensing-in, material transfer, data sharing), effective/expiration dates, financial terms, IP ownership and licensing provisions, publication rights and embargo periods, exclusivity scope, data sharing obligations, IRB requirements, and status. Distinct from commercial contracts — these are research-specific partnerships.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`irb_submission` (
    `irb_submission_id` BIGINT COMMENT 'Unique identifier for the IRB submission record. Primary key. Role: TRANSACTION_HEADER.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to quality.audit. Business justification: IRB submissions undergo quality audits for compliance with human subjects research regulations (45 CFR 46, ICH-GCP). Required for tracking audit findings to specific IRB protocols and ensuring ethical',
    `project_id` BIGINT COMMENT 'Reference identifier to the associated Benchling R&D project where experimental protocols and lab notebook entries are maintained.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: IRB-approved studies incur costs tracked to specific cost centers for regulatory compliance, audit trails, and clinical trial financial reporting. Required for FDA/EMA submissions and sponsor reconcil',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: IRB protocols involving customer sites as research partners or sample sources. Essential for multi-site study coordination, consent management, data sharing agreements, and regulatory compliance. Comm',
    `genomic_access_control_id` BIGINT COMMENT 'Foreign key linking to data.genomic_access_control. Business justification: IRB protocols establish consent frameworks that directly govern genomic data access policies and data use limitations. IRB-approved consent forms define who can access genomic data and for what purpos',
    `grant_id` BIGINT COMMENT 'Foreign key linking to research.grant. Business justification: IRB submissions for grant-funded human subjects research must reference the grant. Currently irb_submission has grant_number (STRING) but no FK. Adding grant_id FK allows joining to grant for funding_',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the workforce record of the Principal Investigator.',
    `rd_project_id` BIGINT COMMENT 'Foreign key reference to the R&D project associated with this IRB submission. Links the submission to the sponsoring research program.',
    `adverse_event_count` STRING COMMENT 'Cumulative count of adverse events reported to the IRB for this study. Tracked for ongoing safety monitoring.',
    `amendment_count` STRING COMMENT 'Number of protocol amendments submitted and approved since initial IRB approval. Tracks protocol evolution.',
    `approval_date` DATE COMMENT 'Date the IRB board granted approval for the research protocol. Null if not yet approved.',
    `approval_expiration_date` DATE COMMENT 'Date the IRB approval expires, requiring continuing review or renewal. Typically one year from approval date for greater-than-minimal-risk studies.',
    `approval_status` STRING COMMENT 'Current lifecycle status of the IRB submission in the review and approval workflow. [ENUM-REF-CANDIDATE: submitted|under_review|approved|conditionally_approved|deferred|disapproved|withdrawn|expired — 8 candidates stripped; promote to reference product]',
    `clinical_trial_registration_number` STRING COMMENT 'ClinicalTrials.gov registration number (NCT number) if the study is a clinical trial requiring public registration. Format: NCT########.. Valid values are `^NCT[0-9]{8}$`',
    `closure_date` DATE COMMENT 'Date the study was formally closed with the IRB, indicating all research activities and data collection have been completed.',
    `consent_form_version` STRING COMMENT 'Version identifier of the informed consent form approved by the IRB for this submission.',
    `continuing_review_due_date` DATE COMMENT 'Date by which continuing review submission is due to maintain active IRB approval. Typically 30-60 days before expiration.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this IRB submission record was first created in the system. Audit trail field.',
    `data_privacy_impact_assessment_completed` BOOLEAN COMMENT 'Boolean flag indicating whether a Data Privacy Impact Assessment has been completed for this study, as required by GDPR for high-risk processing.',
    `data_repository_name` STRING COMMENT 'Name of the public genomic data repository where study data will be deposited (e.g., dbGaP, EGA, AnVIL). Null if data sharing not required.',
    `estimated_enrollment` STRING COMMENT 'Estimated total number of human subjects to be enrolled in the research study.',
    `funding_source` STRING COMMENT 'Primary source of funding for the research study. Determines reporting and compliance obligations.. Valid values are `internal|nih_grant|industry_sponsored|foundation_grant|other_federal|unfunded`',
    `gdpr_applicable` BOOLEAN COMMENT 'Boolean flag indicating whether the study involves EU subjects or data, making GDPR compliance requirements applicable.',
    `genomic_data_sharing_required` BOOLEAN COMMENT 'Boolean flag indicating whether the study is subject to NIH Genomic Data Sharing (GDS) Policy requirements for depositing genomic data into public repositories.',
    `hipaa_waiver_status` STRING COMMENT 'Status of HIPAA authorization waiver or alteration request for use of Protected Health Information (PHI) in the research study.. Valid values are `not_applicable|waiver_granted|waiver_denied|alteration_granted|no_waiver_requested`',
    `irb_board_name` STRING COMMENT 'Name of the Institutional Review Board that reviews this submission (e.g., Stanford IRB, Western IRB, Internal Genomics Biotech IRB).',
    `irb_board_registration_number` STRING COMMENT 'Federal registration number (IORG or IRB registration) assigned by OHRP or FDA for the reviewing IRB board.',
    `last_continuing_review_date` DATE COMMENT 'Date of the most recent continuing review approval by the IRB. Null if no continuing review has occurred.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this IRB submission record was most recently modified. Audit trail field.',
    `phi_handling_classification` STRING COMMENT 'Classification of how Protected Health Information is handled in the study. Determines HIPAA compliance requirements.. Valid values are `no_phi|limited_data_set|identifiable_phi|de_identified`',
    `principal_investigator_name` STRING COMMENT 'Full name of the Principal Investigator responsible for the research protocol and IRB submission.',
    `protocol_title` STRING COMMENT 'Full title of the research protocol submitted for IRB review. Describes the study purpose and scope.',
    `protocol_version` STRING COMMENT 'Version number of the protocol document submitted (e.g., v1.0, 2.3). Tracks protocol amendments and revisions.. Valid values are `^v?[0-9]+.[0-9]+$`',
    `review_type` STRING COMMENT 'Type of IRB review process applied to this submission based on risk and study characteristics.. Valid values are `full_board|expedited|exempt_determination|continuing_review`',
    `risk_classification` STRING COMMENT 'IRB-assigned risk level for human subjects participating in the study. Determines review pathway and oversight requirements.. Valid values are `minimal_risk|greater_than_minimal_risk|exempt`',
    `serious_adverse_event_count` STRING COMMENT 'Cumulative count of serious adverse events (SAEs) reported to the IRB for this study. Requires expedited reporting.',
    `study_coordinator_name` STRING COMMENT 'Full name of the study coordinator or research manager responsible for operational execution of the protocol.',
    `study_duration_months` STRING COMMENT 'Planned duration of the research study in months from first enrollment to study completion.',
    `study_type` STRING COMMENT 'Classification of the research study type. Determines regulatory pathway and risk assessment.. Valid values are `observational|interventional|genomic_data_analysis|biospecimen_collection|registry|retrospective_chart_review`',
    `submission_date` DATE COMMENT 'Date the IRB submission was formally submitted to the IRB board for review. Principal business event timestamp.',
    `submission_number` STRING COMMENT 'Externally-known business identifier for the IRB submission, typically assigned by the IRB board or internal tracking system. Format: IRB-YYYY-NNNNNN.. Valid values are `^IRB-[0-9]{4}-[0-9]{4,6}$`',
    `veeva_document_reference` STRING COMMENT 'Reference identifier to the IRB submission document package stored in Veeva Vault regulatory document management system.',
    `vulnerable_population_involved` BOOLEAN COMMENT 'Boolean flag indicating whether the study involves vulnerable populations (children, prisoners, pregnant women, cognitively impaired) requiring additional IRB protections.',
    `vulnerable_population_type` STRING COMMENT 'Specific type of vulnerable population involved in the study (e.g., children, prisoners, pregnant_women, cognitively_impaired). Null if not applicable.',
    CONSTRAINT pk_irb_submission PRIMARY KEY(`irb_submission_id`)
) COMMENT 'Tracks Institutional Review Board (IRB) submissions and approvals for human subjects research conducted or sponsored by Genomics Biotech — including genomic data studies, clinical sample collection protocols, and precision medicine research programs. Captures submission date, IRB board name, protocol title, study type, risk classification, approval status, approval date, expiration date, amendment history count, HIPAA waiver status, PHI handling classification, and associated R&D project. Ensures compliance with NIH Genomic Data Sharing Policy, HIPAA, and GDPR for human genomic research.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` (
    `ip_disclosure_id` BIGINT COMMENT 'Unique identifier for the intellectual property disclosure record. Primary key.',
    `collaboration_agreement_id` BIGINT COMMENT 'Foreign key linking to research.collaboration_agreement. Business justification: IP disclosures generated under collaboration agreements must track the agreement for ownership determination (joint_ownership_flag, ip_ownership_model). Currently ip_disclosure has collaboration_partn',
    `employee_id` BIGINT COMMENT 'Employee identifier of the lead inventor responsible for the invention conception and disclosure submission.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to commercial.opportunity. Business justification: IP disclosures are core to commercial value proposition in genomics/biotech. Opportunities for novel sequencing technologies, gene-editing tools, or diagnostic panels must reference underlying IP to a',
    `project_id` BIGINT COMMENT 'Reference to the R&D project from which this IP disclosure originated.',
    `document_id` BIGINT COMMENT 'Reference to the IP disclosure document stored in Veeva Vault for regulatory document management and quality compliance.',
    `assigned_ip_counsel` STRING COMMENT 'Name of the internal or external IP attorney or patent agent assigned to manage the disclosure and any subsequent patent prosecution.',
    `benchling_entry_reference` STRING COMMENT 'Reference to the Benchling ELN entry documenting the experimental work and data supporting the invention disclosure.',
    `commercial_potential` STRING COMMENT 'Assessment of the inventions potential commercial value and market impact, used to prioritize IP investment decisions.. Valid values are `high|medium|low|unknown`',
    `competitive_advantage` STRING COMMENT 'Description of how the invention provides competitive advantage over existing solutions or competitor offerings in the genomics-biotechnology market.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the IP disclosure record was first created in the system.',
    `disclosure_code` STRING COMMENT 'Business identifier for the IP disclosure, typically formatted as IPD-XXXXXX for external reference and tracking.. Valid values are `^IPD-[0-9]{6}$`',
    `disclosure_date` DATE COMMENT 'Date on which the invention was formally disclosed to the IP management office. Critical for establishing priority date and patent filing deadlines.',
    `disclosure_status` STRING COMMENT 'Current lifecycle status of the IP disclosure in the evaluation and decision workflow. [ENUM-REF-CANDIDATE: submitted|under_review|novelty_assessment|prior_art_search|decision_pending|approved_for_filing|abandoned|trade_secret — 8 candidates stripped; promote to reference product]',
    `estimated_filing_cost_usd` DECIMAL(18,2) COMMENT 'Estimated cost in USD for patent filing, prosecution, and maintenance over the patent lifecycle. Used for IP budget planning and ROI analysis.',
    `filing_decision_date` DATE COMMENT 'Date when the patent filing decision was made by the IP committee or executive leadership.',
    `filing_decision_rationale` STRING COMMENT 'Business and technical justification for the patent filing decision, including strategic value, competitive landscape, and cost-benefit analysis.',
    `funding_source` STRING COMMENT 'Source of funding for the R&D that led to the invention. Government-funded research may have special IP reporting and licensing obligations.. Valid values are `internal|government_grant|private_grant|collaboration|mixed`',
    `government_interest_statement` STRING COMMENT 'Statement acknowledging government funding and rights in the invention, required for patent applications when research was federally funded.',
    `invention_description` STRING COMMENT 'Detailed technical description of the invention, including the problem solved, novel aspects, and potential applications. Confidential business information.',
    `invention_type` STRING COMMENT 'Classification of the invention according to patent law categories: composition of matter (e.g., novel sequencing chemistry, CRISPR construct), method (e.g., assay protocol), process (e.g., manufacturing workflow), software (e.g., bioinformatics algorithm), apparatus (e.g., instrument component), or design.. Valid values are `composition_of_matter|method|process|software|apparatus|design`',
    `inventors` STRING COMMENT 'Comma-separated list of full names of all inventors who contributed to the conception of the invention. Required for patent applications and inventor recognition.',
    `ip_counsel_firm` STRING COMMENT 'Name of the external law firm providing IP counsel services, if applicable.',
    `joint_ownership_flag` BOOLEAN COMMENT 'Indicates whether the IP is jointly owned with an external party due to collaborative research or co-invention.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the IP disclosure record was last modified, supporting audit trail and change tracking.',
    `novelty_assessment_date` DATE COMMENT 'Date when the novelty assessment was completed by the IP review committee or external counsel.',
    `novelty_assessment_status` STRING COMMENT 'Status and outcome of the internal novelty assessment to determine if the invention is sufficiently novel and non-obvious for patent protection.. Valid values are `not_started|in_progress|completed|novel|not_novel|uncertain`',
    `novelty_rationale` STRING COMMENT 'Summary of the novelty assessment findings, including key differentiators from prior art and justification for novelty determination.',
    `patent_application_number` STRING COMMENT 'Official patent application number assigned by the patent office (USPTO, EPO, etc.) upon filing. Null if not yet filed or if filing decision was to abandon or maintain as trade secret.',
    `patent_filing_date` DATE COMMENT 'Date on which the patent application was officially filed with the patent office. Establishes the priority date for patent rights.',
    `patent_filing_decision` STRING COMMENT 'Strategic decision on how to protect the invention: file a patent application, abandon (no protection), maintain as trade secret, or publish defensively to prevent others from patenting.. Valid values are `file_patent|abandon|trade_secret|defensive_publication|pending_decision`',
    `patent_jurisdiction` STRING COMMENT 'Primary patent jurisdiction or filing route: USA (United States Patent and Trademark Office), EPO (European Patent Office), PCT (Patent Cooperation Treaty for international filing), or specific country codes. [ENUM-REF-CANDIDATE: USA|EPO|PCT|JPN|CHN|KOR|CAN|AUS|BRA|IND — 10 candidates stripped; promote to reference product]',
    `prior_art_references` STRING COMMENT 'List of relevant prior art references identified during the search, including patent numbers, publication citations, and public disclosures.',
    `prior_art_search_date` DATE COMMENT 'Date when the prior art search was completed.',
    `prior_art_search_status` STRING COMMENT 'Status and outcome of the prior art search conducted to identify existing patents, publications, or public disclosures that may affect patentability.. Valid values are `not_started|in_progress|completed|no_blocking_art|blocking_art_found`',
    `public_disclosure_date` DATE COMMENT 'Date of any public disclosure of the invention (publication, presentation, product launch, etc.). Triggers one-year grace period for US patent filing and may bar foreign patent rights.',
    `publication_reference` STRING COMMENT 'Citation or reference to any scientific publication, conference presentation, or public disclosure related to the invention. Critical for tracking public disclosure dates that may affect patentability.',
    `regulatory_impact` STRING COMMENT 'Assessment of whether the invention has regulatory implications (e.g., requires FDA approval, impacts IVD classification, affects GxP compliance).. Valid values are `none|low|medium|high`',
    `strategic_importance` STRING COMMENT 'Assessment of the inventions strategic importance to the companys competitive position, product roadmap, and long-term R&D goals.. Valid values are `critical|high|medium|low`',
    `target_product_application` STRING COMMENT 'Description of the intended product or service application for the invention, linking IP to commercialization strategy.',
    `technology_area` STRING COMMENT 'Primary technology domain of the invention, aligned with the companys core R&D focus areas in genomics and biotechnology. [ENUM-REF-CANDIDATE: sequencing_chemistry|crispr_gene_editing|bioinformatics_algorithm|assay_development|library_preparation|instrument_engineering|reagent_formulation|data_analysis_pipeline|clinical_diagnostic|array_technology — 10 candidates stripped; promote to reference product]',
    `title` STRING COMMENT 'Descriptive title of the invention or discovery being disclosed.',
    CONSTRAINT pk_ip_disclosure PRIMARY KEY(`ip_disclosure_id`)
) COMMENT 'Master record for intellectual property disclosures generated from R&D activities — including novel sequencing chemistries, CRISPR construct innovations, bioinformatics algorithm inventions, and assay method discoveries. Captures disclosure title, disclosure date, inventors, invention type (composition of matter, method, software), associated R&D project, technology area, novelty assessment status, prior art search status, patent filing decision (file/abandon/trade secret), and assigned IP counsel. Serves as the SSOT for IP-generating discoveries originating in the research domain.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`publication` (
    `publication_id` BIGINT COMMENT 'Unique identifier for the scientific publication record.',
    `project_id` BIGINT COMMENT 'Identifier linking the publication to the associated Benchling electronic lab notebook (ELN) project where the research was documented.',
    `collaboration_agreement_id` BIGINT COMMENT 'Foreign key linking to research.collaboration_agreement. Business justification: Publications resulting from collaborations must reference the agreement for publication_rights, embargo tracking, and acknowledgment requirements. Currently publication has external_partner_name (STRI',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Publications acknowledging customer collaboration or using customer-provided data/samples. Required for publication approval workflow, IP clearance, customer acknowledgment requirements, and collabora',
    `fair_assessment_id` BIGINT COMMENT 'Foreign key linking to data.fair_assessment. Business justification: Publications require FAIR assessment of associated datasets for journal data availability requirements (Nature, Science, Cell policies) and funder mandates. Essential for manuscript submission and pee',
    `grant_id` BIGINT COMMENT 'Foreign key linking to research.grant. Business justification: Publications must acknowledge grant funding per agency requirements (NIH Public Access Policy, etc.). Currently publication has grant_number (STRING) but no FK. Adding grant_id FK allows joining to gr',
    `ip_disclosure_id` BIGINT COMMENT 'Foreign key linking to research.ip_disclosure. Business justification: Publications may disclose novel IP, and the relationship must be tracked for patent filing coordination and public disclosure date management. Currently publication has patent_application_number (STRI',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to commercial.opportunity. Business justification: Scientific publications validate technology claims and are routinely cited in commercial proposals for precision medicine and diagnostic applications. Sales teams reference peer-reviewed publications ',
    `rd_project_id` BIGINT COMMENT 'Foreign key reference to the R&D project that generated this publication.',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Publications cited as supporting evidence in regulatory submissions (literature references in 510(k), clinical evidence in PMA). Tracks which publications support which regulatory filings.',
    `document_id` BIGINT COMMENT 'Identifier linking the publication to the associated document in Veeva Vault for regulatory and quality management tracking.',
    `abstract` STRING COMMENT 'Full text of the publication abstract summarizing the research objectives, methods, results, and conclusions.',
    `acceptance_date` DATE COMMENT 'Date the manuscript was accepted for publication by the journal or conference. Null for preprints and rejected submissions.',
    `authors` STRING COMMENT 'Comma-separated list of all authors in publication order, including Genomics Biotech staff and external collaborators.',
    `citation_count` STRING COMMENT 'Number of times the publication has been cited by other scientific works, as tracked by citation databases (e.g., Google Scholar, Web of Science).',
    `collaboration_type` STRING COMMENT 'Type of collaboration that produced the publication: internal (Genomics Biotech only), academic (university partnership), industry (commercial partner), government (agency collaboration), or consortium (multi-party research network).. Valid values are `internal|academic|industry|government|consortium`',
    `conference_name` STRING COMMENT 'Name of the scientific conference where the abstract or presentation was delivered (e.g., ASHG, AGBT, AACR). Null for journal articles and preprints.',
    `corresponding_author_email` STRING COMMENT 'Email address of the corresponding author for publication inquiries.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `corresponding_author_name` STRING COMMENT 'Name of the corresponding author responsible for communication regarding the publication.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the publication record was first created in the system.',
    `data_repository_url` STRING COMMENT 'URL of the public data repository where the underlying research data is deposited (e.g., dbGaP, GEO, SRA). Null if data sharing is not required or not yet completed.',
    `data_sharing_required` BOOLEAN COMMENT 'Indicates whether the publication requires public sharing of underlying research data per journal policy, funder mandate, or NIH Genomic Data Sharing Policy (True) or not (False).',
    `doi` STRING COMMENT 'Unique Digital Object Identifier assigned to the publication for permanent citation and retrieval.. Valid values are `^10.d{4,9}/[-._;()/:A-Za-z0-9]+$`',
    `embargo_end_date` DATE COMMENT 'Date when the embargo restrictions are lifted and the publication can be publicly disclosed. Null if no embargo applies.',
    `embargo_flag` BOOLEAN COMMENT 'Indicates whether the publication is under embargo restrictions that prevent public disclosure until a specified date (True) or not (False).',
    `external_author_count` STRING COMMENT 'Number of external collaborators (non-Genomics Biotech) listed as authors on the publication.',
    `first_author_name` STRING COMMENT 'Name of the first author listed on the publication.',
    `funding_source` STRING COMMENT 'Name of the funding organization or grant that supported the research (e.g., NIH, internal R&D budget, external collaboration). Null if not applicable.',
    `impact_factor` DECIMAL(18,2) COMMENT 'Journal Impact Factor (JIF) of the journal at the time of publication, reflecting the average number of citations to recent articles. Null for conferences and preprints.',
    `internal_author_count` STRING COMMENT 'Number of Genomics Biotech employees or contractors listed as authors on the publication.',
    `ip_clearance_date` DATE COMMENT 'Date when the IP clearance review was completed and the publication was approved for submission.',
    `ip_clearance_status` STRING COMMENT 'Status of intellectual property review and clearance for the publication: pending (under review), cleared (approved for publication), restricted (requires redaction), or blocked (cannot be published).. Valid values are `pending|cleared|restricted|blocked`',
    `journal_name` STRING COMMENT 'Name of the peer-reviewed journal where the article was published (e.g., Nature, Science, Cell). Null for conference presentations and preprints.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or index terms describing the publication content for search and categorization.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the publication record was last modified in the system.',
    `open_access_classification` STRING COMMENT 'Classification of the publications open access status: gold (fully open access journal), green (self-archived), hybrid (open access option in subscription journal), bronze (free to read without license), or closed (subscription-only).. Valid values are `gold|green|hybrid|bronze|closed`',
    `preprint_server` STRING COMMENT 'Name of the preprint server where the manuscript was posted (e.g., bioRxiv, medRxiv). Null for published articles and conference presentations.. Valid values are `bioRxiv|medRxiv|arXiv|other`',
    `publication_code` STRING COMMENT 'Business-assigned unique code for tracking and referencing the publication internally.. Valid values are `^PUB-[A-Z0-9]{8,12}$`',
    `publication_date` DATE COMMENT 'Date the article was officially published online or in print, or the date the preprint was posted.',
    `publication_status` STRING COMMENT 'Current lifecycle status of the publication: draft (in preparation), submitted, under review, accepted, published, rejected, or withdrawn. [ENUM-REF-CANDIDATE: draft|submitted|under_review|accepted|published|rejected|withdrawn — 7 candidates stripped; promote to reference product]',
    `publication_type` STRING COMMENT 'Classification of the publication format: peer-reviewed journal article, conference abstract, conference presentation, preprint (bioRxiv/medRxiv), review article, or book chapter.. Valid values are `peer_reviewed_journal|conference_abstract|conference_presentation|preprint|review_article|book_chapter`',
    `pubmed_identifier` STRING COMMENT 'PubMed unique identifier for the publication in the National Library of Medicine database. Null for non-indexed publications.. Valid values are `^d{7,8}$`',
    `regulatory_submission_required` BOOLEAN COMMENT 'Indicates whether the publication is required to be included in regulatory submissions to agencies such as FDA or EMA (True) or not (False).',
    `submission_date` DATE COMMENT 'Date the manuscript was submitted to the journal, conference, or preprint server.',
    `target_indication` STRING COMMENT 'Disease, condition, or biological target that the research addresses (e.g., cancer, rare genetic disorders, agricultural genomics). Null if not applicable.',
    `technology_area` STRING COMMENT 'Primary technology or scientific domain covered by the publication: Next-Generation Sequencing (NGS), Whole Genome Sequencing (WGS), Whole Exome Sequencing (WES), array-based methods, CRISPR, gene editing, Polymerase Chain Reaction (PCR), quantitative PCR (qPCR), bioinformatics, clinical genomics, or other. [ENUM-REF-CANDIDATE: NGS|WGS|WES|array_based|CRISPR|gene_editing|PCR|qPCR|bioinformatics|clinical_genomics|other — 11 candidates stripped; promote to reference product]',
    `title` STRING COMMENT 'Full title of the scientific publication, conference presentation, or preprint.',
    CONSTRAINT pk_publication PRIMARY KEY(`publication_id`)
) COMMENT 'Tracks scientific publications, conference presentations, and preprints authored or co-authored by Genomics Biotech R&D staff — including peer-reviewed journal articles, Nature/Science/Cell publications, conference abstracts (ASHG, AGBT, AACR), and bioRxiv/medRxiv preprints. Captures title, authors, publication type, journal/conference name, submission date, acceptance date, publication date, DOI, associated R&D project, IP clearance status, embargo flag, and open-access classification. Supports publication strategy, IP protection timing, and scientific reputation management.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` (
    `trl_assessment_id` BIGINT COMMENT 'Unique identifier for the TRL assessment record. Primary key for the TRL assessment entity.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to research.grant. Business justification: TRL assessments may be required for grant reporting and milestone tracking per agency requirements. Currently trl_assessment has grant_number (STRING) but no FK. Adding grant_id FK allows joining to g',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the individual who conducted the TRL assessment. Typically a senior scientist, technical lead, or R&D manager with expertise in the technology domain.',
    `project_id` BIGINT COMMENT 'Foreign key reference to the R&D project being assessed for technology readiness. Links this TRL assessment to the parent project portfolio record.',
    `review_board_id` BIGINT COMMENT 'Foreign key reference to the governance review board or committee that approved this TRL assessment. May be a Technology Review Board, Portfolio Steering Committee, or similar governance body.',
    `technology_transfer_id` BIGINT COMMENT 'Foreign key reference to the specific technology or innovation being assessed. May reference a CRISPR construct, assay design, sequencing protocol, or other discrete technology asset.',
    `document_id` BIGINT COMMENT 'External system identifier linking this TRL assessment to the formal assessment report document stored in Veeva Vault for regulatory and quality management purposes.',
    `advancement_criteria` STRING COMMENT 'Structured description of the specific technical, regulatory, and business criteria that must be met for the technology to advance to the next TRL level. Defines the exit criteria for the current stage.',
    `approval_date` DATE COMMENT 'The date on which this TRL assessment was formally approved by the review authority. Marks the transition from draft to approved status.',
    `assessment_code` STRING COMMENT 'Business identifier for the TRL assessment. Typically follows a pattern such as TRL-PROJ123-2024Q1 to indicate project and assessment period.. Valid values are `^TRL-[A-Z0-9]{6,12}$`',
    `assessment_date` DATE COMMENT 'The date on which the TRL assessment was formally conducted and recorded. Represents the business event timestamp for this evaluation.',
    `assessment_notes` STRING COMMENT 'Additional free-text notes and observations from the TRL assessment. Captures context, concerns, recommendations, and other qualitative insights not covered in structured fields.',
    `assessment_rationale` STRING COMMENT 'Detailed narrative explanation of the TRL score assignment. Describes the evidence, achievements, and technical maturity factors that justify the assigned readiness level.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the TRL assessment record. Draft assessments are in preparation, under review assessments are pending approval, approved assessments are finalized, rejected assessments did not pass review, and superseded assessments have been replaced by newer evaluations.. Valid values are `draft|under_review|approved|rejected|superseded`',
    `assessment_type` STRING COMMENT 'The category of TRL assessment. Periodic assessments occur on a regular schedule (quarterly, annually), milestone assessments coincide with project milestones, gate reviews are formal stage-gate evaluations, and ad-hoc assessments are triggered by specific events.. Valid values are `periodic|milestone|gate_review|ad_hoc|regulatory_triggered|partner_requested`',
    `assessor_name` STRING COMMENT 'Full name of the individual who conducted the TRL assessment. Denormalized for reporting convenience.',
    `assessor_role` STRING COMMENT 'The organizational role or title of the assessor at the time of assessment (e.g., Principal Scientist, R&D Director, Technology Lead).',
    `benchling_entry_reference` STRING COMMENT 'External system identifier linking this TRL assessment to the corresponding electronic lab notebook (ELN) entry in Benchling where detailed assessment notes and evidence are stored.',
    `collaboration_partner` STRING COMMENT 'Name of external organization(s) collaborating on this technology development, if applicable. May include academic institutions, contract research organizations, or commercial partners.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this TRL assessment record was first created in the data system. Used for audit trail and data lineage tracking.',
    `estimated_commercialization_date` DATE COMMENT 'Projected date when this technology is expected to reach commercial launch readiness (TRL 9). Subject to revision based on development progress and gate review outcomes.',
    `evidence_artifacts` STRING COMMENT 'Comma-separated list or structured reference to supporting evidence documents, experimental results, validation reports, or other artifacts that substantiate the TRL score. May include Benchling ELN entry IDs, Veeva document IDs, or file paths.',
    `funding_source` STRING COMMENT 'Primary source of funding for this technology development. May be internal R&D budget, government grants (NIH, NSF, DARPA), SBIR/STTR programs, venture capital, or strategic partner funding. [ENUM-REF-CANDIDATE: internal|nih_grant|nsf_grant|darpa|sbir|sttr|venture_capital|strategic_partner|mixed — 9 candidates stripped; promote to reference product]',
    `gate_decision_rationale` STRING COMMENT 'Narrative explanation of the gate review decision. Captures the strategic, technical, and business reasoning behind the proceed/hold/terminate decision.',
    `gate_review_outcome` STRING COMMENT 'The formal decision outcome from the stage-gate review associated with this TRL assessment. Proceed indicates approval to continue, conditional proceed requires specific actions before continuation, hold pauses the project, terminate ends the project, and pivot indicates a strategic redirection.. Valid values are `proceed|conditional_proceed|hold|terminate|pivot`',
    `gxp_applicable` BOOLEAN COMMENT 'Boolean flag indicating whether Good Practice regulations (GMP, GLP, GCP) apply to this technology development. True for regulated products, false for pure research applications.',
    `ip_status` STRING COMMENT 'Current intellectual property protection status for this technology. Tracks whether IP has been disclosed, patent applications filed, patents granted, or if the technology is protected as trade secret. [ENUM-REF-CANDIDATE: no_ip|invention_disclosure_filed|patent_pending|patent_granted|trade_secret|licensed_in|licensed_out — 7 candidates stripped; promote to reference product]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording the most recent modification to this TRL assessment record. Enables change tracking and audit compliance.',
    `next_assessment_planned_date` DATE COMMENT 'The scheduled date for the next TRL assessment of this technology. Enables proactive portfolio management and stage-gate planning.',
    `next_trl_target` STRING COMMENT 'The target TRL score for the next assessment cycle or milestone. Represents the planned maturation trajectory for the technology.',
    `patent_application_number` STRING COMMENT 'The official patent application number(s) associated with this technology, if applicable. May include provisional, PCT, or national phase application numbers.',
    `prior_trl_score` STRING COMMENT 'The TRL score from the previous assessment cycle, enabling tracking of technology maturation progress over time.',
    `regulatory_pathway` STRING COMMENT 'The anticipated regulatory approval pathway for this technology. FDA 510(k) is for moderate-risk devices, PMA for high-risk devices, De Novo for novel low-to-moderate risk devices, CE-IVD for European in vitro diagnostics, RUO for research use only, LDT for laboratory developed tests, and TBD for undetermined pathways. [ENUM-REF-CANDIDATE: fda_510k|fda_pma|fda_de_novo|eu_ce_ivd|ruo|ldt|exempt|tbd — 8 candidates stripped; promote to reference product]',
    `regulatory_submission_required` BOOLEAN COMMENT 'Boolean flag indicating whether this technology will require formal regulatory submission and approval before commercialization. True for IVD and clinical products, false for RUO products.',
    `risk_assessment_summary` STRING COMMENT 'Summary of technical, regulatory, commercial, and operational risks identified during the TRL assessment. Highlights key risk factors that may impact technology maturation.',
    `strategic_priority` STRING COMMENT 'Business priority level assigned to this technology within the R&D portfolio. Critical technologies receive highest resource allocation and executive attention.. Valid values are `critical|high|medium|low`',
    `target_market_segment` STRING COMMENT 'The intended commercial market segment for this technology. Defines the primary customer base and application domain. [ENUM-REF-CANDIDATE: clinical_diagnostics|research_genomics|agricultural_genomics|pharma_drug_discovery|precision_medicine|population_health|forensics|other — 8 candidates stripped; promote to reference product]',
    `trl_score` STRING COMMENT 'The TRL rating assigned during this assessment, on the standard 1-9 scale. TRL 1-3 represent basic research, TRL 4-5 proof-of-concept, TRL 6-7 prototype validation, and TRL 8-9 production readiness.',
    CONSTRAINT pk_trl_assessment PRIMARY KEY(`trl_assessment_id`)
) COMMENT 'Periodic Technology Readiness Level (TRL) assessments for R&D projects and technologies — capturing the TRL scale rating (1-9), assessment date, assessor, assessment rationale, evidence artifacts referenced, advancement criteria for next TRL, and gate review outcome. Enables structured portfolio stage-gating from basic research (TRL 1-3) through proof-of-concept (TRL 4-5) to product development readiness (TRL 6-9). Distinct from milestone records — TRL assessments are formal periodic evaluations, not binary completion events.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`grant` (
    `grant_id` BIGINT COMMENT 'Unique identifier for the research grant record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Grants execute through specific cost centers for financial tracking, compliance reporting, and reconciliation with funding agency requirements. Standard practice in biotech grant management for NIH/NS',
    `employee_id` BIGINT COMMENT 'Unique identifier of the Principal Investigator (PI) responsible for the scientific and technical direction of the grant. Links to workforce or researcher master data.',
    `grant_principal_investigator_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to commercial.opportunity. Business justification: Government/foundation grants (NIH SBIR/STTR, NSF, Gates Foundation) fund early-stage genomics R&D that becomes commercial product. Opportunities reference grant-funded work for regulatory submissions ',
    `actual_spend_usd` DECIMAL(18,2) COMMENT 'Cumulative actual expenditures charged to the grant to date, in United States Dollars (USD). Sourced from SAP Financial Accounting (FI) module.',
    `application_submission_date` DATE COMMENT 'Date the grant application was submitted to the funding agency.',
    `associated_rd_project_ids` STRING COMMENT 'Comma-separated list of internal R&D project IDs that are funded or supported by this grant. Links grant funding to specific research initiatives tracked in Benchling and the research.project data product.',
    `award_date` DATE COMMENT 'Date the grant was officially awarded by the funding agency. This is the principal business event timestamp for the grant lifecycle.',
    `award_type` STRING COMMENT 'Classification of the grant mechanism (e.g., R01 Research Project Grant, R21 Exploratory/Developmental Research Grant, R43/R44 Small Business Innovation Research (SBIR), U01 Research Project Cooperative Agreement, contract, philanthropic grant). [ENUM-REF-CANDIDATE: R01|R21|R43|R44|U01|U54|P01|P50|contract|cooperative_agreement|philanthropic — 11 candidates stripped; promote to reference product]',
    `co_investigator_names` STRING COMMENT 'Comma-separated list of co-investigator names contributing to the grant project.',
    `compliance_obligations` STRING COMMENT 'Summary of key compliance requirements attached to this grant (e.g., NIH Genomic Data Sharing Policy, HIPAA compliance, IRB oversight, animal welfare assurance, export control restrictions).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this grant record was first created in the system.',
    `current_budget_period_amount_usd` DECIMAL(18,2) COMMENT 'Funding amount for the current budget period in United States Dollars (USD).',
    `current_budget_period_end_date` DATE COMMENT 'End date of the current budget period. Triggers annual progress reporting and continuation application requirements.',
    `current_budget_period_start_date` DATE COMMENT 'Start date of the current budget period (typically one year for multi-year grants). Used for annual funding increments.',
    `data_sharing_required` BOOLEAN COMMENT 'Indicates whether the grant requires submission of research data to public repositories per NIH Genomic Data Sharing Policy or other funder mandates. True if data sharing is required, False otherwise.',
    `direct_costs_usd` DECIMAL(18,2) COMMENT 'Total direct costs portion of the grant award in United States Dollars (USD). Excludes indirect costs (Facilities and Administrative costs).',
    `final_report_due_date` DATE COMMENT 'Due date for the final technical and financial report, typically 90 days after project period end date.',
    `funding_agency` STRING COMMENT 'Name of the organization providing the grant funding (e.g., National Institutes of Health, Biomedical Advanced Research and Development Authority, National Science Foundation, European Commission, Bill & Melinda Gates Foundation).',
    `funding_agency_division` STRING COMMENT 'Specific division, institute, or program within the funding agency (e.g., National Human Genome Research Institute (NHGRI), National Cancer Institute (NCI), NSF Division of Biological Infrastructure).',
    `grant_number` STRING COMMENT 'Official grant number assigned by the funding agency (e.g., NIH R01-123456, BARDA HHSO100201700001C, NSF DBI-1234567, EU Horizon 101012345). This is the externally-known unique identifier for the grant.',
    `grant_status` STRING COMMENT 'Current lifecycle status of the grant. Pending: application submitted, awaiting decision. Active: grant awarded and project period is current. Suspended: temporarily halted by agency or institution. Closed: project period completed, final reporting submitted. Terminated: grant ended prematurely.. Valid values are `pending|active|suspended|closed|terminated`',
    `iacuc_approval_number` STRING COMMENT 'IACUC approval number if the grant involves animal research. Required for compliance with Animal Welfare Act and PHS Policy.',
    `indirect_cost_rate_percent` DECIMAL(18,2) COMMENT 'Negotiated indirect cost rate (Facilities and Administrative rate) applied to the grant, expressed as a percentage of direct costs.',
    `indirect_costs_usd` DECIMAL(18,2) COMMENT 'Total indirect costs (Facilities and Administrative costs) portion of the grant award in United States Dollars (USD).',
    `irb_approval_number` STRING COMMENT 'IRB approval number if the grant involves human subjects research. Required for compliance tracking and audit readiness.',
    `last_report_submission_date` DATE COMMENT 'Date the most recent progress or financial report was submitted to the funding agency.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this grant record was last modified.',
    `next_report_due_date` DATE COMMENT 'Due date for the next scheduled progress or financial report to the funding agency. Used for compliance tracking and alert generation.',
    `patent_count` STRING COMMENT 'Number of patent applications or issued patents resulting from this grant. Required for Intellectual Property (IP) reporting to federal funders under Bayh-Dole Act.',
    `program_officer_email` STRING COMMENT 'Email address of the program officer for grant-related communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `program_officer_name` STRING COMMENT 'Name of the program officer or grants management specialist assigned to oversee this grant at the funding agency.',
    `project_period_end_date` DATE COMMENT 'End date of the total project period for which funding is approved. Marks the effective-until date of the grant agreement.',
    `project_period_start_date` DATE COMMENT 'Start date of the total project period for which funding is approved. Marks the effective-from date of the grant agreement.',
    `publication_count` STRING COMMENT 'Number of peer-reviewed publications resulting from this grant. Used for impact assessment and reporting to funding agency.',
    `remaining_balance_usd` DECIMAL(18,2) COMMENT 'Remaining unspent balance of the grant award in United States Dollars (USD). Calculated as total_award_amount_usd minus actual_spend_usd.',
    `reporting_schedule` STRING COMMENT 'Frequency of required progress reports to the funding agency (e.g., annual Research Performance Progress Report (RPPR), semi-annual technical reports, quarterly financial reports).. Valid values are `annual|semi_annual|quarterly|final_only`',
    `sap_grant_fund_code` STRING COMMENT 'SAP fund code or grant account code used to segregate grant financial transactions in the general ledger.',
    `sap_wbs_element` STRING COMMENT 'SAP Project System (PS) Work Breakdown Structure (WBS) element code used for financial tracking and cost allocation of grant expenditures.',
    `sponsoring_business_unit` STRING COMMENT 'Internal business unit or department at Genomics Biotech that is the institutional home for this grant (e.g., Research and Development, Clinical Genomics, Bioinformatics).',
    `title` STRING COMMENT 'Full title of the research grant as submitted to and approved by the funding agency.',
    `total_award_amount_usd` DECIMAL(18,2) COMMENT 'Total funding amount awarded for the entire project period, including direct and indirect costs, in United States Dollars (USD).',
    `veeva_document_reference` STRING COMMENT 'Reference to the grant agreement document, award notice, and related regulatory documents stored in Veeva Vault Quality Management System.',
    CONSTRAINT pk_grant PRIMARY KEY(`grant_id`)
) COMMENT 'Master record for external research grants awarded to or applied for by Genomics Biotech — including NIH R01/R21/SBIR grants, BARDA contracts, NSF awards, EU Horizon grants, and philanthropic research funding. Captures grant title, funding agency, grant number, program officer, award type, application submission date, award date, total award amount, indirect cost rate, project period start/end, reporting requirements (RPPR schedule, final report deadlines), compliance obligations (NIH Genomic Data Sharing Policy), report submission tracking (type, period, due date, submission status, key findings), and associated R&D projects. Enables grant portfolio management, compliance tracking, and audit readiness for federally funded research.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`grant_report` (
    `grant_report_id` BIGINT COMMENT 'Unique identifier for the grant report submission record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Grant reports must reference the cost center where grant funds were spent for financial reconciliation with funding agencies (NIH, NSF) and indirect cost rate validation.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to research.grant. Business justification: Grant reports are submitted FOR specific grants. Currently grant_report has grant_number (STRING) but no FK to grant table. This is a clear parent-child relationship (N:1). Adding grant_id FK allows j',
    `project_id` BIGINT COMMENT 'Foreign key reference to the R&D project associated with this grant report.',
    `document_id` BIGINT COMMENT 'The unique document identifier in Veeva Vault where the grant report and supporting documentation are stored.',
    `actual_expenditure_usd` DECIMAL(18,2) COMMENT 'The actual amount of grant funds expended during the reporting period in US dollars.',
    `actual_submission_date` DATE COMMENT 'The actual date on which the grant report was submitted to the funding agency.',
    `agency_acknowledgment_date` DATE COMMENT 'The date on which the funding agency formally acknowledged receipt and acceptance of the grant report.',
    `agency_acknowledgment_reference` STRING COMMENT 'The reference number or confirmation code provided by the funding agency upon acknowledgment of the report submission.',
    `agency_program_officer` STRING COMMENT 'The name of the program officer or grants management specialist at the funding agency responsible for this grant.',
    `audit_ready` BOOLEAN COMMENT 'Indicates whether all supporting documentation and records are complete and organized for potential agency audit.',
    `budget_expenditure_summary` STRING COMMENT 'A narrative summary of how grant funds were expended during the reporting period, including major cost categories and variances from the approved budget.',
    `budget_variance_usd` DECIMAL(18,2) COMMENT 'The difference between allocated budget and actual expenditure for the reporting period (positive = under budget, negative = over budget).',
    `compliance_issues_description` STRING COMMENT 'Detailed description of any compliance issues identified, including corrective actions taken or planned.',
    `compliance_issues_identified` BOOLEAN COMMENT 'Indicates whether any compliance issues (regulatory, financial, or ethical) were identified during the reporting period.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this grant report record was first created in the system.',
    `data_sharing_compliance` STRING COMMENT 'Status of compliance with NIH Genomic Data Sharing Policy and other data sharing requirements specified in the grant terms.. Valid values are `compliant|non_compliant|not_applicable|in_progress`',
    `equipment_costs_usd` DECIMAL(18,2) COMMENT 'Total equipment and capital expenditure costs charged to the grant during the reporting period.',
    `funding_agency` STRING COMMENT 'The name of the government or private agency providing grant funding (e.g., NIH, NSF, DOE, private foundation).',
    `indirect_costs_usd` DECIMAL(18,2) COMMENT 'Total indirect costs (facilities and administrative costs) charged to the grant during the reporting period.',
    `irb_approval_status` STRING COMMENT 'Current status of IRB approval for human subjects research conducted under this grant during the reporting period.. Valid values are `approved|pending|not_required|expired|suspended`',
    `key_findings_summary` STRING COMMENT 'A narrative summary of the key scientific findings, discoveries, and accomplishments achieved during the reporting period.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this grant report record was last modified in the system.',
    `milestone_achievement_status` STRING COMMENT 'Overall status of milestone achievement relative to the grant proposal timeline and objectives.. Valid values are `on_track|ahead_of_schedule|delayed|at_risk|completed`',
    `milestones_completed_count` STRING COMMENT 'The number of planned milestones that were successfully completed during the reporting period.',
    `milestones_planned_count` STRING COMMENT 'The total number of milestones that were planned for completion during the reporting period.',
    `next_report_due_date` DATE COMMENT 'The due date for the next scheduled grant report submission to the funding agency.',
    `other_direct_costs_usd` DECIMAL(18,2) COMMENT 'Total other direct costs (travel, publication fees, consultant fees, etc.) charged to the grant during the reporting period.',
    `patent_applications_count` STRING COMMENT 'The number of patent applications filed based on intellectual property generated during the reporting period.',
    `personnel_costs_usd` DECIMAL(18,2) COMMENT 'Total personnel costs (salaries, wages, fringe benefits) charged to the grant during the reporting period.',
    `principal_investigator_name` STRING COMMENT 'The name of the principal investigator responsible for the grant-funded research project.',
    `publications_count` STRING COMMENT 'The number of peer-reviewed publications resulting from the grant-funded research during the reporting period.',
    `report_approved_by` STRING COMMENT 'The name of the individual who reviewed and approved the grant report for submission (typically PI or authorized institutional official).',
    `report_prepared_by` STRING COMMENT 'The name of the individual who prepared the grant report (may be PI, project manager, or grants administrator).',
    `report_type` STRING COMMENT 'The type of grant report being submitted. RPPR = Research Performance Progress Report (NIH annual progress report). [ENUM-REF-CANDIDATE: annual_progress|rppr|sbir_phase_i|sbir_phase_ii|final_technical|interim_progress|financial_status|closeout — 8 candidates stripped; promote to reference product]',
    `reporting_period_end_date` DATE COMMENT 'The end date of the reporting period covered by this grant report.',
    `reporting_period_start_date` DATE COMMENT 'The start date of the reporting period covered by this grant report.',
    `submission_due_date` DATE COMMENT 'The deadline by which the grant report must be submitted to the funding agency.',
    `submission_status` STRING COMMENT 'The current status of the grant report submission in the agency review workflow. [ENUM-REF-CANDIDATE: draft|submitted|acknowledged|under_review|accepted|rejected|revision_requested — 7 candidates stripped; promote to reference product]',
    `supplies_costs_usd` DECIMAL(18,2) COMMENT 'Total costs for laboratory supplies, reagents, and consumables charged to the grant during the reporting period.',
    `total_budget_allocated_usd` DECIMAL(18,2) COMMENT 'The total grant budget amount allocated for the reporting period in US dollars.',
    CONSTRAINT pk_grant_report PRIMARY KEY(`grant_report_id`)
) COMMENT 'Tracks mandatory progress and financial reports submitted to grant funding agencies — including NIH annual progress reports (RPPRs), SBIR Phase I/II reports, and final technical reports. Captures report type, reporting period, submission due date, actual submission date, submission status, key findings summary, milestone achievement status, budget expenditure summary, and agency acknowledgment. Ensures compliance with grant terms and conditions and supports audit readiness for federally funded research.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`research_budget` (
    `research_budget_id` BIGINT COMMENT 'Unique identifier for the R&D budget record. Primary key.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: R&D budgets must reconcile with corporate finance budgets for consolidated planning, variance analysis, and board-level financial reporting. Critical for integrated business planning in genomics compa',
    `grant_id` BIGINT COMMENT 'Reference to the grant record if this budget is funded by an external grant (e.g., NIH, NSF, European Commission), enabling grant budget tracking and compliance reporting.',
    `employee_id` BIGINT COMMENT 'Reference to the employee responsible for managing and monitoring this budget allocation, typically the project manager or principal investigator.',
    `primary_research_employee_id` BIGINT COMMENT 'Reference to the employee or executive who approved this budget allocation, supporting audit trail and accountability.',
    `program_id` BIGINT COMMENT 'Reference to the parent R&D program under which this budget is allocated, enabling program-level budget rollup and portfolio analysis.',
    `project_id` BIGINT COMMENT 'Reference to the R&D project to which this budget allocation applies. Links to the research.project product.',
    `amount` DECIMAL(18,2) COMMENT 'Approved budget amount in the specified currency for this allocation, representing the planned expenditure baseline for budget vs. actuals variance analysis.',
    `amount_usd` DECIMAL(18,2) COMMENT 'Budget amount converted to USD using the exchange rate at the time of budget approval, enabling consolidated reporting and cross-currency comparison.',
    `approval_date` DATE COMMENT 'Date on which this budget allocation was formally approved by the approving authority, establishing the baseline for budget vs. actuals tracking.',
    `approved_by_name` STRING COMMENT 'Full name of the approving authority for this budget allocation, providing human-readable reference for reporting and audit purposes.',
    `approving_authority_level` STRING COMMENT 'Organizational level of the approving authority, reflecting the governance tier required for this budget allocation based on amount and strategic importance.. Valid values are `project_manager|program_director|vp_research|cfo|ceo|board`',
    `budget_code` STRING COMMENT 'Externally-known unique code identifying this budget allocation, used for cross-system reference and financial reporting.. Valid values are `^RDB-[A-Z0-9]{6,12}$`',
    `budget_name` STRING COMMENT 'Human-readable name or title of the budget allocation, typically reflecting the project or program name and fiscal period.',
    `budget_status` STRING COMMENT 'Current approval and lifecycle status of the budget allocation, controlling whether the budget is editable or locked for actuals comparison.. Valid values are `draft|submitted|under_review|approved|rejected|locked`',
    `business_unit` STRING COMMENT 'Business unit or division sponsoring this budget allocation, enabling portfolio-level budget analysis by organizational segment (e.g., Sequencing, Clinical Genomics, Gene Editing).',
    `capitalization_eligible` BOOLEAN COMMENT 'Indicates whether this budget allocation is eligible for R&D capitalization under accounting standards (e.g., IAS 38, ASC 985), supporting P&L vs. balance sheet treatment planning.',
    `capitalization_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of the budget amount that is planned to be capitalized as an intangible asset, based on the project phase and accounting policy.',
    `collaboration_type` STRING COMMENT 'Type of collaboration model for this budget allocation: internal (fully internal R&D), external_partner (co-development with partner), grant_funded (NIH, NSF, or other grant), consortium (multi-party research consortium), or contract_research (CRO-executed work).. Valid values are `internal|external_partner|grant_funded|consortium|contract_research`',
    `cost_category` STRING COMMENT 'High-level classification of the budget allocation by type of expenditure: personnel (FTE salaries and benefits), external services (CRO, consulting), materials (reagents, consumables), equipment (instruments, lab hardware), compute (cloud HPC, bioinformatics infrastructure), facilities (lab space, utilities), travel (conferences, site visits), or other. [ENUM-REF-CANDIDATE: personnel|external_services|materials|equipment|compute|facilities|travel|other — 8 candidates stripped; promote to reference product]',
    `cost_center_code` STRING COMMENT 'Cost center code in the ERP system to which this budget is allocated, supporting departmental and organizational budget tracking.. Valid values are `^CC-[A-Z0-9]{4,8}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was first created in the system, supporting audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amount, supporting multi-currency budget planning for global R&D operations.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date on which this budget allocation expires and no further spending can be charged, supporting budget period control and year-end close processes.',
    `effective_start_date` DATE COMMENT 'Date from which this budget allocation becomes effective and spending can be charged against it, supporting multi-year budget planning and phased project funding.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert the budget amount from the local currency to USD, captured at the time of budget approval for consistent financial reporting.',
    `external_partner_name` STRING COMMENT 'Name of the external partner organization (academic institution, biotech company, CRO) if this budget supports a collaborative R&D effort.',
    `fiscal_period` STRING COMMENT 'The fiscal period within the fiscal year (e.g., Q1, Q2, H1, M01) for which this budget is allocated, supporting quarterly and monthly budget planning.. Valid values are `^(Q[1-4]|H[1-2]|FY|M(0[1-9]|1[0-2]))$`',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this budget allocation applies, enabling year-over-year budget trend analysis.',
    `gl_account_code` STRING COMMENT 'General ledger account code in the ERP system (SAP S/4HANA FI/CO) to which this budget allocation maps, enabling integration with financial reporting and P&L forecasting.. Valid values are `^[0-9]{4,10}$`',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this budget record, supporting audit trail and accountability for budget changes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was last modified, supporting change tracking and audit trail for budget revisions.',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context about this budget allocation, such as assumptions, constraints, or special conditions.',
    `strategic_priority` STRING COMMENT 'Strategic importance classification of this budget allocation, reflecting alignment with corporate strategy and influencing budget reallocation decisions during planning cycles.. Valid values are `critical|high|medium|low`',
    `technology_area` STRING COMMENT 'Technology domain or platform to which this budget is allocated (e.g., NGS, Array, CRISPR, qPCR, Bioinformatics), supporting technology portfolio budget analysis.',
    `variance_threshold_amount` DECIMAL(18,2) COMMENT 'Acceptable variance threshold as an absolute amount in the budget currency, providing an alternative or complementary control to the percentage threshold.',
    `variance_threshold_percent` DECIMAL(18,2) COMMENT 'Acceptable variance threshold as a percentage of the budget amount, beyond which budget overruns or underruns trigger alerts and require management review.',
    `version` STRING COMMENT 'Version of the budget reflecting planning lifecycle stage: initial (first submission), revised (mid-year adjustment), final (approved baseline), forecast (forward projection), or reforecast (updated projection).. Valid values are `initial|revised|final|forecast|reforecast`',
    `wbs_element` STRING COMMENT 'SAP S/4HANA Project System (PS) WBS element code linking this budget to the project structure, enabling project-level budget rollup and variance analysis.. Valid values are `^WBS-[A-Z0-9]{6,12}$`',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this budget record, supporting audit trail and accountability.',
    CONSTRAINT pk_research_budget PRIMARY KEY(`research_budget_id`)
) COMMENT 'Annual and multi-year R&D budget plans at the project and program level — capturing approved budget amounts by cost category (personnel, external services, materials, equipment, compute), fiscal year, budget version (initial, revised, final), approval date, approving authority, and variance thresholds. Distinct from rd_spend (actuals) — this is the planned budget baseline enabling budget vs. actuals analysis. Supports R&D capitalization planning and P&L forecasting for the research portfolio.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`molecular_design` (
    `molecular_design_id` BIGINT COMMENT 'Unique identifier for the molecular design artifact. Primary key for the molecular design entity.',
    `gene_model_id` BIGINT COMMENT 'Foreign key linking to reference.gene_model. Business justification: Molecular designs target specific genes; linking to canonical gene model ensures design accuracy, annotation consistency, and replaces denormalized target_gene text with structured reference to HGNC/E',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Molecular designs (oligos, probes, guides, primers) require genome build for coordinate validation, specificity checking, and manufacturing specifications. Essential for design accuracy and reproducib',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the principal investigator or lead scientist responsible for this molecular design.',
    `project_id` BIGINT COMMENT 'Foreign key reference to the R&D project under which this molecular design was created.',
    `benchling_entity_reference` STRING COMMENT 'Unique identifier of the molecular design entity within the Benchling Electronic Lab Notebook (ELN) system for cross-system traceability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this molecular design record was first created in the data system.',
    `design_algorithm_version` STRING COMMENT 'Version number of the design tool or algorithm used, enabling reproducibility and traceability of design methodology.',
    `design_code` STRING COMMENT 'Unique alphanumeric code or identifier assigned to the molecular design for tracking and cataloging purposes.',
    `design_name` STRING COMMENT 'Human-readable name assigned to the molecular design artifact for identification and reference purposes.',
    `design_rationale` STRING COMMENT 'Scientific justification and reasoning behind the molecular design choices, including biological objectives and design constraints.',
    `design_status` STRING COMMENT 'Current lifecycle status of the molecular design indicating its readiness for use in experiments or production.. Valid values are `draft|in_review|approved|validated|deprecated|archived`',
    `design_tool` STRING COMMENT 'Name of the computational tool, algorithm, or software platform used to generate or optimize this molecular design.',
    `design_type` STRING COMMENT 'Classification of the molecular design artifact by its biological construct type.. Valid values are `plasmid|oligo|gRNA|primer|gene_fragment|expression_vector`',
    `expiration_date` DATE COMMENT 'Date after which the molecular construct may no longer be suitable for use due to degradation or stability concerns.',
    `gc_content_percent` DECIMAL(18,2) COMMENT 'Percentage of guanine and cytosine nucleotides in the sequence, an important parameter for PCR efficiency and stability.',
    `genomic_coordinates` STRING COMMENT 'Precise genomic coordinates of the target region in standard format (e.g., chr:start-end) based on reference genome assembly.',
    `intended_application` STRING COMMENT 'Planned experimental or therapeutic application for this molecular design, such as gene editing, expression, or diagnostic use.',
    `ip_disclosure_date` DATE COMMENT 'Date when the intellectual property disclosure was filed for this molecular design.',
    `ip_status` STRING COMMENT 'Current intellectual property protection status of the molecular design, indicating whether it is subject to patent protection or disclosure.. Valid values are `not_protected|disclosure_filed|patent_pending|patented`',
    `melting_temperature_celsius` DECIMAL(18,2) COMMENT 'Calculated melting temperature (Tm) of the oligonucleotide or primer in degrees Celsius, critical for PCR and hybridization protocols.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this molecular design record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this molecular design record was last modified in the data system.',
    `off_target_score` DECIMAL(18,2) COMMENT 'Computational score assessing the risk of unintended off-target effects or non-specific binding, with lower scores indicating higher specificity.',
    `on_target_efficiency_score` DECIMAL(18,2) COMMENT 'Predicted or measured efficiency score indicating the likelihood of the design achieving its intended on-target effect, typically expressed as a percentage or normalized score.',
    `organism_strain` STRING COMMENT 'Specific strain, cell line, or variant of the target organism for which this design is optimized.',
    `patent_reference` STRING COMMENT 'Patent application number or granted patent number associated with this molecular design for IP tracking purposes.',
    `qc_method` STRING COMMENT 'Analytical method used for quality control verification, such as Sanger sequencing, NGS verification, or mass spectrometry.',
    `quality_control_status` STRING COMMENT 'Result of quality control testing performed on the synthesized molecular construct to verify sequence accuracy and purity.. Valid values are `pending|passed|failed|not_applicable`',
    `regulatory_classification` STRING COMMENT 'Regulatory classification of the molecular design indicating its intended use category: Research Use Only (RUO), In Vitro Diagnostic (IVD), Good Manufacturing Practice (GMP), or clinical grade.. Valid values are `RUO|IVD|GMP|clinical_grade|not_applicable`',
    `sequence_data_reference` STRING COMMENT 'Reference identifier or URI pointing to the nucleotide or amino acid sequence data stored in Benchling or external sequence repository.',
    `sequence_length_bp` STRING COMMENT 'Total length of the molecular design sequence measured in base pairs for DNA/RNA constructs.',
    `species` STRING COMMENT 'Biological species for which this molecular design is intended, using standard taxonomic nomenclature.',
    `storage_location` STRING COMMENT 'Physical location where the synthesized molecular construct is stored, such as freezer location, shelf, or box identifier.',
    `storage_temperature_celsius` DECIMAL(18,2) COMMENT 'Recommended or actual storage temperature for the molecular construct in degrees Celsius to maintain stability.',
    `synthesis_date` DATE COMMENT 'Date when the physical synthesis or manufacturing of the molecular construct was completed.',
    `synthesis_method` STRING COMMENT 'Technical method or platform used for synthesizing the molecular construct, such as solid-phase synthesis, gene synthesis, or PCR amplification.',
    `synthesis_vendor` STRING COMMENT 'Name of the external vendor or internal facility that synthesized or manufactured the molecular construct.',
    `target_locus` STRING COMMENT 'Specific genomic locus or chromosomal location targeted by this molecular design, typically in standard genomic coordinate format.',
    `validation_date` DATE COMMENT 'Date when experimental validation of the molecular design was completed and results were confirmed.',
    `validation_status` STRING COMMENT 'Current status of experimental validation indicating whether the design has been tested and confirmed to function as intended.. Valid values are `not_validated|in_validation|validated|failed_validation`',
    `veeva_document_reference` STRING COMMENT 'Reference identifier to the associated regulatory or quality documentation stored in Veeva Vault system.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this molecular design record in the system.',
    CONSTRAINT pk_molecular_design PRIMARY KEY(`molecular_design_id`)
) COMMENT 'Master entity for molecular biology design artifacts created in Benchling — including plasmid maps, oligo sequences, primer designs, gRNA designs, gene synthesis constructs, and expression vector configurations. Captures design name, design type (plasmid, oligo, gRNA, gene fragment), sequence data reference (Benchling entity ID), target gene or locus, design tool/algorithm used, design status (draft, reviewed, approved, deprecated), associated experiment or CRISPR construct, and IP flag. Serves as the molecular design registry bridging Benchling ELN with the broader research data model.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` (
    `notebook_entry_id` BIGINT COMMENT 'Unique identifier for the electronic lab notebook entry. Primary key for the notebook_entry product.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_asset. Business justification: ELN entries document instrument usage for audit trails and data integrity (21 CFR Part 11). Links observations to instrument qualification/calibration status. Removes denormalized serial_number field.',
    `bioinformatics_pipeline_run_id` BIGINT COMMENT 'Foreign key linking to bioinformatics.pipeline_run. Business justification: ELN entries document bioinformatics analysis results, variant interpretation, and QC review decisions. Required for GxP data integrity, audit trails, and regulatory inspection readiness. Scientists an',
    `deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: ELN entries document protocol deviations in real-time as required by GxP. Links contemporaneous documentation to formal deviation investigations, ensuring data integrity and regulatory compliance in g',
    `experiment_id` BIGINT COMMENT 'Reference to the parent experiment that this notebook entry documents. Links the entry to the broader experimental context.',
    `extraction_id` BIGINT COMMENT 'Foreign key linking to sample.extraction. Business justification: ELN entries document extraction procedures, observations, and results. Linking entries to extractions provides complete experimental provenance, supports GxP data integrity requirements, enables extra',
    `batch_id` BIGINT COMMENT 'Reference to the LIMS sample batch associated with the experimental work documented in this entry, enabling traceability to physical samples.',
    `employee_id` BIGINT COMMENT 'Reference to the scientist or researcher who created this notebook entry. Primary author responsible for the scientific content.',
    `project_id` BIGINT COMMENT 'Reference to the R&D project under which this notebook entry was created. Enables project-level aggregation of scientific records.',
    `research_protocol_id` BIGINT COMMENT 'Reference to the Standard Operating Procedure (SOP) or experimental protocol that was executed and documented in this entry.',
    `reviewer_employee_id` BIGINT COMMENT 'Reference to the scientist, supervisor, or quality assurance (QA) personnel who reviewed and approved this entry.',
    `document_id` BIGINT COMMENT 'Reference to the corresponding document in Veeva Vault regulatory document management system, if this entry has been formalized into a controlled document.',
    `author_name` STRING COMMENT 'Full name of the scientist or researcher who authored this notebook entry. Denormalized for reporting convenience.',
    `benchling_entry_reference` STRING COMMENT 'Unique identifier for this entry in the Benchling Electronic Lab Notebook (ELN) system. Provides traceability to the source system of record.',
    `collaboration_partner` STRING COMMENT 'Name of the external research institution, academic partner, or contract research organization (CRO) involved in the work documented in this entry.',
    `content_summary` STRING COMMENT 'Brief summary or abstract of the scientific content documented in this notebook entry, providing context for search and discovery.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this notebook entry record was first created in the Benchling ELN system. System audit field for data lineage.',
    `data_artifact_reference` STRING COMMENT 'Reference to associated data files, images, sequencing data (FASTQ, BAM, VCF), or other digital artifacts linked to this notebook entry.',
    `data_integrity_signature` STRING COMMENT 'Cryptographic signature or hash ensuring the integrity and non-repudiation of the notebook entry content, required for 21 CFR Part 11 compliance.',
    `entry_code` STRING COMMENT 'Human-readable business identifier for the notebook entry, often following a lab-specific numbering convention.',
    `entry_date` DATE COMMENT 'Date when the scientific observation or experimental work documented in this entry was performed. Represents the real-world event timestamp, distinct from system audit timestamps.',
    `entry_status` STRING COMMENT 'Current lifecycle status of the notebook entry in the review and approval workflow.. Valid values are `draft|submitted|under_review|approved|archived`',
    `entry_type` STRING COMMENT 'Classification of the notebook entry indicating the nature of the scientific record: observation, experimental result, protocol execution, data analysis, hypothesis formulation, or conclusion.. Valid values are `observation|result|protocol_execution|data_analysis|hypothesis|conclusion`',
    `gxp_applicable` BOOLEAN COMMENT 'Flag indicating whether this notebook entry is subject to Good Practice (GxP) regulations including Good Manufacturing Practice (GMP), Good Laboratory Practice (GLP), or Good Clinical Practice (GCP).',
    `ip_classification` STRING COMMENT 'Classification of the intellectual property sensitivity of the documented work, determining access controls and disclosure restrictions.. Valid values are `public|internal|confidential|trade_secret`',
    `ip_disclosure_filed` BOOLEAN COMMENT 'Flag indicating whether an invention disclosure or patent application has been filed based on the work documented in this entry.',
    `irb_approval_number` STRING COMMENT 'IRB approval number if the documented work involves human subjects research, ensuring ethical compliance.',
    `lab_location` STRING COMMENT 'Physical laboratory or facility location where the documented experimental work was performed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this notebook entry record was last modified in the Benchling ELN system. System audit field for change tracking.',
    `observation_text` STRING COMMENT 'Detailed narrative text of the scientific observation, experimental procedure, or data interpretation recorded by the scientist.',
    `patent_reference` STRING COMMENT 'Reference number of the patent application or granted patent associated with the work documented in this entry.',
    `phi_involved` BOOLEAN COMMENT 'Flag indicating whether this entry contains Protected Health Information (PHI) subject to Health Insurance Portability and Accountability Act (HIPAA) regulations.',
    `protocol_version` STRING COMMENT 'Version identifier of the protocol or SOP that was followed during the documented work, critical for reproducibility and compliance.',
    `publication_reference` STRING COMMENT 'Citation or Digital Object Identifier (DOI) of the scientific publication that references or is based on the work documented in this entry.',
    `reagent_lot_numbers` STRING COMMENT 'Comma-separated list of reagent and consumable lot numbers used in the documented experimental work, critical for reproducibility and quality investigations.',
    `result_unit` STRING COMMENT 'Unit of measure for the result value, ensuring proper interpretation of quantitative findings.',
    `result_value` DECIMAL(18,2) COMMENT 'Primary quantitative or qualitative result value documented in this entry, if applicable.',
    `review_status` STRING COMMENT 'Scientific review and approval status of the entry, critical for GxP compliance and intellectual property (IP) prosecution. Indicates whether the entry has undergone peer review or supervisor approval.. Valid values are `unreviewed|peer_reviewed|supervisor_approved|rejected`',
    `review_timestamp` TIMESTAMP COMMENT 'Timestamp when the entry was reviewed and approved or rejected by the designated reviewer.',
    `reviewer_name` STRING COMMENT 'Full name of the reviewer who approved this notebook entry. Denormalized for audit trail reporting.',
    `submission_timestamp` TIMESTAMP COMMENT 'Timestamp when the entry was submitted for review in the Benchling ELN system.',
    `tags` STRING COMMENT 'Comma-separated list of user-defined tags or keywords applied to this entry for categorization, search, and discovery within the ELN system.',
    `title` STRING COMMENT 'Descriptive title of the notebook entry summarizing the scientific observation or experimental result documented.',
    CONSTRAINT pk_notebook_entry PRIMARY KEY(`notebook_entry_id`)
) COMMENT 'Electronic lab notebook (ELN) entries sourced from Benchling — representing individual scientific observations, experimental results, data interpretations, and research notes recorded by scientists. Captures entry title, entry type (observation, result, protocol execution, data analysis), author, entry date, associated experiment, associated project, Benchling entry ID, review status (unreviewed, peer-reviewed, supervisor-approved), and data integrity signature. Provides the auditable scientific record required for IP prosecution and GxP compliance.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`material_request` (
    `material_request_id` BIGINT COMMENT 'Primary key for material_request',
    `experiment_id` BIGINT COMMENT 'Reference to the specific experiment requiring this material.',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Internal R&D material requests that require external procurement trigger sales orders for reagents, consumables, or reference materials. Links research demand to order fulfillment, enabling lead time ',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Material requests must specify the exact material being requested (currently denormalized as material_name/material_code). This is the core business relationship for R&D procurement workflows, enablin',
    `nonconformance_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance. Business justification: Material requests identify nonconforming materials (failed specifications, damaged goods, incorrect items) requiring NCR documentation and disposition decisions. Essential for tracking material qualit',
    `employee_id` BIGINT COMMENT 'Identifier of the R&D scientist or staff member who initiated the request.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Once approved, material requests convert to purchase orders. This link tracks request-to-fulfillment lifecycle for budget reconciliation, delivery tracking, and variance analysis between requested vs.',
    `project_id` BIGINT COMMENT 'Reference to the R&D project for which this material is requested.',
    `sample_specimen_id` BIGINT COMMENT 'Foreign key linking to sample.sample_specimen. Business justification: Material requests specify which specimens researchers need. Linking requests to specimens enables biobank fulfillment workflows, specimen utilization tracking, consent verification before release, and',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Researchers request specific catalog SKUs (reagents, controls, consumables). Procurement and inventory teams fulfill requests by linking to catalog SKUs for ordering, cost allocation, and inventory ma',
    `supplier_id` BIGINT COMMENT 'Identifier of the external vendor or supplier if the material is sourced externally.',
    `actual_cost_usd` DECIMAL(18,2) COMMENT 'Actual cost incurred for fulfilling the material request in United States Dollars.',
    `actual_receipt_date` DATE COMMENT 'Date when the requester physically received the material and confirmed receipt.',
    `approval_date` DATE COMMENT 'Date when the material request was approved.',
    `approval_status` STRING COMMENT 'Approval status indicating whether the request has been reviewed and authorized by the appropriate authority (e.g., principal investigator, lab manager).. Valid values are `pending|approved|rejected|not_required`',
    `approved_by_name` STRING COMMENT 'Full name of the employee who approved the material request.',
    `benchling_entity_reference` STRING COMMENT 'Unique identifier linking this material request to the corresponding entity or entry in the Benchling electronic lab notebook (ELN) system.',
    `consent_verification_status` STRING COMMENT 'Status indicating whether informed consent has been verified for human-derived biological samples or patient materials.. Valid values are `verified|pending|not_required|not_verified`',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which the material request cost is allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the material request record was first created in the system.',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'Estimated cost of fulfilling the material request in United States Dollars.',
    `fulfillment_date` DATE COMMENT 'Date when the material request was fully fulfilled and the material was made available to the requester.',
    `fulfillment_source` STRING COMMENT 'Source from which the material will be obtained to fulfill the request (internal stock, biobank, external vendor, custom synthesis, etc.).. Valid values are `internal_inventory|biobank|external_vendor|custom_synthesis|collaboration_partner|other`',
    `intended_experiment_description` STRING COMMENT 'Brief description of the experiment or research activity for which the material is being requested.',
    `irb_protocol_number` STRING COMMENT 'IRB approval protocol number associated with the request, required for human-derived samples or materials involving human subjects research.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the material request record was last modified or updated.',
    `lims_sample_reference` STRING COMMENT 'Identifier of the sample or material in the LabVantage LIMS system, if the material is tracked as a sample.',
    `lot_number` STRING COMMENT 'Manufacturing lot number or batch identifier of the material provided, critical for traceability and quality control.',
    `material_type` STRING COMMENT 'Classification of the requested material. [ENUM-REF-CANDIDATE: reagent|consumable|biological_sample|cell_line|reference_standard|oligonucleotide|gene_synthesis|crispr_reagent|antibody|organoid|environmental_sample|agricultural_specimen|other — promote to reference product]',
    `notes` STRING COMMENT 'Free-text field for additional comments, special handling instructions, or contextual information related to the material request.',
    `phi_involved` BOOLEAN COMMENT 'Flag indicating whether the requested material involves Protected Health Information under HIPAA regulations.',
    `quantity_fulfilled` DECIMAL(18,2) COMMENT 'Actual quantity of material delivered to fulfill the request, which may differ from the quantity requested.',
    `quantity_requested` DECIMAL(18,2) COMMENT 'Numeric quantity of the material requested by the scientist.',
    `request_date` DATE COMMENT 'Date when the material request was initiated by the scientist.',
    `request_number` STRING COMMENT 'Business-facing unique identifier for the material request, often human-readable and used in communications and tracking.',
    `request_status` STRING COMMENT 'Current lifecycle status of the material request. [ENUM-REF-CANDIDATE: draft|submitted|approved|in_procurement|in_fulfillment|partially_fulfilled|fulfilled|cancelled|rejected — promote to reference product]',
    `requester_name` STRING COMMENT 'Full name of the scientist or staff member who initiated the material request.',
    `required_by_date` DATE COMMENT 'Target date by which the requester needs the material to be available for use.',
    `specification_details` STRING COMMENT 'Detailed technical specifications, purity requirements, concentration, sequence information, or other attributes defining the requested material.',
    `storage_location` STRING COMMENT 'Physical or logical location where the fulfilled material is stored (e.g., freezer ID, shelf location, Laboratory Information Management System (LIMS) location code).',
    `unit_of_measure` STRING COMMENT 'Unit in which the requested quantity is expressed (e.g., milligrams, milliliters, vials, units). [ENUM-REF-CANDIDATE: mg|g|kg|ml|l|ul|nmol|umol|vial|tube|plate|unit|ea — 13 candidates stripped; promote to reference product]',
    `urgency_level` STRING COMMENT 'Priority classification indicating how quickly the material is needed for the experiment or project.. Valid values are `routine|urgent|critical|emergency`',
    `wbs_element` STRING COMMENT 'SAP Work Breakdown Structure element for project-based cost tracking and allocation.',
    CONSTRAINT pk_material_request PRIMARY KEY(`material_request_id`)
) COMMENT 'Transactional record of all material, reagent, and biological sample requests initiated by R&D scientists — including requests for custom oligonucleotides, gene synthesis, CRISPR reagents, specialized antibodies, cell lines, reference standards, biobank specimens, patient-derived organoids, environmental samples, and agricultural genomics specimens. Captures request date, requester, material type (reagent, consumable, biological_sample, cell_line, reference_standard), specification details, quantity, urgency, intended experiment, IRB protocol reference (for human-derived samples), consent verification status, fulfillment source (internal inventory, biobank, or external vendor), fulfillment status, and actual receipt date. Bridges the research domain with supply, reagent, and sample domains without duplicating procurement or biobank ownership.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` (
    `technology_transfer_id` BIGINT COMMENT 'Unique identifier for the technology transfer record. Primary key for the technology transfer entity.',
    `project_id` BIGINT COMMENT 'Reference identifier linking this technology transfer to the originating Benchling R&D project for electronic lab notebook traceability.',
    `capa_id` BIGINT COMMENT 'Foreign key linking to quality.capa. Business justification: Technology transfers generate CAPAs when deviations, gaps, or qualification failures are identified during transfer execution. Required for tracking corrective actions ensuring successful technology t',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.change_control. Business justification: Technology transfers are managed through change control systems to assess impact, approve implementation, and track effectiveness. GxP mandate for controlled introduction of new processes, methods, or',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Technology transfers between sites/functions require cost center tracking for transfer pricing, internal billing, and intercompany transaction documentation. Essential for multi-site biotech operation',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Technology transferred TO customers (assay protocols, bioinformatics pipelines, instrument methods) or FROM customers (novel methods, proprietary workflows). Critical for tech transfer agreements, tra',
    `employee_id` BIGINT COMMENT 'Employee identifier for the technology transfer lead, linking to workforce management systems.',
    `rd_project_id` BIGINT COMMENT 'Reference to the originating R&D project that developed this technology, linking the transfer to its research origins.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Tech transfers to manufacturing often involve supplier qualification for scaled production (e.g., contract manufacturers for assay kits, oligo synthesis at commercial scale). This link tracks supplier',
    `acceptance_criteria` STRING COMMENT 'Predefined criteria that must be met for the receiving team to formally accept the technology transfer, including performance metrics and quality standards.',
    `actual_completion_date` DATE COMMENT 'Date when the technology transfer was formally completed and accepted by the receiving team, marking successful handoff.',
    `actual_cost_usd` DECIMAL(18,2) COMMENT 'Actual total cost incurred for the technology transfer process, tracked for financial reporting and ROI analysis, expressed in USD.',
    `capa_count` STRING COMMENT 'Number of Corrective and Preventive Actions (CAPAs) initiated during the transfer process to address issues or risks.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this technology transfer record was first created in the system, supporting audit trail requirements.',
    `deviation_count` STRING COMMENT 'Number of deviations or non-conformances identified during the technology transfer process, tracked for quality management.',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'Estimated total cost of the technology transfer process including validation, training, and implementation activities, expressed in USD.',
    `gxp_applicable` BOOLEAN COMMENT 'Indicates whether Good Manufacturing Practice (GMP), Good Laboratory Practice (GLP), or Good Clinical Practice (GCP) regulations apply to this transfer.',
    `initiation_date` DATE COMMENT 'Date when the technology transfer process was formally initiated, marking the start of the stage-gate progression.',
    `ip_status` STRING COMMENT 'Intellectual property status of the transferred technology, indicating ownership, patent status, or licensing arrangements. [ENUM-REF-CANDIDATE: proprietary|licensed|patent_pending|patented|trade_secret|open_source|third_party — 7 candidates stripped; promote to reference product]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this technology transfer record was last modified, supporting change control and audit trail requirements.',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, or context regarding the technology transfer process and outcomes.',
    `originating_site` STRING COMMENT 'Physical location or facility where the technology was originally developed, important for traceability and regulatory compliance.',
    `originating_team` STRING COMMENT 'Name or identifier of the R&D team or department that developed the technology being transferred.',
    `patent_number` STRING COMMENT 'Patent number or application number associated with the transferred technology, if applicable.',
    `planned_completion_date` DATE COMMENT 'Target date for completing all transfer activities including validation and acceptance, used for project planning and milestone tracking.',
    `protocol_count` STRING COMMENT 'Number of Standard Operating Procedures (SOPs) or protocols included in the transfer package.',
    `qualification_status` STRING COMMENT 'Status of Installation Qualification (IQ), Operational Qualification (OQ), and Performance Qualification (PQ) activities at the receiving site. [ENUM-REF-CANDIDATE: not_started|in_progress|iq_complete|oq_complete|pq_complete|fully_qualified|failed — 7 candidates stripped; promote to reference product]',
    `quality_approval_date` DATE COMMENT 'Date when Quality Assurance formally approved the technology transfer for implementation at the receiving site.',
    `quality_reviewer_name` STRING COMMENT 'Name of the Quality Assurance reviewer responsible for approving the technology transfer documentation and compliance.',
    `receiving_function` STRING COMMENT 'Business function or operational area receiving the technology, indicating the downstream application context. [ENUM-REF-CANDIDATE: gmp_manufacturing|clinical_development|clia_lab|commercial_operations|quality_assurance|regulatory_affairs|other — 7 candidates stripped; promote to reference product]',
    `receiving_site` STRING COMMENT 'Physical location or facility where the technology will be implemented, such as GMP manufacturing site or CLIA-certified laboratory.',
    `receiving_team` STRING COMMENT 'Name or identifier of the downstream team or department receiving the technology for implementation or commercialization.',
    `regulatory_classification` STRING COMMENT 'Regulatory classification of the technology: In Vitro Diagnostic (IVD), Research Use Only (RUO), Laboratory Developed Test (LDT), or other applicable category. [ENUM-REF-CANDIDATE: ivd|ruo|ldt|medical_device|biologic|drug_substance|non_regulated — 7 candidates stripped; promote to reference product]',
    `regulatory_pathway` STRING COMMENT 'Applicable regulatory pathway for commercialization such as FDA 510(k), PMA, De Novo, or EMA CE-IVD marking process.',
    `regulatory_submission_required` BOOLEAN COMMENT 'Indicates whether regulatory submission to FDA, EMA, or other agencies is required following the technology transfer.',
    `sap_project_number` STRING COMMENT 'SAP project or Work Breakdown Structure (WBS) element number for tracking transfer costs and resource allocation.',
    `target_trl` STRING COMMENT 'Target Technology Readiness Level to be achieved upon successful transfer completion, indicating manufacturing or operational readiness.',
    `training_materials_included` BOOLEAN COMMENT 'Indicates whether training materials and documentation are included in the transfer package for receiving team onboarding.',
    `transfer_number` STRING COMMENT 'Business identifier for the technology transfer, used for external reference and tracking across systems. Typically follows format TT-NNNNNN.. Valid values are `^TT-[0-9]{6,10}$`',
    `transfer_package_contents` STRING COMMENT 'Comprehensive description of all materials included in the transfer package: protocols, SOPs, specifications, training materials, validation data, and supporting documentation.',
    `transfer_status` STRING COMMENT 'Current lifecycle status of the technology transfer process, tracking progression from initiation through completion. [ENUM-REF-CANDIDATE: initiated|planning|in_progress|validation|qualification|completed|on_hold|cancelled — 8 candidates stripped; promote to reference product]',
    `transfer_title` STRING COMMENT 'Descriptive title of the technology or process being transferred, providing clear identification of the transfer scope.',
    `transfer_type` STRING COMMENT 'Classification of the technology being transferred, indicating the nature of the intellectual property or process. [ENUM-REF-CANDIDATE: sequencing_chemistry|crispr_construct|assay_method|manufacturing_process|analytical_method|library_prep_protocol|bioinformatics_pipeline|instrument_method|quality_control_method|other — 10 candidates stripped; promote to reference product]',
    `trl_at_transfer` STRING COMMENT 'Technology Readiness Level score at the time of transfer initiation, typically TRL 6-9 for manufacturing readiness and commercialization.',
    `validation_data_included` BOOLEAN COMMENT 'Indicates whether validation study data and results are included in the transfer package to support qualification activities.',
    `validation_status` STRING COMMENT 'Status of process or method validation activities performed at the receiving site to demonstrate reproducibility and compliance.. Valid values are `not_started|protocol_approved|in_progress|completed|failed|revalidation_required`',
    `veeva_document_reference` STRING COMMENT 'Reference identifier for the technology transfer package stored in Veeva Vault document management system.',
    CONSTRAINT pk_technology_transfer PRIMARY KEY(`technology_transfer_id`)
) COMMENT 'Manages formal handoff of R&D-developed technologies, assays, and manufacturing processes to downstream teams — including transfer of sequencing chemistry to GMP manufacturing, CRISPR constructs to clinical development, and validated assays to CLIA-certified labs. Captures transfer title, technology type, originating R&D project, receiving team/site, transfer initiation and completion dates, transfer package contents (protocols, specifications, training materials, validation data), acceptance criteria, qualification/validation status, deviations, and corrective actions. Serves as the stage-gate record for TRL 6-9 progression and ensures manufacturing readiness.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`sample_request` (
    `sample_request_id` BIGINT COMMENT 'Primary key for sample_request',
    `project_id` BIGINT COMMENT 'External identifier from Benchling R&D platform linking this sample request to the electronic lab notebook (ELN) project or entry.',
    `complaint_id` BIGINT COMMENT 'Foreign key linking to quality.complaint. Business justification: Sample quality issues in research (contamination, mislabeling, integrity failures) trigger internal complaints requiring investigation and disposition. Essential for tracking sample-related quality ev',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Research teams requesting samples from customer biobanks or clinical sites for validation studies or collaborative research. Essential for MTA execution, consent verification, sample logistics, and re',
    `experiment_id` BIGINT COMMENT 'Identifier of the specific experiment or protocol for which the samples are intended, capturing the intended use context.',
    `genomic_access_control_id` BIGINT COMMENT 'Foreign key linking to data.genomic_access_control. Business justification: Sample requests for genomic material must verify access authorization against genomic access control policies and consent requirements. Ensures samples are only released when data use aligns with cons',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Sample procurement for research (reference materials, control samples, cell lines) generates purchase orders. Tracks research supply chain, supports experiment planning, and enables cost allocation fo',
    `inbound_delivery_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_delivery. Business justification: Sample requests fulfilled from external biobanks/CROs arrive as inbound deliveries with chain-of-custody documentation. This link tracks delivery compliance (temperature excursions, transit time), rec',
    `employee_id` BIGINT COMMENT 'Identifier of the R&D scientist, researcher, or staff member who submitted the sample request.',
    `rd_project_id` BIGINT COMMENT 'Identifier of the R&D project for which the samples are being requested, linking the request to the broader research initiative.',
    `service_offering_id` BIGINT COMMENT 'Foreign key linking to product.service_offering. Business justification: Sample requests may be fulfilled through internal service offerings (biobanking, sequencing, genotyping services). Operations links requests to service catalog for capacity planning, billing, SLA trac',
    `biobank_location_id` BIGINT COMMENT 'Identifier of the biobank or storage location from which the samples are being requested and retrieved.',
    `tertiary_sample_handoff_recipient_employee_id` BIGINT COMMENT 'Identifier of the individual who received the samples during the chain of custody handoff.',
    `approved_by_name` STRING COMMENT 'Full name of the individual who approved the sample request.',
    `approved_date` DATE COMMENT 'Date when the sample request was approved by the authorized reviewer or sample custodian.',
    `cancellation_reason` STRING COMMENT 'Explanation or rationale for why the sample request was cancelled by the requester or lab management.',
    `chain_of_custody_handoff_date` TIMESTAMP COMMENT 'Timestamp when the chain of custody for the samples was formally transferred from the sample management domain to the requester, ensuring traceability and compliance.',
    `consent_verification_status` STRING COMMENT 'Status indicating whether patient or donor consent has been verified for the intended use of the requested samples.. Valid values are `not_required|pending_verification|verified|failed|waived`',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which the sample request and associated costs should be allocated for R&D spend tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sample request record was first created in the system.',
    `data_sharing_required` BOOLEAN COMMENT 'Boolean flag indicating whether genomic data generated from these samples must be shared with public repositories per NIH or other funding agency policies.',
    `delivery_location` STRING COMMENT 'Physical location or lab address where the samples should be delivered upon fulfillment.',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'Estimated cost in USD for fulfilling the sample request, including sample preparation, handling, and any associated consumables.',
    `fulfillment_date` DATE COMMENT 'Date when the sample request was fully fulfilled and samples were handed off to the requester or designated location.',
    `fulfillment_status` STRING COMMENT 'Current status of the physical fulfillment process for the sample request, tracking whether samples have been pulled, prepared, and delivered.. Valid values are `not_started|in_progress|partially_fulfilled|fully_fulfilled|unable_to_fulfill|cancelled`',
    `handoff_recipient_name` STRING COMMENT 'Full name of the individual who received the samples during the chain of custody handoff.',
    `intended_use` STRING COMMENT 'Description of the intended research use or experimental purpose for the requested samples, providing context for the request.',
    `irb_approval_status` STRING COMMENT 'Current status of IRB approval for the research use of the requested samples.. Valid values are `not_required|pending|approved|expired|withdrawn`',
    `irb_protocol_number` STRING COMMENT 'Reference to the IRB protocol number under which the sample use is authorized, ensuring ethical and regulatory compliance for human-subject research.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the sample request record was last modified or updated.',
    `lims_request_reference` STRING COMMENT 'External identifier from the Laboratory Information Management System (LabVantage LIMS) linking this request to the source system record.',
    `notes` STRING COMMENT 'Free-text field for additional comments, clarifications, or context related to the sample request.',
    `phi_involved` BOOLEAN COMMENT 'Boolean flag indicating whether the requested samples contain or are linked to Protected Health Information requiring HIPAA compliance.',
    `priority_level` STRING COMMENT 'Priority classification of the sample request indicating urgency and processing sequence.. Valid values are `low|normal|high|urgent|critical`',
    `quantity_requested` DECIMAL(18,2) COMMENT 'Numeric quantity of the sample being requested by the researcher.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the requested sample quantity, such as milliliters, micrograms, vials, or cell count. [ENUM-REF-CANDIDATE: ml|ul|mg|ug|ng|vials|aliquots|tubes|plates|wells|cells|reads — 12 candidates stripped; promote to reference product]',
    `rejection_reason` STRING COMMENT 'Explanation or rationale for why the sample request was rejected, if applicable.',
    `request_date` DATE COMMENT 'Date when the sample request was initially created or submitted by the requester.',
    `request_number` STRING COMMENT 'Human-readable business identifier for the sample request, formatted as SR-YYYYMMDD or similar pattern for external reference and tracking.. Valid values are `^SR-[0-9]{8}$`',
    `request_status` STRING COMMENT 'Current lifecycle status of the sample request in the R&D workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|in_fulfillment|fulfilled|cancelled|on_hold — 9 candidates stripped; promote to reference product]',
    `requested_delivery_date` DATE COMMENT 'Target date by which the requester needs the samples delivered to support their experimental timeline.',
    `requester_email` STRING COMMENT 'Email address of the requester for communication regarding the sample request status and fulfillment.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requester_name` STRING COMMENT 'Full name of the individual who submitted the sample request for R&D use.',
    `sample_subtype` STRING COMMENT 'More granular classification or variant of the sample type, providing additional specificity about the requested material.',
    `sample_type` STRING COMMENT 'Classification of the biological sample being requested, indicating the nature and source of the material. [ENUM-REF-CANDIDATE: biobank_specimen|cell_line_aliquot|patient_derived_organoid|environmental_sample|agricultural_genomics_specimen|tissue_sample|blood_sample|dna_extract|rna_extract|protein_lysate|other — 11 candidates stripped; promote to reference product]',
    `special_handling_instructions` STRING COMMENT 'Free-text field capturing any special handling, storage, or transport requirements for the requested samples, such as temperature control or hazardous material protocols.',
    CONSTRAINT pk_sample_request PRIMARY KEY(`sample_request_id`)
) COMMENT 'Tracks R&D requests for biological samples from the sample management domain — including requests for biobank specimens, cell line aliquots, patient-derived organoids, environmental samples, and agricultural genomics specimens for research use. Captures request date, requester, sample type, quantity, intended use (experiment ID), IRB protocol reference, consent verification status, chain-of-custody handoff date, and fulfillment status. Distinct from the sample domains accessioning and storage records — this captures the R&D consumption demand signal.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`project_investigator` (
    `project_investigator_id` BIGINT COMMENT 'Unique surrogate identifier for the project investigator assignment record',
    `authorized_orderer_id` BIGINT COMMENT 'Foreign key linking to the authorized orderer serving as investigator on the research project',
    `project_id` BIGINT COMMENT 'Foreign key linking to the R&D research project',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the investigator assignment. Values: active (currently serving in role), on_leave (temporary absence), suspended (regulatory hold or compliance issue), completed (assignment ended normally), terminated (assignment ended prematurely).',
    `co_investigator_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this assignment represents a Co-Investigator (co-I) role with shared scientific responsibility. Multiple co-investigators may exist per project.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the project investigator assignment record was first created in the system. Auto-populated by the system.',
    `delegation_log_reference` STRING COMMENT 'Reference identifier or document number linking to the formal delegation of authority log that documents which specific study tasks and responsibilities have been delegated to this investigator. Required for GCP compliance and regulatory inspections.',
    `effort_percent` DECIMAL(18,2) COMMENT 'Percentage of the investigators professional effort allocated to this research project, expressed as a decimal (e.g., 15.00 for 15% effort). Required for NIH effort reporting, institutional conflict of interest monitoring, and project resource planning. Must sum to ≤100% across all concurrent project assignments for the investigator.',
    `end_date` DATE COMMENT 'Date when the investigator role assignment ended or is planned to end. Null for active ongoing assignments. Used for effort reporting period closure and tracking investigator turnover on projects.',
    `fda_1572_signed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this investigator has signed FDA Form 1572 (Statement of Investigator) for this project. Required for clinical investigations subject to FDA IND or IDE regulations.',
    `investigator_role` STRING COMMENT 'The specific investigator role assigned to the authorized orderer on this project. Determines regulatory responsibilities, signature authority, and reporting requirements. Values: principal_investigator (PI with overall scientific and regulatory responsibility), co_investigator (co-I with shared scientific responsibility), sub_investigator (sub-I delegated specific tasks), site_investigator (multi-site trial site lead), consulting_investigator (advisory role without regulatory responsibility).',
    `irb_listed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this investigator is formally listed on the IRB protocol submission for this project. IRB-listed investigators have specific training and compliance obligations.',
    `principal_investigator_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this assignment represents the Principal Investigator (PI) role with ultimate scientific and regulatory responsibility for the project. Only one investigator per project should have this flag set to true at any given time.',
    `signature_authority_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this investigator has been granted signature authority for regulatory documents, protocol amendments, or study reports associated with this project. Typically true for PI and selected co-investigators.',
    `start_date` DATE COMMENT 'Date when the investigator role assignment became effective. Used for effort reporting period determination and regulatory documentation of investigator tenure on the project.',
    `sub_investigator_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this assignment represents a Sub-Investigator (sub-I) role with delegated specific tasks under PI supervision. Multiple sub-investigators may exist per project.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the project investigator assignment record was last modified. Auto-updated by the system on any change.',
    CONSTRAINT pk_project_investigator PRIMARY KEY(`project_investigator_id`)
) COMMENT 'This association product represents the investigator role assignment between authorized clinical orderers and R&D research projects. It captures the formal investigator relationships required for IRB submissions, FDA 1572 forms, and effort reporting in clinical genomics research. Each record links one authorized orderer (serving as PI, co-investigator, or sub-investigator) to one research project with role-specific attributes including effort allocation, delegation authority, and time-bounded assignment periods. This is a core operational entity actively managed by research operations and clinical compliance teams.. Existence Justification: In genomics biotech research operations, authorized clinical orderers (physicians, genetic counselors) serve as investigators on multiple R&D projects simultaneously, and each research project has multiple investigators with distinct roles (PI, co-I, sub-I). The business actively manages these investigator assignments as formal operational records required for IRB submissions, FDA 1572 forms, effort reporting, and regulatory compliance. This is a true operational many-to-many relationship recognized by research operations teams as Project Investigator Assignments or Research Team Member records.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`research_assignment` (
    `research_assignment_id` BIGINT COMMENT 'Primary key for research_assignment',
    `workforce_assignment_id` BIGINT COMMENT 'Unique surrogate identifier for the project assignment record. Primary key for the assignment association.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee record. Identifies which employee is assigned to the project.',
    `project_id` BIGINT COMMENT 'Foreign key linking to the R&D project record. Identifies which research project this assignment belongs to.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the employees total work time allocated to this specific project assignment. Used for resource planning and capacity management. Range 0.00 to 100.00. Explicitly identified in detection phase as relationship data.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the project assignment. Active assignments are currently in progress, planned assignments are future commitments, completed assignments are historical records.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether the employees time on this project assignment is billable to an external sponsor, grant, or collaboration partner. Used for cost allocation and financial reporting. Explicitly identified in detection phase as relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was created in the system. Used for audit trail and data lineage.',
    `effort_hours` DECIMAL(18,2) COMMENT 'Total planned or budgeted hours for this employees work on the project assignment. Used for project planning, resource forecasting, and comparing planned vs. actual effort. Explicitly identified in detection phase as relationship data.',
    `end_date` DATE COMMENT 'Date when the employees assignment to this R&D project ended or is planned to end. Null for ongoing assignments. Enables tracking of assignment duration and historical team composition. Explicitly identified in detection phase as relationship data.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was last updated. Used for change tracking and data freshness monitoring.',
    `role_on_project` STRING COMMENT 'The functional role or capacity in which the employee is assigned to the R&D project. Defines responsibilities and authority level within the project team structure. Explicitly identified in detection phase as relationship data.',
    `start_date` DATE COMMENT 'Date when the employees assignment to this R&D project began. Used to track assignment history and tenure on project. Explicitly identified in detection phase as relationship data.',
    CONSTRAINT pk_research_assignment PRIMARY KEY(`research_assignment_id`)
) COMMENT 'This association product represents the Assignment between R&D projects and employees within Genomics Biotech. It captures the staffing allocation of employees to research projects, tracking their role, time commitment, and assignment period. Each record links one project to one employee with attributes that exist only in the context of this specific project assignment, enabling cross-functional team management and resource planning across concurrent R&D initiatives.. Existence Justification: In genomics biotech R&D operations, projects require cross-functional teams where one project has many employees (PI, project manager, scientists, bioinformaticians, regulatory specialists) and one employee typically works on multiple concurrent projects. The business actively manages these assignments as operational records, tracking role, effort percentage, time period, and billability for each employee-project pairing. This is the classic project staffing pattern where the assignment itself is a managed business entity.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`experiment_analysis` (
    `experiment_analysis_id` BIGINT COMMENT 'Unique surrogate identifier for each experiment-pipeline analysis execution record',
    `experiment_id` BIGINT COMMENT 'Foreign key linking to the experiment whose data is being analyzed by this pipeline execution',
    `bioinformatics_pipeline_run_id` BIGINT COMMENT 'External identifier of the computational pipeline run in the HPC or cloud execution environment (e.g., Cromwell workflow ID, Nextflow run name). Links this association record to the operational execution log.',
    `pipeline_version_id` BIGINT COMMENT 'Foreign key linking to the specific versioned pipeline used for this analysis execution',
    `employee_id` BIGINT COMMENT 'Reference to the employee who reviewed the QC outcomes and analysis results for this execution. Explicitly identified in detection phase relationship data.',
    `actual_runtime_hours` DECIMAL(18,2) COMMENT 'Actual wall-clock execution time in hours for this specific analysis run. Compared against pipeline_version.estimated_runtime_hours for performance monitoring.',
    `analysis_purpose` STRING COMMENT 'Scientific or operational purpose of this analysis execution (initial_processing, reanalysis, method_comparison, validation_study, troubleshooting). Explicitly identified in detection phase relationship data.',
    `compute_cost_usd` DECIMAL(18,2) COMMENT 'Estimated or actual computational cost in USD for executing this pipeline version against this experiment dataset. Used for cost allocation and pipeline optimization studies.',
    `execution_date` TIMESTAMP COMMENT 'Date and time when this pipeline version was executed against this experiment dataset. Explicitly identified in detection phase relationship data.',
    `notes` STRING COMMENT 'Free-text notes documenting any issues, observations, or context specific to this analysis execution (e.g., Rerun after fixing sample swap issue, Comparison run for validation study VAL-2024-03).',
    `output_file_path` STRING COMMENT 'File system path or object storage URI where the output files (VCF, BAM, QC reports) from this analysis execution are stored.',
    `qc_status` STRING COMMENT 'Quality control outcome for this specific analysis execution (passed, failed, warning, pending, not_applicable). Explicitly identified in detection phase relationship data.',
    `review_date` DATE COMMENT 'Date on which the analysis results and QC outcomes were formally reviewed. Explicitly identified in detection phase relationship data.',
    CONSTRAINT pk_experiment_analysis PRIMARY KEY(`experiment_analysis_id`)
) COMMENT 'This association product represents the execution event of a bioinformatics pipeline version against an experiment dataset. It captures the operational record of each analysis run, including when the pipeline was executed, the quality control outcomes, the scientific purpose of the analysis (initial processing, reanalysis with updated algorithms, method comparison study), and the review workflow. Each record links one experiment to one pipeline version with attributes that exist only in the context of this specific analysis execution.. Existence Justification: In genomics biotech operations, experiments generate datasets that are analyzed using bioinformatics pipelines, and the same experiment dataset is routinely reanalyzed with multiple pipeline versions as algorithms improve, validation requirements change, or method comparison studies are conducted. Each pipeline version processes hundreds or thousands of experiments over its lifecycle. The business actively manages each analysis execution as an operational record with QC outcomes, review status, execution metadata, and scientific purpose tracking.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`review_board` (
    `review_board_id` BIGINT COMMENT 'Primary key for review_board',
    `parent_review_board_id` BIGINT COMMENT 'Self-referencing FK on review_board (parent_review_board_id)',
    `address_line1` STRING COMMENT 'First line of the review boards mailing address.',
    `address_line2` STRING COMMENT 'Second line of the review boards mailing address (optional).',
    `audit_trail` STRING COMMENT 'Summary of audit actions performed on the review board record.',
    `board_code` STRING COMMENT 'External code or identifier for the review board used in regulatory filings.',
    `board_name` STRING COMMENT 'Human-readable name of the review board.',
    `board_type` STRING COMMENT 'Category of the review board indicating its primary function.',
    `city` STRING COMMENT 'City where the review board is located.',
    `compliance_requirements` STRING COMMENT 'Key regulatory frameworks the board adheres to (e.g., FDA, EMA, IRB guidelines).',
    `contact_email` STRING COMMENT 'Primary email address for contacting the review board.',
    `contact_phone` STRING COMMENT 'Primary phone number for the review board.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the review board record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the review board became officially active.',
    `effective_until` DATE COMMENT 'Date when the review board ceased operation or is scheduled to retire (nullable).',
    `is_external` BOOLEAN COMMENT 'Flag indicating whether the board is external to the organization (True) or internal (False).',
    `jurisdiction_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the board operates.',
    `last_meeting_date` DATE COMMENT 'Date of the most recent board meeting.',
    `meeting_frequency` STRING COMMENT 'Regularity of the boards meetings.',
    `next_meeting_date` DATE COMMENT 'Scheduled date for the upcoming board meeting.',
    `notes` STRING COMMENT 'Free-text field for additional remarks or internal notes.',
    `number_of_members` STRING COMMENT 'Total count of members serving on the board.',
    `parent_organization` STRING COMMENT 'Name of the organization that sponsors or hosts the review board.',
    `postal_code` STRING COMMENT 'Postal code for the review boards address.',
    `review_scope` STRING COMMENT 'Primary scientific or regulatory domains the board reviews (e.g., gene editing, clinical trials).',
    `state_province` STRING COMMENT 'State or province of the review boards location.',
    `review_board_status` STRING COMMENT 'Current lifecycle status of the review board.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the review board record.',
    `website_url` STRING COMMENT 'Public website URL for the review board.',
    CONSTRAINT pk_review_board PRIMARY KEY(`review_board_id`)
) COMMENT 'Master reference table for review_board. Referenced by review_board_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`program` (
    `program_id` BIGINT COMMENT 'Primary key for program',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for overall program management.',
    `parent_program_id` BIGINT COMMENT 'Self-referencing FK on program (parent_program_id)',
    `actual_end_date` DATE COMMENT 'Calendar date when the program actually finished.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved total budget for the program expressed in the specified currency.',
    `collaboration_partner` STRING COMMENT 'External organization or institution collaborating on the program.',
    `compliance_status` STRING COMMENT 'Regulatory compliance state of the program.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the program record was first created in the system.',
    `currency` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `data_privacy_classification` STRING COMMENT 'Classification indicating the sensitivity of data generated by the program.',
    `program_description` STRING COMMENT 'Detailed textual description of the programs objectives and scope.',
    `end_date` DATE COMMENT 'Planned calendar date for program completion.',
    `funding_source` STRING COMMENT 'Origin of the programs funding.',
    `irb_approval_date` DATE COMMENT 'Date on which IRB approval was granted.',
    `irb_approval_status` STRING COMMENT 'Institutional Review Board approval state for human‑subject research.',
    `is_external_funding` BOOLEAN COMMENT 'Indicates whether the program receives funding from external sources.',
    `last_review_date` DATE COMMENT 'Date of the most recent program governance or status review.',
    `lead_scientist_email` STRING COMMENT 'Corporate email address of the lead scientist.',
    `lead_scientist_name` STRING COMMENT 'Full legal name of the primary scientist leading the program.',
    `program_name` STRING COMMENT 'Human‑readable name of the research program.',
    `patent_count` STRING COMMENT 'Number of patents filed or granted based on program outcomes.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Estimated percentage of work completed, expressed as a value between 0 and 100.',
    `program_code` STRING COMMENT 'External business identifier or code used to reference the program.',
    `program_type` STRING COMMENT 'Category of the program indicating its scientific focus or stage.',
    `publication_count` STRING COMMENT 'Number of peer‑reviewed publications resulting from the program.',
    `risk_level` STRING COMMENT 'Overall risk rating assigned to the program.',
    `scientific_area` STRING COMMENT 'Primary scientific discipline or application area of the program.',
    `sponsor_contact_email` STRING COMMENT 'Email address for the sponsors primary contact.',
    `sponsor_name` STRING COMMENT 'Name of the internal or external entity sponsoring the program.',
    `start_date` DATE COMMENT 'Planned calendar date when the program is scheduled to begin.',
    `program_status` STRING COMMENT 'Current lifecycle status of the program.',
    `technology_readiness_level` STRING COMMENT 'Standardized TRL rating (1‑9) indicating maturity of the technology.',
    `total_spend_to_date` DECIMAL(18,2) COMMENT 'Cumulative expenditures incurred by the program to date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the program record.',
    CONSTRAINT pk_program PRIMARY KEY(`program_id`)
) COMMENT 'Master reference table for program. Referenced by program_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`research`.`study` (
    `study_id` BIGINT COMMENT 'Primary key for study',
    `parent_study_id` BIGINT COMMENT 'Self-referencing FK on study (parent_study_id)',
    `compliance_status` STRING COMMENT 'Indicates whether the study meets applicable regulatory requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the study record was first created in the system.',
    `data_retention_period_days` STRING COMMENT 'Number of days the study data must be retained per policy.',
    `data_retention_policy` STRING COMMENT 'Reference to the internal policy governing data archiving and disposal.',
    `data_sharing_status` STRING COMMENT 'Current policy governing external data access.',
    `disease_area` STRING COMMENT 'Therapeutic or biological domain the study addresses.',
    `end_date` DATE COMMENT 'Planned or actual completion date of the study.',
    `funding_amount` DECIMAL(18,2) COMMENT 'Total monetary amount allocated to the study.',
    `funding_source` STRING COMMENT 'Origin of the studys financial support.',
    `irb_approval_date` DATE COMMENT 'Date the Institutional Review Board granted approval.',
    `is_multi_center` BOOLEAN COMMENT 'Indicates whether the study is conducted across multiple sites.',
    `number_of_sites` STRING COMMENT 'Count of distinct research locations participating in the study.',
    `participant_count` BIGINT COMMENT 'Total number of subjects enrolled in the study.',
    `principal_investigator` STRING COMMENT 'Full legal name of the lead researcher responsible for the study.',
    `protocol_version` STRING COMMENT 'Version identifier of the study protocol document.',
    `regulatory_approval_number` STRING COMMENT 'Identifier assigned by the regulatory authority upon approval.',
    `site_locations` STRING COMMENT 'Comma‑separated list of site identifiers or city/country codes.',
    `start_date` DATE COMMENT 'Planned or actual start date of the study.',
    `study_status` STRING COMMENT 'Current lifecycle state of the study.',
    `study_code` STRING COMMENT 'External reference code used in lab notebooks and regulatory filings.',
    `study_description` STRING COMMENT 'Narrative summary of the study objectives and methods.',
    `study_design` STRING COMMENT 'Methodological framework of the study.',
    `study_name` STRING COMMENT 'Human‑readable title of the study.',
    `study_objective` STRING COMMENT 'Primary scientific question or hypothesis the study seeks to answer.',
    `study_phase` STRING COMMENT 'Development stage of the study, aligned with clinical trial phases where applicable.',
    `study_status_reason` STRING COMMENT 'Free‑text explanation for the current status, e.g., cause of suspension.',
    `study_type` STRING COMMENT 'Category describing the scientific approach of the study.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the study record.',
    CONSTRAINT pk_study PRIMARY KEY(`study_id`)
) COMMENT 'Master reference table for study. Referenced by study_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ADD CONSTRAINT `fk_research_milestone_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ADD CONSTRAINT `fk_research_milestone_review_board_id` FOREIGN KEY (`review_board_id`) REFERENCES `genomics_biotech_ecm`.`research`.`review_board`(`review_board_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_crispr_construct_id` FOREIGN KEY (`crispr_construct_id`) REFERENCES `genomics_biotech_ecm`.`research`.`crispr_construct`(`crispr_construct_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ADD CONSTRAINT `fk_research_crispr_construct_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_irb_submission_id` FOREIGN KEY (`irb_submission_id`) REFERENCES `genomics_biotech_ecm`.`research`.`irb_submission`(`irb_submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ADD CONSTRAINT `fk_research_spend_collaboration_agreement_id` FOREIGN KEY (`collaboration_agreement_id`) REFERENCES `genomics_biotech_ecm`.`research`.`collaboration_agreement`(`collaboration_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ADD CONSTRAINT `fk_research_spend_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `genomics_biotech_ecm`.`research`.`grant`(`grant_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ADD CONSTRAINT `fk_research_spend_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ADD CONSTRAINT `fk_research_collaboration_agreement_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ADD CONSTRAINT `fk_research_collaboration_agreement_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `genomics_biotech_ecm`.`research`.`grant`(`grant_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ADD CONSTRAINT `fk_research_collaboration_agreement_irb_submission_id` FOREIGN KEY (`irb_submission_id`) REFERENCES `genomics_biotech_ecm`.`research`.`irb_submission`(`irb_submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `genomics_biotech_ecm`.`research`.`grant`(`grant_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ADD CONSTRAINT `fk_research_ip_disclosure_collaboration_agreement_id` FOREIGN KEY (`collaboration_agreement_id`) REFERENCES `genomics_biotech_ecm`.`research`.`collaboration_agreement`(`collaboration_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ADD CONSTRAINT `fk_research_ip_disclosure_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ADD CONSTRAINT `fk_research_publication_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ADD CONSTRAINT `fk_research_publication_collaboration_agreement_id` FOREIGN KEY (`collaboration_agreement_id`) REFERENCES `genomics_biotech_ecm`.`research`.`collaboration_agreement`(`collaboration_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ADD CONSTRAINT `fk_research_publication_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `genomics_biotech_ecm`.`research`.`grant`(`grant_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ADD CONSTRAINT `fk_research_publication_ip_disclosure_id` FOREIGN KEY (`ip_disclosure_id`) REFERENCES `genomics_biotech_ecm`.`research`.`ip_disclosure`(`ip_disclosure_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ADD CONSTRAINT `fk_research_publication_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ADD CONSTRAINT `fk_research_trl_assessment_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `genomics_biotech_ecm`.`research`.`grant`(`grant_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ADD CONSTRAINT `fk_research_trl_assessment_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ADD CONSTRAINT `fk_research_trl_assessment_review_board_id` FOREIGN KEY (`review_board_id`) REFERENCES `genomics_biotech_ecm`.`research`.`review_board`(`review_board_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ADD CONSTRAINT `fk_research_trl_assessment_technology_transfer_id` FOREIGN KEY (`technology_transfer_id`) REFERENCES `genomics_biotech_ecm`.`research`.`technology_transfer`(`technology_transfer_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ADD CONSTRAINT `fk_research_grant_report_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `genomics_biotech_ecm`.`research`.`grant`(`grant_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ADD CONSTRAINT `fk_research_grant_report_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ADD CONSTRAINT `fk_research_research_budget_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `genomics_biotech_ecm`.`research`.`grant`(`grant_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ADD CONSTRAINT `fk_research_research_budget_program_id` FOREIGN KEY (`program_id`) REFERENCES `genomics_biotech_ecm`.`research`.`program`(`program_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ADD CONSTRAINT `fk_research_research_budget_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ADD CONSTRAINT `fk_research_molecular_design_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ADD CONSTRAINT `fk_research_notebook_entry_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ADD CONSTRAINT `fk_research_notebook_entry_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ADD CONSTRAINT `fk_research_notebook_entry_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ADD CONSTRAINT `fk_research_material_request_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ADD CONSTRAINT `fk_research_material_request_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ADD CONSTRAINT `fk_research_technology_transfer_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ADD CONSTRAINT `fk_research_technology_transfer_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ADD CONSTRAINT `fk_research_sample_request_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ADD CONSTRAINT `fk_research_sample_request_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ADD CONSTRAINT `fk_research_sample_request_rd_project_id` FOREIGN KEY (`rd_project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`project_investigator` ADD CONSTRAINT `fk_research_project_investigator_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_assignment` ADD CONSTRAINT `fk_research_research_assignment_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment_analysis` ADD CONSTRAINT `fk_research_experiment_analysis_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`review_board` ADD CONSTRAINT `fk_research_review_board_parent_review_board_id` FOREIGN KEY (`parent_review_board_id`) REFERENCES `genomics_biotech_ecm`.`research`.`review_board`(`review_board_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`program` ADD CONSTRAINT `fk_research_program_parent_program_id` FOREIGN KEY (`parent_program_id`) REFERENCES `genomics_biotech_ecm`.`research`.`program`(`program_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`study` ADD CONSTRAINT `fk_research_study_parent_study_id` FOREIGN KEY (`parent_study_id`) REFERENCES `genomics_biotech_ecm`.`research`.`study`(`study_id`);

-- ========= TAGS =========
ALTER SCHEMA `genomics_biotech_ecm`.`research` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `genomics_biotech_ecm`.`research` SET TAGS ('dbx_domain' = 'research');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` SET TAGS ('dbx_subdomain' = 'project_management');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `capex_request_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Request Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `metadata_schema_id` SET TAGS ('dbx_business_glossary_term' = 'Metadata Schema Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `project_principal_investigator_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Project End Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Project Spend (USD)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Project Approval Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `benchling_project_reference` SET TAGS ('dbx_business_glossary_term' = 'Benchling Electronic Lab Notebook (ELN) Project ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `budget_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Amount (USD)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `budget_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `collaboration_type` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `collaboration_type` SET TAGS ('dbx_value_regex' = 'internal|academic|industry|government|consortium');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `data_sharing_required` SET TAGS ('dbx_business_glossary_term' = 'Genomic Data Sharing Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `grant_number` SET TAGS ('dbx_business_glossary_term' = 'Grant Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `gxp_applicable` SET TAGS ('dbx_business_glossary_term' = 'Good Practice Regulations (GxP) Applicable Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `intended_use` SET TAGS ('dbx_business_glossary_term' = 'Intended Use Classification');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `intended_use` SET TAGS ('dbx_value_regex' = 'RUO|IVD|LDT|CE-IVD|research_only');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `ip_classification` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Classification');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `ip_classification` SET TAGS ('dbx_value_regex' = 'proprietary|licensed_in|licensed_out|open_source|trade_secret|patent_pending');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `ip_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `milestone_count` SET TAGS ('dbx_business_glossary_term' = 'Total Milestone Count');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `milestones_achieved_count` SET TAGS ('dbx_business_glossary_term' = 'Milestones Achieved Count');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `patent_application_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Application Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `patent_application_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `phase` SET TAGS ('dbx_business_glossary_term' = 'Project Phase');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `phi_involved` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Involved Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Project End Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `primary_success_metric` SET TAGS ('dbx_business_glossary_term' = 'Primary Success Metric');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'R&D Project Code');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `project_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}-[0-9]{4,8}$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `project_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|completed|cancelled|pending_approval');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'discovery|development|validation|feasibility|translational');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `publication_count` SET TAGS ('dbx_business_glossary_term' = 'Publication Count');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `regulatory_pathway` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Pathway');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `regulatory_pathway` SET TAGS ('dbx_value_regex' = '510k|PMA|De_Novo|CE-IVD|EUA|none');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `regulatory_submission_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_business_glossary_term' = 'SAP Work Breakdown Structure (WBS) Element');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `sponsoring_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Business Unit');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `target_indication` SET TAGS ('dbx_business_glossary_term' = 'Target Indication or Application Area');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `target_product_profile` SET TAGS ('dbx_business_glossary_term' = 'Target Product Profile (TPP)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `technology_area` SET TAGS ('dbx_business_glossary_term' = 'Technology Area');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Project Title');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `trl` SET TAGS ('dbx_business_glossary_term' = 'Technology Readiness Level (TRL)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ALTER COLUMN `veeva_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` SET TAGS ('dbx_subdomain' = 'project_management');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Identifier');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Accountable Milestone Owner ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `rd_capitalization_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Capitalization Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `review_board_id` SET TAGS ('dbx_business_glossary_term' = 'Review Board ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `advancement_criteria` SET TAGS ('dbx_business_glossary_term' = 'Next-Level Advancement Criteria');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `assessment_rationale` SET TAGS ('dbx_business_glossary_term' = 'Milestone Assessment Rationale');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `associated_deliverable` SET TAGS ('dbx_business_glossary_term' = 'Associated Milestone Deliverable');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `benchling_entry_reference` SET TAGS ('dbx_business_glossary_term' = 'Benchling Electronic Lab Notebook (ELN) Entry ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated to Milestone');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Milestone Comments');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Stage Gate Decision Rationale');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `evidence_artifact_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Artifact Reference');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `go_no_go_decision` SET TAGS ('dbx_business_glossary_term' = 'Go/No-Go Stage Gate Decision');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `go_no_go_decision` SET TAGS ('dbx_value_regex' = 'go|no_go|conditional_go|hold');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `is_gxp_relevant` SET TAGS ('dbx_business_glossary_term' = 'Good Practice Regulations (GxP) Relevant Milestone Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `is_ip_generating` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Generating Milestone Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `is_regulatory_critical` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Critical Path Milestone Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_business_glossary_term' = 'Milestone Business Identifier Code');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_value_regex' = '^MS-[A-Z0-9]{4,12}$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Lifecycle Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|met|missed|deferred|cancelled');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'decision_gate|deliverable|trl_assessment|regulatory_checkpoint');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Milestone Outcome');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'met|missed|deferred|partial|cancelled');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `phase` SET TAGS ('dbx_business_glossary_term' = 'R&D Program Phase');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `phase` SET TAGS ('dbx_value_regex' = 'discovery|lead_optimization|preclinical|clinical|regulatory|commercialization');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Milestone Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `prior_trl_score` SET TAGS ('dbx_business_glossary_term' = 'Prior Technology Readiness Level (TRL) Score');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Milestone Priority');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `rd_spend_recognized` SET TAGS ('dbx_business_glossary_term' = 'R&D Spend Recognized at Milestone');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `rd_spend_recognized` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `regulatory_submission_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone Review Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `revised_target_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Target Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_business_glossary_term' = 'SAP Work Breakdown Structure (WBS) Element');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `schedule_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance in Days');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `spend_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Spend Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `spend_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `success_criteria` SET TAGS ('dbx_business_glossary_term' = 'Milestone Success Criteria');
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ALTER COLUMN `trl_score` SET TAGS ('dbx_business_glossary_term' = 'Technology Readiness Level (TRL) Score');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` SET TAGS ('dbx_subdomain' = 'experiment_operations');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Asset Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `crispr_construct_id` SET TAGS ('dbx_business_glossary_term' = 'Crispr Construct Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Deviation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Scientist Employee ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Sample Batch ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `research_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Protocol ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `sample_specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Specimen Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Regulatory Document ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Experiment Cost (USD)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Experiment End Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Experiment Start Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `benchling_eln_entry_reference` SET TAGS ('dbx_business_glossary_term' = 'Benchling Electronic Lab Notebook (ELN) Entry ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `crispr_guide_rna_sequence` SET TAGS ('dbx_business_glossary_term' = 'Clustered Regularly Interspaced Short Palindromic Repeats (CRISPR) Guide RNA Sequence');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `crispr_guide_rna_sequence` SET TAGS ('dbx_value_regex' = '^[ACGTUacgtu]{15,25}$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `crispr_guide_rna_sequence` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `data_integrity_signature` SET TAGS ('dbx_business_glossary_term' = 'Data Integrity Electronic Signature Hash');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `design_type` SET TAGS ('dbx_business_glossary_term' = 'Experimental Design Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `design_type` SET TAGS ('dbx_value_regex' = 'controlled|factorial|dose_response|observational|screening|comparative');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `eln_entry_type` SET TAGS ('dbx_business_glossary_term' = 'Electronic Lab Notebook (ELN) Entry Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `eln_entry_type` SET TAGS ('dbx_value_regex' = 'observation|result|protocol_execution|data_analysis');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Experiment Cost (USD)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `experiment_code` SET TAGS ('dbx_business_glossary_term' = 'Experiment Business Identifier Code');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `experiment_code` SET TAGS ('dbx_value_regex' = '^EXP-[A-Z0-9]{4,12}$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `experiment_status` SET TAGS ('dbx_business_glossary_term' = 'Experiment Lifecycle Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `experiment_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|failed|cancelled|on_hold');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `experiment_type` SET TAGS ('dbx_business_glossary_term' = 'Experiment Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Experiment Failure Reason');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `gxp_applicable` SET TAGS ('dbx_business_glossary_term' = 'Good Practice Regulations (GxP) Applicability Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `hypothesis` SET TAGS ('dbx_business_glossary_term' = 'Experiment Hypothesis');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `ip_disclosure_filed` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Disclosure Filed Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `lab_location_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Location ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `organism` SET TAGS ('dbx_business_glossary_term' = 'Experimental Organism / Model System');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `outcome_summary` SET TAGS ('dbx_business_glossary_term' = 'Experiment Outcome Summary');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Experiment End Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Experiment Start Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `primary_result_metric` SET TAGS ('dbx_business_glossary_term' = 'Primary Result Metric Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `primary_result_unit` SET TAGS ('dbx_business_glossary_term' = 'Primary Result Unit of Measure');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `primary_result_value` SET TAGS ('dbx_business_glossary_term' = 'Primary Result Value');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `publication_reference` SET TAGS ('dbx_business_glossary_term' = 'Scientific Publication Reference (DOI/PubMed ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `r_and_d_cost_center` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Cost Center Code');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `replicate_count` SET TAGS ('dbx_business_glossary_term' = 'Experimental Replicate Count');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Experiment Review Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'unreviewed|peer_reviewed|supervisor_approved|rejected');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `sample_count` SET TAGS ('dbx_business_glossary_term' = 'Experiment Sample Count');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `target_gene_symbol` SET TAGS ('dbx_business_glossary_term' = 'Target Gene Symbol');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `target_gene_symbol` SET TAGS ('dbx_value_regex' = '^[A-Z][A-Z0-9]{1,15}$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `technology_readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Technology Readiness Level (TRL)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Experiment Title');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` SET TAGS ('dbx_subdomain' = 'experiment_operations');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `research_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Controlled Document Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `metadata_schema_id` SET TAGS ('dbx_business_glossary_term' = 'Metadata Schema Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `quality_training_curriculum_id` SET TAGS ('dbx_business_glossary_term' = 'Training Curriculum ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `applicable_instruments` SET TAGS ('dbx_business_glossary_term' = 'Applicable Instrument Platforms');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `applicable_sample_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Sample Types');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Protocol Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Protocol Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|superseded|retired|on_hold');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Protocol Approver');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `assay_type` SET TAGS ('dbx_business_glossary_term' = 'Assay Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `authored_by` SET TAGS ('dbx_business_glossary_term' = 'Protocol Author');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `benchling_protocol_reference` SET TAGS ('dbx_business_glossary_term' = 'Benchling Protocol ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `change_summary` SET TAGS ('dbx_business_glossary_term' = 'Version Change Summary');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `clia_applicable` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Applicable');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `coverage_depth_target` SET TAGS ('dbx_business_glossary_term' = 'Target Coverage Depth');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Protocol Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Protocol Duration (Hours)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Protocol Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `external_reference_standard` SET TAGS ('dbx_business_glossary_term' = 'External Reference Standard');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `glp_compliant` SET TAGS ('dbx_business_glossary_term' = 'Good Laboratory Practice (GLP) Compliant');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `ip_generating` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Generating Protocol');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `ip_generating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `irb_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Required');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `lod` SET TAGS ('dbx_business_glossary_term' = 'Limit of Detection (LOD)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `mastercontrol_doc_reference` SET TAGS ('dbx_business_glossary_term' = 'MasterControl Document ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `owning_department` SET TAGS ('dbx_business_glossary_term' = 'Owning Department');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `patent_reference` SET TAGS ('dbx_business_glossary_term' = 'Patent Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `patent_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `principal_scientist` SET TAGS ('dbx_business_glossary_term' = 'Principal Scientist');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `protocol_category` SET TAGS ('dbx_business_glossary_term' = 'Protocol Category');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Protocol Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `protocol_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}-[A-Z]{2,8}-[0-9]{4,6}(-[0-9]{1,3})?$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `protocol_type` SET TAGS ('dbx_business_glossary_term' = 'Protocol Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `protocol_type` SET TAGS ('dbx_value_regex' = 'SOP|method|assay_protocol|work_instruction|reference_method|study_plan');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `read_length` SET TAGS ('dbx_business_glossary_term' = 'Read Length');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `required_reagent_skus` SET TAGS ('dbx_business_glossary_term' = 'Required Reagent Stock Keeping Units (SKUs)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Protocol Reviewer');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Biosafety Level (BSL) Classification');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `safety_classification` SET TAGS ('dbx_value_regex' = 'BSL1|BSL2|BSL3|BSL4|non_hazardous');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Protocol Short Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `superseded_version_number` SET TAGS ('dbx_business_glossary_term' = 'Superseded Version Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `superseded_version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `technology_platform` SET TAGS ('dbx_business_glossary_term' = 'Technology Platform');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Protocol Title');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Required');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Protocol Validation Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Protocol Validation Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'not_validated|in_validation|validated|qualified|transferred');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` SET TAGS ('dbx_subdomain' = 'experiment_operations');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `crispr_construct_id` SET TAGS ('dbx_business_glossary_term' = 'CRISPR Construct Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `gene_model_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research Project Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `benchling_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Benchling Entity Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `cas_protein_variant` SET TAGS ('dbx_business_glossary_term' = 'Cas Protein Variant');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `cell_type` SET TAGS ('dbx_business_glossary_term' = 'Target Cell Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `construct_code` SET TAGS ('dbx_business_glossary_term' = 'Construct Code');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `construct_length_bp` SET TAGS ('dbx_business_glossary_term' = 'Construct Length in Base Pairs (bp)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `construct_name` SET TAGS ('dbx_business_glossary_term' = 'Construct Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `construct_type` SET TAGS ('dbx_business_glossary_term' = 'Construct Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `construct_type` SET TAGS ('dbx_value_regex' = 'crispr_grna|cas_variant|plasmid|oligo|gene_fragment|expression_vector');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `delivery_format` SET TAGS ('dbx_business_glossary_term' = 'Delivery Format');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `delivery_format` SET TAGS ('dbx_value_regex' = 'plasmid|rnp|lnp|aav|lentiviral|electroporation');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `design_rationale` SET TAGS ('dbx_business_glossary_term' = 'Design Rationale');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `design_status` SET TAGS ('dbx_business_glossary_term' = 'Design Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `design_status` SET TAGS ('dbx_value_regex' = 'draft|reviewed|approved|deprecated|archived');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `design_tool` SET TAGS ('dbx_business_glossary_term' = 'Design Tool or Algorithm');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `development_stage` SET TAGS ('dbx_business_glossary_term' = 'Development Stage');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `development_stage` SET TAGS ('dbx_value_regex' = 'discovery|lead_optimization|preclinical|clinical|commercial');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `editing_modality` SET TAGS ('dbx_business_glossary_term' = 'Editing Modality');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `editing_modality` SET TAGS ('dbx_value_regex' = 'knockout|knock_in|base_edit|prime_edit|activation|repression');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `gc_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Guanine-Cytosine (GC) Content Percentage');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `genomic_coordinates` SET TAGS ('dbx_business_glossary_term' = 'Genomic Coordinates');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `grna_sequence` SET TAGS ('dbx_business_glossary_term' = 'Guide RNA (gRNA) Sequence');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `grna_sequence` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `ip_status` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `ip_status` SET TAGS ('dbx_value_regex' = 'public|proprietary|patent_pending|patented|licensed_in|licensed_out');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `ip_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Construct Notes');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `off_target_score` SET TAGS ('dbx_business_glossary_term' = 'Off-Target Score');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `on_target_efficiency_score` SET TAGS ('dbx_business_glossary_term' = 'On-Target Efficiency Score');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `pam_sequence` SET TAGS ('dbx_business_glossary_term' = 'Protospacer Adjacent Motif (PAM) Sequence');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `patent_reference` SET TAGS ('dbx_business_glossary_term' = 'Patent Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `patent_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `plasmid_backbone` SET TAGS ('dbx_business_glossary_term' = 'Plasmid Backbone');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `principal_investigator` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `promoter_element` SET TAGS ('dbx_business_glossary_term' = 'Promoter Element');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `selection_marker` SET TAGS ('dbx_business_glossary_term' = 'Selection Marker');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `sequence_data_reference` SET TAGS ('dbx_business_glossary_term' = 'Sequence Data Reference');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `species` SET TAGS ('dbx_business_glossary_term' = 'Target Species');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `synthesis_date` SET TAGS ('dbx_business_glossary_term' = 'Synthesis Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `synthesis_vendor` SET TAGS ('dbx_business_glossary_term' = 'Synthesis Vendor');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `target_locus` SET TAGS ('dbx_business_glossary_term' = 'Target Locus');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'not_tested|in_vitro_validated|in_vivo_validated|failed|inconclusive');
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` SET TAGS ('dbx_subdomain' = 'experiment_operations');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `assay_development_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Development Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Controlled Document Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `irb_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Irb Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `metadata_schema_id` SET TAGS ('dbx_business_glossary_term' = 'Metadata Schema Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `rd_capitalization_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Capitalization Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `validation_study_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Study Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `variant_database_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Database Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `analytical_sensitivity_percent` SET TAGS ('dbx_business_glossary_term' = 'Analytical Sensitivity Percentage');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `analytical_specificity_percent` SET TAGS ('dbx_business_glossary_term' = 'Analytical Specificity Percentage');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `assay_code` SET TAGS ('dbx_business_glossary_term' = 'Assay Code');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `assay_name` SET TAGS ('dbx_business_glossary_term' = 'Assay Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `assay_type` SET TAGS ('dbx_business_glossary_term' = 'Assay Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `assay_type` SET TAGS ('dbx_value_regex' = 'NGS Panel|qPCR|SNP Genotyping Array|CNV Detection|Methylation|CRISPR Editing Efficiency');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `commercialization_date` SET TAGS ('dbx_business_glossary_term' = 'Commercialization Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `coverage_depth_target` SET TAGS ('dbx_business_glossary_term' = 'Coverage Depth Target');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `development_phase` SET TAGS ('dbx_business_glossary_term' = 'Development Phase');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `development_phase` SET TAGS ('dbx_value_regex' = 'Feasibility|Optimization|Pre-Validation|Analytical Validation|Clinical Validation|Commercialization');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `development_start_date` SET TAGS ('dbx_business_glossary_term' = 'Development Start Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `development_status` SET TAGS ('dbx_business_glossary_term' = 'Development Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `development_status` SET TAGS ('dbx_value_regex' = 'Active|On Hold|Completed|Cancelled|Transferred');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `estimated_cogs` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost of Goods Sold (COGS)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `estimated_cogs` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `feasibility_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Feasibility Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `intended_use` SET TAGS ('dbx_business_glossary_term' = 'Intended Use');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `ip_status` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `ip_status` SET TAGS ('dbx_value_regex' = 'Patent Pending|Patent Granted|Trade Secret|No IP|Licensed');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `ip_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `lod_unit` SET TAGS ('dbx_business_glossary_term' = 'Limit of Detection (LOD) Unit of Measure');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `lod_value` SET TAGS ('dbx_business_glossary_term' = 'Limit of Detection (LOD) Value');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `loq_unit` SET TAGS ('dbx_business_glossary_term' = 'Limit of Quantification (LOQ) Unit of Measure');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `loq_value` SET TAGS ('dbx_business_glossary_term' = 'Limit of Quantification (LOQ) Value');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `multiplexing_capacity` SET TAGS ('dbx_business_glossary_term' = 'Multiplexing Capacity');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `panel_size` SET TAGS ('dbx_business_glossary_term' = 'Panel Size');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `patent_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `patent_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `precision_cv_percent` SET TAGS ('dbx_business_glossary_term' = 'Precision Coefficient of Variation (CV) Percentage');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `publication_reference` SET TAGS ('dbx_business_glossary_term' = 'Publication Reference');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `rd_budget_allocated` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Budget Allocated');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `rd_budget_allocated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `rd_spend_to_date` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Spend to Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `rd_spend_to_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `read_length` SET TAGS ('dbx_business_glossary_term' = 'Read Length');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'IVD|RUO|LDT');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `regulatory_pathway` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Pathway');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `reproducibility_assessment` SET TAGS ('dbx_business_glossary_term' = 'Reproducibility Assessment');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `target_analyte` SET TAGS ('dbx_business_glossary_term' = 'Target Analyte or Biomarker');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `target_asp` SET TAGS ('dbx_business_glossary_term' = 'Target Average Selling Price (ASP)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `target_asp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `target_tat_hours` SET TAGS ('dbx_business_glossary_term' = 'Target Turnaround Time (TAT) in Hours');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `technology_platform` SET TAGS ('dbx_business_glossary_term' = 'Technology Platform');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `technology_readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Technology Readiness Level (TRL)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ALTER COLUMN `validation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` SET TAGS ('dbx_subdomain' = 'funding_compliance');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `spend_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Identifier');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `capex_request_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Request Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `collaboration_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Agreement ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `compute_job_id` SET TAGS ('dbx_business_glossary_term' = 'Compute Job ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Spend Amount');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `amount_local` SET TAGS ('dbx_business_glossary_term' = 'Spend Amount in Local Currency');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|posted');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `budget_line_item_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Item ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `capitalization_eligible` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Eligible Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `capitalization_status` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `capitalization_status` SET TAGS ('dbx_value_regex' = 'expensed|capitalized|pending_review|deferred');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|partially_paid|paid|overdue');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `spend_date` SET TAGS ('dbx_business_glossary_term' = 'Spend Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `spend_description` SET TAGS ('dbx_business_glossary_term' = 'Spend Description');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `spend_number` SET TAGS ('dbx_business_glossary_term' = 'Spend Transaction Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` SET TAGS ('dbx_subdomain' = 'funding_compliance');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `collaboration_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Agreement Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Benchling Project Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `channel_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Partner Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Genomics Biotech Program Manager Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `genomic_access_control_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Access Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `irb_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Irb Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4,8}$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `agreement_title` SET TAGS ('dbx_business_glossary_term' = 'Agreement Title');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'sponsored_research|co_development|licensing_in|material_transfer|data_sharing|consortium_membership');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `collaboration_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `confidentiality_tier` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Tier');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `confidentiality_tier` SET TAGS ('dbx_value_regex' = 'standard|high|critical');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `data_sharing_obligation` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Obligation');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `data_sharing_obligation` SET TAGS ('dbx_value_regex' = 'full_sharing|limited_sharing|no_sharing|upon_request');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `data_use_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Data Use Restrictions');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_value_regex' = 'exclusive|non_exclusive|co_exclusive|field_limited_exclusive');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `grant_funding_source` SET TAGS ('dbx_business_glossary_term' = 'Grant Funding Source');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `gxp_applicable` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Regulations Applicable');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `ip_ownership_model` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Ownership Model');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `ip_ownership_model` SET TAGS ('dbx_value_regex' = 'genomics_biotech_owns|partner_owns|joint_ownership|background_foreground_split|case_by_case');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `ip_ownership_model` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `irb_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Required');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `licensing_rights` SET TAGS ('dbx_business_glossary_term' = 'Licensing Rights');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `licensing_rights` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `payment_structure` SET TAGS ('dbx_business_glossary_term' = 'Payment Structure');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `payment_structure` SET TAGS ('dbx_value_regex' = 'lump_sum|milestone_based|periodic|cost_reimbursement|hybrid');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `phi_involved` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Involved');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `publication_embargo_days` SET TAGS ('dbx_business_glossary_term' = 'Publication Embargo Days');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `publication_rights` SET TAGS ('dbx_business_glossary_term' = 'Publication Rights');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `publication_rights` SET TAGS ('dbx_value_regex' = 'unrestricted|review_required|embargo_period|restricted');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `regulatory_submission_planned` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Planned');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `research_focus` SET TAGS ('dbx_business_glossary_term' = 'Research Focus');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `sap_contract_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Contract Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `sponsoring_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Business Unit');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `target_indication` SET TAGS ('dbx_business_glossary_term' = 'Target Indication');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `technology_area` SET TAGS ('dbx_business_glossary_term' = 'Technology Area');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `total_funding_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Funding Amount (United States Dollar - USD)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ALTER COLUMN `total_funding_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` SET TAGS ('dbx_subdomain' = 'funding_compliance');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `irb_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Submission Identifier');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Benchling Project Identifier');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `genomic_access_control_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Access Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Identifier');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project Identifier');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `adverse_event_count` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Count');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'IRB Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `approval_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'IRB Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `clinical_trial_registration_number` SET TAGS ('dbx_business_glossary_term' = 'ClinicalTrials.gov Registration Number (NCT)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `clinical_trial_registration_number` SET TAGS ('dbx_value_regex' = '^NCT[0-9]{8}$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Study Closure Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `consent_form_version` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Form Version');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `continuing_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Continuing Review Due Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `data_privacy_impact_assessment_completed` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Impact Assessment (DPIA) Completed Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `data_repository_name` SET TAGS ('dbx_business_glossary_term' = 'Data Repository Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `estimated_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Estimated Subject Enrollment');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'internal|nih_grant|industry_sponsored|foundation_grant|other_federal|unfunded');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Applicable Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `genomic_data_sharing_required` SET TAGS ('dbx_business_glossary_term' = 'Genomic Data Sharing Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `hipaa_waiver_status` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Waiver Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `hipaa_waiver_status` SET TAGS ('dbx_value_regex' = 'not_applicable|waiver_granted|waiver_denied|alteration_granted|no_waiver_requested');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `irb_board_name` SET TAGS ('dbx_business_glossary_term' = 'IRB Board Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `irb_board_registration_number` SET TAGS ('dbx_business_glossary_term' = 'IRB Board Registration Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `last_continuing_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Continuing Review Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `phi_handling_classification` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Handling Classification');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `phi_handling_classification` SET TAGS ('dbx_value_regex' = 'no_phi|limited_data_set|identifiable_phi|de_identified');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `protocol_title` SET TAGS ('dbx_business_glossary_term' = 'Research Protocol Title');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `protocol_version` SET TAGS ('dbx_value_regex' = '^v?[0-9]+.[0-9]+$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'IRB Review Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'full_board|expedited|exempt_determination|continuing_review');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Risk Classification');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `risk_classification` SET TAGS ('dbx_value_regex' = 'minimal_risk|greater_than_minimal_risk|exempt');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `serious_adverse_event_count` SET TAGS ('dbx_business_glossary_term' = 'Serious Adverse Event (SAE) Count');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `study_coordinator_name` SET TAGS ('dbx_business_glossary_term' = 'Study Coordinator Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `study_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Study Duration in Months');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Study Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'observational|interventional|genomic_data_analysis|biospecimen_collection|registry|retrospective_chart_review');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'IRB Submission Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_value_regex' = '^IRB-[0-9]{4}-[0-9]{4,6}$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `veeva_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document Identifier');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `vulnerable_population_involved` SET TAGS ('dbx_business_glossary_term' = 'Vulnerable Population Involved Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ALTER COLUMN `vulnerable_population_type` SET TAGS ('dbx_business_glossary_term' = 'Vulnerable Population Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` SET TAGS ('dbx_subdomain' = 'intellectual_property');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `ip_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Disclosure Identifier');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `collaboration_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Agreement Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Inventor Identifier');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project Identifier');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document Identifier');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `assigned_ip_counsel` SET TAGS ('dbx_business_glossary_term' = 'Assigned Intellectual Property (IP) Counsel');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `benchling_entry_reference` SET TAGS ('dbx_business_glossary_term' = 'Benchling Electronic Lab Notebook (ELN) Entry Identifier');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `commercial_potential` SET TAGS ('dbx_business_glossary_term' = 'Commercial Potential');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `commercial_potential` SET TAGS ('dbx_value_regex' = 'high|medium|low|unknown');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `competitive_advantage` SET TAGS ('dbx_business_glossary_term' = 'Competitive Advantage');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `competitive_advantage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `disclosure_code` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Disclosure Code');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `disclosure_code` SET TAGS ('dbx_value_regex' = '^IPD-[0-9]{6}$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `estimated_filing_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Filing Cost (United States Dollars)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `estimated_filing_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `filing_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Decision Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `filing_decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Filing Decision Rationale');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `filing_decision_rationale` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'internal|government_grant|private_grant|collaboration|mixed');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `government_interest_statement` SET TAGS ('dbx_business_glossary_term' = 'Government Interest Statement');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `invention_description` SET TAGS ('dbx_business_glossary_term' = 'Invention Description');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `invention_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `invention_type` SET TAGS ('dbx_business_glossary_term' = 'Invention Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `invention_type` SET TAGS ('dbx_value_regex' = 'composition_of_matter|method|process|software|apparatus|design');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `inventors` SET TAGS ('dbx_business_glossary_term' = 'Inventors');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `inventors` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `inventors` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `ip_counsel_firm` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Counsel Firm');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `joint_ownership_flag` SET TAGS ('dbx_business_glossary_term' = 'Joint Ownership Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `novelty_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Novelty Assessment Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `novelty_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Novelty Assessment Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `novelty_assessment_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|novel|not_novel|uncertain');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `novelty_rationale` SET TAGS ('dbx_business_glossary_term' = 'Novelty Rationale');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `novelty_rationale` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `patent_application_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Application Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `patent_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `patent_filing_decision` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Decision');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `patent_filing_decision` SET TAGS ('dbx_value_regex' = 'file_patent|abandon|trade_secret|defensive_publication|pending_decision');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `patent_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Patent Jurisdiction');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `prior_art_references` SET TAGS ('dbx_business_glossary_term' = 'Prior Art References');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `prior_art_references` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `prior_art_search_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Art Search Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `prior_art_search_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Art Search Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `prior_art_search_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|no_blocking_art|blocking_art_found');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `public_disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `publication_reference` SET TAGS ('dbx_business_glossary_term' = 'Publication Reference');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `regulatory_impact` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `regulatory_impact` SET TAGS ('dbx_value_regex' = 'none|low|medium|high');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `strategic_importance` SET TAGS ('dbx_business_glossary_term' = 'Strategic Importance');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `strategic_importance` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `target_product_application` SET TAGS ('dbx_business_glossary_term' = 'Target Product Application');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `technology_area` SET TAGS ('dbx_business_glossary_term' = 'Technology Area');
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Title');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` SET TAGS ('dbx_subdomain' = 'intellectual_property');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `publication_id` SET TAGS ('dbx_business_glossary_term' = 'Publication Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Benchling Project Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `collaboration_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Agreement Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `fair_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Fair Assessment Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `ip_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Disclosure Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `abstract` SET TAGS ('dbx_business_glossary_term' = 'Publication Abstract');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `authors` SET TAGS ('dbx_business_glossary_term' = 'Author List');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `citation_count` SET TAGS ('dbx_business_glossary_term' = 'Citation Count');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `collaboration_type` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `collaboration_type` SET TAGS ('dbx_value_regex' = 'internal|academic|industry|government|consortium');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `conference_name` SET TAGS ('dbx_business_glossary_term' = 'Conference Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `corresponding_author_email` SET TAGS ('dbx_business_glossary_term' = 'Corresponding Author Email Address');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `corresponding_author_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `corresponding_author_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `corresponding_author_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `corresponding_author_name` SET TAGS ('dbx_business_glossary_term' = 'Corresponding Author Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `data_repository_url` SET TAGS ('dbx_business_glossary_term' = 'Data Repository Uniform Resource Locator (URL)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `data_sharing_required` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `doi` SET TAGS ('dbx_business_glossary_term' = 'Digital Object Identifier (DOI)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `doi` SET TAGS ('dbx_value_regex' = '^10.d{4,9}/[-._;()/:A-Za-z0-9]+$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `embargo_end_date` SET TAGS ('dbx_business_glossary_term' = 'Embargo End Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `embargo_flag` SET TAGS ('dbx_business_glossary_term' = 'Embargo Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `external_author_count` SET TAGS ('dbx_business_glossary_term' = 'External Author Count');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `first_author_name` SET TAGS ('dbx_business_glossary_term' = 'First Author Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `impact_factor` SET TAGS ('dbx_business_glossary_term' = 'Journal Impact Factor');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `internal_author_count` SET TAGS ('dbx_business_glossary_term' = 'Internal Author Count');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `ip_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Clearance Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `ip_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Clearance Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `ip_clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|restricted|blocked');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `journal_name` SET TAGS ('dbx_business_glossary_term' = 'Journal Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Publication Keywords');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `open_access_classification` SET TAGS ('dbx_business_glossary_term' = 'Open Access Classification');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `open_access_classification` SET TAGS ('dbx_value_regex' = 'gold|green|hybrid|bronze|closed');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `preprint_server` SET TAGS ('dbx_business_glossary_term' = 'Preprint Server');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `preprint_server` SET TAGS ('dbx_value_regex' = 'bioRxiv|medRxiv|arXiv|other');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `publication_code` SET TAGS ('dbx_business_glossary_term' = 'Publication Code');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `publication_code` SET TAGS ('dbx_value_regex' = '^PUB-[A-Z0-9]{8,12}$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `publication_status` SET TAGS ('dbx_business_glossary_term' = 'Publication Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `publication_type` SET TAGS ('dbx_business_glossary_term' = 'Publication Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `publication_type` SET TAGS ('dbx_value_regex' = 'peer_reviewed_journal|conference_abstract|conference_presentation|preprint|review_article|book_chapter');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `pubmed_identifier` SET TAGS ('dbx_business_glossary_term' = 'PubMed Identifier (PMID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `pubmed_identifier` SET TAGS ('dbx_value_regex' = '^d{7,8}$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `regulatory_submission_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `target_indication` SET TAGS ('dbx_business_glossary_term' = 'Target Indication');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `technology_area` SET TAGS ('dbx_business_glossary_term' = 'Technology Area');
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Publication Title');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` SET TAGS ('dbx_subdomain' = 'funding_compliance');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `trl_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Readiness Level (TRL) Assessment ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `review_board_id` SET TAGS ('dbx_business_glossary_term' = 'Review Board ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `technology_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Technology ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `advancement_criteria` SET TAGS ('dbx_business_glossary_term' = 'Advancement Criteria');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `assessment_code` SET TAGS ('dbx_business_glossary_term' = 'TRL Assessment Code');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `assessment_code` SET TAGS ('dbx_value_regex' = '^TRL-[A-Z0-9]{6,12}$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `assessment_rationale` SET TAGS ('dbx_business_glossary_term' = 'Assessment Rationale');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|rejected|superseded');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'periodic|milestone|gate_review|ad_hoc|regulatory_triggered|partner_requested');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `assessor_role` SET TAGS ('dbx_business_glossary_term' = 'Assessor Role');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `benchling_entry_reference` SET TAGS ('dbx_business_glossary_term' = 'Benchling Entry ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `collaboration_partner` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Partner');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `estimated_commercialization_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Commercialization Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `evidence_artifacts` SET TAGS ('dbx_business_glossary_term' = 'Evidence Artifacts');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `gate_decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Gate Decision Rationale');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `gate_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Gate Review Outcome');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `gate_review_outcome` SET TAGS ('dbx_value_regex' = 'proceed|conditional_proceed|hold|terminate|pivot');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `gxp_applicable` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Applicable');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `ip_status` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `next_assessment_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Planned Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `next_trl_target` SET TAGS ('dbx_business_glossary_term' = 'Next TRL Target');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `patent_application_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Application Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `patent_application_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `prior_trl_score` SET TAGS ('dbx_business_glossary_term' = 'Prior Technology Readiness Level (TRL) Score');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `regulatory_pathway` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Pathway');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `regulatory_submission_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Required');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `risk_assessment_summary` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Summary');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `target_market_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Market Segment');
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ALTER COLUMN `trl_score` SET TAGS ('dbx_business_glossary_term' = 'Technology Readiness Level (TRL) Score');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` SET TAGS ('dbx_subdomain' = 'funding_compliance');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `grant_principal_investigator_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend (United States Dollar)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `application_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Application Submission Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `associated_rd_project_ids` SET TAGS ('dbx_business_glossary_term' = 'Associated Research and Development (R&D) Project Identifiers (IDs)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `award_type` SET TAGS ('dbx_business_glossary_term' = 'Award Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `co_investigator_names` SET TAGS ('dbx_business_glossary_term' = 'Co-Investigator Names');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `compliance_obligations` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligations');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `current_budget_period_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Current Budget Period Amount (United States Dollar)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `current_budget_period_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `current_budget_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Current Budget Period End Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `current_budget_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Current Budget Period Start Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `data_sharing_required` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `direct_costs_usd` SET TAGS ('dbx_business_glossary_term' = 'Direct Costs (United States Dollar)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `direct_costs_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `final_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Final Report Due Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `funding_agency` SET TAGS ('dbx_business_glossary_term' = 'Funding Agency');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `funding_agency_division` SET TAGS ('dbx_business_glossary_term' = 'Funding Agency Division');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `grant_number` SET TAGS ('dbx_business_glossary_term' = 'Grant Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_business_glossary_term' = 'Grant Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_value_regex' = 'pending|active|suspended|closed|terminated');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `iacuc_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Animal Care and Use Committee (IACUC) Approval Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `indirect_cost_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (Percent)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `indirect_cost_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `indirect_costs_usd` SET TAGS ('dbx_business_glossary_term' = 'Indirect Costs (United States Dollar)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `indirect_costs_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `last_report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Last Report Submission Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `next_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Report Due Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `patent_count` SET TAGS ('dbx_business_glossary_term' = 'Patent Count');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `program_officer_email` SET TAGS ('dbx_business_glossary_term' = 'Program Officer Email Address');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `program_officer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `program_officer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `program_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Program Officer Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `project_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Project Period End Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `project_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Period Start Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `publication_count` SET TAGS ('dbx_business_glossary_term' = 'Publication Count');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `remaining_balance_usd` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance (United States Dollar)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `remaining_balance_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `reporting_schedule` SET TAGS ('dbx_business_glossary_term' = 'Reporting Schedule');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `reporting_schedule` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|final_only');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `sap_grant_fund_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Grant Fund Code');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `sap_wbs_element` SET TAGS ('dbx_business_glossary_term' = 'SAP Work Breakdown Structure (WBS) Element');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `sponsoring_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Business Unit');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Grant Title');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `total_award_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Award Amount (United States Dollar)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `total_award_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ALTER COLUMN `veeva_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` SET TAGS ('dbx_subdomain' = 'funding_compliance');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `grant_report_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Report Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `actual_expenditure_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Expenditure (United States Dollars - USD)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `actual_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Submission Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `agency_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Acknowledgment Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `agency_acknowledgment_reference` SET TAGS ('dbx_business_glossary_term' = 'Agency Acknowledgment Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `agency_program_officer` SET TAGS ('dbx_business_glossary_term' = 'Agency Program Officer Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `audit_ready` SET TAGS ('dbx_business_glossary_term' = 'Audit Ready Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `budget_expenditure_summary` SET TAGS ('dbx_business_glossary_term' = 'Budget Expenditure Summary');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `budget_variance_usd` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance (United States Dollars - USD)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `compliance_issues_description` SET TAGS ('dbx_business_glossary_term' = 'Compliance Issues Description');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `compliance_issues_identified` SET TAGS ('dbx_business_glossary_term' = 'Compliance Issues Identified Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `data_sharing_compliance` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Compliance Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `data_sharing_compliance` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|not_applicable|in_progress');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `equipment_costs_usd` SET TAGS ('dbx_business_glossary_term' = 'Equipment Costs (United States Dollars - USD)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `funding_agency` SET TAGS ('dbx_business_glossary_term' = 'Funding Agency Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `indirect_costs_usd` SET TAGS ('dbx_business_glossary_term' = 'Indirect Costs (Facilities and Administrative - F&A) (United States Dollars - USD)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `irb_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `irb_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|not_required|expired|suspended');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `key_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Key Findings Summary');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `milestone_achievement_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Achievement Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `milestone_achievement_status` SET TAGS ('dbx_value_regex' = 'on_track|ahead_of_schedule|delayed|at_risk|completed');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `milestones_completed_count` SET TAGS ('dbx_business_glossary_term' = 'Milestones Completed Count');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `milestones_planned_count` SET TAGS ('dbx_business_glossary_term' = 'Milestones Planned Count');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `next_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Report Due Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `other_direct_costs_usd` SET TAGS ('dbx_business_glossary_term' = 'Other Direct Costs (United States Dollars - USD)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `patent_applications_count` SET TAGS ('dbx_business_glossary_term' = 'Patent Applications Count');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `personnel_costs_usd` SET TAGS ('dbx_business_glossary_term' = 'Personnel Costs (United States Dollars - USD)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `publications_count` SET TAGS ('dbx_business_glossary_term' = 'Publications Count');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `report_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Report Approved By');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `report_prepared_by` SET TAGS ('dbx_business_glossary_term' = 'Report Prepared By');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Grant Report Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `submission_due_date` SET TAGS ('dbx_business_glossary_term' = 'Report Submission Due Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `supplies_costs_usd` SET TAGS ('dbx_business_glossary_term' = 'Supplies and Consumables Costs (United States Dollars - USD)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ALTER COLUMN `total_budget_allocated_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Allocated (United States Dollars - USD)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` SET TAGS ('dbx_subdomain' = 'project_management');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `research_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Budget ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner Employee ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `primary_research_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `primary_research_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `primary_research_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Program ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount in United States Dollars (USD)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `approving_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority Level');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `approving_authority_level` SET TAGS ('dbx_value_regex' = 'project_manager|program_director|vp_research|cfo|ceo|board');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_value_regex' = '^RDB-[A-Z0-9]{6,12}$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|locked');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `capitalization_eligible` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Eligible Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `capitalization_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Rate Percentage');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `collaboration_type` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `collaboration_type` SET TAGS ('dbx_value_regex' = 'internal|external_partner|grant_funded|consortium|contract_research');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^CC-[A-Z0-9]{4,8}$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `external_partner_name` SET TAGS ('dbx_business_glossary_term' = 'External Partner Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^(Q[1-4]|H[1-2]|FY|M(0[1-9]|1[0-2]))$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `technology_area` SET TAGS ('dbx_business_glossary_term' = 'Technology Area');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `variance_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Amount');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `variance_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percentage');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = 'initial|revised|final|forecast|reforecast');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `wbs_element` SET TAGS ('dbx_value_regex' = '^WBS-[A-Z0-9]{6,12}$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` SET TAGS ('dbx_subdomain' = 'experiment_operations');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `molecular_design_id` SET TAGS ('dbx_business_glossary_term' = 'Molecular Design Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `gene_model_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `benchling_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Benchling Entity Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `design_algorithm_version` SET TAGS ('dbx_business_glossary_term' = 'Design Algorithm Version');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `design_code` SET TAGS ('dbx_business_glossary_term' = 'Molecular Design Code');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `design_name` SET TAGS ('dbx_business_glossary_term' = 'Molecular Design Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `design_rationale` SET TAGS ('dbx_business_glossary_term' = 'Design Rationale');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `design_status` SET TAGS ('dbx_business_glossary_term' = 'Molecular Design Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `design_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|validated|deprecated|archived');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `design_tool` SET TAGS ('dbx_business_glossary_term' = 'Design Tool or Algorithm');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `design_type` SET TAGS ('dbx_business_glossary_term' = 'Molecular Design Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `design_type` SET TAGS ('dbx_value_regex' = 'plasmid|oligo|gRNA|primer|gene_fragment|expression_vector');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `gc_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Guanine-Cytosine (GC) Content Percentage');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `genomic_coordinates` SET TAGS ('dbx_business_glossary_term' = 'Genomic Coordinates');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `intended_application` SET TAGS ('dbx_business_glossary_term' = 'Intended Application');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `ip_disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Disclosure Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `ip_status` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `ip_status` SET TAGS ('dbx_value_regex' = 'not_protected|disclosure_filed|patent_pending|patented');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `melting_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Melting Temperature in Celsius');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modification Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `off_target_score` SET TAGS ('dbx_business_glossary_term' = 'Off-Target Risk Score');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `on_target_efficiency_score` SET TAGS ('dbx_business_glossary_term' = 'On-Target Efficiency Score');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `organism_strain` SET TAGS ('dbx_business_glossary_term' = 'Organism Strain or Cell Line');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `patent_reference` SET TAGS ('dbx_business_glossary_term' = 'Patent Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `qc_method` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Method');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'RUO|IVD|GMP|clinical_grade|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `sequence_data_reference` SET TAGS ('dbx_business_glossary_term' = 'Sequence Data Reference');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `sequence_length_bp` SET TAGS ('dbx_business_glossary_term' = 'Sequence Length in Base Pairs (bp)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `species` SET TAGS ('dbx_business_glossary_term' = 'Target Species');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Physical Storage Location');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `storage_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature in Celsius');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `synthesis_date` SET TAGS ('dbx_business_glossary_term' = 'Synthesis Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `synthesis_method` SET TAGS ('dbx_business_glossary_term' = 'Synthesis Method');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `synthesis_vendor` SET TAGS ('dbx_business_glossary_term' = 'Synthesis Vendor Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `target_locus` SET TAGS ('dbx_business_glossary_term' = 'Target Genomic Locus');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'not_validated|in_validation|validated|failed_validation');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `veeva_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` SET TAGS ('dbx_subdomain' = 'experiment_operations');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `notebook_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Notebook Entry ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Asset Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `bioinformatics_pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Deviation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `extraction_id` SET TAGS ('dbx_business_glossary_term' = 'Extraction Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Sample Batch ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Author ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `research_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `author_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `author_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `benchling_entry_reference` SET TAGS ('dbx_business_glossary_term' = 'Benchling Entry ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `collaboration_partner` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Partner');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `content_summary` SET TAGS ('dbx_business_glossary_term' = 'Content Summary');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `data_artifact_reference` SET TAGS ('dbx_business_glossary_term' = 'Data Artifact Reference');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `data_integrity_signature` SET TAGS ('dbx_business_glossary_term' = 'Data Integrity Signature');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `entry_code` SET TAGS ('dbx_business_glossary_term' = 'Entry Code');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'Entry Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|archived');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Entry Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_value_regex' = 'observation|result|protocol_execution|data_analysis|hypothesis|conclusion');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `gxp_applicable` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Applicable');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `ip_classification` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Classification');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `ip_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|trade_secret');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `ip_disclosure_filed` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Disclosure Filed');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `lab_location` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Location');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `observation_text` SET TAGS ('dbx_business_glossary_term' = 'Observation Text');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `patent_reference` SET TAGS ('dbx_business_glossary_term' = 'Patent Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `phi_involved` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Involved');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `publication_reference` SET TAGS ('dbx_business_glossary_term' = 'Publication Reference');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `reagent_lot_numbers` SET TAGS ('dbx_business_glossary_term' = 'Reagent Lot Numbers');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `result_unit` SET TAGS ('dbx_business_glossary_term' = 'Result Unit of Measure');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `result_value` SET TAGS ('dbx_business_glossary_term' = 'Result Value');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'unreviewed|peer_reviewed|supervisor_approved|rejected');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Entry Tags');
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Entry Title');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` SET TAGS ('dbx_subdomain' = 'experiment_operations');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `material_request_id` SET TAGS ('dbx_business_glossary_term' = 'Material Request Identifier');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester Employee ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `sample_specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Specimen Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost United States Dollars (USD)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `actual_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Receipt Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `benchling_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Benchling Entity ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `consent_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Verification Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `consent_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|not_required|not_verified');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost United States Dollars (USD)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `fulfillment_date` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `fulfillment_source` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Source');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `fulfillment_source` SET TAGS ('dbx_value_regex' = 'internal_inventory|biobank|external_vendor|custom_synthesis|collaboration_partner|other');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `intended_experiment_description` SET TAGS ('dbx_business_glossary_term' = 'Intended Experiment Description');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `irb_protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Protocol Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `lims_sample_reference` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Sample ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `phi_involved` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Involved');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `quantity_fulfilled` SET TAGS ('dbx_business_glossary_term' = 'Quantity Fulfilled');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Material Request Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `requester_name` SET TAGS ('dbx_business_glossary_term' = 'Requester Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `required_by_date` SET TAGS ('dbx_business_glossary_term' = 'Required By Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `specification_details` SET TAGS ('dbx_business_glossary_term' = 'Specification Details');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `urgency_level` SET TAGS ('dbx_business_glossary_term' = 'Urgency Level');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `urgency_level` SET TAGS ('dbx_value_regex' = 'routine|urgent|critical|emergency');
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` SET TAGS ('dbx_subdomain' = 'intellectual_property');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `technology_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Transfer Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Benchling Project Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Transfer Lead Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost in United States Dollars (USD)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `capa_count` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Count');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost in United States Dollars (USD)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `gxp_applicable` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Applicable Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Technology Transfer Initiation Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `ip_status` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Technology Transfer Notes');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `originating_site` SET TAGS ('dbx_business_glossary_term' = 'Originating Site');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `originating_team` SET TAGS ('dbx_business_glossary_term' = 'Originating Team');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `patent_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `patent_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `protocol_count` SET TAGS ('dbx_business_glossary_term' = 'Protocol Count');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `quality_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `quality_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Reviewer Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `receiving_function` SET TAGS ('dbx_business_glossary_term' = 'Receiving Function');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `receiving_site` SET TAGS ('dbx_business_glossary_term' = 'Receiving Site');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `receiving_team` SET TAGS ('dbx_business_glossary_term' = 'Receiving Team');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `regulatory_pathway` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Pathway');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `regulatory_submission_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `sap_project_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Project Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `target_trl` SET TAGS ('dbx_business_glossary_term' = 'Target Technology Readiness Level (TRL)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `training_materials_included` SET TAGS ('dbx_business_glossary_term' = 'Training Materials Included Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `transfer_number` SET TAGS ('dbx_business_glossary_term' = 'Technology Transfer Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `transfer_number` SET TAGS ('dbx_value_regex' = '^TT-[0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `transfer_package_contents` SET TAGS ('dbx_business_glossary_term' = 'Technology Transfer Package Contents');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Technology Transfer Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `transfer_title` SET TAGS ('dbx_business_glossary_term' = 'Technology Transfer Title');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Transfer Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `trl_at_transfer` SET TAGS ('dbx_business_glossary_term' = 'Technology Readiness Level (TRL) at Transfer');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `validation_data_included` SET TAGS ('dbx_business_glossary_term' = 'Validation Data Included Flag');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'not_started|protocol_approved|in_progress|completed|failed|revalidation_required');
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ALTER COLUMN `veeva_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` SET TAGS ('dbx_subdomain' = 'experiment_operations');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `sample_request_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Identifier');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Benchling Project ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `genomic_access_control_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Access Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `inbound_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Delivery Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `service_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `biobank_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Biobank Location ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `tertiary_sample_handoff_recipient_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Handoff Recipient ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `tertiary_sample_handoff_recipient_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `tertiary_sample_handoff_recipient_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `chain_of_custody_handoff_date` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Handoff Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `consent_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Verification Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `consent_verification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending_verification|verified|failed|waived');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `data_sharing_required` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Required');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost in United States Dollars (USD)');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `fulfillment_date` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|partially_fulfilled|fully_fulfilled|unable_to_fulfill|cancelled');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `handoff_recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Handoff Recipient Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `handoff_recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `handoff_recipient_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `intended_use` SET TAGS ('dbx_business_glossary_term' = 'Intended Use');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `irb_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `irb_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|expired|withdrawn');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `irb_protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Protocol Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `lims_request_reference` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Request ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `phi_involved` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Involved');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|critical');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Number');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^SR-[0-9]{8}$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `requester_email` SET TAGS ('dbx_business_glossary_term' = 'Requester Email Address');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `requester_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `requester_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `requester_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `requester_name` SET TAGS ('dbx_business_glossary_term' = 'Requester Name');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `sample_subtype` SET TAGS ('dbx_business_glossary_term' = 'Sample Subtype');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project_investigator` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project_investigator` SET TAGS ('dbx_subdomain' = 'project_management');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project_investigator` SET TAGS ('dbx_association_edges' = 'clinical.authorized_orderer,research.project');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project_investigator` ALTER COLUMN `project_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Project Investigator Assignment ID');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project_investigator` ALTER COLUMN `authorized_orderer_id` SET TAGS ('dbx_business_glossary_term' = 'Project Investigator - Physician Panel Id');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project_investigator` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Investigator - Rd Project Id');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project_investigator` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Investigator Assignment Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project_investigator` ALTER COLUMN `co_investigator_flag` SET TAGS ('dbx_business_glossary_term' = 'Co-Investigator Indicator');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project_investigator` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project_investigator` ALTER COLUMN `delegation_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Delegation of Authority Log Reference');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project_investigator` ALTER COLUMN `effort_percent` SET TAGS ('dbx_business_glossary_term' = 'Investigator Effort Allocation Percentage');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project_investigator` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Investigator Assignment End Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project_investigator` ALTER COLUMN `fda_1572_signed_flag` SET TAGS ('dbx_business_glossary_term' = 'FDA Form 1572 Signed Indicator');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project_investigator` ALTER COLUMN `investigator_role` SET TAGS ('dbx_business_glossary_term' = 'Investigator Role Type');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project_investigator` ALTER COLUMN `irb_listed_flag` SET TAGS ('dbx_business_glossary_term' = 'IRB Protocol Listed Investigator');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project_investigator` ALTER COLUMN `principal_investigator_flag` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Indicator');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project_investigator` ALTER COLUMN `signature_authority_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Signature Authority Indicator');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project_investigator` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigator Assignment Start Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project_investigator` ALTER COLUMN `sub_investigator_flag` SET TAGS ('dbx_business_glossary_term' = 'Sub-Investigator Indicator');
ALTER TABLE `genomics_biotech_ecm`.`research`.`project_investigator` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_assignment` SET TAGS ('dbx_subdomain' = 'project_management');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_assignment` SET TAGS ('dbx_association_edges' = 'research.project,workforce.employee');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_assignment` ALTER COLUMN `research_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'research_assignment Identifier');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_assignment` ALTER COLUMN `workforce_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Identifier');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment - Employee Id');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_assignment` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment - Rd Project Id');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_assignment` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Effort Allocation Percentage');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_assignment` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Assignment Indicator');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Creation Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_assignment` ALTER COLUMN `effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Effort Hours');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_assignment` ALTER COLUMN `role_on_project` SET TAGS ('dbx_business_glossary_term' = 'Project Role');
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment_analysis` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment_analysis` SET TAGS ('dbx_subdomain' = 'experiment_operations');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment_analysis` SET TAGS ('dbx_association_edges' = 'research.experiment,bioinformatics.pipeline_version');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment_analysis` ALTER COLUMN `experiment_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Analysis Identifier');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment_analysis` ALTER COLUMN `experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Analysis - Experiment Id');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment_analysis` ALTER COLUMN `bioinformatics_pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Identifier');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment_analysis` ALTER COLUMN `pipeline_version_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Analysis - Pipeline Version Id');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analysis Reviewer');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment_analysis` ALTER COLUMN `actual_runtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Execution Runtime');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment_analysis` ALTER COLUMN `analysis_purpose` SET TAGS ('dbx_business_glossary_term' = 'Analysis Purpose Classification');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment_analysis` ALTER COLUMN `compute_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Computational Cost');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment_analysis` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Execution Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment_analysis` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Analysis Execution Notes');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment_analysis` ALTER COLUMN `output_file_path` SET TAGS ('dbx_business_glossary_term' = 'Analysis Output Location');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment_analysis` ALTER COLUMN `qc_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Status');
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment_analysis` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Review Date');
ALTER TABLE `genomics_biotech_ecm`.`research`.`review_board` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`review_board` SET TAGS ('dbx_subdomain' = 'funding_compliance');
ALTER TABLE `genomics_biotech_ecm`.`research`.`review_board` ALTER COLUMN `review_board_id` SET TAGS ('dbx_business_glossary_term' = 'Review Board Identifier');
ALTER TABLE `genomics_biotech_ecm`.`research`.`review_board` ALTER COLUMN `parent_review_board_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`review_board` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`review_board` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`review_board` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`review_board` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`review_board` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`review_board` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`review_board` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`review_board` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`review_board` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`review_board` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`review_board` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`review_board` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`review_board` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`review_board` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`program` SET TAGS ('dbx_subdomain' = 'project_management');
ALTER TABLE `genomics_biotech_ecm`.`research`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier');
ALTER TABLE `genomics_biotech_ecm`.`research`.`program` ALTER COLUMN `parent_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`program` ALTER COLUMN `lead_scientist_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`program` ALTER COLUMN `lead_scientist_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`program` ALTER COLUMN `lead_scientist_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`program` ALTER COLUMN `lead_scientist_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`program` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`program` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`research`.`study` SET TAGS ('dbx_subdomain' = 'project_management');
ALTER TABLE `genomics_biotech_ecm`.`research`.`study` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Identifier');
ALTER TABLE `genomics_biotech_ecm`.`research`.`study` ALTER COLUMN `parent_study_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`study` ALTER COLUMN `funding_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`study` ALTER COLUMN `principal_investigator` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`research`.`study` ALTER COLUMN `principal_investigator` SET TAGS ('dbx_pii_name' = 'true');
