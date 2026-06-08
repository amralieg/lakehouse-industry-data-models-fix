-- Schema for Domain: contract | Business: Construction | Version: v1_mvm
-- Generated on: 2026-05-07 09:27:04

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `construction_ecm`.`contract` COMMENT 'Authoritative contract repository governing all contractual agreements including FIDIC-based EPC, GMP (Guaranteed Maximum Price), lump-sum, and unit-rate contracts. Owns CO (Change Order) logs, LD (Liquidated Damages) provisions, DLP (Defects Liability Period) terms, EOT (Extension of Time) entitlements, payment schedules, and contract milestone administration.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `construction_ecm`.`contract`.`agreement` (
    `agreement_id` BIGINT COMMENT 'System-generated unique identifier for the master contract record.',
    `account_id` BIGINT COMMENT 'Identifier of the client (owner) of the contract.',
    `client_opportunity_id` BIGINT COMMENT 'Foreign key linking to client.client_opportunity. Business justification: Pipeline-to-revenue conversion reporting requires tracing which CRM opportunity resulted in which awarded contract. BD and commercial teams track win rates, opportunity-to-contract conversion, and rev',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Contracts are executed under a specific legal entity (company code) in multi-entity construction groups and JVs. This determines the contracting legal entity for financial reporting, tax jurisdiction,',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project that the contract supports.',
    `env_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.env_impact_assessment. Business justification: Environmental Impact Assessment linkage: contracts need to attach the approved assessment to satisfy regulatory and client environmental requirements.',
    `framework_agreement_id` BIGINT COMMENT 'Foreign key linking to client.client_framework_agreement. Business justification: Framework agreement ceiling value tracking and call-off compliance require each contract (agreement) to reference its governing client framework agreement. Construction contract managers must verify t',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Required for Permit Compliance Tracking: contracts must reference the specific permit authorizing the work; permits are reviewed before contract award.',
    `rfp_issuance_id` BIGINT COMMENT 'Foreign key linking to client.rfp_issuance. Business justification: Procurement compliance and contract setup validation require tracing which RFP issuance (with its defined LD rates, bond %, delivery model, and evaluation criteria) gave rise to each contract. Auditor',
    `vendor_id` BIGINT COMMENT 'Identifier of the primary contractor responsible for delivering the work.',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the agreement.. Valid values are `draft|pending|active|suspended|terminated|closed`',
    `amendment_effective_date` DATE COMMENT 'Date the amendment becomes effective.',
    `amendment_number` STRING COMMENT 'Sequential identifier for a contract amendment.',
    `amendment_type` STRING COMMENT 'Type of amendment (e.g., supplemental, variation, novation).. Valid values are `supplemental|variation|novation`',
    `award_date` DATE COMMENT 'Date the contract was formally awarded to the contractor.',
    `boq_reference` STRING COMMENT 'Reference to the Bill of Quantities associated with the contract.',
    `compliance_requirements` STRING COMMENT 'Regulatory and statutory compliance obligations attached to the agreement.',
    `contract_number` STRING COMMENT 'External contract identifier used in all business communications and legal documents.',
    `contract_type` STRING COMMENT 'Classification of the agreement (e.g., EPC, GMP, Lump Sum, Unit Rate, Design-Build, Design-Bid-Build, PPP, BOT). [ENUM-REF-CANDIDATE: EPC|GMP|LumpSum|UnitRate|DesignBuild|DesignBidBuild|PPP|BOT — promote to reference product]',
    `contract_value` DECIMAL(18,2) COMMENT 'Original monetary value of the agreement as agreed at award.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the contract value.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `defects_liability_period_months` STRING COMMENT 'Duration after completion during which the contractor is liable for defects.',
    `dispute_resolution` STRING COMMENT 'Method for resolving disputes (e.g., arbitration, litigation, mediation).',
    `effective_end_date` DATE COMMENT 'Date the agreement terminates or expires (null for open‑ended contracts).',
    `effective_start_date` DATE COMMENT 'Date the agreement becomes legally binding.',
    `environmental_impact_assessment_ref` STRING COMMENT 'Reference to the approved environmental impact assessment linked to the contract.',
    `extension_of_time_days` STRING COMMENT 'Number of days granted as an extension of time (EOT) under the contract.',
    `geographic_location` STRING COMMENT 'Three‑letter ISO country code where the contract work is performed.. Valid values are `^[A-Z]{3}$`',
    `governing_law` STRING COMMENT 'Jurisdiction whose law governs the contract.',
    `health_safety_plan_ref` STRING COMMENT 'Reference to the HSE plan governing safety on the contract site.',
    `insurance_requirements` STRING COMMENT 'Required insurance coverage and limits for the contract.',
    `liquidated_damages_amount` DECIMAL(18,2) COMMENT 'Monetary amount payable for each day of delay beyond the agreed completion date.',
    `milestone_schedule` STRING COMMENT 'Key project milestones linked to contract payments.',
    `notice_to_proceed_date` DATE COMMENT 'Date the client issued the Notice to Proceed (NTP) to start work.',
    `payment_schedule` STRING COMMENT 'Description of payment milestones, dates, and conditions.',
    `performance_bond_amount` DECIMAL(18,2) COMMENT 'Security amount posted by the contractor to guarantee performance.',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of each payment retained until contract close‑out.',
    `revised_completion_date` DATE COMMENT 'New contract completion date after amendment.',
    `revised_contract_value` DECIMAL(18,2) COMMENT 'Contract value after applying the amendment.',
    `scope_description` STRING COMMENT 'Narrative description of the work scope covered by the agreement.',
    `special_conditions` STRING COMMENT 'Any special or bespoke conditions that modify standard contract terms.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contract record.',
    `wbs_reference` STRING COMMENT 'Identifier linking the contract to the associated Work Breakdown Structure.',
    CONSTRAINT pk_agreement PRIMARY KEY(`agreement_id`)
) COMMENT 'Master contract record representing the authoritative SSOT for all contractual agreements in the construction domain. Captures FIDIC-based EPC, GMP (Guaranteed Maximum Price), lump-sum, unit-rate, DB (Design-Build), DBB (Design-Bid-Build), PPP (Public-Private Partnership), and BOT (Build-Operate-Transfer) contract types via a type classification attribute. Stores contract identity, scope narrative, detailed scope of works including WBS (Work Breakdown Structure) reference, deliverable descriptions, technical specifications reference, BOQ (Bill of Quantities) linkage, geographic boundaries, and exclusions. Records execution dates, NTP (Notice to Proceed) date, contract value, currency, governing law, dispute resolution mechanism, contract status lifecycle from award through close-out, and particular/special conditions that modify standard form terms. Maintains status transition history for audit and lifecycle analytics. Records all formal amendments including supplemental agreements, deed of variations, and novation agreements with amendment number, type, effective date, revised contract value, revised completion date, and execution status. Serves as the authoritative scope baseline against which change orders and EOT claims are evaluated.';

CREATE OR REPLACE TABLE `construction_ecm`.`contract`.`party` (
    `party_id` BIGINT COMMENT 'System‑generated unique identifier for each party associated with a contract.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Required for Contract Administration Report linking each contract party to the client account it represents, enabling account‑level performance and compliance tracking.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Parties are associated with the agreement they belong to; linking provides inbound/outbound relationship.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Needed for Communication Log and Regulatory Contact Register to identify the primary client contact responsible for a contract party.',
    `jv_structure_id` BIGINT COMMENT 'Foreign key linking to client.jv_structure. Business justification: JV contract administration requires linking each JV party record to the governing JV structure to access profit-sharing basis, liability structure, and management arrangements. Construction contract m',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Maps each contract party that is a supplier to its vendor record, enabling vendor performance tracking per contract.',
    `vendor_qualification_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor_qualification. Business justification: A contract party that is a vendor must have been qualified before contract award. Linking party to vendor_qualification enables prequalification compliance verification, insurance and bonding capacity',
    `address_line1` STRING COMMENT 'Primary street address of the party.',
    `address_line2` STRING COMMENT 'Additional address information (suite, floor, etc.).',
    `bank_account_number` STRING COMMENT 'Account number used for contract‑related payments.',
    `bank_name` STRING COMMENT 'Financial institution where the partys account is held.',
    `city` STRING COMMENT 'City component of the mailing address.',
    `contact_email` STRING COMMENT 'Main email used for contractual communications.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary telephone number for reaching the party.',
    `country_code` STRING COMMENT 'Three‑letter country code for the mailing address.. Valid values are `[A-Z]{3}`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time the party record was first entered into the system.',
    `insurance_certificate_number` STRING COMMENT 'Reference number of the insurance policy covering the party.',
    `insurance_expiry_date` DATE COMMENT 'Date when the provided insurance coverage ends.',
    `is_jv_partner` BOOLEAN COMMENT 'True when the party participates as a JV partner in the contract.',
    `is_primary_party` BOOLEAN COMMENT 'True when the party is the main responsible entity for the contract.',
    `jurisdiction` STRING COMMENT 'Three‑letter country code where the party is legally registered.. Valid values are `[A-Z]{3}`',
    `legal_entity_name` STRING COMMENT 'Official registered name of the corporate entity.',
    `liability_limit_amount` DECIMAL(18,2) COMMENT 'Monetary cap on the partys contractual liability.',
    `notes` STRING COMMENT 'Additional comments, observations, or special conditions related to the party.',
    `participation_percentage` DECIMAL(18,2) COMMENT 'Percentage of ownership or profit share for joint‑venture partners.',
    `party_name` STRING COMMENT 'Full legal name of the party (individual or organization) as it appears in the contract.',
    `party_status` STRING COMMENT 'Operational status of the party within the contract management system.. Valid values are `active|inactive|terminated|suspended`',
    `party_type` STRING COMMENT 'Category that defines the business role of the party in construction contracts.',
    `payment_terms` STRING COMMENT 'Agreed payment schedule (e.g., Net 30).. Valid values are `net30|net45|net60|net90|upon_receipt`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the mailing address.',
    `record_source_system` STRING COMMENT 'Name of the operational system of record that originated the party data.',
    `registration_number` STRING COMMENT 'Government‑issued registration identifier for the legal entity.',
    `role_in_contract` STRING COMMENT 'The functional role the party plays for the specific contract (e.g., owner, contractor).. Valid values are `owner|contractor|consultant|guarantor|subcontractor|joint_venture`',
    `signatory_authority` BOOLEAN COMMENT 'True when the party is authorized to execute the contract on behalf of its organization.',
    `state_province` STRING COMMENT 'State or province component of the mailing address.',
    `tax_identifier` STRING COMMENT 'Government‑issued tax ID for the party.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the latest modification to the party record.',
    CONSTRAINT pk_party PRIMARY KEY(`party_id`)
) COMMENT 'Association entity capturing all parties bound to a contract agreement, including the employer/client, general contractor (GC), joint venture (JV) partners, engineer/consultant, and guarantors. Records party role, signatory authority, legal entity name, registration number, jurisdiction, and participation percentage for JV arrangements. Enables multi-party contract structures common in EPC and PPP delivery models.';

