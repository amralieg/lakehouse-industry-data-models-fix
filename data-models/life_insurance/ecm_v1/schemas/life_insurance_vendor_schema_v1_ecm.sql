-- Schema for Domain: vendor | Business: Life Insurance | Version: v1_ecm
-- Generated on: 2026-05-04 03:46:16

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `life_insurance_ecm`.`vendor` COMMENT 'Manages all third-party vendor and service provider relationships including medical exam vendors (ExamOne, APPS), MIB, prescription database providers, reinsurance intermediaries, investment custodians, IT service providers, and outsourced administration (TPA) contracts.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor record. Primary key.',
    `parent_vendor_id` BIGINT COMMENT 'Self-referencing FK on vendor (parent_vendor_id)',
    `business_address_line1` STRING COMMENT 'The first line of the vendors primary business address, typically including street number and name.',
    `business_address_line2` STRING COMMENT 'The second line of the vendors primary business address, typically including suite, floor, or building information.',
    `business_city` STRING COMMENT 'The city of the vendors primary business address.',
    `business_country` STRING COMMENT 'Three-letter ISO country code for the vendors primary business address.. Valid values are `^[A-Z]{3}$`',
    `business_postal_code` STRING COMMENT 'The postal code (ZIP code) for the vendors primary business address.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `business_state` STRING COMMENT 'Two-letter state code for the vendors primary business address.. Valid values are `^[A-Z]{2}$`',
    `contract_end_date` DATE COMMENT 'The date when the primary vendor contract or master service agreement expires or is scheduled for renewal.',
    `contract_start_date` DATE COMMENT 'The date when the primary vendor contract or master service agreement becomes effective.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code indicating the primary currency used for transactions with this vendor.. Valid values are `^[A-Z]{3}$`',
    `data_sharing_agreement_signed` BOOLEAN COMMENT 'Indicates whether a formal data sharing or business associate agreement has been executed with this vendor.',
    `dba_name` STRING COMMENT 'The trade name or doing business as name under which the vendor operates, if different from legal name.',
    `domicile_country` STRING COMMENT 'Three-letter ISO country code indicating the country of incorporation or primary business domicile.. Valid values are `^[A-Z]{3}$`',
    `domicile_state` STRING COMMENT 'Two-letter state code indicating the state of incorporation or primary business domicile.. Valid values are `^[A-Z]{2}$`',
    `duns_number` STRING COMMENT 'The nine-digit DUNS number assigned by Dun & Bradstreet for unique vendor identification and credit assessment.. Valid values are `^[0-9]{9}$`',
    `hipaa_compliant` BOOLEAN COMMENT 'Indicates whether the vendor has demonstrated compliance with HIPAA requirements for handling protected health information.',
    `incorporation_type` STRING COMMENT 'The legal structure under which the vendor is incorporated or organized.. Valid values are `corporation|llc|partnership|sole_proprietorship|nonprofit`',
    `insurance_certificate_on_file` BOOLEAN COMMENT 'Indicates whether a current certificate of insurance (general liability, professional liability, cyber liability) is on file for this vendor.',
    `insurance_expiration_date` DATE COMMENT 'The expiration date of the vendors insurance coverage as documented in the certificate on file.',
    `last_audit_date` DATE COMMENT 'The date of the most recent internal or third-party audit conducted on this vendors operations or controls.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review or re-assessment of the vendor relationship and performance.',
    `notes` STRING COMMENT 'Free-form text field for capturing additional notes, comments, or special instructions related to the vendor relationship.',
    `onboarding_date` DATE COMMENT 'The date when the vendor was formally onboarded and approved for engagement.',
    `onboarding_status` STRING COMMENT 'Current lifecycle status of the vendor relationship, from initial prospect through active engagement to termination.. Valid values are `prospect|in_onboarding|active|suspended|terminated|inactive`',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed upon with the vendor, indicating the number of days within which payment is due.. Valid values are `net_15|net_30|net_45|net_60|net_90|due_on_receipt`',
    `performance_rating` STRING COMMENT 'The most recent overall performance rating assigned to the vendor based on service quality, timeliness, and compliance metrics.. Valid values are `excellent|good|satisfactory|needs_improvement|unsatisfactory`',
    `preferred_payment_method` STRING COMMENT 'The vendors preferred method for receiving payments.. Valid values are `ach|wire_transfer|check|credit_card`',
    `primary_contact_email` STRING COMMENT 'The primary email address for the vendors main business contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'The full name of the primary business contact or account manager at the vendor organization.',
    `primary_contact_phone` STRING COMMENT 'The primary telephone number for the vendors main business contact.. Valid values are `^+?[0-9]{10,15}$`',
    `soc2_certified` BOOLEAN COMMENT 'Indicates whether the vendor holds a current SOC 2 Type II certification for security and data protection controls.',
    `soc2_expiration_date` DATE COMMENT 'The expiration date of the vendors current SOC 2 certification, if applicable.',
    `tax_identifier` STRING COMMENT 'The federal tax identification number (EIN or TIN) assigned by the IRS for tax reporting and compliance purposes.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `termination_date` DATE COMMENT 'The date when the vendor relationship was formally terminated or the contract was ended.',
    `termination_reason` STRING COMMENT 'The business reason or justification for terminating the vendor relationship.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor record was most recently updated or modified.',
    `vendor_category` STRING COMMENT 'Risk tier classification based on the criticality of services provided and potential impact to business operations.. Valid values are `critical|high|medium|low`',
    `vendor_name` STRING COMMENT 'The full legal name of the vendor or service provider as registered with governing authorities.',
    `vendor_type` STRING COMMENT 'Primary classification of the vendor based on the services provided to the insurance company. [ENUM-REF-CANDIDATE: medical_exam|data_provider|tpa|reinsurance_intermediary|investment_custodian|it_service_provider|actuarial_consultant|legal_services|audit_services|marketing_agency|printing_services|facilities_management — promote to reference product]. Valid values are `medical_exam|data_provider|tpa|reinsurance_intermediary|investment_custodian|it_service_provider`',
    `website_url` STRING COMMENT 'The primary website URL for the vendor organization.. Valid values are `^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$`',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master record for every third-party vendor and service provider engaged by Life Insurance — medical exam vendors (ExamOne, APPS), MIB, prescription database providers, reinsurance intermediaries, investment custodians, IT service providers, TPAs, and all other external service organizations. Serves as the SSOT for vendor identity, legal entity details, tax identification, business classification, risk tier, and onboarding status. Captures vendor type (medical exam, data provider, TPA, custodian, IT, intermediary), DUNS/EIN, domicile state, incorporation type, and active/inactive lifecycle status.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` (
    `vendor_contract_id` BIGINT COMMENT 'Unique identifier for the vendor contract record. Primary key for the vendor contract entity.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: Vendor contracts must comply with enterprise compliance policies (data protection, SOX, HIPAA, information security). Tracks primary compliance policy governing contract terms and vendor obligations f',
    `employee_id` BIGINT COMMENT 'The user identifier of the person who created this vendor contract record in the system.',
    `owner_employee_id` BIGINT COMMENT 'Reference to the internal employee who is the business owner or relationship manager responsible for this vendor contract.',
    `parent_contract_vendor_contract_id` BIGINT COMMENT 'Reference to the parent or master contract when this contract is an amendment, addendum, or statement of work under a master service agreement. Nullable for standalone contracts.',
    `updated_by_user_employee_id` BIGINT COMMENT 'The user identifier of the person who last modified this vendor contract record in the system.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or service provider party that is the counterparty to this contract.',
    `renewed_vendor_contract_id` BIGINT COMMENT 'Self-referencing FK on vendor_contract (renewed_vendor_contract_id)',
    `amendment_count` STRING COMMENT 'The total number of amendments that have been executed against this contract since its original execution date. Useful for tracking contract stability and change frequency.',
    `audit_rights_flag` BOOLEAN COMMENT 'Indicates whether the contract grants Life Insurance the right to audit the vendors records, processes, or systems related to services provided. True indicates audit rights exist; False indicates no audit rights.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews at expiration unless either party provides notice of non-renewal. True indicates auto-renewal provisions exist; False indicates contract expires without action.',
    `auto_renewal_term_months` STRING COMMENT 'The duration in months for each automatic renewal period when auto-renewal provisions apply. Nullable if auto_renewal_flag is False.',
    `confidentiality_clause_flag` BOOLEAN COMMENT 'Indicates whether the contract includes confidentiality or non-disclosure provisions protecting proprietary information. True indicates confidentiality provisions exist; False indicates no such provisions.',
    `contract_name` STRING COMMENT 'The descriptive name or title of the contract for business reference and reporting purposes.',
    `contract_number` STRING COMMENT 'The externally-known unique business identifier for this contract, typically assigned by legal or procurement departments.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the contract. Draft indicates initial preparation; Under Review indicates legal or compliance review; Approved indicates internal authorization; Executed indicates signed by all parties; Active indicates currently in force; Suspended indicates temporarily paused; Terminated indicates ended before expiration; Expired indicates reached natural end date. [ENUM-REF-CANDIDATE: Draft|Under Review|Approved|Executed|Active|Suspended|Terminated|Expired — 8 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'The classification of the contract document type. Master Service Agreement (MSA) establishes overarching terms; Statement of Work (SOW) defines specific deliverables; Addendum adds supplementary terms; Amendment modifies existing terms; Service Agreement covers ongoing services; License Agreement grants usage rights.. Valid values are `MSA|SOW|Addendum|Amendment|Service Agreement|License Agreement`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor contract record was first created in the system.',
    `data_protection_clause_flag` BOOLEAN COMMENT 'Indicates whether the contract includes data protection, privacy, or data security provisions compliant with regulations such as GDPR, CCPA, or HIPAA. True indicates data protection provisions exist; False indicates no such provisions.',
    `dispute_resolution_method` STRING COMMENT 'The agreed-upon method for resolving disputes arising under the contract. Litigation involves court proceedings; Arbitration involves binding third-party arbitrator; Mediation involves facilitated negotiation; Negotiation involves direct party-to-party resolution.. Valid values are `Litigation|Arbitration|Mediation|Negotiation`',
    `document_location` STRING COMMENT 'The file path, document management system reference, or URL where the executed contract document is stored for retrieval and audit purposes.',
    `effective_date` DATE COMMENT 'The date on which the contract terms become binding and enforceable. This is the start date of the contract period.',
    `execution_date` DATE COMMENT 'The date on which the contract was signed by all required parties, making it legally binding.',
    `expiration_date` DATE COMMENT 'The date on which the contract terms naturally end unless renewed or extended. Nullable for evergreen or indefinite-term contracts.',
    `governing_law_jurisdiction` STRING COMMENT 'The legal jurisdiction whose laws govern the interpretation and enforcement of the contract, typically specified as a state or country (e.g., State of New York, England and Wales).',
    `indemnification_clause_flag` BOOLEAN COMMENT 'Indicates whether the contract includes indemnification provisions where one party agrees to compensate the other for certain losses or liabilities. True indicates indemnification provisions exist; False indicates no such provisions.',
    `insurance_requirement_flag` BOOLEAN COMMENT 'Indicates whether the contract requires the vendor to maintain specific insurance coverage (e.g., general liability, professional liability, cyber liability, errors and omissions). True indicates insurance requirements exist; False indicates no such requirements.',
    `liability_cap_amount` DECIMAL(18,2) COMMENT 'The maximum monetary amount for which either party can be held liable under the contract, excluding certain carve-outs such as gross negligence or willful misconduct. Nullable if no liability cap is specified.',
    `notice_period_days` STRING COMMENT 'The number of days advance notice required to terminate or not renew the contract, as specified in the termination provisions.',
    `payment_frequency` STRING COMMENT 'The recurring interval at which payments are made to the vendor under this contract.. Valid values are `One-Time|Monthly|Quarterly|Semi-Annually|Annually|Milestone-Based`',
    `payment_terms` STRING COMMENT 'The agreed-upon payment schedule and conditions, such as Net 30, Net 60, monthly in arrears, quarterly in advance, or milestone-based payments.',
    `performance_sla_included_flag` BOOLEAN COMMENT 'Indicates whether the contract includes defined Service Level Agreement (SLA) performance metrics and targets. True indicates SLA provisions exist; False indicates no formal SLA.',
    `procurement_method` STRING COMMENT 'The method by which the vendor was selected and the contract was awarded. Direct Award indicates no competitive process; Competitive Bid indicates multiple vendors competed; Request for Proposal (RFP) indicates formal proposal process; Sole Source indicates only one qualified vendor; Preferred Vendor indicates selection from pre-approved vendor list.. Valid values are `Direct Award|Competitive Bid|Request for Proposal|Sole Source|Preferred Vendor`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the contract includes provisions requiring the vendor to comply with specific insurance industry regulations such as NAIC standards, state insurance department requirements, SOX, or FINRA rules. True indicates regulatory compliance provisions exist; False indicates no such provisions.',
    `service_category` STRING COMMENT 'The high-level classification of services provided under this contract (e.g., Medical Underwriting Services, Data Services, IT Services, Third-Party Administration (TPA), Investment Custody, Reinsurance Intermediary Services, Professional Services). [ENUM-REF-CANDIDATE: Medical Underwriting Services|Data Services|IT Services|Third-Party Administration|Investment Custody|Reinsurance Intermediary|Professional Services|Consulting Services|Outsourced Administration — promote to reference product]',
    `subcontracting_allowed_flag` BOOLEAN COMMENT 'Indicates whether the vendor is permitted to subcontract any portion of the services to third parties. True indicates subcontracting is allowed (typically with approval); False indicates vendor must perform all services directly.',
    `termination_date` DATE COMMENT 'The actual date on which the contract was terminated, either by mutual agreement, for cause, or for convenience. Populated only when contract status is Terminated.',
    `termination_for_cause_flag` BOOLEAN COMMENT 'Indicates whether the contract includes provisions allowing either party to terminate for cause (material breach, failure to perform, insolvency). True indicates termination-for-cause provisions exist; False indicates no such provisions.',
    `termination_for_convenience_flag` BOOLEAN COMMENT 'Indicates whether the contract allows either party to terminate without cause, typically with advance notice. True indicates termination-for-convenience provisions exist; False indicates termination requires cause.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor contract record was last modified in the system.',
    `value_amount` DECIMAL(18,2) COMMENT 'The total monetary value of the contract over its full term, including all fees, charges, and estimated variable costs. Expressed in the currency specified in contract_value_currency.',
    `value_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the contract value amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `vendor_service_description` STRING COMMENT 'Detailed description of the specific services, deliverables, or products the vendor will provide under this contract.',
    CONSTRAINT pk_vendor_contract PRIMARY KEY(`vendor_contract_id`)
) COMMENT 'Master record for every executed contract or master service agreement (MSA) between Life Insurance and a vendor. Captures contract type (MSA, SOW, addendum, amendment), effective and expiration dates, auto-renewal terms, governing law jurisdiction, contract value, payment terms, termination-for-cause provisions, and current contract status. Tracks the full contract lifecycle from negotiation through execution, renewal, and termination. Distinct from reinsurance treaties (owned by reinsurance domain) — covers all non-reinsurance vendor agreements including TPA administration agreements, data license agreements, custodian agreements, and IT service contracts.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`contact` (
    `contact_id` BIGINT COMMENT 'Unique identifier for the vendor contact record. Primary key.',
    `vendor_id` BIGINT COMMENT 'Reference to the parent vendor organization this contact represents.',
    `reports_to_contact_id` BIGINT COMMENT 'Self-referencing FK on contact (reports_to_contact_id)',
    `alternate_email_address` STRING COMMENT 'Secondary or backup email address for the vendor contact, used when primary email is unavailable.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_status` STRING COMMENT 'Current status of the vendor contact. Active contacts are available for communication; inactive contacts are no longer with the vendor or no longer serve in their role.. Valid values are `active|inactive|on_leave|terminated`',
    `contact_type` STRING COMMENT 'Classification of the contacts role within the vendor organization. Defines the nature of the relationship and communication purpose.. Valid values are `account_manager|relationship_manager|technical_lead|compliance_officer|escalation_contact|billing_contact`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor contact record was first created in the system.',
    `department` STRING COMMENT 'Department or business unit within the vendor organization where the contact is employed (e.g., Operations, Compliance, IT, Customer Service).',
    `effective_date` DATE COMMENT 'Date when this contact became active in their role with the vendor organization.',
    `email_address` STRING COMMENT 'Primary email address for the vendor contact. Used for formal communications, contract negotiations, and incident escalations.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for the vendor contact, if applicable for formal document transmission.',
    `first_name` STRING COMMENT 'Given name of the vendor contact person.',
    `is_authorized_signer` BOOLEAN COMMENT 'Indicates whether this contact has authority to sign contracts, amendments, or other legal documents on behalf of the vendor. True if authorized, False otherwise.',
    `is_escalation_contact` BOOLEAN COMMENT 'Indicates whether this contact should be used for escalated issues or critical incidents. True if escalation contact, False otherwise.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this contact is the primary point of contact for the vendor relationship. True if primary, False otherwise.',
    `language_preference` STRING COMMENT 'Preferred language for communication with the contact, using ISO 639-2 three-letter language codes. [ENUM-REF-CANDIDATE: ENG|SPA|FRA|GER|CHI|JPN|POR — 7 candidates stripped; promote to reference product]',
    `last_contact_date` DATE COMMENT 'Date of the most recent communication or interaction with this vendor contact.',
    `last_name` STRING COMMENT 'Family name or surname of the vendor contact person.',
    `middle_name` STRING COMMENT 'Middle name or initial of the vendor contact person, if applicable.',
    `mobile_number` STRING COMMENT 'Mobile or cell phone number for the vendor contact, used for urgent communications and escalations.',
    `notes` STRING COMMENT 'Free-form text field for additional information about the contact, including special instructions, communication preferences, or relationship history.',
    `office_location` STRING COMMENT 'Physical office location or site where the contact is based (e.g., New York HQ, Dallas Regional Office).',
    `phone_number` STRING COMMENT 'Primary business phone number for the vendor contact, including country code and extension if applicable.',
    `preferred_communication_channel` STRING COMMENT 'The contacts preferred method of communication for routine business interactions.. Valid values are `email|phone|mobile|fax|portal`',
    `termination_date` DATE COMMENT 'Date when this contacts role with the vendor ended or when they were marked inactive. Null for active contacts.',
    `time_zone` STRING COMMENT 'Time zone of the contacts primary work location, used for scheduling meetings and coordinating communications (e.g., America/New_York, Europe/London).',
    `title` STRING COMMENT 'Professional job title or position of the contact within the vendor organization (e.g., Vice President of Operations, Senior Account Manager, Chief Compliance Officer).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor contact record was last modified.',
    CONSTRAINT pk_contact PRIMARY KEY(`contact_id`)
) COMMENT 'Master record for all key contacts at vendor organizations — account managers, relationship managers, technical leads, compliance officers, and escalation contacts. Captures contact name, title, role type, phone, email, preferred communication channel, and active status. Supports vendor relationship management, contract negotiation, incident escalation, and audit communication workflows. Distinct from policyholder.party_contact which manages policyholder-side contacts.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`service_order` (
    `service_order_id` BIGINT COMMENT 'Unique identifier for the service order. Primary key for the service order record.',
    `annuity_contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: Vendor services specific to individual annuity contracts (policy conversions, contract audits, compliance reviews, beneficiary research) require linking the service order to the contract being service',
    `insured_id` BIGINT COMMENT 'Foreign key linking to policyholder.insured. Business justification: Underwriting services (APS, paramedical exams, MIB checks, inspection reports) are ordered for specific insureds during new business underwriting. Underwriters must track which insured each service or',
    `party_id` BIGINT COMMENT 'Reference to the insurance applicant or insured individual for whom this service is being performed, if applicable.',
    `employee_id` BIGINT COMMENT 'User identifier of the employee who created and submitted this service order.',
    `report_definition_id` BIGINT COMMENT 'Foreign key linking to reporting.report_definition. Business justification: Service orders for medical exams, actuarial valuations, and custodian reports feed statutory filings and management reports. Annual actuarial opinion preparation and quarterly statutory filing require',
    `vendor_id` BIGINT COMMENT 'Reference to the third-party vendor or service provider fulfilling this service order.',
    `follow_up_service_order_id` BIGINT COMMENT 'Self-referencing FK on service_order (follow_up_service_order_id)',
    `acknowledged_date` DATE COMMENT 'Date when the vendor acknowledged receipt of the service order and committed to fulfillment.',
    `actual_completion_date` DATE COMMENT 'Actual date when the vendor completed the service delivery. Null until service is fulfilled. Used for SLA compliance measurement.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this service order requires management approval before being sent to the vendor, typically based on cost thresholds or service type.',
    `approval_status` STRING COMMENT 'Current approval status of the service order if approval is required.. Valid values are `not_required|pending|approved|rejected`',
    `approved_date` DATE COMMENT 'Date when the service order was approved by the authorized approver.',
    `cancellation_reason` STRING COMMENT 'Business reason for cancelling this service order, if applicable (e.g., policy withdrawn, vendor unavailable, duplicate order).',
    `claim_number` STRING COMMENT 'Claim number associated with this service order, if the service is claim-specific (e.g., medical records retrieval, autopsy report).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this service order.. Valid values are `^[A-Z]{3}$`',
    `delivery_format` STRING COMMENT 'Data format in which the vendor will deliver service results.. Valid values are `xml|json|pdf|csv|edi|proprietary`',
    `fulfillment_method` STRING COMMENT 'Method by which the vendor will deliver the service results (e.g., electronic data exchange, manual report, API integration).. Valid values are `electronic|manual|hybrid|api_integration`',
    `invoice_date` DATE COMMENT 'Date of the vendor invoice for this service order.',
    `invoice_number` STRING COMMENT 'Vendor invoice number associated with this service order, used for three-way matching (purchase order, service receipt, invoice).',
    `order_number` STRING COMMENT 'Business-facing unique identifier for the service order, typically used in vendor communications and invoice matching.',
    `order_status` STRING COMMENT 'Current lifecycle status of the service order indicating its position in the fulfillment workflow. [ENUM-REF-CANDIDATE: draft|submitted|acknowledged|in_progress|completed|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `ordered_date` DATE COMMENT 'Date when the service order was created and issued to the vendor. Primary business event timestamp for order initiation.',
    `payment_date` DATE COMMENT 'Date when payment was issued to the vendor for this service order.',
    `payment_status` STRING COMMENT 'Current payment status for this service order, tracking the accounts payable lifecycle.. Valid values are `not_invoiced|pending_payment|paid|disputed|cancelled`',
    `policy_number` STRING COMMENT 'Life insurance policy number associated with this service order, if the service is policy-specific (e.g., medical exam for underwriting, claim investigation).',
    `priority_level` STRING COMMENT 'Business priority assigned to this service order, influencing vendor service level agreement (SLA) targets and resource allocation.. Valid values are `routine|standard|expedited|urgent|critical`',
    `quality_score` DECIMAL(18,2) COMMENT 'Post-fulfillment quality rating assigned to the vendors service delivery for this order, used for vendor performance management.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of service units ordered. Interpretation depends on service type (e.g., number of exams, number of records, hours of service).',
    `requesting_department` STRING COMMENT 'Internal department or business unit that initiated this service order (e.g., Underwriting, Claims, IT, Actuarial).',
    `required_completion_date` DATE COMMENT 'Target date by which the vendor is contractually required to complete the service delivery. Used for SLA monitoring and performance tracking.',
    `service_description` STRING COMMENT 'Detailed description of the specific service or work to be performed by the vendor under this order.',
    `service_type` STRING COMMENT 'Category of service requested from the vendor. Defines the nature of work to be performed under this order.. Valid values are `medical_exam_scheduling|mib_inquiry_batch|prescription_data_pull|tpa_administration_run|it_service_delivery|reinsurance_data_exchange`',
    `sla_met_flag` BOOLEAN COMMENT 'Indicates whether the vendor met the contracted SLA turnaround time for this service order. Calculated after completion.',
    `sla_target_hours` STRING COMMENT 'Contracted service level agreement turnaround time in hours from order submission to completion.',
    `special_instructions` STRING COMMENT 'Additional instructions or requirements communicated to the vendor for this specific service order.',
    `total_estimated_cost` DECIMAL(18,2) COMMENT 'Total estimated cost for this service order, typically calculated as quantity multiplied by unit price. Used for budget tracking and invoice matching.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the service quantity (e.g., each exam, per hour, per record processed).. Valid values are `each|hour|record|batch|transaction|report`',
    `unit_price` DECIMAL(18,2) COMMENT 'Contracted price per unit of service as defined in the vendor contract or statement of work.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this service order record was last modified.',
    `vendor_reference_number` STRING COMMENT 'External reference number assigned by the vendor to track this service order in their system.',
    CONSTRAINT pk_service_order PRIMARY KEY(`service_order_id`)
) COMMENT 'Transactional record of each service request or work order issued to a vendor under an active contract or statement of work. Captures service order number, vendor reference, contract linkage, service type (medical exam scheduling, MIB inquiry batch, prescription data pull, TPA administration run, IT service delivery), ordered date, required completion date, actual completion date, quantity, unit price, total estimated cost, and fulfillment status. Serves as the operational trigger for vendor service delivery and the basis for invoice matching and payment authorization.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique identifier for the vendor invoice record. Primary key for the vendor invoice entity.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Vendor invoices must post to valid GL accounts for financial reporting, expense classification, and GAAP/SAP compliance. AP posting workflow requires chart of accounts validation. Removes denormalized',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Vendor expenses are allocated to cost centers for budgeting, departmental P&L, and management reporting. Essential for expense allocation and budget variance analysis. Removes denormalized cost_center',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Vendor invoices must be allocated to reporting periods for GAAP/statutory expense recognition and accrual accounting. Period close process requires accurate invoice-to-period assignment for financial ',
    `service_order_id` BIGINT COMMENT 'Identifier of the service order or purchase order that this invoice fulfills. Links to the service order record.',
    `vendor_contract_id` BIGINT COMMENT 'Identifier of the vendor contract under which this invoice was issued. Links to the vendor contract master record.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor who issued this invoice. Links to the vendor master record.',
    `credited_invoice_id` BIGINT COMMENT 'Self-referencing FK on invoice (credited_invoice_id)',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total adjustment amount applied to the invoice for credits, debits, or other modifications after initial issuance.',
    `approval_date` DATE COMMENT 'The date the invoice was approved for payment. Null if not yet approved.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the invoice for payment.',
    `attachment_count` STRING COMMENT 'Number of supporting documents attached to this invoice (e.g., receipts, delivery confirmations, service reports).',
    `billing_period_end_date` DATE COMMENT 'The end date of the service or billing period covered by this invoice.',
    `billing_period_start_date` DATE COMMENT 'The start date of the service or billing period covered by this invoice.',
    `business_unit_code` STRING COMMENT 'The business unit or division code to which this invoice expense is allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice record was first created in the system. Audit trail field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the invoice, including early payment discounts, volume discounts, or contractual discounts.',
    `dispute_date` DATE COMMENT 'The date the invoice was flagged as disputed. Null if invoice has never been disputed.',
    `dispute_reason` STRING COMMENT 'Reason for disputing the invoice if status is disputed. Describes the nature of the disagreement with the vendor.',
    `due_date` DATE COMMENT 'The date by which payment is due to the vendor according to the payment terms.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert foreign currency invoice amounts to the companys functional currency. Null for domestic currency invoices.',
    `gl_posting_date` DATE COMMENT 'The date this invoice was posted to the general ledger. May differ from invoice date due to processing timing.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total gross amount of the invoice before any adjustments, taxes, or discounts. Represents the base charge for services or goods.',
    `internal_reference_number` STRING COMMENT 'Internal company reference number assigned to this invoice for tracking and reconciliation purposes.',
    `invoice_date` DATE COMMENT 'The date the invoice was issued by the vendor. This is the principal business event timestamp for the invoice transaction.',
    `invoice_number` STRING COMMENT 'The unique invoice number assigned by the vendor. This is the vendors external reference for the invoice.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the accounts payable workflow. Tracks the invoice from receipt through payment or dispute resolution. [ENUM-REF-CANDIDATE: received|under_review|approved|disputed|paid|voided|cancelled — 7 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice by its business purpose and accounting treatment.. Valid values are `standard|credit_memo|debit_memo|prepayment|recurring|one_time`',
    `line_item_count` STRING COMMENT 'Total number of line items on this invoice. Indicates the level of detail in the invoice.',
    `net_payable_amount` DECIMAL(18,2) COMMENT 'Final net amount payable to the vendor after all discounts, taxes, and adjustments. This is the amount that will be paid.',
    `notes` STRING COMMENT 'Free-form notes or comments about the invoice, including special instructions, processing notes, or resolution details.',
    `payment_date` DATE COMMENT 'The date payment was made to the vendor. Null if not yet paid.',
    `payment_method` STRING COMMENT 'Method by which payment will be or was made to the vendor for this invoice.. Valid values are `ach|wire|check|eft|credit_card`',
    `payment_reference_number` STRING COMMENT 'Reference number of the payment transaction (e.g., check number, wire confirmation number, ACH trace number).',
    `payment_terms` STRING COMMENT 'Payment terms specified on the invoice (e.g., Net 30, Net 60, 2/10 Net 30). Defines when payment is due and any early payment discounts available.',
    `received_by` STRING COMMENT 'Name or identifier of the person or system that received and logged the invoice.',
    `received_date` DATE COMMENT 'The date the invoice was received by the company. Used to track processing time and aging.',
    `service_category` STRING COMMENT 'High-level category of services or goods provided on this invoice (e.g., medical exams, IT services, reinsurance, investment custody, third-party administration).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount charged on the invoice, including sales tax, VAT, GST, or other applicable taxes.',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match process comparing invoice to purchase order and receiving document. Critical control for SOX compliance.. Valid values are `matched|unmatched|partial_match|not_applicable`',
    `updated_by` STRING COMMENT 'Identifier of the user or system that last updated this invoice record. Audit trail field.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice record was last updated. Audit trail field for tracking changes.',
    `vendor_reference_number` STRING COMMENT 'Additional reference number provided by the vendor for tracking or reconciliation purposes (e.g., vendors internal order number, project code).',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Transactional record of every invoice received from a vendor for services rendered or goods delivered. Captures invoice number, vendor reference, contract and service order linkage, invoice date, due date, billing period, line-item detail, gross amount, tax amount, net payable amount, currency, payment terms, and invoice status (received, under review, approved, disputed, paid, voided). Serves as the SSOT for vendor accounts payable obligations within the vendor domain. Distinct from finance.journal_entry which records the GL posting downstream.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'Unique identifier for the invoice line item. Primary key for the invoice line detail record.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Each invoice line item posts to specific GL account for detailed expense classification required by GAAP/SAP reporting and financial statement preparation. Line-level GL mapping supports audit trail a',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Line-level cost center allocation enables granular expense tracking for activity-based costing, budget variance analysis, and departmental performance measurement. Essential for management accounting ',
    `employee_id` BIGINT COMMENT 'Reference to the employee or system user who approved this invoice line for payment. Supports audit trail and segregation of duties requirements.',
    `invoice_id` BIGINT COMMENT 'Reference to the parent vendor invoice header that contains this line item. Links line-level detail to the invoice document for three-way matching and reconciliation.',
    `service_order_id` BIGINT COMMENT 'Reference to the originating service order or purchase order that authorized this service or deliverable. Critical for three-way matching (PO → receipt → invoice).',
    `application_id` BIGINT COMMENT 'Reference to the underwriting case for which this service was performed (e.g., medical exam, APS, MIB report). Links vendor charges to new business underwriting activity.',
    `credited_invoice_line_id` BIGINT COMMENT 'Self-referencing FK on invoice_line (credited_invoice_line_id)',
    `approval_date` DATE COMMENT 'The date on which this invoice line was approved for payment. Used for audit trail and payment processing workflow tracking.',
    `approval_status` STRING COMMENT 'Current approval status of this invoice line for payment. Lines must be approved before the invoice can be paid. Rejected lines require vendor correction or dispute resolution.. Valid values are `pending|approved|rejected|on_hold`',
    `claim_number` STRING COMMENT 'The claim number to which this service relates, if applicable. Used when vendor services support claims adjudication (e.g., medical records retrieval, investigative services).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this invoice line record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the amounts on this line (e.g., USD, CAD, EUR). Supports multi-currency vendor invoicing and foreign exchange reconciliation.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The total discount applied to this line, reflecting volume discounts, early payment discounts, or contractual pricing adjustments. Reduces the line amount.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this invoice line is currently under dispute. Disputed lines are held from payment pending resolution with the vendor.',
    `dispute_reason` STRING COMMENT 'Detailed explanation of why this invoice line is disputed. Provides context for vendor communication and dispute resolution tracking.',
    `line_amount` DECIMAL(18,2) COMMENT 'The gross extended amount for this line before tax and discounts. Typically calculated as quantity × unit price, but may reflect negotiated pricing or contract rates.',
    `line_number` STRING COMMENT 'Sequential line number within the invoice, establishing the ordering and position of this line item in the invoice document.',
    `match_status` STRING COMMENT 'Indicates whether this invoice line has been successfully matched to a service order and receipt in the three-way matching process. Exceptions require manual review before payment approval.. Valid values are `matched|unmatched|partial_match|exception|disputed`',
    `net_line_amount` DECIMAL(18,2) COMMENT 'The final net amount for this line after applying discounts and adding taxes. This is the amount that contributes to the invoice total and is used for payment and cost allocation.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, special instructions, or contextual information about this invoice line. Supports operational communication and audit documentation.',
    `payment_date` DATE COMMENT 'The date on which payment was issued for this invoice line. Used for cash flow analysis and vendor payment performance tracking.',
    `payment_status` STRING COMMENT 'Indicates whether this invoice line has been paid. Tracks payment lifecycle at the line level for partial payment scenarios and payment reconciliation.. Valid values are `unpaid|paid|partially_paid|voided`',
    `policy_number` STRING COMMENT 'The life insurance or annuity policy number to which this service relates, if applicable. Enables direct cost allocation to specific policies for underwriting, claims, or servicing expenses.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of units or volume of service delivered on this line. Used with unit price to calculate line amount. May represent count of exams, hours of service, number of reports, or other measurable units.',
    `receipt_number` BIGINT COMMENT 'Reference to the goods or services receipt record that confirms delivery and acceptance of this line item. Critical for three-way matching (PO → receipt → invoice) and payment authorization.',
    `service_category` STRING COMMENT 'High-level classification of the service type for cost allocation and spend analysis. Aligns with vendor service taxonomy and enables aggregation by service family. [ENUM-REF-CANDIDATE: medical_exam|mib_report|prescription_check|credit_report|reinsurance_premium|investment_custody|it_services|tpa_administration|actuarial_consulting|legal_services|audit_services|other — 12 candidates stripped; promote to reference product]',
    `service_code` STRING COMMENT 'Vendor-specific or industry-standard code identifying the type of service or deliverable billed on this line (e.g., medical exam type code, MIB report code, reinsurance treaty code, IT service catalog code).',
    `service_completion_date` DATE COMMENT 'The date on which the vendor completed delivery of the service or deliverable. May differ from service date for multi-day or ongoing services.',
    `service_date` DATE COMMENT 'The date on which the service was performed or the deliverable was provided by the vendor. Used for accrual accounting and service-level agreement (SLA) tracking.',
    `service_description` STRING COMMENT 'Detailed textual description of the service, deliverable, or product provided by the vendor on this invoice line. Provides human-readable context for the billed item.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax charged on this line (sales tax, VAT, GST, or other applicable taxes). Added to the net line amount to derive the total line charge.',
    `tax_jurisdiction` STRING COMMENT 'The tax jurisdiction (state, province, country) that applies to this line item for tax calculation and remittance. Supports multi-jurisdictional tax compliance.',
    `tax_rate` DECIMAL(18,2) COMMENT 'The tax rate applied to this line item, expressed as a decimal (e.g., 0.0825 for 8.25%). Used for tax calculation validation and audit.',
    `unit_of_measure` STRING COMMENT 'The unit in which the quantity is measured (e.g., each, hour, report, exam). Provides context for interpreting the quantity field and ensures accurate cost per unit analysis. [ENUM-REF-CANDIDATE: each|hour|day|report|exam|policy|contract|transaction|month|year — 10 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'The price per unit of measure for the service or deliverable. Multiplied by quantity to derive the gross line amount before adjustments.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this invoice line record was last modified. Supports change tracking and audit trail requirements.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between the invoiced amount and the expected amount based on the service order or contract rate. Positive values indicate overbilling; negative values indicate underbilling.',
    `variance_reason_code` STRING COMMENT 'Standardized code explaining the reason for any variance between invoiced and expected amounts. Supports root cause analysis and vendor performance management.. Valid values are `price_difference|quantity_difference|unauthorized_service|billing_error|contract_rate_change|approved_exception`',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Individual line-item detail within a vendor invoice, capturing the granular breakdown of charges billed by a vendor. Each line captures service description, service code, quantity, unit of measure, unit price, line amount, applicable tax, discount, and the specific service order or deliverable it relates to. Enables precise three-way matching (service order → receipt → invoice line) and supports cost allocation to policy, underwriting case, or cost center.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` (
    `vendor_payment_id` BIGINT COMMENT 'Unique identifier for the vendor payment transaction. Primary key for the vendor payment record.',
    `invoice_id` BIGINT COMMENT 'Reference to the primary invoice being settled by this payment. Links to the vendor invoice record.',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this payment for processing. Links to the user or employee record. Nullable if payment does not require approval.',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Payments must be recorded in correct reporting periods for cash flow statements and statutory cash basis reporting. Quarterly/annual close requires accurate payment timing for GAAP cash flow statement',
    `vendor_bank_account_id` BIGINT COMMENT 'Reference to the vendors bank account that received the payment. Links to the vendor bank account record.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor receiving this payment. Links to the vendor master record.',
    `reversal_vendor_payment_id` BIGINT COMMENT 'Self-referencing FK on vendor_payment (reversal_vendor_payment_id)',
    `accounting_period` STRING COMMENT 'The financial accounting period (e.g., 2024-01, Q1-2024) to which this payment is attributed for financial reporting purposes.',
    `amount` DECIMAL(18,2) COMMENT 'The gross monetary value of the payment disbursed to the vendor in the payment currency. Represents the total amount transferred.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the payment was approved for processing. Nullable if payment does not require approval or has not yet been approved.',
    `batch_number` BIGINT COMMENT 'Reference to the payment batch if this payment was processed as part of a batch run. Nullable for individual payments. Links to payment batch record.',
    `check_number` STRING COMMENT 'The physical check number if payment method is check. Nullable for electronic payment methods.',
    `cleared_date` DATE COMMENT 'The date on which the payment cleared the banking system and funds were confirmed as received by the vendor. Nullable if payment has not yet cleared.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payment record was first created in the system. Represents the initial capture of the payment transaction.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the payment was made (e.g., USD, EUR, GBP, CAD).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The monetary value of any early payment discount taken on this payment. Reduces the gross invoice amount. Nullable if no discount was applied.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied if the payment currency differs from the companys functional currency. Nullable if no currency conversion was required.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The payment amount converted to the companys functional currency (typically USD for US-based insurers) using the applicable exchange rate. Used for consolidated financial reporting.',
    `gl_posting_date` DATE COMMENT 'The accounting date on which this payment transaction was posted to the General Ledger. May differ from payment date due to period-end processing.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The final net amount disbursed to the vendor after applying discounts, withholdings, and adjustments. This is the actual cash outflow amount.',
    `notes` STRING COMMENT 'Free-form notes or comments related to the payment transaction. May include special instructions, exceptions, or additional context.',
    `payment_date` DATE COMMENT 'The date on which the payment was issued or scheduled to be disbursed to the vendor. Represents the business event date for accounting purposes.',
    `payment_method` STRING COMMENT 'The financial instrument or mechanism used to disburse funds to the vendor (e.g., Automated Clearing House (ACH), wire transfer, physical check, Electronic Funds Transfer (EFT), virtual card).. Valid values are `ach|wire|check|eft|virtual_card|other`',
    `payment_number` STRING COMMENT 'Business-facing unique payment reference number used for tracking and reconciliation. Typically system-generated or follows a defined numbering scheme.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment transaction. Tracks the payment from scheduling through final settlement or failure. [ENUM-REF-CANDIDATE: scheduled|pending_approval|approved|processing|transmitted|cleared|reconciled|returned|cancelled|failed — 10 candidates stripped; promote to reference product]',
    `payment_type` STRING COMMENT 'Classification of the payment based on business purpose or processing priority (e.g., standard payment, expedited payment, recurring payment, advance payment, final settlement, partial payment).. Valid values are `standard|expedited|recurring|advance|final|partial`',
    `processed_timestamp` TIMESTAMP COMMENT 'The date and time when the payment was processed and transmitted to the bank or payment processor.',
    `purpose` STRING COMMENT 'Business description or purpose of the payment (e.g., Medical exam services - January 2024, Reinsurance premium - Treaty ABC, IT consulting services). Provides context for the disbursement.',
    `reconciled_date` DATE COMMENT 'The date on which this payment was reconciled with bank statements. Nullable if payment has not yet been reconciled.',
    `reconciled_flag` BOOLEAN COMMENT 'Indicates whether this payment has been reconciled with bank statements and vendor records. True if reconciled, False if not yet reconciled.',
    `remittance_advice_number` STRING COMMENT 'Reference number for the remittance advice document sent to the vendor detailing which invoices are being paid. Used for vendor reconciliation.',
    `return_date` DATE COMMENT 'The date on which the payment was returned by the bank or payment processor. Nullable if payment was not returned.',
    `return_reason_code` STRING COMMENT 'Standardized code indicating why a payment was returned by the bank or payment processor (e.g., insufficient funds, invalid account, stop payment). Nullable if payment was not returned.',
    `scheduled_payment_date` DATE COMMENT 'The originally planned or scheduled date for payment disbursement. May differ from actual payment date if processing delays or changes occur.',
    `transaction_reference_number` STRING COMMENT 'Bank or payment processor transaction reference number for electronic payments (e.g., ACH trace number, wire confirmation number). Used for payment tracking and reconciliation.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this payment record was last modified. Tracks the most recent change to any field in the record.',
    `void_date` DATE COMMENT 'The date on which the payment was voided. Nullable if payment is not voided.',
    `void_flag` BOOLEAN COMMENT 'Indicates whether this payment has been voided. True if voided, False if active. Voided payments are retained for audit trail but are not financially active.',
    `void_reason` STRING COMMENT 'Explanation for why the payment was voided (e.g., Duplicate payment, Incorrect amount, Vendor request). Nullable if payment is not voided.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of tax withheld from the payment as required by tax regulations (e.g., for foreign vendors or specific service types). Nullable if no withholding applies.',
    CONSTRAINT pk_vendor_payment PRIMARY KEY(`vendor_payment_id`)
) COMMENT 'Transactional record of each payment disbursement made to a vendor in settlement of an approved invoice. Captures payment date, payment method (ACH, wire, check), bank account reference, payment amount, currency, exchange rate if applicable, invoice(s) settled, remittance advice reference, and payment status (scheduled, processed, cleared, returned). Provides the SSOT for vendor cash outflow within the vendor domain, feeding downstream to finance.journal_entry for GL posting.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` (
    `sla_agreement_id` BIGINT COMMENT 'Unique identifier for the service level agreement record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Management approves SLA agreements before vendor contract execution. Tracks approver for contract authority validation, negotiation accountability, and vendor management governance compliance.',
    `contact_id` BIGINT COMMENT 'Identifier of the primary vendor contact responsible for this SLA. Links to vendor contact record.',
    `vendor_contract_id` BIGINT COMMENT 'Identifier of the vendor contract under which this SLA is defined. Links to the contract master record.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor or service provider to whom this SLA applies. Links to the vendor master record.',
    `superseded_sla_agreement_id` BIGINT COMMENT 'Self-referencing FK on sla_agreement (superseded_sla_agreement_id)',
    `amendment_date` DATE COMMENT 'Date of the most recent amendment to this SLA agreement. Null if never amended.',
    `amendment_number` STRING COMMENT 'Sequential number indicating how many times this SLA has been amended since original execution (0 for original, 1 for first amendment, etc.).',
    `approval_date` DATE COMMENT 'Date when this SLA agreement was formally approved by authorized signatories from both parties.',
    `business_owner` STRING COMMENT 'Name or identifier of the internal business unit or individual responsible for monitoring this SLA and managing vendor performance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA agreement record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when this SLA agreement becomes active and performance measurement begins.',
    `escalation_threshold` DECIMAL(18,2) COMMENT 'Performance level that triggers escalation to senior management or contract review (e.g., if accuracy falls below 90%, escalate to VP level).',
    `exclusions` STRING COMMENT 'Circumstances or conditions under which SLA measurements are excluded or suspended (e.g., Force majeure events, Scheduled maintenance windows, Client-caused delays).',
    `expiration_date` DATE COMMENT 'Date when this SLA agreement expires or is superseded. Null if the SLA remains in effect for the duration of the contract.',
    `grace_period_days` STRING COMMENT 'Number of days allowed for the vendor to cure an SLA breach before penalties are applied.',
    `measurement_frequency` STRING COMMENT 'How often the SLA metric is measured and reported (e.g., real-time monitoring, daily aggregation, monthly reporting, per-transaction basis). [ENUM-REF-CANDIDATE: real_time|daily|weekly|monthly|quarterly|annually|per_transaction — 7 candidates stripped; promote to reference product]',
    `measurement_methodology` STRING COMMENT 'Detailed description of how the metric is calculated, what data sources are used, and any exclusions or special conditions (e.g., Measured from exam order submission timestamp to report delivery timestamp, excluding weekends and holidays).',
    `metric_description` STRING COMMENT 'Detailed description of what the metric measures and how it is defined in business terms.',
    `metric_name` STRING COMMENT 'Specific name of the performance metric being tracked (e.g., Exam Report Delivery Time, MIB Response Latency, Prescription Data Accuracy, System Uptime Percentage).',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal SLA review meeting or assessment.',
    `notes` STRING COMMENT 'Free-form notes or comments about this SLA, including special conditions, historical context, or operational guidance.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Fixed or maximum penalty amount in USD that may be assessed for SLA breach, if applicable.',
    `penalty_structure` STRING COMMENT 'Description of financial or contractual penalties applied when the vendor fails to meet the SLA target (e.g., Service credit of 5% of monthly fee for each percentage point below 95% accuracy, Liquidated damages of $500 per day for each day beyond 48-hour turnaround).',
    `penalty_type` STRING COMMENT 'Type of penalty mechanism defined in the contract (e.g., service credit applied to invoice, liquidated damages payment, fee reduction, right to terminate contract, or no penalty).. Valid values are `service_credit|liquidated_damages|fee_reduction|termination_right|none`',
    `reporting_period` STRING COMMENT 'The period over which SLA performance is aggregated and reported to stakeholders.. Valid values are `daily|weekly|monthly|quarterly|annually`',
    `review_frequency` STRING COMMENT 'How often the SLA terms and performance are formally reviewed by both parties (e.g., quarterly business review, annual contract review).. Valid values are `monthly|quarterly|semi_annually|annually`',
    `service_category` STRING COMMENT 'High-level category of service covered by this SLA (e.g., medical exam services from ExamOne/APPS, MIB inquiries, prescription database queries, reinsurance intermediary services, TPA administration, IT service provider support).. Valid values are `medical_exam|mib_inquiry|prescription_data|reinsurance|tpa_administration|it_services`',
    `sla_agreement_status` STRING COMMENT 'Current lifecycle status of the SLA agreement (active and being measured, suspended temporarily, expired past end date, terminated early, draft not yet effective, under review for modification).. Valid values are `active|suspended|expired|terminated|draft|under_review`',
    `sla_name` STRING COMMENT 'Business-friendly name or title of the SLA (e.g., Medical Exam Turnaround Time SLA, MIB Response Time SLA).',
    `sla_type` STRING COMMENT 'Category of SLA metric being measured (e.g., turnaround time for medical exams, availability for IT services, accuracy rate for data providers, error rate for processing, response time for queries, uptime for systems). [ENUM-REF-CANDIDATE: turnaround_time|availability|accuracy_rate|error_rate|response_time|uptime|processing_time — 7 candidates stripped; promote to reference product]',
    `target_operator` STRING COMMENT 'Comparison operator defining how actual performance is evaluated against the target (e.g., less_than for turnaround time, greater_than_or_equal for uptime percentage).. Valid values are `less_than|less_than_or_equal|greater_than|greater_than_or_equal|equal`',
    `target_unit` STRING COMMENT 'Unit of measure for the target value (e.g., hours, days, percentage, count, minutes, seconds).. Valid values are `hours|days|percentage|count|minutes|seconds`',
    `target_value` DECIMAL(18,2) COMMENT 'The target threshold or goal value that the vendor must meet or exceed (e.g., 95.0 for 95% accuracy, 24.0 for 24 hours turnaround).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA agreement record was last modified in the system.',
    CONSTRAINT pk_sla_agreement PRIMARY KEY(`sla_agreement_id`)
) COMMENT 'Master record defining the service level agreement (SLA) terms negotiated with a vendor under a specific contract. Captures SLA type (turnaround time, availability, accuracy rate, error rate), metric name, target threshold, measurement frequency, measurement methodology, penalty structure for breach, and effective date range. Covers SLAs for medical exam turnaround (ExamOne/APPS), MIB response time, prescription data delivery latency, TPA processing accuracy, and IT service uptime. Enables ongoing SLA monitoring and vendor performance management.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` (
    `sla_measurement_id` BIGINT COMMENT 'Unique identifier for each SLA measurement record. Primary key for the SLA measurement entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Operations staff measure vendor SLA compliance for service quality monitoring. Tracks who performed measurement for accountability and to validate measurement authority in vendor management processes.',
    `report_definition_id` BIGINT COMMENT 'Foreign key linking to reporting.report_definition. Business justification: SLA measurements feed management reports on third-party operational risk and regulatory operational risk disclosures. Quarterly board reporting and annual Own Risk Solvency Assessment (ORSA) require v',
    `sla_agreement_id` BIGINT COMMENT 'Reference to the parent SLA agreement under which this measurement was taken. Links to the master SLA agreement defining targets, metrics, and contractual obligations.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or third-party service provider whose performance is being measured. Links to the vendor master record.',
    `corrected_sla_measurement_id` BIGINT COMMENT 'Self-referencing FK on sla_measurement (corrected_sla_measurement_id)',
    `actual_value` DECIMAL(18,2) COMMENT 'The actual measured value achieved by the vendor during the measurement period. Represents the real performance outcome against which the target is compared.',
    `breach_count` STRING COMMENT 'The number of individual breach incidents or occurrences within the measurement period. Used for tracking cumulative breach patterns and penalty calculations.',
    `breach_severity` STRING COMMENT 'The severity classification of the SLA breach, if one occurred. Determines the level of escalation, remediation, and potential penalties. None indicates no breach occurred.. Valid values are `critical|major|minor|none`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this SLA measurement record was first created in the system. Audit trail for record creation.',
    `data_source` STRING COMMENT 'The system, report, or data repository from which the measurement data was extracted. Provides audit trail and data lineage for regulatory compliance.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator of whether the vendor has disputed the SLA measurement results or breach determination. Triggers dispute resolution process.',
    `dispute_reason` STRING COMMENT 'Vendor-provided explanation or justification for disputing the SLA measurement. Documents the vendor perspective for resolution discussions.',
    `dispute_resolution_date` DATE COMMENT 'The date on which the SLA measurement dispute was formally resolved. Closes the dispute lifecycle and finalizes the measurement record.',
    `is_breach` BOOLEAN COMMENT 'Boolean flag indicating whether the actual performance failed to meet the contractual SLA target, constituting a breach of the service level agreement.',
    `measurement_method` STRING COMMENT 'The methodology or approach used to capture and calculate the SLA metric. Indicates the reliability and auditability of the measurement.. Valid values are `automated_system|manual_review|vendor_reported|third_party_audit|sampling|census`',
    `measurement_period_end_date` DATE COMMENT 'The ending date of the period during which SLA performance was measured. Defines the end boundary of the measurement window.',
    `measurement_period_start_date` DATE COMMENT 'The beginning date of the period during which SLA performance was measured. Defines the start boundary of the measurement window.',
    `measurement_timestamp` TIMESTAMP COMMENT 'The precise date and time when the SLA measurement was captured or calculated. Represents the business event time of the measurement.',
    `metric_category` STRING COMMENT 'The high-level category or classification of the SLA metric being measured. Groups metrics into logical families for reporting and analysis. [ENUM-REF-CANDIDATE: availability|performance|quality|timeliness|accuracy|compliance|security|capacity — 8 candidates stripped; promote to reference product]',
    `metric_name` STRING COMMENT 'The name or identifier of the specific SLA metric being measured (e.g., response time, turnaround time, accuracy rate, uptime percentage). Describes what aspect of service performance is being evaluated.',
    `notes` STRING COMMENT 'Free-form text field for additional context, observations, or special circumstances related to the SLA measurement. Captures qualitative information not covered by structured fields.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The monetary penalty or service credit amount assessed against the vendor for the SLA breach, as defined in the contract. Used for financial reconciliation and vendor invoicing adjustments.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount (e.g., USD, EUR, GBP). Ensures proper financial reporting and currency conversion.. Valid values are `^[A-Z]{3}$`',
    `regulatory_reportable` BOOLEAN COMMENT 'Boolean flag indicating whether this SLA measurement must be included in regulatory reporting to state Departments of Insurance (DOI) for outsourced functions oversight.',
    `remediation_action` STRING COMMENT 'Description of the corrective or remediation actions taken or planned in response to the SLA breach or underperformance. Documents the vendor and company response.',
    `remediation_due_date` DATE COMMENT 'The target date by which remediation actions must be completed. Used for tracking vendor accountability and follow-up.',
    `remediation_status` STRING COMMENT 'Current status of the remediation action plan. Tracks progress toward resolution of the SLA breach or performance issue.. Valid values are `not_required|planned|in_progress|completed|overdue|cancelled`',
    `reporting_period` STRING COMMENT 'The business reporting period to which this measurement belongs (e.g., 2024-Q1, January 2024, FY2024). Used for aggregating measurements into management and regulatory reports.',
    `review_date` DATE COMMENT 'The date on which the SLA measurement was formally reviewed and approved. Documents the validation timeline for audit purposes.',
    `reviewed_by` STRING COMMENT 'The name or identifier of the person or team that reviewed and validated the SLA measurement. Provides quality assurance and oversight.',
    `root_cause_category` STRING COMMENT 'The high-level category identifying the underlying cause of the SLA breach or underperformance. Used for trend analysis and corrective action planning. [ENUM-REF-CANDIDATE: vendor_capacity|vendor_process|vendor_staffing|technology_failure|third_party_dependency|force_majeure|client_caused|data_quality|other — 9 candidates stripped; promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed narrative explanation of the root cause analysis findings. Provides context and specifics about why the SLA target was not met.',
    `sample_size` STRING COMMENT 'The number of transactions, cases, or data points included in the SLA measurement sample. Provides statistical context for the measurement validity.',
    `sla_measurement_status` STRING COMMENT 'Current lifecycle status of the SLA measurement record. Tracks the measurement through validation, review, dispute, and finalization stages.. Valid values are `draft|final|disputed|resolved|archived`',
    `target_value` DECIMAL(18,2) COMMENT 'The contractually agreed target or threshold value that the vendor is expected to meet or exceed. Defines the performance standard from the SLA agreement.',
    `unit_of_measure` STRING COMMENT 'The unit in which the metric is expressed (e.g., percentage, hours, days, count, seconds, transactions). Provides context for interpreting actual and target values.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this SLA measurement record was last modified. Audit trail for record changes and data lineage.',
    `variance` DECIMAL(18,2) COMMENT 'The calculated difference between the actual value and the target value. Positive variance indicates performance exceeding target; negative variance indicates underperformance.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance expressed as a percentage of the target value. Provides a normalized view of performance deviation for comparison across different metrics.',
    `vendor_acknowledgement_date` DATE COMMENT 'The date on which the vendor formally acknowledged receipt and acceptance of the SLA measurement results. Establishes mutual agreement on performance assessment.',
    CONSTRAINT pk_sla_measurement PRIMARY KEY(`sla_measurement_id`)
) COMMENT 'Transactional record of each periodic SLA performance measurement taken against a defined SLA agreement. Captures measurement period, actual metric value achieved, target threshold, variance, breach indicator, breach severity, root cause category, and remediation action taken. Provides the operational evidence base for vendor performance reviews, penalty calculations, and contract renewal decisions. Supports regulatory audit trails for outsourced functions subject to DOI oversight.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` (
    `vendor_performance_review_id` BIGINT COMMENT 'Unique identifier for the vendor performance review record. Primary key for the vendor performance review entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the performance review. Links to the employee master record for the manager or executive who authorized the review outcome.',
    `market_conduct_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.market_conduct_exam. Business justification: Vendor performance issues (especially TPAs, claims vendors) may be identified during market conduct exams as exam findings. Links vendor performance review to exam when vendor deficiencies are cited i',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Performance reviews are conducted on reporting period schedules for vendor governance reporting. Annual/quarterly board and risk committee reporting requires performance reviews aligned with fiscal pe',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the employee who conducted the performance review. Links to the employee master record for the primary reviewer responsible for this evaluation.',
    `vendor_contract_id` BIGINT COMMENT 'Identifier of the vendor contract under which this performance review is conducted. Links to the contract master record governing the vendor relationship.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor being reviewed. Links to the vendor master record for the third-party service provider or supplier subject to this performance evaluation.',
    `prior_period_vendor_performance_review_id` BIGINT COMMENT 'Self-referencing FK on vendor_performance_review (prior_period_vendor_performance_review_id)',
    `action_item_due_date` DATE COMMENT 'Target completion date for improvement action items. Defines the deadline by which the vendor must complete remediation activities.',
    `approval_date` DATE COMMENT 'Date when the performance review was formally approved by management. Represents the date the review outcome was authorized and became official.',
    `comments` STRING COMMENT 'Additional comments, notes, or observations from the reviewer. Provides supplementary context and qualitative insights not captured in structured fields.',
    `compliance_score` DECIMAL(18,2) COMMENT 'Performance score for compliance dimension. Evaluates vendor adherence to regulatory requirements, contractual obligations, data security standards, and industry regulations applicable to insurance operations.',
    `cost_effectiveness_score` DECIMAL(18,2) COMMENT 'Performance score for cost effectiveness dimension. Evaluates value delivered relative to cost, pricing competitiveness, and budget adherence.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor performance review record was first created in the system. Supports audit trail and data lineage tracking.',
    `critical_incident_count` STRING COMMENT 'Number of critical or high-severity incidents attributed to the vendor during the review period. Quantifies major service failures or compliance breaches.',
    `escalation_required` BOOLEAN COMMENT 'Indicates whether the review findings require escalation to senior management or board-level oversight. True if performance issues are severe enough to warrant executive attention.',
    `improvement_action_items` STRING COMMENT 'List of specific action items and corrective measures required from the vendor. Documents remediation steps, process improvements, and performance enhancement initiatives.',
    `incident_count` STRING COMMENT 'Total number of incidents, issues, or service disruptions attributed to the vendor during the review period. Quantifies operational problems requiring resolution.',
    `innovation_score` DECIMAL(18,2) COMMENT 'Performance score for innovation dimension. Evaluates vendor contribution to process improvements, technology enhancements, and strategic value-add initiatives.',
    `is_regulatory_reportable` BOOLEAN COMMENT 'Indicates whether this performance review must be reported to regulatory authorities. True if the review contains findings or outcomes requiring disclosure to state insurance departments or other governing bodies.',
    `key_findings` STRING COMMENT 'Summary of key findings from the performance review. Captures notable strengths, weaknesses, trends, and observations identified during the evaluation period.',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next performance review. Defines when the subsequent evaluation of vendor performance is required.',
    `overall_performance_rating` STRING COMMENT 'Aggregate performance rating assigned to the vendor for the review period. Summarizes the vendors overall performance across all evaluation dimensions.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|unacceptable`',
    `overall_performance_score` DECIMAL(18,2) COMMENT 'Numeric overall performance score assigned to the vendor. Typically on a scale of 0-100 or 0-5, representing the weighted aggregate of individual dimension scores.',
    `quality_score` DECIMAL(18,2) COMMENT 'Performance score for quality dimension. Evaluates accuracy, completeness, and reliability of vendor deliverables and services.',
    `regulatory_findings_count` STRING COMMENT 'Number of regulatory compliance findings or violations identified during the review period. Quantifies vendor non-compliance with insurance industry regulations and standards.',
    `responsiveness_score` DECIMAL(18,2) COMMENT 'Performance score for responsiveness dimension. Evaluates vendor communication effectiveness, issue resolution speed, and escalation handling.',
    `review_date` DATE COMMENT 'Date when the performance review was conducted or completed. Represents the business event date when the evaluation was finalized.',
    `review_number` STRING COMMENT 'Business identifier for the performance review. Externally-known reference number used in vendor communications, audit trails, and regulatory documentation.',
    `review_outcome` STRING COMMENT 'Outcome decision resulting from the performance review. Indicates the strategic action to be taken regarding the vendor relationship based on performance evaluation results.. Valid values are `continue|continue_with_monitoring|remediation_required|escalate|contract_review|terminate`',
    `review_period_end_date` DATE COMMENT 'End date of the performance evaluation period. Defines the conclusion of the time window during which vendor performance is being assessed.',
    `review_period_start_date` DATE COMMENT 'Start date of the performance evaluation period. Defines the beginning of the time window during which vendor performance is being assessed.',
    `review_status` STRING COMMENT 'Current lifecycle status of the performance review. Tracks the review workflow from initiation through completion and approval.. Valid values are `draft|in_progress|pending_approval|approved|completed|cancelled`',
    `review_type` STRING COMMENT 'Classification of the performance review based on frequency and trigger. Indicates whether this is a scheduled periodic review or an event-driven evaluation.. Valid values are `annual|semi_annual|quarterly|ad_hoc|incident_driven|contract_renewal`',
    `reviewer_department` STRING COMMENT 'Department or business unit of the reviewer. Identifies the organizational area responsible for conducting the vendor performance evaluation.',
    `reviewer_name` STRING COMMENT 'Full name of the employee who conducted the performance review. Provides human-readable identification of the reviewer for audit and accountability purposes.',
    `risk_management_score` DECIMAL(18,2) COMMENT 'Performance score for risk management dimension. Evaluates vendor controls, business continuity planning, disaster recovery capabilities, and risk mitigation effectiveness.',
    `sla_compliance_percentage` DECIMAL(18,2) COMMENT 'Percentage of Service Level Agreement (SLA) commitments met by the vendor during the review period. Quantifies vendor adherence to contractual performance targets.',
    `strengths_identified` STRING COMMENT 'Specific strengths and positive performance areas identified during the review. Documents vendor capabilities and performance aspects that exceeded expectations.',
    `timeliness_score` DECIMAL(18,2) COMMENT 'Performance score for timeliness dimension. Evaluates vendor adherence to Service Level Agreements (SLA), delivery schedules, and response time commitments.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor performance review record was last modified. Supports audit trail and change tracking for regulatory compliance and data governance.',
    `weaknesses_identified` STRING COMMENT 'Specific weaknesses and performance deficiencies identified during the review. Documents areas requiring improvement or remediation.',
    CONSTRAINT pk_vendor_performance_review PRIMARY KEY(`vendor_performance_review_id`)
) COMMENT 'Master and transactional record of formal periodic vendor performance evaluations conducted by Life Insurance. Captures review period, overall performance rating, individual dimension scores (quality, timeliness, compliance, responsiveness, cost), reviewer identity, key findings, improvement action items, and review outcome (continue, remediate, escalate, terminate). Supports annual vendor scorecarding, strategic sourcing decisions, and regulatory documentation of third-party oversight for outsourced insurance functions.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` (
    `vendor_risk_assessment_id` BIGINT COMMENT 'Unique identifier for the vendor risk assessment record. Primary key for the vendor risk assessment entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Risk management staff conduct vendor risk assessments per enterprise risk management framework. Links assessment to qualified assessor for accountability, expertise validation, and regulatory audit re',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Vendor risk assessments must evaluate compliance with regulatory obligations (HIPAA for BAAs, state insurance regulations for TPAs, SOX for financial system vendors). Tracks primary regulatory obligat',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Risk assessments are performed on reporting period schedules for SOX certification and operational risk reporting. Annual SOX assessment and quarterly risk committee reporting require assessments alig',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor being assessed. Links to the master vendor record in the vendor management system.',
    `prior_vendor_risk_assessment_id` BIGINT COMMENT 'Self-referencing FK on vendor_risk_assessment (prior_vendor_risk_assessment_id)',
    `approval_date` DATE COMMENT 'The date on which the vendor risk assessment was formally approved by management. Represents the completion of the assessment lifecycle.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who formally approved the completed vendor risk assessment, typically a senior risk management officer, Chief Risk Officer (CRO), or compliance officer.',
    `assessment_date` DATE COMMENT 'The date on which the vendor risk assessment was conducted or completed. Represents the principal business event timestamp for this assessment.',
    `assessment_methodology` STRING COMMENT 'The methodology or approach used to conduct the vendor risk assessment: questionnaire (vendor self-assessment), onsite_audit (physical site visit and inspection), document_review (review of vendor-provided documentation), hybrid (combination of methods), third_party_report (reliance on external audit or certification), continuous_monitoring (automated ongoing assessment).. Valid values are `questionnaire|onsite_audit|document_review|hybrid|third_party_report|continuous_monitoring`',
    `assessment_number` STRING COMMENT 'Business-facing unique identifier for the risk assessment, typically formatted as VRA-YYYYNNNN for external reference and audit trail purposes.. Valid values are `^VRA-[0-9]{8}$`',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the risk assessment: draft (initial creation), in_progress (assessment underway), pending_review (awaiting management review), completed (assessment finished), approved (management approved), rejected (assessment rejected or vendor failed).. Valid values are `draft|in_progress|pending_review|completed|approved|rejected`',
    `assessment_type` STRING COMMENT 'Classification of the assessment based on the trigger or schedule: initial (first assessment of new vendor), annual (scheduled periodic review), triggered (event-driven reassessment), ad_hoc (unscheduled review), renewal (contract renewal assessment), material_change (assessment due to significant vendor change).. Valid values are `initial|annual|triggered|ad_hoc|renewal|material_change`',
    `bcp_adequacy_rating` STRING COMMENT 'Assessment of the adequacy and effectiveness of the vendors business continuity plan and disaster recovery capabilities. Ratings: adequate (BCP meets requirements and tested), needs_improvement (BCP exists but has gaps), inadequate (BCP insufficient or untested), not_reviewed (BCP not assessed in this review).. Valid values are `adequate|needs_improvement|inadequate|not_reviewed`',
    `bcp_last_test_date` DATE COMMENT 'The date on which the vendor last conducted a formal test or exercise of their business continuity plan. Used to assess the currency and reliability of BCP capabilities.',
    `concentration_risk_rating` STRING COMMENT 'Risk rating for concentration risk domain, assessing the degree of dependency on this vendor and the potential impact of vendor failure or service disruption. Considers whether the vendor is a single point of failure, the availability of alternative providers, and the criticality of services provided.. Valid values are `low|moderate|high|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor risk assessment record was first created in the system. Part of standard audit trail for data lineage and compliance.',
    `cybersecurity_risk_rating` STRING COMMENT 'Risk rating for cybersecurity and information security domain, assessing the vendors data protection controls, incident response capabilities, vulnerability management, and compliance with security frameworks (ISO 27001, NIST CSF, SOC 2).. Valid values are `low|moderate|high|critical`',
    `data_access_level` STRING COMMENT 'Classification of the level of access this vendor has to the insurers data and systems: none (no data access), limited (access to non-sensitive operational data), moderate (access to some confidential or PII data), extensive (access to highly sensitive data including PHI, PCI, or core systems).. Valid values are `none|limited|moderate|extensive`',
    `financial_review_date` DATE COMMENT 'The date on which the financial stability review was completed. May differ from the overall assessment date if financial review was conducted separately.',
    `financial_risk_rating` STRING COMMENT 'Risk rating for financial stability domain, evaluating the vendors financial health, solvency, liquidity, and ability to remain a going concern. Based on financial statement review, credit ratings, and financial ratios.. Valid values are `low|moderate|high|critical`',
    `financial_stability_review_completed` BOOLEAN COMMENT 'Indicates whether a formal financial stability review was conducted as part of this risk assessment, including analysis of financial statements, credit ratings, and financial ratios.',
    `inherent_risk_tier` STRING COMMENT 'Overall inherent risk classification before considering mitigating controls. Tier 1 represents highest inherent risk (critical vendors with access to sensitive data or critical operations), Tier 4 represents lowest inherent risk (non-critical vendors with minimal data access). Drives assessment frequency and oversight intensity.. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `key_findings` STRING COMMENT 'Summary of the most significant findings, observations, and concerns identified during the vendor risk assessment. Includes both strengths and weaknesses relevant to risk management decision-making.',
    `next_assessment_due_date` DATE COMMENT 'The scheduled date for the next periodic vendor risk assessment. Assessment frequency is typically driven by the vendors risk tier: Tier 1 (annual), Tier 2 (every 2 years), Tier 3 (every 3 years), Tier 4 (as needed).',
    `notes` STRING COMMENT 'Additional free-form notes, comments, or context relevant to this vendor risk assessment that do not fit into structured fields. May include special circumstances, follow-up actions, or historical context.',
    `operational_risk_rating` STRING COMMENT 'Risk rating for operational risk domain, assessing the vendors ability to deliver services reliably, maintain business continuity, and meet service level agreements (SLAs). Ratings: low (minimal operational risk), moderate (manageable operational concerns), high (significant operational weaknesses), critical (severe operational deficiencies).. Valid values are `low|moderate|high|critical`',
    `overall_risk_score` DECIMAL(18,2) COMMENT 'Composite numerical risk score calculated from individual risk domain ratings, typically on a scale of 0-100 where higher scores indicate greater risk. Used for vendor risk ranking and portfolio analysis.',
    `recommendations` STRING COMMENT 'Specific recommendations for managing or mitigating identified vendor risks, including suggested contractual protections, monitoring activities, or alternative vendor considerations.',
    `regulatory_compliance_risk_rating` STRING COMMENT 'Risk rating for regulatory and compliance domain, evaluating the vendors adherence to applicable insurance regulations, data privacy laws (GDPR, HIPAA), anti-money laundering (AML) requirements, and industry standards (NAIC, state DOI requirements).. Valid values are `low|moderate|high|critical`',
    `remediation_plan_due_date` DATE COMMENT 'The date by which a formal remediation plan must be submitted by the vendor or vendor management team to address identified deficiencies. Null if no remediation is required.',
    `remediation_required` BOOLEAN COMMENT 'Indicates whether the assessment identified deficiencies or gaps that require formal remediation actions by the vendor or the insurers vendor management team.',
    `reputational_risk_rating` STRING COMMENT 'Risk rating for reputational risk domain, evaluating the potential impact on the insurers brand and reputation from association with this vendor. Considers vendor public perception, past controversies, ethical practices, and customer satisfaction.. Valid values are `low|moderate|high|critical`',
    `residual_risk_tier` STRING COMMENT 'Overall residual risk classification after considering the effectiveness of mitigating controls, contractual protections, and vendor risk management activities. Represents the net risk exposure the insurer accepts by engaging this vendor.. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `service_criticality` STRING COMMENT 'Classification of the criticality of services provided by this vendor to the insurers operations: low (non-essential services), medium (important but not critical), high (significant impact if disrupted), critical (essential to core business operations or regulatory compliance).. Valid values are `low|medium|high|critical`',
    `soc2_opinion` STRING COMMENT 'The auditors opinion from the SOC 2 report: unqualified (clean opinion, controls effective), qualified (controls effective with exceptions), adverse (controls not effective), disclaimer (auditor unable to form opinion), not_applicable (no SOC 2 report).. Valid values are `unqualified|qualified|adverse|disclaimer|not_applicable`',
    `soc2_report_date` DATE COMMENT 'The date or period end date of the most recent SOC 2 report reviewed. Used to assess the currency and relevance of the audit findings.',
    `soc2_report_reviewed` BOOLEAN COMMENT 'Indicates whether a SOC 2 Type I or Type II audit report was reviewed as part of this risk assessment. SOC 2 reports provide independent assurance on security, availability, processing integrity, confidentiality, and privacy controls.',
    `soc2_report_type` STRING COMMENT 'Type of SOC 2 report reviewed: Type 1 (point-in-time assessment of control design), Type 2 (assessment of control design and operating effectiveness over a period), not_applicable (no SOC 2 report available or required).. Valid values are `type_1|type_2|not_applicable`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor risk assessment record was last modified in the system. Part of standard audit trail for data lineage and compliance.',
    CONSTRAINT pk_vendor_risk_assessment PRIMARY KEY(`vendor_risk_assessment_id`)
) COMMENT 'Master and transactional record of third-party risk assessments conducted on vendors as part of Life Insurances vendor risk management (VRM) program. Captures assessment date, risk domains evaluated (operational, financial, cybersecurity, regulatory/compliance, concentration, reputational), individual risk ratings, overall inherent and residual risk tier, assessment methodology, assessor identity, and next scheduled review date. Required for NAIC Model Audit Rule compliance and state DOI oversight of outsourced insurance operations. Tracks SOC 2 report review status, financial stability review, and business continuity plan (BCP) adequacy.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`risk_finding` (
    `risk_finding_id` BIGINT COMMENT 'Unique identifier for the vendor risk finding record. Primary key for the vendor risk finding entity.',
    `exam_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.exam_finding. Business justification: Vendor risk findings may be identified during regulatory market conduct exams or may contribute to exam findings (e.g., TPA claims handling deficiencies). Links vendor deficiency to regulatory exam fi',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Risk analysts identify vendor risk findings during assessments and audits. Tracks who identified finding for follow-up, expertise validation, and regulatory audit trail requirements.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_contract. Business justification: Risk findings are often specific to a contracts scope, terms, or service delivery obligations. Linking vendor_risk_finding to vendor_contract provides context for remediation planning and contract am',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor entity for which this risk finding was identified during assessment.',
    `vendor_risk_assessment_id` BIGINT COMMENT 'Reference to the parent vendor risk assessment engagement during which this finding was identified.',
    `escalated_from_risk_finding_id` BIGINT COMMENT 'Self-referencing FK on risk_finding (escalated_from_risk_finding_id)',
    `actual_remediation_date` DATE COMMENT 'Actual date on which the remediation action was completed and validated, marking the closure of the finding.',
    `affected_service` STRING COMMENT 'The specific vendor service, product, or business function impacted by this risk finding (e.g., medical exam processing, policy administration, claims adjudication).',
    `business_impact_description` STRING COMMENT 'Narrative description of the potential business impact if the risk finding is not remediated, including operational, financial, regulatory, and reputational consequences.',
    `control_deficiency_type` STRING COMMENT 'Classification of the control deficiency as a design flaw (control not properly designed), operating effectiveness issue (control not operating as designed), or both.. Valid values are `design|operating_effectiveness|both|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor risk finding record was first created in the system.',
    `escalation_date` DATE COMMENT 'Date on which the finding was escalated to higher management levels or governance committees.',
    `escalation_flag` BOOLEAN COMMENT 'Indicator of whether this finding has been escalated to senior management, risk committee, or board of directors due to severity or remediation delays.',
    `escalation_reason` STRING COMMENT 'Reason for escalating the finding, such as missed remediation deadlines, increased risk severity, or vendor non-responsiveness.',
    `finding_description` STRING COMMENT 'Detailed narrative description of the risk finding, including the observed condition, the control deficiency, and the potential impact to insurance operations.',
    `finding_number` STRING COMMENT 'Business-assigned unique identifier or tracking number for the risk finding, typically formatted as assessment-year-sequence (e.g., VRA-2024-001).',
    `finding_status` STRING COMMENT 'Current lifecycle status of the risk finding, tracking progression from identification through remediation to closure or acceptance.. Valid values are `open|in_remediation|pending_validation|closed|accepted|escalated`',
    `finding_title` STRING COMMENT 'Concise title or summary of the risk finding or control deficiency identified during the vendor assessment.',
    `identification_date` DATE COMMENT 'Date on which the risk finding was first identified and documented during the vendor risk assessment process.',
    `inherent_risk_score` STRING COMMENT 'Quantitative risk score representing the inherent risk level before considering mitigating controls, typically on a scale of 1-25 or 1-100 depending on organizational framework.',
    `last_review_date` DATE COMMENT 'Date of the most recent review or follow-up on this finding to assess remediation progress and update status.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next follow-up review of this finding to monitor remediation progress and validate completion.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the finding, remediation efforts, vendor communications, or special circumstances.',
    `recommended_remediation` STRING COMMENT 'Detailed recommendation for remediation action to address the risk finding, including specific controls, process changes, or technology implementations required.',
    `regulatory_impact_flag` BOOLEAN COMMENT 'Indicator of whether this finding has potential regulatory compliance implications requiring notification to state insurance departments, NAIC, or other governing bodies.',
    `remediation_owner` STRING COMMENT 'Name or identifier of the vendor contact or internal stakeholder responsible for coordinating and completing the remediation action.',
    `remediation_validation_method` STRING COMMENT 'Method used to validate that the remediation action was effectively implemented (e.g., document review, control testing, on-site inspection, vendor attestation).',
    `residual_risk_score` STRING COMMENT 'Quantitative risk score representing the residual risk level after considering existing mitigating controls and planned remediation actions.',
    `risk_acceptance_approver` STRING COMMENT 'Name or title of the executive or risk committee member who approved the risk acceptance decision for findings that will not be fully remediated.',
    `risk_acceptance_date` DATE COMMENT 'Date on which the risk acceptance decision was formally approved and documented.',
    `risk_acceptance_flag` BOOLEAN COMMENT 'Indicator of whether the organization has formally accepted the risk without full remediation, typically requiring executive approval for high or critical findings.',
    `risk_acceptance_justification` STRING COMMENT 'Business rationale and justification for accepting the risk without full remediation, including cost-benefit analysis and compensating controls.',
    `risk_domain` STRING COMMENT 'Primary risk category or domain to which this finding belongs, enabling classification and aggregation of findings by risk type.. Valid values are `operational|financial|compliance|cybersecurity|data_privacy|business_continuity`',
    `risk_subcategory` STRING COMMENT 'More granular classification within the risk domain, providing detailed categorization of the specific risk area (e.g., access control, data encryption, contract compliance).',
    `severity_level` STRING COMMENT 'Risk severity classification indicating the potential impact and urgency of the finding. Critical findings require immediate escalation and remediation.. Valid values are `critical|high|medium|low`',
    `target_remediation_date` DATE COMMENT 'Internal target date by which the organization expects the finding to be remediated, which may differ from the vendor committed date based on risk severity and business requirements.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor risk finding record was last modified, supporting audit trail and change tracking requirements.',
    `validation_evidence` STRING COMMENT 'Description or reference to the evidence collected to validate remediation completion, such as updated policies, test results, screenshots, or audit reports.',
    `vendor_committed_date` DATE COMMENT 'Date by which the vendor has formally committed to complete the remediation action, as documented in the vendor response or remediation plan.',
    `vendor_response` STRING COMMENT 'Vendors formal response to the finding, including their acknowledgment, proposed remediation plan, and any disagreement or alternative approach.',
    CONSTRAINT pk_risk_finding PRIMARY KEY(`risk_finding_id`)
) COMMENT 'Individual risk finding or control deficiency identified during a vendor risk assessment. Captures finding title, risk domain, finding description, severity level (critical, high, medium, low), recommended remediation action, vendor-committed remediation date, actual remediation date, and finding status (open, in remediation, closed, accepted). Enables tracking of open risk items across the vendor portfolio and supports escalation workflows for critical findings affecting insurance operations.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`credential` (
    `credential_id` BIGINT COMMENT 'Unique identifier for the vendor credential record. Primary key.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor who holds this credential. Links to the vendor master record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Compliance officers verify vendor credentials (licenses, certifications) to ensure regulatory compliance. Tracks who performed verification for audit trail and accountability in insurance regulatory e',
    `renewed_credential_id` BIGINT COMMENT 'Self-referencing FK on credential (renewed_credential_id)',
    `attestation_required_flag` BOOLEAN COMMENT 'Indicates whether the vendor must provide periodic attestation or self-certification of continued compliance with this credential. True if attestation is required, False otherwise.',
    `audit_trail_notes` STRING COMMENT 'Free-text field for recording significant events, changes, or compliance notes related to this credential over its lifecycle.',
    `compliance_requirement_flag` BOOLEAN COMMENT 'Indicates whether this credential is a mandatory regulatory or contractual requirement for the vendor to perform services for Life Insurance. True if required, False if optional or supplementary.',
    `continuing_education_hours_required` DECIMAL(18,2) COMMENT 'Number of continuing education hours the vendor must complete within the renewal period to maintain this credential.',
    `continuing_education_required_flag` BOOLEAN COMMENT 'Indicates whether the vendor must complete continuing education or training requirements to maintain this credential. True if CE is required, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor credential record was first created in the system.',
    `credential_name` STRING COMMENT 'Full descriptive name of the credential as issued by the authority (e.g., Certified Information Systems Auditor, State of California Third Party Administrator License).',
    `credential_number` STRING COMMENT 'The unique alphanumeric identifier assigned by the issuing authority for this credential (e.g., license number, certificate number, accreditation ID).',
    `credential_status` STRING COMMENT 'Current lifecycle status of the credential. Indicates whether the vendor is currently authorized under this credential.. Valid values are `active|expired|suspended|revoked|pending_renewal|inactive`',
    `credential_type` STRING COMMENT 'Classification of the credential held by the vendor. Indicates the nature of authorization or certification required to perform contracted services. [ENUM-REF-CANDIDATE: state_insurance_license|hipaa_business_associate|soc2_type_ii|iso_27001|ncqa_accreditation|state_tpa_license|finra_registration|sec_registration|professional_certification|other — 10 candidates stripped; promote to reference product]',
    `document_url` STRING COMMENT 'URL or file path to the stored digital copy of the credential certificate, license document, or accreditation letter in the document management system.',
    `effective_date` DATE COMMENT 'Date from which the credential becomes valid and the vendor is authorized to perform services under this credential.',
    `expiration_date` DATE COMMENT 'Date on which the credential expires and is no longer valid unless renewed. Null for credentials with no expiration.',
    `geographic_scope` STRING COMMENT 'Geographic area or jurisdictions where the credential authorizes the vendor to operate (e.g., California only, All 50 US states, International).',
    `issue_date` DATE COMMENT 'Date on which the credential was originally issued to the vendor by the issuing authority.',
    `issuing_authority` STRING COMMENT 'Name of the regulatory body, certification organization, or government agency that issued the credential (e.g., California Department of Insurance, AICPA, NCQA, ISO).',
    `issuing_jurisdiction` STRING COMMENT 'Geographic or regulatory jurisdiction where the credential is valid (e.g., state code for state licenses, country code for international certifications, FEDERAL for federal registrations).',
    `last_attestation_date` DATE COMMENT 'Date on which the vendor last provided attestation or self-certification of continued compliance with this credential.',
    `next_attestation_due_date` DATE COMMENT 'Date by which the next vendor attestation or self-certification is due for this credential.',
    `next_renewal_due_date` DATE COMMENT 'Date by which the credential must be renewed to maintain continuous authorization. Used for proactive compliance monitoring.',
    `product_line_applicability` STRING COMMENT 'Life insurance product lines or business segments for which this credential is required or applicable (e.g., Term Life, Universal Life, Annuities, All Products).',
    `regulatory_body` STRING COMMENT 'Name of the primary regulatory body or governing organization that oversees this type of credential (e.g., NAIC, State Department of Insurance, FINRA, SEC, AICPA).',
    `reinstatement_date` DATE COMMENT 'Date on which a previously suspended or revoked credential was reinstated and returned to active status.',
    `renewal_date` DATE COMMENT 'Date on which the credential was last renewed. Tracks renewal history for compliance verification.',
    `responsible_party` STRING COMMENT 'Name or identifier of the internal business unit, department, or individual responsible for monitoring and managing this vendor credential.',
    `revocation_date` DATE COMMENT 'Date on which the credential was permanently revoked by the issuing authority. Null if never revoked.',
    `revocation_reason` STRING COMMENT 'Explanation or reason code for why the credential was revoked (e.g., Regulatory violation, Fraud, Failure to meet standards).',
    `risk_rating` STRING COMMENT 'Internal risk assessment rating for this credential based on criticality to business operations and regulatory exposure if the credential lapses or is revoked.. Valid values are `low|medium|high|critical`',
    `scope_of_authorization` STRING COMMENT 'Description of the specific services, activities, or business functions the vendor is authorized to perform under this credential (e.g., Medical examinations for life insurance underwriting, Third-party claims administration).',
    `suspension_date` DATE COMMENT 'Date on which the credential was suspended by the issuing authority or by internal decision. Null if never suspended.',
    `suspension_reason` STRING COMMENT 'Explanation or reason code for why the credential was suspended (e.g., Non-payment of renewal fee, Regulatory investigation, Vendor request).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor credential record was last modified in the system.',
    `verification_date` DATE COMMENT 'Date on which the credential was last verified with the issuing authority or through an authorized verification service.',
    `verification_method` STRING COMMENT 'Method used to verify the credential authenticity (e.g., direct contact with issuing authority, online registry lookup, third-party verification service).. Valid values are `direct_authority_contact|online_registry|third_party_service|document_review|other`',
    `verification_status` STRING COMMENT 'Status of internal verification process confirming the authenticity and validity of the credential with the issuing authority.. Valid values are `verified|pending_verification|failed_verification|not_verified`',
    CONSTRAINT pk_credential PRIMARY KEY(`credential_id`)
) COMMENT 'Master record tracking all licenses, certifications, accreditations, and regulatory credentials held by a vendor that are required to perform contracted services. Captures credential type (state insurance license, HIPAA Business Associate certification, SOC 2 Type II, ISO 27001, NCQA accreditation for exam vendors, state TPA license), issuing authority, credential number, issue date, expiration date, and renewal status. Supports compliance verification that outsourced vendors maintain required authorizations to operate in each jurisdiction where Life Insurance does business.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`baa` (
    `baa_id` BIGINT COMMENT 'Unique identifier for the HIPAA Business Associate Agreement record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Privacy officers manage HIPAA Business Associate Agreements for PHI protection. Links BAA to responsible compliance officer for breach notification, audit coordination, and HHS regulatory compliance.',
    `privacy_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_incident. Business justification: BAA violations or breaches by business associates trigger privacy incident protocols under HIPAA breach notification rules. Links BAA to privacy incident for breach notification timeline enforcement a',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_contract. Business justification: BAAs (Business Associate Agreements) are contractual instruments executed under or referenced by master service agreements. Linking baa to vendor_contract provides the contractual context for HIPAA co',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or business associate with whom this BAA is executed.',
    `renewed_baa_id` BIGINT COMMENT 'Self-referencing FK on baa (renewed_baa_id)',
    `agreement_name` STRING COMMENT 'Descriptive name or title of the BAA, typically including the vendor name and purpose.',
    `agreement_number` STRING COMMENT 'Externally-known unique identifier or contract number for this BAA, used for reference in legal and compliance documentation.',
    `agreement_type` STRING COMMENT 'Classification of the BAA based on its structure and negotiation status.. Valid values are `standard|custom|master|amendment|renewal`',
    `audit_frequency` STRING COMMENT 'Frequency with which Life Insurance may conduct audits of the business associates PHI handling and HIPAA compliance.. Valid values are `annual|biannual|quarterly|on_demand|as_needed`',
    `audit_rights_included` BOOLEAN COMMENT 'Indicates whether Life Insurance retains the right to audit the business associates PHI handling practices and HIPAA compliance under this BAA.',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Indicates whether the BAA automatically renews for successive terms unless either party provides notice of termination.',
    `baa_status` STRING COMMENT 'Current lifecycle status of the BAA indicating its operational state and enforceability. [ENUM-REF-CANDIDATE: draft|pending_review|executed|active|expired|terminated|suspended — 7 candidates stripped; promote to reference product]',
    `breach_notification_method` STRING COMMENT 'Prescribed method or channel through which the business associate must notify Life Insurance of a breach (e.g., email, phone, secure portal).',
    `breach_notification_timeframe_hours` STRING COMMENT 'Maximum number of hours within which the business associate must notify Life Insurance of any breach or suspected breach of unsecured PHI.',
    `covered_phi_categories` STRING COMMENT 'Enumeration or description of the specific categories of PHI that the business associate is authorized to access, process, or transmit under this BAA (e.g., medical exam results, prescription history, MIB reports).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this BAA record was first created in the system.',
    `data_destruction_method` STRING COMMENT 'Approved method or standard for destruction of PHI (e.g., NIST 800-88, DoD 5220.22-M, physical shredding) that the business associate must follow.',
    `data_destruction_required` BOOLEAN COMMENT 'Indicates whether the business associate is required to destroy all PHI upon termination or expiration of the BAA if return is not feasible.',
    `data_retention_period_days` STRING COMMENT 'Number of days the business associate is permitted to retain PHI after termination or expiration of the BAA, if retention is necessary for legal or business purposes.',
    `data_return_required` BOOLEAN COMMENT 'Indicates whether the business associate is required to return all PHI to Life Insurance upon termination or expiration of the BAA.',
    `document_storage_location` STRING COMMENT 'Physical or electronic location where the executed BAA document is stored for compliance and audit purposes.',
    `effective_date` DATE COMMENT 'Date from which the BAA terms become binding and enforceable, marking the start of the business associate relationship.',
    `execution_date` DATE COMMENT 'Date on which the BAA was signed and executed by all parties, establishing the legal binding date.',
    `expiration_date` DATE COMMENT 'Date on which the BAA expires or terminates, after which the business associate relationship is no longer covered unless renewed.',
    `governing_law_jurisdiction` STRING COMMENT 'State or jurisdiction whose laws govern the interpretation and enforcement of this BAA.',
    `indemnification_included` BOOLEAN COMMENT 'Indicates whether the BAA includes indemnification provisions protecting Life Insurance from losses arising from the business associates breach or non-compliance.',
    `insurance_certificate_on_file` BOOLEAN COMMENT 'Indicates whether a current certificate of insurance meeting BAA requirements is on file for the business associate.',
    `insurance_expiration_date` DATE COMMENT 'Expiration date of the business associates current insurance certificate on file.',
    `insurance_requirement_amount` DECIMAL(18,2) COMMENT 'Minimum amount of cyber liability or errors and omissions insurance that the business associate is required to maintain under this BAA.',
    `last_audit_date` DATE COMMENT 'Date of the most recent audit conducted by Life Insurance to verify the business associates compliance with BAA terms and HIPAA requirements.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next audit of the business associates PHI handling and HIPAA compliance under this BAA.',
    `notes` STRING COMMENT 'Additional notes, comments, or special provisions related to this BAA that do not fit into other structured fields.',
    `permitted_disclosures` STRING COMMENT 'Detailed description of the specific disclosures of PHI that the business associate is permitted to make under this BAA, including to whom and under what circumstances.',
    `permitted_uses` STRING COMMENT 'Detailed description of the specific uses of PHI that the business associate is permitted to perform under this BAA, such as underwriting support, claims processing, or actuarial analysis.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiration that Life Insurance must provide notice of intent to renew or terminate the BAA.',
    `signed_by_business_associate` STRING COMMENT 'Name and title of the vendor or business associate representative who signed the BAA.',
    `signed_by_covered_entity` STRING COMMENT 'Name and title of the Life Insurance representative who signed the BAA on behalf of the covered entity.',
    `subcontractor_provision_included` BOOLEAN COMMENT 'Indicates whether the BAA includes provisions requiring the business associate to obtain satisfactory assurances from subcontractors that handle PHI.',
    `subcontractor_requirements` STRING COMMENT 'Detailed requirements and obligations that the business associate must impose on any subcontractors who access PHI, ensuring HIPAA compliance throughout the chain.',
    `termination_date` DATE COMMENT 'Actual date on which the BAA was terminated prior to its natural expiration, if applicable.',
    `termination_reason` STRING COMMENT 'Explanation or justification for early termination of the BAA, including breach, non-compliance, or business decision.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this BAA record was last modified in the system.',
    CONSTRAINT pk_baa PRIMARY KEY(`baa_id`)
) COMMENT 'Master record for HIPAA Business Associate Agreements (BAAs) executed with vendors who access, process, or transmit Protected Health Information (PHI) on behalf of Life Insurance. Captures BAA execution date, effective period, covered PHI categories, permitted uses and disclosures, subcontractor provisions, breach notification obligations, data return/destruction requirements, and BAA status. Required for all medical exam vendors (ExamOne, APPS), MIB, prescription database providers, and any TPA handling medical underwriting data. Supports HIPAA compliance audit and privacy incident response.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` (
    `tpa_agreement_id` BIGINT COMMENT 'Unique identifier for the TPA agreement record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Claims operations managers own TPA relationships for delegated claims administration. Links agreement to responsible manager for performance oversight, escalation, and state DOI regulatory reporting.',
    `baa_id` BIGINT COMMENT 'Foreign key linking to vendor.baa. Business justification: TPAs handle PHI and require HIPAA Business Associate Agreements. The tpa_agreement table has hipaa_baa_signed flag but no FK to the actual BAA record. Linking tpa_agreement to baa enables tracking the',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: TPA agreements must address regulatory obligations including state DOI filings, claims authority limits, licensing requirements, and regulatory reporting. Tracks primary regulatory obligation governin',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_contract. Business justification: TPA agreements are specialized vendor contracts governing outsourced insurance administration. The tpa_agreement table duplicates many contract-level attributes (effective_date, expiration_date, termi',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor master record representing the TPA entity. Links to the vendor product for core vendor information.',
    `renewed_tpa_agreement_id` BIGINT COMMENT 'Self-referencing FK on tpa_agreement (renewed_tpa_agreement_id)',
    `administered_functions` STRING COMMENT 'Comma-separated list of insurance administration functions delegated to the TPA, such as claims processing, billing administration, policy servicing, group enrollment, premium collection, customer service.',
    `agreement_type` STRING COMMENT 'Classification of the TPA agreement based on the scope of outsourced functions. Full service covers all administration; specialty TPAs handle specific functions.. Valid values are `full_service|claims_only|billing_only|policy_servicing|group_enrollment|specialty_tpa`',
    `audit_frequency_months` STRING COMMENT 'Minimum frequency in months at which the insurer will conduct operational and financial audits of the TPA under this agreement.',
    `audit_rights_provision` STRING COMMENT 'Scope of the insurers right to audit TPA operations, records, and systems. Full access allows unannounced audits; scheduled-only requires advance notice.. Valid values are `full_access|scheduled_only|notice_required|restricted`',
    `claims_authority_limit` DECIMAL(18,2) COMMENT 'Maximum dollar amount the TPA is authorized to approve and pay on a single claim without escalation to the insurer. Null if TPA has no claims authority.',
    `claims_processing_sla_days` STRING COMMENT 'Target number of business days for the TPA to process and adjudicate a complete claim from receipt to payment or denial decision.',
    `compensation_model` STRING COMMENT 'Basis on which the TPA is compensated for services. Per-policy charges a fee per administered policy; per-claim charges per processed claim; percentage-of-premium is a revenue share model.. Valid values are `per_policy_fee|per_claim_fee|percentage_of_premium|flat_monthly_fee|hybrid`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this TPA agreement record was first created in the system.',
    `customer_service_sla_hours` STRING COMMENT 'Target number of hours for the TPA to respond to policyholder inquiries and service requests.',
    `data_breach_notification_hours` STRING COMMENT 'Maximum number of hours within which the TPA must notify the insurer of a data breach or security incident involving policyholder information.',
    `data_ownership_provision` STRING COMMENT 'Defines legal ownership of policyholder and claims data processed by the TPA. Insurer-owns means all data remains insurer property; TPA-custodian means TPA holds data on behalf of insurer.. Valid values are `insurer_owns|joint_ownership|tpa_custodian`',
    `data_return_requirement_days` STRING COMMENT 'Number of days after agreement termination within which the TPA must return all policyholder data, records, and systems access to the insurer.',
    `delegated_authority_scope` STRING COMMENT 'Level of decision-making authority granted to the TPA. Administrative-only TPAs execute processes but cannot approve claims or underwriting; full authority TPAs can make binding decisions within limits.. Valid values are `administrative_only|limited_claims_authority|full_claims_authority|underwriting_authority`',
    `disaster_recovery_plan_on_file` BOOLEAN COMMENT 'Indicates whether the TPA has provided a current disaster recovery and business continuity plan to the insurer for review and approval.',
    `eo_certificate_on_file` BOOLEAN COMMENT 'Indicates whether a current certificate of errors and omissions insurance is on file with the insurer.',
    `eo_coverage_amount` DECIMAL(18,2) COMMENT 'Minimum dollar amount of errors and omissions insurance coverage the TPA must maintain. Null if not required.',
    `eo_expiration_date` DATE COMMENT 'Expiration date of the TPAs current errors and omissions insurance policy. Null if not required or not on file.',
    `eo_insurance_required` BOOLEAN COMMENT 'Indicates whether the TPA is required to maintain errors and omissions insurance coverage as a condition of the agreement.',
    `fee_schedule_reference` STRING COMMENT 'Reference to the detailed fee schedule document or contract exhibit defining TPA service fees, rates, and pricing structure.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent formal performance review conducted by the insurer to assess TPA service delivery against SLA and contractual obligations.',
    `next_performance_review_date` DATE COMMENT 'Scheduled date for the next formal performance review of the TPA.',
    `notes` STRING COMMENT 'Free-form notes capturing additional context, special provisions, amendments, or operational considerations related to the TPA agreement.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which the insurer must pay TPA service fees.',
    `performance_rating` STRING COMMENT 'Most recent overall performance rating assigned to the TPA based on SLA compliance, audit results, and service quality metrics.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `performance_sla_reference` STRING COMMENT 'Reference to the service level agreement document or section defining performance standards, turnaround times, accuracy targets, and quality metrics for TPA services.',
    `product_lines_covered` STRING COMMENT 'Comma-separated list of insurance product lines the TPA is authorized to administer under this agreement, such as term life, whole life, universal life, annuities, group life, disability income.',
    `registered_states` STRING COMMENT 'Comma-separated list of US state postal codes where the TPA is registered and authorized to conduct insurance administration business on behalf of the insurer.',
    `regulatory_reporting_responsibility` STRING COMMENT 'Defines which party is responsible for filing regulatory reports related to TPA-administered business. Insurer retains ultimate responsibility but may delegate execution to TPA.. Valid values are `insurer|tpa|shared`',
    `soc2_expiration_date` DATE COMMENT 'Expiration date of the TPAs current SOC 2 Type 2 certification report. Null if not certified.',
    `soc2_type2_certified` BOOLEAN COMMENT 'Indicates whether the TPA holds a current SOC 2 Type 2 certification demonstrating operational controls over security, availability, processing integrity, confidentiality, and privacy.',
    `state_doi_filing_reference` STRING COMMENT 'Reference number or identifier for the TPA registration filing with the state insurance department, as required by NAIC Model Act #225 for TPA oversight.',
    `tpa_name` STRING COMMENT 'Legal name of the TPA entity as registered with state insurance departments.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this TPA agreement record was last modified.',
    CONSTRAINT pk_tpa_agreement PRIMARY KEY(`tpa_agreement_id`)
) COMMENT 'Master record for Third-Party Administrator (TPA) agreements governing outsourced insurance administration functions. Captures TPA name, administered functions (claims processing, billing administration, policy servicing, group enrollment), delegated authority scope, state DOI filing reference for TPA registration, performance standards, audit rights, data ownership provisions, and agreement status. Distinct from vendor_contract (which covers all vendor MSAs) — tpa_agreement captures the insurance-specific regulatory and operational parameters unique to TPA relationships subject to state insurance department oversight.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` (
    `exam_vendor_order_id` BIGINT COMMENT 'Unique identifier for the exam vendor order record. Primary key for this transactional entity tracking paramedical and medical examination orders placed with third-party exam vendors during the life insurance underwriting process.',
    `insured_id` BIGINT COMMENT 'Foreign key linking to policyholder.insured. Business justification: Paramedical exam orders are placed for specific insureds during underwriting. Exam results (blood work, vitals, medical history) must be matched to the correct insured record for underwriting risk cla',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Underwriters order medical exams through vendor portals during underwriting process. Links order to underwriter for case assignment, workload tracking, and underwriting authority validation.',
    `party_id` BIGINT COMMENT 'Reference to the insurance applicant (proposed insured) who will undergo the medical examination. Links to the policyholder or insured party master record.',
    `application_id` BIGINT COMMENT 'Reference to the new business application that triggered this exam order. Links this exam order to the underwriting case and policy application being evaluated.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_contract. Business justification: Exam vendor orders are executed under master exam vendor contracts that define pricing, SLA terms, and service levels. The exam_vendor_order table has vendor_id but no contract_id. Linking exam_vendor',
    `vendor_id` BIGINT COMMENT 'Reference to the exam vendor (ExamOne, APPS, or equivalent) assigned to fulfill this examination order. Links to the vendor master record for the medical examination service provider.',
    `reorder_exam_vendor_order_id` BIGINT COMMENT 'Self-referencing FK on exam_vendor_order (reorder_exam_vendor_order_id)',
    `applicant_contact_email` STRING COMMENT 'Email address provided to the vendor for applicant communication regarding exam scheduling, confirmation, and preparation instructions. Enables digital appointment management and reduces phone tag.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `applicant_contact_phone` STRING COMMENT 'Phone number provided to the vendor for contacting the applicant to schedule the examination. Critical for successful appointment coordination and reducing no-show rates.',
    `blood_specimen_required` BOOLEAN COMMENT 'Indicates whether blood specimen collection is required for this examination. Blood tests are standard for comprehensive underwriting and test for cholesterol, glucose, liver function, and other health markers.',
    `cancellation_date` DATE COMMENT 'Date when the exam order was cancelled. Used for tracking wasted vendor capacity and analyzing cancellation patterns to improve scheduling efficiency.',
    `cancellation_reason` STRING COMMENT 'Reason why the exam order was cancelled if status is cancelled. Common reasons include applicant withdrawal, policy declined before exam, applicant no-show, or underwriting requirements changed. Used for process improvement analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this exam vendor order record was first created in the system. Audit field for data lineage and record lifecycle tracking.',
    `exam_completion_date` DATE COMMENT 'Date when the examination was completed by the examiner. Marks the end of the field examination phase and triggers the results processing workflow. Used for vendor SLA compliance measurement.',
    `exam_completion_timestamp` TIMESTAMP COMMENT 'Precise date and time when the examination was completed. Provides granular timing for operational analytics and end-to-end cycle time measurement from order to completion.',
    `exam_location_address` STRING COMMENT 'Full address where the examination will take place. For home exams, this is the applicants residence. For clinic exams, this is the vendor facility address. Used for examiner routing and applicant confirmation.',
    `exam_location_city` STRING COMMENT 'City where the examination will be conducted. Used for geographic analysis of vendor coverage and examiner assignment optimization.',
    `exam_location_postal_code` STRING COMMENT 'Postal code of the examination location. Used for examiner assignment based on geographic proximity and vendor service area validation.',
    `exam_location_state` STRING COMMENT 'State or province where the examination will be conducted. Important for vendor licensing compliance and regional performance analysis.',
    `exam_location_type` STRING COMMENT 'Type of location where the examination will be conducted. Impacts scheduling logistics, examiner assignment, and applicant convenience. Mobile and home exams are common for life insurance underwriting.. Valid values are `home|office|clinic|mobile_unit|telehealth`',
    `exam_package_code` STRING COMMENT 'Vendor-specific code identifying the bundled exam package ordered (e.g., basic paramedical, comprehensive medical with EKG, senior package). Maps to vendor pricing schedules and defines the specific tests and specimens included.',
    `exam_type` STRING COMMENT 'Type of medical examination ordered based on underwriting requirements. Determines the scope of medical evaluation, specimen collection, and clinical tests to be performed. Drives vendor pricing and scheduling complexity. [ENUM-REF-CANDIDATE: paramedical|full_medical|ekg|treadmill|cognitive|aps|inspection — 7 candidates stripped; promote to reference product]',
    `examiner_name` STRING COMMENT 'Name of the paramedical examiner or medical professional who conducted the examination. Provides accountability and quality assurance traceability.',
    `invoice_amount` DECIMAL(18,2) COMMENT 'Total amount invoiced by the vendor for this exam order. Includes all charges for examination services, specimen collection, lab processing, and result transmission. Used for cost analysis and budget tracking.',
    `invoice_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice amount. Typically USD for US-based vendors but may vary for international exam vendors.',
    `invoice_number` STRING COMMENT 'Invoice number provided by the exam vendor for this order. Used for accounts payable reconciliation and cost tracking. Links exam orders to vendor billing records.',
    `oral_fluid_specimen_required` BOOLEAN COMMENT 'Indicates whether oral fluid (saliva) specimen collection is required. Oral fluid testing is a less invasive alternative for certain health markers and drug screening.',
    `order_date` DATE COMMENT 'Date when the exam order was placed with the vendor. Represents the business event timestamp when the underwriter requested the medical examination. Used for SLA tracking and aging analysis.',
    `order_number` STRING COMMENT 'Business identifier for the exam order, typically assigned by the underwriting workbench or vendor management system. Used for tracking and reconciliation with vendor invoices and results transmission.',
    `order_status` STRING COMMENT 'Current lifecycle status of the exam order. Tracks progression from initial order placement through scheduling, exam completion, and results receipt. Critical for operational tracking and SLA monitoring. [ENUM-REF-CANDIDATE: ordered|scheduled|in_progress|completed|cancelled|failed|results_received — 7 candidates stripped; promote to reference product]',
    `order_timestamp` TIMESTAMP COMMENT 'Precise date and time when the exam order was submitted to the vendor system. Provides granular timing for operational analytics and vendor performance measurement.',
    `priority_level` STRING COMMENT 'Priority level assigned to this exam order. Expedited and rush orders require faster scheduling and results turnaround, often at premium pricing. Used for high-value cases or competitive situations.. Valid values are `standard|expedited|rush|urgent`',
    `results_received_date` DATE COMMENT 'Date when the exam results were received from the vendor. Marks the completion of the vendor fulfillment cycle and enables underwriting decision progression. Used for total turnaround time calculation.',
    `results_received_timestamp` TIMESTAMP COMMENT 'Precise date and time when the exam results were received and logged in the underwriting system. Enables detailed SLA tracking and vendor performance benchmarking.',
    `results_transmission_status` STRING COMMENT 'Status of the exam results transmission from vendor to the insurance company underwriting system. Tracks whether clinical results and lab findings have been successfully delivered and integrated into the underwriting workbench.. Valid values are `pending|transmitted|received|integrated|failed`',
    `scheduled_date` DATE COMMENT 'Date when the medical examination appointment is scheduled to occur. Set after applicant scheduling coordination. Used for applicant communication and vendor resource planning.',
    `scheduled_time` TIMESTAMP COMMENT 'Time of day when the examination appointment is scheduled. Stored as string to accommodate various time formats and time zone considerations across vendor systems.',
    `special_instructions` STRING COMMENT 'Free-text field for special instructions to the vendor or examiner. May include applicant accessibility needs, language preferences, scheduling constraints, or specific clinical requirements beyond the standard exam package.',
    `specimen_collection_date` DATE COMMENT 'Date when biological specimens were collected from the applicant. Critical for lab result validity and turnaround time tracking. Specimens must be processed within specific timeframes to ensure accuracy.',
    `specimen_collection_required` BOOLEAN COMMENT 'Indicates whether biological specimen collection (blood, urine, oral fluid) is required as part of this exam order. Determines lab processing requirements and impacts turnaround time.',
    `turnaround_time_days` STRING COMMENT 'Total number of calendar days from order placement to results receipt. Key performance indicator for vendor service quality and underwriting cycle time optimization. Used for vendor scorecard reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this exam vendor order record was last modified. Audit field for change tracking and data quality monitoring. Updated whenever order status or other attributes change.',
    `urine_specimen_required` BOOLEAN COMMENT 'Indicates whether urine specimen collection is required. Urine tests screen for drug use, kidney function, and other health indicators relevant to mortality risk assessment.',
    `vendor_reference_number` STRING COMMENT 'Unique reference number assigned by the exam vendor to track this order in their system. Used for cross-system reconciliation and vendor support inquiries. May differ from the insurance company order number.',
    CONSTRAINT pk_exam_vendor_order PRIMARY KEY(`exam_vendor_order_id`)
) COMMENT 'Transactional record of each paramedical or medical examination ordered from an exam vendor (ExamOne, APPS, or equivalent) as part of the life insurance underwriting process. Captures order date, exam vendor assigned, exam type (paramedical, full medical, EKG, treadmill, cognitive), applicant scheduling status, scheduled exam date and location, examiner identity, specimen collection details (blood, urine, oral fluid), exam completion date, and results transmission status. Links to underwriting.paramedical_exam for the clinical results. Provides the vendor-side operational record for exam fulfillment tracking and invoice reconciliation.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`custodian_account` (
    `custodian_account_id` BIGINT COMMENT 'Unique identifier for the custodian account record. Primary key for the custodian_account product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Investment operations staff manage custodian account relationships for asset custody. Links account to responsible manager for escalation, reconciliation ownership, and NAIC Schedule D reporting accou',
    `report_definition_id` BIGINT COMMENT 'Foreign key linking to reporting.report_definition. Business justification: Custodian accounts feed Schedule D (investments) and other statutory investment schedules. Quarterly/annual statutory filing requires custodian-held asset reporting for NAIC Annual Statement investmen',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_contract. Business justification: Custodian accounts are established under custody agreements (a type of vendor contract). The custodian_account table has contract_start_date and contract_end_date but no FK to the governing contract. ',
    `vendor_id` BIGINT COMMENT 'Reference to the custodian vendor entity (e.g., State Street, BNY Mellon, Northern Trust) that provides custody services for this account.',
    `successor_custodian_account_id` BIGINT COMMENT 'Self-referencing FK on custodian_account (successor_custodian_account_id)',
    `account_closure_date` DATE COMMENT 'The date on which this custodian account was officially closed. Null for active accounts.',
    `account_name` STRING COMMENT 'The business name or title assigned to this custodian account for identification and reporting purposes.',
    `account_number` STRING COMMENT 'The unique account number assigned by the external custodian to identify this custody account. This is the custodians external identifier for the account.',
    `account_opening_date` DATE COMMENT 'The date on which this custodian account was officially opened and became operational.',
    `account_status` STRING COMMENT 'Current operational status of the custodian account. Active accounts are fully operational; inactive accounts are closed; pending_opening accounts are in setup; pending_closure accounts are being wound down; suspended accounts have temporary holds; restricted accounts have operational limitations.. Valid values are `active|inactive|pending_opening|pending_closure|suspended|restricted`',
    `account_type` STRING COMMENT 'Classification of the custodian account based on its purpose and the type of assets held. General account holds assets backing general account liabilities; separate account holds assets for variable products; securities lending accounts facilitate lending programs; collateral accounts hold pledged assets; transition accounts are temporary holding accounts during asset transfers.. Valid values are `general_account|separate_account|securities_lending|collateral|transition`',
    `asset_classes_held` STRING COMMENT 'Comma-separated list of asset classes held in this custodian account (e.g., equities, fixed_income, real_estate, alternatives, cash_equivalents, derivatives). Provides a high-level view of the accounts investment composition.',
    `base_currency_code` STRING COMMENT 'The primary currency in which the custodian account is denominated and reported, using ISO 4217 three-letter currency codes (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `collateral_pledging_allowed` BOOLEAN COMMENT 'Indicates whether assets in this custodian account may be pledged as collateral for derivatives, securities lending, or other purposes. True if pledging is allowed; False if not allowed.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this custodian account record was first created in the system.',
    `custodian_name` STRING COMMENT 'The legal name of the custodian institution providing custody services (e.g., State Street Bank and Trust Company, The Bank of New York Mellon, Northern Trust Company). Denormalized for reporting convenience.',
    `custody_fee_basis` STRING COMMENT 'The method by which custody fees are calculated for this account. Basis_points fees are calculated as a percentage of assets under custody; flat_fee is a fixed periodic amount; tiered uses different rates for different asset levels; transaction_based charges per transaction; hybrid combines multiple methods.. Valid values are `basis_points|flat_fee|tiered|transaction_based|hybrid`',
    `custody_fee_rate` DECIMAL(18,2) COMMENT 'The negotiated fee rate for custody services. For basis_points fee structures, this represents the annual rate in basis points (e.g., 0.000500 = 5 basis points). For flat_fee structures, this represents the periodic fee amount. For tiered structures, this may represent the base tier rate.',
    `fee_calculation_frequency` STRING COMMENT 'The frequency at which custody fees are calculated and assessed for this account.. Valid values are `daily|monthly|quarterly|annually`',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'The amount of fidelity bond or insurance coverage maintained by the custodian to protect assets in this account against loss, theft, or fraud.',
    `insurance_expiration_date` DATE COMMENT 'The expiration date of the custodians fidelity bond or insurance coverage protecting this account.',
    `last_audit_date` DATE COMMENT 'The date of the most recent internal or external audit of this custodian account and its controls.',
    `last_reconciliation_date` DATE COMMENT 'The date of the most recent successful reconciliation between internal investment records and the custodians records for this account.',
    `legal_entity_name` STRING COMMENT 'The legal name of the Life Insurance entity that owns this custodian account (e.g., ABC Life Insurance Company, XYZ Separate Account A). Important for legal ownership and regulatory reporting.',
    `naic_schedule_classification` STRING COMMENT 'The NAIC Annual Statement Schedule(s) to which assets in this custodian account are reported (e.g., Schedule D Part 1 for bonds, Schedule D Part 2 for stocks, Schedule BA for other invested assets). Multiple schedules may apply and should be comma-separated.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review of this custodian account relationship, fee structure, and service quality.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special instructions, or important information about this custodian account that does not fit in structured fields.',
    `performance_rating` STRING COMMENT 'The most recent performance rating assigned to the custodian for services provided to this account, based on service quality, accuracy, timeliness, and responsiveness.. Valid values are `excellent|good|satisfactory|needs_improvement|unsatisfactory`',
    `primary_contact_email` STRING COMMENT 'The email address of the primary relationship manager or contact person at the custodian for this account.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'The name of the primary relationship manager or contact person at the custodian for this account.',
    `primary_contact_phone` STRING COMMENT 'The phone number of the primary relationship manager or contact person at the custodian for this account.',
    `regulatory_classification` STRING COMMENT 'The primary regulatory accounting framework under which assets in this custodian account are reported. Statutory follows NAIC SAP; GAAP follows US Generally Accepted Accounting Principles; IFRS follows International Financial Reporting Standards; tax_basis follows IRS tax accounting rules.. Valid values are `statutory|gaap|ifrs|tax_basis`',
    `safekeeping_location` STRING COMMENT 'The physical or legal jurisdiction where the assets in this custodian account are held in safekeeping (e.g., Boston MA, London UK, Luxembourg). Important for regulatory reporting and legal jurisdiction purposes.',
    `securities_lending_enabled` BOOLEAN COMMENT 'Indicates whether securities lending is authorized for assets held in this custodian account. True if securities lending is permitted; False if not permitted.',
    `settlement_bank_account_number` STRING COMMENT 'The bank account number used for cash settlement of transactions associated with this custodian account.',
    `settlement_bank_name` STRING COMMENT 'The name of the bank used for cash settlement of transactions in this custodian account.',
    `settlement_bank_routing_number` STRING COMMENT 'The ABA routing number or SWIFT code for the settlement bank account, used to facilitate electronic funds transfers.',
    `settlement_instruction_method` STRING COMMENT 'Default settlement instruction method for securities transactions in this account. DVP (Delivery Versus Payment) for securities purchases; RVP (Receive Versus Payment) for securities sales; FOP (Free Of Payment) for transfers without payment; against_payment for cash-settled transactions.. Valid values are `dvp|rvp|fop|against_payment`',
    `soc2_report_date` DATE COMMENT 'The date of the most recent SOC 2 Type II audit report received from the custodian.',
    `soc2_report_on_file` BOOLEAN COMMENT 'Indicates whether a current SOC 2 Type II audit report is on file for the custodian providing services to this account. True if report is on file and current; False otherwise.',
    `subcustodian_used` BOOLEAN COMMENT 'Indicates whether the primary custodian uses subcustodians (local custodians in foreign markets) to hold assets in this account. True if subcustodians are used; False if all assets are held directly by the primary custodian.',
    `tax_identifier` STRING COMMENT 'The tax identification number (TIN) or Employer Identification Number (EIN) associated with the legal entity that owns this custodian account. Used for tax reporting purposes.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this custodian account record was last modified in the system.',
    CONSTRAINT pk_custodian_account PRIMARY KEY(`custodian_account_id`)
) COMMENT 'Master record for investment custodian accounts maintained with external custodians (e.g., State Street, BNY Mellon, Northern Trust) holding general account and separate account assets on behalf of Life Insurance. Captures custodian name, account number, account type (general account, separate account, securities lending), asset classes held, custody fee schedule, settlement instruction defaults, and account status. Distinct from investment.portfolio (which tracks the investment management view) — custodian_account tracks the legal custody and safekeeping relationship with the external custodian entity.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`incident` (
    `incident_id` BIGINT COMMENT 'Unique identifier for the vendor incident record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal user or team responsible for managing and resolving the vendor incident.',
    `issue_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_issue. Business justification: Vendor incidents (service failures, SLA breaches, security events) often create compliance issues requiring formal tracking, remediation, and regulatory reporting. Links vendor incident to compliance ',
    `privacy_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_incident. Business justification: Vendor incidents involving PHI/PII exposure trigger formal privacy incident reporting obligations under HIPAA and state breach notification laws. Links vendor incident to privacy incident record for r',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Incidents must be tracked by reporting period for operational risk disclosures and management reporting. Quarterly operational risk reporting to regulators and board requires incident aggregation by f',
    `service_order_id` BIGINT COMMENT 'Foreign key linking to vendor.service_order. Business justification: Many incidents originate from specific service orders (e.g., failed exam order, delayed report, data quality issue). Linking vendor_incident to service_order provides root cause traceability and enabl',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_contract. Business justification: Incidents occur in the context of specific contracts. Linking vendor_incident to vendor_contract enables tracking which contract was in effect during the incident, supports contract penalty assessment',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor involved in this incident.',
    `related_incident_id` BIGINT COMMENT 'Self-referencing FK on incident (related_incident_id)',
    `affected_claim_count` STRING COMMENT 'Number of insurance claims impacted by the vendor incident, used to quantify the scope of claims processing disruption.',
    `affected_policy_count` STRING COMMENT 'Number of insurance policies impacted by the vendor incident, used to quantify the scope of business disruption.',
    `affected_underwriting_case_count` STRING COMMENT 'Number of underwriting cases impacted by the vendor incident, used to quantify the scope of new business processing disruption.',
    `business_impact_description` STRING COMMENT 'Detailed narrative description of the business impact caused by the vendor incident, including affected business processes, operational disruptions, financial losses, and reputational damage.',
    `closure_date` DATE COMMENT 'The date when the vendor incident record was formally closed after verification of resolution and completion of all documentation and reporting requirements.',
    `contract_penalty_amount` DECIMAL(18,2) COMMENT 'Financial penalty amount assessed against the vendor for this incident per contractual terms, used for vendor performance management and cost recovery.',
    `contract_penalty_applicable_flag` BOOLEAN COMMENT 'Indicates whether contractual penalties or financial remedies are applicable to the vendor as a result of this incident per the vendor contract terms.',
    `corrective_action_plan` STRING COMMENT 'Detailed description of the corrective actions and remediation steps implemented or planned by the vendor to prevent recurrence of similar incidents.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this vendor incident record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `detected_by_method` STRING COMMENT 'The method or channel through which the vendor incident was detected: vendor notification (vendor self-reported), internal audit (discovered during audit), automated monitoring (system alert), customer complaint (policyholder or claimant report), regulatory inquiry (regulator notification), or third party alert (external notification).. Valid values are `vendor_notification|internal_audit|automated_monitoring|customer_complaint|regulatory_inquiry|third_party_alert`',
    `escalation_date` DATE COMMENT 'The date when the vendor incident was escalated to a higher management level due to severity or complexity.',
    `escalation_level` STRING COMMENT 'Current escalation level of the vendor incident within the organization: none (handled at operational level), management (escalated to department management), executive (escalated to C-suite), or board (escalated to Board of Directors).. Valid values are `none|management|executive|board`',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial loss incurred by the organization due to the vendor incident, including direct costs, remediation expenses, and potential penalties.',
    `incident_date` DATE COMMENT 'The date when the vendor incident occurred or was first detected. This is the principal business event timestamp for the incident.',
    `incident_number` STRING COMMENT 'Externally-known unique incident tracking number assigned to this vendor incident for reference and communication purposes.. Valid values are `^INC-[0-9]{8}$`',
    `incident_status` STRING COMMENT 'Current lifecycle status of the vendor incident: reported (incident logged), investigating (root cause analysis in progress), contained (immediate threat mitigated), resolved (corrective actions completed), or closed (incident fully remediated and documented).. Valid values are `reported|investigating|contained|resolved|closed`',
    `incident_type` STRING COMMENT 'Classification of the vendor incident type: service outage (vendor system unavailable), data breach (unauthorized data access), PHI exposure (Protected Health Information disclosure), SLA breach (Service Level Agreement violation), regulatory violation (non-compliance with regulations), or fraud (fraudulent activity detected).. Valid values are `service_outage|data_breach|phi_exposure|sla_breach|regulatory_violation|fraud`',
    `notes` STRING COMMENT 'Additional free-form notes, comments, or observations related to the vendor incident for internal reference and documentation purposes.',
    `phi_exposed_flag` BOOLEAN COMMENT 'Indicates whether Protected Health Information was exposed or compromised during the vendor incident, triggering HIPAA breach notification requirements.',
    `phi_record_count` STRING COMMENT 'Number of Protected Health Information records exposed or compromised during the vendor incident, used for HIPAA breach notification threshold determination.',
    `pii_exposed_flag` BOOLEAN COMMENT 'Indicates whether Personally Identifiable Information was exposed or compromised during the vendor incident, triggering state breach notification requirements.',
    `pii_record_count` STRING COMMENT 'Number of Personally Identifiable Information records exposed or compromised during the vendor incident, used for state breach notification requirements.',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this vendor incident is a recurrence of a previously reported and resolved incident with the same vendor, signaling potential systemic issues.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body to which the vendor incident was reported (e.g., State Department of Insurance, HHS Office for Civil Rights, SEC, FINRA, FinCEN).',
    `regulatory_report_date` DATE COMMENT 'The date when the vendor incident was formally reported to the applicable regulatory authority.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether the vendor incident must be reported to regulatory authorities (state insurance departments, SEC, FINRA, HHS for HIPAA breaches, FinCEN for AML violations).',
    `reported_by` STRING COMMENT 'Name or identifier of the individual or system that reported the vendor incident (vendor contact, internal employee, automated monitoring system).',
    `reported_date` DATE COMMENT 'The date when the vendor incident was formally reported to the organization by the vendor or discovered internally.',
    `resolution_date` DATE COMMENT 'The date when the vendor incident was fully resolved and all corrective actions were completed.',
    `resolution_time_hours` DECIMAL(18,2) COMMENT 'Total number of hours elapsed from incident detection to full resolution, used to measure incident management efficiency.',
    `root_cause_category` STRING COMMENT 'High-level classification of the root cause of the vendor incident: human error (personnel mistake), system failure (technology malfunction), process gap (inadequate procedures), security vulnerability (exploited weakness), third party dependency (cascading failure), or natural disaster (force majeure event).. Valid values are `human_error|system_failure|process_gap|security_vulnerability|third_party_dependency|natural_disaster`',
    `root_cause_description` STRING COMMENT 'Detailed narrative explanation of the root cause analysis findings for the vendor incident, documenting the underlying factors that led to the incident occurrence.',
    `severity_level` STRING COMMENT 'Business impact severity classification of the vendor incident: critical (major business disruption or regulatory exposure), high (significant impact to operations), medium (moderate impact with workarounds available), or low (minimal business impact).. Valid values are `critical|high|medium|low`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the vendor incident constitutes a breach of contractual Service Level Agreement terms, potentially triggering contract penalties or remedies.',
    `sla_metric_breached` STRING COMMENT 'Specific SLA metric that was breached during the vendor incident (e.g., uptime percentage, response time, turnaround time, accuracy rate).',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this vendor incident record was last modified. Used for audit trail and change tracking.',
    `vendor_response_time_hours` DECIMAL(18,2) COMMENT 'Number of hours elapsed between incident detection and the vendors initial response or acknowledgment, used to measure vendor responsiveness.',
    CONSTRAINT pk_incident PRIMARY KEY(`incident_id`)
) COMMENT 'Transactional record of operational incidents, service failures, data breaches, or compliance violations involving a vendor. Captures incident date, vendor, incident type (service outage, data breach, PHI exposure, SLA breach, regulatory violation, fraud), severity level, business impact description, affected policies or underwriting cases, incident status, root cause, and resolution details. Supports vendor risk management escalation, HIPAA breach notification workflows, regulatory reporting obligations, and contract penalty enforcement.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`onboarding` (
    `onboarding_id` BIGINT COMMENT 'Unique identifier for the vendor onboarding record. Primary key for tracking the end-to-end onboarding workflow from initial sourcing through contract execution and activation.',
    `baa_id` BIGINT COMMENT 'Foreign key linking to vendor.baa. Business justification: BAA execution is a critical milestone in vendor onboarding for vendors who will access PHI. The vendor_onboarding table has baa_completed_flag and baa_execution_start_date/completion_date but no FK to',
    `employee_id` BIGINT COMMENT 'Employee identifier of the individual who provided final approval for the vendor onboarding. Used for accountability and audit trail purposes.',
    `onboarding_requestor_employee_id` BIGINT COMMENT 'Employee identifier of the individual who submitted the vendor onboarding request. Used for accountability and follow-up communications.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_contract. Business justification: Vendor onboarding processes culminate in contract execution. The vendor_onboarding table tracks contract_negotiation_start_date and contract_negotiation_completion_date but has no FK to the resulting ',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor being onboarded. Links to the master vendor record in the vendor management system.',
    `vendor_risk_assessment_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_risk_assessment. Business justification: Risk assessment is a mandatory step in vendor onboarding. The vendor_onboarding table has risk_assessment_start_date/completion_date and risk_assessment_completed_flag but no FK to the actual assessme',
    `restarted_onboarding_id` BIGINT COMMENT 'Self-referencing FK on onboarding (restarted_onboarding_id)',
    `activation_date` DATE COMMENT 'Date when the vendor was formally activated for service delivery. Marks the completion of all onboarding gates and the start of operational service delivery.',
    `approval_date` DATE COMMENT 'Date when final management approval was granted for the vendor onboarding. Marks the authorization to proceed with vendor activation.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether formal management approval is required for this vendor onboarding. Typically true for critical or high-risk vendors requiring executive-level sign-off.',
    `approval_status` STRING COMMENT 'Current status of the management approval process for this vendor onboarding. Tracks whether required approvals have been obtained.. Valid values are `pending|approved|rejected|not_required`',
    `baa_execution_completion_date` DATE COMMENT 'Date when the Business Associate Agreement (BAA) execution stage was completed. Indicates that the BAA has been fully executed by all parties and is in effect.',
    `baa_execution_start_date` DATE COMMENT 'Date when the Business Associate Agreement (BAA) execution stage began. Marks the start of HIPAA-compliant BAA preparation and signing process for vendors with access to Protected Health Information (PHI).',
    `cancellation_date` DATE COMMENT 'Date when the vendor onboarding process was cancelled or terminated. Indicates that the onboarding did not proceed to completion.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the vendor onboarding process was cancelled or terminated. Provides context for audit and process improvement purposes.',
    `contract_negotiation_completion_date` DATE COMMENT 'Date when the contract negotiation stage was completed. Indicates that all parties have agreed to final contract terms and the contract is ready for execution.',
    `contract_negotiation_start_date` DATE COMMENT 'Date when the contract negotiation stage began. Marks the start of formal negotiations on contract terms, pricing, service levels, and legal provisions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor onboarding record was first created in the system. Used for audit trail and data lineage tracking.',
    `credential_verification_completed_flag` BOOLEAN COMMENT 'Indicates whether vendor credential and license verification compliance gate has been completed. Ensures vendor holds all required professional licenses, certifications, and registrations.',
    `due_diligence_completion_date` DATE COMMENT 'Date when the due diligence stage was completed. Indicates that all background checks and capability assessments have been finalized and documented.',
    `due_diligence_start_date` DATE COMMENT 'Date when the due diligence stage began. Marks the start of comprehensive vendor background checks, financial stability assessment, and capability verification.',
    `insurance_certificate_completed_flag` BOOLEAN COMMENT 'Indicates whether the insurance certificate compliance gate has been completed. Ensures vendor maintains required liability, errors and omissions, and other insurance coverage.',
    `legal_review_completion_date` DATE COMMENT 'Date when the legal review stage was completed. Indicates that legal counsel has approved the vendor relationship and contract terms.',
    `legal_review_start_date` DATE COMMENT 'Date when the legal review stage began. Marks the start of legal department review of vendor contracts, terms, and compliance requirements.',
    `notes` STRING COMMENT 'Free-form text field for capturing additional information, special instructions, or context related to the vendor onboarding process. Used for documenting exceptions, issues, or important details.',
    `onboarding_status` STRING COMMENT 'Current overall status of the vendor onboarding workflow. Reflects the highest-level state of the onboarding process from initiation through activation. [ENUM-REF-CANDIDATE: initiated|sourcing|due_diligence|risk_assessment|legal_review|contract_negotiation|baa_execution|system_setup|activation|completed|cancelled|on_hold|rejected — promote to reference product]',
    `priority_level` STRING COMMENT 'Priority classification for the vendor onboarding request. Determines the urgency and resource allocation for completing the onboarding process.. Valid values are `urgent|high|normal|low`',
    `request_date` DATE COMMENT 'Date when the vendor onboarding request was formally submitted. Marks the start of the onboarding timeline and is used for Service Level Agreement (SLA) tracking.',
    `request_number` STRING COMMENT 'Business-facing unique identifier for the onboarding request. Used for tracking and reference in communications and approvals.',
    `requestor_business_unit` STRING COMMENT 'Business unit or department that initiated the vendor onboarding request. Identifies the internal sponsor and primary beneficiary of the vendor relationship.',
    `risk_assessment_completion_date` DATE COMMENT 'Date when the risk assessment stage was completed. Indicates that all risk evaluations have been finalized and risk mitigation strategies have been documented.',
    `risk_assessment_start_date` DATE COMMENT 'Date when the risk assessment stage began. Marks the initiation of formal risk evaluation including operational, financial, cybersecurity, and compliance risks.',
    `soc2_audit_completed_flag` BOOLEAN COMMENT 'Indicates whether System and Organization Controls 2 (SOC2) audit review compliance gate has been completed. Required for vendors with access to sensitive data or critical systems.',
    `sourcing_completion_date` DATE COMMENT 'Date when the sourcing stage was completed. Indicates that vendor selection has been finalized and the onboarding process can proceed to due diligence.',
    `sourcing_start_date` DATE COMMENT 'Date when the sourcing stage began. Marks the initiation of vendor identification and preliminary evaluation activities.',
    `stage` STRING COMMENT 'Current stage in the vendor onboarding workflow. Represents the specific phase of work currently in progress. Each stage must be completed before advancing to the next. [ENUM-REF-CANDIDATE: sourcing|due_diligence|risk_assessment|legal_review|contract_negotiation|baa_execution|system_setup|activation — 8 candidates stripped; promote to reference product]',
    `system_setup_completion_date` DATE COMMENT 'Date when the system setup stage was completed. Indicates that all technical integration and system configuration activities have been finalized and tested.',
    `system_setup_start_date` DATE COMMENT 'Date when the system setup stage began. Marks the start of technical integration activities including system access provisioning, data connectivity configuration, and interface testing.',
    `target_activation_date` DATE COMMENT 'Planned or target date for vendor activation. Used for project planning and Service Level Agreement (SLA) tracking throughout the onboarding process.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor onboarding record was last modified. Used for audit trail and tracking the most recent changes to the onboarding workflow.',
    CONSTRAINT pk_onboarding PRIMARY KEY(`onboarding_id`)
) COMMENT 'Master and transactional record tracking the end-to-end vendor onboarding workflow from initial sourcing through contract execution and activation. Captures onboarding request date, requestor business unit, vendor type, onboarding stage (sourcing, due diligence, risk assessment, legal review, contract negotiation, BAA execution, system setup, activation), stage completion dates, approvals required, and overall onboarding status. Ensures all compliance gates (risk assessment, credential verification, BAA, insurance certificate) are completed before a vendor is activated for service delivery.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` (
    `insurance_cert_id` BIGINT COMMENT 'Unique identifier for the vendor insurance certificate record. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who verified the certificate authenticity and compliance. Links to the user or employee master record.',
    `tertiary_insurance_updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last updated this certificate record. Links to the user or employee master record for audit purposes.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_contract. Business justification: Insurance certificates are required by specific contracts to satisfy indemnification and liability provisions. The vendor_insurance_cert table has contract_requirement_met_flag but no FK to the contra',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor providing this certificate of insurance. Links to the vendor master record.',
    `renewed_insurance_cert_id` BIGINT COMMENT 'Self-referencing FK on insurance_cert (renewed_insurance_cert_id)',
    `additional_insured_endorsement` STRING COMMENT 'Specific endorsement number or form that adds the company as an additional insured. Common forms include CG 20 10, CG 20 37.',
    `additional_insured_flag` BOOLEAN COMMENT 'Indicates whether the company is named as an additional insured on the vendors policy. True means the company has direct coverage under the vendors policy.',
    `cancellation_notice_days` STRING COMMENT 'Number of days advance notice the certificate holder will receive if the policy is cancelled. Typically 30 or 10 days depending on cancellation reason.',
    `certificate_holder_address` STRING COMMENT 'Full mailing address of the certificate holder. Used for certificate delivery and legal notices.',
    `certificate_holder_name` STRING COMMENT 'Legal name of the entity to whom the certificate is issued. Typically the companys legal name.',
    `certificate_issue_date` DATE COMMENT 'Date when the certificate of insurance was issued by the producer. May differ from the coverage effective date.',
    `certificate_number` STRING COMMENT 'Unique certificate number assigned by the insurance broker or agent issuing the certificate of insurance. This is the externally-known identifier for the COI document.',
    `certificate_received_date` DATE COMMENT 'Date when the company received the certificate from the vendor. Used to track vendor compliance with certificate submission requirements.',
    `certificate_type` STRING COMMENT 'Type of insurance coverage documented by this certificate. Categorizes the primary coverage class. [ENUM-REF-CANDIDATE: general_liability|professional_liability|cyber_liability|workers_compensation|umbrella|commercial_auto|property|crime|fiduciary — 9 candidates stripped; promote to reference product]',
    `contract_requirement_met_flag` BOOLEAN COMMENT 'Indicates whether this certificate meets all insurance requirements specified in the vendor contract. True means the certificate is compliant with contractual terms.',
    `coverage_limit_aggregate` DECIMAL(18,2) COMMENT 'Maximum total amount the insurer will pay for all claims during the policy period. Expressed in the policy currency.',
    `coverage_limit_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the coverage limits. Typically USD for US-domiciled vendors.. Valid values are `^[A-Z]{3}$`',
    `coverage_limit_per_occurrence` DECIMAL(18,2) COMMENT 'Maximum amount the insurer will pay for a single claim or occurrence under this policy. Expressed in the policy currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certificate record was first created in the system. Part of the audit trail.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Amount the insured vendor must pay out-of-pocket before insurance coverage applies. Expressed in the policy currency.',
    `document_storage_location` STRING COMMENT 'File path or URI where the physical certificate document is stored in the document management system.',
    `effective_date` DATE COMMENT 'Date when the insurance coverage documented by this certificate becomes active and enforceable.',
    `expiration_date` DATE COMMENT 'Date when the insurance coverage documented by this certificate terminates. Critical for tracking certificate renewal requirements.',
    `insurance_cert_status` STRING COMMENT 'Current lifecycle status of the certificate of insurance. Indicates whether the certificate is currently valid and enforceable.. Valid values are `active|expired|cancelled|pending_renewal|suspended|replaced`',
    `issuing_insurer_am_best_rating` STRING COMMENT 'AM Best financial strength rating of the issuing insurance carrier at the time of certificate issuance. Used to assess carrier creditworthiness.. Valid values are `^[A-F][+-]?$|NR`',
    `issuing_insurer_naic_number` STRING COMMENT 'Five-digit NAIC company code uniquely identifying the insurance carrier. Used to verify carrier legitimacy and financial strength.. Valid values are `^[0-9]{5}$`',
    `issuing_insurer_name` STRING COMMENT 'Name of the insurance carrier providing the underlying coverage documented in this certificate.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the certificate, verification process, or compliance issues.',
    `policy_number` STRING COMMENT 'Insurance policy number under which the coverage is provided. References the underlying insurance contract.',
    `primary_noncontributory_flag` BOOLEAN COMMENT 'Indicates whether the vendors insurance is primary and noncontributory to any insurance carried by the company. True means the vendors policy pays first.',
    `producer_contact_name` STRING COMMENT 'Name of the specific contact person at the insurance broker or agency for certificate inquiries.',
    `producer_email_address` STRING COMMENT 'Email address of the insurance broker or agent for electronic certificate delivery and correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `producer_name` STRING COMMENT 'Name of the insurance broker or agent who issued the certificate on behalf of the insurer.',
    `producer_phone_number` STRING COMMENT 'Phone number of the insurance broker or agent for certificate verification and renewal coordination.',
    `renewal_reminder_sent_date` DATE COMMENT 'Date when a renewal reminder was sent to the vendor requesting an updated certificate prior to expiration.',
    `special_provisions` STRING COMMENT 'Free-text field capturing any special provisions, endorsements, or coverage modifications noted on the certificate that require attention.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this certificate record was last modified. Part of the audit trail for tracking changes.',
    `verification_status` STRING COMMENT 'Status of the certificate verification process. Indicates whether the certificate authenticity and coverage details have been confirmed with the insurer.. Valid values are `verified|pending_verification|rejected|not_verified`',
    `verified_date` DATE COMMENT 'Date when the certificate was verified for authenticity and contract compliance.',
    `waiver_of_subrogation_flag` BOOLEAN COMMENT 'Indicates whether the vendors insurer has waived its right to subrogate against the company. True means the insurer cannot pursue recovery from the company.',
    CONSTRAINT pk_insurance_cert PRIMARY KEY(`insurance_cert_id`)
) COMMENT 'Master record tracking certificates of insurance (COIs) provided by vendors as evidence of their own insurance coverage — general liability, professional liability (E&O), cyber liability, workers compensation, and umbrella coverage. Captures certificate number, issuing insurer, coverage type, policy number, coverage limits, effective and expiration dates, additional insured status, and certificate status. Required for all vendors performing on-site services, handling PHI, or providing technology services. Supports vendor risk management and contract compliance verification.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` (
    `contract_amendment_id` BIGINT COMMENT 'Unique identifier for the contract amendment record. Primary key for the contract amendment entity.',
    `parent_amendment_contract_amendment_id` BIGINT COMMENT 'Reference to a parent amendment if this amendment is a sub-amendment or modification of a previous amendment. Supports hierarchical amendment structures.',
    `employee_id` BIGINT COMMENT 'Reference to the internal employee who initiated or requested the amendment. Used for tracking accountability and approval workflows.',
    `primary_superseded_by_amendment_contract_amendment_id` BIGINT COMMENT 'Reference to a later amendment that supersedes or replaces this amendment. Used for tracking amendment chains and ensuring correct contract term reconstruction.',
    `quaternary_contract_employee_id` BIGINT COMMENT 'Reference to the system user who created this amendment record. Used for audit trail and accountability tracking.',
    `quinary_contract_updated_by_user_employee_id` BIGINT COMMENT 'Reference to the system user who last modified this amendment record. Used for audit trail and change tracking.',
    `tertiary_contract_rejected_by_employee_id` BIGINT COMMENT 'Reference to the employee who rejected the amendment. Used for audit trail and decision tracking.',
    `vendor_contract_id` BIGINT COMMENT 'Reference to the parent vendor contract being amended. Links this amendment to the original contract record.',
    `superseded_contract_amendment_id` BIGINT COMMENT 'Self-referencing FK on contract_amendment (superseded_contract_amendment_id)',
    `amendment_description` STRING COMMENT 'Detailed narrative description of the changes being made by this amendment. Includes the business rationale, specific clauses modified, and impact on existing contract terms.',
    `amendment_number` STRING COMMENT 'Sequential or hierarchical identifier for this amendment within the contract (e.g., Amendment 001, A-1, 2023-01). Used for ordering and referencing amendments in legal and operational contexts.',
    `amendment_status` STRING COMMENT 'Current lifecycle status of the amendment. Tracks the amendment through drafting, approval, execution, and potential rejection or supersession by later amendments.. Valid values are `draft|pending_approval|approved|executed|rejected|superseded`',
    `amendment_title` STRING COMMENT 'Brief descriptive title or subject line for the amendment (e.g., Pricing Adjustment for 2024, Addition of MIB Services). Provides quick identification of the amendment purpose.',
    `amendment_type` STRING COMMENT 'Classification of the amendment based on the nature of the change being made to the contract. Determines the approval workflow and documentation requirements.. Valid values are `scope_change|pricing_adjustment|term_extension|sla_modification|regulatory_update|service_addition`',
    `approval_date` DATE COMMENT 'Date on which the amendment received final internal approval and was authorized for execution. Critical milestone in the amendment lifecycle.',
    `approval_level_required` STRING COMMENT 'Highest organizational level required to approve this amendment based on financial impact, risk assessment, and contract governance policies.. Valid values are `manager|director|vp|svp|executive|board`',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether formal approval workflow is required for this amendment based on financial thresholds, risk level, or contract governance policies.',
    `company_signature_date` DATE COMMENT 'Date on which the company signed the amendment. Used for tracking execution timeline and ensuring all parties have executed before the amendment becomes binding.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this amendment record was first created in the data platform. Used for audit trail and data lineage tracking.',
    `document_location` STRING COMMENT 'File path, URL, or document management system reference to the executed amendment document. Critical for audit, compliance, and dispute resolution.',
    `effective_date` DATE COMMENT 'Date on which the amendment terms become binding and enforceable. Critical for reconstructing contract terms at any point in time for audit and dispute resolution.',
    `execution_date` DATE COMMENT 'Date on which all parties signed the amendment, making it legally binding. May differ from effective date if the amendment specifies a future effective date.',
    `expiration_date` DATE COMMENT 'Date on which the amendment terms expire or are superseded. Nullable for amendments that permanently modify the contract without a defined end date.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Net financial impact of the amendment on the total contract value. Positive values indicate increased cost, negative values indicate savings. Used for budget tracking and financial planning.',
    `financial_impact_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount (e.g., USD, EUR, GBP). Ensures proper currency handling for multi-currency vendor relationships.. Valid values are `^[A-Z]{3}$`',
    `initiated_by_party` STRING COMMENT 'Identifies which party initiated the amendment request. Used for tracking amendment patterns and negotiation dynamics.. Valid values are `vendor|company|mutual`',
    `legal_review_completed_date` DATE COMMENT 'Date on which legal department completed their review of the amendment. Used for tracking approval workflow progress and cycle time analysis.',
    `legal_review_required_flag` BOOLEAN COMMENT 'Indicates whether legal department review and approval is required for this amendment based on risk assessment, financial impact, or contract governance policies.',
    `notes` STRING COMMENT 'Free-form text field for additional context, special instructions, negotiation history, or operational notes related to the amendment. Used for knowledge capture and future reference.',
    `pricing_adjustment_percentage` DECIMAL(18,2) COMMENT 'Percentage change in pricing terms (e.g., 5.00 for 5% increase, -3.50 for 3.5% decrease). Applicable when amendment_type is pricing_adjustment. Used for rate card updates and cost analysis.',
    `regulatory_compliance_reason` STRING COMMENT 'Explanation of the regulatory or compliance requirement driving this amendment. Applicable when amendment_type is regulatory_update. References specific regulations, NAIC guidelines, or state insurance department requirements.',
    `rejection_date` DATE COMMENT 'Date on which the amendment was formally rejected. Marks the end of the amendment process for rejected amendments.',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the amendment was rejected by either party. Applicable when amendment_status is rejected. Used for lessons learned and vendor relationship management.',
    `requested_date` DATE COMMENT 'Date on which the amendment was formally requested by either party. Marks the beginning of the amendment negotiation and approval process.',
    `revised_contract_value_amount` DECIMAL(18,2) COMMENT 'Total contract value after applying this amendment. Represents the cumulative contract value including all prior amendments and this current amendment.',
    `revised_expiration_date` DATE COMMENT 'New contract expiration date after applying this amendment. Applicable when the amendment modifies the contract term or end date.',
    `scope_change_description` STRING COMMENT 'Detailed description of changes to the scope of services or deliverables covered by the contract. Applicable when amendment_type is scope_change or service_addition.',
    `sla_modification_description` STRING COMMENT 'Detailed description of changes to service level agreements, performance metrics, or quality standards. Applicable when amendment_type is sla_modification.',
    `term_extension_months` STRING COMMENT 'Number of months by which the contract term is extended. Applicable when amendment_type is term_extension. Positive values extend the contract, negative values shorten it.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this amendment record was last modified. Used for audit trail, change tracking, and data quality monitoring.',
    `vendor_signature_date` DATE COMMENT 'Date on which the vendor signed the amendment. Used for tracking execution timeline and ensuring all parties have executed before the amendment becomes binding.',
    CONSTRAINT pk_contract_amendment PRIMARY KEY(`contract_amendment_id`)
) COMMENT 'Transactional record of each formal amendment, addendum, or change order executed against an existing vendor contract. Captures amendment number, amendment type (scope change, pricing adjustment, term extension, SLA modification, regulatory update), effective date, description of changes, financial impact, approval chain, and execution status. Maintains the complete amendment history for each vendor contract, enabling reconstruction of the full contractual terms at any point in time for audit and dispute resolution purposes.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`spend` (
    `spend_id` BIGINT COMMENT 'Unique identifier for the vendor spend transaction record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Finance managers approve vendor spend allocations against budget. Tracks approver for budget authority validation, SOX compliance, and financial audit trail in vendor expense management.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Vendor spend summaries roll up to GL accounts for financial statement preparation, monthly close, and expense reporting. Required for consolidation and external financial reporting compliance.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Spend analytics by cost center support budget management, variance analysis, and forecasting. Essential for management reporting and cost control in insurance operations.',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Vendor spend aggregations are inherently period-based for expense reporting and budget variance analysis. Monthly/quarterly management reporting and annual budget review require spend data aligned wit',
    `vendor_contract_id` BIGINT COMMENT 'Reference to the vendor contract under which this spend was incurred, if applicable.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor who provided the service or product for which spend is being recorded.',
    `adjustment_spend_id` BIGINT COMMENT 'Self-referencing FK on spend (adjustment_spend_id)',
    `accrued_amount` DECIMAL(18,2) COMMENT 'The estimated amount accrued for services received but not yet invoiced during the spend period, used for accurate period-end financial reporting.',
    `actual_invoiced_amount` DECIMAL(18,2) COMMENT 'The actual amount invoiced by the vendor for services rendered during the spend period, representing confirmed spend based on received invoices.',
    `approval_date` DATE COMMENT 'The date on which the spend record was approved.',
    `approval_status` STRING COMMENT 'The approval status of the spend record, indicating whether the spend has been reviewed and approved by the appropriate authority.. Valid values are `pending|approved|rejected`',
    `budget_allocation_amount` DECIMAL(18,2) COMMENT 'The budgeted amount allocated for this vendor, service category, and cost center for the spend period, used for budget variance analysis.',
    `budget_variance_amount` DECIMAL(18,2) COMMENT 'The variance between total spend amount and budget allocation amount, calculated as total spend minus budget allocation. Positive values indicate over-budget, negative values indicate under-budget.',
    `budget_variance_percentage` DECIMAL(18,2) COMMENT 'The budget variance expressed as a percentage of the budget allocation amount, calculated as (budget variance amount / budget allocation amount) * 100.',
    `business_unit_code` STRING COMMENT 'The business unit code to which this vendor spend is allocated, enabling spend visibility and analysis at the business unit level.',
    `category_manager` STRING COMMENT 'The name or identifier of the category manager responsible for managing vendor relationships and spend within this service category.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this vendor spend record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the spend amounts are denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `fiscal_month` STRING COMMENT 'The fiscal month (1-12) in which the spend period falls, used for monthly budget tracking.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter (1-4) in which the spend period falls, used for quarterly budget tracking.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the spend period falls, used for annual budget tracking and variance analysis.',
    `invoice_count` STRING COMMENT 'The number of vendor invoices included in this spend record for the period, providing visibility into transaction volume.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, explanations, or context regarding the vendor spend record, such as reasons for budget variances or special circumstances.',
    `payment_status` STRING COMMENT 'The current payment status of the spend record, indicating whether invoices have been paid, are pending payment, are in dispute, or have been cancelled.. Valid values are `pending|paid|partially_paid|disputed|cancelled`',
    `period_end_date` DATE COMMENT 'The ending date of the period for which this spend is being recorded.',
    `period_start_date` DATE COMMENT 'The beginning date of the period for which this spend is being recorded (e.g., monthly, quarterly).',
    `reconciliation_date` DATE COMMENT 'The date on which the spend record was reconciled.',
    `reconciliation_status` STRING COMMENT 'The reconciliation status indicating whether the spend record has been reconciled against vendor invoices, purchase orders, and budget allocations.. Valid values are `pending|reconciled|variance_identified|under_review`',
    `service_category` STRING COMMENT 'The category of service provided by the vendor for which spend is recorded. Categories include medical exam services (ExamOne, APPS), data services (MIB, prescription databases), third-party administration (TPA), IT services, custodial services (investment custodians), and reinsurance intermediary services.. Valid values are `medical_exam|data_services|tpa_administration|it_services|custodial_services|reinsurance_intermediary`',
    `service_order_count` STRING COMMENT 'The number of service orders fulfilled by the vendor during the spend period, providing operational volume metrics.',
    `service_subcategory` STRING COMMENT 'A more granular classification within the service category, providing additional detail on the specific type of service (e.g., paramedical exam, full medical exam, prescription history report, policy administration).',
    `spend_type` STRING COMMENT 'Classification of the spend as direct (directly attributable to revenue-generating activities), indirect (overhead/support), capital (asset acquisition), or operating (day-to-day operations).. Valid values are `direct|indirect|capital|operating`',
    `total_spend_amount` DECIMAL(18,2) COMMENT 'The total spend amount for the period, calculated as the sum of actual invoiced amount and accrued amount, representing the complete financial obligation for the period.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this vendor spend record was last updated in the system.',
    CONSTRAINT pk_spend PRIMARY KEY(`spend_id`)
) COMMENT 'Periodic transactional record capturing actual and accrued spend by vendor, contract, service category, and cost center allocation for management reporting and budget tracking. Captures spend period, vendor, contract reference, service category (medical exam, data services, TPA administration, IT services, custodial services, reinsurance intermediary), actual invoiced amount, accrued amount, budget allocation, cost center, and GL account code. Provides the vendor domains SSOT for spend visibility, enabling category management, budget variance analysis, and vendor consolidation decisions. Distinct from finance.journal_entry which records the accounting treatment.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` (
    `preferred_vendor_id` BIGINT COMMENT 'Unique identifier for the preferred vendor record. Primary key.',
    `employee_id` BIGINT COMMENT 'The employee identifier of the business owner or relationship manager responsible for this preferred vendor relationship.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor master record that holds this preferred status.',
    `superseded_preferred_vendor_id` BIGINT COMMENT 'Self-referencing FK on preferred_vendor (superseded_preferred_vendor_id)',
    `approval_basis` STRING COMMENT 'The rationale or criteria upon which the preferred vendor status was granted (e.g., competitive pricing, service quality, compliance record, strategic partnership).',
    `approval_date` DATE COMMENT 'The date on which the vendor was granted preferred status for this service category.',
    `approving_committee` STRING COMMENT 'The name of the committee or governance body that approved the preferred vendor designation (e.g., Vendor Management Committee, Procurement Board, Executive Committee).',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the preferred vendor status automatically renews upon expiration without additional approval.',
    `compliance_certification_required` STRING COMMENT 'The compliance certifications required to maintain preferred vendor status (e.g., SOC 2, HIPAA, ISO 27001, state insurance department approval).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this preferred vendor record was first created in the system.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this vendor has exclusive preferred status for the service category, meaning no other vendors in the category may be engaged without exception approval.',
    `geographic_coverage_detail` STRING COMMENT 'Detailed specification of the geographic coverage, such as specific states, regions, or territories where the preferred status is valid.',
    `geographic_scope` STRING COMMENT 'The geographic coverage area for which this preferred vendor status applies (national, regional, or state-specific).. Valid values are `national|regional|state_specific`',
    `last_performance_review_date` DATE COMMENT 'The date of the most recent performance review conducted for this preferred vendor.',
    `next_performance_review_date` DATE COMMENT 'The scheduled date for the next performance review of this preferred vendor.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this preferred vendor designation.',
    `performance_score` DECIMAL(18,2) COMMENT 'The most recent performance score assigned to this preferred vendor based on quality, timeliness, compliance, and service delivery metrics.',
    `preferred_status_effective_date` DATE COMMENT 'The date from which the preferred vendor status becomes active and enforceable.',
    `preferred_status_expiration_date` DATE COMMENT 'The date on which the preferred vendor status expires and requires renewal or re-evaluation.',
    `preferred_vendor_status` STRING COMMENT 'The current lifecycle status of the preferred vendor designation.. Valid values are `active|suspended|expired|terminated|under_review`',
    `pricing_tier` STRING COMMENT 'The negotiated pricing tier or discount level applicable to this preferred vendor relationship.',
    `procurement_approval_required_flag` BOOLEAN COMMENT 'Indicates whether additional procurement approval is required for new service orders with this preferred vendor, or if the preferred status allows automatic engagement.',
    `renewal_notice_period_days` STRING COMMENT 'The number of days prior to expiration that renewal notification or review must occur.',
    `service_category` STRING COMMENT 'The category of service for which this vendor holds preferred status (e.g., medical exam providers like ExamOne/APPS, MIB services, prescription database providers, reinsurance intermediaries, investment custodians, IT service providers, or third-party administration). [ENUM-REF-CANDIDATE: medical_exam|mib_services|prescription_database|reinsurance_intermediary|investment_custodian|it_services|tpa_administration — 7 candidates stripped; promote to reference product]',
    `sla_tier` STRING COMMENT 'The service level agreement tier that defines performance expectations and commitments for this preferred vendor.',
    `strategic_partnership_flag` BOOLEAN COMMENT 'Indicates whether this preferred vendor relationship is designated as a strategic partnership with enhanced collaboration and integration.',
    `suspension_date` DATE COMMENT 'The date on which the preferred vendor status was suspended.',
    `suspension_reason` STRING COMMENT 'The reason for suspension of preferred vendor status, if applicable (e.g., performance issues, compliance violations, contract disputes).',
    `termination_date` DATE COMMENT 'The date on which the preferred vendor status was terminated.',
    `termination_reason` STRING COMMENT 'The reason for termination of preferred vendor status (e.g., contract expiration, performance failure, strategic change, vendor exit from market).',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this preferred vendor record was last updated.',
    `vendor_consolidation_initiative_flag` BOOLEAN COMMENT 'Indicates whether this preferred vendor designation is part of a vendor consolidation initiative to reduce vendor count and improve efficiency.',
    `vendor_tier` STRING COMMENT 'The tier classification indicating the level of preference and approval status for this vendor within the service category.. Valid values are `preferred|approved|conditional|restricted`',
    `volume_commitment_amount` DECIMAL(18,2) COMMENT 'The minimum volume or dollar amount of business committed to this vendor as part of the preferred vendor agreement.',
    `volume_commitment_unit` STRING COMMENT 'The unit of measure for the volume commitment (e.g., USD, number of exams, number of policies, number of transactions).',
    CONSTRAINT pk_preferred_vendor PRIMARY KEY(`preferred_vendor_id`)
) COMMENT 'Reference master defining Life Insurances approved and preferred vendor list by service category and geographic scope. Captures service category, vendor tier (preferred, approved, conditional, restricted), approval basis, approval date, approving committee, geographic scope (national, regional, state-specific), volume commitment, and preferred status expiration. Governs which vendors may be engaged for new service orders without additional procurement approval. Supports sourcing strategy, vendor consolidation initiatives, and procurement policy compliance.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`contract_credential_requirement` (
    `contract_credential_requirement_id` BIGINT COMMENT 'Unique identifier for this contract credential requirement record. Primary key.',
    `credential_id` BIGINT COMMENT 'Foreign key linking to the specific vendor credential required by the contract',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to the vendor contract that imposes this credential requirement',
    `compliance_status` STRING COMMENT 'Current compliance status of this specific credential requirement. Indicates whether the vendor currently meets this contractual credential obligation.',
    `last_verification_date` DATE COMMENT 'Most recent date on which compliance with this credential requirement was verified by vendor management or compliance team.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this credential is absolutely mandatory for contract performance (true) or preferred but not required (false).',
    `next_verification_due_date` DATE COMMENT 'Date by which the next verification of this credential requirement must be completed to maintain continuous compliance monitoring.',
    `non_compliance_action` STRING COMMENT 'Contractual consequence or remediation action if vendor fails to maintain this credential (e.g., suspend services, terminate contract, cure period granted).',
    `requirement_effective_date` DATE COMMENT 'Date on which this credential requirement becomes effective for the contract. May differ from contract effective date if added via amendment.',
    `requirement_expiration_date` DATE COMMENT 'Date on which this credential requirement expires or is no longer mandatory for the contract. Null indicates ongoing requirement.',
    `requirement_source` STRING COMMENT 'Source document or event that established this credential requirement (original contract, subsequent amendment, regulatory mandate, etc.).',
    `verification_date` DATE COMMENT 'Date on which this credential was last verified as meeting the contract requirement. Used to track periodic compliance verification cycles.',
    `waiver_expiration_date` DATE COMMENT 'Date on which the granted waiver expires and the credential requirement becomes mandatory again. Null if no waiver granted.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Indicates whether a temporary waiver has been granted for this credential requirement, allowing the vendor to perform services without the credential for a limited period.',
    `waiver_reason` STRING COMMENT 'Business justification for granting a waiver to this credential requirement (e.g., credential renewal in progress, alternative credential accepted, limited scope services).',
    CONSTRAINT pk_contract_credential_requirement PRIMARY KEY(`contract_credential_requirement_id`)
) COMMENT 'This association product represents the compliance requirement relationship between vendor contracts and vendor credentials. It captures which credentials are required by which contracts, when requirements become effective, verification status, and waiver provisions. Each record links one vendor_contract to one vendor_credential with attributes that exist only in the context of this contractual compliance requirement.. Existence Justification: In life insurance vendor management, contracts routinely require multiple credentials (state licenses, HIPAA certification, SOC 2, TPA licenses, etc.), and a single credential (e.g., a state insurance license) is required by multiple contracts across different service agreements. The business actively manages a compliance matrix tracking which credentials are required by which contracts, when requirements were added (often via amendments), verification status, waiver provisions, and expiration tracking. This is a core operational function in vendor risk management and regulatory compliance.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`policy_compliance` (
    `policy_compliance_id` BIGINT COMMENT 'Unique surrogate identifier for each vendor-policy compliance record',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key to compliance_policy - the policy that applies to this vendor',
    `policy_compliance_policy_id` BIGINT COMMENT 'Foreign key linking to the compliance policy that applies to this vendor',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor subject to this compliance policy',
    `attestation_date` DATE COMMENT 'The date on which the vendor provided formal attestation or certification of compliance with this specific policy requirement',
    `audit_finding_reference` STRING COMMENT 'Reference to any audit findings or regulatory examination issues related to this vendor-policy compliance record',
    `compliance_owner` STRING COMMENT 'The individual or role responsible for monitoring and ensuring this vendors compliance with this specific policy',
    `compliance_status` STRING COMMENT 'Current compliance status of this vendor with respect to this specific policy. Values: compliant, non_compliant, pending_review, exception_granted, not_applicable',
    `exception_expiration_date` DATE COMMENT 'The date on which any granted exception expires and full compliance is required',
    `exception_flag` BOOLEAN COMMENT 'Indicates whether a formal exception or waiver has been granted for this vendor-policy combination, typically requiring executive approval',
    `exception_justification` STRING COMMENT 'Business justification and approval documentation for any exception granted to this vendor for this policy requirement',
    `last_review_date` DATE COMMENT 'The date on which the most recent compliance review or assessment was conducted for this vendor-policy combination',
    `next_review_date` DATE COMMENT 'The scheduled date for the next compliance review or reassessment of this vendor against this policy',
    `policy_applicability_date` DATE COMMENT 'The date on which this compliance policy became applicable to this specific vendor, typically driven by contract start date, vendor type classification, or regulatory trigger event',
    `remediation_plan_reference` STRING COMMENT 'Document reference or identifier for any remediation plan in place to address non-compliance for this vendor-policy combination',
    `vendor_contact_for_policy` STRING COMMENT 'The specific contact person at the vendor organization responsible for compliance with this policy requirement',
    CONSTRAINT pk_policy_compliance PRIMARY KEY(`policy_compliance_id`)
) COMMENT 'This association product represents the compliance relationship between compliance policies and vendors. It captures the applicability of specific compliance policies to individual vendors, tracking compliance status, attestation dates, and exceptions. Each record links one compliance_policy to one vendor with attributes that exist only in the context of this regulatory oversight relationship.. Existence Justification: In life insurance operations, a single compliance policy (e.g., data protection, SOX, information security) applies to multiple vendors across different service categories, and each vendor is subject to multiple compliance policies based on their vendor type, risk tier, and services provided. The compliance team actively manages vendor-policy applicability, tracks compliance status, collects attestations, grants exceptions, and schedules periodic reviews for each vendor-policy combination.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`vendor`.`vendor_bank_account` (
    `vendor_bank_account_id` BIGINT COMMENT 'Primary key for vendor_bank_account',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor who owns this bank account. Links to the vendor master entity.',
    `superseded_vendor_bank_account_id` BIGINT COMMENT 'Self-referencing FK on vendor_bank_account (superseded_vendor_bank_account_id)',
    `account_name` STRING COMMENT 'The legal name on the bank account as registered with the financial institution. Must match vendor legal name for payment processing.',
    `account_number` STRING COMMENT 'The unique bank account number assigned by the financial institution. Sensitive financial information requiring restricted access.',
    `account_status` STRING COMMENT 'Current operational status of the vendor bank account indicating whether it can be used for payment processing.',
    `account_type` STRING COMMENT 'Classification of the bank account type indicating the nature of the account and permissible transaction types.',
    `bank_address_line1` STRING COMMENT 'The primary street address line of the financial institution or branch holding the account.',
    `bank_address_line2` STRING COMMENT 'The secondary address line for the financial institution, such as suite or building number.',
    `bank_branch_code` STRING COMMENT 'The unique identifier code for the bank branch, used in some jurisdictions for payment routing.',
    `bank_branch_name` STRING COMMENT 'The name of the specific bank branch where the account is held, if applicable.',
    `bank_city` STRING COMMENT 'The city where the financial institution or branch is located.',
    `bank_country_code` STRING COMMENT 'The three-letter ISO country code indicating the country where the financial institution is domiciled.',
    `bank_name` STRING COMMENT 'The legal name of the financial institution holding the account.',
    `bank_postal_code` STRING COMMENT 'The postal or ZIP code for the financial institution or branch address.',
    `bank_routing_number` STRING COMMENT 'The nine-digit American Bankers Association (ABA) routing transit number identifying the financial institution for electronic funds transfer.',
    `bank_state_province` STRING COMMENT 'The state or province where the financial institution or branch is located.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this bank account record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO currency code indicating the native currency of the bank account (e.g., USD, EUR, GBP, CAD).',
    `effective_end_date` DATE COMMENT 'The date when this bank account is no longer valid for payment processing. Null indicates an open-ended active account.',
    `effective_start_date` DATE COMMENT 'The date from which this bank account becomes active and eligible for payment processing.',
    `iban` STRING COMMENT 'The standardized international bank account number used for identifying bank accounts across national borders, primarily in European and other international transactions.',
    `intermediary_bank_name` STRING COMMENT 'The name of the intermediary or correspondent bank used for international wire transfers when direct routing is not available.',
    `intermediary_bank_swift_code` STRING COMMENT 'The SWIFT/BIC code of the intermediary bank used in the payment routing chain for international transactions.',
    `is_primary_account` BOOLEAN COMMENT 'Boolean flag indicating whether this is the primary or default bank account for payments to this vendor. Only one account per vendor should be marked as primary.',
    `last_payment_date` DATE COMMENT 'The date of the most recent payment transaction processed to this bank account.',
    `maximum_payment_amount` DECIMAL(18,2) COMMENT 'The maximum single payment amount allowed for this account, often set for risk management and fraud prevention purposes.',
    `minimum_payment_amount` DECIMAL(18,2) COMMENT 'The minimum payment amount threshold required for processing payments to this account, if applicable.',
    `modified_by` STRING COMMENT 'The user identifier or system account that last modified this bank account record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this bank account record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text field for internal notes, comments, or additional context about this vendor bank account.',
    `payment_frequency` STRING COMMENT 'The typical or scheduled frequency at which payments are made to this vendor bank account.',
    `payment_method_supported` STRING COMMENT 'The primary payment method or electronic funds transfer mechanism supported by this bank account (ACH for US, SEPA for Europe, BACS for UK, etc.).',
    `special_instructions` STRING COMMENT 'Free-text field containing any special instructions, reference codes, or notes required for payment processing to this account.',
    `swift_code` STRING COMMENT 'The international bank identifier code (BIC/SWIFT) used for international wire transfers and cross-border payments. Required for international vendor payments.',
    `tax_reporting_required` BOOLEAN COMMENT 'Boolean flag indicating whether payments to this account require tax reporting (e.g., 1099 reporting for US vendors).',
    `verification_date` DATE COMMENT 'The date when the bank account was successfully verified and approved for use in payment processing.',
    `verification_method` STRING COMMENT 'The method used to verify the authenticity and accuracy of the bank account information.',
    `verification_status` STRING COMMENT 'Status indicating whether the bank account details have been verified through micro-deposits, third-party validation, or other verification methods.',
    `created_by` STRING COMMENT 'The user identifier or system account that created this bank account record.',
    CONSTRAINT pk_vendor_bank_account PRIMARY KEY(`vendor_bank_account_id`)
) COMMENT 'Master reference table for vendor_bank_account. Referenced by vendor_bank_account_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ADD CONSTRAINT `fk_vendor_vendor_parent_vendor_id` FOREIGN KEY (`parent_vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ADD CONSTRAINT `fk_vendor_vendor_contract_parent_contract_vendor_contract_id` FOREIGN KEY (`parent_contract_vendor_contract_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ADD CONSTRAINT `fk_vendor_vendor_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ADD CONSTRAINT `fk_vendor_vendor_contract_renewed_vendor_contract_id` FOREIGN KEY (`renewed_vendor_contract_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ADD CONSTRAINT `fk_vendor_contact_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ADD CONSTRAINT `fk_vendor_contact_reports_to_contact_id` FOREIGN KEY (`reports_to_contact_id`) REFERENCES `life_insurance_ecm`.`vendor`.`contact`(`contact_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ADD CONSTRAINT `fk_vendor_service_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ADD CONSTRAINT `fk_vendor_service_order_follow_up_service_order_id` FOREIGN KEY (`follow_up_service_order_id`) REFERENCES `life_insurance_ecm`.`vendor`.`service_order`(`service_order_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_service_order_id` FOREIGN KEY (`service_order_id`) REFERENCES `life_insurance_ecm`.`vendor`.`service_order`(`service_order_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_credited_invoice_id` FOREIGN KEY (`credited_invoice_id`) REFERENCES `life_insurance_ecm`.`vendor`.`invoice`(`invoice_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ADD CONSTRAINT `fk_vendor_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `life_insurance_ecm`.`vendor`.`invoice`(`invoice_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ADD CONSTRAINT `fk_vendor_invoice_line_service_order_id` FOREIGN KEY (`service_order_id`) REFERENCES `life_insurance_ecm`.`vendor`.`service_order`(`service_order_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ADD CONSTRAINT `fk_vendor_invoice_line_credited_invoice_line_id` FOREIGN KEY (`credited_invoice_line_id`) REFERENCES `life_insurance_ecm`.`vendor`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ADD CONSTRAINT `fk_vendor_vendor_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `life_insurance_ecm`.`vendor`.`invoice`(`invoice_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ADD CONSTRAINT `fk_vendor_vendor_payment_vendor_bank_account_id` FOREIGN KEY (`vendor_bank_account_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor_bank_account`(`vendor_bank_account_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ADD CONSTRAINT `fk_vendor_vendor_payment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ADD CONSTRAINT `fk_vendor_vendor_payment_reversal_vendor_payment_id` FOREIGN KEY (`reversal_vendor_payment_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor_payment`(`vendor_payment_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ADD CONSTRAINT `fk_vendor_sla_agreement_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `life_insurance_ecm`.`vendor`.`contact`(`contact_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ADD CONSTRAINT `fk_vendor_sla_agreement_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ADD CONSTRAINT `fk_vendor_sla_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ADD CONSTRAINT `fk_vendor_sla_agreement_superseded_sla_agreement_id` FOREIGN KEY (`superseded_sla_agreement_id`) REFERENCES `life_insurance_ecm`.`vendor`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ADD CONSTRAINT `fk_vendor_sla_measurement_sla_agreement_id` FOREIGN KEY (`sla_agreement_id`) REFERENCES `life_insurance_ecm`.`vendor`.`sla_agreement`(`sla_agreement_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ADD CONSTRAINT `fk_vendor_sla_measurement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ADD CONSTRAINT `fk_vendor_sla_measurement_corrected_sla_measurement_id` FOREIGN KEY (`corrected_sla_measurement_id`) REFERENCES `life_insurance_ecm`.`vendor`.`sla_measurement`(`sla_measurement_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ADD CONSTRAINT `fk_vendor_vendor_performance_review_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ADD CONSTRAINT `fk_vendor_vendor_performance_review_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ADD CONSTRAINT `fk_vendor_vendor_performance_review_prior_period_vendor_performance_review_id` FOREIGN KEY (`prior_period_vendor_performance_review_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor_performance_review`(`vendor_performance_review_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ADD CONSTRAINT `fk_vendor_vendor_risk_assessment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ADD CONSTRAINT `fk_vendor_vendor_risk_assessment_prior_vendor_risk_assessment_id` FOREIGN KEY (`prior_vendor_risk_assessment_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor_risk_assessment`(`vendor_risk_assessment_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ADD CONSTRAINT `fk_vendor_risk_finding_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ADD CONSTRAINT `fk_vendor_risk_finding_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ADD CONSTRAINT `fk_vendor_risk_finding_vendor_risk_assessment_id` FOREIGN KEY (`vendor_risk_assessment_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor_risk_assessment`(`vendor_risk_assessment_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ADD CONSTRAINT `fk_vendor_risk_finding_escalated_from_risk_finding_id` FOREIGN KEY (`escalated_from_risk_finding_id`) REFERENCES `life_insurance_ecm`.`vendor`.`risk_finding`(`risk_finding_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ADD CONSTRAINT `fk_vendor_credential_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ADD CONSTRAINT `fk_vendor_credential_renewed_credential_id` FOREIGN KEY (`renewed_credential_id`) REFERENCES `life_insurance_ecm`.`vendor`.`credential`(`credential_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ADD CONSTRAINT `fk_vendor_baa_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ADD CONSTRAINT `fk_vendor_baa_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ADD CONSTRAINT `fk_vendor_baa_renewed_baa_id` FOREIGN KEY (`renewed_baa_id`) REFERENCES `life_insurance_ecm`.`vendor`.`baa`(`baa_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ADD CONSTRAINT `fk_vendor_tpa_agreement_baa_id` FOREIGN KEY (`baa_id`) REFERENCES `life_insurance_ecm`.`vendor`.`baa`(`baa_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ADD CONSTRAINT `fk_vendor_tpa_agreement_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ADD CONSTRAINT `fk_vendor_tpa_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ADD CONSTRAINT `fk_vendor_tpa_agreement_renewed_tpa_agreement_id` FOREIGN KEY (`renewed_tpa_agreement_id`) REFERENCES `life_insurance_ecm`.`vendor`.`tpa_agreement`(`tpa_agreement_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ADD CONSTRAINT `fk_vendor_exam_vendor_order_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ADD CONSTRAINT `fk_vendor_exam_vendor_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ADD CONSTRAINT `fk_vendor_exam_vendor_order_reorder_exam_vendor_order_id` FOREIGN KEY (`reorder_exam_vendor_order_id`) REFERENCES `life_insurance_ecm`.`vendor`.`exam_vendor_order`(`exam_vendor_order_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ADD CONSTRAINT `fk_vendor_custodian_account_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ADD CONSTRAINT `fk_vendor_custodian_account_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ADD CONSTRAINT `fk_vendor_custodian_account_successor_custodian_account_id` FOREIGN KEY (`successor_custodian_account_id`) REFERENCES `life_insurance_ecm`.`vendor`.`custodian_account`(`custodian_account_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ADD CONSTRAINT `fk_vendor_incident_service_order_id` FOREIGN KEY (`service_order_id`) REFERENCES `life_insurance_ecm`.`vendor`.`service_order`(`service_order_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ADD CONSTRAINT `fk_vendor_incident_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ADD CONSTRAINT `fk_vendor_incident_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ADD CONSTRAINT `fk_vendor_incident_related_incident_id` FOREIGN KEY (`related_incident_id`) REFERENCES `life_insurance_ecm`.`vendor`.`incident`(`incident_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ADD CONSTRAINT `fk_vendor_onboarding_baa_id` FOREIGN KEY (`baa_id`) REFERENCES `life_insurance_ecm`.`vendor`.`baa`(`baa_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ADD CONSTRAINT `fk_vendor_onboarding_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ADD CONSTRAINT `fk_vendor_onboarding_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ADD CONSTRAINT `fk_vendor_onboarding_vendor_risk_assessment_id` FOREIGN KEY (`vendor_risk_assessment_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor_risk_assessment`(`vendor_risk_assessment_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ADD CONSTRAINT `fk_vendor_onboarding_restarted_onboarding_id` FOREIGN KEY (`restarted_onboarding_id`) REFERENCES `life_insurance_ecm`.`vendor`.`onboarding`(`onboarding_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ADD CONSTRAINT `fk_vendor_insurance_cert_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ADD CONSTRAINT `fk_vendor_insurance_cert_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ADD CONSTRAINT `fk_vendor_insurance_cert_renewed_insurance_cert_id` FOREIGN KEY (`renewed_insurance_cert_id`) REFERENCES `life_insurance_ecm`.`vendor`.`insurance_cert`(`insurance_cert_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ADD CONSTRAINT `fk_vendor_contract_amendment_parent_amendment_contract_amendment_id` FOREIGN KEY (`parent_amendment_contract_amendment_id`) REFERENCES `life_insurance_ecm`.`vendor`.`contract_amendment`(`contract_amendment_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ADD CONSTRAINT `fk_vendor_contract_amendment_primary_superseded_by_amendment_contract_amendment_id` FOREIGN KEY (`primary_superseded_by_amendment_contract_amendment_id`) REFERENCES `life_insurance_ecm`.`vendor`.`contract_amendment`(`contract_amendment_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ADD CONSTRAINT `fk_vendor_contract_amendment_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ADD CONSTRAINT `fk_vendor_contract_amendment_superseded_contract_amendment_id` FOREIGN KEY (`superseded_contract_amendment_id`) REFERENCES `life_insurance_ecm`.`vendor`.`contract_amendment`(`contract_amendment_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ADD CONSTRAINT `fk_vendor_spend_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ADD CONSTRAINT `fk_vendor_spend_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ADD CONSTRAINT `fk_vendor_spend_adjustment_spend_id` FOREIGN KEY (`adjustment_spend_id`) REFERENCES `life_insurance_ecm`.`vendor`.`spend`(`spend_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ADD CONSTRAINT `fk_vendor_preferred_vendor_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ADD CONSTRAINT `fk_vendor_preferred_vendor_superseded_preferred_vendor_id` FOREIGN KEY (`superseded_preferred_vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`preferred_vendor`(`preferred_vendor_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_credential_requirement` ADD CONSTRAINT `fk_vendor_contract_credential_requirement_credential_id` FOREIGN KEY (`credential_id`) REFERENCES `life_insurance_ecm`.`vendor`.`credential`(`credential_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_credential_requirement` ADD CONSTRAINT `fk_vendor_contract_credential_requirement_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`policy_compliance` ADD CONSTRAINT `fk_vendor_policy_compliance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_bank_account` ADD CONSTRAINT `fk_vendor_vendor_bank_account_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_bank_account` ADD CONSTRAINT `fk_vendor_vendor_bank_account_superseded_vendor_bank_account_id` FOREIGN KEY (`superseded_vendor_bank_account_id`) REFERENCES `life_insurance_ecm`.`vendor`.`vendor_bank_account`(`vendor_bank_account_id`);

