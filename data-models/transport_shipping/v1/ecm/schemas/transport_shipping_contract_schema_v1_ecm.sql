-- Schema for Domain: contract | Business: Transport Shipping | Version: v1_ecm
-- Generated on: 2026-05-08 19:52:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `transport_shipping_ecm`.`contract` COMMENT 'Contract and agreement management for customer service contracts, carrier agreements, 3PL/4PL partnerships, and vendor contracts. Manages SLA thresholds, OTD/OTIF KPI commitments, Incoterms (DDP, DAP, FOB, CIF, EXW), rate validity periods, volume commitments, penalty/incentive clauses, contract terms, renewals, and compliance tracking. Interfaces with pricing, billing, and customer domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`agreement` (
    `agreement_id` BIGINT COMMENT 'Unique identifier for the agreement. Primary key for the agreement master record.',
    `carbon_offset_program_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_offset_program. Business justification: Enterprise agreements with carbon-neutral service commitments designate specific offset programs for customer green SLAs. Required for green logistics product fulfillment and customer ESG reporting.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier for carrier agreements. Links to carrier master for capacity allocation, rate management, and performance tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Contract ownership assignment is fundamental for accountability, approval workflows, performance reviews, and audit trails in logistics contract management. The contract_owner string denormalizes empl',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Contracts allocate operational costs to cost centers for internal accounting, budget tracking, and profitability analysis. Essential for cost allocation reporting and variance analysis in logistics op',
    `parent_agreement_id` BIGINT COMMENT 'Reference to the parent or master agreement if this is a subsidiary or regional agreement. Enables hierarchical agreement structures and consolidated reporting.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Contracts drive revenue and must be tracked to profit centers for segment reporting, EBITDA analysis, and P&L by business unit. Critical for financial statement preparation and management reporting.',
    `program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Customer contracts in logistics frequently mandate specific safety programs (ISO 45001, carrier safety certifications). Links agreement to the safety program it requires for compliance tracking and au',
    `target_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_target. Business justification: Strategic customer agreements tie to corporate sustainability targets (e.g., 30% emission reduction by 2030) for compliance tracking, ESG disclosure, and SLA performance measurement against science-ba',
    `template_id` BIGINT COMMENT 'Foreign key linking to document.document_template. Business justification: Contracts often mandate specific document formats/templates (custom BOL layouts, branded commercial invoices, customer-specific packing list formats). Business need: template selection based on contra',
    `agreement_name` STRING COMMENT 'Human-readable descriptive name or title of the agreement. Used for display in user interfaces, reports, and communications.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the agreement, used in communications and documentation. Typically alphanumeric code assigned at contract creation.. Valid values are `^[A-Z0-9]{8,20}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the agreement. Controls whether the agreement is enforceable and governs operational behavior in pricing, billing, and service execution systems. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|terminated|expired|renewed — 7 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the agreement based on the nature of the commercial relationship. Determines applicable business rules, approval workflows, and compliance requirements.. Valid values are `customer_service_contract|carrier_agreement|3pl_partnership|4pl_partnership|vendor_contract|nvocc_agreement`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or role who approved the agreement. Used for accountability, audit trails, and compliance verification.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the agreement was formally approved by authorized signatories or approval workflow. Marks the transition from draft to enforceable status.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews upon expiry unless terminated. True triggers automated renewal workflows and notifications.',
    `contract_tier` STRING COMMENT 'Classification tier indicating the strategic importance, service level, or pricing category of the agreement. Influences service level agreement (SLA) thresholds, priority handling, and discount structures.. Valid values are `platinum|gold|silver|bronze|standard`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agreement record was first created in the system. Used for audit trails, data lineage, and lifecycle analysis.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit exposure allowed for the counterparty under this agreement. Used for credit risk management, order acceptance decisions, and accounts receivable (AR) monitoring.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all financial transactions under this agreement. Determines billing currency, rate conversion requirements, and financial reporting classification.. Valid values are `^[A-Z]{3}$`',
    `document_reference` STRING COMMENT 'Reference identifier or storage location for the signed agreement document. Links to document management system (DMS) or enterprise content management (ECM) repository.',
    `effective_date` DATE COMMENT 'Date when the agreement becomes legally binding and operational. Used to determine rate applicability, service level agreement (SLA) enforcement start, and billing commencement.',
    `expiry_date` DATE COMMENT 'Date when the agreement terminates unless renewed. Nullable for open-ended agreements. Triggers renewal workflows and rate renegotiation processes.',
    `governing_jurisdiction` STRING COMMENT 'Three-letter ISO country code representing the legal jurisdiction under which the agreement is governed. Determines applicable laws, dispute resolution mechanisms, and regulatory compliance requirements.. Valid values are `^[A-Z]{3}$`',
    `incentive_clause_description` STRING COMMENT 'Textual description of incentive terms applicable when service level agreement (SLA) targets are exceeded or volume commitments are surpassed. Defines rewards, rebates, or preferential terms.',
    `incoterm` STRING COMMENT 'Standardized trade term defining the responsibilities, costs, and risks between buyer and seller in international shipments. Governs freight responsibility, insurance obligations, and customs clearance duties. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `insurance_required_flag` BOOLEAN COMMENT 'Indicates whether cargo insurance is mandatory under the agreement terms. Influences shipment processing, documentation requirements, and claims handling procedures.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the agreement record was last modified. Supports change tracking, audit compliance, and data quality monitoring.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special terms, or operational notes related to the agreement. Supports business context and knowledge retention.',
    `notice_period_days` STRING COMMENT 'Number of days advance notice required for termination or non-renewal of the agreement. Used to trigger alerts and workflow actions for contract management.',
    `payment_term_days` STRING COMMENT 'Number of days allowed for payment after invoice date as per agreement terms. Used for accounts receivable (AR) and accounts payable (AP) management, cash flow forecasting, and dunning processes.',
    `penalty_clause_description` STRING COMMENT 'Textual description of penalty terms applicable when service level agreement (SLA) thresholds are not met or volume commitments are breached. Defines financial or operational consequences.',
    `renewal_count` STRING COMMENT 'Number of times the agreement has been renewed. Indicates relationship longevity and stability, used for customer lifetime value (LTV) analysis and retention metrics.',
    `signatory_party_counterparty` STRING COMMENT 'Name of the counterparty signatory representing the customer, carrier, vendor, or partner organization in the agreement.',
    `signatory_party_primary` STRING COMMENT 'Name of the primary signatory party representing Transport Shipping in the agreement. Typically an authorized officer or legal representative.',
    `sla_otd_target_percent` DECIMAL(18,2) COMMENT 'Target percentage for on-time delivery (OTD) key performance indicator (KPI) as committed in the agreement. Measured against actual delivery performance for compliance and penalty/incentive calculations.',
    `sla_otif_target_percent` DECIMAL(18,2) COMMENT 'Target percentage for on-time in-full (OTIF) key performance indicator (KPI) as committed in the agreement. Combines delivery timeliness and order completeness for comprehensive service measurement.',
    `termination_date` DATE COMMENT 'Actual date when the agreement was terminated, if applicable. Nullable for active agreements. Used for historical analysis, compliance audits, and relationship lifecycle tracking.',
    `termination_reason` STRING COMMENT 'Reason code for agreement termination. Used for root cause analysis, relationship management insights, and compliance reporting. [ENUM-REF-CANDIDATE: expiry|mutual_consent|breach|non_renewal|business_closure|regulatory|other — 7 candidates stripped; promote to reference product]',
    `volume_commitment_teu` DECIMAL(18,2) COMMENT 'Committed volume in twenty-foot equivalent units (TEU) for ocean freight agreements. Used for capacity planning, rate negotiation, and performance tracking against commitments.',
    `volume_commitment_weight_kg` DECIMAL(18,2) COMMENT 'Committed volume in kilograms for air freight or road freight agreements. Basis for rate calculations, capacity allocation, and incentive/penalty clause evaluation.',
    CONSTRAINT pk_agreement PRIMARY KEY(`agreement_id`)
) COMMENT 'Master record for all commercial contracts and agreements managed by Transport Shipping, including customer service contracts, carrier agreements, 3PL/4PL partnership agreements, and vendor contracts. Captures contract type, status, effective and expiry dates, governing Incoterms (DDP, DAP, FOB, CIF, EXW), jurisdiction, signatory parties, contract owner, auto-renewal flags, notice period, and contract tier classification. Serves as the SSOT for all contractual relationships across the enterprise.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`agreement_version` (
    `agreement_version_id` BIGINT COMMENT 'Unique identifier for each version of a contract agreement. Primary key. Role: MASTER_AGREEMENT version tracking entity.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract agreement that this version belongs to. Links to the master agreement entity.',
    `superseded_by_version_agreement_version_id` BIGINT COMMENT 'Reference to the newer agreement version that replaced this version. Nullable for the current active version. Enables version chain navigation.',
    `amendment_type` STRING COMMENT 'Classification of the version change: initial (first version), renewal (contract renewal), addendum (supplemental terms), amendment (modification), termination (contract end), extension (time extension).. Valid values are `initial|renewal|addendum|amendment|termination|extension`',
    `approval_action` STRING COMMENT 'Action taken by the approver at the current workflow stage: approved (authorized to proceed), rejected (denied), returned (sent back for revision), pending (awaiting decision).. Valid values are `approved|rejected|returned|pending`',
    `approval_comments` STRING COMMENT 'Free-text comments or notes provided by the approver during the review process. Captures feedback, conditions, or reasons for approval/rejection.',
    `approval_date` DATE COMMENT 'Date when the current workflow stage approval action was completed. Nullable if approval is still pending.',
    `assigned_approver` STRING COMMENT 'Name or identifier of the individual or role currently responsible for reviewing and approving this version at the current workflow stage. May be a user ID, email, or role name.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier to the complete audit trail or change log for this version. Links to detailed history of all modifications, approvals, and workflow transitions.',
    `authorized_signatory` STRING COMMENT 'Name or identifier of the individual with legal authority to sign and execute this version on behalf of the organization. Must have appropriate delegation of authority.',
    `change_reason` STRING COMMENT 'Business justification or trigger for creating this version: regulatory compliance update, rate adjustment, scope expansion, customer request, General Rate Increase (GRI), Bunker Adjustment Factor (BAF) change, or other commercial reasons.',
    `change_summary` STRING COMMENT 'High-level description of what changed in this version compared to the previous version. Captures key modifications, additions, or deletions to terms, rates, Service Level Agreement (SLA) thresholds, or scope.',
    `compliance_review_date` DATE COMMENT 'Date when compliance review was completed for this version. Nullable if review is not required or still pending.',
    `compliance_review_required` BOOLEAN COMMENT 'Indicates whether this version requires formal compliance review due to regulatory impact, cross-border terms, Customs-Trade Partnership Against Terrorism (C-TPAT) requirements, or Authorized Economic Operator (AEO) obligations.',
    `compliance_reviewer` STRING COMMENT 'Name or identifier of the compliance officer or team who reviewed this version for regulatory adherence.',
    `counterparty_execution_date` DATE COMMENT 'Date when the counterparty signed this version. May differ from internal execution date in sequential signing workflows.',
    `counterparty_signatory` STRING COMMENT 'Name or identifier of the authorized representative from the counterparty (customer, carrier, Third-Party Logistics (3PL), vendor) who signed this version.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this version record was first created in the system. Part of audit trail for compliance and change tracking.',
    `document_format` STRING COMMENT 'File format of the contract document: PDF, Word (DOCX), XML, Electronic Data Interchange (EDI) message, scanned image, or other format.. Valid values are `pdf|docx|xml|edi|scanned|other`',
    `document_reference` STRING COMMENT 'Reference identifier or URI to the physical or digital contract document for this version. May link to document management system, Electronic Data Interchange (EDI) archive, or file storage location.',
    `effective_date` DATE COMMENT 'Date when this version of the agreement becomes legally binding and enforceable. Aligns with Incoterms and contract law requirements.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this version has been escalated to higher authority due to delays, disputes, or special circumstances requiring executive intervention.',
    `escalation_reason` STRING COMMENT 'Explanation of why this version was escalated: approval timeout, conflicting terms, high-value contract, regulatory concern, or other exceptional circumstances.',
    `execution_date` DATE COMMENT 'Date when this version was fully executed (signed by all parties). Marks the transition from approved to legally binding status.',
    `expiration_date` DATE COMMENT 'Date when this version of the agreement ceases to be valid. Nullable for open-ended agreements or those superseded before expiration.',
    `modified_by` STRING COMMENT 'User identifier or name of the individual who last modified this version record. Part of audit trail for SOX compliance and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this version record was last modified in the system. Part of audit trail for compliance and change tracking.',
    `notification_date` DATE COMMENT 'Date when notification of this version change was sent to stakeholders. Nullable if notification is not required or not yet sent.',
    `notification_sent` BOOLEAN COMMENT 'Indicates whether notification of this version change was sent to relevant stakeholders (customer, carrier, internal teams) as required by contract terms or Service Level Agreement (SLA).',
    `sox_authorization_control` STRING COMMENT 'SOX-compliant authorization control identifier or audit trail reference ensuring segregation of duties and proper financial controls for contract approvals. Required for contracts with financial impact.',
    `superseded_date` DATE COMMENT 'Date when this version was superseded by a newer version and ceased to be the active version. Nullable for current active version.',
    `version_hash` STRING COMMENT 'Cryptographic hash or checksum of the contract document for this version. Ensures document integrity and detects unauthorized modifications.',
    `version_number` STRING COMMENT 'Sequential version identifier for the agreement (e.g., 1.0, 1.1, 2.0, 2.1). Tracks the progression of amendments and revisions.',
    `version_status` STRING COMMENT 'Current lifecycle status of this agreement version: draft (being prepared), pending_review (under review), approved (authorized but not signed), executed (signed and active), superseded (replaced by newer version), cancelled (voided).. Valid values are `draft|pending_review|approved|executed|superseded|cancelled`',
    `workflow_stage` STRING COMMENT 'Current stage in the approval workflow: draft (initial preparation), legal_review (legal department review), commercial_review (business unit review), finance_review (financial approval), executive_approval (C-level sign-off), executed (fully signed and active).. Valid values are `draft|legal_review|commercial_review|finance_review|executive_approval|executed`',
    `created_by` STRING COMMENT 'User identifier or name of the individual who created this version record. Part of audit trail for SOX compliance and change tracking.',
    CONSTRAINT pk_agreement_version PRIMARY KEY(`agreement_version_id`)
) COMMENT 'Tracks the full version history, amendment lifecycle, and approval workflow of each contract agreement. Captures version number, amendment type (initial, renewal, addendum, termination), effective date of each version, change summary, document reference, and the complete approval workflow: workflow stage (draft, legal review, commercial review, finance review, executive approval, executed), assigned approver(s), approval action (approved, rejected, returned), action date, comments, escalation flag, and SOX-compliant authorization controls. Enables audit trail and compliance tracking for contract changes over time.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` (
    `contract_sla_commitment_id` BIGINT COMMENT 'Unique identifier for the SLA commitment record within a contract. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or agreement to which this SLA commitment belongs.',
    `compliance_check_id` BIGINT COMMENT 'Foreign key linking to document.document_compliance_check. Business justification: SLA commitments require document compliance verification (on-time document delivery, document completeness, accuracy checks). Business process: SLA performance measurement includes document timeliness',
    `emissions_factor_id` BIGINT COMMENT 'Foreign key linking to sustainability.emissions_factor. Business justification: Green SLA commitments specify carbon intensity thresholds (gCO2e/tonne-km) requiring designated emission factors for consistent measurement methodology across contract term. Essential for SLA complian',
    `service_corridor_id` BIGINT COMMENT 'Foreign key linking to route.service_corridor. Business justification: SLA commitments often apply to entire service corridors (multi-leg routes) rather than individual lanes. Enables corridor-level performance tracking, capacity planning, and compliance reporting agains',
    `baseline_value` DECIMAL(18,2) COMMENT 'The historical or initial baseline performance value used as a reference point for improvement targets. Nullable if no baseline is established.',
    `compliance_tracking_flag` BOOLEAN COMMENT 'Indicates whether this SLA commitment is actively tracked for compliance and reporting (True) or is informational only (False).',
    `contract_sla_commitment_status` STRING COMMENT 'Current lifecycle status of the SLA commitment: active (in force), inactive (not currently enforced), suspended (temporarily paused), expired (past effective-to date), superseded (replaced by newer commitment), or draft (not yet finalized).. Valid values are `active|inactive|suspended|expired|superseded|draft`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this SLA commitment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for penalty and incentive amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'The customer segment or industry vertical to which this SLA applies (e.g., enterprise, mid-market, small business, e-commerce, retail, wholesale, government, healthcare, manufacturing). Nullable if SLA applies to all segments. [ENUM-REF-CANDIDATE: enterprise|mid_market|small_business|ecommerce|retail|wholesale|government|healthcare|manufacturing — 9 candidates stripped; promote to reference product]',
    `effective_from_date` DATE COMMENT 'The date from which this SLA commitment becomes active and enforceable.',
    `effective_to_date` DATE COMMENT 'The date on which this SLA commitment expires or is superseded. Nullable for open-ended commitments.',
    `escalation_procedure` STRING COMMENT 'Description of the escalation process or contact procedure when SLA thresholds are breached. Free-text field.',
    `exclusion_conditions` STRING COMMENT 'Conditions or circumstances under which this SLA commitment does not apply (e.g., force majeure, weather delays, customs holds, peak season surcharges, hazardous materials). Free-text field.',
    `geographic_scope` STRING COMMENT 'The geographic region, country, or trade lane to which this SLA applies (e.g., USA Domestic, Trans-Pacific, EU Intra-Regional, Global). Use ISO 3166-1 alpha-3 country codes where applicable.',
    `incentive_amount` DECIMAL(18,2) COMMENT 'The financial incentive or bonus amount awarded per occurrence or period when the SLA target is exceeded. Nullable if no incentive applies.',
    `incentive_clause_flag` BOOLEAN COMMENT 'Indicates whether an incentive or bonus clause is associated with exceeding this SLA commitment (True) or not (False).',
    `kpi_metric` STRING COMMENT 'The specific KPI metric being measured: on-time delivery percentage, on-time in-full percentage, transit time in hours, pickup response time in minutes, claims resolution time in days, customer service response time in hours, delivery accuracy percentage, or customs clearance time in hours. [ENUM-REF-CANDIDATE: on_time_delivery_pct|on_time_in_full_pct|transit_time_hours|pickup_response_minutes|claims_resolution_days|service_response_hours|delivery_accuracy_pct|customs_clearance_hours — 8 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this SLA commitment record was last updated or modified.',
    `measurement_frequency` STRING COMMENT 'How often the SLA performance is measured and reported: daily, weekly, monthly, quarterly, annually, per shipment, or continuous real-time monitoring. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|annually|per_shipment|continuous — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or clarifications regarding this SLA commitment. Nullable.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The financial penalty amount or percentage applied per occurrence or period when the SLA is not met. Nullable if no penalty applies.',
    `penalty_clause_flag` BOOLEAN COMMENT 'Indicates whether a penalty clause is associated with failure to meet this SLA commitment (True) or not (False).',
    `reporting_period` STRING COMMENT 'The time window over which SLA performance is aggregated for reporting: calendar month, rolling 30 days, calendar quarter, rolling 90 days, calendar year, contract year, weekly, or daily. [ENUM-REF-CANDIDATE: calendar_month|rolling_30_days|calendar_quarter|rolling_90_days|calendar_year|contract_year|weekly|daily — 8 candidates stripped; promote to reference product]',
    `service_level` STRING COMMENT 'Specific service tier or product offering within the service mode (e.g., Next Day Air, Standard Ground, 2-Day Express, Economy Ocean).',
    `service_mode` STRING COMMENT 'The logistics service mode to which this SLA applies: express parcel, freight (air/ocean/road/rail), last-mile delivery, LTL (Less Than Truckload), FTL (Full Truckload), FCL (Full Container Load), or LCL (Less Than Container Load). [ENUM-REF-CANDIDATE: express|freight|last_mile|air|ocean|road|rail|parcel|ltl|ftl|fcl|lcl — 12 candidates stripped; promote to reference product]',
    `sla_code` STRING COMMENT 'Business identifier or code for the SLA commitment, used for external reference and reporting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `sla_name` STRING COMMENT 'Human-readable name or title of the SLA commitment (e.g., Express Delivery OTD Target, Freight Transit Time Guarantee).',
    `sla_type` STRING COMMENT 'Category of SLA commitment: OTD (On-Time Delivery), OTIF (On-Time In-Full), transit time guarantee, pickup window, claims resolution time, customer service response time, delivery window, customs clearance time, or proof of delivery turnaround. [ENUM-REF-CANDIDATE: otd|otif|transit_time|pickup_window|claims_resolution|customer_service_response|delivery_window|customs_clearance|proof_of_delivery — 9 candidates stripped; promote to reference product]',
    `target_value` DECIMAL(18,2) COMMENT 'The committed target value for the KPI metric (e.g., 95.0 for 95% OTD, 48.0 for 48-hour transit time).',
    `threshold_value` DECIMAL(18,2) COMMENT 'The minimum acceptable threshold value below which penalties or escalations may apply. Nullable if no threshold is defined.',
    `unit_of_measure` STRING COMMENT 'The unit in which the target and threshold values are expressed: percentage, hours, minutes, days, count, or ratio.. Valid values are `percentage|hours|minutes|days|count|ratio`',
    `volume_commitment_max` DECIMAL(18,2) COMMENT 'The maximum shipment volume (in units, weight, or TEU) for which this SLA applies. Nullable if no maximum volume is defined.',
    `volume_commitment_min` DECIMAL(18,2) COMMENT 'The minimum shipment volume (in units, weight, or TEU) required for this SLA to apply. Nullable if no minimum volume is required.',
    `volume_unit` STRING COMMENT 'The unit of measure for volume commitments: shipments, packages, pallets, TEU (Twenty-foot Equivalent Unit), kilograms, pounds, CBM (Cubic Meter), or tons. [ENUM-REF-CANDIDATE: shipments|packages|pallets|teu|kg|lbs|cbm|tons — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_contract_sla_commitment PRIMARY KEY(`contract_sla_commitment_id`)
) COMMENT 'Defines the SLA thresholds and KPI commitments embedded within a contract, including OTD (On-Time Delivery) targets, OTIF (On-Time In-Full) percentages, transit time guarantees, pickup window SLAs, claims resolution SLAs, and customer service response SLAs. Captures measurement frequency, reporting period, baseline values, target values, and the service mode (express, freight, last-mile) to which each SLA applies.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`sla_performance` (
    `sla_performance_id` BIGINT COMMENT 'Unique identifier for the SLA performance measurement record.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or agreement under which this SLA performance is measured.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier or service provider whose performance is being measured. Applicable for carrier agreements and 3PL/4PL partnerships.',
    `contract_sla_commitment_id` BIGINT COMMENT 'Reference to the specific SLA clause or commitment being measured (e.g., OTD threshold, OTIF target, transit time commitment).',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account for whom this SLA performance is being measured. Applicable for customer service contracts.',
    `hse_incident_id` BIGINT COMMENT 'Foreign key linking to safety.hse_incident. Business justification: SLA breaches (OTD/OTIF failures) are often caused by safety incidents (accidents, driver injuries, vehicle impoundment). Links SLA performance record to causal incident for root cause analysis.',
    `lane_id` BIGINT COMMENT 'Reference to the specific service lane or route for which this SLA performance is measured (e.g., USA-EUR air express, Asia-USA ocean FCL).',
    `shipment_carbon_footprint_id` BIGINT COMMENT 'Foreign key linking to sustainability.shipment_carbon_footprint. Business justification: Green SLA performance measurement requires linking measurement periods to aggregated shipment carbon footprint data for compliance verification, penalty/incentive calculation, and customer carbon repo',
    `actual_value` DECIMAL(18,2) COMMENT 'The actual value achieved during this measurement period (e.g., 92.5 for 92.5% OTD achieved, 9500 for 9,500 TEU delivered).',
    `approved_by` STRING COMMENT 'The name or identifier of the person or role who approved this SLA performance measurement record.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this SLA performance measurement was approved.',
    `attainment_percentage` DECIMAL(18,2) COMMENT 'The percentage of target achieved, calculated as (actual_value / target_value) * 100. Values above 100 indicate over-achievement.',
    `breach_flag` BOOLEAN COMMENT 'Indicates whether the SLA was breached (True) or met (False) during this measurement period. True if actual performance fell below the committed threshold.',
    `breach_severity` STRING COMMENT 'The severity level of the SLA breach, if any. none = no breach, minor = slight miss, moderate = noticeable shortfall, major = significant breach, critical = severe breach triggering penalties.. Valid values are `none|minor|moderate|major|critical`',
    `compliant_shipment_count` STRING COMMENT 'The number of shipments that met the SLA criteria during this measurement period. Used as the numerator for percentage-based SLA calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this SLA performance record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for penalty and incentive amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this SLA performance measurement is under dispute (True) or not (False). Disputes may arise from disagreements on measurement methodology or data accuracy.',
    `dispute_reason` STRING COMMENT 'Free-text description of the reason for disputing this SLA performance measurement, if applicable.',
    `incentive_amount` DECIMAL(18,2) COMMENT 'The calculated financial incentive or bonus amount earned for exceeding the SLA target, if applicable. Expressed in the contract currency.',
    `incentive_applicable_flag` BOOLEAN COMMENT 'Indicates whether a contractual incentive or bonus is applicable for exceeding the SLA target (True) or not (False).',
    `incoterm` STRING COMMENT 'The International Commercial Terms (Incoterms) applicable to this SLA measurement, defining the division of responsibilities between buyer and seller (e.g., DDP, DAP, FOB, CIF, EXW). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this SLA performance record was last updated or modified.',
    `measurement_category` STRING COMMENT 'High-level category of the measurement: service_level (OTD, OTIF, transit time), volume_attainment (TEU, kg, CBM, shipment count), quality (damage rate, accuracy), compliance (regulatory adherence).. Valid values are `service_level|volume_attainment|quality|compliance`',
    `measurement_methodology` STRING COMMENT 'Description of the methodology or calculation logic used to measure this SLA performance (e.g., OTD calculated as shipments delivered within committed window / total shipments, OTIF calculated as shipments delivered on-time and in-full / total shipments).',
    `measurement_period_end_date` DATE COMMENT 'The end date of the measurement period for this SLA performance record.',
    `measurement_period_start_date` DATE COMMENT 'The start date of the measurement period for this SLA performance record (e.g., beginning of month, quarter, or custom period).',
    `measurement_source_system` STRING COMMENT 'The system or platform used to capture and calculate this SLA performance measurement (e.g., SAP TM, Oracle TMS, FourKites, internal BI platform).',
    `measurement_status` STRING COMMENT 'The current status of this SLA performance measurement record in its lifecycle (e.g., draft, finalized, under_review, disputed, approved, archived).. Valid values are `draft|finalized|under_review|disputed|approved|archived`',
    `measurement_type` STRING COMMENT 'The type of SLA or commitment being measured. OTD = On-Time Delivery, OTIF = On-Time In-Full, transit_time = delivery speed commitment, volume_commitment = shipment count target, weight_commitment = weight volume target, teu_commitment = TEU volume target.. Valid values are `OTD|OTIF|transit_time|volume_commitment|weight_commitment|teu_commitment`',
    `non_compliant_shipment_count` STRING COMMENT 'The number of shipments that failed to meet the SLA criteria during this measurement period.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to this SLA performance measurement, including context, exceptions, or clarifications.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The calculated financial penalty amount due to the SLA breach, if applicable. Expressed in the contract currency.',
    `penalty_applicable_flag` BOOLEAN COMMENT 'Indicates whether a contractual penalty is applicable for this SLA breach (True) or not (False). Penalties are typically triggered when performance falls below a defined threshold.',
    `service_type` STRING COMMENT 'The type of logistics service for which this SLA performance is measured (e.g., express_parcel, air_freight, ocean_freight, road_freight, rail_freight, last_mile, warehousing). [ENUM-REF-CANDIDATE: express_parcel|air_freight|ocean_freight|road_freight|rail_freight|last_mile|warehousing — 7 candidates stripped; promote to reference product]',
    `shipment_count_in_scope` STRING COMMENT 'The total number of shipments included in this SLA performance measurement period. Used as the denominator for percentage-based SLA calculations.',
    `target_value` DECIMAL(18,2) COMMENT 'The committed or target value for this measurement period (e.g., 95.0 for 95% OTD, 10000 for 10,000 TEU commitment).',
    `unit_of_measure` STRING COMMENT 'The unit in which the target and actual values are expressed. percentage for OTD/OTIF, TEU for container volume, kg for weight, CBM for cubic meters, shipment_count for number of shipments, hours/days for transit time. [ENUM-REF-CANDIDATE: percentage|TEU|kg|CBM|shipment_count|hours|days — 7 candidates stripped; promote to reference product]',
    `variance` DECIMAL(18,2) COMMENT 'The difference between actual and target values (actual_value - target_value). Negative values indicate shortfall; positive values indicate over-achievement.',
    CONSTRAINT pk_sla_performance PRIMARY KEY(`sla_performance_id`)
) COMMENT 'Transactional record of actual contract performance measured against committed thresholds for each measurement period, covering both SLA performance (OTD, OTIF, transit time) and volume attainment (TEU, kg, CBM, shipment count). Captures measurement type (SLA or volume), period start and end dates, actual value achieved, committed/target value, variance, attainment percentage, breach or shortfall flag, breach severity, number of shipments in scope, and the data source system used for measurement. Feeds penalty and incentive calculations and contract compliance reporting.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` (
    `rate_schedule_id` BIGINT COMMENT 'Unique identifier for the rate schedule. Primary key for this entity.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or agreement under which this rate schedule is defined. Links to the master agreement entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Rate schedule approval workflows require employee tracking for SOX compliance, audit trails, and authorization verification in freight pricing operations. The approved_by string denormalizes employee ',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Rate schedules are carrier-specific pricing agreements in transport shipping. Operations and pricing teams require direct carrier attribution for rate shopping, carrier performance analysis, contract ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Rate schedules tie to cost centers for transfer pricing, cost-plus pricing models, and internal cost recovery analysis. Enables cost accounting and pricing strategy validation in logistics operations.',
    `emissions_factor_id` BIGINT COMMENT 'Foreign key linking to sustainability.emissions_factor. Business justification: Green logistics rate schedules structure pricing around emission intensity tiers (e.g., premium for <50 gCO2e/tonne-km service), requiring direct linkage to applicable emission factors for rate calcul',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Rate schedules define contracted pricing for specific origin-destination lanes. Essential for freight costing, quote generation, and invoice validation. Logistics experts expect rate-to-lane linkage f',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Customer rate schedules are often underpinned by procurement contracts with carriers. Essential for margin analysis, cost-to-serve calculations, and ensuring customer pricing aligns with negotiated ca',
    `approval_status` STRING COMMENT 'Approval workflow status for the rate schedule. Indicates whether the schedule is pending review, approved for use, or rejected.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this rate schedule was approved, recorded in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `base_rate` DECIMAL(18,2) COMMENT 'The fundamental rate amount per unit as defined by the rate basis. This is the core charge before any surcharges, discounts, or adjustments.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this rate schedule record was first created in the system, recorded in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the rate is denominated (e.g., USD, EUR, GBP, CNY).. Valid values are `^[A-Z]{3}$`',
    `destination_zone` STRING COMMENT 'Geographic zone or region code for the destination, used in zone-based pricing structures. May represent postal zones, service areas, or custom-defined geographic segments.',
    `distance_break_max` DECIMAL(18,2) COMMENT 'Maximum distance threshold for this rate tier in distance-based pricing structures. Defines the upper bound of the distance bracket.',
    `distance_break_min` DECIMAL(18,2) COMMENT 'Minimum distance threshold for this rate tier in distance-based pricing structures. Rates may vary based on distance brackets.',
    `distance_uom` STRING COMMENT 'Unit of measure for distance-based rate calculations. Common units include kilometers (km), miles (mi), or nautical miles (nmi).. Valid values are `km|mi|nmi`',
    `effective_end_date` DATE COMMENT 'Date on which this rate schedule expires or is no longer valid. Nullable for open-ended rate schedules subject to notice-based termination.',
    `effective_start_date` DATE COMMENT 'Date from which this rate schedule becomes valid and applicable for shipment pricing. Aligns with contract effective dates and rate validity periods.',
    `fuel_surcharge_applicable` BOOLEAN COMMENT 'Indicates whether a fuel surcharge (Bunker Adjustment Factor for ocean, fuel surcharge for air/road) is applicable to this rate schedule.',
    `fuel_surcharge_rate` DECIMAL(18,2) COMMENT 'Fuel surcharge rate as a percentage or fixed amount applied to the base rate. Commonly known as Bunker Adjustment Factor (BAF) for ocean freight.',
    `incoterm` STRING COMMENT 'International Commercial Terms (Incoterms) defining the responsibilities, costs, and risks between buyer and seller. Common terms include EXW (Ex Works), FOB (Free on Board), CIF (Cost Insurance and Freight), DAP (Delivered at Place), DDP (Delivered Duty Paid). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `maximum_charge` DECIMAL(18,2) COMMENT 'Maximum charge cap for this rate schedule. If the calculated charge exceeds this amount, the maximum charge applies instead.',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Minimum charge threshold for this rate schedule. If the calculated charge falls below this amount, the minimum charge applies instead.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this rate schedule record was last modified, recorded in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or clarifications related to this rate schedule. May include operational instructions or exceptions.',
    `origin_zone` STRING COMMENT 'Geographic zone or region code for the origin, used in zone-based pricing structures. May represent postal zones, service areas, or custom-defined geographic segments.',
    `peak_season_surcharge_applicable` BOOLEAN COMMENT 'Indicates whether a peak season surcharge is applicable during high-demand periods (e.g., holiday seasons, Chinese New Year).',
    `peak_season_surcharge_rate` DECIMAL(18,2) COMMENT 'Peak season surcharge rate as a percentage or fixed amount applied during designated peak periods.',
    `rate_basis` STRING COMMENT 'Unit of measure on which the rate is calculated. Common bases include per kilogram, per pound, per Twenty-foot Equivalent Unit (TEU), per Forty-foot Equivalent Unit (FEU), per Cubic Meter (CBM), per shipment, per pallet, per mile, or per kilometer. [ENUM-REF-CANDIDATE: per_kg|per_lb|per_teu|per_feu|per_cbm|per_shipment|per_pallet|per_mile|per_km — 9 candidates stripped; promote to reference product]',
    `rate_validity_period_days` STRING COMMENT 'Number of days for which this rate schedule remains valid from the effective start date. Used for time-bound promotional rates or short-term agreements.',
    `schedule_name` STRING COMMENT 'Descriptive name of the rate schedule, providing business context such as lane, service type, or customer segment.',
    `schedule_number` STRING COMMENT 'Business identifier for the rate schedule, typically a human-readable code or number used in contract documentation and operational references.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the rate schedule. Indicates whether the schedule is in draft, active and applicable, temporarily suspended, expired past its end date, or terminated early.. Valid values are `draft|active|suspended|expired|terminated`',
    `schedule_type` STRING COMMENT 'Classification of the rate schedule structure, indicating the basis for rate calculation such as lane-level, zone-level, weight-based, volume-based, distance-based, or flat rate.. Valid values are `lane_based|zone_based|weight_based|volume_based|distance_based|flat_rate`',
    `security_surcharge_applicable` BOOLEAN COMMENT 'Indicates whether a security surcharge is applicable to this rate schedule, often required for air freight and high-security shipments.',
    `security_surcharge_rate` DECIMAL(18,2) COMMENT 'Security surcharge rate as a percentage or fixed amount applied to the base rate.',
    `service_type` STRING COMMENT 'Type of logistics service covered by this rate schedule. Includes express parcel, standard delivery, Full Truckload (FTL), Less Than Truckload (LTL), Full Container Load (FCL), Less Than Container Load (LCL), and mode-specific services (air, ocean, road, rail). [ENUM-REF-CANDIDATE: express|standard|economy|FTL|LTL|FCL|LCL|air|ocean|road|rail — 11 candidates stripped; promote to reference product]',
    `transport_mode` STRING COMMENT 'Primary mode of transportation for which this rate schedule applies. Includes air freight, ocean freight, road transport, rail transport, multimodal (multiple modes under single contract), and intermodal (containerized across modes).. Valid values are `air|ocean|road|rail|multimodal|intermodal`',
    `volume_break_max` DECIMAL(18,2) COMMENT 'Maximum volume threshold for this rate tier in volume-based pricing structures. Defines the upper bound of the volume bracket.',
    `volume_break_min` DECIMAL(18,2) COMMENT 'Minimum volume threshold for this rate tier in volume-based pricing structures. Rates may vary based on volume brackets.',
    `volume_uom` STRING COMMENT 'Unit of measure for volume-based rate calculations. Common units include Cubic Meters (CBM), cubic feet (CFT), m3, or ft3.. Valid values are `cbm|cft|m3|ft3`',
    `weight_break_max` DECIMAL(18,2) COMMENT 'Maximum weight threshold for this rate tier in weight-based pricing structures. Defines the upper bound of the weight bracket.',
    `weight_break_min` DECIMAL(18,2) COMMENT 'Minimum weight threshold for this rate tier in weight-based pricing structures. Rates may vary based on weight brackets.',
    `weight_uom` STRING COMMENT 'Unit of measure for weight-based rate calculations. Common units include kilograms (kg), pounds (lb), short tons, or metric tonnes.. Valid values are `kg|lb|ton|tonne`',
    CONSTRAINT pk_rate_schedule PRIMARY KEY(`rate_schedule_id`)
) COMMENT 'Contractually agreed rate schedules and tariff structures embedded within a specific agreement, distinct from the global pricing catalog. Captures lane-level or zone-level rates, mode of transport (air, ocean, road, rail), service type (FTL, LTL, FCL, LCL, express), currency, rate validity start and end dates, rate basis (per kg, per TEU, per CBM, per shipment), and minimum charge thresholds. Links to the parent agreement and pricing domain rate cards.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` (
    `contract_surcharge_schedule_id` BIGINT COMMENT 'Unique identifier for the contract surcharge schedule record.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or agreement to which this surcharge schedule applies.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Surcharge approval tracking is required for financial controls, audit compliance, and authorization verification in logistics pricing. The approved_by string denormalizes employee identity.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Surcharge schedules (fuel, security, peak season) are carrier-imposed charges. Finance and pricing teams require direct carrier linkage for surcharge reconciliation, invoice validation, dispute resolu',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Surcharge schedules (fuel, security, peak season) reference procurement contracts with carriers that define pass-through terms. Critical for surcharge reconciliation, margin protection, and regulatory',
    `supersedes_schedule_contract_surcharge_schedule_id` BIGINT COMMENT 'Reference to the previous surcharge schedule that this version replaces or supersedes. Null if this is the first version.',
    `adjustment_frequency` STRING COMMENT 'Frequency at which the surcharge rate is reviewed and adjusted. Weekly = every week, biweekly = every two weeks, monthly = every month, quarterly = every quarter, annually = once per year, event_driven = adjusted based on specific triggers or market events.. Valid values are `weekly|biweekly|monthly|quarterly|annually|event_driven`',
    `applicability_condition` STRING COMMENT 'Business rules or conditions under which this surcharge applies (e.g., specific service types, lanes, origin/destination pairs, shipment characteristics, weight thresholds, or seasonal periods).',
    `approval_status` STRING COMMENT 'Current approval and lifecycle status of the surcharge schedule. Draft = under development, pending_approval = awaiting management approval, approved = approved but not yet active, active = currently in effect, suspended = temporarily inactive, expired = past effective date range.. Valid values are `draft|pending_approval|approved|active|suspended|expired`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this surcharge schedule was approved.',
    `calculation_method` STRING COMMENT 'Method used to calculate the surcharge amount. Percentage = percentage of base rate, flat_rate = fixed amount per shipment, per_unit = amount per weight/volume unit, tiered = rate varies by volume brackets, index_based = linked to external index (e.g., fuel price index), formula = custom calculation formula.. Valid values are `percentage|flat_rate|per_unit|tiered|index_based|formula`',
    `compounding_allowed` BOOLEAN COMMENT 'Indicates whether this surcharge can be compounded with other surcharges (true) or must be applied independently (false).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this surcharge schedule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the surcharge rate (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `destination_region` STRING COMMENT 'Geographic region or country code to which shipments must be destined for this surcharge to apply. Uses ISO 3166-1 alpha-3 country codes or regional identifiers.',
    `effective_from_date` DATE COMMENT 'Date from which this surcharge schedule becomes active and applicable to shipments.',
    `effective_to_date` DATE COMMENT 'Date until which this surcharge schedule remains active. Null indicates an open-ended schedule.',
    `exemption_criteria` STRING COMMENT 'Conditions under which shipments are exempt from this surcharge (e.g., specific customer segments, promotional periods, volume commitments, or contractual waivers).',
    `index_reference` STRING COMMENT 'External index or benchmark used for index-based surcharge calculations (e.g., Platts Bunker Index, DOE Fuel Price Index, market commodity indices). Specifies the source and identifier of the index.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this surcharge schedule record was last updated or modified.',
    `maximum_charge` DECIMAL(18,2) COMMENT 'Cap value for the surcharge. If the calculated surcharge exceeds this amount, the maximum charge applies instead.',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Floor value for the surcharge. If the calculated surcharge is below this amount, the minimum charge applies instead.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this surcharge schedule, including business context, negotiation details, or operational guidance.',
    `notification_lead_days` STRING COMMENT 'Number of days in advance that customers must be notified before this surcharge takes effect or is adjusted. Null if notification_required is false.',
    `notification_required` BOOLEAN COMMENT 'Indicates whether customers must be notified in advance when this surcharge is applied or adjusted (true) or if notification is not required (false).',
    `origin_region` STRING COMMENT 'Geographic region or country code from which shipments must originate for this surcharge to apply. Uses ISO 3166-1 alpha-3 country codes or regional identifiers.',
    `priority_sequence` STRING COMMENT 'Order in which this surcharge should be applied when multiple surcharges are applicable to the same shipment. Lower numbers indicate higher priority.',
    `proration_method` STRING COMMENT 'Method for prorating surcharges when they apply for partial periods. None = no proration, daily = prorated by day, monthly = prorated by month, proportional = prorated based on usage or volume.. Valid values are `none|daily|monthly|proportional`',
    `regulatory_basis` STRING COMMENT 'Legal or regulatory framework that mandates or governs this surcharge (e.g., IMO regulations for BAF, government-imposed security fees, environmental levies, or customs-related charges).',
    `schedule_code` STRING COMMENT 'Business identifier or code for the surcharge schedule, used for external reference and reporting.',
    `service_type` STRING COMMENT 'Type of logistics service to which this surcharge schedule applies. Express = expedited delivery, standard = regular service, economy = cost-optimized service, freight = cargo transport, air = air freight, ocean = sea freight, road = trucking, rail = rail transport, multimodal = combined transport modes. [ENUM-REF-CANDIDATE: express|standard|economy|freight|air|ocean|road|rail|multimodal — 9 candidates stripped; promote to reference product]',
    `surcharge_rate` DECIMAL(18,2) COMMENT 'The rate or percentage value used in surcharge calculation. For percentage-based surcharges, this represents the percentage (e.g., 5.5 for 5.5%). For flat or per-unit rates, this represents the monetary amount.',
    `surcharge_type` STRING COMMENT 'Type of surcharge covered by this schedule. BAF = Bunker Adjustment Factor, GRI = General Rate Increase, THC = Terminal Handling Charge, fuel_surcharge = Fuel-related charges, peak_season_surcharge = High-demand period charges, remote_area_surcharge = Charges for remote delivery locations, dim_weight_adjustment = Dimensional weight pricing adjustments, security_surcharge = Security-related fees, congestion_surcharge = Port or terminal congestion fees. [ENUM-REF-CANDIDATE: BAF|GRI|THC|fuel_surcharge|peak_season_surcharge|remote_area_surcharge|dim_weight_adjustment|security_surcharge|congestion_surcharge — 9 candidates stripped; promote to reference product]',
    `unit_of_measure` STRING COMMENT 'Unit of measure for per-unit surcharge calculations. kg = kilogram, lb = pound, TEU = Twenty-foot Equivalent Unit, CBM = Cubic Meter, shipment = per shipment, pallet = per pallet, container = per container. [ENUM-REF-CANDIDATE: kg|lb|TEU|CBM|shipment|pallet|container — 7 candidates stripped; promote to reference product]',
    `version_number` STRING COMMENT 'Version number of this surcharge schedule, incremented with each revision or amendment to track changes over time.',
    `volume_threshold_max` DECIMAL(18,2) COMMENT 'Maximum shipment volume (in CBM or cubic feet) for this surcharge to apply. Null indicates no maximum threshold.',
    `volume_threshold_min` DECIMAL(18,2) COMMENT 'Minimum shipment volume (in CBM or cubic feet) for this surcharge to apply. Null indicates no minimum threshold.',
    `weight_threshold_max` DECIMAL(18,2) COMMENT 'Maximum shipment weight (in the unit specified by weight_threshold_unit) for this surcharge to apply. Null indicates no maximum threshold.',
    `weight_threshold_min` DECIMAL(18,2) COMMENT 'Minimum shipment weight (in the unit specified by weight_threshold_unit) for this surcharge to apply. Null indicates no minimum threshold.',
    `weight_threshold_unit` STRING COMMENT 'Unit of measure for weight thresholds. kg = kilogram, lb = pound, ton = US ton (2000 lbs), metric_ton = metric tonne (1000 kg).. Valid values are `kg|lb|ton|metric_ton`',
    CONSTRAINT pk_contract_surcharge_schedule PRIMARY KEY(`contract_surcharge_schedule_id`)
) COMMENT 'Contractually agreed surcharge schedules applicable to a specific agreement, covering BAF (Bunker Adjustment Factor), GRI (General Rate Increase), THC (Terminal Handling Charge), fuel surcharges, peak season surcharges, remote area surcharges, and DIM weight adjustments. Captures surcharge type, calculation method, cap/floor values, applicability conditions, and validity period within the contract.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` (
    `contract_volume_commitment_id` BIGINT COMMENT 'Unique identifier for the contract volume commitment record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or agreement under which this volume commitment is defined.',
    `contract_party_id` BIGINT COMMENT 'Identifier of the party (customer, carrier, or partner) to whom this volume commitment obligation applies. Links to the appropriate party master table based on commitment_party_type.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Volume commitment creation audit trails are mandatory for contract governance, dispute resolution, and accountability tracking in logistics operations. The created_by string denormalizes employee iden',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Volume commitments frequently specify particular lanes (origin-destination pairs) with minimum/maximum volume obligations. Critical for lane-level capacity allocation, booking prioritization, and moni',
    `actual_volume` DECIMAL(18,2) COMMENT 'Actual volume utilized or booked against this commitment during the current measurement period. Updated periodically as shipments are executed.',
    `auto_renew_flag` BOOLEAN COMMENT 'Indicates whether this volume commitment automatically renews for the next period upon expiration. True if auto-renewal is enabled, False otherwise.',
    `commitment_code` STRING COMMENT 'Business identifier or code for this volume commitment, used for external reference and reporting.',
    `commitment_notes` STRING COMMENT 'Free-text notes or comments providing additional context, special conditions, or clarifications regarding this volume commitment.',
    `commitment_party_type` STRING COMMENT 'Type of party to whom this volume commitment applies: customer (shipper/consignee), carrier (transport provider), 3PL (Third-Party Logistics provider), 4PL (Fourth-Party Logistics provider), or vendor.. Valid values are `customer|carrier|3pl|4pl|vendor`',
    `commitment_period` STRING COMMENT 'Measurement period for evaluating volume commitment performance: daily, weekly, monthly, quarterly, annual, or over the entire contract term.. Valid values are `daily|weekly|monthly|quarterly|annual|contract_term`',
    `commitment_status` STRING COMMENT 'Current lifecycle status of the volume commitment: active (in force), suspended (temporarily paused), expired (past validity period), fulfilled (target met), breached (obligation not met), or pending (awaiting activation).. Valid values are `active|suspended|expired|fulfilled|breached|pending`',
    `commitment_type` STRING COMMENT 'Classification of the volume commitment: minimum volume guarantee (MVG), maximum volume cap, capacity allocation, shipment count commitment, weight-based commitment, TEU (Twenty-foot Equivalent Unit) commitment for ocean freight, or lane-specific allocation. [ENUM-REF-CANDIDATE: minimum_volume_guarantee|maximum_volume_cap|capacity_allocation|shipment_count|weight_based|teu_based|lane_specific — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this volume commitment record was first created in the system.',
    `destination_location_code` STRING COMMENT 'Code for the destination port, hub, terminal, or geographic region covered by this commitment. May be IATA airport code, UN/LOCODE port code, or internal location identifier.',
    `effective_from_date` DATE COMMENT 'Start date from which this volume commitment becomes binding and enforceable.',
    `effective_to_date` DATE COMMENT 'End date until which this volume commitment remains valid. Nullable for open-ended commitments.',
    `excess_incentive_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the excess incentive amount.. Valid values are `^[A-Z]{3}$`',
    `excess_incentive_rate` DECIMAL(18,2) COMMENT 'Incentive rate or rebate amount per unit of volume exceeding the target commitment. Rewards customers or carriers for exceeding volume targets.',
    `last_measured_date` DATE COMMENT 'Date when the actual volume utilization was last calculated and updated for this commitment.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this volume commitment record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this volume commitment record was last updated or modified.',
    `maximum_volume` DECIMAL(18,2) COMMENT 'Maximum volume or capacity cap that can be utilized during the commitment period. Represents the ceiling limit.',
    `measurement_frequency` STRING COMMENT 'Frequency at which actual volume utilization is measured and reported against this commitment: real-time, daily, weekly, monthly, quarterly, or annual.. Valid values are `real_time|daily|weekly|monthly|quarterly|annual`',
    `minimum_volume` DECIMAL(18,2) COMMENT 'Minimum volume or capacity that must be utilized or booked during the commitment period to avoid penalties. Represents the floor obligation.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review or reconciliation of this volume commitment against actual performance.',
    `origin_location_code` STRING COMMENT 'Code for the origin port, hub, terminal, or geographic region covered by this commitment. May be IATA airport code, UN/LOCODE port code, or internal location identifier.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiration that renewal notice must be provided if auto-renewal is not desired. Used for contract management and notification workflows.',
    `rollover_allowed_flag` BOOLEAN COMMENT 'Indicates whether unused volume from one commitment period can be rolled over to the next period. True if rollover is permitted, False otherwise.',
    `rollover_volume` DECIMAL(18,2) COMMENT 'Volume carried over from the previous commitment period, if rollover is allowed. Added to the current periods commitment.',
    `route_code` STRING COMMENT 'Service string or route code identifying the specific service routing or network path covered by this commitment. Nullable if not route-specific.',
    `service_type` STRING COMMENT 'Service level or product type covered by this commitment: FCL (Full Container Load), LCL (Less Than Container Load), FTL (Full Truckload), LTL (Less Than Truckload), express, standard, economy, or premium service. [ENUM-REF-CANDIDATE: FCL|LCL|FTL|LTL|express|standard|economy|premium — 8 candidates stripped; promote to reference product]',
    `shortfall_penalty_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the shortfall penalty amount.. Valid values are `^[A-Z]{3}$`',
    `shortfall_penalty_rate` DECIMAL(18,2) COMMENT 'Penalty rate or amount per unit of volume shortfall if the minimum commitment is not met. May be a fixed amount or percentage of the shortfall value.',
    `target_volume` DECIMAL(18,2) COMMENT 'Target or expected volume for the commitment period, often used as a benchmark for incentive calculations.',
    `transport_mode` STRING COMMENT 'Mode of transportation to which this volume commitment applies: air freight, ocean freight, road (FTL/LTL), rail, multimodal, or express parcel delivery.. Valid values are `air|ocean|road|rail|multimodal|express`',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of the target or minimum volume that has been utilized, calculated as (actual_volume / target_volume) * 100. Used for performance tracking and incentive calculation.',
    `volume_unit` STRING COMMENT 'Unit of measure for the volume commitment: TEU (Twenty-foot Equivalent Unit) for ocean freight, kg or ton for weight-based, CBM (Cubic Meter) for dimensional, shipment count for express parcels, pallet, or container count. [ENUM-REF-CANDIDATE: TEU|kg|ton|cbm|shipment_count|pallet|container — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_contract_volume_commitment PRIMARY KEY(`contract_volume_commitment_id`)
) COMMENT 'Defines volume and capacity commitment obligations within a contract, including minimum volume guarantees (MVG), maximum volume caps, TEU commitments for ocean freight, weight-based commitments for air freight, shipment count commitments for express, and lane-level capacity allocations specifying origin-destination pairs, transport mode, weekly or monthly capacity (TEU, kg, flights, truck loads), minimum booking obligations, and rollover provisions. Captures commitment period (monthly, quarterly, annual), measurement unit, lane code, origin/destination port or hub, service string or route code, penalty for shortfall, and incentive for exceeding targets.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` (
    `volume_actuals_id` BIGINT COMMENT 'Unique identifier for the volume actuals record. Primary key for tracking actual shipped volumes against contracted commitments.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or customer service agreement under which this volume commitment was established.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Volume actuals measure shipment volumes against commitments. In multi-carrier agreements, operations and finance teams need direct carrier attribution to track which carrier delivered the volume for p',
    `contract_volume_commitment_id` BIGINT COMMENT 'Foreign key linking to contract.contract_volume_commitment. Business justification: volume_actuals measures actual shipped volumes against contracted volume commitments. Currently only links to agreement (parent), but should link to the specific volume commitment being measured to en',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Volume actuals drive operational cost allocations to cost centers for cost accounting, variance analysis, and budget vs actual reporting. Essential for operational cost management in logistics.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account responsible for this volume commitment. Used for customer-level volume tracking and compliance reporting.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Volume actuals measurement requires lane-level granularity to track performance against lane-specific commitments. Enables lane utilization reporting, commitment compliance monitoring, and identificat',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Volume actuals drive revenue recognition and profitability analysis by profit center. Critical for segment reporting, performance management, and EBITDA tracking in logistics operations.',
    `actual_volume_shipped` DECIMAL(18,2) COMMENT 'The actual volume shipped during the measurement period, expressed in the unit of measure specified in volume_unit. This is the primary metric for contract compliance and penalty/incentive calculations.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'The volume adjustment amount applied to actual or committed volumes, expressed in the volume unit of measure. Null if no adjustment was made. Positive values increase volume, negative values decrease.',
    `adjustment_reason` STRING COMMENT 'Free-text explanation for any manual adjustments made to actual or committed volumes. Null if no adjustments were applied. Supports audit and dispute resolution.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this volume actuals record was approved. Null if no approval workflow is required. Supports audit trail and compliance tracking.',
    `approved_by` STRING COMMENT 'The name or identifier of the person who approved this volume actuals record, particularly when adjustments or exceptions were applied. Supports accountability and audit trail.',
    `attainment_percentage` DECIMAL(18,2) COMMENT 'The percentage of committed volume that was actually shipped, calculated as (actual_volume_shipped / committed_volume) * 100. Used to determine compliance with volume commitments and trigger penalty or incentive clauses.',
    `calculation_timestamp` TIMESTAMP COMMENT 'The date and time when the volume actuals were calculated and this record was generated. Supports audit trail and data lineage tracking.',
    `committed_volume` DECIMAL(18,2) COMMENT 'The contracted volume commitment for this measurement period, expressed in the same unit of measure as actual volume. Represents the baseline for attainment calculation.',
    `compliance_status` STRING COMMENT 'The compliance status of this volume actuals record relative to contract terms. Compliant indicates attainment meets or exceeds thresholds, non-compliant triggers penalties, at-risk indicates approaching threshold, grace-period allows temporary shortfall, waived indicates contractual exception.. Valid values are `compliant|non-compliant|at-risk|grace-period|waived`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this volume actuals record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for penalty and incentive amounts (e.g., USD, EUR, GBP). Aligns with contract currency terms.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'The source system or module from which the actual volume data was extracted (e.g., SAP TM, Oracle TMS, Manhattan WMS). Supports data lineage and reconciliation.',
    `destination_region` STRING COMMENT 'The destination region or country code for shipments included in this volume actuals record. Supports geographic segmentation of volume commitments.',
    `incentive_amount` DECIMAL(18,2) COMMENT 'The calculated incentive or rebate amount in the contract currency resulting from volume surplus. Null if no incentive is triggered. Used for billing credits and customer relationship management.',
    `incentive_triggered_flag` BOOLEAN COMMENT 'Indicates whether this volume surplus has triggered a contractual incentive or rebate clause. True if incentive conditions are met, False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this volume actuals record was last modified. Supports change tracking and audit trail.',
    `measurement_period_end_date` DATE COMMENT 'The end date of the measurement period for which actual volumes are being tracked. Defines the boundary for volume aggregation and attainment calculation.',
    `measurement_period_start_date` DATE COMMENT 'The start date of the measurement period for which actual volumes are being tracked. Typically aligns with contract billing cycles (monthly, quarterly, annually).',
    `notes` STRING COMMENT 'Free-text notes or comments related to this volume actuals record. Used to capture context, exceptions, or additional information for business users and auditors.',
    `origin_region` STRING COMMENT 'The origin region or country code for shipments included in this volume actuals record. Supports geographic segmentation of volume commitments.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The calculated penalty amount in the contract currency resulting from volume shortfall. Null if no penalty is triggered. Used for billing adjustments and financial reporting.',
    `penalty_triggered_flag` BOOLEAN COMMENT 'Indicates whether this volume shortfall has triggered a contractual penalty clause. True if penalty conditions are met, False otherwise.',
    `period_type` STRING COMMENT 'The type of measurement period used for volume tracking. Aligns with contract terms and billing cycles.. Valid values are `monthly|quarterly|semi-annual|annual|custom`',
    `record_status` STRING COMMENT 'The current status of this volume actuals record in its lifecycle. Draft indicates preliminary calculation, final indicates approved and locked, revised indicates correction applied, voided indicates record is no longer valid.. Valid values are `draft|final|revised|voided`',
    `service_level` STRING COMMENT 'The primary service level or product type associated with this volume commitment. Used to segment volume tracking by service offering.. Valid values are `express|standard|economy|freight|specialized`',
    `shipment_count` STRING COMMENT 'The total number of individual shipments processed during the measurement period. Provides additional context for volume analysis and operational performance tracking.',
    `shortfall_flag` BOOLEAN COMMENT 'Indicates whether the actual volume shipped fell short of the committed volume for this period. True if actual < committed, False otherwise.',
    `surplus_flag` BOOLEAN COMMENT 'Indicates whether the actual volume shipped exceeded the committed volume for this period. True if actual > committed, False otherwise.',
    `trade_lane` STRING COMMENT 'The trade lane or geographic corridor for which this volume commitment applies (e.g., Asia-Europe, Trans-Pacific, Intra-Europe). Used for regional volume analysis and network planning.',
    `transport_mode` STRING COMMENT 'The primary mode of transportation for shipments included in this volume commitment. Used to segment volume tracking by operational capability.. Valid values are `air|ocean|road|rail|multimodal`',
    `volume_unit` STRING COMMENT 'The unit of measure used for both actual and committed volumes. Common units include TEU (Twenty-foot Equivalent Unit) for containers, kg for weight-based commitments, CBM (Cubic Meter) for dimensional volume, or shipment count for parcel-based agreements.. Valid values are `TEU|kg|CBM|shipment_count|pallet|ton`',
    `volume_variance` DECIMAL(18,2) COMMENT 'The difference between actual volume shipped and committed volume (actual minus committed). Positive values indicate surplus, negative values indicate shortfall.',
    CONSTRAINT pk_volume_actuals PRIMARY KEY(`volume_actuals_id`)
) COMMENT 'Transactional record of actual volumes shipped against contracted volume commitments for each measurement period. Captures period start and end dates, actual volume shipped (TEU, kg, CBM, shipment count), committed volume, variance, attainment percentage, and shortfall or surplus flag. Used to trigger penalty or incentive clause calculations and contract compliance reporting.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` (
    `penalty_clause_id` BIGINT COMMENT 'Unique identifier for the penalty or incentive clause within a contract or agreement.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or agreement to which this penalty or incentive clause belongs.',
    `contract_sla_commitment_id` BIGINT COMMENT 'Reference to the specific SLA entitlement or commitment that this penalty or incentive clause is tied to. Null if not linked to a specific SLA.',
    `contract_volume_commitment_id` BIGINT COMMENT 'Reference to the specific volume commitment or minimum volume agreement that this penalty or incentive clause is tied to. Null if not linked to a volume commitment.',
    `target_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_target. Business justification: Penalty clauses trigger when carrier fails contractual sustainability targets (e.g., SAF usage percentage, emission reduction milestones). Required for automated penalty calculation and sustainability',
    `accrual_method` STRING COMMENT 'Accounting method for recognizing the penalty or incentive (e.g., immediate upon trigger, at period end, on invoice date, upon settlement).. Valid values are `immediate|period_end|invoice_date|settlement_date`',
    `applies_to_party` STRING COMMENT 'The party to whom this penalty or incentive clause applies (e.g., customer, carrier, vendor, 3PL, 4PL, customs broker).. Valid values are `customer|carrier|vendor|3pl|4pl|broker`',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether management or executive approval is required before applying this penalty or awarding this incentive.',
    `auto_apply_flag` BOOLEAN COMMENT 'Indicates whether this penalty or incentive is automatically calculated and applied by the system, or requires manual review and application.',
    `calculation_method` STRING COMMENT 'Method used to calculate the penalty or incentive amount (e.g., fixed fee per breach, percentage of invoice value, tiered rebate schedule, flat bonus amount, credit note issuance, per-unit deduction or reward).. Valid values are `fixed_fee|percentage_of_invoice|tiered_rebate|flat_bonus|credit_note|per_unit`',
    `clause_category` STRING COMMENT 'Specific category of the penalty or incentive clause (e.g., SLA breach penalty, volume shortfall penalty, late payment penalty, service failure deduction, volume rebate, performance bonus for exceeding OTD/OTIF targets, loyalty discount, early payment incentive).. Valid values are `sla_breach|volume_shortfall|late_payment|service_failure|performance_bonus|volume_rebate`',
    `clause_description` STRING COMMENT 'Detailed textual description of the penalty or incentive clause, including business rationale, calculation examples, and any special conditions.',
    `clause_number` STRING COMMENT 'The externally-known clause identifier or section number within the contract document (e.g., Section 7.3, Clause P-001).',
    `clause_status` STRING COMMENT 'Current lifecycle status of the penalty or incentive clause within the contract.. Valid values are `active|inactive|suspended|expired|superseded`',
    `clause_type` STRING COMMENT 'Classification of the clause as a penalty (financial deduction for non-performance) or incentive/rebate (financial reward for exceeding targets).. Valid values are `penalty|incentive|rebate|bonus|deduction|credit`',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this penalty or incentive clause record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this penalty or incentive clause record was first created in the system.',
    `cure_period_days` STRING COMMENT 'Number of days allowed to remedy the breach or non-performance before the penalty is applied. Null if no cure period is granted.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this clause (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dispute_allowed_flag` BOOLEAN COMMENT 'Indicates whether the affected party is allowed to dispute the penalty or incentive calculation and trigger the escalation path.',
    `effective_from_date` DATE COMMENT 'Date from which this penalty or incentive clause becomes active and enforceable.',
    `effective_to_date` DATE COMMENT 'Date on which this penalty or incentive clause expires or is no longer enforceable. Null for open-ended clauses.',
    `escalation_path` STRING COMMENT 'Defined escalation or dispute resolution process if the penalty or incentive calculation is contested (e.g., escalate to account manager, arbitration, executive review).',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Fixed incentive or bonus amount awarded when performance exceeds the threshold (in contract currency). Null if calculation is percentage-based or tiered.',
    `incentive_percentage` DECIMAL(18,2) COMMENT 'Percentage rate applied to calculate the incentive or rebate (e.g., 3.0 for 3.0% volume rebate). Null if calculation is fixed-fee based.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this penalty or incentive clause record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this penalty or incentive clause record was last updated or modified.',
    `legal_reference` STRING COMMENT 'Reference to the specific section, article, or clause number in the legal contract document where this penalty or incentive is formally documented.',
    `maximum_liability_cap` DECIMAL(18,2) COMMENT 'Maximum cumulative penalty amount that can be assessed under this clause within a defined period (in contract currency). Protects against unlimited liability exposure.',
    `maximum_payout_cap` DECIMAL(18,2) COMMENT 'Maximum cumulative incentive or rebate amount that can be awarded under this clause within a defined period (in contract currency). Limits total incentive exposure.',
    `measurement_period` STRING COMMENT 'Time period over which performance is measured to determine if the clause is triggered (e.g., daily, weekly, monthly, quarterly, annually, per shipment, entire contract term). [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|annually|per_shipment|contract_term — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or special instructions related to this penalty or incentive clause.',
    `notification_required_flag` BOOLEAN COMMENT 'Indicates whether the affected party must be notified in advance before a penalty is applied or an incentive is awarded.',
    `payment_frequency` STRING COMMENT 'Frequency at which penalties are assessed or incentives are paid out (e.g., per occurrence, monthly, quarterly, annually, upon final settlement).. Valid values are `per_occurrence|monthly|quarterly|annually|upon_settlement`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Fixed penalty amount or base penalty value applied when the clause is triggered (in contract currency). Null if calculation is percentage-based or tiered.',
    `penalty_percentage` DECIMAL(18,2) COMMENT 'Percentage rate applied to calculate the penalty or incentive (e.g., 2.5 for 2.5% of invoice value). Null if calculation is fixed-fee based.',
    `threshold_unit` STRING COMMENT 'Unit of measure for the threshold value (e.g., percentage, TEU, shipments, days, USD, hours).',
    `threshold_value` DECIMAL(18,2) COMMENT 'The numeric threshold or target value that must be met or breached to trigger the clause (e.g., 95 for 95% OTD, 1000 for 1000 TEU volume commitment).',
    `trigger_condition` STRING COMMENT 'Detailed description of the condition or event that activates this penalty or incentive clause (e.g., OTD below 95%, volume below 1000 TEU per month, payment received after 60 days).',
    `version_number` STRING COMMENT 'Version number of this penalty or incentive clause, incremented with each amendment or revision to the clause terms.',
    CONSTRAINT pk_penalty_clause PRIMARY KEY(`penalty_clause_id`)
) COMMENT 'Defines financial clauses embedded within a contract, encompassing both penalty clauses (SLA breach penalties, volume shortfall penalties, late payment penalties, service failure deductions) and incentive/rebate clauses (volume rebates, performance bonuses for exceeding OTD/OTIF targets, loyalty discounts, early payment incentives). Captures clause type (penalty or incentive), trigger condition/threshold, calculation method (fixed fee, percentage of invoice, credit note, tiered rebate, flat bonus), maximum liability cap or maximum payout, cure period, escalation path, payment frequency, and accrual method. Linked to the parent agreement and specific SLA or volume commitment.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` (
    `incentive_clause_id` BIGINT COMMENT 'Unique identifier for the incentive clause within the contract management system. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or agreement to which this incentive clause belongs. Links the incentive clause to the master agreement.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Incentive clause approval workflows require employee tracking for financial controls, authorization verification, and audit compliance in logistics contract management. The approved_by string denormal',
    `target_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_target. Business justification: Incentive clauses reward carriers/customers for exceeding sustainability targets (e.g., bonus for 50% emission reduction vs. baseline). Essential for green performance incentive programs and sustainab',
    `accrual_method` STRING COMMENT 'The method by which the incentive is recognized and settled. Options include accrued (accumulated over time and paid later), paid immediately (applied at transaction time), deferred (held until contract end), credited to account (applied as credit memo).. Valid values are `accrued|paid_immediately|deferred|credited_to_account`',
    `applies_to_customer_segment` STRING COMMENT 'The customer segment or classification to which this incentive clause applies (e.g., enterprise, SMB, e-commerce, 3PL). Pipe-separated list if multiple segments are eligible. Nullable if applies to all segments.',
    `applies_to_lane` STRING COMMENT 'The specific trade lanes or routes to which this incentive clause applies (e.g., USA-EUR, Asia-USA, domestic USA). Pipe-separated list if multiple lanes are eligible. Nullable if applies to all lanes.',
    `applies_to_service_type` STRING COMMENT 'The specific service types or product lines to which this incentive clause applies (e.g., express parcel, air freight, ocean freight, LTL, FTL, warehousing). Pipe-separated list if multiple service types are eligible. Nullable if applies to all services.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether manual approval is required before the incentive can be paid out or applied (true) or if it is automatically applied upon meeting criteria (false). Used for governance and control.',
    `approved_date` DATE COMMENT 'The date on which this incentive clause was approved. Used for audit trail and governance. Nullable if approval is not required or not yet obtained.',
    `calculation_method` STRING COMMENT 'The method used to calculate the incentive payout or discount. Options include tiered rebate (different rates for different volume bands), flat bonus (fixed amount), percentage discount (percentage off charges), fixed amount (one-time payment), sliding scale (continuous function), cumulative (accumulates over time).. Valid values are `tiered_rebate|flat_bonus|percentage_discount|fixed_amount|sliding_scale|cumulative`',
    `cap_amount` DECIMAL(18,2) COMMENT 'The maximum total incentive payout or discount amount that can be earned under this clause, regardless of performance. Used to limit financial exposure. Nullable if no cap applies.',
    `cap_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the cap amount (e.g., USD, EUR, GBP). Applicable when a monetary cap is defined.. Valid values are `^[A-Z]{3}$`',
    `clause_name` STRING COMMENT 'Human-readable name or title of the incentive clause (e.g., Volume Rebate Tier 3, On-Time Delivery Bonus, Early Payment Discount).',
    `clause_number` STRING COMMENT 'The business-assigned clause number or identifier within the contract document (e.g., Section 5.2, Clause IC-001). Used for legal and operational reference.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this incentive clause record was first created in the system. Used for audit trail and data lineage.',
    `cumulative_flag` BOOLEAN COMMENT 'Indicates whether the incentive is cumulative across measurement periods (true) or resets each period (false). For example, a cumulative volume rebate accumulates shipments across the entire contract term, while a non-cumulative rebate resets monthly.',
    `effective_from_date` DATE COMMENT 'The date from which the incentive clause becomes active and applicable. Aligns with contract effective dates or specific promotion periods.',
    `effective_to_date` DATE COMMENT 'The date on which the incentive clause expires or is no longer applicable. Nullable for open-ended clauses that remain active until contract termination.',
    `exclusions` STRING COMMENT 'Free-text description of any exclusions or exceptions to the incentive clause (e.g., does not apply to fuel surcharges, excludes promotional shipments, not applicable during peak season). Provides clarity on scope limitations.',
    `incentive_clause_status` STRING COMMENT 'Current lifecycle status of the incentive clause. Indicates whether the clause is currently in effect, suspended, expired, or awaiting approval.. Valid values are `active|inactive|suspended|expired|pending_approval`',
    `incentive_type` STRING COMMENT 'Classification of the incentive clause. Defines the nature of the incentive: volume rebate (based on shipment volume), performance bonus (exceeding OTD/OTIF targets), loyalty discount (long-term partnership rewards), early payment incentive (payment term discounts), OTD bonus (On-Time Delivery performance), OTIF bonus (On-Time In-Full performance).. Valid values are `volume_rebate|performance_bonus|loyalty_discount|early_payment_incentive|otd_bonus|otif_bonus`',
    `incentive_value` DECIMAL(18,2) COMMENT 'The numeric value of the incentive. Interpretation depends on calculation method: for percentage discount, this is the percentage (e.g., 5.00 for 5%); for flat bonus, this is the fixed amount; for tiered rebate, this may be the base rate.',
    `incentive_value_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for monetary incentive values (e.g., USD, EUR, GBP). Applicable when the incentive is a fixed amount or monetary rebate.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this incentive clause record was last updated or modified. Used for audit trail and change tracking.',
    `measurement_period_type` STRING COMMENT 'The time period over which the trigger metric is measured and evaluated (e.g., calendar month, calendar quarter, calendar year, rolling 30 days, rolling 90 days, entire contract term, custom period). Defines the evaluation window for incentive eligibility. [ENUM-REF-CANDIDATE: calendar_month|calendar_quarter|calendar_year|rolling_30_days|rolling_90_days|contract_term|custom — 7 candidates stripped; promote to reference product]',
    `modified_by` STRING COMMENT 'The user identifier or name of the person who last modified this incentive clause record. Used for audit trail and accountability.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the incentive clause. Used for operational context and clarifications.',
    `payment_frequency` STRING COMMENT 'The frequency at which the incentive is paid out or applied. Defines the cadence of incentive settlement (e.g., monthly rebate, quarterly bonus, annual loyalty discount, per-shipment discount, upon achievement of milestone, at end of contract term).. Valid values are `monthly|quarterly|annually|per_shipment|upon_achievement|end_of_contract`',
    `retroactive_flag` BOOLEAN COMMENT 'Indicates whether the incentive applies retroactively to all qualifying transactions once the threshold is met (true) or only to transactions after the threshold is achieved (false). Common in tiered rebate structures.',
    `tier_level` STRING COMMENT 'The tier or band level for tiered incentive structures (e.g., Tier 1, Tier 2, Tier 3). Used when calculation method is tiered rebate or sliding scale. Nullable for non-tiered incentives.',
    `tier_max_value` DECIMAL(18,2) COMMENT 'The maximum threshold value for this tier level. Used in tiered rebate structures to define the upper bound of the tier (e.g., Tier 2 ends at 999 TEU). Nullable for open-ended top tiers or non-tiered incentives.',
    `tier_min_value` DECIMAL(18,2) COMMENT 'The minimum threshold value for this tier level. Used in tiered rebate structures to define the lower bound of the tier (e.g., Tier 2 starts at 500 TEU). Nullable for non-tiered incentives.',
    `trigger_metric` STRING COMMENT 'The performance metric or business measure that triggers the incentive (e.g., total shipment volume in TEU, OTD percentage, OTIF percentage, total revenue, payment days). Defines what is being measured to determine incentive eligibility.',
    `trigger_operator` STRING COMMENT 'The comparison operator used to evaluate whether the trigger threshold has been met (e.g., greater than, greater than or equal, less than, between). Defines the logic for incentive activation.. Valid values are `greater_than|greater_than_or_equal|less_than|less_than_or_equal|equal|between`',
    `trigger_threshold_unit` STRING COMMENT 'The unit of measure for the trigger threshold value (e.g., TEU, percentage, days, USD, shipments, pallets). Provides context for interpreting the threshold value.',
    `trigger_threshold_value` DECIMAL(18,2) COMMENT 'The numeric threshold value that must be met or exceeded to activate the incentive. For example, 1000 TEU for volume rebate, 95% for OTD target, 30 days for early payment.',
    CONSTRAINT pk_incentive_clause PRIMARY KEY(`incentive_clause_id`)
) COMMENT 'Defines incentive and rebate clauses within a contract, including volume rebates, performance bonuses for exceeding OTD/OTIF targets, loyalty discounts, and early payment incentives. Captures incentive type, trigger threshold, calculation method (tiered rebate, flat bonus, percentage discount), payment frequency, and accrual method. Linked to the parent agreement.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`penalty_event` (
    `penalty_event_id` BIGINT COMMENT 'Unique identifier for the penalty or incentive event. Primary key for the penalty event transaction.',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Penalty events generate customer receivables when penalties are invoiced. Essential for revenue recognition, AR aging, collections management, and financial close processes in logistics billing.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract under which this penalty or incentive event was triggered.',
    `cargo_claim_id` BIGINT COMMENT 'Foreign key linking to claim.cargo_claim. Business justification: Penalty events (late delivery, damage) frequently result in cargo claims. Linking enables financial reconciliation—verifying that penalties assessed match claim settlements, resolving disputes where c',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Penalty events track carrier service failures (late delivery, damage, documentation errors). Claims and dispute resolution teams require direct carrier attribution for root cause analysis, financial r',
    `consignment_id` BIGINT COMMENT 'Reference to the specific shipment associated with this penalty event, if applicable. Null for volume-based or aggregate performance events.',
    `contract_party_id` BIGINT COMMENT 'Identifier of the specific party (customer, carrier, vendor) to whom this penalty or incentive applies.',
    `credit_note_id` BIGINT COMMENT 'Reference to the credit note issued for this incentive event, if applicable.',
    `cycle_id` BIGINT COMMENT 'Reference to the billing cycle in which this penalty or incentive will be or was applied.',
    `debit_note_id` BIGINT COMMENT 'Reference to the debit note issued for this penalty event, if applicable.',
    `hse_incident_id` BIGINT COMMENT 'Foreign key linking to safety.hse_incident. Business justification: Contract penalties may be triggered by safety incidents affecting service delivery (driver unavailability, vehicle damage, regulatory detention). Links penalty to causal incident for financial impact ',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice on which this penalty or incentive was applied as a line item or adjustment.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Penalty events trigger journal entries for revenue/expense recognition and accrual accounting. Critical for financial close, audit trail, SOX compliance, and accurate financial statement preparation.',
    `freight_order_id` BIGINT COMMENT 'Reference to the customer order associated with this penalty event, if applicable. Null for carrier or vendor penalties.',
    `penalty_clause_id` BIGINT COMMENT 'Reference to the specific contract clause that defines the penalty or incentive terms that were breached or met.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to route.route_plan. Business justification: Penalty events (SLA breaches) often result from route execution failures—delays, missed connections, routing errors. Direct link enables root cause analysis, correlating contractual penalties with spe',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Penalty events may originate from procurement failures (late delivery of critical parts/equipment causing service disruptions). Links penalties to root-cause POs for supplier accountability, dispute r',
    `shipment_carbon_footprint_id` BIGINT COMMENT 'Foreign key linking to sustainability.shipment_carbon_footprint. Business justification: Penalty events for green SLA breaches must reference specific shipment carbon footprint that triggered violation for dispute resolution, audit trail, and customer transparency on carbon performance fa',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Penalty events often reference specific transport documents as evidence (late BOL issuance, missing POD, incorrect document data). Business need: linking penalties to documentary proof, supporting pen',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Any manual adjustment applied to the calculated amount due to dispute resolution, management override, or contractual cap.',
    `approval_date` DATE COMMENT 'Date on which the penalty event was approved for billing application.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this penalty event requires management approval before being applied to billing.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the penalty or incentive event for billing application.',
    `base_amount` DECIMAL(18,2) COMMENT 'The base monetary value used in the penalty or incentive calculation (e.g., shipment value, contract value, invoice amount).',
    `calculated_amount` DECIMAL(18,2) COMMENT 'The computed penalty or incentive amount before any adjustments, caps, or approvals.',
    `calculation_method` STRING COMMENT 'Method used to calculate the penalty or incentive amount as defined in the contract clause (fixed, percentage, tiered, per-unit, per-day).. Valid values are `fixed_amount|percentage_of_value|tiered_rate|per_unit|per_day`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this penalty event record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this penalty event.. Valid values are `^[A-Z]{3}$`',
    `detection_date` DATE COMMENT 'The date on which the penalty or incentive event was detected and recorded in the system.',
    `dispute_date` DATE COMMENT 'Date on which the dispute was formally raised against this penalty event.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this penalty event is currently under dispute by the customer or carrier.',
    `dispute_reason` STRING COMMENT 'Explanation provided by the disputing party for challenging the penalty or incentive event.',
    `event_date` DATE COMMENT 'The date on which the triggering event occurred (e.g., the date of SLA breach, the end of the measurement period for volume shortfall).',
    `event_number` STRING COMMENT 'Human-readable business identifier for the penalty event, used for tracking and reference in communications and billing documents.. Valid values are `^PE-[0-9]{10}$`',
    `event_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the triggering event occurred, used for detailed audit and reconciliation.',
    `event_type` STRING COMMENT 'Classification of the event as a penalty (charge to customer/carrier) or incentive (credit to customer/carrier).. Valid values are `penalty|incentive|credit|debit`',
    `external_reference_number` STRING COMMENT 'External reference number or identifier from the source system or partner system for cross-system reconciliation.',
    `final_amount` DECIMAL(18,2) COMMENT 'The final approved penalty or incentive amount to be applied to billing, after all adjustments and approvals.',
    `notification_date` DATE COMMENT 'Date on which the notification was sent to the affected party.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether a notification has been sent to the affected party regarding this penalty or incentive event.',
    `party_type` STRING COMMENT 'Type of party to whom the penalty is charged or incentive is credited (customer, carrier, third-party logistics provider, vendor).. Valid values are `customer|carrier|vendor|3pl|4pl`',
    `penalty_event_status` STRING COMMENT 'Current lifecycle status of the penalty event in the approval and settlement workflow.. Valid values are `pending|approved|disputed|settled|waived|cancelled`',
    `penalty_rate` DECIMAL(18,2) COMMENT 'The rate or percentage applied to calculate the penalty or incentive amount (e.g., 5% of shipment value, $50 per day).',
    `resolution_date` DATE COMMENT 'Date on which the penalty event was settled, waived, or otherwise resolved.',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the resolution outcome, including any negotiated adjustments or waivers.',
    `sla_metric_code` STRING COMMENT 'Code identifying the specific SLA metric that was breached or exceeded (e.g., OTD, OTIF, transit time, damage rate). Null if event is not SLA-related.',
    `source_system` STRING COMMENT 'Name of the operational system that originated this penalty event record (e.g., SAP TM, Oracle TMS, billing system).',
    `trigger_category` STRING COMMENT 'High-level category of the triggering event that caused the penalty or incentive to be applied.. Valid values are `sla_breach|volume_shortfall|service_failure|quality_failure|compliance_violation|performance_bonus`',
    `trigger_description` STRING COMMENT 'Detailed narrative description of the specific event or condition that triggered the penalty or incentive, including relevant context and supporting details.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this penalty event record was last modified.',
    `waived_by` STRING COMMENT 'Name or identifier of the person who authorized the waiver of this penalty event.',
    `waiver_date` DATE COMMENT 'Date on which the penalty was waived.',
    `waiver_reason` STRING COMMENT 'Business justification for waiving the penalty or not applying the incentive, if status is waived.',
    CONSTRAINT pk_penalty_event PRIMARY KEY(`penalty_event_id`)
) COMMENT 'Transactional record of an actual penalty or incentive event triggered under a contract clause. Captures the triggering event (SLA breach, volume shortfall, service failure), event date, calculated penalty or incentive amount, currency, status (pending, approved, disputed, settled), reference to the billing domain for credit/debit note issuance, and resolution notes.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` (
    `renewal_schedule_id` BIGINT COMMENT 'Unique identifier for the renewal schedule record. Primary key for the renewal schedule entity.',
    `contract_party_id` BIGINT COMMENT 'Reference to the customer party involved in the renewal decision. Primary counterparty to the agreement being renewed.',
    `previous_renewal_schedule_id` BIGINT COMMENT 'Reference to the prior renewal schedule record for this agreement, creating a historical chain of renewal events. Null for the first renewal schedule.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or agreement that this renewal schedule governs. Links to the master agreement entity.',
    `employee_id` BIGINT COMMENT 'Reference to the account manager or contract owner responsible for managing the renewal process, conducting reviews, and making recommendations.',
    `quaternary_renewal_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the system user who last modified this renewal schedule record. Used for change accountability and audit trail.',
    `tertiary_renewal_created_by_user_employee_id` BIGINT COMMENT 'Reference to the system user who created this renewal schedule record. Used for accountability and audit trail.',
    `approval_date` DATE COMMENT 'Date when the renewal was formally approved by the designated authority. Null if approval is pending or not required.',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Indicates whether the contract is configured for automatic renewal. True means the contract will renew automatically unless notice of termination is provided within the notice period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this renewal schedule record was first created in the system. Used for audit trail and data lineage.',
    `current_term_end_date` DATE COMMENT 'End date of the current contract term. The renewal decision must be executed before this date to ensure continuity or proper termination.',
    `current_term_start_date` DATE COMMENT 'Start date of the current contract term that this renewal schedule applies to. Used to calculate term duration and renewal timing.',
    `customer_response_date` DATE COMMENT 'Date when the customer provided their response to the renewal notification. Null if no response received.',
    `customer_response_type` STRING COMMENT 'Type of response received from the customer regarding the renewal. Accept means agreement to renew, decline means termination, request_renegotiation means desire to modify terms, request_extension means need more time to decide, no_response means deadline passed without feedback.. Valid values are `accept|decline|request_renegotiation|request_extension|no_response`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this renewal schedule record. Used for change tracking and audit purposes.',
    `negotiated_changes_summary` STRING COMMENT 'Summary of key changes negotiated during the renewal process, including pricing adjustments, SLA modifications, volume commitment changes, or service scope alterations.',
    `notice_period_days` STRING COMMENT 'Number of days prior to contract expiration that renewal notice must be provided. Critical for compliance with contractual notification requirements and to avoid automatic renewal or lapse.',
    `pricing_adjustment_percentage` DECIMAL(18,2) COMMENT 'Percentage change in pricing for the renewed term compared to the current term. Positive values indicate price increase, negative values indicate discount. Used for revenue forecasting and margin analysis.',
    `proposed_renewal_term_months` STRING COMMENT 'Duration in months for the proposed renewal term. May differ from the original term length based on renegotiation or standard renewal practices.',
    `renewal_approval_required` BOOLEAN COMMENT 'Indicates whether the renewal requires executive or management approval based on contract value, strategic importance, or policy requirements.',
    `renewal_decision_date` DATE COMMENT 'Actual date when the renewal decision was made and documented. Null if decision is still pending.',
    `renewal_decision_deadline` DATE COMMENT 'Final date by which a renewal decision must be made and communicated to avoid default action (auto-renewal or lapse). Critical milestone for contract management.',
    `renewal_notes` STRING COMMENT 'Free-text field for capturing additional context, special considerations, negotiation history, or internal notes related to the renewal process.',
    `renewal_notification_method` STRING COMMENT 'Communication channel used to deliver the renewal notification. Important for audit trail and compliance verification.. Valid values are `email|postal_mail|electronic_portal|in_person|phone|fax`',
    `renewal_notification_sent_date` DATE COMMENT 'Date when formal renewal notification was sent to the customer or counterparty. Critical for compliance with contractual notice requirements.',
    `renewal_outcome` STRING COMMENT 'Final outcome of the renewal decision. Renewed means contract continued with same terms, renegotiated means new terms agreed, terminated means ended by mutual decision, expired means ended by time without renewal, lapsed means deadline passed without action, withdrawn means renewal offer was retracted.. Valid values are `renewed|renegotiated|terminated|expired|lapsed|withdrawn`',
    `renewal_priority` STRING COMMENT 'Business priority level assigned to this renewal based on strategic importance, revenue impact, or customer relationship value. Used for resource allocation and attention management.. Valid values are `critical|high|medium|low`',
    `renewal_review_start_date` DATE COMMENT 'Date when the renewal review process should begin. Calculated based on notice period and internal review requirements to ensure timely decision-making.',
    `renewal_status` STRING COMMENT 'Current lifecycle status of the renewal schedule. Pending indicates awaiting review, under_review means active evaluation, approved means decision made to renew, renewed indicates successful renewal completion, renegotiated means terms were modified, terminated means contract ended by mutual agreement, expired means contract ended by time, lapsed means renewal deadline passed without action, cancelled means renewal was withdrawn. [ENUM-REF-CANDIDATE: pending|under_review|approved|renewed|renegotiated|terminated|expired|lapsed|cancelled — 9 candidates stripped; promote to reference product]',
    `renewal_trigger_condition` STRING COMMENT 'Business condition or performance threshold that triggers renewal evaluation for conditional renewal types. Examples include volume commitments met, SLA compliance achieved, or mutual satisfaction criteria.',
    `renewal_type` STRING COMMENT 'Classification of the renewal mechanism. Auto indicates automatic renewal without intervention, manual requires explicit action, conditional depends on performance or volume thresholds, negotiated requires renegotiation, evergreen continues indefinitely until terminated, fixed_term renews for a specific period.. Valid values are `auto|manual|conditional|negotiated|evergreen|fixed_term`',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Quantitative risk score (0-10 scale) assessing the likelihood of non-renewal or difficult renegotiation. Based on customer satisfaction, payment history, service performance, and market conditions.',
    `sla_modification_flag` BOOLEAN COMMENT 'Indicates whether SLA terms were modified during the renewal process. True means SLA thresholds, penalties, or incentives were changed.',
    `termination_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for contract termination if renewal outcome was terminated. Used for trend analysis and service improvement. [ENUM-REF-CANDIDATE: mutual_agreement|performance_issues|cost_concerns|service_quality|business_closure|strategic_change|competitive_offer|non_compliance|other — 9 candidates stripped; promote to reference product]',
    `termination_reason_description` STRING COMMENT 'Detailed explanation of the termination reason, providing context beyond the standardized code. Captures specific circumstances and business rationale.',
    `volume_commitment_change_percentage` DECIMAL(18,2) COMMENT 'Percentage change in volume commitments for the renewed term. Positive indicates increased commitment, negative indicates reduced commitment. Critical for capacity planning and revenue forecasting.',
    CONSTRAINT pk_renewal_schedule PRIMARY KEY(`renewal_schedule_id`)
) COMMENT 'Manages the complete renewal lifecycle of contracts, including auto-renewal configurations, notice period deadlines, renewal review milestones, renegotiation triggers, and the transactional history of renewal decisions. Captures renewal type (auto, manual, conditional), notice period in days, renewal review start date, renewal decision deadline, assigned account manager, and for each renewal event: decision date, outcome (renewed, renegotiated, terminated, expired, lapsed), new agreement reference if renewed, reason for termination if applicable, negotiated changes summary, and parties involved. Provides complete renewal history and forward-looking renewal management for each agreement.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`renewal_event` (
    `renewal_event_id` BIGINT COMMENT 'Unique identifier for the contract renewal or termination event. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or agreement that is being renewed or terminated.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the renewal occurred automatically based on auto-renewal clauses in the original contract.',
    `competitive_bid_conducted_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a competitive bidding process was conducted before the renewal decision.',
    `contract_value_change_amount` DECIMAL(18,2) COMMENT 'The change in total contract value as a result of the renewal or renegotiation, expressed in the contract currency.',
    `contract_value_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the contract value change amount.. Valid values are `^[A-Z]{3}$`',
    `counterparty_representative_name` STRING COMMENT 'The name of the representative from the counterparty organization (customer, carrier, Third-Party Logistics (3PL), Fourth-Party Logistics (4PL), or vendor) involved in the renewal negotiation.',
    `counterparty_representative_role` STRING COMMENT 'The job title or role of the counterparty representative involved in the renewal negotiation.',
    `created_by_user` STRING COMMENT 'The username or identifier of the system user who created this renewal event record.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this renewal event record was first created in the system.',
    `decision_maker_name` STRING COMMENT 'The name of the individual who authorized the renewal or termination decision on behalf of the organization.',
    `decision_maker_role` STRING COMMENT 'The job title or role of the individual who authorized the renewal or termination decision.',
    `incoterms_change_flag` BOOLEAN COMMENT 'Boolean flag indicating whether International Commercial Terms (Incoterms) such as Delivered Duty Paid (DDP), Delivered at Place (DAP), Free on Board (FOB), Cost Insurance and Freight (CIF), or Ex Works (EXW) were modified during the renewal.',
    `last_modified_by_user` STRING COMMENT 'The username or identifier of the system user who last modified this renewal event record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this renewal event record was last modified in the system.',
    `negotiated_changes_summary` STRING COMMENT 'Summary of key changes negotiated during the renewal process, including rate adjustments, Service Level Agreement (SLA) modifications, volume commitments, and other material terms.',
    `otd_compliance_percentage` DECIMAL(18,2) COMMENT 'The On-Time Delivery (OTD) compliance percentage achieved under the prior contract term, used to evaluate performance for renewal decisions.',
    `otif_compliance_percentage` DECIMAL(18,2) COMMENT 'The On-Time In-Full (OTIF) compliance percentage achieved under the prior contract term, used to evaluate performance for renewal decisions.',
    `penalty_clause_change_flag` BOOLEAN COMMENT 'Boolean flag indicating whether penalty or incentive clauses were modified during the renewal or renegotiation.',
    `prior_contract_performance_rating` STRING COMMENT 'The overall performance rating of the counterparty under the prior contract term, used as input to the renewal decision.. Valid values are `excellent|good|satisfactory|poor|unacceptable`',
    `rate_change_percentage` DECIMAL(18,2) COMMENT 'The percentage change in contract rates as a result of the renewal or renegotiation. Positive values indicate rate increases, negative values indicate rate decreases.',
    `renewal_approval_date` DATE COMMENT 'The date on which the renewal decision received final internal approval.',
    `renewal_approval_status` STRING COMMENT 'The approval status of the renewal event within the internal approval workflow.. Valid values are `pending|approved|rejected|conditional|escalated`',
    `renewal_approver_name` STRING COMMENT 'The name of the individual who provided final approval for the renewal or termination decision.',
    `renewal_decision_date` DATE COMMENT 'The date on which the renewal or termination decision was made by the authorized party.',
    `renewal_decision_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the renewal or termination decision was recorded in the system.',
    `renewal_effective_date` DATE COMMENT 'The date on which the renewed or renegotiated contract terms become effective. Null if terminated.',
    `renewal_expiry_date` DATE COMMENT 'The new expiration date of the renewed or renegotiated contract. Null if terminated.',
    `renewal_notes` STRING COMMENT 'Additional free-text notes and comments regarding the renewal event, capturing context, special circumstances, or follow-up actions required.',
    `renewal_notice_period_days` STRING COMMENT 'The number of days advance notice provided for the renewal or termination, as specified in the original contract terms.',
    `renewal_notification_date` DATE COMMENT 'The date on which the renewal or termination notification was sent to the counterparty, as required by contract terms.',
    `renewal_outcome` STRING COMMENT 'The outcome of the renewal event indicating whether the contract was renewed, renegotiated, terminated, expired, cancelled, or extended.. Valid values are `renewed|renegotiated|terminated|expired|cancelled|extended`',
    `renewal_term_months` STRING COMMENT 'The duration of the renewed contract term expressed in months. Null if terminated.',
    `renewal_type` STRING COMMENT 'Classification of the renewal event based on timing and circumstances (standard renewal at contract end, early renewal, late renewal, emergency renewal, or conditional renewal).. Valid values are `standard|early|late|emergency|conditional`',
    `sla_change_flag` BOOLEAN COMMENT 'Boolean flag indicating whether Service Level Agreement (SLA) terms were modified during the renewal or renegotiation.',
    `termination_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for contract termination if applicable. Null if the contract was renewed.. Valid values are `poor_performance|cost_reduction|service_quality|strategic_change|compliance_issue|mutual_agreement`',
    `termination_reason_description` STRING COMMENT 'Detailed narrative explanation of the reason for termination, providing context beyond the standardized code.',
    `volume_commitment_change_flag` BOOLEAN COMMENT 'Boolean flag indicating whether volume commitment terms were modified during the renewal or renegotiation.',
    CONSTRAINT pk_renewal_event PRIMARY KEY(`renewal_event_id`)
) COMMENT 'Transactional record of each contract renewal or termination event, capturing the renewal decision date, outcome (renewed, renegotiated, terminated, expired), new agreement reference if renewed, reason for termination if applicable, negotiated changes summary, and the parties involved in the renewal decision. Provides a complete renewal history for each agreement.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` (
    `compliance_obligation_id` BIGINT COMMENT 'Unique identifier for the compliance obligation record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or agreement that contains this compliance obligation.',
    `compliance_check_id` BIGINT COMMENT 'Foreign key linking to document.document_compliance_check. Business justification: Compliance obligations drive document compliance checks (CTPAT documentation requirements, AEO record-keeping, GDPR data retention). Business process: regulatory compliance verification through docume',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Compliance obligations require assigned employee contacts for execution, monitoring, escalation, and regulatory reporting in logistics operations. Contact person attributes denormalize employee data.',
    `corsia_compliance_record_id` BIGINT COMMENT 'Foreign key linking to sustainability.corsia_compliance_record. Business justification: Aviation contracts with CORSIA obligations require direct linkage to compliance records for regulatory verification, offsetting obligation tracking, and competent authority reporting. Mandatory for ai',
    `esg_disclosure_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_disclosure. Business justification: Contractual compliance obligations (e.g., annual carbon reporting, CDP disclosure) are fulfilled through formal ESG disclosures. Required for compliance verification, audit trail, and customer sustain',
    `program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Compliance obligations (OSHA, DOT, IATA DG regulations) require implementation of specific safety programs. Links obligation to implementing program for regulatory compliance tracking and audit trail.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Compliance obligations (AEO, C-TPAT, ISO certifications) apply to suppliers. Links obligations to supplier master for certification tracking, audit scheduling, qualification management, and regulatory',
    `audit_frequency` STRING COMMENT 'The frequency at which compliance audits must be conducted for this obligation (e.g., monthly, quarterly, semi-annually, annually, biannually, on-demand, not required). [ENUM-REF-CANDIDATE: monthly|quarterly|semi_annually|annually|biannually|on_demand|not_required — 7 candidates stripped; promote to reference product]',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether formal certification or accreditation is required to fulfill this compliance obligation (True/False).',
    `certification_type` STRING COMMENT 'The type of certification or accreditation required (e.g., AEO certification, C-TPAT Tier 2, ISO 28000, IATA CEIV Pharma).',
    `compliance_score` DECIMAL(18,2) COMMENT 'Quantitative score or rating representing the level of compliance with this obligation, typically expressed as a percentage (0.00 to 100.00).',
    `compliance_standard` STRING COMMENT 'The specific regulation, standard, or code that defines this obligation (e.g., ISO 28000, IMDG Code, ICAO Technical Instructions, C-TPAT guidelines, AEO criteria, GDPR Article 28).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this compliance obligation record was first created in the system.',
    `documentation_required` STRING COMMENT 'List or description of documentation that must be maintained or provided to demonstrate compliance with this obligation (e.g., certificates, declarations, audit reports, training records).',
    `effective_from_date` DATE COMMENT 'The date from which this compliance obligation becomes binding and enforceable under the contract.',
    `effective_until_date` DATE COMMENT 'The date on which this compliance obligation expires or is no longer enforceable. Nullable for obligations that remain in effect for the contract duration.',
    `escalation_procedure` STRING COMMENT 'Description of the escalation process to be followed in case of non-compliance or dispute regarding this obligation.',
    `governing_body` STRING COMMENT 'The regulatory authority or standards organization that mandates this compliance obligation (e.g., IMO, IATA, WCO, FMC, DOT, ICAO, WTO, ISO, GDPR, SOX, C-TPAT, AEO, EU ETS, CORSIA, IFRS). [ENUM-REF-CANDIDATE: IMO|IATA|WCO|FMC|DOT|ICAO|WTO|ISO|GDPR|SOX|C-TPAT|AEO|EU_ETS|CORSIA|IFRS — 15 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this compliance obligation record was last updated or modified.',
    `last_verification_date` DATE COMMENT 'The date on which compliance with this obligation was last verified or audited.',
    `next_verification_due_date` DATE COMMENT 'The date by which the next compliance verification or audit is due.',
    `non_compliance_count` STRING COMMENT 'The cumulative number of non-compliance incidents or violations recorded for this obligation during the contract period.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or clarifications regarding this compliance obligation.',
    `obligation_code` STRING COMMENT 'Business identifier code for the compliance obligation, used for external reference and reporting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `obligation_description` STRING COMMENT 'Detailed narrative description of the compliance obligation, including specific requirements, actions, and deliverables.',
    `obligation_status` STRING COMMENT 'Current lifecycle status of the compliance obligation within the contract term.. Valid values are `active|pending|suspended|fulfilled|expired|waived`',
    `obligation_title` STRING COMMENT 'Short descriptive title of the compliance obligation for identification and reporting purposes.',
    `obligation_type` STRING COMMENT 'Classification of the compliance obligation by regulatory domain (e.g., customs compliance, trade security, dangerous goods handling, data protection, environmental, financial reporting).. Valid values are `customs_compliance|trade_security|dangerous_goods|data_protection|environmental|financial_reporting`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount for non-compliance, if specified as a fixed value in the contract. Nullable if penalty is percentage-based or non-monetary.',
    `penalty_clause` STRING COMMENT 'Description of penalties, fines, or consequences for non-compliance with this obligation as defined in the contract.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `reporting_frequency` STRING COMMENT 'The frequency at which compliance reporting must be submitted (e.g., per shipment, daily, weekly, monthly, quarterly, annually, on incident, not required). [ENUM-REF-CANDIDATE: per_shipment|daily|weekly|monthly|quarterly|annually|on_incident|not_required — 8 candidates stripped; promote to reference product]',
    `reporting_requirement` STRING COMMENT 'Description of any periodic or event-driven reporting obligations related to this compliance requirement (e.g., monthly compliance reports, incident notifications, audit findings).',
    `responsible_party` STRING COMMENT 'The party designated as responsible for fulfilling this compliance obligation under the contract (e.g., shipper, carrier, consignee, customs broker, freight forwarder, 3PL, 4PL, Transport Shipping, joint responsibility). [ENUM-REF-CANDIDATE: shipper|carrier|consignee|customs_broker|freight_forwarder|3pl|4pl|transport_shipping|joint — 9 candidates stripped; promote to reference product]',
    `training_description` STRING COMMENT 'Description of the training requirements, including topics, certification levels, and recertification intervals (e.g., IATA DGR Category 6, IMO dangerous goods handling, C-TPAT security awareness).',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether personnel training is required to fulfill this compliance obligation (True/False).',
    `verification_frequency` STRING COMMENT 'The frequency at which compliance verification must be performed (e.g., per shipment, daily, weekly, monthly, quarterly, annually, on-demand, continuous monitoring). [ENUM-REF-CANDIDATE: per_shipment|daily|weekly|monthly|quarterly|annually|on_demand|continuous — 8 candidates stripped; promote to reference product]',
    `verification_method` STRING COMMENT 'The method by which compliance with this obligation is verified and validated (e.g., audit, certification, inspection, documentation review, system validation, third-party assessment).. Valid values are `audit|certification|inspection|documentation_review|system_validation|third_party_assessment`',
    `waiver_expiry_date` DATE COMMENT 'The date on which the granted waiver or exemption expires and the obligation becomes enforceable again.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Indicates whether a waiver or exemption has been granted for this compliance obligation (True/False).',
    `waiver_reason` STRING COMMENT 'Explanation or justification for granting a waiver or exemption from this compliance obligation.',
    CONSTRAINT pk_compliance_obligation PRIMARY KEY(`compliance_obligation_id`)
) COMMENT 'Defines regulatory and trade compliance obligations embedded within a contract, including C-TPAT requirements, AEO compliance clauses, IATA/IMO dangerous goods handling obligations, customs brokerage responsibilities, ISF filing obligations, and GDPR data handling clauses. Captures obligation type, governing body (WCO, IATA, IMO, DOT), compliance standard, responsible party, and verification method.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`compliance_review` (
    `compliance_review_id` BIGINT COMMENT 'Unique identifier for the compliance review record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the contract or agreement being reviewed for compliance.',
    `compliance_check_id` BIGINT COMMENT 'Foreign key linking to document.document_compliance_check. Business justification: Compliance reviews examine document compliance check results (audit of document validation processes, review of compliance check findings). Business process: audit trail from compliance review to spec',
    `compliance_obligation_id` BIGINT COMMENT 'Reference to the specific compliance obligation being assessed in this review.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or auditor who conducted the compliance review.',
    `ghg_inventory_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_inventory. Business justification: Compliance reviews of contractual sustainability obligations verify against annual GHG inventory submissions for accuracy, completeness, and methodology compliance. Required for third-party assurance ',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Compliance reviews assess supplier adherence to regulatory and contractual standards. Links reviews to supplier master for audit trail, qualification status updates, corrective action tracking, and su',
    `approval_date` DATE COMMENT 'Date on which the compliance review findings were formally approved.',
    `approval_required` BOOLEAN COMMENT 'Flag indicating whether the compliance review findings require formal approval before closure.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved the compliance review findings and corrective actions.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this compliance review to the broader audit trail or compliance management system for traceability.',
    `compliance_finding` STRING COMMENT 'Overall outcome of the compliance review indicating whether the obligation was met, not met, or partially met.. Valid values are `compliant|non_compliant|partially_compliant|not_applicable|pending_verification`',
    `corrective_action_deadline` DATE COMMENT 'Target date by which corrective actions must be completed to remediate non-compliance.',
    `corrective_action_description` STRING COMMENT 'Description of the corrective actions required to remediate non-compliance findings and achieve compliance.',
    `corrective_action_owner` STRING COMMENT 'Name or identifier of the individual or department responsible for implementing corrective actions.',
    `corrective_action_required` BOOLEAN COMMENT 'Flag indicating whether corrective action is required to address non-compliance findings.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action implementation and verification process.. Valid values are `not_started|in_progress|completed|overdue|verified`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance review record was first created in the system.',
    `escalation_date` DATE COMMENT 'Date on which the compliance finding was escalated to higher authority or management.',
    `escalation_recipient` STRING COMMENT 'Name or role of the individual or department to whom the compliance finding was escalated.',
    `escalation_required` BOOLEAN COMMENT 'Flag indicating whether the compliance finding requires escalation to senior management or regulatory authorities.',
    `evidence_reference` STRING COMMENT 'Reference to supporting documentation, records, or evidence collected during the compliance review.',
    `finding_description` STRING COMMENT 'Detailed narrative description of the compliance finding, including evidence, observations, and specific non-compliance details.',
    `finding_severity` STRING COMMENT 'Severity classification of non-compliance findings, indicating the level of risk or impact to the business.. Valid values are `critical|major|minor|observation`',
    `follow_up_date` DATE COMMENT 'Scheduled date for follow-up review to verify that corrective actions have been implemented and are effective.',
    `follow_up_required` BOOLEAN COMMENT 'Flag indicating whether a follow-up review is required to verify corrective action effectiveness.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance review record was last modified or updated.',
    `notification_date` DATE COMMENT 'Date on which notification of the compliance review findings was sent to stakeholders.',
    `notification_sent` BOOLEAN COMMENT 'Flag indicating whether notification of the compliance review findings has been sent to relevant stakeholders.',
    `regulatory_framework` STRING COMMENT 'The regulatory or compliance framework under which this review was conducted, such as International Maritime Organization (IMO), International Air Transport Association (IATA), Customs-Trade Partnership Against Terrorism (C-TPAT), or Authorized Economic Operator (AEO).',
    `review_comments` STRING COMMENT 'Additional comments, observations, or notes provided by the reviewer regarding the compliance review.',
    `review_date` DATE COMMENT 'The date on which the compliance review was conducted or completed.',
    `review_number` STRING COMMENT 'Business identifier for the compliance review, formatted as CR-YYYYMMDD-NNNN for external reference and audit trail.. Valid values are `^CR-[0-9]{8}-[0-9]{4}$`',
    `review_outcome` STRING COMMENT 'Final outcome of the compliance review indicating whether the overall compliance assessment was successful or requires further action.. Valid values are `passed|failed|conditional_pass|deferred`',
    `review_scope` STRING COMMENT 'Description of the scope and boundaries of the compliance review, including specific obligations, clauses, or operational areas assessed.',
    `review_status` STRING COMMENT 'Current lifecycle status of the compliance review process.. Valid values are `scheduled|in_progress|completed|cancelled|deferred`',
    `review_type` STRING COMMENT 'Classification of the compliance review based on its trigger or scheduling pattern.. Valid values are `scheduled|ad_hoc|triggered|annual|quarterly|incident_driven`',
    `reviewer_name` STRING COMMENT 'Full name of the individual who conducted the compliance review for audit trail purposes.',
    `reviewer_role` STRING COMMENT 'Job title or functional role of the reviewer conducting the compliance assessment.',
    `risk_rating` STRING COMMENT 'Risk level associated with the compliance finding, indicating potential business impact if not remediated.. Valid values are `low|medium|high|critical`',
    `scheduled_date` DATE COMMENT 'The originally planned date for the compliance review to be conducted.',
    CONSTRAINT pk_compliance_review PRIMARY KEY(`compliance_review_id`)
) COMMENT 'Transactional record of periodic compliance reviews conducted against contractual compliance obligations. Captures review date, reviewer identity, obligations assessed, findings (compliant, non-compliant, partially compliant), corrective action required, corrective action deadline, and review outcome. Supports regulatory audit readiness and contract compliance reporting.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` (
    `carrier_agreement_id` BIGINT COMMENT 'Unique identifier for the carrier agreement. Primary key. Role: MASTER_AGREEMENT.',
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: Carrier agreements often involve agents as intermediaries for specific territories in global logistics. Operations and finance teams need agent attribution for commission calculation, territory manage',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Carrier agreement execution requires employee signatory tracking for legal validity, authorization verification, and audit compliance in logistics procurement. The authorized_signatory string denormal',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier party with whom this agreement is established.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Carrier costs are allocated to cost centers for operational cost tracking, budget vs actual analysis, and cost management. Essential for transportation cost accounting in logistics.',
    `driver_safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.driver_safety_program. Business justification: Carrier contracts mandate driver safety standards (telematics monitoring, training requirements). Links carrier agreement to required driver safety program for performance evaluation against contracte',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Carriers often act as suppliers for fuel, equipment, or services beyond transport. Links carrier agreements to supplier master for procurement tracking, payment terms reconciliation, and consolidated ',
    `agreement_name` STRING COMMENT 'Descriptive name or title of the carrier agreement for easy identification.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the carrier agreement, used in communications and documentation.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the carrier agreement (draft, pending approval, active, suspended, terminated, expired, renewed). [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|terminated|expired|renewed — 7 candidates stripped; promote to reference product]',
    `agreement_tier` STRING COMMENT 'Classification of the carrier agreement tier indicating priority and relationship level (preferred, approved, spot, strategic, tactical, backup).. Valid values are `preferred|approved|spot|strategic|tactical|backup`',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the carrier agreement automatically renews upon expiration unless terminated.',
    `carrier_type` STRING COMMENT 'Mode of transport provided by the carrier under this agreement (ocean, air, road, rail, multimodal, courier).. Valid values are `ocean|air|road|rail|multimodal|courier`',
    `compliance_certification_required` BOOLEAN COMMENT 'Indicates whether the carrier must maintain compliance certifications such as C-TPAT, AEO, ISO 28000 under this agreement.',
    `contract_term_months` STRING COMMENT 'Duration of the carrier agreement in months from effective date to expiration.',
    `contracted_capacity_cbm` DECIMAL(18,2) COMMENT 'Committed volumetric capacity in cubic meters (CBM) for freight under this agreement.',
    `contracted_capacity_kg` DECIMAL(18,2) COMMENT 'Committed weight capacity in kilograms for air or road freight under this agreement.',
    `contracted_capacity_teu` DECIMAL(18,2) COMMENT 'Committed container capacity in Twenty-foot Equivalent Units (TEU) for ocean freight under this agreement.',
    `counterparty_execution_date` DATE COMMENT 'Date when the carrier agreement was formally executed and signed by the carrier.',
    `counterparty_signatory` STRING COMMENT 'Name of the authorized signatory who executed the carrier agreement on behalf of the carrier.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the carrier agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all financial transactions under this carrier agreement.. Valid values are `^[A-Z]{3}$`',
    `document_reference` STRING COMMENT 'Reference identifier or file path to the physical or digital contract document for this carrier agreement.',
    `edi_connectivity_required` BOOLEAN COMMENT 'Indicates whether Electronic Data Interchange (EDI) connectivity is required for shipment booking and tracking under this agreement.',
    `edi_standard` STRING COMMENT 'EDI standard or protocol used for electronic communication with the carrier (EDIFACT, ANSI X12, XML, API, proprietary).. Valid values are `EDIFACT|ANSI_X12|XML|API|proprietary`',
    `effective_date` DATE COMMENT 'Date when the carrier agreement becomes binding and operational.',
    `execution_date` DATE COMMENT 'Date when the carrier agreement was formally executed and signed by the shipper.',
    `expiration_date` DATE COMMENT 'Date when the carrier agreement ends or is scheduled for renewal. Nullable for open-ended agreements.',
    `fuel_surcharge_applicable` BOOLEAN COMMENT 'Indicates whether Bunker Adjustment Factor (BAF) or fuel surcharge is applicable under this agreement.',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Monetary incentive amount or percentage awarded for exceeding SLA targets or performance thresholds.',
    `incentive_clause_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes incentive clauses for exceeding performance targets.',
    `incoterms` STRING COMMENT 'Standard Incoterms governing the transfer of risk and cost responsibility between shipper and carrier (EXW, FCA, CPT, CIP, DAP, DPU, DDP, FAS, FOB, CFR, CIF). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `insurance_required_flag` BOOLEAN COMMENT 'Indicates whether cargo insurance is required under the terms of this carrier agreement.',
    `liability_limit_amount` DECIMAL(18,2) COMMENT 'Maximum liability amount the carrier assumes for loss or damage to cargo under this agreement.',
    `liability_limit_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the liability limit amount.. Valid values are `^[A-Z]{3}$`',
    `minimum_volume_commitment` DECIMAL(18,2) COMMENT 'Minimum shipment volume or weight the shipper commits to tender to the carrier during the agreement period.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the carrier agreement record was last modified in the system.',
    `nvocc_flag` BOOLEAN COMMENT 'Indicates whether the carrier is a Non-Vessel Operating Common Carrier (NVOCC) rather than a direct vessel operator.',
    `payment_term_days` STRING COMMENT 'Number of days allowed for payment of carrier invoices under the agreement terms (e.g., Net 30, Net 60).',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount or percentage applied for SLA breaches or non-compliance with agreement terms.',
    `penalty_clause_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes penalty clauses for non-performance or SLA breaches.',
    `rate_validity_end_date` DATE COMMENT 'End date for the validity period of contracted rates, after which rates may be renegotiated.',
    `rate_validity_start_date` DATE COMMENT 'Start date for the validity period of contracted rates under this carrier agreement.',
    `renewal_notice_days` STRING COMMENT 'Number of days advance notice required before expiration to trigger renewal or termination decision.',
    `sla_otd_target_percent` DECIMAL(18,2) COMMENT 'Target percentage for On-Time Delivery (OTD) performance committed by the carrier in the SLA.',
    `sla_otif_target_percent` DECIMAL(18,2) COMMENT 'Target percentage for On-Time In-Full (OTIF) delivery performance committed by the carrier in the SLA.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the carrier agreement.',
    `termination_reason` STRING COMMENT 'Reason for termination of the carrier agreement if status is terminated.',
    `volume_commitment_type` STRING COMMENT 'Type of volume commitment specified in the agreement (minimum, maximum, target, flexible).. Valid values are `minimum|maximum|target|flexible`',
    CONSTRAINT pk_carrier_agreement PRIMARY KEY(`carrier_agreement_id`)
) COMMENT 'Master record for carrier-specific agreements governing transport capacity procurement, including contracted lane allocations, space commitments, carrier performance standards, liability limits, and EDI connectivity requirements. Captures carrier type (ocean, air, road, rail), NVOCC or direct carrier flag, IATA/IMO carrier code, contracted capacity (TEU, kg, CBM), and agreement tier (preferred, approved, spot).';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` (
    `lane_commitment_id` BIGINT COMMENT 'Unique identifier for the lane commitment record within the carrier agreement. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent carrier agreement or contract under which this lane commitment is defined.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier or transportation service provider responsible for fulfilling this lane commitment.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Lane commitments drive cost allocations for specific trade lanes. Essential for lane profitability analysis, cost management, and operational cost tracking in logistics operations.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Lane commitment creation audit trails are required for capacity planning accountability, dispute resolution, and change tracking in logistics network management. The created_by string denormalizes emp',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Lane commitments specify contracted capacity/volume obligations for specific operational lanes. Critical for capacity allocation, booking management, and monitoring volume commitment compliance. Direc',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.network_partner. Business justification: Lane commitments can be fulfilled by 3PL partners or agents in addition to direct carriers. Capacity planning and fulfillment teams require partner attribution to track which entity is responsible for',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Lane commitments to customers are backed by capacity commitments from carriers via procurement contracts. Essential for capacity planning, commitment reconciliation, and ensuring customer commitments ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Lane commitments drive revenue and must be tracked to profit centers for segment reporting and lane P&L analysis. Critical for trade lane profitability management in logistics.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this lane commitment automatically renews at the end of the effective period.',
    `booking_lead_time_hours` STRING COMMENT 'Minimum advance notice in hours required to book capacity on this lane.',
    `capacity_commitment_quantity` DECIMAL(18,2) COMMENT 'Contracted capacity allocation for the lane per commitment period (e.g., weekly or monthly volume).',
    `capacity_unit` STRING COMMENT 'Unit of measure for the capacity commitment (TEU, FEU, kg, ton, CBM, pallet, truckload, flight). [ENUM-REF-CANDIDATE: TEU|FEU|kg|ton|cbm|pallet|truckload|flight — 8 candidates stripped; promote to reference product]',
    `commitment_period` STRING COMMENT 'Frequency or period over which the capacity commitment is measured (weekly, monthly, quarterly, annual).. Valid values are `weekly|monthly|quarterly|annual`',
    `commitment_status` STRING COMMENT 'Current lifecycle status of the lane commitment (draft, active, suspended, expired, terminated).. Valid values are `draft|active|suspended|expired|terminated`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this lane commitment record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the contracted rate (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_from_date` DATE COMMENT 'Start date from which this lane commitment becomes active and binding.',
    `effective_to_date` DATE COMMENT 'End date after which this lane commitment is no longer active. Null indicates open-ended commitment.',
    `equipment_type` STRING COMMENT 'Specific equipment or container type required for this lane (e.g., 20ft dry, 40ft reefer, flatbed, box truck).',
    `exclusion_conditions` STRING COMMENT 'Specific conditions, cargo types, or circumstances excluded from this lane commitment (e.g., hazardous materials, oversized cargo, peak season surcharges).',
    `geographic_scope` STRING COMMENT 'Geographic coverage or regional scope of the lane commitment (e.g., specific countries, trade lanes, or regions covered).',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Financial incentive or rebate amount per unit for exceeding the committed volume threshold.',
    `incentive_clause_flag` BOOLEAN COMMENT 'Indicates whether incentives or rebates apply for exceeding volume commitments on this lane.',
    `incentive_threshold_quantity` DECIMAL(18,2) COMMENT 'Volume threshold that must be exceeded to trigger incentive payments or rebates.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this lane commitment record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this lane commitment record was last updated in the system.',
    `maximum_booking_quantity` DECIMAL(18,2) COMMENT 'Maximum volume that can be booked per commitment period under this lane commitment.',
    `minimum_booking_quantity` DECIMAL(18,2) COMMENT 'Minimum volume that must be booked per commitment period to meet contractual obligations and avoid penalties.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or special instructions related to this lane commitment.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Financial penalty amount charged per unit shortfall if minimum booking quantity is not met.',
    `penalty_clause_flag` BOOLEAN COMMENT 'Indicates whether penalties apply for failing to meet minimum booking obligations on this lane.',
    `priority_level` STRING COMMENT 'Priority ranking of this lane commitment for capacity allocation and booking preference (high, medium, low, standard).. Valid values are `high|medium|low|standard`',
    `rate_per_unit` DECIMAL(18,2) COMMENT 'Contracted rate per capacity unit for this lane (e.g., cost per TEU, per kg, per truckload).',
    `renewal_notice_days` STRING COMMENT 'Number of days advance notice required before the effective_to_date to trigger or prevent auto-renewal.',
    `rollover_allowed_flag` BOOLEAN COMMENT 'Indicates whether unused capacity from one period can be rolled over to the next commitment period.',
    `rollover_expiry_periods` STRING COMMENT 'Number of commitment periods after which rolled-over capacity expires if not utilized.',
    `rollover_limit_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity of unused capacity that can be rolled over to the next period, if rollover is allowed.',
    `route_code` STRING COMMENT 'Service string or route identifier that defines the specific path, vessel string, flight number pattern, or truck route for this lane.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `service_type` STRING COMMENT 'Service level or product type for the lane (express, standard, economy, dedicated, LTL, FTL, FCL, LCL). [ENUM-REF-CANDIDATE: express|standard|economy|dedicated|LTL|FTL|FCL|LCL — 8 candidates stripped; promote to reference product]',
    `transit_time_days` STRING COMMENT 'Standard transit time in days for shipments on this lane from origin to destination.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation for this lane (air, ocean, road, rail, intermodal, parcel).. Valid values are `air|ocean|road|rail|intermodal|parcel`',
    CONSTRAINT pk_lane_commitment PRIMARY KEY(`lane_commitment_id`)
) COMMENT 'Defines contracted lane-level capacity commitments within a carrier agreement, specifying origin-destination pairs, transport mode, weekly or monthly capacity allocation (TEU, kg, flights, truck loads), minimum booking obligations, and rollover provisions. Captures lane code, origin port/hub, destination port/hub, service string or route code, and capacity unit.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` (
    `partnership_agreement_id` BIGINT COMMENT 'Primary key for partnership_agreement',
    `contractor_safety_prequal_id` BIGINT COMMENT 'Foreign key linking to safety.contractor_safety_prequal. Business justification: 3PL partnership agreements require safety prequalification before contract execution. Links partnership to the prequalification record for onboarding compliance verification and ongoing safety perform',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: 3PL partnership creation audit trails are mandatory for procurement accountability, vendor management, and governance tracking in logistics operations. The created_by string denormalizes employee iden',
    `partner_id` BIGINT COMMENT 'Reference to the 3PL or 4PL partner organization providing logistics services under this agreement.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: 3PL partnerships are supplier relationships requiring procurement management. Links partnership agreements to supplier master for performance tracking, payment processing, compliance monitoring, and c',
    `aeo_certified` BOOLEAN COMMENT 'Indicates whether the partner holds valid AEO certification recognized by customs authorities for trusted trader status.',
    `agreement_name` STRING COMMENT 'Human-readable name or title of the partnership agreement for identification and reference purposes.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the partnership agreement, used in communications and documentation.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the partnership agreement indicating its operational state and validity. [ENUM-REF-CANDIDATE: Draft|Pending Approval|Active|Suspended|Terminated|Expired|Under Review|Renewal Pending — 8 candidates stripped; promote to reference product]',
    `api_integration_required` BOOLEAN COMMENT 'Indicates whether real-time API integration is required for data exchange, tracking, and system interoperability.',
    `authorized_signatory` STRING COMMENT 'Name and title of the authorized signatory from Transport Shipping who executed this partnership agreement.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the partnership agreement automatically renews upon expiration unless either party provides termination notice.',
    `carbon_reporting_required` BOOLEAN COMMENT 'Indicates whether the partner must provide regular reporting on carbon emissions and environmental impact of logistics operations under this agreement.',
    `compliance_certifications_required` STRING COMMENT 'Comma-separated list of required compliance certifications and authorizations: C-TPAT (Customs-Trade Partnership Against Terrorism), AEO (Authorized Economic Operator), ISO 9001, ISO 28000, IATA certification, customs broker license, or other regulatory credentials.',
    `confidentiality_clause_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes confidentiality and non-disclosure provisions protecting proprietary business information, customer data, and operational details.',
    `contract_term_months` STRING COMMENT 'Duration of the partnership agreement in months from effective date to expiration date.',
    `covered_countries` STRING COMMENT 'Comma-separated list of ISO 3-letter country codes where the partner is authorized to provide services under this agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this partnership agreement record was first created in the system for audit trail purposes.',
    `ctpat_certified` BOOLEAN COMMENT 'Indicates whether the partner holds valid C-TPAT certification for enhanced supply chain security and expedited customs processing.',
    `data_protection_compliance_required` BOOLEAN COMMENT 'Indicates whether the partner must comply with data protection regulations including General Data Protection Regulation (GDPR), California Consumer Privacy Act (CCPA), and other privacy laws for handling customer and shipment data.',
    `document_reference` STRING COMMENT 'Reference identifier or file path to the signed partnership agreement document stored in the document management system.',
    `edi_integration_required` BOOLEAN COMMENT 'Indicates whether Electronic Data Interchange connectivity is required for automated document exchange including Advanced Shipping Notices (ASN), invoices, and status updates.',
    `effective_date` DATE COMMENT 'Date when the partnership agreement becomes legally binding and operational services commence.',
    `escalation_contact_email` STRING COMMENT 'Email address of the escalation contact for critical issues requiring senior management attention.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `escalation_contact_name` STRING COMMENT 'Name of the escalation contact person at the partner organization for critical issues and executive-level communications.',
    `expiration_date` DATE COMMENT 'Date when the partnership agreement terminates or requires renewal. Nullable for open-ended agreements.',
    `geographic_coverage` STRING COMMENT 'Description of geographic regions, countries, or territories covered by this partnership agreement. May include specific trade lanes, ports, or distribution zones.',
    `governance_model` STRING COMMENT 'Framework defining how the partnership is managed, including decision-making authority, escalation procedures, performance reviews, and relationship management structure.. Valid values are `Collaborative|Managed Service|Integrated|Transactional|Strategic Partnership`',
    `incentive_clause_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes incentive or bonus clauses for exceeding performance targets or achieving operational excellence.',
    `insurance_requirements` STRING COMMENT 'Description of required insurance coverage including cargo insurance, liability insurance, workers compensation, and minimum coverage amounts that the partner must maintain.',
    `liability_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for liability limit amounts and financial terms.. Valid values are `^[A-Z]{3}$`',
    `liability_limit_amount` DECIMAL(18,2) COMMENT 'Maximum financial liability amount that the partner is responsible for in case of service failures, cargo loss, or damage incidents.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this partnership agreement record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this partnership agreement record was last updated in the system for audit trail and change tracking purposes.',
    `notes` STRING COMMENT 'Additional notes, comments, or special conditions related to this partnership agreement for internal reference and context.',
    `operational_kpi_commitments` STRING COMMENT 'Summary of key performance indicators and service level commitments including On-Time Delivery (OTD), On-Time In-Full (OTIF), order accuracy, damage rates, and other operational metrics.',
    `otd_target_percentage` DECIMAL(18,2) COMMENT 'Target percentage for on-time delivery performance that the partner must achieve, typically 95-99%.',
    `otif_target_percentage` DECIMAL(18,2) COMMENT 'Target percentage for on-time and in-full delivery performance combining timeliness and completeness metrics.',
    `partner_signatory` STRING COMMENT 'Name and title of the authorized signatory from the partner organization who executed this partnership agreement.',
    `partnership_tier` STRING COMMENT 'Classification of the partnership model: 3PL (Third-Party Logistics provider managing specific operations), 4PL (Fourth-Party Logistics provider managing entire supply chain), 2PL (asset-based carrier), Lead Logistics Provider, or Specialized Service Provider.. Valid values are `3PL|4PL|2PL|Lead Logistics Provider|Specialized Service Provider`',
    `penalty_clause_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes penalty clauses for failure to meet Service Level Agreement (SLA) commitments or KPI targets.',
    `performance_review_frequency` STRING COMMENT 'Frequency at which formal performance reviews and business reviews are conducted to assess KPI achievement and partnership health.. Valid values are `Weekly|Monthly|Quarterly|Semi-Annual|Annual`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact person for operational communications and escalations.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary contact person at the partner organization responsible for managing this partnership agreement.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary contact person for urgent communications and operational coordination.',
    `renewal_notice_days` STRING COMMENT 'Number of days advance notice required before expiration date to prevent automatic renewal or to initiate renewal negotiations.',
    `service_categories` STRING COMMENT 'Comma-separated list of service categories provided: warehousing, distribution, last-mile delivery, customs brokerage, freight forwarding, cross-docking, value-added services, returns management, inventory management, order fulfillment.',
    `service_scope` STRING COMMENT 'Comprehensive description of the logistics services covered under this partnership, including warehouse operations, last-mile delivery, customs brokerage, freight forwarding, supply chain management, and other specialized services.',
    `signed_date` DATE COMMENT 'Date when the partnership agreement was formally signed by authorized representatives of both parties.',
    `sustainability_commitments` STRING COMMENT 'Description of environmental and sustainability commitments including Greenhouse Gas (GHG) emissions reduction targets, Carbon Dioxide Equivalent (CO2e) reporting, use of alternative fuels, and participation in carbon offset programs.',
    `technology_integration_requirements` STRING COMMENT 'Description of required technology integrations including Warehouse Management System (WMS), Transportation Management System (TMS), Electronic Data Interchange (EDI), Application Programming Interface (API) connections, and real-time visibility platforms.',
    `termination_for_cause_allowed` BOOLEAN COMMENT 'Indicates whether the agreement permits immediate termination for cause due to material breach, regulatory violations, or failure to meet critical SLA commitments.',
    `termination_notice_days` STRING COMMENT 'Number of days advance written notice required by either party to terminate the partnership agreement for convenience.',
    `tms_integration_required` BOOLEAN COMMENT 'Indicates whether integration with the partners Transportation Management System is required for shipment tracking and freight management.',
    `transition_support_days` STRING COMMENT 'Number of days the partner must provide transition support and knowledge transfer upon agreement termination to ensure smooth handover to alternative providers.',
    `volume_commitment_max` DECIMAL(18,2) COMMENT 'Maximum volume capacity that the partner commits to handle under this agreement without requiring renegotiation or capacity expansion.',
    `volume_commitment_min` DECIMAL(18,2) COMMENT 'Minimum volume of shipments, orders, or units that must be processed through the partner to maintain agreement terms and pricing.',
    `volume_unit` STRING COMMENT 'Unit of measure for volume commitments: shipments, orders, Twenty-foot Equivalent Units (TEU), pallets, Cubic Meters (CBM), weight, or item units. [ENUM-REF-CANDIDATE: Shipments|Orders|TEU|Pallets|CBM|Kilograms|Pounds|Units — 8 candidates stripped; promote to reference product]',
    `wms_integration_required` BOOLEAN COMMENT 'Indicates whether integration with the partners Warehouse Management System is required for inventory visibility and order management.',
    CONSTRAINT pk_partnership_agreement PRIMARY KEY(`partnership_agreement_id`)
) COMMENT 'Master record for 3PL and 4PL partnership agreements governing outsourced logistics operations, including warehouse operations, last-mile delivery, customs brokerage, and supply chain management services. Captures partnership tier (3PL, 4PL), service scope, geographic coverage, operational KPIs, technology integration requirements (WMS, TMS, EDI, API), and governance model.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`service_scope` (
    `service_scope_id` BIGINT COMMENT 'Unique identifier for the service scope record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or agreement under which this service scope is defined.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Service scope defines carrier-provided services under an agreement (customs clearance, insurance, temperature control). Operations teams need direct carrier linkage for service capability validation, ',
    `commodity_rate_class_id` BIGINT COMMENT 'Foreign key linking to pricing.commodity_rate_class. Business justification: Contract pricing teams reference standard commodity classifications when defining service scope restrictions for hazmat handling, special equipment requirements, and rate class validation in multi-com',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Service scope definitions drive cost allocations for different service types. Essential for service line costing, profitability analysis, and operational cost management in logistics.',
    `dim_weight_rule_id` BIGINT COMMENT 'Foreign key linking to pricing.dim_weight_rule. Business justification: Contract operations teams specify which dimensional weight rules apply to each service scope within multi-service agreements to ensure consistent chargeable weight calculations across different servic',
    `emissions_factor_id` BIGINT COMMENT 'Foreign key linking to sustainability.emissions_factor. Business justification: Service scope definitions (mode, route, equipment type) determine applicable emission factors for carbon calculation methodology and green product pricing. Essential for consistent carbon accounting a',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.network_partner. Business justification: Service scopes also define 3PL/partner capabilities in multi-party logistics models. Operations teams require partner attribution for service capability validation, partner selection, and performance ',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Service scope definitions reference procurement contracts that enable service delivery (carrier contracts, warehouse agreements). Essential for service feasibility validation, cost allocation, and ens',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Service scope drives revenue recognition by profit center for segment reporting and service line P&L. Critical for service line profitability analysis and management reporting in logistics.',
    `cod_allowed_flag` BOOLEAN COMMENT 'Indicates whether cash on delivery (COD) payment collection is allowed under this service scope.',
    `compliance_program` STRING COMMENT 'Applicable compliance or certification program for this service scope (e.g., C-TPAT, AEO, ISO 28000, TAPA).',
    `container_type` STRING COMMENT 'Container load type for ocean freight services: Full Container Load (FCL), Less than Container Load (LCL), or not applicable for non-containerized services.. Valid values are `fcl|lcl|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service scope record was first created in the system.',
    `customs_clearance_included_flag` BOOLEAN COMMENT 'Indicates whether customs brokerage and clearance services are included in this service scope.',
    `dangerous_goods_flag` BOOLEAN COMMENT 'Indicates whether this service scope includes handling of dangerous goods (DG) or hazardous materials (HAZMAT).',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the destination geography covered by this service scope.. Valid values are `^[A-Z]{3}$`',
    `destination_region` STRING COMMENT 'Geographic region or trade lane destination (e.g., North America, Europe, Asia-Pacific, Middle East).',
    `dimension_limit_cbm` DECIMAL(18,2) COMMENT 'Maximum dimensional limit per shipment or unit under this service scope, measured in cubic meters (CBM).',
    `effective_from_date` DATE COMMENT 'Date from which this service scope becomes effective and operational under the contract.',
    `effective_to_date` DATE COMMENT 'Date until which this service scope remains effective under the contract. Null indicates open-ended scope.',
    `epod_required_flag` BOOLEAN COMMENT 'Indicates whether electronic proof of delivery (ePOD) is required for this service scope.',
    `freight_type` STRING COMMENT 'Freight load type for road/rail services: Full Truckload (FTL), Less than Truckload (LTL), or not applicable for non-trucking services.. Valid values are `ftl|ltl|not_applicable`',
    `geographic_scope` STRING COMMENT 'Geographic coverage of the service (global, regional, domestic, international, cross-border).. Valid values are `global|regional|domestic|international|cross_border`',
    `incoterm` STRING COMMENT 'Applicable Incoterms rule governing the transfer of risk and responsibility between buyer and seller (EXW, FCA, CPT, CIP, DAP, DPU, DDP, FAS, FOB, CFR, CIF). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `insurance_included_flag` BOOLEAN COMMENT 'Indicates whether cargo insurance is included in this service scope.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service scope record was last modified or updated.',
    `notes` STRING COMMENT 'Additional notes, comments, or clarifications regarding this service scope.',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the origin geography covered by this service scope.. Valid values are `^[A-Z]{3}$`',
    `origin_region` STRING COMMENT 'Geographic region or trade lane origin (e.g., North America, Europe, Asia-Pacific, Middle East).',
    `packaging_included_flag` BOOLEAN COMMENT 'Indicates whether packaging, crating, or palletization services are included in this service scope.',
    `service_code` STRING COMMENT 'Standardized code identifying the specific logistics service (e.g., EXPRESS_PARCEL, AIR_FREIGHT, OCEAN_FCL, ROAD_FTL, CUSTOMS_BROKERAGE, WAREHOUSING, LAST_MILE, ECOM_FULFILLMENT).. Valid values are `^[A-Z0-9]{3,10}$`',
    `service_description` STRING COMMENT 'Detailed description of the service, including operational characteristics, handling requirements, and service-specific terms.',
    `service_exclusions` STRING COMMENT 'Specific exclusions, restrictions, or limitations applicable to this service scope (e.g., prohibited commodities, excluded geographies, restricted handling).',
    `service_line` STRING COMMENT 'High-level categorization of the service into major logistics service lines (express parcel, air freight, ocean freight, road freight, rail freight, customs brokerage, warehousing, last mile). [ENUM-REF-CANDIDATE: express_parcel|air_freight|ocean_freight|road_freight|rail_freight|customs_brokerage|warehousing|last_mile — 8 candidates stripped; promote to reference product]',
    `service_mode` STRING COMMENT 'Primary transportation mode used for this service (air, ocean, road, rail, multimodal, parcel, courier). [ENUM-REF-CANDIDATE: air|ocean|road|rail|multimodal|parcel|courier — 7 candidates stripped; promote to reference product]',
    `service_name` STRING COMMENT 'Human-readable name of the logistics service included in the contract scope (e.g., Express Parcel Delivery, Air Freight Forwarding, Ocean Full Container Load).',
    `service_scope_status` STRING COMMENT 'Current lifecycle status of this service scope (active, inactive, suspended, pending, expired).. Valid values are `active|inactive|suspended|pending|expired`',
    `service_tier` STRING COMMENT 'Service level tier indicating speed, priority, and handling quality (premium, standard, economy, basic).. Valid values are `premium|standard|economy|basic`',
    `service_type` STRING COMMENT 'Operational service type defining pickup and delivery scope (door-to-door, port-to-port, door-to-port, port-to-door, CFS-to-CFS, depot-to-depot).. Valid values are `door_to_door|port_to_port|door_to_port|port_to_door|cfs_to_cfs|depot_to_depot`',
    `special_handling_requirements` STRING COMMENT 'Any special handling, packaging, or operational requirements specific to this service scope.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this service scope includes temperature-controlled or refrigerated (reefer) handling.',
    `tracking_visibility_level` STRING COMMENT 'Level of shipment tracking and visibility provided under this service scope (real-time, milestone, basic, none).. Valid values are `real_time|milestone|basic|none`',
    `trade_lane` STRING COMMENT 'Specific trade lane or corridor covered by this service (e.g., Asia-Europe, Transpacific, Transatlantic).',
    `volume_commitment_max` DECIMAL(18,2) COMMENT 'Maximum volume commitment allowed under this service scope, measured in the unit specified by volume_unit.',
    `volume_commitment_min` DECIMAL(18,2) COMMENT 'Minimum volume commitment required under this service scope, measured in the unit specified by volume_unit.',
    `volume_unit` STRING COMMENT 'Unit of measure for volume commitments (TEU for containers, kg for weight, CBM for cubic meters, shipments for count, pallets for pallet count).. Valid values are `teu|kg|cbm|shipments|pallets`',
    `warehousing_included_flag` BOOLEAN COMMENT 'Indicates whether warehousing, storage, or distribution services are included in this service scope.',
    `weight_limit_kg` DECIMAL(18,2) COMMENT 'Maximum weight limit per shipment or unit under this service scope, measured in kilograms.',
    CONSTRAINT pk_service_scope PRIMARY KEY(`service_scope_id`)
) COMMENT 'Defines the specific logistics services and service lines included within a contract, such as express parcel delivery, air freight forwarding, ocean FCL/LCL, road FTL/LTL, customs brokerage, warehousing, last-mile delivery, and e-commerce fulfillment. Captures service code, service description, applicable geographies, service tier, and any service-specific terms or exclusions.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`contract_party` (
    `contract_party_id` BIGINT COMMENT 'Unique identifier for the contract party association record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or agreement to which this party is associated.',
    `trade_party_id` BIGINT COMMENT 'Reference to the master party entity (customer, carrier, vendor, broker, guarantor) participating in this contract.',
    `aeo_number` STRING COMMENT 'AEO certification number if the party holds Authorized Economic Operator status for customs facilitation.',
    `compliance_certification` STRING COMMENT 'Compliance certifications held by this party relevant to the contract (e.g., C-TPAT, AEO, ISO 28000, IATA certification).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract party association record was first created in the system (format: yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `ctpat_number` STRING COMMENT 'C-TPAT certification number if the party is certified under the U.S. Customs-Trade Partnership Against Terrorism program.',
    `customs_broker_license` STRING COMMENT 'Customs broker license number if the party is authorized to conduct customs clearance activities.',
    `edi_identifier` STRING COMMENT 'EDI identifier or interchange ID for electronic communication with this party (e.g., GS1 GLN, DUNS number).',
    `effective_from_date` DATE COMMENT 'The date from which this partys participation in the contract becomes effective (format: yyyy-MM-dd).',
    `effective_to_date` DATE COMMENT 'The date on which this partys participation in the contract ends or is scheduled to end (format: yyyy-MM-dd). Nullable for open-ended participation.',
    `guarantor_flag` BOOLEAN COMMENT 'Indicates whether this party serves as a guarantor for contract obligations (True/False).',
    `iata_code` STRING COMMENT 'IATA carrier or agent code if the party is an air carrier or freight forwarder registered with IATA.. Valid values are `^[A-Z0-9]{2,3}$`',
    `insurance_expiry_date` DATE COMMENT 'Expiration date of the insurance policy (format: yyyy-MM-dd).',
    `insurance_policy_number` STRING COMMENT 'Reference number of the insurance policy maintained by this party for contract obligations.',
    `insurance_required_flag` BOOLEAN COMMENT 'Indicates whether this party is required to maintain insurance coverage as a condition of the contract (True/False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract party association record was last updated (format: yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `legal_entity_name` STRING COMMENT 'The full legal name of the party as registered with governing authorities, used for contract execution and compliance.',
    `liability_cap_amount` DECIMAL(18,2) COMMENT 'Maximum liability amount for this party under the contract terms, if applicable.',
    `liability_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the liability cap amount.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Additional notes or comments regarding this partys role, responsibilities, or special conditions in the contract.',
    `notification_preference` STRING COMMENT 'Preferred method for contract-related notifications and communications (email, phone, postal mail, EDI, API).. Valid values are `email|phone|postal_mail|edi|api`',
    `nvocc_license_number` STRING COMMENT 'NVOCC license number issued by the Federal Maritime Commission if the party operates as a non-vessel operating common carrier.',
    `party_role` STRING COMMENT 'The role this party plays in the contract (e.g., shipper, carrier, 3PL provider, customs broker, guarantor, co-signatory). [ENUM-REF-CANDIDATE: shipper|consignee|carrier|freight_forwarder|customs_broker|guarantor|co_signatory|third_party_logistics_provider — 8 candidates stripped; promote to reference product]',
    `party_status` STRING COMMENT 'Current status of this partys participation in the contract (active, inactive, suspended, terminated).. Valid values are `active|inactive|suspended|terminated`',
    `party_type` STRING COMMENT 'Classification of the party entity (corporate, individual, government agency, non-profit, partnership).. Valid values are `corporate|individual|government|non_profit|partnership`',
    `payment_responsibility_flag` BOOLEAN COMMENT 'Indicates whether this party has payment responsibility under the contract (True/False). Relevant for identifying payers vs. service recipients.',
    `primary_contact_flag` BOOLEAN COMMENT 'Indicates whether this party is the primary contact for contract administration and communication (True/False).',
    `registration_jurisdiction` STRING COMMENT 'The country or jurisdiction where the party is legally registered (ISO 3166-1 alpha-3 country code).',
    `registration_number` STRING COMMENT 'Official business registration or incorporation number issued by the relevant jurisdiction (e.g., company registration number, tax ID, VAT number).',
    `scac_code` STRING COMMENT 'Standard Carrier Alpha Code for ocean and intermodal carriers, used for shipment identification and EDI transactions.. Valid values are `^[A-Z]{2,4}$`',
    `signatory_email` STRING COMMENT 'Email address of the authorized signatory for contract correspondence and notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `signatory_name` STRING COMMENT 'Full name of the individual authorized to sign the contract on behalf of this party.',
    `signatory_phone` STRING COMMENT 'Contact phone number of the authorized signatory.',
    `signatory_title` STRING COMMENT 'Job title or position of the authorized signatory (e.g., Chief Executive Officer, Director of Operations, Authorized Representative).',
    `signature_date` DATE COMMENT 'The date on which this party signed the contract (format: yyyy-MM-dd).',
    `signature_location` STRING COMMENT 'City and country where the contract was signed by this party.',
    `signature_method` STRING COMMENT 'The method by which the contract was signed (wet signature, electronic signature, digital signature, notarized).. Valid values are `wet_signature|electronic_signature|digital_signature|notarized`',
    `termination_date` DATE COMMENT 'Actual date on which this partys participation was terminated, if applicable (format: yyyy-MM-dd).',
    `termination_reason` STRING COMMENT 'Reason for termination of this partys participation (e.g., contract expiry, breach of terms, mutual agreement, business closure).',
    CONSTRAINT pk_contract_party PRIMARY KEY(`contract_party_id`)
) COMMENT 'Association entity capturing all parties to a contract, including the shipper/customer, carrier, 3PL partner, customs broker, and guarantor. Captures party role (buyer, seller, carrier, broker, guarantor, co-signatory), party type (corporate, individual), legal entity name, registration number, signatory name, signatory title, and date of signature. Supports multi-party contract structures.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` (
    `contract_dispute_id` BIGINT COMMENT 'Unique identifier for the contract dispute record. Primary key.',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Disputes relate to specific AR items and impact collections, aging, and write-off decisions. Essential for dispute resolution, credit management, and accurate AR reporting in logistics billing.',
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: Disputes can involve agents (commission disputes, territory conflicts, service failures on agent-managed lanes). Finance and legal teams need direct agent attribution for resolution workflows, commiss',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or agreement under which this dispute was raised.',
    `cargo_claim_id` BIGINT COMMENT 'Foreign key linking to claim.cargo_claim. Business justification: Contract disputes often arise from cargo claims—disagreement over liability, settlement amounts, or SLA breach determination. Natural bidirectional business relationship requiring linkage for dispute ',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Disputes frequently involve carrier performance failures (service level breaches, damage claims, billing errors). Legal and claims teams require direct carrier attribution for dispute categorization, ',
    `contract_sla_commitment_id` BIGINT COMMENT 'Reference to the specific SLA commitment that was allegedly breached, if the dispute is SLA-related.',
    `credit_note_id` BIGINT COMMENT 'Reference to the credit note issued as a result of the dispute resolution, if applicable.',
    `hse_incident_id` BIGINT COMMENT 'Foreign key linking to safety.hse_incident. Business justification: Contract disputes frequently arise from safety incidents affecting service quality or liability (cargo damage, injury claims, regulatory violations). Links dispute to incident for liability determinat',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice that is the subject of the dispute, if applicable (e.g., for invoice discrepancy disputes).',
    `employee_id` BIGINT COMMENT 'Reference to the internal user or dispute resolution specialist assigned to investigate and manage this dispute.',
    `contact_id` BIGINT COMMENT 'Reference to the specific contact person or representative who raised the dispute.',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment associated with the dispute, if applicable (e.g., for delivery delay or damage claims).',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Dispute resolutions trigger adjusting journal entries for revenue/expense corrections. Critical for financial close, audit trail, SOX compliance, and accurate financial statement preparation.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Disputes frequently involve transport documents as evidence (damaged goods claims reference BOL condition notes, delivery disputes reference POD timestamps, freight charge disputes reference rate conf',
    `assigned_date` DATE COMMENT 'The date when the dispute was assigned to a resolution specialist or team for investigation.',
    `closed_date` DATE COMMENT 'The date when the dispute record was formally closed in the system, marking the end of all administrative and follow-up activities.',
    `corrective_action_description` STRING COMMENT 'Description of the corrective actions, process improvements, or preventive measures implemented or planned as a result of the dispute investigation.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether corrective actions or process improvements are required to prevent recurrence of similar disputes.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the dispute record was first created in the system.',
    `credit_note_issued_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether a credit note was issued to the customer or counterparty as part of the dispute resolution.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the disputed amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customer_satisfaction_rating` STRING COMMENT 'Post-resolution satisfaction rating provided by the customer or raising party, typically on a scale (e.g., 1-5 or 1-10), used for service quality tracking.',
    `days_to_resolution` STRING COMMENT 'The number of calendar days elapsed from the dispute date to the resolution date, used for performance tracking and Service Level Agreement (SLA) compliance.',
    `dispute_date` DATE COMMENT 'The date on which the dispute was formally raised or logged in the system.',
    `dispute_description` STRING COMMENT 'Detailed narrative description of the dispute, including the nature of the disagreement, relevant facts, and context provided by the raising party.',
    `dispute_number` STRING COMMENT 'Business-facing unique identifier or reference number for the dispute, used in communications and tracking.',
    `dispute_status` STRING COMMENT 'Current lifecycle status of the dispute: open (newly raised), under review (being investigated), escalated (moved to higher authority), resolved (agreement reached), withdrawn (claimant withdrew), or closed (finalized).. Valid values are `open|under_review|escalated|resolved|withdrawn|closed`',
    `dispute_timestamp` TIMESTAMP COMMENT 'The precise date and time when the dispute was formally raised or logged in the system.',
    `dispute_type` STRING COMMENT 'Classification of the dispute by nature: rate disputes, Service Level Agreement (SLA) breach disputes, volume shortfall disputes, penalty disputes, invoice discrepancy disputes, service failure, delivery delay, damage claim, or other. [ENUM-REF-CANDIDATE: rate_dispute|sla_breach|volume_shortfall|penalty_dispute|invoice_discrepancy|service_failure|delivery_delay|damage_claim|other — 9 candidates stripped; promote to reference product]',
    `disputed_amount` DECIMAL(18,2) COMMENT 'The monetary value in dispute, representing the amount being contested by the raising party.',
    `escalation_date` DATE COMMENT 'The date when the dispute was escalated to a higher authority or management level.',
    `escalation_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the dispute has been escalated to senior management, legal, or executive level for resolution.',
    `escalation_reason` STRING COMMENT 'Explanation or justification for why the dispute was escalated, including factors such as complexity, high value, or failure to resolve at lower levels.',
    `financial_impact` DECIMAL(18,2) COMMENT 'The net financial impact to the organization resulting from the dispute resolution, including settlements, penalties, credits, or cost recoveries.',
    `governing_jurisdiction` STRING COMMENT 'The legal jurisdiction or governing law under which the dispute is being resolved, as specified in the contract or agreement.',
    `incoterm` STRING COMMENT 'The Incoterm applicable to the disputed shipment or transaction, defining the responsibilities and risk transfer between buyer and seller (e.g., Delivered Duty Paid (DDP), Delivered at Place (DAP), Free on Board (FOB), Cost Insurance and Freight (CIF), Ex Works (EXW)). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the dispute record was last updated or modified in the system.',
    `legal_case_reference` STRING COMMENT 'Reference number or identifier for any formal legal case, arbitration proceeding, or court filing associated with the dispute.',
    `legal_counsel_involved_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether legal counsel or attorneys were engaged in the dispute resolution process.',
    `penalty_waived_amount` DECIMAL(18,2) COMMENT 'The monetary value of penalties that were waived as part of the dispute resolution.',
    `penalty_waived_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether contractual penalties were waived as part of the dispute resolution or goodwill gesture.',
    `priority_level` STRING COMMENT 'Priority classification for the dispute resolution process, indicating urgency and resource allocation (low, medium, high, critical).. Valid values are `low|medium|high|critical`',
    `raised_by_party` STRING COMMENT 'The party that initiated the dispute: customer, carrier, vendor, internal (own organization), or Third-Party Logistics (3PL) / Fourth-Party Logistics (4PL) partner.. Valid values are `customer|carrier|vendor|internal|third_party_logistics`',
    `reason_code` STRING COMMENT 'Standardized code categorizing the root cause or reason for the dispute, used for analytics and trend analysis.',
    `resolution_date` DATE COMMENT 'The date when the dispute was formally resolved, either through agreement, arbitration decision, or withdrawal.',
    `resolution_method` STRING COMMENT 'The approach or mechanism used to resolve the dispute: negotiation (direct discussion), mediation (third-party facilitated), arbitration (binding third-party decision), litigation (court proceedings), internal review, or mutual agreement.. Valid values are `negotiation|mediation|arbitration|litigation|internal_review|mutual_agreement`',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the resolution process, decisions made, rationale, and any conditions or follow-up actions agreed upon by the parties.',
    `resolution_outcome` STRING COMMENT 'The final outcome of the dispute resolution: favor claimant (dispute upheld), favor respondent (dispute rejected), partial settlement, compromise (both parties concede), withdrawn (claimant withdrew), or dismissed (no merit).. Valid values are `favor_claimant|favor_respondent|partial_settlement|compromise|withdrawn|dismissed`',
    `resolution_timestamp` TIMESTAMP COMMENT 'The precise date and time when the dispute was formally resolved.',
    `root_cause_category` STRING COMMENT 'High-level classification of the underlying root cause identified during dispute investigation (e.g., operational error, system failure, communication breakdown, external factor).',
    `settlement_amount` DECIMAL(18,2) COMMENT 'The final monetary amount agreed upon or awarded as part of the dispute resolution, which may differ from the originally disputed amount.',
    `supporting_evidence_reference` STRING COMMENT 'Reference to supporting documentation, evidence files, or document management system identifiers (e.g., Proof of Delivery (POD), Electronic Proof of Delivery (ePOD), photos, correspondence) that substantiate the dispute claim.',
    `target_resolution_date` DATE COMMENT 'The target or expected date by which the dispute should be resolved, based on Service Level Agreement (SLA) or internal Key Performance Indicator (KPI) commitments.',
    CONSTRAINT pk_contract_dispute PRIMARY KEY(`contract_dispute_id`)
) COMMENT 'Manages formal contract disputes raised by either party, including rate disputes, SLA breach disputes, volume shortfall disputes, penalty disputes, and invoice discrepancy disputes. Captures dispute type, raised-by party, dispute date, disputed amount, supporting evidence references, dispute status (open, under review, escalated, resolved, withdrawn), resolution method (negotiation, mediation, arbitration), and resolution date.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` (
    `contract_approval_workflow_id` BIGINT COMMENT 'Unique identifier for the contract approval workflow instance. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the contract or agreement undergoing approval workflow. Links to the parent contract entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who initiated the approval workflow. Part of audit trail for SOX compliance.',
    `modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified the workflow record. Part of audit trail for SOX compliance.',
    `primary_contract_employee_id` BIGINT COMMENT 'Identifier of the user or role currently assigned to review and approve the workflow at the current stage.',
    `tertiary_contract_authorized_signatory_employee_id` BIGINT COMMENT 'Identifier of the individual with legal authority to execute the contract on behalf of the organization.',
    `workflow_id` BIGINT COMMENT 'Foreign key linking to document.document_workflow. Business justification: Contract approval workflows may trigger document workflow creation (approved contract initiates template setup, executed agreement triggers document package creation). Business process: operational ha',
    `action_date` DATE COMMENT 'Date when the approval action was taken by the assigned approver.',
    `action_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the approval action was recorded. Critical for SOX audit trail and SLA compliance.',
    `approval_action` STRING COMMENT 'Action taken by the approver at the current stage. Determines workflow progression or termination.. Valid values are `approved|rejected|returned|escalated|delegated|pending`',
    `approval_comments` STRING COMMENT 'Free-text comments or notes provided by the approver explaining their decision or requesting clarifications.',
    `assigned_approver_name` STRING COMMENT 'Full name of the individual currently assigned to approve the workflow. Denormalized for reporting convenience.',
    `assigned_approver_role` STRING COMMENT 'Functional role or title of the assigned approver (e.g., Legal Counsel, Finance Director, VP Commercial).',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking to detailed audit log entries for this workflow. Supports SOX compliance and forensic analysis.',
    `authorized_signatory_name` STRING COMMENT 'Full name of the authorized signatory who will execute the contract. Denormalized for audit and reporting.',
    `compliance_review_required_flag` BOOLEAN COMMENT 'Indicates whether a formal compliance review is required as part of the approval workflow. Triggered by regulatory obligations or contract characteristics.',
    `contract_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the contract undergoing approval. Used for authorization level determination and risk assessment.',
    `contract_value_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the contract value amount.. Valid values are `^[A-Z]{3}$`',
    `counterparty_execution_date` DATE COMMENT 'Date when the counterparty executed the contract. May differ from internal execution date in sequential signing scenarios.',
    `counterparty_signatory_name` STRING COMMENT 'Full name of the counterparty representative who executed the contract on behalf of the customer, carrier, or vendor.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the workflow record was created in the system. Part of standard audit trail.',
    `document_reference` STRING COMMENT 'Reference to the contract document or document management system location. Links workflow to physical/digital contract artifact.',
    `escalation_date` DATE COMMENT 'Date when the workflow was escalated to higher authority or exception handling process.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the workflow has been escalated to higher authority due to delays, disputes, or policy exceptions.',
    `escalation_reason` STRING COMMENT 'Explanation of why the workflow was escalated. Captures business justification for exception handling.',
    `execution_date` DATE COMMENT 'Date when the contract was formally executed by the authorized signatory following final approval.',
    `execution_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the contract execution was recorded. Marks the legal binding moment.',
    `initiated_date` DATE COMMENT 'Date when the approval workflow was initiated. Marks the start of the approval process.',
    `initiated_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the approval workflow was initiated. Used for SLA tracking and audit trail.',
    `legal_review_required_flag` BOOLEAN COMMENT 'Indicates whether legal counsel review is required. Typically mandatory for new contracts and material amendments.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the workflow record was last modified. Part of standard audit trail.',
    `notification_date` DATE COMMENT 'Date when workflow status notification was sent to stakeholders.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether workflow status notification has been sent to relevant stakeholders.',
    `priority_level` STRING COMMENT 'Business priority assigned to the approval workflow. Influences SLA targets and escalation thresholds.. Valid values are `low|medium|high|urgent`',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided when a workflow is rejected. Captures business rationale for non-approval.',
    `risk_rating` STRING COMMENT 'Business risk assessment assigned to the contract. Influences approval routing and required review levels.. Valid values are `low|medium|high|critical`',
    `sla_actual_days` STRING COMMENT 'Actual number of business days taken to complete the approval workflow. Calculated from initiation to execution.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether the workflow was completed within the target SLA timeframe. Used for KPI reporting.',
    `sla_target_days` STRING COMMENT 'Target number of business days for completing the approval workflow. Used for performance measurement and escalation triggers.',
    `sox_authorization_control` STRING COMMENT 'Reference to the SOX control framework rule or policy governing this approval workflow. Ensures compliance with financial reporting controls.',
    `submitted_date` DATE COMMENT 'Date when the workflow was formally submitted for approval. Marks transition from draft to active review.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the workflow was submitted for approval. Used for SLA compliance measurement.',
    `workflow_stage` STRING COMMENT 'Current approval stage in the workflow sequence. Defines which functional area is currently reviewing the contract. [ENUM-REF-CANDIDATE: draft|legal_review|commercial_review|finance_review|compliance_review|executive_approval|executed — 7 candidates stripped; promote to reference product]',
    `workflow_status` STRING COMMENT 'Current lifecycle status of the approval workflow. Tracks progression through approval stages. [ENUM-REF-CANDIDATE: draft|submitted|in_review|approved|rejected|returned|cancelled|executed — 8 candidates stripped; promote to reference product]',
    `workflow_type` STRING COMMENT 'Type of contract event triggering the approval workflow. Determines the approval path and required reviewers.. Valid values are `creation|amendment|renewal|termination|rate_change|sla_modification`',
    CONSTRAINT pk_contract_approval_workflow PRIMARY KEY(`contract_approval_workflow_id`)
) COMMENT 'Tracks the approval workflow lifecycle for contract creation, amendment, renewal, and termination events. Captures workflow stage (draft, legal review, commercial review, finance review, executive approval, executed), assigned approver, approval action (approved, rejected, returned), action date, comments, and escalation flag. Supports SOX-compliant contract authorization controls.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`agreement_supplier_service` (
    `agreement_supplier_service_id` BIGINT COMMENT 'Unique identifier for this agreement-supplier service assignment. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to the commercial agreement under which the supplier provides services',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to the supplier providing services under this agreement',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of total agreement volume allocated to this supplier. Used in multi-supplier scenarios where volume is split (e.g., 70% primary carrier, 30% backup carrier).',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this supplier assignment. Controls whether the supplier is actively fulfilling services under this agreement.',
    `effective_date` DATE COMMENT 'Date when this supplier begins providing services under this agreement. May differ from the master agreement effective date if suppliers are added mid-term.',
    `expiry_date` DATE COMMENT 'Date when this supplier stops providing services under this agreement. Nullable for open-ended assignments. May differ from master agreement expiry if suppliers rotate.',
    `primary_supplier_flag` BOOLEAN COMMENT 'Indicates whether this supplier is the primary service provider for this agreement (true) or a backup/secondary provider (false). Used for routing and allocation logic.',
    `rate_schedule_reference` STRING COMMENT 'Reference identifier to the detailed rate card or pricing schedule applicable to this supplier for this agreement. Links to external rate management systems or documents.',
    `rate_validity_end_date` DATE COMMENT 'Date when the agreed pricing rates expire. Triggers rate renegotiation workflows and ensures billing accuracy during rate transition periods. [Moved from agreement: Rate expiry dates are supplier-specific. Suppliers may be added or removed mid-term with their own rate validity windows.]',
    `rate_validity_start_date` DATE COMMENT 'Date when the agreed pricing rates become effective. Used by pricing and billing systems to apply correct rates to shipments and services. [Moved from agreement: Rate validity periods are supplier-specific. Different suppliers may have different rate renewal cycles within the same master agreement.]',
    `service_type` STRING COMMENT 'Classification of the service role this supplier fulfills under the agreement. Enables multi-vendor service delivery where different suppliers handle different logistics functions for the same customer agreement.',
    `sla_otd_target_percent` DECIMAL(18,2) COMMENT 'Target percentage for on-time delivery (OTD) KPI specific to this supplier under this agreement. May differ from master agreement SLA if different service types have different targets.',
    `sla_otif_target_percent` DECIMAL(18,2) COMMENT 'Target percentage for on-time in-full (OTIF) KPI specific to this supplier under this agreement. Enables supplier-specific performance tracking and penalty/incentive calculations.',
    `volume_commitment_teu` DECIMAL(18,2) COMMENT 'Committed volume in twenty-foot equivalent units (TEU) allocated to this specific supplier under this agreement. Used for capacity planning and volume-based pricing tiers.',
    `volume_commitment_weight_kg` DECIMAL(18,2) COMMENT 'Committed volume in kilograms allocated to this specific supplier under this agreement for air or road freight. Basis for volume discounts and capacity reservations.',
    CONSTRAINT pk_agreement_supplier_service PRIMARY KEY(`agreement_supplier_service_id`)
) COMMENT 'This association product represents the service assignment contract between a commercial agreement and a supplier. It captures the specific terms, rates, commitments, and SLAs that apply when a particular supplier provides services under a specific agreement. Each record links one agreement to one supplier with attributes that exist only in the context of this relationship, enabling multi-vendor service delivery models where a single customer agreement is fulfilled by multiple carriers, brokers, warehouse providers, or other logistics service providers.. Existence Justification: In logistics operations, a single customer service agreement frequently requires multiple suppliers to fulfill different service components: a primary ocean carrier, a backup carrier for capacity overflow, a customs broker for clearance, a warehouse provider for storage, and last-mile delivery partners. Conversely, a single supplier (e.g., a major carrier like Maersk or DHL) serves hundreds of different customer agreements with varying rates, SLAs, and volume commitments specific to each agreement-supplier pairing. This is an operational M:N relationship that contract managers actively maintain.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`carrier_document_specification` (
    `carrier_document_specification_id` BIGINT COMMENT 'Unique identifier for this carrier document specification record. Primary key.',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to the carrier agreement that specifies this document requirement',
    `template_id` BIGINT COMMENT 'Foreign key linking to the document template required by this carrier agreement',
    `carrier_customization_allowed` BOOLEAN COMMENT 'Indicates whether the carrier permits customization of this document template (logo, additional fields, layout modifications) or requires strict adherence to the standard template format.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this carrier document specification record was created in the system.',
    `edi_mapping_reference` STRING COMMENT 'Reference identifier for the carrier-specific EDI mapping configuration used when generating documents from this template for this carrier. Captures carrier-specific field mappings, segment orders, or qualifier codes.',
    `effective_date` DATE COMMENT 'Date when this document template requirement becomes effective for the carrier agreement. May differ from the carrier agreement effective date if template requirements are phased in.',
    `expiry_date` DATE COMMENT 'Date when this document template requirement expires or is superseded by a new template version. Nullable for ongoing requirements.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier that last modified this carrier document specification record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this carrier document specification record was last modified.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this document template is mandatory for all shipments under this carrier agreement (true) or optional/conditional (false). Drives document generation workflows.',
    `specification_status` STRING COMMENT 'Current lifecycle status of this carrier document specification (draft, pending_approval, active, deprecated, superseded). Tracks approval workflow and active/inactive state.',
    `template_version_required` STRING COMMENT 'Specific version number of the document template required by this carrier agreement (e.g., 2.1, 3.0.1). Carriers may mandate specific template versions for compliance or system compatibility.',
    `usage_trigger_event` STRING COMMENT 'Business event or shipment milestone that triggers generation of this document template for this carrier (e.g., booking confirmation, cargo ready, customs clearance, delivery completion).',
    `created_by` STRING COMMENT 'User ID or system identifier that created this carrier document specification record.',
    CONSTRAINT pk_carrier_document_specification PRIMARY KEY(`carrier_document_specification_id`)
) COMMENT 'This association product represents the contractual specification between carrier_agreement and document_template. It captures carrier-specific document requirements, template version mandates, EDI mapping configurations, and customization permissions that exist only in the context of a specific carrier agreement. Each record links one carrier agreement to one document template with attributes governing how that template must be used for that carrier relationship.. Existence Justification: In logistics operations, carrier agreements specify multiple document templates with carrier-specific requirements (BOL format, MAWB layout, delivery receipt format, customs documentation), and each document template is reused across multiple carrier agreements. The business actively manages these specifications as contractual requirements, tracking which template versions are mandated, when they become effective, what EDI mappings apply, and whether carrier customization is permitted. This is an operational relationship that humans create during contract negotiation and update when carriers change their document requirements.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`compliance_documentation_requirement` (
    `compliance_documentation_requirement_id` BIGINT COMMENT 'Unique identifier for the compliance documentation requirement record. Primary key.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to the compliance obligation that requires specific documentation',
    `type_id` BIGINT COMMENT 'Foreign key linking to the document type that satisfies the compliance obligation',
    `compliance_status` STRING COMMENT 'Current compliance status for this specific document type in the context of this compliance obligation. Tracks whether the documentation requirement is being met. Explicitly identified in detection phase.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this compliance documentation requirement record was created in the system.',
    `effective_from_date` DATE COMMENT 'The date from which this document type becomes required for this compliance obligation. Supports time-bound documentation requirements.',
    `effective_until_date` DATE COMMENT 'The date on which this document type is no longer required for this compliance obligation. Supports time-bound documentation requirements and regulatory changes.',
    `last_modified_by` STRING COMMENT 'User or system identifier that last modified this compliance documentation requirement record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this compliance documentation requirement record was last modified.',
    `last_verification_date` DATE COMMENT 'The date on which this specific document type was last verified for compliance with this obligation. Tracks verification at the obligation-document level. Explicitly identified in detection phase.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this document type is mandatory (required) or optional for satisfying the compliance obligation. Explicitly identified in detection phase.',
    `next_verification_due_date` DATE COMMENT 'The date by which the next verification of this document type for this compliance obligation is due. Drives compliance monitoring workflows. Explicitly identified in detection phase.',
    `retention_period_override_years` STRING COMMENT 'Override for the document retention period specific to this compliance obligation context. Overrides the default retention period from document_type when compliance requirements mandate longer retention. Explicitly identified in detection phase.',
    `submission_method` STRING COMMENT 'The method by which this document type must be submitted to satisfy the compliance obligation (e.g., electronic filing, paper submission, API integration).',
    `verification_frequency` STRING COMMENT 'The frequency at which this document type must be verified for compliance with the specific obligation. May differ from the obligations general verification frequency. Explicitly identified in detection phase.',
    `created_by` STRING COMMENT 'User or system identifier that created this compliance documentation requirement record.',
    CONSTRAINT pk_compliance_documentation_requirement PRIMARY KEY(`compliance_documentation_requirement_id`)
) COMMENT 'This association product represents the documentation requirement relationship between compliance obligations and document types. It captures which document types are required to satisfy specific compliance obligations, including whether the document is mandatory, retention period overrides, verification schedules, and compliance status tracking. Each record links one compliance obligation to one document type with attributes that exist only in the context of this regulatory documentation requirement.. Existence Justification: In transport shipping logistics, compliance obligations (C-TPAT, AEO, IATA dangerous goods, GDPR, customs) require multiple specific document types to demonstrate compliance, and each document type can satisfy multiple different compliance obligations across contracts. For example, a security certification document may satisfy both C-TPAT and AEO obligations, while a single GDPR compliance obligation requires consent forms, privacy notices, and data processing agreements. The business actively manages these documentation requirements with obligation-specific retention periods, verification schedules, and compliance status tracking.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`agreement_compliance_qualification` (
    `agreement_compliance_qualification_id` BIGINT COMMENT 'Unique identifier for this agreement-compliance program qualification record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to the commercial agreement that is qualified by this compliance program',
    `compliance_program_id` BIGINT COMMENT 'Foreign key linking to the compliance program that qualifies this agreement for customs benefits',
    `applicable_trade_lanes` STRING COMMENT 'Comma-separated list of trade lane codes or origin-destination pairs where this compliance program qualification applies for this agreement (e.g., US-EU, CN-US). Allows lane-specific program application.',
    `benefit_effective_date` DATE COMMENT 'Date from which the compliance program benefits become effective for shipments under this agreement. May differ from the programs general effective_date based on agreement-specific qualification timing.',
    `benefit_expiry_date` DATE COMMENT 'Date when the compliance program benefits expire for this agreement. May differ from the programs general expiry_date based on agreement-specific terms or renewal cycles.',
    `compliance_program` STRING COMMENT 'Name or identifier of the compliance program applicable to this agreement, such as Customs-Trade Partnership Against Terrorism (C-TPAT) or Authorized Economic Operator (AEO). Determines security and audit requirements. [Moved from agreement: The compliance_program attribute in the agreement table is a STRING field that appears to store a single program name or identifier. This is insufficient for the true M:N business reality where agreements can be qualified by multiple compliance programs simultaneously (e.g., AEO for EU lanes, C-TPAT for US lanes). This attribute should be removed from agreement and replaced by the M:N association, which allows multiple programs per agreement with program-specific qualification details.]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was created in the system',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was last modified',
    `program_benefit_tier` STRING COMMENT 'Tier or level of customs benefits that this specific compliance program confers to this specific agreement (e.g., Standard, Enhanced, Premium). Benefit tier may vary by agreement based on volume, lanes, or negotiated terms.',
    `program_reference_date` DATE COMMENT 'Date when this compliance program was first referenced or associated with this agreement during contract negotiation or execution',
    `qualification_verification_status` STRING COMMENT 'Current verification status of this compliance program qualification for this agreement. Tracks whether the program benefits are actively applicable to shipments under this agreement.',
    CONSTRAINT pk_agreement_compliance_qualification PRIMARY KEY(`agreement_compliance_qualification_id`)
) COMMENT 'This association product represents the qualification relationship between compliance programs and commercial agreements. It captures which trusted trader programs (C-TPAT, AEO, etc.) qualify specific service agreements for customs benefits, including program-specific benefit tiers, qualification dates, and verification status. Each record links one compliance_program to one agreement with attributes that exist only in the context of this qualification relationship.. Existence Justification: In Transport Shipping logistics operations, a single compliance program (such as AEO or C-TPAT) can qualify multiple commercial service agreements for customs benefits, and a single agreement can legitimately reference multiple compliance programs simultaneously to cover different trade lanes (e.g., AEO for EU shipments, C-TPAT for US shipments under the same master agreement). The business actively manages these qualifications with program-specific benefit tiers, verification statuses, and effective dates that vary by agreement.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_parent_agreement_id` FOREIGN KEY (`parent_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ADD CONSTRAINT `fk_contract_agreement_version_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ADD CONSTRAINT `fk_contract_agreement_version_superseded_by_version_agreement_version_id` FOREIGN KEY (`superseded_by_version_agreement_version_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement_version`(`agreement_version_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ADD CONSTRAINT `fk_contract_contract_sla_commitment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ADD CONSTRAINT `fk_contract_sla_performance_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ADD CONSTRAINT `fk_contract_sla_performance_contract_sla_commitment_id` FOREIGN KEY (`contract_sla_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`contract_sla_commitment`(`contract_sla_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ADD CONSTRAINT `fk_contract_rate_schedule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ADD CONSTRAINT `fk_contract_contract_surcharge_schedule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ADD CONSTRAINT `fk_contract_contract_surcharge_schedule_supersedes_schedule_contract_surcharge_schedule_id` FOREIGN KEY (`supersedes_schedule_contract_surcharge_schedule_id`) REFERENCES `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule`(`contract_surcharge_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ADD CONSTRAINT `fk_contract_contract_volume_commitment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ADD CONSTRAINT `fk_contract_contract_volume_commitment_contract_party_id` FOREIGN KEY (`contract_party_id`) REFERENCES `transport_shipping_ecm`.`contract`.`contract_party`(`contract_party_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ADD CONSTRAINT `fk_contract_volume_actuals_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ADD CONSTRAINT `fk_contract_volume_actuals_contract_volume_commitment_id` FOREIGN KEY (`contract_volume_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`contract_volume_commitment`(`contract_volume_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ADD CONSTRAINT `fk_contract_penalty_clause_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ADD CONSTRAINT `fk_contract_penalty_clause_contract_sla_commitment_id` FOREIGN KEY (`contract_sla_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`contract_sla_commitment`(`contract_sla_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ADD CONSTRAINT `fk_contract_penalty_clause_contract_volume_commitment_id` FOREIGN KEY (`contract_volume_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`contract_volume_commitment`(`contract_volume_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ADD CONSTRAINT `fk_contract_incentive_clause_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_contract_party_id` FOREIGN KEY (`contract_party_id`) REFERENCES `transport_shipping_ecm`.`contract`.`contract_party`(`contract_party_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_penalty_clause_id` FOREIGN KEY (`penalty_clause_id`) REFERENCES `transport_shipping_ecm`.`contract`.`penalty_clause`(`penalty_clause_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ADD CONSTRAINT `fk_contract_renewal_schedule_contract_party_id` FOREIGN KEY (`contract_party_id`) REFERENCES `transport_shipping_ecm`.`contract`.`contract_party`(`contract_party_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ADD CONSTRAINT `fk_contract_renewal_schedule_previous_renewal_schedule_id` FOREIGN KEY (`previous_renewal_schedule_id`) REFERENCES `transport_shipping_ecm`.`contract`.`renewal_schedule`(`renewal_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ADD CONSTRAINT `fk_contract_renewal_schedule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ADD CONSTRAINT `fk_contract_renewal_event_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ADD CONSTRAINT `fk_contract_compliance_obligation_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ADD CONSTRAINT `fk_contract_compliance_review_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ADD CONSTRAINT `fk_contract_compliance_review_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `transport_shipping_ecm`.`contract`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ADD CONSTRAINT `fk_contract_lane_commitment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ADD CONSTRAINT `fk_contract_contract_party_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ADD CONSTRAINT `fk_contract_contract_dispute_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ADD CONSTRAINT `fk_contract_contract_dispute_contract_sla_commitment_id` FOREIGN KEY (`contract_sla_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`contract_sla_commitment`(`contract_sla_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ADD CONSTRAINT `fk_contract_contract_approval_workflow_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_supplier_service` ADD CONSTRAINT `fk_contract_agreement_supplier_service_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_document_specification` ADD CONSTRAINT `fk_contract_carrier_document_specification_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_documentation_requirement` ADD CONSTRAINT `fk_contract_compliance_documentation_requirement_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `transport_shipping_ecm`.`contract`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_compliance_qualification` ADD CONSTRAINT `fk_contract_agreement_compliance_qualification_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= TAGS =========
ALTER SCHEMA `transport_shipping_ecm`.`contract` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `transport_shipping_ecm`.`contract` SET TAGS ('dbx_domain' = 'contract');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `carbon_offset_program_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Program Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `parent_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Agreement Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Document Template Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'customer_service_contract|carrier_agreement|3pl_partnership|4pl_partnership|vendor_contract|nvocc_agreement');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `contract_tier` SET TAGS ('dbx_business_glossary_term' = 'Contract Tier');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `contract_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `governing_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Jurisdiction');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `governing_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `incentive_clause_description` SET TAGS ('dbx_business_glossary_term' = 'Incentive Clause Description');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `insurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `payment_term_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Days');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `penalty_clause_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Description');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `renewal_count` SET TAGS ('dbx_business_glossary_term' = 'Renewal Count');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `signatory_party_counterparty` SET TAGS ('dbx_business_glossary_term' = 'Signatory Party Counterparty');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `signatory_party_primary` SET TAGS ('dbx_business_glossary_term' = 'Signatory Party Primary');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `sla_otd_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) On-Time Delivery (OTD) Target Percent');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `sla_otif_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) On-Time In-Full (OTIF) Target Percent');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `volume_commitment_teu` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Twenty-foot Equivalent Unit (TEU)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `volume_commitment_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Weight Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `agreement_version_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Version Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `superseded_by_version_agreement_version_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Version Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'initial|renewal|addendum|amendment|termination|extension');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `approval_action` SET TAGS ('dbx_business_glossary_term' = 'Approval Action');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `approval_action` SET TAGS ('dbx_value_regex' = 'approved|rejected|returned|pending');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `approval_comments` SET TAGS ('dbx_business_glossary_term' = 'Approval Comments');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `assigned_approver` SET TAGS ('dbx_business_glossary_term' = 'Assigned Approver');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `assigned_approver` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `authorized_signatory` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `authorized_signatory` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `change_summary` SET TAGS ('dbx_business_glossary_term' = 'Change Summary');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `compliance_review_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Required');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `compliance_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reviewer');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `compliance_reviewer` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `counterparty_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Execution Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `counterparty_signatory` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Signatory');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `counterparty_signatory` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document Format');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `document_format` SET TAGS ('dbx_value_regex' = 'pdf|docx|xml|edi|scanned|other');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `modified_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `sox_authorization_control` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Authorization Control');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `sox_authorization_control` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `superseded_date` SET TAGS ('dbx_business_glossary_term' = 'Superseded Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `version_hash` SET TAGS ('dbx_business_glossary_term' = 'Version Hash');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Version Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `version_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|executed|superseded|cancelled');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `workflow_stage` SET TAGS ('dbx_business_glossary_term' = 'Workflow Stage');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `workflow_stage` SET TAGS ('dbx_value_regex' = 'draft|legal_review|commercial_review|finance_review|executive_approval|executed');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ALTER COLUMN `created_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `contract_sla_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Service Level Agreement (SLA) Commitment Identifier');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `compliance_check_id` SET TAGS ('dbx_business_glossary_term' = 'Document Compliance Check Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `emissions_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Factor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `service_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Corridor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `compliance_tracking_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Tracking Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `contract_sla_commitment_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `contract_sla_commitment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|expired|superseded|draft');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `escalation_procedure` SET TAGS ('dbx_business_glossary_term' = 'Escalation Procedure');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `exclusion_conditions` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Conditions');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `incentive_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Incentive Clause Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `kpi_metric` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Metric');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `penalty_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `service_mode` SET TAGS ('dbx_business_glossary_term' = 'Service Mode');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `sla_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `sla_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `sla_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Name');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `sla_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'percentage|hours|minutes|days|count|ratio');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `volume_commitment_max` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Maximum');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `volume_commitment_min` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Minimum');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_sla_commitment` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `sla_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Performance ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `contract_sla_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Clause ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Service Lane ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `shipment_carbon_footprint_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Carbon Footprint Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Value');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `attainment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Attainment Percentage');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Breach Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `breach_severity` SET TAGS ('dbx_business_glossary_term' = 'Breach Severity');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `breach_severity` SET TAGS ('dbx_value_regex' = 'none|minor|moderate|major|critical');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `compliant_shipment_count` SET TAGS ('dbx_business_glossary_term' = 'Compliant Shipment Count');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `incentive_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Incentive Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `measurement_category` SET TAGS ('dbx_business_glossary_term' = 'Measurement Category');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `measurement_category` SET TAGS ('dbx_value_regex' = 'service_level|volume_attainment|quality|compliance');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `measurement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `measurement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `measurement_source_system` SET TAGS ('dbx_business_glossary_term' = 'Measurement Source System');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'draft|finalized|under_review|disputed|approved|archived');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'OTD|OTIF|transit_time|volume_commitment|weight_commitment|teu_commitment');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `non_compliant_shipment_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliant Shipment Count');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `penalty_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `shipment_count_in_scope` SET TAGS ('dbx_business_glossary_term' = 'Shipment Count in Scope');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `variance` SET TAGS ('dbx_business_glossary_term' = 'Variance');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` SET TAGS ('dbx_subdomain' = 'rate_obligations');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `emissions_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Factor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Rate');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `destination_zone` SET TAGS ('dbx_business_glossary_term' = 'Destination Zone');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `distance_break_max` SET TAGS ('dbx_business_glossary_term' = 'Distance Break Maximum');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `distance_break_min` SET TAGS ('dbx_business_glossary_term' = 'Distance Break Minimum');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `distance_uom` SET TAGS ('dbx_business_glossary_term' = 'Distance Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `distance_uom` SET TAGS ('dbx_value_regex' = 'km|mi|nmi');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `fuel_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Applicable');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `fuel_surcharge_rate` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Rate');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm (International Commercial Terms)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `maximum_charge` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Notes');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `origin_zone` SET TAGS ('dbx_business_glossary_term' = 'Origin Zone');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `peak_season_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Peak Season Surcharge Applicable');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `peak_season_surcharge_rate` SET TAGS ('dbx_business_glossary_term' = 'Peak Season Surcharge Rate');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `rate_validity_period_days` SET TAGS ('dbx_business_glossary_term' = 'Rate Validity Period (Days)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Name');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Number');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'lane_based|zone_based|weight_based|volume_based|distance_based|flat_rate');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `security_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Security Surcharge Applicable');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `security_surcharge_rate` SET TAGS ('dbx_business_glossary_term' = 'Security Surcharge Rate');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal|intermodal');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `volume_break_max` SET TAGS ('dbx_business_glossary_term' = 'Volume Break Maximum');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `volume_break_min` SET TAGS ('dbx_business_glossary_term' = 'Volume Break Minimum');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'cbm|cft|m3|ft3');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `weight_break_max` SET TAGS ('dbx_business_glossary_term' = 'Weight Break Maximum');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `weight_break_min` SET TAGS ('dbx_business_glossary_term' = 'Weight Break Minimum');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `weight_uom` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `weight_uom` SET TAGS ('dbx_value_regex' = 'kg|lb|ton|tonne');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` SET TAGS ('dbx_subdomain' = 'rate_obligations');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `contract_surcharge_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Surcharge Schedule ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `supersedes_schedule_contract_surcharge_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Schedule ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `adjustment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Frequency');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `adjustment_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly|annually|event_driven');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `applicability_condition` SET TAGS ('dbx_business_glossary_term' = 'Applicability Condition');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|active|suspended|expired');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'percentage|flat_rate|per_unit|tiered|index_based|formula');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `compounding_allowed` SET TAGS ('dbx_business_glossary_term' = 'Compounding Allowed Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `destination_region` SET TAGS ('dbx_business_glossary_term' = 'Destination Region');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `exemption_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exemption Criteria');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `index_reference` SET TAGS ('dbx_business_glossary_term' = 'Index Reference');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `maximum_charge` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `notification_lead_days` SET TAGS ('dbx_business_glossary_term' = 'Notification Lead Days');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `notification_required` SET TAGS ('dbx_business_glossary_term' = 'Notification Required Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `origin_region` SET TAGS ('dbx_business_glossary_term' = 'Origin Region');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `priority_sequence` SET TAGS ('dbx_business_glossary_term' = 'Priority Sequence');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `proration_method` SET TAGS ('dbx_business_glossary_term' = 'Proration Method');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `proration_method` SET TAGS ('dbx_value_regex' = 'none|daily|monthly|proportional');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Schedule Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `surcharge_rate` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Rate');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `surcharge_type` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `volume_threshold_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume Threshold');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `volume_threshold_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume Threshold');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `weight_threshold_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Weight Threshold');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `weight_threshold_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Weight Threshold');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `weight_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Weight Threshold Unit');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `weight_threshold_unit` SET TAGS ('dbx_value_regex' = 'kg|lb|ton|metric_ton');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` SET TAGS ('dbx_subdomain' = 'rate_obligations');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `contract_volume_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Volume Commitment ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `contract_party_id` SET TAGS ('dbx_business_glossary_term' = 'Commitment Party ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `actual_volume` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renew Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `commitment_code` SET TAGS ('dbx_business_glossary_term' = 'Commitment Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `commitment_notes` SET TAGS ('dbx_business_glossary_term' = 'Commitment Notes');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `commitment_party_type` SET TAGS ('dbx_business_glossary_term' = 'Commitment Party Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `commitment_party_type` SET TAGS ('dbx_value_regex' = 'customer|carrier|3pl|4pl|vendor');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `commitment_period` SET TAGS ('dbx_business_glossary_term' = 'Commitment Period');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `commitment_period` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|contract_term');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_business_glossary_term' = 'Commitment Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|fulfilled|breached|pending');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `commitment_type` SET TAGS ('dbx_business_glossary_term' = 'Commitment Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `excess_incentive_currency` SET TAGS ('dbx_business_glossary_term' = 'Excess Incentive Currency');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `excess_incentive_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `excess_incentive_rate` SET TAGS ('dbx_business_glossary_term' = 'Excess Incentive Rate');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `excess_incentive_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `last_measured_date` SET TAGS ('dbx_business_glossary_term' = 'Last Measured Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `maximum_volume` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_value_regex' = 'real_time|daily|weekly|monthly|quarterly|annual');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `minimum_volume` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `rollover_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollover Allowed Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `rollover_volume` SET TAGS ('dbx_business_glossary_term' = 'Rollover Volume');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Route Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `shortfall_penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Shortfall Penalty Currency');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `shortfall_penalty_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `shortfall_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Shortfall Penalty Rate');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `shortfall_penalty_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `target_volume` SET TAGS ('dbx_business_glossary_term' = 'Target Volume');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal|express');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Utilization Percentage');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_volume_commitment` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` SET TAGS ('dbx_subdomain' = 'rate_obligations');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `volume_actuals_id` SET TAGS ('dbx_business_glossary_term' = 'Volume Actuals ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `contract_volume_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Volume Commitment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `actual_volume_shipped` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume Shipped');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `attainment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Attainment Percentage');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `committed_volume` SET TAGS ('dbx_business_glossary_term' = 'Committed Volume');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|at-risk|grace-period|waived');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `destination_region` SET TAGS ('dbx_business_glossary_term' = 'Destination Region');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `incentive_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Incentive Triggered Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `measurement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `measurement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `origin_region` SET TAGS ('dbx_business_glossary_term' = 'Origin Region');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `penalty_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Triggered Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annual|annual|custom');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'draft|final|revised|voided');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'express|standard|economy|freight|specialized');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `shipment_count` SET TAGS ('dbx_business_glossary_term' = 'Shipment Count');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `shortfall_flag` SET TAGS ('dbx_business_glossary_term' = 'Shortfall Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `surplus_flag` SET TAGS ('dbx_business_glossary_term' = 'Surplus Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `trade_lane` SET TAGS ('dbx_business_glossary_term' = 'Trade Lane');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `volume_unit` SET TAGS ('dbx_value_regex' = 'TEU|kg|CBM|shipment_count|pallet|ton');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `volume_variance` SET TAGS ('dbx_business_glossary_term' = 'Volume Variance');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` SET TAGS ('dbx_subdomain' = 'rate_obligations');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `penalty_clause_id` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `contract_sla_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `contract_volume_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Accrual Method');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'immediate|period_end|invoice_date|settlement_date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `applies_to_party` SET TAGS ('dbx_business_glossary_term' = 'Applies To Party');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `applies_to_party` SET TAGS ('dbx_value_regex' = 'customer|carrier|vendor|3pl|4pl|broker');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `auto_apply_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Apply Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'fixed_fee|percentage_of_invoice|tiered_rebate|flat_bonus|credit_note|per_unit');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `clause_category` SET TAGS ('dbx_business_glossary_term' = 'Clause Category');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `clause_category` SET TAGS ('dbx_value_regex' = 'sla_breach|volume_shortfall|late_payment|service_failure|performance_bonus|volume_rebate');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `clause_description` SET TAGS ('dbx_business_glossary_term' = 'Clause Description');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `clause_number` SET TAGS ('dbx_business_glossary_term' = 'Clause Number');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `clause_status` SET TAGS ('dbx_business_glossary_term' = 'Clause Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `clause_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|expired|superseded');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `clause_type` SET TAGS ('dbx_business_glossary_term' = 'Clause Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `clause_type` SET TAGS ('dbx_value_regex' = 'penalty|incentive|rebate|bonus|deduction|credit');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `cure_period_days` SET TAGS ('dbx_business_glossary_term' = 'Cure Period Days');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `dispute_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Allowed Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `escalation_path` SET TAGS ('dbx_business_glossary_term' = 'Escalation Path');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `incentive_percentage` SET TAGS ('dbx_business_glossary_term' = 'Incentive Percentage');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `legal_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Reference');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `maximum_liability_cap` SET TAGS ('dbx_business_glossary_term' = 'Maximum Liability Cap');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `maximum_payout_cap` SET TAGS ('dbx_business_glossary_term' = 'Maximum Payout Cap');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `measurement_period` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Required Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'per_occurrence|monthly|quarterly|annually|upon_settlement');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `penalty_percentage` SET TAGS ('dbx_business_glossary_term' = 'Penalty Percentage');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `trigger_condition` SET TAGS ('dbx_business_glossary_term' = 'Trigger Condition');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` SET TAGS ('dbx_subdomain' = 'rate_obligations');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `incentive_clause_id` SET TAGS ('dbx_business_glossary_term' = 'Incentive Clause Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Accrual Method');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'accrued|paid_immediately|deferred|credited_to_account');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `applies_to_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Applies to Customer Segment');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `applies_to_lane` SET TAGS ('dbx_business_glossary_term' = 'Applies to Lane');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `applies_to_service_type` SET TAGS ('dbx_business_glossary_term' = 'Applies to Service Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'tiered_rebate|flat_bonus|percentage_discount|fixed_amount|sliding_scale|cumulative');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Cap Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `cap_currency` SET TAGS ('dbx_business_glossary_term' = 'Cap Currency Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `cap_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `clause_name` SET TAGS ('dbx_business_glossary_term' = 'Clause Name');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `clause_number` SET TAGS ('dbx_business_glossary_term' = 'Clause Number');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `cumulative_flag` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'Exclusions');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `incentive_clause_status` SET TAGS ('dbx_business_glossary_term' = 'Incentive Clause Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `incentive_clause_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|expired|pending_approval');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `incentive_type` SET TAGS ('dbx_business_glossary_term' = 'Incentive Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `incentive_type` SET TAGS ('dbx_value_regex' = 'volume_rebate|performance_bonus|loyalty_discount|early_payment_incentive|otd_bonus|otif_bonus');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `incentive_value` SET TAGS ('dbx_business_glossary_term' = 'Incentive Value');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `incentive_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Incentive Value Currency Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `incentive_value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `measurement_period_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|per_shipment|upon_achievement|end_of_contract');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `retroactive_flag` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `tier_level` SET TAGS ('dbx_business_glossary_term' = 'Tier Level');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `tier_max_value` SET TAGS ('dbx_business_glossary_term' = 'Tier Maximum Value');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `tier_min_value` SET TAGS ('dbx_business_glossary_term' = 'Tier Minimum Value');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `trigger_metric` SET TAGS ('dbx_business_glossary_term' = 'Trigger Metric');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `trigger_operator` SET TAGS ('dbx_business_glossary_term' = 'Trigger Operator');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `trigger_operator` SET TAGS ('dbx_value_regex' = 'greater_than|greater_than_or_equal|less_than|less_than_or_equal|equal|between');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `trigger_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Trigger Threshold Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`incentive_clause` ALTER COLUMN `trigger_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Trigger Threshold Value');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` SET TAGS ('dbx_subdomain' = 'rate_obligations');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `penalty_event_id` SET TAGS ('dbx_business_glossary_term' = 'Penalty Event ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `cargo_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Claim Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `contract_party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `credit_note_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Note ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `debit_note_id` SET TAGS ('dbx_business_glossary_term' = 'Debit Note ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `penalty_clause_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Clause ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route Plan Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `shipment_carbon_footprint_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Carbon Footprint Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `base_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `calculated_amount` SET TAGS ('dbx_business_glossary_term' = 'Calculated Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'fixed_amount|percentage_of_value|tiered_rate|per_unit|per_day');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `detection_date` SET TAGS ('dbx_business_glossary_term' = 'Detection Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Penalty Event Number');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `event_number` SET TAGS ('dbx_value_regex' = '^PE-[0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'penalty|incentive|credit|debit');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `final_amount` SET TAGS ('dbx_business_glossary_term' = 'Final Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `party_type` SET TAGS ('dbx_business_glossary_term' = 'Party Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `party_type` SET TAGS ('dbx_value_regex' = 'customer|carrier|vendor|3pl|4pl');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `penalty_event_status` SET TAGS ('dbx_business_glossary_term' = 'Penalty Event Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `penalty_event_status` SET TAGS ('dbx_value_regex' = 'pending|approved|disputed|settled|waived|cancelled');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Penalty Rate');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `sla_metric_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Metric Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `trigger_category` SET TAGS ('dbx_business_glossary_term' = 'Trigger Category');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `trigger_category` SET TAGS ('dbx_value_regex' = 'sla_breach|volume_shortfall|service_failure|quality_failure|compliance_violation|performance_bonus');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `trigger_description` SET TAGS ('dbx_business_glossary_term' = 'Trigger Description');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `waived_by` SET TAGS ('dbx_business_glossary_term' = 'Waived By');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` SET TAGS ('dbx_subdomain' = 'lifecycle_renewal');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `renewal_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal Schedule ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `contract_party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Party ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `previous_renewal_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Renewal Schedule ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Account Manager ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `quaternary_renewal_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `quaternary_renewal_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `quaternary_renewal_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `tertiary_renewal_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `tertiary_renewal_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `tertiary_renewal_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `auto_renewal_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `current_term_end_date` SET TAGS ('dbx_business_glossary_term' = 'Current Term End Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `current_term_start_date` SET TAGS ('dbx_business_glossary_term' = 'Current Term Start Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `customer_response_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `customer_response_type` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `customer_response_type` SET TAGS ('dbx_value_regex' = 'accept|decline|request_renegotiation|request_extension|no_response');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `negotiated_changes_summary` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Changes Summary');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `pricing_adjustment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Pricing Adjustment Percentage');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `proposed_renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Proposed Renewal Term Months');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `renewal_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Approval Required Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `renewal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Decision Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `renewal_decision_deadline` SET TAGS ('dbx_business_glossary_term' = 'Renewal Decision Deadline');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `renewal_notes` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notes');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `renewal_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notification Method');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `renewal_notification_method` SET TAGS ('dbx_value_regex' = 'email|postal_mail|electronic_portal|in_person|phone|fax');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `renewal_notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notification Sent Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `renewal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Renewal Outcome');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `renewal_outcome` SET TAGS ('dbx_value_regex' = 'renewed|renegotiated|terminated|expired|lapsed|withdrawn');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `renewal_priority` SET TAGS ('dbx_business_glossary_term' = 'Renewal Priority');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `renewal_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `renewal_review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Review Start Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `renewal_trigger_condition` SET TAGS ('dbx_business_glossary_term' = 'Renewal Trigger Condition');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `renewal_type` SET TAGS ('dbx_business_glossary_term' = 'Renewal Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `renewal_type` SET TAGS ('dbx_value_regex' = 'auto|manual|conditional|negotiated|evergreen|fixed_term');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `sla_modification_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Modification Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `termination_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Description');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_schedule` ALTER COLUMN `volume_commitment_change_percentage` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Change Percentage');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` SET TAGS ('dbx_subdomain' = 'lifecycle_renewal');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `renewal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal Event ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `competitive_bid_conducted_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitive Bid Conducted Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `contract_value_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Change Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `contract_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Currency Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `contract_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `counterparty_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Representative Name');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `counterparty_representative_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `counterparty_representative_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `counterparty_representative_role` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Representative Role');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `decision_maker_name` SET TAGS ('dbx_business_glossary_term' = 'Decision Maker Name');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `decision_maker_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `decision_maker_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `decision_maker_role` SET TAGS ('dbx_business_glossary_term' = 'Decision Maker Role');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `incoterms_change_flag` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms) Change Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `negotiated_changes_summary` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Changes Summary');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `otd_compliance_percentage` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery (OTD) Compliance Percentage');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `otif_compliance_percentage` SET TAGS ('dbx_business_glossary_term' = 'On-Time In-Full (OTIF) Compliance Percentage');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `penalty_clause_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Change Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `prior_contract_performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Prior Contract Performance Rating');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `prior_contract_performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|poor|unacceptable');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `rate_change_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rate Change Percentage');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `renewal_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Approval Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `renewal_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Approval Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `renewal_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional|escalated');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `renewal_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Renewal Approver Name');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `renewal_approver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `renewal_approver_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `renewal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Decision Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `renewal_decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Renewal Decision Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `renewal_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Effective Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `renewal_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `renewal_notes` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notes');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period Days');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `renewal_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notification Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `renewal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Renewal Outcome');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `renewal_outcome` SET TAGS ('dbx_value_regex' = 'renewed|renegotiated|terminated|expired|cancelled|extended');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Months');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `renewal_type` SET TAGS ('dbx_business_glossary_term' = 'Renewal Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `renewal_type` SET TAGS ('dbx_value_regex' = 'standard|early|late|emergency|conditional');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `sla_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Change Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_value_regex' = 'poor_performance|cost_reduction|service_quality|strategic_change|compliance_issue|mutual_agreement');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `termination_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Description');
ALTER TABLE `transport_shipping_ecm`.`contract`.`renewal_event` ALTER COLUMN `volume_commitment_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Change Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `compliance_check_id` SET TAGS ('dbx_business_glossary_term' = 'Document Compliance Check Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `corsia_compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'Corsia Compliance Record Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `esg_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Disclosure Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `documentation_required` SET TAGS ('dbx_business_glossary_term' = 'Documentation Required');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `escalation_procedure` SET TAGS ('dbx_business_glossary_term' = 'Escalation Procedure');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `last_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `next_verification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Verification Due Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `non_compliance_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Count');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|fulfilled|expired|waived');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `obligation_title` SET TAGS ('dbx_business_glossary_term' = 'Obligation Title');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'customs_compliance|trade_security|dangerous_goods|data_protection|environmental|financial_reporting');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `reporting_requirement` SET TAGS ('dbx_business_glossary_term' = 'Reporting Requirement');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `training_description` SET TAGS ('dbx_business_glossary_term' = 'Training Description');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `verification_frequency` SET TAGS ('dbx_business_glossary_term' = 'Verification Frequency');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'audit|certification|inspection|documentation_review|system_validation|third_party_assessment');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `waiver_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `waiver_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `compliance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `compliance_check_id` SET TAGS ('dbx_business_glossary_term' = 'Document Compliance Check Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `ghg_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Inventory Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `compliance_finding` SET TAGS ('dbx_business_glossary_term' = 'Compliance Finding');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `compliance_finding` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partially_compliant|not_applicable|pending_verification');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `corrective_action_owner` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Owner');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|overdue|verified');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `escalation_recipient` SET TAGS ('dbx_business_glossary_term' = 'Escalation Recipient');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `escalation_required` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Reference');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `finding_severity` SET TAGS ('dbx_business_glossary_term' = 'Finding Severity');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `finding_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|observation');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `review_comments` SET TAGS ('dbx_business_glossary_term' = 'Review Comments');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Number');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `review_number` SET TAGS ('dbx_value_regex' = '^CR-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Review Outcome');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `review_outcome` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional_pass|deferred');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `review_scope` SET TAGS ('dbx_business_glossary_term' = 'Review Scope');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|deferred');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'scheduled|ad_hoc|triggered|annual|quarterly|incident_driven');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `reviewer_role` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Role');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_review` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Review Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Agreement ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `driver_safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Safety Program Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `agreement_tier` SET TAGS ('dbx_business_glossary_term' = 'Agreement Tier');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `agreement_tier` SET TAGS ('dbx_value_regex' = 'preferred|approved|spot|strategic|tactical|backup');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `carrier_type` SET TAGS ('dbx_business_glossary_term' = 'Carrier Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `carrier_type` SET TAGS ('dbx_value_regex' = 'ocean|air|road|rail|multimodal|courier');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `compliance_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Required');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term Months');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `contracted_capacity_cbm` SET TAGS ('dbx_business_glossary_term' = 'Contracted Capacity Cubic Meter (CBM)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `contracted_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Contracted Capacity Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `contracted_capacity_teu` SET TAGS ('dbx_business_glossary_term' = 'Contracted Capacity Twenty-foot Equivalent Unit (TEU)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `counterparty_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Execution Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `counterparty_signatory` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Signatory');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `edi_connectivity_required` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Connectivity Required');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `edi_standard` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Standard');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `edi_standard` SET TAGS ('dbx_value_regex' = 'EDIFACT|ANSI_X12|XML|API|proprietary');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `fuel_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Applicable');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `incentive_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Incentive Clause Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `insurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `liability_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit Currency');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `liability_limit_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `minimum_volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume Commitment');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `nvocc_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Vessel Operating Common Carrier (NVOCC) Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `payment_term_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Days');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `penalty_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `rate_validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Validity End Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `rate_validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Validity Start Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `sla_otd_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) On-Time Delivery (OTD) Target Percent');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `sla_otif_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) On-Time In-Full (OTIF) Target Percent');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `volume_commitment_type` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `volume_commitment_type` SET TAGS ('dbx_value_regex' = 'minimum|maximum|target|flexible');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `lane_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Commitment ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Network Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `booking_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Booking Lead Time Hours');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `capacity_commitment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Capacity Commitment Quantity');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `commitment_period` SET TAGS ('dbx_business_glossary_term' = 'Commitment Period');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `commitment_period` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|annual');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_business_glossary_term' = 'Commitment Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `exclusion_conditions` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Conditions');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `incentive_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Incentive Clause Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `incentive_threshold_quantity` SET TAGS ('dbx_business_glossary_term' = 'Incentive Threshold Quantity');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `maximum_booking_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Booking Quantity');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `minimum_booking_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Booking Quantity');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `penalty_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low|standard');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `rate_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Per Unit');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `rate_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `rollover_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollover Allowed Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `rollover_expiry_periods` SET TAGS ('dbx_business_glossary_term' = 'Rollover Expiry Periods');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `rollover_limit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rollover Limit Quantity');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Route Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `route_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `transit_time_days` SET TAGS ('dbx_business_glossary_term' = 'Transit Time Days');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|intermodal|parcel');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `partnership_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Identifier');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `contractor_safety_prequal_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Safety Prequal Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization Identifier');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `aeo_certified` SET TAGS ('dbx_business_glossary_term' = 'Authorized Economic Operator (AEO) Certified');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Name');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Number');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `api_integration_required` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Integration Required');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `authorized_signatory` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory Name');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `authorized_signatory` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Renewal Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `carbon_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emissions Reporting Required');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `compliance_certifications_required` SET TAGS ('dbx_business_glossary_term' = 'Required Compliance Certifications');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `confidentiality_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause Included Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term Duration in Months');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `covered_countries` SET TAGS ('dbx_business_glossary_term' = 'Covered Country Codes');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `ctpat_certified` SET TAGS ('dbx_business_glossary_term' = 'Customs-Trade Partnership Against Terrorism (C-TPAT) Certified');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `data_protection_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Compliance Required');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Agreement Document Reference');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `edi_integration_required` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Integration Required');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Email Address');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Name');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiration Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage Scope');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `governance_model` SET TAGS ('dbx_business_glossary_term' = 'Partnership Governance Model');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `governance_model` SET TAGS ('dbx_value_regex' = 'Collaborative|Managed Service|Integrated|Transactional|Strategic Partnership');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `incentive_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Incentive Clause Included Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Requirements');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `liability_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Liability Currency Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `liability_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Limit Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `liability_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Notes');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `operational_kpi_commitments` SET TAGS ('dbx_business_glossary_term' = 'Operational Key Performance Indicator (KPI) Commitments');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `otd_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery (OTD) Target Percentage');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `otif_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'On-Time In-Full (OTIF) Target Percentage');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `partner_signatory` SET TAGS ('dbx_business_glossary_term' = 'Partner Authorized Signatory Name');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `partner_signatory` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `partnership_tier` SET TAGS ('dbx_business_glossary_term' = 'Partnership Tier Classification');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `partnership_tier` SET TAGS ('dbx_value_regex' = '3PL|4PL|2PL|Lead Logistics Provider|Specialized Service Provider');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `penalty_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Included Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `performance_review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Frequency');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `performance_review_frequency` SET TAGS ('dbx_value_regex' = 'Weekly|Monthly|Quarterly|Semi-Annual|Annual');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Partner Contact Email Address');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Partner Contact Name');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Partner Contact Phone Number');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period in Days');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `service_categories` SET TAGS ('dbx_business_glossary_term' = 'Service Category List');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `service_scope` SET TAGS ('dbx_business_glossary_term' = 'Service Scope Description');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Signed Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `sustainability_commitments` SET TAGS ('dbx_business_glossary_term' = 'Sustainability and Environmental Commitments');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `technology_integration_requirements` SET TAGS ('dbx_business_glossary_term' = 'Technology Integration Requirements');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `termination_for_cause_allowed` SET TAGS ('dbx_business_glossary_term' = 'Termination for Cause Allowed');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period in Days');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `tms_integration_required` SET TAGS ('dbx_business_glossary_term' = 'Transportation Management System (TMS) Integration Required');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `transition_support_days` SET TAGS ('dbx_business_glossary_term' = 'Transition Support Period in Days');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `volume_commitment_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume Commitment');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `volume_commitment_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume Commitment');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`contract`.`partnership_agreement` ALTER COLUMN `wms_integration_required` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Integration Required');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `service_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Service Scope ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `commodity_rate_class_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Rate Class Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `dim_weight_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Dim Weight Rule Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `emissions_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Factor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Network Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `cod_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Allowed Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `compliance_program` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type (FCL/LCL)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `container_type` SET TAGS ('dbx_value_regex' = 'fcl|lcl|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `customs_clearance_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Included Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `dangerous_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `destination_region` SET TAGS ('dbx_business_glossary_term' = 'Destination Region');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `dimension_limit_cbm` SET TAGS ('dbx_business_glossary_term' = 'Dimension Limit (CBM)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `epod_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Proof of Delivery (ePOD) Required Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `freight_type` SET TAGS ('dbx_business_glossary_term' = 'Freight Type (FTL/LTL)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `freight_type` SET TAGS ('dbx_value_regex' = 'ftl|ltl|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|regional|domestic|international|cross_border');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `insurance_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Included Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Service Scope Notes');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `origin_region` SET TAGS ('dbx_business_glossary_term' = 'Origin Region');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `packaging_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Packaging Included Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Service Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `service_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `service_exclusions` SET TAGS ('dbx_business_glossary_term' = 'Service Exclusions');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `service_mode` SET TAGS ('dbx_business_glossary_term' = 'Service Mode');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `service_name` SET TAGS ('dbx_business_glossary_term' = 'Service Name');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `service_scope_status` SET TAGS ('dbx_business_glossary_term' = 'Service Scope Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `service_scope_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|expired');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `service_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Tier');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `service_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|economy|basic');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'door_to_door|port_to_port|door_to_port|port_to_door|cfs_to_cfs|depot_to_depot');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `special_handling_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Requirements');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `tracking_visibility_level` SET TAGS ('dbx_business_glossary_term' = 'Tracking Visibility Level');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `tracking_visibility_level` SET TAGS ('dbx_value_regex' = 'real_time|milestone|basic|none');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `trade_lane` SET TAGS ('dbx_business_glossary_term' = 'Trade Lane');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `volume_commitment_max` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Maximum');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `volume_commitment_min` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Minimum');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `volume_unit` SET TAGS ('dbx_value_regex' = 'teu|kg|cbm|shipments|pallets');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `warehousing_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Warehousing Included Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `weight_limit_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Limit (kg)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `contract_party_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Party Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `aeo_number` SET TAGS ('dbx_business_glossary_term' = 'Authorized Economic Operator (AEO) Number');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `aeo_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `compliance_certification` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `ctpat_number` SET TAGS ('dbx_business_glossary_term' = 'Customs-Trade Partnership Against Terrorism (C-TPAT) Number');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `ctpat_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `customs_broker_license` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker License Number');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `customs_broker_license` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `edi_identifier` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Identifier');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `guarantor_flag` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `iata_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `iata_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `insurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `liability_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Liability Currency Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `liability_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `notification_preference` SET TAGS ('dbx_business_glossary_term' = 'Notification Preference');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `notification_preference` SET TAGS ('dbx_value_regex' = 'email|phone|postal_mail|edi|api');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `nvocc_license_number` SET TAGS ('dbx_business_glossary_term' = 'Non-Vessel Operating Common Carrier (NVOCC) License Number');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `nvocc_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `party_role` SET TAGS ('dbx_business_glossary_term' = 'Party Role');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `party_status` SET TAGS ('dbx_business_glossary_term' = 'Party Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `party_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `party_type` SET TAGS ('dbx_business_glossary_term' = 'Party Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `party_type` SET TAGS ('dbx_value_regex' = 'corporate|individual|government|non_profit|partnership');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `payment_responsibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Responsibility Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `primary_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `registration_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Registration Jurisdiction');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Business Registration Number');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `scac_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Carrier Alpha Code (SCAC)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `scac_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `signatory_email` SET TAGS ('dbx_business_glossary_term' = 'Signatory Email Address');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `signatory_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `signatory_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `signatory_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory Name');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `signatory_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `signatory_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `signatory_phone` SET TAGS ('dbx_business_glossary_term' = 'Signatory Phone Number');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `signatory_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `signatory_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Signatory Title');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `signature_date` SET TAGS ('dbx_business_glossary_term' = 'Signature Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `signature_location` SET TAGS ('dbx_business_glossary_term' = 'Signature Location');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `signature_method` SET TAGS ('dbx_business_glossary_term' = 'Signature Method');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `signature_method` SET TAGS ('dbx_value_regex' = 'wet_signature|electronic_signature|digital_signature|notarized');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `contract_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Dispute Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `cargo_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Claim Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `contract_sla_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Related Service Level Agreement (SLA) Commitment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `credit_note_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Related Invoice Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Raised By Contact Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Related Shipment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Resolution Journal Entry Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assigned Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `credit_note_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Issued Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `customer_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Rating');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `days_to_resolution` SET TAGS ('dbx_business_glossary_term' = 'Days to Resolution');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `dispute_description` SET TAGS ('dbx_business_glossary_term' = 'Dispute Description');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `dispute_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Number');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'open|under_review|escalated|resolved|withdrawn|closed');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `dispute_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_business_glossary_term' = 'Dispute Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `financial_impact` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `governing_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Jurisdiction');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `legal_case_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Case Reference');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `legal_counsel_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Involved Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `penalty_waived_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Waived Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `penalty_waived_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Waived Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `raised_by_party` SET TAGS ('dbx_business_glossary_term' = 'Raised By Party');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `raised_by_party` SET TAGS ('dbx_value_regex' = 'customer|carrier|vendor|internal|third_party_logistics');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Resolution Method');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `resolution_method` SET TAGS ('dbx_value_regex' = 'negotiation|mediation|arbitration|litigation|internal_review|mutual_agreement');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'favor_claimant|favor_respondent|partial_settlement|compromise|withdrawn|dismissed');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `supporting_evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Evidence Reference');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_dispute` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `contract_approval_workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Approval Workflow ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `primary_contract_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Approver ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `primary_contract_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `primary_contract_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `tertiary_contract_authorized_signatory_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `tertiary_contract_authorized_signatory_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `tertiary_contract_authorized_signatory_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Document Workflow Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `action_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Action Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `action_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Action Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `approval_action` SET TAGS ('dbx_business_glossary_term' = 'Approval Action');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `approval_action` SET TAGS ('dbx_value_regex' = 'approved|rejected|returned|escalated|delegated|pending');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `approval_comments` SET TAGS ('dbx_business_glossary_term' = 'Approval Comments');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `assigned_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Approver Name');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `assigned_approver_role` SET TAGS ('dbx_business_glossary_term' = 'Assigned Approver Role');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `authorized_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory Name');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `compliance_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Required Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `contract_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `contract_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Currency Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `contract_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `counterparty_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Execution Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `counterparty_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Signatory Name');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Workflow Initiated Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Workflow Initiated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `legal_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `sla_actual_days` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Actual Days');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Compliance Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `sla_target_days` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Target Days');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `sox_authorization_control` SET TAGS ('dbx_business_glossary_term' = 'SOX (Sarbanes-Oxley) Authorization Control');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Workflow Submitted Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Workflow Submitted Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `workflow_stage` SET TAGS ('dbx_business_glossary_term' = 'Workflow Stage');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Workflow Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `workflow_type` SET TAGS ('dbx_business_glossary_term' = 'Workflow Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_approval_workflow` ALTER COLUMN `workflow_type` SET TAGS ('dbx_value_regex' = 'creation|amendment|renewal|termination|rate_change|sla_modification');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_supplier_service` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_supplier_service` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_supplier_service` SET TAGS ('dbx_association_edges' = 'contract.agreement,procurement.supplier');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_supplier_service` ALTER COLUMN `agreement_supplier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Supplier Service ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_supplier_service` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Supplier Service - Agreement Id');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_supplier_service` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Supplier Service - Supplier Id');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_supplier_service` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Volume Allocation Percentage');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_supplier_service` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_supplier_service` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Service Assignment Effective Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_supplier_service` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Service Assignment Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_supplier_service` ALTER COLUMN `primary_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Supplier Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_supplier_service` ALTER COLUMN `rate_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Reference');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_supplier_service` ALTER COLUMN `rate_validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Validity End Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_supplier_service` ALTER COLUMN `rate_validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Validity Start Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_supplier_service` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_supplier_service` ALTER COLUMN `sla_otd_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Supplier SLA On-Time Delivery Target');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_supplier_service` ALTER COLUMN `sla_otif_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Supplier SLA On-Time In-Full Target');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_supplier_service` ALTER COLUMN `volume_commitment_teu` SET TAGS ('dbx_business_glossary_term' = 'Supplier Volume Commitment TEU');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_supplier_service` ALTER COLUMN `volume_commitment_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Supplier Volume Commitment Weight');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_document_specification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_document_specification` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_document_specification` SET TAGS ('dbx_association_edges' = 'contract.carrier_agreement,document.document_template');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_document_specification` ALTER COLUMN `carrier_document_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Document Specification ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_document_specification` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Document Specification - Carrier Agreement Id');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_document_specification` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Document Specification - Document Template Id');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_document_specification` ALTER COLUMN `carrier_customization_allowed` SET TAGS ('dbx_business_glossary_term' = 'Carrier Customization Allowed');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_document_specification` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Specification Created Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_document_specification` ALTER COLUMN `edi_mapping_reference` SET TAGS ('dbx_business_glossary_term' = 'EDI Mapping Reference');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_document_specification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Specification Effective Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_document_specification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Specification Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_document_specification` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Specification Last Modified By');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_document_specification` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Specification Last Modified Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_document_specification` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Template Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_document_specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_document_specification` ALTER COLUMN `template_version_required` SET TAGS ('dbx_business_glossary_term' = 'Template Version Required');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_document_specification` ALTER COLUMN `usage_trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Usage Trigger Event');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_document_specification` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Specification Created By');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_documentation_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_documentation_requirement` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_documentation_requirement` SET TAGS ('dbx_association_edges' = 'contract.compliance_obligation,document.document_type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_documentation_requirement` ALTER COLUMN `compliance_documentation_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Documentation Requirement ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_documentation_requirement` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Documentation Requirement - Compliance Obligation Id');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_documentation_requirement` ALTER COLUMN `type_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Documentation Requirement - Document Type Id');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_documentation_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_documentation_requirement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_documentation_requirement` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_documentation_requirement` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_documentation_requirement` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_documentation_requirement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_documentation_requirement` ALTER COLUMN `last_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_documentation_requirement` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_documentation_requirement` ALTER COLUMN `next_verification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Verification Due Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_documentation_requirement` ALTER COLUMN `retention_period_override_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Override Years');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_documentation_requirement` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_documentation_requirement` ALTER COLUMN `verification_frequency` SET TAGS ('dbx_business_glossary_term' = 'Verification Frequency');
ALTER TABLE `transport_shipping_ecm`.`contract`.`compliance_documentation_requirement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_compliance_qualification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_compliance_qualification` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_compliance_qualification` SET TAGS ('dbx_association_edges' = 'customs.compliance_program,contract.agreement');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_compliance_qualification` ALTER COLUMN `agreement_compliance_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Compliance Qualification ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_compliance_qualification` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Compliance Qualification - Agreement Id');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_compliance_qualification` ALTER COLUMN `compliance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Compliance Qualification - Compliance Program Id');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_compliance_qualification` ALTER COLUMN `applicable_trade_lanes` SET TAGS ('dbx_business_glossary_term' = 'Applicable Trade Lanes');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_compliance_qualification` ALTER COLUMN `benefit_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Effective Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_compliance_qualification` ALTER COLUMN `benefit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_compliance_qualification` ALTER COLUMN `compliance_program` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_compliance_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_compliance_qualification` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_compliance_qualification` ALTER COLUMN `program_benefit_tier` SET TAGS ('dbx_business_glossary_term' = 'Program Benefit Tier');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_compliance_qualification` ALTER COLUMN `program_reference_date` SET TAGS ('dbx_business_glossary_term' = 'Program Reference Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_compliance_qualification` ALTER COLUMN `qualification_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Verification Status');