CREATE OR REPLACE TABLE `construction_ecm`.`contract`.`scope` (
    `scope_id` BIGINT COMMENT 'Unique identifier for the contract scope record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Each contract scope belongs to a single agreement; adding agreement_id creates a parent link and eliminates the silo.',
    `boq_id` BIGINT COMMENT 'Reference to the BOQ that quantifies the scope items.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Contract scope items are mapped to finance cost codes for job costing and budget allocation. This mapping is fundamental to construction cost control — each scope element must be coded to enable budge',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to project.site. Business justification: Contract scope defines work performed at a specific site. Linking contract_scope to site enables site-based contract reporting, HSE compliance tracking per site, and eliminates denormalized site_addre',
    `technical_specification_id` BIGINT COMMENT 'Identifier for the technical specification linked to the scope.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element that the scope aligns to.',
    `wbs_node_id` BIGINT COMMENT 'Foreign key linking to schedule.wbs_node. Business justification: Contract scope items must be mapped to schedule WBS nodes for earned value measurement and payment certification. In construction, the contract BOQ/scope is aligned to the programme WBS to enable cost',
    `actual_end_date` DATE COMMENT 'Actual date work on the scope was completed.',
    `actual_start_date` DATE COMMENT 'Actual date work on the scope began.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the scope was formally approved.',
    `attachments_flag` BOOLEAN COMMENT 'Indicates whether supporting documents are attached to the scope record.',
    `change_order_count` STRING COMMENT 'Number of change orders that have been applied to this scope.',
    `city` STRING COMMENT 'City where the scope work is performed.',
    `compliance_requirements` STRING COMMENT 'Text describing regulatory or compliance conditions tied to the scope.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the scope is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the scope record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `USD|EUR|GBP|JPY|CAD`',
    `dlp_end_date` DATE COMMENT 'Date when the defects liability period expires.',
    `effective_end_date` DATE COMMENT 'Date when the scope ceases to be binding (nullable for open‑ended scopes).',
    `effective_start_date` DATE COMMENT 'Date when the scope becomes contractually binding.',
    `eot_entitlement_flag` BOOLEAN COMMENT 'Indicates whether the scope includes entitlement to extensions of time.',
    `exclusions` STRING COMMENT 'Text describing work items explicitly excluded from the scope.',
    `geographic_area` STRING COMMENT 'Textual description of the geographic boundaries covered by the scope.',
    `inclusions` STRING COMMENT 'Text describing work items explicitly included in the scope.',
    `liquidated_damages_amount` DECIMAL(18,2) COMMENT 'Monetary amount stipulated for liquidated damages under the contract.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the scope.',
    `planned_end_date` DATE COMMENT 'Planned completion date for the scope.',
    `planned_start_date` DATE COMMENT 'Planned start date for execution of the scope.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the total quantity (e.g., cubic meters, kilograms).. Valid values are `m3|kg|ton|unit|sq_m`',
    `region` STRING COMMENT 'Region or state within the country for the scope location.',
    `revision_number` STRING COMMENT 'Sequential revision number for the scope document.',
    `risk_level` STRING COMMENT 'Overall risk classification for the scope.. Valid values are `low|medium|high|critical`',
    `scope_code` STRING COMMENT 'Business identifier code for the scope of works.',
    `scope_name` STRING COMMENT 'Human‑readable name or title of the scope of works.',
    `scope_status` STRING COMMENT 'Current lifecycle status of the scope.. Valid values are `active|inactive|completed|cancelled|draft`',
    `scope_type` STRING COMMENT 'Classification of the scope (e.g., design, construction, procurement).. Valid values are `design|construction|procurement|commissioning|maintenance`',
    `total_amount` DECIMAL(18,2) COMMENT 'Monetary value of the scope before taxes and adjustments.',
    `total_quantity` DECIMAL(18,2) COMMENT 'Aggregate quantity of all items covered by the scope.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the scope record.',
    `version_number` STRING COMMENT 'Version identifier (e.g., v1.0, v2.1) for the scope.',
    `wbs_reference` STRING COMMENT 'Human‑readable WBS code or description.',
    CONSTRAINT pk_scope PRIMARY KEY(`scope_id`)
) COMMENT 'Defines the detailed scope of works attached to a contract agreement, including WBS (Work Breakdown Structure) reference, deliverable descriptions, technical specifications reference, BOQ (Bill of Quantities) linkage, geographic boundaries, and exclusions. Serves as the authoritative scope baseline against which change orders and EOT (Extension of Time) claims are evaluated.';

CREATE OR REPLACE TABLE `construction_ecm`.`contract`.`contract_milestone` (
    `contract_milestone_id` BIGINT COMMENT 'System-generated unique identifier for the contract milestone record.',
    `agreement_id` BIGINT COMMENT 'Identifier of the parent contract to which this milestone belongs.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project associated with the contract milestone.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Construction milestones (e.g., commence piling, open to traffic) are gated by specific permits. Project controls teams verify permit validity before approving milestone completion. This link suppo',
    `project_milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Contract milestones (payment triggers, LD triggers) must be reconciled against project schedule milestones in Primavera. Direct FK enables contract administrators to verify contractual milestone dates',
    `party_id` BIGINT COMMENT 'Identifier of the party (e.g., contractor, project manager) responsible for delivering the milestone.',
    `site_id` BIGINT COMMENT 'Foreign key linking to site.site. Business justification: Sectional and practical completion milestones are tied to specific physical sites. Milestone certificate issuance, LD triggering, and DLP tracking all require site-level milestone reporting. Construct',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Milestones are tied to work fronts for progress monitoring and payment certification.',
    `actual_date` DATE COMMENT 'Date the milestone was actually achieved or certified.',
    `amendment_number` STRING COMMENT 'Sequential number of any amendment made to the milestone.',
    `amendment_reason` STRING COMMENT 'Reason provided for the most recent amendment to the milestone.',
    `compliance_status` STRING COMMENT 'Indicates compliance of the milestone with contractual and regulatory requirements.. Valid values are `compliant|non-compliant|pending`',
    `contract_milestone_description` STRING COMMENT 'Free‑text description providing additional context for the milestone.',
    `contract_milestone_status` STRING COMMENT 'Current lifecycle status of the milestone.. Valid values are `planned|forecasted|achieved|delayed|cancelled`',
    `cost_variance_amount` DECIMAL(18,2) COMMENT 'Difference between milestone_value and amount actually paid.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the milestone record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the milestone value.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `defects_notified_date` DATE COMMENT 'Date the employer formally notified the contractor of defects.',
    `dlp_end_date` DATE COMMENT 'End date of the Defects Liability Period.',
    `dlp_start_date` DATE COMMENT 'Start date of the Defects Liability Period associated with the milestone.',
    `final_certificate_issued_date` DATE COMMENT 'Date the final completion certificate was issued.',
    `forecast_date` DATE COMMENT 'Updated forecasted date based on progress and risk assessments.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the milestone is deemed critical for project schedule or payment.',
    `ld_rate_per_day` DECIMAL(18,2) COMMENT 'Daily rate applied if liquidated damages are triggered.',
    `ld_triggered` BOOLEAN COMMENT 'Indicates whether liquidated damages have been incurred for this milestone.',
    `liquidated_damages_applicable` BOOLEAN COMMENT 'Flag indicating whether liquidated damages may be assessed for this milestone.',
    `milestone_code` STRING COMMENT 'Business identifier code for the milestone, used in contracts and payment schedules.',
    `milestone_name` STRING COMMENT 'Descriptive name of the milestone (e.g., Notice to Proceed, Practical Completion).',
    `milestone_type` STRING COMMENT 'Classification of the milestone type according to contract terminology.. Valid values are `NTP|Sectional Completion|Practical Completion|Final Certificate|DLP Start|DLP End`',
    `milestone_value` DECIMAL(18,2) COMMENT 'Monetary value of the milestone, often linked to a payment certificate.',
    `notes` STRING COMMENT 'Additional notes or comments entered by users.',
    `outstanding_defects_flag` BOOLEAN COMMENT 'Indicates whether any defects remain unresolved at DLP expiry.',
    `payment_certificate_date` DATE COMMENT 'Date the payment certificate was issued.',
    `payment_certificate_number` STRING COMMENT 'Reference number of the payment certificate linked to the milestone.',
    `performance_certificate_date` DATE COMMENT 'Date the performance certificate was issued.',
    `performance_certificate_issued` BOOLEAN COMMENT 'Flag showing if a performance certificate has been issued for the milestone.',
    `planned_date` DATE COMMENT 'Date originally scheduled for the milestone in the contract baseline.',
    `rectification_deadline` DATE COMMENT 'Deadline by which the contractor must rectify notified defects.',
    `regulatory_reference` STRING COMMENT 'Reference to specific regulatory clause or standard governing the milestone (e.g., FIDIC Clause 12.1).',
    `retention_amount` DECIMAL(18,2) COMMENT 'Portion of the milestone value retained until final acceptance.',
    `retention_release_date` DATE COMMENT 'Scheduled date for releasing retained amounts after final acceptance.',
    `schedule_variance_days` STRING COMMENT 'Difference in days between planned_date and actual_date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the milestone record.',
    CONSTRAINT pk_contract_milestone PRIMARY KEY(`contract_milestone_id`)
) COMMENT 'Tracks contractually obligated milestones, key dates, and DLP (Defects Liability Period) obligations within a contract. Covers NTP (Notice to Proceed), sectional completion dates, practical completion, DLP start/end dates, performance certificate issuance, and final certificate dates. Records planned date, forecast date, actual achieved date, milestone value (if linked to payment), milestone type, and milestone status. Manages the complete DLP register including defects notified by the employer, contractor rectification commitments, rectification deadlines, outstanding defects at DLP expiry, and the transition from practical completion through to final certificate issuance and retention release. Used for LD (Liquidated Damages) trigger assessment, payment certification, DLP management, and retention release scheduling.';

CREATE OR REPLACE TABLE `construction_ecm`.`contract`.`payment_schedule` (
    `payment_schedule_id` BIGINT COMMENT 'System-generated unique identifier for the payment schedule.',
    `agreement_id` BIGINT COMMENT 'Identifier of the contract to which this payment schedule belongs.',
    `contract_milestone_id` BIGINT COMMENT 'Identifier of the milestone associated with the payment.',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: In phased construction contracts, payment installments are structured around project phase completions (e.g., 30% on completion of foundations phase). Linking payment_schedule to phase enables phase-b',
    `actual_payment_date` DATE COMMENT 'Date the payment was actually made.',
    `advance_balance_remaining` DECIMAL(18,2) COMMENT 'Outstanding advance amount yet to be recovered.',
    `advance_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the advance payment disbursed.',
    `advance_payment_flag` BOOLEAN COMMENT 'Indicates whether this schedule includes an advance payment component.',
    `advance_recovery_amount` DECIMAL(18,2) COMMENT 'Cumulative amount recovered from subsequent payments.',
    `business_event_timestamp` TIMESTAMP COMMENT 'Timestamp representing the business event that generated the schedule, e.g., milestone approval.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment schedule record was created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the payment amounts.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount applied to the gross amount before tax.',
    `due_date` DATE COMMENT 'Date by which the payment is contractually due.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before taxes, discounts, or retentions.',
    `guarantee_reference` STRING COMMENT 'Reference to the advance payment guarantee document.',
    `installment_number` STRING COMMENT 'Sequence number of this payment within the overall schedule.',
    `is_final_payment` BOOLEAN COMMENT 'True if this schedule represents the final payment of the contract.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle state of the payment schedule.. Valid values are `draft|active|closed|void`',
    `net_amount` DECIMAL(18,2) COMMENT 'Amount payable after tax, discount, and retention adjustments.',
    `net_amount_after_discount` DECIMAL(18,2) COMMENT 'Net payable amount after discount and before tax.',
    `notes` STRING COMMENT 'Additional remarks or observations related to the payment schedule.',
    `payment_certificate_date` DATE COMMENT 'Date the payment certificate was issued.',
    `payment_certificate_number` STRING COMMENT 'Reference number of the payment certificate issued for this schedule.',
    `payment_method` STRING COMMENT 'Means by which the payment will be transferred.. Valid values are `bank_transfer|cheque|cash|credit_card`',
    `payment_method_reference` STRING COMMENT 'Reference details for the payment method, such as bank account number.',
    `payment_schedule_description` STRING COMMENT 'Free-text description providing additional context for the payment schedule.',
    `payment_source` STRING COMMENT 'Originating party responsible for the payment.. Valid values are `employer|client|owner`',
    `payment_status` STRING COMMENT 'Current processing status of the payment.. Valid values are `pending|approved|paid|rejected|cancelled`',
    `payment_terms` STRING COMMENT 'Contractual terms governing payment timing, e.g., Net 30.',
    `payment_type` STRING COMMENT 'Classification of the payment schedule based on its nature.. Valid values are `milestone|time_based|retention|advance|final`',
    `retention_amount` DECIMAL(18,2) COMMENT 'Amount retained from the payment as per contract terms.',
    `retention_release_amount` DECIMAL(18,2) COMMENT 'Amount of retention to be released on the scheduled release date.',
    `retention_release_date` DATE COMMENT 'Date when the retained amount is scheduled to be released.',
    `schedule_number` STRING COMMENT 'External reference number for the payment schedule as defined in the contract.',
    `scheduled_date` DATE COMMENT 'Date the payment is scheduled to be processed.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the gross amount.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate percentage for the payment.',
    `total_installments` STRING COMMENT 'Total number of installments defined in the contract.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment schedule record.',
    CONSTRAINT pk_payment_schedule PRIMARY KEY(`payment_schedule_id`)
) COMMENT 'Defines the contractual payment schedule governing when and how much the employer is obligated to pay the contractor, including full advance payment (mobilization payment) lifecycle management. Captures payment terms, payment intervals, payment due dates, payment method, currency, and supports both milestone-based and time-based payment structures as defined under FIDIC and GMP contract forms. Manages the complete advance payment lifecycle: advance payment amount, percentage of contract value, disbursement date, repayment/recovery schedule, cumulative amount recovered through payment certificate deductions, outstanding advance balance, advance payment guarantee reference, and advance payment status from initial disbursement through full recovery. Serves as the authoritative SSOT for all payment scheduling and advance payment tracking, alongside progress payment and retention release scheduling.';

