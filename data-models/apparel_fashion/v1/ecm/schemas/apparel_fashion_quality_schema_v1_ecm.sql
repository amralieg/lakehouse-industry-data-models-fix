-- Schema for Domain: quality | Business: Apparel Fashion | Version: v1_ecm
-- Generated on: 2026-05-05 15:54:37

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `apparel_fashion_ecm`.`quality` COMMENT 'Ensures product quality through inspection protocols, defect tracking, SMS (Sample Management), PP sample approvals, lab testing, and compliance with OEKO-TEX, CPSC, and GOTS standards. Manages quality audits, non-conformance reports, RTV disposition, corrective actions, and quality gates across the T&A calendar from pre-production through final random inspection.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`quality`.`inspection` (
    `inspection_id` BIGINT COMMENT 'Unique identifier for the quality inspection event. Primary key for the inspection record.',
    `aql_plan_id` BIGINT COMMENT 'Foreign key linking to quality.aql_plan. Business justification: Inspection uses an AQL plan to determine sampling size and acceptance criteria. N inspections : 1 aql_plan. No columns removed because aql_level and sampling_plan on inspection are execution values th',
    `carbon_emission_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_emission. Business justification: Factory inspections occur during production runs that generate Scope 1/2 emissions. Quality teams track carbon footprint per inspection event for ESG reporting and carbon accounting allocation to prod',
    `colorway_id` BIGINT COMMENT 'Foreign key linking to product.colorway. Business justification: Inspections can identify colorway-specific issues (color variance, print defects, dye consistency). FK enables defect analysis by colorway for color approval gates, seasonal color performance tracking',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inspection activities incur labor and overhead costs that must be allocated to cost centers for quality program budgeting, variance analysis, and cost-of-quality reporting in apparel manufacturing ope',
    `employee_id` BIGINT COMMENT 'Identifier of the quality inspector or inspection agency personnel who performed the inspection.',
    `gate_id` BIGINT COMMENT 'Foreign key linking to quality.quality_gate. Business justification: Inspection occurs at a specific quality gate checkpoint in the T&A calendar. N inspections : 1 quality_gate. No columns removed because inspection_stage is an execution value.',
    `order_purchase_order_id` BIGINT COMMENT 'Foreign key linking to order.purchase_order. Business justification: Receiving inspections validate incoming PO shipments against quality standards before warehouse acceptance. Critical gate for inventory quality control and vendor compliance tracking in apparel supply',
    `production_factory_id` BIGINT COMMENT 'Identifier of the manufacturing facility or supplier location where the inspection was conducted.',
    `sales_order_line_id` BIGINT COMMENT 'Foreign key linking to order.sales_order_line. Business justification: Final pre-ship inspections validate specific order line items before customer delivery. Ensures SKU-level quality compliance for DTC and wholesale shipments, drives line-level hold and release decisio',
    `sample_request_id` BIGINT COMMENT 'Foreign key linking to sourcing.sample_request. Business justification: Pre-production inspections validate samples submitted via sourcing requests. Enables tracking of sample approval status, revision rounds, and PP approval workflow. Standard apparel product development',
    `sketch_id` BIGINT COMMENT 'Foreign key linking to design.design_sketch. Business justification: Pre-production and inline inspections reference original design sketches to verify design intent compliance, construction details, and aesthetic specifications. Essential for quality gates that valida',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Inspections track sku as text. FK enables defect tracking at SKU level for inventory disposition decisions, AQL compliance reporting by size/color, and warehouse quality hold management. Critical for ',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order. Business justification: Inspections validate PO shipments at receiving or in-line production stages. Critical for OTIF tracking, quality gate clearance, and vendor performance scorecards. Standard apparel QC workflow links i',
    `standard_id` BIGINT COMMENT 'Foreign key linking to quality.quality_standard. Business justification: Inspection is conducted against a specific compliance standard (OEKO-TEX, CPSC, GOTS, etc.). N inspections : 1 quality_standard. Remove compliance_standard as it can be retrieved from quality_standard',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Inspections currently track style_number as text. FK enables quality metrics rollup by style for defect rate analysis, supplier scorecards, and style approval decisions. Essential for product developm',
    `supplier_esg_assessment_id` BIGINT COMMENT 'Foreign key linking to sustainability.supplier_esg_assessment. Business justification: Inspection outcomes validate supplier ESG claims and feed into ESG assessment scores. Failed inspections trigger ESG rating downgrades and corrective action requirements in supplier scorecards.',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or vendor responsible for the goods being inspected. Links to supplier master data.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Inspections (inline, final, pre-shipment) are performed on specific work orders throughout production lifecycle. Critical for quality gate enforcement, production release decisions, and AQL pass/fail ',
    `work_order_operation_id` BIGINT COMMENT 'Foreign key linking to production.work_order_operation. Business justification: Operation-level inspections (cutting, sewing, finishing) track quality at specific production steps. Essential for defect root cause analysis, process control, and identifying which operation introduc',
    `agency` STRING COMMENT 'The name of the third-party inspection agency or internal quality team that performed the inspection (e.g., SGS, Bureau Veritas, Intertek).',
    `approval_date` DATE COMMENT 'The date on which the inspection results and disposition decision were formally approved by quality management.',
    `approved_by` STRING COMMENT 'The name or identifier of the quality manager or authorized personnel who reviewed and approved the inspection results and disposition decision.',
    `aql_level` STRING COMMENT 'The AQL (Acceptable Quality Limit) standard applied for this inspection, defining the maximum acceptable defect rate. Typically expressed as critical/major/minor defect thresholds (e.g., Critical 0.0, Major 2.5, Minor 4.0).. Valid values are `critical_0|major_2_5|minor_4_0`',
    `capa_reference_number` STRING COMMENT 'The reference number of the CAPA record created as a result of this inspection, if applicable.. Valid values are `^CAPA-[0-9]{6,10}$`',
    `capa_triggered` BOOLEAN COMMENT 'Flag indicating whether this inspection triggered a formal CAPA (Corrective and Preventive Action) process due to significant quality issues or non-conformance.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this inspection record was first created in the system.',
    `critical_defects_found` STRING COMMENT 'The count of critical defects identified during the inspection. Critical defects are those that pose safety hazards or render the product completely unusable.',
    `disposition_decision` STRING COMMENT 'The action decision made based on the inspection outcome. Accept: goods approved for shipment; Reject: goods refused and returned to vendor (RTV); Rework: defects to be corrected; Sort: 100% inspection to remove defective units; RTY: Return to Yard for further evaluation; Hold: quarantine pending further review.. Valid values are `accept|reject|rework|sort|rty|hold`',
    `end_time` TIMESTAMP COMMENT 'The precise timestamp when the inspection activity was completed, including time zone information.',
    `hold_flag` BOOLEAN COMMENT 'Flag indicating whether the inspected lot has been placed on quality hold, preventing shipment or further processing until issues are resolved.',
    `inspection_date` DATE COMMENT 'The calendar date on which the inspection was performed. This is the primary business event timestamp for the inspection.',
    `inspection_number` STRING COMMENT 'Human-readable business identifier for the inspection event, typically formatted as INS-YYYYMMDD or similar pattern used in quality management systems.. Valid values are `^INS-[0-9]{8}$`',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection event. Tracks the inspection from scheduling through completion or cancellation.. Valid values are `scheduled|in_progress|completed|cancelled|on_hold`',
    `inspection_type` STRING COMMENT 'Classification of the inspection event based on the stage in the production lifecycle. Pre-production (PP) inspections validate samples before bulk production; inline inspections occur during manufacturing; mid-production inspections assess progress; final random inspection (FRI) validates finished goods using AQL sampling; receiving inspections validate incoming materials; lab test inspections validate compliance with technical specifications.. Valid values are `pre_production|inline|mid_production|final_random|receiving|lab_test`',
    `inspector_name` STRING COMMENT 'The full name of the quality inspector who conducted the inspection.',
    `inspector_notes` STRING COMMENT 'Free-text notes and observations recorded by the inspector during the inspection, providing additional context and details beyond structured defect data.',
    `lab_test_required` BOOLEAN COMMENT 'Flag indicating whether laboratory testing is required as part of this inspection to validate material composition, chemical safety, or performance specifications.',
    `lab_test_status` STRING COMMENT 'The current status of laboratory testing associated with this inspection, if applicable.. Valid values are `not_required|pending|in_progress|completed|failed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this inspection record was last updated or modified in the system.',
    `lot_size` STRING COMMENT 'The total quantity of units in the production lot or shipment being inspected.',
    `major_defects_found` STRING COMMENT 'The count of major defects identified during the inspection. Major defects significantly impair product functionality or appearance and are likely to result in customer rejection.',
    `minor_defects_found` STRING COMMENT 'The count of minor defects identified during the inspection. Minor defects are small imperfections that do not significantly affect product functionality or appearance.',
    `pass_fail_outcome` STRING COMMENT 'The final inspection result indicating whether the lot met the AQL acceptance criteria. Pass indicates acceptance; Fail indicates rejection; Conditional Pass indicates acceptance with minor corrective actions required; Pending indicates awaiting final determination.. Valid values are `pass|fail|conditional_pass|pending`',
    `photo_evidence_url` STRING COMMENT 'The URL or file path to photographic evidence of defects or inspection findings, typically stored in a document management system or cloud storage.. Valid values are `^https?://.*`',
    `product_category` STRING COMMENT 'The high-level product category or classification (e.g., apparel, footwear, accessories) for the inspected goods.',
    `report_url` STRING COMMENT 'The URL or file path to the detailed inspection report document, typically stored in a document management system or cloud storage.. Valid values are `^https?://.*`',
    `sample_size` STRING COMMENT 'The number of units randomly selected and inspected from the lot, as determined by the sampling plan.',
    `sampling_plan` STRING COMMENT 'The statistical sampling plan reference used for the inspection, defining sample size and acceptance criteria based on lot size and AQL level.',
    `stage` STRING COMMENT 'The specific production stage or milestone in the Time and Action (T&A) calendar where the inspection was performed. Aligns with quality gates in the manufacturing workflow.. Valid values are `raw_material|cutting|sewing|finishing|packing|pre_shipment`',
    `start_time` TIMESTAMP COMMENT 'The precise timestamp when the inspection activity commenced, including time zone information.',
    `total_defects_found` STRING COMMENT 'The total count of all defects (critical + major + minor) identified during the inspection.',
    `units_inspected` STRING COMMENT 'The actual number of units physically inspected during the inspection event. May differ from sample size if inspection was incomplete.',
    CONSTRAINT pk_inspection PRIMARY KEY(`inspection_id`)
) COMMENT 'Master record for all quality inspection events across the product lifecycle — pre-production (PP), in-line, mid-production, and final random inspection (FRI/AQL). Header captures inspection type, stage in T&A calendar, factory, style/SKU scope, inspection date, AQL level, sampling plan reference, pass/fail outcome, defect summary counts, inspector identity, and disposition decision. Line-level findings (modeled as child records within this product) capture: defect type (linked to defect catalog), severity classification (critical/major/minor per AQL), quantity found, affected unit reference, location on garment, inspector notes, photographic evidence URL, and hold/CAPA trigger flags. Serves as the primary operational record for quality gate enforcement from raw material receipt through finished goods shipment, enabling defect frequency analysis and Pareto reporting by style, factory, and defect type.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`quality`.`defect` (
    `defect_id` BIGINT COMMENT 'Unique identifier for the quality defect record. Primary key for the quality defect taxonomy.',
    `acceptance_criteria` STRING COMMENT 'The quantitative or qualitative threshold that distinguishes acceptable variation from a defect. Defines pass/fail boundaries for inspections and lab tests, ensuring consistent application across factories and seasons.',
    `active_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this defect type is currently active in the quality taxonomy. Inactive defects are retained for historical analysis but not used in current inspection workflows.',
    `affected_area` STRING COMMENT 'The specific component or area of the garment or product where the defect occurs. Enables root-cause analysis by production stage and supplier capability assessment. [ENUM-REF-CANDIDATE: seam|fabric|trim|print|embroidery|fit|label|packaging|hardware|zipper|button — 11 candidates stripped; promote to reference product]',
    `applicable_product_category` STRING COMMENT 'The product categories or divisions where this defect type is relevant. May include apparel, footwear, accessories, or specific subcategories (e.g., outerwear, activewear, luxury). Enables category-specific quality reporting.',
    `aql_classification` STRING COMMENT 'AQL (Acceptable Quality Limit) classification tier per ISO 2859-1 and ANSI/ASQC Z1.4 standards. Determines sampling plan, acceptance number, and rejection criteria during pre-production (PP), inline, and final random inspections.. Valid values are `critical|major|minor`',
    `compliance_standard` STRING COMMENT 'The regulatory or industry standard that this defect type may violate if present. References OEKO-TEX Standard 100 for textile safety, CPSC (Consumer Product Safety Commission) requirements, GOTS (Global Organic Textile Standard), FTC labeling rules, or other applicable frameworks.',
    `corrective_action_guidance` STRING COMMENT 'Recommended corrective and preventive actions (CAPA) to address this defect type. Provides factory partners and internal quality teams with standardized remediation steps aligned with ISO 9001 and continuous improvement frameworks.',
    `cost_impact_category` STRING COMMENT 'Estimated financial impact category of this defect type, considering rework costs, RTV (Return to Vendor) expenses, customer returns, and brand reputation risk. Informs quality investment prioritization.. Valid values are `high|medium|low`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this defect record was first created in the quality management system. Supports audit trails and data lineage per ISO 9001 and GDPR requirements.',
    `customer_visibility` STRING COMMENT 'Indicates whether the defect is visible to the end customer during normal use. Visible defects have higher severity weighting and stricter acceptance criteria. Hidden defects may still affect durability or compliance.. Valid values are `visible|hidden|conditional`',
    `defect_category` STRING COMMENT 'AQL (Acceptable Quality Limit) classification of the defect severity. Critical defects render product unsafe or unusable; major defects significantly impair function or appearance; minor defects are noticeable but do not affect primary use. Drives sampling plans and acceptance criteria per ISO 2859-1.. Valid values are `critical|major|minor`',
    `defect_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying the defect type across all quality workflows. Used as the operational reference in inspection systems, SMS (Sample Management System), and audit reports.. Valid values are `^[A-Z0-9]{4,12}$`',
    `defect_description` STRING COMMENT 'Detailed textual description of the defect, including visual characteristics, measurement criteria, and conditions under which it is considered a defect. Serves as the authoritative definition for training inspectors and resolving disputes.',
    `defect_name` STRING COMMENT 'Human-readable name of the defect type. Provides clear identification for quality inspectors, factory auditors, and merchandising teams.',
    `effective_end_date` DATE COMMENT 'The date on which this defect definition was retired or superseded. Null for currently active defects. Enables historical trend analysis and ensures data lineage for compliance audits.',
    `effective_start_date` DATE COMMENT 'The date from which this defect definition became effective in quality workflows. Supports historical analysis and ensures consistent application of quality standards across seasons and T&A (Time and Action) calendars.',
    `frequency_rank` STRING COMMENT 'Historical ranking of this defect type by occurrence frequency across all inspections and audits. Lower numbers indicate more common defects. Used for Pareto analysis and prioritization of quality improvement initiatives.',
    `inspection_stage` STRING COMMENT 'The quality gate or inspection checkpoint where this defect type is typically identified. Aligns with T&A (Time and Action) calendar milestones and quality protocols across the production lifecycle.. Valid values are `pre_production|inline|final_random|lab_test|receiving`',
    `lab_test_method` STRING COMMENT 'The specific laboratory test method or standard used to detect or measure this defect. References AATCC (American Association of Textile Chemists and Colorists), ASTM, or ISO test procedures.',
    `lab_test_required` BOOLEAN COMMENT 'Boolean flag indicating whether detection or confirmation of this defect requires laboratory testing (e.g., colorfastness, flammability, chemical composition) rather than visual inspection alone.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this defect record was last updated. Tracks changes to definitions, criteria, or classifications, ensuring all stakeholders work from the current version.',
    `measurement_method` STRING COMMENT 'The standardized procedure or tool used to detect and measure the defect. May reference visual inspection, dimensional measurement, lab testing (colorfastness, tensile strength), or specialized equipment (RFID readers, spectrophotometers).',
    `modified_by_user` STRING COMMENT 'Identifier of the user or system that last modified this defect record. Supports accountability, audit trails, and change management per ISO 9001 quality management principles.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or clarifications related to this defect type. May include regional variations, seasonal considerations, or links to related quality documentation.',
    `photo_reference_url` STRING COMMENT 'URL link to photographic or visual reference material illustrating the defect. Used in training materials, SMS (Sample Management System) workflows, and factory communication to ensure consistent identification.. Valid values are `^https?://.*`',
    `rework_feasibility` STRING COMMENT 'Indicates whether products with this defect can be repaired or reworked to meet quality standards, or must be rejected and returned to vendor (RTV). Conditional rework depends on defect severity and cost-benefit analysis.. Valid values are `reworkable|non_reworkable|conditional`',
    `root_cause_category` STRING COMMENT 'High-level classification of the typical root cause for this defect type. Supports corrective action planning, supplier capability assessment, and continuous improvement initiatives.. Valid values are `material|workmanship|design|equipment|process|handling`',
    `severity_weight` DECIMAL(18,2) COMMENT 'Numeric weighting factor representing the relative impact of this defect on product quality and customer satisfaction. Used in quality scoring algorithms, Pareto analysis, and supplier scorecards. Higher values indicate greater severity.',
    `supplier_notification_required` BOOLEAN COMMENT 'Boolean flag indicating whether occurrence of this defect triggers mandatory notification to the supplier or factory partner. Critical and major defects typically require immediate supplier engagement and corrective action.',
    `version_number` STRING COMMENT 'Version identifier for this defect definition. Incremented when acceptance criteria, descriptions, or classifications are updated. Ensures traceability and alignment across global quality teams and factory partners.. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_defect PRIMARY KEY(`defect_id`)
) COMMENT 'Reference taxonomy of all defect types used to classify findings during inspections, lab tests, and production audits. Each entry defines a defect code, name, category (critical/major/minor per AQL classification), affected product area (seam, fabric, trim, print, fit, label, packaging), detailed description, photographic reference, and severity weighting. Acts as the controlled vocabulary ensuring consistent defect recording and enabling cross-factory, cross-season Pareto analysis across all quality workflows.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` (
    `non_conformance_id` BIGINT COMMENT 'Unique identifier for the non-conformance report. Primary key for the non_conformance data product.',
    `audit_id` BIGINT COMMENT 'Reference to the quality audit that identified this non-conformance, if applicable. Null if NCR originated from inspection rather than audit.',
    `colorway_id` BIGINT COMMENT 'Foreign key linking to product.colorway. Business justification: NCRs can identify colorway-specific defects (color bleeding, dye lot issues, print misalignment). FK enables quality tracking by colorway for color approval decisions, dye house performance evaluation',
    `corrective_action_plan_id` BIGINT COMMENT 'Reference to the formal corrective action plan initiated to address this non-conformance. Null if no CAP is required.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Non-conformances generate rework, scrap, and containment costs that are charged to cost centers for quality cost tracking, budget management, and cost-of-poor-quality (COPQ) analysis required in appar',
    `defect_id` BIGINT COMMENT 'Foreign key linking to quality.quality_defect. Business justification: Non-conformance report references a specific defect type from the quality defect taxonomy. N non_conformances : 1 quality_defect. Remove defect_code and defect_description as they can be retrieved fro',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: NCR financial impacts (scrap, rework, claims) must post to specific GL accounts for financial statement reporting, quality cost categorization, and COPQ analysis mandated by apparel finance operations',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Quality non-conformances violating regulations (lead in childrens products, flammability failures, restricted substances) escalate to compliance incidents. Business must link for regulatory notificat',
    `lot_batch_id` BIGINT COMMENT 'Reference to the specific lot or batch of material or finished goods affected by this non-conformance. Enables traceability and containment.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to production.lot. Business justification: NCRs reference specific production lots for traceability and containment. Critical for recall management, batch-level quality tracking, and isolating affected inventory when defects are discovered pos',
    `order_purchase_order_id` BIGINT COMMENT 'Reference to the purchase order associated with the non-conforming goods. Critical for RTV and supplier accountability workflows.',
    `employee_id` BIGINT COMMENT 'Reference to the quality inspector, auditor, or user who created this non-conformance report.',
    `related_ncr_non_conformance_id` BIGINT COMMENT 'Reference to a previous or related non-conformance report, used to track recurring issues and corrective action effectiveness.',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to order.sales_order. Business justification: NCRs raised against shipped customer orders capture post-delivery quality failures. Drives customer complaint resolution, warranty claims, and quality cost tracking for delivered goods in apparel reta',
    `sketch_id` BIGINT COMMENT 'Foreign key linking to design.design_sketch. Business justification: Non-conformances often cite design sketch deviations as root cause. Critical for root cause analysis when production doesnt match design intent, determining whether issue stems from design specificat',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU affected by this non-conformance. Provides size/color/variant-level traceability.',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order. Business justification: NCRs track defects against specific POs for vendor chargebacks, cost-of-quality reporting, and supplier scorecards. Essential for financial reconciliation and vendor performance management in apparel ',
    `style_id` BIGINT COMMENT 'Reference to the affected product style. Links to the product master in PLM systems.',
    `supplier_esg_assessment_id` BIGINT COMMENT 'Foreign key linking to sustainability.supplier_esg_assessment. Business justification: NCRs trigger ESG assessment reviews. Repeated quality failures impact supplier ESG ratings, sourcing approval status, and vendor consolidation decisions in responsible sourcing programs.',
    `tertiary_non_closed_by_user_employee_id` BIGINT COMMENT 'Reference to the quality manager or authorized user who approved closure of this non-conformance report.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or factory responsible for the non-conforming product or material.',
    `vendor_quote_id` BIGINT COMMENT 'Foreign key linking to sourcing.vendor_quote. Business justification: NCRs may reference quoted specifications for compliance verification when actual product deviates from vendor quote commitments. Supports vendor accountability and quote accuracy audits.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: NCRs are raised against specific work orders when quality failures occur. Required for production hold decisions, rework authorization, cost-of-quality allocation to work orders, and tracking quality ',
    `closure_date` DATE COMMENT 'Date when the non-conformance report was formally closed after disposition execution and verification. Null for open NCRs.',
    `closure_notes` STRING COMMENT 'Final comments and verification notes recorded at NCR closure, including confirmation of disposition execution and effectiveness of corrective actions.',
    `compliance_standard_violated` STRING COMMENT 'Specific regulatory or certification standard that was violated by this non-conformance (e.g., OEKO-TEX Standard 100, CPSC safety requirements, GOTS organic standards). Critical for compliance reporting and audit trails. [ENUM-REF-CANDIDATE: OEKO-TEX Standard 100|CPSC Product Safety|GOTS Organic|BCI Cotton|FLA Labor Standards|WRAP Certification|ISO 9001 — promote to reference product]',
    `containment_action` STRING COMMENT 'Immediate actions taken to prevent non-conforming product from reaching customers or downstream processes. Includes quarantine, hold, or recall activities.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether formal corrective action plan (CAP) is required to address systemic issues. True for major/critical defects or recurring non-conformances.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this non-conformance record was first created in the quality management system. Audit trail for record lifecycle.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount.. Valid values are `^[A-Z]{3}$`',
    `customer_impact_flag` BOOLEAN COMMENT 'Indicates whether the non-conformance reached or could potentially reach end customers. True triggers customer notification and potential recall workflows.',
    `detected_at_stage` STRING COMMENT 'Quality gate or stage in the T&A (Time and Action) calendar where the non-conformance was identified. Earlier detection reduces cost and customer impact.. Valid values are `pre_production_sample|inline_inspection|final_random_inspection|warehouse_receiving|store_receiving|customer_complaint`',
    `detection_date` DATE COMMENT 'Date when the non-conformance was first identified during inspection, audit, or customer feedback.',
    `disposition_decision` STRING COMMENT 'Final decision on how to handle the non-conforming goods. RTV (Return to Vendor) triggers supplier debit and logistics workflows; rework initiates corrective production; accept-as-is requires concession approval.. Valid values are `accept_as_is|rework|return_to_vendor|scrap|use_as_is_with_concession|sort_and_rework`',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial cost of the non-conformance, including material cost, rework cost, logistics cost, and potential customer claims. Expressed in company reporting currency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this non-conformance record. Tracks changes through investigation, disposition, and closure lifecycle.',
    `ncr_number` STRING COMMENT 'Business-facing unique identifier for the non-conformance report, typically formatted as NCR-YYYYMMDD or similar pattern used in quality management workflows.. Valid values are `^NCR-[0-9]{8}$`',
    `ncr_status` STRING COMMENT 'Current lifecycle status of the non-conformance report. Tracks progression from identification through resolution and closure.. Valid values are `open|under_review|pending_disposition|corrective_action_required|closed|cancelled`',
    `non_conformance_category` STRING COMMENT 'High-level classification of the type of non-conformance. Used for trend analysis and root cause categorization in quality reporting.. Valid values are `material_defect|workmanship_defect|dimensional_variance|color_variance|labeling_error|packaging_defect`',
    `photo_evidence_url` STRING COMMENT 'URL or file path to photographic evidence of the non-conformance. Critical for remote audits, supplier communication, and dispute resolution.. Valid values are `^https?://.*`',
    `quantity_affected` STRING COMMENT 'Total number of units (pieces, cartons, or other unit of measure) impacted by this non-conformance. Used for containment scope and financial impact calculation.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the quantity affected field. Aligns with inventory and logistics unit standards.. Valid values are `pieces|cartons|pallets|meters|kilograms`',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this non-conformance is a repeat occurrence of a previously identified issue. True signals ineffective corrective actions and escalates priority.',
    `responsible_party` STRING COMMENT 'Entity or organizational unit accountable for the non-conformance. Determines ownership of corrective actions and financial liability.. Valid values are `factory|supplier|internal_design|internal_sourcing|internal_production|third_party_logistics`',
    `rework_completion_date` DATE COMMENT 'Date when rework or corrective production activities were completed. Null if disposition was not rework.',
    `root_cause_analysis` STRING COMMENT 'Detailed findings from root cause investigation, including contributing factors, process breakdowns, and systemic issues identified.',
    `root_cause_classification` STRING COMMENT 'Categorization of the underlying root cause of the non-conformance. Used for corrective action planning and continuous improvement initiatives.. Valid values are `material_quality|process_control|equipment_failure|operator_error|design_issue|specification_unclear`',
    `severity_level` STRING COMMENT 'Classification of the non-conformance severity based on impact to product safety, functionality, and customer acceptance. Critical defects require immediate action and typically result in RTV.. Valid values are `critical|major|minor`',
    CONSTRAINT pk_non_conformance PRIMARY KEY(`non_conformance_id`)
) COMMENT 'Formal non-conformance report (NCR) raised when a product, material, or process fails to meet defined quality standards. Captures NCR number, originating inspection or audit reference, affected style/SKU/PO, non-conformance category, root cause classification, severity, responsible party (factory, supplier, internal), disposition decision (rework, RTV, scrap, accept-as-is), corrective action required flag, and NCR status lifecycle (open, under review, closed). Central record for quality failure management and RTV disposition workflows.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` (
    `corrective_action_id` BIGINT COMMENT 'Unique identifier for the corrective and preventive action (CAPA) record.',
    `compliance_audit_finding_id` BIGINT COMMENT 'Reference to the quality audit finding that triggered this corrective action, if applicable.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Corrective action implementation costs (process changes, training, tooling) are allocated to cost centers for quality improvement budget tracking and cost-benefit analysis in apparel quality managemen',
    `gate_id` BIGINT COMMENT 'Foreign key linking to quality.quality_gate. Business justification: Corrective action is associated with a quality gate stage where the issue was detected. N corrective_actions : 1 quality_gate. No columns removed because quality_gate_stage is an execution value.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_initiative. Business justification: Quality CAPAs often drive sustainability initiatives (waste reduction, chemical substitution, water-saving processes). Tracking this link measures ESG ROI and reports quality-driven environmental impr',
    `non_conformance_id` BIGINT COMMENT 'Reference to the non-conformance report or audit finding that triggered this corrective action.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Corrective actions require employee owners for accountability and completion tracking. Real business process: CAPA assignment, workload management, and performance tracking. Removes denormalized respo',
    `rfq_id` BIGINT COMMENT 'Foreign key linking to sourcing.rfq. Business justification: Severe CAPAs may require RFQ reissuance for replacement sourcing or vendor substitution. Links quality failures to sourcing strategy adjustments and vendor diversification decisions.',
    `rma_id` BIGINT COMMENT 'Foreign key linking to order.rma. Business justification: CAPAs triggered by customer return patterns close the quality loop from field failures back to supplier/factory. Tracks systemic quality issues identified through RMA analysis, drives vendor scorecard',
    `sketch_id` BIGINT COMMENT 'Foreign key linking to design.design_sketch. Business justification: Corrective actions may require design sketch amendments when quality issues stem from design specifications (unclear construction details, unachievable tolerances). Essential for design revision workf',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order. Business justification: CAPAs tied to specific PO failures drive vendor accountability, cost recovery, and supplier performance improvement. Essential for closed-loop quality management in apparel sourcing operations.',
    `standard_id` BIGINT COMMENT 'Foreign key linking to quality.quality_standard. Business justification: Corrective action is related to a compliance standard violation. N corrective_actions : 1 quality_standard. Remove compliance_standard as it can be retrieved from quality_standard.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or factory if the corrective action is supplier-related.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: CAPAs are implemented at work order level to address systemic production quality issues. Required for production process improvement, quality cost allocation, and tracking effectiveness of corrective ',
    `action_description` STRING COMMENT 'Detailed description of the corrective or preventive action plan to address the root cause and prevent recurrence.',
    `action_number` STRING COMMENT 'Business-readable unique identifier for the corrective action, typically following a CAPA numbering convention.. Valid values are `^CAPA-[0-9]{6,10}$`',
    `action_type` STRING COMMENT 'Classification of the action as corrective (addressing existing non-conformance), preventive (preventing potential non-conformance), or both.. Valid values are `corrective|preventive|both`',
    `actual_completion_date` DATE COMMENT 'Actual date when the corrective action was completed.',
    `affected_product_category` STRING COMMENT 'Product category or collection affected by the non-conformance that triggered this corrective action.',
    `affected_sku_count` STRING COMMENT 'Number of SKUs affected by the non-conformance that triggered this corrective action.',
    `closed_by` STRING COMMENT 'User or system identifier of the person who closed the corrective action record.',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action was formally closed after successful verification.',
    `containment_action` STRING COMMENT 'Immediate containment action taken to prevent further non-conforming product from reaching customers or production.',
    `corrective_action_status` STRING COMMENT 'Current lifecycle status of the corrective action plan.. Valid values are `open|in_progress|pending_verification|verified|closed|cancelled`',
    `cost_of_quality_impact` DECIMAL(18,2) COMMENT 'Estimated financial impact of the non-conformance and corrective action, including rework, scrap, returns, and prevention costs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost of quality impact amount.. Valid values are `^[A-Z]{3}$`',
    `disposition_action` STRING COMMENT 'Disposition decision for non-conforming product (rework, scrap, Return to Vendor (RTV), use as-is with concession, downgrade to secondary market).. Valid values are `rework|scrap|return_to_vendor|use_as_is|downgrade`',
    `escalation_level` STRING COMMENT 'Level to which the corrective action has been escalated based on severity, recurrence, or regulatory impact.. Valid values are `none|manager|director|executive|regulatory`',
    `last_modified_by` STRING COMMENT 'User or system identifier of the person who last modified the corrective action record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action record was last updated.',
    `priority` STRING COMMENT 'Business priority level assigned to the corrective action based on severity and impact of the non-conformance.. Valid values are `critical|high|medium|low`',
    `quality_gate_stage` STRING COMMENT 'Stage in the Time and Action (T&A) calendar where the non-conformance was identified (pre-production sample, inline inspection, final random inspection, shipment inspection).. Valid values are `pre_production|inline|final_random|shipment`',
    `recurrence_count` STRING COMMENT 'Number of times the same or similar non-conformance has recurred, indicating effectiveness of corrective actions.',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether the same or similar non-conformance has recurred after the corrective action was implemented.',
    `responsible_party_type` STRING COMMENT 'Classification of the party responsible for implementing the corrective action (factory QC manager, supplier, internal team, etc.).. Valid values are `factory_qc_manager|supplier|internal_quality_team|production_manager|sourcing_team|third_party_lab`',
    `root_cause_analysis_method` STRING COMMENT 'Methodology used to identify the root cause of the non-conformance (5-Why, Fishbone/Ishikawa, Fault Tree Analysis, Pareto, etc.).. Valid values are `5_why|fishbone|fault_tree|pareto|other`',
    `root_cause_description` STRING COMMENT 'Detailed description of the identified root cause of the non-conformance or quality issue.',
    `source_system` STRING COMMENT 'Operational system of record where the corrective action was originally captured (Infor PLM, Centric PLM, SAP S/4HANA QM, etc.).',
    `source_system_code` STRING COMMENT 'Unique identifier of the corrective action record in the source operational system.',
    `supplier_performance_impact` STRING COMMENT 'Impact of this corrective action on supplier performance rating and relationship status.. Valid values are `no_impact|warning|probation|suspension|termination`',
    `target_completion_date` DATE COMMENT 'Planned date by which the corrective action should be completed.',
    `verification_date` DATE COMMENT 'Date when the corrective action effectiveness was verified.',
    `verification_method` STRING COMMENT 'Method used to verify the effectiveness of the corrective action (on-site audit, document review, sample inspection, lab testing, process audit, etc.).. Valid values are `on_site_audit|document_review|sample_inspection|lab_test|process_audit|supplier_self_assessment`',
    `verification_notes` STRING COMMENT 'Detailed notes from the verification process documenting findings and evidence of effectiveness.',
    `verification_outcome` STRING COMMENT 'Result of the effectiveness review indicating whether the corrective action successfully addressed the root cause and prevented recurrence.. Valid values are `effective|partially_effective|ineffective|pending`',
    `created_by` STRING COMMENT 'User or system identifier of the person who created the corrective action record.',
    CONSTRAINT pk_corrective_action PRIMARY KEY(`corrective_action_id`)
) COMMENT 'Corrective and Preventive Action (CAPA) record linked to a non-conformance or audit finding. Tracks the corrective action plan, responsible owner (factory QC manager, supplier, internal team), root cause analysis method (5-Why, Fishbone), action description, target completion date, actual completion date, verification method, effectiveness review outcome, and recurrence flag. Supports closed-loop quality management and supplier performance improvement programs.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` (
    `quality_sample_id` BIGINT COMMENT 'Unique identifier for the quality sample record. Primary key for the quality sample entity.',
    `cad_file_id` BIGINT COMMENT 'Foreign key linking to design.cad_file. Business justification: Quality samples are produced from CAD files. Linking enables digital-to-physical traceability for sample evaluation, pattern accuracy verification, and design iteration management—critical for tech pa',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Pre-production samples are photographed for campaign creative assets. Marketing teams request quality-approved samples for photoshoots and lookbooks. Sample approval gates campaign asset production—a ',
    `colorway_development_id` BIGINT COMMENT 'Foreign key linking to design.colorway_development. Business justification: Quality samples represent specific colorway developments for lab dip and strike-off approval. This link is essential for color approval workflows, tracking which colorway iteration a sample represents',
    `colorway_id` BIGINT COMMENT 'Foreign key linking to product.colorway. Business justification: Quality samples are produced in specific colorways. Currently tracked as colorway_code text. FK enables sample approval tracking by colorway for color-specific quality issues, dye lot consistency anal',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Quality samples require employee evaluators for evaluation and approval. Real business process: sample evaluation assignment, approval workflow, and evaluator workload management. Removes denormalized',
    `material_certification_id` BIGINT COMMENT 'Foreign key linking to sustainability.material_certification. Business justification: Quality samples for sustainable collections require certified materials. Sample approval is contingent on material certification validity (GOTS, GRS, RCS) for product launch authorization.',
    `order_purchase_order_id` BIGINT COMMENT 'Foreign key linking to order.purchase_order. Business justification: Pre-production sample approval gates PO release for bulk manufacturing. Sample evaluation results determine whether factory can proceed with production order, critical milestone in apparel sourcing wo',
    `print_design_id` BIGINT COMMENT 'Foreign key linking to design.print_design. Business justification: When samples feature prints, linking to print_design enables print quality evaluation, strike-off approval, and print registration/color accuracy assessment—critical for printed garment development an',
    `sample_request_id` BIGINT COMMENT 'Foreign key linking to sourcing.sample_request. Business justification: Quality samples ARE sourcing sample requests under evaluation. Direct 1:1 relationship between sourcing request and quality evaluation record. Core apparel product development workflow.',
    `seasonal_launch_id` BIGINT COMMENT 'Foreign key linking to marketing.seasonal_launch. Business justification: Seasonal launches depend on approved samples for visual merchandising, PR kits, and influencer seeding. Launch readiness is gated by sample approval status—critical path dependency in apparel go-to-ma',
    `sketch_id` BIGINT COMMENT 'Foreign key linking to design.design_sketch. Business justification: Quality samples are physical manifestations of design sketches. Sample approval workflows require traceability to the originating sketch for design intent verification, fit approval, and iteration tra',
    `standard_id` BIGINT COMMENT 'Foreign key linking to quality.quality_standard. Business justification: Quality sample evaluation may be conducted against a specific quality standard. N samples : 1 quality_standard. Remove compliance_certification as it can be retrieved from quality_standard.',
    `sustainable_material_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainable_material. Business justification: Pre-production samples for sustainable collections use specific certified materials. Quality teams validate material certifications match sample composition before bulk production approval.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Pre-production samples (SMS, TOP, PP) are evaluated before work order release. Gate-keeping function that prevents production of non-conforming styles. Sample approval status directly determines work ',
    `actual_receipt_date` DATE COMMENT 'Actual date when the sample was physically received at the evaluation facility. Used to measure supplier OTIF (On Time In Full) performance for sample delivery.',
    `approval_authority` STRING COMMENT 'Name or identifier of the individual with authority to provide final sign-off on the sample. Typically a senior product manager, design director, or quality director for critical PP and TOP approvals.',
    `approval_date` DATE COMMENT 'Date when the approval authority provided final sign-off on the sample. Represents the completion of the approval gate in the T&A calendar.',
    `bom_version` STRING COMMENT 'Version number of the BOM (Bill of Materials) used to produce this sample. Identifies the specific material and component specifications.. Valid values are `^[A-Z0-9.]{1,10}$`',
    `color_comments` STRING COMMENT 'Feedback on color accuracy, consistency, and match to approved color standards. Includes assessment of dye quality, color fastness, and shade variation.',
    `construction_comments` STRING COMMENT 'Detailed feedback on the garment construction quality, including seam quality, stitching, assembly methods, and structural integrity. Part of the comprehensive evaluation record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sample record was first created in the SMS (Sample Management System). Audit trail for record creation.',
    `disposition` STRING COMMENT 'Final disposition decision for the sample after evaluation is complete. Retain (keep for reference), Archive (long-term storage), Destroy (dispose), RTV (Return to Vendor).. Valid values are `retain|archive|destroy|rtv`',
    `evaluation_date` DATE COMMENT 'Date when the formal sample evaluation was conducted. Represents the principal business event timestamp for the evaluation process.',
    `evaluation_decision` STRING COMMENT 'Final outcome of the sample evaluation. Pass (approved for next stage), Fail (rejected, requires rework), Conditional (approved with amendments required).. Valid values are `pass|fail|conditional`',
    `evaluation_type` STRING COMMENT 'Classification of the evaluation activity performed on the sample. Fit session (fit and construction), aesthetic review (design and appearance), PP approval (pre-production sign-off), TOP approval (top of production sign-off), lab test (physical testing), compliance check (regulatory verification).. Valid values are `fit_session|aesthetic_review|pp_approval|top_approval|lab_test|compliance_check`',
    `expected_receipt_date` DATE COMMENT 'Target date by which the sample is expected to arrive at the evaluation facility. Used for T&A (Time and Action) calendar planning and milestone tracking.',
    `fabric_hand_comments` STRING COMMENT 'Feedback on the tactile quality and drape of the fabric, including texture, weight, softness, and overall hand feel. Assesses material quality and suitability.',
    `fit_comments` STRING COMMENT 'Detailed feedback on the garment fit, including measurements, proportions, ease, and adherence to fit specifications. Critical for fit sample evaluations.',
    `general_comments` STRING COMMENT 'Additional observations, notes, or feedback about the sample that do not fit into specific evaluation categories. Provides context and supplementary information.',
    `is_critical_path` BOOLEAN COMMENT 'Indicates whether this sample evaluation is on the critical path of the T&A (Time and Action) calendar. True if delays in this sample approval would impact the overall product launch timeline.',
    `lab_test_required` BOOLEAN COMMENT 'Indicates whether the sample requires formal laboratory testing for physical properties, chemical composition, or safety compliance. True if lab testing is mandated.',
    `lab_test_status` STRING COMMENT 'Current status of laboratory testing for the sample. Tracks progression through the testing workflow and final test outcome.. Valid values are `not_required|pending|in_progress|completed|passed|failed`',
    `labeling_comments` STRING COMMENT 'Feedback on the accuracy, placement, and compliance of care labels, content labels, brand labels, and regulatory labeling. Ensures FTC (Federal Trade Commission) and CPSC (Consumer Product Safety Commission) compliance.',
    `location` STRING COMMENT 'Current physical location or storage facility where the sample is held. Used for sample inventory management and retrieval.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the sample record was last updated in the SMS. Audit trail for record modification and tracking of evaluation progress.',
    `request_date` DATE COMMENT 'Date when the sample was formally requested from the factory or supplier. Marks the initiation of the sample procurement process.',
    `requested_by` STRING COMMENT 'Name or identifier of the individual who initiated the sample request. Typically a product developer, designer, or merchandiser.',
    `required_amendments` STRING COMMENT 'Detailed list of corrections, modifications, or improvements required before the sample can be approved. Used when evaluation decision is conditional or fail.',
    `sample_number` STRING COMMENT 'Externally-known unique identifier for the physical sample, typically generated by the SMS (Sample Management System). Used for tracking and reference across the product development lifecycle.. Valid values are `^[A-Z0-9]{8,20}$`',
    `sample_status` STRING COMMENT 'Current lifecycle status of the sample in the SMS workflow. Tracks progression from request through evaluation to final disposition. [ENUM-REF-CANDIDATE: requested|in_transit|received|under_evaluation|approved|rejected|conditional|archived — 8 candidates stripped; promote to reference product]',
    `sample_type` STRING COMMENT 'Classification of the sample based on its purpose in the product development cycle. Proto (prototype), Salesman (sales sample), Fit (fit evaluation), PP (pre-production), TOP (top of production), Shipment (shipment sample).. Valid values are `proto|salesman|fit|pp|top|shipment`',
    `season_code` STRING COMMENT 'Identifier for the merchandising season or collection to which this sample belongs. Typically formatted as year and season (e.g., SS24, FW24).. Valid values are `^[A-Z0-9]{4,10}$`',
    `size_code` STRING COMMENT 'Size designation for the sample garment or accessory. May use standard sizing (XS, S, M, L, XL) or numeric sizing depending on product category.. Valid values are `^[A-Z0-9]{1,10}$`',
    `tech_pack_version` STRING COMMENT 'Version number of the technical specification package (tech pack) that this sample was produced against. Links the sample to the specific design and construction specifications.. Valid values are `^[A-Z0-9.]{1,10}$`',
    `trim_comments` STRING COMMENT 'Feedback on the quality, placement, and functionality of trims and embellishments including buttons, zippers, labels, hardware, and decorative elements.',
    CONSTRAINT pk_quality_sample PRIMARY KEY(`quality_sample_id`)
) COMMENT 'Master record for all physical samples managed through the SMS (Sample Management System) across product development and pre-production, including evaluation outcomes and approval decisions. Captures sample type (proto, salesman, fit, PP, TOP, shipment), style/colorway/size, season, request/expected/actual receipt dates, origin factory, sample status, and comments. Includes evaluation records: evaluator identity, evaluation date, type (fit session, aesthetic review, PP approval, TOP approval), pass/fail/conditional decision, comments by category (construction, fit, fabric hand, color, trim, labeling), required amendments, and approval authority sign-off. Serves as the SSOT for sample tracking and approval from design through pre-production sign-off, driving the PP approval gate in the T&A calendar.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`quality`.`lab_test` (
    `lab_test_id` BIGINT COMMENT 'Unique identifier for the laboratory test record. Primary key for the lab test entity.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: External lab test invoices are processed through AP for payment, three-way matching with test requests, and accrual accounting required in apparel financial operations for compliance testing costs.',
    `chemical_compliance_id` BIGINT COMMENT 'Foreign key linking to sustainability.chemical_compliance. Business justification: Lab tests verify chemical compliance against ZDHC MRSL, REACH, Oeko-Tex standards. Test results populate chemical compliance records required for market access and retailer RSL audits.',
    `colorway_development_id` BIGINT COMMENT 'Foreign key linking to design.colorway_development. Business justification: Lab tests validate colorway specifications including color matching accuracy, colorfastness ratings, and dye chemical compliance during development phase. Essential for colorway approval workflows and',
    `corrective_action_id` BIGINT COMMENT 'Reference to the corrective action request (CAR) or non-conformance report (NCR) generated for failed tests. Links test failures to remediation workflow.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Lab testing costs are allocated to cost centers for quality assurance budget management, cost-per-test analysis, and overhead allocation in apparel compliance and quality programs.',
    `fabric_development_id` BIGINT COMMENT 'Foreign key linking to sourcing.fabric_development. Business justification: Fabric testing is mandatory quality gate in development cycle. Links test results (colorfastness, shrinkage, pilling) to fabric development records for bulk approval decisions.',
    `material_certification_id` BIGINT COMMENT 'Foreign key linking to sustainability.material_certification. Business justification: Lab tests validate material certification claims (organic cotton %, recycled polyester content, biodegradability). Test reports support GOTS, GRS, Cradle-to-Cradle certification audits and renewal.',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Lab tests evaluate materials (material_type exists as text). FK enables test result tracking by material for material approval workflows, restricted substance compliance certification, and material su',
    `order_purchase_order_id` BIGINT COMMENT 'Foreign key linking to order.purchase_order. Business justification: Lab tests validate material compliance (flammability, colorfastness, chemical restrictions) for specific PO shipments before production release or receiving acceptance. Regulatory requirement for mark',
    `employee_id` BIGINT COMMENT 'Reference to the quality engineer, product developer, or sourcing manager who requested the test. Used for workflow tracking and accountability.',
    `print_design_id` BIGINT COMMENT 'Foreign key linking to design.print_design. Business justification: Lab tests for colorfastness, print durability, chemical compliance (azo-free, phthalates), and wash performance are performed on specific print designs. Critical for regulatory compliance and print qu',
    `product_safety_test_id` BIGINT COMMENT 'Foreign key linking to compliance.product_safety_test. Business justification: When product_safety_test fails (lead, phthalates, flammability), lab_test tracks remediation testing and retest verification. Business process requires linking compliance failure to quality validation',
    `quality_sample_id` BIGINT COMMENT 'Foreign key linking to quality.quality_sample. Business justification: Lab test is performed on a quality sample managed through SMS. N lab_tests : 1 quality_sample. No columns removed because sample_id points to product.sample (cross-domain), which is a different entity',
    `retest_of_test_id` BIGINT COMMENT 'Reference to the original lab test ID if this is a retest following a failure or corrective action. Enables tracking of retest cycles and remediation effectiveness.',
    `sample_request_id` BIGINT COMMENT 'Foreign key linking to sourcing.sample_request. Business justification: Lab tests validate samples from sourcing requests for compliance, performance, and safety. Standard apparel testing workflow links test results to sample submissions for PP approval.',
    `sourcing_material_sourcing_id` BIGINT COMMENT 'Foreign key linking to sourcing.material_sourcing. Business justification: Material testing validates sourced materials for compliance (Oeko-Tex, GOTS), performance, and safety. Mandatory for material approval and supplier qualification in apparel sourcing.',
    `standard_id` BIGINT COMMENT 'Foreign key linking to quality.quality_standard. Business justification: Lab test is conducted against a specific quality standard (ISO, ASTM, AATCC, etc.). N lab_tests : 1 quality_standard. Remove test_standard as it can be retrieved from quality_standard.',
    `style_id` BIGINT COMMENT 'Reference to the product (SKU or style) that this test applies to. Links to the product master in PLM or merchandising system.',
    `sustainable_material_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainable_material. Business justification: Lab tests verify sustainable material properties (recycled content %, biodegradability, organic certification). Test results validate material sustainability attributes for marketing claims and certif',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or manufacturer who provided the material or garment being tested. Used for supplier quality scorecarding and corrective action tracking.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Lab tests (fabric performance, colorfastness, dimensional stability) are performed on work order materials and outputs. Required for compliance certification, production release decisions, and validat',
    `approval_date` DATE COMMENT 'Date when the test results were formally approved by the quality manager. Marks the quality gate clearance for production or shipment release.',
    `certificate_expiry_date` DATE COMMENT 'Date when the compliance certificate expires. Critical for ongoing compliance monitoring and re-testing schedules. OEKO-TEX certificates typically valid for 12 months.',
    `certificate_issue_date` DATE COMMENT 'Date when the compliance certificate was issued by the certifying body. Marks the start of certificate validity period.',
    `certificate_number` STRING COMMENT 'Certification number issued for passing tests (e.g., OEKO-TEX certificate number, GOTS transaction certificate). Required for compliance documentation and customer claims.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lab test record was first created in the system. Audit trail for record creation.',
    `lab_accreditation_number` STRING COMMENT 'ISO/IEC 17025 accreditation certificate number for the testing laboratory. Validates lab competency and compliance.',
    `lab_location` STRING COMMENT 'Geographic location (city and country) of the testing laboratory facility.',
    `lab_name` STRING COMMENT 'Name of the accredited laboratory that performed the test. Must be ISO/IEC 17025 accredited for applicable test types.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lab test record was last updated. Audit trail for record changes and status updates.',
    `market_destination` STRING COMMENT 'Target market or country where the product will be sold. Determines applicable regulatory standards (e.g., USA requires CPSC flammability; EU requires REACH compliance). Pipe-separated list for multi-market products. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|DEU|FRA|ITA|ESP|CHN|JPN|AUS — promote to reference product]',
    `overall_result` STRING COMMENT 'Aggregate pass/fail/conditional outcome for the entire test. Conditional indicates minor deviations requiring review. Determines whether the sample meets quality gate requirements.. Valid values are `pass|fail|conditional|pending|cancelled`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this test is required for regulatory compliance (FTC labeling, CPSC safety, OEKO-TEX certification). True for mandatory compliance tests; false for voluntary quality tests.',
    `remediation_required_flag` BOOLEAN COMMENT 'Indicates whether corrective action or remediation is required based on test results. True for failed or conditional results requiring supplier corrective action or material rework.',
    `sample_received_date` DATE COMMENT 'Date when the physical sample was received by the laboratory. Marks the start of the testing timeline.',
    `season_code` STRING COMMENT 'Merchandising season or collection code (e.g., SS24, FW24) that this test applies to. Used for seasonal quality trend analysis.',
    `test_completion_date` DATE COMMENT 'Date when all test procedures were completed and results finalized. Critical for T&A calendar compliance and pre-production (PP) sample approval gates.',
    `test_cost_amount` DECIMAL(18,2) COMMENT 'Total cost charged by the laboratory for performing this test. Used for cost of quality (COQ) analysis and budget tracking.',
    `test_cost_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the test cost amount (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `test_notes` STRING COMMENT 'Free-text notes and observations from the laboratory or quality team regarding test conditions, anomalies, or special considerations. Provides context for test interpretation.',
    `test_priority` STRING COMMENT 'Urgency level for test completion. Critical priority used for pre-production samples on tight T&A timelines or regulatory compliance issues.. Valid values are `critical|high|normal|low`',
    `test_purpose` STRING COMMENT 'Business reason for conducting the test. Determines approval workflow and quality gate requirements. Pre-production tests gate production approval; random inspections validate ongoing compliance.. Valid values are `pre_production|bulk_production|random_inspection|complaint_investigation|regulatory_compliance|supplier_qualification`',
    `test_report_number` STRING COMMENT 'Unique report number issued by the laboratory for this test. Used for audit trail and certificate reference.. Valid values are `^[A-Z0-9]{8,20}$`',
    `test_report_url` STRING COMMENT 'URL or document management system link to the full laboratory test report PDF. Enables digital access to detailed test documentation.',
    `test_request_date` DATE COMMENT 'Date when the test request was submitted to the laboratory. Used for tracking against Time and Action (T&A) calendar milestones.',
    `test_request_number` STRING COMMENT 'Externally-known unique identifier for the test request submitted to the laboratory. Business identifier used for tracking and reference.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `test_start_date` DATE COMMENT 'Date when laboratory testing commenced. Used for tracking test duration and turnaround time.',
    `test_status` STRING COMMENT 'Current lifecycle status of the test request. Tracks progress through the testing workflow from submission to completion.. Valid values are `requested|in_progress|completed|on_hold|cancelled`',
    `test_type` STRING COMMENT 'Category of test performed (e.g., colorfastness, tensile strength, flammability, chemical safety, dimensional stability, pH, fiber content, pilling resistance, abrasion resistance, seam strength).',
    CONSTRAINT pk_lab_test PRIMARY KEY(`lab_test_id`)
) COMMENT 'Record of a laboratory test submission, its individual parameter-level results, and overall outcome for a fabric, trim, or finished garment. Captures test request date, lab name, test standard (OEKO-TEX 100, GOTS, CPSC, ASTM, ISO), test type (colorfastness, tensile strength, flammability, chemical safety, dimensional stability, pH, fiber content), sample reference, overall pass/fail/conditional result, test report number, certificate expiry date, and remediation required flag. Includes granular line-level results per test parameter: parameter name, test method, required specification (min/max), actual measured value, unit of measure, parameter-level pass/fail, and lab technician notes. Supports compliance with FTC labeling, CPSC safety, and OEKO-TEX certification requirements with full parameter traceability.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` (
    `quality_audit_id` BIGINT COMMENT 'Unique identifier for the quality audit record. Primary key for the quality audit entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_agreement. Business justification: Audits validate vendor compliance with agreement terms (quality standards, certifications, capacity). Audit results drive agreement renewals, pricing adjustments, and vendor approval status.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: External quality audit invoices (third-party auditors, certification bodies) are processed through AP for payment processing, accrual accounting, and audit cost tracking in apparel supplier quality pr',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Quality audits require assigned auditor employees for execution and accountability. Real business process: audit assignment, execution tracking, and auditor performance management. Removes denormalize',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Quality audit costs (internal labor, external auditor fees) are charged to cost centers for quality program budget management and supplier quality assurance cost tracking in apparel operations.',
    `production_factory_id` BIGINT COMMENT 'Identifier of the specific manufacturing facility or site where the audit was conducted.',
    `quality_certification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_certification. Business justification: Quality audit may result in or maintain a quality certification. N audits : 1 certification (multiple audits over time for one certification). Remove certification_number and certification_expiry_date',
    `standard_id` BIGINT COMMENT 'Foreign key linking to quality.quality_standard. Business justification: Quality audit is conducted against a specific standard (WRAP, FLA, ISO 9001, etc.). N audits : 1 quality_standard. Remove audit_standard as it can be retrieved from quality_standard.',
    `supplier_esg_assessment_id` BIGINT COMMENT 'Foreign key linking to sustainability.supplier_esg_assessment. Business justification: Quality audits and ESG assessments are often conducted together at supplier facilities. Quality audit findings (process control, traceability) contribute to overall ESG scores and supplier approval st',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or factory that was audited.',
    `audit_date` DATE COMMENT 'The date on which the on-site audit fieldwork was conducted or commenced. For multi-day audits, this represents the start date.',
    `audit_number` STRING COMMENT 'Externally-known unique reference number assigned to this quality audit for tracking and reporting purposes.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `audit_scope` STRING COMMENT 'Description of the scope and boundaries of the audit, including departments, processes, product lines, or systems covered during the audit.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit: scheduled (planned but not started), in_progress (audit fieldwork underway), completed (fieldwork done, report being finalized), report_pending (awaiting final report issuance), closed (all findings resolved and audit closed), cancelled (audit did not proceed).. Valid values are `scheduled|in_progress|completed|report_pending|closed|cancelled`',
    `audit_type` STRING COMMENT 'Classification of the audit based on its primary focus area: social compliance (labor standards), quality management system (QMS), environmental (ISO 14001), product safety (CPSC compliance), process audit (manufacturing processes), or supplier qualification (initial approval).. Valid values are `social_compliance|quality_management_system|environmental|product_safety|process_audit|supplier_qualification`',
    `auditing_body` STRING COMMENT 'Name of the organization or entity that conducted the audit (e.g., third-party certification body, internal audit team, customer audit team, accredited inspection agency).',
    `auditor_certification` STRING COMMENT 'Professional certification or accreditation held by the lead auditor (e.g., ISO 9001 Lead Auditor, WRAP Certified Auditor, FLA Accredited Assessor).',
    `certification_issued_flag` BOOLEAN COMMENT 'Indicates whether a formal certification or approval was issued as a result of this audit (True if certification was granted, False otherwise).',
    `corrective_action_due_date` DATE COMMENT 'The deadline by which the audited facility must submit a corrective action plan addressing all findings.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action plan: not_required (no findings requiring CAP), pending (CAP not yet submitted), submitted (CAP received), under_review (being evaluated), approved (CAP accepted), in_progress (actions being implemented), completed (all actions closed), overdue (past due date). [ENUM-REF-CANDIDATE: not_required|pending|submitted|under_review|approved|in_progress|completed|overdue — 8 candidates stripped; promote to reference product]',
    `cost` DECIMAL(18,2) COMMENT 'Total cost incurred for conducting the audit, including auditor fees, travel expenses, and administrative costs.',
    `cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the audit cost (e.g., USD, EUR, GBP, CNY).. Valid values are `^[A-Z]{3}$`',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this audit record in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this quality audit record was first created in the system.',
    `critical_findings_count` STRING COMMENT 'Total number of critical-severity findings identified during the audit. Critical findings represent immediate risks to product safety, worker safety, or legal compliance.',
    `duration_days` DECIMAL(18,2) COMMENT 'Total duration of the on-site audit fieldwork, measured in days (e.g., 1.0, 2.5, 3.0 days).',
    `end_date` DATE COMMENT 'The date on which the on-site audit fieldwork was completed. For single-day audits, this may match the audit_date.',
    `follow_up_audit_date` DATE COMMENT 'The scheduled date for the follow-up audit to verify corrective action implementation and finding closure.',
    `follow_up_audit_required_flag` BOOLEAN COMMENT 'Indicates whether a follow-up audit is required to verify closure of critical or major findings (True if follow-up required, False otherwise).',
    `frequency_months` STRING COMMENT 'The required frequency (in months) for conducting audits of this facility, based on risk assessment, audit grade, and compliance requirements (e.g., 6, 12, 24 months).',
    `grade` STRING COMMENT 'Letter grade, pass/fail designation, or color-coded rating assigned to the audit result based on the total score and findings severity (e.g., A/B/C/D/F, pass/fail, platinum/gold/silver/bronze, red/amber/green). [ENUM-REF-CANDIDATE: A|B|C|D|F|pass|fail|conditional_pass|platinum|gold|silver|bronze|red|amber|green — 15 candidates stripped; promote to reference product]',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this audit record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this quality audit record was last updated or modified.',
    `major_findings_count` STRING COMMENT 'Total number of major-severity findings identified during the audit. Major findings represent significant non-conformances that could impact product quality or system effectiveness.',
    `minor_findings_count` STRING COMMENT 'Total number of minor-severity findings identified during the audit. Minor findings represent isolated non-conformances or documentation gaps that do not significantly impact quality.',
    `next_audit_scheduled_date` DATE COMMENT 'The planned date for the next scheduled audit of this facility, based on audit frequency requirements and the results of this audit.',
    `notes` STRING COMMENT 'Additional notes, comments, or context about the audit, including special circumstances, audit challenges, or notable observations.',
    `observation_count` STRING COMMENT 'Total number of observations or opportunities for improvement noted during the audit. Observations are not formal non-conformances but represent areas for enhancement.',
    `report_document_url` STRING COMMENT 'URL or file path to the complete audit report document stored in the document management system.',
    `report_issued_date` DATE COMMENT 'The date on which the formal audit report was issued to the audited facility and stakeholders.',
    `supplier_approval_status` STRING COMMENT 'The approval status of the supplier or facility resulting from this audit: approved (meets all requirements), conditional_approval (approved with conditions), suspended (approval temporarily withdrawn), rejected (does not meet requirements), under_review (decision pending).. Valid values are `approved|conditional_approval|suspended|rejected|under_review`',
    `total_score` DECIMAL(18,2) COMMENT 'Overall numerical score or rating achieved by the audited facility, expressed as a percentage or point value based on the audit standards scoring methodology.',
    CONSTRAINT pk_quality_audit PRIMARY KEY(`quality_audit_id`)
) COMMENT 'Record of a formal quality system or factory audit conducted against a defined standard (WRAP, FLA, ISO 9001, BSCI, SA8000, internal QMS), including all individual findings raised during the audit. Captures audit type (social compliance, quality management system, environmental, product safety), audit date, auditing body, factory/supplier audited, scope, total score, grade/rating, finding counts by severity, audit status, and next scheduled audit date. Includes line-level findings: finding reference, category, severity (critical/major/minor/observation), clause violated, description, photographic evidence, required corrective action, due date, and closure status. Distinct from product inspection — this audits the factorys quality management system and feeds directly into the corrective action workflow.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`quality`.`standard` (
    `standard_id` BIGINT COMMENT 'Unique identifier for the quality standard record. Primary key.',
    `ecolabel_id` BIGINT COMMENT 'Foreign key linking to sustainability.ecolabel. Business justification: Quality standards define requirements for ecolabel eligibility (EU Ecolabel, Nordic Swan). Standards specify testing protocols and certification needed for consumer-facing environmental claims.',
    `labeling_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.labeling_requirement. Business justification: Quality standards (ISO, ASTM) mandate specific labeling requirements (FTC fiber content, care symbols) for market compliance. Business needs to trace which quality standards drive labeling obligations',
    `superseded_by_standard_id` BIGINT COMMENT 'Reference to the quality_standard_id of the newer standard version that supersedes this one. Null if this is the current active version. Enables version lineage tracking.',
    `applicable_channels` STRING COMMENT 'Sales channels or distribution methods to which this quality standard applies (e.g., DTC (Direct-to-Consumer), wholesale, e-commerce, retail stores). Enables channel-specific quality requirements.',
    `applicable_markets` STRING COMMENT 'Geographic markets or regions where this quality standard is required or applicable (e.g., USA, EU, APAC, Global). Uses 3-letter ISO country codes or region identifiers.',
    `applicable_product_categories` STRING COMMENT 'Comma-separated list or description of product categories to which this quality standard applies (e.g., apparel, footwear, accessories, childrens wear, sleepwear). Drives automatic quality workflow setup for new styles.',
    `aql_level` STRING COMMENT 'Acceptable Quality Limit level specified by this standard for inspection sampling plans (e.g., AQL 1.5, AQL 2.5, AQL 4.0). Defines the maximum acceptable defect rate for production batches.. Valid values are `^(AQLs)?[0-9]+(.[0-9]+)?$`',
    `audit_scope` STRING COMMENT 'Description of the audit scope and focus areas required by this quality standard (e.g., facility inspection, process audit, documentation review, labor practices, environmental controls). Configures audit checklists and schedules.',
    `corrective_action_threshold` STRING COMMENT 'Threshold or trigger condition that mandates corrective action when non-conformance to this standard is detected (e.g., defect rate exceeds AQL, critical safety failure, repeated minor defects). Drives CAPA (Corrective and Preventive Action) workflows.',
    `cost_impact` STRING COMMENT 'Estimated cost impact of complying with this quality standard on product COGS (Cost of Goods Sold) or operational expenses (e.g., high for extensive lab testing, low for documentation-only requirements).. Valid values are `high|medium|low|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this quality standard record was first created in the system. Supports audit trail and data lineage.',
    `documentation_requirements` STRING COMMENT 'Description of documentation that must be maintained or submitted to demonstrate compliance with this quality standard (e.g., test reports, certificates of conformity, audit reports, material safety data sheets, traceability records).',
    `effective_date` DATE COMMENT 'Date from which this quality standard becomes applicable and enforceable for product development, sourcing, and manufacturing activities.',
    `expiry_date` DATE COMMENT 'Date on which this quality standard version is no longer valid or has been superseded by a newer version. Null indicates no planned expiration.',
    `inspection_frequency` STRING COMMENT 'Required frequency of quality inspections mandated by this standard (e.g., per batch, per shipment, random sampling). Drives inspection scheduling in the T&A (Time and Action) calendar. [ENUM-REF-CANDIDATE: per_batch|per_shipment|per_style|per_season|random|continuous|on_demand — 7 candidates stripped; promote to reference product]',
    `internal_owner` STRING COMMENT 'Name or identifier of the internal business role, department, or individual responsible for maintaining and enforcing this quality standard (e.g., Quality Assurance Manager, Compliance Director, Product Safety Team).',
    `issuing_body` STRING COMMENT 'Name of the organization, regulatory authority, or governing body that publishes and maintains this quality standard (e.g., OEKO-TEX Association, CPSC, ISO, FTC, GOTS International Working Group).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this quality standard record was last modified. Supports change tracking and audit trail.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether compliance with this quality standard is mandatory (true) or voluntary (false) for the applicable product categories and markets.',
    `mandatory_lab_tests` STRING COMMENT 'Comma-separated list of laboratory test protocols required by this quality standard (e.g., colorfastness, tensile strength, flammability, chemical residue analysis, pH testing). Configures lab test workflows in SMS (Sample Management System).',
    `notes` STRING COMMENT 'Free-text field for additional notes, clarifications, implementation guidance, or special instructions related to this quality standard. Used for operational context not captured in structured fields.',
    `pp_sample_approval_required` BOOLEAN COMMENT 'Indicates whether this quality standard requires formal approval of PP (Pre-Production) samples before bulk production can commence. Drives quality gates in the T&A calendar.',
    `quality_gate_stage` STRING COMMENT 'Stage(s) in the T&A (Time and Action) calendar where this quality standard must be verified as a quality gate (e.g., pre-production, inline inspection, final random inspection, pre-shipment). Comma-separated if multiple stages apply.',
    `reference_document_url` STRING COMMENT 'URL or file path to the authoritative reference document, standard specification, or regulatory text for this quality standard. Enables direct access to source documentation.. Valid values are `^(https?://)?[a-zA-Z0-9.-]+.[a-zA-Z]{2,}(/.*)?$`',
    `regulatory_basis` STRING COMMENT 'Legal or regulatory framework that mandates or influences this quality standard (e.g., CPSC 16 CFR 1610, FTC Textile Fiber Products Identification Act, EU REACH Regulation 1907/2006). Null for voluntary standards.',
    `required_certifications` STRING COMMENT 'Comma-separated list of certifications that must be obtained to comply with this quality standard (e.g., OEKO-TEX Standard 100, GOTS Organic, WRAP Facility Certification). Drives audit and certification tracking.',
    `risk_level` STRING COMMENT 'Risk level associated with non-compliance to this quality standard (e.g., critical for safety-related standards, high for regulatory requirements, medium for voluntary certifications).. Valid values are `critical|high|medium|low`',
    `rtv_disposition_rule` STRING COMMENT 'Rule governing RTV (Return to Vendor) disposition when products fail to meet this quality standard (e.g., automatic RTV for critical defects, conditional RTV for minor defects, no RTV allowed). Drives supply chain and vendor management workflows.. Valid values are `automatic_rtv|conditional_rtv|no_rtv|case_by_case`',
    `sms_integration_flag` BOOLEAN COMMENT 'Indicates whether this quality standard is integrated with the SMS (Sample Management System) for automated sample tracking, test result capture, and approval workflows.',
    `standard_category` STRING COMMENT 'Functional category grouping the standard by its primary compliance or quality domain (e.g., textile safety, chemical compliance, labor standards). [ENUM-REF-CANDIDATE: textile_safety|chemical_compliance|labor_standards|environmental|product_safety|flammability|labeling|organic|sustainability|general_quality — 10 candidates stripped; promote to reference product]',
    `standard_code` STRING COMMENT 'Unique business identifier for the quality standard (e.g., OEKO-TEX-100, GOTS-5.0, CPSC-FLAM, ISO-9001). Used for external reference and system integration.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `standard_name` STRING COMMENT 'Full descriptive name of the quality standard (e.g., OEKO-TEX Standard 100 Textile Safety Certification, Global Organic Textile Standard Version 5.0).',
    `standard_status` STRING COMMENT 'Current lifecycle status of the quality standard within the organizations quality management system.. Valid values are `active|superseded|retired|draft|pending_approval`',
    `standard_type` STRING COMMENT 'Classification of the quality standard by its nature and purpose within the quality management framework.. Valid values are `certification|testing_protocol|regulatory_requirement|internal_policy|industry_guideline|safety_standard`',
    `supplier_qualification_required` BOOLEAN COMMENT 'Indicates whether suppliers must be pre-qualified or certified to meet this quality standard before they can be approved for production (e.g., WRAP certification, OEKO-TEX facility approval).',
    `training_requirements` STRING COMMENT 'Description of training or competency requirements for personnel involved in activities governed by this quality standard (e.g., quality inspector certification, lab technician training, auditor qualification).',
    `version` STRING COMMENT 'Version number or edition identifier of the quality standard, enabling tracking of standard evolution and ensuring compliance with the correct revision.. Valid values are `^[0-9]{1,3}(.[0-9]{1,3}){0,2}$`',
    CONSTRAINT pk_standard PRIMARY KEY(`standard_id`)
) COMMENT 'Master reference and business rule catalog defining all quality standards, certifications, testing protocols, and category/market-specific quality requirements applicable to the business. Encompasses standard definitions (OEKO-TEX, GOTS, CPSC, FTC, ISO, WRAP, FLA), version control, effective/expiry dates, and geographic applicability. Also serves as the single authoritative source for category-specific quality requirements: required certifications per product category, mandatory lab tests, AQL levels, inspection frequencies, regulatory basis (CPSC, FTC, REACH, OEKO-TEX), target market/channel applicability (DTC, wholesale, EU, US, APAC), and mandatory vs. voluntary classification. Drives lab test configurations, audit scopes, inspection plans, and automated quality workflow setup for new styles entering the T&A calendar. Replaces any separate quality requirement records — all quality rules are consolidated here.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` (
    `quality_certification_id` BIGINT COMMENT 'Unique identifier for the quality or sustainability certification record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_agreement. Business justification: Certifications are prerequisites in sourcing agreements. Links vendor/factory certifications to contractual compliance requirements and supplier qualification gates.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Campaigns promoting sustainability or compliance claims (GOTS, Fair Trade, OEKO-TEX) must reference valid certifications. Marketing compliance requires certification validation before making public cl',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_certification. Business justification: Certifications like OEKO-TEX, GOTS, and Bluesign span quality and compliance domains. Business tracks unified certification portfolio for supplier qualification, customer requirements, and regulatory ',
    `material_certification_id` BIGINT COMMENT 'Foreign key linking to sustainability.material_certification. Business justification: Quality certifications (ISO 9001) are often prerequisites for material certifications (GOTS, GRS). Certification bodies cross-reference quality management systems when auditing material chain-of-custo',
    `material_id` BIGINT COMMENT 'Foreign key reference to the material or fabric that holds this certification. Populated when certified_entity_type is material.',
    `production_factory_id` BIGINT COMMENT 'Foreign key reference to the factory or manufacturing facility that holds this certification. Populated when certified_entity_type is factory.',
    `sourcing_material_sourcing_id` BIGINT COMMENT 'Foreign key linking to sourcing.material_sourcing. Business justification: Material certifications (GOTS, Oeko-Tex, BCI) validate sourced materials. Essential for sustainability compliance, material approval, and supplier qualification in apparel sourcing.',
    `standard_id` BIGINT COMMENT 'Foreign key linking to quality.quality_standard. Business justification: Quality certification is issued for compliance with a specific standard. N certifications : 1 quality_standard. No columns removed because certification_type and issuing_body may have execution-specif',
    `style_id` BIGINT COMMENT 'Foreign key reference to the product or SKU that holds this certification. Populated when certified_entity_type is product.',
    `vendor_id` BIGINT COMMENT 'Foreign key reference to the supplier that holds this certification. Populated when certified_entity_type is supplier.',
    `accreditation_body` STRING COMMENT 'The name of the accreditation body that accredits the issuing body (e.g., ANAB, UKAS, DAkkS). Provides additional assurance of certification validity.',
    `audit_frequency_months` STRING COMMENT 'The required frequency of audits or surveillance visits in months (e.g., 12 for annual, 6 for semi-annual). Used for scheduling compliance activities.',
    `certificate_document_url` STRING COMMENT 'The URL or file path to the digital copy of the official certificate document stored in the document management system.',
    `certificate_number` STRING COMMENT 'The official certificate number or registration number issued by the certifying body. This is the externally-known unique identifier for the certification.',
    `certification_level` STRING COMMENT 'The level or grade of certification achieved, if the certification standard has multiple tiers (e.g., OEKO-TEX Class I, II, III, IV; GOTS organic vs. made with organic).',
    `certification_scope` STRING COMMENT 'Detailed description of the scope of the certification, including specific products, processes, materials, or activities covered. May include exclusions.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification. Indicates whether the certification is currently valid and enforceable.. Valid values are `active|expired|suspended|pending_renewal|revoked|under_review`',
    `certification_type` STRING COMMENT 'The type or standard of certification held. Indicates the specific quality, safety, or sustainability framework under which the entity is certified. [ENUM-REF-CANDIDATE: OEKO-TEX Standard 100|GOTS|BCI|WRAP|ISO 9001|ISO 14001|ISO 45001|Fair Trade|Bluesign|GRS — 10 candidates stripped; promote to reference product]',
    `certified_entity_name` STRING COMMENT 'The human-readable name of the entity that holds the certification (e.g., factory name, supplier name, material description).',
    `certified_entity_reference` STRING COMMENT 'The internal identifier of the entity that holds the certification. This could reference a factory ID, supplier ID, material ID, or product SKU depending on certified_entity_type.',
    `certified_entity_type` STRING COMMENT 'The type of entity that holds the certification: factory, supplier, material, product, facility, or process.. Valid values are `factory|supplier|material|product|facility|process`',
    `compliance_gate` STRING COMMENT 'The stage in the Time and Action (T&A) calendar or product lifecycle where this certification is required as a quality gate (e.g., pre-production, bulk production, customs clearance).',
    `compliance_officer` STRING COMMENT 'The name or employee ID of the internal compliance officer responsible for managing this certification and ensuring ongoing compliance.',
    `cost` DECIMAL(18,2) COMMENT 'The total cost incurred to obtain and maintain this certification, including audit fees, consulting fees, and remediation costs. Expressed in the companys reporting currency.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this certification record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the certification_cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'The date from which the certification becomes valid and enforceable. May differ from issue_date if there is a grace period.',
    `expiry_date` DATE COMMENT 'The date on which the certification expires and is no longer valid. Nullable for certifications without expiration.',
    `geographic_scope` STRING COMMENT 'The geographic region or countries where this certification is recognized and valid (e.g., EU, USA, Global). Important for customs and regulatory compliance.',
    `is_mandatory` BOOLEAN COMMENT 'Boolean flag indicating whether this certification is mandatory for the certified entity to be used in production or sold in target markets. True if mandatory, False if voluntary.',
    `issue_date` DATE COMMENT 'The date on which the certification was originally issued by the certifying body.',
    `issuing_body` STRING COMMENT 'The name of the organization or authority that issued the certification (e.g., OEKO-TEX Association, Control Union, SGS, Bureau Veritas).',
    `issuing_body_contact` STRING COMMENT 'Contact information (email or phone) for the certifying body representative responsible for this certification.',
    `last_audit_date` DATE COMMENT 'The date of the most recent audit or inspection conducted by the certifying body to verify ongoing compliance.',
    `next_audit_date` DATE COMMENT 'The scheduled date for the next audit or surveillance visit by the certifying body.',
    `non_conformance_count` STRING COMMENT 'The number of non-conformances or corrective action requests identified during the last audit. Zero indicates full compliance.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to this certification. May include audit findings, remediation plans, or stakeholder communications.',
    `product_category` STRING COMMENT 'The product category or material type covered by this certification (e.g., woven fabrics, knit apparel, footwear, accessories). Relevant when certified_entity_type is product or material.',
    `regulatory_requirement` STRING COMMENT 'The specific regulatory requirement, law, or customer mandate that necessitates this certification (e.g., CPSC 16 CFR 1610, EU REACH, customer sustainability policy).',
    `renewal_due_date` DATE COMMENT 'The date by which the certification must be renewed to maintain continuous compliance. Used for proactive renewal planning.',
    `renewal_status` STRING COMMENT 'Current status of the certification renewal process. Tracks whether renewal activities are on schedule.. Valid values are `not_required|pending|in_progress|completed|overdue`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this certification record was last modified in the system. Used for audit trail and change tracking.',
    CONSTRAINT pk_quality_certification PRIMARY KEY(`quality_certification_id`)
) COMMENT 'Record of an active or historical quality or sustainability certification held by a product, material, factory, or supplier. Captures certification type (OEKO-TEX 100, GOTS, BCI, WRAP, ISO 9001, ISO 14001, Fair Trade), certificate number, issuing body, certified entity (factory, material, product), issue date, expiry date, certificate document URL, scope of certification, and renewal status. Enables compliance verification at sourcing, production, and customs clearance stages.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` (
    `quality_hold_id` BIGINT COMMENT 'Unique identifier for the quality hold record. Primary key.',
    `backorder_id` BIGINT COMMENT 'Foreign key linking to order.backorder. Business justification: Quality holds convert allocated inventory to backorder status when defects found. Impacts customer promise dates and ATP calculations, requires backorder tracking for quality-driven unavailability dis',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to quality.corrective_action. Business justification: Quality hold may be linked to a corrective action plan. N holds : 1 corrective_action. Remove corrective_action_number as it can be retrieved from corrective_action.',
    `defect_id` BIGINT COMMENT 'Foreign key linking to quality.quality_defect. Business justification: Quality hold is triggered by a specific defect type. N holds : 1 quality_defect. Remove defect_code as it can be retrieved from quality_defect.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Quality holds triggered by compliance violations (restricted substances detected, flammability failures) must reference the compliance incident for regulatory reporting, penalty tracking, and executiv',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to quality.inspection. Business justification: Quality hold is triggered by inspection failure. N holds : 1 inspection. Remove inspection_type, aql_level, and defect counts as they can be retrieved from inspection.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to production.lot. Business justification: Holds are placed on specific production lots for granular inventory control. Essential for warehouse management system integration, lot-level inventory blocking, and enabling partial release when only',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Quality holds require responsible quality manager employees for release authority and accountability. Real business process: hold management, release approval, and manager performance tracking. Remove',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Holds can be material-specific (material_type exists as text). FK enables material quality tracking for supplier material approval, restricted substance compliance holds, and material-level corrective',
    `non_conformance_id` BIGINT COMMENT 'Foreign key linking to quality.non_conformance. Business justification: Quality hold is often linked to a formal non-conformance report. N holds : 1 non_conformance. Remove ncr_number as it can be retrieved from non_conformance.',
    `fulfillment_id` BIGINT COMMENT 'Foreign key linking to order.fulfillment. Business justification: Quality holds block warehouse fulfillment execution when defects detected during pick/pack. WMS integration enforces hold at fulfillment level to prevent shipment of non-conforming inventory to custom',
    `rtv_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.rtv_order. Business justification: Holds trigger RTVs when disposition is return-to-vendor. Direct workflow link between quality hold decision and sourcing RTV execution for vendor returns.',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to order.sales_order. Business justification: Quality holds block customer order fulfillment when defects are detected pre-ship. Essential for preventing non-conforming goods from reaching customers and managing order delivery commitments during ',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Holds track sku as text. FK enables WMS inventory blocking at SKU level, ATP calculation exclusions, and SKU-specific disposition workflows. Critical for inventory accuracy and order fulfillment syste',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order. Business justification: Holds block PO shipments pending quality resolution. Critical for inventory management, financial accruals, and vendor payment holds. Standard apparel quality control workflow.',
    `standard_id` BIGINT COMMENT 'Foreign key linking to quality.quality_standard. Business justification: Quality hold is triggered by violation of a compliance standard. N holds : 1 quality_standard. Remove compliance_standard_violated as it can be retrieved from quality_standard.',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Quality holds reference style_code as text. FK enables hold analysis by style for product quality trends, financial impact assessment by style, and style-level disposition decision support. Essential ',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Quality holds block specific work orders from shipping when defects are found. Critical for inventory management, WMS blocking, customer shipment control, and tracking financial impact of quality issu',
    `corrective_action_required` BOOLEAN COMMENT 'Flag indicating whether a formal corrective action plan is required from the supplier or internal team to address the root cause of the quality issue.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the goods were manufactured, required for customs compliance and origin labeling per FTC regulations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the quality hold record was first created in the system, supporting audit trail and data lineage.',
    `disposition_date` DATE COMMENT 'Date when the final disposition decision was made and executed, marking the resolution of the quality hold.',
    `disposition_decision` STRING COMMENT 'Final disposition decision for the held goods: released (approved for use/sale), rework (sent for correction), scrap (destroyed), RTV (Return to Vendor), use as-is (accepted with deviation), or downgrade (sold at reduced price or to outlet channel).. Valid values are `released|rework|scrap|rtv|use_as_is|downgrade`',
    `duration_days` STRING COMMENT 'Number of calendar days the goods were on hold, calculated from hold initiation date to release/disposition date, used for quality performance metrics and supplier scorecarding.',
    `estimated_financial_impact` DECIMAL(18,2) COMMENT 'Estimated financial impact of the quality hold in USD, including cost of goods on hold, potential rework costs, and risk of customer chargebacks or penalties.',
    `factory_name` STRING COMMENT 'Name of the manufacturing factory where the held goods were produced, supporting traceability and supplier quality management.',
    `hold_status` STRING COMMENT 'Current lifecycle status of the quality hold: active (goods blocked), under review (quality team investigating), pending disposition (awaiting decision), released (hold lifted, goods approved), reworked (goods sent for correction), scrapped (goods destroyed), or RTV (Return to Vendor). [ENUM-REF-CANDIDATE: active|under_review|pending_disposition|released|reworked|scrapped|rtv — 7 candidates stripped; promote to reference product]',
    `hold_type` STRING COMMENT 'Classification of the quality hold reason: inspection failure (inline or final random inspection), lab test failure (physical/chemical/colorfastness), NCR (Non-Conformance Report), PP (Pre-Production) sample approval pending, compliance failure (OEKO-TEX, GOTS, CPSC), or customer complaint-driven hold.. Valid values are `inspection_failure|lab_test_failure|ncr|pp_approval_pending|compliance_failure|customer_complaint`',
    `initiation_date` DATE COMMENT 'Date when the quality hold was placed on the goods, marking the start of the hold period and blocking inventory movement.',
    `lab_test_report_number` STRING COMMENT 'Reference number for the laboratory test report if the hold was triggered by physical, chemical, or performance test failure (e.g., colorfastness, flammability, chemical content).. Valid values are `^LAB-[0-9]{8}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the quality hold record was last updated, tracking changes to hold status, disposition decisions, or other attributes.',
    `location_code` STRING COMMENT 'Specific location code or identifier (facility code, warehouse ID, or 3PL site code) where the held goods are stored, enabling physical retrieval and inspection.. Valid values are `^[A-Z0-9]{4,10}$`',
    `location_type` STRING COMMENT 'Type of location where the held goods are physically located: factory (manufacturing site), distribution center (company-owned DC), warehouse (storage facility), third-party logistics (3PL provider), in transit (goods en route), or retail store.. Valid values are `factory|distribution_center|warehouse|third_party_logistics|in_transit|retail_store`',
    `quantity_on_hold` DECIMAL(18,2) COMMENT 'Quantity of goods placed on hold, measured in the unit of measure appropriate to the material type (units for finished goods, yards/meters for fabric, pieces for trims).',
    `reason_description` STRING COMMENT 'Detailed narrative description of the quality issue or defect that triggered the hold, including specific defect types, test failure details, or non-conformance observations.',
    `reference_number` STRING COMMENT 'Business-facing unique reference number for the quality hold, used for tracking and communication with suppliers and internal teams.. Valid values are `^QH-[0-9]{8}-[A-Z0-9]{6}$`',
    `reinspection_date` DATE COMMENT 'Date when re-inspection of the held goods was performed after rework or corrective action.',
    `reinspection_required` BOOLEAN COMMENT 'Flag indicating whether the goods must undergo re-inspection after rework or corrective action before the hold can be released.',
    `reinspection_result` STRING COMMENT 'Result of the re-inspection: passed (goods approved), failed (hold continues or disposition changes), or conditional pass (approved with specific usage restrictions).. Valid values are `passed|failed|conditional_pass`',
    `release_conditions` STRING COMMENT 'Specific conditions or corrective actions required before the hold can be released, such as rework completion, re-inspection passing, lab test approval, or supplier corrective action plan acceptance.',
    `release_date` DATE COMMENT 'Date when the quality hold was released and goods were approved for movement, sale, or use. Null if hold is still active or goods were scrapped/returned.',
    `rework_completion_date` DATE COMMENT 'Date when rework or corrective actions on the held goods were completed, enabling re-inspection and potential release.',
    `supplier_code` STRING COMMENT 'Unique identifier for the supplier or factory that produced the goods on hold, enabling supplier performance tracking and corrective action follow-up.. Valid values are `^SUP-[0-9]{6}$`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity on hold, aligned with industry standards for apparel materials and finished goods.. Valid values are `units|yards|meters|pieces|kilograms|pounds`',
    `wms_block_flag` BOOLEAN COMMENT 'System flag indicating whether the held goods are blocked in the WMS, preventing picking, shipping, or transfer transactions until the hold is released.',
    CONSTRAINT pk_quality_hold PRIMARY KEY(`quality_hold_id`)
) COMMENT 'Operational record placing a hold on a specific quantity of goods (fabric, WIP, or finished goods) pending quality resolution. Captures hold reference number, hold type (inspection failure, lab test failure, NCR, pending PP approval), affected PO/style/SKU/lot, quantity on hold, hold location (factory, DC, warehouse), hold initiation date, hold reason, responsible quality manager, release conditions, release date, and final disposition (released, reworked, scrapped, RTV). Integrates with WMS and inventory to block movement of held goods.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` (
    `aql_plan_id` BIGINT COMMENT 'Unique identifier for the AQL sampling plan configuration.',
    `superseded_by_plan_aql_plan_id` BIGINT COMMENT 'Reference to the AQL plan that replaces this plan when it is superseded. Null if the plan is still current or has been archived without replacement.',
    `accept_number_critical` STRING COMMENT 'Maximum number of critical defects allowed in the sample for the lot to be accepted. Typically 0 for critical defects.',
    `accept_number_major` STRING COMMENT 'Maximum number of major defects allowed in the sample for the lot to be accepted.',
    `accept_number_minor` STRING COMMENT 'Maximum number of minor defects allowed in the sample for the lot to be accepted.',
    `applicable_product_category` STRING COMMENT 'Product category or categories to which this AQL plan applies (e.g., apparel, footwear, accessories, outerwear, activewear). Null indicates the plan is category-agnostic.',
    `applicable_supplier_tier` STRING COMMENT 'Supplier tier classification to which this AQL plan applies. Tier 1 suppliers may have more stringent or relaxed plans based on performance history.. Valid values are `tier_1|tier_2|tier_3|all_tiers`',
    `approval_status` STRING COMMENT 'Approval workflow status for the AQL plan. Plans must be approved before becoming active.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the quality manager or authorized person who approved this AQL plan.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the AQL plan was approved for use.',
    `aql_critical` DECIMAL(18,2) COMMENT 'AQL percentage for critical defects (defects that render the product unsafe or non-compliant with mandatory regulations). Typical values range from 0.0 to 0.65 percent. Critical defects are those that could cause injury or violate safety standards such as CPSC, OEKO-TEX, or GOTS.',
    `aql_major` DECIMAL(18,2) COMMENT 'AQL percentage for major defects (defects that significantly affect product usability, performance, or appearance and are likely to result in customer rejection). Typical values range from 1.0 to 2.5 percent.',
    `aql_minor` DECIMAL(18,2) COMMENT 'AQL percentage for minor defects (defects that do not significantly affect product usability but represent deviations from specifications). Typical values range from 2.5 to 6.5 percent.',
    `aql_plan_status` STRING COMMENT 'Current lifecycle status of the AQL plan configuration.. Valid values are `active|inactive|draft|archived|superseded|under_review`',
    `compliance_standard` STRING COMMENT 'Regulatory or certification standards that this AQL plan is designed to satisfy (e.g., OEKO-TEX Standard 100, CPSC, GOTS, FTC labeling, ISO 9001). Multiple standards may be comma-separated.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this AQL plan record was first created in the system.',
    `effective_date` DATE COMMENT 'Date from which this AQL plan becomes active and applicable to inspections.',
    `expiration_date` DATE COMMENT 'Date after which this AQL plan is no longer valid. Null indicates the plan remains active indefinitely until superseded or archived.',
    `inspection_level` STRING COMMENT 'General inspection level (I, II, III) or special inspection level (S-1 through S-4) that determines the relationship between lot size and sample size. Level II is typical for general use; Level I requires smaller samples; Level III requires larger samples. Special levels S-1 through S-4 are used when small sample sizes are necessary and large sampling risks can be tolerated. [ENUM-REF-CANDIDATE: I|II|III|S-1|S-2|S-3|S-4 — 7 candidates stripped; promote to reference product]',
    `inspection_standard` STRING COMMENT 'The quality inspection standard framework upon which this AQL plan is based.. Valid values are `ANSI_ASQ_Z1_4|ISO_2859_1|MIL_STD_105E|custom`',
    `last_modified_by` STRING COMMENT 'User or system identifier of the person who last modified this AQL plan record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this AQL plan record was last updated.',
    `lot_size_max` STRING COMMENT 'Maximum lot size (in units) to which this AQL plan applies. Defines the upper bound of the lot size range for sample size determination. Null indicates no upper limit.',
    `lot_size_min` STRING COMMENT 'Minimum lot size (in units) to which this AQL plan applies. Defines the lower bound of the lot size range for sample size determination.',
    `notes` STRING COMMENT 'Additional notes, instructions, or context for the application of this AQL plan, including special handling instructions or exceptions.',
    `plan_code` STRING COMMENT 'Business identifier code for the AQL sampling plan, used for reference in inspection workflows and quality documentation.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `plan_name` STRING COMMENT 'Descriptive name of the AQL sampling plan for business user identification.',
    `plan_type` STRING COMMENT 'Classification of the AQL plan indicating its application scope and derivation basis.. Valid values are `standard|custom|supplier_specific|category_specific|risk_based|regulatory`',
    `quality_gate_stage` STRING COMMENT 'Stage in the Time and Action (T&A) calendar or production lifecycle where this AQL plan is applied (e.g., PP sample, pre-production, inline inspection, final random inspection, shipment inspection). Multiple stages may be comma-separated. [ENUM-REF-CANDIDATE: pp_sample|pre_production|inline_inspection|final_random_inspection|shipment_inspection|receiving_inspection|in_process_inspection — promote to reference product]',
    `reject_number_critical` STRING COMMENT 'Minimum number of critical defects in the sample that triggers lot rejection. Typically 1 for critical defects.',
    `reject_number_major` STRING COMMENT 'Minimum number of major defects in the sample that triggers lot rejection.',
    `reject_number_minor` STRING COMMENT 'Minimum number of minor defects in the sample that triggers lot rejection.',
    `risk_level` STRING COMMENT 'Risk classification of products or suppliers to which this AQL plan applies. Higher risk levels typically require more stringent inspection (lower AQL values, larger sample sizes, or tightened inspection).. Valid values are `low|medium|high|critical`',
    `sample_size` STRING COMMENT 'Number of units to be randomly selected and inspected from the lot, determined by the sample size code letter and inspection type (single, double, multiple).',
    `sample_size_code_letter` STRING COMMENT 'Code letter (A through R) assigned based on lot size and inspection level, used to determine the actual sample size from the master sampling tables. [ENUM-REF-CANDIDATE: A|B|C|D|E|F|G|H|J|K|L|M|N|P|Q|R — 16 candidates stripped; promote to reference product]',
    `sampling_plan_type` STRING COMMENT 'Type of sampling plan: single (one sample, one decision), double (up to two samples with intermediate decision), or multiple (up to seven samples with cumulative decision).. Valid values are `single|double|multiple`',
    `source_system` STRING COMMENT 'Name of the operational system from which this AQL plan record originated (e.g., SAP QM, Infor PLM, Centric PLM, proprietary quality management system).',
    `source_system_code` STRING COMMENT 'Unique identifier of this AQL plan in the source operational system, used for traceability and reconciliation.',
    `switching_rule` STRING COMMENT 'Current inspection severity level. Normal is the default. Tightened inspection is applied when quality history deteriorates (2 out of 5 consecutive lots rejected). Reduced inspection is applied when quality history is consistently good (10 consecutive lots accepted under normal inspection). Switching rules are defined in ANSI/ASQ Z1.4 Section 9.. Valid values are `normal|tightened|reduced`',
    `version_number` STRING COMMENT 'Version identifier for the AQL plan configuration, following semantic versioning (e.g., 1.0, 1.1, 2.0) to track revisions and updates.. Valid values are `^[0-9]+.[0-9]+$`',
    `created_by` STRING COMMENT 'User or system identifier of the person who created this AQL plan record.',
    CONSTRAINT pk_aql_plan PRIMARY KEY(`aql_plan_id`)
) COMMENT 'Reference configuration defining Acceptable Quality Level (AQL) sampling plans per ANSI/ASQ Z1.4 (ISO 2859-1) applied to inspections by product category, supplier tier, or risk level. Stores AQL level (0.65–6.5), inspection level (I/II/III, S-1 through S-4), lot size ranges, sample size code letters, and accept/reject number pairs for critical/major/minor defect classes. Supports tightened/normal/reduced switching rules based on inspection history. Drives automated sample size calculation and pass/fail determination in all inspection workflows.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`quality`.`gate` (
    `gate_id` BIGINT COMMENT 'Unique identifier for the quality gate configuration record.',
    `predecessor_gate_id` BIGINT COMMENT 'Reference to the quality gate that must be completed before this gate can be executed. Null if this is the first gate or has no predecessor dependency.',
    `applicable_order_type` STRING COMMENT 'Type of production order to which this quality gate applies (production, sample, bulk, all).. Valid values are `production|sample|bulk|all`',
    `applicable_product_category` STRING COMMENT 'Product category or categories to which this quality gate applies (e.g., Apparel, Footwear, Accessories, All). Multiple categories separated by semicolon. Null indicates applies to all categories.',
    `applicable_supplier_tier` STRING COMMENT 'Supplier tier classification to which this quality gate applies (Tier 1, Tier 2, Tier 3, All Tiers). Null indicates applies to all suppliers.. Valid values are `tier_1|tier_2|tier_3|all_tiers`',
    `approval_authority` STRING COMMENT 'Job role or title authorized to provide formal approval for this quality gate (e.g., QA Director, Technical Design Manager, Compliance Lead).',
    `approval_required` BOOLEAN COMMENT 'Boolean flag indicating whether formal approval signature is required to pass this gate.',
    `aql_level` STRING COMMENT 'Acceptable Quality Limit (AQL) level for inspection sampling, expressed as percentage of defects allowed (e.g., 1.5, 2.5, 4.0). Applicable for inspection gates.. Valid values are `^(0.065|0.10|0.15|0.25|0.40|0.65|1.0|1.5|2.5|4.0|6.5|10.0)$`',
    `auto_escalation_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether automatic escalation is enabled when the gate is not completed within SLA.',
    `bypass_authority_role` STRING COMMENT 'Job role or title authorized to bypass or override this quality gate in exceptional circumstances (e.g., VP Quality, Chief Product Officer, General Manager).',
    `bypass_requires_justification` BOOLEAN COMMENT 'Boolean flag indicating whether a written justification is required when the gate is bypassed.',
    `compliance_standard` STRING COMMENT 'Regulatory or industry compliance standard enforced by this quality gate (e.g., OEKO-TEX Standard 100, CPSC 16 CFR Part 1610, GOTS 6.0, ISO 9001, WRAP, FLA). Multiple standards separated by semicolon.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this quality gate configuration record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date after which this quality gate configuration is no longer effective. Null indicates no end date (indefinite).',
    `effective_start_date` DATE COMMENT 'Date from which this quality gate configuration becomes effective and enforceable.',
    `enforcement_level` STRING COMMENT 'Enforcement mode of the quality gate: blocking (production/shipment cannot proceed without pass), advisory (warning issued but can proceed), warning (notification only).. Valid values are `blocking|advisory|warning`',
    `escalation_recipient_email` STRING COMMENT 'Email address or distribution list to receive escalation notifications when the gate is overdue.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `escalation_threshold_hours` STRING COMMENT 'Number of hours past the SLA deadline before automatic escalation is triggered. Null if auto-escalation is disabled.',
    `gate_category` STRING COMMENT 'High-level category of the quality gate (material, sample, production, inspection, compliance, shipment).. Valid values are `material|sample|production|inspection|compliance|shipment`',
    `gate_code` STRING COMMENT 'Unique business identifier code for the quality gate (e.g., FAB_APPR, LAB_TEST, PP_SIGN, INLINE_INSP, FINAL_RND, TOP_APPR, PRESHIP).. Valid values are `^[A-Z0-9_]{3,20}$`',
    `gate_description` STRING COMMENT 'Detailed description of the quality gate purpose, scope, and requirements.',
    `gate_name` STRING COMMENT 'Descriptive name of the quality gate checkpoint (e.g., Fabric Approval, Lab Test Pass, Pre-Production Sample Sign-Off, In-Line Inspection, Final Random Inspection, Time of Production Approval, Pre-Shipment Inspection).',
    `gate_status` STRING COMMENT 'Current status of the quality gate configuration (active, inactive, draft, deprecated).. Valid values are `active|inactive|draft|deprecated`',
    `inspection_level` STRING COMMENT 'ISO 2859-1 inspection level that determines sample size (General I, General II, General III, Special S-1, S-2, S-3, S-4). Applicable for inspection gates. [ENUM-REF-CANDIDATE: general_i|general_ii|general_iii|special_s1|special_s2|special_s3|special_s4 — 7 candidates stripped; promote to reference product]',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this quality gate configuration record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this quality gate configuration record was last modified.',
    `lifecycle_stage` STRING COMMENT 'Stage in the product lifecycle where this quality gate is enforced within the Time & Action (T&A) calendar (fabric approval, lab test, PP sample sign-off, in-line inspection, final random inspection, TOP approval, pre-shipment). [ENUM-REF-CANDIDATE: fabric_approval|lab_test|pp_sample_signoff|inline_inspection|final_random_inspection|top_approval|pre_shipment — 7 candidates stripped; promote to reference product]',
    `notification_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether automated notifications are sent when this gate is approaching or overdue.',
    `notification_recipient_list` STRING COMMENT 'Comma-separated list of email addresses or distribution lists to receive notifications for this quality gate.',
    `pass_criteria` STRING COMMENT 'Detailed specification of the criteria that must be satisfied for the gate to pass (e.g., AQL levels, test results, approval signatures, defect thresholds).',
    `required_documentation` STRING COMMENT 'List of documents or records that must be submitted for gate approval (e.g., lab test report, PP sample photos, inspection report, certificate of compliance). Multiple documents separated by semicolon.',
    `responsible_role` STRING COMMENT 'Specific job role or title responsible for gate approval (e.g., QA Manager, Technical Designer, Compliance Officer, Production Manager).',
    `responsible_team` STRING COMMENT 'Internal team or department responsible for executing and approving this quality gate (quality assurance, product development, sourcing, production, lab testing, compliance, supplier quality). [ENUM-REF-CANDIDATE: quality_assurance|product_development|sourcing|production|lab_testing|compliance|supplier_quality — 7 candidates stripped; promote to reference product]',
    `sequence` STRING COMMENT 'Sequential order of this gate within the overall quality gate framework (1, 2, 3, etc.). Lower numbers indicate earlier gates in the T&A calendar.',
    `sla_days_before_exfactory` STRING COMMENT 'Number of days before the ex-factory date that this quality gate must be completed, as defined in the Time & Action (T&A) calendar. Negative values indicate days after ex-factory.',
    `source_system` STRING COMMENT 'Name of the source system from which this quality gate configuration originated (e.g., Infor PLM, Centric PLM, SAP QM, proprietary QMS).',
    `source_system_code` STRING COMMENT 'Unique identifier of this quality gate configuration in the source system.',
    `test_method_reference` STRING COMMENT 'Reference to the specific test method, protocol, or standard operating procedure (SOP) used for this gate (e.g., AATCC 61, ISO 105-C06, ASTM D1230). Applicable for lab test and inspection gates.',
    `version_number` STRING COMMENT 'Version number of the quality gate configuration (e.g., 1.0, 2.1). Incremented when gate criteria or requirements are updated.. Valid values are `^[0-9]+.[0-9]+$`',
    `created_by` STRING COMMENT 'User ID or name of the person who created this quality gate configuration record.',
    CONSTRAINT pk_gate PRIMARY KEY(`gate_id`)
) COMMENT 'Configuration record defining mandatory quality checkpoints within the Time & Action (T&A) calendar that must be satisfied before production or shipment can proceed. Each gate specifies gate name, lifecycle stage (fabric approval, lab test pass, PP sample sign-off, in-line inspection, final random inspection, TOP approval, pre-shipment), required pass criteria, responsible team, SLA days relative to ex-factory date, blocking vs. advisory enforcement level, auto-escalation rules, and bypass authority. Ensures systematic quality enforcement across all production orders and prevents shipment of non-conforming goods.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`quality`.`fit_session` (
    `fit_session_id` BIGINT COMMENT 'Unique identifier for the fit evaluation session. Primary key for the fit session record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Fit sessions require employee evaluators for approval authority and accountability. Real business process: fit approval workflow, evaluator assignment, and decision tracking. Removes denormalized fit_',
    `fit_model_id` BIGINT COMMENT 'Reference to the fit model who wore the garment during the evaluation session. Fit models have standardized body measurements representing target customer segments.',
    `quality_sample_id` BIGINT COMMENT 'Foreign key linking to quality.quality_sample. Business justification: Fit session evaluates a physical quality sample (PP sample, SMS sample, etc.). N fit_sessions : 1 quality_sample. No columns removed because sample_type on fit_session may be execution-specific.',
    `sample_request_id` BIGINT COMMENT 'Foreign key linking to sourcing.sample_request. Business justification: Fit sessions evaluate samples from sourcing requests. Links fit approval decisions to sample submissions for pattern amendments and PP approval workflow in apparel product development.',
    `sketch_id` BIGINT COMMENT 'Foreign key linking to design.design_sketch. Business justification: Fit sessions evaluate how physical samples match original design sketch intent, proportions, and aesthetic vision. Critical for design approval workflows, pattern amendment decisions, and ensuring pro',
    `style_id` BIGINT COMMENT 'Reference to the style or garment prototype being evaluated in this fit session.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or Cut Make Trim (CMT) partner who produced the sample being evaluated. Links fit quality to supplier performance.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Fit sessions evaluate samples from specific work orders (SMS, TOP, PP stages). Required for production approval decisions, pattern amendment authorization, and determining if work order can proceed or',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the fit was formally approved, marking completion of this quality gate. Null if fit is not yet approved.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who provided final fit approval. Establishes accountability for quality gate sign-off.',
    `armhole_fit_comment` STRING COMMENT 'Detailed fit evaluation comments for the armhole area including depth and circumference. Documents fit issues, adjustments needed, or approval notes for this body zone.',
    `chest_bust_fit_comment` STRING COMMENT 'Detailed fit evaluation comments for the chest or bust area. Documents fit issues, adjustments needed, or approval notes for this body zone.',
    `construction_issue_flag` BOOLEAN COMMENT 'Indicates whether construction or workmanship issues were identified during the fit session that require corrective action beyond pattern changes.',
    `construction_issue_notes` STRING COMMENT 'Details of any construction, stitching, or assembly issues identified during fit evaluation (e.g., seam puckering, uneven hem, incorrect stitch type).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this fit session record was created in the system. Supports audit trail and data lineage.',
    `fabric_performance_comment` STRING COMMENT 'Observations on fabric behavior during fit session including drape, stretch recovery, wrinkling, and comfort. Informs fabric approval decisions.',
    `fit_evaluator_team` STRING COMMENT 'Comma-separated list of additional team members present during the fit session (designers, merchandisers, product managers). Captures cross-functional collaboration.',
    `fit_model_measurements` STRING COMMENT 'Key body measurements of the fit model at the time of the session (e.g., bust-waist-hip in inches or centimeters). Provides context for fit evaluation.',
    `fit_stage` STRING COMMENT 'The stage in the product development lifecycle at which this fit session occurs. Aligns with quality gates in the Time and Action (T&A) calendar from prototype through Pre-Production (PP) sample approval. [ENUM-REF-CANDIDATE: proto|first_fit|second_fit|final_fit|pp_sample|top_sample|size_set — 7 candidates stripped; promote to reference product]',
    `grading_notes` STRING COMMENT 'Notes on how fit adjustments should be applied across the size range during grading. Ensures proportional fit across all sizes based on base size approval.',
    `hip_fit_comment` STRING COMMENT 'Detailed fit evaluation comments for the hip area. Documents fit issues, adjustments needed, or approval notes for this body zone.',
    `inseam_fit_comment` STRING COMMENT 'Detailed fit evaluation comments for the inseam and crotch area (applicable to bottoms). Documents fit issues, adjustments needed, or approval notes for this body zone.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified this fit session record. Supports audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this fit session record was last updated. Supports change tracking and audit trail.',
    `length_fit_comment` STRING COMMENT 'Detailed fit evaluation comments for overall garment length (hem, rise, torso length). Documents fit issues, adjustments needed, or approval notes for this body zone.',
    `measurement_variance_flag` BOOLEAN COMMENT 'Indicates whether actual garment measurements deviate from tech pack specifications beyond acceptable tolerance. Triggers measurement reconciliation.',
    `neckline_fit_comment` STRING COMMENT 'Detailed fit evaluation comments for the neckline and collar area. Documents fit issues, adjustments needed, or approval notes for this body zone.',
    `next_fit_session_required` BOOLEAN COMMENT 'Indicates whether an additional fit session is required after pattern amendments are made. Drives scheduling in the Time and Action (T&A) calendar.',
    `overall_fit_comment` STRING COMMENT 'General fit evaluation comments covering overall silhouette, balance, proportion, and any cross-zone observations not captured in body-zone-specific comments.',
    `overall_fit_status` STRING COMMENT 'The overall approval status resulting from this fit session. Determines whether the style can proceed to the next quality gate or requires additional fit sessions.. Valid values are `approved|approved_with_minor_changes|rejected|on_hold`',
    `pattern_amendment_notes` STRING COMMENT 'Detailed instructions for pattern maker on specific adjustments required (e.g., add 0.5 inch to shoulder seam, reduce waist by 1 cm). Supports technical specification updates.',
    `pattern_amendment_required` BOOLEAN COMMENT 'Indicates whether pattern adjustments are required based on fit session findings. Triggers pattern maker work in the product development workflow.',
    `photo_reference` STRING COMMENT 'File path or URL reference to photos taken during the fit session. Visual documentation supports remote collaboration and historical reference.',
    `sample_type` STRING COMMENT 'The type of sample garment being evaluated. Sample Management System (SMS) categorization for tracking sample inventory and usage.. Valid values are `proto|sms|pp_sample|production_sample|size_set|photo_sample`',
    `season_code` STRING COMMENT 'The season and year for which this style is being developed (e.g., SS24 for Spring/Summer 2024, FW24 for Fall/Winter 2024).. Valid values are `^[A-Z]{2}[0-9]{2}$`',
    `session_date` DATE COMMENT 'The date on which the fit evaluation session was conducted. Critical for tracking progress against the Time and Action (T&A) calendar.',
    `session_number` STRING COMMENT 'Sequential number of this fit session for the given style (e.g., 1 for first fit, 2 for second fit). Tracks iteration count through the fit approval process.',
    `shoulder_fit_comment` STRING COMMENT 'Detailed fit evaluation comments for the shoulder area. Documents fit issues, adjustments needed, or approval notes for this body zone.',
    `size_evaluated` STRING COMMENT 'The garment size being evaluated in this fit session (e.g., M, L, 8, 10). Typically the base size for initial fit approval before grading.',
    `sleeve_fit_comment` STRING COMMENT 'Detailed fit evaluation comments for the sleeve area including armhole, sleeve length, and cuff. Documents fit issues, adjustments needed, or approval notes for this body zone.',
    `source_system` STRING COMMENT 'Name of the source system from which this fit session record originated (e.g., Centric PLM, Infor PLM). Supports data lineage and integration traceability.',
    `source_system_code` STRING COMMENT 'Unique identifier of this fit session record in the source system. Enables cross-system reconciliation and data lineage tracking.',
    `target_next_fit_date` DATE COMMENT 'Planned date for the next fit session if additional evaluation is required. Supports Time and Action (T&A) calendar management and critical path tracking.',
    `tech_pack_version` STRING COMMENT 'Version number of the technical specification package (tech pack) used to produce the sample being evaluated. Ensures traceability to design specifications.',
    `waist_fit_comment` STRING COMMENT 'Detailed fit evaluation comments for the waist area. Documents fit issues, adjustments needed, or approval notes for this body zone.',
    `created_by` STRING COMMENT 'User identifier of the person who created this fit session record. Supports audit trail and accountability.',
    CONSTRAINT pk_fit_session PRIMARY KEY(`fit_session_id`)
) COMMENT 'Record of a formal fit evaluation session conducted on a garment prototype or sample. Captures session date, season, style reference, fit model measurements, size evaluated, fit evaluator team, fit comments by body zone (shoulder, chest, waist, hip, sleeve, inseam, length), grading notes, required pattern amendments, fit approval status, and next fit session required flag. Supports the product development quality workflow from proto through pre-production fit sign-off.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` (
    `measurement_spec_id` BIGINT COMMENT 'Unique identifier for the measurement specification record. Primary key.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the quality inspector or evaluator who performed the measurement.',
    `gate_id` BIGINT COMMENT 'Foreign key linking to quality.quality_gate. Business justification: Measurement validation occurs at a specific quality gate checkpoint. N measurement_specs : 1 quality_gate. No columns removed because quality_gate_stage is an execution value.',
    `quality_sample_id` BIGINT COMMENT 'Foreign key linking to quality.quality_sample. Business justification: Measurement spec is validated against a physical quality sample. N measurement_specs : 1 quality_sample. No columns removed because sample_id points to product.sample (cross-domain), which is a differ',
    `sample_request_id` BIGINT COMMENT 'Foreign key linking to sourcing.sample_request. Business justification: Measurement validation against sourcing samples is quality gate for PP approval. Links spec conformance to sample submissions for pattern corrections and bulk production authorization.',
    `sketch_id` BIGINT COMMENT 'Foreign key linking to design.design_sketch. Business justification: Measurement specifications are derived from design sketches and must reference them for design intent validation. Essential for verifying that graded specs maintain the designers intended proportions',
    `standard_id` BIGINT COMMENT 'Foreign key linking to quality.quality_standard. Business justification: Measurement spec is validated against a compliance standard. N measurement_specs : 1 quality_standard. Remove compliance_standard as it can be retrieved from quality_standard.',
    `style_id` BIGINT COMMENT 'Reference to the style for which this measurement specification is defined.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or manufacturer whose sample was measured.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Measurement specs are validated against work order outputs during inline and final inspection. Required for pass/fail decisions, production release authorization, and tracking measurement conformance ',
    `actual_measurement` DECIMAL(18,2) COMMENT 'Actual measurement value captured during fit session, pre-production sample inspection, or final random inspection.',
    `approved_by` STRING COMMENT 'Name of the person who approved the measurement specification or fit sample.',
    `approved_date` DATE COMMENT 'Date when the measurement specification or fit sample was approved.',
    `base_size` STRING COMMENT 'The base or sample size from which all other sizes are graded (e.g., M, 8, 38).',
    `base_size_measurement` DECIMAL(18,2) COMMENT 'Target measurement value for the base size at this measurement point.',
    `corrective_action_required` BOOLEAN COMMENT 'Flag indicating whether corrective action is required based on measurement results (pattern correction, grading adjustment, etc.).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the measurement specification record was first created in the system.',
    `effective_date` DATE COMMENT 'Date from which this measurement specification becomes effective and must be used for production.',
    `expiration_date` DATE COMMENT 'Date when this measurement specification is superseded or no longer valid.',
    `fit_approval_status` STRING COMMENT 'Overall fit approval decision based on measurement results (approved for production, rejected, conditional approval, pending review).. Valid values are `approved|rejected|conditional|pending`',
    `fit_comments` STRING COMMENT 'Detailed comments and notes from the fit session or inspection regarding measurement results, fit issues, and corrective actions needed.',
    `garment_type` STRING COMMENT 'Specific garment type within the category (e.g., t-shirt, jeans, jacket, sneaker).',
    `grade_rule` STRING COMMENT 'Grading rule defining how the measurement changes across size breaks (e.g., +1 inch per size, -0.5 cm per size).',
    `inspection_location` STRING COMMENT 'Location where the measurement was taken (e.g., factory name, lab name, headquarters fit room).',
    `inspector_name` STRING COMMENT 'Name of the quality inspector or evaluator who performed the measurement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the measurement specification record was last updated.',
    `measurement_date` DATE COMMENT 'Date when the actual measurement was taken during fit session or inspection.',
    `measurement_method` STRING COMMENT 'Method or technique used to take the measurement (e.g., flat lay, circumference, point-to-point).',
    `measurement_point_code` STRING COMMENT 'Standardized code for the measurement point used across tech packs and inspection protocols.',
    `measurement_point_name` STRING COMMENT 'Name of the specific measurement point on the garment (e.g., chest width, inseam length, sleeve length, waist circumference).',
    `measurement_stage` STRING COMMENT 'Stage in the Time and Action (T&A) calendar when the measurement was captured (fit session, PP sample, pre-production, inline, final).. Valid values are `fit_session|pp_sample|pre_production|inline_inspection|final_inspection`',
    `measurement_variance` DECIMAL(18,2) COMMENT 'Calculated variance between actual measurement and specified target measurement (actual minus target).',
    `pass_fail_status` STRING COMMENT 'Pass or fail determination for this measurement point based on whether actual measurement falls within tolerance.. Valid values are `pass|fail|conditional|not_measured`',
    `pattern_correction_notes` STRING COMMENT 'Specific instructions for pattern corrections needed to bring measurements within specification.',
    `product_category` STRING COMMENT 'High-level product category classification (e.g., tops, bottoms, outerwear, footwear, accessories).',
    `quality_gate_stage` STRING COMMENT 'Quality gate stage in the T&A calendar where this measurement checkpoint occurs (design approval, PP approval, production approval).',
    `sample_type` STRING COMMENT 'Type of sample measured (proto, fit sample, pre-production, SMS sample, production sample, golden sample).. Valid values are `proto|fit|pp|sms|production|golden`',
    `season_code` STRING COMMENT 'Season identifier for which this measurement specification applies (e.g., SS24, FW24).',
    `size_range` STRING COMMENT 'Size range covered by this specification (e.g., XS-XXL, 2-16, 6-12).',
    `source_system` STRING COMMENT 'Name of the source system from which this measurement specification was extracted (Centric PLM, Infor PLM, etc.).',
    `source_system_code` STRING COMMENT 'Unique identifier of this measurement specification record in the source PLM system.',
    `spec_number` STRING COMMENT 'Business identifier for the measurement specification, typically a human-readable code used in tech packs and PLM systems.',
    `spec_status` STRING COMMENT 'Current lifecycle status of the measurement specification in the approval workflow.. Valid values are `draft|submitted|approved|rejected|superseded|archived`',
    `spec_version` STRING COMMENT 'Version number of the measurement specification, incremented when spec is revised during product development or after fit sessions.',
    `tolerance_minus` DECIMAL(18,2) COMMENT 'Negative tolerance allowed below the target measurement before the garment is considered out of specification.',
    `tolerance_plus` DECIMAL(18,2) COMMENT 'Positive tolerance allowed above the target measurement before the garment is considered out of specification.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the measurement value (centimeters, inches, millimeters).. Valid values are `cm|inch|mm`',
    CONSTRAINT pk_measurement_spec PRIMARY KEY(`measurement_spec_id`)
) COMMENT 'Master record defining graded measurement specifications (spec sheet) for a style across all sizes, including actual measurement readings captured during fit sessions and inspections. Stores style reference, season, size range, measurement point name, base size measurement, grade rule per size break, tolerance (plus/minus), unit of measure, and spec version. Includes measurement result records: actual value measured, specified value, tolerance, variance, pass/fail per measurement point, and inspector/evaluator notes. Acts as the authoritative measurement standard and evidence base for fit approval or rejection decisions, supporting pattern correction workflows. Sourced from Centric PLM / Infor PLM tech pack data.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` (
    `rtv_disposition_id` BIGINT COMMENT 'Unique identifier for the RTV disposition record. Primary key.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: RTV dispositions generate vendor debit memos and credit adjustments that must link to original AP invoices for financial settlement, three-way match reversal, and vendor payment reconciliation in appa',
    `cogs_entry_id` BIGINT COMMENT 'Foreign key linking to finance.cogs_entry. Business justification: RTV dispositions require COGS reversal entries for returned defective goods to correct cost of sales, inventory valuation, and gross margin reporting in apparel financial statements and management rep',
    `defect_id` BIGINT COMMENT 'Foreign key linking to quality.quality_defect. Business justification: RTV disposition is triggered by a specific defect type. N rtv_dispositions : 1 quality_defect. Remove defect_type as it can be retrieved from quality_defect.',
    `gate_id` BIGINT COMMENT 'Foreign key linking to quality.quality_gate. Business justification: RTV disposition occurs at a specific quality gate stage. N rtv_dispositions : 1 quality_gate. No columns removed because quality_gate_stage is an execution value.',
    `inspection_id` BIGINT COMMENT 'Reference to the quality inspection record that identified the defect or non-conformance leading to this RTV. Links to quality.inspection.',
    `non_conformance_id` BIGINT COMMENT 'Reference to the originating non-conformance report that triggered this RTV disposition. Links to quality.corrective_action domain.',
    `order_purchase_order_id` BIGINT COMMENT 'Foreign key linking to order.purchase_order. Business justification: RTV authorizations reference original PO for vendor debit and replacement order processing. Financial reconciliation and vendor chargeback workflows require direct PO linkage for return-to-vendor tran',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: RTV dispositions require employee owners for authorization and accountability. Real business process: return authorization, disposition decision tracking, and employee performance management. Removes ',
    `production_factory_id` BIGINT COMMENT 'Identifier of the manufacturing facility that produced the non-conforming goods. May differ from supplier if using CMT or OEM arrangements.',
    `rtv_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.rtv_order. Business justification: Quality RTV dispositions drive sourcing RTV orders. Direct workflow link between quality decision (return, rework, scrap) and sourcing execution for vendor returns and credits.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: RTVs track sku as text. FK enables disposition tracking at SKU level for inventory adjustments, replacement PO generation, and SKU-specific vendor debit memos. Essential for financial reconciliation a',
    `standard_id` BIGINT COMMENT 'Foreign key linking to quality.quality_standard. Business justification: RTV disposition is triggered by violation of a compliance standard. N rtv_dispositions : 1 quality_standard. Remove compliance_standard_violated as it can be retrieved from quality_standard.',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: RTVs reference style_number as text. FK enables return analysis by style for vendor chargeback calculations, style quality performance tracking, and product development feedback loops. Critical for su',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier responsible for the non-conforming goods. The party to whom goods are being returned.',
    `waste_record_id` BIGINT COMMENT 'Foreign key linking to sustainability.waste_record. Business justification: RTV dispositions (landfill/recycle/rework/donate) generate waste records. Tracking this link measures zero-waste-to-landfill progress and calculates waste diversion rates for ESG reporting.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: RTV authorizations reference the originating work order for vendor debit memo generation, replacement order linkage, and tracking quality failure costs by production batch. Essential for supplier perf',
    `actual_receipt_date` DATE COMMENT 'Actual date when the supplier confirmed receipt of the returned goods. Triggers credit processing and closure workflow.',
    `closure_date` DATE COMMENT 'Date when the RTV disposition was fully closed. Indicates all actions (return, credit, replacement) have been completed and verified.',
    `closure_notes` STRING COMMENT 'Final notes and comments recorded at the time of RTV closure. Includes resolution summary, lessons learned, and any outstanding issues.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this RTV disposition record was first created in the system. Audit trail for record creation.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Financial credit amount expected or issued by the supplier for the returned goods. Represents the monetary value of the RTV.',
    `credit_issued_date` DATE COMMENT 'Date when the supplier issued the financial credit for the returned goods. Triggers accounts payable adjustment and financial reconciliation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the credit amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `disposition_date` DATE COMMENT 'Date when the RTV disposition was authorized and initiated. Principal business event timestamp for this transaction.',
    `disposition_instructions` STRING COMMENT 'Detailed instructions for handling the RTV, including packaging requirements, shipping instructions, documentation needed, and any special handling notes.',
    `disposition_status` STRING COMMENT 'Current lifecycle status of the RTV disposition process. Tracks progression from initiation through closure. [ENUM-REF-CANDIDATE: initiated|approved|in_transit|received_by_vendor|credit_issued|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `expected_receipt_date` DATE COMMENT 'Expected date when the supplier will receive the returned goods. Used for tracking and follow-up.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this RTV disposition record. Audit trail for change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this RTV disposition record was last updated. Audit trail for record modifications.',
    `logistics_carrier` STRING COMMENT 'Name of the shipping carrier or third-party logistics (3PL) provider handling the return shipment to the vendor.',
    `product_category` STRING COMMENT 'High-level product category classification for the returned goods (e.g., apparel, footwear, accessories).',
    `quality_gate_stage` STRING COMMENT 'Stage in the Time and Action (T&A) calendar or quality process where the non-conformance was detected. Indicates at which inspection checkpoint the issue was identified.. Valid values are `pre_production|inline|final_random|pre_shipment|receiving`',
    `replacement_po_number` STRING COMMENT 'Purchase order number for replacement goods, if the RTV type is replacement. Links to the new procurement transaction for substitute inventory.. Valid values are `^PO-[A-Z0-9]{8,15}$`',
    `return_quantity` STRING COMMENT 'Number of units being returned to the vendor through this RTV disposition.',
    `return_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for returning goods to the vendor. Aligns with AQL defect classification and inspection outcomes. [ENUM-REF-CANDIDATE: defect_critical|defect_major|defect_minor|wrong_item|damaged_in_transit|late_delivery|non_compliance|specification_mismatch — 8 candidates stripped; promote to reference product]',
    `return_reason_description` STRING COMMENT 'Detailed narrative explanation of why the goods are being returned. Includes specific defect descriptions, non-conformance details, and quality issues.',
    `return_shipment_date` DATE COMMENT 'Date when the goods were physically shipped back to the vendor.',
    `return_shipment_tracking_number` STRING COMMENT 'Tracking number for the return shipment. Used to monitor the physical movement of goods back to the supplier.',
    `rtv_authorization_number` STRING COMMENT 'Externally-known unique authorization number issued for this return-to-vendor transaction. Used for tracking and supplier communication.. Valid values are `^RTV-[A-Z0-9]{8,12}$`',
    `rtv_type` STRING COMMENT 'Classification of the RTV disposition action. Defines whether goods are physically returned, credited without return, replaced, repaired, or scrapped.. Valid values are `full_return|credit_only|replacement|repair|scrap`',
    `supplier_acknowledgment_date` DATE COMMENT 'Date when the supplier formally acknowledged the RTV authorization. Marks the start of the return logistics process.',
    `supplier_acknowledgment_flag` BOOLEAN COMMENT 'Indicates whether the supplier has acknowledged receipt of the RTV authorization and agreed to the disposition terms. True if acknowledged, False otherwise.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the return quantity (e.g., each, pieces, pairs, sets).. Valid values are `EA|PCS|PAIR|SET|BOX|CARTON`',
    `vendor_debit_memo_number` STRING COMMENT 'Debit memo number issued to the supplier for the financial charge-back associated with this RTV. Links to finance domain for accounts payable adjustment.. Valid values are `^VDM-[A-Z0-9]{8,12}$`',
    `warehouse_location` STRING COMMENT 'Warehouse or distribution center location code where the non-conforming goods were held prior to RTV disposition.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this RTV disposition record. Audit trail for accountability.',
    CONSTRAINT pk_rtv_disposition PRIMARY KEY(`rtv_disposition_id`)
) COMMENT 'Return-to-Vendor (RTV) disposition record for goods rejected through quality inspection or non-conformance. Captures RTV authorization number, originating NCR or inspection reference, affected PO/style/SKU, quantity to be returned, return reason, supplier responsible, RTV type (full return, credit, replacement), logistics instructions, return shipment tracking, financial credit amount, and disposition closure status. Integrates with supply chain and finance domains for vendor debit and inventory adjustment.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`quality`.`inspection_finding` (
    `inspection_finding_id` BIGINT COMMENT 'Unique identifier for this specific defect finding record. Primary key for the inspection_finding association.',
    `defect_id` BIGINT COMMENT 'Foreign key linking to the defect type classification from the quality defect taxonomy.',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to the quality inspection event during which this defect was identified.',
    `affected_unit_reference` STRING COMMENT 'Identifier or reference number of the specific unit(s) in the sample where this defect was found (e.g., sample unit 3 of 32).',
    `capa_trigger_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this finding triggered a formal Corrective and Preventive Action (CAPA) process due to severity or recurrence.',
    `defect_count` STRING COMMENT 'The number of occurrences of this specific defect type found during this inspection. Explicitly identified in detection phase as relationship data.',
    `defect_location_on_product` STRING COMMENT 'The specific location on the garment or product where this defect was observed (e.g., left sleeve seam, collar label, front panel). Explicitly identified in detection phase as relationship data.',
    `finding_timestamp` TIMESTAMP COMMENT 'The precise timestamp when this defect was identified and recorded during the inspection event.',
    `hold_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this specific finding triggered a hold on the lot or shipment, requiring immediate corrective action before release.',
    `inspector_notes` STRING COMMENT 'Free-text notes recorded by the inspector about this specific defect finding, including context, severity justification, or remediation recommendations. Explicitly identified in detection phase as relationship data.',
    `photo_evidence_url` STRING COMMENT 'URL or file path to photographic evidence of this specific defect finding. Explicitly identified in detection phase as relationship data.',
    `recorded_by_user` STRING COMMENT 'Identifier of the inspector or user who recorded this specific finding in the quality management system.',
    `severity_classification` STRING COMMENT 'The AQL severity classification assigned to this specific finding (Critical/Major/Minor). May differ from the defect catalog default based on inspector judgment. Explicitly identified in detection phase as relationship data.',
    CONSTRAINT pk_inspection_finding PRIMARY KEY(`inspection_finding_id`)
) COMMENT 'This association product represents the individual defect findings recorded during a quality inspection event. Each record captures one specific defect type identified during one inspection, with attributes that exist only in the context of this finding: the count of occurrences, severity classification, location on the garment, photographic evidence, and inspector notes. This is the operational record created by quality inspectors as they document findings during pre-production, in-line, and final random inspections.. Existence Justification: In apparel quality management, inspectors examine production lots and identify multiple defect types during a single inspection event (e.g., one inspection may find stitching defects, label placement issues, and fabric flaws). Conversely, each defect type from the quality taxonomy appears across many different inspections over time and across factories. The business actively manages these findings as operational records, with inspectors documenting count, location, severity, and photographic evidence for each defect type found during each inspection.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`quality`.`fit_model` (
    `fit_model_id` BIGINT COMMENT 'Primary key for fit_model',
    `reference_fit_model_id` BIGINT COMMENT 'Self-referencing FK on fit_model (reference_fit_model_id)',
    `agency_name` STRING COMMENT 'Name of the modeling agency representing the fit model, if applicable. Null for in-house or freelance models.',
    `availability_schedule` STRING COMMENT 'General availability pattern or schedule for the fit model (e.g., weekdays, specific days, time ranges).',
    `bust_measurement_cm` DECIMAL(18,2) COMMENT 'Bust circumference measurement of the fit model in centimeters, critical for upper body garment fitting.',
    `certification_date` DATE COMMENT 'Date when the fit model completed certification training for quality assessment protocols.',
    `certification_status` STRING COMMENT 'Indicates whether the fit model has completed internal training and certification for quality assessment protocols.',
    `contract_end_date` DATE COMMENT 'Date when the fit model engagement or contract expires or expired. Null for ongoing engagements.',
    `contract_start_date` DATE COMMENT 'Date when the fit model engagement or contract became effective.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fit model record was first created in the system.',
    `email_address` STRING COMMENT 'Primary email address for contacting the fit model for scheduling fitting sessions and quality assessments.',
    `gender` STRING COMMENT 'Gender classification of the fit model used for appropriate garment category assignments.',
    `height_cm` DECIMAL(18,2) COMMENT 'Total height of the fit model in centimeters, used for overall garment proportion assessment.',
    `hip_measurement_cm` DECIMAL(18,2) COMMENT 'Hip circumference measurement of the fit model in centimeters, critical for lower body garment fitting.',
    `hourly_rate_usd` DECIMAL(18,2) COMMENT 'Hourly compensation rate for the fit model in United States Dollars for fitting session work.',
    `inseam_measurement_cm` DECIMAL(18,2) COMMENT 'Inseam length measurement of the fit model in centimeters, used for pants and bottom garment fitting.',
    `last_measurement_update_date` DATE COMMENT 'Date when the fit model body measurements were last verified and updated to ensure accuracy in fit assessments.',
    `measurement_frequency_days` STRING COMMENT 'Required frequency in days for re-measuring the fit model to maintain measurement accuracy standards.',
    `model_code` STRING COMMENT 'Unique business identifier code assigned to the fit model for external reference and tracking across quality processes.',
    `model_name` STRING COMMENT 'Full name of the individual serving as the fit model for garment fitting and quality assessment.',
    `model_type` STRING COMMENT 'Classification of the fit model based on employment or engagement relationship with the business.',
    `neck_measurement_cm` DECIMAL(18,2) COMMENT 'Neck circumference measurement of the fit model in centimeters, used for collar and neckline fitting.',
    `notes` STRING COMMENT 'Additional notes, comments, or special considerations regarding the fit model (e.g., specific fit preferences, physical considerations, scheduling constraints).',
    `phone_number` STRING COMMENT 'Primary contact phone number for the fit model used for scheduling and communication.',
    `preferred_fitting_location` STRING COMMENT 'Primary facility or location where the fit model prefers to conduct fitting sessions.',
    `product_category_specialization` STRING COMMENT 'Primary product categories that the fit model specializes in for fitting sessions (e.g., activewear, outerwear, denim, dresses). Multiple categories may be pipe-separated.',
    `shoe_size` STRING COMMENT 'Shoe size of the fit model used for footwear fitting and quality assessment sessions.',
    `shoulder_width_cm` DECIMAL(18,2) COMMENT 'Shoulder width measurement of the fit model in centimeters, used for upper body garment shoulder seam placement.',
    `size_category` STRING COMMENT 'Body proportion category of the fit model used to represent specific customer segments in fit testing.',
    `sleeve_length_cm` DECIMAL(18,2) COMMENT 'Sleeve length measurement from shoulder to wrist in centimeters, critical for upper garment sleeve fitting.',
    `standard_size` STRING COMMENT 'The standard garment size that the fit model represents (e.g., S, M, L, XL, or numeric sizing).',
    `fit_model_status` STRING COMMENT 'Current lifecycle status of the fit model indicating availability for fitting sessions and quality assessments.',
    `total_fitting_sessions` STRING COMMENT 'Cumulative count of fitting sessions completed by the fit model since engagement start.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the fit model record was last modified in the system.',
    `waist_measurement_cm` DECIMAL(18,2) COMMENT 'Waist circumference measurement of the fit model in centimeters, essential for mid-body garment fitting.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Weight of the fit model in kilograms, monitored to ensure consistency in fit assessments over time.',
    CONSTRAINT pk_fit_model PRIMARY KEY(`fit_model_id`)
) COMMENT 'Master reference table for fit_model. Referenced by fit_model_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_aql_plan_id` FOREIGN KEY (`aql_plan_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`aql_plan`(`aql_plan_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_gate_id` FOREIGN KEY (`gate_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`gate`(`gate_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_standard_id` FOREIGN KEY (`standard_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`standard`(`standard_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_defect_id` FOREIGN KEY (`defect_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`defect`(`defect_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ADD CONSTRAINT `fk_quality_non_conformance_related_ncr_non_conformance_id` FOREIGN KEY (`related_ncr_non_conformance_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`non_conformance`(`non_conformance_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_gate_id` FOREIGN KEY (`gate_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`gate`(`gate_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_non_conformance_id` FOREIGN KEY (`non_conformance_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`non_conformance`(`non_conformance_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_standard_id` FOREIGN KEY (`standard_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`standard`(`standard_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ADD CONSTRAINT `fk_quality_quality_sample_standard_id` FOREIGN KEY (`standard_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`standard`(`standard_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_quality_sample_id` FOREIGN KEY (`quality_sample_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`quality_sample`(`quality_sample_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_retest_of_test_id` FOREIGN KEY (`retest_of_test_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`lab_test`(`lab_test_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ADD CONSTRAINT `fk_quality_lab_test_standard_id` FOREIGN KEY (`standard_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`standard`(`standard_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_quality_certification_id` FOREIGN KEY (`quality_certification_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`quality_certification`(`quality_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_standard_id` FOREIGN KEY (`standard_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`standard`(`standard_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ADD CONSTRAINT `fk_quality_standard_superseded_by_standard_id` FOREIGN KEY (`superseded_by_standard_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`standard`(`standard_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_standard_id` FOREIGN KEY (`standard_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`standard`(`standard_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_defect_id` FOREIGN KEY (`defect_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`defect`(`defect_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_non_conformance_id` FOREIGN KEY (`non_conformance_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`non_conformance`(`non_conformance_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ADD CONSTRAINT `fk_quality_quality_hold_standard_id` FOREIGN KEY (`standard_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`standard`(`standard_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ADD CONSTRAINT `fk_quality_aql_plan_superseded_by_plan_aql_plan_id` FOREIGN KEY (`superseded_by_plan_aql_plan_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`aql_plan`(`aql_plan_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ADD CONSTRAINT `fk_quality_gate_predecessor_gate_id` FOREIGN KEY (`predecessor_gate_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`gate`(`gate_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ADD CONSTRAINT `fk_quality_fit_session_fit_model_id` FOREIGN KEY (`fit_model_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`fit_model`(`fit_model_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ADD CONSTRAINT `fk_quality_fit_session_quality_sample_id` FOREIGN KEY (`quality_sample_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`quality_sample`(`quality_sample_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ADD CONSTRAINT `fk_quality_measurement_spec_gate_id` FOREIGN KEY (`gate_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`gate`(`gate_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ADD CONSTRAINT `fk_quality_measurement_spec_quality_sample_id` FOREIGN KEY (`quality_sample_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`quality_sample`(`quality_sample_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ADD CONSTRAINT `fk_quality_measurement_spec_standard_id` FOREIGN KEY (`standard_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`standard`(`standard_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ADD CONSTRAINT `fk_quality_rtv_disposition_defect_id` FOREIGN KEY (`defect_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`defect`(`defect_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ADD CONSTRAINT `fk_quality_rtv_disposition_gate_id` FOREIGN KEY (`gate_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`gate`(`gate_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ADD CONSTRAINT `fk_quality_rtv_disposition_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ADD CONSTRAINT `fk_quality_rtv_disposition_non_conformance_id` FOREIGN KEY (`non_conformance_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`non_conformance`(`non_conformance_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ADD CONSTRAINT `fk_quality_rtv_disposition_standard_id` FOREIGN KEY (`standard_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`standard`(`standard_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection_finding` ADD CONSTRAINT `fk_quality_inspection_finding_defect_id` FOREIGN KEY (`defect_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`defect`(`defect_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection_finding` ADD CONSTRAINT `fk_quality_inspection_finding_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_model` ADD CONSTRAINT `fk_quality_fit_model_reference_fit_model_id` FOREIGN KEY (`reference_fit_model_id`) REFERENCES `apparel_fashion_ecm`.`quality`.`fit_model`(`fit_model_id`);

