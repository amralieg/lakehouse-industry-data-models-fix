-- Schema for Domain: procurement | Business: Pharmaceuticals | Version: v1_ecm
-- Generated on: 2026-05-05 17:50:36

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `pharmaceuticals_ecm`.`procurement` COMMENT 'Manages strategic sourcing and procurement of raw materials (APIs, excipients), packaging materials, laboratory supplies, and services. Covers supplier qualification, vendor master data, purchase orders, contracts, supplier performance, and GMP vendor audits. Coordinates with CRO, CMO, and CDMO partners. Integrates with SAP MM and Ariba. Ensures compliance with supplier quality agreements and GDP requirements.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor record. Primary key for the vendor master data product.',
    `business_partner_id` BIGINT COMMENT 'Foreign key linking to masterdata.business_partner. Business justification: Vendors are business partners in MDM for master data governance, data quality scoring, and cross-system synchronization. Business partner master provides golden record and system crosswalk for pharmac',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Vendor headquarters country determines tax jurisdiction, regulatory authority oversight, trade compliance requirements, and FCPA risk classification for pharmaceutical procurement due diligence and ve',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Vendors are legal entities requiring registration, tax ID, and incorporation data for compliance due diligence, tax reporting, and contract execution. Pharmaceutical procurement tracks vendor legal st',
    `annual_spend_amount` DECIMAL(18,2) COMMENT 'Total procurement spend with this vendor in the current fiscal year, in the organizations reporting currency. Used for vendor segmentation and strategic sourcing decisions.',
    `audit_outcome` STRING COMMENT 'Result of the most recent vendor audit. Approved: no critical findings. Approved with Observations: minor findings requiring follow-up. Conditional Approval: major findings requiring CAPA (Corrective and Preventive Action) before full approval. Not Approved: critical findings, vendor disqualified.. Valid values are `approved|approved_with_observations|conditional_approval|not_approved`',
    `classification` STRING COMMENT 'Primary business classification of the vendor based on the goods or services provided. API (Active Pharmaceutical Ingredient) supplier, excipient supplier, packaging material supplier, laboratory equipment supplier, service provider, CRO (Contract Research Organization), CMO (Contract Manufacturing Organization), or CDMO (Contract Development and Manufacturing Organization). [ENUM-REF-CANDIDATE: api_supplier|excipient_supplier|packaging_supplier|equipment_supplier|service_provider|cro|cmo|cdmo — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor record was first created in the system.',
    `deactivation_date` DATE COMMENT 'Date when the vendor was deactivated or blocked from procurement activities. Null if vendor is currently active.',
    `deactivation_reason` STRING COMMENT 'Business reason for vendor deactivation or blocking (e.g., quality issues, regulatory non-compliance, business closure, contract termination, poor performance).',
    `duns_number` STRING COMMENT 'Nine-digit DUNS number assigned by Dun & Bradstreet for global vendor identification and credit assessment.. Valid values are `^[0-9]{9}$`',
    `gdp_certified_flag` BOOLEAN COMMENT 'Indicates whether the vendor holds current GDP (Good Distribution Practice) certification, required for distributors and logistics service providers handling pharmaceutical products.',
    `headquarters_address_line1` STRING COMMENT 'First line of the vendors headquarters street address.',
    `headquarters_city` STRING COMMENT 'City where the vendors headquarters is located.',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code for the vendors headquarters address.',
    `headquarters_state_province` STRING COMMENT 'State, province, or administrative region where the vendors headquarters is located.',
    `incoterms_code` STRING COMMENT 'Standard Incoterms code defining the responsibilities, costs, and risks between buyer and seller for international shipments (e.g., EXW, FOB, CIF, DDP). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_audit_date` DATE COMMENT 'Date of the most recent on-site or remote audit conducted by the organizations quality assurance team. GMP vendors require periodic audits per regulatory requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor record was last updated in the system.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next vendor audit. Audit frequency is risk-based, typically annual for critical suppliers (API, CMO/CDMO) and biennial for lower-risk suppliers.',
    `payment_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for vendor payments (e.g., USD, EUR, GBP, JPY, CNY).. Valid values are `^[A-Z]{3}$`',
    `payment_terms_code` STRING COMMENT 'Standard payment terms agreed with the vendor. Common terms include Net 30 (payment due in 30 days), Net 60, Net 90, Due on Receipt, or discount terms like 2/10 Net 30 (2% discount if paid within 10 days, otherwise net 30).. Valid values are `net_30|net_60|net_90|due_on_receipt|2_10_net_30`',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether the vendor has been designated as a preferred supplier based on quality performance, pricing, delivery reliability, and strategic partnership criteria.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact at the vendor organization.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the vendor organization for procurement and operational matters.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary business contact at the vendor organization.',
    `qualification_date` DATE COMMENT 'Date when the vendor successfully completed the qualification process and was approved for procurement activities.',
    `quality_agreement_effective_date` DATE COMMENT 'Date when the current Quality Agreement with the vendor became effective.',
    `quality_agreement_expiry_date` DATE COMMENT 'Date when the current Quality Agreement expires and requires renewal or renegotiation.',
    `quality_agreement_flag` BOOLEAN COMMENT 'Indicates whether a formal Quality Agreement or Supplier Quality Agreement (SQA) is in place with the vendor. Required for GMP-critical suppliers per ICH Q10.',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk score (0-100) calculated based on quality performance, delivery reliability, financial stability, regulatory compliance, and geopolitical factors. Higher scores indicate higher risk.',
    `vendor_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the vendor in SAP MM module. Used for procurement transactions and purchase orders.. Valid values are `^[A-Z0-9]{6,12}$`',
    `vendor_name` STRING COMMENT 'Full legal name of the vendor organization as registered with regulatory authorities. Used for contracts, purchase orders, and regulatory submissions.',
    `vendor_status` STRING COMMENT 'Current lifecycle status of the vendor. Active: approved for procurement. Inactive: not currently used but qualified. Suspended: temporarily blocked pending investigation. Pending Qualification: undergoing qualification process. Disqualified: failed qualification. Blocked: permanently blocked from procurement.. Valid values are `active|inactive|suspended|pending_qualification|disqualified|blocked`',
    `vendor_tier` STRING COMMENT 'Strategic tier classification of the vendor. Tier 1: critical strategic partners with high spend and risk. Tier 2: important suppliers with moderate spend. Tier 3: transactional suppliers with low spend and risk.. Valid values are `tier_1|tier_2|tier_3`',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master record for all external suppliers, vendors, CROs, CMOs, and CDMOs engaged by the organization. Captures vendor identity, classification (API supplier, excipient supplier, packaging supplier, service provider, CRO, CMO, CDMO), tax identifiers, business registration details, GMP certification status, preferred vendor flag, vendor tier, payment terms, currency, incoterms, lifecycle status, and associated manufacturing/warehouse/laboratory sites with their GMP/GDP certification scope and regulatory registration numbers. SSOT for vendor identity and site topology within the procurement domain.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` (
    `vendor_site_id` BIGINT COMMENT 'Unique identifier for the vendor site. Primary key.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Vendor site country drives GMP inspection authority, ICH region classification, import/export licensing, and controlled substance regulations. Essential for pharmaceutical supply chain compliance and ',
    `address_id` BIGINT COMMENT 'Foreign key linking to masterdata.address. Business justification: Vendor sites require standardized address master for geocoding, regulatory site identification (FDA Establishment ID), and GMP audit logistics. Address validation ensures accurate shipping and regulat',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Vendor manufacturing sites map to plant master for capacity planning, GMP certification tracking, and regulatory inspection coordination. Critical for CMO/API supplier qualification and technology tra',
    `vendor_id` BIGINT COMMENT 'Reference to the parent vendor organization that owns or operates this site.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the vendor site record was first created in the system.',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier for the vendor site assigned by Dun & Bradstreet for business identification.. Valid values are `^[0-9]{9}$`',
    `ema_site_number` STRING COMMENT 'Unique site identifier assigned by the European Medicines Agency for regulatory tracking and inspection purposes.',
    `email_address` STRING COMMENT 'Primary email address for official communication with the vendor site.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for the vendor site for document transmission.',
    `fda_establishment_number` STRING COMMENT 'Unique FDA establishment identifier assigned to the vendor site for regulatory registration and inspection tracking.. Valid values are `^[0-9]{7,10}$`',
    `gdp_certified` BOOLEAN COMMENT 'Indicates whether the vendor site holds current Good Distribution Practice certification for pharmaceutical distribution.',
    `gmp_certified` BOOLEAN COMMENT 'Indicates whether the vendor site holds current Good Manufacturing Practice certification.',
    `iso_certification_standard` STRING COMMENT 'Specific ISO standard(s) for which the site is certified, such as ISO 9001, ISO 13485, or ISO 14001.',
    `iso_certified` BOOLEAN COMMENT 'Indicates whether the vendor site holds ISO quality management system certification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the vendor site record was last updated or modified.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the vendor site.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the vendor site for procurement and quality matters.',
    `primary_contact_title` STRING COMMENT 'Job title or role of the primary contact person at the vendor site.',
    `qualification_date` DATE COMMENT 'Date when the vendor site was officially qualified for supplying materials or services.',
    `qualification_expiry_date` DATE COMMENT 'Date when the current qualification status expires and requires renewal or re-qualification.',
    `qualification_status` STRING COMMENT 'Current qualification status of the vendor site for supplying materials or services to pharmaceutical operations.. Valid values are `qualified|not_qualified|under_review|conditional|expired`',
    `risk_rating` STRING COMMENT 'Overall risk assessment rating assigned to the vendor site based on quality, compliance, and supply chain factors.. Valid values are `low|medium|high|critical`',
    `site_capacity` STRING COMMENT 'Description of the production, storage, or service delivery capacity of the vendor site, including units and volume.',
    `site_code` STRING COMMENT 'Unique alphanumeric code assigned to the vendor site for identification in procurement and supply chain systems.. Valid values are `^[A-Z0-9]{4,20}$`',
    `site_name` STRING COMMENT 'Official business name of the vendor site or facility.',
    `site_status` STRING COMMENT 'Current operational and qualification status of the vendor site in the procurement system.. Valid values are `active|inactive|suspended|pending_qualification|disqualified`',
    `site_type` STRING COMMENT 'Classification of the vendor site based on its primary operational function.. Valid values are `manufacturing|distribution|warehouse|laboratory|office|research`',
    CONSTRAINT pk_vendor_site PRIMARY KEY(`vendor_site_id`)
) COMMENT 'Physical manufacturing, warehouse, or service delivery sites associated with a vendor. Captures site address, site type (manufacturing, distribution, laboratory, office), GMP certification scope, GDP certification status, country of origin, site capacity, site qualification status, and regulatory registration numbers (FDA establishment ID, EMA site number). A single vendor may operate multiple qualified sites.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` (
    `vendor_qualification_id` BIGINT COMMENT 'Unique identifier for the vendor qualification record. Primary key for the vendor qualification entity.',
    `audit_id` BIGINT COMMENT 'Reference to the qualifying audit or assessment that resulted in this qualification decision. Links to the vendor audit record in the quality domain.',
    `dmf_id` BIGINT COMMENT 'Foreign key linking to regulatory.dmf. Business justification: Vendor qualifications for API/excipient suppliers require verification of current DMF filing status. Pharma procurement teams link vendor approvals to specific DMF records to ensure regulatory complia',
    `gxp_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.gxp_obligation. Business justification: Vendor qualifications must demonstrate compliance with specific GxP obligations (GMP, GDP, GCP) based on the material category and regulatory requirements. This link enables traceability between suppl',
    `employee_id` BIGINT COMMENT 'Reference to the quality assurance professional responsible for managing this vendor qualification. Typically a QA manager or supplier quality engineer.',
    `supplier_quality_agreement_id` BIGINT COMMENT 'Reference to the Supplier Quality Agreement (SQA) governing the quality requirements and responsibilities for this vendor. Links to the contract or agreement record.',
    `tertiary_vendor_modified_by_employee_id` BIGINT COMMENT 'Reference to the user who last modified the vendor qualification record. Links to the employee or system user record for audit trail purposes.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor master record being qualified. Links to the vendor entity in the master data domain.',
    `vendor_site_id` BIGINT COMMENT 'Reference to the specific vendor site or facility being qualified. A vendor may have multiple sites requiring independent qualification.',
    `approval_date` DATE COMMENT 'Date when the vendor qualification was formally approved by the quality owner or authorized approver. Represents the official approval decision date.',
    `approved_for_purchasing` BOOLEAN COMMENT 'Indicates whether the vendor is approved for active purchasing. True if purchasing is allowed, false if vendor is blocked or restricted. Drives procurement system integration.',
    `audit_date` DATE COMMENT 'Date when the qualifying audit or assessment was conducted. Denormalized from the audit record for quick reference and reporting.',
    `audit_outcome` STRING COMMENT 'Overall outcome of the qualifying audit. Passed indicates no critical findings, passed-with-observations indicates minor findings that do not prevent qualification, failed indicates critical findings preventing qualification, not-applicable for qualifications not requiring formal audit.. Valid values are `passed|passed-with-observations|failed|not-applicable`',
    `audit_type` STRING COMMENT 'Type of audit or assessment conducted to support the qualification. On-site for physical facility audits, remote for virtual audits, desktop for document-only reviews, hybrid for combination approaches, third-party for audits conducted by external certification bodies.. Valid values are `on-site|remote|desktop|hybrid|third-party`',
    `capa_completion_date` DATE COMMENT 'Date when all required CAPA activities were completed and verified. Null if no CAPA is required or if CAPA is still in progress.',
    `capa_required` BOOLEAN COMMENT 'Indicates whether CAPA (Corrective and Preventive Action) is required from the vendor to address audit findings before or after qualification approval. True if CAPA is required, false otherwise.',
    `certification_iso_13485` BOOLEAN COMMENT 'Indicates whether the vendor holds valid ISO 13485 Medical Devices Quality Management certification. Applicable for vendors supplying medical device components or combination products.',
    `certification_iso_9001` BOOLEAN COMMENT 'Indicates whether the vendor holds valid ISO 9001 Quality Management System certification. True if certified, false otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor qualification record was first created in the system. Used for audit trail and record lifecycle tracking.',
    `critical_findings_count` STRING COMMENT 'Number of critical findings identified during the qualifying audit or assessment. Critical findings typically require resolution before qualification can be approved.',
    `gdp_compliance_required` BOOLEAN COMMENT 'Indicates whether the vendor must comply with GDP (Good Distribution Practice) requirements. True for vendors involved in storage, transportation, or distribution of pharmaceutical products.',
    `gmp_compliance_required` BOOLEAN COMMENT 'Indicates whether the vendor or vendor site must comply with GMP (Good Manufacturing Practice) regulations. True for vendors supplying materials or services that impact product quality, false for non-GMP vendors.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor qualification record was last modified. Used for audit trail and change tracking.',
    `last_regulatory_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection (FDA, EMA, MHRA, etc.) at the vendor site. Used to assess regulatory compliance currency.',
    `major_findings_count` STRING COMMENT 'Number of major findings identified during the qualifying audit or assessment. Major findings may result in conditional approval with required corrective actions.',
    `material_category` STRING COMMENT 'Primary category of materials or services for which the vendor is qualified. API (Active Pharmaceutical Ingredient) for drug substances, excipient for inactive ingredients, packaging-material for primary and secondary packaging, laboratory-supply for testing materials, equipment for capital goods, service for general services, CRO (Contract Research Organization) service, CMO (Contract Manufacturing Organization) service, CDMO (Contract Development and Manufacturing Organization) service. [ENUM-REF-CANDIDATE: api|excipient|packaging-material|laboratory-supply|equipment|service|cro-service|cmo-service|cdmo-service — 9 candidates stripped; promote to reference product]',
    `minor_findings_count` STRING COMMENT 'Number of minor findings or observations identified during the qualifying audit or assessment. Minor findings typically do not prevent qualification but should be addressed.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or re-qualification assessment. Used for proactive qualification lifecycle management.',
    `qualification_date` DATE COMMENT 'Date when the vendor or vendor site was formally qualified and approved for business. Represents the effective start date of the qualification.',
    `qualification_expiry_date` DATE COMMENT 'Date when the current qualification expires and re-qualification is required. Null for indefinite qualifications or when expiry is event-driven rather than time-driven.',
    `qualification_notes` STRING COMMENT 'Free-text notes capturing additional context, conditions, restrictions, or special requirements associated with this qualification. Used for business communication and audit trail.',
    `qualification_number` STRING COMMENT 'Business identifier for the vendor qualification record. Externally visible unique number used in quality documentation and audit trails. Format: VQ-YYYYNNNN.. Valid values are `^VQ-[0-9]{8}$`',
    `qualification_scope` STRING COMMENT 'Detailed description of the scope of qualification, including specific materials, services, processes, or capabilities covered by this qualification. Free-text field capturing business context.',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the vendor qualification. Pending indicates initiated but not started, in-progress indicates active assessment, approved indicates full qualification, conditionally-approved indicates qualified with restrictions, suspended indicates temporary hold, disqualified indicates failed qualification, expired indicates qualification period has lapsed. [ENUM-REF-CANDIDATE: pending|in-progress|approved|conditionally-approved|suspended|disqualified|expired — 7 candidates stripped; promote to reference product]',
    `qualification_type` STRING COMMENT 'Type of qualification being performed. Initial qualification for new vendors, re-qualification for periodic review, for-cause for triggered assessments due to quality issues, periodic for scheduled reviews, change-control for qualification after significant vendor changes.. Valid values are `initial|re-qualification|for-cause|periodic|change-control`',
    `regulatory_inspection_status` STRING COMMENT 'Status of regulatory inspections (FDA, EMA, MHRA, etc.) at the vendor site. Inspected indicates successful regulatory inspection, not-inspected indicates no inspection on record, inspection-pending indicates scheduled inspection, inspection-failed indicates failed inspection with outstanding issues, not-applicable for vendors not subject to regulatory inspection.. Valid values are `inspected|not-inspected|inspection-pending|inspection-failed|not-applicable`',
    `risk_classification` STRING COMMENT 'Risk classification of the vendor based on the impact of their materials or services on product quality and patient safety. Critical for direct product contact materials (APIs, excipients), high for materials affecting product quality, medium for indirect materials, low for non-product-impacting services.. Valid values are `critical|high|medium|low`',
    CONSTRAINT pk_vendor_qualification PRIMARY KEY(`vendor_qualification_id`)
) COMMENT 'Records the formal qualification lifecycle of a vendor or vendor site against GMP, GDP, and supplier quality requirements. Tracks qualification type (initial, re-qualification, for-cause), qualification status (pending, approved, conditionally approved, suspended, disqualified), qualification date, expiry date, responsible quality owner, applicable material categories, and reference to the qualifying audit or assessment. Supports 21 CFR Part 211 and ICH Q10 supplier qualification requirements.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` (
    `supplier_audit_id` BIGINT COMMENT 'Unique identifier for the supplier audit record. Primary key.',
    `employee_id` BIGINT COMMENT 'Internal employee identifier for the lead auditor, used for traceability and accountability.',
    `pai_id` BIGINT COMMENT 'Foreign key linking to regulatory.pai. Business justification: Supplier audits are often triggered by or coordinated with regulatory PAI findings at vendor sites. Pharma quality teams link internal supplier audits to PAI records to verify CAPA closure, assess reg',
    `regulatory_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_inspection. Business justification: Regulatory inspections of manufacturing sites often trigger supplier audits as part of supply chain qualification and risk mitigation. Pharmaceutical companies must audit suppliers when regulatory fin',
    `vendor_site_id` BIGINT COMMENT 'Reference to the vendor site that was audited.',
    `actual_end_date` DATE COMMENT 'Actual date when the on-site audit activities concluded.',
    `actual_start_date` DATE COMMENT 'Actual date when the audit activities commenced, which may differ from the scheduled start date due to logistical or operational reasons.',
    `audit_closure_date` DATE COMMENT 'Date when the audit was formally closed after all findings were resolved, CAPAs verified, and final documentation completed.',
    `audit_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for conducting the audit, including travel, accommodation, auditor time, and vendor fees (if applicable). Captured for cost tracking and budget management.',
    `audit_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the audit cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `audit_number` STRING COMMENT 'Externally-known unique identifier for the audit, typically assigned by the Quality Management System (QMS) or audit management system.',
    `audit_report_number` STRING COMMENT 'Unique identifier for the final audit report document, used for document control and retrieval from Veeva Vault QualityDocs.',
    `audit_scope` STRING COMMENT 'Detailed description of the audit scope, including specific processes, systems, product lines, or GMP/GDP areas covered (e.g., API manufacturing, sterile fill-finish, cold chain distribution, quality control laboratory).',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit: planned (scheduled but not started), in-progress (on-site or in execution), report-draft (audit complete, report being finalized), report-issued (final report delivered to vendor), capa-in-progress (awaiting CAPA closure), closed (all findings resolved and verified), or cancelled. [ENUM-REF-CANDIDATE: planned|in_progress|report_draft|report_issued|capa_in_progress|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `audit_team_members` STRING COMMENT 'Comma-separated list of names or employee IDs of additional audit team members who participated in the audit, including subject matter experts (SMEs) and technical specialists.',
    `audit_type` STRING COMMENT 'Classification of the audit based on its purpose: initial qualification (first-time vendor assessment), periodic surveillance (routine scheduled audit), for-cause (triggered by quality issue or complaint), pre-approval (before contract award), re-qualification (after suspension or major change), or desktop review (document-only assessment).. Valid values are `initial_qualification|periodic_surveillance|for_cause|pre_approval|re_qualification|desktop_review`',
    `capa_approval_date` DATE COMMENT 'Date when the vendors CAPA plan was reviewed and approved by the quality team.',
    `capa_due_date` DATE COMMENT 'Target date by which the vendor must submit CAPA plans for all findings. Typically set based on finding severity and business criticality.',
    `capa_required_flag` BOOLEAN COMMENT 'Indicates whether Corrective and Preventive Action (CAPA) is required from the vendor to address audit findings. True if any critical, major, or minor findings were identified.',
    `capa_submission_date` DATE COMMENT 'Actual date when the vendor submitted their CAPA plan for review and approval.',
    `capa_verification_date` DATE COMMENT 'Date when CAPA effectiveness was verified and findings were confirmed as closed.',
    `capa_verification_method` STRING COMMENT 'Method used to verify the effectiveness of implemented CAPAs: document-review (review of evidence documents), follow-up-audit (on-site verification audit), remote-verification (virtual assessment), sample-testing (product testing to confirm improvement), or not-applicable (no CAPA required).. Valid values are `document_review|follow_up_audit|remote_verification|sample_testing|not_applicable`',
    `comments` STRING COMMENT 'Free-text field for additional notes, context, or special circumstances related to the audit (e.g., vendor cooperation level, logistical challenges, scope changes).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was first created in the system.',
    `critical_findings_count` STRING COMMENT 'Number of critical findings identified. Critical findings represent serious GMP/GDP violations that pose immediate risk to product quality, patient safety, or regulatory compliance.',
    `gdp_compliance_rating` STRING COMMENT 'Overall assessment of the vendors compliance with Good Distribution Practice (GDP) requirements, applicable for distributors and logistics providers.. Valid values are `excellent|satisfactory|needs_improvement|unsatisfactory|not_applicable`',
    `gmp_compliance_rating` STRING COMMENT 'Overall assessment of the vendors compliance with Good Manufacturing Practice (GMP) requirements based on audit findings.. Valid values are `excellent|satisfactory|needs_improvement|unsatisfactory`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was last updated, used for audit trail and change tracking.',
    `major_findings_count` STRING COMMENT 'Number of major findings identified. Major findings represent significant deviations from GMP/GDP requirements that could potentially impact product quality or compliance.',
    `minor_findings_count` STRING COMMENT 'Number of minor findings identified. Minor findings represent isolated or low-impact deviations that do not pose immediate risk but require corrective action.',
    `next_audit_due_date` DATE COMMENT 'Calculated or manually set date for the next scheduled audit of this vendor site, based on risk rating, audit frequency policy, and audit outcome.',
    `observations_count` STRING COMMENT 'Number of observations noted. Observations are areas for improvement or best practice recommendations that do not constitute regulatory non-compliance.',
    `overall_audit_outcome` STRING COMMENT 'Summary conclusion of the audit: approved (vendor meets all requirements), approved-with-conditions (vendor approved pending minor CAPA closure), not-approved (vendor fails to meet critical requirements), or follow-up-required (additional audit needed).. Valid values are `approved|approved_with_conditions|not_approved|follow_up_required`',
    `quality_system_rating` STRING COMMENT 'Overall assessment of the vendors Quality Management System (QMS) maturity and effectiveness.. Valid values are `excellent|satisfactory|needs_improvement|unsatisfactory`',
    `regulatory_references` STRING COMMENT 'Comma-separated list of regulatory citations relevant to the audit scope and findings (e.g., 21 CFR 211.68, EU GMP Annex 11, ICH Q7, ISO 13485).',
    `report_issue_date` DATE COMMENT 'Date when the final audit report was officially issued to the vendor and internal stakeholders.',
    `scheduled_end_date` DATE COMMENT 'Planned end date for the on-site audit or assessment activities.',
    `scheduled_start_date` DATE COMMENT 'Planned start date for the on-site audit or assessment activities.',
    `total_findings_count` STRING COMMENT 'Total number of findings (critical, major, minor, and observations) identified during the audit.',
    `vault_document_reference` STRING COMMENT 'Unique document identifier in Veeva Vault QualityDocs where the full audit report, supporting evidence, and CAPA documentation are stored.',
    CONSTRAINT pk_supplier_audit PRIMARY KEY(`supplier_audit_id`)
) COMMENT 'Records of GMP and GDP audits conducted at vendor locations, including all individual findings, observations, and CAPA tracking through to closure. Captures audit metadata (type, date range, lead auditor, team, scope, overall outcome), individual findings with classification (critical/major/minor/observation), regulatory references (e.g., 21 CFR 211.68, EU GMP Annex 11), root cause categories, proposed CAPAs, CAPA owners, due dates, verification status, and closure dates. References audit reports in Veeva Vault QualityDocs. Supports regulatory inspection readiness and supplier quality oversight.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'Unique identifier for the audit finding record. Primary key.',
    `compliance_capa_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_capa. Business justification: Supplier audit findings requiring corrective action must be tracked in the compliance CAPA system when they relate to GxP obligations or regulatory commitments. This link enables oversight of supplier',
    `supplier_audit_id` BIGINT COMMENT 'Reference to the parent supplier audit during which this finding was raised. Links to the supplier_audit product.',
    `auditor_name` STRING COMMENT 'Name of the lead auditor or audit team member who identified and documented this finding during the supplier audit.',
    `capa_completion_date` DATE COMMENT 'Actual date when the vendor completed implementation of the CAPA. Null if CAPA is still in progress.',
    `capa_description` STRING COMMENT 'Detailed description of the corrective and preventive actions proposed or implemented by the vendor to address the finding and prevent recurrence.',
    `capa_due_date` DATE COMMENT 'Target completion date for the CAPA implementation, agreed upon between the auditing organization and the vendor.',
    `capa_owner_name` STRING COMMENT 'Name of the individual at the vendor organization responsible for implementing and completing the CAPA.',
    `capa_owner_title` STRING COMMENT 'Job title or role of the CAPA owner at the vendor organization (e.g., Quality Manager, Production Supervisor, QA Director).',
    `capa_verification_date` DATE COMMENT 'Date when the CAPA verification was completed and the effectiveness of the corrective action was confirmed.',
    `capa_verification_status` STRING COMMENT 'Status of the verification process to confirm that the CAPA was effectively implemented and addresses the root cause. Rejected status requires rework.. Valid values are `not_started|pending_evidence|under_review|accepted|rejected`',
    `capa_verifier_name` STRING COMMENT 'Name of the individual from the auditing organization who verified the effectiveness of the CAPA implementation.',
    `comments` STRING COMMENT 'Additional notes, observations, or context related to the finding, CAPA implementation, or verification process.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit finding record was first created in the system.',
    `escalation_date` DATE COMMENT 'Date when the finding was escalated to senior management or regulatory authorities. Null if no escalation occurred.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether this finding requires escalation to senior management or regulatory authorities due to severity or potential impact.',
    `finding_classification` STRING COMMENT 'Severity classification of the audit finding. Critical: immediate risk to product quality or patient safety; Major: significant GMP/GDP non-compliance; Minor: isolated deviation; Observation: improvement opportunity without non-compliance.. Valid values are `critical|major|minor|observation`',
    `finding_closure_date` DATE COMMENT 'Date when the audit finding was formally closed after successful CAPA verification and acceptance. Null if finding remains open.',
    `finding_description` STRING COMMENT 'Detailed narrative description of the audit observation, including what was observed, where it was observed, and why it constitutes a non-compliance or improvement opportunity.',
    `finding_identified_date` DATE COMMENT 'Date when the finding was first observed and documented during the audit. Represents the principal business event timestamp for this finding.',
    `finding_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this audit finding for tracking and communication purposes. Typically follows format AUDIT-YEAR-SEQ (e.g., AUD-2024-001).. Valid values are `^[A-Z0-9-]{6,20}$`',
    `finding_status` STRING COMMENT 'Current lifecycle status of the audit finding. Tracks progression from identification through CAPA implementation to closure.. Valid values are `open|capa_pending|capa_submitted|under_review|verified|closed`',
    `gmp_area` STRING COMMENT 'The GMP functional area or system where the finding was identified (e.g., Quality Control, Production, Materials Management, Equipment Maintenance, Documentation, Facilities).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit finding record was last updated in the system. Tracks the most recent change to any field.',
    `previous_finding_reference` STRING COMMENT 'Reference number of the previous audit finding if this is a repeat observation. Null if this is a new finding.',
    `regulatory_reference` STRING COMMENT 'Citation of the specific regulatory requirement, guideline, or standard that was not met. Examples: 21 CFR 211.68, EU GMP Annex 11, ICH Q7, ISO 13485 clause 7.5.3.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this finding must be reported to regulatory authorities (FDA, EMA, etc.) due to its nature or severity.',
    `repeat_finding_flag` BOOLEAN COMMENT 'Indicates whether this finding is a repeat observation from a previous audit of the same vendor, suggesting ineffective CAPA or systemic issues.',
    `risk_to_patient_safety` STRING COMMENT 'Assessment of the potential impact of this finding on patient safety if the underlying issue is not corrected.. Valid values are `high|medium|low|none`',
    `risk_to_product_quality` STRING COMMENT 'Assessment of the potential impact of this finding on the quality, safety, or efficacy of drug products supplied by the vendor.. Valid values are `high|medium|low|none`',
    `root_cause_analysis` STRING COMMENT 'Detailed analysis of the underlying root cause(s) that led to the finding. May include results from 5-Why analysis, fishbone diagrams, or other RCA methodologies.',
    `root_cause_category` STRING COMMENT 'High-level categorization of the underlying root cause of the finding. Used for trend analysis and systemic improvement initiatives.. Valid values are `procedure|training|equipment|material|documentation|system`',
    `supporting_evidence_location` STRING COMMENT 'Reference to the location or document management system path where supporting evidence (photos, documents, test results) for this finding is stored.',
    `vendor_response_date` DATE COMMENT 'Date when the vendor formally responded to the finding with their proposed CAPA plan.',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Individual observations and findings raised during a supplier GMP or GDP audit. Captures finding reference number, finding classification (critical, major, minor, observation), finding description, regulatory reference (e.g., 21 CFR 211.68, EU GMP Annex 11), root cause category, proposed CAPA, CAPA owner at vendor, CAPA due date, CAPA verification status, and finding closure date. Linked to the parent supplier_audit record.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` (
    `supplier_quality_agreement_id` BIGINT COMMENT 'Unique identifier for the supplier quality agreement record.',
    `gxp_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.gxp_obligation. Business justification: Supplier Quality Agreements formalize GxP compliance requirements and responsibilities between parties. Each SQA must reference the specific GxP obligations it addresses (e.g., 21 CFR Part 211 for API',
    `superseded_agreement_supplier_quality_agreement_id` BIGINT COMMENT 'Reference to the previous supplier quality agreement that this version supersedes or replaces.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor party with whom this quality agreement is executed.',
    `vendor_site_id` BIGINT COMMENT 'Reference to the specific vendor site or facility covered by this quality agreement.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the supplier quality agreement document.. Valid values are `^SQA-[A-Z0-9]{6,12}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the supplier quality agreement. [ENUM-REF-CANDIDATE: Draft|Under Review|Approved|Active|Suspended|Expired|Terminated|Superseded — 8 candidates stripped; promote to reference product]',
    `agreement_title` STRING COMMENT 'Descriptive title of the supplier quality agreement document.',
    `agreement_type` STRING COMMENT 'Classification of the supplier quality agreement based on the scope of supply or service. [ENUM-REF-CANDIDATE: API Supply|Excipient Supply|Packaging Material Supply|Laboratory Services|Manufacturing Services|Testing Services|Distribution Services|Analytical Services|Storage Services|Transport Services — promote to reference product]',
    `audit_frequency_months` STRING COMMENT 'Agreed frequency in months for conducting supplier audits as stipulated in the quality agreement.',
    `audit_rights_clause` STRING COMMENT 'Contractual clause defining the organizations right to audit the suppliers facilities, processes, and quality systems, including frequency and scope.',
    `change_notification_lead_time_days` STRING COMMENT 'Minimum number of days advance notice the supplier must provide before implementing any change covered by the agreement.',
    `change_notification_required` BOOLEAN COMMENT 'Indicates whether the supplier is obligated to notify the organization of any changes to materials, processes, facilities, or quality systems.',
    `coa_format_specification` STRING COMMENT 'Detailed specification of the required format, content, and data elements for the Certificate of Analysis.',
    `coa_required` BOOLEAN COMMENT 'Indicates whether the supplier is required to provide a Certificate of Analysis with each shipment or batch.',
    `confidentiality_clause` STRING COMMENT 'Contractual provisions governing the protection and handling of confidential information exchanged between the parties.',
    `created_by_user` STRING COMMENT 'User identifier or name of the person who created this supplier quality agreement record in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supplier quality agreement record was first created in the system.',
    `deviation_notification_required` BOOLEAN COMMENT 'Indicates whether the supplier must notify the organization of any deviations, Out of Specification (OOS) results, or quality incidents.',
    `deviation_notification_timeframe_hours` STRING COMMENT 'Maximum number of hours within which the supplier must notify the organization of a deviation or quality incident.',
    `document_storage_location` STRING COMMENT 'Physical or electronic location where the executed supplier quality agreement document is stored, such as a document management system path or repository reference.',
    `effective_date` DATE COMMENT 'Date on which the supplier quality agreement becomes legally binding and enforceable.',
    `expiry_date` DATE COMMENT 'Date on which the supplier quality agreement expires or terminates, unless renewed. Nullable for open-ended agreements.',
    `gdp_compliance_required` BOOLEAN COMMENT 'Indicates whether the supplier must comply with Good Distribution Practice guidelines for storage and transportation.',
    `gmp_responsibility_matrix` STRING COMMENT 'Documented allocation of GMP responsibilities between the organization and the supplier, specifying who is accountable for each quality activity.',
    `last_modified_by_user` STRING COMMENT 'User identifier or name of the person who last modified this supplier quality agreement record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this supplier quality agreement record was last updated or modified.',
    `organization_signatory_name` STRING COMMENT 'Full name of the authorized representative from the organization who signed the quality agreement.',
    `organization_signatory_title` STRING COMMENT 'Job title or position of the organization signatory who executed the quality agreement.',
    `organization_signature_date` DATE COMMENT 'Date on which the organization signatory executed the quality agreement.',
    `quality_specifications_reference` STRING COMMENT 'Reference to the detailed quality specifications, acceptance criteria, and testing requirements applicable to the materials or services covered by this agreement.',
    `regulatory_compliance_requirements` STRING COMMENT 'Specific regulatory standards and compliance requirements the supplier must adhere to, including FDA, EMA, PMDA, and other applicable regulations.',
    `review_date` DATE COMMENT 'Scheduled date for periodic review of the supplier quality agreement to ensure continued relevance and compliance.',
    `scope_of_supply` STRING COMMENT 'Detailed description of the materials, products, services, or manufacturing steps covered under this supplier quality agreement.',
    `supplier_signatory_name` STRING COMMENT 'Full name of the authorized representative from the supplier organization who signed the quality agreement.',
    `supplier_signatory_title` STRING COMMENT 'Job title or position of the supplier signatory who executed the quality agreement.',
    `supplier_signature_date` DATE COMMENT 'Date on which the supplier signatory executed the quality agreement.',
    `termination_clause` STRING COMMENT 'Contractual terms and conditions under which either party may terminate the supplier quality agreement, including notice periods and grounds for termination.',
    `version_number` STRING COMMENT 'Version identifier of the supplier quality agreement document, following major.minor versioning convention.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    CONSTRAINT pk_supplier_quality_agreement PRIMARY KEY(`supplier_quality_agreement_id`)
) COMMENT 'Formal quality agreements (SQAs) executed between the organization and its GMP suppliers, CROs, CMOs, and CDMOs. Captures agreement version, effective date, expiry date, scope of supply (materials, services, manufacturing steps), GMP responsibilities matrix, change notification requirements, audit rights clause, CoA requirements, deviation notification obligations, and signatory details. Mandated under 21 CFR 211.84 and EU GMP Chapter 7 for outsourced activities.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` (
    `sourcing_event_id` BIGINT COMMENT 'Unique identifier for the sourcing event. Primary key.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor awarded the contract from this sourcing event. Links to vendor master data.',
    `audit_requirement_flag` BOOLEAN COMMENT 'Indicates whether the sourcing event requires vendors to undergo a GMP or quality audit before contract award.',
    `award_date` DATE COMMENT 'Date when the sourcing event was awarded to the winning vendor(s).',
    `awarded_bid_amount` DECIMAL(18,2) COMMENT 'Total contract value or bid amount of the winning vendors proposal.',
    `bid_submission_deadline` TIMESTAMP COMMENT 'Date and time by which vendors must submit their bids. After this timestamp, the event is closed to new submissions.',
    `business_unit` STRING COMMENT 'Business unit or division sponsoring the sourcing event (e.g., Manufacturing, R&D, Quality, Clinical Operations).',
    `commercial_weight_percentage` DECIMAL(18,2) COMMENT 'Percentage weight assigned to commercial terms (payment terms, delivery, MOQ, etc.) in the overall bid scoring model (0-100).',
    `commodity_category` STRING COMMENT 'Procurement commodity category or spend category for the sourcing event (e.g., Active Pharmaceutical Ingredients, Excipients, Packaging Materials, Laboratory Supplies, CRO Services, CMO Services).',
    `contract_duration_months` STRING COMMENT 'Expected duration of the contract resulting from the sourcing event, expressed in months.',
    `contract_type` STRING COMMENT 'Type of contract to be awarded from the sourcing event (e.g., Fixed Price, Cost Plus, Time and Materials, Blanket Purchase Agreement, Framework Agreement).. Valid values are `Fixed Price|Cost Plus|Time and Materials|Blanket|Framework`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the sourcing event record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the sourcing event (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `estimated_total_value` DECIMAL(18,2) COMMENT 'Estimated total contract value or spend amount for the sourcing event, used for planning and budgeting purposes.',
    `evaluation_completion_date` DATE COMMENT 'Date when bid evaluation was completed and final vendor selection was made.',
    `evaluation_criteria` STRING COMMENT 'Structured description of the evaluation criteria used to assess vendor bids (e.g., price, quality, delivery time, technical capability, compliance). May be stored as JSON or delimited text listing criteria names.',
    `evaluation_start_date` DATE COMMENT 'Date when bid evaluation process began.',
    `event_description` STRING COMMENT 'Detailed description of the sourcing event, including scope of work, materials or services being procured, technical requirements, and any special instructions for vendors.',
    `event_number` STRING COMMENT 'Business identifier for the sourcing event, typically generated by SAP Ariba or procurement system. Externally visible reference number used in communications with vendors.',
    `event_owner_email` STRING COMMENT 'Email address of the event owner for vendor communications and inquiries.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `event_owner_name` STRING COMMENT 'Name of the procurement professional or buyer responsible for managing the sourcing event.',
    `event_status` STRING COMMENT 'Current lifecycle status of the sourcing event: Draft (being prepared), Published (sent to vendors), Open (accepting bids), Closed (bid submission ended), Evaluation (bids being reviewed), Awarded (vendor selected), Cancelled (event terminated). [ENUM-REF-CANDIDATE: Draft|Published|Open|Closed|Evaluation|Awarded|Cancelled — 7 candidates stripped; promote to reference product]',
    `event_title` STRING COMMENT 'Descriptive title of the sourcing event, summarizing the procurement need or category being sourced.',
    `event_type` STRING COMMENT 'Type of sourcing event: RFI (Request for Information), RFP (Request for Proposal), RFQ (Request for Quotation), Auction, Reverse Auction, or eRFX (electronic request for X).. Valid values are `RFI|RFP|RFQ|Auction|Reverse Auction|eRFX`',
    `gdp_requirement_flag` BOOLEAN COMMENT 'Indicates whether the sourcing event requires vendors to comply with GDP standards for distribution and logistics.',
    `gmp_requirement_flag` BOOLEAN COMMENT 'Indicates whether the sourcing event requires vendors to be GMP-certified or comply with GMP standards.',
    `invited_vendor_count` STRING COMMENT 'Total number of vendors invited to participate in the sourcing event.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the sourcing event record was last updated or modified.',
    `price_weight_percentage` DECIMAL(18,2) COMMENT 'Percentage weight assigned to price in the overall bid evaluation scoring model (0-100).',
    `publication_date` DATE COMMENT 'Date when the sourcing event was published and made available to invited vendors.',
    `quality_agreement_required` BOOLEAN COMMENT 'Indicates whether a formal Supplier Quality Agreement (SQA) is required as part of the contract award.',
    `responding_vendor_count` STRING COMMENT 'Number of vendors who submitted bids or responses to the sourcing event.',
    `savings_achieved` DECIMAL(18,2) COMMENT 'Cost savings achieved through the sourcing event, calculated as the difference between baseline/target cost and awarded bid amount.',
    `technical_weight_percentage` DECIMAL(18,2) COMMENT 'Percentage weight assigned to technical evaluation criteria in the overall bid scoring model (0-100).',
    `terms_and_conditions` STRING COMMENT 'Standard or custom terms and conditions applicable to the sourcing event and resulting contract, including legal, commercial, and compliance requirements.',
    CONSTRAINT pk_sourcing_event PRIMARY KEY(`sourcing_event_id`)
) COMMENT 'Strategic sourcing events (RFI, RFP, RFQ) managed through SAP Ariba, including all vendor bid responses and evaluation outcomes. Captures event metadata (type, title, commodity category, business unit, status, deadline, evaluation criteria/weightings, invited vendors) and complete bid detail per vendor (quoted prices, lead times, MOQ, payment terms, technical/commercial scores, total evaluated cost, bid status, evaluator comments). Enables end-to-end competitive sourcing from event publication through bid evaluation to vendor award decision.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` (
    `sourcing_bid_id` BIGINT COMMENT 'Unique identifier for the sourcing bid record. Primary key.',
    `sourcing_event_id` BIGINT COMMENT 'Reference to the parent sourcing event (Request for Information (RFI), Request for Proposal (RFP), Request for Quotation (RFQ)) for which this bid was submitted.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor (supplier, Contract Research Organization (CRO), Contract Manufacturing Organization (CMO), Contract Development and Manufacturing Organization (CDMO)) who submitted this bid.',
    `award_date` DATE COMMENT 'Date when the bid was awarded and the vendor was selected as the supplier for the sourcing event.',
    `bid_number` STRING COMMENT 'Externally-known unique business identifier for this bid submission, typically assigned by the vendor or sourcing system.',
    `bid_status` STRING COMMENT 'Current lifecycle status of the bid in the evaluation and selection process.. Valid values are `submitted|under_evaluation|shortlisted|rejected|awarded|withdrawn`',
    `certificate_of_analysis_provided` BOOLEAN COMMENT 'Indicates whether the vendor provided a sample Certificate of Analysis (CoA) with the bid to demonstrate material quality and compliance.',
    `commercial_score` DECIMAL(18,2) COMMENT 'Score assigned by the evaluation team assessing the commercial attractiveness of the bid (price, payment terms, lead time, Minimum Order Quantity (MOQ)). Typically on a 0-100 scale.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bid record was first created in the system. Audit trail field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the quoted prices (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `delivery_location` STRING COMMENT 'Destination location or plant where the vendor will deliver the material or service.',
    `drug_master_file_number` STRING COMMENT 'Drug Master File (DMF) number provided by the vendor for Active Pharmaceutical Ingredient (API) or excipient sourcing, if applicable.',
    `evaluator_comments` STRING COMMENT 'Free-text comments and observations from the evaluation team regarding the bid, including strengths, weaknesses, risks, and recommendations.',
    `gmp_certificate_number` STRING COMMENT 'Certificate number of the vendors Good Manufacturing Practice (GMP) certification, if applicable to this bid.',
    `gmp_compliant` BOOLEAN COMMENT 'Indicates whether the vendor confirmed Good Manufacturing Practice (GMP) compliance for the material or service in this bid.',
    `incoterms` STRING COMMENT 'Incoterms code defining the delivery terms and transfer of risk (e.g., EXW, FOB, CIF, DDP). Follows International Chamber of Commerce (ICC) Incoterms standards.',
    `iso_certification_standard` STRING COMMENT 'Specific International Organization for Standardization (ISO) standard(s) the vendor is certified to (e.g., ISO 9001:2015, ISO 13485:2016).',
    `iso_certified` BOOLEAN COMMENT 'Indicates whether the vendor holds relevant International Organization for Standardization (ISO) certifications (e.g., ISO 9001, ISO 13485) for the material or service in this bid.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this bid record was last updated in the system. Audit trail field.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required by the vendor for this material or service. Expressed in the unit of measure specified in unit_of_measure.',
    `payment_terms` STRING COMMENT 'Payment terms offered by the vendor (e.g., Net 30, Net 60, 2/10 Net 30, Letter of Credit, Advance Payment). Defines when and how payment is expected.',
    `quality_score` DECIMAL(18,2) COMMENT 'Score assigned by the quality team assessing the vendors quality management system, Good Manufacturing Practice (GMP) certification, audit history, and quality track record. Typically on a 0-100 scale.',
    `quoted_lead_time_days` STRING COMMENT 'Number of days the vendor commits to deliver the material or service from order placement to delivery.',
    `quoted_total_price` DECIMAL(18,2) COMMENT 'Total price quoted by the vendor for the entire quantity or scope of the sourcing event. Expressed in the currency specified in currency_code.',
    `quoted_unit_price` DECIMAL(18,2) COMMENT 'Unit price quoted by the vendor for the material or service being sourced. Expressed in the currency specified in currency_code.',
    `regulatory_compliance_confirmed` BOOLEAN COMMENT 'Indicates whether the vendor confirmed compliance with applicable regulatory requirements (Food and Drug Administration (FDA), European Medicines Agency (EMA), Pharmaceuticals and Medical Devices Agency (PMDA), etc.) for the material or service.',
    `rejection_reason` STRING COMMENT 'Reason for rejecting the bid, if applicable (e.g., non-compliance, high price, long lead time, failed quality assessment).',
    `sample_provided` BOOLEAN COMMENT 'Indicates whether the vendor provided a physical sample of the material with the bid for evaluation and testing.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the vendor submitted the bid response to the sourcing event. Principal business event timestamp.',
    `technical_compliance_score` DECIMAL(18,2) COMMENT 'Score assigned by the evaluation team assessing the vendors technical compliance with specifications, Good Manufacturing Practice (GMP), Good Laboratory Practice (GLP), and regulatory requirements. Typically on a 0-100 scale.',
    `total_evaluated_cost` DECIMAL(18,2) COMMENT 'Total cost of ownership calculated by the evaluation team, including quoted price, logistics costs, quality risk adjustments, and other factors. Used for comparative bid analysis.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quoted material or service (e.g., KG, L, EA, HR, MT). Aligns with International System of Units (SI) or industry-standard units.',
    `validity_end_date` DATE COMMENT 'End date of the period during which the vendors quoted prices and terms are valid and binding.',
    `validity_start_date` DATE COMMENT 'Start date of the period during which the vendors quoted prices and terms are valid and binding.',
    `vendor_contact_email` STRING COMMENT 'Email address of the vendor representative for communication regarding this bid.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `vendor_contact_name` STRING COMMENT 'Name of the vendor representative who submitted the bid and serves as the primary contact for this sourcing event.',
    `vendor_contact_phone` STRING COMMENT 'Phone number of the vendor representative for communication regarding this bid.',
    CONSTRAINT pk_sourcing_bid PRIMARY KEY(`sourcing_bid_id`)
) COMMENT 'Vendor responses and bids submitted in response to a sourcing event (RFI/RFP/RFQ). Captures bid submission date, vendor quoted price, quoted lead time, minimum order quantity (MOQ), payment terms offered, technical compliance score, commercial score, total evaluated cost, bid status (submitted, under evaluation, shortlisted, rejected, awarded), and evaluator comments. Enables competitive bid comparison and supplier selection decisions.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` (
    `supply_contract_id` BIGINT COMMENT 'Primary key for supply_contract',
    `drug_substance_id` BIGINT COMMENT 'Foreign key linking to product.drug_substance. Business justification: API supply contracts specify the drug substance. FK enables contract price verification against purchase orders, specification version alignment, change control notification requirements, and supply c',
    `excipient_id` BIGINT COMMENT 'Foreign key linking to product.excipient. Business justification: Excipient supply contracts specify the excipient grade and specification. FK enables contract compliance verification, specification change management, quality agreement alignment, and alternate sourc',
    `sourcing_event_id` BIGINT COMMENT 'Foreign key linking to procurement.sourcing_event. Business justification: Supply contracts are often awarded as a result of competitive sourcing events (RFP/RFQ). This FK links the executed contract back to the sourcing event that led to vendor selection, enabling sourcing ',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor party who is the counterparty to this contract.',
    `approval_date` DATE COMMENT 'Date when the contract was formally approved by authorized signatories and became legally binding. May differ from effective_start_date if approval precedes contract activation.',
    `approved_by` STRING COMMENT 'Name or employee ID of the authorized signatory who approved this contract on behalf of the organization. Required for contract audit trail and SOX compliance.',
    `audit_frequency_months` STRING COMMENT 'Required frequency in months for conducting supplier audits under this contract. High-risk suppliers (API, sterile products) typically require annual audits; lower-risk suppliers may be audited every 2-3 years.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews at the end of its term. True means the contract will extend for another period unless terminated; False means it expires without action.',
    `committed_volume` DECIMAL(18,2) COMMENT 'Total quantity the buyer commits to purchase over the contract lifetime. Used in volume-based pricing agreements and supplier capacity planning.',
    `contract_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this contract (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `contract_description` STRING COMMENT 'Free-text description of the contract scope, covering materials, services, or categories included. Provides business context for contract purpose and coverage.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the supply contract, used in SAP MM and Ariba contract workspace.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `contract_owner` STRING COMMENT 'Name or employee ID of the procurement professional responsible for managing this supply contract. Primary point of contact for contract administration and supplier relationship management.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the supply contract. Active contracts are in force; suspended contracts are temporarily on hold; expired contracts have passed their validity period. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|renewed — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the supply contract type. Framework agreements cover multiple materials over time; blanket orders specify quantity or value limits; quality agreements define supplier quality requirements.. Valid values are `framework_agreement|blanket_order|quantity_contract|value_contract|master_service_agreement|quality_agreement`',
    `contract_value` DECIMAL(18,2) COMMENT 'Total monetary value of the supply contract over its lifetime. For value contracts, this is the maximum spend allowed. For quantity contracts, this is the estimated total value based on committed volumes and unit prices.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was first created in the system. Used for audit trail and data lineage tracking.',
    `delivery_location` STRING COMMENT 'Primary delivery destination or plant code where materials under this contract will be shipped. May reference SAP plant or warehouse master data.',
    `effective_end_date` DATE COMMENT 'Date when the supply contract expires or terminates. Nullable for open-ended contracts. After this date, no new purchase orders can reference this contract unless renewed.',
    `effective_start_date` DATE COMMENT 'Date when the supply contract becomes legally binding and enforceable. Purchase orders can reference this contract from this date forward.',
    `gdp_compliance_required` BOOLEAN COMMENT 'Indicates whether the supplier must comply with Good Distribution Practice (GDP) guidelines for storage and transportation of pharmaceutical materials. Critical for temperature-sensitive APIs and biologics.',
    `gmp_compliance_required` BOOLEAN COMMENT 'Indicates whether the supplier must maintain current Good Manufacturing Practice (cGMP) certification for materials supplied under this contract. Mandatory for API, excipient, and drug product suppliers.',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the responsibilities of buyer and seller for delivery, insurance, and risk transfer (e.g., EXW, FOB, CIF, DDP). Critical for landed cost calculation and GDP compliance. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_audit_date` DATE COMMENT 'Date of the most recent supplier audit conducted under this contract. Used to calculate next audit due date and maintain audit compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was last updated. Tracks all changes to contract terms, status, or pricing for audit and compliance purposes.',
    `material_category` STRING COMMENT 'Primary material or service category covered by this contract (e.g., API, excipients, packaging materials, laboratory supplies, CRO services, CMO services). May reference SAP MM material group hierarchy. [ENUM-REF-CANDIDATE: api|excipient|packaging_primary|packaging_secondary|laboratory_supplies|cro_services|cmo_services|cdmo_services|equipment|utilities — promote to reference product]',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity that can be ordered per purchase order under this contract. May reflect supplier capacity constraints or buyer volume commitments.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered per purchase order under this contract. Enforces supplier minimum batch or economic order quantity requirements.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next supplier audit. Calculated from last_audit_date plus audit_frequency_months. Critical for maintaining supplier qualification status.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the supplier (e.g., net_30, net_60, 2_10_net_30 for 2% discount if paid within 10 days otherwise net 30). Defines when payment is due after invoice receipt.. Valid values are `^(net_[0-9]{1,3}|[0-9]{1,2}_[0-9]{1,3}_net_[0-9]{1,3}|due_on_receipt|prepayment|consignment)$`',
    `price_basis` STRING COMMENT 'Pricing methodology for this contract. Fixed prices remain constant; indexed prices adjust based on external indices; cost-plus adds margin to supplier costs; market-based prices fluctuate with market conditions.. Valid values are `fixed|indexed|cost_plus|market_based`',
    `price_escalation_clause` STRING COMMENT 'Contractual terms defining how and when prices may be adjusted during the contract term. May reference inflation indices, raw material cost changes, or periodic review schedules.',
    `price_index_reference` STRING COMMENT 'External price index or benchmark used for indexed pricing (e.g., CPI, commodity index, published API price index). Only applicable when price_basis is indexed.',
    `quality_agreement_number` STRING COMMENT 'Reference number of the associated Supplier Quality Agreement (SQA) or Quality Technical Agreement (QTA). Links to quality management system documentation.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `quality_agreement_required` BOOLEAN COMMENT 'Indicates whether a separate Quality Agreement or Supplier Quality Agreement (SQA) is required for materials supplied under this contract. Mandatory for API and excipient suppliers under GMP.',
    `renewal_period_months` STRING COMMENT 'Number of months the contract extends for each automatic renewal cycle. Only applicable when auto_renewal_flag is True.',
    `risk_rating` STRING COMMENT 'Supplier and contract risk classification based on material criticality, supplier qualification status, regulatory requirements, and supply chain risk assessment. Critical rating applies to sole-source API suppliers.. Valid values are `critical|high|medium|low`',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required to terminate the contract. Both parties must provide this notice period before contract termination becomes effective.',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measure for all volume and quantity fields in this contract (e.g., KG for kilograms, EA for each, L for liters). Must align with SAP MM material master UOM.. Valid values are `^[A-Z]{2,3}$`',
    CONSTRAINT pk_supply_contract PRIMARY KEY(`supply_contract_id`)
) COMMENT 'Commercial contracts and framework agreements with suppliers covering supply of APIs, excipients, packaging materials, laboratory supplies, and outsourced services. Captures contract terms (type, value, currency, dates, auto-renewal, payment terms, incoterms, price escalation, volume commitments, termination notice) and complete tiered pricing schedules (price per unit, volume breaks, price validity periods, price basis including fixed/indexed/cost-plus, index references, approved price change history). Integrates with SAP MM outline agreements and Ariba contract workspace. Enables accurate PO pricing and landed cost calculations.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` (
    `contract_price_schedule_id` BIGINT COMMENT 'Unique identifier for the contract price schedule entry. Primary key.',
    `superseded_by_schedule_contract_price_schedule_id` BIGINT COMMENT 'Reference to the contract_price_schedule_id that supersedes this entry. Null if this is the current active schedule.',
    `supply_contract_id` BIGINT COMMENT 'Reference to the parent procurement contract to which this price schedule is attached. Links to the master contract agreement.',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: Contract price schedule UOM for pricing and PO creation. UOM master provides conversion factors for pharmaceutical contract pricing and procurement cost calculation.',
    `approval_date` DATE COMMENT 'Date on which this price schedule entry was formally approved and became effective.',
    `approved_by` STRING COMMENT 'Name or user ID of the procurement manager or authorized approver who approved this price schedule entry.',
    `cost_plus_percentage` DECIMAL(18,2) COMMENT 'Markup percentage applied to vendor cost when price_basis is cost_plus. Null for other pricing bases.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this price schedule entry was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the price per unit (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `freight_cost_included` BOOLEAN COMMENT 'Indicates whether freight and shipping costs are included in the price per unit (True) or billed separately (False).',
    `incoterms` STRING COMMENT 'International Commercial Terms (Incoterms) defining the delivery and risk transfer point for this price schedule entry, such as EXW, FOB, CIF, DDP. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `index_reference` STRING COMMENT 'External index or benchmark used for indexed pricing, such as CPI (Consumer Price Index), PPI (Producer Price Index) for chemicals, or commodity market indices. Null if price_basis is not indexed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this price schedule entry was last updated or modified.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days from PO issuance to delivery for materials or services under this price schedule.',
    `material_code` STRING COMMENT 'Material master code identifying the specific raw material, API (Active Pharmaceutical Ingredient), excipient, packaging component, or laboratory supply covered by this price schedule entry. Aligns with SAP material master.. Valid values are `^[A-Z0-9]{6,18}$`',
    `material_description` STRING COMMENT 'Human-readable description of the material or service covered by this price schedule line, including grade, specification, or service type.',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum order quantity allowed under this price schedule entry. Null if no upper limit applies.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required to qualify for this price schedule entry. Null if no MOQ applies.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this price schedule entry, such as special conditions, negotiation context, or supplier-specific terms.',
    `payment_terms` STRING COMMENT 'Payment terms applicable to this price schedule entry, such as Net 30, Net 60, or 2/10 Net 30. Aligns with contract payment terms.',
    `price_basis` STRING COMMENT 'Pricing methodology applied to this schedule line: fixed (static price), indexed (tied to external index), cost_plus (vendor cost plus margin), or market_based (subject to market rate adjustments).. Valid values are `fixed|indexed|cost_plus|market_based`',
    `price_change_reason` STRING COMMENT 'Business reason for the most recent price change, such as market adjustment, volume discount, contract renegotiation, or index escalation.',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Contracted price per unit of measure for the material or service. Used for PO (Purchase Order) pricing and COGS (Cost of Goods Sold) calculation.',
    `price_validity_end_date` DATE COMMENT 'Effective end date until which this price schedule entry remains valid. Null for open-ended pricing agreements.',
    `price_validity_start_date` DATE COMMENT 'Effective start date from which this price schedule entry is valid and applicable to purchase orders.',
    `schedule_line_number` STRING COMMENT 'Sequential line number within the contract price schedule, used for ordering and referencing specific pricing tiers or periods.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of this price schedule entry: active (in use), inactive (not in use), pending (awaiting approval), expired (validity period ended), or superseded (replaced by newer schedule).. Valid values are `active|inactive|pending|expired|superseded`',
    `service_code` STRING COMMENT 'Service master code for contracted services such as CRO (Contract Research Organization), CMO (Contract Manufacturing Organization), or CDMO (Contract Development and Manufacturing Organization) services. Null if the schedule line applies to materials.',
    `tax_code` STRING COMMENT 'Tax code applicable to this price schedule entry, used for VAT, GST, or sales tax calculation. Aligns with SAP FI tax configuration.',
    `threshold_unit_of_measure` STRING COMMENT 'Unit of measure for the volume break threshold, ensuring alignment with the material or service UOM. [ENUM-REF-CANDIDATE: KG|L|EA|M|M2|M3|HR|DAY|DOSE|VIAL|BOX|PALLET — 12 candidates stripped; promote to reference product]',
    `volume_break_threshold` DECIMAL(18,2) COMMENT 'Minimum order quantity or cumulative volume threshold that triggers this pricing tier. Null if no volume-based tiering applies.',
    CONSTRAINT pk_contract_price_schedule PRIMARY KEY(`contract_price_schedule_id`)
) COMMENT 'Tiered pricing schedules and price validity periods attached to procurement contracts. Captures material or service code, price per unit, unit of measure, currency, volume break thresholds, price validity start and end dates, price basis (fixed, indexed, cost-plus), index reference (e.g., CPI, PPI chemical index), and approved price change history. Enables accurate PO pricing and landed cost calculations for COGS reporting.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` (
    `purchase_requisition_id` BIGINT COMMENT 'Unique identifier for the purchase requisition record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Purchase requisitions charge to cost centers for budget control, SOX compliance, and financial planning. Cost center master provides budget availability, GMP classification, and approval hierarchy for',
    `vendor_id` BIGINT COMMENT 'Identifier of the preferred or suggested vendor for sourcing this requisition. Optional field; may be specified by requester based on prior relationships or sourcing strategy. Links to vendor master data.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who created and submitted the purchase requisition. Links to employee master data for approval routing and accountability.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Requisitions triggered by production orders for campaign-specific materials, equipment, or services. Links procurement demand signal to manufacturing execution for MRP accuracy, campaign planning, and',
    `requester_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Requisitions specify receiving plant for MRP planning, goods receipt processing, and inventory management. Plant master provides GMP certification status, capacity, and storage conditions for pharmace',
    `sourcing_material_id` BIGINT COMMENT 'Foreign key linking to procurement.sourcing_material. Business justification: Purchase requisitions request procurement of specific materials. The existing material_number, material_description, and material_group are denormalized references that should be replaced with a prope',
    `approval_date` DATE COMMENT 'Date when the purchase requisition received final approval and became eligible for sourcing and purchase order creation. Null if not yet approved.',
    `approval_workflow_stage` STRING COMMENT 'Current stage in the multi-level approval workflow. Tracks which approval authority level the requisition is awaiting. Workflow stages vary by requisition value and material category per company policy. [ENUM-REF-CANDIDATE: not_submitted|pending_supervisor|pending_manager|pending_procurement|pending_finance|pending_quality|approved|rejected — 8 candidates stripped; promote to reference product]',
    `cancellation_date` DATE COMMENT 'Date when the purchase requisition was cancelled. Null if not cancelled. Cancellation may occur due to changed business needs or duplicate requests.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the purchase requisition was cancelled. Provides business context for audit and process improvement.',
    `contract_number` STRING COMMENT 'Reference to an existing procurement contract or supplier quality agreement under which this requisition should be sourced. Links to contract master data in SAP MM.. Valid values are `^CTR[0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Precise timestamp when this purchase requisition record was first captured in the system, including time component for audit trail purposes.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated value. Typically company code default currency (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_address_line_1` STRING COMMENT 'First line of the delivery address for the requested materials or services. May differ from plant default address for special delivery instructions.',
    `delivery_city` STRING COMMENT 'City name for the delivery address. Part of the complete delivery location specification.',
    `delivery_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the delivery address. Determines customs, regulatory, and GDP compliance requirements.. Valid values are `^[A-Z]{3}$`',
    `delivery_postal_code` STRING COMMENT 'Postal or ZIP code for the delivery address. Required for logistics planning and shipping documentation.',
    `estimated_value` DECIMAL(18,2) COMMENT 'Estimated total value of the purchase requisition in the company currency. Used for approval threshold determination and budget checking. May be system-calculated from material price or manually entered.',
    `gmp_relevant` BOOLEAN COMMENT 'Indicates whether the requisition is for GMP-regulated materials or services that require qualified suppliers and quality agreements. True for APIs, excipients, and materials used in drug product manufacturing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this purchase requisition record. Tracks all changes for audit and compliance purposes.',
    `priority_code` STRING COMMENT 'Priority level assigned to the requisition indicating urgency of need. Influences approval routing speed and sourcing strategy. Critical priority may be used for production-critical APIs or clinical trial materials.. Valid values are `low|normal|high|urgent|critical`',
    `purchase_order_number` STRING COMMENT 'Purchase order number generated from this requisition. Populated when requisition is converted to a purchase order in SAP MM (ME21N). Null if not yet sourced.. Valid values are `^PO[0-9]{10}$`',
    `quality_approval_date` DATE COMMENT 'Date when Quality Assurance approved the requisition. Null if quality approval not required or not yet obtained.',
    `quality_approval_required` BOOLEAN COMMENT 'Indicates whether the requisition requires approval from Quality Assurance before purchase order creation. Typically true for GMP materials, laboratory reagents, and critical manufacturing supplies.',
    `quantity_requested` DECIMAL(18,2) COMMENT 'Quantity of material or service units being requested. Precision supports pharmaceutical dosage and laboratory measurement requirements.',
    `rejection_date` DATE COMMENT 'Date when the purchase requisition was rejected by an approver. Null if not rejected.',
    `rejection_reason` STRING COMMENT 'Free-text explanation provided by the approver for rejecting the purchase requisition. Captures business justification for denial.',
    `required_delivery_date` DATE COMMENT 'Date by which the requester needs the material or service delivered. Drives procurement lead time calculations and supplier selection.',
    `requisition_number` STRING COMMENT 'Business identifier for the purchase requisition as displayed in SAP MM. Externally-known unique number used for tracking and reference across procurement processes.. Valid values are `^PR[0-9]{10}$`',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the purchase requisition in the procurement workflow. Tracks progression from creation through approval, sourcing, and purchase order generation. [ENUM-REF-CANDIDATE: created|pending_approval|approved|rejected|sourced|po_created|partially_ordered|fully_ordered|cancelled|closed — 10 candidates stripped; promote to reference product]',
    `requisition_type` STRING COMMENT 'Classification of the purchase requisition based on procurement category. Determines downstream processing rules and approval workflows.. Valid values are `standard|subcontracting|consignment|stock_transfer|service|third_party`',
    `sourcing_date` DATE COMMENT 'Date when the requisition was assigned to a purchase order. Marks the transition from requisition to committed procurement.',
    `special_instructions` STRING COMMENT 'Free-text field for additional instructions or requirements related to the requisition. May include handling requirements, packaging specifications, or delivery constraints specific to pharmaceutical materials.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the requested quantity. ISO codes such as KG (kilogram), L (liter), EA (each), HR (hour). Must align with material master base UOM.. Valid values are `^[A-Z]{2,3}$`',
    `creation_date` DATE COMMENT 'Date when the purchase requisition was originally created in the system. Represents the business event timestamp for requisition initiation.',
    CONSTRAINT pk_purchase_requisition PRIMARY KEY(`purchase_requisition_id`)
) COMMENT 'Internal purchase requisitions (PRs) raised by business units requesting procurement of materials or services. Captures requisition number, requesting plant or cost center, material or service description, required quantity, unit of measure, required delivery date, estimated value, requisition status (created, approved, sourced, PO created, cancelled), approval workflow stage, and preferred vendor if specified. Source document for purchase order creation in SAP MM (ME51N).';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Primary key for purchase_order',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Pharma procurement requires tracking which buyer created each PO for audit trails, workload analysis, performance metrics, and SOX compliance. Critical for segregation of duties validation and regulat',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Purchase orders are issued by legal entities for contract authority, tax determination, and financial accounting. Legal entity master provides tax ID, company code, and regulatory identifiers for phar',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Purchase orders specify receiving plant for goods receipt, quality inspection, and inventory posting. Plant master provides GMP zone, LIMS integration, and storage capacity for pharmaceutical procurem',
    `supply_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supply_contract. Business justification: Purchase orders are often issued under framework contracts or blanket agreements. The existing contract_reference_number (STRING) is a denormalized reference that should be replaced with a proper FK. ',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor from whom materials or services are being procured. Links to vendor master data for supplier qualification, GMP certification, and quality agreement details.',
    `vendor_site_id` BIGINT COMMENT 'Reference to the specific vendor site or facility from which goods will be shipped. Critical for GMP-regulated materials where site-specific certifications and audit status must be verified.',
    `approval_date` DATE COMMENT 'Date when the purchase order was approved and released for vendor transmission. Nullable for draft or pending approval orders.',
    `approved_by_user` STRING COMMENT 'User ID of the manager or authorized approver who released the purchase order for transmission to vendor. Nullable for orders below approval threshold or still in draft status.',
    `batch_managed_flag` BOOLEAN COMMENT 'Boolean indicator whether materials on this purchase order require batch number tracking and Certificate of Analysis (CoA) documentation. True for all GMP materials and critical raw materials.',
    `cancellation_date` DATE COMMENT 'Date when the purchase order was cancelled before completion. Nullable for non-cancelled orders.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for purchase order cancellation. Examples: vendor unable to supply, project cancelled, duplicate order, pricing dispute. Nullable for non-cancelled orders.',
    `closed_date` DATE COMMENT 'Date when the purchase order was administratively closed after completion of all goods receipts, invoice matching, and payment processing. Nullable for open orders.',
    `confirmed_delivery_date` DATE COMMENT 'Date confirmed by the vendor for delivery of goods or completion of services. May differ from requested date based on vendor capacity and lead times. Nullable until vendor confirmation received.',
    `created_by_user` STRING COMMENT 'User ID of the procurement professional who created the purchase order document in SAP MM. Used for audit trail and workload analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this purchase order record was first created in the source system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this purchase order. Determines exchange rate application for multi-currency reporting.. Valid values are `^[A-Z]{3}$`',
    `delivery_address_line1` STRING COMMENT 'First line of the ship-to address where goods should be delivered. Typically contains street number and street name. May differ from plant address for direct-to-line deliveries.',
    `delivery_address_line2` STRING COMMENT 'Second line of the ship-to address for additional location details such as building name, floor, or department. Nullable if not required.',
    `delivery_city` STRING COMMENT 'City name for the delivery address. Used for logistics planning and freight cost calculation.',
    `delivery_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the delivery address. Critical for customs documentation, import/export compliance, and GDP requirements.. Valid values are `^[A-Z]{3}$`',
    `delivery_postal_code` STRING COMMENT 'Postal or ZIP code for the delivery address. Used for carrier routing and delivery time estimation.',
    `delivery_state_province` STRING COMMENT 'State, province, or region for the delivery address. Used for tax jurisdiction determination and regulatory compliance.',
    `freight_charges` DECIMAL(18,2) COMMENT 'Transportation and logistics costs associated with delivery of goods. May be vendor-charged or buyer-arranged depending on Incoterms. Nullable if freight is included in material price.',
    `gmp_relevant_flag` BOOLEAN COMMENT 'Boolean indicator whether this purchase order is for GMP-regulated materials or services requiring enhanced quality controls, vendor qualification, and regulatory documentation. True for APIs, excipients, and primary packaging materials.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms code defining the division of costs and risks between buyer and seller for transportation and delivery. Governed by ICC Incoterms 2020 rules. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'Named place or port specified in the Incoterms agreement where risk and cost transfer occurs. Examples: Port of Shanghai, Vendor Warehouse Munich.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this purchase order record was last updated in the source system. Tracks changes to quantities, dates, pricing, or status throughout the order lifecycle.',
    `notes` STRING COMMENT 'Free-text field for additional instructions, special handling requirements, or internal comments. May include GMP documentation requirements, cold chain specifications, or vendor-specific delivery instructions.',
    `payment_terms_code` STRING COMMENT 'Four-character code defining payment conditions including due date calculation, cash discount periods, and discount percentages. Examples: Net 30, 2/10 Net 30.. Valid values are `^[A-Z0-9]{4}$`',
    `po_date` DATE COMMENT 'Date when the purchase order document was created in the system. Used as the baseline for lead time calculations and payment term start dates.',
    `po_number` STRING COMMENT 'Externally-known unique purchase order document number assigned by SAP MM system. Ten-digit numeric identifier used across procurement, receiving, and accounts payable processes.. Valid values are `^[0-9]{10}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order. Draft indicates not yet approved, released indicates approved and transmitted to vendor, partially/fully received tracks goods receipt progress, partially/fully invoiced tracks invoice matching status, closed indicates completed three-way match, cancelled indicates order termination. [ENUM-REF-CANDIDATE: draft|released|partially_received|fully_received|partially_invoiced|fully_invoiced|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of the purchase order document type. Standard for one-time procurement, blanket for long-term agreements with release schedules, contract for framework agreements, subcontracting for external processing, consignment for vendor-owned inventory, stock transfer for inter-plant movements.. Valid values are `standard|blanket|contract|subcontracting|consignment|stock_transfer`',
    `purchasing_group` STRING COMMENT 'Three-character code identifying the buyer or procurement team responsible for this purchase order. Used for workload distribution, performance tracking, and vendor communication routing.. Valid values are `^[A-Z0-9]{3}$`',
    `purchasing_organization` STRING COMMENT 'Four-character code identifying the organizational unit responsible for procurement activities. Determines approval authority, contract terms, and vendor relationships. Typically aligned to regional or business unit structure.. Valid values are `^[A-Z0-9]{4}$`',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Boolean indicator whether incoming goods must undergo quality inspection and release before use. Triggers creation of inspection lot in SAP QM upon goods receipt.',
    `requested_delivery_date` DATE COMMENT 'Date by which the buyer requests delivery of goods or completion of services. Used for production planning and vendor performance measurement.',
    `requisition_number` STRING COMMENT 'Reference to the internal purchase requisition document that originated this purchase order. Links procurement to demand planning and budget approval workflows.',
    `storage_location` STRING COMMENT 'Four-character code identifying the specific warehouse location, quarantine area, or storage zone within the plant where received materials will be placed. Used for inventory segregation and GMP compliance.. Valid values are `^[A-Z0-9]{4}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount calculated for the purchase order based on tax jurisdiction, material tax classification, and vendor tax status. Nullable for tax-exempt transactions.',
    `total_order_value` DECIMAL(18,2) COMMENT 'Total monetary value of the purchase order including all line items, before taxes and freight charges. Expressed in the currency specified in currency_code. Used for budget tracking and vendor spend analysis.',
    `total_po_value` DECIMAL(18,2) COMMENT 'Grand total of the purchase order including line item values, taxes, and freight charges. Represents the complete financial commitment to the vendor.',
    `vendor_acknowledgement_date` DATE COMMENT 'Date when the vendor confirmed receipt and acceptance of the purchase order. Nullable until vendor confirmation received via EDI or portal.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Legally binding purchase orders issued to vendors for supply of raw materials (APIs, excipients), packaging materials, laboratory supplies, and services. Captures complete PO document including header (PO number, type, vendor, plant, delivery address, dates, payment terms, incoterms, total value, currency, GMP-relevant flag, status), all line items (material, quantities ordered/confirmed/delivered/invoiced, pricing, storage location, batch management flag), and delivery schedule lines for blanket orders and scheduling agreements. Core transactional entity in SAP MM (ME21N/ME22N). Supports three-way matching with goods_receipt and vendor_invoice.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` (
    `po_line_item_id` BIGINT COMMENT 'Unique identifier for the purchase order line item. Primary key.',
    `material_id` BIGINT COMMENT 'Foreign key reference to the material master record. Identifies the specific material, API, excipient, packaging component, or laboratory reagent being procured on this line.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: PO line items specify plant for MRP integration, goods receipt processing, and inventory valuation. Plant master provides storage location assignment and quality inspection requirements for pharmaceut',
    `purchase_order_id` BIGINT COMMENT 'Foreign key reference to the parent purchase order header. Links this line item to its containing purchase order document.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to masterdata.storage_location. Business justification: PO line items specify storage location for goods receipt posting and inventory placement. Storage location master provides GMP zone, temperature control, and DEA license for pharmaceutical material ha',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: PO line item UOM must reference UOM master for conversion to base UOM, inventory posting, and three-way match. UOM master provides ISO codes and conversion factors for pharmaceutical procurement.',
    `account_assignment_category` STRING COMMENT 'Defines how the line item cost is assigned in financial accounting. K=Cost Center, F=Order, A=Asset, P=Project, N=Network, Q=Quality. Determines GL account posting and cost allocation.. Valid values are `K|F|A|P|N|Q`',
    `batch_management_flag` BOOLEAN COMMENT 'Indicates whether this material requires batch number tracking at goods receipt. True for APIs, excipients, and other GMP-critical materials requiring lot traceability.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'The quantity confirmed by the supplier for delivery. May differ from ordered quantity due to supplier capacity constraints or order modifications.',
    `cost_center` STRING COMMENT 'The cost center to which this line item expenditure is charged. Used for departmental cost allocation and financial reporting when account assignment category is K (Cost Center).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line item record was first created in the system. Used for audit trail and procurement cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the line item pricing (e.g., USD, EUR, GBP, JPY). Determines the currency for net price, total value, and payment processing.. Valid values are `^[A-Z]{3}$`',
    `deletion_indicator` BOOLEAN COMMENT 'Indicates whether this line item has been marked for deletion. Deleted line items are excluded from delivery schedules and supplier communications but retained for audit trail.',
    `delivered_quantity` DECIMAL(18,2) COMMENT 'The cumulative quantity that has been physically received and goods-receipted against this line item. Updated with each goods receipt transaction.',
    `delivery_date` DATE COMMENT 'The requested or confirmed delivery date for this line item. Used for production planning, inventory management, and supplier on-time delivery performance tracking.',
    `gl_account` STRING COMMENT 'The general ledger account number to which this line item cost is posted. Determines the financial statement classification (COGS, R&D expense, capital expenditure, etc.).',
    `gmp_relevant_flag` BOOLEAN COMMENT 'Indicates whether this line item is subject to GMP regulations and requires enhanced quality documentation, supplier qualification, and Certificate of Analysis (CoA) at receipt. True for materials used in drug substance or drug product manufacturing.',
    `goods_receipt_flag` BOOLEAN COMMENT 'Indicates whether a goods receipt transaction is required for this line item. Typically true for materials, false for services or non-stock items.',
    `incoterms` STRING COMMENT 'International Commercial Terms code defining the delivery terms and transfer of risk between buyer and supplier (e.g., EXW, FOB, CIF, DDP). May be specified at line level to override header-level incoterms.',
    `invoice_receipt_flag` BOOLEAN COMMENT 'Indicates whether an invoice is expected for this line item. Controls invoice verification process and three-way match requirements in accounts payable.',
    `invoiced_quantity` DECIMAL(18,2) COMMENT 'The cumulative quantity that has been invoiced by the supplier. Used for three-way match validation (PO vs. goods receipt vs. invoice) in accounts payable processing.',
    `item_category` STRING COMMENT 'The procurement item category that determines the business process flow (standard purchase, consignment, subcontracting, service procurement, etc.). Controls goods receipt, invoice verification, and inventory management behavior.. Valid values are `Standard|Consignment|Subcontracting|Service|Stock Transfer|Third-Party`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line item record was last modified. Tracks changes to quantities, prices, delivery dates, or other line item attributes for audit and compliance purposes.',
    `line_item_number` STRING COMMENT 'Sequential line item number within the purchase order. Determines the ordering and display sequence of line items in the PO document.',
    `line_item_status` STRING COMMENT 'Current lifecycle status of the purchase order line item. Tracks progression from order placement through delivery, invoicing, and closure. Used for procurement analytics and supplier performance monitoring.. Valid values are `Open|Partially Delivered|Fully Delivered|Invoiced|Closed|Cancelled`',
    `material_description` STRING COMMENT 'Short text description of the material being procured. Provides human-readable context for the line item in procurement documents and reports.',
    `material_group` STRING COMMENT 'Material group code for procurement categorization and reporting. Used for spend analysis, supplier segmentation, and strategic sourcing decisions.',
    `material_type` STRING COMMENT 'Classification of the material being procured. Distinguishes between Active Pharmaceutical Ingredients (APIs), excipients, packaging materials, laboratory supplies, services, and other procurement categories. Critical for GMP compliance tracking and spend analysis. [ENUM-REF-CANDIDATE: API|Excipient|Packaging Material|Laboratory Reagent|Laboratory Equipment|Service|Raw Material|Finished Product|Semi-Finished Product — 9 candidates stripped; promote to reference product]',
    `net_price` DECIMAL(18,2) COMMENT 'The negotiated price per unit of measure, excluding taxes and additional charges. Basis for line item value calculation and supplier price variance analysis.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity of material or service ordered on this line item. Represents the original purchase order commitment to the supplier.',
    `price_unit` STRING COMMENT 'The quantity unit to which the net price applies (e.g., price per 1, per 10, per 100 units). Used to calculate the effective unit price when suppliers quote prices for bulk quantities.',
    `quality_inspection_flag` BOOLEAN COMMENT 'Indicates whether incoming goods receipt requires quality inspection and release before use. True for GMP-critical materials, APIs, and materials subject to supplier quality agreements.',
    `short_text` STRING COMMENT 'Additional short text description or notes for this line item. Provides supplementary information beyond the standard material description, such as special handling instructions or supplier-specific details.',
    `tax_code` STRING COMMENT 'The tax jurisdiction code applied to this line item. Determines VAT, GST, or sales tax calculation based on supplier location, delivery destination, and material tax classification.',
    `total_line_value` DECIMAL(18,2) COMMENT 'The total monetary value of this line item, calculated as (ordered_quantity / price_unit) * net_price. Represents the financial commitment for this line before taxes and additional charges.',
    CONSTRAINT pk_po_line_item PRIMARY KEY(`po_line_item_id`)
) COMMENT 'Individual line items within a purchase order, each representing a distinct material or service being procured. Captures line item number, material number (SAP material master), material description, material type (API, excipient, packaging, laboratory reagent, service), ordered quantity, unit of measure, confirmed quantity, delivered quantity, invoiced quantity, net price, total line value, storage location, batch management flag, GMP-relevant flag, and delivery schedule. Enables granular tracking of multi-material POs.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Unique identifier for the goods receipt transaction. Primary key for the goods receipt record.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Received materials consumed in specific manufacturing batches. Critical for material genealogy, lot traceability, recall management, and regulatory compliance (21 CFR Part 11). Enables forward/backwar',
    `inventory_lot_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_lot. Business justification: Pharmaceutical goods receipt creates inventory lot upon material receipt and QC release. Essential for lot traceability, batch genealogy, and GDP compliance tracking from procurement through supply ch',
    `material_id` BIGINT COMMENT 'Identifier of the material being received. Links to material master data for specifications, classification, and regulatory information.',
    `po_line_item_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line_item. Business justification: Goods receipts are recorded against specific PO line items, not just the header. The existing po_line_item_number (INT) is a denormalized reference that should be replaced with a proper FK. This enabl',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this goods receipt is posted. Links the receipt to the original procurement request.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Goods receipts post to plant for inventory management, quality inspection lot creation, and material valuation. Plant master provides LIMS integration and GMP certification for pharmaceutical goods re',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to masterdata.storage_location. Business justification: Goods receipts post to storage location for inventory placement and quarantine management. Storage location master provides temperature control, GMP zone, and capacity for pharmaceutical material rece',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: Goods receipt quantity UOM for inventory posting and three-way match with PO and invoice. UOM master provides conversion to base UOM for pharmaceutical inventory management.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor who supplied the materials. Links to vendor master data for supplier information and qualification status.',
    `coa_document_number` STRING COMMENT 'Reference number of the Certificate of Analysis document provided by the vendor. Used for linking quality documentation to received materials.',
    `coa_received_flag` BOOLEAN COMMENT 'Indicates whether the Certificate of Analysis has been received from the vendor. CoA is mandatory for pharmaceutical materials to verify quality specifications and compliance with Drug Master File (DMF) requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the goods receipt record was first created in the data platform. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the valuation amount. Typically the company currency for inventory valuation purposes.. Valid values are `^[A-Z]{3}$`',
    `delivery_note_number` STRING COMMENT 'External delivery note or packing slip number provided by the vendor. Used for cross-referencing shipment documentation and vendor records.',
    `document_date` DATE COMMENT 'Date on the delivery note or shipping document. May differ from posting date and is used for reconciliation with vendor documentation.',
    `expiry_date` DATE COMMENT 'Expiration or retest date of the received material as indicated on the vendor label or Certificate of Analysis. Critical for shelf-life management and First-Expired-First-Out (FEFO) inventory control in pharmaceutical operations.',
    `gr_status` STRING COMMENT 'Current status of the goods receipt transaction. Tracks the lifecycle from initial posting through quality inspection and potential reversal or cancellation.. Valid values are `posted|reversed|cancelled|pending_inspection`',
    `inspection_lot_number` STRING COMMENT 'Quality inspection lot number generated in SAP QM module when goods receipt triggers quality inspection. Links the receipt to quality control testing and approval workflow.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the goods receipt record was last updated. Supports change tracking and audit compliance in regulated pharmaceutical environments.',
    `manufacturing_date` DATE COMMENT 'Date when the material was manufactured by the vendor. Used for shelf-life calculation and stability monitoring of Active Pharmaceutical Ingredients (APIs) and excipients.',
    `material_document_number` STRING COMMENT 'SAP material document number generated during goods receipt posting (MIGO transaction). Serves as the official system reference for inventory movement.. Valid values are `^[0-9]{10}$`',
    `material_document_year` STRING COMMENT 'Fiscal year in which the material document was posted. Used in combination with material document number for unique identification in SAP.',
    `movement_type` STRING COMMENT 'SAP movement type code that classifies the type of goods receipt transaction (e.g., 101 for GR against PO, 501 for transfer posting). Determines accounting entries and inventory impact.. Valid values are `^[0-9]{3}$`',
    `packaging_condition` STRING COMMENT 'Assessment of the physical condition of packaging upon receipt. Damaged or tampered packaging may trigger quality investigation and material rejection per GDP requirements.. Valid values are `intact|damaged|partial_damage|tampered|acceptable_with_notes`',
    `packaging_condition_notes` STRING COMMENT 'Free-text notes describing any packaging damage, discrepancies, or observations made during receipt inspection. Supports quality investigations and vendor performance evaluation.',
    `posting_date` DATE COMMENT 'Date when the goods receipt was posted in the system. Determines the accounting period for inventory valuation and financial reporting.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether the received material requires quality inspection before release to unrestricted stock. Determined by material master settings and vendor qualification status.',
    `quantity_variance` DECIMAL(18,2) COMMENT 'Difference between the received quantity and the purchase order quantity. Positive values indicate over-delivery; negative values indicate under-delivery. Triggers procurement follow-up and invoice reconciliation.',
    `received_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of material physically received and accepted at the receiving location. Used for inventory posting and variance analysis against purchase order quantity.',
    `receiving_person_name` STRING COMMENT 'Name of the warehouse or laboratory personnel who physically received and verified the materials. Used for accountability and audit trail in GMP environments.',
    `receiving_timestamp` TIMESTAMP COMMENT 'Date and time when the materials were physically received at the facility. Distinct from posting date; used for lead time analysis and cold-chain monitoring.',
    `remarks` STRING COMMENT 'Additional comments or observations recorded during goods receipt. May include special handling instructions, deviations from standard procedures, or notes for quality assurance review.',
    `stock_type` STRING COMMENT 'Classification of the received stock based on quality status. Unrestricted stock is available for use; quality inspection stock awaits QC clearance; blocked stock cannot be used; restricted stock has limited usage.. Valid values are `unrestricted|quality_inspection|blocked|restricted`',
    `temperature_excursion_flag` BOOLEAN COMMENT 'Indicates whether a temperature excursion was detected during shipment or receipt. Critical for cold-chain materials such as biologics, vaccines, and temperature-sensitive Active Pharmaceutical Ingredients (APIs).',
    `temperature_max_recorded` DECIMAL(18,2) COMMENT 'Maximum temperature recorded during shipment or storage of cold-chain materials. Excursions beyond specified limits trigger quality investigation and potential material rejection.',
    `temperature_min_recorded` DECIMAL(18,2) COMMENT 'Minimum temperature recorded during shipment or storage of cold-chain materials. Used to verify compliance with storage conditions specified in the Drug Product (DP) or Drug Substance (DS) specifications.',
    `valuation_amount` DECIMAL(18,2) COMMENT 'Total inventory value of the received goods in the company currency. Calculated as received quantity multiplied by material standard price or moving average price. Posted to inventory and accounts payable.',
    `vendor_batch_number` STRING COMMENT 'Batch or lot number assigned by the vendor to the received materials. Critical for traceability, quality control, and pharmacovigilance in pharmaceutical manufacturing.',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Records of physical receipt of materials against purchase orders at manufacturing plants, warehouses, or laboratories. Captures goods receipt document number, posting date, delivery note number, vendor batch number, received quantity, unit of measure, storage location, receiving plant, GR status (unrestricted, quality inspection, blocked), CoA received flag, temperature excursion flag (for cold-chain materials), and SAP material document reference (MIGO). Triggers quality inspection and inventory posting in SAP MM/QM.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` (
    `incoming_inspection_id` BIGINT COMMENT 'Unique identifier for the incoming inspection record. Primary key for this entity.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Incoming inspections are performed on materials that have been physically received. The business flow is: goods receipt → incoming inspection → disposition decision. This FK links the inspection recor',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: GMP regulations require full traceability of who performed incoming inspections for APIs/excipients. Essential for deviation investigations, training effectiveness analysis, regulatory audits, and ins',
    `internal_control_id` BIGINT COMMENT 'Foreign key linking to compliance.internal_control. Business justification: Incoming material inspections are key quality controls that may be part of SOX internal control frameworks (inventory valuation) or GxP control frameworks (material qualification). This link enables c',
    `inventory_lot_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_lot. Business justification: Incoming inspection results determine inventory lot release status and disposition. Critical for GMP compliance, CoA verification, and linking quality test results to specific lots available for suppl',
    `material_id` BIGINT COMMENT 'Reference to the material master record being inspected (API, excipient, packaging material, or laboratory supply).',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order under which the material was procured.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to masterdata.storage_location. Business justification: Inspection lots are assigned to quarantine storage locations for GMP compliance. Storage location master provides quarantine zone flag, temperature monitoring, and segregation requirements for pharmac',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor who supplied the incoming material.',
    `assay_result_unit` STRING COMMENT 'Unit of measure for the assay result (e.g., %, mg/g, IU/mg).',
    `assay_result_value` DECIMAL(18,2) COMMENT 'Quantitative assay result indicating the purity or potency of the material, typically expressed as a percentage.',
    `assay_specification_max` DECIMAL(18,2) COMMENT 'Maximum acceptable assay value per the approved material specification.',
    `assay_specification_min` DECIMAL(18,2) COMMENT 'Minimum acceptable assay value per the approved material specification.',
    `coa_received_flag` BOOLEAN COMMENT 'Indicates whether a Certificate of Analysis was received from the vendor with the material shipment.',
    `coa_review_date` DATE COMMENT 'Date when the Certificate of Analysis review was completed by the quality control team.',
    `coa_review_status` STRING COMMENT 'Status of the quality review of the vendor-supplied Certificate of Analysis: not started, in review, approved, or rejected.. Valid values are `not_started|in_review|approved|rejected`',
    `comments` STRING COMMENT 'Free-text field for additional observations, deviations, or notes recorded during the incoming inspection process.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the incoming inspection record was first created in the system.',
    `disposition_reason` STRING COMMENT 'Detailed reason for the inspection decision, especially for rejected or conditionally released materials (e.g., OOS assay, failed identity, CoA discrepancy).',
    `expiry_date` DATE COMMENT 'Vendor-stated expiration or use-by date for the incoming material batch.',
    `identity_test_result` STRING COMMENT 'Result of the identity test confirming the material is what it is claimed to be (pass, fail, or not tested).. Valid values are `pass|fail|not_tested`',
    `impurity_profile_result` STRING COMMENT 'Overall result of impurity testing indicating whether all individual and total impurities are within specification limits.. Valid values are `within_limits|out_of_specification|not_tested`',
    `inspection_completion_date` DATE COMMENT 'Date when all inspection testing and Certificate of Analysis (CoA) review were completed and final decision was recorded.',
    `inspection_decision` STRING COMMENT 'Final quality decision for the incoming material: approved for use, rejected, or conditionally released pending further evaluation.. Valid values are `approved|rejected|conditionally_released`',
    `inspection_lot_number` STRING COMMENT 'Unique inspection lot number assigned by SAP QM for tracking and traceability of the inspection batch.',
    `inspection_start_date` DATE COMMENT 'Date when the incoming inspection activities commenced in the quality control laboratory.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection: pending initiation, in progress, completed, or cancelled.. Valid values are `pending|in_progress|completed|cancelled`',
    `inspection_type` STRING COMMENT 'Type of inspection sampling plan applied: normal, reduced, tightened, or skip-lot per statistical sampling strategy and vendor performance history.. Valid values are `normal|reduced|tightened|skip_lot`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the incoming inspection record was last updated or modified.',
    `material_batch_number` STRING COMMENT 'Vendor-supplied batch or lot number of the incoming material as stated on the Certificate of Analysis (CoA).',
    `microbiological_test_result` STRING COMMENT 'Result of microbiological testing (total aerobic count, yeast/mold, pathogens) if applicable to the material type.. Valid values are `pass|fail|not_applicable`',
    `quantity_received` DECIMAL(18,2) COMMENT 'Total quantity of material received in the shipment, expressed in the materials base unit of measure.',
    `receipt_date` DATE COMMENT 'Date the material was physically received at the facility warehouse or quarantine area.',
    `retest_date` DATE COMMENT 'Date by which the material must be retested to confirm continued compliance with specifications.',
    `reviewer_name` STRING COMMENT 'Name of the quality assurance reviewer who approved the final inspection decision.',
    `samples_drawn_count` STRING COMMENT 'Number of samples drawn from the incoming material lot for testing per the approved sampling plan.',
    `test_methods_applied` STRING COMMENT 'Comma-separated list of compendial or validated test methods applied during inspection (e.g., USP <621>, EP 2.2.1, JP 17).',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the received quantity (e.g., kg, L, EA, m2).',
    CONSTRAINT pk_incoming_inspection PRIMARY KEY(`incoming_inspection_id`)
) COMMENT 'Quality inspection records for incoming materials received from vendors, covering API, excipient, packaging, and laboratory supply receipts. Captures inspection lot number (SAP QM), inspection type (skip-lot, reduced, normal, tightened per sampling plan), material batch number, inspection start and completion dates, number of samples drawn, test methods applied (USP, EP, JP compendial), CoA review status, identity test result, assay result, impurity profile, microbiological test result, overall inspection decision (approved, rejected, conditionally released), and disposition reason. Supports 21 CFR 211.84 incoming material testing and ICH Q7 Section 7 requirements. Triggers material release or rejection workflow.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` (
    `vendor_invoice_id` BIGINT COMMENT 'Unique identifier for the vendor invoice record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: SOX controls and pharma audit requirements mandate tracking who approved invoices for payment, especially high-value API/CMO invoices. Critical for segregation of duties validation, fraud prevention, ',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Three-way matching requires linking invoice to goods receipt. The existing goods_receipt_number (STRING) is a denormalized reference that should be replaced with a proper FK. This enables automated ve',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Vendor invoices post to legal entity for financial accounting, tax determination, and payment processing. Legal entity master provides company code, tax ID, and currency for pharmaceutical accounts pa',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Vendor invoices must reference the purchase order for three-way matching (PO → GR → Invoice). The existing purchase_order_number (STRING) is a denormalized reference that should be replaced with a pro',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor who issued this invoice. Links to vendor master data.',
    `vendor_site_id` BIGINT COMMENT 'Reference to the specific vendor site that issued this invoice. Links to vendor site master data.',
    `approval_status` STRING COMMENT 'Current approval status in the invoice approval workflow: pending approval, approved, rejected, or escalated to higher authority.. Valid values are `pending|approved|rejected|escalated`',
    `approved_timestamp` TIMESTAMP COMMENT 'The timestamp when the invoice was approved for payment.',
    `baseline_date` DATE COMMENT 'The baseline date used for calculating payment due date and discount periods per payment terms.',
    `blocked_for_payment_flag` BOOLEAN COMMENT 'Indicates whether the invoice is blocked for payment pending resolution of issues (e.g., pricing dispute, quality issue, missing documentation).',
    `cost_center` STRING COMMENT 'The cost center to which the invoice amount is charged for internal cost accounting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the invoice (e.g., early payment discount, volume discount).',
    `document_date` DATE COMMENT 'The document date used for accounting purposes. May differ from invoice date for period-end adjustments.',
    `due_date` DATE COMMENT 'The date by which payment is due to the vendor per the payment terms.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year to which this invoice is assigned.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this invoice is assigned for financial reporting and period closing.',
    `gl_account` STRING COMMENT 'The general ledger account code to which the invoice is posted for financial reporting.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total gross amount of the invoice before tax and discounts. Sum of all line item amounts.',
    `invoice_date` DATE COMMENT 'The date the invoice was issued by the vendor. This is the principal business event timestamp for the invoice.',
    `invoice_description` STRING COMMENT 'Free-text description or notes about the invoice. May include vendor comments or special instructions.',
    `invoice_number` STRING COMMENT 'The unique invoice number assigned by the vendor. This is the externally-known business identifier for the invoice document.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the accounts payable workflow: draft, pending three-way match, matched, approved, posted to GL, paid, cancelled, or on hold. [ENUM-REF-CANDIDATE: draft|pending_match|matched|approved|posted|paid|cancelled|on_hold — 8 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'The type of invoice document: standard invoice, credit memo (vendor refund), debit memo (additional charges), prepayment, or down payment.. Valid values are `standard|credit_memo|debit_memo|prepayment|down_payment`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was last modified or updated.',
    `match_status` STRING COMMENT 'Status of the three-way matching process (Purchase Order, Goods Receipt, Invoice): not matched, two-way matched (PO and invoice only), three-way matched (PO, GR, and invoice), exception (mismatch detected), or override (manual approval).. Valid values are `not_matched|two_way_matched|three_way_matched|exception|override`',
    `net_amount` DECIMAL(18,2) COMMENT 'Net payable amount after applying tax and discounts. This is the final amount due to the vendor.',
    `payment_block_reason` STRING COMMENT 'The reason code or description for why the invoice is blocked for payment (e.g., price variance, quantity mismatch, quality hold).',
    `payment_date` DATE COMMENT 'The actual date payment was made to the vendor. Null if invoice is unpaid.',
    `payment_method` STRING COMMENT 'The method by which payment will be made to the vendor: wire transfer, check, ACH, credit card, or electronic payment.. Valid values are `wire_transfer|check|ach|credit_card|electronic_payment`',
    `payment_reference_number` STRING COMMENT 'The payment reference number or transaction ID when the invoice has been paid. Links to payment document.',
    `payment_terms_code` STRING COMMENT 'The payment terms code defining the payment schedule and discount conditions (e.g., Net 30, 2/10 Net 30).',
    `plant_code` STRING COMMENT 'The manufacturing plant or facility code where the goods or services were received.',
    `posting_date` DATE COMMENT 'The date the invoice was posted to the financial ledger in SAP FI. Used for accounting period assignment.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount charged on the invoice. Includes VAT, GST, sales tax, or other applicable taxes.',
    `tax_code` STRING COMMENT 'Tax code used for tax calculation and reporting (e.g., VAT code, GST code, sales tax jurisdiction code).',
    `wbs_element` STRING COMMENT 'The WBS element (project code) to which the invoice is assigned for project accounting and tracking.',
    CONSTRAINT pk_vendor_invoice PRIMARY KEY(`vendor_invoice_id`)
) COMMENT 'Vendor invoices received for goods and services procured, processed through three-way matching (PO, GR, invoice) in SAP MM/FI. Captures complete invoice document including header (invoice number, dates, total amount, currency, tax, payment terms, match status, approval status) and all line items (material/service, quantities, unit prices, PO/GR references, tax codes, account assignments including cost center, WBS element, G/L account, and line-level match status). Enables granular three-way matching and spend analytics at both document and line level for AP processing and COGS reporting.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` (
    `invoice_line_item_id` BIGINT COMMENT 'Unique identifier for the invoice line item. Primary key.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to masterdata.chart_of_accounts. Business justification: Invoice lines post to GL accounts for financial reporting and IFRS/GAAP compliance. Chart of accounts master provides account type, financial statement classification, and R&D capitalization rules for',
    `goods_receipt_id` BIGINT COMMENT 'Reference to the goods receipt document for three-way match validation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Invoice lines charge to cost centers for expense allocation and budget tracking. Cost center master provides GL account assignment, profit center, and SOX controls for pharmaceutical financial account',
    `material_id` BIGINT COMMENT 'Reference to the material master record for the invoiced item (API, excipient, packaging material, or laboratory supply).',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Invoice lines specify plant for inventory valuation and cost allocation. Plant master provides valuation area and cost center for pharmaceutical material accounting and standard cost calculation.',
    `po_line_item_id` BIGINT COMMENT 'Reference to the originating purchase order line item for three-way matching.',
    `service_entry_sheet_id` BIGINT COMMENT 'Reference to the service entry sheet for service-based invoice lines, used in CRO/CMO/CDMO engagements.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to masterdata.storage_location. Business justification: Invoice lines reference storage location for inventory accounting and three-way match with goods receipt. Storage location master provides inventory valuation and GMP zone for pharmaceutical material ',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: Invoice line UOM for three-way match with PO and goods receipt. UOM master provides conversion factors for pharmaceutical invoice verification and payment processing.',
    `vendor_invoice_id` BIGINT COMMENT 'Reference to the parent vendor invoice header document.',
    `batch_number` STRING COMMENT 'Batch or lot number of the material as stated on the invoice, critical for API and excipient traceability under GMP.',
    `coa_received_flag` BOOLEAN COMMENT 'Indicates whether a Certificate of Analysis has been received from the vendor for this material batch.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice line item record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this line.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to this invoice line, if any.',
    `expiry_date` DATE COMMENT 'Expiration or retest date of the material batch, critical for pharmaceutical materials under GMP and GDP.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which this invoice line is posted for financial reporting and compliance.',
    `gmp_material_flag` BOOLEAN COMMENT 'Indicates whether this line item is for a GMP-regulated material requiring enhanced quality and traceability controls.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total gross amount for the invoice line before taxes and discounts (quantity × unit price).',
    `internal_order` STRING COMMENT 'Internal order number for cost tracking and allocation, often used for campaign or initiative-specific spend.',
    `invoiced_quantity` DECIMAL(18,2) COMMENT 'Quantity of material or service units invoiced on this line.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice line item record was last modified or updated.',
    `line_number` STRING COMMENT 'Sequential line number within the invoice document, used for ordering and reference.',
    `line_type` STRING COMMENT 'Classification of the invoice line item indicating whether it represents material, service, freight, or miscellaneous charges.. Valid values are `material|service|freight|miscellaneous`',
    `match_status` STRING COMMENT 'Status of the three-way match between invoice line, PO line, and goods receipt (matched, variance, unmatched, or blocked).. Valid values are `matched|quantity_variance|price_variance|unmatched|blocked`',
    `material_description` STRING COMMENT 'Textual description of the material or service as stated on the invoice line.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount for the invoice line after discounts and including taxes (gross - discount + tax).',
    `payment_block_flag` BOOLEAN COMMENT 'Indicates whether this invoice line is blocked for payment pending resolution of variances or quality issues.',
    `payment_block_reason` STRING COMMENT 'Reason for payment block, if applicable (e.g., price variance, missing CoA, quality hold).',
    `posted_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice line was posted to the general ledger for financial accounting.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether the material on this line requires quality inspection before invoice approval and payment release.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount calculated for this invoice line based on the tax code.',
    `tax_code` STRING COMMENT 'Tax jurisdiction code applied to this invoice line for VAT, GST, or sales tax calculation.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of measure as stated on the invoice line.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Monetary variance between the invoice line and the PO/GR, if any, requiring resolution or approval.',
    `variance_reason_code` STRING COMMENT 'Code indicating the reason for any match variance (e.g., price difference, quantity difference, freight adjustment).',
    `wbs_element` STRING COMMENT 'Project WBS element for project-based procurement, used in clinical trial or R&D project accounting.',
    CONSTRAINT pk_invoice_line_item PRIMARY KEY(`invoice_line_item_id`)
) COMMENT 'Individual line items on a vendor invoice, each corresponding to a PO line item or service entry sheet. Captures invoice line number, material or service description, invoiced quantity, unit of measure, unit price, line total, PO reference line, GR reference, tax code, account assignment (cost center, WBS element, G/L account), and match status. Enables granular three-way matching and spend analytics at the material and cost center level.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` (
    `vendor_performance_id` BIGINT COMMENT 'Unique identifier for the vendor performance record. Primary key for the vendor performance scorecard.',
    `monitoring_activity_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_monitoring_activity. Business justification: Vendor performance evaluations are compliance monitoring activities under supplier oversight programs. This link enables integration of supplier scorecards into compliance program reporting, risk-base',
    `vendor_id` BIGINT COMMENT 'Reference to the qualified vendor being evaluated. Links to the vendor master data.',
    `vendor_site_id` BIGINT COMMENT 'Reference to the specific vendor site being evaluated. Links to vendor site master data for site-level performance tracking.',
    `audit_score` DECIMAL(18,2) COMMENT 'Most recent GMP audit score for the vendor site. Typically scored on a 0-100 scale based on audit findings and compliance observations.',
    `average_lead_time_days` DECIMAL(18,2) COMMENT 'Average lead time in days from purchase order issuance to goods receipt during the evaluation period. Key supply chain planning metric.',
    `capa_closure_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of CAPA actions assigned to the vendor that were closed on time during the evaluation period. Measures vendor commitment to continuous improvement.',
    `coa_compliance_percentage` DECIMAL(18,2) COMMENT 'Percentage of shipments with compliant Certificate of Analysis documentation meeting GMP and quality requirements.',
    `comments` STRING COMMENT 'Free-text comments and observations from the evaluator. Captures qualitative insights, improvement recommendations, and context for performance ratings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor performance record was first created in the system. Supports audit trail and data lineage.',
    `critical_findings_count` STRING COMMENT 'Number of critical audit findings or observations identified during GMP audits in the evaluation period. Critical findings may trigger re-qualification or disqualification.',
    `deviation_attribution_count` STRING COMMENT 'Number of manufacturing or quality deviations attributed to vendor-supplied materials or services during the evaluation period.',
    `documentation_accuracy_percentage` DECIMAL(18,2) COMMENT 'Percentage of shipments with complete and accurate documentation including CoA, packing lists, and regulatory certificates during the evaluation period.',
    `evaluation_completion_date` DATE COMMENT 'Date when the performance evaluation and scorecard were finalized and approved.',
    `evaluation_period_end_date` DATE COMMENT 'End date of the performance evaluation period. Defines the close of the measurement window for KPI calculation.',
    `evaluation_period_start_date` DATE COMMENT 'Start date of the performance evaluation period. Defines the beginning of the measurement window for KPI calculation.',
    `evaluator_name` STRING COMMENT 'Name of the procurement or quality professional who completed the performance evaluation and scorecard.',
    `evaluator_role` STRING COMMENT 'Role or title of the evaluator. Typically procurement manager, quality assurance manager, or supplier quality engineer.',
    `financial_claims_amount` DECIMAL(18,2) COMMENT 'Total monetary value of financial claims filed against the vendor for quality issues, delivery failures, or contract breaches during the evaluation period. Expressed in the vendors payment currency.',
    `in_full_delivery_percentage` DECIMAL(18,2) COMMENT 'Percentage of deliveries that met the full ordered quantity during the evaluation period. Component of OTIF metric.',
    `last_audit_date` DATE COMMENT 'Date of the most recent GMP or quality audit conducted at the vendor site.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor performance record was last updated. Supports audit trail and change tracking.',
    `major_findings_count` STRING COMMENT 'Number of major audit findings or observations identified during GMP audits in the evaluation period. Major findings require CAPA but do not immediately disqualify.',
    `minor_findings_count` STRING COMMENT 'Number of minor audit findings or observations identified during GMP audits in the evaluation period. Minor findings are opportunities for improvement.',
    `non_conformance_count` STRING COMMENT 'Total number of non-conformance records raised against the vendor during the evaluation period. Includes quality, delivery, and documentation non-conformances.',
    `on_time_delivery_percentage` DECIMAL(18,2) COMMENT 'Percentage of deliveries that arrived on or before the requested delivery date during the evaluation period. Component of OTIF metric.',
    `otif_percentage` DECIMAL(18,2) COMMENT 'Percentage of deliveries that arrived on time and in full during the evaluation period. Key supply chain performance metric.',
    `overall_performance_rating` STRING COMMENT 'Composite overall performance rating based on weighted KPIs. Determines vendor tier status and re-qualification triggers.. Valid values are `preferred|approved|conditional|probation|disqualified`',
    `performance_trend` STRING COMMENT 'Directional trend of vendor performance compared to previous evaluation periods. Supports strategic supplier relationship management decisions.. Valid values are `improving|stable|declining`',
    `quality_complaints_count` STRING COMMENT 'Total number of quality complaints raised against the vendor during the evaluation period. Includes OOS, foreign matter, mislabeling, and other quality issues.',
    `re_qualification_required_flag` BOOLEAN COMMENT 'Indicates whether vendor re-qualification is triggered based on performance thresholds. True if performance falls below acceptable levels requiring formal re-qualification process.',
    `rejected_lots_count` STRING COMMENT 'Number of material lots or batches rejected during incoming inspection or quality control during the evaluation period.',
    `responsiveness_rating` STRING COMMENT 'Qualitative rating of vendor responsiveness to inquiries, change requests, and issue resolution. Assessed by procurement and quality teams.. Valid values are `excellent|good|satisfactory|needs_improvement|poor`',
    `scorecard_type` STRING COMMENT 'Type of performance scorecard. Indicates the frequency and purpose of the evaluation cycle.. Valid values are `monthly|quarterly|annual|ad_hoc`',
    `spend_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the total spend amount. Indicates the currency in which vendor transactions are denominated.. Valid values are `^[A-Z]{3}$`',
    `temperature_excursion_count` STRING COMMENT 'Number of shipments with documented temperature excursions outside specified storage and transport conditions during the evaluation period. Critical for temperature-sensitive APIs and biologics.',
    `total_purchase_orders_count` STRING COMMENT 'Total number of purchase orders issued to the vendor during the evaluation period. Provides context for performance metrics.',
    `total_spend_amount` DECIMAL(18,2) COMMENT 'Total monetary value of purchases from the vendor during the evaluation period. Expressed in the vendors payment currency.',
    CONSTRAINT pk_vendor_performance PRIMARY KEY(`vendor_performance_id`)
) COMMENT 'Periodic supplier performance scorecards, KPI tracking, quality complaints, and non-conformance records for qualified vendors. Captures performance metrics (OTIF, CoA compliance, quality complaints count, deviation attribution, audit scores, responsiveness, CAPA closure rate, overall rating, trend), and detailed complaint/non-conformance records (type including OOS result/foreign matter/mislabelling/documentation error/delivery damage/temperature excursion, affected material/batch, severity, dates, root cause, corrective action, resolution status, financial claims). Supports strategic supplier relationship management, re-qualification triggers, and continuous improvement programs.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` (
    `vendor_complaint_id` BIGINT COMMENT 'Unique identifier for the vendor complaint record. Primary key.',
    `inventory_lot_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_lot. Business justification: Vendor complaints reference specific received inventory lots with quality defects. Essential for CAPA tracking, lot quarantine decisions, and linking supplier quality issues to affected supply chain i',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Quality complaints about vendor-supplied materials must trace to affected manufacturing batches for impact assessment, product disposition decisions, and regulatory reporting. Essential for quality ev',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Vendor complaints are frequently raised upon receipt of materials. The existing goods_receipt_number (STRING) is a denormalized reference that should be replaced with a proper FK to link complaints to',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Vendor quality complaints may trigger compliance incidents when they involve GxP deviations, regulatory reporting obligations, or patient safety risks. This link enables escalation workflows, regulato',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Vendor complaints are often tied to specific purchase orders. The existing purchase_order_number (STRING) is a denormalized reference that should be replaced with a proper FK to enable direct navigati',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor against whom the complaint is raised.',
    `vendor_site_id` BIGINT COMMENT 'Reference to the specific vendor site or facility associated with the complaint, if applicable.',
    `affected_batch_number` STRING COMMENT 'Batch or lot number of the affected material supplied by the vendor. Critical for traceability and potential recall actions.',
    `affected_material_code` STRING COMMENT 'Material number or Stock Keeping Unit (SKU) of the raw material, Active Pharmaceutical Ingredient (API), excipient, or packaging component that is the subject of the complaint.',
    `affected_material_description` STRING COMMENT 'Human-readable description of the affected material or service.',
    `capa_completion_date` DATE COMMENT 'Actual date when the vendor completed implementation of the corrective and preventive actions.',
    `capa_description` STRING COMMENT 'Description of the corrective and preventive actions committed by the vendor to address the root cause and prevent recurrence.',
    `capa_due_date` DATE COMMENT 'Target completion date for the vendor to implement the committed corrective and preventive actions.',
    `capa_required_flag` BOOLEAN COMMENT 'Indicates whether a formal Corrective and Preventive Action (CAPA) is required from the vendor to address the root cause and prevent recurrence.',
    `capa_verification_date` DATE COMMENT 'Date when the CAPA effectiveness was verified through follow-up audit, inspection, or testing.',
    `capa_verification_status` STRING COMMENT 'Status of the verification activity to confirm effectiveness of the vendor CAPA implementation.. Valid values are `pending|verified|not verified|partially verified`',
    `complaint_closure_date` DATE COMMENT 'Date when the complaint was formally closed after satisfactory resolution and CAPA verification.',
    `complaint_date` DATE COMMENT 'Date when the complaint was formally raised and logged in the Quality Management System (QMS).',
    `complaint_description` STRING COMMENT 'Detailed narrative description of the non-conformance, including observed defects, test results, and impact assessment.',
    `complaint_owner_email` STRING COMMENT 'Email address of the complaint owner for communication and escalation purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `complaint_owner_name` STRING COMMENT 'Name of the quality assurance or procurement professional responsible for managing the complaint through resolution.',
    `complaint_reference_number` STRING COMMENT 'Externally-known unique business identifier for the vendor complaint, used for tracking and communication with the vendor.. Valid values are `^VC-[0-9]{8}$`',
    `complaint_resolution_status` STRING COMMENT 'Final resolution outcome of the complaint indicating whether the vendor response and corrective actions were deemed satisfactory.. Valid values are `unresolved|resolved satisfactorily|resolved with conditions|unresolved escalated`',
    `complaint_severity` STRING COMMENT 'Severity classification of the complaint based on impact to product quality, patient safety, and regulatory compliance. Critical indicates immediate risk to patient safety or product integrity; major indicates significant quality impact; minor indicates low impact.. Valid values are `critical|major|minor`',
    `complaint_status` STRING COMMENT 'Current lifecycle status of the vendor complaint in the resolution workflow. [ENUM-REF-CANDIDATE: open|under investigation|awaiting vendor response|vendor response received|resolved|closed|escalated — 7 candidates stripped; promote to reference product]',
    `complaint_type` STRING COMMENT 'Classification of the complaint based on the nature of the non-conformance. Values include Out of Specification (OOS) result, foreign matter contamination, mislabelling, documentation error, delivery damage, or temperature excursion during transit.. Valid values are `OOS result|foreign matter|mislabelling|documentation error|delivery damage|temperature excursion`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor complaint record was first created in the system.',
    `detection_date` DATE COMMENT 'Date when the non-conformance was first detected or identified during receiving inspection, quality control testing, or production use.',
    `financial_claim_amount` DECIMAL(18,2) COMMENT 'Monetary value of the financial claim raised against the vendor for the non-conforming material or service, including material cost, rework cost, disposal cost, and any associated penalties.',
    `financial_claim_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial claim amount.. Valid values are `^[A-Z]{3}$`',
    `financial_claim_status` STRING COMMENT 'Status of the financial claim processing and settlement with the vendor.. Valid values are `not claimed|claimed|approved|rejected|partially approved|settled`',
    `impact_to_patient_safety` STRING COMMENT 'Assessment of the potential or actual risk to patient safety resulting from the non-conforming material or service.. Valid values are `none|low|medium|high|critical`',
    `impact_to_product_quality` STRING COMMENT 'Assessment of the potential or actual impact of the non-conformance on finished drug product quality and Critical Quality Attributes (CQA).. Valid values are `none|low|medium|high|critical`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor complaint record was last updated or modified.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether the complaint and associated non-conformance must be reported to regulatory authorities such as FDA, EMA, or other health authorities.',
    `root_cause_analysis` STRING COMMENT 'Detailed root cause analysis provided by the vendor, including investigation methodology, findings, and contributing factors.',
    `root_cause_category` STRING COMMENT 'High-level classification of the root cause identified by the vendor or internal investigation. [ENUM-REF-CANDIDATE: material defect|process deviation|equipment failure|human error|documentation error|contamination|storage condition|transportation issue|supplier change|unknown — 10 candidates stripped; promote to reference product]',
    `vendor_notification_date` DATE COMMENT 'Date when the vendor was formally notified of the complaint.',
    `vendor_response_date` DATE COMMENT 'Actual date when the vendor submitted their formal response to the complaint.',
    `vendor_response_due_date` DATE COMMENT 'Expected or contractual due date by which the vendor must provide a formal response including root cause analysis and corrective action plan.',
    CONSTRAINT pk_vendor_complaint PRIMARY KEY(`vendor_complaint_id`)
) COMMENT 'Formal quality complaints and non-conformance records raised against vendors for material or service failures. Captures complaint reference number, complaint type (OOS result, foreign matter, mislabelling, documentation error, delivery damage, temperature excursion), affected material and batch, complaint severity, complaint date, vendor notification date, vendor response date, root cause provided by vendor, corrective action committed, complaint resolution status, and financial claim amount if applicable. Feeds into vendor performance scoring and re-qualification triggers.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` (
    `approved_vendor_list_id` BIGINT COMMENT 'Unique identifier for the approved vendor list entry. Primary key for the AVL record representing a specific vendor-material-site combination approval.',
    `drug_substance_id` BIGINT COMMENT 'Foreign key linking to product.drug_substance. Business justification: AVL entries approve vendors for specific drug substances. FK enables automated compliance checking during purchase requisition approval, change control impact assessment (vendor changes), and regulato',
    `site_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_site. Business justification: AVL approvals are site-specific in pharma due to site-specific vendor qualifications, regulatory filings (DMFs, CEPs), and quality agreements. Tracks which vendors are qualified to supply which manufa',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor entity. Links to the master vendor record for the approved supplier.',
    `vendor_site_id` BIGINT COMMENT 'Reference to the specific vendor site entity. Links to the vendor site record representing the manufacturing or service location that is approved.',
    `alternate_vendor_available_flag` BOOLEAN COMMENT 'Indicates whether an alternate approved vendor exists for this material. Critical for supply chain risk management and business continuity.',
    `approval_date` DATE COMMENT 'Date when the vendor-material-site combination was officially approved for procurement. Represents the effective start of the approval.',
    `approval_expiry_date` DATE COMMENT 'Date when the current approval expires and re-qualification is required. Nullable for indefinite approvals subject to periodic review.',
    `approval_justification` STRING COMMENT 'Business and quality rationale for granting this AVL approval. Documents the basis for the qualification decision.',
    `approval_scope` STRING COMMENT 'Detailed scope of the approval including grade, batch size limits, therapeutic application, or other constraints. Defines the boundaries within which procurement is authorized.',
    `approval_status` STRING COMMENT 'Current lifecycle status of the vendor approval for this material-site combination. Determines whether procurement is authorized.. Valid values are `Approved|Conditionally Approved|Suspended|Delisted|Pending Qualification|Under Review`',
    `approved_by_name` STRING COMMENT 'Name of the quality or procurement authority who granted the AVL approval. Provides accountability for the approval decision.',
    `approved_by_title` STRING COMMENT 'Job title or role of the approving authority. Ensures appropriate authorization level for the approval.',
    `audit_frequency_months` STRING COMMENT 'Standard interval in months between quality audits for this vendor-material combination. Determined by risk classification.',
    `avl_number` STRING COMMENT 'Business identifier for the AVL entry. Externally-known unique code used in procurement documents and quality records to reference this approval.. Valid values are `^AVL-[A-Z0-9]{8,12}$`',
    `change_control_required_flag` BOOLEAN COMMENT 'Indicates whether changes to this vendor-material combination require formal change control and regulatory notification. True for GMP-critical materials.',
    `coa_required_flag` BOOLEAN COMMENT 'Indicates whether a Certificate of Analysis must accompany each shipment from this vendor. Mandatory for most GMP materials.',
    `comments` STRING COMMENT 'Additional notes, observations, or context regarding this AVL entry. Captures supplementary information not covered by structured fields.',
    `conditional_approval_conditions` STRING COMMENT 'Specific conditions or restrictions that apply when approval status is Conditionally Approved. Defines limitations on procurement until conditions are met.',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this AVL record. Provides accountability for record creation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this AVL record was first created in the system. Audit trail for record creation.',
    `delisting_date` DATE COMMENT 'Date when the vendor-material combination was permanently removed from the AVL. Marks the end of the approval lifecycle.',
    `delisting_reason` STRING COMMENT 'Reason for permanent removal from the Approved Vendor List. Documents the basis for terminating the vendor relationship.',
    `dmf_reference_number` STRING COMMENT 'Reference to the Drug Master File submitted to regulatory authorities for this material. Applicable for Active Pharmaceutical Ingredients (APIs) and excipients.. Valid values are `^DMF-[A-Z]{2,3}-[0-9]{5,8}$`',
    `gmp_grade_approved` STRING COMMENT 'The quality grade or compendial standard for which the vendor is approved to supply this material. Critical for regulatory compliance. [ENUM-REF-CANDIDATE: Pharmaceutical Grade|USP Grade|EP Grade|JP Grade|Technical Grade|Food Grade|Cosmetic Grade — 7 candidates stripped; promote to reference product]',
    `last_audit_date` DATE COMMENT 'Date of the most recent quality audit conducted at the vendor site for this material scope. Used to track audit currency.',
    `last_audit_outcome` STRING COMMENT 'Overall outcome or conclusion of the most recent vendor audit. Influences approval status and re-qualification decisions.. Valid values are `Acceptable|Acceptable with Observations|Conditional|Unacceptable`',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this AVL record. Provides accountability for record changes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this AVL record was last updated. Audit trail for record modifications.',
    `material_category` STRING COMMENT 'Classification of the material or service type covered by this approval. Defines the procurement category for which the vendor is qualified. [ENUM-REF-CANDIDATE: API|Excipient|Packaging Material|Laboratory Supply|Equipment|Service|Raw Material — 7 candidates stripped; promote to reference product]',
    `material_description` STRING COMMENT 'Detailed description of the specific material, component, or service covered by this AVL entry. Includes grade, specification, or scope details.',
    `material_specification_reference` STRING COMMENT 'Reference to the internal specification document or standard that defines the quality requirements for the material or service. Links to quality specifications in the Quality Management System (QMS).',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next quality audit of this vendor-material combination. Ensures ongoing compliance monitoring.',
    `next_requalification_due_date` DATE COMMENT 'Scheduled date for the next vendor re-qualification activity. Triggers quality audit and review processes to maintain AVL status.',
    `quality_agreement_reference` STRING COMMENT 'Reference number or identifier of the Supplier Quality Agreement (SQA) that governs this vendor-material relationship. Links to the contractual quality framework.',
    `regulatory_filing_reference` STRING COMMENT 'Reference to the regulatory submission (IND, NDA, BLA, MAA) where this vendor-material combination is documented. Links AVL to product registrations.',
    `requalification_frequency_months` STRING COMMENT 'Standard interval in months between re-qualification activities for this vendor-material combination. Defines the periodic review cycle.',
    `risk_classification` STRING COMMENT 'Risk-based classification of this vendor-material combination based on impact to product quality and patient safety. Drives audit frequency and oversight level.. Valid values are `Critical|High|Medium|Low`',
    `sole_source_flag` BOOLEAN COMMENT 'Indicates whether this is the only approved vendor for this material. Identifies single points of failure in the supply chain.',
    `suspension_date` DATE COMMENT 'Date when the AVL approval was suspended. Marks the effective date when procurement was halted.',
    `suspension_reason` STRING COMMENT 'Reason for suspension of the AVL approval. Documents quality issues, audit findings, or compliance concerns that led to suspension.',
    CONSTRAINT pk_approved_vendor_list PRIMARY KEY(`approved_vendor_list_id`)
) COMMENT 'The Approved Vendor List (AVL) — the authoritative register of vendors and vendor-material combinations that are qualified and approved for procurement of GMP-relevant materials and services. Captures material or service category, vendor, vendor site, approval status (approved, conditionally approved, suspended, delisted), approval date, next re-qualification due date, approval scope (e.g., API grade, excipient grade, packaging component), and quality system reference. Mandatory control under 21 CFR 211.84 and EU GMP Chapter 7.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` (
    `cro_cmo_engagement_id` BIGINT COMMENT 'Unique identifier for the CRO/CMO/CDMO engagement record. Primary key.',
    `affairs_plan_id` BIGINT COMMENT 'Foreign key linking to medical.medical_affairs_plan. Business justification: CRO/CMO engagements for clinical services, manufacturing, or research are strategically aligned with Medical Affairs plans for evidence generation, publication planning, and scientific platform develo',
    `application_id` BIGINT COMMENT 'Foreign key linking to regulatory.application. Business justification: CRO/CMO engagements support specific regulatory applications (manufacturing for NDA/BLA, clinical studies for IND). Pharma companies link vendor engagements to applications to track regulatory filing ',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: CMO engagements specify the drug product (formulation) being manufactured. FK enables technology transfer tracking, batch record reconciliation, quality agreement enforcement, regulatory filing coordi',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: CRO/CMO engagements must align with compliance programs (GCP for clinical CROs, GMP for manufacturing CMOs). This link enables oversight of third-party compliance obligations, audit planning, inspecti',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: CRO/CMO engagements deliver specific submission packages (eCTD modules, clinical study reports, manufacturing sections). Pharma companies link vendor engagements to submissions to track deliverable ti',
    `supply_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supply_contract. Business justification: CRO/CMO engagements typically have associated commercial supply contracts covering pricing, payment terms, and commercial obligations. The engagement record has technical_agreement_reference and quali',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor master record representing the CRO, CMO, or CDMO organization.',
    `vendor_site_id` BIGINT COMMENT 'Reference to the specific vendor site where the engagement activities are performed.',
    `audit_required_flag` BOOLEAN COMMENT 'Indicates whether periodic quality audits of the CRO/CMO/CDMO are required as part of this engagement.',
    `comments` STRING COMMENT 'Additional notes, observations, or context related to the engagement.',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this engagement record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this engagement record was first created in the system.',
    `engagement_end_date` DATE COMMENT 'Planned or actual date when the engagement activities conclude. Nullable for open-ended engagements.',
    `engagement_number` STRING COMMENT 'Business identifier for the engagement, used for external communication and tracking.',
    `engagement_owner_email` STRING COMMENT 'Email address of the internal engagement owner.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `engagement_owner_name` STRING COMMENT 'Name of the internal employee responsible for managing and overseeing this engagement.',
    `engagement_start_date` DATE COMMENT 'Date when the engagement activities officially commenced.',
    `engagement_status` STRING COMMENT 'Current lifecycle status of the engagement: active for ongoing operations, on-hold for temporarily suspended activities, winding-down for planned closure in progress, terminated for prematurely ended engagements, or completed for successfully concluded engagements.. Valid values are `active|on_hold|winding_down|terminated|completed`',
    `engagement_title` STRING COMMENT 'Descriptive title of the engagement summarizing the scope and purpose.',
    `engagement_type` STRING COMMENT 'Classification of the engagement based on the type of outsourced service: clinical CRO for clinical trial execution, bioanalytical CRO for laboratory testing, CMO drug substance for API manufacturing, CMO drug product for finished dosage form manufacturing, CDMO integrated for combined development and manufacturing, preclinical CRO for toxicology and safety studies, regulatory consulting for submission support, or pharmacovigilance services for safety monitoring. [ENUM-REF-CANDIDATE: clinical_cro|bioanalytical_cro|cmo_drug_substance|cmo_drug_product|cdmo_integrated|preclinical_cro|regulatory_consulting|pharmacovigilance_services — 8 candidates stripped; promote to reference product]',
    `gcp_compliance_required` BOOLEAN COMMENT 'Indicates whether the engagement requires the CRO to operate under Good Clinical Practice (GCP) guidelines for clinical trial conduct.',
    `glp_compliance_required` BOOLEAN COMMENT 'Indicates whether the engagement requires the CRO to operate under Good Laboratory Practice (GLP) standards for preclinical safety studies.',
    `gmp_compliance_required` BOOLEAN COMMENT 'Indicates whether the engagement requires the CRO/CMO/CDMO to operate under current Good Manufacturing Practice (cGMP) regulations.',
    `governance_meeting_cadence` STRING COMMENT 'Frequency of scheduled governance and oversight meetings between the organization and the CRO/CMO/CDMO.. Valid values are `weekly|biweekly|monthly|quarterly|as_needed`',
    `last_audit_date` DATE COMMENT 'Date of the most recent quality audit conducted at the CRO/CMO/CDMO site for this engagement.',
    `last_governance_meeting_date` DATE COMMENT 'Date of the most recent governance meeting held with the CRO/CMO/CDMO.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this engagement record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this engagement record was last updated in the system.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next quality audit of the CRO/CMO/CDMO site for this engagement.',
    `next_governance_meeting_date` DATE COMMENT 'Scheduled date for the next governance meeting with the CRO/CMO/CDMO.',
    `primary_technical_contact_email` STRING COMMENT 'Email address of the primary technical contact at the CRO/CMO/CDMO.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_technical_contact_name` STRING COMMENT 'Name of the primary technical contact person at the CRO/CMO/CDMO responsible for technical coordination and issue resolution.',
    `primary_technical_contact_phone` STRING COMMENT 'Phone number of the primary technical contact at the CRO/CMO/CDMO.',
    `product_program_reference` STRING COMMENT 'Reference to the internal product development program or project that this engagement supports.',
    `quality_agreement_reference` STRING COMMENT 'Document reference number for the quality agreement defining GMP responsibilities, quality standards, and compliance obligations.',
    `regulatory_filing_impact_flag` BOOLEAN COMMENT 'Indicates whether this engagement impacts regulatory filings such as IND (Investigational New Drug), NDA (New Drug Application), BLA (Biologics License Application), or MAA (Marketing Authorization Application).',
    `regulatory_filing_type` STRING COMMENT 'Type of regulatory filing impacted by this engagement: IND for investigational new drug, NDA for new drug application, BLA for biologics license application, MAA for marketing authorization application, ANDA for abbreviated new drug application, DME for drug master file, or not applicable if no filing impact. [ENUM-REF-CANDIDATE: ind|nda|bla|maa|anda|dme|not_applicable — 7 candidates stripped; promote to reference product]',
    `risk_classification` STRING COMMENT 'Risk rating assigned to this engagement based on factors such as product criticality, regulatory impact, supplier capability, and quality history.. Valid values are `low|medium|high|critical`',
    `scope_of_work_summary` STRING COMMENT 'High-level description of the activities, deliverables, and responsibilities covered under this engagement.',
    `technical_agreement_reference` STRING COMMENT 'Document reference number for the technical agreement defining specifications, processes, and technical requirements.',
    `technology_transfer_completion_date` DATE COMMENT 'Date when technology transfer activities were successfully completed and validated.',
    `technology_transfer_status` STRING COMMENT 'Status of technology transfer activities for transferring manufacturing processes, analytical methods, or clinical protocols to the CRO/CMO/CDMO.. Valid values are `not_started|in_progress|completed|not_applicable`',
    `termination_reason` STRING COMMENT 'Explanation for why the engagement was terminated or ended prematurely, if applicable.',
    `therapeutic_area` STRING COMMENT 'Primary therapeutic area or disease indication that this engagement supports (e.g., oncology, immunology, rare diseases, cardiovascular).',
    CONSTRAINT pk_cro_cmo_engagement PRIMARY KEY(`cro_cmo_engagement_id`)
) COMMENT 'Master records for formal engagements with Contract Research Organizations (CROs), Contract Manufacturing Organizations (CMOs), and CDMOs covering outsourced clinical, development, and manufacturing activities. Captures engagement type (clinical CRO, bioanalytical CRO, CMO drug substance, CMO drug product, CDMO integrated), scope of work summary, engagement start and end dates, technical agreement reference, quality agreement reference, technology transfer status, regulatory filing impact flag (IND/NDA/BLA/MAA), primary technical contact, governance meeting cadence, and engagement status (active, on-hold, winding-down, terminated). Distinct from the commercial supply_contract — this captures the operational and technical relationship including technology transfer milestones.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` (
    `sourcing_material_id` BIGINT COMMENT 'Primary key for sourcing_material',
    `drug_substance_id` BIGINT COMMENT 'Foreign key linking to product.drug_substance. Business justification: Sourcing material (procurement master) must link to drug substance (product master) for GMP traceability, specification alignment, certificate of analysis verification, and regulatory inspection readi',
    `excipient_id` BIGINT COMMENT 'Foreign key linking to product.excipient. Business justification: Sourcing material for excipients must link to excipient master for specification compliance, allergen/GMO status verification, compendial grade confirmation, and quality documentation traceability. Pa',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Material sourcing data is plant-specific for MRP planning, reorder point calculation, and vendor selection. Plant master provides storage capacity and lead time for pharmaceutical procurement planning',
    `vendor_id` BIGINT COMMENT 'Identifier of the preferred or primary vendor for this material. Links to the vendor master in the procurement domain.',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: Sourcing material order UOM for purchase requisition and PO creation. UOM master provides conversion to base UOM for pharmaceutical procurement and inventory management.',
    `abc_indicator` STRING COMMENT 'ABC classification for inventory management: A (high value, tight control), B (moderate value), C (low value, simple control). Based on consumption value analysis.. Valid values are `A|B|C`',
    `batch_managed_flag` BOOLEAN COMMENT 'Indicates whether this material requires batch or lot number tracking for traceability and quality control purposes.',
    `coa_required_flag` BOOLEAN COMMENT 'Indicates whether a Certificate of Analysis must be provided by the supplier with each delivery of this material.',
    `cold_chain_required_flag` BOOLEAN COMMENT 'Indicates whether this material requires temperature-controlled storage and transportation (cold chain logistics).',
    `controlled_substance_flag` BOOLEAN COMMENT 'Indicates whether this material is a controlled substance requiring DEA registration and special handling procedures.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this procurement material master record was first created in the system.',
    `dea_schedule` STRING COMMENT 'DEA controlled substance schedule classification if applicable: SCHEDULE_I through SCHEDULE_V based on abuse potential and medical use, or NOT_CONTROLLED for non-controlled materials.. Valid values are `SCHEDULE_I|SCHEDULE_II|SCHEDULE_III|SCHEDULE_IV|SCHEDULE_V|NOT_CONTROLLED`',
    `gmp_relevant_flag` BOOLEAN COMMENT 'Indicates whether this material is subject to GMP regulations and requires GMP-certified suppliers and quality documentation.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether this material is classified as hazardous and requires special handling, storage, and transportation procedures.',
    `last_goods_receipt_date` DATE COMMENT 'Date of the most recent goods receipt for this material. Used to identify slow-moving or obsolete inventory.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this procurement material master record was last updated.',
    `last_purchase_price` DECIMAL(18,2) COMMENT 'Most recent actual purchase price paid for this material. Used for price variance analysis and future procurement negotiations.',
    `material_category` STRING COMMENT 'Procurement-specific categorization of the material: API (Active Pharmaceutical Ingredient), EXCIPIENT (Inactive ingredient), PACKAGING_PRIMARY (Direct contact packaging), PACKAGING_SECONDARY (Outer packaging), LAB_SUPPLY (Laboratory consumables), CONSUMABLE (General supplies), SERVICE (Procured services). [ENUM-REF-CANDIDATE: API|EXCIPIENT|PACKAGING_PRIMARY|PACKAGING_SECONDARY|LAB_SUPPLY|CONSUMABLE|SERVICE — 7 candidates stripped; promote to reference product]',
    `material_description` STRING COMMENT 'Short textual description of the material for procurement purposes.',
    `material_status` STRING COMMENT 'Current lifecycle status of the material in the procurement system: ACTIVE (available for ordering), INACTIVE (temporarily unavailable), BLOCKED (quality hold), OBSOLETE (discontinued), PENDING_APPROVAL (awaiting qualification).. Valid values are `ACTIVE|INACTIVE|BLOCKED|OBSOLETE|PENDING_APPROVAL`',
    `material_type` STRING COMMENT 'SAP material type classification: ROH (Raw Material), VERP (Packaging Material), HIBE (Operating Supplies), FERT (Finished Product), HALB (Semi-Finished Product), UNBW (Non-Valuated Material).. Valid values are `ROH|VERP|HIBE|FERT|HALB|UNBW`',
    `maximum_stock_quantity` DECIMAL(18,2) COMMENT 'Maximum inventory level for this material to prevent overstocking and optimize working capital.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered from the supplier per purchase order. Supplier-imposed constraint.',
    `minimum_remaining_shelf_life_days` STRING COMMENT 'Minimum remaining shelf life required at goods receipt. Materials received with less remaining shelf life are rejected or require special approval.',
    `price_unit` STRING COMMENT 'Quantity unit for which the price is specified (e.g., price per 1, per 100, per 1000 units). Used to normalize pricing across different order quantities.',
    `procurement_type` STRING COMMENT 'Indicates whether the material is procured externally from vendors, produced internally, or both.. Valid values are `EXTERNAL|INTERNAL|BOTH`',
    `purchasing_group` STRING COMMENT 'Three-character code identifying the purchasing group responsible for procuring this material. Purchasing groups are buyer teams organized by commodity or supplier.. Valid values are `^[A-Z0-9]{3}$`',
    `purchasing_organization` STRING COMMENT 'Four-character code representing the organizational unit responsible for procurement activities for this material. Defines procurement authority and vendor relationships.. Valid values are `^[A-Z0-9]{4}$`',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether incoming goods of this material must undergo quality inspection before release to unrestricted stock.',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'Inventory level at which a purchase requisition should be automatically triggered to replenish stock. Used in material requirements planning.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Minimum inventory level maintained as buffer stock to prevent stockouts due to demand variability or supply delays.',
    `sap_material_number` STRING COMMENT '18-digit SAP material master number that uniquely identifies the material in the enterprise material master. Cross-reference to the masterdata domain material master SSOT.. Valid values are `^[0-9]{18}$`',
    `serial_number_managed_flag` BOOLEAN COMMENT 'Indicates whether this material requires individual serial number tracking for complete unit-level traceability.',
    `shelf_life_days` STRING COMMENT 'Total shelf life of the material in days from manufacturing date to expiration. Critical for pharmaceutical materials with limited stability.',
    `standard_lead_time_days` STRING COMMENT 'Standard procurement lead time in days from purchase order creation to goods receipt. Used for material requirements planning and order scheduling.',
    `standard_price` DECIMAL(18,2) COMMENT 'Standard or planned unit price for this material used for cost accounting and budgeting purposes. Currency is defined at the plant or company code level.',
    `storage_temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum storage temperature requirement in degrees Celsius for this material. Critical for cold chain and temperature-sensitive materials.',
    `storage_temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum storage temperature requirement in degrees Celsius for this material. Critical for cold chain and temperature-sensitive materials.',
    CONSTRAINT pk_sourcing_material PRIMARY KEY(`sourcing_material_id`)
) COMMENT 'Procurement-specific attributes for raw materials, APIs, excipients, packaging components, and laboratory supplies managed within the procurement domain. Captures SAP material number, purchasing group, purchasing organization, GMP-relevant flag, controlled substance flag (DEA schedule), cold-chain requirement, reorder point, safety stock level, standard lead time, and preferred vendor. SSOT BOUNDARY: This product owns ONLY procurement-specific attributes (purchasing parameters, sourcing preferences, procurement lead times). The enterprise material master in the masterdata domain owns material identity, classification, and base attributes. Cross-reference via SAP material number.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` (
    `delivery_schedule_id` BIGINT COMMENT 'Unique identifier for the delivery schedule line. Primary key for this entity.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to supply.shipment. Business justification: Vendor delivery schedules result in inbound shipments tracked in supply domain. Essential for OTIF measurement, ASN reconciliation, and linking procurement commitments to physical receipt and cold cha',
    `material_id` BIGINT COMMENT 'Reference to the material being delivered under this schedule. May represent Active Pharmaceutical Ingredient (API), excipient, packaging material, or laboratory supply.',
    `po_line_item_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line_item. Business justification: Delivery schedules in SAP MM are maintained at the line item level, not the header level. While delivery_schedule already has FK to purchase_order, adding FK to po_line_item provides the correct granu',
    `purchase_order_id` BIGINT COMMENT 'Reference to the parent purchase order or blanket purchase order under which this delivery schedule is created. Links to the procurement purchase order entity.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Delivery schedules specify receiving plant for inbound logistics planning and goods receipt preparation. Plant master provides receiving hours and dock capacity for pharmaceutical supply chain executi',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to masterdata.storage_location. Business justification: Delivery schedules specify storage location for inbound logistics and goods receipt posting. Storage location master provides capacity and temperature control for pharmaceutical delivery planning.',
    `supply_agreement_id` BIGINT COMMENT 'Reference to the scheduling agreement with the vendor that governs this delivery schedule. Used for long-term procurement arrangements with scheduled releases.',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: Delivery schedule quantity UOM for ASN confirmation and goods receipt matching. UOM master provides conversion for pharmaceutical inbound logistics and inventory posting.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor responsible for delivering the materials under this schedule. Links to the vendor master data.',
    `actual_delivery_date` DATE COMMENT 'The actual date on which the material was received at the destination. Populated upon goods receipt posting. Used for schedule adherence analysis and vendor performance evaluation.',
    `asn_number` STRING COMMENT 'The unique identifier of the Advanced Shipping Notice document received from the vendor. Used to correlate shipment notification with goods receipt.',
    `asn_received_date` DATE COMMENT 'The date on which the Advanced Shipping Notice was received from the vendor. Used to measure vendor compliance with ASN lead time requirements.',
    `asn_received_flag` BOOLEAN COMMENT 'Indicates whether an Advanced Shipping Notice (ASN) has been received from the vendor for this delivery schedule line. ASN provides advance notification of shipment details and enables proactive receiving preparation.',
    `carrier_name` STRING COMMENT 'The name of the logistics carrier or freight forwarder responsible for transporting the material from the vendor to the receiving location.',
    `confirmed_delivery_date` DATE COMMENT 'The delivery date confirmed by the vendor in response to the scheduled delivery date. May differ from the scheduled date if the vendor cannot meet the original request. Used for supply planning and risk assessment.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'The quantity of material confirmed by the vendor for delivery. May differ from the scheduled quantity if the vendor cannot fulfill the full request. Used for supply planning adjustments.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this delivery schedule record was first created in the system. Used for audit trail and data lineage tracking.',
    `delivered_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of material received and posted in the goods receipt. Used for invoice verification and schedule adherence tracking.',
    `delivery_delay_days` STRING COMMENT 'The number of calendar days by which the actual delivery date exceeded the confirmed delivery date. Positive values indicate late delivery; negative values indicate early delivery. Used for vendor performance scoring.',
    `delivery_tolerance_percentage` DECIMAL(18,2) COMMENT 'The acceptable percentage variance (over or under) from the scheduled quantity that the buyer will accept without requiring approval. Used for automated goods receipt processing and tolerance checking.',
    `goods_receipt_number` STRING COMMENT 'The unique identifier of the goods receipt document created when the material was physically received and posted into inventory. Links the delivery schedule to the actual receipt transaction.',
    `incoterms_code` STRING COMMENT 'The Incoterms code that defines the responsibilities, costs, and risks between buyer and seller for this delivery. Examples include EXW (Ex Works), FOB (Free On Board), CIF (Cost Insurance and Freight), DDP (Delivered Duty Paid).',
    `inspection_lot_number` STRING COMMENT 'The unique identifier of the quality inspection lot created for this goods receipt. Used to track sampling, testing, and release decisions in the Laboratory Information Management System (LIMS).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this delivery schedule record was most recently updated. Tracks the latest change to any field in the record for change management and audit purposes.',
    `overdelivery_tolerance_percentage` DECIMAL(18,2) COMMENT 'The maximum acceptable percentage by which the vendor may exceed the scheduled quantity. Separate from underdelivery tolerance to provide asymmetric control.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether the received material must undergo quality inspection before being released for use. Typically true for Good Manufacturing Practice (GMP) materials including APIs, excipients, and packaging components.',
    `quantity_variance_percentage` DECIMAL(18,2) COMMENT 'The percentage difference between the delivered quantity and the confirmed quantity. Calculated as ((delivered_quantity - confirmed_quantity) / confirmed_quantity) * 100. Used for vendor performance evaluation.',
    `required_temperature_max_celsius` DECIMAL(18,2) COMMENT 'The maximum acceptable temperature in degrees Celsius for temperature-controlled shipments. Excursions beyond this threshold may compromise material quality and require investigation.',
    `required_temperature_min_celsius` DECIMAL(18,2) COMMENT 'The minimum acceptable temperature in degrees Celsius for temperature-controlled shipments. Used for cold chain validation and compliance verification.',
    `schedule_adherence_status` STRING COMMENT 'Classification of the delivery performance relative to the confirmed delivery date and quantity. On-time indicates delivery within tolerance; early and late indicate timing deviations; partial indicates quantity shortfall; cancelled indicates the schedule line was not fulfilled.. Valid values are `on_time|early|late|partial|cancelled`',
    `schedule_change_reason` STRING COMMENT 'Free-text explanation of why the delivery schedule was modified after initial creation. Captures business context for date or quantity changes, cancellations, or expedited deliveries.',
    `schedule_line_number` STRING COMMENT 'Sequential line number within the purchase order or scheduling agreement that uniquely identifies this delivery schedule entry. Used for ordering and referencing specific schedule lines.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the delivery schedule line. Tracks progression from initial planning through vendor confirmation, shipment, and final delivery or cancellation.. Valid values are `planned|confirmed|in_transit|delivered|cancelled|delayed`',
    `schedule_type` STRING COMMENT 'Classification of the delivery schedule indicating the commitment level and planning horizon. Forecast schedules are non-binding planning signals; firm schedules are committed deliveries; just-in-time schedules support lean manufacturing; blanket and contract releases are call-offs from long-term agreements.. Valid values are `forecast|firm|just_in_time|blanket_release|contract_release`',
    `scheduled_delivery_date` DATE COMMENT 'The originally planned date on which the material is expected to be delivered to the receiving location. This is the buyers requested delivery date communicated to the vendor.',
    `scheduled_quantity` DECIMAL(18,2) COMMENT 'The quantity of material originally scheduled for delivery on the scheduled delivery date. Expressed in the materials base unit of measure.',
    `shipping_point` STRING COMMENT 'The vendors facility or location from which the material is being shipped. Used for logistics planning and transit time calculation.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this delivery requires temperature-controlled transportation to maintain material stability and quality. Critical for biologics, vaccines, and temperature-sensitive Active Pharmaceutical Ingredients (APIs).',
    `tracking_number` STRING COMMENT 'The carrier-provided tracking number for the shipment. Enables real-time visibility of in-transit materials and proactive exception management.',
    `underdelivery_tolerance_percentage` DECIMAL(18,2) COMMENT 'The maximum acceptable percentage by which the vendor may fall short of the scheduled quantity without triggering a deviation or requiring approval.',
    CONSTRAINT pk_delivery_schedule PRIMARY KEY(`delivery_schedule_id`)
) COMMENT 'Planned and confirmed delivery schedules for materials under blanket purchase orders and scheduling agreements with vendors. Captures schedule line number, scheduled delivery date, confirmed delivery date, scheduled quantity, confirmed quantity, delivery tolerance percentage, shipping notification (ASN) received flag, actual delivery date, and schedule adherence status. Enables supply planning integration with Kinaxis RapidResponse and proactive management of supply continuity risks.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_material` (
    `approved_vendor_material_id` BIGINT COMMENT 'Unique identifier for this vendor-material approval record. Primary key.',
    `material_id` BIGINT COMMENT 'Foreign key linking to the material master record. Identifies which material this vendor is approved to supply.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor master record. Identifies which vendor is approved for this material.',
    `approval_date` DATE COMMENT 'Date when this vendor was approved to supply this specific material following successful qualification, audit, and quality agreement execution.',
    `approval_expiry_date` DATE COMMENT 'Date when the approval for this vendor-material combination expires and requires requalification or renewal. Typically aligned with quality agreement term or audit cycle.',
    `approval_status` STRING COMMENT 'Current regulatory and quality approval status for this vendor to supply this specific material. Approved: fully qualified. Conditional: approved with restrictions. Suspended: temporarily not allowed. Revoked: approval withdrawn. Under Review: qualification in progress.',
    `conditional_approval_conditions` STRING COMMENT 'Text description of specific conditions, restrictions, or requirements that apply when approval_status is Conditional. Examples: additional testing required, batch-by-batch release, restricted to specific manufacturing site.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor-material approval record was first created in the system.',
    `dmf_reference_number` STRING COMMENT 'FDA Drug Master File (DMF) reference number or equivalent regulatory filing reference (e.g., CEP, ASMF) specific to this vendors manufacturing process for this material. Critical for APIs and excipients.',
    `last_audit_date` DATE COMMENT 'Date of the most recent vendor audit specifically covering this materials manufacturing, testing, and release processes. Material-specific audits may occur separately from general vendor audits.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor-material approval record was last modified.',
    `lead_time_days` STRING COMMENT 'Standard procurement lead time in days from purchase order placement to goods receipt for this material from this vendor. Vendor-material specific based on manufacturing cycle and logistics.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required by this vendor for this material, expressed in the materials base unit of measure. Vendor-material specific based on manufacturing batch sizes.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next audit of this vendors capability to supply this specific material. Audit frequency is risk-based per the risk_classification.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether this vendor is the preferred or primary source for this specific material based on quality performance, pricing, lead time, and strategic relationship. Used for sourcing prioritization.',
    `pricing_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit_price (e.g., USD, EUR, GBP, JPY, CHF).',
    `quality_agreement_reference` STRING COMMENT 'Reference number or identifier for the material-specific quality agreement or addendum governing the supply of this material by this vendor. May reference a master quality agreement with material-specific annexes.',
    `risk_classification` STRING COMMENT 'Risk-based classification of this specific vendor-material supply relationship based on material criticality, vendor performance, regulatory complexity, and supply chain risk. Determines audit frequency and oversight level.',
    `unit_price` DECIMAL(18,2) COMMENT 'Current negotiated unit price for this material from this vendor, expressed in the pricing currency. Price is vendor-material specific and may vary based on volume tiers.',
    CONSTRAINT pk_approved_vendor_material PRIMARY KEY(`approved_vendor_material_id`)
) COMMENT 'This association product represents the regulatory approval and quality agreement between a vendor and a specific material they are authorized to supply. It captures vendor-material-specific approval status, quality agreements, DMF references, audit history, and risk classifications that exist only in the context of this specific supply relationship. Each record links one vendor to one material with regulatory and quality attributes that govern the supply of that specific material by that specific vendor.. Existence Justification: In pharmaceutical operations, a vendor can be approved to supply multiple materials (APIs, excipients, packaging materials), and a material can be sourced from multiple approved vendors to ensure supply continuity and competitive pricing. The approval relationship is actively managed by procurement and quality teams through vendor qualification, audits, quality agreements, and regulatory filings (DMF references). Each vendor-material combination has its own approval status, quality agreement, pricing terms, lead times, and audit history that cannot be stored on either the vendor or material master alone.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` (
    `vendor_gxp_qualification_id` BIGINT COMMENT 'Unique identifier for this vendor-GxP obligation qualification record. Primary key.',
    `gxp_obligation_id` BIGINT COMMENT 'Foreign key linking to the GxP regulatory obligation record in the compliance domain',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor master record in the procurement domain',
    `audit_frequency_months` STRING COMMENT 'Required audit frequency in months for this vendor-obligation pair. Frequency is risk-based and varies by obligation criticality and vendor risk profile. Typical values: 12 (annual), 24 (biennial), 36 (triennial).',
    `audit_outcome` STRING COMMENT 'Result of the most recent audit for this vendor-obligation pair. Approved: no critical findings. Approved with Observations: minor findings documented. Conditional Approval: major findings require corrective action. Not Approved: critical findings prevent qualification. Pending: audit completed but outcome under review.',
    `capa_reference` STRING COMMENT 'Reference identifier to the CAPA record(s) associated with this vendor-obligation qualification. Null if no CAPA required.',
    `capa_required_flag` BOOLEAN COMMENT 'Indicates whether Corrective and Preventive Action (CAPA) is required for this vendor-obligation qualification based on audit findings or compliance gaps.',
    `compliance_evidence_reference` STRING COMMENT 'Reference identifier or document path to the compliance evidence package supporting this vendors qualification for this obligation. May include audit reports, certificates, test results, quality agreements, and correspondence with regulatory authorities.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this vendor-GxP obligation qualification record was created in the system.',
    `gmp_certification_authority` STRING COMMENT 'Name of the regulatory authority or certification body that issued the GMP certification (e.g., FDA, EMA, MHRA, PMDA, WHO PQ). [Moved from vendor: Similar to above - this is vendor-level general GMP certification metadata. The association tracks obligation-specific qualification, not general certifications. This should remain on vendor. Removing this entry.]',
    `gmp_certification_expiry_date` DATE COMMENT 'Date when the current GMP certification expires. Vendors must renew certification before this date to maintain qualified supplier status. [Moved from vendor: This is the vendors general GMP certificate expiry. The association has qualification_expiry_date which is obligation-specific and may differ. Both are needed. Removing this entry.]',
    `gmp_certified_flag` BOOLEAN COMMENT 'Indicates whether the vendor holds current GMP (Good Manufacturing Practice) certification from a recognized regulatory authority. Critical for API, excipient, and CMO/CDMO suppliers. [Moved from vendor: This is a general GMP certification flag at the vendor level, but GMP is just one of many GxP obligations. The qualification_status in the association captures whether the vendor is qualified for each specific GxP obligation (GMP, GDP, GCP, GLP, GPvP). However, upon reflection, this attribute should REMAIN on vendor as it represents the vendors general GMP certification status, while the association tracks obligation-specific qualification. Removing this entry.]',
    `last_audit_date` DATE COMMENT 'Date of the most recent audit conducted specifically for this vendor-obligation combination. Distinct from the vendors general last_audit_date as audits may be obligation-specific.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp when this vendor-GxP obligation qualification record was last modified.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next audit of this vendor for this specific GxP obligation. Calculated based on last_audit_date plus audit_frequency_months.',
    `qualification_date` DATE COMMENT 'Date when the vendor was qualified for this specific GxP obligation. Represents successful completion of qualification assessment including documentation review, audit, and approval.',
    `qualification_expiry_date` DATE COMMENT 'Date when the vendors qualification for this specific GxP obligation expires and requires renewal. Expiry dates are obligation-specific and may differ from the vendors general GMP certification expiry.',
    `qualification_owner` STRING COMMENT 'The role, department, or individual responsible for managing this specific vendor-obligation qualification. May differ from the general obligation owner based on vendor category or material type.',
    `qualification_status` STRING COMMENT 'Current qualification status of the vendor for this specific GxP obligation. Qualified: vendor meets all requirements. Conditionally Qualified: vendor meets requirements with minor observations. Not Qualified: vendor does not meet requirements. Under Review: qualification assessment in progress. Suspended: qualification temporarily revoked. Expired: qualification period has lapsed.',
    `updated_by` STRING COMMENT 'User ID or system identifier of the person or process that last updated this qualification record.',
    CONSTRAINT pk_vendor_gxp_qualification PRIMARY KEY(`vendor_gxp_qualification_id`)
) COMMENT 'This association product represents the qualification and compliance relationship between a vendor and a specific GxP regulatory obligation. It captures the vendors qualification status, audit history, and compliance evidence for each applicable GxP requirement (GMP, GDP, GCP, GLP, GPvP). Each record links one vendor to one GxP obligation with attributes that exist only in the context of this vendor-obligation qualification pair. Essential for supplier oversight, inspection readiness, and regulatory compliance tracking.. Existence Justification: In pharmaceutical operations, vendors must be qualified against multiple specific GxP obligations depending on the materials or services they supply (e.g., an API supplier must meet GMP requirements, a distributor must meet GDP requirements, a CRO must meet GCP requirements). Conversely, each GxP obligation applies to multiple vendors across the supply chain. The business actively manages this as a Vendor GxP Qualification Matrix with obligation-specific qualification statuses, audit schedules, and compliance evidence that cannot reside on either the vendor master record or the obligation master record alone.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`procurement`.`service_entry_sheet` (
    `service_entry_sheet_id` BIGINT COMMENT 'Primary key for service_entry_sheet',
    `supply_contract_id` BIGINT COMMENT 'Reference to the master service contract or supplier quality agreement under which this service was procured.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center to which the service costs are allocated for financial accounting and management reporting.',
    `created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created the service entry sheet record.',
    `employee_id` BIGINT COMMENT 'Reference to the user who performed the service acceptance, typically a quality assurance or receiving department representative.',
    `modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified the service entry sheet record.',
    `plant_id` BIGINT COMMENT 'Reference to the manufacturing plant, research facility, or site where the service was performed or for which the service was procured.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which services were rendered and recorded.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or service provider who performed the services documented in this entry sheet.',
    `reversed_service_entry_sheet_id` BIGINT COMMENT 'Self-referencing FK on service_entry_sheet (reversed_service_entry_sheet_id)',
    `acceptance_date` DATE COMMENT 'Date when the service was formally accepted by the receiving department or quality assurance, applicable when acceptance is required.',
    `acceptance_required_flag` BOOLEAN COMMENT 'Indicates whether formal acceptance or quality approval is required before the service entry can be posted and invoiced.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the service entry sheet record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this service entry sheet.',
    `deletion_flag` BOOLEAN COMMENT 'Indicates whether this service entry sheet record has been marked for deletion or logical archival, typically used for error correction or cancellation scenarios.',
    `entry_sheet_status` STRING COMMENT 'Current lifecycle status of the service entry sheet in the approval and posting workflow.',
    `external_reference_number` STRING COMMENT 'External reference number provided by the vendor or service provider, such as their delivery note, timesheet reference, or service report number.',
    `general_ledger_account_code` STRING COMMENT 'General ledger account code to which the service entry value is posted for financial reporting.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total value of services before taxes and adjustments, calculated as quantity multiplied by unit price.',
    `invoice_verification_status` STRING COMMENT 'Status of the invoice verification process for this service entry, indicating whether the vendor invoice has been matched and approved for payment.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the service entry sheet record was last modified.',
    `net_amount` DECIMAL(18,2) COMMENT 'Total payable amount including taxes and all adjustments.',
    `posted_date` DATE COMMENT 'Date when the service entry sheet was posted to financial accounting, triggering accounts payable liability recognition.',
    `purchase_order_item_number` STRING COMMENT 'Line item number within the purchase order for which this service entry is recorded.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether a formal quality inspection or audit of the service deliverables is required per Good Manufacturing Practice (GMP) or supplier quality agreement requirements.',
    `quality_inspection_result` STRING COMMENT 'Outcome of the quality inspection or audit performed on the service deliverables, critical for GMP compliance and supplier performance tracking.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of service units rendered, measured according to the unit of measure specified in the purchase order (e.g., hours, days, tests, batches).',
    `remarks` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the service entry, including any deviations or exceptions.',
    `service_description` STRING COMMENT 'Detailed textual description of the services performed, including scope, deliverables, and any deviations from the original purchase order specification.',
    `service_end_date` DATE COMMENT 'Date when the service performance period ended.',
    `service_entry_sheet_number` STRING COMMENT 'Business identifier for the service entry sheet, externally visible and used for tracking and reference in procurement and accounts payable processes.',
    `service_performer_name` STRING COMMENT 'Name of the individual or organization unit that performed the service, may differ from the contracting vendor in subcontracting scenarios.',
    `service_start_date` DATE COMMENT 'Date when the service performance period began.',
    `service_type` STRING COMMENT 'Classification of the type of service rendered, aligned with pharmaceutical procurement categories including Contract Research Organization (CRO), Contract Manufacturing Organization (CMO), and Contract Development and Manufacturing Organization (CDMO) services.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to the service entry, including VAT, GST, or other jurisdiction-specific taxes.',
    `unit_of_measure` STRING COMMENT 'Unit in which the service quantity is measured, aligned with pharmaceutical service measurement standards.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of service as agreed in the purchase order or contract.',
    CONSTRAINT pk_service_entry_sheet PRIMARY KEY(`service_entry_sheet_id`)
) COMMENT 'Master reference table for service_entry_sheet. Referenced by service_entry_sheet_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ADD CONSTRAINT `fk_procurement_vendor_site_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ADD CONSTRAINT `fk_procurement_vendor_qualification_supplier_quality_agreement_id` FOREIGN KEY (`supplier_quality_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement`(`supplier_quality_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ADD CONSTRAINT `fk_procurement_vendor_qualification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ADD CONSTRAINT `fk_procurement_vendor_qualification_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ADD CONSTRAINT `fk_procurement_supplier_audit_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ADD CONSTRAINT `fk_procurement_audit_finding_supplier_audit_id` FOREIGN KEY (`supplier_audit_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`supplier_audit`(`supplier_audit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ADD CONSTRAINT `fk_procurement_supplier_quality_agreement_superseded_agreement_supplier_quality_agreement_id` FOREIGN KEY (`superseded_agreement_supplier_quality_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement`(`supplier_quality_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ADD CONSTRAINT `fk_procurement_supplier_quality_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ADD CONSTRAINT `fk_procurement_supplier_quality_agreement_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ADD CONSTRAINT `fk_procurement_sourcing_bid_sourcing_event_id` FOREIGN KEY (`sourcing_event_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`sourcing_event`(`sourcing_event_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ADD CONSTRAINT `fk_procurement_sourcing_bid_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ADD CONSTRAINT `fk_procurement_supply_contract_sourcing_event_id` FOREIGN KEY (`sourcing_event_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`sourcing_event`(`sourcing_event_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ADD CONSTRAINT `fk_procurement_supply_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ADD CONSTRAINT `fk_procurement_contract_price_schedule_superseded_by_schedule_contract_price_schedule_id` FOREIGN KEY (`superseded_by_schedule_contract_price_schedule_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule`(`contract_price_schedule_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ADD CONSTRAINT `fk_procurement_contract_price_schedule_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_sourcing_material_id` FOREIGN KEY (`sourcing_material_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`sourcing_material`(`sourcing_material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ADD CONSTRAINT `fk_procurement_incoming_inspection_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ADD CONSTRAINT `fk_procurement_incoming_inspection_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ADD CONSTRAINT `fk_procurement_incoming_inspection_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_service_entry_sheet_id` FOREIGN KEY (`service_entry_sheet_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`service_entry_sheet`(`service_entry_sheet_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor_invoice`(`vendor_invoice_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ADD CONSTRAINT `fk_procurement_vendor_complaint_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ADD CONSTRAINT `fk_procurement_vendor_complaint_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ADD CONSTRAINT `fk_procurement_vendor_complaint_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ADD CONSTRAINT `fk_procurement_vendor_complaint_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ADD CONSTRAINT `fk_procurement_cro_cmo_engagement_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ADD CONSTRAINT `fk_procurement_cro_cmo_engagement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ADD CONSTRAINT `fk_procurement_cro_cmo_engagement_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ADD CONSTRAINT `fk_procurement_sourcing_material_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_material` ADD CONSTRAINT `fk_procurement_approved_vendor_material_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` ADD CONSTRAINT `fk_procurement_vendor_gxp_qualification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_reversed_service_entry_sheet_id` FOREIGN KEY (`reversed_service_entry_sheet_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`service_entry_sheet`(`service_entry_sheet_id`);

