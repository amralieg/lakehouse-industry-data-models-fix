-- Schema for Domain: compliance | Business: Apparel Fashion | Version: v1_ecm
-- Generated on: 2026-05-05 15:54:34

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `apparel_fashion_ecm`.`compliance` COMMENT 'Manages regulatory filings, product safety certifications, ESG reporting obligations, trade compliance, labeling requirements (FTC), and ethical manufacturing audits. Owns compliance calendars, certification tracking, and regulatory change management across all jurisdictions.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` (
    `regulatory_filing_id` BIGINT COMMENT 'Unique identifier for the regulatory filing record. Primary key for the regulatory filing entity.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Regulatory filings report audit results to governing bodies (e.g., factory audit score submitted to FLA). This FK links the filing to the audit being reported. audit_score on filing is redundant with ',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_certification. Business justification: Regulatory filings reference certifications as supporting evidence (e.g., OEKO-TEX certification submitted with EU market entry filing). This FK links the filing to the certification it references. ce',
    `esg_report_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_report. Business justification: Regulatory filings (California Transparency Act, UK Modern Slavery Act, EU CSRD) require ESG data from sustainability reporting systems. Linking enables automated regulatory disclosure generation from',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Regulatory filings are submitted to satisfy compliance obligations (e.g., annual ESG report filing satisfies ESG reporting obligation). This FK links the filing transaction to the obligation it addres',
    `production_factory_id` BIGINT COMMENT 'Reference to the manufacturing facility or production site that is the subject of or associated with this regulatory filing (e.g., for factory audits, safety certifications).',
    `regulatory_change_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_change. Business justification: Regulatory filings may be triggered by regulatory changes (e.g., new REACH regulation requires updated substance disclosure filing). This FK links the filing to the regulatory change that triggered it',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Regulatory filings (CPSC submissions, flammability certifications, safety declarations) are often style-specific. Compliance teams file regulatory submissions for new styles before market launch. Crit',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or manufacturing partner associated with the products or materials covered by this regulatory filing.',
    `approval_date` DATE COMMENT 'The date on which the regulatory filing was officially approved by the governing body or certification authority.',
    `compliance_level` STRING COMMENT 'The assessed level of compliance with the regulatory framework or standard, indicating whether requirements are fully met, conditionally met, or not met.. Valid values are `full_compliance|conditional_compliance|non_compliance|pending_review`',
    `corrective_action_due_date` DATE COMMENT 'The deadline date by which required corrective actions must be completed and documented to achieve compliance.',
    `corrective_action_required` BOOLEAN COMMENT 'Boolean flag indicating whether corrective actions are required to address identified non-conformances or deficiencies before approval can be granted.',
    `country_of_origin` STRING COMMENT 'The three-letter ISO country code representing the country where the products covered by this filing were manufactured or produced.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this regulatory filing record was first created in the system.',
    `due_date` DATE COMMENT 'The deadline date by which the regulatory filing must be submitted to remain compliant with regulatory requirements.',
    `effective_date` DATE COMMENT 'The date from which the regulatory filing or certification becomes legally effective and enforceable.',
    `expiration_date` DATE COMMENT 'The date on which the regulatory filing, certification, or approval expires and requires renewal or re-submission.',
    `filing_cost` DECIMAL(18,2) COMMENT 'The total cost incurred for preparing, submitting, and processing the regulatory filing, including fees, audit costs, and consulting expenses.',
    `filing_currency` STRING COMMENT 'The three-letter ISO 4217 currency code representing the currency in which the filing cost is denominated.. Valid values are `^[A-Z]{3}$`',
    `filing_description` STRING COMMENT 'Detailed textual description of the regulatory filing, including its purpose, scope, and key content or requirements being addressed.',
    `filing_number` STRING COMMENT 'Externally-known unique filing number or reference code assigned by the business or regulatory body for tracking and identification purposes.',
    `filing_status` STRING COMMENT 'Current lifecycle status of the regulatory filing indicating its position in the submission and approval workflow.. Valid values are `draft|submitted|under_review|approved|rejected|withdrawn`',
    `filing_type` STRING COMMENT 'Classification of the regulatory filing indicating the nature of the submission (e.g., textile labeling, product safety certification, trade compliance, ESG reporting, audit report).. Valid values are `textile_labeling|product_safety|certification|trade_compliance|esg_report|audit_report`',
    `governing_body` STRING COMMENT 'The name of the regulatory authority, certification body, or governing organization to which the filing was submitted (e.g., FTC, CPSC, OEKO-TEX, GOTS, FLA, WRAP, BCI).',
    `hs_code` STRING COMMENT 'The Harmonized System code used for international trade classification of the products covered by this filing, required for customs and trade compliance.. Valid values are `^[0-9]{6,10}$`',
    `internal_notes` STRING COMMENT 'Internal business notes, comments, or observations related to the regulatory filing for internal tracking and knowledge management purposes.',
    `jurisdiction` STRING COMMENT 'The geographic or legal jurisdiction under which the regulatory filing applies, typically represented by country code or regional authority (e.g., USA, EUR, CHN).',
    `last_modified_by` STRING COMMENT 'The username or identifier of the system user who last modified this regulatory filing record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this regulatory filing record was last updated or modified in the system.',
    `non_conformance_count` STRING COMMENT 'The number of non-conformances, violations, or deficiencies identified during the regulatory review or audit process.',
    `priority_level` STRING COMMENT 'The business priority assigned to this regulatory filing based on risk, urgency, and business impact.. Valid values are `critical|high|medium|low`',
    `product_category` STRING COMMENT 'The category or classification of products covered by this regulatory filing (e.g., apparel, footwear, accessories, textiles).',
    `regulatory_framework` STRING COMMENT 'The specific regulatory standard, law, or framework under which the filing is made (e.g., OEKO-TEX Standard 100, GOTS, ISO 9001, GDPR, CCPA, FTC Act Section 5).',
    `rejection_reason` STRING COMMENT 'Detailed explanation or reason provided by the regulatory body for rejecting the filing, including specific deficiencies or non-conformances.',
    `renewal_frequency_months` STRING COMMENT 'The number of months between required renewals or re-certifications for this regulatory filing (e.g., 12 for annual, 36 for triennial).',
    `renewal_required` BOOLEAN COMMENT 'Boolean flag indicating whether this regulatory filing or certification requires periodic renewal to maintain compliance status.',
    `responsible_party` STRING COMMENT 'The name or identifier of the individual, department, or organizational unit responsible for preparing and submitting the regulatory filing.',
    `responsible_party_email` STRING COMMENT 'The email address of the responsible party for communication and follow-up regarding the regulatory filing.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `review_completion_date` DATE COMMENT 'The date on which the regulatory body completed its review and assessment of the filing.',
    `reviewer_name` STRING COMMENT 'The name of the regulatory body representative or auditor who reviewed and assessed the filing.',
    `risk_category` STRING COMMENT 'The primary risk category or domain that this regulatory filing addresses (e.g., product safety, environmental compliance, labor standards, trade compliance, financial reporting, data privacy).. Valid values are `product_safety|environmental|labor|trade|financial|data_privacy`',
    `submission_date` DATE COMMENT 'The date on which the regulatory filing was officially submitted to the governing body or regulatory authority.',
    `supporting_document_count` STRING COMMENT 'The number of supporting documents, attachments, or evidence files submitted as part of the regulatory filing package.',
    `created_by` STRING COMMENT 'The username or identifier of the system user who created this regulatory filing record.',
    CONSTRAINT pk_regulatory_filing PRIMARY KEY(`regulatory_filing_id`)
) COMMENT 'Master record for all regulatory filings submitted to governing bodies (FTC, CPSC, OEKO-TEX, GOTS, FLA, WRAP, etc.) across all jurisdictions. Captures filing type, jurisdiction, submission date, due date, status, responsible party, and associated regulatory framework. Serves as the authoritative log of all compliance submissions for apparel and fashion regulatory obligations including textile labeling, product safety, and trade compliance filings.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` (
    `compliance_certification_id` BIGINT COMMENT 'Unique identifier for the compliance certification record. Primary key for the compliance certification entity.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Certifications are issued based on audit results (e.g., GOTS certification issued after successful GOTS audit). This FK links the certification to the audit that verified compliance. audit_date, audit',
    `material_certification_id` BIGINT COMMENT 'Foreign key linking to sustainability.material_certification. Business justification: Compliance certifications (OEKO-TEX, GOTS, BCI) are often material-specific sustainability certifications. Linking enables unified certification tracking across compliance and sustainability reporting',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Material certifications (GOTS for organic cotton, bluesign for sustainable fabrics, recycled content certifications) are tracked at material level. Sourcing teams obtain material certifications from s',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Certifications are issued to satisfy specific compliance obligations. The regulatory_requirement_met STRING field should be normalized to a FK relationship to compliance_obligation, allowing JOIN to r',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Certifications (GOTS organic, bluesign, OEKO-TEX, Fair Trade) are often style-specific. Sustainability/compliance teams obtain certifications for specific styles to support marketing claims and meet r',
    `certificate_document_url` STRING COMMENT 'The URL or file path to the digital copy of the certification certificate document. Provides direct access to the official certificate for verification, audit, and reporting purposes.',
    `certificate_number` STRING COMMENT 'The unique certificate number or identifier issued by the certifying body. This is the externally-known business identifier for the certification (e.g., OEKO-TEX certificate number, GOTS license number).',
    `certification_category` STRING COMMENT 'The high-level category or domain of the certification. Groups certifications by their primary focus area: product safety (e.g., OEKO-TEX Standard 100), sustainability (e.g., bluesign, Cradle to Cradle), ethical manufacturing (e.g., WRAP, FLA, SA8000), quality management (e.g., ISO 9001), environmental management (e.g., ISO 14001), occupational health and safety (e.g., ISO 45001), social accountability (e.g., SA8000), organic standards (e.g., GOTS, OCS), recycled content (e.g., GRS, RCS), or chemical safety (e.g., OEKO-TEX, bluesign). [ENUM-REF-CANDIDATE: product_safety|sustainability|ethical_manufacturing|quality_management|environmental_management|occupational_health_safety|social_accountability|organic|recycled_content|chemical_safety — 10 candidates stripped; promote to reference product]',
    `certification_scope` STRING COMMENT 'The scope or level at which the certification applies. Indicates whether the certification covers a specific product or product line (product), a manufacturing facility or site (facility), the entire organization (organization), a supplier entity (supplier), a specific material or raw material (material), or a production process (process).. Valid values are `product|facility|organization|supplier|material|process`',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification. Indicates whether the certification is currently valid and in force (active), has lapsed (expired), has been temporarily suspended by the certifying body (suspended), has been permanently revoked (withdrawn), is awaiting issuance (pending), or is undergoing renewal or surveillance audit review (under_review).. Valid values are `active|expired|suspended|withdrawn|pending|under_review`',
    `certification_type` STRING COMMENT 'The type or standard of certification. Classifies the certification by its governing standard or program (e.g., OEKO-TEX Standard 100 for textile safety, GOTS for organic textiles, BCI for sustainable cotton, ISO 9001 for quality management, ISO 14001 for environmental management, ISO 45001 for occupational health and safety, WRAP for ethical manufacturing, FLA for labor standards, SA8000 for social accountability, bluesign for sustainable textile production, Cradle to Cradle for circular economy design, GRS for recycled content verification). [ENUM-REF-CANDIDATE: OEKO-TEX Standard 100|OEKO-TEX STEP|GOTS|BCI|GRS|ISO 9001|ISO 14001|ISO 45001|WRAP|FLA|SA8000|bluesign|Cradle to Cradle|Fair Trade|Organic Content Standard|Recycled Claim Standard — 16 candidates stripped; promote to reference product]',
    `certified_entity_country_code` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code for the country where the certified entity is located (e.g., USA, CHN, IND, BGD, VNM, TUR). Used for geographic analysis and compliance reporting by jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `certified_entity_location` STRING COMMENT 'The geographic location (city, state/province, country) of the certified entity. For facility or supplier certifications, this identifies the physical site covered by the certification. For organization-level certifications, this may be the headquarters or registered address.',
    `certified_entity_name` STRING COMMENT 'The name of the entity (organization, facility, supplier, or product line) that holds the certification. This is the legal or business name as it appears on the certificate.',
    `certified_entity_type` STRING COMMENT 'The type of entity that holds the certification. Classifies whether the certified entity is an internal facility owned by Apparel Fashion (internal_facility), an external supplier or vendor (external_supplier), a contract manufacturer or CMT partner (contract_manufacturer), a raw material or component supplier (raw_material_supplier), a specific product line or SKU group (product_line), or the corporate entity itself (corporate_entity).. Valid values are `internal_facility|external_supplier|contract_manufacturer|raw_material_supplier|product_line|corporate_entity`',
    `certified_materials_list` STRING COMMENT 'A comma-separated or structured list of raw materials, fabrics, or components covered by this certification. For material-scope certifications (e.g., organic cotton, recycled polyester), this identifies which specific materials are certified. May include material codes, fiber types, or material categories.',
    `certified_products_list` STRING COMMENT 'A comma-separated or structured list of product categories, SKUs, or product lines covered by this certification. For product-scope certifications, this identifies which specific products or product families are certified under this certificate. May reference product codes, material types, or product categories as defined in the certification scope document.',
    `compliance_jurisdiction` STRING COMMENT 'The regulatory jurisdiction or geographic region for which this certification provides compliance coverage (e.g., European Union, United States, Global). Some certifications are jurisdiction-specific (e.g., CPSC compliance for US market), while others are globally recognized.',
    `cost_amount` DECIMAL(18,2) COMMENT 'The total cost incurred to obtain or renew this certification, including audit fees, application fees, and any consulting or preparation costs. Tracked for budgeting and cost management of the compliance program.',
    `cost_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the cost amount (e.g., USD, EUR, GBP, CNY). Enables multi-currency tracking of certification costs across global operations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this certification record was first created in the system. Audit trail field for data lineage and record creation tracking.',
    `expiry_date` DATE COMMENT 'The date on which the certification expires and is no longer valid unless renewed. Nullable for certifications without a fixed expiration (e.g., one-time product certifications that do not require renewal).',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this certification record is currently active and in use (true) or has been archived or soft-deleted (false). Used for record lifecycle management and filtering active certifications.',
    `issue_date` DATE COMMENT 'The date on which the certification was officially issued or granted by the certifying body. Represents the effective start date of the certification validity period.',
    `issuing_body` STRING COMMENT 'The name of the organization, certification body, or accredited auditor that issued the certification (e.g., OEKO-TEX Association, Control Union, Bureau Veritas, SGS, TÜV, Intertek). This is the authoritative source of the certification.',
    `issuing_body_accreditation_number` STRING COMMENT 'The accreditation number or identifier of the issuing body, demonstrating that the certifying organization is itself accredited by a recognized accreditation authority (e.g., ANAB, UKAS, DAkkS). Ensures the legitimacy and authority of the issuing body.',
    `modified_by` STRING COMMENT 'The user ID or name of the person who last modified this certification record in the system. Audit trail field for change accountability and data governance.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this certification record was last modified or updated in the system. Audit trail field for change tracking and data quality management.',
    `next_audit_due_date` DATE COMMENT 'The scheduled date for the next surveillance or renewal audit. Used for compliance calendar management and proactive audit planning to ensure continuous certification validity.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about the certification. May include details about audit findings, corrective actions taken, special conditions, or other relevant information not captured in structured fields.',
    `public_verification_url` STRING COMMENT 'The URL to a public online verification portal where the certification can be independently verified by customers, regulators, or other stakeholders (e.g., OEKO-TEX certificate verification portal, GOTS public database). Many certification bodies provide online verification tools.',
    `renewal_application_date` DATE COMMENT 'The date on which the renewal application was submitted to the certifying body. Tracks the initiation of the renewal process for certifications that require periodic renewal.',
    `renewal_status` STRING COMMENT 'The current status of the certification renewal process. Indicates whether renewal is not required for this certification type (not_required), renewal is upcoming but not yet initiated (pending), renewal application or audit is in progress (in_progress), renewal has been successfully completed (completed), or renewal is overdue and the certification may lapse (overdue).. Valid values are `not_required|pending|in_progress|completed|overdue`',
    `responsible_party_email` STRING COMMENT 'The email address of the responsible party for this certification. Used for notifications, renewal reminders, and audit coordination communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_party_name` STRING COMMENT 'The name of the individual or team within Apparel Fashion responsible for managing this certification, including renewal tracking, audit coordination, and compliance maintenance. This is the internal owner or steward of the certification.',
    `standard_version` STRING COMMENT 'The version or edition of the certification standard under which the certification was issued (e.g., OEKO-TEX Standard 100 version 2023, GOTS version 6.0, ISO 9001:2015). Standards are periodically updated, and this field tracks which version applies to this certification.',
    `created_by` STRING COMMENT 'The user ID or name of the person who created this certification record in the system. Audit trail field for accountability and data governance.',
    CONSTRAINT pk_compliance_certification PRIMARY KEY(`compliance_certification_id`)
) COMMENT 'Master record for all product safety, sustainability, and ethical manufacturing certifications held by Apparel Fashion or its suppliers. Covers OEKO-TEX Standard 100/STEP, GOTS (Global Organic Textile Standard), BCI (Better Cotton Initiative), GRS (Global Recycled Standard), ISO 9001/14001/45001, WRAP, FLA, SA8000, bluesign, Cradle to Cradle, and other industry certifications. Tracks certificate number, issuing body, certification scope (product, facility, or organization level), issue date, expiry date, renewal status, audit linkage, and certified entity. Manages the full certification lifecycle from application through issuance, surveillance audits, renewal, and expiration/withdrawal.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`compliance`.`obligation` (
    `obligation_id` BIGINT COMMENT 'Unique identifier for the compliance obligation record. Primary key.',
    `target_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_target. Business justification: Compliance obligations (EU Green Deal, plastic packaging taxes, Extended Producer Responsibility) drive sustainability targets with regulatory deadlines. Linking enables regulatory-driven target setti',
    `actual_completion_date` DATE COMMENT 'Actual date when compliance activities or remediation actions were completed.',
    `applicable_business_process` STRING COMMENT 'Core business process or operational area to which this compliance obligation applies (e.g., Product Design and Development, Sourcing and Procurement, Manufacturing and Production, E-Commerce and Digital Commerce).',
    `applicable_product_category` STRING COMMENT 'Product category or SKU classification to which this obligation applies (e.g., athletic apparel, childrens clothing, footwear, accessories). Null if obligation applies to all products.',
    `audit_scheduled_date` DATE COMMENT 'Planned date for the next compliance audit or inspection activity.',
    `business_process_owner` STRING COMMENT 'Name or identifier of the individual who is the designated process owner and primary point of accountability for this obligation.',
    `calendar_entry_status` STRING COMMENT 'Current status of this obligation within the compliance calendar: upcoming (not yet due), overdue (past deadline), completed (fulfilled), waived (exemption granted), or cancelled (no longer required).. Valid values are `upcoming|overdue|completed|waived|cancelled`',
    `certification_renewal_date` DATE COMMENT 'Date when certification or accreditation must be renewed to maintain compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance obligation record was first created in the system.',
    `documentation_required` STRING COMMENT 'Description of documentation, records, or evidence that must be maintained to demonstrate compliance (e.g., test reports, certificates of conformity, audit reports, training records).',
    `effective_date` DATE COMMENT 'Date when this compliance obligation becomes legally binding and enforceable.',
    `escalation_path` STRING COMMENT 'Defined escalation hierarchy or contact chain for unresolved compliance issues (e.g., Manager > Director > VP > Chief Compliance Officer).',
    `escalation_trigger_days` STRING COMMENT 'Number of days before or after the deadline when escalation to senior management should occur if compliance is not achieved.',
    `expiration_date` DATE COMMENT 'Date when this compliance obligation ceases to be applicable or is superseded. Null for ongoing obligations.',
    `external_reference_url` STRING COMMENT 'Web link to the official regulatory text, standard document, or governing body website for this obligation.',
    `filing_deadline` DATE COMMENT 'Due date for submitting required compliance filings, reports, or certifications to the governing body.',
    `governing_body` STRING COMMENT 'Name of the regulatory or standards organization that issues and enforces this obligation (e.g., FTC, CPSC, ISO, OEKO-TEX, BCI, FLA, WRAP).',
    `internal_policy_reference` STRING COMMENT 'Reference to internal company policy, procedure document, or compliance manual that governs how this obligation is implemented.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this compliance obligation is currently active and enforceable (True) or has been deactivated or archived (False).',
    `jurisdiction` STRING COMMENT 'Geographic or legal jurisdiction where this obligation applies (country, region, or multi-national scope). Use 3-letter ISO country codes where applicable (e.g., USA, GBR, DEU) or regional identifiers.',
    `last_review_date` DATE COMMENT 'Date when the most recent compliance review or assessment was completed.',
    `maximum_penalty_amount` DECIMAL(18,2) COMMENT 'Maximum financial penalty or fine amount (in USD) that could be imposed for non-compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance obligation record was last updated or modified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next compliance review or assessment activity.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or clarifications related to this compliance obligation.',
    `obligation_code` STRING COMMENT 'Unique business identifier code for the compliance obligation, used for external reference and reporting.. Valid values are `^[A-Z0-9]{6,20}$`',
    `obligation_name` STRING COMMENT 'Full descriptive name of the compliance obligation.',
    `obligation_status` STRING COMMENT 'Current lifecycle status of the compliance obligation.. Valid values are `active|inactive|pending|suspended|archived`',
    `obligation_type` STRING COMMENT 'Category of compliance obligation: labeling (FTC requirements), safety (CPSC standards), ESG (environmental/social/governance reporting), trade (customs/tariffs), labor (FLA/WRAP standards), or chemical (OEKO-TEX/GOTS).. Valid values are `labeling|safety|esg|trade|labor|chemical`',
    `penalty_description` STRING COMMENT 'Description of potential penalties, fines, sanctions, or legal consequences for non-compliance with this obligation.',
    `planned_completion_date` DATE COMMENT 'Target date by which compliance activities or remediation actions are planned to be completed.',
    `regulatory_citation` STRING COMMENT 'Specific legal or regulatory reference (statute, regulation number, standard code) that defines this obligation.',
    `reminder_trigger_days` STRING COMMENT 'Number of days before the deadline when automated reminders should be sent to responsible parties.',
    `responsible_team` STRING COMMENT 'Name of the business unit, department, or team assigned ownership and accountability for this compliance obligation.',
    `retention_period_years` STRING COMMENT 'Number of years that compliance documentation and records must be retained per regulatory or legal requirements.',
    `review_frequency` STRING COMMENT 'Scheduled frequency for reviewing and validating compliance with this obligation.. Valid values are `annual|semi_annual|quarterly|monthly|ad_hoc`',
    `risk_level` STRING COMMENT 'Assessed risk level associated with non-compliance: critical (severe legal/financial/reputational impact), high (significant impact), medium (moderate impact), or low (minimal impact).. Valid values are `critical|high|medium|low`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the compliance obligation has breached the internal SLA threshold (True) or is within acceptable timeframes (False).',
    `sla_threshold_days` STRING COMMENT 'Maximum number of days allowed to complete compliance activities before breaching the internal SLA.',
    CONSTRAINT pk_obligation PRIMARY KEY(`obligation_id`)
) COMMENT 'Master record defining each distinct regulatory, ethical, or sustainability compliance obligation applicable to Apparel Fashion, serving as both the obligation registry and the unified compliance calendar. Captures obligation type (labeling, safety, ESG, trade, labor, chemical), governing body, applicable jurisdiction, regulatory citation, effective date, review frequency, and business process owner. Manages the full compliance scheduling lifecycle as the single operational calendar: filing deadlines, certification renewal dates, audit scheduling windows, planned vs. actual completion dates, reminder triggers, escalation paths, SLA breach thresholds, responsible team assignments, and calendar entry status (upcoming, overdue, completed, waived). Acts as the single authoritative source for what the company must comply with, when each activity is due, and who owns it — replacing any need for a separate calendar entity. Foundation for all proactive compliance tracking, deadline management, and regulatory calendar operations across FTC labeling, CPSC safety, ESG reporting, trade compliance, and ethical sourcing programs.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`compliance`.`audit` (
    `audit_id` BIGINT COMMENT 'Unique identifier for the compliance or ethical manufacturing audit record. Primary key for the audit entity.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Audits are conducted to verify compliance with specific obligations (e.g., GOTS audit verifies organic cotton obligation). This FK links the audit to the obligation being verified. audit_program is ke',
    `production_factory_id` BIGINT COMMENT 'Identifier of the facility (factory, warehouse, distribution center, or supplier site) where the audit was conducted.',
    `supplier_esg_assessment_id` BIGINT COMMENT 'Foreign key linking to sustainability.supplier_esg_assessment. Business justification: Social compliance audits (WRAP, BSCI, SA8000) and ESG assessments often cover same facilities on overlapping schedules. Linking enables consolidated supplier risk profiles, avoids duplicate audit sche',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or vendor organization that owns or operates the audited facility. Links the audit to the supplier master record for supply chain compliance tracking.',
    `approved_for_production_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the facility is approved for production based on audit results. False if critical findings or zero-tolerance violations were identified. Used in factory approval workflows and sourcing decisions.',
    `audit_date` DATE COMMENT 'Date on which the audit was conducted or completed. Primary business event timestamp for the audit record.',
    `audit_number` STRING COMMENT 'Externally-known unique audit reference number assigned by the auditing organization or internal compliance team. Used for tracking and reporting purposes.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `audit_scope` STRING COMMENT 'Detailed description of the audit scope, including specific areas, processes, departments, or compliance domains covered during the audit. May include production lines, warehousing operations, chemical management, worker dormitories, or specific regulatory requirements.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit. Tracks the audit from scheduling through completion and review stages.. Valid values are `scheduled|in_progress|completed|cancelled|pending_review`',
    `audit_type` STRING COMMENT 'Classification of the audit based on its primary focus area: social compliance (labor practices), environmental compliance (sustainability), quality assurance, safety standards, or combined multi-disciplinary audit.. Valid values are `social|environmental|quality|safety|combined`',
    `auditor_name` STRING COMMENT 'Full name of the lead auditor or audit firm responsible for conducting the audit. Confidential business information for audit integrity and accountability.',
    `auditor_organization` STRING COMMENT 'Name of the auditing organization, firm, or certification body that performed the audit. Confidential business information.',
    `auditor_type` STRING COMMENT 'Classification of the auditor conducting the audit: internal (company compliance team), third-party (independent audit firm), or certification body (accredited certification organization).. Valid values are `internal|third_party|certification_body`',
    `certification_expiry_date` DATE COMMENT 'Date when the certification granted by this audit expires. Applicable for certification-based audit programs. Used for compliance calendar management and recertification planning.',
    `certification_status` STRING COMMENT 'Certification status resulting from the audit for programs that grant certification (e.g., WRAP, SA8000, OEKO-TEX). Indicates whether the facility achieved, maintained, or lost certification based on audit results.. Valid values are `certified|provisional|suspended|revoked|not_applicable`',
    `compliance_percentage` DECIMAL(18,2) COMMENT 'Percentage of audit criteria or checkpoints that the facility met or passed. Calculated as (compliant items / total items audited) * 100.',
    `corrective_action_plan_due_date` DATE COMMENT 'Date by which the facility must submit a formal corrective action plan addressing audit findings. Part of the remediation workflow and compliance tracking process.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether corrective action is required based on audit findings. True if any critical, major, or actionable findings were identified that require formal corrective action plans.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for conducting the audit, including auditor fees, travel expenses, and administrative costs. Confidential financial information used for compliance program budgeting and cost allocation.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the audit cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the facility where the audit was conducted. Used for geographic compliance reporting and regional risk analysis.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was first created in the system. Part of audit trail for data governance and compliance tracking.',
    `critical_findings_count` STRING COMMENT 'Number of critical or zero-tolerance violations identified during the audit. Critical findings typically require immediate corrective action and may result in facility suspension.',
    `end_date` DATE COMMENT 'Date when the on-site audit activities concluded. Used to calculate audit duration and resource allocation.',
    `follow_up_audit_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a follow-up audit is required to verify implementation of corrective actions. Typically true for facilities with critical or major findings.',
    `major_findings_count` STRING COMMENT 'Number of major non-conformances or significant violations identified during the audit. Major findings require corrective action plans with defined timelines.',
    `minor_findings_count` STRING COMMENT 'Number of minor non-conformances or observations identified during the audit. Minor findings represent opportunities for improvement but do not pose immediate risk.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified the audit record. Part of audit trail for accountability and change management.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was last modified or updated. Part of audit trail for data governance and change tracking.',
    `next_audit_date` DATE COMMENT 'Date when the next audit is scheduled or recommended based on audit frequency requirements, previous audit results, and risk assessment. Critical for compliance calendar management and factory approval workflows.',
    `overall_rating` STRING COMMENT 'Overall qualitative rating or grade assigned to the facility based on audit findings. Used for supplier scorecarding, factory approval decisions, and risk-based sourcing strategies.. Valid values are `excellent|good|acceptable|needs_improvement|unacceptable|zero_tolerance`',
    `overall_score` DECIMAL(18,2) COMMENT 'Numerical score assigned to the facility based on audit findings, typically expressed as a percentage (0-100) or point scale. Enables quantitative benchmarking and trend analysis across facilities and audit cycles.',
    `program` STRING COMMENT 'Name of the audit program or standard under which the audit was conducted. Examples include FLA (Fair Labor Association), WRAP (Worldwide Responsible Accredited Production), BSCI (Business Social Compliance Initiative), SA8000, Higg FEM (Facility Environmental Module), Higg FSLM (Facility Social and Labor Module), or internal proprietary audit programs.',
    `protocol_version` STRING COMMENT 'Version number of the audit protocol or standard methodology used during the audit. Ensures traceability of audit criteria and comparability across audit cycles.. Valid values are `^[0-9]{1,2}.[0-9]{1,2}(.[0-9]{1,2})?$`',
    `region` STRING COMMENT 'Geographic region or sourcing region where the audited facility is located (e.g., Asia Pacific, Europe, Americas, Middle East). Used for regional compliance reporting and supply chain analytics.',
    `report_url` STRING COMMENT 'URL or file path to the full audit report document stored in the document management system. Confidential business information containing detailed findings and recommendations.. Valid values are `^https?://.*$`',
    `risk_level` STRING COMMENT 'Risk level classification assigned to the facility based on audit results. Used for risk-based sourcing decisions, audit frequency determination, and supply chain risk management.. Valid values are `low|medium|high|critical`',
    `scheduled_date` DATE COMMENT 'Originally scheduled date for the audit. Used for compliance calendar management and audit planning.',
    `start_date` DATE COMMENT 'Date when the on-site audit activities commenced. Relevant for multi-day audits to track audit duration.',
    `summary` STRING COMMENT 'Executive summary or key highlights from the audit report. Provides high-level overview of audit findings, strengths, and areas for improvement. Confidential business information.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created the audit record in the system. Part of audit trail for accountability and data governance.',
    CONSTRAINT pk_audit PRIMARY KEY(`audit_id`)
) COMMENT 'Master record for all compliance and ethical manufacturing audits conducted at factories, warehouses, and supplier facilities. Covers FLA, WRAP, BSCI, SA8000, Higg FEM/FSLM, and internal audit programs. Captures audit type (social, environmental, quality, safety), audit scope, auditor identity (internal or third-party firm), facility audited, audit date, overall rating/score, corrective action requirement flag, next scheduled audit date, and audit protocol version. Central entity for ethical sourcing oversight, factory approval workflows, and supply chain compliance verification.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` (
    `compliance_audit_finding_id` BIGINT COMMENT 'Unique identifier for the compliance audit finding record. Primary key for the compliance audit finding entity.',
    `audit_id` BIGINT COMMENT 'Reference to the parent compliance audit during which this finding was identified. Links the finding to the broader audit event.',
    `corrective_action_plan_id` BIGINT COMMENT 'Reference to the formal corrective action plan created to address this finding. Links the finding to the remediation workflow and tracking system.',
    `higg_index_assessment_id` BIGINT COMMENT 'Foreign key linking to sustainability.higg_index_assessment. Business justification: Audit findings (wastewater violations, energy management gaps) directly inform Higg FEM/FSLM verification scores and improvement action plans. Linking enables finding-to-Higg-score traceability, suppo',
    `previous_finding_compliance_audit_finding_id` BIGINT COMMENT 'Reference to the prior finding record if this is a recurrence. Enables tracking of persistent compliance issues across audit cycles.',
    `production_factory_id` BIGINT COMMENT 'Reference to the specific manufacturing facility, warehouse, or operational site where the non-conformance was observed.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or manufacturing facility where the finding was identified. Links the finding to the audited party for remediation tracking.',
    `affected_product_category` STRING COMMENT 'Product category or line impacted by the finding, if applicable. Relevant for quality, safety, or labeling non-conformances that affect specific merchandise.',
    `affected_sku_count` STRING COMMENT 'Number of distinct SKUs impacted by the finding. Used to quantify the scope of product-related compliance issues.',
    `auditor_name` STRING COMMENT 'Name of the auditor or audit team member who identified and documented the finding. Provides accountability and traceability.',
    `auditor_organization` STRING COMMENT 'Name of the auditing organization or certification body that conducted the audit. May be internal audit team, third-party auditor, or accredited certification body.',
    `business_impact` STRING COMMENT 'Primary type of business impact if the finding is not remediated. Categories include reputational damage, financial penalties, operational disruption, legal liability, or supply chain interruption.. Valid values are `reputational|financial|operational|legal|supply_chain`',
    `closed_by` STRING COMMENT 'Name or identifier of the user or auditor who verified remediation and closed the finding. Provides accountability for closure decisions.',
    `closure_date` DATE COMMENT 'Date on which the finding was verified as remediated and officially closed. Null if the finding is still open or in remediation.',
    `corrective_action_required` STRING COMMENT 'Recommended corrective action to remediate the finding and prevent recurrence. Describes specific steps the audited entity must take to achieve compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the finding record was first created in the system. Represents the audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated remediation cost. Ensures consistent financial reporting across global operations.. Valid values are `^[A-Z]{3}$`',
    `due_date` DATE COMMENT 'Target date by which the corrective action must be completed and verified. Driven by severity level and regulatory timelines.',
    `escalation_level` STRING COMMENT 'Level to which the finding has been escalated within the organization. Reflects the governance and oversight required based on severity and business impact.. Valid values are `none|management|executive|board|external`',
    `estimated_remediation_cost` DECIMAL(18,2) COMMENT 'Estimated financial cost to implement the corrective action, including capital expenditure, training, process changes, and verification activities. Expressed in the companys reporting currency.',
    `evidence_file_path` STRING COMMENT 'File path or URI to supporting evidence documentation such as photographs, documents, or audit reports that substantiate the finding.',
    `finding_category` STRING COMMENT 'High-level classification of the non-conformance area. Categories include labor practices, workplace safety, environmental impact, product quality, ethical sourcing, and trade compliance.. Valid values are `labor|safety|environmental|quality|ethical|trade_compliance`',
    `finding_date` DATE COMMENT 'Date on which the non-conformance was observed and documented during the audit. Represents the business event timestamp for the finding.',
    `finding_number` STRING COMMENT 'Business-readable unique identifier for the finding within the audit context. Typically follows a pattern such as audit code followed by sequential number.. Valid values are `^[A-Z0-9]{2,4}-[0-9]{4,6}$`',
    `finding_status` STRING COMMENT 'Current lifecycle state of the finding. Tracks progression from identification through remediation to closure.. Valid values are `open|in_remediation|pending_verification|closed|escalated`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the finding record. Tracks changes throughout the finding lifecycle from identification to closure.',
    `recurrence_flag` BOOLEAN COMMENT 'Boolean indicator of whether this finding is a repeat of a previously identified and supposedly remediated non-conformance. True indicates a recurring issue requiring escalation.',
    `regulatory_body` STRING COMMENT 'Name of the regulatory authority or governing body to which the finding must be reported, if applicable. Examples include FTC, CPSC, OSHA, EPA, or international equivalents.',
    `regulatory_reference` STRING COMMENT 'Citation of the specific regulation, standard, code of conduct clause, or policy requirement that was violated. May reference FTC labeling rules, CPSC safety standards, FLA workplace standards, OEKO-TEX criteria, or internal codes of conduct.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Boolean flag indicating whether this finding must be reported to a regulatory authority or governing body. True for findings that trigger mandatory disclosure obligations.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk assessment score for the finding, typically on a scale of 0-100. Combines severity, likelihood of harm, and potential business impact.',
    `root_cause` STRING COMMENT 'Analysis of the underlying reason or systemic issue that led to the non-conformance. Identifies whether the cause was procedural, training-related, resource-based, or systemic.',
    `severity_level` STRING COMMENT 'Classification of the findings impact and urgency. Critical findings require immediate action, major findings require corrective action plans, minor findings are improvement opportunities, and observations are advisory notes.. Valid values are `critical|major|minor|observation`',
    `standard_clause` STRING COMMENT 'Specific clause, section, or article number within the referenced standard or regulation that was not met. Enables precise traceability to compliance requirements.',
    `verification_method` STRING COMMENT 'Method used to verify that the corrective action was effectively implemented. Options include document review, on-site re-inspection, photographic evidence submission, worker interviews, or full re-audit.. Valid values are `document_review|on_site_inspection|photographic_evidence|interview|re_audit`',
    `verification_notes` STRING COMMENT 'Detailed notes from the verification process, including evidence reviewed, observations made, and rationale for verification decision.',
    `verification_status` STRING COMMENT 'Current status of the verification process for the corrective action. Tracks whether remediation has been confirmed as effective.. Valid values are `not_started|pending|verified|rejected|partially_verified`',
    `violation_description` STRING COMMENT 'Detailed narrative description of the specific non-conformance observed during the audit. Includes factual observations, evidence collected, and context of the violation.',
    CONSTRAINT pk_compliance_audit_finding PRIMARY KEY(`compliance_audit_finding_id`)
) COMMENT 'Detailed finding record generated from a compliance or ethical manufacturing audit. Each finding captures the non-conformance category (labor, safety, environmental, quality), severity level (critical, major, minor), specific violation description, regulatory or code-of-conduct reference, root cause, and recommended corrective action. Linked to the parent audit record and drives the corrective action plan (CAP) workflow for factory remediation.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` (
    `corrective_action_plan_id` BIGINT COMMENT 'Unique identifier for the corrective action plan record. Primary key for the corrective action plan entity.',
    `audit_id` BIGINT COMMENT 'Reference to the audit that generated this corrective action plan. Links to the source audit inspection or compliance review.',
    `employee_id` BIGINT COMMENT 'Identifier of the specific factory, supplier, or internal team responsible for executing the corrective action plan.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_initiative. Business justification: Corrective action plans often require sustainability investments (wastewater treatment systems, energy-efficient equipment, chemical substitution). Linking enables tracking remediation as sustainabili',
    `previous_cap_corrective_action_plan_id` BIGINT COMMENT 'Reference to a previous corrective action plan for the same or related issue, used to track recurring non-conformances.',
    `production_factory_id` BIGINT COMMENT 'Identifier of the manufacturing facility, warehouse, or distribution center where the corrective action is being implemented.',
    `actual_completion_date` DATE COMMENT 'Actual date when the corrective action was completed and submitted for verification. Null if not yet completed.',
    `cap_number` STRING COMMENT 'Business-facing unique identifier for the corrective action plan, used in communications with suppliers, factories, and internal teams.. Valid values are `^CAP-[0-9]{6,10}$`',
    `cap_title` STRING COMMENT 'Brief descriptive title summarizing the corrective action plan focus area or issue being addressed.',
    `closure_date` DATE COMMENT 'Date when the corrective action plan was officially closed after successful verification and acceptance. Null if not yet closed.',
    `closure_notes` STRING COMMENT 'Final notes and comments recorded at the time of corrective action plan closure, summarizing outcomes and lessons learned.',
    `compliance_category` STRING COMMENT 'Primary compliance domain or category of the corrective action: labor standards, health and safety, environmental, product safety, trade compliance, or ethical sourcing.. Valid values are `labor_standards|health_safety|environmental|product_safety|trade_compliance|ethical_sourcing`',
    `corrective_action_description` STRING COMMENT 'Detailed description of the remediation steps, actions, and measures required to address the non-conformance and prevent recurrence.',
    `corrective_action_plan_status` STRING COMMENT 'Current lifecycle status of the corrective action plan: open (newly issued), in progress (being implemented), pending verification (awaiting inspection), verified (confirmed complete), closed (fully resolved), overdue (past target date), escalated (requires management intervention). [ENUM-REF-CANDIDATE: open|in_progress|pending_verification|verified|closed|overdue|escalated — 7 candidates stripped; promote to reference product]',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost estimate (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost to implement the corrective action, including materials, labor, training, and any infrastructure improvements required.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action plan record was first created in the system.',
    `escalation_date` DATE COMMENT 'Date when the corrective action plan was escalated to higher management levels. Null if no escalation has occurred.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the corrective action plan has been escalated to senior management or executive leadership due to severity, delays, or non-compliance.',
    `escalation_reason` STRING COMMENT 'Explanation of why the corrective action plan was escalated, such as repeated non-compliance, critical safety risk, or failure to meet deadlines.',
    `finding_id` BIGINT COMMENT 'Reference to the specific audit finding or non-conformance that triggered this corrective action plan.',
    `impact_assessment` STRING COMMENT 'Assessment of the business, operational, and reputational impact of the non-conformance and the expected benefits of the corrective action.',
    `issue_description` STRING COMMENT 'Detailed description of the non-conformance, violation, or deficiency identified during the audit that requires corrective action.',
    `jurisdiction` STRING COMMENT 'Three-letter country code representing the legal jurisdiction or geographic location where the corrective action is being implemented.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action plan record was last updated or modified.',
    `preventive_measures` STRING COMMENT 'Description of preventive measures and systemic changes implemented to prevent recurrence of the non-conformance in the future.',
    `product_category` STRING COMMENT 'Product category or line affected by the non-conformance and corrective action (e.g., footwear, apparel, accessories).',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this corrective action addresses a recurring issue that has been identified in previous audits or inspections.',
    `regulatory_framework` STRING COMMENT 'Specific regulatory framework, standard, or certification program that governs this corrective action (e.g., FLA, WRAP, OEKO-TEX, GOTS, ISO 9001, local labor law).',
    `responsible_contact_email` STRING COMMENT 'Email address of the primary contact person responsible for corrective action implementation and reporting.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_contact_name` STRING COMMENT 'Name of the primary contact person at the responsible party organization who is accountable for corrective action execution.',
    `responsible_contact_phone` STRING COMMENT 'Phone number of the primary contact person responsible for corrective action execution.',
    `responsible_party_name` STRING COMMENT 'Name of the factory, supplier, or internal team responsible for implementing the corrective action.',
    `responsible_party_type` STRING COMMENT 'Type of entity responsible for implementing the corrective action: factory, supplier, internal team, third-party vendor, or logistics partner.. Valid values are `factory|supplier|internal_team|third_party_vendor|logistics_partner`',
    `root_cause_analysis` STRING COMMENT 'Analysis of the underlying root cause of the non-conformance or violation, identifying systemic issues rather than symptoms.',
    `severity_level` STRING COMMENT 'Classification of the severity or risk level of the non-conformance: critical (immediate safety/legal risk), major (significant compliance breach), moderate (process deficiency), minor (documentation gap).. Valid values are `critical|major|moderate|minor`',
    `target_completion_date` DATE COMMENT 'Planned or agreed-upon date by which the corrective action must be completed and verified.',
    `training_completion_date` DATE COMMENT 'Date when required training was completed as part of the corrective action. Null if training is not required or not yet completed.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether employee or supplier training is required as part of the corrective action plan implementation.',
    `verification_date` DATE COMMENT 'Date when the corrective action was verified as complete and effective. Null if verification has not yet occurred.',
    `verification_method` STRING COMMENT 'Method used to verify completion and effectiveness of the corrective action: on-site inspection, document review, photo evidence, video evidence, third-party audit, or self-assessment.. Valid values are `on_site_inspection|document_review|photo_evidence|video_evidence|third_party_audit|self_assessment`',
    `verification_notes` STRING COMMENT 'Detailed notes from the verification process, including observations, evidence reviewed, and any remaining concerns or follow-up items.',
    `verifier_name` STRING COMMENT 'Name of the auditor, compliance officer, or third-party inspector who verified the corrective action completion.',
    CONSTRAINT pk_corrective_action_plan PRIMARY KEY(`corrective_action_plan_id`)
) COMMENT 'Corrective Action Plan (CAP) record created in response to audit findings or regulatory violations. Captures the remediation steps required, responsible party (factory, supplier, or internal team), target completion date, actual completion date, verification method, and closure status. Tracks the full lifecycle of corrective actions from issuance through verification and closure, supporting FLA, WRAP, and internal ethical sourcing programs.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` (
    `product_safety_test_id` BIGINT COMMENT 'Unique identifier for the product safety test record. Primary key.',
    `cad_file_id` BIGINT COMMENT 'Foreign key linking to design.cad_file. Business justification: Safety testing references specific CAD files for construction details affecting test outcomes (drawstring length, small parts, fabric layering for flammability). Essential for traceability when tests ',
    `chemical_compliance_id` BIGINT COMMENT 'Foreign key linking to sustainability.chemical_compliance. Business justification: Safety testing and chemical compliance testing often use same samples, labs, and test methods (e.g., CPSIA lead testing overlaps with ZDHC MRSL screening). Linking enables unified chemical risk manage',
    `colorway_id` BIGINT COMMENT 'Foreign key linking to product.colorway. Business justification: Safety tests (lead content, phthalates, azo dyes, flammability) are conducted on specific colorways because dyes and finishes can introduce restricted substances. QA/compliance teams test each colorwa',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_certification. Business justification: Product safety tests generate results that support certification issuance (e.g., flammability test results support CPSC certification). This FK links the test record to the certification it supports. ',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Material-level safety tests (restricted substance testing, flammability, colorfastness) are conducted before style development. Sourcing teams require material-level test reports from suppliers; compl',
    `product_sample_id` BIGINT COMMENT 'Unique identifier of the physical sample submitted for testing. Enables traceability to the specific unit tested.',
    `production_factory_id` BIGINT COMMENT 'Identifier of the specific manufacturing facility where the tested product was produced.',
    `sketch_id` BIGINT COMMENT 'Foreign key linking to design.design_sketch. Business justification: Safety tests (flammability, small parts, chemical) initiated during sketch phase to validate design concepts before tech pack investment. Links test results to originating design for early-stage compl',
    `sku_id` BIGINT COMMENT 'Identifier of the SKU tested. Links to the specific product variant subjected to safety testing.',
    `style_id` BIGINT COMMENT 'Identifier of the style tested. Links to the design or collection being validated for safety compliance.',
    `testing_laboratory_vendor_id` BIGINT COMMENT 'Identifier of the accredited laboratory that performed the safety test.',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or manufacturer whose product was tested. Used for supplier quality tracking.',
    `age_group` STRING COMMENT 'Target age group for the product. Critical for determining applicable safety standards, especially for childrens products.. Valid values are `infant|toddler|child|youth|adult`',
    `certification_required` BOOLEAN COMMENT 'Indicates whether this test is required for a formal certification (e.g., OEKO-TEX, CPSC compliance certificate).',
    `comments` STRING COMMENT 'Additional notes, observations, or context related to the safety test.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this test record was first created in the system.',
    `failure_reason` STRING COMMENT 'Detailed explanation of why the test failed, including specific non-conformance details.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this test record was last updated.',
    `product_category` STRING COMMENT 'High-level category of the product tested. Used to determine applicable safety standards. [ENUM-REF-CANDIDATE: apparel|footwear|accessories|childrenswear|activewear|outerwear|sleepwear|swimwear — 8 candidates stripped; promote to reference product]',
    `production_batch_number` STRING COMMENT 'Batch or lot number of the production run from which the test sample was drawn.',
    `regulatory_jurisdiction` STRING COMMENT 'Geographic jurisdiction or market for which this test was conducted (e.g., USA, EU, China). Determines applicable regulatory standards.',
    `remediation_action` STRING COMMENT 'Description of the corrective action plan to address test failures or non-conformances.',
    `remediation_due_date` DATE COMMENT 'Target date by which remediation actions must be completed.',
    `remediation_required` BOOLEAN COMMENT 'Indicates whether corrective action is required based on the test result.',
    `retest_date` DATE COMMENT 'Scheduled or actual date for retesting the product.',
    `retest_required` BOOLEAN COMMENT 'Indicates whether the product must be retested after remediation or due to inconclusive results.',
    `sample_size` STRING COMMENT 'Number of units or specimens tested in this safety test.',
    `season_code` STRING COMMENT 'Season or collection identifier for which the product was tested (e.g., SS24, FW24).. Valid values are `^[A-Z]{2}[0-9]{2}$`',
    `test_approved_by` STRING COMMENT 'Name or identifier of the quality manager or compliance officer who approved the test results.',
    `test_approved_date` DATE COMMENT 'Date on which the test results were formally approved by the quality or compliance team.',
    `test_cost` DECIMAL(18,2) COMMENT 'Cost incurred for conducting the safety test, typically charged by the testing laboratory.',
    `test_cost_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the test cost.. Valid values are `^[A-Z]{3}$`',
    `test_date` DATE COMMENT 'Date on which the safety test was performed. Principal business event timestamp for the test lifecycle.',
    `test_number` STRING COMMENT 'Externally-known unique identifier for the safety test, typically assigned by the testing laboratory or internal quality system.. Valid values are `^[A-Z0-9]{6,20}$`',
    `test_report_url` STRING COMMENT 'URL or file path to the detailed laboratory test report document.',
    `test_requested_by` STRING COMMENT 'Name or identifier of the person or department that requested the safety test.',
    `test_result` STRING COMMENT 'Outcome of the safety test indicating whether the product met the required standard.. Valid values are `pass|fail|conditional_pass|pending|retest_required`',
    `test_standard` STRING COMMENT 'Specific regulatory or industry standard against which the test was conducted (e.g., CPSC 16 CFR 1610, ASTM D1230, OEKO-TEX Standard 100, ISO 12947).',
    `test_status` STRING COMMENT 'Current lifecycle status of the test record in the quality management workflow.. Valid values are `scheduled|in_progress|completed|cancelled|on_hold`',
    `test_type` STRING COMMENT 'Category of safety or performance test conducted. Defines the specific hazard or quality attribute being evaluated. [ENUM-REF-CANDIDATE: flammability|chemical_content|tensile_strength|colorfastness|abrasion_resistance|dimensional_stability|pilling_resistance|seam_strength|zipper_durability|button_pull|sharp_edges|small_parts|lead_content|azo_dyes|formaldehyde|phthalates — 16 candidates stripped; promote to reference product]',
    `testing_laboratory_name` STRING COMMENT 'Name of the accredited laboratory that conducted the test.',
    `threshold_operator` STRING COMMENT 'Comparison operator defining how the test measurement is evaluated against the threshold (e.g., must be less than threshold for chemical content).. Valid values are `greater_than|less_than|equal_to|greater_than_or_equal|less_than_or_equal`',
    `threshold_value` DECIMAL(18,2) COMMENT 'Regulatory or internal threshold that the test result must meet or exceed to pass.',
    CONSTRAINT pk_product_safety_test PRIMARY KEY(`product_safety_test_id`)
) COMMENT 'Record of laboratory safety and performance testing conducted on apparel, footwear, and accessories to meet CPSC standards, OEKO-TEX certification requirements, and internal quality gates. Captures test type (flammability, chemical content, tensile strength, colorfastness), testing laboratory, test date, test result (pass/fail), specific standard tested against, and any remediation required. Links to the specific SKU/style and season tested.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` (
    `ftc_label_id` BIGINT COMMENT 'Unique identifier for the FTC-compliant textile and apparel label record. Primary key for the label master data.',
    `colorway_development_id` BIGINT COMMENT 'Foreign key linking to design.colorway_development. Business justification: Fiber content and care instructions vary by colorway due to different dye processes and fabric treatments. Links FTC label to specific colorway for accurate regulatory labeling and care instruction co',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_certification. Business justification: FTC labels reference certifications for organic, OEKO-TEX, and other claims. This FK links the label to the certification it references, enabling verification that label claims are backed by valid cer',
    `ecolabel_id` BIGINT COMMENT 'Foreign key linking to sustainability.ecolabel. Business justification: FTC labels and ecolabels (GOTS, Cradle to Cradle, EU Ecolabel) both appear on product packaging and hangtags. Linking enables unified label compliance verification, prevents conflicting environmental ',
    `labeling_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.labeling_requirement. Business justification: FTC labels implement country-specific labeling requirements. This FK links the label design to the requirement it satisfies, enabling verification that labels comply with jurisdiction-specific rules. ',
    `print_design_id` BIGINT COMMENT 'Foreign key linking to design.print_design. Business justification: FTC labels for textile products must reference print designs when prints contain regulated content disclosures (e.g., fur product labeling, wool content). Links label compliance to specific print artw',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: FTC labels are created for specific styles during product development. Compliance teams generate FTC-compliant labels (fiber content, care instructions, COO) at style level before production. Natural ',
    `superseded_by_label_ftc_label_id` BIGINT COMMENT 'Reference to the newer label that replaces this label. Used to track label revision history and ensure proper version control. Null for current active labels.',
    `approval_date` DATE COMMENT 'Date when the label received final approval for production and use. Marks transition from legal_review to approved status.',
    `care_instructions` STRING COMMENT 'Complete care instructions for the product including washing, bleaching, drying, ironing, and dry cleaning guidance as required by the Care Labeling Rule. Must include at least one safe cleaning method.',
    `care_symbol_code` STRING COMMENT 'Standardized care symbol codes following ASTM D5489 international care labeling system. Represents washing, bleaching, drying, ironing, and professional care symbols in sequence.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the product was manufactured, processed, or assembled as required by FTC country of origin marking requirements and customs regulations.. Valid values are `^[A-Z]{3}$`',
    `country_of_origin_statement` STRING COMMENT 'Full country of origin disclosure statement as it appears on the label. Example: Made in USA, Imported, Made in China, Assembled in Mexico from imported materials.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the label record was first created in the system. Part of audit trail for compliance tracking.',
    `down_content_percentage` DECIMAL(18,2) COMMENT 'Percentage by weight of down fill content. Required disclosure for products containing down fill. Null if product contains no down.',
    `down_feather_indicator` BOOLEAN COMMENT 'Indicates whether the product contains down or feather fill and requires down/feather content disclosure per FTC guidelines.',
    `effective_date` DATE COMMENT 'Date when the label becomes effective and approved for use on products. Labels cannot be used on products before this date.',
    `expiration_date` DATE COMMENT 'Date when the label is no longer valid for use on new products. Null for labels with indefinite validity. Superseded labels receive an expiration date.',
    `fiber_content_description` STRING COMMENT 'Complete fiber content disclosure listing all constituent fibers by generic name and percentage by weight in descending order, as required by the Textile Fiber Products Identification Act. Example: 60% Cotton, 40% Polyester.',
    `flammability_standard_code` STRING COMMENT 'Applicable flammability standard code for the product. 16CFR1610 for general wearing apparel, 16CFR1615/1616 for childrens sleepwear. Required for products subject to CPSC flammability regulations.. Valid values are `16CFR1610|16CFR1615|16CFR1616|exempt|not_applicable`',
    `flammability_test_result` STRING COMMENT 'Result of flammability testing per applicable CPSC standards. Pass indicates compliance with flammability requirements. Required for childrens sleepwear and certain textile products.. Valid values are `pass|fail|not_tested|exempt`',
    `fur_animal_name` STRING COMMENT 'True English name of the animal producing the fur, as required by the Fur Products Labeling Act. Example: Rabbit, Fox, Mink. Null if product contains no fur.',
    `fur_product_indicator` BOOLEAN COMMENT 'Indicates whether the product contains fur and is subject to the Fur Products Labeling Act requirements.',
    `label_language` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the primary language of the label text. Multiple languages may require separate label records.. Valid values are `^[A-Z]{3}$`',
    `label_number` STRING COMMENT 'Business identifier for the label used for tracking and reference across product lifecycle management and compliance systems.. Valid values are `^LBL-[A-Z0-9]{8,12}$`',
    `label_status` STRING COMMENT 'Current lifecycle status of the label in the approval workflow. Tracks progression from draft through legal review to active use and eventual retirement.. Valid values are `draft|legal_review|approved|active|superseded|retired`',
    `label_type` STRING COMMENT 'Physical format and construction method of the label (woven fabric label, printed label, heat transfer, hang tag, sewn-in label, or adhesive label).. Valid values are `woven|printed|heat_transfer|hang_tag|sewn_in|adhesive`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the label record was last modified. Updated whenever any field in the record changes. Part of audit trail for compliance tracking.',
    `legal_review_date` DATE COMMENT 'Date when legal review of the label was completed and compliance with FTC regulations was verified.',
    `legal_reviewer_name` STRING COMMENT 'Name of the legal or compliance professional who reviewed and approved the label for regulatory compliance.',
    `manufacturer_identifier_type` STRING COMMENT 'Type of manufacturer or importer identification used on the label: RN (Registered Identification Number), WPL (Wool Products Labeling number), or full company name.. Valid values are `RN|WPL|company_name`',
    `manufacturer_name` STRING COMMENT 'Full legal name of the manufacturer, importer, or other business responsible for the product. Used when RN/WPL number is not provided on the label.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the label. May include supplier instructions, production notes, or compliance clarifications.',
    `oeko_tex_certified` BOOLEAN COMMENT 'Indicates whether the product is certified under OEKO-TEX Standard 100 for textile safety and absence of harmful substances.',
    `organic_certification_indicator` BOOLEAN COMMENT 'Indicates whether the product carries organic certification (GOTS, USDA Organic, or other recognized organic standard) and requires organic content disclosure.',
    `primary_fiber_percentage` DECIMAL(18,2) COMMENT 'Percentage by weight of the primary fiber constituent. Must be accurate within tolerances specified by FTC regulations (typically +/- 3% for fibers over 15%, +/- 2% for fibers under 15%).',
    `primary_fiber_type` STRING COMMENT 'The predominant fiber type by weight percentage. Used for reporting and categorization purposes.',
    `product_category` STRING COMMENT 'High-level product category that determines applicable FTC labeling requirements. Childrens sleepwear and down/feather products have additional flammability and content disclosure requirements.. Valid values are `apparel|footwear|accessories|childrens_sleepwear|down_feather_products|textile_home_goods`',
    `recycled_content_indicator` BOOLEAN COMMENT 'Indicates whether the product contains recycled fiber content and requires recycled content disclosure per FTC Green Guides.',
    `recycled_content_percentage` DECIMAL(18,2) COMMENT 'Percentage by weight of recycled fiber content (pre-consumer or post-consumer). Required for substantiation of recycled content claims.',
    `revision_number` STRING COMMENT 'Sequential revision number for the label. Increments with each approved change to fiber content, care instructions, or other regulated content.',
    `revision_reason` STRING COMMENT 'Business reason for creating a new revision of the label. Examples: fiber content change, country of origin change, regulatory requirement update, care instruction correction.',
    `rn_number` STRING COMMENT 'FTC-issued Registered Identification Number that identifies the manufacturer, importer, or other business responsible for the product. Format: RN followed by 5-6 digits.. Valid values are `^RN[0-9]{5,6}$`',
    `wool_content_percentage` DECIMAL(18,2) COMMENT 'Percentage by weight of wool fiber content. Required disclosure for products subject to Wool Products Labeling Act. Null if product contains no wool.',
    `wool_product_indicator` BOOLEAN COMMENT 'Indicates whether the product contains wool fiber and is subject to the Wool Products Labeling Act requirements. True if product contains any wool content.',
    `wpl_number` STRING COMMENT 'Legacy FTC-issued Wool Products Labeling number (discontinued in 1998 but still valid for existing registrations). Format: WPL followed by 4-5 digits.. Valid values are `^WPL[0-9]{4,5}$`',
    CONSTRAINT pk_ftc_label PRIMARY KEY(`ftc_label_id`)
) COMMENT 'Master record for FTC-mandated textile and apparel labeling compliance under the Textile Fiber Products Identification Act, Wool Products Labeling Act, and Care Labeling Rule (16 CFR 423). Captures fiber content percentages, country of origin statement, care instruction symbols (ASTM D5489), manufacturer/importer RN/WPL number, label format (woven, printed, hang tag), approval status, effective date, and associated SKU/style. Manages the full lifecycle of label creation, legal review, approval, and revision across all product categories including childrens sleepwear (flammability labeling) and down/feather products.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` (
    `trade_compliance_record_id` BIGINT COMMENT 'Unique identifier for the trade compliance record. Primary key for the trade compliance master record.',
    `carbon_emission_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_emission. Business justification: Trade lane emissions (Scope 3 categories 4 & 9: upstream/downstream transportation) require HS code, origin, and trade lane data from customs records. Linking enables accurate supply chain carbon foot',
    `sketch_id` BIGINT COMMENT 'Foreign key linking to design.design_sketch. Business justification: HS code classification and duty assessment begins at sketch stage to evaluate trade cost implications before production commitment. Enables early-stage landed cost modeling and trade compliance planni',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Trade compliance (HS code classification, duty rates, COO determination) is managed at SKU level because different sizes/colors may have different classifications or origins. Trade compliance teams cl',
    `style_id` BIGINT COMMENT 'Reference to the product or SKU (Stock Keeping Unit) subject to this trade compliance determination.',
    `vendor_id` BIGINT COMMENT 'Reference to the licensed customs broker or freight forwarder responsible for customs clearance in this trade lane.',
    `antidumping_duty_flag` BOOLEAN COMMENT 'Indicates whether antidumping duties are imposed on this product from the origin country.',
    `certificate_of_origin_required_flag` BOOLEAN COMMENT 'Indicates whether a certificate of origin document is required to claim preferential duty treatment or meet import requirements.',
    `certificate_of_origin_type` STRING COMMENT 'Type of certificate of origin document required (e.g., GSP Form A, USMCA Certification, EUR.1, Movement Certificate, or self-certification).. Valid values are `form_a|usmca_cert|eur1|movement_cert|self_certification|none`',
    `classification_date` DATE COMMENT 'Date when the HS code classification was determined or last validated.',
    `classification_method` STRING COMMENT 'Method used to determine the HS code classification for this product.. Valid values are `manual|automated|third_party|customs_ruling`',
    `compliance_review_date` DATE COMMENT 'Date when the trade compliance record was last reviewed or audited for accuracy and regulatory adherence.',
    `compliance_status` STRING COMMENT 'Overall trade compliance status of this record, indicating whether all regulatory requirements are met.. Valid values are `compliant|non_compliant|under_review|pending_documentation|expired`',
    `coo_determination_date` DATE COMMENT 'Date when the country of origin determination was made or last validated.',
    `coo_determination_method` STRING COMMENT 'Method used to determine the country of origin, such as substantial transformation rule, tariff shift criterion, value-added percentage, or wholly obtained.. Valid values are `substantial_transformation|tariff_shift|value_added|assembly|wholly_obtained`',
    `countervailing_duty_flag` BOOLEAN COMMENT 'Indicates whether countervailing duties (anti-subsidy duties) are imposed on this product from the origin country.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country where the product was manufactured or substantially transformed.. Valid values are `^[A-Z]{3}$`',
    `duty_optimization_strategy` STRING COMMENT 'Strategy employed to minimize duty costs, such as leveraging free trade agreements, GSP, duty drawback programs, foreign trade zones, or bonded warehouses.. Valid values are `standard|fta_preferential|gsp|duty_drawback|ftz|bonded_warehouse`',
    `export_control_classification` STRING COMMENT 'Export Control Classification Number assigned to the product under the Export Administration Regulations (EAR) or equivalent export control regime.. Valid values are `^[A-Z0-9]{4,10}$`',
    `export_license_required_flag` BOOLEAN COMMENT 'Indicates whether an export license is required for this product to the destination country based on export control regulations.',
    `gsp_beneficiary_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the GSP beneficiary developing country from which the product originates.. Valid values are `^[A-Z]{3}$`',
    `gsp_eligible_flag` BOOLEAN COMMENT 'Indicates whether the product qualifies for duty-free or reduced-duty treatment under the Generalized System of Preferences program.',
    `hs_code` STRING COMMENT 'Harmonized System tariff classification code (6-10 digits) assigned to the product for customs purposes. Determines duty rates and regulatory requirements.. Valid values are `^[0-9]{6,10}$`',
    `hs_code_description` STRING COMMENT 'Official description of the HS code classification from the Harmonized System nomenclature.',
    `import_duty_rate` DECIMAL(18,2) COMMENT 'Standard import duty rate (as a percentage) applicable to this product in the destination country under the HS code classification.',
    `landed_duty_paid_amount` DECIMAL(18,2) COMMENT 'Total landed cost including product cost, freight, insurance, duties, and taxes, representing the full delivered cost in the destination country.',
    `ldp_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the landed duty paid amount.. Valid values are `^[A-Z]{3}$`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this trade compliance record to ensure continued accuracy.',
    `notes` STRING COMMENT 'Free-text field for additional notes, exceptions, or special instructions related to this trade compliance determination.',
    `preferential_duty_rate` DECIMAL(18,2) COMMENT 'Reduced duty rate (as a percentage) available under a preferential trade agreement or program (e.g., USMCA, GSP, EU FTA).',
    `quota_applicable_flag` BOOLEAN COMMENT 'Indicates whether import or export quotas apply to this product in the specified trade lane.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade compliance record was first created in the system.',
    `record_updated_by` STRING COMMENT 'User or system identifier of the person or process that last updated this trade compliance record.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade compliance record was last modified or updated.',
    `restricted_party_screening_status` STRING COMMENT 'Status of screening against restricted party lists (OFAC SDN, EU Sanctions, UN Sanctions) for trade partners involved in this transaction.. Valid values are `cleared|flagged|pending|not_screened`',
    `ruling_expiration_date` DATE COMMENT 'Expiration date of the customs ruling, after which the ruling is no longer valid and a new determination may be required.',
    `ruling_reference_number` STRING COMMENT 'Reference number of any binding customs ruling or advance ruling obtained for this product classification or origin determination.. Valid values are `^[A-Z0-9-]{5,20}$`',
    `sanctioned_country_flag` BOOLEAN COMMENT 'Indicates whether the origin or destination country is subject to comprehensive trade sanctions or embargoes.',
    `screening_date` DATE COMMENT 'Date when the most recent restricted party screening was performed for this trade compliance record.',
    `special_program_code` STRING COMMENT 'Code identifying any special customs program utilized (e.g., foreign trade zone, bonded warehouse, temporary import, duty drawback program).. Valid values are `^[A-Z0-9_]{2,10}$`',
    `textile_category_code` STRING COMMENT 'Textile and apparel category code used for quota monitoring and trade agreement compliance (legacy system for quota-restricted products).. Valid values are `^[0-9]{3,4}$`',
    `trade_agreement_code` STRING COMMENT 'Code identifying the applicable preferential trade agreement (e.g., USMCA, RCEP, EU_FTA, GSP) under which preferential duty treatment is claimed.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `trade_lane_code` STRING COMMENT 'Origin-destination country pair for this trade compliance record, formatted as ISO 3166-1 alpha-3 codes (e.g., CHN-USA for China to United States).. Valid values are `^[A-Z]{3}-[A-Z]{3}$`',
    CONSTRAINT pk_trade_compliance_record PRIMARY KEY(`trade_compliance_record_id`)
) COMMENT 'Trade compliance master record managing import/export regulatory requirements, restricted party screening, and country-of-origin determinations for each product or trade lane. Captures HS code classification, COO determination method (substantial transformation, tariff shift), GSP eligibility, import duty rates, LDP calculations, export control classification, OFAC/SDN/EU sanctions screening results, and applicable trade agreement benefits (USMCA, EU FTA, RCEP). Supports customs classification, duty optimization, sanctions compliance, and preferential trade program utilization across all sourcing and distribution markets.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` (
    `regulatory_change_id` BIGINT COMMENT 'Unique identifier for the regulatory change record. Primary key.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Regulatory changes create new compliance obligations or modify existing ones. This FK links the change record to the obligation it creates or affects, enabling tracking of obligation evolution over ti',
    `affected_business_processes` STRING COMMENT 'Comma-separated list of core business processes impacted by this regulatory change (e.g., Product Design and Development, Sourcing and Procurement, Manufacturing and Production, Retail Store Operations, E-Commerce and Digital Commerce, Marketing and Brand Management).',
    `affected_data_domains` STRING COMMENT 'Comma-separated list of data domains impacted by this regulatory change (e.g., Product, Customer, Order, Inventory, Supply Chain, Merchandising, Marketing, Quality).',
    `change_status` STRING COMMENT 'Current lifecycle status of the regulatory change: proposed (under review), enacted (passed but not yet effective), effective (in force), deferred (delayed), or withdrawn (cancelled).. Valid values are `proposed|enacted|effective|deferred|withdrawn`',
    `change_type` STRING COMMENT 'Type of regulatory change: new regulation introduced, amendment to existing regulation, repeal of regulation, clarification issued, extension of deadline, or temporary suspension.. Valid values are `new|amendment|repeal|clarification|extension|suspension`',
    `compliance_category` STRING COMMENT 'Primary compliance area this regulation falls under: product safety, labeling requirements, trade compliance, labor standards, environmental sustainability (ESG), data privacy, financial reporting, or ethical sourcing. [ENUM-REF-CANDIDATE: product_safety|labeling|trade_compliance|labor_standards|environmental_esg|data_privacy|financial_reporting|ethical_sourcing|quality_standards|consumer_protection — promote to reference product]',
    `compliance_completion_date` DATE COMMENT 'Actual date when full compliance with this regulatory change was achieved and verified internally.',
    `compliance_deadline` DATE COMMENT 'Final date by which the organization must achieve full compliance with the regulatory change. May differ from effective date if a grace period is granted.',
    `compliance_owner` STRING COMMENT 'Name or employee identifier of the individual accountable for ensuring compliance with this regulatory change.',
    `compliance_progress_status` STRING COMMENT 'Current progress status of internal compliance efforts: not started, in progress, completed, overdue (past deadline), or on hold (temporarily paused).. Valid values are `not_started|in_progress|completed|overdue|on_hold`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory change record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when the regulatory change becomes legally binding and must be complied with.',
    `estimated_compliance_cost` DECIMAL(18,2) COMMENT 'Estimated total cost in USD to achieve compliance with this regulatory change, including system updates, process changes, training, and external consulting.',
    `external_consultant_engaged` BOOLEAN COMMENT 'Flag indicating whether external legal counsel, compliance consultants, or subject matter experts have been engaged to support compliance efforts (True) or not (False).',
    `impact_assessment` STRING COMMENT 'Assessed level of impact this regulatory change has on Apparel Fashion operations: critical (business-stopping), high (significant operational change), medium (moderate adjustment), low (minor change), or minimal (negligible impact).. Valid values are `critical|high|medium|low|minimal`',
    `internal_response_required` BOOLEAN COMMENT 'Flag indicating whether this regulatory change requires formal internal response actions, policy updates, or operational changes (True) or is informational only (False).',
    `issuing_authority` STRING COMMENT 'Name of the regulatory body, government agency, or standards organization that issued or amended the regulation (e.g., FTC, CPSC, ISO, OEKO-TEX, GOTS).',
    `jurisdiction` STRING COMMENT 'Geographic or legal jurisdiction where the regulation applies (e.g., USA, EU, California, Global). Use 3-letter ISO country codes or recognized jurisdiction names.',
    `notes` STRING COMMENT 'Free-text field for additional context, observations, or internal commentary related to this regulatory change.',
    `notification_date` DATE COMMENT 'Date when internal stakeholders were formally notified of this regulatory change.',
    `notification_sent_flag` BOOLEAN COMMENT 'Flag indicating whether internal stakeholders have been formally notified of this regulatory change (True) or not (False).',
    `penalty_description` STRING COMMENT 'Description of penalties, fines, sanctions, or legal consequences that may result from non-compliance with this regulation.',
    `publication_date` DATE COMMENT 'Date when the regulatory change was officially published or announced by the issuing authority.',
    `regulation_code` STRING COMMENT 'Official code or reference number assigned to the regulation by the issuing authority (e.g., 16 CFR Part 303 for FTC textile labeling).',
    `regulation_name` STRING COMMENT 'Official name or title of the regulation, law, or standard that has changed.',
    `regulation_summary` STRING COMMENT 'Brief executive summary of the regulatory change, its purpose, and key requirements in business-friendly language.',
    `regulation_url` STRING COMMENT 'Web link to the official source document or regulatory authority page where the full text of the regulation can be accessed.',
    `related_regulations` STRING COMMENT 'Comma-separated list of related regulation codes or names that are connected to or impacted by this regulatory change.',
    `response_action_plan` STRING COMMENT 'Description of the internal actions, policy updates, system changes, or operational adjustments required to achieve compliance with this regulatory change.',
    `responsible_department` STRING COMMENT 'Name of the internal department or business unit responsible for leading the compliance response (e.g., Legal, Quality Assurance, Product Development, Supply Chain, IT, Finance).',
    `risk_level` STRING COMMENT 'Risk level associated with non-compliance: critical (legal/financial/reputational catastrophe), high (significant penalties or operational disruption), medium (moderate risk), or low (minor risk).. Valid values are `critical|high|medium|low`',
    `updated_by` STRING COMMENT 'User identifier or name of the person who last updated this regulatory change record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory change record was last modified.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this regulatory change record.',
    CONSTRAINT pk_regulatory_change PRIMARY KEY(`regulatory_change_id`)
) COMMENT 'Regulatory change management record tracking new, amended, or repealed regulations that impact Apparel Fashions operations. Captures the regulation name, issuing authority, jurisdiction, change type (new/amendment/repeal), effective date, impact assessment, affected business processes, and required internal response actions. Drives the regulatory change management workflow ensuring timely adaptation of labeling, safety, trade, and ESG compliance programs.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`compliance`.`incident` (
    `incident_id` BIGINT COMMENT 'Unique identifier for the compliance incident record. Primary key.',
    `colorway_development_id` BIGINT COMMENT 'Foreign key linking to design.colorway_development. Business justification: Colorway-specific compliance failures (azo dye violations, heavy metal content) require linking incident to exact colorway for targeted remediation. Supports colorway-level recalls and prevents reuse ',
    `compliance_audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_audit_finding. Business justification: Compliance incidents can be discovered through audit findings (identification_source = audit). This FK links the incident to the specific finding that identified it, enabling traceability from findi',
    `corrective_action_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action_plan. Business justification: Compliance incidents trigger corrective action plans for remediation. This FK links the incident to its CAP, consolidating remediation tracking in the CAP record. Columns remediation_plan, remediation',
    `esg_disclosure_metric_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_disclosure_metric. Business justification: Material compliance incidents (fines, sanctions, labor violations) require ESG disclosure under GRI 419, SASB, and SEC climate rules. Linking enables automated incident-to-disclosure workflows, ensure',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Material-level compliance incidents (restricted substance violations, supplier non-compliance, material defects) are tracked for supplier corrective action and material substitution decisions. Complia',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Compliance incidents represent violations or breaches of specific compliance obligations. This FK links the incident to the obligation that was violated, enabling tracking of which obligations have th',
    `print_design_id` BIGINT COMMENT 'Foreign key linking to design.print_design. Business justification: Print designs using non-compliant inks, dyes, or restricted substances trigger compliance incidents. Direct link enables traceability, recall management, and prevents reuse of non-compliant print desi',
    `production_factory_id` BIGINT COMMENT 'Identifier of the manufacturing facility, warehouse, store, or office location where the incident occurred.',
    `related_incident_id` BIGINT COMMENT 'Identifier of a related or parent compliance incident, used to link recurring or cascading incidents.',
    `sketch_id` BIGINT COMMENT 'Foreign key linking to design.design_sketch. Business justification: Compliance incidents (restricted substance violations, safety failures) often trace to original design decisions. Links incident to design sketch for root cause analysis and prevents recurrence in fut',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Compliance incidents (product recalls, safety violations, customer complaints) are tracked at SKU level for traceability. Quality/compliance teams track incidents at SKU level for corrective action, b',
    `style_id` BIGINT COMMENT 'Identifier of the product or Stock Keeping Unit (SKU) involved in the incident, applicable for product safety or labeling violations.',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or vendor involved in the compliance incident, if applicable.',
    `actual_penalty_amount` DECIMAL(18,2) COMMENT 'Actual monetary penalty or fine imposed by regulatory authorities as a result of the incident.',
    `affected_business_unit` STRING COMMENT 'Name or code of the business unit, division, or department where the compliance incident occurred.',
    `affected_individuals_count` STRING COMMENT 'Number of individuals (customers, employees, or other data subjects) affected by the incident, applicable for data privacy breaches.',
    `affected_jurisdiction` STRING COMMENT 'Geographic jurisdiction or regulatory region where the incident occurred. Uses 3-letter ISO country codes or multi-country region codes.',
    `assigned_investigator` STRING COMMENT 'Name or identifier of the compliance officer, auditor, or investigator assigned to lead the incident investigation.',
    `certification_impacted` STRING COMMENT 'Name of industry certification or accreditation that may be impacted or at risk due to the incident (e.g., OEKO-TEX, GOTS, WRAP, FLA).',
    `closure_date` DATE COMMENT 'Date when the incident was formally closed after all remediation, verification, and documentation activities were completed.',
    `closure_notes` STRING COMMENT 'Final summary notes documenting the resolution, lessons learned, and any outstanding follow-up actions at the time of incident closure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance incident record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated financial impact amount.. Valid values are `^[A-Z]{3}$`',
    `escalated_to_executive` BOOLEAN COMMENT 'Indicates whether the incident was escalated to executive leadership or board level due to severity or regulatory significance.',
    `estimated_financial_impact` DECIMAL(18,2) COMMENT 'Estimated total financial impact of the incident including potential fines, penalties, remediation costs, and business disruption costs.',
    `identification_source` STRING COMMENT 'Channel or mechanism through which the compliance incident was discovered. [ENUM-REF-CANDIDATE: internal_audit|external_audit|regulatory_inspection|whistleblower|customer_complaint|supplier_audit|self_disclosure — 7 candidates stripped; promote to reference product]',
    `identified_date` DATE COMMENT 'Date when the compliance incident was first identified or reported.',
    `identified_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the compliance incident was first identified or reported. Used for regulatory notification timing calculations.',
    `incident_description` STRING COMMENT 'Detailed narrative description of the compliance incident, including circumstances, scope, and initial findings.',
    `incident_number` STRING COMMENT 'Business-facing unique incident reference number used for tracking and reporting. Format: INC-YYYYMMDD.. Valid values are `^INC-[0-9]{8}$`',
    `incident_status` STRING COMMENT 'Current lifecycle status of the compliance incident in the remediation workflow.. Valid values are `identified|under_investigation|remediation_in_progress|resolved|closed|escalated`',
    `incident_type` STRING COMMENT 'Classification of the compliance incident by regulatory domain. Determines applicable regulatory frameworks and notification requirements.. Valid values are `labor_violation|product_safety_breach|data_privacy_breach|trade_compliance_violation|environmental_violation|ethical_sourcing_violation`',
    `investigation_completion_date` DATE COMMENT 'Date when the incident investigation was completed and findings documented.',
    `investigation_start_date` DATE COMMENT 'Date when formal investigation of the incident commenced.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance incident record was last updated or modified.',
    `public_disclosure_date` DATE COMMENT 'Date when public disclosure or customer notification was made.',
    `public_disclosure_required` BOOLEAN COMMENT 'Indicates whether the incident requires public disclosure or notification to affected parties (e.g., data breach notifications to customers).',
    `recurrence_indicator` BOOLEAN COMMENT 'Indicates whether this incident is a recurrence of a previously identified and remediated compliance issue.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body or governing authority to which the incident was or must be reported (e.g., FTC, CPSC, Data Protection Authority).',
    `regulatory_framework` STRING COMMENT 'Specific regulation, standard, or compliance framework that was violated or breached (e.g., GDPR, CPSC, FLA, OEKO-TEX, GOTS).',
    `regulatory_notification_date` TIMESTAMP COMMENT 'Actual date and time when the incident was reported to the regulatory authority.',
    `regulatory_notification_deadline` TIMESTAMP COMMENT 'Deadline by which the incident must be reported to regulatory authorities. Calculated based on applicable notification windows (e.g., GDPR 72 hours).',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether the incident must be reported to a regulatory authority or governing body.',
    `root_cause` STRING COMMENT 'Identified root cause or underlying factor that led to the compliance incident, determined through investigation.',
    `severity_level` STRING COMMENT 'Risk severity classification of the incident based on potential regulatory, financial, and reputational impact.. Valid values are `critical|high|medium|low`',
    CONSTRAINT pk_incident PRIMARY KEY(`incident_id`)
) COMMENT 'Record of compliance incidents, violations, or breaches identified through audits, regulatory inspections, internal reviews, or whistleblower reports. Captures incident type (labor violation, product safety breach, data privacy breach, trade compliance violation, environmental violation), severity, date identified, source of identification, affected business unit or facility, regulatory notification requirement, and remediation status. Drives incident response workflows and regulatory notification obligations.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`compliance`.`document` (
    `document_id` BIGINT COMMENT 'Unique identifier for the compliance document record. Primary key for the compliance document entity.',
    `collaboration_id` BIGINT COMMENT 'Foreign key linking to design.design_collaboration. Business justification: Collaboration contracts, IP rights agreements, exclusivity terms, and compliance documentation stored as compliance_documents linked to collaboration. Supports legal compliance and contract management',
    `audit_id` BIGINT COMMENT 'Reference to the compliance audit record this document supports or evidences.',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_certification. Business justification: Compliance documents include certification artifacts (certificate PDFs, audit reports supporting certification). The certification_number STRING field should be normalized to a FK to compliance_certif',
    `concept_id` BIGINT COMMENT 'Foreign key linking to design.concept. Business justification: Sustainability certifications, IP agreements, and compliance documentation attached to design concepts for approval workflows. Supports concept-stage compliance review before investment in detailed de',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Material-level compliance documents (MSDS, test reports, supplier certifications, mill certificates) are maintained for regulatory compliance and supplier management. Sourcing/compliance teams maintai',
    `obligation_id` BIGINT COMMENT 'Reference to the compliance obligation this document fulfills or evidences.',
    `print_design_id` BIGINT COMMENT 'Foreign key linking to design.print_design. Business justification: Licensed print designs require copyright agreements, usage rights documentation, and royalty terms stored as compliance documents. Essential for IP compliance and legal audit trails for licensed artwo',
    `production_factory_id` BIGINT COMMENT 'Reference to the manufacturing facility, warehouse, or location that the compliance document pertains to.',
    `regulatory_filing_id` BIGINT COMMENT 'Reference to the regulatory filing record this document supports or confirms.',
    `style_id` BIGINT COMMENT 'Foreign key linking to product.style. Business justification: Style-level compliance documents (test reports, certifications, technical files, safety declarations) are maintained for regulatory filings and customer audits. Compliance teams maintain style-level d',
    `supersedes_document_id` BIGINT COMMENT 'Reference to the previous version of the compliance document that this version replaces or supersedes.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor associated with the compliance document, applicable for supplier audits and certifications.',
    `superseded_document_id` BIGINT COMMENT 'Self-referencing FK on document (superseded_document_id)',
    `access_restriction_notes` STRING COMMENT 'Additional notes or instructions regarding access restrictions, handling requirements, or special considerations for the compliance document.',
    `confidentiality_classification` STRING COMMENT 'Data classification level indicating the sensitivity and access restrictions for the compliance document.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance document record was first created in the system.',
    `destruction_eligible_date` DATE COMMENT 'Calculated date when the document becomes eligible for destruction based on retention period and applicable regulations.',
    `document_date` DATE COMMENT 'Official date of the document as indicated on the document itself, representing when it was created or issued.',
    `document_description` STRING COMMENT 'Detailed description of the document content, purpose, and key findings or conclusions.',
    `document_number` STRING COMMENT 'Business identifier or reference number assigned to the compliance document for tracking and retrieval purposes.',
    `document_source` STRING COMMENT 'Origin or provider of the compliance document indicating who created or issued it.. Valid values are `internal|third_party_auditor|laboratory|regulatory_body|supplier|legal_counsel`',
    `document_status` STRING COMMENT 'Current lifecycle status of the compliance document in the review and approval workflow.. Valid values are `draft|pending_review|approved|rejected|archived|expired`',
    `document_type` STRING COMMENT 'Classification of the compliance document indicating its purpose and content category.. Valid values are `audit_report|certification_document|test_result_report|regulatory_filing_confirmation|corrective_action_evidence|chain_of_custody_record`',
    `effective_date` DATE COMMENT 'Date from which the compliance document becomes valid or enforceable.',
    `expiration_date` DATE COMMENT 'Date when the compliance document expires or is no longer valid, applicable for time-limited certifications and approvals.',
    `file_format` STRING COMMENT 'Digital file format of the compliance document indicating the file type and extension. [ENUM-REF-CANDIDATE: PDF|DOCX|XLSX|JPG|PNG|TIFF|XML|CSV — 8 candidates stripped; promote to reference product]',
    `file_path` STRING COMMENT 'Storage location or URI path where the physical compliance document file is stored in the document management system.',
    `file_size_kb` DECIMAL(18,2) COMMENT 'Size of the compliance document file measured in kilobytes for storage management and tracking.',
    `governing_body` STRING COMMENT 'Regulatory agency, certification body, or standards organization that governs or issued the compliance document.',
    `hash` STRING COMMENT 'Cryptographic hash value of the document file to ensure integrity and detect tampering or unauthorized modifications.',
    `issuing_organization` STRING COMMENT 'Name of the organization, agency, or entity that issued or authored the compliance document.',
    `jurisdiction` STRING COMMENT 'Geographic or legal jurisdiction to which the compliance document applies, using ISO 3166-1 alpha-3 country codes or regional identifiers.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance document record was last updated or modified.',
    `legal_hold_case_number` STRING COMMENT 'Case or matter number associated with the legal hold placed on the compliance document.',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicator of whether the compliance document is subject to a legal hold and must be preserved for litigation or investigation purposes.',
    `page_count` STRING COMMENT 'Total number of pages in the compliance document, applicable for multi-page documents.',
    `product_category` STRING COMMENT 'Category of products or materials that the compliance document applies to or certifies.',
    `regulatory_framework` STRING COMMENT 'Name of the regulatory framework, standard, or compliance program that the document supports or evidences.',
    `responsible_party` STRING COMMENT 'Name or identifier of the individual or team responsible for managing and maintaining the compliance document.',
    `responsible_party_email` STRING COMMENT 'Email address of the individual or team responsible for the compliance document for contact and notification purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `retention_period_years` STRING COMMENT 'Number of years the compliance document must be retained per regulatory or legal requirements before eligible for destruction.',
    `tags` STRING COMMENT 'Comma-separated list of keywords or tags for categorization, search, and retrieval of the compliance document.',
    `title` STRING COMMENT 'Descriptive title or name of the compliance document for identification and cataloging.',
    `upload_date` DATE COMMENT 'Date when the compliance document was uploaded or ingested into the compliance repository system.',
    `verification_date` DATE COMMENT 'Date when the compliance document was verified for authenticity and accuracy.',
    `verification_status` STRING COMMENT 'Status indicating whether the authenticity and accuracy of the compliance document has been verified by authorized personnel.. Valid values are `unverified|verified|rejected|pending_verification`',
    `verified_by` STRING COMMENT 'Name or identifier of the person who verified the authenticity and accuracy of the compliance document.',
    `version_number` STRING COMMENT 'Version identifier for the compliance document to track revisions and updates over time.',
    CONSTRAINT pk_document PRIMARY KEY(`document_id`)
) COMMENT 'Master record for compliance evidence artifacts including audit reports, certification documents, test result reports, regulatory filing confirmations, corrective action evidence photos/documents, and chain-of-custody records. Captures document type, associated compliance record (audit, certification, filing, incident), upload date, document source (internal, third-party auditor, laboratory, regulatory body), retention period, confidentiality classification, and verification status. Serves as the centralized evidence repository supporting regulatory inquiries, audit preparation, legal discovery, and third-party assurance processes across all compliance programs.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` (
    `restricted_substance_id` BIGINT COMMENT 'Unique identifier for the restricted substance record. Primary key.',
    `chemical_compliance_id` BIGINT COMMENT 'Foreign key linking to sustainability.chemical_compliance. Business justification: Restricted substance lists (REACH SVHC, California Prop 65, ZDHC MRSL) define thresholds and test methods for chemical compliance testing. Linking enables automated test protocol generation from RSL u',
    `colorway_development_id` BIGINT COMMENT 'Foreign key linking to design.colorway_development. Business justification: Colorway development requires restricted substance screening for dyes, pigments, and finishing chemicals before lab dip approval. Ensures colorways comply with REACH, ZDHC, and other chemical restrict',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Restricted substances are tested and tracked at material level. Sourcing teams screen materials against RSL (Restricted Substance List); compliance teams track material-level test results for regulato',
    `print_design_id` BIGINT COMMENT 'Foreign key linking to design.print_design. Business justification: Print designs must be screened against restricted substance lists (REACH SVHC, California Prop 65) during design phase. Links restricted substance to print design for proactive compliance and prevents',
    `parent_restricted_substance_id` BIGINT COMMENT 'Self-referencing FK on restricted_substance (parent_restricted_substance_id)',
    `alternative_substance_recommendation` STRING COMMENT 'Recommended safer alternative substances or chemistries that can replace this restricted substance in manufacturing processes.',
    `applicable_jurisdiction` STRING COMMENT 'Geographic jurisdiction or regulatory region where this substance restriction applies. Pipe-separated list of ISO 3166-1 alpha-3 country codes or regional codes (e.g., USA|CAN|MEX, EUR, CHN, JPN). [ENUM-REF-CANDIDATE: USA|CAN|MEX|BRA|GBR|FRA|DEU|ITA|ESP|CHN|JPN|KOR|IND|AUS|NZL|ZAF|TUR|RUS|SAU|ARE — promote to reference product]',
    `applicable_material_type` STRING COMMENT 'Type of material or component to which this substance restriction applies (e.g., textile, leather, trim, packaging, dye, finish, adhesive). Pipe-separated list for multiple material types.',
    `applicable_product_category` STRING COMMENT 'Product category or age group to which this restriction applies (e.g., childrens apparel, adult apparel, footwear, accessories, all products). Pipe-separated list for multiple categories.',
    `authorization_required_flag` BOOLEAN COMMENT 'Indicates whether use of this substance requires specific regulatory authorization or license. True if authorization required.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service to every chemical substance described in the open scientific literature. Standard format: XXXXXX-XX-X.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this restricted substance record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `effective_date` DATE COMMENT 'Date when this substance restriction became or will become legally effective and enforceable.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether this substance has known adverse environmental impacts (bioaccumulation, persistence, aquatic toxicity). True if environmental hazard exists.',
    `exemption_conditions` STRING COMMENT 'Description of any exemptions, derogations, or special conditions under which the substance may be used despite restriction (e.g., spare parts, specific applications, concentration below threshold).',
    `health_hazard_classification` STRING COMMENT 'Primary health hazard classification of the substance based on toxicological profile (e.g., carcinogen, mutagen, reproductive toxin, endocrine disruptor, skin sensitizer). [ENUM-REF-CANDIDATE: carcinogen|mutagen|reproductive_toxin|endocrine_disruptor|skin_sensitizer|acute_toxin|environmental_hazard|none — 8 candidates stripped; promote to reference product]',
    `internal_notes` STRING COMMENT 'Free-text field for internal compliance team notes, implementation guidance, or special handling instructions related to this substance restriction.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this restricted substance record is currently active and applicable. False if restriction has been superseded or is no longer enforced.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this restricted substance record was last updated or modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_review_date` DATE COMMENT 'Date when this restricted substance record was last reviewed and validated for accuracy and regulatory currency.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this restricted substance record.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this restricted substance record to ensure ongoing regulatory alignment.',
    `penalty_description` STRING COMMENT 'Description of penalties, fines, or enforcement actions for non-compliance with this substance restriction (e.g., product recall, import ban, monetary fine).',
    `regulatory_framework` STRING COMMENT 'Primary regulatory framework or standard that defines this substance restriction (e.g., REACH, Proposition 65, CPSIA, OEKO-TEX, ZDHC MRSL, GOTS, bluesign, AFIRM RSL). [ENUM-REF-CANDIDATE: reach|proposition_65|cpsia|oeko_tex|zdhc_mrsl|gots|bluesign|afirm_rsl|gb_standard|other — 10 candidates stripped; promote to reference product]',
    `reporting_threshold_flag` BOOLEAN COMMENT 'Indicates whether this substance requires disclosure or reporting to regulatory authorities even if below restriction limits (e.g., REACH SVHC candidate list). True if reporting required.',
    `restriction_status` STRING COMMENT 'Current regulatory status of the substance indicating the level of restriction (prohibited, restricted with limits, monitored, phased out, under review).. Valid values are `prohibited|restricted|monitored|phased_out|under_review`',
    `source_reference_url` STRING COMMENT 'URL link to the authoritative regulatory source document or official publication defining this substance restriction.',
    `substance_category` STRING COMMENT 'Classification of the restricted substance by chemical family or functional group (e.g., heavy metal, phthalate, flame retardant, azo dye, PFAS). [ENUM-REF-CANDIDATE: heavy_metal|phthalate|flame_retardant|azo_dye|formaldehyde|per_and_polyfluoroalkyl_substance|other — 7 candidates stripped; promote to reference product]',
    `substance_name` STRING COMMENT 'Common or chemical name of the restricted or prohibited substance (e.g., Lead, Cadmium, Phthalates, Formaldehyde).',
    `sunset_date` DATE COMMENT 'Date when this substance restriction expires or is superseded by updated regulation. Null if restriction is indefinite.',
    `svhc_candidate_list_flag` BOOLEAN COMMENT 'Indicates whether this substance is on the REACH SVHC candidate list for authorization. True if on candidate list.',
    `test_method_standard` STRING COMMENT 'Standard test method or protocol used to detect and quantify this substance (e.g., ISO 17234, AATCC 20, EN 14362, CPSC-CH-E1001). Pipe-separated list for multiple methods.',
    `threshold_limit_value` DECIMAL(18,2) COMMENT 'Maximum allowable concentration or amount of the substance permitted in materials or finished goods, expressed as a numeric value. Used in conjunction with threshold_unit.',
    `threshold_unit` STRING COMMENT 'Unit of measure for the threshold limit value (e.g., ppm - parts per million, mg/kg - milligrams per kilogram, percent by weight).. Valid values are `ppm|mg_kg|percent|mg_l|ug_g`',
    CONSTRAINT pk_restricted_substance PRIMARY KEY(`restricted_substance_id`)
) COMMENT 'Master record tracking restricted and prohibited substances (REACH, Prop 65, CPSIA) applicable to apparel materials and finished goods, including substance name, CAS number, threshold limits, and applicable jurisdictions';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` (
    `labeling_requirement_id` BIGINT COMMENT 'Unique identifier for the labeling requirement record. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Labeling requirements vary by product category (childrens sleepwear has different flammability labeling than adult outerwear). Compliance teams map labeling requirements to product categories for lab',
    `superseded_by_requirement_labeling_requirement_id` BIGINT COMMENT 'Reference to the labeling requirement that supersedes this one, if this requirement has been replaced by a newer version.',
    `parent_labeling_requirement_id` BIGINT COMMENT 'Self-referencing FK on labeling_requirement (parent_labeling_requirement_id)',
    `age_group` STRING COMMENT 'Target age group for which this labeling requirement applies, as certain regulations differ for childrens versus adult apparel.. Valid values are `adult|children|infant|toddler|all`',
    `care_instruction_required` BOOLEAN COMMENT 'Indicates whether care and maintenance instructions must be provided on the label.',
    `care_symbol_standard` STRING COMMENT 'International or regional standard for care symbols that must be used, such as ISO 3758 or ASTM D5489.',
    `country_of_origin_format` STRING COMMENT 'Prescribed wording or format for the country of origin statement, such as Made in [Country] or Product of [Country].',
    `country_of_origin_required` BOOLEAN COMMENT 'Indicates whether the country of origin must be disclosed on the product label.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this labeling requirement record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when this labeling requirement became or will become legally enforceable.',
    `environmental_claim_standard` STRING COMMENT 'Standard or guideline that must be followed when making environmental claims on labels, such as FTC Green Guides or ISO 14021.',
    `expiration_date` DATE COMMENT 'Date when this labeling requirement ceases to be enforceable, if applicable. Null for requirements with no expiration.',
    `fiber_content_format` STRING COMMENT 'Prescribed format or template for displaying fiber content information on the label, including ordering rules and percentage thresholds.',
    `fiber_content_required` BOOLEAN COMMENT 'Indicates whether disclosure of fiber content percentages is mandatory under this requirement.',
    `flammability_standard` STRING COMMENT 'Flammability testing standard that products must meet, such as 16 CFR Part 1610 for general wearing apparel or 16 CFR Part 1615 for childrens sleepwear.',
    `font_size_minimum` DECIMAL(18,2) COMMENT 'Minimum font size in points or millimeters required for label text to ensure readability.',
    `governing_body` STRING COMMENT 'Name of the regulatory authority or governing body that issued and enforces this labeling requirement.',
    `internal_notes` STRING COMMENT 'Internal notes or comments regarding the interpretation, implementation, or special considerations for this labeling requirement.',
    `jurisdiction` STRING COMMENT 'Three-letter ISO country code identifying the country or jurisdiction where this labeling requirement applies.. Valid values are `^[A-Z]{3}$`',
    `label_permanence` STRING COMMENT 'Requirement for how the label must be attached, such as permanently sewn, printed, or allowed as a removable hang tag.. Valid values are `permanent|removable|hang_tag`',
    `label_placement` STRING COMMENT 'Prescribed location or placement requirements for the label on the garment, such as inside neck, side seam, or permanently attached.',
    `language_required` STRING COMMENT 'Language or languages in which label information must be presented, such as English, French, Spanish, or local language requirements.',
    `last_review_date` DATE COMMENT 'Date when this labeling requirement was last reviewed for accuracy and currency.',
    `manufacturer_id_required` BOOLEAN COMMENT 'Indicates whether the manufacturer or responsible party must be identified on the label.',
    `manufacturer_id_type` STRING COMMENT 'Type of manufacturer identification that must be displayed, such as Registered Number (RN), Wool Products Labeling (WPL) number, or full company name and address.. Valid values are `rn_number|wpl_number|company_name|address`',
    `maximum_penalty_amount` DECIMAL(18,2) COMMENT 'Maximum monetary penalty that can be assessed for violation of this labeling requirement.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this labeling requirement record was last modified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this labeling requirement.',
    `organic_certification_required` BOOLEAN COMMENT 'Indicates whether organic certification information must be displayed if the product claims to be organic.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the maximum penalty amount.. Valid values are `^[A-Z]{3}$`',
    `penalty_description` STRING COMMENT 'Description of penalties or enforcement actions that may result from non-compliance with this labeling requirement.',
    `product_category` STRING COMMENT 'Apparel or fashion product category to which this labeling requirement applies, such as outerwear, footwear, accessories, or childrens apparel.',
    `recycled_content_disclosure` BOOLEAN COMMENT 'Indicates whether recycled material content must be disclosed on the label if present.',
    `reference_url` STRING COMMENT 'Web URL linking to the official regulatory text, guidance document, or authoritative source for this labeling requirement.',
    `regulatory_citation` STRING COMMENT 'Official legal citation or reference number for the regulation, statute, or standard that defines this requirement.',
    `requirement_code` STRING COMMENT 'Business identifier code for the labeling requirement, used for external reference and cross-system identification.',
    `requirement_name` STRING COMMENT 'Human-readable name of the labeling requirement, describing the specific regulation or standard.',
    `requirement_status` STRING COMMENT 'Current lifecycle status of the labeling requirement indicating whether it is currently enforceable.. Valid values are `active|inactive|pending|superseded|draft|under_review`',
    `requirement_type` STRING COMMENT 'Classification of the labeling requirement by regulatory category.. Valid values are `care_instruction|fiber_content|country_of_origin|size_labeling|safety_warning|flammability`',
    `review_frequency_months` STRING COMMENT 'Frequency in months at which this labeling requirement should be reviewed for regulatory changes or updates.',
    `safety_warning_required` BOOLEAN COMMENT 'Indicates whether safety warnings or hazard notices must be included on the label, particularly for childrens products or items with specific risks.',
    `safety_warning_text` STRING COMMENT 'Prescribed text for mandatory safety warnings, such as choking hazard notices or flammability warnings.',
    `size_labeling_required` BOOLEAN COMMENT 'Indicates whether size information must be displayed on the label.',
    `size_standard` STRING COMMENT 'International or regional sizing standard that must be followed, such as ISO 3635 for clothing sizes or country-specific sizing conventions.',
    CONSTRAINT pk_labeling_requirement PRIMARY KEY(`labeling_requirement_id`)
) COMMENT 'Reference master defining country-specific labeling requirements for apparel products including care instructions, fiber content disclosure, country of origin marking, and size labeling standards per jurisdiction';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`compliance`.`substance_regulation` (
    `substance_regulation_id` BIGINT COMMENT 'Unique identifier for this substance regulation record. Primary key.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key to compliance_obligation',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to the compliance obligation that imposes this substance restriction',
    `restricted_substance_id` BIGINT COMMENT 'Foreign key linking to the restricted substance being regulated by this obligation',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this substance regulation record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when this specific substance restriction under this compliance obligation became legally effective. May differ from the general obligation effective date or substance effective date.',
    `exemption_conditions` STRING COMMENT 'Description of any exemptions, derogations, or special conditions under which this substance may be used despite the restriction under this specific compliance obligation.',
    `internal_notes` STRING COMMENT 'Free-text field for compliance team notes specific to this substance-obligation relationship, including implementation guidance or special handling instructions.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this substance regulation record is currently active and applicable for compliance enforcement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this substance regulation record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date when this substance regulation relationship was last reviewed and validated for accuracy and applicability.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this substance regulation record.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this substance regulation relationship.',
    `regulation_status` STRING COMMENT 'Current status of this substance regulation: active (currently enforced), pending (future effective date), superseded (replaced by updated regulation), expired (past sunset date).',
    `reporting_threshold_flag` BOOLEAN COMMENT 'Indicates whether this substance requires disclosure or reporting to regulatory authorities under this specific compliance obligation.',
    `sunset_date` DATE COMMENT 'Date when this specific substance restriction under this compliance obligation expires or is superseded. Null if no expiration is defined.',
    `threshold_limit_value` DECIMAL(18,2) COMMENT 'Maximum allowable concentration or amount of this substance under this specific compliance obligation. This value is context-specific to the obligation-substance pair and may differ from the general threshold in restricted_substance.',
    `threshold_unit` STRING COMMENT 'Unit of measure for the threshold limit value in the context of this specific regulation (e.g., ppm, mg/kg, percentage).',
    CONSTRAINT pk_substance_regulation PRIMARY KEY(`substance_regulation_id`)
) COMMENT 'This association product represents the regulatory restriction relationship between compliance obligations and restricted substances. It captures the specific regulatory requirements, thresholds, and conditions that apply when a particular compliance obligation restricts a particular substance. Each record links one compliance obligation to one restricted substance with jurisdiction-specific thresholds, effective dates, exemption conditions, and reporting requirements that exist only in the context of this regulatory relationship.. Existence Justification: This is a genuine operational M:N relationship representing substance regulation management in apparel compliance. Compliance teams actively manage a matrix where each compliance obligation (REACH, Prop 65, CPSIA, etc.) restricts multiple substances, and each substance is restricted by multiple regulations with different thresholds, exemptions, and effective dates. The business queries this as which substances are restricted under REACH? and which regulations restrict lead?';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`compliance`.`test_substance_measurement` (
    `test_substance_measurement_id` BIGINT COMMENT 'Unique identifier for this test substance measurement record. Primary key.',
    `product_safety_test_id` BIGINT COMMENT 'Foreign key linking to the product safety test record that this substance measurement belongs to',
    `restricted_substance_id` BIGINT COMMENT 'Foreign key linking to the restricted substance that was measured in this test',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this test substance measurement record was created',
    `failure_reason` STRING COMMENT 'Detailed explanation of why this substance measurement failed, including specific non-conformance details',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this test substance measurement record was last updated',
    `measurement_unit` STRING COMMENT 'Unit of measure for the substance test result (e.g., ppm - parts per million, mg/kg)',
    `measurement_value` DECIMAL(18,2) COMMENT 'Quantitative result of the substance test (e.g., chemical concentration in ppm). This is the actual measured value for this specific substance in this specific test.',
    `result` STRING COMMENT 'Pass/fail outcome for this specific substance measurement within the test',
    `test_measurement_unit` STRING COMMENT 'Unit of measure for the test result (e.g., seconds, ppm, newtons, grade). [Moved from product_safety_test: The unit of measure is specific to each substance measurement within a test. Different substances may be measured in different units within the same test.]',
    `test_measurement_value` DECIMAL(18,2) COMMENT 'Quantitative result of the test (e.g., flame spread rate, chemical concentration, tensile strength). [Moved from product_safety_test: This value is specific to a particular substance within a test, not to the test as a whole. A single test measures multiple substances, each with its own measurement value.]',
    `threshold_operator` STRING COMMENT 'Comparison operator defining how the measurement is evaluated against the threshold (e.g., less_than, greater_than)',
    `threshold_value` DECIMAL(18,2) COMMENT 'Regulatory or internal threshold that this substance measurement must meet or exceed to pass. This is the applicable limit for this substance in this test context.',
    CONSTRAINT pk_test_substance_measurement PRIMARY KEY(`test_substance_measurement_id`)
) COMMENT 'This association product represents the measurement result for a specific restricted substance within a product safety test. It captures the laboratory measurement of each substance tested, the threshold comparison, and the pass/fail determination for that substance. Each record links one product_safety_test to one restricted_substance with measurement values, thresholds, and results that exist only in the context of this specific test-substance combination.. Existence Justification: In apparel product safety testing, laboratories test each product sample against multiple restricted substances (lead, cadmium, phthalates, formaldehyde, etc.) and report individual measurement results for each substance. A single safety test generates multiple substance measurements, and each restricted substance is tested across many different products/tests over time. The business actively manages these test-substance measurements as the core output of laboratory testing.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ADD CONSTRAINT `fk_compliance_compliance_certification_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ADD CONSTRAINT `fk_compliance_compliance_certification_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ADD CONSTRAINT `fk_compliance_compliance_audit_finding_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ADD CONSTRAINT `fk_compliance_compliance_audit_finding_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ADD CONSTRAINT `fk_compliance_compliance_audit_finding_previous_finding_compliance_audit_finding_id` FOREIGN KEY (`previous_finding_compliance_audit_finding_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding`(`compliance_audit_finding_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_previous_cap_corrective_action_plan_id` FOREIGN KEY (`previous_cap_corrective_action_plan_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ADD CONSTRAINT `fk_compliance_product_safety_test_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ADD CONSTRAINT `fk_compliance_ftc_label_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ADD CONSTRAINT `fk_compliance_ftc_label_labeling_requirement_id` FOREIGN KEY (`labeling_requirement_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`labeling_requirement`(`labeling_requirement_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ADD CONSTRAINT `fk_compliance_ftc_label_superseded_by_label_ftc_label_id` FOREIGN KEY (`superseded_by_label_ftc_label_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`ftc_label`(`ftc_label_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_compliance_audit_finding_id` FOREIGN KEY (`compliance_audit_finding_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding`(`compliance_audit_finding_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_related_incident_id` FOREIGN KEY (`related_incident_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ADD CONSTRAINT `fk_compliance_document_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ADD CONSTRAINT `fk_compliance_document_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ADD CONSTRAINT `fk_compliance_document_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ADD CONSTRAINT `fk_compliance_document_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ADD CONSTRAINT `fk_compliance_document_supersedes_document_id` FOREIGN KEY (`supersedes_document_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`document`(`document_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ADD CONSTRAINT `fk_compliance_document_superseded_document_id` FOREIGN KEY (`superseded_document_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`document`(`document_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ADD CONSTRAINT `fk_compliance_restricted_substance_parent_restricted_substance_id` FOREIGN KEY (`parent_restricted_substance_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`restricted_substance`(`restricted_substance_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ADD CONSTRAINT `fk_compliance_labeling_requirement_superseded_by_requirement_labeling_requirement_id` FOREIGN KEY (`superseded_by_requirement_labeling_requirement_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`labeling_requirement`(`labeling_requirement_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ADD CONSTRAINT `fk_compliance_labeling_requirement_parent_labeling_requirement_id` FOREIGN KEY (`parent_labeling_requirement_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`labeling_requirement`(`labeling_requirement_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`substance_regulation` ADD CONSTRAINT `fk_compliance_substance_regulation_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`substance_regulation` ADD CONSTRAINT `fk_compliance_substance_regulation_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`substance_regulation` ADD CONSTRAINT `fk_compliance_substance_regulation_restricted_substance_id` FOREIGN KEY (`restricted_substance_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`restricted_substance`(`restricted_substance_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`test_substance_measurement` ADD CONSTRAINT `fk_compliance_test_substance_measurement_product_safety_test_id` FOREIGN KEY (`product_safety_test_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`product_safety_test`(`product_safety_test_id`);
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`test_substance_measurement` ADD CONSTRAINT `fk_compliance_test_substance_measurement_restricted_substance_id` FOREIGN KEY (`restricted_substance_id`) REFERENCES `apparel_fashion_ecm`.`compliance`.`restricted_substance`(`restricted_substance_id`);

-- ========= TAGS =========
ALTER SCHEMA `apparel_fashion_ecm`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `apparel_fashion_ecm`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `esg_report_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Report Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `compliance_level` SET TAGS ('dbx_business_glossary_term' = 'Compliance Level');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `compliance_level` SET TAGS ('dbx_value_regex' = 'full_compliance|conditional_compliance|non_compliance|pending_review');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_cost` SET TAGS ('dbx_business_glossary_term' = 'Filing Cost');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_currency` SET TAGS ('dbx_business_glossary_term' = 'Filing Cost Currency');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_description` SET TAGS ('dbx_business_glossary_term' = 'Filing Description');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Number');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|withdrawn');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_value_regex' = 'textile_labeling|product_safety|certification|trade_compliance|esg_report|audit_report');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `non_conformance_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Count');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency in Months');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `responsible_party` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Email Address');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'product_safety|environmental|labor|trade|financial|data_privacy');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `supporting_document_count` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Count');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `created_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `material_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `certificate_document_url` SET TAGS ('dbx_business_glossary_term' = 'Certificate Document Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `certification_category` SET TAGS ('dbx_business_glossary_term' = 'Certification Category');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `certification_scope` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `certification_scope` SET TAGS ('dbx_value_regex' = 'product|facility|organization|supplier|material|process');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|withdrawn|pending|under_review');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `certified_entity_country_code` SET TAGS ('dbx_business_glossary_term' = 'Certified Entity Country Code');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `certified_entity_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `certified_entity_location` SET TAGS ('dbx_business_glossary_term' = 'Certified Entity Location');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `certified_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Certified Entity Name');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `certified_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Certified Entity Type');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `certified_entity_type` SET TAGS ('dbx_value_regex' = 'internal_facility|external_supplier|contract_manufacturer|raw_material_supplier|product_line|corporate_entity');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `certified_materials_list` SET TAGS ('dbx_business_glossary_term' = 'Certified Materials List');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `certified_products_list` SET TAGS ('dbx_business_glossary_term' = 'Certified Products List');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `compliance_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Compliance Jurisdiction');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `issuing_body_accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body Accreditation Number');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `public_verification_url` SET TAGS ('dbx_business_glossary_term' = 'Public Verification Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `renewal_application_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Application Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|overdue');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Email Address');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `standard_version` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard Version');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_certification` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `applicable_business_process` SET TAGS ('dbx_business_glossary_term' = 'Applicable Business Process');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `applicable_product_category` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Category');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `audit_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Scheduled Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `business_process_owner` SET TAGS ('dbx_business_glossary_term' = 'Business Process Owner');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `business_process_owner` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `calendar_entry_status` SET TAGS ('dbx_business_glossary_term' = 'Calendar Entry Status');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `calendar_entry_status` SET TAGS ('dbx_value_regex' = 'upcoming|overdue|completed|waived|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `certification_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Renewal Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `documentation_required` SET TAGS ('dbx_business_glossary_term' = 'Documentation Required');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `escalation_path` SET TAGS ('dbx_business_glossary_term' = 'Escalation Path');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `escalation_trigger_days` SET TAGS ('dbx_business_glossary_term' = 'Escalation Trigger Days');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `external_reference_url` SET TAGS ('dbx_business_glossary_term' = 'External Reference Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `filing_deadline` SET TAGS ('dbx_business_glossary_term' = 'Filing Deadline');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `internal_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Internal Policy Reference');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `maximum_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Penalty Amount');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `maximum_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_name` SET TAGS ('dbx_business_glossary_term' = 'Obligation Name');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Status');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|archived');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'labeling|safety|esg|trade|labor|chemical');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `penalty_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Description');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `penalty_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `reminder_trigger_days` SET TAGS ('dbx_business_glossary_term' = 'Reminder Trigger Days');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `responsible_team` SET TAGS ('dbx_business_glossary_term' = 'Responsible Team');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|ad_hoc');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`obligation` ALTER COLUMN `sla_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Threshold Days');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` SET TAGS ('dbx_subdomain' = 'facility_auditing');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `supplier_esg_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Esg Assessment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `approved_for_production_flag` SET TAGS ('dbx_business_glossary_term' = 'Approved for Production Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Conducted Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope Description');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Lifecycle Status');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|pending_review');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type Classification');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'social|environmental|quality|safety|combined');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Name');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `auditor_organization` SET TAGS ('dbx_business_glossary_term' = 'Auditor Organization Name');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `auditor_organization` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `auditor_type` SET TAGS ('dbx_business_glossary_term' = 'Auditor Type Classification');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `auditor_type` SET TAGS ('dbx_value_regex' = 'internal|third_party|certification_body');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|provisional|suspended|revoked|not_applicable');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `compliance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Compliance Percentage Score');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `corrective_action_plan_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Due Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Amount');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Country Code');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit End Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `follow_up_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Audit Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Rating');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|acceptable|needs_improvement|unacceptable|zero_tolerance');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Score');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `program` SET TAGS ('dbx_business_glossary_term' = 'Audit Program Name');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Audit Protocol Version Number');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `protocol_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,2}.[0-9]{1,2}(.[0-9]{1,2})?$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `report_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Document URL');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `report_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `report_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Facility Risk Level Classification');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Audit Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Start Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `summary` SET TAGS ('dbx_business_glossary_term' = 'Audit Summary Notes');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`audit` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` SET TAGS ('dbx_subdomain' = 'facility_auditing');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `compliance_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Finding Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `higg_index_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Higg Index Assessment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `previous_finding_compliance_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Finding Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `affected_product_category` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Category');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `affected_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Stock Keeping Unit (SKU) Count');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `auditor_organization` SET TAGS ('dbx_business_glossary_term' = 'Auditor Organization');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `business_impact` SET TAGS ('dbx_business_glossary_term' = 'Business Impact');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `business_impact` SET TAGS ('dbx_value_regex' = 'reputational|financial|operational|legal|supply_chain');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `closed_by` SET TAGS ('dbx_business_glossary_term' = 'Closed By');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|management|executive|board|external');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `estimated_remediation_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Remediation Cost');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `estimated_remediation_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `evidence_file_path` SET TAGS ('dbx_business_glossary_term' = 'Evidence File Path');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_business_glossary_term' = 'Finding Category');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_value_regex' = 'labor|safety|environmental|quality|ethical|trade_compliance');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `finding_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}-[0-9]{4,6}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_value_regex' = 'open|in_remediation|pending_verification|closed|escalated');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor|observation');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `standard_clause` SET TAGS ('dbx_business_glossary_term' = 'Standard Clause');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'document_review|on_site_inspection|photographic_evidence|interview|re_audit');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `verification_notes` SET TAGS ('dbx_business_glossary_term' = 'Verification Notes');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_started|pending|verified|rejected|partially_verified');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`compliance_audit_finding` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` SET TAGS ('dbx_subdomain' = 'facility_auditing');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Initiative Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `previous_cap_corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Corrective Action Plan (CAP) ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Number');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_number` SET TAGS ('dbx_value_regex' = '^CAP-[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `cap_title` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Title');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `compliance_category` SET TAGS ('dbx_value_regex' = 'labor_standards|health_safety|environmental|product_safety|trade_compliance|ethical_sourcing');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `corrective_action_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Status');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `finding_id` SET TAGS ('dbx_business_glossary_term' = 'Finding ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `issue_description` SET TAGS ('dbx_business_glossary_term' = 'Issue Description');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `preventive_measures` SET TAGS ('dbx_business_glossary_term' = 'Preventive Measures');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Contact Email');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Contact Name');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Responsible Contact Phone');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Type');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_value_regex' = 'factory|supplier|internal_team|third_party_vendor|logistics_partner');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|moderate|minor');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'on_site_inspection|document_review|photo_evidence|video_evidence|third_party_audit|self_assessment');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `verification_notes` SET TAGS ('dbx_business_glossary_term' = 'Verification Notes');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`corrective_action_plan` ALTER COLUMN `verifier_name` SET TAGS ('dbx_business_glossary_term' = 'Verifier Name');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` SET TAGS ('dbx_subdomain' = 'substance_testing');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `product_safety_test_id` SET TAGS ('dbx_business_glossary_term' = 'Product Safety Test ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `cad_file_id` SET TAGS ('dbx_business_glossary_term' = 'Cad File Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `chemical_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Compliance Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `colorway_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `product_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `testing_laboratory_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Testing Laboratory ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `age_group` SET TAGS ('dbx_business_glossary_term' = 'Age Group');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `age_group` SET TAGS ('dbx_value_regex' = 'infant|toddler|child|youth|adult');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `production_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Number');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `remediation_required` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `retest_required` SET TAGS ('dbx_business_glossary_term' = 'Retest Required');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `test_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Test Approved By');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `test_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Test Approved Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `test_cost` SET TAGS ('dbx_business_glossary_term' = 'Test Cost');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `test_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `test_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Test Cost Currency');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `test_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `test_number` SET TAGS ('dbx_business_glossary_term' = 'Test Number');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `test_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `test_report_url` SET TAGS ('dbx_business_glossary_term' = 'Test Report URL');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `test_requested_by` SET TAGS ('dbx_business_glossary_term' = 'Test Requested By');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|pending|retest_required');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `test_standard` SET TAGS ('dbx_business_glossary_term' = 'Test Standard');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|on_hold');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `testing_laboratory_name` SET TAGS ('dbx_business_glossary_term' = 'Testing Laboratory Name');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `threshold_operator` SET TAGS ('dbx_business_glossary_term' = 'Threshold Operator');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `threshold_operator` SET TAGS ('dbx_value_regex' = 'greater_than|less_than|equal_to|greater_than_or_equal|less_than_or_equal');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`product_safety_test` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `ftc_label_id` SET TAGS ('dbx_business_glossary_term' = 'Federal Trade Commission (FTC) Label Identifier');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `colorway_development_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway Development Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `ecolabel_id` SET TAGS ('dbx_business_glossary_term' = 'Ecolabel Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `labeling_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Labeling Requirement Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `print_design_id` SET TAGS ('dbx_business_glossary_term' = 'Print Design Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `superseded_by_label_ftc_label_id` SET TAGS ('dbx_business_glossary_term' = 'Superseding Label Identifier');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Label Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `care_instructions` SET TAGS ('dbx_business_glossary_term' = 'Care and Maintenance Instructions');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `care_symbol_code` SET TAGS ('dbx_business_glossary_term' = 'Care Symbol Code Sequence');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `country_of_origin_statement` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Disclosure Statement');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `down_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Down Content Percentage by Weight');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `down_feather_indicator` SET TAGS ('dbx_business_glossary_term' = 'Down and Feather Product Indicator');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Label Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Label Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `fiber_content_description` SET TAGS ('dbx_business_glossary_term' = 'Fiber Content Composition Description');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `flammability_standard_code` SET TAGS ('dbx_business_glossary_term' = 'Flammability Standard Code');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `flammability_standard_code` SET TAGS ('dbx_value_regex' = '16CFR1610|16CFR1615|16CFR1616|exempt|not_applicable');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `flammability_test_result` SET TAGS ('dbx_business_glossary_term' = 'Flammability Test Result Status');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `flammability_test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_tested|exempt');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `fur_animal_name` SET TAGS ('dbx_business_glossary_term' = 'Fur Animal Name Disclosure');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `fur_product_indicator` SET TAGS ('dbx_business_glossary_term' = 'Fur Product Indicator Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `label_language` SET TAGS ('dbx_business_glossary_term' = 'Label Language Code');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `label_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `label_number` SET TAGS ('dbx_business_glossary_term' = 'Label Control Number');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `label_number` SET TAGS ('dbx_value_regex' = '^LBL-[A-Z0-9]{8,12}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `label_status` SET TAGS ('dbx_business_glossary_term' = 'Label Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `label_status` SET TAGS ('dbx_value_regex' = 'draft|legal_review|approved|active|superseded|retired');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `label_type` SET TAGS ('dbx_business_glossary_term' = 'Label Format Type');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `label_type` SET TAGS ('dbx_value_regex' = 'woven|printed|heat_transfer|hang_tag|sewn_in|adhesive');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `legal_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewer Name');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `legal_reviewer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `manufacturer_identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Identifier Type');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `manufacturer_identifier_type` SET TAGS ('dbx_value_regex' = 'RN|WPL|company_name');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer or Importer Company Name');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Label Notes and Comments');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `oeko_tex_certified` SET TAGS ('dbx_business_glossary_term' = 'OEKO-TEX Standard 100 Certified Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `organic_certification_indicator` SET TAGS ('dbx_business_glossary_term' = 'Organic Certification Indicator Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `primary_fiber_percentage` SET TAGS ('dbx_business_glossary_term' = 'Primary Fiber Percentage by Weight');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `primary_fiber_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Fiber Type');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category Classification');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `product_category` SET TAGS ('dbx_value_regex' = 'apparel|footwear|accessories|childrens_sleepwear|down_feather_products|textile_home_goods');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `recycled_content_indicator` SET TAGS ('dbx_business_glossary_term' = 'Recycled Content Indicator Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `recycled_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Recycled Content Percentage by Weight');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Label Revision Number');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Label Revision Reason Description');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `rn_number` SET TAGS ('dbx_business_glossary_term' = 'Registered Identification Number (RN)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `rn_number` SET TAGS ('dbx_value_regex' = '^RN[0-9]{5,6}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `wool_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Wool Content Percentage by Weight');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `wool_product_indicator` SET TAGS ('dbx_business_glossary_term' = 'Wool Product Indicator Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `wpl_number` SET TAGS ('dbx_business_glossary_term' = 'Wool Products Labeling Number (WPL)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`ftc_label` ALTER COLUMN `wpl_number` SET TAGS ('dbx_value_regex' = '^WPL[0-9]{4,5}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `trade_compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Compliance Record Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `carbon_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `antidumping_duty_flag` SET TAGS ('dbx_business_glossary_term' = 'Antidumping Duty Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `certificate_of_origin_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Origin Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `certificate_of_origin_type` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Origin Type');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `certificate_of_origin_type` SET TAGS ('dbx_value_regex' = 'form_a|usmca_cert|eur1|movement_cert|self_certification|none');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `classification_date` SET TAGS ('dbx_business_glossary_term' = 'Classification Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `classification_method` SET TAGS ('dbx_business_glossary_term' = 'Classification Method');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `classification_method` SET TAGS ('dbx_value_regex' = 'manual|automated|third_party|customs_ruling');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|pending_documentation|expired');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `coo_determination_date` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (COO) Determination Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `coo_determination_method` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (COO) Determination Method');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `coo_determination_method` SET TAGS ('dbx_value_regex' = 'substantial_transformation|tariff_shift|value_added|assembly|wholly_obtained');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `countervailing_duty_flag` SET TAGS ('dbx_business_glossary_term' = 'Countervailing Duty Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (COO)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `duty_optimization_strategy` SET TAGS ('dbx_business_glossary_term' = 'Duty Optimization Strategy');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `duty_optimization_strategy` SET TAGS ('dbx_value_regex' = 'standard|fta_preferential|gsp|duty_drawback|ftz|bonded_warehouse');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `export_license_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Export License Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `gsp_beneficiary_country` SET TAGS ('dbx_business_glossary_term' = 'Generalized System of Preferences (GSP) Beneficiary Country');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `gsp_beneficiary_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `gsp_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Generalized System of Preferences (GSP) Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `hs_code_description` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code Description');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `import_duty_rate` SET TAGS ('dbx_business_glossary_term' = 'Import Duty Rate');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `landed_duty_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Landed Duty Paid (LDP) Amount');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `landed_duty_paid_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `ldp_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Landed Duty Paid (LDP) Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `ldp_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `preferential_duty_rate` SET TAGS ('dbx_business_glossary_term' = 'Preferential Duty Rate');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `quota_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Quota Applicable Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `record_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `restricted_party_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Restricted Party Screening Status');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `restricted_party_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|flagged|pending|not_screened');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `ruling_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Customs Ruling Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `ruling_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Ruling Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `ruling_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,20}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `sanctioned_country_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanctioned Country Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `screening_date` SET TAGS ('dbx_business_glossary_term' = 'Screening Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `special_program_code` SET TAGS ('dbx_business_glossary_term' = 'Special Program Code');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `special_program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `textile_category_code` SET TAGS ('dbx_business_glossary_term' = 'Textile Category Code');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `textile_category_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3,4}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `trade_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Code');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `trade_agreement_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `trade_lane_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Lane Code');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`trade_compliance_record` ALTER COLUMN `trade_lane_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `affected_business_processes` SET TAGS ('dbx_business_glossary_term' = 'Affected Business Processes');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `affected_data_domains` SET TAGS ('dbx_business_glossary_term' = 'Affected Data Domains');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `change_status` SET TAGS ('dbx_business_glossary_term' = 'Change Status');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `change_status` SET TAGS ('dbx_value_regex' = 'proposed|enacted|effective|deferred|withdrawn');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'new|amendment|repeal|clarification|extension|suspension');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `compliance_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `compliance_owner` SET TAGS ('dbx_business_glossary_term' = 'Compliance Owner');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `compliance_owner` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `compliance_progress_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Progress Status');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `compliance_progress_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|overdue|on_hold');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `estimated_compliance_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Compliance Cost');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `estimated_compliance_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `external_consultant_engaged` SET TAGS ('dbx_business_glossary_term' = 'External Consultant Engaged');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|minimal');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `internal_response_required` SET TAGS ('dbx_business_glossary_term' = 'Internal Response Required');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `penalty_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Description');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `regulation_code` SET TAGS ('dbx_business_glossary_term' = 'Regulation Code');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `regulation_name` SET TAGS ('dbx_business_glossary_term' = 'Regulation Name');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `regulation_summary` SET TAGS ('dbx_business_glossary_term' = 'Regulation Summary');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `regulation_url` SET TAGS ('dbx_business_glossary_term' = 'Regulation URL');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `related_regulations` SET TAGS ('dbx_business_glossary_term' = 'Related Regulations');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `response_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Response Action Plan');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` SET TAGS ('dbx_subdomain' = 'facility_auditing');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `colorway_development_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway Development Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `compliance_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Finding Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `esg_disclosure_metric_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Disclosure Metric Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `print_design_id` SET TAGS ('dbx_business_glossary_term' = 'Print Design Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Facility Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `related_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Related Incident Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Supplier Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `actual_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Penalty Amount');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `actual_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `affected_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Affected Business Unit');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `affected_individuals_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Individuals Count');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `affected_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Affected Jurisdiction');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `assigned_investigator` SET TAGS ('dbx_business_glossary_term' = 'Assigned Investigator');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `assigned_investigator` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `certification_impacted` SET TAGS ('dbx_business_glossary_term' = 'Certification Impacted');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `escalated_to_executive` SET TAGS ('dbx_business_glossary_term' = 'Escalated to Executive');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `identification_source` SET TAGS ('dbx_business_glossary_term' = 'Identification Source');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Identified Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `identified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Identified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = '^INC-[0-9]{8}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'identified|under_investigation|remediation_in_progress|resolved|closed|escalated');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'labor_violation|product_safety_breach|data_privacy_breach|trade_compliance_violation|environmental_violation|ethical_sourcing_violation');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `public_disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `public_disclosure_required` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Required');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `recurrence_indicator` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Indicator');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `regulatory_notification_deadline` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Deadline');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` SET TAGS ('dbx_subdomain' = 'facility_auditing');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `collaboration_id` SET TAGS ('dbx_business_glossary_term' = 'Design Collaboration Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `print_design_id` SET TAGS ('dbx_business_glossary_term' = 'Print Design Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `supersedes_document_id` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Document ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `superseded_document_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `access_restriction_notes` SET TAGS ('dbx_business_glossary_term' = 'Access Restriction Notes');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Classification');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `confidentiality_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `destruction_eligible_date` SET TAGS ('dbx_business_glossary_term' = 'Destruction Eligible Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `document_source` SET TAGS ('dbx_business_glossary_term' = 'Document Source');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `document_source` SET TAGS ('dbx_value_regex' = 'internal|third_party_auditor|laboratory|regulatory_body|supplier|legal_counsel');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `document_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|archived|expired');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'audit_report|certification_document|test_result_report|regulatory_filing_confirmation|corrective_action_evidence|chain_of_custody_record');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'File Path');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `file_size_kb` SET TAGS ('dbx_business_glossary_term' = 'File Size Kilobytes (KB)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `hash` SET TAGS ('dbx_business_glossary_term' = 'Document Hash');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `issuing_organization` SET TAGS ('dbx_business_glossary_term' = 'Issuing Organization');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `legal_hold_case_number` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Case Number');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Email');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `responsible_party_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Tags');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `upload_date` SET TAGS ('dbx_business_glossary_term' = 'Upload Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|verified|rejected|pending_verification');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` SET TAGS ('dbx_subdomain' = 'substance_testing');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `restricted_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Restricted Substance ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `chemical_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Compliance Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `colorway_development_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway Development Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `print_design_id` SET TAGS ('dbx_business_glossary_term' = 'Print Design Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `parent_restricted_substance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `alternative_substance_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Alternative Substance Recommendation');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `applicable_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Applicable Jurisdiction');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `applicable_material_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Material Type');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `applicable_product_category` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Category');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Authorization Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `exemption_conditions` SET TAGS ('dbx_business_glossary_term' = 'Exemption Conditions');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `health_hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Health Hazard Classification');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `health_hazard_classification` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `health_hazard_classification` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `penalty_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Description');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `reporting_threshold_flag` SET TAGS ('dbx_business_glossary_term' = 'Reporting Threshold Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `restriction_status` SET TAGS ('dbx_business_glossary_term' = 'Restriction Status');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `restriction_status` SET TAGS ('dbx_value_regex' = 'prohibited|restricted|monitored|phased_out|under_review');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `source_reference_url` SET TAGS ('dbx_business_glossary_term' = 'Source Reference URL');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `substance_category` SET TAGS ('dbx_business_glossary_term' = 'Substance Category');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `substance_name` SET TAGS ('dbx_business_glossary_term' = 'Substance Name');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `sunset_date` SET TAGS ('dbx_business_glossary_term' = 'Sunset Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `svhc_candidate_list_flag` SET TAGS ('dbx_business_glossary_term' = 'Substance of Very High Concern (SVHC) Candidate List Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `test_method_standard` SET TAGS ('dbx_business_glossary_term' = 'Test Method Standard');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `threshold_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Limit Value');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit of Measure');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`restricted_substance` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'ppm|mg_kg|percent|mg_l|ug_g');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `labeling_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Labeling Requirement ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `superseded_by_requirement_labeling_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Requirement ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `parent_labeling_requirement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `age_group` SET TAGS ('dbx_business_glossary_term' = 'Age Group');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `age_group` SET TAGS ('dbx_value_regex' = 'adult|children|infant|toddler|all');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `care_instruction_required` SET TAGS ('dbx_business_glossary_term' = 'Care Instruction Required');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `care_symbol_standard` SET TAGS ('dbx_business_glossary_term' = 'Care Symbol Standard');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `country_of_origin_format` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (COO) Format');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `country_of_origin_required` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (COO) Required');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `environmental_claim_standard` SET TAGS ('dbx_business_glossary_term' = 'Environmental Claim Standard');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `fiber_content_format` SET TAGS ('dbx_business_glossary_term' = 'Fiber Content Format');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `fiber_content_required` SET TAGS ('dbx_business_glossary_term' = 'Fiber Content Required');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `flammability_standard` SET TAGS ('dbx_business_glossary_term' = 'Flammability Standard');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `font_size_minimum` SET TAGS ('dbx_business_glossary_term' = 'Font Size Minimum');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `label_permanence` SET TAGS ('dbx_business_glossary_term' = 'Label Permanence');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `label_permanence` SET TAGS ('dbx_value_regex' = 'permanent|removable|hang_tag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `label_placement` SET TAGS ('dbx_business_glossary_term' = 'Label Placement');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `language_required` SET TAGS ('dbx_business_glossary_term' = 'Language Required');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `manufacturer_id_required` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Identification Required');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `manufacturer_id_type` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Identification Type');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `manufacturer_id_type` SET TAGS ('dbx_value_regex' = 'rn_number|wpl_number|company_name|address');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `maximum_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Penalty Amount');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `organic_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Organic Certification Required');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `penalty_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Description');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `recycled_content_disclosure` SET TAGS ('dbx_business_glossary_term' = 'Recycled Content Disclosure');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `reference_url` SET TAGS ('dbx_business_glossary_term' = 'Reference Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Requirement Code');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `requirement_name` SET TAGS ('dbx_business_glossary_term' = 'Requirement Name');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Requirement Status');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded|draft|under_review');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Requirement Type');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_value_regex' = 'care_instruction|fiber_content|country_of_origin|size_labeling|safety_warning|flammability');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Months');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `safety_warning_required` SET TAGS ('dbx_business_glossary_term' = 'Safety Warning Required');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `safety_warning_text` SET TAGS ('dbx_business_glossary_term' = 'Safety Warning Text');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `size_labeling_required` SET TAGS ('dbx_business_glossary_term' = 'Size Labeling Required');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`labeling_requirement` ALTER COLUMN `size_standard` SET TAGS ('dbx_business_glossary_term' = 'Size Standard');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`substance_regulation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`substance_regulation` SET TAGS ('dbx_subdomain' = 'substance_testing');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`substance_regulation` SET TAGS ('dbx_association_edges' = 'compliance.compliance_obligation,compliance.restricted_substance');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`substance_regulation` ALTER COLUMN `substance_regulation_id` SET TAGS ('dbx_business_glossary_term' = 'Substance Regulation ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`substance_regulation` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`substance_regulation` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Substance Regulation - Compliance Obligation Id');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`substance_regulation` ALTER COLUMN `restricted_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Substance Regulation - Restricted Substance Id');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`substance_regulation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`substance_regulation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Regulation Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`substance_regulation` ALTER COLUMN `exemption_conditions` SET TAGS ('dbx_business_glossary_term' = 'Exemption Conditions');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`substance_regulation` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`substance_regulation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`substance_regulation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`substance_regulation` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`substance_regulation` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`substance_regulation` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`substance_regulation` ALTER COLUMN `regulation_status` SET TAGS ('dbx_business_glossary_term' = 'Regulation Status');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`substance_regulation` ALTER COLUMN `reporting_threshold_flag` SET TAGS ('dbx_business_glossary_term' = 'Reporting Threshold Flag');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`substance_regulation` ALTER COLUMN `sunset_date` SET TAGS ('dbx_business_glossary_term' = 'Regulation Sunset Date');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`substance_regulation` ALTER COLUMN `threshold_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Limit Value');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`substance_regulation` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`test_substance_measurement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`test_substance_measurement` SET TAGS ('dbx_subdomain' = 'substance_testing');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`test_substance_measurement` SET TAGS ('dbx_association_edges' = 'compliance.product_safety_test,compliance.restricted_substance');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`test_substance_measurement` ALTER COLUMN `test_substance_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Test Substance Measurement ID');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`test_substance_measurement` ALTER COLUMN `product_safety_test_id` SET TAGS ('dbx_business_glossary_term' = 'Test Substance Measurement - Product Safety Test Id');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`test_substance_measurement` ALTER COLUMN `restricted_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Test Substance Measurement - Restricted Substance Id');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`test_substance_measurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`test_substance_measurement` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`test_substance_measurement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`test_substance_measurement` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`test_substance_measurement` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measurement Value');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`test_substance_measurement` ALTER COLUMN `result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`test_substance_measurement` ALTER COLUMN `test_measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Test Measurement Unit');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`test_substance_measurement` ALTER COLUMN `test_measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Test Measurement Value');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`test_substance_measurement` ALTER COLUMN `threshold_operator` SET TAGS ('dbx_business_glossary_term' = 'Threshold Operator');
ALTER TABLE `apparel_fashion_ecm`.`compliance`.`test_substance_measurement` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