CREATE OR REPLACE TABLE `construction_ecm`.`contract`.`payment_certificate` (
    `payment_certificate_id` BIGINT COMMENT 'System-generated unique identifier for the payment certificate record.',
    `agreement_id` BIGINT COMMENT 'Reference to the master contract to which this certificate belongs.',
    `construction_project_id` BIGINT COMMENT 'Reference to the project associated with the contract.',
    `contract_milestone_id` BIGINT COMMENT 'Foreign key linking to contract.contract_milestone. Business justification: payment_certificate currently stores milestone_code as a denormalized STRING. In construction, payment certificates are frequently triggered by milestone achievement (e.g., IPC issued upon reaching a ',
    `payment_schedule_id` BIGINT COMMENT 'Foreign key linking to contract.payment_schedule. Business justification: A payment certificate (IPC/FPC) is issued to fulfill a specific scheduled payment installment defined in the payment_schedule. Linking payment_certificate to payment_schedule enables reconciliation be',
    `progress_measurement_id` BIGINT COMMENT 'Foreign key linking to project.progress_measurement. Business justification: Payment certification in construction is directly based on measured progress. Engineers certify payment against a specific progress measurement record. This link enables audit traceability from paymen',
    `progress_update_id` BIGINT COMMENT 'Foreign key linking to schedule.progress_update. Business justification: Payment certificates are issued based on a specific progress update period. In construction, the certifying engineer references the schedule progress update (SPI, percent complete, earned value) when ',
    `site_id` BIGINT COMMENT 'Foreign key linking to site.site. Business justification: Payment certificates are issued per site/section in multi-site contracts. Finance and commercial teams filter payment certificates by site for cash flow reporting, site-level cost control, and client ',
    `trade_package_id` BIGINT COMMENT 'Foreign key linking to bid.trade_package. Business justification: Payment certificates in construction are issued per trade package to track certified value against awarded package budget. Project controls teams run certified vs awarded by trade package reports fo',
    `actual_payment_date` DATE COMMENT 'Date on which the payment was actually received.',
    `advance_recovery_amount` DECIMAL(18,2) COMMENT 'Amount recovered against any previously paid advances.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the certificate was approved.',
    `certificate_number` STRING COMMENT 'Business identifier assigned to each payment certificate, following the convention CP########.. Valid values are `^CP[0-9]{8}$`',
    `certification_date` TIMESTAMP COMMENT 'Timestamp when the certificate was formally issued.',
    `certification_version` STRING COMMENT 'Version number for revised certificates.',
    `certified_amount` DECIMAL(18,2) COMMENT 'Gross amount certified for payment before deductions.',
    `change_order_reference` STRING COMMENT 'Reference number of any change order affecting this payment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certificate record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO code of the currency for the payment.. Valid values are `^[A-Z]{3}$`',
    `invoice_date` DATE COMMENT 'Date the invoice was issued.',
    `invoice_number` STRING COMMENT 'Reference to the invoice generated for this certificate.',
    `is_advance_recovered` BOOLEAN COMMENT 'True when an advance payment is being recovered.',
    `is_ld_applied` BOOLEAN COMMENT 'True when liquidated damages are deducted.',
    `is_pay_when_paid` BOOLEAN COMMENT 'Indicates whether payment is contingent on receipt of funds from the client.',
    `is_retention_applied` BOOLEAN COMMENT 'Indicates if retention is being held for this certificate.',
    `ld_deduction_amount` DECIMAL(18,2) COMMENT 'Deduction applied for liquidated damages, if any.',
    `net_amount_due` DECIMAL(18,2) COMMENT 'Final payable amount after all deductions.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the certificate.',
    `payment_certificate_status` STRING COMMENT 'Current lifecycle state of the certificate.. Valid values are `draft|issued|approved|rejected|paid|cancelled`',
    `payment_due_date` DATE COMMENT 'Date by which the net amount is contractually due.',
    `payment_method` STRING COMMENT 'Means by which the payment will be made.. Valid values are `bank_transfer|cheque|cash|letter_of_credit`',
    `payment_status` STRING COMMENT 'Current status of the payment transaction.. Valid values are `pending|processed|failed|reconciled`',
    `payment_type` STRING COMMENT 'Indicates whether the certificate is for an interim or final payment.. Valid values are `interim|final`',
    `retention_amount` DECIMAL(18,2) COMMENT 'Amount retained per contract terms, deducted from the certified amount.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the certified amount.',
    `tax_code` STRING COMMENT 'Code representing the tax regime applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the certificate record.',
    CONSTRAINT pk_payment_certificate PRIMARY KEY(`payment_certificate_id`)
) COMMENT 'Transactional record of each interim payment certificate (IPC) and final payment certificate (FPC) issued under a main contract or subcontract. Captures certified amount, retention deducted, advance payment recovery, LD deductions, net amount due, certification date, certifier identity, payment due date, and actual payment date. Supports both main contract certification (FIDIC Clause 14) and subcontract payment certification via a contract-level discriminator distinguishing main contract from subcontract certificates. Records subcontract payment applications, certified amounts, and enables back-to-back payment flow management between main contract receipts and subcontractor disbursements. Supports cash flow forecasting, pay-when-paid clause administration, and unified payment reconciliation across the full contract hierarchy.';

CREATE OR REPLACE TABLE `construction_ecm`.`contract`.`contract_change_order` (
    `contract_change_order_id` BIGINT COMMENT 'System generated unique identifier for the contract change order record.',
    `contract_milestone_id` BIGINT COMMENT 'Foreign key linking to contract.contract_milestone. Business justification: A change order frequently impacts a specific contractual milestone — most commonly the completion milestone (revised_completion_date is already on the CCO). Adding affected_contract_milestone_id links',
    `agreement_id` BIGINT COMMENT 'Identifier of the original contract to which this change order applies.',
    `estimate_id` BIGINT COMMENT 'Foreign key linking to bid.estimate. Business justification: Change orders are priced using a revised estimate produced by the estimating team. The change order must reference that estimate for cost substantiation, variation audit trails, and contract value rec',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Change orders altering scope, location, or construction method require a new or amended permit before execution. Contract administrators track which permit amendment is triggered by each change order ',
    `scope_id` BIGINT COMMENT 'Foreign key linking to contract.contract_scope. Business justification: A contract change order (CO/variation) modifies a specific scope of work defined in contract_scope. contract_change_order has scope_description (a change-specific description of what is being changed)',
    `vendor_id` BIGINT COMMENT 'Identifier of the contractor or subcontractor responsible for executing the change order work.',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Change orders frequently affect a particular work front; the link supports impact analysis per front.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of adjustments (e.g., taxes, fees, discounts) applied to the gross amount.',
    `approved_by` STRING COMMENT 'Name of the individual or authority that approved the change order.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the change order received approval.',
    `change_order_number` STRING COMMENT 'External reference number assigned to the change order by the contract administration system.',
    `change_order_type` STRING COMMENT 'Classification of the change order purpose, e.g., addition, omission, time extension, price adjustment, or scope change.. Valid values are `addition|omission|time_extension|price_adjustment|scope_change`',
    `comments` STRING COMMENT 'Free‑form notes or remarks entered by users regarding the change order.',
    `contract_change_order_status` STRING COMMENT 'Current lifecycle status of the change order.. Valid values are `draft|submitted|approved|rejected|executed|closed`',
    `cost_impact_amount` DECIMAL(18,2) COMMENT 'Monetary impact of the change order on the contract price (positive for additions, negative for omissions).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the change order record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for monetary values.',
    `dlp_end_date` DATE COMMENT 'Date when the Defects Liability Period expires for work covered by the change order.',
    `effective_date` DATE COMMENT 'Date on which the change order becomes contractually effective.',
    `eot_claim_reference` STRING COMMENT 'Link to any Extension of Time claim associated with the schedule impact.',
    `executed_timestamp` TIMESTAMP COMMENT 'Date and time when the change order was executed and became binding.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before any adjustments, taxes, or discounts.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the change order is considered critical to project delivery.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified the change order record.',
    `ld_provision_amount` DECIMAL(18,2) COMMENT 'Monetary amount stipulated for liquidated damages if the change order affects performance penalties.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final payable amount after adjustments.',
    `reason_code` STRING COMMENT 'Standardized code indicating why the change order was initiated.. Valid values are `employer_directed|unforeseen_condition|design_change|regulatory|client_request`',
    `revised_completion_date` DATE COMMENT 'New contract completion date after applying schedule impact.',
    `schedule_impact_days` STRING COMMENT 'Number of days the contract schedule is extended or reduced due to the change order.',
    `scope_description` STRING COMMENT 'Narrative description of the work scope affected by the change order.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the change order was formally submitted for approval.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the change order record.',
    `variation_instruction_reference` STRING COMMENT 'Reference to the original variation instruction that triggered this change order.',
    `created_by` STRING COMMENT 'User identifier of the person who created the change order record.',
    CONSTRAINT pk_contract_change_order PRIMARY KEY(`contract_change_order_id`)
) COMMENT 'Authoritative log of all CO (Change Orders) and contract variations issued against a contract. Records variation instruction reference, scope description, reason code (employer-directed, unforeseen conditions, design change), cost impact (addition or omission), schedule impact in days, approval status, and executed value. Tracks the full variation lifecycle from instruction through valuation, negotiation, and formal execution. Links to EOT claims where schedule impact is asserted.';