-- ========= TAGS =========
ALTER SCHEMA `life_insurance_ecm`.`vendor` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `life_insurance_ecm`.`vendor` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `parent_vendor_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Business Address Line 1');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Business Address Line 2');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `business_city` SET TAGS ('dbx_business_glossary_term' = 'Business City');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `business_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `business_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `business_country` SET TAGS ('dbx_business_glossary_term' = 'Business Country Code');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `business_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `business_country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `business_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Business Postal Code');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `business_state` SET TAGS ('dbx_business_glossary_term' = 'Business State Code');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `business_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `business_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `business_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration End Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `data_sharing_agreement_signed` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Agreement Signed Indicator');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `domicile_country` SET TAGS ('dbx_business_glossary_term' = 'Domicile Country Code');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `domicile_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `domicile_state` SET TAGS ('dbx_business_glossary_term' = 'Domicile State Code');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `domicile_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `hipaa_compliant` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Compliance Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `incorporation_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Incorporation Type');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `incorporation_type` SET TAGS ('dbx_value_regex' = 'corporation|llc|partnership|sole_proprietorship|nonprofit');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `insurance_certificate_on_file` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate on File Indicator');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Insurance Policy Expiration Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Vendor Audit Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Vendor Review Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Vendor Notes and Comments');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Onboarding Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Onboarding and Lifecycle Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'prospect|in_onboarding|active|suspended|terminated|inactive');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Vendor Payment Terms');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_15|net_30|net_45|net_60|net_90|due_on_receipt');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance Rating');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `preferred_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Payment Method');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `preferred_payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|credit_card');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Full Name');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `soc2_certified` SET TAGS ('dbx_business_glossary_term' = 'Service Organization Control 2 (SOC 2) Certification Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `soc2_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Service Organization Control 2 (SOC 2) Certification Expiration Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Employer Identification Number (EIN) / Taxpayer Identification Number (TIN)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Relationship Termination Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Vendor Termination Reason');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `vendor_category` SET TAGS ('dbx_business_glossary_term' = 'Vendor Risk Category');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `vendor_category` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Legal Name');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type Classification');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_value_regex' = 'medical_exam|data_provider|tpa|reinsurance_intermediary|investment_custodian|it_service_provider');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Vendor Website Uniform Resource Locator (URL)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `parent_contract_vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Contract Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `renewed_vendor_contract_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `auto_renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Term in Months');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `confidentiality_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'MSA|SOW|Addendum|Amendment|Service Agreement|License Agreement');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `data_protection_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Clause Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'Litigation|Arbitration|Mediation|Negotiation');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `document_location` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Location');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `document_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Execution Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `indemnification_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Indemnification Clause Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `insurance_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirement Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period in Days');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'One-Time|Monthly|Quarterly|Semi-Annually|Annually|Milestone-Based');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `performance_sla_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Service Level Agreement (SLA) Included Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `procurement_method` SET TAGS ('dbx_business_glossary_term' = 'Procurement Method');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `procurement_method` SET TAGS ('dbx_value_regex' = 'Direct Award|Competitive Bid|Request for Proposal|Sole Source|Preferred Vendor');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `subcontracting_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Subcontracting Allowed Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `termination_for_cause_flag` SET TAGS ('dbx_business_glossary_term' = 'Termination for Cause Provision Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `termination_for_convenience_flag` SET TAGS ('dbx_business_glossary_term' = 'Termination for Convenience Provision Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `value_amount` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `value_currency` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Currency Code');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_contract` ALTER COLUMN `vendor_service_description` SET TAGS ('dbx_business_glossary_term' = 'Vendor Service Description');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `reports_to_contact_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `alternate_email_address` SET TAGS ('dbx_business_glossary_term' = 'Alternate Contact Email Address');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `alternate_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `alternate_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `alternate_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|terminated');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'account_manager|relationship_manager|technical_lead|compliance_officer|escalation_contact|billing_contact');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Contact Department');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Effective Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Fax Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `is_authorized_signer` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signer Indicator');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `is_escalation_contact` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Indicator');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Indicator');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Middle Name');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Mobile Phone Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `office_location` SET TAGS ('dbx_business_glossary_term' = 'Contact Office Location');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|fax|portal');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Termination Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Contact Time Zone');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Contact Job Title');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Service Order Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `insured_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Report Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `follow_up_service_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `acknowledged_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `claim_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `delivery_format` SET TAGS ('dbx_business_glossary_term' = 'Delivery Format');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `delivery_format` SET TAGS ('dbx_value_regex' = 'xml|json|pdf|csv|edi|proprietary');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Method');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_value_regex' = 'electronic|manual|hybrid|api_integration');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Service Order Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Service Order Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `ordered_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'not_invoiced|pending_payment|paid|disputed|cancelled');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'routine|standard|expedited|urgent|critical');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Service Quantity');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `requesting_department` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `required_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Required Completion Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'medical_exam_scheduling|mib_inquiry_batch|prescription_data_pull|tpa_administration_run|it_service_delivery|reinsurance_data_exchange');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `total_estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Cost');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|hour|record|batch|transaction|report');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`service_order` ALTER COLUMN `vendor_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Reference Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice ID');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Service Order ID');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `credited_invoice_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `internal_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Reference Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|prepayment|recurring|one_time');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Line Item Count');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `net_payable_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payable Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire|check|eft|credit_card');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `received_by` SET TAGS ('dbx_business_glossary_term' = 'Invoice Received By');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Received Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|partial_match|not_applicable');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice` ALTER COLUMN `vendor_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Reference Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Service Order Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Case Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `credited_invoice_line_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|on_hold');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `claim_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `line_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Match Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `match_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|partial_match|exception|disputed');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `net_line_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Line Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|paid|partially_paid|voided');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Service Code');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `service_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Service Completion Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `life_insurance_ecm`.`vendor`.`invoice_line` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_value_regex' = 'price_difference|quantity_difference|unauthorized_service|billing_error|contract_rate_change|approved_exception');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `vendor_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Payment Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `vendor_bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Bank Account Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `vendor_bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `vendor_bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `reversal_vendor_payment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Batch Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `cleared_date` SET TAGS ('dbx_business_glossary_term' = 'Cleared Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire|check|eft|virtual_card|other');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'standard|expedited|recurring|advance|final|partial');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processed Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Payment Purpose');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `reconciled_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciled Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `reconciled_flag` SET TAGS ('dbx_business_glossary_term' = 'Reconciled Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `remittance_advice_number` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Return Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `scheduled_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Payment Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `void_date` SET TAGS ('dbx_business_glossary_term' = 'Void Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `void_flag` SET TAGS ('dbx_business_glossary_term' = 'Void Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` SET TAGS ('dbx_subdomain' = 'performance_oversight');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `sla_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Agreement ID');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact ID');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `superseded_sla_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `business_owner` SET TAGS ('dbx_business_glossary_term' = 'Business Owner');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `escalation_threshold` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'Exclusions');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `metric_description` SET TAGS ('dbx_business_glossary_term' = 'Metric Description');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Metric Name');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `penalty_structure` SET TAGS ('dbx_business_glossary_term' = 'Penalty Structure');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `penalty_structure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `penalty_type` SET TAGS ('dbx_business_glossary_term' = 'Penalty Type');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `penalty_type` SET TAGS ('dbx_value_regex' = 'service_credit|liquidated_damages|fee_reduction|termination_right|none');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `reporting_period` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `service_category` SET TAGS ('dbx_value_regex' = 'medical_exam|mib_inquiry|prescription_data|reinsurance|tpa_administration|it_services');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `sla_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `sla_agreement_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|terminated|draft|under_review');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `sla_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Name');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `sla_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Type');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `target_operator` SET TAGS ('dbx_business_glossary_term' = 'Target Operator');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `target_operator` SET TAGS ('dbx_value_regex' = 'less_than|less_than_or_equal|greater_than|greater_than_or_equal|equal');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `target_unit` SET TAGS ('dbx_business_glossary_term' = 'Target Unit of Measure');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `target_unit` SET TAGS ('dbx_value_regex' = 'hours|days|percentage|count|minutes|seconds');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` SET TAGS ('dbx_subdomain' = 'performance_oversight');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `sla_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Measurement Identifier');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Measured By Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Report Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `sla_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Agreement Identifier');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `corrected_sla_measurement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Metric Value');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `breach_count` SET TAGS ('dbx_business_glossary_term' = 'Breach Count');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `breach_severity` SET TAGS ('dbx_business_glossary_term' = 'Breach Severity Level');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `breach_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|none');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `is_breach` SET TAGS ('dbx_business_glossary_term' = 'Breach Indicator');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'automated_system|manual_review|vendor_reported|third_party_audit|sampling|census');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `measurement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `measurement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `metric_category` SET TAGS ('dbx_business_glossary_term' = 'Metric Category');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Metric Name');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Notes');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `regulatory_reportable` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Indicator');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Taken');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_required|planned|in_progress|completed|overdue|cancelled');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `sla_measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `sla_measurement_status` SET TAGS ('dbx_value_regex' = 'draft|final|disputed|resolved|archived');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Metric Value');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `variance` SET TAGS ('dbx_business_glossary_term' = 'Variance from Target');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `life_insurance_ecm`.`vendor`.`sla_measurement` ALTER COLUMN `vendor_acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Acknowledgement Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` SET TAGS ('dbx_subdomain' = 'performance_oversight');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `vendor_performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance Review Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `market_conduct_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Market Conduct Exam Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `prior_period_vendor_performance_review_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `action_item_due_date` SET TAGS ('dbx_business_glossary_term' = 'Action Item Due Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `cost_effectiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Cost Effectiveness Score');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `critical_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Incident Count');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `escalation_required` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `improvement_action_items` SET TAGS ('dbx_business_glossary_term' = 'Improvement Action Items');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `incident_count` SET TAGS ('dbx_business_glossary_term' = 'Incident Count');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `innovation_score` SET TAGS ('dbx_business_glossary_term' = 'Innovation Score');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `is_regulatory_reportable` SET TAGS ('dbx_business_glossary_term' = 'Is Regulatory Reportable');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `key_findings` SET TAGS ('dbx_business_glossary_term' = 'Key Findings');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `overall_performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `overall_performance_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|unacceptable');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `overall_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Score');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `regulatory_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Findings Count');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `responsiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Responsiveness Score');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Review Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Review Outcome');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `review_outcome` SET TAGS ('dbx_value_regex' = 'continue|continue_with_monitoring|remediation_required|escalate|contract_review|terminate');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|pending_approval|approved|completed|cancelled');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|ad_hoc|incident_driven|contract_renewal');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `reviewer_department` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Department');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `risk_management_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Management Score');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `sla_compliance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Percentage');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `strengths_identified` SET TAGS ('dbx_business_glossary_term' = 'Strengths Identified');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `timeliness_score` SET TAGS ('dbx_business_glossary_term' = 'Timeliness Score');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_performance_review` ALTER COLUMN `weaknesses_identified` SET TAGS ('dbx_business_glossary_term' = 'Weaknesses Identified');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `vendor_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Risk Assessment Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `prior_vendor_risk_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Approval Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Assessment Approved By');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Methodology');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_value_regex' = 'questionnaire|onsite_audit|document_review|hybrid|third_party_report|continuous_monitoring');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Risk Assessment Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_value_regex' = '^VRA-[0-9]{8}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|pending_review|completed|approved|rejected');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Type');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'initial|annual|triggered|ad_hoc|renewal|material_change');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `bcp_adequacy_rating` SET TAGS ('dbx_business_glossary_term' = 'Business Continuity Plan (BCP) Adequacy Rating');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `bcp_adequacy_rating` SET TAGS ('dbx_value_regex' = 'adequate|needs_improvement|inadequate|not_reviewed');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `bcp_last_test_date` SET TAGS ('dbx_business_glossary_term' = 'Business Continuity Plan (BCP) Last Test Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `concentration_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Concentration Risk Rating');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `concentration_risk_rating` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `cybersecurity_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Cybersecurity Risk Rating');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `cybersecurity_risk_rating` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `data_access_level` SET TAGS ('dbx_business_glossary_term' = 'Vendor Data Access Level');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `data_access_level` SET TAGS ('dbx_value_regex' = 'none|limited|moderate|extensive');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `financial_review_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Review Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `financial_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Financial Risk Rating');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `financial_risk_rating` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `financial_stability_review_completed` SET TAGS ('dbx_business_glossary_term' = 'Financial Stability Review Completed');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `inherent_risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Tier');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `inherent_risk_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `key_findings` SET TAGS ('dbx_business_glossary_term' = 'Key Assessment Findings');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Risk Assessment Due Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `operational_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Rating');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `operational_risk_rating` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `overall_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Risk Score');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `recommendations` SET TAGS ('dbx_business_glossary_term' = 'Risk Management Recommendations');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `regulatory_compliance_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Risk Rating');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `regulatory_compliance_risk_rating` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `remediation_plan_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Due Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `remediation_required` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `reputational_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Reputational Risk Rating');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `reputational_risk_rating` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `residual_risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Tier');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `residual_risk_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `service_criticality` SET TAGS ('dbx_business_glossary_term' = 'Service Criticality Level');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `service_criticality` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `soc2_opinion` SET TAGS ('dbx_business_glossary_term' = 'System and Organization Controls 2 (SOC 2) Auditor Opinion');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `soc2_opinion` SET TAGS ('dbx_value_regex' = 'unqualified|qualified|adverse|disclaimer|not_applicable');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `soc2_report_date` SET TAGS ('dbx_business_glossary_term' = 'System and Organization Controls 2 (SOC 2) Report Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `soc2_report_reviewed` SET TAGS ('dbx_business_glossary_term' = 'System and Organization Controls 2 (SOC 2) Report Reviewed');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `soc2_report_type` SET TAGS ('dbx_business_glossary_term' = 'System and Organization Controls 2 (SOC 2) Report Type');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `soc2_report_type` SET TAGS ('dbx_value_regex' = 'type_1|type_2|not_applicable');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_risk_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `risk_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Risk Finding Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `exam_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Exam Finding Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Identified By Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `vendor_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Risk Assessment Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `escalated_from_risk_finding_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `actual_remediation_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Remediation Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `affected_service` SET TAGS ('dbx_business_glossary_term' = 'Affected Service');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `business_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Business Impact Description');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `control_deficiency_type` SET TAGS ('dbx_business_glossary_term' = 'Control Deficiency Type');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `control_deficiency_type` SET TAGS ('dbx_value_regex' = 'design|operating_effectiveness|both|not_applicable');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_value_regex' = 'open|in_remediation|pending_validation|closed|accepted|escalated');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `finding_title` SET TAGS ('dbx_business_glossary_term' = 'Finding Title');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `identification_date` SET TAGS ('dbx_business_glossary_term' = 'Identification Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `inherent_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Score');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `recommended_remediation` SET TAGS ('dbx_business_glossary_term' = 'Recommended Remediation Action');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `remediation_owner` SET TAGS ('dbx_business_glossary_term' = 'Remediation Owner');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `remediation_validation_method` SET TAGS ('dbx_business_glossary_term' = 'Remediation Validation Method');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `risk_acceptance_approver` SET TAGS ('dbx_business_glossary_term' = 'Risk Acceptance Approver');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `risk_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Acceptance Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `risk_acceptance_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Acceptance Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `risk_acceptance_justification` SET TAGS ('dbx_business_glossary_term' = 'Risk Acceptance Justification');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `risk_domain` SET TAGS ('dbx_business_glossary_term' = 'Risk Domain');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `risk_domain` SET TAGS ('dbx_value_regex' = 'operational|financial|compliance|cybersecurity|data_privacy|business_continuity');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `risk_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Risk Subcategory');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `target_remediation_date` SET TAGS ('dbx_business_glossary_term' = 'Target Remediation Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `validation_evidence` SET TAGS ('dbx_business_glossary_term' = 'Validation Evidence');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `vendor_committed_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Committed Remediation Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`risk_finding` ALTER COLUMN `vendor_response` SET TAGS ('dbx_business_glossary_term' = 'Vendor Response');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `credential_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Credential Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `renewed_credential_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `attestation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Attestation Required Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `compliance_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `continuing_education_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Hours Required');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `continuing_education_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Required Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `credential_name` SET TAGS ('dbx_business_glossary_term' = 'Credential Name');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `credential_number` SET TAGS ('dbx_business_glossary_term' = 'Credential Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `credential_status` SET TAGS ('dbx_business_glossary_term' = 'Credential Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `credential_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending_renewal|inactive');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `credential_type` SET TAGS ('dbx_business_glossary_term' = 'Credential Type');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Credential Document Uniform Resource Locator (URL)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `issuing_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Issuing Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `last_attestation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Attestation Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `next_attestation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Attestation Due Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `next_renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Due Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `product_line_applicability` SET TAGS ('dbx_business_glossary_term' = 'Product Line Applicability');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `reinstatement_date` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `scope_of_authorization` SET TAGS ('dbx_business_glossary_term' = 'Scope of Authorization');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'direct_authority_contact|online_registry|third_party_service|document_review|other');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`credential` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|failed_verification|not_verified');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `baa_id` SET TAGS ('dbx_business_glossary_term' = 'Business Associate Agreement (BAA) ID');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `privacy_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Incident Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `renewed_baa_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Business Associate Agreement (BAA) Name');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Business Associate Agreement (BAA) Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Business Associate Agreement (BAA) Type');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'standard|custom|master|amendment|renewal');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_value_regex' = 'annual|biannual|quarterly|on_demand|as_needed');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `audit_rights_included` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Included Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `auto_renewal_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Enabled Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `baa_status` SET TAGS ('dbx_business_glossary_term' = 'Business Associate Agreement (BAA) Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `breach_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Breach Notification Method');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `breach_notification_timeframe_hours` SET TAGS ('dbx_business_glossary_term' = 'Breach Notification Timeframe (Hours)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `covered_phi_categories` SET TAGS ('dbx_business_glossary_term' = 'Covered Protected Health Information (PHI) Categories');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `data_destruction_method` SET TAGS ('dbx_business_glossary_term' = 'Data Destruction Method');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `data_destruction_required` SET TAGS ('dbx_business_glossary_term' = 'Data Destruction Required Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `data_return_required` SET TAGS ('dbx_business_glossary_term' = 'Data Return Required Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `document_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Location');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Business Associate Agreement (BAA) Effective Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Business Associate Agreement (BAA) Execution Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Business Associate Agreement (BAA) Expiration Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `indemnification_included` SET TAGS ('dbx_business_glossary_term' = 'Indemnification Included Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `insurance_certificate_on_file` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate on File Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiration Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `insurance_requirement_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirement Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Business Associate Agreement (BAA) Notes');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `permitted_disclosures` SET TAGS ('dbx_business_glossary_term' = 'Permitted Disclosures of Protected Health Information (PHI)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `permitted_uses` SET TAGS ('dbx_business_glossary_term' = 'Permitted Uses of Protected Health Information (PHI)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `signed_by_business_associate` SET TAGS ('dbx_business_glossary_term' = 'Signed by Business Associate Representative');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `signed_by_covered_entity` SET TAGS ('dbx_business_glossary_term' = 'Signed by Covered Entity Representative');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `subcontractor_provision_included` SET TAGS ('dbx_business_glossary_term' = 'Subcontractor Provision Included Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `subcontractor_requirements` SET TAGS ('dbx_business_glossary_term' = 'Subcontractor Requirements');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Business Associate Agreement (BAA) Termination Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Business Associate Agreement (BAA) Termination Reason');
ALTER TABLE `life_insurance_ecm`.`vendor`.`baa` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `tpa_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Administrator (TPA) Agreement ID');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Owner Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `baa_id` SET TAGS ('dbx_business_glossary_term' = 'Baa Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `renewed_tpa_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `administered_functions` SET TAGS ('dbx_business_glossary_term' = 'Administered Functions');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Administrator (TPA) Agreement Type');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'full_service|claims_only|billing_only|policy_servicing|group_enrollment|specialty_tpa');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency Months');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `audit_rights_provision` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Provision');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `audit_rights_provision` SET TAGS ('dbx_value_regex' = 'full_access|scheduled_only|notice_required|restricted');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `claims_authority_limit` SET TAGS ('dbx_business_glossary_term' = 'Claims Authority Limit');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `claims_processing_sla_days` SET TAGS ('dbx_business_glossary_term' = 'Claims Processing Service Level Agreement (SLA) Days');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `compensation_model` SET TAGS ('dbx_business_glossary_term' = 'Compensation Model');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `compensation_model` SET TAGS ('dbx_value_regex' = 'per_policy_fee|per_claim_fee|percentage_of_premium|flat_monthly_fee|hybrid');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `compensation_model` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `compensation_model` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `customer_service_sla_hours` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Service Level Agreement (SLA) Hours');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `data_breach_notification_hours` SET TAGS ('dbx_business_glossary_term' = 'Data Breach Notification Hours');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `data_ownership_provision` SET TAGS ('dbx_business_glossary_term' = 'Data Ownership Provision');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `data_ownership_provision` SET TAGS ('dbx_value_regex' = 'insurer_owns|joint_ownership|tpa_custodian');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `data_return_requirement_days` SET TAGS ('dbx_business_glossary_term' = 'Data Return Requirement Days');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `delegated_authority_scope` SET TAGS ('dbx_business_glossary_term' = 'Delegated Authority Scope');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `delegated_authority_scope` SET TAGS ('dbx_value_regex' = 'administrative_only|limited_claims_authority|full_claims_authority|underwriting_authority');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `disaster_recovery_plan_on_file` SET TAGS ('dbx_business_glossary_term' = 'Disaster Recovery Plan on File');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `eo_certificate_on_file` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Certificate on File');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `eo_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Coverage Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `eo_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Expiration Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `eo_insurance_required` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Insurance Required');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `fee_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Reference');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `fee_schedule_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `next_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Performance Review Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `performance_sla_reference` SET TAGS ('dbx_business_glossary_term' = 'Performance Service Level Agreement (SLA) Reference');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `product_lines_covered` SET TAGS ('dbx_business_glossary_term' = 'Product Lines Covered');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `registered_states` SET TAGS ('dbx_business_glossary_term' = 'Registered States');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `regulatory_reporting_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Responsibility');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `regulatory_reporting_responsibility` SET TAGS ('dbx_value_regex' = 'insurer|tpa|shared');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `soc2_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Service Organization Control 2 (SOC 2) Expiration Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `soc2_type2_certified` SET TAGS ('dbx_business_glossary_term' = 'Service Organization Control 2 (SOC 2) Type 2 Certified');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `state_doi_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'State Department of Insurance (DOI) Filing Reference');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `tpa_name` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Administrator (TPA) Name');
ALTER TABLE `life_insurance_ecm`.`vendor`.`tpa_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `exam_vendor_order_id` SET TAGS ('dbx_business_glossary_term' = 'Exam Vendor Order Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `insured_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Ordered By Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Application Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `reorder_exam_vendor_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `applicant_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Applicant Contact Email Address');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `applicant_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `applicant_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `applicant_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `applicant_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Applicant Contact Phone Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `applicant_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `applicant_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `blood_specimen_required` SET TAGS ('dbx_business_glossary_term' = 'Blood Specimen Required Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `exam_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Exam Completion Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `exam_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exam Completion Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `exam_location_address` SET TAGS ('dbx_business_glossary_term' = 'Exam Location Address');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `exam_location_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `exam_location_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `exam_location_city` SET TAGS ('dbx_business_glossary_term' = 'Exam Location City');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `exam_location_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Exam Location Postal Code');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `exam_location_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `exam_location_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `exam_location_state` SET TAGS ('dbx_business_glossary_term' = 'Exam Location State');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `exam_location_type` SET TAGS ('dbx_business_glossary_term' = 'Exam Location Type');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `exam_location_type` SET TAGS ('dbx_value_regex' = 'home|office|clinic|mobile_unit|telehealth');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `exam_package_code` SET TAGS ('dbx_business_glossary_term' = 'Exam Package Code');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `exam_type` SET TAGS ('dbx_business_glossary_term' = 'Examination Type');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `examiner_name` SET TAGS ('dbx_business_glossary_term' = 'Examiner Name');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `invoice_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Invoice Currency Code');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `oral_fluid_specimen_required` SET TAGS ('dbx_business_glossary_term' = 'Oral Fluid Specimen Required Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Exam Order Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `order_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|rush|urgent');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `results_received_date` SET TAGS ('dbx_business_glossary_term' = 'Results Received Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `results_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Results Received Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `results_transmission_status` SET TAGS ('dbx_business_glossary_term' = 'Results Transmission Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `results_transmission_status` SET TAGS ('dbx_value_regex' = 'pending|transmitted|received|integrated|failed');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Exam Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `scheduled_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Exam Time');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `specimen_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `specimen_collection_required` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Required Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `turnaround_time_days` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time in Days');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `urine_specimen_required` SET TAGS ('dbx_business_glossary_term' = 'Urine Specimen Required Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`exam_vendor_order` ALTER COLUMN `vendor_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Reference Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `custodian_account_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Report Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `successor_custodian_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `account_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closure Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Name');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `account_opening_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opening Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_opening|pending_closure|suspended|restricted');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Type');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'general_account|separate_account|securities_lending|collateral|transition');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `asset_classes_held` SET TAGS ('dbx_business_glossary_term' = 'Asset Classes Held');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `base_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Code');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `base_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `collateral_pledging_allowed` SET TAGS ('dbx_business_glossary_term' = 'Collateral Pledging Allowed Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `custodian_name` SET TAGS ('dbx_business_glossary_term' = 'Custodian Institution Name');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `custody_fee_basis` SET TAGS ('dbx_business_glossary_term' = 'Custody Fee Basis');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `custody_fee_basis` SET TAGS ('dbx_value_regex' = 'basis_points|flat_fee|tiered|transaction_based|hybrid');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `custody_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Custody Fee Rate');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `custody_fee_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `fee_calculation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Fee Calculation Frequency');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `fee_calculation_frequency` SET TAGS ('dbx_value_regex' = 'daily|monthly|quarterly|annually');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiration Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `naic_schedule_classification` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Schedule Classification');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'statutory|gaap|ifrs|tax_basis');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `safekeeping_location` SET TAGS ('dbx_business_glossary_term' = 'Safekeeping Location');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `securities_lending_enabled` SET TAGS ('dbx_business_glossary_term' = 'Securities Lending Enabled Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `settlement_bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Bank Account Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `settlement_bank_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `settlement_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Settlement Bank Name');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `settlement_bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Bank Routing Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `settlement_bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `settlement_instruction_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction Method');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `settlement_instruction_method` SET TAGS ('dbx_value_regex' = 'dvp|rvp|fop|against_payment');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `soc2_report_date` SET TAGS ('dbx_business_glossary_term' = 'Service Organization Control 2 (SOC2) Report Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `soc2_report_on_file` SET TAGS ('dbx_business_glossary_term' = 'Service Organization Control 2 (SOC2) Report On File Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `subcustodian_used` SET TAGS ('dbx_business_glossary_term' = 'Subcustodian Used Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`custodian_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` SET TAGS ('dbx_subdomain' = 'performance_oversight');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Incident Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `issue_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Issue Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `privacy_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Incident Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Service Order Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `related_incident_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `affected_claim_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Claim Count');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `affected_policy_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Policy Count');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `affected_underwriting_case_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Underwriting Case Count');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `business_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Business Impact Description');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `contract_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Contract Penalty Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `contract_penalty_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Penalty Applicable Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `detected_by_method` SET TAGS ('dbx_business_glossary_term' = 'Detected By Method');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `detected_by_method` SET TAGS ('dbx_value_regex' = 'vendor_notification|internal_audit|automated_monitoring|customer_complaint|regulatory_inquiry|third_party_alert');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|management|executive|board');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = '^INC-[0-9]{8}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'reported|investigating|contained|resolved|closed');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'service_outage|data_breach|phi_exposure|sla_breach|regulatory_violation|fraud');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `phi_exposed_flag` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Exposed Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `phi_record_count` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Record Count');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `pii_exposed_flag` SET TAGS ('dbx_business_glossary_term' = 'Personally Identifiable Information (PII) Exposed Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `pii_record_count` SET TAGS ('dbx_business_glossary_term' = 'Personally Identifiable Information (PII) Record Count');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `resolution_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Resolution Time Hours');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'human_error|system_failure|process_gap|security_vulnerability|third_party_dependency|natural_disaster');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `sla_metric_breached` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Metric Breached');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`incident` ALTER COLUMN `vendor_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Vendor Response Time Hours');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `onboarding_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Onboarding Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `baa_id` SET TAGS ('dbx_business_glossary_term' = 'Baa Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `onboarding_requestor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `onboarding_requestor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `onboarding_requestor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Vendor Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `vendor_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Risk Assessment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `restarted_onboarding_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Activation Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `baa_execution_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Business Associate Agreement (BAA) Execution Completion Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `baa_execution_start_date` SET TAGS ('dbx_business_glossary_term' = 'Business Associate Agreement (BAA) Execution Start Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `contract_negotiation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Negotiation Completion Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `contract_negotiation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Negotiation Start Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `credential_verification_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Credential Verification Completed Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `due_diligence_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Completion Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `due_diligence_start_date` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Start Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `insurance_certificate_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Completed Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `legal_review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completion Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `legal_review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Start Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Notes');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Request Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Request Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `requestor_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Requestor Business Unit');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `risk_assessment_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Completion Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `risk_assessment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Start Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `soc2_audit_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'System and Organization Controls 2 (SOC2) Audit Completed Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `sourcing_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Completion Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `sourcing_start_date` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Start Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Stage');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `system_setup_completion_date` SET TAGS ('dbx_business_glossary_term' = 'System Setup Completion Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `system_setup_start_date` SET TAGS ('dbx_business_glossary_term' = 'System Setup Start Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `target_activation_date` SET TAGS ('dbx_business_glossary_term' = 'Target Activation Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`onboarding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `insurance_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Insurance Certificate ID');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By User ID');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `tertiary_insurance_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `tertiary_insurance_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `tertiary_insurance_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `renewed_insurance_cert_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `additional_insured_endorsement` SET TAGS ('dbx_business_glossary_term' = 'Additional Insured Endorsement');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `additional_insured_flag` SET TAGS ('dbx_business_glossary_term' = 'Additional Insured Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `cancellation_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Notice Days');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `certificate_holder_address` SET TAGS ('dbx_business_glossary_term' = 'Certificate Holder Address');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `certificate_holder_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `certificate_holder_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `certificate_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Certificate Holder Name');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `certificate_received_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Received Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Certificate Type');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `contract_requirement_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Requirement Met Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `coverage_limit_aggregate` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Aggregate');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `coverage_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Currency');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `coverage_limit_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `coverage_limit_per_occurrence` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Per Occurrence');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `document_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Location');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `insurance_cert_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `insurance_cert_status` SET TAGS ('dbx_value_regex' = 'active|expired|cancelled|pending_renewal|suspended|replaced');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `issuing_insurer_am_best_rating` SET TAGS ('dbx_business_glossary_term' = 'Issuing Insurer AM Best Rating');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `issuing_insurer_am_best_rating` SET TAGS ('dbx_value_regex' = '^[A-F][+-]?$|NR');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `issuing_insurer_naic_number` SET TAGS ('dbx_business_glossary_term' = 'Issuing Insurer National Association of Insurance Commissioners (NAIC) Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `issuing_insurer_naic_number` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `issuing_insurer_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Insurer Name');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `primary_noncontributory_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary and Noncontributory Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `producer_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Producer Contact Name');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `producer_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `producer_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `producer_email_address` SET TAGS ('dbx_business_glossary_term' = 'Producer Email Address');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `producer_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `producer_email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `producer_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `producer_name` SET TAGS ('dbx_business_glossary_term' = 'Producer Name');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `producer_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Producer Phone Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `producer_phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `producer_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `renewal_reminder_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Reminder Sent Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `special_provisions` SET TAGS ('dbx_business_glossary_term' = 'Special Provisions');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|rejected|not_verified');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `verified_date` SET TAGS ('dbx_business_glossary_term' = 'Verified Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`insurance_cert` ALTER COLUMN `waiver_of_subrogation_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver of Subrogation Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `contract_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Amendment Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `parent_amendment_contract_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Amendment Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `primary_superseded_by_amendment_contract_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Amendment Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `quaternary_contract_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `quaternary_contract_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `quaternary_contract_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `quinary_contract_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `quinary_contract_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `quinary_contract_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `tertiary_contract_rejected_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Rejected By Employee Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `tertiary_contract_rejected_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `tertiary_contract_rejected_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `superseded_contract_amendment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Description');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|executed|rejected|superseded');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `amendment_title` SET TAGS ('dbx_business_glossary_term' = 'Amendment Title');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'scope_change|pricing_adjustment|term_extension|sla_modification|regulatory_update|service_addition');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Approval Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `approval_level_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Level Required');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `approval_level_required` SET TAGS ('dbx_value_regex' = 'manager|director|vp|svp|executive|board');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `company_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Company Signature Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `document_location` SET TAGS ('dbx_business_glossary_term' = 'Amendment Document Location');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Execution Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Expiration Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency Code');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `initiated_by_party` SET TAGS ('dbx_business_glossary_term' = 'Amendment Initiated By Party');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `initiated_by_party` SET TAGS ('dbx_value_regex' = 'vendor|company|mutual');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `legal_review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completed Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `legal_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Amendment Notes');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `pricing_adjustment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Pricing Adjustment Percentage');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `regulatory_compliance_reason` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Reason');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Rejection Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Rejection Reason');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Requested Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `revised_contract_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Contract Value Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `revised_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Contract Expiration Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `scope_change_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Change Description');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `sla_modification_description` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Modification Description');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `term_extension_months` SET TAGS ('dbx_business_glossary_term' = 'Term Extension Months');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_amendment` ALTER COLUMN `vendor_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Signature Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `spend_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Spend ID');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `adjustment_spend_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `accrued_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `actual_invoiced_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Invoiced Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `budget_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `budget_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `budget_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Percentage');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `category_manager` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Manager');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `fiscal_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Month');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `invoice_count` SET TAGS ('dbx_business_glossary_term' = 'Invoice Count');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|paid|partially_paid|disputed|cancelled');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Spend Period End Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Spend Period Start Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|variance_identified|under_review');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `service_category` SET TAGS ('dbx_value_regex' = 'medical_exam|data_services|tpa_administration|it_services|custodial_services|reinsurance_intermediary');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `service_order_count` SET TAGS ('dbx_business_glossary_term' = 'Service Order Count');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `service_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Service Subcategory');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `spend_type` SET TAGS ('dbx_business_glossary_term' = 'Spend Type');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `spend_type` SET TAGS ('dbx_value_regex' = 'direct|indirect|capital|operating');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `total_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Spend Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`spend` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `preferred_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor ID');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee ID');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `superseded_preferred_vendor_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `approval_basis` SET TAGS ('dbx_business_glossary_term' = 'Approval Basis');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `approving_committee` SET TAGS ('dbx_business_glossary_term' = 'Approving Committee');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `compliance_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Required');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `geographic_coverage_detail` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage Detail');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'national|regional|state_specific');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `next_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Performance Review Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Performance Score');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `preferred_status_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Preferred Status Effective Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `preferred_status_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Preferred Status Expiration Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `preferred_vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `preferred_vendor_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|terminated|under_review');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `procurement_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Procurement Approval Required Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period Days');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `strategic_partnership_flag` SET TAGS ('dbx_business_glossary_term' = 'Strategic Partnership Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `vendor_consolidation_initiative_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Consolidation Initiative Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `vendor_tier` SET TAGS ('dbx_business_glossary_term' = 'Vendor Tier');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `vendor_tier` SET TAGS ('dbx_value_regex' = 'preferred|approved|conditional|restricted');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `volume_commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Amount');
ALTER TABLE `life_insurance_ecm`.`vendor`.`preferred_vendor` ALTER COLUMN `volume_commitment_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Unit');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_credential_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_credential_requirement` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_credential_requirement` SET TAGS ('dbx_association_edges' = 'vendor.vendor_contract,vendor.vendor_credential');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_credential_requirement` ALTER COLUMN `contract_credential_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Credential Requirement ID');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_credential_requirement` ALTER COLUMN `credential_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Credential Requirement - Vendor Credential Id');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_credential_requirement` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Credential Requirement - Vendor Contract Id');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_credential_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_credential_requirement` ALTER COLUMN `last_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_credential_requirement` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_credential_requirement` ALTER COLUMN `next_verification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Verification Due Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_credential_requirement` ALTER COLUMN `non_compliance_action` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Action');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_credential_requirement` ALTER COLUMN `requirement_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Effective Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_credential_requirement` ALTER COLUMN `requirement_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Expiration Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_credential_requirement` ALTER COLUMN `requirement_source` SET TAGS ('dbx_business_glossary_term' = 'Requirement Source');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_credential_requirement` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_credential_requirement` ALTER COLUMN `waiver_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Expiration Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_credential_requirement` ALTER COLUMN `waiver_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`contract_credential_requirement` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `life_insurance_ecm`.`vendor`.`policy_compliance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`policy_compliance` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `life_insurance_ecm`.`vendor`.`policy_compliance` SET TAGS ('dbx_association_edges' = 'compliance.compliance_policy,vendor.vendor');
ALTER TABLE `life_insurance_ecm`.`vendor`.`policy_compliance` ALTER COLUMN `policy_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Policy Compliance ID');
ALTER TABLE `life_insurance_ecm`.`vendor`.`policy_compliance` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy ID');
ALTER TABLE `life_insurance_ecm`.`vendor`.`policy_compliance` ALTER COLUMN `policy_compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Policy Compliance - Compliance Policy Id');
ALTER TABLE `life_insurance_ecm`.`vendor`.`policy_compliance` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Policy Compliance - Vendor Id');
ALTER TABLE `life_insurance_ecm`.`vendor`.`policy_compliance` ALTER COLUMN `attestation_date` SET TAGS ('dbx_business_glossary_term' = 'Attestation Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`policy_compliance` ALTER COLUMN `audit_finding_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Reference');
ALTER TABLE `life_insurance_ecm`.`vendor`.`policy_compliance` ALTER COLUMN `compliance_owner` SET TAGS ('dbx_business_glossary_term' = 'Compliance Owner');
ALTER TABLE `life_insurance_ecm`.`vendor`.`policy_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `life_insurance_ecm`.`vendor`.`policy_compliance` ALTER COLUMN `exception_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Expiration Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`policy_compliance` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `life_insurance_ecm`.`vendor`.`policy_compliance` ALTER COLUMN `exception_justification` SET TAGS ('dbx_business_glossary_term' = 'Exception Justification');
ALTER TABLE `life_insurance_ecm`.`vendor`.`policy_compliance` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`policy_compliance` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`policy_compliance` ALTER COLUMN `policy_applicability_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Applicability Date');
ALTER TABLE `life_insurance_ecm`.`vendor`.`policy_compliance` ALTER COLUMN `remediation_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Reference');
ALTER TABLE `life_insurance_ecm`.`vendor`.`policy_compliance` ALTER COLUMN `vendor_contact_for_policy` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact for Policy');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_bank_account` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_bank_account` ALTER COLUMN `vendor_bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Bank Account Identifier');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_bank_account` ALTER COLUMN `superseded_vendor_bank_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_bank_account` ALTER COLUMN `bank_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_bank_account` ALTER COLUMN `bank_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_bank_account` ALTER COLUMN `bank_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_bank_account` ALTER COLUMN `bank_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_bank_account` ALTER COLUMN `bank_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_bank_account` ALTER COLUMN `bank_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_bank_account` ALTER COLUMN `bank_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_bank_account` ALTER COLUMN `bank_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_bank_account` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_bank_account` ALTER COLUMN `bank_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_bank_account` ALTER COLUMN `bank_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_bank_account` ALTER COLUMN `intermediary_bank_swift_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`vendor`.`vendor_bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_confidential' = 'true');