-- ========= TAGS =========
ALTER SCHEMA `apparel_fashion_ecm`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `apparel_fashion_ecm`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` SET TAGS ('dbx_subdomain' = 'inspection_management');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `aql_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Aql Plan Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `carbon_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `colorway_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `gate_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Gate Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `order_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Purchase Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `sales_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `sample_request_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `standard_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `supplier_esg_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Esg Assessment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `work_order_operation_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Operation Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `agency` SET TAGS ('dbx_business_glossary_term' = 'Inspection Agency');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `aql_level` SET TAGS ('dbx_business_glossary_term' = 'Acceptable Quality Limit (AQL) Level');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `aql_level` SET TAGS ('dbx_value_regex' = 'critical_0|major_2_5|minor_4_0');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `capa_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `capa_reference_number` SET TAGS ('dbx_value_regex' = '^CAPA-[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `capa_triggered` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Triggered');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `critical_defects_found` SET TAGS ('dbx_business_glossary_term' = 'Critical Defects Found');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'accept|reject|rework|sort|rty|hold');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Time');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_value_regex' = '^INS-[0-9]{8}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|on_hold');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'pre_production|inline|mid_production|final_random|receiving|lab_test');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `inspector_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspector Notes');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `lab_test_required` SET TAGS ('dbx_business_glossary_term' = 'Lab Test Required');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `lab_test_status` SET TAGS ('dbx_business_glossary_term' = 'Lab Test Status');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `lab_test_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|failed');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'Lot Size');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `major_defects_found` SET TAGS ('dbx_business_glossary_term' = 'Major Defects Found');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `minor_defects_found` SET TAGS ('dbx_business_glossary_term' = 'Minor Defects Found');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `pass_fail_outcome` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Outcome');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `pass_fail_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|pending');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `photo_evidence_url` SET TAGS ('dbx_business_glossary_term' = 'Photo Evidence URL');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `photo_evidence_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `report_url` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report URL');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `report_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `sampling_plan` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Inspection Stage');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `stage` SET TAGS ('dbx_value_regex' = 'raw_material|cutting|sewing|finishing|packing|pre_shipment');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Time');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `total_defects_found` SET TAGS ('dbx_business_glossary_term' = 'Total Defects Found');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection` ALTER COLUMN `units_inspected` SET TAGS ('dbx_business_glossary_term' = 'Units Inspected');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` SET TAGS ('dbx_subdomain' = 'inspection_management');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `defect_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Defect ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `affected_area` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Area');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `applicable_product_category` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Category');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `aql_classification` SET TAGS ('dbx_business_glossary_term' = 'Acceptable Quality Limit (AQL) Classification');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `aql_classification` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `corrective_action_guidance` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Guidance');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `cost_impact_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Category');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `cost_impact_category` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `customer_visibility` SET TAGS ('dbx_business_glossary_term' = 'Customer Visibility');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `customer_visibility` SET TAGS ('dbx_value_regex' = 'visible|hidden|conditional');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `defect_category` SET TAGS ('dbx_business_glossary_term' = 'Defect Category');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `defect_category` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `defect_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `defect_name` SET TAGS ('dbx_business_glossary_term' = 'Defect Name');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `frequency_rank` SET TAGS ('dbx_business_glossary_term' = 'Frequency Rank');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `inspection_stage` SET TAGS ('dbx_business_glossary_term' = 'Inspection Stage');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `inspection_stage` SET TAGS ('dbx_value_regex' = 'pre_production|inline|final_random|lab_test|receiving');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `lab_test_method` SET TAGS ('dbx_business_glossary_term' = 'Lab Test Method');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `lab_test_required` SET TAGS ('dbx_business_glossary_term' = 'Lab Test Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `photo_reference_url` SET TAGS ('dbx_business_glossary_term' = 'Photographic Reference URL');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `photo_reference_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `rework_feasibility` SET TAGS ('dbx_business_glossary_term' = 'Rework Feasibility');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `rework_feasibility` SET TAGS ('dbx_value_regex' = 'reworkable|non_reworkable|conditional');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'material|workmanship|design|equipment|process|handling');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `severity_weight` SET TAGS ('dbx_business_glossary_term' = 'Severity Weight');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `supplier_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Supplier Notification Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`defect` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` SET TAGS ('dbx_subdomain' = 'inspection_management');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `non_conformance_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `colorway_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `defect_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Defect Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot/Batch ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `order_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By User ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `related_ncr_non_conformance_id` SET TAGS ('dbx_business_glossary_term' = 'Related Non-Conformance Report (NCR) ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `supplier_esg_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Esg Assessment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `tertiary_non_closed_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Closed By User ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `tertiary_non_closed_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `tertiary_non_closed_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `vendor_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Quote Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `compliance_standard_violated` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard Violated');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `containment_action` SET TAGS ('dbx_business_glossary_term' = 'Containment Action');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `customer_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `detected_at_stage` SET TAGS ('dbx_business_glossary_term' = 'Detected at Stage');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `detected_at_stage` SET TAGS ('dbx_value_regex' = 'pre_production_sample|inline_inspection|final_random_inspection|warehouse_receiving|store_receiving|customer_complaint');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `detection_date` SET TAGS ('dbx_business_glossary_term' = 'Detection Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'accept_as_is|rework|return_to_vendor|scrap|use_as_is_with_concession|sort_and_rework');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `ncr_number` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Number');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `ncr_number` SET TAGS ('dbx_value_regex' = '^NCR-[0-9]{8}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `ncr_status` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Status');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `ncr_status` SET TAGS ('dbx_value_regex' = 'open|under_review|pending_disposition|corrective_action_required|closed|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `non_conformance_category` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Category');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `non_conformance_category` SET TAGS ('dbx_value_regex' = 'material_defect|workmanship_defect|dimensional_variance|color_variance|labeling_error|packaging_defect');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `photo_evidence_url` SET TAGS ('dbx_business_glossary_term' = 'Photo Evidence URL');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `photo_evidence_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `quantity_affected` SET TAGS ('dbx_business_glossary_term' = 'Quantity Affected');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'pieces|cartons|pallets|meters|kilograms');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `responsible_party` SET TAGS ('dbx_value_regex' = 'factory|supplier|internal_design|internal_sourcing|internal_production|third_party_logistics');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `rework_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Rework Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `root_cause_classification` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Classification');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `root_cause_classification` SET TAGS ('dbx_value_regex' = 'material_quality|process_control|equipment_failure|operator_error|design_issue|specification_unclear');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`non_conformance` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` SET TAGS ('dbx_subdomain' = 'inspection_management');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `compliance_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `gate_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Gate Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Initiative Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `non_conformance_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Rfq Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `standard_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Number');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `action_number` SET TAGS ('dbx_value_regex' = '^CAPA-[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|both');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `affected_product_category` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Category');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `affected_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Stock Keeping Unit (SKU) Count');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `closed_by` SET TAGS ('dbx_business_glossary_term' = 'Closed By User');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `containment_action` SET TAGS ('dbx_business_glossary_term' = 'Containment Action');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_verification|verified|closed|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `cost_of_quality_impact` SET TAGS ('dbx_business_glossary_term' = 'Cost of Quality (COQ) Impact');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `cost_of_quality_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `disposition_action` SET TAGS ('dbx_business_glossary_term' = 'Disposition Action');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `disposition_action` SET TAGS ('dbx_value_regex' = 'rework|scrap|return_to_vendor|use_as_is|downgrade');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|manager|director|executive|regulatory');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Action Priority');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `quality_gate_stage` SET TAGS ('dbx_business_glossary_term' = 'Quality Gate Stage');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `quality_gate_stage` SET TAGS ('dbx_value_regex' = 'pre_production|inline|final_random|shipment');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `recurrence_count` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Count');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Type');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_value_regex' = 'factory_qc_manager|supplier|internal_quality_team|production_manager|sourcing_team|third_party_lab');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `root_cause_analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Method');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `root_cause_analysis_method` SET TAGS ('dbx_value_regex' = '5_why|fishbone|fault_tree|pareto|other');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `supplier_performance_impact` SET TAGS ('dbx_business_glossary_term' = 'Supplier Performance Impact');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `supplier_performance_impact` SET TAGS ('dbx_value_regex' = 'no_impact|warning|probation|suspension|termination');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'on_site_audit|document_review|sample_inspection|lab_test|process_audit|supplier_self_assessment');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `verification_notes` SET TAGS ('dbx_business_glossary_term' = 'Verification Notes');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `verification_outcome` SET TAGS ('dbx_business_glossary_term' = 'Verification Outcome');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `verification_outcome` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective|pending');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`corrective_action` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` SET TAGS ('dbx_subdomain' = 'product_evaluation');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `quality_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Sample ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `cad_file_id` SET TAGS ('dbx_business_glossary_term' = 'Cad File Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `colorway_development_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway Development Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `colorway_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `material_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `order_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Purchase Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `print_design_id` SET TAGS ('dbx_business_glossary_term' = 'Print Design Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `sample_request_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `seasonal_launch_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Launch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `standard_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `sustainable_material_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `actual_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Receipt Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `approval_authority` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `bom_version` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Version');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `bom_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.]{1,10}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `color_comments` SET TAGS ('dbx_business_glossary_term' = 'Color Comments');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `construction_comments` SET TAGS ('dbx_business_glossary_term' = 'Construction Comments');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Sample Disposition');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'retain|archive|destroy|rtv');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `evaluation_decision` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Decision');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `evaluation_decision` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Type');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_value_regex' = 'fit_session|aesthetic_review|pp_approval|top_approval|lab_test|compliance_check');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `expected_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Receipt Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `fabric_hand_comments` SET TAGS ('dbx_business_glossary_term' = 'Fabric Hand Comments');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `fit_comments` SET TAGS ('dbx_business_glossary_term' = 'Fit Comments');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `general_comments` SET TAGS ('dbx_business_glossary_term' = 'General Comments');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Path');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `lab_test_required` SET TAGS ('dbx_business_glossary_term' = 'Lab Test Required');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `lab_test_status` SET TAGS ('dbx_business_glossary_term' = 'Lab Test Status');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `lab_test_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|passed|failed');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `labeling_comments` SET TAGS ('dbx_business_glossary_term' = 'Labeling Comments');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Sample Location');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `requested_by` SET TAGS ('dbx_business_glossary_term' = 'Requested By');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `requested_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `required_amendments` SET TAGS ('dbx_business_glossary_term' = 'Required Amendments');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `sample_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Number');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `sample_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `sample_status` SET TAGS ('dbx_business_glossary_term' = 'Sample Status');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'proto|salesman|fit|pp|top|shipment');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `size_code` SET TAGS ('dbx_business_glossary_term' = 'Size Code');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `size_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `tech_pack_version` SET TAGS ('dbx_business_glossary_term' = 'Tech Pack Version');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `tech_pack_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.]{1,10}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_sample` ALTER COLUMN `trim_comments` SET TAGS ('dbx_business_glossary_term' = 'Trim Comments');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` SET TAGS ('dbx_subdomain' = 'product_evaluation');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `lab_test_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `chemical_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Compliance Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `colorway_development_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway Development Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `fabric_development_id` SET TAGS ('dbx_business_glossary_term' = 'Fabric Development Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `material_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `order_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Purchase Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By User ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `print_design_id` SET TAGS ('dbx_business_glossary_term' = 'Print Design Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `product_safety_test_id` SET TAGS ('dbx_business_glossary_term' = 'Product Safety Test Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `quality_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Sample Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `retest_of_test_id` SET TAGS ('dbx_business_glossary_term' = 'Retest Of Test ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `sample_request_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `sourcing_material_sourcing_id` SET TAGS ('dbx_business_glossary_term' = 'Material Sourcing Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `standard_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `sustainable_material_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `lab_accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Accreditation Number');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `lab_location` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Location');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `lab_name` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Name');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `market_destination` SET TAGS ('dbx_business_glossary_term' = 'Market Destination');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `overall_result` SET TAGS ('dbx_business_glossary_term' = 'Overall Test Result');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `overall_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|pending|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `sample_received_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Received Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `test_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Test Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `test_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Test Cost Amount');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `test_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Test Cost Currency');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `test_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `test_notes` SET TAGS ('dbx_business_glossary_term' = 'Test Notes');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `test_priority` SET TAGS ('dbx_business_glossary_term' = 'Test Priority');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `test_priority` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `test_purpose` SET TAGS ('dbx_business_glossary_term' = 'Test Purpose');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `test_purpose` SET TAGS ('dbx_value_regex' = 'pre_production|bulk_production|random_inspection|complaint_investigation|regulatory_compliance|supplier_qualification');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `test_report_number` SET TAGS ('dbx_business_glossary_term' = 'Test Report Number');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `test_report_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `test_report_url` SET TAGS ('dbx_business_glossary_term' = 'Test Report URL');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `test_request_date` SET TAGS ('dbx_business_glossary_term' = 'Test Request Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `test_request_number` SET TAGS ('dbx_business_glossary_term' = 'Test Request Number');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `test_request_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `test_start_date` SET TAGS ('dbx_business_glossary_term' = 'Test Start Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'requested|in_progress|completed|on_hold|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`lab_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` SET TAGS ('dbx_subdomain' = 'compliance_certification');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `quality_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Audit ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Agreement Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `quality_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `standard_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `supplier_esg_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Esg Assessment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|report_pending|closed|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'social_compliance|quality_management_system|environmental|product_safety|process_audit|supplier_qualification');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `auditing_body` SET TAGS ('dbx_business_glossary_term' = 'Auditing Body');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `auditor_certification` SET TAGS ('dbx_business_glossary_term' = 'Auditor Certification');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `certification_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Due Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Status');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Audit Duration in Days');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit End Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `follow_up_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `follow_up_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency in Months');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `grade` SET TAGS ('dbx_business_glossary_term' = 'Audit Grade or Rating');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `next_audit_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Scheduled Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `observation_count` SET TAGS ('dbx_business_glossary_term' = 'Observation Count');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `report_document_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Document URL');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `report_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `report_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Issued Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `supplier_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `supplier_approval_status` SET TAGS ('dbx_value_regex' = 'approved|conditional_approval|suspended|rejected|under_review');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_audit` ALTER COLUMN `total_score` SET TAGS ('dbx_business_glossary_term' = 'Total Audit Score');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` SET TAGS ('dbx_subdomain' = 'compliance_certification');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `standard_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `ecolabel_id` SET TAGS ('dbx_business_glossary_term' = 'Ecolabel Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `labeling_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Labeling Requirement Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `superseded_by_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Quality Standard ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `applicable_channels` SET TAGS ('dbx_business_glossary_term' = 'Applicable Sales Channels');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `applicable_markets` SET TAGS ('dbx_business_glossary_term' = 'Applicable Markets');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `applicable_product_categories` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Categories');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `aql_level` SET TAGS ('dbx_business_glossary_term' = 'Acceptable Quality Limit (AQL) Level');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `aql_level` SET TAGS ('dbx_value_regex' = '^(AQLs)?[0-9]+(.[0-9]+)?$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Quality Audit Scope');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `corrective_action_threshold` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Threshold');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `cost_impact` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `cost_impact` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `documentation_requirements` SET TAGS ('dbx_business_glossary_term' = 'Documentation Requirements');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `inspection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `internal_owner` SET TAGS ('dbx_business_glossary_term' = 'Internal Owner');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `mandatory_lab_tests` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Lab Tests');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Notes');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `pp_sample_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Pre-Production (PP) Sample Approval Required');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `quality_gate_stage` SET TAGS ('dbx_business_glossary_term' = 'Quality Gate Stage');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `reference_document_url` SET TAGS ('dbx_business_glossary_term' = 'Reference Document URL');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `reference_document_url` SET TAGS ('dbx_value_regex' = '^(https?://)?[a-zA-Z0-9.-]+.[a-zA-Z]{2,}(/.*)?$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `rtv_disposition_rule` SET TAGS ('dbx_business_glossary_term' = 'Return to Vendor (RTV) Disposition Rule');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `rtv_disposition_rule` SET TAGS ('dbx_value_regex' = 'automatic_rtv|conditional_rtv|no_rtv|case_by_case');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `sms_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Sample Management System (SMS) Integration Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `standard_category` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Category');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `standard_code` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Code');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `standard_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `standard_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Name');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `standard_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Status');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `standard_status` SET TAGS ('dbx_value_regex' = 'active|superseded|retired|draft|pending_approval');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `standard_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Type');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `standard_type` SET TAGS ('dbx_value_regex' = 'certification|testing_protocol|regulatory_requirement|internal_policy|industry_guideline|safety_standard');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `supplier_qualification_required` SET TAGS ('dbx_business_glossary_term' = 'Supplier Qualification Required');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `training_requirements` SET TAGS ('dbx_business_glossary_term' = 'Training Requirements');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Standard Version');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`standard` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}(.[0-9]{1,3}){0,2}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` SET TAGS ('dbx_subdomain' = 'compliance_certification');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `quality_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Agreement Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `material_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `sourcing_material_sourcing_id` SET TAGS ('dbx_business_glossary_term' = 'Material Sourcing Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `standard_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency in Months');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `certificate_document_url` SET TAGS ('dbx_business_glossary_term' = 'Certificate Document Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `certificate_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `certification_scope` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|pending_renewal|revoked|under_review');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `certified_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Certified Entity Name');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `certified_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Certified Entity Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `certified_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Certified Entity Type');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `certified_entity_type` SET TAGS ('dbx_value_regex' = 'factory|supplier|material|product|facility|process');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `compliance_gate` SET TAGS ('dbx_business_glossary_term' = 'Compliance Gate');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `compliance_officer` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Certification Cost');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `issuing_body_contact` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body Contact');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `issuing_body_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `issuing_body_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `non_conformance_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Count');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|overdue');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` SET TAGS ('dbx_subdomain' = 'inspection_management');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `quality_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `backorder_id` SET TAGS ('dbx_business_glossary_term' = 'Backorder Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `defect_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Defect Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `non_conformance_id` SET TAGS ('dbx_business_glossary_term' = 'Non Conformance Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `fulfillment_id` SET TAGS ('dbx_business_glossary_term' = 'Order Fulfillment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `rtv_order_id` SET TAGS ('dbx_business_glossary_term' = 'Rtv Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `standard_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'released|rework|scrap|rtv|use_as_is|downgrade');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Hold Duration Days');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `factory_name` SET TAGS ('dbx_business_glossary_term' = 'Factory Name');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'inspection_failure|lab_test_failure|ncr|pp_approval_pending|compliance_failure|customer_complaint');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Initiation Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `lab_test_report_number` SET TAGS ('dbx_business_glossary_term' = 'Lab Test Report Number');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `lab_test_report_number` SET TAGS ('dbx_value_regex' = '^LAB-[0-9]{8}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Location Code');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Location Type');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'factory|distribution_center|warehouse|third_party_logistics|in_transit|retail_store');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `quantity_on_hold` SET TAGS ('dbx_business_glossary_term' = 'Quantity on Hold');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Description');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Hold Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^QH-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `reinspection_date` SET TAGS ('dbx_business_glossary_term' = 'Reinspection Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `reinspection_required` SET TAGS ('dbx_business_glossary_term' = 'Reinspection Required');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `reinspection_result` SET TAGS ('dbx_business_glossary_term' = 'Reinspection Result');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `reinspection_result` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional_pass');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `release_conditions` SET TAGS ('dbx_business_glossary_term' = 'Release Conditions');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `rework_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Rework Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `supplier_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Code');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `supplier_code` SET TAGS ('dbx_value_regex' = '^SUP-[0-9]{6}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'units|yards|meters|pieces|kilograms|pounds');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`quality_hold` ALTER COLUMN `wms_block_flag` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Block Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` SET TAGS ('dbx_subdomain' = 'inspection_management');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `aql_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Acceptable Quality Level (AQL) Plan ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `superseded_by_plan_aql_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By AQL Plan ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `accept_number_critical` SET TAGS ('dbx_business_glossary_term' = 'Accept Number Critical Defects');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `accept_number_major` SET TAGS ('dbx_business_glossary_term' = 'Accept Number Major Defects');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `accept_number_minor` SET TAGS ('dbx_business_glossary_term' = 'Accept Number Minor Defects');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `applicable_product_category` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Category');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `applicable_supplier_tier` SET TAGS ('dbx_business_glossary_term' = 'Applicable Supplier Tier');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `applicable_supplier_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|all_tiers');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `aql_critical` SET TAGS ('dbx_business_glossary_term' = 'Acceptable Quality Level (AQL) Critical Defects');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `aql_major` SET TAGS ('dbx_business_glossary_term' = 'Acceptable Quality Level (AQL) Major Defects');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `aql_minor` SET TAGS ('dbx_business_glossary_term' = 'Acceptable Quality Level (AQL) Minor Defects');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `aql_plan_status` SET TAGS ('dbx_business_glossary_term' = 'AQL Plan Status');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `aql_plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|superseded|under_review');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `inspection_level` SET TAGS ('dbx_business_glossary_term' = 'Inspection Level');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `inspection_standard` SET TAGS ('dbx_business_glossary_term' = 'Inspection Standard');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `inspection_standard` SET TAGS ('dbx_value_regex' = 'ANSI_ASQ_Z1_4|ISO_2859_1|MIL_STD_105E|custom');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `lot_size_max` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Maximum');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `lot_size_min` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Minimum');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'AQL Plan Notes');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'AQL Plan Code');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'AQL Plan Name');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'AQL Plan Type');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'standard|custom|supplier_specific|category_specific|risk_based|regulatory');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `quality_gate_stage` SET TAGS ('dbx_business_glossary_term' = 'Quality Gate Stage');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `reject_number_critical` SET TAGS ('dbx_business_glossary_term' = 'Reject Number Critical Defects');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `reject_number_major` SET TAGS ('dbx_business_glossary_term' = 'Reject Number Major Defects');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `reject_number_minor` SET TAGS ('dbx_business_glossary_term' = 'Reject Number Minor Defects');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `sample_size_code_letter` SET TAGS ('dbx_business_glossary_term' = 'Sample Size Code Letter');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `sampling_plan_type` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Type');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `sampling_plan_type` SET TAGS ('dbx_value_regex' = 'single|double|multiple');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `switching_rule` SET TAGS ('dbx_business_glossary_term' = 'Switching Rule');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `switching_rule` SET TAGS ('dbx_value_regex' = 'normal|tightened|reduced');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`aql_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` SET TAGS ('dbx_subdomain' = 'compliance_certification');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `gate_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Gate ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `predecessor_gate_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Quality Gate ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `applicable_order_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Order Type');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `applicable_order_type` SET TAGS ('dbx_value_regex' = 'production|sample|bulk|all');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `applicable_product_category` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Category');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `applicable_supplier_tier` SET TAGS ('dbx_business_glossary_term' = 'Applicable Supplier Tier');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `applicable_supplier_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|all_tiers');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `aql_level` SET TAGS ('dbx_business_glossary_term' = 'Acceptable Quality Limit (AQL) Level');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `aql_level` SET TAGS ('dbx_value_regex' = '^(0.065|0.10|0.15|0.25|0.40|0.65|1.0|1.5|2.5|4.0|6.5|10.0)$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `auto_escalation_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Escalation Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `bypass_authority_role` SET TAGS ('dbx_business_glossary_term' = 'Bypass Authority Role');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `bypass_requires_justification` SET TAGS ('dbx_business_glossary_term' = 'Bypass Requires Justification Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `enforcement_level` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Level');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `enforcement_level` SET TAGS ('dbx_value_regex' = 'blocking|advisory|warning');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `escalation_recipient_email` SET TAGS ('dbx_business_glossary_term' = 'Escalation Recipient Email Address');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `escalation_recipient_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `escalation_recipient_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `escalation_threshold_hours` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold Hours');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `gate_category` SET TAGS ('dbx_business_glossary_term' = 'Quality Gate Category');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `gate_category` SET TAGS ('dbx_value_regex' = 'material|sample|production|inspection|compliance|shipment');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `gate_code` SET TAGS ('dbx_business_glossary_term' = 'Quality Gate Code');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `gate_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `gate_description` SET TAGS ('dbx_business_glossary_term' = 'Quality Gate Description');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `gate_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Gate Name');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `gate_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Gate Status');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `gate_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|deprecated');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `inspection_level` SET TAGS ('dbx_business_glossary_term' = 'Inspection Level');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Stage');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `notification_enabled` SET TAGS ('dbx_business_glossary_term' = 'Notification Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `notification_recipient_list` SET TAGS ('dbx_business_glossary_term' = 'Notification Recipient List');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `notification_recipient_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `pass_criteria` SET TAGS ('dbx_business_glossary_term' = 'Pass Criteria');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `required_documentation` SET TAGS ('dbx_business_glossary_term' = 'Required Documentation');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `responsible_role` SET TAGS ('dbx_business_glossary_term' = 'Responsible Role');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `responsible_team` SET TAGS ('dbx_business_glossary_term' = 'Responsible Team');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Quality Gate Sequence Number');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `sla_days_before_exfactory` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Days Before Ex-Factory Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `test_method_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Method Reference');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`gate` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` SET TAGS ('dbx_subdomain' = 'product_evaluation');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `fit_session_id` SET TAGS ('dbx_business_glossary_term' = 'Fit Session ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `fit_model_id` SET TAGS ('dbx_business_glossary_term' = 'Fit Model ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `quality_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Sample Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `sample_request_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fit Approval Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `armhole_fit_comment` SET TAGS ('dbx_business_glossary_term' = 'Armhole Fit Comment');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `chest_bust_fit_comment` SET TAGS ('dbx_business_glossary_term' = 'Chest or Bust Fit Comment');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `construction_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Construction Issue Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `construction_issue_notes` SET TAGS ('dbx_business_glossary_term' = 'Construction Issue Notes');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `fabric_performance_comment` SET TAGS ('dbx_business_glossary_term' = 'Fabric Performance Comment');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `fit_evaluator_team` SET TAGS ('dbx_business_glossary_term' = 'Fit Evaluator Team');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `fit_model_measurements` SET TAGS ('dbx_business_glossary_term' = 'Fit Model Measurements');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `fit_stage` SET TAGS ('dbx_business_glossary_term' = 'Fit Stage');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `grading_notes` SET TAGS ('dbx_business_glossary_term' = 'Grading Notes');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `hip_fit_comment` SET TAGS ('dbx_business_glossary_term' = 'Hip Fit Comment');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `inseam_fit_comment` SET TAGS ('dbx_business_glossary_term' = 'Inseam Fit Comment');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `length_fit_comment` SET TAGS ('dbx_business_glossary_term' = 'Length Fit Comment');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `measurement_variance_flag` SET TAGS ('dbx_business_glossary_term' = 'Measurement Variance Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `neckline_fit_comment` SET TAGS ('dbx_business_glossary_term' = 'Neckline Fit Comment');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `next_fit_session_required` SET TAGS ('dbx_business_glossary_term' = 'Next Fit Session Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `overall_fit_comment` SET TAGS ('dbx_business_glossary_term' = 'Overall Fit Comment');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `overall_fit_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Fit Status');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `overall_fit_status` SET TAGS ('dbx_value_regex' = 'approved|approved_with_minor_changes|rejected|on_hold');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `pattern_amendment_notes` SET TAGS ('dbx_business_glossary_term' = 'Pattern Amendment Notes');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `pattern_amendment_required` SET TAGS ('dbx_business_glossary_term' = 'Pattern Amendment Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `photo_reference` SET TAGS ('dbx_business_glossary_term' = 'Photo Reference');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'proto|sms|pp_sample|production_sample|size_set|photo_sample');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `session_date` SET TAGS ('dbx_business_glossary_term' = 'Fit Session Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `session_number` SET TAGS ('dbx_business_glossary_term' = 'Fit Session Number');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `shoulder_fit_comment` SET TAGS ('dbx_business_glossary_term' = 'Shoulder Fit Comment');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `size_evaluated` SET TAGS ('dbx_business_glossary_term' = 'Size Evaluated');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `sleeve_fit_comment` SET TAGS ('dbx_business_glossary_term' = 'Sleeve Fit Comment');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `target_next_fit_date` SET TAGS ('dbx_business_glossary_term' = 'Target Next Fit Session Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `tech_pack_version` SET TAGS ('dbx_business_glossary_term' = 'Tech Pack Version');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `waist_fit_comment` SET TAGS ('dbx_business_glossary_term' = 'Waist Fit Comment');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_session` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` SET TAGS ('dbx_subdomain' = 'product_evaluation');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `measurement_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Specification ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `gate_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Gate Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `quality_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Sample Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `sample_request_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `standard_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `actual_measurement` SET TAGS ('dbx_business_glossary_term' = 'Actual Measurement');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `base_size` SET TAGS ('dbx_business_glossary_term' = 'Base Size');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `base_size_measurement` SET TAGS ('dbx_business_glossary_term' = 'Base Size Measurement');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `fit_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Fit Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `fit_approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|conditional|pending');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `fit_comments` SET TAGS ('dbx_business_glossary_term' = 'Fit Comments');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `garment_type` SET TAGS ('dbx_business_glossary_term' = 'Garment Type');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `grade_rule` SET TAGS ('dbx_business_glossary_term' = 'Grade Rule');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `inspection_location` SET TAGS ('dbx_business_glossary_term' = 'Inspection Location');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `inspector_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `measurement_point_code` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Code');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `measurement_point_name` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Name');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `measurement_stage` SET TAGS ('dbx_business_glossary_term' = 'Measurement Stage');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `measurement_stage` SET TAGS ('dbx_value_regex' = 'fit_session|pp_sample|pre_production|inline_inspection|final_inspection');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `measurement_variance` SET TAGS ('dbx_business_glossary_term' = 'Measurement Variance');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|not_measured');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `pattern_correction_notes` SET TAGS ('dbx_business_glossary_term' = 'Pattern Correction Notes');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `quality_gate_stage` SET TAGS ('dbx_business_glossary_term' = 'Quality Gate Stage');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'proto|fit|pp|sms|production|golden');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `size_range` SET TAGS ('dbx_business_glossary_term' = 'Size Range');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `spec_number` SET TAGS ('dbx_business_glossary_term' = 'Specification Number');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `spec_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `spec_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|superseded|archived');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `spec_version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `tolerance_minus` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Minus');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `tolerance_plus` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Plus');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`measurement_spec` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'cm|inch|mm');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` SET TAGS ('dbx_subdomain' = 'compliance_certification');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `rtv_disposition_id` SET TAGS ('dbx_business_glossary_term' = 'Return-to-Vendor (RTV) Disposition ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `cogs_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cogs Entry Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `defect_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Defect Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `gate_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Gate Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `non_conformance_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `order_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Purchase Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `rtv_order_id` SET TAGS ('dbx_business_glossary_term' = 'Rtv Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `standard_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `waste_record_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Record Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `actual_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Receipt Date by Vendor');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Return-to-Vendor (RTV) Closure Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Return-to-Vendor (RTV) Closure Notes');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `credit_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Issued Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Return-to-Vendor (RTV) Disposition Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `disposition_instructions` SET TAGS ('dbx_business_glossary_term' = 'Disposition Instructions');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `disposition_status` SET TAGS ('dbx_business_glossary_term' = 'Return-to-Vendor (RTV) Disposition Status');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `expected_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Receipt Date by Vendor');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `logistics_carrier` SET TAGS ('dbx_business_glossary_term' = 'Logistics Carrier');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `quality_gate_stage` SET TAGS ('dbx_business_glossary_term' = 'Quality Gate Stage');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `quality_gate_stage` SET TAGS ('dbx_value_regex' = 'pre_production|inline|final_random|pre_shipment|receiving');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `replacement_po_number` SET TAGS ('dbx_business_glossary_term' = 'Replacement Purchase Order (PO) Number');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `replacement_po_number` SET TAGS ('dbx_value_regex' = '^PO-[A-Z0-9]{8,15}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `return_quantity` SET TAGS ('dbx_business_glossary_term' = 'Return Quantity');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `return_shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Return Shipment Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `return_shipment_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Return Shipment Tracking Number');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `rtv_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Return-to-Vendor (RTV) Authorization Number');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `rtv_authorization_number` SET TAGS ('dbx_value_regex' = '^RTV-[A-Z0-9]{8,12}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `rtv_type` SET TAGS ('dbx_business_glossary_term' = 'Return-to-Vendor (RTV) Type');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `rtv_type` SET TAGS ('dbx_value_regex' = 'full_return|credit_only|replacement|repair|scrap');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `supplier_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Acknowledgment Date');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `supplier_acknowledgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Supplier Acknowledgment Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|PCS|PAIR|SET|BOX|CARTON');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `vendor_debit_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Debit Memo Number');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `vendor_debit_memo_number` SET TAGS ('dbx_value_regex' = '^VDM-[A-Z0-9]{8,12}$');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `warehouse_location` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`rtv_disposition` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection_finding` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection_finding` SET TAGS ('dbx_subdomain' = 'inspection_management');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection_finding` SET TAGS ('dbx_association_edges' = 'quality.inspection,quality.quality_defect');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection_finding` ALTER COLUMN `inspection_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Finding Identifier');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection_finding` ALTER COLUMN `defect_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Finding - Quality Defect Id');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection_finding` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Finding - Inspection Id');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection_finding` ALTER COLUMN `affected_unit_reference` SET TAGS ('dbx_business_glossary_term' = 'Affected Unit Reference');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection_finding` ALTER COLUMN `capa_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'CAPA Trigger Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection_finding` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection_finding` ALTER COLUMN `defect_location_on_product` SET TAGS ('dbx_business_glossary_term' = 'Defect Location');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection_finding` ALTER COLUMN `finding_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Finding Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection_finding` ALTER COLUMN `hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Flag');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection_finding` ALTER COLUMN `inspector_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspector Notes');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection_finding` ALTER COLUMN `photo_evidence_url` SET TAGS ('dbx_business_glossary_term' = 'Photo Evidence URL');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection_finding` ALTER COLUMN `recorded_by_user` SET TAGS ('dbx_business_glossary_term' = 'Recorded By User');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`inspection_finding` ALTER COLUMN `severity_classification` SET TAGS ('dbx_business_glossary_term' = 'Severity Classification');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_model` SET TAGS ('dbx_subdomain' = 'product_evaluation');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_model` ALTER COLUMN `fit_model_id` SET TAGS ('dbx_business_glossary_term' = 'Fit Model Identifier');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_model` ALTER COLUMN `reference_fit_model_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_model` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_model` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_model` ALTER COLUMN `hourly_rate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_model` ALTER COLUMN `model_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_model` ALTER COLUMN `model_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_model` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`quality`.`fit_model` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