-- ========= TAGS =========
ALTER SCHEMA `pharmaceuticals_ecm`.`procurement` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `pharmaceuticals_ecm`.`procurement` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Business Partner Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `annual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Amount');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `annual_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `audit_outcome` SET TAGS ('dbx_business_glossary_term' = 'Audit Outcome Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `audit_outcome` SET TAGS ('dbx_value_regex' = 'approved|approved_with_observations|conditional_approval|not_approved');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Vendor Classification Type');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Deactivation Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_business_glossary_term' = 'Vendor Deactivation Reason');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `gdp_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Distribution Practice (GDP) Certified Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 1');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms) Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = 'net_30|net_60|net_90|due_on_receipt|2_10_net_30');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Qualification Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `quality_agreement_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Agreement Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `quality_agreement_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Agreement Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `quality_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Agreement Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Vendor Risk Score');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Legal Name');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Lifecycle Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_qualification|disqualified|blocked');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_tier` SET TAGS ('dbx_business_glossary_term' = 'Vendor Tier Classification');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Address Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `ema_site_number` SET TAGS ('dbx_business_glossary_term' = 'European Medicines Agency (EMA) Site Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `fda_establishment_number` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Establishment Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `fda_establishment_number` SET TAGS ('dbx_value_regex' = '^[0-9]{7,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `gdp_certified` SET TAGS ('dbx_business_glossary_term' = 'Good Distribution Practice (GDP) Certified');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `gmp_certified` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certified');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `iso_certification_standard` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) Certification Standard');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `iso_certified` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) Certified');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `qualification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|not_qualified|under_review|conditional|expired');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `site_capacity` SET TAGS ('dbx_business_glossary_term' = 'Site Capacity');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `site_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `site_status` SET TAGS ('dbx_business_glossary_term' = 'Site Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `site_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_qualification|disqualified');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ALTER COLUMN `site_type` SET TAGS ('dbx_value_regex' = 'manufacturing|distribution|warehouse|laboratory|office|research');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `vendor_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Qualification Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `dmf_id` SET TAGS ('dbx_business_glossary_term' = 'Dmf Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `gxp_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Gxp Obligation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Owner Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `supplier_quality_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Quality Agreement Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `tertiary_vendor_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `tertiary_vendor_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `tertiary_vendor_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `approved_for_purchasing` SET TAGS ('dbx_business_glossary_term' = 'Approved for Purchasing');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `audit_outcome` SET TAGS ('dbx_business_glossary_term' = 'Audit Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `audit_outcome` SET TAGS ('dbx_value_regex' = 'passed|passed-with-observations|failed|not-applicable');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'on-site|remote|desktop|hybrid|third-party');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `capa_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `capa_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `certification_iso_13485` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) 13485 Certification');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `certification_iso_9001` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) 9001 Certification');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `gdp_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Good Distribution Practice (GDP) Compliance Required');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `gmp_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Required');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `last_regulatory_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Regulatory Inspection Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Qualification Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_value_regex' = '^VQ-[0-9]{8}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_scope` SET TAGS ('dbx_business_glossary_term' = 'Qualification Scope');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'initial|re-qualification|for-cause|periodic|change-control');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `regulatory_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `regulatory_inspection_status` SET TAGS ('dbx_value_regex' = 'inspected|not-inspected|inspection-pending|inspection-failed|not-applicable');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Risk Classification');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `risk_classification` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `supplier_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Audit ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `pai_id` SET TAGS ('dbx_business_glossary_term' = 'Related Pai Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Closure Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_cost` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_report_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_team_members` SET TAGS ('dbx_business_glossary_term' = 'Audit Team Members');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'initial_qualification|periodic_surveillance|for_cause|pre_approval|re_qualification|desktop_review');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `capa_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `capa_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `capa_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Submission Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `capa_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Verification Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `capa_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Verification Method');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `capa_verification_method` SET TAGS ('dbx_value_regex' = 'document_review|follow_up_audit|remote_verification|sample_testing|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Audit Comments');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `gdp_compliance_rating` SET TAGS ('dbx_business_glossary_term' = 'Good Distribution Practice (GDP) Compliance Rating');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `gdp_compliance_rating` SET TAGS ('dbx_value_regex' = 'excellent|satisfactory|needs_improvement|unsatisfactory|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `gmp_compliance_rating` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Rating');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `gmp_compliance_rating` SET TAGS ('dbx_value_regex' = 'excellent|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `observations_count` SET TAGS ('dbx_business_glossary_term' = 'Observations Count');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `overall_audit_outcome` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `overall_audit_outcome` SET TAGS ('dbx_value_regex' = 'approved|approved_with_conditions|not_approved|follow_up_required');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `quality_system_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Management System (QMS) Rating');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `quality_system_rating` SET TAGS ('dbx_value_regex' = 'excellent|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `regulatory_references` SET TAGS ('dbx_business_glossary_term' = 'Regulatory References');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `report_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Report Issue Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `total_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `vault_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `compliance_capa_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Capa Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `supplier_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Audit ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `capa_completion_date` SET TAGS ('dbx_business_glossary_term' = 'CAPA Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `capa_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Description');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `capa_due_date` SET TAGS ('dbx_business_glossary_term' = 'CAPA Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `capa_owner_name` SET TAGS ('dbx_business_glossary_term' = 'CAPA Owner Name');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `capa_owner_title` SET TAGS ('dbx_business_glossary_term' = 'CAPA Owner Title');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `capa_verification_date` SET TAGS ('dbx_business_glossary_term' = 'CAPA Verification Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `capa_verification_status` SET TAGS ('dbx_business_glossary_term' = 'CAPA Verification Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `capa_verification_status` SET TAGS ('dbx_value_regex' = 'not_started|pending_evidence|under_review|accepted|rejected');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `capa_verifier_name` SET TAGS ('dbx_business_glossary_term' = 'CAPA Verifier Name');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `finding_classification` SET TAGS ('dbx_business_glossary_term' = 'Finding Classification');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `finding_classification` SET TAGS ('dbx_value_regex' = 'critical|major|minor|observation');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `finding_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Closure Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `finding_identified_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Identified Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_value_regex' = 'open|capa_pending|capa_submitted|under_review|verified|closed');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `gmp_area` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Area');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `previous_finding_reference` SET TAGS ('dbx_business_glossary_term' = 'Previous Finding Reference');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `repeat_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Finding Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `risk_to_patient_safety` SET TAGS ('dbx_business_glossary_term' = 'Risk to Patient Safety');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `risk_to_patient_safety` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `risk_to_product_quality` SET TAGS ('dbx_business_glossary_term' = 'Risk to Product Quality');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `risk_to_product_quality` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'procedure|training|equipment|material|documentation|system');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `supporting_evidence_location` SET TAGS ('dbx_business_glossary_term' = 'Supporting Evidence Location');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ALTER COLUMN `vendor_response_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Response Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `supplier_quality_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Quality Agreement (SQA) ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `gxp_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Gxp Obligation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `superseded_agreement_supplier_quality_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Agreement ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Quality Agreement (SQA) Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^SQA-[A-Z0-9]{6,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `agreement_title` SET TAGS ('dbx_business_glossary_term' = 'Agreement Title');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency (Months)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `audit_rights_clause` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Clause');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `change_notification_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Change Notification Lead Time (Days)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `change_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Change Notification Required');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `coa_format_specification` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) Format Specification');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `coa_required` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) Required');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `confidentiality_clause` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `deviation_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Deviation Notification Required');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `deviation_notification_timeframe_hours` SET TAGS ('dbx_business_glossary_term' = 'Deviation Notification Timeframe (Hours)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `document_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Location');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `gdp_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Good Distribution Practice (GDP) Compliance Required');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `gmp_responsibility_matrix` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Responsibility Matrix');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `organization_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Organization Signatory Name');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `organization_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `organization_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Organization Signatory Title');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `organization_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Organization Signature Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `quality_specifications_reference` SET TAGS ('dbx_business_glossary_term' = 'Quality Specifications Reference');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `regulatory_compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Requirements');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `scope_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Scope of Supply');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `supplier_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Signatory Name');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `supplier_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `supplier_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Supplier Signatory Title');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `supplier_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Signature Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` SET TAGS ('dbx_subdomain' = 'strategic_sourcing');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Awarded Vendor ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `audit_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Requirement Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `awarded_bid_amount` SET TAGS ('dbx_business_glossary_term' = 'Awarded Bid Amount');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `awarded_bid_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `bid_submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Bid Submission Deadline');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `commercial_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commercial Weight Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `contract_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Duration in Months');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'Fixed Price|Cost Plus|Time and Materials|Blanket|Framework');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `estimated_total_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Value');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `estimated_total_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `evaluation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `evaluation_criteria` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Criteria');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `evaluation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Description');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `event_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Event Owner Email Address');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `event_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `event_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `event_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `event_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Event Owner Name');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `event_title` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Title');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Type');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'RFI|RFP|RFQ|Auction|Reverse Auction|eRFX');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `gdp_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Distribution Practice (GDP) Requirement Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `gmp_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Requirement Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `invited_vendor_count` SET TAGS ('dbx_business_glossary_term' = 'Invited Vendor Count');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `price_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Price Weight Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `quality_agreement_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Agreement Required');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `responding_vendor_count` SET TAGS ('dbx_business_glossary_term' = 'Responding Vendor Count');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `savings_achieved` SET TAGS ('dbx_business_glossary_term' = 'Savings Achieved');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `savings_achieved` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `technical_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Technical Weight Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` SET TAGS ('dbx_subdomain' = 'strategic_sourcing');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `sourcing_bid_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Bid Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `bid_number` SET TAGS ('dbx_business_glossary_term' = 'Bid Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `bid_status` SET TAGS ('dbx_business_glossary_term' = 'Bid Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `bid_status` SET TAGS ('dbx_value_regex' = 'submitted|under_evaluation|shortlisted|rejected|awarded|withdrawn');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `certificate_of_analysis_provided` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) Provided');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `commercial_score` SET TAGS ('dbx_business_glossary_term' = 'Commercial Score');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `drug_master_file_number` SET TAGS ('dbx_business_glossary_term' = 'Drug Master File (DMF) Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `evaluator_comments` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Comments');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `gmp_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certificate Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `gmp_compliant` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliant');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `iso_certification_standard` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) Certification Standard');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `iso_certified` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) Certified');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `quoted_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Quoted Lead Time (Days)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `quoted_total_price` SET TAGS ('dbx_business_glossary_term' = 'Quoted Total Price');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `quoted_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Quoted Unit Price');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `regulatory_compliance_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Confirmed');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `sample_provided` SET TAGS ('dbx_business_glossary_term' = 'Sample Provided');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bid Submission Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `technical_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Technical Compliance Score');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `total_evaluated_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Evaluated Cost');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Bid Validity End Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Bid Validity Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Email Address');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Name');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Phone Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` SET TAGS ('dbx_subdomain' = 'strategic_sourcing');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `drug_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Substance Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `excipient_id` SET TAGS ('dbx_business_glossary_term' = 'Excipient Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency (Months)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `committed_volume` SET TAGS ('dbx_business_glossary_term' = 'Committed Volume');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `committed_volume` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `contract_currency` SET TAGS ('dbx_business_glossary_term' = 'Contract Currency');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `contract_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `contract_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Description');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `contract_owner` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'framework_agreement|blanket_order|quantity_contract|value_contract|master_service_agreement|quality_agreement');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `contract_value` SET TAGS ('dbx_business_glossary_term' = 'Contract Value');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `gdp_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Good Distribution Practice (GDP) Compliance Required');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `gmp_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Required');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^(net_[0-9]{1,3}|[0-9]{1,2}_[0-9]{1,3}_net_[0-9]{1,3}|due_on_receipt|prepayment|consignment)$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `price_basis` SET TAGS ('dbx_business_glossary_term' = 'Price Basis');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `price_basis` SET TAGS ('dbx_value_regex' = 'fixed|indexed|cost_plus|market_based');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `price_escalation_clause` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Clause');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `price_index_reference` SET TAGS ('dbx_business_glossary_term' = 'Price Index Reference');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `quality_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Agreement Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `quality_agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `quality_agreement_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Agreement Required');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `renewal_period_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Period (Months)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` SET TAGS ('dbx_subdomain' = 'strategic_sourcing');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `contract_price_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Price Schedule ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `superseded_by_schedule_contract_price_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Schedule ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Uom Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `cost_plus_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Plus Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `freight_cost_included` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Included');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `index_reference` SET TAGS ('dbx_business_glossary_term' = 'Index Reference');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `material_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,18}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `price_basis` SET TAGS ('dbx_business_glossary_term' = 'Price Basis');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `price_basis` SET TAGS ('dbx_value_regex' = 'fixed|indexed|cost_plus|market_based');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `price_validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Price Validity End Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `price_validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Price Validity Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `schedule_line_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|superseded');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Service Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `threshold_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit of Measure');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `volume_break_threshold` SET TAGS ('dbx_business_glossary_term' = 'Volume Break Threshold');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `sourcing_material_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Material Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Final Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_workflow_stage` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Stage');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^CTR[0-9]{10}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `delivery_address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 1');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `delivery_address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `delivery_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `delivery_city` SET TAGS ('dbx_business_glossary_term' = 'Delivery City');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `delivery_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `delivery_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Postal Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Requisition Value');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `gmp_relevant` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Relevant Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Requisition Priority Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|critical');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^PO[0-9]{10}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `quality_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `quality_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Approval Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^PR[0-9]{10}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'standard|subcontracting|consignment|stock_transfer|service|third_party');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `sourcing_date` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Procurement Instructions');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `creation_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Creation Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `batch_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Batch Managed Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 1');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 2');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_city` SET TAGS ('dbx_business_glossary_term' = 'Delivery City');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Postal Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_business_glossary_term' = 'Delivery State or Province');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `freight_charges` SET TAGS ('dbx_business_glossary_term' = 'Freight Charges');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `freight_charges` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `gmp_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Relevant Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Notes');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|contract|subcontracting|consignment|stock_transfer');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `storage_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `total_order_value` SET TAGS ('dbx_business_glossary_term' = 'Total Order Value');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `total_order_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `total_po_value` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Value');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `total_po_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ALTER COLUMN `vendor_acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Acknowledgement Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Item ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Uom Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Category');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_value_regex' = 'K|F|A|P|N|Q');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `batch_management_flag` SET TAGS ('dbx_business_glossary_term' = 'Batch Management Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Delivered Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `gmp_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Relevant Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `goods_receipt_flag` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `invoice_receipt_flag` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `invoiced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `item_category` SET TAGS ('dbx_value_regex' = 'Standard|Consignment|Subcontracting|Service|Stock Transfer|Third-Party');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `line_item_status` SET TAGS ('dbx_business_glossary_term' = 'Line Item Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `line_item_status` SET TAGS ('dbx_value_regex' = 'Open|Partially Delivered|Fully Delivered|Invoiced|Closed|Cancelled');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price per Unit');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `quality_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `short_text` SET TAGS ('dbx_business_glossary_term' = 'Short Text');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ALTER COLUMN `total_line_value` SET TAGS ('dbx_business_glossary_term' = 'Total Line Value');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `inventory_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Lot Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Item Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Uom Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `coa_document_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) Document Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `coa_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) Received Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|cancelled|pending_inspection');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `material_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `material_document_year` SET TAGS ('dbx_business_glossary_term' = 'Material Document Year');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `packaging_condition` SET TAGS ('dbx_business_glossary_term' = 'Packaging Condition');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `packaging_condition` SET TAGS ('dbx_value_regex' = 'intact|damaged|partial_damage|tampered|acceptable_with_notes');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `packaging_condition_notes` SET TAGS ('dbx_business_glossary_term' = 'Packaging Condition Notes');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Posting Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `quantity_variance` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_person_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Person Name');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_person_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receiving Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Remarks');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|restricted');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `temperature_excursion_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Excursion Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `temperature_max_recorded` SET TAGS ('dbx_business_glossary_term' = 'Maximum Recorded Temperature (Celsius)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `temperature_min_recorded` SET TAGS ('dbx_business_glossary_term' = 'Minimum Recorded Temperature (Celsius)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Amount');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `vendor_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Batch Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `incoming_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Incoming Inspection ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `internal_control_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Control Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `inventory_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Lot Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `assay_result_unit` SET TAGS ('dbx_business_glossary_term' = 'Assay Result Unit');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `assay_result_value` SET TAGS ('dbx_business_glossary_term' = 'Assay Result Value');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `assay_specification_max` SET TAGS ('dbx_business_glossary_term' = 'Assay Specification Maximum');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `assay_specification_min` SET TAGS ('dbx_business_glossary_term' = 'Assay Specification Minimum');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `coa_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) Received Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `coa_review_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `coa_review_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) Review Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `coa_review_status` SET TAGS ('dbx_value_regex' = 'not_started|in_review|approved|rejected');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Inspection Comments');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `disposition_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposition Reason');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `identity_test_result` SET TAGS ('dbx_business_glossary_term' = 'Identity Test Result');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `identity_test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_tested');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `impurity_profile_result` SET TAGS ('dbx_business_glossary_term' = 'Impurity Profile Result');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `impurity_profile_result` SET TAGS ('dbx_value_regex' = 'within_limits|out_of_specification|not_tested');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `inspection_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `inspection_decision` SET TAGS ('dbx_business_glossary_term' = 'Inspection Decision');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `inspection_decision` SET TAGS ('dbx_value_regex' = 'approved|rejected|conditionally_released');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `inspection_start_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|cancelled');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'normal|reduced|tightened|skip_lot');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `material_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Material Batch Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `microbiological_test_result` SET TAGS ('dbx_business_glossary_term' = 'Microbiological Test Result');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `microbiological_test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `samples_drawn_count` SET TAGS ('dbx_business_glossary_term' = 'Samples Drawn Count');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `test_methods_applied` SET TAGS ('dbx_business_glossary_term' = 'Test Methods Applied');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `blocked_for_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Blocked for Payment Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|prepayment|down_payment');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `match_status` SET TAGS ('dbx_value_regex' = 'not_matched|two_way_matched|three_way_matched|exception|override');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_block_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Reason');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|check|ach|credit_card|electronic_payment');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `invoice_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Item ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Item ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `service_entry_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet (SES) ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Uom Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Header ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `coa_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) Received Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Material Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `gmp_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Material Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Line Amount');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `internal_order` SET TAGS ('dbx_business_glossary_term' = 'Internal Order');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `invoiced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Type');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'material|service|freight|miscellaneous');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `match_status` SET TAGS ('dbx_value_regex' = 'matched|quantity_variance|price_variance|unmatched|blocked');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Line Amount');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `payment_block_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `payment_block_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Reason');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Financial Posting Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Match Variance Amount');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `vendor_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `monitoring_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Monitoring Activity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `average_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Average Lead Time Days');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `capa_closure_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Closure Rate Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `coa_compliance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) Compliance Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Comments');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `deviation_attribution_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Attribution Count');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `documentation_accuracy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Documentation Accuracy Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Name');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluator_role` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Role');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `financial_claims_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Claims Amount');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `in_full_delivery_percentage` SET TAGS ('dbx_business_glossary_term' = 'In-Full Delivery Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `non_conformance_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Count');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `on_time_delivery_percentage` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `otif_percentage` SET TAGS ('dbx_business_glossary_term' = 'On-Time In-Full (OTIF) Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `overall_performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `overall_performance_rating` SET TAGS ('dbx_value_regex' = 'preferred|approved|conditional|probation|disqualified');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `performance_trend` SET TAGS ('dbx_business_glossary_term' = 'Performance Trend');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `performance_trend` SET TAGS ('dbx_value_regex' = 'improving|stable|declining');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `quality_complaints_count` SET TAGS ('dbx_business_glossary_term' = 'Quality Complaints Count');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `re_qualification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Re-Qualification Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `rejected_lots_count` SET TAGS ('dbx_business_glossary_term' = 'Rejected Lots Count');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `responsiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Responsiveness Rating');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `responsiveness_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|poor');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `scorecard_type` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Type');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `scorecard_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|ad_hoc');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `spend_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Spend Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `spend_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `temperature_excursion_count` SET TAGS ('dbx_business_glossary_term' = 'Temperature Excursion Count');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `total_purchase_orders_count` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Orders Count');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `total_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Spend Amount');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `vendor_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Complaint Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `inventory_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Inventory Lot Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `affected_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Affected Batch Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `affected_material_code` SET TAGS ('dbx_business_glossary_term' = 'Affected Material Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `affected_material_description` SET TAGS ('dbx_business_glossary_term' = 'Affected Material Description');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `capa_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `capa_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Description');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `capa_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `capa_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Verification Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `capa_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Verification Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `capa_verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|not verified|partially verified');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `complaint_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Complaint Closure Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `complaint_date` SET TAGS ('dbx_business_glossary_term' = 'Complaint Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Complaint Description');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `complaint_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Complaint Owner Email Address');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `complaint_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `complaint_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `complaint_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `complaint_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Complaint Owner Name');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `complaint_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Complaint Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `complaint_reference_number` SET TAGS ('dbx_value_regex' = '^VC-[0-9]{8}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `complaint_resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Complaint Resolution Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `complaint_resolution_status` SET TAGS ('dbx_value_regex' = 'unresolved|resolved satisfactorily|resolved with conditions|unresolved escalated');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `complaint_severity` SET TAGS ('dbx_business_glossary_term' = 'Complaint Severity');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `complaint_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `complaint_status` SET TAGS ('dbx_business_glossary_term' = 'Complaint Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `complaint_type` SET TAGS ('dbx_business_glossary_term' = 'Complaint Type');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `complaint_type` SET TAGS ('dbx_value_regex' = 'OOS result|foreign matter|mislabelling|documentation error|delivery damage|temperature excursion');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `detection_date` SET TAGS ('dbx_business_glossary_term' = 'Detection Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `financial_claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Claim Amount');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `financial_claim_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Financial Claim Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `financial_claim_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `financial_claim_status` SET TAGS ('dbx_business_glossary_term' = 'Financial Claim Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `financial_claim_status` SET TAGS ('dbx_value_regex' = 'not claimed|claimed|approved|rejected|partially approved|settled');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `impact_to_patient_safety` SET TAGS ('dbx_business_glossary_term' = 'Impact to Patient Safety');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `impact_to_patient_safety` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|critical');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `impact_to_product_quality` SET TAGS ('dbx_business_glossary_term' = 'Impact to Product Quality');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `impact_to_product_quality` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|critical');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `vendor_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Notification Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `vendor_response_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Response Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ALTER COLUMN `vendor_response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Response Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approved_vendor_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List (AVL) ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `drug_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Substance Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `alternate_vendor_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Alternate Vendor Available Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approval_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approval_justification` SET TAGS ('dbx_business_glossary_term' = 'Approval Justification');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approval_scope` SET TAGS ('dbx_business_glossary_term' = 'Approval Scope');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'Approved|Conditionally Approved|Suspended|Delisted|Pending Qualification|Under Review');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approved_by_title` SET TAGS ('dbx_business_glossary_term' = 'Approved By Title');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency (Months)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `avl_number` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List (AVL) Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `avl_number` SET TAGS ('dbx_value_regex' = '^AVL-[A-Z0-9]{8,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `change_control_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Change Control Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `coa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `conditional_approval_conditions` SET TAGS ('dbx_business_glossary_term' = 'Conditional Approval Conditions');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `delisting_date` SET TAGS ('dbx_business_glossary_term' = 'Delisting Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `delisting_reason` SET TAGS ('dbx_business_glossary_term' = 'Delisting Reason');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `dmf_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Drug Master File (DMF) Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `dmf_reference_number` SET TAGS ('dbx_value_regex' = '^DMF-[A-Z]{2,3}-[0-9]{5,8}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `gmp_grade_approved` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Grade Approved');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `last_audit_outcome` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `last_audit_outcome` SET TAGS ('dbx_value_regex' = 'Acceptable|Acceptable with Observations|Conditional|Unacceptable');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `material_specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Material Specification Reference');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `next_requalification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Re-qualification Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `quality_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Quality Agreement Reference');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `requalification_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Re-qualification Frequency (Months)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Risk Classification');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `risk_classification` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `sole_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Sole Source Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `cro_cmo_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Research Organization (CRO) / Contract Manufacturing Organization (CMO) Engagement ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `affairs_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Affairs Plan Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `engagement_number` SET TAGS ('dbx_business_glossary_term' = 'Engagement Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `engagement_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Engagement Owner Email');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `engagement_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `engagement_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `engagement_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Engagement Owner Name');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|winding_down|terminated|completed');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `engagement_title` SET TAGS ('dbx_business_glossary_term' = 'Engagement Title');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `engagement_type` SET TAGS ('dbx_business_glossary_term' = 'Engagement Type');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `gcp_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Good Clinical Practice (GCP) Compliance Required');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `glp_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Good Laboratory Practice (GLP) Compliance Required');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `gmp_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Required');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `governance_meeting_cadence` SET TAGS ('dbx_business_glossary_term' = 'Governance Meeting Cadence');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `governance_meeting_cadence` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly|as_needed');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `last_governance_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Last Governance Meeting Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `next_governance_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Next Governance Meeting Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `primary_technical_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Technical Contact Email');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `primary_technical_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `primary_technical_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `primary_technical_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Technical Contact Name');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `primary_technical_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `primary_technical_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `primary_technical_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Technical Contact Phone');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `primary_technical_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `product_program_reference` SET TAGS ('dbx_business_glossary_term' = 'Product Program Reference');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `quality_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Quality Agreement Reference');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `regulatory_filing_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Impact Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `regulatory_filing_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Type');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Risk Classification');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `risk_classification` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `scope_of_work_summary` SET TAGS ('dbx_business_glossary_term' = 'Scope of Work Summary');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `technical_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Technical Agreement Reference');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `technology_transfer_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Technology Transfer Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `technology_transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Technology Transfer Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `technology_transfer_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` SET TAGS ('dbx_subdomain' = 'strategic_sourcing');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `sourcing_material_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Material Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `drug_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Substance Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `excipient_id` SET TAGS ('dbx_business_glossary_term' = 'Excipient Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Order Uom Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_business_glossary_term' = 'ABC Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `batch_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Batch Managed Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `coa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `cold_chain_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `controlled_substance_flag` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'SCHEDULE_I|SCHEDULE_II|SCHEDULE_III|SCHEDULE_IV|SCHEDULE_V|NOT_CONTROLLED');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `gmp_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Relevant Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `last_goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Receipt Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `last_purchase_price` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Price');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `last_purchase_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `material_status` SET TAGS ('dbx_business_glossary_term' = 'Material Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `material_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|INACTIVE|BLOCKED|OBSOLETE|PENDING_APPROVAL');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'ROH|VERP|HIBE|FERT|HALB|UNBW');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `maximum_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `minimum_remaining_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Remaining Shelf Life Days');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'EXTERNAL|INTERNAL|BOTH');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `sap_material_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Material Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `sap_material_number` SET TAGS ('dbx_value_regex' = '^[0-9]{18}$');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `serial_number_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Managed Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `standard_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Lead Time Days');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `standard_price` SET TAGS ('dbx_business_glossary_term' = 'Standard Price');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `standard_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `storage_temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Maximum Celsius');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ALTER COLUMN `storage_temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Minimum Celsius');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `delivery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Item Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Storage Location Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `supply_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Agreement Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Uom Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `asn_received_date` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Received Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `asn_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Received Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Delivered Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `delivery_delay_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Delay Days');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `delivery_tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Delivery Tolerance Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms) Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `overdelivery_tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overdelivery Tolerance Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `quantity_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `required_temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Required Maximum Temperature (Celsius)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `required_temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Required Minimum Temperature (Celsius)');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `schedule_adherence_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Adherence Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `schedule_adherence_status` SET TAGS ('dbx_value_regex' = 'on_time|early|late|partial|cancelled');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `schedule_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Schedule Change Reason');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `schedule_line_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'planned|confirmed|in_transit|delivered|cancelled|delayed');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'forecast|firm|just_in_time|blanket_release|contract_release');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `scheduled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `shipping_point` SET TAGS ('dbx_business_glossary_term' = 'Shipping Point');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Shipment Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `underdelivery_tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Underdelivery Tolerance Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_material` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_material` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_material` SET TAGS ('dbx_association_edges' = 'procurement.vendor,masterdata.material');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_material` ALTER COLUMN `approved_vendor_material_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor Material ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_material` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor Material - Masterdata Material Master Id');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_material` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor Material - Vendor Id');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_material` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_material` ALTER COLUMN `approval_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_material` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_material` ALTER COLUMN `conditional_approval_conditions` SET TAGS ('dbx_business_glossary_term' = 'Conditional Approval Conditions');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_material` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_material` ALTER COLUMN `dmf_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Drug Master File Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_material` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_material` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_material` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_material` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_material` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_material` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_material` ALTER COLUMN `pricing_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_material` ALTER COLUMN `quality_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Quality Agreement Reference');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_material` ALTER COLUMN `risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Risk Classification');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_material` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` SET TAGS ('dbx_association_edges' = 'procurement.vendor,compliance.gxp_obligation');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` ALTER COLUMN `vendor_gxp_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor GxP Qualification ID');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` ALTER COLUMN `gxp_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Gxp Qualification - Gxp Obligation Id');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Gxp Qualification - Vendor Id');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency Months');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` ALTER COLUMN `audit_outcome` SET TAGS ('dbx_business_glossary_term' = 'Audit Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` ALTER COLUMN `capa_reference` SET TAGS ('dbx_business_glossary_term' = 'CAPA Reference');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'CAPA Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` ALTER COLUMN `compliance_evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Evidence Reference');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` ALTER COLUMN `gmp_certification_authority` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certification Authority');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` ALTER COLUMN `gmp_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certification Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` ALTER COLUMN `gmp_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certified Flag');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` ALTER COLUMN `qualification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` ALTER COLUMN `qualification_owner` SET TAGS ('dbx_business_glossary_term' = 'Qualification Owner');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`service_entry_sheet` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`service_entry_sheet` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_entry_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `reversed_service_entry_sheet_id` SET TAGS ('dbx_self_ref_fk' = 'true');