CREATE OR REPLACE TABLE `construction_ecm`.`contract`.`eot_claim` (
    `eot_claim_id` BIGINT COMMENT 'System generated unique identifier for the EOT claim record.',
    `contract_milestone_id` BIGINT COMMENT 'Foreign key linking to contract.contract_milestone. Business justification: An EOT (Extension of Time) claim is submitted to extend the date of a specific contractual milestone — typically the completion milestone. contract_eot_claim has claim_original_schedule_date and claim',
    `agreement_id` BIGINT COMMENT 'Identifier of the underlying contract to which this EOT claim relates.',
    `authority_notice_id` BIGINT COMMENT 'Foreign key linking to compliance.authority_notice. Business justification: Authority notices (stop-work orders, permit suspensions, enforcement notices) are primary delay events substantiating EOT claims. Construction contracts explicitly recognize regulatory authority actio',
    `ncr_id` BIGINT COMMENT 'Identifier of a Non‑Conformance Report linked to the claim.',
    `rfi_id` BIGINT COMMENT 'Identifier of a Request for Information that is associated with the claim.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project associated with the claim.',
    `contract_change_order_id` BIGINT COMMENT 'Identifier of a change order that may be linked to the time extension request.',
    `delay_event_id` BIGINT COMMENT 'Foreign key linking to schedule.delay_event. Business justification: EOT claims are substantiated by specific delay events recorded in the schedule. In construction contract administration, every EOT claim must reference the causative delay event(s) for entitlement ass',
    `fleet_assignment_id` BIGINT COMMENT 'Foreign key linking to equipment.fleet_assignment. Business justification: EOT claims are frequently substantiated by evidence of equipment non-availability or delayed mobilization. Linking an EOT claim to the specific fleet assignment that caused or contributed to the delay',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: EOT claims in construction are frequently caused by safety incidents triggering stop-work orders or work suspension. Construction claims managers must reference the causative incident record to substa',
    `maintenance_order_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_order. Business justification: Equipment breakdown requiring emergency maintenance is a recognized EOT entitlement event. Linking an EOT claim to the causative maintenance order provides documentary evidence for the claim, supports',
    `party_id` BIGINT COMMENT 'Identifier of the contractor submitting the EOT claim.',
    `project_milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: EOT claims reference specific project schedule milestones that were delayed. claim_impact_on_milestones is currently a text field. Direct FK to project_milestone enables quantitative delay analysis, s',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: EOT claims arise from delay events at specific work fronts. Linking enables delay analysis by work front, supports EOT substantiation reports, and allows site managers to identify which work fronts ar',
    `claim_amount` DECIMAL(18,2) COMMENT 'Financial value of the claim based on days claimed and daily rate.',
    `claim_approved_by` STRING COMMENT 'Name of the individual who approved or rejected the claim.',
    `claim_assessor_comments` STRING COMMENT 'Free‑text comments entered by the engineer or assessor during evaluation.',
    `claim_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the claim record was first created in the system.',
    `claim_currency` STRING COMMENT 'Three‑letter ISO currency code for the claim amount.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `claim_decision_date` DATE COMMENT 'Date when the final decision on the claim was recorded.',
    `claim_external_reference` STRING COMMENT 'Reference number used by external parties (e.g., client or auditor) to identify the claim.',
    `claim_final_amount` DECIMAL(18,2) COMMENT 'Final monetary amount after any adjustments or partial approvals.',
    `claim_final_days` STRING COMMENT 'Total number of days finally approved for the extension.',
    `claim_impact_on_milestones` STRING COMMENT 'Explanation of how the extension affects key project milestones.',
    `claim_is_critical` BOOLEAN COMMENT 'True if the claim is deemed critical to project delivery or financial exposure.',
    `claim_new_schedule_date` DATE COMMENT 'Projected completion date after applying the approved extension.',
    `claim_notes` STRING COMMENT 'Additional free‑form notes captured by any stakeholder.',
    `claim_number` STRING COMMENT 'Unique claim number assigned by the contractor or system for tracking.',
    `claim_original_schedule_date` DATE COMMENT 'Baseline project completion date before any extensions.',
    `claim_priority` STRING COMMENT 'Priority level assigned to the claim for processing urgency.. Valid values are `high|medium|low`',
    `claim_resolution_date` DATE COMMENT 'Date when the claim was fully closed and any adjustments were posted.',
    `claim_review_date` DATE COMMENT 'Date on which the claim was formally reviewed by the project engineer.',
    `claim_source_system` STRING COMMENT 'Originating operational system where the claim was first recorded.. Valid values are `Procore|Primavera|SAP`',
    `claim_status` STRING COMMENT 'Current processing status of the claim within the claim lifecycle.. Valid values are `submitted|under_review|approved|rejected|withdrawn`',
    `claim_status_reason` STRING COMMENT 'Explanation for the current status, such as reason for rejection or hold.',
    `claim_submission_timestamp` TIMESTAMP COMMENT 'Date and time when the contractor formally submitted the EOT claim.',
    `claim_type` STRING COMMENT 'Category describing the contractual basis for the time extension request.. Valid values are `employer_risk|force_majeure|client_change|weather|other`',
    `claim_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the claim record.',
    `days_assessed` STRING COMMENT 'Number of days approved by the engineer after assessment.',
    `days_claimed` STRING COMMENT 'Number of calendar days the contractor claims as an extension.',
    `delay_event_description` STRING COMMENT 'Narrative description of the event that caused the schedule delay.',
    `determination_outcome` STRING COMMENT 'Final decision result after engineering review.. Valid values are `approved|rejected|partial|pending`',
    `entitlement_basis` STRING COMMENT 'FIDIC sub‑clause or contractual provision that justifies the claim.',
    `liquidated_damages_impact` DECIMAL(18,2) COMMENT 'Estimated reduction in liquidated damages exposure due to the approved extension.',
    `revised_completion_date` DATE COMMENT 'New projected project completion date after the approved extension.',
    `supporting_document_refs` STRING COMMENT 'Comma‑separated list of document IDs (e.g., drawings, logs, photos) that substantiate the claim.',
    CONSTRAINT pk_eot_claim PRIMARY KEY(`eot_claim_id`)
) COMMENT 'Records EOT (Extension of Time) claims submitted by the contractor asserting entitlement to additional time due to employer risk events, force majeure, or other contractual grounds. Captures claim submission date, delay event description, days claimed, days assessed by engineer, grounds of entitlement (FIDIC Sub-Clause reference), supporting documentation references, and final determination outcome. Critical for managing LD (Liquidated Damages) exposure and revised completion date.';

CREATE OR REPLACE TABLE `construction_ecm`.`contract`.`ld_assessment` (
    `ld_assessment_id` BIGINT COMMENT 'System-generated unique identifier for each liquidated damages assessment record.',
    `agreement_id` BIGINT COMMENT 'Reference to the contract to which this LD assessment applies.',
    `payment_certificate_id` BIGINT COMMENT 'Reference to the payment certificate from which the LD amount will be deducted.',
    `project_milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: LD assessments are triggered by delays to specific project schedule milestones (is_ld_trigger flag on project_milestone). Direct FK enables LD calculation based on actual vs planned milestone dates fr',
    `actual_completion_date` DATE COMMENT 'Date on which the milestone was actually completed, as recorded on site.',
    `assessed_by` STRING COMMENT 'Name of the individual or team that performed the LD assessment.',
    `assessment_date` DATE COMMENT 'Date on which the LD assessment was formally recorded.',
    `assessment_number` STRING COMMENT 'Business identifier assigned to the LD assessment, typically following the contracts numbering scheme.. Valid values are `^LD-d{6}$`',
    `assessment_reason` STRING COMMENT 'Narrative explanation for why the LD assessment was generated (e.g., missed milestone, force majeure).',
    `assessment_status` STRING COMMENT 'Current processing status of the LD assessment.. Valid values are `pending|approved|rejected|waived`',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the LD amounts (e.g., USD, EUR).',
    `delay_days` STRING COMMENT 'Number of calendar days the milestone was delayed beyond the due date.',
    `ld_rate_per_day` DECIMAL(18,2) COMMENT 'Contractual LD rate applied for each day of delay, expressed in the contract currency.',
    `ld_waiver_flag` BOOLEAN COMMENT 'Indicates whether a waiver has been granted for this assessment (true = waiver granted).',
    `ld_waiver_justification` STRING COMMENT 'Explanation or contractual clause supporting the granted waiver.',
    `milestone_due_date` DATE COMMENT 'Scheduled date by which the milestone was contractually required to be achieved.',
    `milestone_name` STRING COMMENT 'Descriptive name of the contractual milestone that was missed (e.g., "Substantial Completion").',
    `net_ld_deducted` DECIMAL(18,2) COMMENT 'Final liquidated damages amount deducted from the payment certificate after waivers.',
    `notes` STRING COMMENT 'Additional free‑form comments or observations related to the assessment.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the LD assessment record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the LD assessment record.',
    `total_ld_amount` DECIMAL(18,2) COMMENT 'Gross liquidated damages amount before any waivers or reductions.',
    `waiver_amount` DECIMAL(18,2) COMMENT 'Amount of LD that has been waived or reduced per contractual negotiation.',
    CONSTRAINT pk_ld_assessment PRIMARY KEY(`ld_assessment_id`)
) COMMENT 'Tracks LD (Liquidated Damages) assessments applied or withheld against a contractor for failure to achieve contractual completion milestones. Records the milestone missed, LD rate per day (as defined in the contract appendix), number of days in delay, total LD amount assessed, any LD waiver or reduction granted, and the net LD deducted from payment certificates. Provides the authoritative LD register for financial reporting and dispute management.';

CREATE OR REPLACE TABLE `construction_ecm`.`contract`.`retention_ledger` (
    `retention_ledger_id` BIGINT COMMENT 'System-generated unique identifier for each retention ledger record.',
    `agreement_id` BIGINT COMMENT 'Identifier of the contract to which this retention record belongs.',
    `contract_milestone_id` BIGINT COMMENT 'Foreign key linking to contract.contract_milestone. Business justification: contract_retention_ledger currently stores contract_milestone_code as a denormalized STRING. Retention release events are directly tied to milestone achievement (e.g., 50% retention released at practi',
    `payment_certificate_id` BIGINT COMMENT 'Identifier of the payment certificate that triggered the retention calculation.',
    `contract_retention_ledger_status` STRING COMMENT 'Current lifecycle status of the retention ledger entry.. Valid values are `active|released|closed|cancelled`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ledger record was first inserted.',
    `cumulative_retention_balance` DECIMAL(18,2) COMMENT 'Running total of retention still held after this release.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for all monetary values in this record.. Valid values are `^[A-Z]{3}$`',
    `effective_timestamp` TIMESTAMP COMMENT 'Exact point in time when the retention entry became effective.',
    `notes` STRING COMMENT 'Additional free‑form comments or observations related to the entry.',
    `release_amount` DECIMAL(18,2) COMMENT 'Amount of retention released in this transaction (partial or full).',
    `release_date` DATE COMMENT 'Calendar date on which the retention amount was released.',
    `release_reason` STRING COMMENT 'Free‑text explanation for why the retention was released (e.g., milestone achieved, DLP expiry).',
    `retention_adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary adjustment to the retention (positive or negative) applied after initial calculation.',
    `retention_adjustment_reason` STRING COMMENT 'Explanation for why a retention adjustment was made.',
    `retention_amount` DECIMAL(18,2) COMMENT 'Monetary amount retained for this entry before any releases.',
    `retention_bond_amount` DECIMAL(18,2) COMMENT 'Monetary value of the retention bond when substitution occurs.',
    `retention_bond_currency` STRING COMMENT 'Currency of the retention bond amount.. Valid values are `^[A-Z]{3}$`',
    `retention_bond_substituted_flag` BOOLEAN COMMENT 'Indicates whether a retention bond was used in place of cash retention.',
    `retention_entry_number` STRING COMMENT 'Human‑readable sequential identifier for the retention entry, often used in reports and certificates.',
    `retention_hold_expiry_date` DATE COMMENT 'Date when a retention hold is scheduled to be lifted if unresolved.',
    `retention_hold_flag` BOOLEAN COMMENT 'Indicates if the retention amount is currently on hold (e.g., due to dispute).',
    `retention_hold_reason` STRING COMMENT 'Explanation for why the retention is being held.',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of the payment amount retained as per contract terms (e.g., 5.00%).',
    `retention_release_percentage` DECIMAL(18,2) COMMENT 'Percentage of the total retention released in this transaction.',
    `retention_release_sequence` STRING COMMENT 'Ordinal number indicating the order of releases for a given contract.',
    `retention_release_type` STRING COMMENT 'Reason category for the retention release (e.g., practical completion, DLP expiry).. Valid values are `practical_completion|defects_liability|bond_substitution|partial|final`',
    `retention_source` STRING COMMENT 'Origin of the retention amount (e.g., regular payment certificate, change order, or manual adjustment).. Valid values are `payment_certificate|change_order|adjustment`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the ledger record.',
    CONSTRAINT pk_retention_ledger PRIMARY KEY(`retention_ledger_id`)
) COMMENT 'Tracks the accumulation and release of retention monies held under a contract. Records retention percentage applied per payment certificate, cumulative retention balance, practical completion release amount (typically 50% of retention), DLP (Defects Liability Period) expiry release amount, retention bond substitution details, and any partial releases approved. Provides the authoritative retention balance for financial reconciliation.';

