-- Schema for Domain: service | Business: Legal | Version: v8_ecm
-- Generated on: 2026-05-21 01:11:38

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `legal_ecm_v1`.`service` COMMENT 'Catalog of legal service offerings such as M&A advisory, litigation, IP counsel, regulatory compliance counseling, employment law, and advisory packages. Manages service definitions, practice area taxonomy, pricing models, SLA terms, and service-to-matter mappings enabling business development and RFP responses.';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`service`.`practice_area` (
    `practice_area_id` BIGINT COMMENT 'Unique identifier for the practice area. Primary key for the practice area master taxonomy.',
    `category_id` BIGINT COMMENT 'Foreign key linking to risk.risk_category. Business justification: Practice areas map to inherent risk categories (litigation = PI exposure, regulatory = compliance risk, corporate = conflict risk). Insurance allocation, conflict screening protocols, and risk managem',
    `parent_practice_area_id` BIGINT COMMENT 'Reference to the parent practice area in the hierarchical taxonomy, enabling roll-up reporting from sub-specializations to broader practice groups. Null for top-level practice areas.',
    `average_matter_value` DECIMAL(18,2) COMMENT 'Historical average total billed value for matters in this practice area, used for pipeline valuation, revenue forecasting, and business development targeting. Expressed in firm base currency.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether time and disbursements in this practice area are typically billable to clients. False for internal practice areas such as professional development, pro bono coordination, or firm administration.',
    `classification_type` STRING COMMENT 'High-level classification of the practice area by the nature of legal work performed. Transactional covers M&A (Mergers and Acquisitions), corporate deals; Advisory covers counseling and opinions; Litigation covers dispute resolution; Regulatory covers compliance and government relations; Hybrid covers mixed-mode practices; Specialized covers niche areas like IP (Intellectual Property) prosecution.. Valid values are `transactional|advisory|litigation|regulatory|hybrid|specialized`',
    `cpd_requirement_hours` DECIMAL(18,2) COMMENT 'Annual CPD (Continuing Professional Development) or CLE (Continuing Legal Education) hours required for timekeepers practicing in this area, as mandated by the governing regulatory body. Used for compliance tracking and training program planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this practice area record was first created in the system. Used for audit trail and data lineage tracking.',
    `default_billing_arrangement` STRING COMMENT 'The most common fee arrangement type for matters in this practice area. Hourly for traditional time-based billing; Fixed Fee for scoped project work; Contingency for plaintiff litigation; AFA (Alternative Fee Arrangement) for value-based or risk-sharing models; Retainer for ongoing advisory; Capped Fee for budget-certainty arrangements; Blended Rate for team-based pricing; Success Fee for outcome-based compensation. [ENUM-REF-CANDIDATE: hourly|fixed_fee|contingency|afa|retainer|capped_fee|blended_rate|success_fee — 8 candidates stripped; promote to reference product]',
    `effective_from_date` DATE COMMENT 'Date from which this practice area definition became effective and available for matter classification and timekeeper assignment. Used for historical reporting and taxonomy versioning.',
    `effective_to_date` DATE COMMENT 'Date on which this practice area definition ceased to be effective. Null for currently active practice areas. Used for historical reporting and taxonomy evolution tracking.',
    `external_reference_code` STRING COMMENT 'External or client-facing practice area code used in RFP (Request for Proposal) responses, pitch materials, or industry benchmarking surveys. May differ from internal code for marketing or competitive positioning reasons.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this practice area in the hierarchical taxonomy. Level 1 represents top-level practice groups, Level 2 represents major practice areas, Level 3+ represents sub-specializations. Enables hierarchical roll-up queries and reporting.',
    `hierarchy_path` STRING COMMENT 'Materialized path representing the full lineage from root to this practice area, typically formatted as slash-separated IDs or codes (e.g., /CORP/MA/CROSSBORDER). Optimizes hierarchical queries and enables efficient ancestor/descendant lookups.',
    `insurance_coverage_requirement` STRING COMMENT 'Specific professional indemnity or malpractice insurance coverage requirements for this practice area, including minimum coverage amounts and specialized endorsements. Critical for high-risk areas like securities litigation, M&A (Mergers and Acquisitions), or medical malpractice defense.',
    `jurisdiction_scope` STRING COMMENT 'Geographic or legal jurisdiction scope for this practice area. May be a single jurisdiction (e.g., New York, England and Wales), multi-jurisdictional (e.g., US Federal, EU), or global. Critical for conflict checking, regulatory compliance, and timekeeper licensing requirements.',
    `knowledge_management_category` STRING COMMENT 'Classification used by the firms knowledge management system to organize precedents, practice notes, standard documents, and checklists for this practice area. Maps to DMS (Document Management System) taxonomy and knowledge repository structure.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this practice area record was last updated. Used for change tracking, audit trail, and data synchronization across systems.',
    `practice_area_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the practice area across all firm systems. Used in matter coding, timekeeper assignments, and rate card structures.. Valid values are `^[A-Z0-9]{2,10}$`',
    `practice_area_description` STRING COMMENT 'Detailed narrative describing the scope, services, and typical matters handled within this practice area. Used for RFP (Request for Proposal) responses, business development materials, and knowledge management.',
    `practice_area_name` STRING COMMENT 'Full business name of the practice area as recognized by clients and used in marketing materials, engagement letters, and matter classifications.',
    `practice_area_status` STRING COMMENT 'Current lifecycle status of the practice area. Active areas are available for new matter intake and timekeeper assignment. Inactive areas are no longer offered but may have legacy matters. Suspended areas are temporarily unavailable. Archived areas are historical records only.. Valid values are `active|inactive|suspended|archived`',
    `practice_group` STRING COMMENT 'Broader practice group or department to which this practice area belongs, enabling organizational roll-up and resource allocation reporting.',
    `primary_service_line` STRING COMMENT 'The primary revenue-generating service line or business unit to which this practice area contributes. Used for P&L (Profit and Loss) allocation, partner compensation, and strategic planning.',
    `pro_bono_eligible` BOOLEAN COMMENT 'Indicates whether this practice area is commonly used for pro bono matters. True for areas like immigration, civil rights, family law; False for highly specialized commercial areas. Used for pro bono reporting and CLE (Continuing Legal Education) credit tracking.',
    `regulatory_body_alignment` STRING COMMENT 'Primary regulatory or professional body whose standards, ethics rules, and CPD (Continuing Professional Development) requirements govern this practice area. Examples include ABA (American Bar Association), SRA (Solicitors Regulation Authority), IBA (International Bar Association), state bar associations, or specialized bodies like USPTO for IP (Intellectual Property) practice.',
    `requires_security_clearance` BOOLEAN COMMENT 'Indicates whether timekeepers working in this practice area typically require government or client security clearance due to the nature of matters (e.g., defense contracting, national security, classified government work).',
    `requires_specialization` BOOLEAN COMMENT 'Indicates whether this practice area requires specialized certification, licensing, or accreditation beyond general legal practice admission. True for areas like patent prosecution (USPTO registration), tax law (CPA or LLM), or admiralty law (specialized bar admission).',
    `short_name` STRING COMMENT 'Abbreviated name or acronym for the practice area used in internal reporting, dashboards, and space-constrained displays.',
    `source_system` STRING COMMENT 'Name of the operational system of record from which this practice area definition originated. Typically Elite 3E practice area master, but may include legacy systems or manual taxonomy management tools.',
    `technology_platform_requirement` STRING COMMENT 'Specialized technology platforms or tools typically required for matters in this practice area. Examples: Relativity for eDiscovery (Electronic Discovery) in litigation; LexisNexis for legal research; CLM (Contract Lifecycle Management) systems for transactional work; IP (Intellectual Property) docketing systems for patent prosecution.',
    `typical_matter_duration_days` STRING COMMENT 'Average or median duration in days for matters in this practice area, from matter opening to closure. Used for resource planning, pipeline forecasting, and WIP (Work in Progress) aging analysis. Null for ongoing advisory relationships without defined end dates.',
    `utbms_activity_code_prefix` STRING COMMENT 'Standard UTBMS (Uniform Task-Based Management System) activity code prefix applicable to this practice area, providing granular activity-level coding for time entries and expense tracking in client billing.. Valid values are `^[A-Z][0-9]{3}$`',
    `utbms_task_code_prefix` STRING COMMENT 'Standard UTBMS (Uniform Task-Based Management System) task code prefix applicable to this practice area, enabling standardized time entry coding and client billing compliance. Examples: L for Litigation, C for Case Management, A for ADR (Alternative Dispute Resolution), T for Transactional.. Valid values are `^[A-Z][0-9]{3}$`',
    CONSTRAINT pk_practice_area PRIMARY KEY(`practice_area_id`)
) COMMENT 'Master taxonomy of legal practice areas and sub-specializations offered by the firm (e.g., M&A, Litigation, IP, Employment Law, Regulatory Compliance, Real Estate). Supports hierarchical parent-child classification enabling roll-up reporting. Each practice area carries a unique code, description, active/inactive status, and regulatory body alignment. Used to categorize matters, timekeepers, service offerings, and rate cards across all firm systems.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`service`.`legal_service` (
    `legal_service_id` BIGINT COMMENT 'Unique identifier for the legal service offering. Primary key for the legal service catalog.',
    `attorney_profile_id` BIGINT COMMENT 'Identifier of the partner responsible for this service offerings definition, quality, pricing, and strategic positioning. Links to the workforce or partner master data.',
    `category_id` BIGINT COMMENT 'Foreign key linking to risk.risk_category. Business justification: Legal services are classified by inherent risk category (M&A = conflict risk, IP = PI exposure). Risk-based pricing, insurance requirements, and partner approval thresholds depend on this classificati',
    `delivery_model_id` BIGINT COMMENT 'FK to service.delivery_model.delivery_model_id — Services are delivered through specific models (in-house, secondment, ALSP). The service definition must reference its standard delivery model for capacity planning and client communication.',
    `line_id` BIGINT COMMENT 'FK to service.service_line.service_line_id — Every legal service rolls up to a service line for P&L reporting and business management. This is the operational grouping FK that enables firm financial reporting by service line.',
    `practice_area_id` BIGINT COMMENT 'FK to service.practice_area.practice_area_id — Every legal service offering must be classified under a practice area. This is the primary taxonomic relationship in the domain and is referenced in every RFP, engagement letter, and matter opening. W',
    `allows_afa` BOOLEAN COMMENT 'Indicates whether this service offering is eligible for Alternative Fee Arrangement (AFA) pricing models including fixed fees, capped fees, success fees, or blended rates.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether engagement for this service requires formal approval from practice group leadership, risk committee, or conflicts committee before client commitment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service offering record was first created in the system. Used for audit trail and data lineage.',
    `cross_sell_services` STRING COMMENT 'Comma-separated list of related service codes that are commonly cross-sold or bundled with this offering. Used in business development, client relationship management, and revenue optimization.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the standard rate. Supports multi-currency pricing for international service offerings.. Valid values are `^[A-Z]{3}$`',
    `deliverable_types` STRING COMMENT 'Comma-separated list of typical deliverable types produced by this service. Examples include legal opinions, contracts, court filings, compliance reports, due diligence memoranda, or advisory presentations.',
    `effective_date` DATE COMMENT 'Date from which this service offering became or will become available for client engagement. Controls visibility in service catalogs and business development systems.',
    `eligible_client_segments` STRING COMMENT 'Comma-separated list of client segments or types eligible for this service offering. Used to filter service catalog visibility in business development and RFP response systems. [ENUM-REF-CANDIDATE: corporate|government|individual|nonprofit|startup|enterprise|sme — promote to reference product]',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Typical or average duration in hours required to deliver this service. Used for resource planning, capacity management, and client expectation setting in engagement letters.',
    `expiration_date` DATE COMMENT 'Date on which this service offering will be or was retired from the active catalog. Null for ongoing services. Used for service lifecycle management and historical analysis.',
    `insurance_coverage_required` BOOLEAN COMMENT 'Indicates whether specialized professional indemnity insurance coverage is required for this service offering beyond standard firm coverage. Relevant for high-risk or specialized services.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether this service is typically billed to clients or provided as a non-billable internal or pro bono service. Controls time entry classification and revenue recognition.',
    `jurisdiction_coverage` STRING COMMENT 'Comma-separated list of legal jurisdictions or geographic regions where the firm is qualified and authorized to deliver this service. Critical for regulatory compliance and engagement eligibility.',
    `knowledge_assets` STRING COMMENT 'Comma-separated list of knowledge management asset identifiers (practice notes, precedent documents, checklists, templates) from the knowledge management system that support delivery of this service.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of this service offerings definition, pricing, scope, and compliance requirements. Supports governance and quality assurance processes.',
    `matter_type_mapping` STRING COMMENT 'Comma-separated list of matter types in the practice management system that typically utilize this service offering. Enables service-to-matter linkage for analytics and cross-selling.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this service offering record. Supports audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service offering record was last modified. Used for audit trail, change tracking, and data synchronization.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of this service offering. Ensures periodic validation of service relevance, pricing accuracy, and regulatory compliance.',
    `practice_area` STRING COMMENT 'Primary practice area or legal discipline to which this service belongs. Aligns service offerings with firm practice group structure and expertise areas.. Valid values are `corporate|litigation|intellectual_property|employment|regulatory_compliance|real_estate`',
    `regulatory_framework` STRING COMMENT 'Primary regulatory or compliance framework applicable to this service offering. Examples include General Data Protection Regulation (GDPR), Sarbanes-Oxley Act (SOX), Securities and Exchange Commission (SEC) regulations, or industry-specific compliance regimes.',
    `required_expertise_level` STRING COMMENT 'Minimum attorney seniority or expertise level required to lead delivery of this service. Used for resource allocation, staffing decisions, and quality assurance.. Valid values are `associate|senior_associate|counsel|partner|specialized_counsel`',
    `requires_conflict_check` BOOLEAN COMMENT 'Indicates whether this service offering mandates a formal conflict check through the conflict checking system before engagement. Ensures compliance with ethical rules and Legal Professional Privilege (LPP) requirements.',
    `requires_kyc` BOOLEAN COMMENT 'Indicates whether this service offering requires Know Your Client (KYC) and Anti-Money Laundering (AML) verification before engagement. Ensures compliance with Financial Action Task Force (FATF) standards.',
    `service_category` STRING COMMENT 'Commercial category of the service offering indicating complexity, customization level, and typical engagement model. Used for pricing strategy and client segmentation.. Valid values are `standard|premium|specialized|package|retainer_based`',
    `service_code` STRING COMMENT 'Unique alphanumeric code identifying the service offering in business development systems, Request for Proposal (RFP) responses, and Letter of Engagement (LOE) documents. Used as the external business identifier.. Valid values are `^[A-Z0-9]{6,12}$`',
    `service_description` STRING COMMENT 'Detailed description of the legal service offering, including scope, deliverables, typical activities, and value proposition. Used in RFP responses and client presentations.',
    `service_name` STRING COMMENT 'Full business name of the legal service offering as presented to clients and used in marketing materials, RFP responses, and engagement letters.',
    `service_status` STRING COMMENT 'Current lifecycle status of the service offering. Controls visibility in business development systems, RFP response tools, and client-facing service catalogs.. Valid values are `active|inactive|deprecated|under_development|pilot`',
    `service_type` STRING COMMENT 'Classification of the service by delivery model and nature of legal work performed. Distinguishes between advisory, transactional, contentious, and support services.. Valid values are `advisory|transactional|litigation|compliance|research|drafting`',
    `sla_delivery_time_days` STRING COMMENT 'Committed delivery timeframe in business days from engagement to completion, as defined in Service Level Agreement (SLA) terms. Used in client commitments and matter planning.',
    `sla_response_time_hours` STRING COMMENT 'Committed response time in hours from service request to initial engagement or acknowledgment, as defined in Service Level Agreement (SLA) terms for this offering.',
    `standard_rate` DECIMAL(18,2) COMMENT 'Standard billing rate or base fee for this service offering in the firms primary operating currency. For hourly services, represents the blended or standard hourly rate. For fixed-fee services, represents the base package price.',
    `technology_requirements` STRING COMMENT 'Comma-separated list of specialized technology platforms or tools required to deliver this service. Examples include eDiscovery platforms, contract lifecycle management systems, legal research databases, or document automation tools.',
    `utbms_task_codes` STRING COMMENT 'Comma-separated list of Uniform Task-Based Management System (UTBMS) task codes associated with this service offering. Used for time entry classification, billing, and client reporting in LEDES format.',
    CONSTRAINT pk_legal_service PRIMARY KEY(`legal_service_id`)
) COMMENT 'Core catalog of legal service offerings available from the firm, including M&A advisory, litigation representation, IP counsel, regulatory compliance counseling, employment law advisory, and structured advisory packages. Each record defines a distinct service offering with its scope, practice area alignment, delivery model, and eligibility criteria. This is the SSOT for what the firm offers commercially and operationally, used in RFP responses, engagement letters (LOE), and business development pipelines in Microsoft Dynamics 365.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`service`.`tier` (
    `tier_id` BIGINT COMMENT 'Unique identifier for the service tier. Primary key.',
    `appetite_id` BIGINT COMMENT 'Foreign key linking to risk.risk_appetite. Business justification: Service tiers define firm risk appetite boundaries (premium tier = higher complexity tolerance, standard tier = conservative limits). Engagement acceptance workflows verify matter risk profile against',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Service tiers are defined per practice area. Normalize by linking to practice_area master. The practice_area STRING column is just a code/name reference.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to client.client_segment. Business justification: Service tiers explicitly target client segments (premium tier for top-tier clients, standard for mid-market). Tier eligibility, SLA commitments, and pricing are segment-driven. Removes denormalized cl',
    `afa_eligible_flag` BOOLEAN COMMENT 'Indicates whether this tier is eligible for Alternative Fee Arrangements (AFA) such as fixed fees, capped fees, or success-based pricing. True if AFA options are available; False if only hourly billing applies.',
    `afa_models_supported` STRING COMMENT 'Comma-separated list of AFA models supported for this tier (e.g., Fixed Fee, Capped Fee, Blended Rate, Success Fee, Retainer). Used in pricing discussions and engagement structuring.',
    `approval_date` DATE COMMENT 'Date on which this service tier configuration was approved. Used for governance and audit trail.',
    `approval_status` STRING COMMENT 'Current approval status of this service tier configuration. Only approved tiers are available for engagement assignment. Used in governance workflow.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_by_partner` STRING COMMENT 'Name or identifier of the partner who approved this service tier configuration. Used for governance and accountability.',
    `base_hourly_rate` DECIMAL(18,2) COMMENT 'Standard hourly billing rate for this tier in the firms base currency. Used as the starting point for rate negotiations and engagement pricing. May vary by timekeeper seniority within the tier.',
    `conflict_check_level` STRING COMMENT 'Level of conflict checking required for engagements under this tier (standard, enhanced, comprehensive). Higher tiers may require more rigorous conflict analysis and ethical wall procedures.. Valid values are `standard|enhanced|comprehensive`',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this service tier record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service tier record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the base hourly rate and pricing (e.g., USD, GBP, EUR). Used in multi-currency billing and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `data_protection_classification` STRING COMMENT 'Data protection and confidentiality classification level for matters under this tier (standard, confidential, highly_confidential). Determines document handling, access controls, and encryption requirements.. Valid values are `standard|confidential|highly_confidential`',
    `document_retention_years` STRING COMMENT 'Minimum document retention period in years for matters under this tier, as required by regulatory obligations and professional standards. Used in records management and DMS configuration.',
    `effective_end_date` DATE COMMENT 'Date on which this service tier is no longer available for new engagements. Null for currently active tiers. Used in service catalog versioning and deprecation management.',
    `effective_start_date` DATE COMMENT 'Date from which this service tier becomes available for new engagements. Used in service catalog versioning and pricing transitions.',
    `included_deliverables` STRING COMMENT 'Comma-separated or structured list of standard deliverables included in the tier (e.g., legal opinions, memoranda, contract drafts, compliance checklists). Used in RFP responses and engagement scoping.',
    `insurance_coverage_required_flag` BOOLEAN COMMENT 'Indicates whether specific professional indemnity insurance coverage or coverage limits are required for engagements under this tier. True if additional coverage is mandatory; False otherwise.',
    `kyc_aml_level` STRING COMMENT 'Level of KYC and AML due diligence required for clients engaging under this tier (basic, standard, enhanced, high_risk). Higher tiers or higher-risk practice areas may require enhanced due diligence.. Valid values are `basic|standard|enhanced|high_risk`',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this service tier record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service tier record was last modified. Used for audit trail and change tracking.',
    `matter_type_applicability` STRING COMMENT 'Comma-separated list of matter types or case categories to which this tier applies (e.g., Transactional, Litigation, Advisory, Compliance). Used in matter intake and service assignment.',
    `maximum_engagement_value` DECIMAL(18,2) COMMENT 'Maximum total engagement value or cap applicable to this tier (if any). Null for uncapped tiers. Used in pricing and risk management.',
    `minimum_engagement_value` DECIMAL(18,2) COMMENT 'Minimum total engagement value or retainer amount required to qualify for this tier. Used in client segmentation and engagement acceptance decisions.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this service tier, including special terms, exceptions, or usage guidance. Used by practice managers and business development teams.',
    `partner_approval_required_flag` BOOLEAN COMMENT 'Indicates whether partner-level approval is required to assign a matter to this tier. True if approval is mandatory; False if associates or practice managers can assign. Used in engagement workflow and governance.',
    `practice_area` STRING COMMENT 'Primary practice area or legal service line to which this tier applies (e.g., M&A, Litigation, IP Counsel, Regulatory Compliance, Employment Law). Aligns with firm practice area taxonomy. [ENUM-REF-CANDIDATE: M&A|Litigation|IP Counsel|Regulatory Compliance|Employment Law|Corporate Transactions|Dispute Resolution|Real Estate|Tax|Labor & Employment — promote to reference product]',
    `response_time_commitment_hours` DECIMAL(18,2) COMMENT 'Maximum response time commitment in hours for initial client inquiries or urgent requests under this tier. Forms part of the Service Level Agreement (SLA) terms.',
    `scope_of_coverage` STRING COMMENT 'Detailed definition of the legal services and deliverables included in this tier (e.g., advisory opinions, document review, representation in proceedings, regulatory filings). Used to set client expectations and scope engagement letters (LOE).',
    `sla_terms` STRING COMMENT 'Full text or reference to the Service Level Agreement (SLA) terms applicable to this tier, including response times, escalation procedures, and performance guarantees. Used in engagement letters (LOE) and client contracts.',
    `tier_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the service tier (e.g., STD, PREM, ENT, BESPOKE). Used in system integrations and billing configurations.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `tier_description` STRING COMMENT 'Detailed description of the service tier, including scope of coverage, key differentiators, and target client segments. Used in business development materials and RFP responses.',
    `tier_level` STRING COMMENT 'Numeric ranking of the tier within the service hierarchy (e.g., 1=Standard, 2=Premium, 3=Enterprise, 4=Bespoke). Used for sorting and eligibility logic.',
    `tier_name` STRING COMMENT 'Full business name of the service tier (e.g., Standard, Premium, Enterprise, Bespoke). Used in client-facing documents, RFPs, and engagement letters (LOE).',
    `tier_status` STRING COMMENT 'Current lifecycle status of the service tier. Active tiers are available for new engagements; deprecated tiers are honored for existing matters but not offered to new clients.. Valid values are `active|inactive|deprecated|draft`',
    `version_number` STRING COMMENT 'Version number of this service tier configuration. Incremented with each substantive change to tier terms, pricing, or scope. Used in change management and historical analysis.',
    CONSTRAINT pk_tier PRIMARY KEY(`tier_id`)
) COMMENT 'Defines the tiered packaging levels for legal services (e.g., Standard, Premium, Enterprise, Bespoke). Each tier specifies the scope of coverage, included deliverables, response commitments, and eligibility for alternative fee arrangements (AFA). Used to structure RFP responses and engagement letter (LOE) terms. Enables differentiated pricing and SLA assignment across client segments.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`service`.`pricing_model` (
    `pricing_model_id` BIGINT COMMENT 'Unique identifier for the pricing model record. Primary key.',
    `attorney_profile_id` BIGINT COMMENT 'Identifier of the partner who approved this pricing model for use. Null if not yet approved or approval not required.',
    `category_id` BIGINT COMMENT 'Foreign key linking to risk.risk_category. Business justification: AFA pricing models require risk classification (contingency = outcome risk, fixed fee = scope risk, capped fee = budget overrun risk). Pricing committees evaluate risk category before approving non-st',
    `legal_service_id` BIGINT COMMENT 'FK to service.legal_service.legal_service_id — Pricing models are configured per legal service offering. Each service has one or more applicable pricing models (hourly, fixed, capped, etc.).',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the user who created this pricing model record.',
    `pricing_last_modified_by_user_timekeeper_id` BIGINT COMMENT 'Identifier of the user who last modified this pricing model record.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to client.client_segment. Business justification: Pricing models are often segment-specific (volume discounts for enterprise clients, standard rates for individuals). Rate cards, AFA eligibility, and discount structures are determined by client segme',
    `advance_payment_amount` DECIMAL(18,2) COMMENT 'Required advance payment or retainer deposit amount. Null if no advance payment is required.',
    `advance_payment_required` BOOLEAN COMMENT 'Flag indicating whether an advance payment or retainer deposit is required before work commences under this pricing model. True = advance required; False = no advance.',
    `afa_indicator` BOOLEAN COMMENT 'Flag indicating whether this pricing model represents an Alternative Fee Arrangement (non-traditional hourly billing). True = AFA; False = traditional hourly.',
    `applicable_jurisdictions` STRING COMMENT 'Comma-separated list of jurisdictions where this pricing model is approved for use (e.g., USA, GBR, CAN). Ensures compliance with local bar association fee rules.',
    `applicable_practice_areas` STRING COMMENT 'Comma-separated list of practice areas where this pricing model is typically applied (e.g., M&A, Corporate Transactions, Litigation, Dispute Resolution). [ENUM-REF-CANDIDATE: litigation|corporate|ip|employment|regulatory|real_estate|tax|bankruptcy|family|immigration — promote to reference product]',
    `approval_date` DATE COMMENT 'Date on which this pricing model was approved by authorized partner or management. Null if not yet approved.',
    `approval_required` BOOLEAN COMMENT 'Flag indicating whether partner or management approval is required before applying this pricing model to a matter. True = approval required; False = no approval needed.',
    `base_rate_amount` DECIMAL(18,2) COMMENT 'The standard rate amount for this pricing model. For hourly models, this is the hourly rate; for fixed fee, this is the base fee amount. Null if rate varies by timekeeper or matter.',
    `billing_increment_minutes` STRING COMMENT 'Time increment used for rounding billable time entries (e.g., 6 minutes = 0.1 hour, 15 minutes = 0.25 hour). Common values: 6, 10, 15.',
    `blended_rate_amount` DECIMAL(18,2) COMMENT 'Single averaged hourly rate applied across all timekeepers on a matter, regardless of individual seniority. Used in blended rate pricing models.',
    `calculation_basis` STRING COMMENT 'The foundational method used to calculate fees under this model. Time-based = hours worked; Matter-based = per matter/case; Transaction Value = percentage of deal value; Outcome-based = tied to result; Hybrid = combination of methods.. Valid values are `time_based|matter_based|transaction_value|outcome_based|hybrid`',
    `contingency_percentage` DECIMAL(18,2) COMMENT 'The percentage of recovery or transaction value that constitutes the fee for contingency-based pricing models. Null for non-contingency models.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pricing model record was first created in the system.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Standard discount percentage applied to standard rates under this pricing model. Null if no discount applies.',
    `effective_end_date` DATE COMMENT 'Date on which this pricing model expires or is no longer available for new matters. Null for open-ended models.',
    `effective_start_date` DATE COMMENT 'Date from which this pricing model becomes effective and available for use in client engagements.',
    `expense_markup_percentage` DECIMAL(18,2) COMMENT 'Percentage markup applied to reimbursable expenses (e.g., 10% administrative fee on disbursements). Null if no markup applies.',
    `expense_reimbursement_policy` STRING COMMENT 'Policy governing how disbursements and expenses are handled under this pricing model. Full = all expenses billed separately; Capped = expenses up to limit; Included = expenses absorbed in fee; No Reimbursement = client pays directly.. Valid values are `full_reimbursement|capped_reimbursement|included_in_fee|no_reimbursement`',
    `internal_notes` STRING COMMENT 'Internal notes and comments about this pricing model for firm use only. May include strategic considerations, client negotiation history, or profitability analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this pricing model record was last updated.',
    `late_payment_interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate applied to overdue invoices under this pricing model. Null if no late payment interest applies.',
    `ledes_format_version` STRING COMMENT 'LEDES billing format version supported by this pricing model (e.g., LEDES1998BI, LEDES1998BIV2). Ensures billing data compatibility with client systems.. Valid values are `^LEDES[0-9]{4}BI(V[0-9])?$`',
    `maximum_fee_amount` DECIMAL(18,2) COMMENT 'The maximum fee cap for capped fee arrangements. Fees will not exceed this amount regardless of time spent. Null if no cap applies.',
    `minimum_fee_amount` DECIMAL(18,2) COMMENT 'The minimum fee that will be charged under this pricing model, regardless of time or effort expended. Null if no minimum applies.',
    `model_code` STRING COMMENT 'Business identifier code for the pricing model, used in billing systems and client communications.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `model_name` STRING COMMENT 'Human-readable name of the pricing model (e.g., Standard Hourly Billing, Fixed Fee M&A Advisory, Blended Rate Litigation).',
    `model_type` STRING COMMENT 'Classification of the fee structure type. Hourly = time-based billing; Fixed Fee = predetermined amount; Capped Fee = hourly with maximum limit; Blended Rate = averaged rate across timekeepers; Retainer = recurring periodic fee; Contingency = success-based percentage.. Valid values are `hourly|fixed_fee|capped_fee|blended_rate|retainer|contingency`',
    `payment_terms_days` STRING COMMENT 'Standard payment terms in days from invoice date (e.g., 30 days net). Defines when payment is due under this pricing model.',
    `pricing_model_description` STRING COMMENT 'Detailed description of the pricing model, including its intended use cases, calculation methodology, and any special terms or conditions.',
    `pricing_model_status` STRING COMMENT 'Current lifecycle status of the pricing model. Active = in use; Inactive = not available for new matters; Draft = under development; Archived = historical; Under Review = pending approval; Approved = ready for activation.. Valid values are `active|inactive|draft|archived|under_review|approved`',
    `rate_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the rate amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `retainer_amount` DECIMAL(18,2) COMMENT 'The recurring retainer fee amount charged per billing period. Null for non-retainer models.',
    `retainer_frequency` STRING COMMENT 'Billing frequency for retainer-based pricing models. Indicates how often the retainer fee is charged.. Valid values are `monthly|quarterly|annual|one_time`',
    `sla_resolution_time_days` STRING COMMENT 'Target resolution or delivery time in days for matters under this pricing model. Part of service level commitments.',
    `sla_response_time_hours` STRING COMMENT 'Guaranteed response time in hours for client inquiries under this pricing model. Part of service level commitments.',
    `success_fee_amount` DECIMAL(18,2) COMMENT 'Fixed or additional fee payable upon successful outcome (e.g., case won, deal closed). Null if no success fee applies.',
    `utbms_task_code` STRING COMMENT 'UTBMS task code alignment for this pricing model, enabling standardized billing code reporting (e.g., L110 for Case Assessment, L310 for Discovery).. Valid values are `^[A-Z][0-9]{3}$`',
    CONSTRAINT pk_pricing_model PRIMARY KEY(`pricing_model_id`)
) COMMENT 'Defines the fee structures and alternative fee arrangements (AFA) applicable to legal service offerings, including hourly billing, fixed fee, capped fee, blended rate, retainer, contingency, and success fee models. Each record captures the model type, calculation basis, currency, applicable jurisdictions, and LEDES/UTBMS billing code alignment. Serves as the authoritative pricing configuration referenced by billing and matter domains.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`service`.`rate_card` (
    `rate_card_id` BIGINT COMMENT 'Unique identifier for the rate card record. Primary key.',
    `matter_id` BIGINT COMMENT 'Reference to the specific matter for which this rate applies. Null indicates the rate applies at the client level or as a standard rate.',
    `practice_area_id` BIGINT COMMENT 'FK to service.practice_area.practice_area_id — Rate cards are structured by practice area (litigation rates differ from corporate rates). This is a fundamental billing configuration relationship.',
    `profile_id` BIGINT COMMENT 'Reference to the client for whom this rate is defined. Null indicates a standard rate applicable to all clients unless overridden.',
    `superseded_by_rate_card_id` BIGINT COMMENT 'Reference to the rate card that supersedes this one. Null if this is the current active rate card.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper (attorney, paralegal, or other legal professional) to whom this rate applies.',
    `approval_date` DATE COMMENT 'Date on which this rate card was approved for use.',
    `approval_status` STRING COMMENT 'Current approval status of the rate card in the rate management workflow (draft = under construction, pending_approval = submitted for review, approved = active and usable, rejected = not approved, expired = past effective end date).. Valid values are `draft|pending_approval|approved|rejected|expired`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved this rate card (typically a partner, billing manager, or finance director).',
    `billing_guideline_compliant` BOOLEAN COMMENT 'Boolean flag indicating whether this rate complies with the clients outside counsel billing guidelines (True = compliant, False = non-compliant or requires review).',
    `client_segment` STRING COMMENT 'Classification of the client segment to which this rate applies (e.g., Fortune 500, mid-market, small business, government, non-profit, individual).. Valid values are `fortune_500|mid_market|small_business|government|non_profit|individual`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate card record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the rate is denominated (e.g., USD, GBP, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the standard rate to derive this rate (e.g., 10.00 for a 10% discount). Null if no discount applies.',
    `effective_end_date` DATE COMMENT 'The date on which this rate ceases to be effective. Null indicates the rate is currently active with no defined end date.',
    `effective_start_date` DATE COMMENT 'The date from which this rate becomes effective and applicable for billing purposes.',
    `firm_office_location_code` STRING COMMENT 'Code representing the office location from which the timekeeper operates (e.g., NYC, LON, SFO, HKG).. Valid values are `^[A-Z0-9]{2,10}$`',
    `hourly_rate` DECIMAL(18,2) COMMENT 'The billing rate per hour for the timekeepers services under this rate card. Used for time-based billing calculations in Elite 3E and Aderant Expert.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this rate card is currently active and available for use in billing (True = active, False = inactive).',
    `is_default_rate` BOOLEAN COMMENT 'Boolean flag indicating whether this is the default rate to be applied when no client-specific or matter-specific rate is defined (True = default, False = not default).',
    `jurisdiction_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code or state/province code representing the jurisdiction where the legal services are provided (e.g., USA, GBR, NY, CA).. Valid values are `^[A-Z]{2,3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate card record was last updated or modified.',
    `minimum_charge_increment_minutes` STRING COMMENT 'Minimum time increment for billing purposes (e.g., 6 minutes for 0.1 hour increments, 15 minutes for 0.25 hour increments). Used in time entry rounding.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this rate card, including special terms, exceptions, or context for the rate structure.',
    `rate_cap_amount` DECIMAL(18,2) COMMENT 'Maximum hourly rate cap agreed with the client, regardless of timekeeper seniority or standard rate. Null if no cap applies.',
    `rate_card_description` STRING COMMENT 'Detailed description of the rate card, including its purpose, scope, and any special terms or conditions.',
    `rate_card_name` STRING COMMENT 'Descriptive name or label for this rate card (e.g., 2024 Standard Corporate Rates, Client XYZ Preferred Rates, Litigation Blended Rate).',
    `rate_floor_amount` DECIMAL(18,2) COMMENT 'Minimum hourly rate floor below which billing cannot fall. Null if no floor applies.',
    `rate_source` STRING COMMENT 'Origin or basis for this rate (firm_standard = firms published standard rates, client_negotiated = negotiated with client, engagement_letter = specified in Letter of Engagement (LOE), rfp_response = proposed in RFP response, afa_agreement = part of Alternative Fee Arrangement, market_benchmark = based on market survey).. Valid values are `firm_standard|client_negotiated|engagement_letter|rfp_response|afa_agreement|market_benchmark`',
    `rate_type` STRING COMMENT 'Classification of the billing rate structure (standard = firm standard rate, preferred = client-specific preferred rate, blended = averaged rate across multiple timekeepers, discounted = reduced rate, negotiated = custom negotiated rate, afa = Alternative Fee Arrangement rate).. Valid values are `standard|preferred|blended|discounted|negotiated|afa`',
    `rate_version` STRING COMMENT 'Version number of this rate card, incremented with each revision or update. Used for rate history tracking and audit purposes.',
    `seniority_level` STRING COMMENT 'Seniority classification of the timekeeper (e.g., equity partner, non-equity partner, of counsel, senior associate, mid-level associate, junior associate, paralegal, legal assistant, contract attorney). [ENUM-REF-CANDIDATE: equity_partner|non_equity_partner|of_counsel|senior_associate|mid_level_associate|junior_associate|paralegal|legal_assistant|contract_attorney — 9 candidates stripped; promote to reference product]',
    `utbms_activity_code` STRING COMMENT 'UTBMS activity code providing granular detail on the type of legal work performed under this rate (e.g., A101 for Plan and Prepare for Issue Development).. Valid values are `^[A-Z][0-9]{3}$`',
    `utbms_task_code` STRING COMMENT 'UTBMS task code aligned with this rate for standardized legal billing and matter management (e.g., L110 for Case Assessment, L120 for Investigation).. Valid values are `^[A-Z][0-9]{3}$`',
    CONSTRAINT pk_rate_card PRIMARY KEY(`rate_card_id`)
) COMMENT 'Stores the standard and negotiated timekeeper billing rates for legal services by practice area, seniority level (partner, associate, paralegal), jurisdiction, and client segment. Captures effective date ranges, currency, rate type (standard, preferred, blended), and UTBMS task code alignment. Feeds directly into Elite 3E and Aderant Expert rate management modules for WIP calculation and prebilling. Distinct from pricing_model which defines the fee structure type.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`service`.`sla_template` (
    `sla_template_id` BIGINT COMMENT 'Unique identifier for the SLA template. Primary key.',
    `legal_service_id` BIGINT COMMENT 'FK to service.legal_service.legal_service_id — SLA templates are defined per service offering — response time commitments for litigation differ from advisory. This link is required for LOE generation and matter SLA assignment.',
    `offering_version_id` BIGINT COMMENT 'Reference to the legal service offering catalog entry to which this SLA template is associated.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: SLA templates are scoped by practice area. Normalize by linking to practice_area master. The practice_area STRING column is a code/name reference.',
    `pricing_model_id` BIGINT COMMENT 'Foreign key linking to service.pricing_model. Business justification: SLA templates may reference a pricing model. Normalize by linking to pricing_model master. The pricing_model STRING column is a code/name reference.',
    `approval_date` DATE COMMENT 'Date on which this SLA template was formally approved for use in client engagements.',
    `approval_status` STRING COMMENT 'Current approval and lifecycle status of the SLA template within the firms governance process.. Valid values are `draft|pending_review|approved|active|deprecated|archived`',
    `approved_by` STRING COMMENT 'Name or identifier of the partner or practice group leader who approved this SLA template for use.',
    `availability_commitment` STRING COMMENT 'Timekeeper availability commitment specified in the SLA (e.g., 24/7 emergency access, business hours only, named partner availability).',
    `breach_count` STRING COMMENT 'Historical count of SLA breaches across all matters using this template, used for template refinement and risk assessment.',
    `breach_threshold_percentage` DECIMAL(18,2) COMMENT 'Percentage threshold over target time that constitutes an SLA breach (e.g., 110.00 means 10% over target triggers breach).',
    `client_tier` STRING COMMENT 'Client segmentation tier for which this SLA template is designed, reflecting service level differentiation in client relationship management.. Valid values are `platinum|gold|silver|bronze|standard`',
    `communication_protocol` STRING COMMENT 'Specified communication channels and protocols for SLA-governed matters (e.g., email, secure portal, phone, video conference, encrypted messaging).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA template record was first created in the system.',
    `effective_date` DATE COMMENT 'Date from which this SLA template becomes effective and available for use in new Letter of Engagement (LOE) drafting and matter setup.',
    `escalation_threshold` STRING COMMENT 'Threshold value (in same unit as response/turnaround time) at which SLA breach triggers escalation to senior counsel or practice group leader.',
    `escalation_unit` STRING COMMENT 'Unit of measure for escalation threshold: hours, business days, or calendar days.. Valid values are `hours|business_days|calendar_days`',
    `expiration_date` DATE COMMENT 'Date on which this SLA template expires or is superseded by a newer version. Null indicates no expiration.',
    `fee_adjustment_percentage` DECIMAL(18,2) COMMENT 'Percentage fee adjustment (reduction or credit) applied upon SLA breach as specified in remediation terms.',
    `jurisdiction` STRING COMMENT 'Legal jurisdiction or geographic scope to which this SLA template applies (e.g., USA, GBR, multi-jurisdictional). [ENUM-REF-CANDIDATE: USA|GBR|CAN|AUS|DEU|FRA|CHN|IND|multi_jurisdictional — promote to reference product]',
    `matter_complexity` STRING COMMENT 'Target matter complexity level for which this SLA template is appropriate, enabling proper SLA-to-matter matching.. Valid values are `low|medium|high|critical`',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified this SLA template record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA template record was last modified, supporting change tracking and audit requirements.',
    `notes` STRING COMMENT 'Additional notes, guidance, or special instructions for applying this SLA template in client engagements and RFP responses.',
    `practice_area` STRING COMMENT 'Legal practice area taxonomy classification to which this SLA template applies (e.g., M&A, Litigation, IP Counsel, Regulatory Compliance, Employment Law). [ENUM-REF-CANDIDATE: corporate|litigation|intellectual_property|employment|regulatory_compliance|real_estate|tax|antitrust|banking_finance|environmental — promote to reference product]',
    `quality_standard` STRING COMMENT 'Description of the quality standards and deliverable expectations associated with this SLA template (e.g., peer review required, cite-checking standards, document formatting requirements).',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this SLA template includes specific regulatory compliance commitments (e.g., GDPR response times, SOX filing deadlines, CCPA data subject request turnaround).',
    `remediation_terms` STRING COMMENT 'Contractual remediation terms and client remedies in the event of SLA breach (e.g., fee reduction, credit, expedited service on next matter).',
    `reporting_frequency` STRING COMMENT 'Frequency of status reporting and matter updates committed in the SLA template.. Valid values are `daily|weekly|bi_weekly|monthly|quarterly|on_demand`',
    `response_time_target` STRING COMMENT 'Target response time commitment in the unit specified by response_time_unit (e.g., 24 hours for initial client inquiry response).',
    `response_time_unit` STRING COMMENT 'Unit of measure for response time target: hours, business days, or calendar days.. Valid values are `hours|business_days|calendar_days`',
    `sla_type` STRING COMMENT 'Classification of the SLA template by commitment category: matter response time, document turnaround, court filing deadline adherence, regulatory submission timeliness, client communication response, or legal research delivery.. Valid values are `matter_response|document_turnaround|court_filing_deadline|regulatory_submission|client_communication|research_delivery`',
    `template_code` STRING COMMENT 'Business identifier code for the SLA template used in Letter of Engagement (LOE) drafting and Request for Proposal (RFP) responses.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `template_description` STRING COMMENT 'Detailed description of the SLA template including scope, applicability, and business context for use in client engagements.',
    `template_name` STRING COMMENT 'Human-readable name of the SLA template describing the service commitment level.',
    `turnaround_time_target` STRING COMMENT 'Target turnaround time for deliverable completion in the unit specified by turnaround_time_unit (e.g., 5 business days for contract review).',
    `turnaround_time_unit` STRING COMMENT 'Unit of measure for turnaround time target: hours, business days, calendar days, or weeks.. Valid values are `hours|business_days|calendar_days|weeks`',
    `usage_count` STRING COMMENT 'Number of times this SLA template has been applied to active matters or included in Letter of Engagement (LOE) documents, used for template effectiveness analysis.',
    `version_number` STRING COMMENT 'Version number of the SLA template following semantic versioning (e.g., 1.0, 2.1) for template change management and audit trail.. Valid values are `^[0-9]+.[0-9]+$`',
    `created_by` STRING COMMENT 'Identifier of the user or system that created this SLA template record.',
    CONSTRAINT pk_sla_template PRIMARY KEY(`sla_template_id`)
) COMMENT 'Defines the service level agreement (SLA) templates governing response times, turnaround commitments, escalation thresholds, and quality standards for each legal service offering. Captures SLA type (matter response, document turnaround, court filing deadline, regulatory submission), target metrics, breach thresholds, and remediation terms. Used in LOE drafting, RFP responses, and matter management SLA monitoring. Distinct from individual matter-level SLA instances.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`service`.`package` (
    `package_id` BIGINT COMMENT 'Unique identifier for the service package. Primary key.',
    `appetite_id` BIGINT COMMENT 'Foreign key linking to risk.risk_appetite. Business justification: Service packages are designed within firm risk appetite boundaries. Package approval workflows verify that included services and pricing terms align with risk tolerance thresholds. Prevents offering p',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user who most recently modified this service package record.',
    `package_owner_timekeeper_id` BIGINT COMMENT 'Reference to the user who created this service package record in the system.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Service packages are scoped by practice area. Normalize by linking to practice_area master. The practice_area STRING column is a code/name reference.',
    `pricing_model_id` BIGINT COMMENT 'Foreign key linking to service.pricing_model. Business justification: Service packages reference a pricing model via pricing_basis attribute (synonym in legal services context). Normalize by linking to pricing_model master.',
    `primary_package_approved_by_partner_timekeeper_id` BIGINT COMMENT 'Reference to the partner who provided final approval for this service package to be offered to clients.',
    `primary_superseded_by_package_id` BIGINT COMMENT 'Reference to the newer service package that replaces this one, enabling version lineage tracking and client migration paths.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether the service package is currently active and available for new client engagements. True = active and available.',
    `approval_status` STRING COMMENT 'Current approval workflow status of the service package within internal governance processes.. Valid values are `draft|pending_approval|approved|rejected|archived`',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this service package received final approval and became available for client engagements.',
    `average_engagement_value` DECIMAL(18,2) COMMENT 'Average revenue per engagement for this service package calculated from historical billing data. Used for forecasting and business development.',
    `base_price_amount` DECIMAL(18,2) COMMENT 'Standard base price for the service package before any client-specific adjustments or discounts. Used as starting point for pricing negotiations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service package record was first created in the system.',
    `cross_sell_eligible_flag` BOOLEAN COMMENT 'Indicates whether this package is eligible for cross-selling to existing clients with other active engagements. True = eligible for cross-sell campaigns.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the base price amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `document_management_required_flag` BOOLEAN COMMENT 'Indicates whether this package requires use of firm DMS (iManage Work or NetDocuments) for document storage, version control, and collaboration.',
    `effective_end_date` DATE COMMENT 'Date after which this service package is no longer available for new engagements. Null indicates no planned end date.',
    `effective_start_date` DATE COMMENT 'Date from which this service package becomes available for client engagements and RFP responses.',
    `estimated_hours` DECIMAL(18,2) COMMENT 'Estimated total professional hours required to deliver all services within the package. Used for resource planning and capacity management.',
    `includes_ediscovery_flag` BOOLEAN COMMENT 'Indicates whether the package includes electronic discovery services using platforms such as Relativity for document review and production.',
    `includes_legal_research_flag` BOOLEAN COMMENT 'Indicates whether the package includes access to legal research platforms such as LexisNexis or Thomson Reuters Practical Law.',
    `internal_notes` STRING COMMENT 'Internal commentary, pricing rationale, competitive positioning notes, or strategic considerations for firm use only.',
    `jurisdiction_coverage` STRING COMMENT 'Comma-separated list of jurisdictions or countries where this package can be delivered based on firm licensing and practice rights (e.g., USA, GBR, DEU).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service package record was most recently updated.',
    `marketing_collateral_url` STRING COMMENT 'URL or document path to client-facing marketing materials, brochures, or pitch decks for this service package.',
    `minimum_engagement_term_months` STRING COMMENT 'Minimum commitment period in months required for this package. Null indicates no minimum term requirement.',
    `package_code` STRING COMMENT 'Externally-known unique business identifier for the service package used in RFP responses, client proposals, and billing systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `package_description` STRING COMMENT 'Detailed description of the service package scope, objectives, and value proposition for client-facing materials and internal knowledge management.',
    `package_name` STRING COMMENT 'Human-readable name of the service package (e.g., Corporate Governance Bundle, M&A Full-Service Package, IP Portfolio Management Suite).',
    `package_type` STRING COMMENT 'Classification of the service package structure determining engagement model and delivery approach.. Valid values are `fixed_scope|retainer_based|project_based|advisory|transactional|hybrid`',
    `practice_area` STRING COMMENT 'Primary practice area taxonomy classification for the service package aligning with firm organizational structure and expertise domains.. Valid values are `corporate|litigation|intellectual_property|employment|regulatory_compliance|real_estate`',
    `pricing_basis` STRING COMMENT 'Pricing model for the package. AFA = Alternative Fee Arrangement. Determines how the package is billed to clients.. Valid values are `hourly|fixed_fee|contingency|blended_rate|afa|value_based`',
    `regulatory_framework` STRING COMMENT 'Primary regulatory or compliance framework applicable to services within this package (e.g., GDPR, SOX, CCPA, FRAND).',
    `requires_conflict_check_flag` BOOLEAN COMMENT 'Indicates whether engagement under this package mandates formal conflict checking through Intapp Conflicts or equivalent system before matter intake.',
    `requires_kyc_flag` BOOLEAN COMMENT 'Indicates whether this package requires formal KYC and AML compliance checks before engagement commencement per regulatory obligations.',
    `sla_resolution_time_days` STRING COMMENT 'Target resolution time in business days for standard matters covered by this package under SLA commitments.',
    `sla_response_time_hours` STRING COMMENT 'Maximum response time in hours guaranteed under the SLA terms for client inquiries or urgent matters within this package.',
    `target_client_segment` STRING COMMENT 'Intended client segment for this package enabling targeted business development and marketing campaigns.. Valid values are `enterprise|mid_market|startup|government|non_profit|individual`',
    `total_engagements_count` STRING COMMENT 'Cumulative count of client engagements or matters that have utilized this service package since inception. Used for performance tracking.',
    `version_number` STRING COMMENT 'Version number of the service package definition enabling tracking of changes to scope, pricing, or terms over time.',
    CONSTRAINT pk_package PRIMARY KEY(`package_id`)
) COMMENT 'Defines bundled legal service packages combining multiple legal_service offerings into structured advisory packages (e.g., Corporate Governance Bundle, M&A Full-Service Package, IP Portfolio Management Suite). Modeled as header+line: header captures package name, target client segment, minimum engagement term, pricing basis, cross-sell eligibility, and active/inactive status; line-level rows specify each constituent legal_service, its quantity or scope allocation within the package, sequencing order, optionality (mandatory vs. elective component), and any component-level pricing override. This is the SSOT for all package composition data. Enables cross-selling, structured RFP responses, and downstream matter-to-service mapping.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` (
    `jurisdiction_coverage_id` BIGINT COMMENT 'Unique identifier for the jurisdiction coverage record. Primary key.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key to matter.jurisdiction.jurisdiction_id',
    `legal_service_id` BIGINT COMMENT 'FK to service.legal_service.legal_service_id — Jurisdictional availability is defined per service offering. A firm may offer M&A advisory in the US and UK but not in jurisdictions where it lacks local counsel. Critical for RFP eligibility.',
    `admission_required` BOOLEAN COMMENT 'Indicates whether formal admission or bar membership is required to practice in this jurisdiction.',
    `admission_requirements` STRING COMMENT 'Detailed description of admission or licensing requirements for practicing in this jurisdiction (e.g., bar exam, character and fitness review, Continuing Legal Education requirements).',
    `adr_services_available` BOOLEAN COMMENT 'Indicates whether Alternative Dispute Resolution services (arbitration, mediation, conciliation) are available in this jurisdiction.',
    `aml_kyc_compliance_available` BOOLEAN COMMENT 'Indicates whether AML and KYC compliance counseling services are available in this jurisdiction.',
    `conflict_check_scope` STRING COMMENT 'Indicates the scope of conflict checking required for this jurisdiction coverage: full (comprehensive conflict check required), limited (partial check), or excluded (no conflict check needed).. Valid values are `full|limited|excluded`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the jurisdiction (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `court_access_level` STRING COMMENT 'Level of court access available in this jurisdiction: full (can appear in all courts), limited (specific courts only), none (no court appearances), advisory_only (counsel only, no litigation).. Valid values are `full|limited|none|advisory_only`',
    `coverage_notes` STRING COMMENT 'Additional notes, comments, or guidance regarding service coverage in this jurisdiction, including special considerations, recent regulatory changes, or operational caveats.',
    `coverage_status` STRING COMMENT 'Current status of service coverage in this jurisdiction. Active indicates full service availability; restricted indicates limited scope; suspended indicates temporary unavailability.. Valid values are `active|inactive|pending|restricted|suspended`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this jurisdiction coverage record was first created in the system.',
    `data_privacy_compliance_scope` STRING COMMENT 'Description of data privacy and protection compliance counseling available in this jurisdiction (e.g., GDPR, CCPA, DPA, sector-specific privacy laws).',
    `ecf_access` BOOLEAN COMMENT 'Indicates whether the firm has Electronic Case Filing access in this jurisdiction for federal or state court filings.',
    `effective_from_date` DATE COMMENT 'Date from which the service coverage in this jurisdiction became or will become effective.',
    `effective_to_date` DATE COMMENT 'Date until which the service coverage in this jurisdiction remains valid. Null indicates indefinite coverage.',
    `international_arbitration_venue` BOOLEAN COMMENT 'Indicates whether this jurisdiction is recognized as an international arbitration venue under ICC, LCIA, or other international arbitration frameworks.',
    `ip_portfolio_management_available` BOOLEAN COMMENT 'Indicates whether IP portfolio management services (patent, trademark, copyright prosecution and maintenance) are available in this jurisdiction.',
    `jurisdictional_restrictions` STRING COMMENT 'Detailed description of any restrictions, caveats, or limitations on service delivery in this jurisdiction (e.g., cannot appear in court, advisory only, regulatory compliance counseling excluded).',
    `language_requirements` STRING COMMENT 'Languages in which legal services must or can be delivered in this jurisdiction (e.g., English, French, Spanish). Relevant for multi-lingual jurisdictions or international matters.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this jurisdiction coverage record was last modified.',
    `local_counsel_notes` STRING COMMENT 'Additional notes or guidance on local counsel requirements, including circumstances when local counsel may be waived or specific qualifications needed.',
    `local_counsel_required` BOOLEAN COMMENT 'Indicates whether local counsel must be engaged for matters in this jurisdiction when the primary attorney is not admitted.',
    `matter_staffing_priority` STRING COMMENT 'Priority ranking for staffing matters in this jurisdiction (1 = highest priority, higher numbers = lower priority). Used for multi-jurisdictional matter staffing decisions.',
    `multi_jurisdictional_flag` BOOLEAN COMMENT 'Indicates whether this coverage is part of a multi-jurisdictional service offering spanning multiple states, provinces, or countries.',
    `pacer_access` BOOLEAN COMMENT 'Indicates whether the firm has PACER access for retrieving court records in this jurisdiction.',
    `patent_bar_required` BOOLEAN COMMENT 'Indicates whether patent bar admission (USPTO registration for patent prosecution) is required for IP services in this jurisdiction.',
    `practice_area_restrictions` STRING COMMENT 'Description of any practice area limitations or restrictions in this jurisdiction (e.g., certain IP matters require patent bar admission, criminal defense requires state bar membership).',
    `pro_hac_vice_available` BOOLEAN COMMENT 'Indicates whether pro hac vice admission (temporary admission for a specific case) is available in this jurisdiction for attorneys not admitted to the local bar.',
    `pro_hac_vice_requirements` STRING COMMENT 'Description of requirements and procedures for obtaining pro hac vice admission in this jurisdiction (e.g., motion filing, local counsel sponsorship, fee payment).',
    `regulatory_body` STRING COMMENT 'Name of the primary regulatory or licensing body governing legal practice in this jurisdiction (e.g., State Bar of California, Solicitors Regulation Authority, American Bar Association).',
    `regulatory_compliance_scope` STRING COMMENT 'Description of the regulatory compliance counseling scope available in this jurisdiction (e.g., GDPR compliance, SOX advisory, AML counseling, sector-specific regulations).',
    `rfp_eligible` BOOLEAN COMMENT 'Indicates whether this jurisdiction coverage qualifies the firm to respond to RFPs requiring service delivery in this jurisdiction.',
    `state_province_code` STRING COMMENT 'Standard code for the state or province within the country (e.g., NY, CA, ON). Null for country-level or international jurisdictions.',
    `updated_by` STRING COMMENT 'Identifier of the user or system that last updated this jurisdiction coverage record.',
    CONSTRAINT pk_jurisdiction_coverage PRIMARY KEY(`jurisdiction_coverage_id`)
) COMMENT 'Defines the jurisdictional scope in which each legal service offering is available and licensed for delivery. Captures country, state/province, regulatory body (ABA, SRA, IBA, state bar), admission requirements, local counsel requirements, and any jurisdictional restrictions or caveats. Critical for conflict checking, RFP eligibility, and regulatory compliance counseling scope definition. Enables multi-jurisdictional matter staffing decisions.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`service`.`offering_version` (
    `offering_version_id` BIGINT COMMENT 'Unique identifier for this version of the service offering. Primary key for the service offering version record.',
    `legal_service_id` BIGINT COMMENT 'Reference to the parent service offering entity. Links this version to the master service offering record.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user who created this service offering version record. Links to workforce/user master data for audit purposes.',
    `offering_last_modified_by_user_timekeeper_id` BIGINT COMMENT 'Reference to the user who last modified this service offering version record. Links to workforce/user master data for audit purposes.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Service offering versions are scoped by practice area. Normalize by linking to practice_area master. Remove practice_area_name as it can be retrieved via JOIN to practice_area.name.',
    `pricing_model_id` BIGINT COMMENT 'Foreign key linking to service.pricing_model. Business justification: Service offering versions reference a pricing model. Normalize by linking to pricing_model master. The pricing_model STRING column is a code/name reference.',
    `superseded_offering_version_id` BIGINT COMMENT 'Reference to the previous service offering version that this version replaces. Nullable for initial versions. Enables version lineage tracking.',
    `version_owner_timekeeper_id` BIGINT COMMENT 'Reference to the partner or senior lawyer who approved this service offering version for use. Links to workforce/partner master data.',
    `active_matters_count` STRING COMMENT 'Current count of active matters using this service offering version. Supports impact analysis for version deprecation decisions.',
    `approval_date` DATE COMMENT 'Date when this service offering version received formal approval for use in client engagements.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this service version requires formal approval from practice group leadership or management committee before use in client engagements.',
    `archive_flag` BOOLEAN COMMENT 'Indicates whether this service offering version has been archived and is no longer available for selection in operational systems, while retained for historical audit and compliance review.',
    `change_reason_code` STRING COMMENT 'Standardized code indicating why this new version was created. Supports audit trail and version history analysis. [ENUM-REF-CANDIDATE: initial|pricing_update|scope_expansion|scope_reduction|regulatory_change|market_adjustment|client_feedback|quality_improvement|error_correction — 9 candidates stripped; promote to reference product]',
    `change_reason_description` STRING COMMENT 'Detailed explanation of the business rationale and specific changes made in this version compared to the previous version.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service offering version record was first created in the system. Audit trail for version history.',
    `deliverables_list` STRING COMMENT 'Structured list or description of tangible outputs and work products included in this service offering (e.g., opinion letters, drafted agreements, research memoranda, court filings).',
    `effective_end_date` DATE COMMENT 'Date when this version ceases to be valid for new engagements. Nullable for currently active versions with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this version becomes valid and available for use in new engagements. Marks the beginning of the versions active period.',
    `engagement_letter_template_reference` STRING COMMENT 'Reference to the standard Letter of Engagement (LOE) template document that should be used when this service offering is sold.',
    `estimated_hours_max` DECIMAL(18,2) COMMENT 'Maximum estimated hours required to deliver this service. Provides upper bound for resource allocation and budget planning.',
    `estimated_hours_min` DECIMAL(18,2) COMMENT 'Minimum estimated hours required to deliver this service. Used for scoping, resource planning, and client expectation setting.',
    `exclusions_description` STRING COMMENT 'Explicit statement of what is NOT included in this service offering version. Clarifies scope boundaries and manages client expectations.',
    `jurisdiction_scope` STRING COMMENT 'Geographic or legal jurisdictions covered by this service offering (e.g., England and Wales, New York State, Federal US, Multi-jurisdictional). Critical for regulatory compliance and professional licensing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this service offering version record. Supports change tracking and audit compliance.',
    `matter_type_applicability` STRING COMMENT 'Types of legal matters for which this service offering is appropriate. Enables service-to-matter mapping for business development and Request for Proposal (RFP) responses.',
    `prerequisites_description` STRING COMMENT 'Required conditions, client inputs, or prior steps that must be satisfied before this service can be delivered (e.g., completed conflict check, signed engagement letter, provided documents).',
    `pricing_model` STRING COMMENT 'Fee structure methodology for this service version. Includes traditional hourly billing, Alternative Fee Arrangement (AFA) models, and hybrid approaches. [ENUM-REF-CANDIDATE: hourly|fixed_fee|contingency|retainer|afa_capped|afa_blended|afa_success|value_based|hybrid — 9 candidates stripped; promote to reference product]',
    `rate_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the standard rate amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `regulatory_compliance_notes` STRING COMMENT 'Documentation of how this service version complies with applicable regulatory requirements, bar association rules, and professional conduct standards.',
    `rfp_template_reference` STRING COMMENT 'Reference to standard Request for Proposal (RFP) response templates or proposal documents associated with this service offering version.',
    `risk_rating` STRING COMMENT 'Professional indemnity and malpractice risk assessment for this service offering. Informs insurance coverage requirements and quality control procedures.. Valid values are `low|medium|high|critical`',
    `service_scope_description` STRING COMMENT 'Comprehensive textual description of what is included in this service offering version. Details deliverables, activities, and boundaries of the service.',
    `service_type` STRING COMMENT 'Classification of the nature of legal service provided. Distinguishes between advisory, transactional work, dispute resolution, and other service modalities. [ENUM-REF-CANDIDATE: advisory|transactional|litigation|compliance|research|drafting|representation|portfolio_management — 8 candidates stripped; promote to reference product]',
    `sla_delivery_time_days` STRING COMMENT 'Committed delivery timeframe in days for completion of standard service deliverables. Part of the Service Level Agreement (SLA) terms.',
    `sla_response_time_hours` STRING COMMENT 'Committed response time in hours for initial client inquiries or matter initiation under this service offering. Part of the Service Level Agreement (SLA) terms.',
    `sla_terms_description` STRING COMMENT 'Detailed textual description of all Service Level Agreement (SLA) commitments, performance metrics, and remedies for this service version.',
    `standard_rate_amount` DECIMAL(18,2) COMMENT 'Base rate or fee amount for this service version in the firms standard currency. For hourly models, represents the standard hourly rate; for fixed-fee models, represents the package price.',
    `target_client_segment` STRING COMMENT 'Intended client profile or market segment for this service offering (e.g., Fortune 500 Corporates, Mid-Market Private Equity, Government Entities, Individual High Net Worth).',
    `version_name` STRING COMMENT 'Business-friendly name or label for this version (e.g., Standard M&A Package 2024, Enhanced IP Counsel Q1). Used in client-facing documents and internal communications.',
    `version_number` STRING COMMENT 'Semantic version number of this service offering iteration (e.g., 1.0, 2.1, 3.0.1). Follows semantic versioning convention to track major and minor changes.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `version_status` STRING COMMENT 'Current lifecycle status of this service offering version. Tracks progression from draft through approval to active use and eventual retirement. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|deprecated|retired|superseded — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_offering_version PRIMARY KEY(`offering_version_id`)
) COMMENT 'Tracks the versioned lifecycle of legal service definitions, capturing changes to scope, pricing model, SLA terms, and practice area classification over time. Each version record preserves the full service definition snapshot at a point in time with effective start/end dates, change reason, and approval status. Enables historical audit of what was offered at the time of any given engagement letter or matter opening. Supports regulatory compliance and professional indemnity review.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` (
    `matter_service_mapping_id` BIGINT COMMENT 'Unique identifier for the matter-service mapping record. Primary key.',
    `clearance_id` BIGINT COMMENT 'Identifier of the conflict clearance record that authorized this service engagement, ensuring ethical compliance.',
    `guideline_id` BIGINT COMMENT 'Identifier of the client-specific billing guideline that governs invoicing rules, rate caps, and approval workflows for this service.',
    `letter_of_engagement_id` BIGINT COMMENT 'Identifier of the Letter of Engagement (LOE) document that formalizes the terms of this service mapping.',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the user who created this service mapping record.',
    `matter_id` BIGINT COMMENT 'Identifier of the legal matter to which this service mapping applies. Links to the matter entity.',
    `matter_last_modified_by_user_timekeeper_id` BIGINT COMMENT 'Identifier of the user who last modified this service mapping record.',
    `package_id` BIGINT COMMENT 'Identifier of the bundled service package (if applicable) that groups multiple legal services for this matter.',
    `practice_area_id` BIGINT COMMENT 'FK to service.practice_area',
    `legal_service_id` BIGINT COMMENT 'FK to service.legal_service.legal_service_id — The mapping must reference which legal_service is being delivered on a matter. This is the operational bridge between catalog and execution.',
    `primary_matter_approved_by_timekeeper_id` BIGINT COMMENT 'Identifier of the timekeeper (partner or senior attorney) who approved this service mapping.',
    `pricing_model_id` BIGINT COMMENT 'FK to service.pricing_model.pricing_model_id — The mapping must capture which pricing model applies to this specific matter-service combination, as it may differ from the service default due to negotiation.',
    `sla_template_id` BIGINT COMMENT 'FK to service.sla_template.sla_template_id — Each matter-service mapping must reference the SLA template in effect for that engagement, enabling SLA monitoring and breach detection.',
    `tertiary_matter_lead_associate_timekeeper_id` BIGINT COMMENT 'Identifier of the lead associate assigned to execute the service work for this matter.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to service.service_tier. Business justification: Matter service mappings reference a service tier. Normalize by linking to service_tier master. The service_tier STRING column is a code/name reference.',
    `amendment_count` STRING COMMENT 'The number of post-opening amendments made to this service mapping. Tracks scope changes and service adjustments.',
    `approval_date` DATE COMMENT 'The date on which this service mapping was approved.',
    `approval_status` STRING COMMENT 'Current approval status of the service mapping. Indicates whether the mapping is draft, pending approval, approved for use, rejected, suspended, or terminated.. Valid values are `draft|pending_approval|approved|rejected|suspended|terminated`',
    `billing_frequency` STRING COMMENT 'The frequency at which invoices are generated for this service mapping (monthly, quarterly, milestone-based, on completion, or ad hoc).. Valid values are `monthly|quarterly|milestone|on_completion|ad_hoc`',
    `budget_amount` DECIMAL(18,2) COMMENT 'The budgeted amount allocated for this service on this matter. Used for cost tracking and variance analysis.',
    `budget_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the budget amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this service mapping record was first created in the system.',
    `effective_end_date` DATE COMMENT 'The date on which this service mapping ceases to be active. Null indicates an open-ended mapping.',
    `effective_start_date` DATE COMMENT 'The date from which this service mapping becomes active and work under this service can be billed and tracked.',
    `estimated_hours` DECIMAL(18,2) COMMENT 'Estimated total hours required to deliver this service for the matter. Used for resource planning and capacity management.',
    `is_primary_service` BOOLEAN COMMENT 'Boolean flag indicating whether this is the primary service for the matter (true) or a secondary/ancillary service (false).',
    `last_amendment_date` DATE COMMENT 'The date of the most recent amendment to this service mapping. Null if no amendments have been made.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this service mapping record was last modified.',
    `matter_pricing_model_fk` BIGINT COMMENT 'FK to service.pricing_model.pricing_model_id — Each matter-service mapping records the agreed pricing model for that engagement. Required for billing code alignment and WIP calculation.',
    `matter_sla_template_fk` BIGINT COMMENT 'FK to service.sla_template.sla_template_id — Each matter-service mapping references the active SLA template governing service delivery commitments for that engagement.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special instructions, or exceptions related to this service mapping.',
    `pricing_model` STRING COMMENT 'The pricing model applied to this service mapping. Includes hourly billing, fixed fee, contingency, Alternative Fee Arrangement (AFA) capped, AFA blended rate, or retainer.. Valid values are `hourly|fixed_fee|contingency|afa_capped|afa_blended|retainer`',
    `rfp_reference_number` STRING COMMENT 'Reference number of the RFP that led to this service engagement, if applicable. Used for traceability to business development.',
    `service_completion_date` DATE COMMENT 'The date on which service delivery was completed for this mapping. Null if service is ongoing.',
    `service_scope_description` STRING COMMENT 'Detailed textual description of the agreed service scope at matter opening, outlining deliverables, exclusions, and boundaries.',
    `service_start_date` DATE COMMENT 'The actual date on which service delivery commenced for this mapping. May differ from effective_start_date.',
    `service_tier` STRING COMMENT 'The tier of service delivery (standard, premium, enterprise, custom) indicating the level of resource allocation and priority.. Valid values are `standard|premium|enterprise|custom`',
    `service_tier_fk` BIGINT COMMENT 'FK to service.service_tier.service_tier_id — The mapping records which service tier was agreed for the engagement, determining scope and pricing.',
    `utbms_activity_code` STRING COMMENT 'UTBMS activity code aligned to this service mapping for granular work activity classification per LEDES standards.. Valid values are `^[A-Z][0-9]{3}$`',
    `utbms_task_code` STRING COMMENT 'UTBMS task code aligned to this service mapping for standardized billing and work categorization per LEDES standards.. Valid values are `^[A-Z][0-9]{3}$`',
    CONSTRAINT pk_matter_service_mapping PRIMARY KEY(`matter_service_mapping_id`)
) COMMENT 'Operational association linking active legal matters to the specific legal_service offerings and service_packages under which work is delivered. Each record captures the agreed service scope at matter opening, applied pricing_model, active sla_template, service_tier, effective dates, and approval status. Serves as the runtime bridge between the service catalog and matter execution, enabling service-level WIP attribution, SLA monitoring, billing code alignment per LEDES/UTBMS, and performance analytics by service type. Parent record for service_scope_amendment records that track post-opening changes.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`service`.`delivery_model` (
    `delivery_model_id` BIGINT COMMENT 'Unique identifier for the legal service delivery model. Primary key.',
    `attorney_profile_id` BIGINT COMMENT 'Identifier of the partner or practice group leader responsible for governance and performance of this delivery model.',
    `category_id` BIGINT COMMENT 'Foreign key linking to risk.risk_category. Business justification: Delivery models (offshore, nearshore, hybrid) carry distinct risk profiles: data security, regulatory compliance, quality control, ethical wall requirements. Risk assessments gate delivery model selec',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the user who last modified this delivery model record.',
    `applicable_practice_areas` STRING COMMENT 'Comma-separated list of legal practice areas for which this delivery model is suitable (e.g., M&A, Litigation, IP Prosecution, Regulatory Compliance, Employment Law).',
    `applicable_service_types` STRING COMMENT 'Comma-separated list of service type codes or names that can be delivered using this model (e.g., advisory, transactional, dispute_resolution, compliance_counseling).',
    `approval_authority` STRING COMMENT 'Level of authority required to approve use of this delivery model for a new engagement: partner (individual partner discretion), practice_group_head (practice leader approval), managing_partner (firm leadership approval), executive_committee (board-level approval).. Valid values are `partner|practice_group_head|managing_partner|executive_committee`',
    `capacity_utilization_target_pct` DECIMAL(18,2) COMMENT 'Target utilization rate (percentage of billable hours to total available hours) for resources operating under this delivery model, used for capacity planning and profitability analysis.',
    `client_interaction_model` STRING COMMENT 'Level and frequency of direct client engagement: high_touch (frequent partner/senior attorney interaction), medium_touch (periodic check-ins), low_touch (minimal direct contact), self_service (client portal-driven), or hybrid (varies by phase).. Valid values are `high_touch|medium_touch|low_touch|self_service|hybrid`',
    `conflict_check_required` BOOLEAN COMMENT 'Indicates whether formal conflict checking is mandatory before engaging this delivery model (True for traditional attorney-led models, may be False for certain ALSP or administrative services).',
    `cost_structure_basis` STRING COMMENT 'Primary pricing and cost structure associated with this delivery model: hourly_rate (traditional billable hour), fixed_fee (project-based), capped_fee (not-to-exceed), contingency (success-based), retainer (ongoing access), subscription (periodic flat fee), outcome_based (performance-linked), or blended_rate (averaged hourly rate across team). [ENUM-REF-CANDIDATE: hourly_rate|fixed_fee|capped_fee|contingency|retainer|subscription|outcome_based|blended_rate — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery model record was first created in the system.',
    `data_security_tier` STRING COMMENT 'Level of data security and confidentiality controls applied to this delivery model: standard (baseline firm security), enhanced (additional encryption and access controls), maximum (air-gapped or highly restricted), client_specific (bespoke security per client requirements).. Valid values are `standard|enhanced|maximum|client_specific`',
    `delivery_model_description` STRING COMMENT 'Detailed narrative description of the delivery model, including operational characteristics, typical use cases, and distinguishing features.',
    `delivery_model_status` STRING COMMENT 'Current lifecycle status of the delivery model: active (in production use), inactive (temporarily suspended), pilot (under trial), deprecated (phasing out), retired (no longer offered).. Valid values are `active|inactive|pilot|deprecated|retired`',
    `effective_end_date` DATE COMMENT 'Date on which this delivery model was retired or deprecated, if applicable. Null for currently active models.',
    `effective_start_date` DATE COMMENT 'Date from which this delivery model became available for use in client engagements.',
    `ethical_wall_support` BOOLEAN COMMENT 'Indicates whether this delivery model supports the establishment of ethical walls (information barriers) to manage conflicts of interest (True for models with segregated teams, False for fully integrated teams).',
    `fte_requirement_max` DECIMAL(18,2) COMMENT 'Maximum number of full-time equivalent staff typically allocated to this delivery model for scalability planning.',
    `fte_requirement_min` DECIMAL(18,2) COMMENT 'Minimum number of full-time equivalent staff required to operate this delivery model effectively for a typical engagement.',
    `innovation_maturity` STRING COMMENT 'Maturity level of innovation and technology adoption in this delivery model: traditional (established methods), emerging (adopting new tools), innovative (leading-edge practices), cutting_edge (experimental or pioneering approaches).. Valid values are `traditional|emerging|innovative|cutting_edge`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery model record was last updated.',
    `model_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the delivery model for business reference and system integration (e.g., TRAD_PARTNER, ALSP_HYBRID, MLS_ONSITE).. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `model_name` STRING COMMENT 'Full business name of the delivery model (e.g., Traditional Partner-Led Team, Alternative Legal Service Provider (ALSP) Co-Delivery, Managed Legal Services).',
    `model_type` STRING COMMENT 'Primary classification of the delivery model: traditional (partner-led attorney teams), ALSP (Alternative Legal Service Provider co-delivery), MLS (Managed Legal Services), LPO (Legal Process Outsourcing), secondment (client-embedded counsel), or hybrid (combination of multiple models).. Valid values are `traditional|alsp|mls|lpo|secondment|hybrid`',
    `preferred_matter_size` STRING COMMENT 'Optimal matter or engagement size for which this delivery model is best suited: small (low-value, short-duration), medium (moderate complexity and duration), large (high-value, extended engagement), enterprise (multi-year, strategic), or any (flexible across all sizes).. Valid values are `small|medium|large|enterprise|any`',
    `primary_delivery_geography` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the primary geographic location from which services are delivered (e.g., USA, GBR, IND for offshore centers).. Valid values are `^[A-Z]{3}$`',
    `quality_assurance_approach` STRING COMMENT 'Primary quality control mechanism for work delivered under this model: partner_review (senior attorney sign-off), peer_review (colleague validation), automated_qa (technology-driven checks), external_audit (third-party review), iso_certified (ISO 9001 quality management), or none (no formal QA).. Valid values are `partner_review|peer_review|automated_qa|external_audit|iso_certified|none`',
    `regulatory_compliance_scope` STRING COMMENT 'Comma-separated list of regulatory frameworks and compliance requirements applicable to this delivery model (e.g., GDPR, CCPA, SOX, AML, Legal Professional Privilege (LPP), Solicitors Regulation Authority (SRA) standards).',
    `resource_composition` STRING COMMENT 'Textual description of the typical team composition, including ratios of partners, associates, paralegals, legal technologists, and support staff (e.g., 1 partner : 3 associates : 2 paralegals).',
    `scalability_rating` STRING COMMENT 'Assessment of how easily this delivery model can scale up or down to meet fluctuating demand: low (fixed team, limited flexibility), medium (moderate scaling with lead time), high (rapid scaling capability), elastic (on-demand scaling with minimal lead time).. Valid values are `low|medium|high|elastic`',
    `secondary_delivery_geography` STRING COMMENT 'ISO 3166-1 alpha-3 country code for secondary or backup delivery location, if applicable (e.g., nearshore support center).. Valid values are `^[A-Z]{3}$`',
    `sla_response_time_hours` STRING COMMENT 'Standard response time commitment in hours for client inquiries under this delivery model, as defined in typical Service Level Agreements (SLAs).',
    `sla_turnaround_time_days` STRING COMMENT 'Standard turnaround time commitment in business days for deliverable completion under this delivery model, as defined in typical Service Level Agreements (SLAs).',
    `staffing_model` STRING COMMENT 'Defines the primary resource composition and leadership structure: partner-led (senior attorney oversight), associate-led (mid-level attorney execution), paralegal-led (support-staff driven), mixed-tier (blended seniority), offshore/nearshore/onshore (geographic staffing), or client-site (embedded at client location). [ENUM-REF-CANDIDATE: partner_led|associate_led|paralegal_led|mixed_tier|offshore|nearshore|onshore|client_site — 8 candidates stripped; promote to reference product]',
    `technology_enablement` STRING COMMENT 'Degree of technology integration in the delivery model: manual (minimal tech), standard_tools (DMS and research platforms), advanced_automation (workflow automation and RPA), ai_assisted (AI/ML for document review, contract analysis), or full_digital (end-to-end digital delivery).. Valid values are `manual|standard_tools|advanced_automation|ai_assisted|full_digital`',
    CONSTRAINT pk_delivery_model PRIMARY KEY(`delivery_model_id`)
) COMMENT 'Reference catalog of operational delivery models through which legal services are provided to clients. Covers traditional partner-led attorney teams, client secondments, ALSP (Alternative Legal Service Provider) co-delivery, managed legal services (MLS), legal process outsourcing (LPO), and hybrid models. Each record defines the staffing model type, resource composition, technology enablement approach, primary delivery geography, cost structure basis, and applicable service types. Referenced by legal_service definitions for default delivery configuration and used in capacity planning, RFP staffing proposals, and client reporting on delivery efficiency.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`service`.`scope_amendment` (
    `scope_amendment_id` BIGINT COMMENT 'Unique identifier for the service scope amendment record. Primary key.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user who created this amendment record.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the partner or senior lawyer who approved the amendment on behalf of the firm.',
    `client_engagement_scope_id` BIGINT COMMENT 'Reference to the original engagement scope that this amendment modifies.',
    `matter_id` BIGINT COMMENT 'Reference to the matter to which this scope amendment applies.',
    `client_contact_id` BIGINT COMMENT 'Reference to the contact (client or internal) who initiated or requested the scope amendment.',
    `scope_modified_by_user_timekeeper_id` BIGINT COMMENT 'Reference to the user who last modified this amendment record.',
    `superseded_by_scope_amendment_id` BIGINT COMMENT 'Reference to a subsequent amendment that supersedes or replaces this amendment. Null if this is the current active amendment.',
    `amendment_description` STRING COMMENT 'Detailed narrative describing the changes being made to the engagement scope, including business rationale and impact summary.',
    `amendment_document_reference` STRING COMMENT 'Reference identifier or Document Management System (DMS) path to the formal amendment document or Letter of Engagement (LOE) addendum.',
    `amendment_number` STRING COMMENT 'Business identifier for the amendment, typically sequential within a matter or engagement (e.g., AMD-001, AMD-002).',
    `amendment_reason_code` STRING COMMENT 'Standardized code indicating the primary business reason for the amendment: scope creep (unplanned work expansion), client request (client-initiated change), regulatory change (compliance-driven), cost overrun (budget exceeded), timeline extension (schedule change), or service upgrade (enhanced service level).. Valid values are `scope_creep|client_request|regulatory_change|cost_overrun|timeline_extension|service_upgrade`',
    `amendment_status` STRING COMMENT 'Current lifecycle status of the amendment: draft (being prepared), pending approval (awaiting client or partner sign-off), approved (authorized but not yet executed), rejected (declined), executed (in force), or superseded (replaced by a later amendment).. Valid values are `draft|pending_approval|approved|rejected|executed|superseded`',
    `amendment_type` STRING COMMENT 'Classification of the nature of the scope amendment: scope expansion (additional work added), scope reduction (work removed), fee renegotiation (pricing changes), SLA modification (service level changes), AFA restructuring (Alternative Fee Arrangement changes), or service addition (new service lines added).. Valid values are `scope_expansion|scope_reduction|fee_renegotiation|sla_modification|afa_restructuring|service_addition`',
    `approval_date` DATE COMMENT 'Date on which the amendment was formally approved by the authorized partner or client representative.',
    `billing_impact_notes` STRING COMMENT 'Detailed notes on how this amendment affects billing arrangements, including changes to billing frequency, payment terms, or invoicing procedures.',
    `client_approval_date` DATE COMMENT 'Date on which the client formally approved the scope amendment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this amendment record was first created in the system.',
    `effective_date` DATE COMMENT 'Date from which the amended scope terms become binding and applicable to the matter.',
    `execution_date` DATE COMMENT 'Date on which the amendment was formally executed and became binding, typically when all parties have signed.',
    `expiry_date` DATE COMMENT 'Date on which the amendment terms expire or are scheduled for review, if applicable. Null for indefinite amendments.',
    `fee_adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary value of the fee change resulting from this amendment. Positive for increases, negative for decreases, zero for no change.',
    `fee_adjustment_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the fee adjustment amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `fee_impact_type` STRING COMMENT 'Classification of how the amendment affects fees: increase (higher fees), decrease (lower fees), no change (scope change without fee impact), or restructure (fee model changed).. Valid values are `increase|decrease|no_change|restructure`',
    `indemnity_exposure_impact` STRING COMMENT 'Assessment of how this amendment affects the firms professional indemnity insurance exposure: increased (higher risk), decreased (lower risk), unchanged (no material impact), or under review (being assessed).. Valid values are `increased|decreased|unchanged|under_review`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this amendment record was last modified.',
    `original_scope_reference` STRING COMMENT 'Reference identifier or clause number from the original Letter of Engagement (LOE) or engagement scope document that is being amended.',
    `request_date` DATE COMMENT 'Date on which the scope amendment was formally requested.',
    `requested_by_party` STRING COMMENT 'Indicates which party initiated the amendment request: client (client-driven), firm (law firm-driven), or mutual (jointly agreed).. Valid values are `client|firm|mutual`',
    `revised_fee_arrangement_type` STRING COMMENT 'The fee arrangement model after this amendment: hourly (time-based), fixed fee (flat rate), contingency (outcome-based), capped fee (not-to-exceed), blended rate (averaged hourly), success fee (performance bonus), or retainer (ongoing engagement). [ENUM-REF-CANDIDATE: hourly|fixed_fee|contingency|capped_fee|blended_rate|success_fee|retainer — 7 candidates stripped; promote to reference product]',
    `revised_sla_terms` STRING COMMENT 'Description of the modified SLA terms, including response times, deliverable deadlines, and performance commitments.',
    `risk_assessment_notes` STRING COMMENT 'Internal notes documenting risk considerations, conflict implications, and professional responsibility issues arising from the scope amendment.',
    `scope_change_summary` STRING COMMENT 'Concise summary of the specific scope changes, including work added, removed, or modified.',
    `sla_change_indicator` BOOLEAN COMMENT 'Flag indicating whether this amendment includes changes to Service Level Agreement (SLA) terms (True) or not (False).',
    `wip_adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary value of Work in Progress (WIP) adjustments resulting from this amendment (write-offs, re-ratings, or accruals).',
    `wip_impact_assessment` STRING COMMENT 'Assessment of how this amendment affects existing Work in Progress (WIP), including whether unbilled time will be written off, re-rated, or carried forward under new terms.',
    CONSTRAINT pk_scope_amendment PRIMARY KEY(`scope_amendment_id`)
) COMMENT 'Records formal amendments to the agreed scope of a legal service engagement after matter opening, including scope expansions, reductions, fee renegotiations, SLA modifications, and AFA restructuring. Each amendment captures the original scope reference, the nature of the change, the effective date, approval chain, and impact on the pricing model and WIP. Supports LOE amendment tracking and professional indemnity exposure management.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`service`.`eligibility_rule` (
    `eligibility_rule_id` BIGINT COMMENT 'Unique identifier for the service eligibility rule. Primary key for this entity.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user (timekeeper, business development manager, or system administrator) who most recently modified this eligibility rule record.',
    `legal_service_id` BIGINT COMMENT 'Reference to the legal service offering to which this eligibility rule applies (e.g., M&A advisory, litigation, IP counsel, regulatory compliance counseling).',
    `practice_area_id` BIGINT COMMENT 'Foreign key to service.practice_area.practice_area_id',
    `primary_eligibility_timekeeper_id` BIGINT COMMENT 'Reference to the partner, practice group leader, or business development manager responsible for defining and maintaining this eligibility rule.',
    `rule_owner_timekeeper_id` BIGINT COMMENT 'Reference to the user (timekeeper, business development manager, or system administrator) who created this eligibility rule record.',
    `approval_date` DATE COMMENT 'Date on which this eligibility rule was formally approved for activation. Null if rule has not been approved or approval is not required.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether formal approval is required before this rule can be activated. True if approval workflow must be completed, false otherwise.',
    `client_type_filter` STRING COMMENT 'Pipe-separated list of client types to which this rule applies (e.g., corporate|government, individual, nonprofit). Empty if rule applies to all client types. [ENUM-REF-CANDIDATE: corporate|government|individual|nonprofit|partnership|trust|estate|public_sector|private_sector — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this eligibility rule record was first created in the system. Used for audit trail and data lineage.',
    `effective_end_date` DATE COMMENT 'Date after which this eligibility rule is no longer active. Null for open-ended rules that remain in effect indefinitely.',
    `effective_start_date` DATE COMMENT 'Date from which this eligibility rule becomes active and is enforced during new business intake and RFP qualification processes.',
    `enforcement_level` STRING COMMENT 'Severity of the rule enforcement: hard block (prevents engagement from proceeding without exception), advisory warning (requires partner override to proceed), or soft warning (informational only, does not block).. Valid values are `hard_block|advisory_warning|soft_warning`',
    `evaluation_logic` STRING COMMENT 'Structured expression or pseudo-code defining how the rule is evaluated during intake workflow. May reference client attributes, matter attributes, clearance outcomes, or external data sources.',
    `external_reference_code` STRING COMMENT 'Optional reference to an external policy document, regulatory requirement, or business standard that mandates or informs this eligibility rule (e.g., ABA Model Rule reference, SRA Code reference).',
    `industry_sector_exclusion` STRING COMMENT 'Pipe-separated list of industry sectors (e.g., NAICS or SIC codes) that are excluded from eligibility for this legal service. Empty if no sector exclusions apply.',
    `jurisdiction_filter` STRING COMMENT 'Pipe-separated list of jurisdictions (ISO 3166-1 alpha-3 country codes or state/province codes) to which this rule applies. Empty if rule applies globally. Used to enforce jurisdictional licensing constraints.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this eligibility rule record was most recently updated. Used for audit trail and change tracking.',
    `matter_value_threshold` DECIMAL(18,2) COMMENT 'Minimum estimated matter value (in base currency) required for the client or matter to qualify for the legal service. Null if no value threshold applies.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, implementation guidance, or historical information about this eligibility rule. Used by business development and intake teams.',
    `override_authority_level` STRING COMMENT 'The minimum authority level required to override this rule when enforcement level is advisory warning (e.g., partner, managing partner, practice group leader, general counsel). Null if rule cannot be overridden.. Valid values are `partner|managing_partner|practice_group_leader|general_counsel|none`',
    `practice_area_filter` STRING COMMENT 'Pipe-separated list of practice area codes or identifiers to which this rule applies (e.g., M&A, litigation, IP, employment). Empty if rule applies to all practice areas.',
    `prerequisite_clearance_status_required` STRING COMMENT 'The clearance status outcome required from the prerequisite clearance process for the rule to pass (e.g., approved, cleared, passed). Null if no prerequisite applies.. Valid values are `approved|cleared|passed|none`',
    `prerequisite_clearance_type` STRING COMMENT 'Type of prerequisite clearance required before the legal service can be offered: conflict check (from conflict domain), KYC (Know Your Client), AML (Anti-Money Laundering), sanctions screening, or none if no prerequisite applies.. Valid values are `conflict_check|kyc|aml|sanctions_screening|none`',
    `rule_code` STRING COMMENT 'Business-assigned unique code for the eligibility rule, used for reference in intake workflows and RFP qualification processes.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `rule_description` STRING COMMENT 'Detailed business description of the eligibility rule, including the rationale, business context, and any special considerations for application during new business intake.',
    `rule_name` STRING COMMENT 'Human-readable name of the eligibility rule, describing its purpose (e.g., Corporate Client Minimum Matter Value, Government Sector Exclusion).',
    `rule_priority` STRING COMMENT 'Numeric priority for rule evaluation order when multiple rules apply to the same service. Lower numbers indicate higher priority. Used by intake workflow engine to sequence rule checks.',
    `rule_status` STRING COMMENT 'Current lifecycle status of the eligibility rule: active (enforced), inactive (not enforced), draft (under development), suspended (temporarily disabled), or retired (no longer used).. Valid values are `active|inactive|draft|suspended|retired`',
    `rule_type` STRING COMMENT 'Category of eligibility rule defining the nature of the constraint: client-type restrictions (corporate, government, individual), minimum matter value thresholds, jurisdictional licensing constraints, industry sector exclusions, prerequisite clearance requirements (conflict check, KYC, AML), or practice area restrictions.. Valid values are `client_type_restriction|matter_value_threshold|jurisdictional_licensing|industry_sector_exclusion|prerequisite_clearance|practice_area_restriction`',
    `rule_version` STRING COMMENT 'Version number of this eligibility rule, incremented with each substantive change to evaluation logic or enforcement parameters. Supports rule change tracking and audit.',
    `threshold_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the matter value threshold (e.g., USD, GBP, EUR). Null if no value threshold applies.. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_eligibility_rule PRIMARY KEY(`eligibility_rule_id`)
) COMMENT 'Defines configurable business rules governing which clients or matters qualify for specific legal service offerings during new business intake. Rule types include client-type restrictions (corporate, government, individual), minimum matter value thresholds, jurisdictional licensing constraints, industry sector exclusions, and prerequisite clearance requirements. Each rule specifies evaluation logic, enforcement level (hard block preventing engagement vs. advisory warning requiring partner override), and the legal_service scope to which it applies. Consumed by the intake workflow engine during RFP qualification and matter opening. Note: this product defines the eligibility gating rules only — actual conflict-of-interest screening execution is owned by the conflict domain, and KYC/AML program management is owned by the compliance domain. This product references their clearance outcomes as prerequisite inputs.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`service`.`lpm_template` (
    `lpm_template_id` BIGINT COMMENT 'Unique identifier for the Legal Project Management template. Primary key.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the partner who owns and maintains this template, responsible for updates and quality.',
    `knowledge_asset_id` BIGINT COMMENT 'Foreign key linking to knowledge.knowledge_asset. Business justification: LPM templates reference specific knowledge assets as required inputs for matter phases and deliverables. Used in matter planning, resource estimation, and scope definition. Enables tracking which know',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: LPM templates are scoped by practice area. Normalize by linking to practice_area master. The practice_area STRING column is a code/name reference.',
    `legal_service_id` BIGINT COMMENT 'FK to service.legal_service.legal_service_id — LPM templates are created for specific service types. A litigation LPM template differs fundamentally from a transactional one. This link enables correct template selection at matter opening.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether formal approval is required before a matter team can instantiate this template for a new matter (True/False).',
    `approved_by` STRING COMMENT 'Name or identifier of the partner or practice group leader who approved this template for use.',
    `approved_date` DATE COMMENT 'Date when this template was formally approved for use in matter management.',
    `budget_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the estimated budget amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `client_reporting_frequency` STRING COMMENT 'Standard frequency for client progress reporting defined in this template (Weekly, Bi-Weekly, Monthly, Quarterly, Milestone-Based, Ad-Hoc).. Valid values are `Weekly|Bi-Weekly|Monthly|Quarterly|Milestone-Based|Ad-Hoc`',
    `complexity_level` STRING COMMENT 'Complexity classification of matters that should use this template, indicating resource requirements and risk profile (Low, Medium, High, Very High).. Valid values are `Low|Medium|High|Very High`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this template record was first created in the system.',
    `deliverable_count` STRING COMMENT 'Total number of standard deliverables (documents, reports, opinions) defined in this template.',
    `document_template_references` STRING COMMENT 'Comma-separated list of document template IDs or codes that are standard deliverables for this LPM template.',
    `effective_from_date` DATE COMMENT 'Date from which this template version becomes effective and available for matter instantiation.',
    `effective_to_date` DATE COMMENT 'Date until which this template version remains effective; nullable for templates with no planned end date.',
    `estimated_budget_amount` DECIMAL(18,2) COMMENT 'Standard estimated budget amount for matters using this template, used for initial scoping and client proposals.',
    `estimated_duration_days` STRING COMMENT 'Standard estimated duration in calendar days for matters following this template, from matter opening to closure.',
    `fee_arrangement_type` STRING COMMENT 'Default fee arrangement type recommended for matters using this template (Hourly, Fixed Fee, Contingency, Capped Fee, Blended Rate, Success Fee).. Valid values are `Hourly|Fixed Fee|Contingency|Capped Fee|Blended Rate|Success Fee`',
    `fte_requirement` DECIMAL(18,2) COMMENT 'Estimated total Full-Time Equivalent (FTE) resource requirement for the duration of a matter using this template.',
    `jurisdiction_scope` STRING COMMENT 'Comma-separated list of jurisdictions or countries where this template is applicable (e.g., USA, GBR, EU, Global).',
    `knowledge_article_references` STRING COMMENT 'Comma-separated list of knowledge management article IDs or practice notes that support this template.',
    `last_modified_by` STRING COMMENT 'Name or identifier of the user who last modified this template record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this template record was last modified in the system.',
    `last_used_date` DATE COMMENT 'Date when this template was most recently used to instantiate a new matter.',
    `milestone_count` STRING COMMENT 'Total number of key milestones defined across all phases in this template.',
    `notes` STRING COMMENT 'Free-text notes or comments about this template, including usage guidance, special considerations, or change history.',
    `phase_count` STRING COMMENT 'Total number of project phases defined in this template (e.g., Intake, Planning, Execution, Review, Closure).',
    `practice_area` STRING COMMENT 'Primary practice area classification for this template (e.g., Corporate, Litigation, Intellectual Property, Employment, Regulatory Compliance, Real Estate).. Valid values are `Corporate|Litigation|Intellectual Property|Employment|Regulatory Compliance|Real Estate`',
    `practice_group_code` STRING COMMENT 'Code identifying the practice group that owns and maintains this template (e.g., CORP, LIT, IP, EMP).. Valid values are `^[A-Z0-9_]{2,10}$`',
    `regulatory_framework` STRING COMMENT 'Applicable regulatory frameworks or compliance requirements this template addresses (e.g., GDPR, SOX, CCPA, AML).',
    `resource_role_requirements` STRING COMMENT 'Comma-separated list of required resource roles for this template (e.g., Partner, Senior Associate, Junior Associate, Paralegal, Legal Secretary).',
    `risk_checkpoint_count` STRING COMMENT 'Number of formal risk assessment checkpoints defined in the template for matter governance and quality control.',
    `service_type` STRING COMMENT 'Type of legal service this template supports (e.g., Advisory, Transactional, Contentious, Compliance, Due Diligence, Drafting).. Valid values are `Advisory|Transactional|Contentious|Compliance|Due Diligence|Drafting`',
    `sla_target_days` STRING COMMENT 'Service Level Agreement (SLA) target duration in days for matter completion when using this template.',
    `task_count` STRING COMMENT 'Total number of standard tasks defined in the template task sequence.',
    `template_code` STRING COMMENT 'Business identifier code for the LPM template, used for quick reference and system integration (e.g., MA_STANDARD, LIT_COMPLEX, IP_PATENT).. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `template_description` STRING COMMENT 'Detailed description of the LPM template, including its purpose, scope, typical use cases, and key deliverables.',
    `template_name` STRING COMMENT 'Human-readable name of the LPM template describing the project structure and service type (e.g., Standard M&A Transaction Template, Complex Commercial Litigation Template).',
    `template_status` STRING COMMENT 'Current lifecycle status of the LPM template (Draft, Active, Under Review, Deprecated, Archived).. Valid values are `Draft|Active|Under Review|Deprecated|Archived`',
    `usage_count` STRING COMMENT 'Total number of matters that have been instantiated using this template, used for template effectiveness analysis.',
    `utbms_task_codes` STRING COMMENT 'Comma-separated list of Uniform Task-Based Management System (UTBMS) task codes applicable to this template for standardized billing and reporting.',
    `version_number` STRING COMMENT 'Version identifier for the template following semantic versioning (e.g., 1.0, 2.1, 3.0.1), enabling version control and change tracking.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `created_by` STRING COMMENT 'Name or identifier of the user who created this template record.',
    CONSTRAINT pk_lpm_template PRIMARY KEY(`lpm_template_id`)
) COMMENT 'Stores Legal Project Management (LPM) plan templates associated with specific legal service offerings, defining standard phases, milestones, task sequences, resource role requirements, budget allocation by phase, and risk checkpoints. Each template provides a reusable project structure for matter teams to instantiate when opening a new matter under a given service type. Supports consistent delivery, budget control, and client reporting across matters of the same service type.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`service`.`line` (
    `line_id` BIGINT COMMENT 'Unique identifier for the service line. Primary key.',
    `timekeeper_id` BIGINT COMMENT 'The identifier of the user who last modified this service line record. Used for audit trail and accountability tracking.',
    `parent_line_id` BIGINT COMMENT 'Self-referencing FK on line (parent_line_id)',
    `average_matter_duration_days` STRING COMMENT 'The typical duration in days from matter opening to closure for matters in this service line. Used for resource planning, WIP forecasting, and client expectation management.',
    `average_matter_value` DECIMAL(18,2) COMMENT 'The average total billed value (in firm base currency) of matters in this service line. Used for pipeline forecasting, partner compensation modeling, and lateral hiring business case analysis.',
    `billing_model_default` STRING COMMENT 'The predominant billing model used by this service line. Hourly = traditional time-based billing. Fixed Fee = flat fee per matter. Contingency = success-based fee. AFA (Alternative Fee Arrangement) = value-based or outcome-based pricing. Hybrid = combination. Retainer = ongoing monthly/quarterly fee.. Valid values are `hourly|fixed_fee|contingency|afa|hybrid|retainer`',
    `client_facing_flag` BOOLEAN COMMENT 'Indicates whether this service line is used in client-facing branding, marketing materials, and RFP responses (True) or is purely an internal financial reporting construct (False).',
    `conflict_sensitivity_level` STRING COMMENT 'The typical conflict-of-interest sensitivity for matters in this service line. High = frequent conflicts requiring ethical walls (e.g., M&A, litigation). Medium = occasional conflicts. Low = rare conflicts. Used to inform conflict checking protocols.. Valid values are `high|medium|low`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this service line record was first created in the system. Used for audit trail and data lineage tracking.',
    `cross_selling_affinity_score` DECIMAL(18,2) COMMENT 'A calculated score (0-100) representing the likelihood of cross-selling opportunities between this service line and other service lines. Based on historical client engagement patterns. Used for business development targeting.',
    `diversity_target_percentage` DECIMAL(18,2) COMMENT 'The firms diversity representation target (as a percentage) for this service lines attorney population. Used for DEI reporting, lateral hiring decisions, and client diversity scorecard requirements.',
    `effective_date` DATE COMMENT 'The date when this service line was officially established or became operational for financial reporting and matter assignment purposes.',
    `end_date` DATE COMMENT 'The date when this service line was discontinued or sunset. Null for active service lines. Used for historical P&L reporting and partner compensation reconciliation.',
    `fte_count_current` DECIMAL(18,2) COMMENT 'The current total FTE headcount (partners, associates, paralegals, and support staff) allocated to this service line. Used for utilization analysis, capacity planning, and revenue per FTE calculations.',
    `geographic_scope` STRING COMMENT 'The geographic market scope of this service lines operations and client base. Local = single city/metro. Regional = multi-city within region. National = country-wide. International = multi-country. Global = worldwide presence.. Valid values are `local|regional|national|international|global`',
    `insurance_coverage_required_flag` BOOLEAN COMMENT 'Indicates whether specialized professional liability insurance coverage is required for this service line beyond the firms general malpractice policy (True) or not (False). Common for high-risk practices like securities litigation or IP prosecution.',
    `knowledge_management_repository` STRING COMMENT 'The primary knowledge management system or repository used by this service line for precedent documents, practice notes, and matter templates (e.g., Thomson Reuters Practical Law, iManage Work, internal KM system).',
    `line_code` STRING COMMENT 'Short alphanumeric code used internally for financial reporting, practice management systems, and partner compensation allocation (e.g., CORP, DISP, REG, TRANS, IP, EMP).. Valid values are `^[A-Z0-9]{2,10}$`',
    `line_description` STRING COMMENT 'Detailed description of the service lines scope, including the types of legal services, practice areas, and client matters it encompasses. Used for business development, RFP responses, and strategic planning.',
    `line_name` STRING COMMENT 'The official name of the service line as used in firm communications, financial reporting, and client-facing materials (e.g., Corporate Advisory, Disputes & Investigations, Regulatory & Government Affairs, Transactional, Intellectual Property, Employment & Labor).',
    `line_status` STRING COMMENT 'Current operational status of the service line. Active lines are fully operational with revenue targets and partner assignments. Inactive lines are no longer accepting new matters. Under review indicates strategic evaluation. Sunset indicates planned phase-out.. Valid values are `active|inactive|under_review|sunset`',
    `market_positioning` STRING COMMENT 'The firms market positioning and competitive differentiation statement for this service line. Used in business development, RFP responses, and lateral partner recruitment.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this service line record was last modified. Used for audit trail, change tracking, and data quality monitoring.',
    `partner_count` STRING COMMENT 'The number of equity and non-equity partners primarily assigned to this service line. Used for RPE (Revenue Per Equity Partner) and PPP (Profit Per Partner) calculations.',
    `practice_area_taxonomy` STRING COMMENT 'Comma-separated list or structured taxonomy of practice areas that roll up into this service line (e.g., M&A, Securities, Private Equity for Corporate Advisory service line). Used for matter classification and lateral hiring decisions.',
    `pro_bono_allocation_percentage` DECIMAL(18,2) COMMENT 'The target percentage of this service lines total hours to be allocated to pro bono work. Used for ABA pro bono reporting and associate development planning.',
    `realization_rate_target` DECIMAL(18,2) COMMENT 'The target realization rate (percentage of standard rates actually collected) for this service line. Expressed as a percentage (e.g., 92.50 for 92.5%). Used for pricing strategy and partner performance evaluation.',
    `regulatory_oversight_body` STRING COMMENT 'Primary regulatory or professional body governing the legal services provided by this service line (e.g., SEC for securities practice, USPTO for patent prosecution, State Bar for general practice). Used for compliance tracking and CPD planning.',
    `revenue_target_annual` DECIMAL(18,2) COMMENT 'The annual revenue target (in firm base currency) set for this service line during strategic planning. Used for partner compensation, performance evaluation, and resource allocation decisions.',
    `strategic_priority_level` STRING COMMENT 'The firms strategic investment priority for this service line. Tier 1 = high growth investment. Tier 2 = selective growth. Tier 3 = maintain current scale. Maintain = stable revenue focus. Divest = planned wind-down or sale.. Valid values are `tier_1|tier_2|tier_3|maintain|divest`',
    `technology_platform_primary` STRING COMMENT 'The primary technology platform or specialized software used by this service line (e.g., Relativity for eDiscovery, LexisNexis for legal research, Thomson Reuters for transactional work). Used for IT budgeting and training planning.',
    CONSTRAINT pk_line PRIMARY KEY(`line_id`)
) COMMENT 'Defines the firms operational business lines that group legal service offerings for P&L reporting, partner compensation allocation, strategic planning, and client-facing branding. Each service line (e.g., Corporate Advisory, Disputes & Investigations, Regulatory & Government Affairs, Transactional) aggregates multiple practice areas and legal services into a commercially-managed unit with its own revenue targets, leadership structure, and market positioning. Distinct from practice_area (which is a professional taxonomy) — service_line is the business management layer used in firm financials, lateral hiring decisions, and strategic growth planning.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`service`.`delivery_configuration` (
    `delivery_configuration_id` BIGINT COMMENT 'Unique identifier for this service-delivery model configuration. Primary key.',
    `delivery_model_id` BIGINT COMMENT 'Foreign key linking to the delivery model through which the service can be provided',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to the legal service offering being configured for delivery',
    `practice_area_id` BIGINT COMMENT 'Foreign key to service.practice_area.practice_area_id',
    `configuration_status` STRING COMMENT 'Current lifecycle status of this service-delivery configuration: active (in production use), inactive (temporarily disabled), pilot (testing phase), deprecated (being phased out).',
    `cost_allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of service delivery cost allocated to this specific delivery model when multiple models are used for the same service. Used in financial planning and client billing allocation.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this service-delivery configuration was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date on which this service-delivery model combination was retired or deprecated. Null indicates currently active configuration.',
    `effective_start_date` DATE COMMENT 'Date from which this service-delivery model combination became available for client engagements. Tracks when specific delivery configurations were activated.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this service-delivery configuration record.',
    `preferred_flag` BOOLEAN COMMENT 'Indicates whether this delivery model is the preferred or recommended approach for delivering this specific service. Used in RFP responses and capacity planning to prioritize delivery model selection.',
    `sla_override` STRING COMMENT 'Service Level Agreement override or adjustment specific to this service-delivery model combination. Captures deviations from standard SLAs defined in either the service or delivery model when this specific pairing requires different commitments.',
    CONSTRAINT pk_delivery_configuration PRIMARY KEY(`delivery_configuration_id`)
) COMMENT 'This association product represents the operational configuration between legal services and delivery models. It captures which services can be delivered through which models, tracking effectiveness, cost allocation, and SLA overrides for each combination. Each record links one legal_service to one delivery_model with attributes that exist only in the context of this specific service-model pairing, used in capacity planning, RFP staffing proposals, and client delivery optimization.. Existence Justification: In legal services operations, firms actively manage which services can be delivered through which delivery models, creating a genuine many-to-many operational relationship. A single legal service (e.g., M&A advisory) can be delivered through multiple models (traditional partner-led, ALSP co-delivery, managed legal services) depending on client requirements, matter complexity, and cost constraints. Conversely, a single delivery model (e.g., client secondment) can be used to deliver multiple different legal services (litigation, IP counsel, regulatory compliance). The firm tracks the effectiveness, cost allocation, and SLA commitments for each specific service-model pairing.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`service`.`practice_area_delivery_configuration` (
    `practice_area_delivery_configuration_id` BIGINT COMMENT 'Primary key for practice_area_delivery_configuration',
    `delivery_configuration_id` BIGINT COMMENT 'Primary key uniquely identifying each practice area delivery configuration record',
    `delivery_model_id` BIGINT COMMENT 'Foreign key linking to the delivery model through which the practice area can be delivered',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to the practice area being configured for delivery',
    `capacity_allocation_fte` DECIMAL(18,2) COMMENT 'Number of full-time equivalent staff allocated to deliver this specific practice area through this specific delivery model. Used for capacity planning and resource forecasting. Explicitly identified in detection phase relationship data.',
    `client_demand_rating` STRING COMMENT 'Assessment of client demand for this practice area delivered through this delivery model, based on RFP requests, client inquiries, and market analysis.',
    `configuration_status` STRING COMMENT 'Current lifecycle status of this practice area-delivery model configuration. Active configurations are in production use, pilot configurations are being tested, inactive are temporarily suspended, and deprecated are retired.',
    `cost_efficiency_score` DECIMAL(18,2) COMMENT 'Calculated score (0-100) representing the cost efficiency of delivering this practice area through this delivery model, based on cost per matter, realization rates, and resource utilization.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this configuration record was first created in the system',
    `effective_end_date` DATE COMMENT 'Date on which this practice area-delivery model configuration was retired or deprecated. Null for currently active configurations. Explicitly identified in detection phase relationship data.',
    `effective_start_date` DATE COMMENT 'Date from which this practice area-delivery model configuration became active and available for use in client engagements and capacity planning. Explicitly identified in detection phase relationship data.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this configuration record was last modified',
    `priority_level` STRING COMMENT 'Strategic importance of this practice area-delivery model combination to the firm. Strategic combinations receive priority in capacity allocation and investment.',
    `quality_rating` STRING COMMENT 'Assessment of the quality and effectiveness of delivering this practice area through this delivery model, based on client feedback, matter outcomes, and internal quality reviews. Explicitly identified in detection phase relationship data.',
    `utilization_target_percentage` DECIMAL(18,2) COMMENT 'Target utilization rate (percentage of billable hours to total available hours) for resources delivering this practice area through this delivery model. Used for performance management and capacity optimization. Explicitly identified in detection phase relationship data.',
    CONSTRAINT pk_practice_area_delivery_configuration PRIMARY KEY(`practice_area_delivery_configuration_id`)
) COMMENT 'This association product represents the operational configuration between practice areas and delivery models in legal service delivery. It captures which practice areas can be delivered through which delivery models, along with capacity allocation, performance targets, and effectiveness tracking. Each record links one practice area to one delivery model with attributes that define the operational parameters, resource allocation, and quality metrics for that specific combination. This is actively managed by legal operations teams for capacity planning, RFP response preparation, and delivery optimization.. Existence Justification: In legal operations, practice areas can be delivered through multiple delivery models (e.g., M&A can be delivered via traditional partner-led teams, ALSP co-delivery, or managed legal services), and each delivery model supports multiple practice areas (e.g., ALSP co-delivery can handle IP, employment law, and regulatory compliance). Legal operations teams actively manage this matrix to allocate capacity, respond to RFPs with appropriate staffing models, track delivery effectiveness, and optimize resource deployment across the practice-delivery configuration space.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ADD CONSTRAINT `fk_service_practice_area_parent_practice_area_id` FOREIGN KEY (`parent_practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ADD CONSTRAINT `fk_service_legal_service_delivery_model_id` FOREIGN KEY (`delivery_model_id`) REFERENCES `legal_ecm_v1`.`service`.`delivery_model`(`delivery_model_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ADD CONSTRAINT `fk_service_legal_service_line_id` FOREIGN KEY (`line_id`) REFERENCES `legal_ecm_v1`.`service`.`line`(`line_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ADD CONSTRAINT `fk_service_legal_service_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ADD CONSTRAINT `fk_service_tier_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ADD CONSTRAINT `fk_service_pricing_model_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ADD CONSTRAINT `fk_service_rate_card_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ADD CONSTRAINT `fk_service_rate_card_superseded_by_rate_card_id` FOREIGN KEY (`superseded_by_rate_card_id`) REFERENCES `legal_ecm_v1`.`service`.`rate_card`(`rate_card_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ADD CONSTRAINT `fk_service_sla_template_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ADD CONSTRAINT `fk_service_sla_template_offering_version_id` FOREIGN KEY (`offering_version_id`) REFERENCES `legal_ecm_v1`.`service`.`offering_version`(`offering_version_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ADD CONSTRAINT `fk_service_sla_template_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ADD CONSTRAINT `fk_service_sla_template_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm_v1`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`package` ADD CONSTRAINT `fk_service_package_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`package` ADD CONSTRAINT `fk_service_package_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm_v1`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`package` ADD CONSTRAINT `fk_service_package_primary_superseded_by_package_id` FOREIGN KEY (`primary_superseded_by_package_id`) REFERENCES `legal_ecm_v1`.`service`.`package`(`package_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ADD CONSTRAINT `fk_service_jurisdiction_coverage_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ADD CONSTRAINT `fk_service_offering_version_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ADD CONSTRAINT `fk_service_offering_version_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ADD CONSTRAINT `fk_service_offering_version_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm_v1`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ADD CONSTRAINT `fk_service_offering_version_superseded_offering_version_id` FOREIGN KEY (`superseded_offering_version_id`) REFERENCES `legal_ecm_v1`.`service`.`offering_version`(`offering_version_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ADD CONSTRAINT `fk_service_matter_service_mapping_package_id` FOREIGN KEY (`package_id`) REFERENCES `legal_ecm_v1`.`service`.`package`(`package_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ADD CONSTRAINT `fk_service_matter_service_mapping_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ADD CONSTRAINT `fk_service_matter_service_mapping_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ADD CONSTRAINT `fk_service_matter_service_mapping_pricing_model_id` FOREIGN KEY (`pricing_model_id`) REFERENCES `legal_ecm_v1`.`service`.`pricing_model`(`pricing_model_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ADD CONSTRAINT `fk_service_matter_service_mapping_sla_template_id` FOREIGN KEY (`sla_template_id`) REFERENCES `legal_ecm_v1`.`service`.`sla_template`(`sla_template_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ADD CONSTRAINT `fk_service_matter_service_mapping_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `legal_ecm_v1`.`service`.`tier`(`tier_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ADD CONSTRAINT `fk_service_scope_amendment_superseded_by_scope_amendment_id` FOREIGN KEY (`superseded_by_scope_amendment_id`) REFERENCES `legal_ecm_v1`.`service`.`scope_amendment`(`scope_amendment_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ADD CONSTRAINT `fk_service_eligibility_rule_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ADD CONSTRAINT `fk_service_eligibility_rule_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ADD CONSTRAINT `fk_service_lpm_template_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ADD CONSTRAINT `fk_service_lpm_template_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`line` ADD CONSTRAINT `fk_service_line_parent_line_id` FOREIGN KEY (`parent_line_id`) REFERENCES `legal_ecm_v1`.`service`.`line`(`line_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_configuration` ADD CONSTRAINT `fk_service_delivery_configuration_delivery_model_id` FOREIGN KEY (`delivery_model_id`) REFERENCES `legal_ecm_v1`.`service`.`delivery_model`(`delivery_model_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_configuration` ADD CONSTRAINT `fk_service_delivery_configuration_legal_service_id` FOREIGN KEY (`legal_service_id`) REFERENCES `legal_ecm_v1`.`service`.`legal_service`(`legal_service_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_configuration` ADD CONSTRAINT `fk_service_delivery_configuration_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area_delivery_configuration` ADD CONSTRAINT `fk_service_practice_area_delivery_configuration_delivery_configuration_id` FOREIGN KEY (`delivery_configuration_id`) REFERENCES `legal_ecm_v1`.`service`.`delivery_configuration`(`delivery_configuration_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area_delivery_configuration` ADD CONSTRAINT `fk_service_practice_area_delivery_configuration_delivery_model_id` FOREIGN KEY (`delivery_model_id`) REFERENCES `legal_ecm_v1`.`service`.`delivery_model`(`delivery_model_id`);
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area_delivery_configuration` ADD CONSTRAINT `fk_service_practice_area_delivery_configuration_practice_area_id` FOREIGN KEY (`practice_area_id`) REFERENCES `legal_ecm_v1`.`service`.`practice_area`(`practice_area_id`);

-- ========= TAGS =========
ALTER SCHEMA `legal_ecm_v1`.`service` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `legal_ecm_v1`.`service` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area ID');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Category Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `parent_practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Practice Area ID');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `average_matter_value` SET TAGS ('dbx_business_glossary_term' = 'Average Matter Value');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `average_matter_value` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `classification_type` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Classification Type');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `classification_type` SET TAGS ('dbx_value_regex' = 'transactional|advisory|litigation|regulatory|hybrid|specialized');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `cpd_requirement_hours` SET TAGS ('dbx_business_glossary_term' = 'Continuing Professional Development (CPD) Requirement Hours');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `default_billing_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Default Billing Arrangement');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Code');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `insurance_coverage_requirement` SET TAGS ('dbx_business_glossary_term' = 'Professional Indemnity Insurance Coverage Requirement');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `jurisdiction_scope` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Scope');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `knowledge_management_category` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Management Category');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `practice_area_code` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Code');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `practice_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `practice_area_description` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Description');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `practice_area_name` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Name');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `practice_area_status` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Status');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `practice_area_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|archived');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `practice_group` SET TAGS ('dbx_business_glossary_term' = 'Practice Group');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `primary_service_line` SET TAGS ('dbx_business_glossary_term' = 'Primary Service Line');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `pro_bono_eligible` SET TAGS ('dbx_business_glossary_term' = 'Pro Bono Eligible Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `regulatory_body_alignment` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Alignment');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `requires_security_clearance` SET TAGS ('dbx_business_glossary_term' = 'Requires Security Clearance Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `requires_specialization` SET TAGS ('dbx_business_glossary_term' = 'Requires Specialization Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Short Name');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `technology_platform_requirement` SET TAGS ('dbx_business_glossary_term' = 'Technology Platform Requirement');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `typical_matter_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Typical Matter Duration in Days');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `utbms_activity_code_prefix` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Activity Code Prefix');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `utbms_activity_code_prefix` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{3}$');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `utbms_task_code_prefix` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code Prefix');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area` ALTER COLUMN `utbms_task_code_prefix` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{3}$');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Partner Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Category Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `delivery_model_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Model Id');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Id');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `allows_afa` SET TAGS ('dbx_business_glossary_term' = 'Allows Alternative Fee Arrangement (AFA)');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `cross_sell_services` SET TAGS ('dbx_business_glossary_term' = 'Cross-Sell Services');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `deliverable_types` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Types');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `eligible_client_segments` SET TAGS ('dbx_business_glossary_term' = 'Eligible Client Segments');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Hours');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `insurance_coverage_required` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Required');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `jurisdiction_coverage` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Coverage');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `knowledge_assets` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Assets');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `matter_type_mapping` SET TAGS ('dbx_business_glossary_term' = 'Matter Type Mapping');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'Practice Area');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `practice_area` SET TAGS ('dbx_value_regex' = 'corporate|litigation|intellectual_property|employment|regulatory_compliance|real_estate');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `required_expertise_level` SET TAGS ('dbx_business_glossary_term' = 'Required Expertise Level');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `required_expertise_level` SET TAGS ('dbx_value_regex' = 'associate|senior_associate|counsel|partner|specialized_counsel');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `requires_conflict_check` SET TAGS ('dbx_business_glossary_term' = 'Requires Conflict Check');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `requires_kyc` SET TAGS ('dbx_business_glossary_term' = 'Requires Know Your Client (KYC)');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `service_category` SET TAGS ('dbx_value_regex' = 'standard|premium|specialized|package|retainer_based');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Service Code');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `service_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `service_name` SET TAGS ('dbx_business_glossary_term' = 'Service Name');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `service_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|under_development|pilot');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'advisory|transactional|litigation|compliance|research|drafting');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `sla_delivery_time_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Delivery Time Days');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time Hours');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `standard_rate` SET TAGS ('dbx_business_glossary_term' = 'Standard Rate');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `standard_rate` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `technology_requirements` SET TAGS ('dbx_business_glossary_term' = 'Technology Requirements');
ALTER TABLE `legal_ecm_v1`.`service`.`legal_service` ALTER COLUMN `utbms_task_codes` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Codes');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Service Tier Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `appetite_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Threshold Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Client Segment Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `afa_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Alternative Fee Arrangement (AFA) Eligible Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `afa_models_supported` SET TAGS ('dbx_business_glossary_term' = 'Alternative Fee Arrangement (AFA) Models Supported');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `approved_by_partner` SET TAGS ('dbx_business_glossary_term' = 'Approved By Partner');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `base_hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Hourly Rate');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `base_hourly_rate` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `conflict_check_level` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Level');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `conflict_check_level` SET TAGS ('dbx_value_regex' = 'standard|enhanced|comprehensive');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `data_protection_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Classification');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `data_protection_classification` SET TAGS ('dbx_value_regex' = 'standard|confidential|highly_confidential');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `document_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Document Retention Period (Years)');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `included_deliverables` SET TAGS ('dbx_business_glossary_term' = 'Included Deliverables');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `insurance_coverage_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Professional Indemnity Insurance Coverage Required Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `kyc_aml_level` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) and Anti-Money Laundering (AML) Level');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `kyc_aml_level` SET TAGS ('dbx_value_regex' = 'basic|standard|enhanced|high_risk');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `matter_type_applicability` SET TAGS ('dbx_business_glossary_term' = 'Matter Type Applicability');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `maximum_engagement_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Engagement Value');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `maximum_engagement_value` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `minimum_engagement_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Engagement Value');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `minimum_engagement_value` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `partner_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Partner Approval Required Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'Practice Area');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `response_time_commitment_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Time Commitment (Hours)');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `scope_of_coverage` SET TAGS ('dbx_business_glossary_term' = 'Scope of Coverage');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `sla_terms` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Terms');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_business_glossary_term' = 'Service Tier Code');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `tier_description` SET TAGS ('dbx_business_glossary_term' = 'Service Tier Description');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `tier_level` SET TAGS ('dbx_business_glossary_term' = 'Service Tier Level');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_business_glossary_term' = 'Service Tier Name');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `tier_status` SET TAGS ('dbx_business_glossary_term' = 'Service Tier Status');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `tier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|draft');
ALTER TABLE `legal_ecm_v1`.`service`.`tier` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `pricing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Partner Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Category Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `pricing_last_modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `pricing_last_modified_by_user_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `pricing_last_modified_by_user_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Client Segment Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `advance_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Amount');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `advance_payment_required` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Required Indicator');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `afa_indicator` SET TAGS ('dbx_business_glossary_term' = 'Alternative Fee Arrangement (AFA) Indicator');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `applicable_jurisdictions` SET TAGS ('dbx_business_glossary_term' = 'Applicable Jurisdictions');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `applicable_practice_areas` SET TAGS ('dbx_business_glossary_term' = 'Applicable Practice Areas');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Indicator');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `base_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Rate Amount');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `billing_increment_minutes` SET TAGS ('dbx_business_glossary_term' = 'Billing Increment (Minutes)');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `blended_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Blended Rate Amount');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Calculation Basis');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_value_regex' = 'time_based|matter_based|transaction_value|outcome_based|hybrid');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contingency Fee Percentage');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `expense_markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Expense Markup Percentage');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `expense_reimbursement_policy` SET TAGS ('dbx_business_glossary_term' = 'Expense Reimbursement Policy');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `expense_reimbursement_policy` SET TAGS ('dbx_value_regex' = 'full_reimbursement|capped_reimbursement|included_in_fee|no_reimbursement');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `internal_notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `late_payment_interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Interest Rate (Annual Percentage)');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `ledes_format_version` SET TAGS ('dbx_business_glossary_term' = 'Legal Electronic Data Exchange Standard (LEDES) Format Version');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `ledes_format_version` SET TAGS ('dbx_value_regex' = '^LEDES[0-9]{4}BI(V[0-9])?$');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `maximum_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Fee Amount (Cap)');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `minimum_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Fee Amount');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `model_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Code');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `model_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Name');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Type');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'hourly|fixed_fee|capped_fee|blended_rate|retainer|contingency');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (Days)');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `pricing_model_description` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Description');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `pricing_model_status` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Status');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `pricing_model_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|under_review|approved');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `retainer_amount` SET TAGS ('dbx_business_glossary_term' = 'Retainer Amount');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `retainer_frequency` SET TAGS ('dbx_business_glossary_term' = 'Retainer Frequency');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `retainer_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|one_time');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `sla_resolution_time_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Resolution Time (Days)');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time (Hours)');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `success_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Success Fee Amount');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code');
ALTER TABLE `legal_ecm_v1`.`service`.`pricing_model` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{3}$');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `superseded_by_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Rate Card Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|expired');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `billing_guideline_compliant` SET TAGS ('dbx_business_glossary_term' = 'Billing Guideline Compliant Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `client_segment` SET TAGS ('dbx_business_glossary_term' = 'Client Segment');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `client_segment` SET TAGS ('dbx_value_regex' = 'fortune_500|mid_market|small_business|government|non_profit|individual');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `firm_office_location_code` SET TAGS ('dbx_business_glossary_term' = 'Office Location Code');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `firm_office_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Billing Rate');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `is_default_rate` SET TAGS ('dbx_business_glossary_term' = 'Is Default Rate Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `minimum_charge_increment_minutes` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Increment (Minutes)');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Notes');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `rate_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Cap Amount');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `rate_cap_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `rate_card_description` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Description');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `rate_card_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Name');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `rate_floor_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Floor Amount');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `rate_floor_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `rate_source` SET TAGS ('dbx_business_glossary_term' = 'Rate Source');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `rate_source` SET TAGS ('dbx_value_regex' = 'firm_standard|client_negotiated|engagement_letter|rfp_response|afa_agreement|market_benchmark');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'standard|preferred|blended|discounted|negotiated|afa');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `rate_version` SET TAGS ('dbx_business_glossary_term' = 'Rate Version Number');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `seniority_level` SET TAGS ('dbx_business_glossary_term' = 'Seniority Level');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `utbms_activity_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Activity Code');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `utbms_activity_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{3}$');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code');
ALTER TABLE `legal_ecm_v1`.`service`.`rate_card` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{3}$');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `sla_template_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Template ID');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `offering_version_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering ID');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `pricing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|active|deprecated|archived');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `availability_commitment` SET TAGS ('dbx_business_glossary_term' = 'Availability Commitment');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `breach_count` SET TAGS ('dbx_business_glossary_term' = 'Breach Count');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `breach_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Breach Threshold Percentage');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `client_tier` SET TAGS ('dbx_business_glossary_term' = 'Client Tier');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `client_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `escalation_threshold` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `escalation_unit` SET TAGS ('dbx_business_glossary_term' = 'Escalation Unit');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `escalation_unit` SET TAGS ('dbx_value_regex' = 'hours|business_days|calendar_days');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `fee_adjustment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fee Adjustment Percentage');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `matter_complexity` SET TAGS ('dbx_business_glossary_term' = 'Matter Complexity');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `matter_complexity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'Practice Area');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `quality_standard` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `remediation_terms` SET TAGS ('dbx_business_glossary_term' = 'Remediation Terms');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|bi_weekly|monthly|quarterly|on_demand');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `response_time_target` SET TAGS ('dbx_business_glossary_term' = 'Response Time Target');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `response_time_unit` SET TAGS ('dbx_business_glossary_term' = 'Response Time Unit');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `response_time_unit` SET TAGS ('dbx_value_regex' = 'hours|business_days|calendar_days');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `sla_type` SET TAGS ('dbx_business_glossary_term' = 'SLA Type');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `sla_type` SET TAGS ('dbx_value_regex' = 'matter_response|document_turnaround|court_filing_deadline|regulatory_submission|client_communication|research_delivery');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'SLA Template Code');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `template_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `template_description` SET TAGS ('dbx_business_glossary_term' = 'SLA Template Description');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'SLA Template Name');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `turnaround_time_target` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time Target');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `turnaround_time_unit` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time Unit');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `turnaround_time_unit` SET TAGS ('dbx_value_regex' = 'hours|business_days|calendar_days|weeks');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `legal_ecm_v1`.`service`.`sla_template` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `legal_ecm_v1`.`service`.`package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Service Package ID');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `appetite_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Threshold Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `package_owner_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `package_owner_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `package_owner_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `pricing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `primary_package_approved_by_partner_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Partner ID');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `primary_superseded_by_package_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Package ID');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|archived');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `average_engagement_value` SET TAGS ('dbx_business_glossary_term' = 'Average Engagement Value');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `average_engagement_value` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `base_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Price Amount');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `base_price_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `cross_sell_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Sell Eligible Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `document_management_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Document Management System (DMS) Required Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `estimated_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Hours');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `includes_ediscovery_flag` SET TAGS ('dbx_business_glossary_term' = 'Includes eDiscovery Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `includes_legal_research_flag` SET TAGS ('dbx_business_glossary_term' = 'Includes Legal Research Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `internal_notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `jurisdiction_coverage` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Coverage');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `marketing_collateral_url` SET TAGS ('dbx_business_glossary_term' = 'Marketing Collateral Uniform Resource Locator (URL)');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `minimum_engagement_term_months` SET TAGS ('dbx_business_glossary_term' = 'Minimum Engagement Term (Months)');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `package_code` SET TAGS ('dbx_business_glossary_term' = 'Package Code');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `package_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `package_description` SET TAGS ('dbx_business_glossary_term' = 'Package Description');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `package_name` SET TAGS ('dbx_business_glossary_term' = 'Package Name');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'fixed_scope|retainer_based|project_based|advisory|transactional|hybrid');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'Practice Area');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `practice_area` SET TAGS ('dbx_value_regex' = 'corporate|litigation|intellectual_property|employment|regulatory_compliance|real_estate');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_value_regex' = 'hourly|fixed_fee|contingency|blended_rate|afa|value_based');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `requires_conflict_check_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Conflict Check Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `requires_kyc_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Know Your Client (KYC) Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `sla_resolution_time_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Resolution Time (Days)');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time (Hours)');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `target_client_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Client Segment');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `target_client_segment` SET TAGS ('dbx_value_regex' = 'enterprise|mid_market|startup|government|non_profit|individual');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `total_engagements_count` SET TAGS ('dbx_business_glossary_term' = 'Total Engagements Count');
ALTER TABLE `legal_ecm_v1`.`service`.`package` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `jurisdiction_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Coverage ID');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `admission_required` SET TAGS ('dbx_business_glossary_term' = 'Admission Required');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `admission_requirements` SET TAGS ('dbx_business_glossary_term' = 'Admission Requirements');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `adr_services_available` SET TAGS ('dbx_business_glossary_term' = 'Alternative Dispute Resolution (ADR) Services Available');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `aml_kyc_compliance_available` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) and Know Your Client (KYC) Compliance Available');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `conflict_check_scope` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Scope');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `conflict_check_scope` SET TAGS ('dbx_value_regex' = 'full|limited|excluded');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `court_access_level` SET TAGS ('dbx_business_glossary_term' = 'Court Access Level');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `court_access_level` SET TAGS ('dbx_value_regex' = 'full|limited|none|advisory_only');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `coverage_notes` SET TAGS ('dbx_business_glossary_term' = 'Coverage Notes');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|restricted|suspended');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `data_privacy_compliance_scope` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Compliance Scope');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `ecf_access` SET TAGS ('dbx_business_glossary_term' = 'Electronic Case Filing (ECF) Access');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `international_arbitration_venue` SET TAGS ('dbx_business_glossary_term' = 'International Arbitration Venue');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `ip_portfolio_management_available` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Portfolio Management Available');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `jurisdictional_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Jurisdictional Restrictions');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `language_requirements` SET TAGS ('dbx_business_glossary_term' = 'Language Requirements');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `local_counsel_notes` SET TAGS ('dbx_business_glossary_term' = 'Local Counsel Notes');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `local_counsel_required` SET TAGS ('dbx_business_glossary_term' = 'Local Counsel Required');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `matter_staffing_priority` SET TAGS ('dbx_business_glossary_term' = 'Matter Staffing Priority');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `multi_jurisdictional_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Jurisdictional Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `pacer_access` SET TAGS ('dbx_business_glossary_term' = 'Public Access to Court Electronic Records (PACER) Access');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `patent_bar_required` SET TAGS ('dbx_business_glossary_term' = 'Patent Bar Required');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `practice_area_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Restrictions');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `pro_hac_vice_available` SET TAGS ('dbx_business_glossary_term' = 'Pro Hac Vice Available');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `pro_hac_vice_requirements` SET TAGS ('dbx_business_glossary_term' = 'Pro Hac Vice Requirements');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `regulatory_compliance_scope` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Scope');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `rfp_eligible` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Eligible');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `legal_ecm_v1`.`service`.`jurisdiction_coverage` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `offering_version_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Version Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `offering_last_modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `offering_last_modified_by_user_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `offering_last_modified_by_user_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `pricing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `superseded_offering_version_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Version Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `version_owner_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Partner Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `active_matters_count` SET TAGS ('dbx_business_glossary_term' = 'Active Matters Count');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `archive_flag` SET TAGS ('dbx_business_glossary_term' = 'Archive Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Code');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `change_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Description');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `deliverables_list` SET TAGS ('dbx_business_glossary_term' = 'Deliverables List');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `engagement_letter_template_reference` SET TAGS ('dbx_business_glossary_term' = 'Engagement Letter Template Reference');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `estimated_hours_max` SET TAGS ('dbx_business_glossary_term' = 'Estimated Hours Maximum');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `estimated_hours_min` SET TAGS ('dbx_business_glossary_term' = 'Estimated Hours Minimum');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `exclusions_description` SET TAGS ('dbx_business_glossary_term' = 'Exclusions Description');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `jurisdiction_scope` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Scope');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `matter_type_applicability` SET TAGS ('dbx_business_glossary_term' = 'Matter Type Applicability');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `prerequisites_description` SET TAGS ('dbx_business_glossary_term' = 'Prerequisites Description');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `rfp_template_reference` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Template Reference');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `service_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Service Scope Description');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `sla_delivery_time_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Delivery Time Days');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time Hours');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `sla_terms_description` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Terms Description');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `standard_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Standard Rate Amount');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `standard_rate_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `target_client_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Client Segment');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `version_name` SET TAGS ('dbx_business_glossary_term' = 'Version Name');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `legal_ecm_v1`.`service`.`offering_version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Version Status');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `matter_service_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Service Mapping ID');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Clearance ID');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Guideline ID');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Letter ID');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `matter_last_modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `matter_last_modified_by_user_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `matter_last_modified_by_user_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Service Package ID');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_dbx_internal' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `primary_matter_approved_by_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Timekeeper ID');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `pricing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Id');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `sla_template_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Template Id');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `tertiary_matter_lead_associate_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Associate ID');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Service Tier Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|suspended|terminated');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|milestone|on_completion|ad_hoc');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `estimated_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Hours');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `is_primary_service` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Service');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `matter_pricing_model_fk` SET TAGS ('dbx_business_glossary_term' = 'Matter Pricing Model Fk');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `matter_sla_template_fk` SET TAGS ('dbx_business_glossary_term' = 'Matter Sla Template Fk');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'hourly|fixed_fee|contingency|afa_capped|afa_blended|retainer');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `rfp_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Reference Number');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `service_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Service Completion Date');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `service_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Service Scope Description');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `service_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Tier');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `service_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|enterprise|custom');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `service_tier_fk` SET TAGS ('dbx_business_glossary_term' = 'Service Tier Fk');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `utbms_activity_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Activity Code');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `utbms_activity_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{3}$');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code');
ALTER TABLE `legal_ecm_v1`.`service`.`matter_service_mapping` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{3}$');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `delivery_model_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Model ID');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Partner ID');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Category Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `applicable_practice_areas` SET TAGS ('dbx_business_glossary_term' = 'Applicable Practice Areas');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `applicable_service_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Service Types');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `approval_authority` SET TAGS ('dbx_value_regex' = 'partner|practice_group_head|managing_partner|executive_committee');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `capacity_utilization_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Capacity Utilization Target Percentage');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `client_interaction_model` SET TAGS ('dbx_business_glossary_term' = 'Client Interaction Model');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `client_interaction_model` SET TAGS ('dbx_value_regex' = 'high_touch|medium_touch|low_touch|self_service|hybrid');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `conflict_check_required` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Required Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `cost_structure_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Structure Basis');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `data_security_tier` SET TAGS ('dbx_business_glossary_term' = 'Data Security Tier');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `data_security_tier` SET TAGS ('dbx_value_regex' = 'standard|enhanced|maximum|client_specific');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `delivery_model_description` SET TAGS ('dbx_business_glossary_term' = 'Delivery Model Description');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `delivery_model_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Model Status');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `delivery_model_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pilot|deprecated|retired');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `ethical_wall_support` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Support Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `fte_requirement_max` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Requirement Maximum');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `fte_requirement_min` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Requirement Minimum');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `innovation_maturity` SET TAGS ('dbx_business_glossary_term' = 'Innovation Maturity Level');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `innovation_maturity` SET TAGS ('dbx_value_regex' = 'traditional|emerging|innovative|cutting_edge');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `model_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Model Code');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `model_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Delivery Model Name');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Delivery Model Type');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'traditional|alsp|mls|lpo|secondment|hybrid');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `preferred_matter_size` SET TAGS ('dbx_business_glossary_term' = 'Preferred Matter Size');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `preferred_matter_size` SET TAGS ('dbx_value_regex' = 'small|medium|large|enterprise|any');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `primary_delivery_geography` SET TAGS ('dbx_business_glossary_term' = 'Primary Delivery Geography');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `primary_delivery_geography` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `quality_assurance_approach` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Approach');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `quality_assurance_approach` SET TAGS ('dbx_value_regex' = 'partner_review|peer_review|automated_qa|external_audit|iso_certified|none');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `regulatory_compliance_scope` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Scope');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `resource_composition` SET TAGS ('dbx_business_glossary_term' = 'Resource Composition');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `scalability_rating` SET TAGS ('dbx_business_glossary_term' = 'Scalability Rating');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `scalability_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|elastic');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `secondary_delivery_geography` SET TAGS ('dbx_business_glossary_term' = 'Secondary Delivery Geography');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `secondary_delivery_geography` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time Hours');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `sla_turnaround_time_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Turnaround Time Days');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `staffing_model` SET TAGS ('dbx_business_glossary_term' = 'Staffing Model');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `technology_enablement` SET TAGS ('dbx_business_glossary_term' = 'Technology Enablement Level');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_model` ALTER COLUMN `technology_enablement` SET TAGS ('dbx_value_regex' = 'manual|standard_tools|advanced_automation|ai_assisted|full_digital');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `scope_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Scope Amendment ID');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Partner ID');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `client_engagement_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Scope ID');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By Contact ID');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `scope_modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `scope_modified_by_user_timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `scope_modified_by_user_timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `superseded_by_scope_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Amendment ID');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Description');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `amendment_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Amendment Document Reference');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `amendment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason Code');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `amendment_reason_code` SET TAGS ('dbx_value_regex' = 'scope_creep|client_request|regulatory_change|cost_overrun|timeline_extension|service_upgrade');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|executed|superseded');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'scope_expansion|scope_reduction|fee_renegotiation|sla_modification|afa_restructuring|service_addition');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `billing_impact_notes` SET TAGS ('dbx_business_glossary_term' = 'Billing Impact Notes');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `client_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Client Approval Date');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `fee_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Adjustment Amount');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `fee_adjustment_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Adjustment Currency');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `fee_adjustment_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `fee_impact_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Impact Type');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `fee_impact_type` SET TAGS ('dbx_value_regex' = 'increase|decrease|no_change|restructure');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `indemnity_exposure_impact` SET TAGS ('dbx_business_glossary_term' = 'Professional Indemnity Exposure Impact');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `indemnity_exposure_impact` SET TAGS ('dbx_value_regex' = 'increased|decreased|unchanged|under_review');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `original_scope_reference` SET TAGS ('dbx_business_glossary_term' = 'Original Scope Reference');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `requested_by_party` SET TAGS ('dbx_business_glossary_term' = 'Requested By Party');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `requested_by_party` SET TAGS ('dbx_value_regex' = 'client|firm|mutual');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `revised_fee_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Revised Fee Arrangement Type');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `revised_sla_terms` SET TAGS ('dbx_business_glossary_term' = 'Revised Service Level Agreement (SLA) Terms');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `risk_assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Notes');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `risk_assessment_notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `scope_change_summary` SET TAGS ('dbx_business_glossary_term' = 'Scope Change Summary');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `sla_change_indicator` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Change Indicator');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `wip_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Adjustment Amount');
ALTER TABLE `legal_ecm_v1`.`service`.`scope_amendment` ALTER COLUMN `wip_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Impact Assessment');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `eligibility_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Service Eligibility Rule Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `primary_eligibility_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Owner Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `rule_owner_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `client_type_filter` SET TAGS ('dbx_business_glossary_term' = 'Client Type Filter');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `enforcement_level` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Level');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `enforcement_level` SET TAGS ('dbx_value_regex' = 'hard_block|advisory_warning|soft_warning');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `evaluation_logic` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Logic');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Code');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `industry_sector_exclusion` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector Exclusion');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `jurisdiction_filter` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Filter');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `matter_value_threshold` SET TAGS ('dbx_business_glossary_term' = 'Matter Value Threshold');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `override_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Override Authority Level');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `override_authority_level` SET TAGS ('dbx_value_regex' = 'partner|managing_partner|practice_group_leader|general_counsel|none');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `practice_area_filter` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Filter');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `prerequisite_clearance_status_required` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Clearance Status Required');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `prerequisite_clearance_status_required` SET TAGS ('dbx_value_regex' = 'approved|cleared|passed|none');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `prerequisite_clearance_type` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Clearance Type');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `prerequisite_clearance_type` SET TAGS ('dbx_value_regex' = 'conflict_check|kyc|aml|sanctions_screening|none');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `rule_priority` SET TAGS ('dbx_business_glossary_term' = 'Rule Priority');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|suspended|retired');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Rule Type');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'client_type_restriction|matter_value_threshold|jurisdictional_licensing|industry_sector_exclusion|prerequisite_clearance|practice_area_restriction');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `rule_version` SET TAGS ('dbx_business_glossary_term' = 'Rule Version');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `threshold_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Threshold Currency Code');
ALTER TABLE `legal_ecm_v1`.`service`.`eligibility_rule` ALTER COLUMN `threshold_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `lpm_template_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Project Management (LPM) Template ID');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Partner ID');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `client_reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Client Reporting Frequency');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `client_reporting_frequency` SET TAGS ('dbx_value_regex' = 'Weekly|Bi-Weekly|Monthly|Quarterly|Milestone-Based|Ad-Hoc');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `complexity_level` SET TAGS ('dbx_business_glossary_term' = 'Complexity Level');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `complexity_level` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Very High');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `deliverable_count` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Count');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `document_template_references` SET TAGS ('dbx_business_glossary_term' = 'Document Template References');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `estimated_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Budget Amount');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `estimated_budget_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `estimated_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration (Days)');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Alternative Fee Arrangement (AFA) Type');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_value_regex' = 'Hourly|Fixed Fee|Contingency|Capped Fee|Blended Rate|Success Fee');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `fte_requirement` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Requirement');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `jurisdiction_scope` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Scope');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `knowledge_article_references` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Article References');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `milestone_count` SET TAGS ('dbx_business_glossary_term' = 'Milestone Count');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `phase_count` SET TAGS ('dbx_business_glossary_term' = 'Phase Count');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'Practice Area');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `practice_area` SET TAGS ('dbx_value_regex' = 'Corporate|Litigation|Intellectual Property|Employment|Regulatory Compliance|Real Estate');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `practice_group_code` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Code');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `practice_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `resource_role_requirements` SET TAGS ('dbx_business_glossary_term' = 'Resource Role Requirements');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `risk_checkpoint_count` SET TAGS ('dbx_business_glossary_term' = 'Risk Checkpoint Count');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'Advisory|Transactional|Contentious|Compliance|Due Diligence|Drafting');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `sla_target_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target (Days)');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `task_count` SET TAGS ('dbx_business_glossary_term' = 'Task Count');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `template_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `template_description` SET TAGS ('dbx_business_glossary_term' = 'Template Description');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `template_status` SET TAGS ('dbx_business_glossary_term' = 'Template Status');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `template_status` SET TAGS ('dbx_value_regex' = 'Draft|Active|Under Review|Deprecated|Archived');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `utbms_task_codes` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Codes');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `legal_ecm_v1`.`service`.`lpm_template` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `legal_ecm_v1`.`service`.`line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `parent_line_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Line Id');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `parent_line_id` SET TAGS ('dbx_dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `average_matter_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Average Matter Duration (Days)');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `average_matter_value` SET TAGS ('dbx_business_glossary_term' = 'Average Matter Value');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `average_matter_value` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `billing_model_default` SET TAGS ('dbx_business_glossary_term' = 'Default Billing Model');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `billing_model_default` SET TAGS ('dbx_value_regex' = 'hourly|fixed_fee|contingency|afa|hybrid|retainer');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `client_facing_flag` SET TAGS ('dbx_business_glossary_term' = 'Client-Facing Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `conflict_sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Conflict Sensitivity Level');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `conflict_sensitivity_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `cross_selling_affinity_score` SET TAGS ('dbx_business_glossary_term' = 'Cross-Selling Affinity Score');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `diversity_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Diversity Target Percentage');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Service Line Effective Date');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Service Line End Date');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `fte_count_current` SET TAGS ('dbx_business_glossary_term' = 'Current Full-Time Equivalent (FTE) Count');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `fte_count_current` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'local|regional|national|international|global');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `insurance_coverage_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Required Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `knowledge_management_repository` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Management Repository');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `line_code` SET TAGS ('dbx_business_glossary_term' = 'Service Line Code');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `line_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Service Line Description');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `line_name` SET TAGS ('dbx_business_glossary_term' = 'Service Line Name');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Service Line Status');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|sunset');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `market_positioning` SET TAGS ('dbx_business_glossary_term' = 'Market Positioning Statement');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `partner_count` SET TAGS ('dbx_business_glossary_term' = 'Partner Count');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `partner_count` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `practice_area_taxonomy` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Taxonomy');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `pro_bono_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Pro Bono Allocation Percentage');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `realization_rate_target` SET TAGS ('dbx_business_glossary_term' = 'Realization Rate Target (Percentage)');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `realization_rate_target` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `regulatory_oversight_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Oversight Body');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `revenue_target_annual` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Target');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `revenue_target_annual` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `strategic_priority_level` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority Level');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `strategic_priority_level` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|maintain|divest');
ALTER TABLE `legal_ecm_v1`.`service`.`line` ALTER COLUMN `technology_platform_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Technology Platform');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_configuration` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_configuration` ALTER COLUMN `delivery_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery Configuration ID');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_configuration` ALTER COLUMN `delivery_model_id` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery Configuration - Delivery Model Id');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_configuration` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery Configuration - Legal Service Id');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_configuration` ALTER COLUMN `configuration_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_configuration` ALTER COLUMN `cost_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Percentage');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_configuration` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Configuration Created Date');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_configuration` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Configuration Effective End Date');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_configuration` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Configuration Effective Start Date');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_configuration` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Configuration Last Modified Date');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_configuration` ALTER COLUMN `preferred_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Delivery Configuration Flag');
ALTER TABLE `legal_ecm_v1`.`service`.`delivery_configuration` ALTER COLUMN `sla_override` SET TAGS ('dbx_business_glossary_term' = 'SLA Override Configuration');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area_delivery_configuration` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area_delivery_configuration` ALTER COLUMN `practice_area_delivery_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'practice_area_delivery_configuration Identifier');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area_delivery_configuration` ALTER COLUMN `delivery_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Identifier');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area_delivery_configuration` ALTER COLUMN `delivery_model_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Delivery Configuration - Delivery Model Id');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area_delivery_configuration` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Delivery Configuration - Practice Area Id');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area_delivery_configuration` ALTER COLUMN `capacity_allocation_fte` SET TAGS ('dbx_business_glossary_term' = 'Capacity Allocation in FTE');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area_delivery_configuration` ALTER COLUMN `client_demand_rating` SET TAGS ('dbx_business_glossary_term' = 'Client Demand Rating');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area_delivery_configuration` ALTER COLUMN `configuration_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area_delivery_configuration` ALTER COLUMN `cost_efficiency_score` SET TAGS ('dbx_business_glossary_term' = 'Cost Efficiency Score');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area_delivery_configuration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Configuration Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area_delivery_configuration` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Configuration Effective End Date');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area_delivery_configuration` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Configuration Effective Start Date');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area_delivery_configuration` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Configuration Last Updated Timestamp');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area_delivery_configuration` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Configuration Priority Level');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area_delivery_configuration` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `legal_ecm_v1`.`service`.`practice_area_delivery_configuration` ALTER COLUMN `utilization_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Utilization Target Percentage');
