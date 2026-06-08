-- Schema for Domain: contract | Business: Transport Shipping | Version: v1_mvm
-- Generated on: 2026-05-08 22:35:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `transport_shipping_ecm`.`contract` COMMENT 'Contract and agreement management for customer service contracts, carrier agreements, 3PL/4PL partnerships, and vendor contracts. Manages SLA thresholds, OTD/OTIF KPI commitments, Incoterms (DDP, DAP, FOB, CIF, EXW), rate validity periods, volume commitments, penalty/incentive clauses, contract terms, renewals, and compliance tracking. Interfaces with pricing, billing, and customer domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`agreement` (
    `agreement_id` BIGINT COMMENT 'Unique identifier for the agreement. Primary key for the agreement master record.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier for carrier agreements. Links to carrier master for capacity allocation, rate management, and performance tracking.',
    `parent_agreement_id` BIGINT COMMENT 'Reference to the parent or master agreement if this is a subsidiary or regional agreement. Enables hierarchical agreement structures and consolidated reporting.',
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

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` (
    `sla_commitment_id` BIGINT COMMENT 'Unique identifier for the SLA commitment record within a contract. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or agreement to which this SLA commitment belongs.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: SLA commitments (e.g., 95% on-time delivery) apply to specific carrier service levels. Performance measurement systems track actuals against service-specific targets. Critical for service-level compli',
    `service_corridor_id` BIGINT COMMENT 'Foreign key linking to route.service_corridor. Business justification: SLA commitments often apply to entire service corridors (multi-leg routes) rather than individual lanes. Enables corridor-level performance tracking, capacity planning, and compliance reporting agains',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: SLA commitments made by suppliers providing logistics services. Business process: supplier performance management requires linking service level commitments to supplier master data for scorecarding an',
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
    CONSTRAINT pk_sla_commitment PRIMARY KEY(`sla_commitment_id`)
) COMMENT 'Defines the SLA thresholds and KPI commitments embedded within a contract, including OTD (On-Time Delivery) targets, OTIF (On-Time In-Full) percentages, transit time guarantees, pickup window SLAs, claims resolution SLAs, and customer service response SLAs. Captures measurement frequency, reporting period, baseline values, target values, and the service mode (express, freight, last-mile) to which each SLA applies.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`sla_performance` (
    `sla_performance_id` BIGINT COMMENT 'Unique identifier for the SLA performance measurement record.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or agreement under which this SLA performance is measured.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier or service provider whose performance is being measured. Applicable for carrier agreements and 3PL/4PL partnerships.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: SLA performance measurements track actual delivery against service-specific commitments (e.g., Next Day Air vs 2-Day Ground). Performance dashboards and carrier scorecards require service-level gr',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account for whom this SLA performance is being measured. Applicable for customer service contracts.',
    `lane_id` BIGINT COMMENT 'Reference to the specific service lane or route for which this SLA performance is measured (e.g., USA-EUR air express, Asia-USA ocean FCL).',
    `sla_commitment_id` BIGINT COMMENT 'Reference to the specific SLA clause or commitment being measured (e.g., OTD threshold, OTIF target, transit time commitment).',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Actual performance measurement of supplier-delivered transport services. Business process: supplier scorecarding, performance reviews, and rebate/penalty calculations require linking measured performa',
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
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Rate schedules are carrier-specific pricing agreements in transport shipping. Operations and pricing teams require direct carrier attribution for rate shopping, carrier performance analysis, contract ',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Rate schedules price specific carrier services (express vs standard vs economy). Rating engines require this link to select correct tariff based on service selection. Fundamental to quote generation a',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Rate schedules define contracted pricing for specific origin-destination lanes. Essential for freight costing, quote generation, and invoice validation. Logistics experts expect rate-to-lane linkage f',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to pricing.rate_card. Business justification: Rate schedules in agreements are often built from or reference carrier rate cards. Linking enables rate card governance, version tracking, and ensures agreement rate schedules remain synchronized with',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Rate schedules negotiated with suppliers providing transport services. Business process: procurement-sourced carriers have negotiated rates tracked in contract domain for freight cost management and i',
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
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Surcharge schedules (fuel, security, peak season) are carrier-imposed charges. Finance and pricing teams require direct carrier linkage for surcharge reconciliation, invoice validation, dispute resolu',
    `surcharge_id` BIGINT COMMENT 'Foreign key linking to pricing.surcharge. Business justification: Contract surcharge schedules define agreement-specific terms for standard surcharges. Linking enables surcharge master data governance, ensures consistent surcharge definitions, and supports surcharge',
    `supersedes_schedule_contract_surcharge_schedule_id` BIGINT COMMENT 'Reference to the previous surcharge schedule that this version replaces or supersedes. Null if this is the first version.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Surcharge schedules (fuel, peak season, security) negotiated with suppliers. Business process: procurement-managed suppliers have surcharge terms tracked in contract domain for accurate freight cost f',
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

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` (
    `volume_commitment_id` BIGINT COMMENT 'Unique identifier for the contract volume commitment record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or agreement under which this volume commitment is defined.',
    `contract_party_id` BIGINT COMMENT 'Identifier of the party (customer, carrier, or partner) to whom this volume commitment obligation applies. Links to the appropriate party master table based on commitment_party_type.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Volume commitments frequently specify particular lanes (origin-destination pairs) with minimum/maximum volume obligations. Critical for lane-level capacity allocation, booking prioritization, and moni',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Volume commitments made to suppliers for transport capacity. Business process: capacity planning, supplier relationship management, and rebate/penalty calculations require tracking committed volumes a',
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
    CONSTRAINT pk_volume_commitment PRIMARY KEY(`volume_commitment_id`)
) COMMENT 'Defines volume and capacity commitment obligations within a contract, including minimum volume guarantees (MVG), maximum volume caps, TEU commitments for ocean freight, weight-based commitments for air freight, shipment count commitments for express, and lane-level capacity allocations specifying origin-destination pairs, transport mode, weekly or monthly capacity (TEU, kg, flights, truck loads), minimum booking obligations, and rollover provisions. Captures commitment period (monthly, quarterly, annual), measurement unit, lane code, origin/destination port or hub, service string or route code, penalty for shortfall, and incentive for exceeding targets.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` (
    `volume_actuals_id` BIGINT COMMENT 'Unique identifier for the volume actuals record. Primary key for tracking actual shipped volumes against contracted commitments.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or customer service agreement under which this volume commitment was established.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Volume actuals measure shipment volumes against commitments. In multi-carrier agreements, operations and finance teams need direct carrier attribution to track which carrier delivered the volume for p',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account responsible for this volume commitment. Used for customer-level volume tracking and compliance reporting.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Volume actuals measurement requires lane-level granularity to track performance against lane-specific commitments. Enables lane utilization reporting, commitment compliance monitoring, and identificat',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Actual volumes shipped via suppliers. Business process: supplier performance analytics, rebate calculations, and volume commitment compliance tracking require linking actual shipped volumes to supplie',
    `volume_commitment_id` BIGINT COMMENT 'Foreign key linking to contract.contract_volume_commitment. Business justification: volume_actuals measures actual shipped volumes against contracted volume commitments. Currently only links to agreement (parent), but should link to the specific volume commitment being measured to en',
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
    `sla_commitment_id` BIGINT COMMENT 'Reference to the specific SLA entitlement or commitment that this penalty or incentive clause is tied to. Null if not linked to a specific SLA.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Penalty terms applicable to suppliers in service agreements. Business process: supplier contract enforcement, dispute resolution, and financial settlement require linking penalty clauses to supplier e',
    `volume_commitment_id` BIGINT COMMENT 'Reference to the specific volume commitment or minimum volume agreement that this penalty or incentive clause is tied to. Null if not linked to a volume commitment.',
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

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`penalty_event` (
    `penalty_event_id` BIGINT COMMENT 'Unique identifier for the penalty or incentive event. Primary key for the penalty event transaction.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract under which this penalty or incentive event was triggered.',
    `cargo_claim_id` BIGINT COMMENT 'Foreign key linking to claim.cargo_claim. Business justification: Penalty events (late delivery, damage) frequently result in cargo claims. Linking enables financial reconciliation—verifying that penalties assessed match claim settlements, resolving disputes where c',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Penalty events track carrier service failures (late delivery, damage, documentation errors). Claims and dispute resolution teams require direct carrier attribution for root cause analysis, financial r',
    `consignment_id` BIGINT COMMENT 'Reference to the specific shipment associated with this penalty event, if applicable. Null for volume-based or aggregate performance events.',
    `contract_party_id` BIGINT COMMENT 'Identifier of the specific party (customer, carrier, vendor) to whom this penalty or incentive applies.',
    `credit_note_id` BIGINT COMMENT 'Reference to the credit note issued for this incentive event, if applicable.',
    `cycle_id` BIGINT COMMENT 'Reference to the billing cycle in which this penalty or incentive will be or was applied.',
    `freight_order_id` BIGINT COMMENT 'Reference to the customer order associated with this penalty event, if applicable. Null for carrier or vendor penalties.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice on which this penalty or incentive was applied as a line item or adjustment.',
    `penalty_clause_id` BIGINT COMMENT 'Reference to the specific contract clause that defines the penalty or incentive terms that were breached or met.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to route.route_plan. Business justification: Penalty events (SLA breaches) often result from route execution failures—delays, missed connections, routing errors. Direct link enables root cause analysis, correlating contractual penalties with spe',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Penalty events may originate from procurement failures (late delivery of critical parts/equipment causing service disruptions). Links penalties to root-cause POs for supplier accountability, dispute r',
    `sla_performance_id` BIGINT COMMENT 'Foreign key linking to contract.sla_performance. Business justification: A penalty_event is triggered by a specific SLA performance measurement — when sla_performance records a breach (breach_flag=true), it triggers a penalty_event. Linking penalty_event directly to the sl',
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

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` (
    `carrier_agreement_id` BIGINT COMMENT 'Unique identifier for the carrier agreement. Primary key. Role: MASTER_AGREEMENT.',
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: Carrier agreements often involve agents as intermediaries for specific territories in global logistics. Operations and finance teams need agent attribution for commission calculation, territory manage',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: carrier_agreement is a specialization of the master agreement entity — it represents carrier-specific contracts that are a subtype of the broader commercial agreement. Adding agreement_id as a FK to t',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier party with whom this agreement is established.',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to pricing.rate_card. Business justification: Carrier agreements govern buy-side pricing structures. Linking to carrier rate cards enables buy-rate governance, margin analysis, and supports carrier rate change impact assessment across carrier agr',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Carrier agreements authorize specific carrier services (air/ocean/road schedules). Operations teams validate bookings against contracted service scope. Essential for service eligibility verification a',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Carriers often act as suppliers for fuel, equipment, or services beyond transport. Links carrier agreements to supplier master for procurement tracking, payment terms reconciliation, and consolidated ',
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
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.carrier_agreement. Business justification: The business description of lane_commitment explicitly states it defines contracted lane-level capacity commitments within a carrier agreement. This makes lane_commitment a direct child of carrier_a',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier or transportation service provider responsible for fulfilling this lane commitment.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Lane commitments specify capacity on particular carrier services (e.g., weekly TEU allocation on Maersk AE7 service). Capacity planning and booking allocation systems require this link to enforce comm',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Lane commitments specify contracted capacity/volume obligations for specific operational lanes. Critical for capacity allocation, booking management, and monitoring volume commitment compliance. Direc',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.network_partner. Business justification: Lane commitments can be fulfilled by 3PL partners or agents in addition to direct carriers. Capacity planning and fulfillment teams require partner attribution to track which entity is responsible for',
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

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`contract`.`service_scope` (
    `service_scope_id` BIGINT COMMENT 'Unique identifier for the service scope record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the parent contract or agreement under which this service scope is defined.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Service scope defines carrier-provided services under an agreement (customs clearance, insurance, temperature control). Operations teams need direct carrier linkage for service capability validation, ',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Service scope definitions reference specific carrier service offerings (e.g., FedEx Priority Overnight vs Ground). Required for matching customer requirements to contracted service levels and gene',
    `dim_weight_rule_id` BIGINT COMMENT 'Foreign key linking to pricing.dim_weight_rule. Business justification: Contract operations teams specify which dimensional weight rules apply to each service scope within multi-service agreements to ensure consistent chargeable weight calculations across different servic',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.network_partner. Business justification: Service scopes also define 3PL/partner capabilities in multi-party logistics models. Operations teams require partner attribution for service capability validation, partner selection, and performance ',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Service scope definitions for supplier-provided logistics services. Business process: procurement teams define what services suppliers can provide; contract teams reference these scopes when creating ',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to pricing.tariff. Business justification: Service scope definitions often reference applicable tariffs for regulatory and pricing context. Linking supports tariff applicability rules, enables service scope validation against published tariffs',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_parent_agreement_id` FOREIGN KEY (`parent_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ADD CONSTRAINT `fk_contract_agreement_version_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` ADD CONSTRAINT `fk_contract_agreement_version_superseded_by_version_agreement_version_id` FOREIGN KEY (`superseded_by_version_agreement_version_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement_version`(`agreement_version_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ADD CONSTRAINT `fk_contract_sla_commitment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ADD CONSTRAINT `fk_contract_sla_performance_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ADD CONSTRAINT `fk_contract_sla_performance_sla_commitment_id` FOREIGN KEY (`sla_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`sla_commitment`(`sla_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ADD CONSTRAINT `fk_contract_rate_schedule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ADD CONSTRAINT `fk_contract_contract_surcharge_schedule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ADD CONSTRAINT `fk_contract_contract_surcharge_schedule_supersedes_schedule_contract_surcharge_schedule_id` FOREIGN KEY (`supersedes_schedule_contract_surcharge_schedule_id`) REFERENCES `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule`(`contract_surcharge_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ADD CONSTRAINT `fk_contract_volume_commitment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ADD CONSTRAINT `fk_contract_volume_commitment_contract_party_id` FOREIGN KEY (`contract_party_id`) REFERENCES `transport_shipping_ecm`.`contract`.`contract_party`(`contract_party_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ADD CONSTRAINT `fk_contract_volume_actuals_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ADD CONSTRAINT `fk_contract_volume_actuals_volume_commitment_id` FOREIGN KEY (`volume_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`volume_commitment`(`volume_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ADD CONSTRAINT `fk_contract_penalty_clause_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ADD CONSTRAINT `fk_contract_penalty_clause_sla_commitment_id` FOREIGN KEY (`sla_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`sla_commitment`(`sla_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ADD CONSTRAINT `fk_contract_penalty_clause_volume_commitment_id` FOREIGN KEY (`volume_commitment_id`) REFERENCES `transport_shipping_ecm`.`contract`.`volume_commitment`(`volume_commitment_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_contract_party_id` FOREIGN KEY (`contract_party_id`) REFERENCES `transport_shipping_ecm`.`contract`.`contract_party`(`contract_party_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_penalty_clause_id` FOREIGN KEY (`penalty_clause_id`) REFERENCES `transport_shipping_ecm`.`contract`.`penalty_clause`(`penalty_clause_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ADD CONSTRAINT `fk_contract_penalty_event_sla_performance_id` FOREIGN KEY (`sla_performance_id`) REFERENCES `transport_shipping_ecm`.`contract`.`sla_performance`(`sla_performance_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ADD CONSTRAINT `fk_contract_carrier_agreement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ADD CONSTRAINT `fk_contract_lane_commitment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ADD CONSTRAINT `fk_contract_lane_commitment_carrier_agreement_id` FOREIGN KEY (`carrier_agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`carrier_agreement`(`carrier_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ADD CONSTRAINT `fk_contract_service_scope_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` ADD CONSTRAINT `fk_contract_contract_party_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `transport_shipping_ecm`.`contract`.`agreement`(`agreement_id`);

-- ========= TAGS =========
ALTER SCHEMA `transport_shipping_ecm`.`contract` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `transport_shipping_ecm`.`contract` SET TAGS ('dbx_domain' = 'contract');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement` ALTER COLUMN `parent_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Agreement Identifier (ID)');
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
ALTER TABLE `transport_shipping_ecm`.`contract`.`agreement_version` SET TAGS ('dbx_subdomain' = 'agreement_management');
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
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `sla_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Service Level Agreement (SLA) Commitment Identifier');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `service_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Corridor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `compliance_tracking_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Tracking Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `contract_sla_commitment_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `contract_sla_commitment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|expired|superseded|draft');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `escalation_procedure` SET TAGS ('dbx_business_glossary_term' = 'Escalation Procedure');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `exclusion_conditions` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Conditions');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `incentive_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Incentive Clause Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `kpi_metric` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Metric');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `penalty_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `service_mode` SET TAGS ('dbx_business_glossary_term' = 'Service Mode');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `sla_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `sla_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `sla_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Name');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `sla_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'percentage|hours|minutes|days|count|ratio');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `volume_commitment_max` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Maximum');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `volume_commitment_min` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Minimum');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_commitment` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `sla_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Performance ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Service Lane ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `sla_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Clause ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`sla_performance` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` SET TAGS ('dbx_subdomain' = 'pricing_terms');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`rate_schedule` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` SET TAGS ('dbx_subdomain' = 'pricing_terms');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `contract_surcharge_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Surcharge Schedule ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `surcharge_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Surcharge Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `supersedes_schedule_contract_surcharge_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Schedule ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_surcharge_schedule` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `volume_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Volume Commitment ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `contract_party_id` SET TAGS ('dbx_business_glossary_term' = 'Commitment Party ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `actual_volume` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renew Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `commitment_code` SET TAGS ('dbx_business_glossary_term' = 'Commitment Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `commitment_notes` SET TAGS ('dbx_business_glossary_term' = 'Commitment Notes');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `commitment_party_type` SET TAGS ('dbx_business_glossary_term' = 'Commitment Party Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `commitment_party_type` SET TAGS ('dbx_value_regex' = 'customer|carrier|3pl|4pl|vendor');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `commitment_period` SET TAGS ('dbx_business_glossary_term' = 'Commitment Period');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `commitment_period` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|contract_term');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_business_glossary_term' = 'Commitment Status');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|fulfilled|breached|pending');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `commitment_type` SET TAGS ('dbx_business_glossary_term' = 'Commitment Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `excess_incentive_currency` SET TAGS ('dbx_business_glossary_term' = 'Excess Incentive Currency');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `excess_incentive_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `excess_incentive_rate` SET TAGS ('dbx_business_glossary_term' = 'Excess Incentive Rate');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `excess_incentive_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `last_measured_date` SET TAGS ('dbx_business_glossary_term' = 'Last Measured Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `maximum_volume` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_value_regex' = 'real_time|daily|weekly|monthly|quarterly|annual');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `minimum_volume` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `rollover_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollover Allowed Flag');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `rollover_volume` SET TAGS ('dbx_business_glossary_term' = 'Rollover Volume');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Route Code');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `shortfall_penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Shortfall Penalty Currency');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `shortfall_penalty_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `shortfall_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Shortfall Penalty Rate');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `shortfall_penalty_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `target_volume` SET TAGS ('dbx_business_glossary_term' = 'Target Volume');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal|express');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Utilization Percentage');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_commitment` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `volume_actuals_id` SET TAGS ('dbx_business_glossary_term' = 'Volume Actuals ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`volume_actuals` ALTER COLUMN `volume_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Volume Commitment Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `penalty_clause_id` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `sla_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_clause` ALTER COLUMN `volume_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment ID');
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
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `penalty_event_id` SET TAGS ('dbx_business_glossary_term' = 'Penalty Event ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `cargo_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Claim Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `contract_party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `credit_note_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Note ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `penalty_clause_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Clause ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route Plan Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`penalty_event` ALTER COLUMN `sla_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Performance Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` SET TAGS ('dbx_subdomain' = 'carrier_relations');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Agreement ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Rate Card Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`carrier_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` SET TAGS ('dbx_subdomain' = 'carrier_relations');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `lane_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Commitment ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`lane_commitment` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Network Partner Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `service_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Service Scope ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `dim_weight_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Dim Weight Rule Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Network Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`contract`.`service_scope` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`contract`.`contract_party` SET TAGS ('dbx_subdomain' = 'agreement_management');
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