CREATE OR REPLACE TABLE `construction_ecm`.`contract`.`amendment` (
    `amendment_id` BIGINT COMMENT 'Unique surrogate key for each contract amendment record.',
    `agreement_id` BIGINT COMMENT 'Identifier of the original contract to which this amendment applies.',
    `contract_change_order_id` BIGINT COMMENT 'Identifier of a change order linked to this amendment, if applicable.',
    `contract_milestone_id` BIGINT COMMENT 'Foreign key linking to contract.contract_milestone. Business justification: amendment currently stores contract_milestone as a denormalized STRING field. Formal contract amendments frequently modify specific milestone dates (e.g., revised completion date, DLP end date). Addin',
    `schedule_baseline_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_baseline. Business justification: Contract amendments that extend time or revise scope require a revised schedule baseline. Linking amendment to the resulting schedule_baseline enables contract administrators to track which programme ',
    `amendment_category` STRING COMMENT 'High-level category of impact caused by the amendment.. Valid values are `financial|schedule|scope|quality|safety`',
    `amendment_description` STRING COMMENT 'Narrative description of the amendment purpose and changes.',
    `amendment_number` STRING COMMENT 'Sequential identifier assigned to the amendment within the contract lifecycle.',
    `amendment_scope` STRING COMMENT 'Detailed description of the scope changes introduced.',
    `amendment_status` STRING COMMENT 'Current lifecycle status of the amendment.. Valid values are `draft|pending_approval|approved|rejected|executed|closed`',
    `amendment_type` STRING COMMENT 'Category of amendment indicating its nature.. Valid values are `supplemental|variation|novation|deed_of_variation|addendum`',
    `approval_date` DATE COMMENT 'Date when the amendment was approved.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the amendment.',
    `change_order_number` STRING COMMENT 'External change order number associated with the amendment.',
    `change_summary` STRING COMMENT 'Brief summary of key changes introduced by the amendment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the amendment record was created in the system.',
    `document_reference` STRING COMMENT 'Reference identifier or path to the signed amendment document.',
    `document_signed_flag` BOOLEAN COMMENT 'Indicates whether the amendment document has been signed.',
    `document_storage_path` STRING COMMENT 'File system or repository path where the signed amendment is stored.',
    `effective_date` DATE COMMENT 'Date when the amendment becomes legally effective.',
    `effective_until` DATE COMMENT 'Date until which the amendment remains in effect, if applicable.',
    `execution_status` STRING COMMENT 'Operational execution status of the amendment implementation.. Valid values are `not_started|in_progress|completed|cancelled`',
    `impact_financial` DECIMAL(18,2) COMMENT 'Monetary impact of the amendment on the contract value.',
    `impact_schedule_days` STRING COMMENT 'Number of days added or removed from the contract schedule due to the amendment.',
    `impact_scope_description` STRING COMMENT 'Narrative description of how the scope is affected.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the amendment contains confidential information.',
    `last_modified_by` STRING COMMENT 'User identifier who last modified the amendment record.',
    `legal_review_status` STRING COMMENT 'Status of the legal review process for the amendment.. Valid values are `not_started|in_review|approved|rejected`',
    `notes` STRING COMMENT 'Additional free-text notes related to the amendment.',
    `original_completion_date` DATE COMMENT 'Original contract completion date prior to amendment.',
    `original_contract_value` DECIMAL(18,2) COMMENT 'Contract value before any amendments.',
    `payment_adjustment_amount` DECIMAL(18,2) COMMENT 'Adjustment to payment schedule amount due to amendment.',
    `payment_schedule_new_date` DATE COMMENT 'New date for the next payment after amendment.',
    `reason_code` STRING COMMENT 'Code representing the primary reason for the amendment.. Valid values are `design_change|scope_change|regulatory|client_request|cost_overrun`',
    `revised_completion_date` DATE COMMENT 'New contract completion date after amendment.',
    `revised_contract_value` DECIMAL(18,2) COMMENT 'Total contract value after applying the amendment.',
    `risk_rating` STRING COMMENT 'Risk rating assigned to the amendment.. Valid values are `low|medium|high|critical`',
    `signed_date` DATE COMMENT 'Date when the amendment was signed by the parties.',
    `source_system` STRING COMMENT 'Source system where the amendment originated.. Valid values are `Procore|SAP|Viewpoint|Custom`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the amendment record.',
    `version` STRING COMMENT 'Version number of the amendment record for change tracking.',
    `created_by` STRING COMMENT 'User identifier who created the amendment record.',
    CONSTRAINT pk_amendment PRIMARY KEY(`amendment_id`)
) COMMENT 'Records formal amendments to the original contract agreement, including supplemental agreements, deed of variations, and novation agreements. Captures amendment number, amendment type, effective date, description of changes to original terms, revised contract value, revised completion date, and execution status. Maintains a complete amendment history for each contract to support audit and dispute resolution.';

CREATE OR REPLACE TABLE `construction_ecm`.`contract`.`bond_guarantee` (
    `bond_guarantee_id` BIGINT COMMENT 'Unique surrogate key for the bond guarantee record.',
    `agreement_id` BIGINT COMMENT 'Identifier of the contract to which this bond guarantee is attached.',
    `bond_id` BIGINT COMMENT 'Foreign key linking to bid.bond. Business justification: Bid bonds (bid domain) are converted to performance/retention bond guarantees (contract domain) upon award. Finance and legal teams must reconcile the originating bid bond against the contract-stage g',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project associated with the bond guarantee.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Environmental and performance bonds in construction are frequently mandated by specific regulatory obligations (e.g., rehabilitation bonds required by environmental authority conditions). Bond managem',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Connects bond guarantee issuing party to vendor master, required for bond compliance and risk reporting.',
    `vendor_qualification_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor_qualification. Business justification: Bond guarantees are issued based on vendor bonding capacity verified during qualification. Linking bond_guarantee to vendor_qualification enables verification that the vendors bonding capacity covers',
    `bond_amount` DECIMAL(18,2) COMMENT 'Monetary value of the bond guarantee.',
    `bond_guarantee_description` STRING COMMENT 'Free-text description or notes about the bond guarantee.',
    `bond_guarantee_status` STRING COMMENT 'Current lifecycle status of the bond guarantee.. Valid values are `active|expired|called|released|pending|cancelled`',
    `bond_type` STRING COMMENT 'Classification of the bond guarantee type.. Valid values are `performance|advance|retention|bid|parent_company`',
    `call_condition_description` STRING COMMENT 'Conditions under which the bond can be called by the obligee.',
    `call_date` DATE COMMENT 'Date when the bond was called, if applicable.',
    `compliance_requirements` STRING COMMENT 'Regulatory compliance requirements applicable to the bond guarantee (e.g., OSHA, ISO 9001).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bond guarantee record was created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code of the bond amount.. Valid values are `^[A-Z]{3}$`',
    `effective_from` DATE COMMENT 'Date from which the bond guarantee becomes effective.',
    `effective_until` DATE COMMENT 'Date until which the bond guarantee remains in effect, if different from expiry.',
    `expiry_date` DATE COMMENT 'Date when the bond guarantee expires.',
    `guarantee_number` STRING COMMENT 'Unique identifier assigned to the bond guarantee by the issuing surety or bank.',
    `guarantee_purpose` STRING COMMENT 'Purpose of the bond guarantee within the contract.. Valid values are `performance|payment|maintenance|completion|other`',
    `issue_date` DATE COMMENT 'Date when the bond guarantee was issued.',
    `jurisdiction` STRING COMMENT 'Legal jurisdiction governing the bond guarantee. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|AUS|DEU|FRA|CHN|IND|BRA — promote to reference product]',
    `release_date` DATE COMMENT 'Date when the bond was released or returned to the issuer.',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of the contract value retained under the bond, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the bond guarantee record.',
    CONSTRAINT pk_bond_guarantee PRIMARY KEY(`bond_guarantee_id`)
) COMMENT 'Tracks all performance bonds, advance payment guarantees, retention bonds, bid bonds, and parent company guarantees associated with a contract. Records bond type, issuing bank or surety, bond amount, bond currency, issue date, expiry date, call conditions, and current status (active, expired, called, released). Provides the authoritative bond register for contract administration and financial risk management.';

CREATE OR REPLACE TABLE `construction_ecm`.`contract`.`subcontract` (
    `subcontract_id` BIGINT COMMENT 'System generated unique identifier for the subcontract record.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Subcontracts are executed under a specific legal entity for intercompany accounting, tax compliance, and statutory reporting. In JV and multi-entity construction groups, knowing which company code a s',
    `env_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.env_impact_assessment. Business justification: Subcontract Environmental Assessment: linking subcontract to its specific environmental assessment ensures compliance monitoring.',
    `hse_plan_id` BIGINT COMMENT 'Foreign key linking to safety.hse_plan. Business justification: Construction subcontracts legally require a governing HSE plan per regulatory and contractual obligation. HSE officers and project managers track which HSE plan governs each subcontractors work scope',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: REQUIRED: Subcontracts specify the exact material to be supplied; this FK supports the Subcontract‑Material tracking sheet used in procurement.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Subcontract Permit Requirement: each subcontract must reference the permit(s) required for its scope of work.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to quality.quality_plan. Business justification: Subcontracts require a Subcontractor Quality Management Plan as a contractual deliverable in the Subcontractor Quality Compliance process. Construction main contractors must reference the approved Q',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: In construction, a PO is raised to authorize and fund a subcontract. Linking subcontract to purchase_order enables 3-way match (PO/GR/invoice), committed cost tracking, and procurement-to-contract tra',
    `rfq_id` BIGINT COMMENT 'Foreign key linking to procurement.rfq. Business justification: Subcontracts are awarded following an RFQ to subcontractors. Linking subcontract to rfq provides the procurement basis for the subcontract award — required for subcontractor procurement audit trail, s',
    `scope_id` BIGINT COMMENT 'Foreign key linking to contract.contract_scope. Business justification: A subcontract is let by the main contractor to cover a specific portion of the contract scope (e.g., MEP works, civil works, specialist trade). Linking subcontract to contract_scope establishes the fo',
    `site_id` BIGINT COMMENT 'Foreign key linking to site.site. Business justification: Subcontracts govern work at a specific physical site. HSE compliance audits, site access control registers, and subcontractor management reports require querying all active subcontracts per site. A co',
    `agreement_id` BIGINT COMMENT 'Identifier of the parent/main contract to which this subcontract is linked.',
    `subcontract_main_contract_agreement_id` BIGINT COMMENT 'Identifier of the overarching contract under which this subcontract is issued.',
    `submission_id` BIGINT COMMENT 'Foreign key linking to bid.submission. Business justification: The awarded subcontract must reference the winning bid submission for procurement compliance, audit trails, and value-for-money reporting. Construction procurement regulations require traceability fro',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: Under Australian WHS legislation and equivalent international standards, each subcontract work package must reference a SWMS before work commences. Construction HSE managers routinely verify SWMS cove',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Subcontracts are scoped against specific technical specifications (e.g., civil works spec, MEP spec) that define the subcontractors workmanship standards and deliverables. Procurement and quality aud',
    `trade_package_id` BIGINT COMMENT 'Foreign key linking to bid.trade_package. Business justification: Subcontracts are awarded to execute a specific trade package scope. Construction procurement teams track which trade package each subcontract fulfils for budget reconciliation, package closeout report',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Links subcontract vendor to master vendor for compliance, insurance, and bonding checks.',
    `change_order_count` STRING COMMENT 'Total number of change orders issued against this subcontract.',
    `completion_date` DATE COMMENT 'Target date for subcontract completion as per the contract.',
    `compliance_status` STRING COMMENT 'Current compliance status of the subcontract with regulatory and contractual obligations.. Valid values are `compliant|non_compliant|pending`',
    `contract_category` STRING COMMENT 'High‑level category of the subcontract agreement (e.g., Engineering Procurement Construction, Guaranteed Maximum Price, Lump‑Sum).. Valid values are `EPC|GMP|LumpSum|UnitRate|CostPlus|TimeAndMaterial`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the subcontract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the subcontract value.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `defects_liability_period_end` DATE COMMENT 'Date when the defects liability period expires.',
    `effective_from` DATE COMMENT 'Date when the subcontract becomes legally binding (often the Notice to Proceed date).',
    `effective_until` DATE COMMENT 'Date when the subcontract ends or expires; null for open‑ended agreements.',
    `extension_of_time_days` STRING COMMENT 'Number of days granted as an extension of time for project completion.',
    `insurance_requirements` STRING COMMENT 'Summary of insurance coverage obligations for the subcontractor.',
    `liquidated_damages_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount stipulated for delays or breaches.',
    `milestone_description` STRING COMMENT 'Key contractual milestones associated with the subcontract.',
    `notice_to_proceed_date` DATE COMMENT 'Date when the subcontractor is authorized to commence work.',
    `payment_schedule_description` STRING COMMENT 'Textual description of the payment milestones and dates.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed for the subcontract.. Valid values are `net30|net45|net60|milestone|upon_completion`',
    `risk_rating` STRING COMMENT 'Qualitative risk rating assigned to the subcontract.. Valid values are `low|medium|high`',
    `scope_summary` STRING COMMENT 'Brief textual description of the work scope covered by the subcontract.',
    `subcontract_number` STRING COMMENT 'External contract number or code assigned to the subcontract as defined in the main contract documents.',
    `subcontract_status` STRING COMMENT 'Current lifecycle state of the subcontract.. Valid values are `draft|active|suspended|terminated|completed|closed`',
    `subcontract_type` STRING COMMENT 'Classification of the subcontract based on procurement approach (e.g., domestic, nominated, specialist, trade).. Valid values are `domestic|nominated|specialist|trade`',
    `updated_by` STRING COMMENT 'User identifier who last modified the subcontract record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the subcontract record.',
    `value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the subcontract as agreed in the contract.',
    `created_by` STRING COMMENT 'User identifier who created the subcontract record.',
    CONSTRAINT pk_subcontract PRIMARY KEY(`subcontract_id`)
) COMMENT 'Master record for subcontracts let by the main contractor to specialist trade and MEP (Mechanical Electrical Plumbing) subcontractors under the main contract. Captures subcontract type (domestic, nominated, specialist), subcontract value, scope summary, back-to-back terms with main contract, NTP date, completion date, and subcontract status. Distinct from the subcontractor domain master — this entity owns the contractual instrument, not the subcontractor party profile.';

CREATE OR REPLACE TABLE `construction_ecm`.`contract`.`subcontract_payment` (
    `subcontract_payment_id` BIGINT COMMENT 'System-generated unique identifier for the subcontract payment record.',
    `agreement_id` BIGINT COMMENT 'Identifier of the master contract under which the subcontract work is performed.',
    `subcontract_id` BIGINT COMMENT 'Foreign key linking to contract.subcontract. Business justification: subcontract_payment is the transactional payment record issued under a specific subcontract. Every payment application and certificate belongs to exactly one subcontract. Currently subcontract_payment',
    `vendor_invoice_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor_invoice. Business justification: Subcontract payments are processed against vendor invoices. Linking subcontract_payment to vendor_invoice enables payment reconciliation, audit trail, and accounts payable matching — essential for con',
    `actual_payment_date` DATE COMMENT 'Date the payment was actually received by the subcontractor.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of taxes, fees, or other adjustments applied to the gross amount.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amounts.. Valid values are `^[A-Z]{3}$`',
    `due_date` DATE COMMENT 'Date by which the payment is contractually due.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount claimed before any deductions.',
    `is_late_payment` BOOLEAN COMMENT 'True if the actual payment date is later than the due date.',
    `is_ld_deduction_applied` BOOLEAN COMMENT 'True when liquidated damages have been deducted from the payment.',
    `is_retention_applied` BOOLEAN COMMENT 'True when a retention amount is held back from the payment.',
    `ld_deduction_amount` DECIMAL(18,2) COMMENT 'Amount deducted for liquidated damages, if applicable.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after all adjustments and deductions.',
    `notes` STRING COMMENT 'Free-text field for any additional comments or explanations.',
    `payment_channel` STRING COMMENT 'Interface through which the payment was processed.. Valid values are `electronic|manual|portal|mobile`',
    `payment_date` DATE COMMENT 'Date the payment was issued to the subcontractor.',
    `payment_method` STRING COMMENT 'Instrument used to make the payment.. Valid values are `bank_transfer|check|cash|credit_card|wire|online`',
    `payment_number` STRING COMMENT 'Business-visible identifier assigned to the payment application (e.g., PAY-2023-00123).. Valid values are `^[A-Z0-9-]+$`',
    `payment_type` STRING COMMENT 'Classification of the payment (e.g., progress payment, final payment).. Valid values are `progress|final|retention_release|interim`',
    `retention_amount` DECIMAL(18,2) COMMENT 'Portion of the payment retained per contract terms.',
    `retention_percent` DECIMAL(18,2) COMMENT 'Retention expressed as a percentage of the gross amount.',
    `subcontract_payment_status` STRING COMMENT 'Current lifecycle state of the payment record.. Valid values are `draft|submitted|approved|rejected|paid|cancelled`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the payment record.',
    CONSTRAINT pk_subcontract_payment PRIMARY KEY(`subcontract_payment_id`)
) COMMENT 'Transactional record of payment applications and payment certificates issued under each subcontract. Captures application amount, certified amount, retention deducted, LD deductions, net payment due, payment due date, and actual payment date. Enables back-to-back payment flow management between main contract receipts and subcontractor disbursements, supporting cash flow forecasting and pay-when-paid clause administration.';

CREATE OR REPLACE TABLE `construction_ecm`.`contract`.`closeout` (
    `closeout_id` BIGINT COMMENT 'System-generated unique identifier for each contract closeout record.',
    `agreement_id` BIGINT COMMENT 'Identifier of the original contract that is being closed out.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.assessment. Business justification: Contract closeout checklists in construction require a compliance assessment sign-off (environmental audit, regulatory clearance) before the final certificate is issued. Role-prefixed compliance_asse',
    `contract_milestone_id` BIGINT COMMENT 'Foreign key linking to contract.contract_milestone. Business justification: In construction contracts, practical completion is a formal contractual milestone that triggers DLP commencement, retention release, and the closeout process. closeout has practical_completion_date bu',
    `document_register_id` BIGINT COMMENT 'Identifier of the primary document package associated with the closeout.',
    `payment_certificate_id` BIGINT COMMENT 'Foreign key linking to contract.payment_certificate. Business justification: closeout currently stores final_payment_certificate_number as a denormalized STRING. The contract closeout process is formally concluded with the issuance of a Final Payment Certificate (FPC). Adding ',
    `vendor_invoice_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor_invoice. Business justification: Contract closeout requires confirmation that the final vendor invoice has been settled. Linking closeout to the final vendor_invoice supports financial closeout, final account reconciliation, and audi',
    `handover_package_id` BIGINT COMMENT 'Foreign key linking to design.handover_package. Business justification: Contract closeout cannot be finalized until all handover packages are client-accepted. Final account and closeout reporting requires direct traceability from the closeout record to the handover packag',
    `hse_plan_id` BIGINT COMMENT 'Foreign key linking to safety.hse_plan. Business justification: Contract closeout in construction requires formal verification that all HSE plan obligations have been fulfilled before issuing the final certificate. Contract administrators and HSE managers referenc',
    `party_id` BIGINT COMMENT 'Identifier of the primary party (owner/client) associated with the closeout.',
    `schedule_milestone_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_milestone. Business justification: Contract closeout is triggered by achievement of the practical completion schedule milestone. closeout already references practical_completion_milestone_id (contract domain), but the schedule_mileston',
    `punch_list_id` BIGINT COMMENT 'Foreign key linking to quality.punch_list. Business justification: Contract closeout is gated by punch list completion in the Practical Completion / Handover Gate process. A construction contract administrator must reference the specific punch list to confirm all i',
    `site_id` BIGINT COMMENT 'Foreign key linking to site.site. Business justification: Contract closeout is executed site-by-site on large infrastructure projects. Handover documentation, defects liability period tracking, O&M manual delivery, and regulatory sign-off all require the clo',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of adjustments (retentions, penalties, change order impacts) applied to the gross amount.',
    `approved_by` STRING COMMENT 'Name of the individual who approved the closeout.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the closeout was approved.',
    `bond_release_flag` BOOLEAN COMMENT 'Indicates whether performance/bid bonds have been released.',
    `change_order_summary` STRING COMMENT 'Narrative summary of all change orders applied during the project.',
    `checklist_completed_date` DATE COMMENT 'Date when the closeout checklist was marked as completed.',
    `checklist_status` STRING COMMENT 'Progress status of the closeout checklist.. Valid values are `not_started|in_progress|completed`',
    `closeout_date` DATE COMMENT 'Date on which the contract was officially closed out.',
    `closeout_number` STRING COMMENT 'External reference number assigned to the contract closeout process.',
    `closeout_status` STRING COMMENT 'Current lifecycle state of the closeout record.. Valid values are `draft|in_review|approved|rejected|closed`',
    `compliance_status` STRING COMMENT 'Overall regulatory compliance status of the closeout.. Valid values are `compliant|non_compliant|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the closeout record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.',
    `dlp_end_date` DATE COMMENT 'Date when the Defects Liability Period expires.',
    `eot_claims_settled_flag` BOOLEAN COMMENT 'Indicates whether all Extension of Time claims have been settled.',
    `final_account_gross_amount` DECIMAL(18,2) COMMENT 'Total gross amount before adjustments for the final account.',
    `final_contract_value` DECIMAL(18,2) COMMENT 'Contract value after all change orders and adjustments.',
    `is_finalized` BOOLEAN COMMENT 'Indicates whether the closeout record has been finalized and locked.',
    `ld_waiver_flag` BOOLEAN COMMENT 'Indicates whether a waiver for liquidated damages was granted.',
    `lessons_learned_reference` STRING COMMENT 'Link or identifier to the documented lessons‑learned record for the project.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final net amount payable after all adjustments.',
    `o_m_manual_handover_date` DATE COMMENT 'Date the Operations & Maintenance manual was handed over to the client.',
    `original_contract_value` DECIMAL(18,2) COMMENT 'The baseline contract amount before any changes.',
    `performance_certificate_issued_date` DATE COMMENT 'Date the performance certificate was issued to the contractor.',
    `practical_completion_date` DATE COMMENT 'Date when practical completion of the project was declared.',
    `remarks` STRING COMMENT 'Free‑form comments or notes about the closeout.',
    `retention_release_flag` BOOLEAN COMMENT 'Indicates whether retention monies have been released (true) or are still held (false).',
    `signed_by_contractor` STRING COMMENT 'Name of the contractor signatory on the final closeout documents.',
    `signed_timestamp` TIMESTAMP COMMENT 'Date and time when the contractor signed the closeout documents.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the closeout record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between final and original contract values.',
    `warranty_end_date` DATE COMMENT 'End date of the warranty period.',
    `warranty_start_date` DATE COMMENT 'Start date of the warranty period for the completed works.',
    CONSTRAINT pk_closeout PRIMARY KEY(`closeout_id`)
) COMMENT 'Records the formal contract close-out process including practical completion declaration, final account agreement, performance certificate issuance, final payment certificate, retention release, bond release, and O&M (Operations and Maintenance) manual handover. Captures close-out checklist status, outstanding punch list items, final contract value versus original contract value, and lessons learned reference. Marks the definitive end of contractual obligations.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `construction_ecm`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`contract`.`scope` ADD CONSTRAINT `fk_contract_scope_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ADD CONSTRAINT `fk_contract_contract_milestone_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ADD CONSTRAINT `fk_contract_contract_milestone_party_id` FOREIGN KEY (`party_id`) REFERENCES `construction_ecm`.`contract`.`party`(`party_id`);
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ADD CONSTRAINT `fk_contract_payment_schedule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ADD CONSTRAINT `fk_contract_payment_schedule_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `construction_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ADD CONSTRAINT `fk_contract_payment_certificate_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ADD CONSTRAINT `fk_contract_payment_certificate_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `construction_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ADD CONSTRAINT `fk_contract_payment_certificate_payment_schedule_id` FOREIGN KEY (`payment_schedule_id`) REFERENCES `construction_ecm`.`contract`.`payment_schedule`(`payment_schedule_id`);
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ADD CONSTRAINT `fk_contract_contract_change_order_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `construction_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ADD CONSTRAINT `fk_contract_contract_change_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ADD CONSTRAINT `fk_contract_contract_change_order_scope_id` FOREIGN KEY (`scope_id`) REFERENCES `construction_ecm`.`contract`.`scope`(`scope_id`);
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ADD CONSTRAINT `fk_contract_eot_claim_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `construction_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ADD CONSTRAINT `fk_contract_eot_claim_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ADD CONSTRAINT `fk_contract_eot_claim_contract_change_order_id` FOREIGN KEY (`contract_change_order_id`) REFERENCES `construction_ecm`.`contract`.`contract_change_order`(`contract_change_order_id`);
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ADD CONSTRAINT `fk_contract_eot_claim_party_id` FOREIGN KEY (`party_id`) REFERENCES `construction_ecm`.`contract`.`party`(`party_id`);
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ADD CONSTRAINT `fk_contract_ld_assessment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ADD CONSTRAINT `fk_contract_ld_assessment_payment_certificate_id` FOREIGN KEY (`payment_certificate_id`) REFERENCES `construction_ecm`.`contract`.`payment_certificate`(`payment_certificate_id`);
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ADD CONSTRAINT `fk_contract_retention_ledger_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ADD CONSTRAINT `fk_contract_retention_ledger_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `construction_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ADD CONSTRAINT `fk_contract_retention_ledger_payment_certificate_id` FOREIGN KEY (`payment_certificate_id`) REFERENCES `construction_ecm`.`contract`.`payment_certificate`(`payment_certificate_id`);
ALTER TABLE `construction_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_contract_change_order_id` FOREIGN KEY (`contract_change_order_id`) REFERENCES `construction_ecm`.`contract`.`contract_change_order`(`contract_change_order_id`);
ALTER TABLE `construction_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `construction_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ADD CONSTRAINT `fk_contract_bond_guarantee_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_scope_id` FOREIGN KEY (`scope_id`) REFERENCES `construction_ecm`.`contract`.`scope`(`scope_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_subcontract_main_contract_agreement_id` FOREIGN KEY (`subcontract_main_contract_agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ADD CONSTRAINT `fk_contract_subcontract_payment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ADD CONSTRAINT `fk_contract_subcontract_payment_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `construction_ecm`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `construction_ecm`.`contract`.`closeout` ADD CONSTRAINT `fk_contract_closeout_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `construction_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `construction_ecm`.`contract`.`closeout` ADD CONSTRAINT `fk_contract_closeout_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `construction_ecm`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `construction_ecm`.`contract`.`closeout` ADD CONSTRAINT `fk_contract_closeout_payment_certificate_id` FOREIGN KEY (`payment_certificate_id`) REFERENCES `construction_ecm`.`contract`.`payment_certificate`(`payment_certificate_id`);
ALTER TABLE `construction_ecm`.`contract`.`closeout` ADD CONSTRAINT `fk_contract_closeout_party_id` FOREIGN KEY (`party_id`) REFERENCES `construction_ecm`.`contract`.`party`(`party_id`);

-- ========= TAGS =========
ALTER SCHEMA `construction_ecm`.`contract` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `construction_ecm`.`contract` SET TAGS ('dbx_domain' = 'contract');
ALTER TABLE `construction_ecm`.`contract`.`agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`contract`.`agreement` SET TAGS ('dbx_subdomain' = 'contract_setup');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement ID');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `client_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Client Opportunity Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `env_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `framework_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Client Framework Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `rfp_issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Rfp Issuance Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending|active|suspended|terminated|closed');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `amendment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'supplemental|variation|novation');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `boq_reference` SET TAGS ('dbx_business_glossary_term' = 'BOQ Reference');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `contract_value` SET TAGS ('dbx_business_glossary_term' = 'Contract Value');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `defects_liability_period_months` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period (Months)');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `dispute_resolution` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `environmental_impact_assessment_ref` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Assessment Reference');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `extension_of_time_days` SET TAGS ('dbx_business_glossary_term' = 'Extension of Time (Days)');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `geographic_location` SET TAGS ('dbx_business_glossary_term' = 'Geographic Location');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `geographic_location` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `health_safety_plan_ref` SET TAGS ('dbx_business_glossary_term' = 'Health & Safety Plan Reference');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `health_safety_plan_ref` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `health_safety_plan_ref` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `liquidated_damages_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Amount');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `milestone_schedule` SET TAGS ('dbx_business_glossary_term' = 'Milestone Schedule');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `notice_to_proceed_date` SET TAGS ('dbx_business_glossary_term' = 'Notice to Proceed Date');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `performance_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Amount');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `revised_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Completion Date');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `revised_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Revised Contract Value');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Conditions');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`agreement` ALTER COLUMN `wbs_reference` SET TAGS ('dbx_business_glossary_term' = 'WBS Reference');
ALTER TABLE `construction_ecm`.`contract`.`party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`contract`.`party` SET TAGS ('dbx_subdomain' = 'contract_setup');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Party Identifier');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `jv_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Jv Structure Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `vendor_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Qualification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `insurance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Number');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `is_jv_partner` SET TAGS ('dbx_business_glossary_term' = 'Joint‑Venture Partner Flag');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `is_primary_party` SET TAGS ('dbx_business_glossary_term' = 'Primary Party Flag');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (Country Code)');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit Amount');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Party Notes');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `participation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Participation Percentage');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `party_name` SET TAGS ('dbx_business_glossary_term' = 'Party Name');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `party_status` SET TAGS ('dbx_business_glossary_term' = 'Party Status');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `party_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|suspended');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `party_type` SET TAGS ('dbx_business_glossary_term' = 'Party Type (Classification)');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|net90|upon_receipt');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `role_in_contract` SET TAGS ('dbx_business_glossary_term' = 'Role in Contract');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `role_in_contract` SET TAGS ('dbx_value_regex' = 'owner|contractor|consultant|guarantor|subcontractor|joint_venture');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `signatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Signatory Authority Flag');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identifier');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`party` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`scope` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`contract`.`scope` SET TAGS ('dbx_subdomain' = 'contract_setup');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `scope_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope ID');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `boq_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Quantities ID');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification ID');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure ID');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `wbs_node_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Node Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Scope End Date');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Scope Start Date');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scope Approval Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `attachments_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachments Present Flag');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `change_order_count` SET TAGS ('dbx_business_glossary_term' = 'Change Order Count');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scope Record Created Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `dlp_end_date` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period End Date');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scope Effective End Date');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scope Effective Start Date');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `eot_entitlement_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension of Time Entitlement Flag');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'Scope Exclusions');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `geographic_area` SET TAGS ('dbx_business_glossary_term' = 'Geographic Area Description');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `inclusions` SET TAGS ('dbx_business_glossary_term' = 'Scope Inclusions');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `liquidated_damages_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Amount');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Scope Notes');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Scope End Date');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Scope Start Date');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'm3|kg|ton|unit|sq_m');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Scope Risk Level');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `scope_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope Code');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `scope_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope Name');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `scope_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope Status');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `scope_status` SET TAGS ('dbx_value_regex' = 'active|inactive|completed|cancelled|draft');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `scope_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope Type');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `scope_type` SET TAGS ('dbx_value_regex' = 'design|construction|procurement|commissioning|maintenance');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Scope Amount');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scope Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `construction_ecm`.`contract`.`scope` ALTER COLUMN `wbs_reference` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure Reference');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` SET TAGS ('dbx_subdomain' = 'contract_setup');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Milestone ID');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `project_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party ID');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Date');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Milestone Amendment Number');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Milestone Amendment Reason');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|pending');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `contract_milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Description');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `contract_milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `contract_milestone_status` SET TAGS ('dbx_value_regex' = 'planned|forecasted|achieved|delayed|cancelled');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `cost_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance Amount');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `defects_notified_date` SET TAGS ('dbx_business_glossary_term' = 'Defects Notified Date');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `dlp_end_date` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period End Date');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `dlp_start_date` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period Start Date');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `final_certificate_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Final Certificate Issued Date');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Date');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Milestone Flag');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `ld_rate_per_day` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Rate per Day');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `ld_triggered` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Triggered');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `liquidated_damages_applicable` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Applicable');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_business_glossary_term' = 'Milestone Code');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'NTP|Sectional Completion|Practical Completion|Final Certificate|DLP Start|DLP End');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `milestone_value` SET TAGS ('dbx_business_glossary_term' = 'Milestone Value');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Milestone Notes');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `outstanding_defects_flag` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Defects Flag');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `payment_certificate_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Certificate Date');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `payment_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Certificate Number');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `performance_certificate_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Certificate Date');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `performance_certificate_issued` SET TAGS ('dbx_business_glossary_term' = 'Performance Certificate Issued');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Date');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `rectification_deadline` SET TAGS ('dbx_business_glossary_term' = 'Rectification Deadline');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `retention_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Amount');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `retention_release_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Release Date');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `schedule_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance (Days)');
ALTER TABLE `construction_ecm`.`contract`.`contract_milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` SET TAGS ('dbx_subdomain' = 'contract_setup');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `payment_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule ID');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone ID');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `actual_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Payment Date (ACT_PAY_DT)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `advance_balance_remaining` SET TAGS ('dbx_business_glossary_term' = 'Advance Balance Remaining (ADV_BAL_REMAIN)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `advance_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Amount (ADV_AMT)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `advance_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Flag (ADV_FLAG)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `advance_recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Recovery Amount (ADV_REC_AMT)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `business_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Business Event Timestamp (EVENT_TS)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (DISC_AMT)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date (DUE_DT)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount (GROSS_AMT)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `guarantee_reference` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Reference (GUAR_REF)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `installment_number` SET TAGS ('dbx_business_glossary_term' = 'Installment Number (INST_NUM)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `is_final_payment` SET TAGS ('dbx_business_glossary_term' = 'Final Payment Indicator (FINAL_FLAG)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LIFECYCLE_STATUS)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|active|closed|void');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (NET_AMT)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `net_amount_after_discount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount After Discount (NET_AMT_DISC)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `payment_certificate_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Certificate Date (CERT_DT)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `payment_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Certificate Number (CERT_NUM)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method (PAY_METHOD)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|cheque|cash|credit_card');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `payment_method_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Reference (PAY_METHOD_REF)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `payment_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule Description (DESC)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `payment_source` SET TAGS ('dbx_business_glossary_term' = 'Payment Source (PAY_SOURCE)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `payment_source` SET TAGS ('dbx_value_regex' = 'employer|client|owner');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status (PAY_STATUS)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|paid|rejected|cancelled');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAY_TERMS)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type (PAY_TYPE)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'milestone|time_based|retention|advance|final');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `retention_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Amount (RET_AMT)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `retention_release_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Release Amount (RET_REL_AMT)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `retention_release_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Release Date (RET_REL_DT)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Number (SCH_NUM)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Payment Date (SCHD_DT)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate (TAX_RATE)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `total_installments` SET TAGS ('dbx_business_glossary_term' = 'Total Installments (TOTAL_INST)');
ALTER TABLE `construction_ecm`.`contract`.`payment_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` SET TAGS ('dbx_subdomain' = 'financial_obligations');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `payment_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Payment Certificate ID');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Milestone Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `payment_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `progress_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Progress Measurement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `progress_update_id` SET TAGS ('dbx_business_glossary_term' = 'Progress Update Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `trade_package_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `actual_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Payment Date');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `advance_recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Recovery Amount (USD)');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Certificate Number (PCN)');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `certificate_number` SET TAGS ('dbx_value_regex' = '^CP[0-9]{8}$');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date and Time');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `certification_version` SET TAGS ('dbx_business_glossary_term' = 'Certification Version');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `certified_amount` SET TAGS ('dbx_business_glossary_term' = 'Certified Amount (USD)');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `change_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Change Order Reference');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `is_advance_recovered` SET TAGS ('dbx_business_glossary_term' = 'Advance Recovery Flag');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `is_ld_applied` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Applied Flag');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `is_pay_when_paid` SET TAGS ('dbx_business_glossary_term' = 'Pay‑When‑Paid Clause Flag');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `is_retention_applied` SET TAGS ('dbx_business_glossary_term' = 'Retention Applied Flag');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `ld_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Deduction (USD)');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `net_amount_due` SET TAGS ('dbx_business_glossary_term' = 'Net Amount Due (USD)');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certificate Notes');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `payment_certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Certificate Status');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `payment_certificate_status` SET TAGS ('dbx_value_regex' = 'draft|issued|approved|rejected|paid|cancelled');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|cheque|cash|letter_of_credit');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|processed|failed|reconciled');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'interim|final');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `retention_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Amount (USD)');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (USD)');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `construction_ecm`.`contract`.`payment_certificate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` SET TAGS ('dbx_subdomain' = 'financial_obligations');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `contract_change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Change Order ID');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Contract Milestone Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Estimate Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `scope_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Change Order Number');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `change_order_type` SET TAGS ('dbx_business_glossary_term' = 'Change Order Type');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `change_order_type` SET TAGS ('dbx_value_regex' = 'addition|omission|time_extension|price_adjustment|scope_change');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `contract_change_order_status` SET TAGS ('dbx_business_glossary_term' = 'Change Order Status');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `contract_change_order_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|executed|closed');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Amount');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `dlp_end_date` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period End Date');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `eot_claim_reference` SET TAGS ('dbx_business_glossary_term' = 'Extension of Time Claim Reference');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `executed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Executed Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Change Order Flag');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `ld_provision_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Provision Amount');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'employer_directed|unforeseen_condition|design_change|regulatory|client_request');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `revised_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Completion Date');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact (Days)');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `variation_instruction_reference` SET TAGS ('dbx_business_glossary_term' = 'Variation Instruction Reference');
ALTER TABLE `construction_ecm`.`contract`.`contract_change_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` SET TAGS ('dbx_subdomain' = 'financial_obligations');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `eot_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Extension of Time (EOT) Claim ID');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Contract Milestone Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `authority_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Authority Notice Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Related NCR ID');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `rfi_id` SET TAGS ('dbx_business_glossary_term' = 'Related RFI ID');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `contract_change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Change Order ID');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `delay_event_id` SET TAGS ('dbx_business_glossary_term' = 'Delay Event Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `fleet_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Assignment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `maintenance_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `project_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Claim Amount (Monetary)');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Claim Approver Name');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_assessor_comments` SET TAGS ('dbx_business_glossary_term' = 'Assessor Comments');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_currency` SET TAGS ('dbx_business_glossary_term' = 'Claim Currency');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Decision Date');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_final_amount` SET TAGS ('dbx_business_glossary_term' = 'Final Claim Amount');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_final_days` SET TAGS ('dbx_business_glossary_term' = 'Final Approved Days');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_impact_on_milestones` SET TAGS ('dbx_business_glossary_term' = 'Milestone Impact Description');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Claim Indicator');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_new_schedule_date` SET TAGS ('dbx_business_glossary_term' = 'New Scheduled Completion Date');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_notes` SET TAGS ('dbx_business_glossary_term' = 'Claim Notes');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'EOT Claim Number');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_original_schedule_date` SET TAGS ('dbx_business_glossary_term' = 'Original Scheduled Completion Date');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_priority` SET TAGS ('dbx_business_glossary_term' = 'Claim Priority');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Resolution Date');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_review_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Review Date');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_source_system` SET TAGS ('dbx_value_regex' = 'Procore|Primavera|SAP');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'EOT Claim Status');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_value_regex' = 'submitted|under_review|approved|rejected|withdrawn');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Claim Submission Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'EOT Claim Type');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'employer_risk|force_majeure|client_change|weather|other');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `claim_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `days_assessed` SET TAGS ('dbx_business_glossary_term' = 'Days Assessed');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `days_claimed` SET TAGS ('dbx_business_glossary_term' = 'Days Claimed');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `delay_event_description` SET TAGS ('dbx_business_glossary_term' = 'Delay Event Description');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `determination_outcome` SET TAGS ('dbx_business_glossary_term' = 'Claim Determination Outcome');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `determination_outcome` SET TAGS ('dbx_value_regex' = 'approved|rejected|partial|pending');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `entitlement_basis` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Basis (FIDIC Clause)');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `liquidated_damages_impact` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Impact');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `revised_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Completion Date');
ALTER TABLE `construction_ecm`.`contract`.`eot_claim` ALTER COLUMN `supporting_document_refs` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document References');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` SET TAGS ('dbx_subdomain' = 'financial_obligations');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `ld_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Assessment ID');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `payment_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Certificate ID');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `project_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `assessed_by` SET TAGS ('dbx_business_glossary_term' = 'Assessed By (ASSESED_BY)');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `assessed_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `assessed_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number (ASSESSMENT_NUMBER)');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_value_regex' = '^LD-d{6}$');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `assessment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assessment Reason (ASSESSMENT_REASON)');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status (ASSESSMENT_STATUS)');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|waived');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `delay_days` SET TAGS ('dbx_business_glossary_term' = 'Delay Days (DELAY_DAYS)');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `ld_rate_per_day` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Rate Per Day (LD_RATE_PER_DAY)');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `ld_waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'LD Waiver Flag');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `ld_waiver_justification` SET TAGS ('dbx_business_glossary_term' = 'LD Waiver Justification');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `milestone_due_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone Due Date');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name (MILESTONE_NAME)');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `net_ld_deducted` SET TAGS ('dbx_business_glossary_term' = 'Net LD Deducted (NET_LD_DEDUCTED)');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `total_ld_amount` SET TAGS ('dbx_business_glossary_term' = 'Total LD Amount (TOTAL_LD_AMOUNT)');
ALTER TABLE `construction_ecm`.`contract`.`ld_assessment` ALTER COLUMN `waiver_amount` SET TAGS ('dbx_business_glossary_term' = 'LD Waiver Amount (LD_WAIVER_AMOUNT)');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` SET TAGS ('dbx_subdomain' = 'financial_obligations');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `retention_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Retention Ledger ID');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Milestone Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `payment_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Certificate ID');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `contract_retention_ledger_status` SET TAGS ('dbx_business_glossary_term' = 'Retention Ledger Status');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `contract_retention_ledger_status` SET TAGS ('dbx_value_regex' = 'active|released|closed|cancelled');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `cumulative_retention_balance` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Retention Balance');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Retention Ledger Notes');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `release_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Release Amount');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Release Date');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `release_reason` SET TAGS ('dbx_business_glossary_term' = 'Retention Release Reason');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `retention_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Adjustment Amount');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `retention_adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Retention Adjustment Reason');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `retention_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Amount');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `retention_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Bond Amount');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `retention_bond_currency` SET TAGS ('dbx_business_glossary_term' = 'Retention Bond Currency (ISO 4217)');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `retention_bond_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `retention_bond_substituted_flag` SET TAGS ('dbx_business_glossary_term' = 'Retention Bond Substituted Flag');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `retention_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Retention Entry Number');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `retention_hold_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Hold Expiry Date');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `retention_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Retention Hold Flag');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `retention_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Retention Hold Reason');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `retention_release_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retention Release Percentage');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `retention_release_sequence` SET TAGS ('dbx_business_glossary_term' = 'Retention Release Sequence');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `retention_release_type` SET TAGS ('dbx_business_glossary_term' = 'Retention Release Type');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `retention_release_type` SET TAGS ('dbx_value_regex' = 'practical_completion|defects_liability|bond_substitution|partial|final');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `retention_source` SET TAGS ('dbx_business_glossary_term' = 'Retention Source');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `retention_source` SET TAGS ('dbx_value_regex' = 'payment_certificate|change_order|adjustment');
ALTER TABLE `construction_ecm`.`contract`.`retention_ledger` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`contract`.`amendment` SET TAGS ('dbx_subdomain' = 'contract_setup');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Amendment ID');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `contract_change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Change Order ID');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Milestone Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `schedule_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Baseline Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_category` SET TAGS ('dbx_business_glossary_term' = 'Amendment Category');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_category` SET TAGS ('dbx_value_regex' = 'financial|schedule|scope|quality|safety');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Description');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_scope` SET TAGS ('dbx_business_glossary_term' = 'Amendment Scope');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|executed|closed');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'supplemental|variation|novation|deed_of_variation|addendum');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Change Order Number');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `change_summary` SET TAGS ('dbx_business_glossary_term' = 'Change Summary');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Amendment Document Reference');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `document_signed_flag` SET TAGS ('dbx_business_glossary_term' = 'Amendment Document Signed Flag');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `document_storage_path` SET TAGS ('dbx_business_glossary_term' = 'Amendment Document Storage Path');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Until');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `execution_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|cancelled');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `impact_financial` SET TAGS ('dbx_business_glossary_term' = 'Amendment Financial Impact (USD)');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `impact_financial` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `impact_financial` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `impact_schedule_days` SET TAGS ('dbx_business_glossary_term' = 'Amendment Schedule Impact (Days)');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `impact_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Scope Impact Description');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Amendment Confidential Flag');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Amendment Last Modified By');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Status');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_value_regex' = 'not_started|in_review|approved|rejected');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Amendment Notes');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `original_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Original Completion Date');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `original_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Original Contract Value (USD)');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `original_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `original_contract_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `payment_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Adjustment Amount (USD)');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `payment_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `payment_adjustment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `payment_schedule_new_date` SET TAGS ('dbx_business_glossary_term' = 'New Payment Schedule Date');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason Code');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'design_change|scope_change|regulatory|client_request|cost_overrun');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `revised_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Completion Date');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `revised_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Revised Contract Value (USD)');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `revised_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `revised_contract_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Amendment Risk Rating');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Amendment Source System');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Procore|SAP|Viewpoint|Custom');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Amendment Version');
ALTER TABLE `construction_ecm`.`contract`.`amendment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Amendment Created By');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` SET TAGS ('dbx_subdomain' = 'contract_setup');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `bond_guarantee_id` SET TAGS ('dbx_business_glossary_term' = 'Bond Guarantee ID');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `bond_id` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Party Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `vendor_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Qualification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Bond Amount (BOND_AMOUNT)');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `bond_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `bond_guarantee_description` SET TAGS ('dbx_business_glossary_term' = 'Bond Description (DESCRIPTION)');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `bond_guarantee_status` SET TAGS ('dbx_business_glossary_term' = 'Bond Status (BOND_STATUS)');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `bond_guarantee_status` SET TAGS ('dbx_value_regex' = 'active|expired|called|released|pending|cancelled');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `bond_type` SET TAGS ('dbx_business_glossary_term' = 'Bond Type (BOND_TYPE)');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `bond_type` SET TAGS ('dbx_value_regex' = 'performance|advance|retention|bid|parent_company');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `call_condition_description` SET TAGS ('dbx_business_glossary_term' = 'Call Condition Description (CALL_CONDITION_DESCRIPTION)');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `call_date` SET TAGS ('dbx_business_glossary_term' = 'Call Date (CALL_DATE)');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements (COMPLIANCE_REQUIREMENTS)');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURRENCY_CODE)');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From (EFFECTIVE_FROM)');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until (EFFECTIVE_UNTIL)');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date (EXPIRY_DATE)');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `guarantee_number` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Number (GUARANTEE_NUMBER)');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `guarantee_purpose` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Purpose (GUARANTEE_PURPOSE)');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `guarantee_purpose` SET TAGS ('dbx_value_regex' = 'performance|payment|maintenance|completion|other');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date (ISSUE_DATE)');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (JURISDICTION)');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date (RELEASE_DATE)');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retention Percentage (RETENTION_PERCENTAGE)');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`bond_guarantee` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` SET TAGS ('dbx_subdomain' = 'contract_setup');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `subcontract_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract ID');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `env_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `hse_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Plan Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Plan Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Rfq Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `scope_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Back‑to‑Back Contract ID');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `subcontract_main_contract_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Main Contract ID');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `trade_package_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `change_order_count` SET TAGS ('dbx_business_glossary_term' = 'Change Order Count');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `contract_category` SET TAGS ('dbx_business_glossary_term' = 'Contract Category');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `contract_category` SET TAGS ('dbx_value_regex' = 'EPC|GMP|LumpSum|UnitRate|CostPlus|TimeAndMaterial');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `defects_liability_period_end` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period End Date');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `extension_of_time_days` SET TAGS ('dbx_business_glossary_term' = 'Extension of Time (Days)');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `liquidated_damages_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Amount');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `liquidated_damages_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `liquidated_damages_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Description');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `notice_to_proceed_date` SET TAGS ('dbx_business_glossary_term' = 'Notice to Proceed Date');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `payment_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule Description');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|milestone|upon_completion');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `scope_summary` SET TAGS ('dbx_business_glossary_term' = 'Scope Summary');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `subcontract_number` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Number');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `subcontract_status` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Status');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `subcontract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|completed|closed');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `subcontract_type` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Type');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `subcontract_type` SET TAGS ('dbx_value_regex' = 'domestic|nominated|specialist|trade');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `value_amount` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Value Amount');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `value_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`subcontract` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` SET TAGS ('dbx_subdomain' = 'financial_obligations');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `subcontract_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Payment ID');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `subcontract_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `actual_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Payment Date');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Payment Amount');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `is_late_payment` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Indicator');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `is_ld_deduction_applied` SET TAGS ('dbx_business_glossary_term' = 'LD Deduction Applied Flag');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `is_retention_applied` SET TAGS ('dbx_business_glossary_term' = 'Retention Applied Flag');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `ld_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Deduction');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'electronic|manual|portal|mobile');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|check|cash|credit_card|wire|online');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'progress|final|retention_release|interim');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `retention_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Amount');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `retention_percent` SET TAGS ('dbx_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `subcontract_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `subcontract_payment_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|paid|cancelled');
ALTER TABLE `construction_ecm`.`contract`.`subcontract_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`closeout` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`contract`.`closeout` SET TAGS ('dbx_subdomain' = 'financial_obligations');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `closeout_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Closeout ID');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Practical Completion Milestone Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `document_register_id` SET TAGS ('dbx_business_glossary_term' = 'Document Reference ID');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `payment_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Final Payment Certificate Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Final Vendor Invoice Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `handover_package_id` SET TAGS ('dbx_business_glossary_term' = 'Handover Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `hse_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Plan Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `schedule_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Practical Completion Schedule Milestone Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `punch_list_id` SET TAGS ('dbx_business_glossary_term' = 'Punch List Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `approved_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `bond_release_flag` SET TAGS ('dbx_business_glossary_term' = 'Bond Release Flag');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `change_order_summary` SET TAGS ('dbx_business_glossary_term' = 'Change Order Summary');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `checklist_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Closeout Checklist Completed Date');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `checklist_status` SET TAGS ('dbx_business_glossary_term' = 'Closeout Checklist Status');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `checklist_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `closeout_date` SET TAGS ('dbx_business_glossary_term' = 'Closeout Date');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `closeout_number` SET TAGS ('dbx_business_glossary_term' = 'Closeout Number');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `closeout_status` SET TAGS ('dbx_business_glossary_term' = 'Closeout Status');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `closeout_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|rejected|closed');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `dlp_end_date` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period End Date');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `eot_claims_settled_flag` SET TAGS ('dbx_business_glossary_term' = 'EOT Claims Settled Flag');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `final_account_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Final Account Gross Amount');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `final_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Final Contract Value');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `is_finalized` SET TAGS ('dbx_business_glossary_term' = 'Is Finalized Flag');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `ld_waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Waiver Flag');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `lessons_learned_reference` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned Reference');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `o_m_manual_handover_date` SET TAGS ('dbx_business_glossary_term' = 'O&M Manual Handover Date');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `original_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Original Contract Value');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `performance_certificate_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Certificate Issued Date');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `practical_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Practical Completion Date');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `retention_release_flag` SET TAGS ('dbx_business_glossary_term' = 'Retention Release Flag');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `signed_by_contractor` SET TAGS ('dbx_business_glossary_term' = 'Signed By Contractor');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `signed_by_contractor` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `signed_by_contractor` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `signed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Contractor Signature Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Variance Amount');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `warranty_end_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty End Date');
ALTER TABLE `construction_ecm`.`contract`.`closeout` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
