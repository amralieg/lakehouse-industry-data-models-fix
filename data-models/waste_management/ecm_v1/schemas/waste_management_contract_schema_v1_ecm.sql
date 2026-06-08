-- Schema for Domain: contract | Business: Waste Management | Version: v1_ecm
-- Generated on: 2026-05-07 20:07:54

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `waste_management_ecm`.`contract` COMMENT 'Service agreements and contracts with customers including municipal solid waste contracts, commercial service agreements, hauling contracts, disposal agreements, and franchise agreements. Manages contract terms, service levels (SLA), pricing structures, rate escalation clauses, renewal dates, performance obligations, contract amendments, and lifecycle events (origination, renewal, amendment, termination). Links customers to service commitments and billing terms. Integrates with Salesforce CRM and SAP SD.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`contract` (
    `contract_id` BIGINT COMMENT 'Primary key for contract',
    `agreement_type_id` BIGINT COMMENT 'Foreign key linking to contract.agreement_type. Business justification: contract has contract_type (STRING) attribute which is semantically equivalent to agreement_type in this domain context. The agreement_type reference table provides classification for all contract and',
    `carbon_initiative_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_initiative. Business justification: Waste management contracts frequently include sustainability commitments (diversion targets, GHG reductions) tracked as formal carbon initiatives. Enables performance measurement, ESG reporting, and c',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer party to this contract. Links to the customer master record.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Contracts specify service delivery at facilities (landfills, MRFs, transfer stations). Required for facility capacity planning, contract performance tracking, regulatory compliance reporting, and reve',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Master service agreements reference applicable regulatory frameworks (RCRA, Clean Air Act, state environmental codes) governing service delivery. Links contracts to primary regulatory drivers, essenti',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Master contracts specify primary service offering being sold (residential collection, commercial recycling, hazmat). Needed for contract template selection, pricing validation, service eligibility che',
    `parent_agreement_contract_id` BIGINT COMMENT 'Identifier of the master or umbrella agreement under which this contract is subordinated. Used for multi-site or multi-service contract hierarchies. Nullable for standalone contracts.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Waste collection/disposal contracts must reference operating permits authorizing contracted services. Contract execution requires permit verification; service scope cannot exceed permitted capacity. E',
    `safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Master service contracts often mandate specific safety programs for regulatory compliance (OSHA, EPA, DOT). Required for contract compliance verification, audit trail, and performance bond validation.',
    `amendment_count` STRING COMMENT 'Number of formal amendments executed against this contract since origination. Used to track contract change history and version control.',
    `annual_escalation_percentage` DECIMAL(18,2) COMMENT 'Fixed percentage rate increase applied annually to the base service rate. Expressed as a percentage (e.g., 3.00 for 3% annual increase). Nullable if escalation is CPI-based or not applicable.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews at expiration unless either party provides notice. True for auto-renewing contracts, False for fixed-term agreements requiring explicit renewal.',
    `base_service_rate` DECIMAL(18,2) COMMENT 'Primary recurring charge amount for the contracted service. Currency is USD unless otherwise specified in contract terms. Excludes variable charges, surcharges, and taxes.',
    `billing_frequency` STRING COMMENT 'Frequency at which invoices are generated under this contract. Monthly for recurring monthly billing, Quarterly for quarterly invoicing, Annual for yearly billing, Per Service for event-based billing.. Valid values are `Monthly|Quarterly|Annual|Per Service`',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the contract. Used in customer communications, invoicing, and legal documentation.. Valid values are `^[A-Z0-9]{6,20}$`',
    `contract_status` STRING COMMENT 'Current lifecycle state of the contract. Draft for contracts under negotiation, Pending for signed but not yet effective, Active for in-force agreements, Suspended for temporarily paused contracts, Amended for contracts with modifications, Terminated for ended agreements.. Valid values are `Draft|Pending|Active|Suspended|Amended|Terminated`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this contract record was first created in the system. Used for audit trail and data lineage tracking.',
    `early_termination_penalty` DECIMAL(18,2) COMMENT 'Financial penalty amount charged if the customer terminates the contract before the expiration date. May be a fixed amount or calculated as a percentage of remaining contract value.',
    `effective_date` DATE COMMENT 'Date when the contract terms become binding and service obligations commence. Used for billing start date and service level agreement (SLA) enforcement.',
    `environmental_compliance_requirement` STRING COMMENT 'Description of environmental regulations and compliance obligations specified in the contract. May reference Resource Conservation and Recovery Act (RCRA), Clean Air Act (CAA), or state-specific environmental requirements.',
    `expiration_date` DATE COMMENT 'Date when the contract term ends and obligations cease unless renewed. Nullable for evergreen or indefinite-term contracts.',
    `force_majeure_clause` STRING COMMENT 'Description of the circumstances (natural disasters, pandemics, war, government action) that excuse non-performance of contract obligations without penalty.',
    `governing_jurisdiction` STRING COMMENT 'Legal jurisdiction whose laws govern the contract interpretation and dispute resolution. Typically a state or province code (e.g., TX, CA, ON) or country code for international contracts.',
    `indemnification_clause` STRING COMMENT 'Description of the indemnification obligations where one party agrees to protect the other from specified liabilities, claims, or damages arising from contract performance.',
    `insurance_requirement` STRING COMMENT 'Description of the insurance coverage types and minimum limits required under the contract. Typically includes general liability, auto liability, workers compensation, and environmental impairment liability.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent contract amendment execution. Nullable if no amendments have been executed.',
    `late_payment_penalty_rate` DECIMAL(18,2) COMMENT 'Percentage rate charged on overdue balances per month or per annum as specified in contract terms. Expressed as a percentage (e.g., 1.50 for 1.5% monthly).',
    `maximum_tonnage_limit` DECIMAL(18,2) COMMENT 'Maximum volume of waste in tons that the facility or service provider will accept under the contract. Common in landfill disposal agreements. Nullable for unlimited contracts.',
    `minimum_tonnage_commitment` DECIMAL(18,2) COMMENT 'Minimum volume of waste in tons that the customer commits to deliver under the contract term. Common in disposal and hauling agreements. Nullable for contracts without volume commitments.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this contract record was last updated. Used for audit trail, change tracking, and data synchronization.',
    `owner_name` STRING COMMENT 'Name of the Waste Management employee responsible for managing this contract relationship. Typically a sales representative, account manager, or municipal services manager.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date that payment is due. Common values are 15, 30, or 60 days. Used for accounts receivable (AR) aging and collections management.',
    `performance_bond_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the performance bond required under the contract. Nullable if no bond is required.',
    `performance_bond_required_flag` BOOLEAN COMMENT 'Indicates whether the contract requires the service provider to post a performance bond to guarantee service delivery. Common in municipal and franchise agreements.',
    `rate_escalation_clause` STRING COMMENT 'Description of the pricing adjustment mechanism over the contract term. May reference Consumer Price Index (CPI), fixed percentage increases, or fuel surcharge formulas.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiration that either party must provide notice to prevent auto-renewal or initiate renewal discussions. Typically 30, 60, or 90 days.',
    `salesforce_opportunity_code` STRING COMMENT 'Salesforce CRM opportunity identifier that originated this contract. Links contract to the sales pipeline and opportunity record for revenue attribution and sales performance tracking.. Valid values are `^[a-zA-Z0-9]{15,18}$`',
    `sap_contract_number` STRING COMMENT 'SAP S/4HANA Sales and Distribution (SD) module contract document number. Used for integration with SAP billing, order management, and financial accounting.. Valid values are `^[0-9]{10}$`',
    `service_level_agreement` STRING COMMENT 'Description of the performance obligations and service commitments defined in the contract. May include pickup frequency, response times, container delivery standards, and quality metrics.',
    `signed_date` DATE COMMENT 'Date when all parties executed the contract. Used for legal enforceability and contract lifecycle tracking. May differ from effective date.',
    `source_system` STRING COMMENT 'System of record that originated this contract data. Salesforce for CRM-originated contracts, SAP for ERP-originated contracts, AMCS for operations platform contracts, Manual for legacy or paper contracts.. Valid values are `Salesforce|SAP|AMCS|Manual`',
    `term_months` STRING COMMENT 'Duration of the contract term expressed in months. Common values are 12, 24, 36, or 60 months. Used for calculating expiration dates and renewal cycles.',
    `termination_clause` STRING COMMENT 'Description of the conditions and procedures under which either party may terminate the contract prior to expiration. Includes notice requirements, cause provisions, and early termination penalties.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required for contract termination. Typically 30, 60, or 90 days depending on contract type and jurisdiction.',
    `value_total` DECIMAL(18,2) COMMENT 'Total estimated revenue value of the contract over its full term. Calculated from base rates, estimated volumes, and contract duration. Used for revenue forecasting and sales performance metrics.',
    CONSTRAINT pk_contract PRIMARY KEY(`contract_id`)
) COMMENT 'Master record for all service agreements and contracts between Waste Management and its customers. Covers MSW municipal contracts, commercial service agreements, hauling contracts, disposal agreements, and franchise agreements. Stores contract number, type, status, effective/expiration dates, auto-renewal flags, governing jurisdiction, and Salesforce CRM opportunity reference. Single source of truth for contract identity and lifecycle stage (origination, active, amended, renewed, terminated). Integrates with Salesforce CRM and SAP SD.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`agreement_type` (
    `agreement_type_id` BIGINT COMMENT 'Unique identifier for the agreement type reference record. Primary key.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this agreement type is currently active and available for new contract creation. Inactive types are retained for historical reference but not used for new agreements.',
    `allows_early_termination` BOOLEAN COMMENT 'Indicates whether agreements of this type permit early termination by either party, typically subject to notice periods and potential penalties.',
    `amendment_approval_level` STRING COMMENT 'Organizational approval authority level required to amend or modify agreements of this type. Drives contract workflow routing in Salesforce CRM.. Valid values are `operations_manager|regional_director|vp_commercial|legal_counsel|board_approval`',
    `auto_renewal_eligible` BOOLEAN COMMENT 'Indicates whether agreements of this type are eligible for automatic renewal upon expiration, subject to notice periods and customer consent.',
    `compliance_framework` STRING COMMENT 'Primary regulatory compliance framework governing agreements of this type (e.g., RCRA for hazardous waste, local franchise ordinances for MSW, CERCLA for remediation contracts).',
    `contract_duration_type` STRING COMMENT 'Typical duration classification for agreements of this type. Short-term (under 1 year), long-term (multi-year), evergreen (auto-renewing), project-based (tied to specific project completion), or indefinite (no fixed end date).. Valid values are `short_term|long_term|evergreen|project_based|indefinite`',
    `created_by_user` STRING COMMENT 'User identifier or system account that created this agreement type reference record. Supports audit and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this agreement type reference record was first created in the system. Audit trail field.',
    `customer_segment` STRING COMMENT 'Primary customer segment targeted by this agreement type (e.g., municipal governments, commercial businesses, industrial facilities, residential customers, institutional entities).. Valid values are `municipal|commercial|industrial|residential|institutional`',
    `default_billing_frequency` STRING COMMENT 'Standard billing cycle frequency for agreements of this type. Drives invoice generation scheduling in Oracle Revenue Management.. Valid values are `monthly|quarterly|annual|per_service|project_milestone`',
    `default_term_months` STRING COMMENT 'Standard initial contract term length in months for agreements of this type. Null if term is project-based or indefinite.',
    `effective_end_date` DATE COMMENT 'Date when this agreement type was retired or superseded. Null if currently active. Supports temporal validity tracking.',
    `effective_start_date` DATE COMMENT 'Date when this agreement type became available for use in contract creation. Supports temporal validity tracking.',
    `hazmat_classification_required` BOOLEAN COMMENT 'Indicates whether agreements of this type require hazardous material classification and manifest tracking per Resource Conservation and Recovery Act (RCRA) and Department of Transportation (DOT) regulations.',
    `last_modified_by_user` STRING COMMENT 'User identifier or system account that last modified this agreement type reference record. Supports audit and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this agreement type reference record was last updated. Audit trail field.',
    `pricing_model` STRING COMMENT 'Standard pricing structure used for agreements of this type. Flat rate (fixed fee), per ton (weight-based), per pickup (service event-based), tiered (volume-based brackets), cost-plus (cost recovery plus margin), or negotiated (custom pricing).. Valid values are `flat_rate|per_ton|per_pickup|tiered|cost_plus|negotiated`',
    `reporting_frequency` STRING COMMENT 'Standard frequency for regulatory or customer reporting required under agreements of this type (e.g., tonnage reports, diversion rate reports, manifest submissions).. Valid values are `daily|weekly|monthly|quarterly|annual|as_required`',
    `requires_franchise_approval` BOOLEAN COMMENT 'Indicates whether agreements of this type require municipal or local government franchise approval before execution. Critical for Municipal Solid Waste (MSW) franchise agreements.',
    `requires_insurance_certificate` BOOLEAN COMMENT 'Indicates whether agreements of this type require the service provider to maintain and provide proof of general liability, environmental liability, and workers compensation insurance.',
    `requires_performance_bond` BOOLEAN COMMENT 'Indicates whether agreements of this type require the service provider to post a performance bond or financial guarantee to ensure contract obligations are met. Common for municipal franchise agreements.',
    `requires_permit` BOOLEAN COMMENT 'Indicates whether this agreement type requires an active operating permit (e.g., Resource Conservation and Recovery Act (RCRA) permit for hazardous waste, landfill operating permit, Treatment Storage and Disposal Facility (TSDF) permit).',
    `service_category` STRING COMMENT 'High-level service category that this agreement type supports. Aligns with core business process segmentation for routing, billing, and compliance workflows.. Valid values are `residential_collection|commercial_collection|roll_off_service|disposal_service|recycling_service|hazardous_waste_service`',
    `sla_template_required` BOOLEAN COMMENT 'Indicates whether agreements of this type must include a formal Service Level Agreement (SLA) defining performance obligations, response times, and service quality metrics.',
    `supports_rate_escalation` BOOLEAN COMMENT 'Indicates whether agreements of this type typically include automatic rate escalation clauses tied to Consumer Price Index (CPI), fuel surcharges, or other economic indices.',
    `termination_notice_days` STRING COMMENT 'Standard advance notice period in days required for either party to terminate agreements of this type without cause. Null if termination is not permitted or requires cause.',
    `type_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the agreement type (e.g., MSW_FRAN, COMM_HAUL, ROLLOFF, HAZ_DISP). Used as business key in operational systems and contract workflows.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `type_description` STRING COMMENT 'Detailed business description of the agreement type, including scope of services, typical customer segments, and operational characteristics.',
    `type_name` STRING COMMENT 'Full descriptive name of the agreement type (e.g., Municipal Solid Waste Franchise Agreement, Commercial Hauling Contract, Roll-Off Disposal Agreement, Hazardous Waste Treatment Storage and Disposal Facility Agreement).',
    `waste_stream_type` STRING COMMENT 'Primary waste stream classification handled under agreements of this type. Municipal Solid Waste (MSW), Construction and Demolition (C&D), recyclable materials, hazardous waste, organic waste, universal waste, or special waste. [ENUM-REF-CANDIDATE: msw|cnd|recyclable|hazardous|organic|universal_waste|special_waste — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_agreement_type PRIMARY KEY(`agreement_type_id`)
) COMMENT 'Reference classification of contract and agreement types used across Waste Managements commercial and municipal operations. Includes types such as MSW Municipal Franchise, Commercial Hauling, Roll-Off Disposal, Residential Service, Hazardous Waste Disposal, and Intermodal Transfer. Drives contract workflow routing, SLA assignment, and billing rule selection.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` (
    `contract_service_commitment_id` BIGINT COMMENT 'Unique identifier for the service commitment record. Primary key.',
    `area_id` BIGINT COMMENT 'Foreign key linking to service.service_area. Business justification: Service commitments must validate against franchise boundaries, permit coverage, and operational service areas. Critical for route planning, regulatory compliance, service feasibility validation, and ',
    `asset_container_id` BIGINT COMMENT 'Foreign key linking to asset.container. Business justification: Service commitments drive container deployment to customer sites. Essential for asset deployment tracking, service fulfillment verification, billing reconciliation, and container lifecycle management.',
    `billing_rate_schedule_id` BIGINT COMMENT 'Reference to the applicable rate schedule used for billing this service commitment.',
    `circular_economy_program_id` BIGINT COMMENT 'Foreign key linking to sustainability.circular_economy_program. Business justification: Recycling/composting service commitments are governed by specific circular economy programs that define material handling, pricing, and diversion reporting requirements. Operations teams need this lin',
    `container_type_id` BIGINT COMMENT 'Foreign key linking to service.container_type. Business justification: Service commitments specify exact container equipment for delivery and billing. Direct link needed for asset allocation, delivery scheduling, capacity validation, rental billing, and maintenance track',
    `contract_id` BIGINT COMMENT 'Reference to the parent contract or service agreement under which this service commitment is defined.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer receiving the committed service.',
    `frequency_plan_id` BIGINT COMMENT 'Foreign key linking to service.frequency_plan. Business justification: Service commitments define pickup schedules (weekly, bi-weekly, on-demand). Direct link required for route optimization, driver scheduling, SLA compliance tracking, and billing verification. Removes d',
    `jha_id` BIGINT COMMENT 'Foreign key linking to safety.jha. Business justification: Service commitments for hazardous waste, confined space work, or specialized equipment require documented Job Hazard Analysis. Essential for pre-service safety planning, crew briefings, and liability ',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: Service commitments for disposal services specify destination landfill site for capacity reservation and routing. Required for site capacity planning, contract fulfillment tracking, and customer servi',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Service commitments in contracts should reference the service catalog offering to ensure contractual terms align with defined service offerings. This enables validation that contracted services match ',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Service commitments for hazmat/special waste must align with facility permits authorizing specific waste streams at service locations. Operations teams verify permit coverage before activating service',
    `route_id` BIGINT COMMENT 'Reference to the collection route assigned to fulfill this service commitment.',
    `activated_timestamp` TIMESTAMP COMMENT 'Timestamp when the service commitment transitioned to active status and service delivery commenced.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the service commitment automatically renews at the end of its term.',
    `cancellation_notice_days` STRING COMMENT 'Number of days advance notice required for customer to cancel this service commitment.',
    `commitment_number` STRING COMMENT 'Business-readable unique identifier for the service commitment, often used in customer communications and operational systems.',
    `commitment_status` STRING COMMENT 'Current lifecycle status of the service commitment.. Valid values are `draft|active|suspended|terminated|expired|pending_activation`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service commitment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this service commitment.. Valid values are `USD|CAD|MXN`',
    `effective_end_date` DATE COMMENT 'Date when the service commitment expires or is scheduled to terminate. Null for open-ended commitments.',
    `effective_start_date` DATE COMMENT 'Date when the service commitment becomes active and service delivery begins.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether this service commitment involves collection or handling of hazardous waste materials requiring special permits and handling.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service commitment record was last updated.',
    `monthly_service_charge` DECIMAL(18,2) COMMENT 'Base monthly recurring charge for this service commitment, excluding usage-based fees.',
    `overage_charge_rate` DECIMAL(18,2) COMMENT 'Rate charged for service usage exceeding the committed volume or frequency.',
    `per_pickup_charge` DECIMAL(18,2) COMMENT 'Additional charge applied per individual pickup event, if applicable.',
    `permit_required_flag` BOOLEAN COMMENT 'Indicates whether a special operating permit or authorization is required to fulfill this service commitment.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiration that renewal notice must be provided to customer or by customer to cancel.',
    `service_address_line1` STRING COMMENT 'Primary street address line where the service is delivered.',
    `service_address_line2` STRING COMMENT 'Secondary address line (suite, unit, building) where the service is delivered.',
    `service_city` STRING COMMENT 'City where the service is delivered.',
    `service_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the service is delivered.. Valid values are `USA|CAN|MEX`',
    `service_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the service delivery location for route optimization and GPS tracking.',
    `service_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the service delivery location for route optimization and GPS tracking.',
    `service_postal_code` STRING COMMENT 'Postal or ZIP code where the service is delivered.',
    `service_start_time` TIMESTAMP COMMENT 'Preferred or contracted start time window for service delivery (e.g., 06:00-08:00).',
    `service_state_province` STRING COMMENT 'State or province where the service is delivered.',
    `sla_resolution_time_hours` STRING COMMENT 'Maximum number of hours committed to resolve service issues under this commitment.',
    `sla_response_time_hours` STRING COMMENT 'Maximum number of hours committed to respond to service requests or issues under this commitment.',
    `special_instructions` STRING COMMENT 'Free-text field capturing special handling instructions, access codes, gate information, or other operational notes for service delivery.',
    `terminated_timestamp` TIMESTAMP COMMENT 'Timestamp when the service commitment was terminated or cancelled.',
    CONSTRAINT pk_contract_service_commitment PRIMARY KEY(`contract_service_commitment_id`)
) COMMENT 'Defines specific service obligations committed under a contract, representing distinct service lines a customer is entitled to receive. Captures service type (residential curbside, commercial FEL/ASL/REL, roll-off temporary/permanent, recycling, organics, hazmat), service frequency (1x/week, 2x/week, on-call), container specification (size, type, count), collection schedule pattern, and geographic service zone or route assignment. Each agreement may have multiple service commitments. Links customers to contracted service entitlements and drives operational scheduling in AMCS route planning. References the applicable rate schedule for billing calculation.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`pricing` (
    `pricing_id` BIGINT COMMENT 'Unique identifier for the contract pricing record. Primary key for this entity.',
    `contract_id` BIGINT COMMENT 'Reference to the parent service contract or agreement to which this pricing structure applies.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Disposal and processing pricing varies by facility (tipping fees, processing rates). Required for facility-specific rate management, revenue allocation, and cost-plus pricing models at different facil',
    `approval_status` STRING COMMENT 'Workflow approval state for this pricing record. Ensures pricing changes are reviewed and authorized before activation.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved this pricing record. Part of audit trail for pricing governance.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this pricing record was approved. Part of audit trail for pricing governance and compliance.',
    `base_rate` DECIMAL(18,2) COMMENT 'The primary unit rate charged for the service or material, expressed in the currency of the contract. Does not include surcharges or adjustments.',
    `billing_frequency` STRING COMMENT 'How often this pricing component is billed to the customer. Determines invoice generation schedule.. Valid values are `monthly|quarterly|annual|per_service|on_demand`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this pricing record was first created in the source system. Part of audit trail for pricing lifecycle management.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the pricing rates and charges are denominated (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Fixed monetary discount applied to the base rate. Alternative to percentage-based discounts for negotiated contract pricing.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the base rate for this pricing component. Used for volume discounts, promotional pricing, or negotiated contract terms.',
    `effective_end_date` DATE COMMENT 'The date on which this pricing structure ceases to be active. Nullable for open-ended pricing agreements. Supports rate change management and contract amendments.',
    `effective_start_date` DATE COMMENT 'The date from which this pricing structure becomes active and applicable to billing. Part of the pricing lifecycle management.',
    `environmental_fee_applicable` BOOLEAN COMMENT 'Indicates whether environmental recovery fees are applied to recover costs of environmental compliance, recycling programs, or sustainability initiatives.',
    `escalation_frequency` STRING COMMENT 'How often the rate escalation is applied (e.g., annually on contract anniversary, quarterly based on fuel index).. Valid values are `annual|semi_annual|quarterly|monthly|none`',
    `escalation_rate` DECIMAL(18,2) COMMENT 'The percentage rate at which pricing increases during escalation events. Used for fixed-percentage escalation types.',
    `escalation_type` STRING COMMENT 'Method by which the pricing rate increases over time. Supports automatic rate adjustments per contract terms (e.g., annual CPI adjustment, fixed 3% increase).. Valid values are `fixed_percentage|cpi_indexed|fuel_index|custom_formula|none`',
    `fuel_surcharge_applicable` BOOLEAN COMMENT 'Indicates whether a variable fuel surcharge is applied to this pricing component based on diesel fuel price indices.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this pricing record was most recently updated. Supports change tracking and audit compliance.',
    `maximum_charge` DECIMAL(18,2) COMMENT 'The maximum amount that can be billed for this pricing component in a billing cycle. Provides a cap for high-volume customers or regulatory compliance.',
    `minimum_charge` DECIMAL(18,2) COMMENT 'The minimum amount that will be billed for this pricing component, regardless of usage or volume. Ensures revenue floor for low-volume customers.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this pricing record. Part of audit trail for pricing governance.',
    `next_escalation_date` DATE COMMENT 'The scheduled date for the next automatic rate increase. Used for proactive rate change notifications and billing system updates.',
    `notes` STRING COMMENT 'Free-text field for additional pricing details, special terms, or explanations of custom pricing arrangements. Used for documentation and customer service reference.',
    `pricing_code` STRING COMMENT 'Business identifier for the pricing structure, used for external reference and reporting.',
    `pricing_status` STRING COMMENT 'Current lifecycle state of this pricing record. Controls whether the pricing is used in billing calculations.. Valid values are `active|pending|expired|suspended|superseded`',
    `pricing_type` STRING COMMENT 'Category of pricing component. Defines the nature of the charge applied to the contract. [ENUM-REF-CANDIDATE: base_service_rate|tipping_fee|container_rental|fuel_surcharge|environmental_recovery_fee|regulatory_cost_recovery|disposal_fee|hauling_fee|processing_fee|administrative_fee — 10 candidates stripped; promote to reference product]',
    `proration_allowed` BOOLEAN COMMENT 'Indicates whether partial-period charges are calculated when service starts or ends mid-cycle. Supports accurate billing for contract changes.',
    `rate_basis` STRING COMMENT 'Unit of measure on which the pricing rate is calculated (e.g., per-lift for collection, per-ton for disposal, per-yard for container volume). [ENUM-REF-CANDIDATE: per_lift|per_ton|per_yard|per_month|per_service|flat_rate|per_gallon|per_container — 8 candidates stripped; promote to reference product]',
    `regulatory_fee_applicable` BOOLEAN COMMENT 'Indicates whether regulatory cost recovery charges are applied to recover costs of permits, compliance monitoring, or mandated reporting.',
    `source_record_code` STRING COMMENT 'The unique identifier of this pricing record in the source system. Enables traceability and cross-system reconciliation.',
    `source_system` STRING COMMENT 'The operational system from which this pricing record originated (e.g., Oracle Revenue Management, SAP SD, Salesforce CPQ). Used for data lineage and reconciliation.',
    `tax_exempt` BOOLEAN COMMENT 'Indicates whether this pricing component is exempt from sales tax or other applicable taxes. Typically applies to municipal contracts or non-profit customers.',
    `tier_level` STRING COMMENT 'Sequence number for tiered pricing structures. Used when pricing varies by volume thresholds (e.g., tier 1 for 0-10 tons, tier 2 for 10-50 tons). Null for non-tiered pricing.',
    `tier_maximum_quantity` DECIMAL(18,2) COMMENT 'The maximum quantity threshold for this pricing tier. Nullable for the highest tier with no upper limit.',
    `tier_minimum_quantity` DECIMAL(18,2) COMMENT 'The minimum quantity threshold for this pricing tier. Used in volume-based pricing models to define tier breakpoints.',
    CONSTRAINT pk_pricing PRIMARY KEY(`pricing_id`)
) COMMENT 'Defines the pricing structure and rate tables associated with a contract, including base service rates, tipping fees (per-ton disposal charges), container rental fees, fuel surcharges, environmental recovery fees, and regulatory cost recovery charges. Stores rate effective dates, rate basis (per-lift, per-ton, per-yard, flat monthly), and currency. Supports complex commercial pricing models including tiered tonnage rates and volume discounts. Sourced from Oracle Revenue Management and SAP SD.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`rate_line` (
    `rate_line_id` BIGINT COMMENT 'Unique identifier for the rate line item within the rate schedule. Primary key.',
    `billing_rate_schedule_id` BIGINT COMMENT 'Reference to the parent rate schedule that contains this rate line. Links this line item to the overall pricing structure for a customer contract.',
    `approval_status` STRING COMMENT 'Approval workflow status for this rate line. Tracks whether the rate has been drafted, is pending management approval, has been approved for use, or was rejected.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'Username or identifier of the person who approved this rate line for use in customer contracts. Used for audit trail and accountability.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this rate line was approved. Provides audit trail for rate approval process and regulatory compliance.',
    `arrears_advance_indicator` STRING COMMENT 'Indicates whether this rate line is billed in arrears (after service delivery) or in advance (before service delivery). Affects revenue recognition timing.. Valid values are `arrears|advance`',
    `billing_frequency` STRING COMMENT 'Frequency at which this rate line is billed to the customer. Options include monthly, quarterly, annual, per-service event, or on-demand billing.. Valid values are `monthly|quarterly|annual|per_service|on_demand`',
    `charge_description` STRING COMMENT 'Detailed business description of the charge component. Provides clarity on what this rate line represents for billing transparency and customer communication.',
    `charge_type` STRING COMMENT 'Category of charge represented by this rate line. Defines the nature of the pricing component (e.g., base collection rate, tipping fee, fuel surcharge, environmental fee, container rental, overage charge, special handling fee).. Valid values are `base_collection|tipping_fee|fuel_surcharge|environmental_fee|container_rental|overage_charge`',
    `cost_center_code` STRING COMMENT 'Cost center responsible for delivering the service associated with this rate line. Used for internal cost allocation and profitability analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this rate line record was first created in the system. Provides audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit price. Typically USD for U.S. operations but supports multi-currency contracts.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount discount applied to this rate line. Alternative to percentage-based discounts for absolute price reductions.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the unit price for this rate line. Used for promotional pricing, volume discounts, or negotiated contract terms.',
    `effective_end_date` DATE COMMENT 'Date when this rate line expires or is superseded by a new rate. Null indicates the rate line is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this rate line becomes active and applicable for billing. Supports rate changes and contract amendments with future-dated pricing.',
    `escalation_frequency` STRING COMMENT 'Frequency at which rate escalation is applied. Common values include annual, semi-annual, quarterly, or monthly adjustments.. Valid values are `annual|semi_annual|quarterly|monthly`',
    `escalation_method` STRING COMMENT 'Method used for automatic rate escalation over time. Options include no escalation, fixed percentage increase, Consumer Price Index (CPI) adjustment, fuel index linkage, or custom formula.. Valid values are `none|fixed_percentage|cpi|fuel_index|custom`',
    `escalation_percentage` DECIMAL(18,2) COMMENT 'Annual percentage increase applied to the unit price when using fixed percentage escalation method. Typically ranges from 2% to 5% for waste management contracts.',
    `gl_account_code` STRING COMMENT 'General ledger account code for revenue recognition. Maps this rate line to the appropriate revenue account in the financial system for accounting and reporting purposes.',
    `is_mandatory` BOOLEAN COMMENT 'Boolean flag indicating whether this rate line is a mandatory charge that cannot be waived or removed from the contract. True means mandatory, false means optional.',
    `is_recurring` BOOLEAN COMMENT 'Boolean flag indicating whether this rate line represents a recurring charge (true) or a one-time charge (false). Used for subscription-based billing models.',
    `is_taxable` BOOLEAN COMMENT 'Boolean flag indicating whether this rate line is subject to sales tax or other applicable taxes. True means taxable, false means tax-exempt.',
    `line_sequence_number` STRING COMMENT 'Sequential ordering of this rate line within the parent rate schedule. Used for display and processing order.',
    `maximum_charge` DECIMAL(18,2) COMMENT 'Maximum charge cap for this rate line. Limits the total charge amount to protect customers from excessive billing in high-usage scenarios.',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Minimum charge amount that applies regardless of usage or quantity. Ensures a baseline revenue for the service even if consumption is below threshold.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this rate line record was last modified. Tracks changes for audit purposes and data quality monitoring.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special instructions, or clarifications about this rate line. Used for internal documentation and customer communication.',
    `proration_rule` STRING COMMENT 'Rule for prorating charges when service starts or ends mid-period. Options include daily proration, monthly proration, no proration, or custom calculation method.. Valid values are `daily|monthly|none|custom`',
    `rate_basis` STRING COMMENT 'Methodology used to calculate the rate. Options include flat rate, tiered pricing, volume-based, weight-based, or frequency-based. Defines the pricing model structure.. Valid values are `flat|tiered|volume|weight|frequency`',
    `rate_line_status` STRING COMMENT 'Current lifecycle status of this rate line. Active means currently in use for billing, inactive means not applied, pending means scheduled for future activation, superseded means replaced by a newer rate line.. Valid values are `active|inactive|pending|superseded`',
    `revenue_category` STRING COMMENT 'High-level revenue classification for financial reporting and analytics. Groups rate lines into business segments such as collection revenue, disposal revenue, recycling revenue, rental revenue, surcharge, or fee.. Valid values are `collection|disposal|recycling|rental|surcharge|fee`',
    `service_type` STRING COMMENT 'Type of waste management service this rate line applies to. Aligns charge with specific service offerings such as residential collection, commercial collection, roll-off, recycling, hazardous waste, or special waste handling.. Valid values are `residential_collection|commercial_collection|roll_off|recycling|hazardous_waste|special_waste`',
    `tax_code` STRING COMMENT 'Tax classification code that determines applicable sales tax, use tax, or environmental taxes for this rate line. Links to tax jurisdiction and rate tables.',
    `tier_threshold_lower` DECIMAL(18,2) COMMENT 'Lower bound threshold for tiered pricing. Defines the minimum quantity or usage level at which this rate line applies. Used in conjunction with tiered rate structures.',
    `tier_threshold_upper` DECIMAL(18,2) COMMENT 'Upper bound threshold for tiered pricing. Defines the maximum quantity or usage level at which this rate line applies. Null indicates no upper limit for the tier.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the rate calculation. Common values include per-ton, per-lift, per-yard, per-gallon, per-month, each, or per-trip. Defines how the charge is quantified. [ENUM-REF-CANDIDATE: ton|lift|yard|gallon|month|each|trip — 7 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of measure for this rate line. The base rate applied to calculate the charge amount based on quantity consumed or service frequency.',
    CONSTRAINT pk_rate_line PRIMARY KEY(`rate_line_id`)
) COMMENT 'Individual line-item pricing components within a rate schedule. Each rate line captures a specific charge element: base collection rate, tipping fee, fuel surcharge, environmental fee, container rental, overage charge, or special handling fee. Stores unit of measure (per-ton, per-lift, per-yard, per-month), unit price, minimum charge, and applicable service type. Enables granular billing calculation and rate transparency for commercial and municipal customers.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`escalation_clause` (
    `escalation_clause_id` BIGINT COMMENT 'Unique identifier for the escalation clause record. Primary key.',
    `contract_id` BIGINT COMMENT 'Reference to the parent contract that contains this escalation clause.',
    `amendment_reference` STRING COMMENT 'Reference number or identifier of the contract amendment that introduced or modified this escalation clause. Null for clauses in original contract.',
    `applies_to_service_types` STRING COMMENT 'Comma-separated list of service types to which this escalation clause applies (e.g., residential_collection, commercial_hauling, disposal_fees, recycling_processing). Allows selective application of escalation to specific contract line items.',
    `base_index_date` DATE COMMENT 'The date on which the base index value was established, typically the contract effective date or last escalation reset date.',
    `base_index_value` DECIMAL(18,2) COMMENT 'The baseline index value established at contract origination or last reset, against which future index values are compared to calculate escalation percentage.',
    `calculation_methodology` STRING COMMENT 'Detailed description of how the escalation percentage is calculated, including formulas, rounding rules, and any special provisions (e.g., Calculate percentage change from base index to current index, round to two decimal places, apply cap if exceeded).',
    `clause_number` STRING COMMENT 'Business identifier for the escalation clause within the contract (e.g., Section 4.2, Clause E-1).',
    `compounding_method` STRING COMMENT 'How escalations are calculated over multiple periods. Simple = each escalation applies to original base rate; compound = each escalation applies to previously escalated rate; reset_to_base = rate resets to base and new escalation calculated from current index.. Valid values are `simple|compound|reset_to_base`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this escalation clause record was first created in the system.',
    `customer_approval_required` BOOLEAN COMMENT 'Indicates whether customer approval or acceptance is required before escalated rates take effect. True for some municipal contracts with board approval requirements; false for automatic escalations.',
    `dispute_period_days` STRING COMMENT 'Number of days after notification during which customer may dispute the escalation calculation or request review. Null if no dispute period is contractually defined.',
    `effective_date` DATE COMMENT 'The date when this escalation clause becomes active and begins governing rate adjustments.',
    `escalation_cap_percentage` DECIMAL(18,2) COMMENT 'Maximum allowable rate increase percentage in any single escalation period, protecting customers from excessive increases during high inflation periods (e.g., 5.00 represents 5% cap).',
    `escalation_clause_status` STRING COMMENT 'Current lifecycle status of the escalation clause. Active = currently in effect; suspended = temporarily not applied; expired = past expiration date; superseded = replaced by amendment; pending_approval = awaiting customer or internal approval.. Valid values are `active|suspended|expired|superseded|pending_approval`',
    `escalation_floor_percentage` DECIMAL(18,2) COMMENT 'Minimum rate increase percentage guaranteed in any escalation period, ensuring revenue growth even during deflationary periods (e.g., 1.00 represents 1% floor). Null if no floor applies.',
    `escalation_type` STRING COMMENT 'Type of rate escalation mechanism applied. CPI (Consumer Price Index) escalation adjusts rates based on inflation indices; PPI (Producer Price Index) escalation ties to producer cost changes; fuel index escalation adjusts for fuel cost fluctuations; fixed percentage applies a predetermined annual increase; disposal cost passthrough allows direct pass-through of landfill tipping fee increases; labor cost index ties to wage inflation; hybrid combines multiple escalation methods. [ENUM-REF-CANDIDATE: cpi|ppi|fuel_index|fixed_percentage|disposal_cost_passthrough|labor_cost_index|hybrid — 7 candidates stripped; promote to reference product]',
    `exclusions` STRING COMMENT 'Description of any charges or fees explicitly excluded from this escalation clause (e.g., regulatory fees, environmental surcharges, one-time charges). Free-text field capturing negotiated exclusions.',
    `expiration_date` DATE COMMENT 'The date when this escalation clause expires or is superseded. Null for clauses that remain active through contract term.',
    `fixed_escalation_percentage` DECIMAL(18,2) COMMENT 'The predetermined annual percentage increase applied to rates for fixed percentage escalation clauses (e.g., 3.00 represents 3% annual increase). Null for index-based escalations.',
    `index_reference` STRING COMMENT 'Specific economic index or benchmark used for escalation calculation (e.g., CPI-U All Urban Consumers, PPI Waste Management Services, DOE Diesel Fuel Index, Regional CPI). Null for fixed percentage escalations.',
    `last_escalation_date` DATE COMMENT 'The date when the most recent rate escalation was applied under this clause. Null if no escalation has occurred yet.',
    `last_escalation_percentage` DECIMAL(18,2) COMMENT 'The actual percentage increase applied during the most recent escalation event (e.g., 2.75 represents 2.75% increase). Used for historical tracking and forecasting.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this escalation clause record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this escalation clause record was last modified.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next escalation review and rate adjustment calculation. Critical for proactive customer rate notifications and revenue forecasting.',
    `notes` STRING COMMENT 'Free-text field for additional context, special provisions, negotiation history, or operational notes related to this escalation clause.',
    `notification_days_advance` STRING COMMENT 'Number of days prior to rate change effective date that customer must be notified, as stipulated in contract terms (e.g., 30, 60, 90 days). Required for compliance with municipal contract notification requirements.',
    `review_frequency` STRING COMMENT 'How often the escalation clause is reviewed and rates are adjusted (annual = once per year, semi-annual = twice per year, quarterly = four times per year, biennial = every two years, monthly = every month).. Valid values are `annual|semi_annual|quarterly|biennial|monthly`',
    `supporting_documentation_required` BOOLEAN COMMENT 'Indicates whether supporting documentation (index reports, cost data, calculations) must be provided to customer with escalation notification. True for municipal contracts requiring transparency; false for standard commercial agreements.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this escalation clause record in the system.',
    CONSTRAINT pk_escalation_clause PRIMARY KEY(`escalation_clause_id`)
) COMMENT 'Captures rate escalation provisions embedded in contracts, including CPI (Consumer Price Index) escalation, fuel index escalation, fixed annual percentage increases, and disposal cost pass-through clauses. Stores escalation type, index reference (CPI-U, PPI), escalation cap percentage, floor percentage, review frequency (annual, semi-annual), and next escalation review date. Critical for revenue forecasting and proactive customer rate notifications. Sourced from Salesforce CRM contract terms.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`sla_term` (
    `sla_term_id` BIGINT COMMENT 'Unique identifier for the SLA term record. Primary key.',
    `contract_id` BIGINT COMMENT 'Reference to the parent contract that contains this SLA term. Links the SLA term to the governing service agreement.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: SLA terms often specify facility-specific performance metrics (turnaround time at MRFs, acceptance windows at landfills). Required for facility performance monitoring, SLA compliance tracking, and pen',
    `reduction_target_id` BIGINT COMMENT 'Foreign key linking to sustainability.reduction_target. Business justification: SLA terms in waste contracts often include sustainability performance metrics (e.g., achieve 75% diversion rate) that map to formal reduction targets. Enables automated SLA compliance monitoring, pe',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: SLA terms (response times for hazmat incidents, missed pickup resolution) are often mandated by regulatory requirements (RCRA, state codes). Links contractual service levels to regulatory drivers, ess',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.customer_segment. Business justification: SLA terms vary by customer segment (residential 48hr vs commercial 24hr vs municipal 4hr response). Segment linkage enables segment-specific SLA template application, performance benchmarking, and aut',
    `sla_definition_id` BIGINT COMMENT 'Foreign key linking to service.sla_definition. Business justification: Contract SLA terms should reference standard service-level definitions for consistency and template application. Needed for SLA performance measurement standardization, penalty calculation automation,',
    `amendment_date` DATE COMMENT 'The date when the most recent amendment to this SLA term was executed. Null if never amended.',
    `amendment_number` STRING COMMENT 'Sequential number indicating how many times this SLA term has been amended since the original contract. Zero for original terms.',
    `amendment_reason` STRING COMMENT 'Business justification for the most recent amendment to this SLA term (e.g., service scope change, performance improvement initiative, regulatory requirement, customer request).',
    `baseline_period_end_date` DATE COMMENT 'The end date of the period used to establish the baseline performance value.',
    `baseline_period_start_date` DATE COMMENT 'The start date of the period used to establish the baseline performance value.',
    `baseline_value` DECIMAL(18,2) COMMENT 'The historical or initial performance level used as a reference point for measuring improvement or setting targets.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this SLA term record was first created in the system.',
    `data_source_system` STRING COMMENT 'The operational system or platform from which performance data for this SLA metric is extracted (e.g., AMCS Platform, Locus Dispatch, Salesforce CRM, Geotab Fleet Telematics).',
    `effective_end_date` DATE COMMENT 'The date when this SLA term expires or is no longer in effect. Null for open-ended terms.',
    `effective_start_date` DATE COMMENT 'The date when this SLA term becomes active and performance measurement begins.',
    `escalation_procedure` STRING COMMENT 'Description of the escalation process when performance falls below the escalation threshold (e.g., notify regional manager, schedule customer meeting, initiate corrective action plan).',
    `escalation_threshold_value` DECIMAL(18,2) COMMENT 'The performance level that triggers escalation procedures or management notification (typically worse than the target threshold).',
    `exclusion_conditions` STRING COMMENT 'Circumstances under which the SLA obligation does not apply (e.g., force majeure events, customer-caused delays, extreme weather, equipment failure beyond control, regulatory shutdowns).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this SLA term record was most recently updated.',
    `measurement_frequency` STRING COMMENT 'How often the SLA metric is measured and evaluated (daily, weekly, monthly, quarterly, annually, per incident, continuous). [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|annually|per_incident|continuous — 7 candidates stripped; promote to reference product]',
    `measurement_methodology` STRING COMMENT 'Detailed description of how the SLA metric is calculated, including data sources, calculation formulas, and any adjustments or exclusions applied.',
    `measurement_period_days` STRING COMMENT 'The rolling or fixed period in days over which the SLA metric is calculated (e.g., 30 for monthly rolling average, 90 for quarterly).',
    `notes` STRING COMMENT 'Additional context, clarifications, or special instructions related to this SLA term that do not fit in other structured fields.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The monetary value of the penalty or service credit applied per occurrence or period of non-compliance. Null if penalty is non-monetary.',
    `penalty_calculation_method` STRING COMMENT 'Description of how the penalty is calculated (e.g., flat fee per incident, percentage of monthly service fee, tiered based on severity, prorated by days of non-compliance).',
    `penalty_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the penalty amount (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `penalty_provision_flag` BOOLEAN COMMENT 'Indicates whether financial penalties or service credits apply for non-compliance with this SLA term (True if penalties exist, False otherwise).',
    `penalty_type` STRING COMMENT 'The type of penalty or remedy applied when the SLA is not met (service credit, financial penalty, rate reduction, contract termination right, none).. Valid values are `service_credit|financial_penalty|rate_reduction|contract_termination_right|none`',
    `reporting_format` STRING COMMENT 'The format in which SLA performance must be reported (e.g., PDF dashboard, Excel spreadsheet, online portal, email summary, API feed).',
    `reporting_frequency` STRING COMMENT 'How often SLA performance reports must be delivered to the customer (daily, weekly, monthly, quarterly, annually, on request, none). [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|annually|on_request|none — 7 candidates stripped; promote to reference product]',
    `reporting_requirement_flag` BOOLEAN COMMENT 'Indicates whether formal reporting of this SLA metric to the customer is required (True if reporting is mandatory, False otherwise).',
    `responsible_party` STRING COMMENT 'The party responsible for meeting this SLA obligation (Waste Management, customer, third party, shared responsibility).. Valid values are `waste_management|customer|third_party|shared`',
    `sla_category` STRING COMMENT 'The category of SLA term grouping related performance obligations (collection performance, response time, service quality, safety compliance, environmental compliance, customer satisfaction).. Valid values are `collection_performance|response_time|service_quality|safety_compliance|environmental_compliance|customer_satisfaction`',
    `sla_metric_code` STRING COMMENT 'Standardized code for the SLA metric to enable consistent tracking and reporting across contracts.',
    `sla_metric_name` STRING COMMENT 'The name of the performance metric being measured (e.g., On-Time Collection Rate, Missed Pickup Response Time, Container Delivery Lead Time, Complaint Resolution Time, Contamination Notification Time).',
    `sla_term_status` STRING COMMENT 'Current lifecycle status of the SLA term (active, suspended, expired, superseded, draft, cancelled).. Valid values are `active|suspended|expired|superseded|draft|cancelled`',
    `target_threshold_value` DECIMAL(18,2) COMMENT 'The numeric target value that must be met or exceeded to satisfy the SLA obligation (e.g., 98.5 for 98.5% on-time rate, 4 for 4-hour response time).',
    `threshold_operator` STRING COMMENT 'The comparison operator defining how actual performance is evaluated against the target (greater than or equal, less than or equal, equal, greater than, less than).. Valid values are `greater_than_or_equal|less_than_or_equal|equal|greater_than|less_than`',
    `threshold_unit_of_measure` STRING COMMENT 'The unit of measurement for the target threshold (percentage, hours, days, minutes, count, tons, cubic yards). [ENUM-REF-CANDIDATE: percentage|hours|days|minutes|count|tons|cubic_yards — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_sla_term PRIMARY KEY(`sla_term_id`)
) COMMENT 'Service Level Agreement terms defined within a contract, specifying performance obligations such as on-time collection rate, missed pickup response time, container delivery lead time, complaint resolution SLA, and contamination notification requirements. Stores SLA metric name, target threshold, measurement frequency, penalty provisions for non-compliance, and reporting requirements. Supports SLA monitoring and customer performance reporting. Aligns with Salesforce CRM SLA tracking.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`amendment` (
    `amendment_id` BIGINT COMMENT 'Unique identifier for the contract amendment record. Primary key.',
    `contract_id` BIGINT COMMENT 'Reference to the parent contract being amended. Links to the original service agreement or contract.',
    `document_id` BIGINT COMMENT 'Foreign key linking to contract.document. Business justification: Amendments are formal contract modifications that generate legal documents tracked in the document product. Currently amendment.document_reference is a STRING field - this should be normalized to a pr',
    `superseded_by_amendment_id` BIGINT COMMENT 'Reference to a subsequent amendment that supersedes or replaces this amendment. Null if this is the current active amendment.',
    `amendment_description` STRING COMMENT 'Detailed narrative description of the changes being made to the contract, including business rationale and scope of modifications.',
    `amendment_number` STRING COMMENT 'Business identifier for the amendment, typically sequential or hierarchical (e.g., A-001, A-002). Used for external reference and tracking.',
    `amendment_status` STRING COMMENT 'Current lifecycle status of the amendment in the approval and execution workflow. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|rejected|executed|cancelled|superseded — 7 candidates stripped; promote to reference product]',
    `amendment_type` STRING COMMENT 'Classification of the amendment based on the nature of the change being made to the contract. [ENUM-REF-CANDIDATE: scope_change|rate_adjustment|service_addition|service_removal|term_extension|sla_revision|pricing_structure_change|volume_adjustment|equipment_change|other — 10 candidates stripped; promote to reference product]',
    `approved_by` STRING COMMENT 'Name or identifier of the approving authority who authorized the amendment. May be a manager, legal counsel, or executive depending on amendment materiality.',
    `approved_date` DATE COMMENT 'Date when the amendment received final approval and was authorized for execution.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the amendment record was first created in the system. Part of audit trail.',
    `customer_signature_required` BOOLEAN COMMENT 'Indicates whether customer signature is required for this amendment to be legally binding.',
    `customer_signed_date` DATE COMMENT 'Date when the customer signed the amendment, if customer signature was required.',
    `effective_date` DATE COMMENT 'Date when the amendment terms become binding and enforceable. May differ from approval or execution date.',
    `executed_date` DATE COMMENT 'Date when the amendment was formally executed or signed by all parties.',
    `expiration_date` DATE COMMENT 'Date when the amendment terms expire or are superseded. Nullable for permanent amendments.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated total financial impact of the amendment over its effective period. Positive for revenue increases, negative for decreases.',
    `legal_review_required` BOOLEAN COMMENT 'Indicates whether legal department review and approval is required for this amendment based on materiality thresholds.',
    `legal_reviewed_by` STRING COMMENT 'Name or identifier of the legal counsel who reviewed the amendment, if legal review was required.',
    `legal_reviewed_date` DATE COMMENT 'Date when legal review was completed and the amendment was cleared by legal counsel.',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified the amendment record. Part of audit trail.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the amendment record was last modified. Updated on every change. Part of audit trail.',
    `notes` STRING COMMENT 'Additional free-form notes, comments, or internal annotations related to the amendment processing or special considerations.',
    `rate_change_amount` DECIMAL(18,2) COMMENT 'Monetary value of rate adjustment if the amendment involves pricing changes. Positive for increases, negative for decreases.',
    `rate_change_percentage` DECIMAL(18,2) COMMENT 'Percentage change in rates if the amendment involves pricing adjustments. Expressed as a decimal (e.g., 5.00 for 5%).',
    `reason_code` STRING COMMENT 'Standardized code indicating the primary business driver or trigger for the amendment. [ENUM-REF-CANDIDATE: customer_request|regulatory_change|market_adjustment|service_expansion|cost_recovery|performance_issue|merger_acquisition|other — 8 candidates stripped; promote to reference product]',
    `requested_by` STRING COMMENT 'Name or identifier of the individual or department who initiated the amendment request.',
    `requested_date` DATE COMMENT 'Date when the amendment was formally requested or initiated in the system.',
    `scope_change_description` STRING COMMENT 'Detailed description of changes to the scope of services, including additions, removals, or modifications to service offerings.',
    `service_level_change_description` STRING COMMENT 'Detailed description of changes to service level commitments, performance obligations, or SLA metrics.',
    `source_system` STRING COMMENT 'Identifier of the operational system from which this amendment record originated (Salesforce CRM, SAP SD, etc.).. Valid values are `salesforce_crm|sap_sd|manual_entry|data_migration|other`',
    `source_system_code` STRING COMMENT 'Original unique identifier of the amendment in the source system, used for traceability and reconciliation.',
    `term_extension_months` STRING COMMENT 'Number of months by which the contract term is extended, if applicable. Null if amendment does not affect contract duration.',
    `version_number` STRING COMMENT 'Sequential version number for tracking revisions to the amendment during draft and approval stages.',
    `created_by` STRING COMMENT 'User identifier or system account that created the amendment record. Part of audit trail.',
    CONSTRAINT pk_amendment PRIMARY KEY(`amendment_id`)
) COMMENT 'Records all formal modifications to an existing contract including scope changes, rate adjustments, service additions or removals, term extensions, and SLA revisions. Each amendment captures amendment number, effective date, amendment type, description of changes, approval status, approving authority, and reference to the original agreement. Maintains a complete audit trail of contract evolution from origination through termination. Sourced from Salesforce CRM and SAP SD change orders.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`renewal` (
    `renewal_id` BIGINT COMMENT 'Unique identifier for the contract renewal event. Primary key.',
    `amendment_id` BIGINT COMMENT 'Reference to the contract amendment record if renewal triggered formal amendment. Links to contract amendment tracking in Salesforce CRM. Null if no amendment was required.',
    `contract_id` BIGINT COMMENT 'Reference to the parent contract being renewed. Links to the contract master record in Salesforce CRM.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer associated with this renewal. Links to customer master data in Salesforce CRM.',
    `employee_id` BIGINT COMMENT 'Reference to the sales representative or account manager responsible for managing this renewal. Links to employee master data in Workday Human Capital Management (HCM).',
    `renewal_approved_by_employee_id` BIGINT COMMENT 'Reference to the manager or executive who approved the renewal terms. Links to employee master data in Workday HCM. Null if no approval was required.',
    `amendment_required_flag` BOOLEAN COMMENT 'Indicates whether renewal resulted in formal contract amendment documentation due to material changes in terms, pricing, or service scope. True if amendment executed; False if renewal proceeded under existing contract framework.',
    `approval_date` DATE COMMENT 'Date when renewal terms were approved by authorized manager or executive. Null if no approval was required or approval is still pending.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether renewal terms required management approval due to rate concessions, service modifications, or contract value thresholds. True if approval workflow triggered; False if within standard authority limits.',
    `auto_renewal_eligible_flag` BOOLEAN COMMENT 'Indicates whether the contract is eligible for automatic renewal based on original contract terms. True if auto-renewal clause exists and conditions are met; False if manual renewal process required.',
    `churn_risk_score` DECIMAL(18,2) COMMENT 'Predictive score (0.00 to 1.00) indicating likelihood of customer not renewing, calculated at renewal notice date. Higher scores indicate greater risk of churn. Derived from customer payment history, service complaints, competitive activity, and engagement metrics.',
    `competitor_name` STRING COMMENT 'Name of competing waste management company that customer was considering during renewal, if disclosed. Used for competitive analysis and market intelligence.',
    `competitor_threat_flag` BOOLEAN COMMENT 'Indicates whether customer indicated they were considering or received offers from competing waste management providers during renewal process. True if competitive threat identified; False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the renewal record was first created in the system. Audit field for data lineage and compliance tracking.',
    `customer_response_date` DATE COMMENT 'Date when the customer provided their decision on the renewal offer (accepted, declined, or requested renegotiation).',
    `effective_date` DATE COMMENT 'Date when the renewed contract term begins. Typically aligns with the expiration date of the previous term.',
    `escalation_basis` STRING COMMENT 'Method used to calculate rate increase at renewal. CPI: Consumer Price Index adjustment. Fixed Percentage: predetermined annual increase. Market Rate: adjustment to current market pricing. Negotiated: custom rate agreed during renewal discussion. None: no escalation applied.. Valid values are `cpi|fixed_percentage|market_rate|negotiated|none`',
    `expiration_date` DATE COMMENT 'Date when the renewed contract term ends. Defines the end of the new commitment period.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the renewal record was last updated. Audit field for change tracking and data quality monitoring.',
    `notes` STRING COMMENT 'Free-text field for account manager to document renewal discussions, customer feedback, negotiation details, special considerations, or other contextual information relevant to the renewal process.',
    `notice_date` DATE COMMENT 'Date when the renewal notice was sent to the customer, typically 60-90 days before contract expiration per Service Level Agreement (SLA) terms.',
    `offer_date` DATE COMMENT 'Date when formal renewal terms and pricing were presented to the customer. May differ from notice date if negotiation occurred.',
    `opt_out_date` DATE COMMENT 'Date when customer submitted formal opt-out notice for auto-renewal. Must be received within notice period specified in contract (typically 30-90 days before expiration). Null if no opt-out received.',
    `opt_out_received_flag` BOOLEAN COMMENT 'Indicates whether customer provided written notice to opt out of auto-renewal within the required notice period. True if opt-out notice received; False otherwise. Relevant only for contracts with auto-renewal clauses.',
    `outcome` STRING COMMENT 'Business result of the renewal process. Retained: customer renewed at similar service level. Lost: customer declined renewal and terminated service. Expanded: customer renewed with increased service scope or value. Downsized: customer renewed with reduced service scope or value.. Valid values are `retained|lost|expanded|downsized`',
    `previous_annual_value` DECIMAL(18,2) COMMENT 'Total annual revenue from the contract term prior to renewal, expressed in USD. Used as baseline for rate change calculation.',
    `previous_term_end_date` DATE COMMENT 'End date of the contract term that preceded this renewal. Typically one day before renewal_effective_date.',
    `previous_term_start_date` DATE COMMENT 'Start date of the contract term that preceded this renewal. Used for historical tracking and term comparison.',
    `rate_change_percentage` DECIMAL(18,2) COMMENT 'Percentage change in annual contract value from previous term to renewed term. Positive values indicate rate increase (escalation), negative values indicate discount or concession. Calculated as ((renewed_annual_value - previous_annual_value) / previous_annual_value) * 100.',
    `rate_escalation_clause_applied` BOOLEAN COMMENT 'Indicates whether a contractual rate escalation clause (e.g., Consumer Price Index (CPI) adjustment, fixed percentage increase) was applied at renewal. True if escalation clause triggered; False if rates remained flat or were manually adjusted.',
    `renewal_number` STRING COMMENT 'Business-facing unique identifier for the renewal event. Format: RNW-YYYYMMDD followed by sequence. Used in customer communications and internal tracking.. Valid values are `^RNW-[0-9]{8}$`',
    `renewal_status` STRING COMMENT 'Current lifecycle state of the renewal. Pending: renewal window opened but no action taken. Offered: renewal terms presented to customer. Accepted: customer agreed to renew. Declined: customer rejected renewal. Renegotiated: terms modified during renewal. Lapsed: renewal window closed without action. Cancelled: renewal process terminated. [ENUM-REF-CANDIDATE: pending|offered|accepted|declined|renegotiated|lapsed|cancelled — 7 candidates stripped; promote to reference product]',
    `renewal_type` STRING COMMENT 'Classification of the renewal mechanism. Auto-renewal executes automatically per contract terms; negotiated renewal requires active renegotiation; evergreen continues indefinitely until terminated; manual renewal requires explicit customer action.. Valid values are `auto_renewal|negotiated_renewal|evergreen|manual_renewal`',
    `renewed_annual_value` DECIMAL(18,2) COMMENT 'Total annual revenue from the renewed contract term, expressed in USD. Reflects any rate escalation or service changes applied at renewal.',
    `retention_strategy` STRING COMMENT 'Proactive retention approach applied during renewal process. Standard: normal renewal process. Discount Offered: pricing concession to retain customer. Service Upgrade: enhanced service at no additional cost. Executive Engagement: senior leadership involvement. None: no special retention effort required.. Valid values are `standard|discount_offered|service_upgrade|executive_engagement|none`',
    `service_change_description` STRING COMMENT 'Free-text description of any service level or scope changes applied at renewal. Examples: increased pickup frequency from weekly to twice-weekly, added recycling service, reduced container count from 5 to 3 units.',
    `service_level_change_flag` BOOLEAN COMMENT 'Indicates whether Service Level Agreement (SLA) terms or service scope changed at renewal. True if service frequency, container count, or performance commitments were modified; False if service levels remained unchanged.',
    `source_system` STRING COMMENT 'Identifies the operational system where this renewal record originated. Salesforce CRM: renewal opportunity pipeline. SAP SD: sales and distribution module. Manual Entry: direct data entry by user.. Valid values are `salesforce_crm|sap_sd|manual_entry`',
    `term_length_months` STRING COMMENT 'Duration of the renewed contract term expressed in months. Common values: 12, 24, 36, 60 months.',
    CONSTRAINT pk_renewal PRIMARY KEY(`renewal_id`)
) COMMENT 'Tracks contract renewal events and renewal pipeline management. Captures renewal type (auto-renewal, negotiated renewal, evergreen), renewal notice date, renewal offer date, customer response date, new term start/end dates, rate changes applied at renewal, and renewal outcome (accepted, declined, renegotiated, lapsed). Supports proactive renewal management workflows and revenue retention tracking. Integrates with Salesforce CRM opportunity pipeline.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`termination` (
    `termination_id` BIGINT COMMENT 'Unique identifier for the contract termination event. Primary key.',
    `asset_container_id` BIGINT COMMENT 'Foreign key linking to asset.container. Business justification: Contract termination triggers container retrieval from customer sites. Required for asset recovery logistics, final billing reconciliation, container redeployment planning, and tracking equipment_retr',
    `contract_id` BIGINT COMMENT 'Reference to the service contract being terminated. Links to the parent contract record in Salesforce CRM or SAP SD.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer whose contract is being terminated. Used for churn analysis and win-back program targeting.',
    `employee_id` BIGINT COMMENT 'Reference to the user (manager or authorized personnel) who approved the contract termination. Used for audit trail and approval workflow tracking.',
    `approval_date` DATE COMMENT 'Date when the contract termination was formally approved by authorized personnel. Used for audit trail and compliance reporting.',
    `churn_classification` STRING COMMENT 'Classification of customer churn type for analytics and retention program targeting. Voluntary churn: customer chose to leave. Involuntary churn: terminated by company (non-payment, breach). Natural expiration: contract ended without renewal. Regulatory churn: regulatory requirement forced termination.. Valid values are `voluntary_churn|involuntary_churn|natural_expiration|regulatory_churn`',
    `competitor_name` STRING COMMENT 'Name of competitor that customer switched to, if known. Used for competitive intelligence and market share analysis. Confidential business information.',
    `contract_value_lost` DECIMAL(18,2) COMMENT 'Estimated annual recurring revenue lost due to contract termination in USD. Calculated from contract billing rate and service frequency. Used for revenue loss analysis and churn impact reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the termination record was first created in the system. Used for audit trail and process timing analysis.',
    `early_termination_flag` BOOLEAN COMMENT 'Indicates whether the contract is being terminated before its natural expiration date. True: early termination (may trigger penalties). False: termination at contract end date.',
    `early_termination_penalty_amount` DECIMAL(18,2) COMMENT 'Financial penalty assessed for early contract termination per contract terms. Amount in USD. Null if no penalty applies or termination is at natural contract end.',
    `effective_termination_date` DATE COMMENT 'Date when the contract termination becomes legally effective and service obligations cease. Calculated from notice date plus required notice period, or as mutually agreed.',
    `equipment_retrieval_date` DATE COMMENT 'Date when company-owned equipment was retrieved from customer site. Used to track asset recovery and close out termination process. Null if no equipment retrieval required.',
    `equipment_retrieval_required_flag` BOOLEAN COMMENT 'Indicates whether company-owned equipment (containers, compactors, bins) must be retrieved from customer site. True: retrieval required. False: no equipment to retrieve or customer-owned equipment.',
    `equipment_retrieval_status` STRING COMMENT 'Current status of equipment retrieval process. Not required: no equipment to retrieve. Scheduled: retrieval appointment set. In progress: retrieval underway. Completed: all equipment recovered. Customer retained: customer purchased equipment. Lost: equipment not recoverable.. Valid values are `not_required|scheduled|in_progress|completed|customer_retained|lost`',
    `exit_feedback_summary` STRING COMMENT 'Summary of customer feedback from exit interview. Captures key concerns, service issues, and improvement suggestions. Used for service quality improvement and retention strategy development.',
    `exit_interview_completed_flag` BOOLEAN COMMENT 'Indicates whether an exit interview or customer feedback survey was completed. True: feedback collected. False: no feedback obtained. Used to assess data quality for churn analysis.',
    `exit_interview_date` DATE COMMENT 'Date when exit interview or customer feedback survey was conducted. Null if no exit interview completed.',
    `final_billing_date` DATE COMMENT 'Date when the final invoice for the terminated contract was generated. Includes prorated charges, outstanding balances, and any termination penalties.',
    `final_invoice_amount` DECIMAL(18,2) COMMENT 'Total amount of the final invoice for the terminated contract in USD. Includes prorated service charges, outstanding balances, penalties, and any credits or adjustments.',
    `final_payment_date` DATE COMMENT 'Date when final payment was received and account was settled. Null if final payment not yet received or account written off.',
    `final_payment_received_flag` BOOLEAN COMMENT 'Indicates whether final payment has been received and account is settled. True: final payment received, account closed. False: outstanding balance remains.',
    `final_service_date` DATE COMMENT 'Date of the last service delivery (pickup, haul, disposal) under the terminated contract. Used to determine final billing period and service completion.',
    `initiated_by` STRING COMMENT 'Party that initiated the contract termination. Customer: customer requested termination. Waste Management: company initiated termination. Mutual: both parties agreed to terminate. Regulatory authority: termination mandated by regulatory body.. Valid values are `customer|waste_management|mutual|regulatory_authority`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the termination record was last updated. Used for audit trail and data lineage tracking.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special circumstances, or operational details about the termination. Used for customer service reference and dispute resolution.',
    `notice_date` DATE COMMENT 'Date when formal termination notice was provided by the initiating party. Used to calculate notice period compliance and effective termination date per contract terms.',
    `notice_period_days` STRING COMMENT 'Number of days notice required per contract terms before termination becomes effective. Typically 30, 60, or 90 days for commercial contracts. Used to validate notice compliance.',
    `nps_score` STRING COMMENT 'Customer Net Promoter Score (NPS) at time of termination, scale 0-10. Measures customer satisfaction and likelihood to recommend. Used to correlate satisfaction with churn drivers.',
    `outstanding_balance_amount` DECIMAL(18,2) COMMENT 'Total unpaid balance on the customer account at time of termination in USD. Includes past due invoices and current charges. Used for collections and write-off decisions.',
    `penalty_waived_flag` BOOLEAN COMMENT 'Indicates whether early termination penalty was waived by management approval. True: penalty waived. False: penalty enforced. Used for revenue impact analysis and customer retention decisions.',
    `penalty_waiver_reason` STRING COMMENT 'Business justification for waiving early termination penalty. Examples: customer hardship, service failure, competitive retention, regulatory requirement. Null if penalty not waived.',
    `reason_code` STRING COMMENT 'Primary business reason for contract termination. Used for churn analysis, service improvement initiatives, and competitive intelligence. Price increase: customer cited cost concerns. Service quality: dissatisfaction with service delivery. Relocation: customer moved outside service area. Business closure: customer ceased operations. Competitor offer: customer switched to competitor. Contract breach: violation of contract terms. Regulatory change: regulatory requirement forced termination. Consolidation: customer consolidated services with another provider. Bankruptcy: customer filed for bankruptcy protection. [ENUM-REF-CANDIDATE: price_increase|service_quality|relocation|business_closure|competitor_offer|contract_breach|regulatory_change|consolidation|bankruptcy|other — 10 candidates stripped; promote to reference product]',
    `requested_termination_date` DATE COMMENT 'Date requested by the customer or initiating party for contract termination. May differ from effective termination date due to notice period requirements or mutual negotiation.',
    `source_system` STRING COMMENT 'System of record where the termination event was originally captured. Salesforce CRM: customer-initiated terminations. SAP SD: contract management terminations. Waste Logics: customer portal terminations. Manual entry: offline or legacy terminations.. Valid values are `salesforce_crm|sap_sd|waste_logics|manual_entry`',
    `source_system_code` STRING COMMENT 'Unique identifier of the termination record in the source system. Used for data lineage, reconciliation, and troubleshooting integration issues.',
    `termination_number` STRING COMMENT 'Business-facing unique identifier for the termination event. Format: TRM-YYYYMMDD sequence. Used in customer communications and internal tracking.. Valid values are `^TRM-[0-9]{8}$`',
    `termination_status` STRING COMMENT 'Current lifecycle status of the termination process. Pending: termination request received, under review. Notice given: formal termination notice issued. Approved: termination approved by management. Equipment retrieved: containers and equipment returned. Final billed: final invoice generated. Completed: all termination activities finished. Cancelled: termination request withdrawn. [ENUM-REF-CANDIDATE: pending|notice_given|approved|equipment_retrieved|final_billed|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `termination_type` STRING COMMENT 'Classification of the termination event by initiating party and legal basis. Voluntary cancellation: customer-initiated. Non-renewal expiration: contract expired without renewal. Breach termination: terminated due to contract violation. Regulatory termination: ended due to regulatory requirement. Mutual agreement: both parties agreed to end. Convenience termination: terminated per convenience clause.. Valid values are `voluntary_cancellation|non_renewal_expiration|breach_termination|regulatory_termination|mutual_agreement|convenience_termination`',
    `win_back_campaign_code` BIGINT COMMENT 'Reference to the marketing campaign targeting this churned customer for re-acquisition. Null if no win-back campaign assigned or customer not eligible.',
    `win_back_eligible_flag` BOOLEAN COMMENT 'Indicates whether the customer is eligible for win-back marketing programs. True: eligible for retention offers. False: not eligible (breach, fraud, regulatory). Used to target re-acquisition campaigns.',
    CONSTRAINT pk_termination PRIMARY KEY(`termination_id`)
) COMMENT 'Records contract termination events including voluntary cancellations, non-renewal expirations, breach-based terminations, and regulatory-driven contract endings. Captures termination reason code, notice date, effective termination date, early termination penalty amount, equipment retrieval requirements, final billing instructions, and customer churn classification. Supports revenue loss analysis and customer win-back programs. Sourced from Salesforce CRM and SAP SD.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`franchise_agreement` (
    `franchise_agreement_id` BIGINT COMMENT 'Unique identifier for the franchise agreement record. Primary key.',
    `agreement_type_id` BIGINT COMMENT 'Foreign key linking to contract.agreement_type. Business justification: franchise_agreement has agreement_type (STRING) attribute which is a classification code. agreement_type is the reference table for contract and agreement type classifications. This is a standard N:1 ',
    `area_id` BIGINT COMMENT 'Foreign key linking to service.service_area. Business justification: Franchise agreements grant exclusive service rights within specific geographic service areas. Essential for regulatory compliance validation, service authorization checks, franchise fee calculation, a',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: franchise_agreement is a specialized master record for municipal franchise agreements, which are a subtype of the general contract entity. Linking franchise_agreement to contract establishes the speci',
    `esg_disclosure_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_disclosure. Business justification: Municipal franchise agreements require ESG disclosures (diversion rates, emissions, community investment) for franchise fee calculations and renewal evaluations. Direct link needed for regulatory repo',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Franchise agreements govern municipal waste operations at specific facilities. Required for franchise fee calculation, performance bond tracking, diversion rate compliance, and regulatory reporting to',
    `municipality_id` BIGINT COMMENT 'Reference to the municipal government entity that granted this franchise agreement.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Municipal franchise agreements require underlying operating permits for the franchised territory. Franchise execution is contingent on permit issuance; franchise terms (capacity, waste streams) must a',
    `safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Municipal franchise agreements explicitly mandate safety program compliance (OSHA VPP, DOT safety ratings, environmental compliance programs). Critical for franchise renewal audits, regulatory reporti',
    `scheduled_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.scheduled_obligation. Business justification: Franchise agreements create recurring compliance obligations (quarterly tonnage reporting, annual diversion audits, franchise fee calculations) tracked in compliance calendar. Links contractual commit',
    `agreement_name` STRING COMMENT 'Descriptive name of the franchise agreement, typically including municipality name and service type.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the franchise agreement, typically formatted as FA-[STATE]-[NUMBER].. Valid values are `^FA-[A-Z]{2,3}-[0-9]{6,8}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the franchise agreement.. Valid values are `draft|pending_approval|active|suspended|terminated|expired`',
    `amendment_count` STRING COMMENT 'Total number of amendments executed to date that modify the original franchise agreement terms.',
    `annual_rate_escalation_percentage` DECIMAL(18,2) COMMENT 'Fixed annual percentage increase applied to service rates, if applicable under the rate adjustment mechanism.',
    `cpi_index_reference` STRING COMMENT 'Specific Consumer Price Index used for rate escalation calculations, such as CPI-U for All Urban Consumers or regional CPI.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the franchise agreement record was first created in the system.',
    `dispute_resolution_method` STRING COMMENT 'Primary method for resolving disputes between Waste Management and the municipality under the franchise agreement.. Valid values are `litigation|arbitration|mediation|negotiation`',
    `diversion_rate_requirement` DECIMAL(18,2) COMMENT 'Minimum percentage of waste that must be diverted from landfill through recycling, composting, or waste-to-energy programs as mandated by the municipality.',
    `effective_end_date` DATE COMMENT 'Date on which the franchise agreement expires or terminates, unless renewed or extended.',
    `effective_start_date` DATE COMMENT 'Date on which the franchise agreement becomes legally binding and service obligations commence.',
    `environmental_compliance_requirements` STRING COMMENT 'Description of specific environmental compliance obligations under the franchise agreement, including EPA, RCRA, Clean Air Act, and state environmental regulations.',
    `exclusivity_type` STRING COMMENT 'Indicates whether Waste Management has exclusive, non-exclusive, or semi-exclusive rights to provide waste collection services within the franchise territory.. Valid values are `exclusive|non_exclusive|semi_exclusive`',
    `fleet_composition_requirements` STRING COMMENT 'Requirements for fleet composition serving the franchise territory, including minimum percentages of CNG, RNG, electric, or other alternative fuel vehicles.',
    `franchise_fee_fixed_amount` DECIMAL(18,2) COMMENT 'Fixed annual franchise fee amount paid to the municipality, applicable when franchise_fee_type is fixed_annual or hybrid.',
    `franchise_fee_per_ton_rate` DECIMAL(18,2) COMMENT 'Per-ton franchise fee rate charged for waste disposed within the franchise territory, applicable when franchise_fee_type is per_ton or hybrid.',
    `franchise_fee_percentage` DECIMAL(18,2) COMMENT 'Percentage of gross revenue paid to the municipality as franchise fee, applicable when franchise_fee_type is percentage_of_revenue or hybrid.',
    `franchise_fee_type` STRING COMMENT 'Structure of the franchise fee payment to the municipality: percentage of gross revenue, fixed annual amount, per-ton disposal fee, or hybrid model.. Valid values are `percentage_of_revenue|fixed_annual|per_ton|hybrid`',
    `ghg_reduction_target_percentage` DECIMAL(18,2) COMMENT 'Target percentage reduction in greenhouse gas emissions required under the franchise agreement, typically measured in CO2e.',
    `governing_law_jurisdiction` STRING COMMENT 'State or jurisdiction whose laws govern the interpretation and enforcement of the franchise agreement.',
    `initial_term_years` STRING COMMENT 'Number of years in the initial term of the franchise agreement before any renewal options.',
    `insurance_requirement_description` STRING COMMENT 'Description of the insurance coverage types and minimum limits required under the franchise agreement, including general liability, auto liability, and environmental liability.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment to the franchise agreement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the franchise agreement record was last updated in the system.',
    `lea_reference_number` STRING COMMENT 'Reference number assigned by the Local Enforcement Agency responsible for solid waste regulatory oversight in the franchise territory.',
    `performance_bond_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the performance bond required to be maintained, if applicable.',
    `performance_bond_required` BOOLEAN COMMENT 'Indicates whether Waste Management is required to maintain a performance bond to guarantee service delivery under this franchise agreement.',
    `rate_adjustment_mechanism` STRING COMMENT 'Description of the methodology for adjusting service rates over the term of the franchise agreement, including CPI escalation, fuel surcharge formulas, or other adjustment triggers.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiration that either party must provide written notice of intent to renew or terminate the franchise agreement.',
    `renewal_option_years` STRING COMMENT 'Number of years in each renewal option period, if the franchise agreement includes renewal provisions.',
    `reporting_frequency` STRING COMMENT 'Frequency at which Waste Management must submit operational and compliance reports to the municipality.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `service_scope` STRING COMMENT 'Detailed description of the waste collection and disposal services covered under this franchise agreement, including residential, commercial, recycling, and special waste streams.',
    `sla_missed_pickup_resolution_hours` STRING COMMENT 'Maximum number of hours allowed to resolve a missed pickup complaint within the franchise territory.',
    `sla_response_time_hours` STRING COMMENT 'Maximum number of hours allowed to respond to service requests or complaints from residents within the franchise territory.',
    `swis_reporting_required` BOOLEAN COMMENT 'Indicates whether reporting to the state Solid Waste Information System is required under this franchise agreement.',
    `termination_for_cause_allowed` BOOLEAN COMMENT 'Indicates whether the municipality has the right to terminate the franchise agreement for cause due to performance failures or regulatory violations.',
    `termination_notice_days` STRING COMMENT 'Number of days advance written notice required for termination of the franchise agreement by either party.',
    `territory_geojson` STRING COMMENT 'GeoJSON representation of the franchise territory boundaries for mapping and spatial analysis.',
    CONSTRAINT pk_franchise_agreement PRIMARY KEY(`franchise_agreement_id`)
) COMMENT 'Specialized master record for municipal franchise agreements granting Waste Management exclusive or non-exclusive rights to provide waste collection services within a defined geographic jurisdiction. Captures franchise territory boundaries, exclusivity terms, franchise fee structure (percentage of gross revenue), diversion rate requirements, reporting obligations to the municipality, LEA (Local Enforcement Agency) references, and SWIS compliance requirements. Distinct from commercial service agreements due to regulatory and public-service obligations.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`disposal_agreement` (
    `disposal_agreement_id` BIGINT COMMENT 'Unique identifier for the disposal agreement record. Primary key.',
    `agreement_type_id` BIGINT COMMENT 'Foreign key linking to contract.agreement_type. Business justification: disposal_agreement has agreement_type (STRING) attribute. Consistent with franchise_agreement normalization pattern, this should reference the agreement_type lookup table. N:1 relationship where many ',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: disposal_agreement is a specialized master record for disposal and tipping agreements, which are a subtype of the general contract entity. Same specialization pattern as franchise_agreement. disposal_',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Disposal agreements require employee ownership for vendor relationship management, performance monitoring, renewal negotiations, and escalation workflows. Current contract_owner free-text field should',
    `cell_id` BIGINT COMMENT 'Foreign key linking to landfill.cell. Business justification: Some disposal agreements specify designated cells for particular waste streams (e.g., industrial waste, C&D). Supports cell-specific capacity allocation, waste stream segregation requirements, and per',
    `facility_id` BIGINT COMMENT 'Reference to the disposal facility (landfill, transfer station, MRF, WTE, TSDF) where waste is delivered under this agreement.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Disposal agreements with landfills/transfer stations must reference facility operating permits to verify accepted waste streams, capacity limits, and regulatory authorization. Procurement teams valida',
    `safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Disposal facility agreements require facility-specific safety programs (RCRA compliance, confined space entry, LOTO procedures). Necessary for contractor safety orientation, facility access authorizat',
    `ghg_inventory_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_inventory. Business justification: Disposal agreements with landfills/incinerators require GHG inventory data for carbon accounting and EPA GHGRP reporting. Facilities must track which disposal contracts contribute to which inventory p',
    `scheduled_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.scheduled_obligation. Business justification: Disposal agreements trigger scheduled compliance obligations (manifest reconciliation, tonnage reporting, permit condition verification) tied to facility permits. Links disposal contracts to recurring',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: Disposal agreements specify accepted waste streams at facilities (MSW, C&D, hazmat, organics). Critical for waste acceptance validation, manifest verification, RCRA compliance, and tipping fee applica',
    `agreement_name` STRING COMMENT 'Descriptive name of the disposal agreement for business reference and reporting.',
    `agreement_number` STRING COMMENT 'Externally-known business identifier for the disposal agreement, used in contracts and invoicing.. Valid values are `^DA-[0-9]{8}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the disposal agreement indicating its operational state.. Valid values are `draft|active|suspended|terminated|expired|pending_renewal`',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the disposal agreement automatically renews at the end of its term unless terminated by either party.',
    `base_tipping_fee_rate` DECIMAL(18,2) COMMENT 'Base rate charged per ton for waste disposal at the facility, measured in currency per ton. Excludes surcharges and adjustments.',
    `billing_frequency` STRING COMMENT 'Frequency at which invoices are generated for disposal services under this agreement.. Valid values are `daily|weekly|monthly|quarterly|per_load`',
    `contracted_annual_tonnage` DECIMAL(18,2) COMMENT 'Total tonnage volume contracted per year under this disposal agreement, measured in tons.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this disposal agreement record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the disposal agreement expires or terminates. Nullable for open-ended agreements.',
    `effective_start_date` DATE COMMENT 'Date when the disposal agreement becomes legally binding and operational.',
    `escalation_percentage` DECIMAL(18,2) COMMENT 'Annual percentage rate for tipping fee escalation as specified in the contract. Nullable if escalation is index-based.',
    `facility_operator` STRING COMMENT 'Name of the organization or entity that operates the disposal facility.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Minimum insurance coverage amount required from the disposal facility vendor, measured in currency. Nullable if insurance is not required.',
    `insurance_required` BOOLEAN COMMENT 'Indicates whether the disposal facility is required to maintain liability insurance as a condition of the agreement.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who last modified this disposal agreement record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this disposal agreement record was last updated in the system.',
    `manifest_required` BOOLEAN COMMENT 'Indicates whether a hazardous waste tracking manifest (Bill of Lading) is required for waste deliveries under this agreement.',
    `maximum_tonnage_limit` DECIMAL(18,2) COMMENT 'Maximum tonnage volume allowed annually under this agreement, measured in tons. Nullable if no maximum is specified.',
    `minimum_tonnage_guarantee` DECIMAL(18,2) COMMENT 'Minimum tonnage volume that must be delivered annually to meet contractual obligations, measured in tons. Nullable if no minimum is required.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special terms, or operational instructions related to the disposal agreement.',
    `payment_terms` STRING COMMENT 'Standard payment terms for invoices under this disposal agreement (e.g., Net 30, Net 45).. Valid values are `net_15|net_30|net_45|net_60|due_on_receipt`',
    `performance_penalty_clause` STRING COMMENT 'Description of penalties or liquidated damages for failure to meet contracted tonnage, SLA, or other performance obligations.',
    `permit_number` STRING COMMENT 'Regulatory permit number issued by the EPA or state environmental agency authorizing the facility to accept waste under this agreement.',
    `rate_escalation_clause` STRING COMMENT 'Description of the rate escalation terms, including frequency, percentage, and index (e.g., CPI-based annual adjustment).',
    `rcra_compliance_required` BOOLEAN COMMENT 'Indicates whether this disposal agreement requires compliance with RCRA regulations for hazardous waste handling and disposal.',
    `renewal_notice_days` STRING COMMENT 'Number of days advance notice required to terminate or renegotiate the agreement before automatic renewal.',
    `sla_turnaround_time_hours` STRING COMMENT 'Maximum turnaround time in hours for waste acceptance and processing as specified in the Service Level Agreement (SLA).',
    `termination_date` DATE COMMENT 'Actual date when the disposal agreement was terminated, if applicable. Nullable for active agreements.',
    `termination_reason` STRING COMMENT 'Business reason for termination of the disposal agreement (e.g., contract expiration, breach, facility closure, cost optimization).',
    `tipping_fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for tipping fee rates (e.g., USD, CAD).. Valid values are `^[A-Z]{3}$`',
    `tpd_capacity` DECIMAL(18,2) COMMENT 'Daily tonnage capacity allocated under this disposal agreement, measured in Tons Per Day (TPD).',
    `vendor_contact_email` STRING COMMENT 'Email address for the vendor contact at the disposal facility.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `vendor_contact_name` STRING COMMENT 'Primary contact name at the disposal facility vendor for operational coordination.',
    `vendor_contact_phone` STRING COMMENT 'Primary phone number for the vendor contact at the disposal facility.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this disposal agreement record.',
    CONSTRAINT pk_disposal_agreement PRIMARY KEY(`disposal_agreement_id`)
) COMMENT 'Master record for disposal and tipping agreements with landfill sites, transfer stations, MRFs, WTE facilities, and TSDFs (Treatment, Storage, and Disposal Facilities). Captures disposal facility reference, accepted waste streams (MSW, C&D, hazmat, recyclables), contracted tonnage volumes (TPD or annual tons), tipping fee rates, minimum tonnage guarantees, and RCRA compliance requirements. Governs where and how collected waste is disposed or processed. Integrates with SAP SD and landfill/transfer domain.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`hauling_agreement` (
    `hauling_agreement_id` BIGINT COMMENT 'Unique identifier for the hauling agreement record. Primary key for third-party hauling and subcontractor agreements.',
    `agreement_type_id` BIGINT COMMENT 'Foreign key linking to contract.agreement_type. Business justification: hauling_agreement has agreement_type (STRING) attribute. Consistent normalization pattern with franchise_agreement and disposal_agreement. N:1 relationship to agreement_type reference table. Removes r',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: hauling_agreement is a specialized master record for third-party hauling and subcontractor agreements, which are a subtype of the general contract entity. Same specialization pattern as franchise_agre',
    `employee_id` BIGINT COMMENT 'Identifier for the Waste Management employee responsible for managing this hauling agreement. Typically a procurement or operations manager.',
    `customer_account_id` BIGINT COMMENT 'Identifier for the customer or contracting party for whom hauling services are provided. May be Waste Management internal division or external client.',
    `facility_id` BIGINT COMMENT 'Identifier for the facility where waste is delivered. May be landfill, MRF, WTE facility, or TSDF.',
    `hauler_account_id` BIGINT COMMENT 'Identifier for the third-party hauler or subcontractor party to this agreement. Links to hauler master record.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Third-party haulers are vendors providing transportation services under contract. Critical for subcontractor invoice reconciliation, insurance certificate tracking, DOT compliance verification, and pa',
    `origin_facility_id` BIGINT COMMENT 'Identifier for the facility or location where waste is collected or loaded for transport. May be collection point, transfer station, or customer site.',
    `safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Hauling agreements mandate DOT compliance programs, driver safety certifications, and hazmat handling protocols. Essential for carrier qualification, insurance verification, and regulatory compliance ',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Hauling agreements for hazardous waste transport require DOT/EPA permits. Contract terms (waste types, routes, volumes) must align with permit conditions. Essential for third-party hauler qualificatio',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: Hauling agreements specify waste stream types being transported with DOT hazmat class and handling requirements. Essential for DOT compliance, driver CDL/endorsement validation, manifest requirements,',
    `agreement_number` STRING COMMENT 'Externally-known business identifier for the hauling agreement. Used in contracts, BOL references, and vendor communications.. Valid values are `^HA-[0-9]{6,10}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the hauling agreement indicating operational validity and contract state.. Valid values are `draft|pending_approval|active|suspended|terminated|expired`',
    `approval_date` DATE COMMENT 'Date when the hauling agreement was formally approved by authorized signatories and became legally binding.',
    `bol_requirement_flag` BOOLEAN COMMENT 'Indicates whether a BOL document is required for each haul under this agreement. True if BOL is mandatory.',
    `contracted_rate` DECIMAL(18,2) COMMENT 'Base rate amount per unit as defined by rate structure type. Expressed in USD unless otherwise specified in currency code.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hauling agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for contracted rate and financial terms.. Valid values are `^[A-Z]{3}$`',
    `dot_compliance_requirements` STRING COMMENT 'Specific DOT regulatory obligations applicable to this hauling agreement including vehicle standards, driver qualifications, and hours of service.',
    `effective_end_date` DATE COMMENT 'Date when the hauling agreement expires or terminates. Nullable for open-ended agreements subject to notice provisions.',
    `effective_start_date` DATE COMMENT 'Date when the hauling agreement becomes binding and operational services may commence.',
    `environmental_compliance_certifications` STRING COMMENT 'List of environmental certifications and permits held by the hauler relevant to this agreement (e.g., EPA ID, state permits, ISO 14001).',
    `fuel_surcharge_applicable_flag` BOOLEAN COMMENT 'Indicates whether a variable fuel surcharge is applied to hauling rates based on market fuel prices. True if surcharge applies.',
    `fuel_surcharge_formula` STRING COMMENT 'Mathematical formula or index reference used to calculate fuel surcharge adjustments. Typically references DOE diesel price index.',
    `insurance_certificate_number` STRING COMMENT 'Reference number for the haulers liability and cargo insurance certificate on file. Required for risk management and compliance.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Minimum insurance coverage amount in USD required under the agreement for liability and cargo protection.',
    `insurance_expiration_date` DATE COMMENT 'Date when the haulers insurance certificate expires. Triggers renewal verification process.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or modification to the hauling agreement terms. Nullable if no amendments have been made.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this hauling agreement record was last updated in the system.',
    `manifest_requirement_flag` BOOLEAN COMMENT 'Indicates whether hazardous waste manifest tracking is required per RCRA regulations. True for hazardous waste streams.',
    `maximum_volume_capacity_tons` DECIMAL(18,2) COMMENT 'Maximum tonnage the hauler commits to transport over the contract period. Defines capacity ceiling.',
    `minimum_volume_commitment_tons` DECIMAL(18,2) COMMENT 'Minimum tonnage the customer commits to provide for hauling over the contract period. Nullable if no minimum applies.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special instructions, or contextual information about the hauling agreement.',
    `payment_terms` STRING COMMENT 'Standard payment terms defining invoice due date and payment schedule for hauling services.. Valid values are `net_15|net_30|net_45|net_60|due_on_receipt|prepaid`',
    `performance_penalty_clause` STRING COMMENT 'Contractual terms defining financial penalties or remedies for failure to meet SLA performance standards.',
    `performance_sla_on_time_pct` DECIMAL(18,2) COMMENT 'Contractual service level target for on-time delivery performance expressed as a percentage. Used for performance monitoring and penalties.',
    `rate_escalation_clause` STRING COMMENT 'Contractual terms governing automatic rate adjustments based on CPI, fuel surcharges, or other indices.',
    `rate_structure_type` STRING COMMENT 'Pricing model used to calculate hauling charges. Defines the unit basis for rate application.. Valid values are `per_ton|per_ton_mile|per_load|per_trip|hourly|monthly_fixed`',
    `renewal_terms` STRING COMMENT 'Contractual provisions governing automatic renewal, renewal notice periods, and renegotiation requirements.',
    `route_lane_description` STRING COMMENT 'Textual description of the hauling route or lane including key waypoints, geographic coverage, and operational constraints.',
    `safety_rating` STRING COMMENT 'DOT safety rating assigned to the hauler based on compliance history and safety performance inspections.. Valid values are `satisfactory|conditional|unsatisfactory|not_rated`',
    `termination_for_cause_clause` STRING COMMENT 'Contractual terms defining conditions under which either party may terminate immediately for material breach or non-performance.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the agreement without cause.',
    CONSTRAINT pk_hauling_agreement PRIMARY KEY(`hauling_agreement_id`)
) COMMENT 'Master record for third-party hauling and subcontractor agreements where Waste Management engages or is engaged as a hauler for waste transport between collection points, transfer stations, landfills, and processing facilities. Captures hauler identity, route or lane definition, waste stream type, contracted rate per ton-mile or per load, BOL (Bill of Lading) requirements, DOT compliance obligations, insurance requirements, and performance standards. Supports subcontracted collection and intermodal transport operations.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`performance_obligation` (
    `performance_obligation_id` BIGINT COMMENT 'Unique identifier for the performance obligation. Primary key for this entity.',
    `contract_id` BIGINT COMMENT 'Reference to the parent contract that contains this performance obligation.',
    `diversion_record_id` BIGINT COMMENT 'Foreign key linking to sustainability.diversion_record. Business justification: ASC 606 revenue recognition for recycling/diversion services depends on actual diversion performance. Links performance obligations to measurable diversion outcomes for variable consideration calculat',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Performance obligations for disposal/processing services are facility-specific. Required for ASC 606 revenue recognition by facility, standalone selling price allocation, and facility-level revenue tr',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: ASC 606 performance obligations decompose contract deliverables into distinct service offerings for revenue recognition. Required for revenue accounting, standalone selling price allocation, contract ',
    `service_enrollment_id` BIGINT COMMENT 'Foreign key linking to customer.service_enrollment. Business justification: ASC 606 revenue recognition requires performance obligations mapped to specific service enrollments. Linking enables accurate revenue allocation, satisfaction tracking, and contract asset/liability ca',
    `allocated_transaction_price` DECIMAL(18,2) COMMENT 'Portion of the total contract transaction price allocated to this specific performance obligation based on relative standalone selling prices.',
    `amendment_date` DATE COMMENT 'Date when this performance obligation was amended or modified. Null if never amended.',
    `amendment_indicator` BOOLEAN COMMENT 'Indicates whether this performance obligation was added or modified through a contract amendment.',
    `billing_schedule` STRING COMMENT 'Billing frequency or schedule for this performance obligation (may differ from revenue recognition pattern).. Valid values are `monthly|quarterly|annual|per_service|milestone|upfront`',
    `constraint_applied` BOOLEAN COMMENT 'Indicates whether a constraint has been applied to variable consideration to prevent significant revenue reversal.',
    `contract_asset_liability_indicator` STRING COMMENT 'Indicates whether this obligation creates a contract asset (revenue recognized before billing) or contract liability (billing before revenue recognition) on the balance sheet.. Valid values are `contract_asset|contract_liability|neither`',
    `cost_of_service` DECIMAL(18,2) COMMENT 'Estimated or actual cost to fulfill this performance obligation, used for profitability analysis.',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this performance obligation record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this performance obligation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this performance obligation (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this performance obligation ends or is expected to be fully satisfied. Nullable for ongoing obligations.',
    `effective_start_date` DATE COMMENT 'Date when this performance obligation becomes effective and service delivery begins.',
    `gl_revenue_account` STRING COMMENT 'General ledger account code to which revenue for this performance obligation is posted.. Valid values are `^[0-9]{4,10}$`',
    `is_distinct` BOOLEAN COMMENT 'Indicates whether this obligation is distinct and separately identifiable from other promises in the contract per ASC 606 criteria.',
    `is_variable_consideration` BOOLEAN COMMENT 'Indicates whether this obligation includes variable consideration (e.g., usage-based pricing, performance bonuses, penalties) that may affect the transaction price.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this performance obligation record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this performance obligation record was last updated or modified.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this performance obligation.',
    `obligation_description` STRING COMMENT 'Detailed description of the distinct service promise represented by this obligation (e.g., weekly residential collection, monthly roll-off swap, annual container maintenance).',
    `obligation_number` STRING COMMENT 'Business-readable identifier for the performance obligation, typically formatted as PO-NNNNNN.. Valid values are `^PO-[0-9]{6,10}$`',
    `obligation_status` STRING COMMENT 'Current lifecycle status of the performance obligation indicating whether it is active, satisfied, or terminated.. Valid values are `draft|active|satisfied|partially_satisfied|terminated|cancelled`',
    `percentage_complete` DECIMAL(18,2) COMMENT 'Percentage of completion for obligations satisfied over time, used to calculate revenue recognition (0.00 to 100.00).',
    `performance_milestone` STRING COMMENT 'Description of key milestone or deliverable that triggers satisfaction of this obligation (applicable for milestone-based recognition).',
    `remaining_revenue` DECIMAL(18,2) COMMENT 'Remaining revenue to be recognized for this performance obligation (allocated transaction price minus revenue recognized to date).',
    `revenue_recognition_pattern` STRING COMMENT 'The pattern used to recognize revenue for this obligation (e.g., straight-line over contract term, usage-based per service event, milestone completion).. Valid values are `straight_line|usage_based|milestone_based|output_method|input_method`',
    `revenue_recognized_to_date` DECIMAL(18,2) COMMENT 'Cumulative revenue recognized for this performance obligation as of the current reporting period.',
    `satisfaction_date` DATE COMMENT 'Actual date when the performance obligation was fully satisfied. Null if not yet satisfied.',
    `satisfaction_method` STRING COMMENT 'Indicates whether the performance obligation is satisfied over time (e.g., ongoing collection service) or at a point in time (e.g., one-time container delivery).. Valid values are `over_time|point_in_time`',
    `service_frequency` STRING COMMENT 'Expected frequency of service delivery for this performance obligation (e.g., weekly collection, monthly swap). [ENUM-REF-CANDIDATE: daily|weekly|biweekly|monthly|quarterly|annual|on_demand|one_time — 8 candidates stripped; promote to reference product]',
    `service_quantity` DECIMAL(18,2) COMMENT 'Quantity of service units promised under this obligation (e.g., number of pickups, number of containers, tons of waste).',
    `service_unit_of_measure` STRING COMMENT 'Unit of measure for the service quantity (e.g., pickups, containers, tons, cubic yards). [ENUM-REF-CANDIDATE: pickup|container|ton|cubic_yard|gallon|service_event|month — 7 candidates stripped; promote to reference product]',
    `sla_target` STRING COMMENT 'Service level target or performance standard associated with this obligation (e.g., 99% on-time pickup rate, 24-hour response time).',
    `standalone_selling_price` DECIMAL(18,2) COMMENT 'The price at which the entity would sell the promised good or service separately to a customer, used for transaction price allocation under ASC 606.',
    `termination_reason` STRING COMMENT 'Reason for termination or cancellation of this performance obligation if applicable (e.g., customer request, contract breach, service discontinuation).',
    `variable_consideration_estimate` DECIMAL(18,2) COMMENT 'Estimated amount of variable consideration expected to be received for this obligation, subject to constraint requirements.',
    CONSTRAINT pk_performance_obligation PRIMARY KEY(`performance_obligation_id`)
) COMMENT 'Defines discrete performance obligations within a contract as required under ASC 606 revenue recognition standards. Each obligation represents a distinct service promise (e.g., weekly residential collection, monthly roll-off swap, annual container maintenance) with its standalone selling price, satisfaction method (over time vs. point in time), and revenue recognition pattern. Supports GAAP/IFRS-compliant revenue recognition and SOX financial reporting. Sourced from SAP SD revenue recognition module.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`lifecycle_event` (
    `lifecycle_event_id` BIGINT COMMENT 'Primary key for lifecycle_event',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved this lifecycle event. Null if no approval was required or if auto-approved by system.',
    `contract_id` BIGINT COMMENT 'Reference to the parent contract that this lifecycle event belongs to. Links to the contract master record.',
    `document_id` BIGINT COMMENT 'Foreign key linking to contract.document. Business justification: Lifecycle events capture significant contract state transitions (origination, amendment, renewal, termination) that often generate or reference supporting legal documents. Currently lifecycle_event.do',
    `primary_lifecycle_employee_id` BIGINT COMMENT 'Identifier of the user who initiated or triggered this lifecycle event. May be a system identifier for automated events.',
    `amendment_detail` STRING COMMENT 'For AMENDMENT events, provides specific details about what was changed (e.g., service frequency increased from weekly to bi-weekly, rate adjusted from $150 to $175). Null for non-amendment events.',
    `amendment_type_code` STRING COMMENT 'For AMENDMENT events, specifies the nature of the contract modification. Null for non-amendment events. [ENUM-REF-CANDIDATE: SCOPE_CHANGE|RATE_ADJUSTMENT|SERVICE_ADDITION|SERVICE_REMOVAL|TERM_EXTENSION|ADDRESS_CHANGE|BILLING_CHANGE — 7 candidates stripped; promote to reference product]',
    `approval_reference_number` STRING COMMENT 'Reference number or identifier of the approval workflow or authorization that permitted this lifecycle event. Null if no approval was required.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the approval for this lifecycle event was granted. Null if no approval was required.',
    `compliance_review_completed_flag` BOOLEAN COMMENT 'Indicates whether required compliance review has been completed for this lifecycle event. True if completed, False if pending or not applicable.',
    `compliance_review_required_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle event requires regulatory or legal compliance review. True if review is required, False otherwise.',
    `created_by_user` STRING COMMENT 'Identifier of the user or system process that created this lifecycle event record. Audit trail field.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this lifecycle event record was first created in the data platform. Audit trail field.',
    `customer_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether the customer was notified about this lifecycle event. True if notification was sent, False otherwise.',
    `customer_notification_timestamp` TIMESTAMP COMMENT 'Date and time when customer notification about this lifecycle event was sent. Null if no notification was sent.',
    `effective_date` DATE COMMENT 'The date when this lifecycle event becomes legally or operationally effective. May differ from event_timestamp if the event is scheduled for future execution.',
    `event_description` STRING COMMENT 'Detailed narrative description of the lifecycle event, including business context, reason for change, and any relevant details specific to this event occurrence.',
    `event_sequence_number` STRING COMMENT 'Sequential ordering number of this event within the contracts lifecycle history. Enables chronological reconstruction of contract state changes.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the lifecycle event occurred in the real world. This is the business event time, distinct from system audit timestamps.',
    `event_type_code` STRING COMMENT 'Classification code identifying the type of lifecycle event. Values: ORIGINATION (contract created), ACTIVATION (contract becomes active), FIRST_SERVICE (first service delivery), AMENDMENT (contract modified), RENEWAL (contract renewed), TERMINATION (contract ended), SUSPENSION (contract temporarily paused), REINSTATEMENT (contract reactivated after suspension). [ENUM-REF-CANDIDATE: ORIGINATION|ACTIVATION|FIRST_SERVICE|AMENDMENT|RENEWAL|TERMINATION|SUSPENSION|REINSTATEMENT — 8 candidates stripped; promote to reference product]',
    `last_modified_by_user` STRING COMMENT 'Identifier of the user or system process that last modified this lifecycle event record. Audit trail field.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this lifecycle event record was last updated. Audit trail field.',
    `new_contract_status` STRING COMMENT 'The contract status after this lifecycle event was applied. Represents the resulting state of the contract. [ENUM-REF-CANDIDATE: DRAFT|PENDING_APPROVAL|ACTIVE|SUSPENDED|TERMINATED|EXPIRED|RENEWED — 7 candidates stripped; promote to reference product]',
    `new_monthly_value` DECIMAL(18,2) COMMENT 'For AMENDMENT or RENEWAL events that change pricing, the monthly contract value after the event in USD. Null if pricing was not modified.',
    `new_term_end_date` DATE COMMENT 'For RENEWAL or AMENDMENT events that extend the contract term, the new end date of the contract. Null if term was not modified.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about this lifecycle event, capturing context not covered by structured fields.',
    `prior_contract_status` STRING COMMENT 'The contract status immediately before this lifecycle event occurred. Enables state transition tracking and audit trail reconstruction. [ENUM-REF-CANDIDATE: DRAFT|PENDING_APPROVAL|ACTIVE|SUSPENDED|TERMINATED|EXPIRED|RENEWED — 7 candidates stripped; promote to reference product]',
    `prior_monthly_value` DECIMAL(18,2) COMMENT 'For AMENDMENT or RENEWAL events that change pricing, the monthly contract value before the event in USD. Null if pricing was not modified.',
    `prior_term_end_date` DATE COMMENT 'For RENEWAL events, the end date of the previous contract term. Null for non-renewal events.',
    `rate_escalation_percentage` DECIMAL(18,2) COMMENT 'For RENEWAL or AMENDMENT events involving rate escalation, the percentage increase applied to contract rates. Null if no escalation occurred.',
    `renewal_outcome_code` STRING COMMENT 'For RENEWAL events, indicates how the renewal was executed. Null for non-renewal events.. Valid values are `AUTO_RENEWED|NEGOTIATED_RENEWED|EVERGREEN_CONTINUED|NOT_RENEWED`',
    `service_level_agreement_change_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle event resulted in changes to the contracts Service Level Agreement terms. True if SLA was modified, False otherwise.',
    `termination_penalty_amount` DECIMAL(18,2) COMMENT 'For TERMINATION events, the early termination penalty amount charged to the customer in USD. Null if no penalty applies or for non-termination events.',
    `termination_reason_code` STRING COMMENT 'For TERMINATION events, specifies the reason the contract was ended. Null for non-termination events.. Valid values are `VOLUNTARY_CANCELLATION|NON_RENEWAL|BREACH|REGULATORY|CUSTOMER_RELOCATION|SERVICE_UNAVAILABLE`',
    `triggering_system_code` STRING COMMENT 'Identifies the source system or process that generated this lifecycle event. Enables traceability of event origin.. Valid values are `SALESFORCE_CRM|SAP_SD|WASTE_LOGICS|MANUAL_ENTRY|AUTOMATED_WORKFLOW`',
    CONSTRAINT pk_lifecycle_event PRIMARY KEY(`lifecycle_event_id`)
) COMMENT 'Chronological audit log capturing all significant state transitions and business events in a contracts lifecycle. Event types include: origination, activation, first-service-date, amendment (scope changes, rate adjustments, service additions/removals, term extensions), renewal (auto-renewal execution, negotiated renewal, evergreen continuation), termination (voluntary cancellation, non-renewal expiration, breach-based, regulatory-driven), suspension, and reinstatement. Each event stores event type, event timestamp, prior state, new state, triggering user/system, event-specific detail attributes (amendment description, renewal outcome, termination reason code, penalty amounts), and approval reference. Provides complete chronological contract history for compliance, dispute resolution, revenue retention analysis, and customer service inquiries. Sourced from Salesforce CRM and SAP SD.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`document` (
    `document_id` BIGINT COMMENT 'Primary key for document',
    `contract_id` BIGINT COMMENT 'Reference to the parent contract to which this document belongs. Links document to the service agreement or contract record in Salesforce CRM.',
    `superseded_by_document_id` BIGINT COMMENT 'Reference to the contract document that supersedes or replaces this document. Establishes version lineage and ensures users access the most current document.',
    `access_restriction_notes` STRING COMMENT 'Free-text notes describing specific access restrictions, handling requirements, or distribution limitations for the document. Used for confidential or proprietary documents.',
    `approved_by_user` STRING COMMENT 'User identifier or name of the person who approved the document for execution or publication. Supports approval workflow tracking and accountability.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the document was formally approved. Tracks approval workflow completion and establishes approval audit trail.',
    `checksum_verified_timestamp` TIMESTAMP COMMENT 'Date and time when the document hash checksum was last verified against the stored file. Ensures ongoing document integrity and detects corruption or tampering.',
    `confidentiality_level` STRING COMMENT 'Data classification level indicating the sensitivity and access restrictions for the document. Aligns with enterprise information security policy.. Valid values are `PUBLIC|INTERNAL|CONFIDENTIAL|RESTRICTED`',
    `created_by_user` STRING COMMENT 'User identifier or name of the person who created the document record in the system. Supports audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the document record was first created in the system. Audit trail field for record creation tracking.',
    `document_description` STRING COMMENT 'Detailed narrative description of the document content, purpose, and key provisions. Used for search and retrieval purposes.',
    `document_number` STRING COMMENT 'Business-assigned unique identifier or control number for the document. Used for tracking and retrieval in document management systems.',
    `document_status` STRING COMMENT 'Current lifecycle status of the document indicating its state in the approval and execution workflow. Tracks progression from draft through execution to archival. [ENUM-REF-CANDIDATE: DRAFT|PENDING_REVIEW|PENDING_APPROVAL|APPROVED|EXECUTED|ACTIVE|SUPERSEDED|EXPIRED|TERMINATED|ARCHIVED — 10 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'Date from which the document provisions become legally effective and enforceable. May differ from execution date based on contract terms.',
    `eligible_for_destruction_date` DATE COMMENT 'Calculated date on which the document becomes eligible for destruction per retention policy. Computed as retention_trigger_date plus retention_period_years.',
    `execution_date` DATE COMMENT 'Date on which the document was formally executed or signed by all required parties. Establishes legal effectiveness date for binding documents.',
    `expiration_date` DATE COMMENT 'Date on which the document or its provisions cease to be effective. Applicable to time-limited documents such as permits, certificates of insurance, and term-based amendments.',
    `extracted_text_available_flag` BOOLEAN COMMENT 'Boolean indicator of whether extracted text content is available for the document. Supports full-text search and content analysis capabilities.',
    `file_size_bytes` BIGINT COMMENT 'Size of the document file measured in bytes. Used for storage management and transmission planning.',
    `format` STRING COMMENT 'File format or media type of the stored document. Common formats include Portable Document Format (PDF), Microsoft Word (DOCX), Microsoft Excel (XLSX), Tagged Image File Format (TIFF), and email formats (MSG, EML). [ENUM-REF-CANDIDATE: PDF|DOCX|DOC|XLSX|XLS|TIF|TIFF|JPG|JPEG|PNG|MSG|EML — 12 candidates stripped; promote to reference product]',
    `hash` STRING COMMENT 'Cryptographic hash (SHA-256 or MD5) of the document file content. Ensures document integrity and detects unauthorized modifications for audit and compliance purposes.',
    `indexed_for_search_flag` BOOLEAN COMMENT 'Boolean indicator of whether the document content has been indexed for full-text search. Enables rapid document discovery and retrieval.',
    `last_modified_by_user` STRING COMMENT 'User identifier or name of the person who last modified the document record. Supports audit trail and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the document record was last modified in the system. Audit trail field for change tracking.',
    `legal_hold_case_number` STRING COMMENT 'Case or matter number associated with the legal hold. Links document to specific litigation, investigation, or regulatory proceeding requiring preservation.',
    `legal_hold_flag` BOOLEAN COMMENT 'Boolean indicator of whether the document is subject to a legal hold or litigation hold order. When true, document must be preserved and cannot be destroyed regardless of retention schedule.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or context about the document. Used for internal annotations and handling instructions.',
    `ocr_processed_flag` BOOLEAN COMMENT 'Boolean indicator of whether the document has been processed through Optical Character Recognition (OCR) to extract text from scanned images. Enables searchability of scanned documents.',
    `page_count` STRING COMMENT 'Total number of pages in the document. Applicable to paginated document formats such as PDF and Word documents.',
    `regulatory_filing_date` DATE COMMENT 'Date on which the document was filed with the applicable regulatory authority. Used for compliance tracking and audit trail purposes.',
    `related_document_ids` STRING COMMENT 'Comma-separated list of contract_document_id values for related or cross-referenced documents. Supports navigation between exhibits, addenda, and parent agreements.',
    `requires_regulatory_filing` BOOLEAN COMMENT 'Boolean indicator of whether this document must be filed with or submitted to a regulatory authority such as Environmental Protection Agency (EPA), state environmental quality department, or local solid waste authority.',
    `retention_period_years` STRING COMMENT 'Number of years the document must be retained per legal, regulatory, or internal policy requirements. Drives records retention schedule and archival processes.',
    `retention_trigger_date` DATE COMMENT 'Date from which the retention period begins counting. Typically the execution date, expiration date, or contract termination date depending on document type and retention policy.',
    `signatory_party_names` STRING COMMENT 'Comma-separated list of all parties who signed or are required to sign the document. Includes customer representatives, Waste Management authorized signatories, and third-party witnesses.',
    `source_system` STRING COMMENT 'Name of the originating system or application from which the document was uploaded or created. Examples include Salesforce CRM, SAP Document Management, SharePoint, or email systems.',
    `source_system_document_code` STRING COMMENT 'Unique identifier for the document in the source system. Enables traceability and reconciliation between the lakehouse and operational systems.',
    `storage_path` STRING COMMENT 'Full file path or Uniform Resource Locator (URL) reference to the physical document location in the Document Management System (DMS), SharePoint, or cloud storage repository. Enables direct retrieval of the document file.',
    `title` STRING COMMENT 'Full descriptive title of the document as it appears on the document itself. Provides human-readable identification of document content and purpose.',
    `type_code` STRING COMMENT 'Classification code indicating the type of contract document: executed agreement, exhibit, addendum, amendment, certificate of insurance (COI), regulatory permit, franchise ordinance, amendment letter, rate schedule, attachment, notice, waiver, or consent form. [ENUM-REF-CANDIDATE: AGREEMENT|EXHIBIT|ADDENDUM|AMENDMENT|COI|PERMIT|FRANCHISE|ORDINANCE|LETTER|SCHEDULE|ATTACHMENT|NOTICE|WAIVER|CONSENT — 14 candidates stripped; promote to reference product]',
    `version_number` STRING COMMENT 'Version identifier for the document indicating revision level. Supports version control and tracking of document changes over time.',
    CONSTRAINT pk_document PRIMARY KEY(`document_id`)
) COMMENT 'Metadata registry for all legal documents associated with a contract including the executed agreement, exhibits, addenda, certificates of insurance, regulatory permits, franchise ordinances, and amendment letters. Stores document type, document title, version number, execution date, signatory parties, document storage reference (DMS path or SharePoint URL), and document status (draft, executed, superseded). Enables document retrieval for audits, disputes, and regulatory inspections.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`billing_term` (
    `billing_term_id` BIGINT COMMENT 'Unique identifier for the billing term record. Primary key.',
    `contract_id` BIGINT COMMENT 'Reference to the parent contract to which these billing terms apply. Links billing configuration to the master service agreement.',
    `accepted_payment_methods` STRING COMMENT 'Comma-separated list of payment methods accepted under this billing term (e.g., check, ACH, credit_card, wire_transfer). Defines customer payment options.',
    `auto_pay_enabled` BOOLEAN COMMENT 'Indicates whether automatic payment processing is enabled for this billing term. True if customer has authorized automatic payment deduction.',
    `billing_address_line1` STRING COMMENT 'First line of the billing address where paper invoices and billing correspondence are sent.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address (suite, apartment, building number, etc.). Optional.',
    `billing_city` STRING COMMENT 'City name for the billing address.',
    `billing_contact_email` STRING COMMENT 'Primary email address for billing-related communications and invoice delivery. Used for electronic invoice distribution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `billing_contact_phone` STRING COMMENT 'Primary phone number for billing inquiries and payment-related communications.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the billing address (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `billing_cycle_day` STRING COMMENT 'Day of the month when the billing cycle closes and invoice is generated (e.g., 1 for first of month, 15 for mid-month). Null for event-based billing.',
    `billing_frequency` STRING COMMENT 'Frequency at which invoices are generated for the contract. Determines billing cycle cadence. [ENUM-REF-CANDIDATE: monthly|quarterly|annually|semi_annually|per_service_event|weekly|bi_weekly — 7 candidates stripped; promote to reference product]',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code for the billing address.',
    `billing_state_province` STRING COMMENT 'Two-letter state or province code for the billing address (e.g., CA, TX, ON).. Valid values are `^[A-Z]{2}$`',
    `billing_term_status` STRING COMMENT 'Current lifecycle status of the billing term configuration. Active terms are in use for billing operations.. Valid values are `active|inactive|suspended|pending_approval|expired|terminated`',
    `created_by_user` STRING COMMENT 'User ID or username of the person who created this billing term record. Audit trail field.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this billing term record was first created in the system. Audit trail field.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum outstanding balance allowed for the customer under this billing term. Used for credit control and risk management. Null if no limit applies.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this billing term (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `discount_terms` STRING COMMENT 'Early payment discount terms (e.g., 2/10 Net 30 means 2% discount if paid within 10 days, otherwise net 30). Null if no early payment discount applies.',
    `dunning_procedure` STRING COMMENT 'Collections procedure applied for overdue invoices. Defines escalation steps and timing for collection actions.. Valid values are `standard|aggressive|lenient|custom|none`',
    `effective_end_date` DATE COMMENT 'Date when this billing term configuration expires and is no longer valid for new billing. Null for open-ended terms.',
    `effective_start_date` DATE COMMENT 'Date when this billing term configuration becomes effective and can be applied to billing operations.',
    `electronic_invoice_format` STRING COMMENT 'File format for electronic invoice delivery. EDI 810 is the standard Electronic Data Interchange (EDI) invoice transaction set.. Valid values are `pdf|xml|edi_810|csv|json`',
    `grace_period_days` STRING COMMENT 'Number of days after payment due date before late payment penalties are applied. Provides customer buffer period.',
    `invoice_consolidation` BOOLEAN COMMENT 'Indicates whether multiple service charges should be consolidated into a single invoice. True for consolidated billing, False for separate invoices per service.',
    `invoice_delivery_method` STRING COMMENT 'Method by which invoices are delivered to the customer. Supports paper mail, electronic delivery, Electronic Data Interchange (EDI), customer portal access, or combined methods.. Valid values are `paper|email|edi|portal|fax|combined`',
    `last_modified_by_user` STRING COMMENT 'User ID or username of the person who last modified this billing term record. Audit trail field.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this billing term record was last updated. Audit trail field for change tracking.',
    `late_payment_penalty_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied to overdue balances as a late payment penalty. Expressed as annual percentage rate (APR). Null if no late fees apply.',
    `minimum_invoice_amount` DECIMAL(18,2) COMMENT 'Minimum monetary amount required to generate an invoice. Charges below this threshold may be carried forward to next billing cycle. Null if no minimum applies.',
    `notes` STRING COMMENT 'Free-text notes capturing special billing instructions, exceptions, or additional context for this billing term arrangement.',
    `payment_due_day` STRING COMMENT 'Specific day of the month when payment is due, if applicable. Used for fixed-date payment schedules (e.g., payment always due on the 15th of the month).',
    `payment_terms` STRING COMMENT 'Standard payment terms defining the number of days from invoice date by which payment is due. Net 30 means payment due within 30 days of invoice date. [ENUM-REF-CANDIDATE: net_30|net_45|net_60|net_15|due_on_receipt|prepaid|net_90 — 7 candidates stripped; promote to reference product]',
    `proration_allowed` BOOLEAN COMMENT 'Indicates whether charges can be prorated for partial billing periods (e.g., mid-cycle service start or termination). True if proration is permitted.',
    `security_deposit_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the security deposit required, if applicable. Null if no deposit is required.',
    `security_deposit_required` BOOLEAN COMMENT 'Indicates whether a security deposit is required under this billing term. True if deposit is mandatory, False otherwise.',
    `statement_frequency` STRING COMMENT 'Frequency at which account statements are generated and sent to the customer. Separate from invoice frequency.. Valid values are `monthly|quarterly|none|on_demand`',
    `tax_exempt` BOOLEAN COMMENT 'Indicates whether the customer is exempt from sales tax under this billing term. True if tax-exempt status applies.',
    `tax_exemption_certificate_number` STRING COMMENT 'Government-issued tax exemption certificate number, if applicable. Required for tax-exempt customers to validate exemption status.',
    `term_code` STRING COMMENT 'Unique business identifier code for the billing term configuration. Used for external reference and integration with Oracle Revenue Management.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `term_name` STRING COMMENT 'Human-readable name describing the billing term arrangement (e.g., Monthly Net 30, Quarterly Prepaid, Per-Service Event).',
    CONSTRAINT pk_billing_term PRIMARY KEY(`billing_term_id`)
) COMMENT 'Defines the billing and payment terms embedded in a contract, including billing frequency (monthly, quarterly, per-service-event), invoice delivery method (paper, email, EDI, portal), payment terms (Net 30, Net 45, prepaid), accepted payment methods, late payment penalty rate, security deposit requirements, and credit limit. Links contract commitments to Oracle Revenue Management billing configuration. Ensures billing setup accurately reflects negotiated contract terms.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`volume_commitment` (
    `volume_commitment_id` BIGINT COMMENT 'Unique identifier for the volume commitment record. Primary key.',
    `contract_id` BIGINT COMMENT 'Reference to the parent contract or service agreement that contains this volume commitment. Links to the contract master record.',
    `facility_id` BIGINT COMMENT 'Reference to the WM facility (landfill, transfer station, MRF, or WTE plant) where the committed volume will be received or processed. Used for capacity planning and throughput forecasting. Null if commitment is facility-agnostic or covers multiple sites.',
    `service_enrollment_id` BIGINT COMMENT 'Foreign key linking to customer.service_enrollment. Business justification: Volume commitments (minimum tonnage guarantees) are tied to specific service enrollments for true-up calculations. Linking enables enrollment-level variance tracking, shortfall penalty assessment, and',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: Volume commitments specify minimum/maximum tonnage guarantees by waste stream (MSW, recyclables, organics). Essential for true-up calculations, shortfall penalty assessment, diversion rate tracking, a',
    `actual_volume_to_date` DECIMAL(18,2) COMMENT 'Cumulative actual volume delivered or processed within the current measurement period. Updated continuously from load tickets, scale transactions, and haul manifests. Compared against committed quantity to calculate variance and trigger alerts.',
    `amendment_reference` STRING COMMENT 'Reference to the contract amendment document that created or modified this volume commitment. Used for audit trail and legal documentation. Null for commitments established in the original contract.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this volume commitment automatically renews at the end of its term. True triggers renewal workflow and extends effective end date; false requires explicit renegotiation or amendment. Common for evergreen municipal contracts.',
    `calculation_methodology` STRING COMMENT 'Detailed description of how actual volume is measured and compared to committed quantity. May reference specific scale systems, load ticket aggregation rules, proration formulas, or third-party verification procedures. Critical for dispute resolution and audit compliance.',
    `commitment_direction` STRING COMMENT 'Identifies the party making the volume commitment. Customer-to-WM: customer guarantees to deliver minimum volume to WM facility (common for landfill disposal contracts). WM-to-customer: WM guarantees capacity or service availability. WM-to-third-party: WM commits to deliver volume to external disposal facility. Third-party-to-WM: external hauler commits to deliver volume to WM facility.. Valid values are `customer_to_wm|wm_to_customer|wm_to_third_party|third_party_to_wm`',
    `commitment_number` STRING COMMENT 'Business identifier for the volume commitment, often used in contract documentation and customer communications. May follow customer-specific or internal numbering schemes.',
    `commitment_status` STRING COMMENT 'Current lifecycle status of the volume commitment. Active commitments are in force and being measured; suspended commitments are temporarily paused; expired commitments have passed their end date; terminated commitments were ended early; pending activation are signed but not yet effective; under review are being evaluated for amendment or dispute.. Valid values are `active|suspended|expired|terminated|pending_activation|under_review`',
    `commitment_type` STRING COMMENT 'Classification of the volume commitment structure. Minimum volume requires customer to deliver a floor quantity; tonnage guarantee commits WM to accept a minimum; take-or-pay obligates payment regardless of delivery; capacity reservation holds disposal capacity; throughput commitment guarantees processing volume; load guarantee commits to a number of hauls or loads.. Valid values are `minimum_volume|tonnage_guarantee|take_or_pay|capacity_reservation|throughput_commitment|load_guarantee`',
    `committed_quantity` DECIMAL(18,2) COMMENT 'The minimum or guaranteed volume quantity specified in the commitment. Represents the floor volume (for customer commitments) or ceiling capacity (for WM guarantees). Used as the baseline for shortfall and excess calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this volume commitment record was first created in the system. Represents the business event of commitment establishment, not the technical ETL load time.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this commitment (shortfall penalty rate, excess tonnage rate, true-up amounts). Typically USD for US operations; CAD for Canadian operations.. Valid values are `^[A-Z]{3}$`',
    `customer_approval_required` BOOLEAN COMMENT 'Indicates whether changes to this volume commitment require formal customer approval. True for commitments with strict governance (municipal contracts, franchise agreements); false for standard commercial agreements where WM has unilateral adjustment rights within contract terms.',
    `dispute_period_days` STRING COMMENT 'The number of days after true-up invoicing during which the customer may dispute the volume variance calculation or penalty assessment. Used to manage accounts receivable aging and dispute resolution workflows.',
    `effective_end_date` DATE COMMENT 'The date on which this volume commitment expires or terminates. May be null for evergreen commitments that renew automatically. Used to determine commitment lifecycle and trigger renewal or renegotiation workflows.',
    `effective_start_date` DATE COMMENT 'The date on which this volume commitment becomes active and measurement begins. Aligns with contract effective date or amendment date if the commitment was added mid-term.',
    `excess_tonnage_rate` DECIMAL(18,2) COMMENT 'The pricing rate applied to volume delivered above the committed quantity. May be discounted (incentive for over-delivery) or premium (capacity constraint surcharge). Expressed in currency per unit of measure. Null if standard rates apply to excess volume.',
    `force_majeure_applicable` BOOLEAN COMMENT 'Indicates whether force majeure provisions (natural disasters, strikes, regulatory shutdowns) suspend or modify the volume commitment obligations. True means commitment is waived during qualifying events; false means commitment remains in force regardless of external circumstances.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this volume commitment record was most recently updated. Tracks amendments, status changes, and data corrections. Used for change data capture and audit trails.',
    `last_true_up_amount` DECIMAL(18,2) COMMENT 'The financial adjustment (penalty or excess charge) calculated at the most recent true-up. Positive values represent charges to customer; negative values represent credits. Used for revenue recognition and accounts receivable management.',
    `last_true_up_date` DATE COMMENT 'The date of the most recent volume reconciliation and true-up calculation. Used to track billing cycles and ensure timely reconciliation. Updated after each true-up process completes.',
    `last_true_up_variance` DECIMAL(18,2) COMMENT 'The variance quantity calculated at the most recent true-up. Provides historical performance context and trend analysis. Used for forecasting and contract renegotiation discussions.',
    `measurement_period` STRING COMMENT 'The time interval over which the committed quantity is measured and evaluated. Daily commitments are common for Tons Per Day (TPD) contracts; monthly for MSW hauling; quarterly or annual for large municipal or commercial agreements; contract term for total lifecycle commitments.. Valid values are `daily|weekly|monthly|quarterly|annual|contract_term`',
    `modified_by` STRING COMMENT 'The user ID or system account that performed the most recent modification to this volume commitment record. Used for audit trails and accountability in contract change management.',
    `next_true_up_date` DATE COMMENT 'The scheduled date for the next volume reconciliation and true-up calculation. Used to trigger billing workflows and variance reporting. Updated after each true-up cycle.',
    `notes` STRING COMMENT 'Free-text field for additional context, special terms, or operational instructions related to this volume commitment. May include references to side letters, verbal agreements, or customer-specific measurement procedures.',
    `notification_threshold_percentage` DECIMAL(18,2) COMMENT 'The variance percentage threshold that triggers automated alerts to account managers and customers. For example, 80% means alert when actual volume reaches 80% of committed quantity (risk of shortfall) or exceeds 120% (capacity constraint). Used for proactive contract management.',
    `proration_allowed` BOOLEAN COMMENT 'Indicates whether the committed quantity is prorated for partial measurement periods (e.g., mid-month contract start, early termination, or service suspension). True allows proportional adjustment; false requires full-period commitment regardless of actual service days.',
    `renewal_notice_days` STRING COMMENT 'The number of days advance notice required before the effective end date to trigger renewal or termination workflows. Used to schedule customer outreach and contract renegotiation activities. Null if auto-renewal is not applicable.',
    `shortfall_penalty_rate` DECIMAL(18,2) COMMENT 'The financial penalty rate applied per unit when actual volume delivered falls below the committed quantity. Expressed in currency per unit of measure (e.g., dollars per ton below minimum). Core component of take-or-pay economics. Null if no penalty applies.',
    `source_record_code` STRING COMMENT 'The unique identifier of this volume commitment in the source system. Used for traceability, troubleshooting, and bidirectional synchronization between lakehouse and operational systems.',
    `source_system` STRING COMMENT 'The operational system of record from which this volume commitment was originally created or is mastered. Typically Salesforce CRM for customer-facing contracts or SAP SD for enterprise agreements. Used for data lineage and reconciliation.',
    `supporting_documentation_required` BOOLEAN COMMENT 'Indicates whether detailed supporting documentation (load tickets, scale reports, manifests) must be provided with true-up invoices. True for high-value contracts or those with strict audit requirements; false for standard commercial agreements with self-service reporting.',
    `true_up_frequency` STRING COMMENT 'The frequency at which actual volume is reconciled against committed volume and shortfall penalties or excess charges are calculated and invoiced. Monthly true-ups provide frequent reconciliation; annual true-ups are common for large municipal contracts; contract-end true-ups settle the entire term at close.. Valid values are `monthly|quarterly|semi_annual|annual|contract_end`',
    `unit_of_measure` STRING COMMENT 'The unit in which the committed quantity is expressed. Tons and metric tons are standard for landfill disposal; cubic yards for compacted waste volume; loads or trips for hauling commitments; containers for service-level agreements; gallons for liquid waste. [ENUM-REF-CANDIDATE: tons|cubic_yards|loads|trips|containers|gallons|kilograms|metric_tons — 8 candidates stripped; promote to reference product]',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance quantity expressed as a percentage of the committed quantity. Provides normalized view of performance across commitments with different scales. Used for KPI dashboards and executive reporting.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'The difference between actual volume to date and committed quantity for the current measurement period. Positive variance indicates over-delivery; negative variance indicates shortfall. Used to calculate penalties or excess charges at true-up.',
    CONSTRAINT pk_volume_commitment PRIMARY KEY(`volume_commitment_id`)
) COMMENT 'Captures minimum volume guarantees and tonnage commitments within disposal and hauling contracts, implementing take-or-pay economics. Stores committed volume quantity, unit of measure (tons per day, tons per month, annual tons, loads per week), measurement period, shortfall penalty rate ($/ton below minimum), excess tonnage rate, true-up frequency (monthly, quarterly, annual), and actual-vs-committed variance tracking. Critical for landfill capacity planning, transfer station throughput management, and revenue assurance. Supports both WM-as-disposer (guaranteeing capacity) and WM-as-hauler (guaranteeing volume to third-party facilities) scenarios.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`compliance_obligation` (
    `compliance_obligation_id` BIGINT COMMENT 'Primary key for compliance_obligation',
    `contract_id` BIGINT COMMENT 'Reference to the parent contract that contains this compliance obligation.',
    `ghg_emission_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_emission. Business justification: Contracts with large commercial/industrial customers may include GHG reporting obligations where the hauler must track and report emissions from waste collection/disposal. Links contractual reporting ',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Compliance obligations (diversion rates, GHG reduction, reporting) are tied to specific service offerings with regulatory requirements. Needed for regulatory reporting, sustainability program tracking',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Contract compliance obligations (diversion rates, reporting frequencies, environmental performance targets in franchise agreements) are driven by specific regulatory requirements. Links contractual co',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Compliance obligations require accountable employee assignment for regulatory reporting, audit trails, performance tracking, and escalation procedures. Environmental services compliance (RCRA, EPA, st',
    `safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Contract compliance obligations frequently reference specific safety programs (e.g., "Maintain OSHA VPP Star certification", "Implement EPA Spill Prevention Program"). Required for compliance verifica',
    `waste_generator_profile_id` BIGINT COMMENT 'Foreign key linking to customer.waste_generator_profile. Business justification: Compliance obligations (manifest requirements, EPA biennial reports, RCRA notifications) are driven by generator profile classification (LQG/SQG/CESQG). Linking enables automated compliance tracking, ',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this compliance obligation is currently active and being tracked.',
    `audit_frequency` STRING COMMENT 'How often this obligation is subject to internal or external audit: monthly, quarterly, annual, biennial, ad-hoc (as needed), or none.. Valid values are `monthly|quarterly|annual|biennial|ad_hoc|none`',
    `compliance_status` STRING COMMENT 'Current compliance state: compliant (obligation met), non_compliant (violation or missed deadline), pending (awaiting verification), in_progress (actively being fulfilled), waived (temporarily exempted), or not_applicable (obligation no longer applies).. Valid values are `compliant|non_compliant|pending|in_progress|waived|not_applicable`',
    `contract_clause_reference` STRING COMMENT 'Specific contract section, clause, or exhibit number that defines this obligation (e.g., Section 7.3, Exhibit B, Schedule 2).',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this compliance obligation record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance obligation record was first created in the system.',
    `documentation_required` STRING COMMENT 'Types of documentation or evidence required to demonstrate compliance (e.g., manifests, tonnage reports, inspection certificates, training records, emissions calculations).',
    `effective_end_date` DATE COMMENT 'Date when this compliance obligation expires or is no longer applicable. Null indicates ongoing obligation.',
    `effective_start_date` DATE COMMENT 'Date when this compliance obligation becomes active and enforceable.',
    `escalation_procedure` STRING COMMENT 'Process for escalating non-compliance issues, including notification chain and remediation steps.',
    `governing_regulation` STRING COMMENT 'The specific regulation, statute, or standard that mandates this obligation (e.g., RCRA Subtitle D, Clean Air Act Section 111, ISO 14001:2015, Municipal Code Section 8.40).',
    `grace_period_days` STRING COMMENT 'Number of days after the due date during which late submission is still accepted without penalty.',
    `last_audit_date` DATE COMMENT 'Date of the most recent audit or compliance review for this obligation.',
    `last_audit_result` STRING COMMENT 'Outcome of the most recent audit: passed (compliant), failed (non-compliant), conditional (compliant with corrective actions), or not_audited.. Valid values are `passed|failed|conditional|not_audited`',
    `last_compliance_date` DATE COMMENT 'Date when the obligation was last successfully fulfilled or reported.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this compliance obligation record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance obligation record was most recently updated.',
    `measurement_methodology` STRING COMMENT 'Description of how compliance is measured and verified (e.g., monthly tonnage reports, third-party audit, GPS tracking data, manifest counts, emissions calculations per EPA Method 25).',
    `next_due_date` DATE COMMENT 'Next scheduled date by which the obligation must be fulfilled or reported.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the compliance obligation, including historical changes or special circumstances.',
    `obligation_category` STRING COMMENT 'Functional category of the obligation: reporting (periodic submissions), manifest submission (hazardous waste tracking), diversion rate (waste reduction targets), emissions (GHG/air quality), safety (OSHA standards), performance (SLA metrics), financial (bonding/insurance), or operational (service delivery standards). [ENUM-REF-CANDIDATE: reporting|manifest_submission|diversion_rate|emissions|safety|performance|financial|operational — 8 candidates stripped; promote to reference product]',
    `obligation_description` STRING COMMENT 'Detailed description of the compliance obligation including specific requirements, deliverables, and performance criteria.',
    `obligation_number` STRING COMMENT 'Business-facing unique identifier for the compliance obligation, used in reporting and tracking.. Valid values are `^OBL-[0-9]{8}$`',
    `obligation_title` STRING COMMENT 'Short descriptive title of the compliance obligation for identification and reporting purposes.',
    `obligation_type` STRING COMMENT 'Classification of the compliance obligation source: regulatory (EPA, OSHA, DOT), contractual (customer SLA), statutory (RCRA, CERCLA), voluntary (ISO certification), franchise (municipal agreement), or permit (operating license).. Valid values are `regulatory|contractual|statutory|voluntary|franchise|permit`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount for non-compliance, if applicable, in the contract currency.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `penalty_for_non_compliance` STRING COMMENT 'Description of penalties, fines, or consequences for failing to meet the obligation (e.g., monetary fine, contract termination, permit suspension, liquidated damages).',
    `reporting_frequency` STRING COMMENT 'How often the obligation must be fulfilled or reported: daily, weekly, monthly, quarterly, semi-annual, annual, biennial, event-driven (triggered by specific events), or continuous (ongoing monitoring). [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|semi_annual|annual|biennial|event_driven|continuous — 9 candidates stripped; promote to reference product]',
    `responsible_department` STRING COMMENT 'Internal department or business unit accountable for managing and fulfilling this obligation (e.g., Environmental Compliance, Operations, Safety, Finance).',
    `responsible_party` STRING COMMENT 'Entity responsible for fulfilling the obligation: waste_management (company obligation), customer (customer responsibility), third_party (contractor/vendor), joint (shared responsibility), or regulatory_agency (government-led).. Valid values are `waste_management|customer|third_party|joint|regulatory_agency`',
    `submission_method` STRING COMMENT 'Method by which compliance documentation must be submitted: electronic (file upload), paper (physical mail), portal (web-based system), email, API (system integration), or in-person.. Valid values are `electronic|paper|portal|email|api|in_person`',
    `submission_recipient` STRING COMMENT 'Entity or system to which compliance documentation must be submitted (e.g., EPA Regional Office, State Environmental Agency, Customer Contract Manager, SWIS Portal).',
    `target_metric` STRING COMMENT 'Specific performance metric or KPI that must be achieved (e.g., 50% diversion rate, 95% on-time service, zero OSHA recordables, GHG reduction of 10%).',
    `target_unit_of_measure` STRING COMMENT 'Unit of measure for the target value (e.g., percentage, tons, days, incidents, CO2e metric tons).',
    `target_value` DECIMAL(18,2) COMMENT 'Numeric target value for the performance metric (e.g., 50.00 for 50% diversion rate, 95.00 for 95% on-time).',
    `waiver_expiration_date` DATE COMMENT 'Date when the granted waiver expires and the obligation resumes, if applicable.',
    `waiver_granted` BOOLEAN COMMENT 'Indicates whether a temporary waiver or exemption from this obligation has been granted.',
    `waiver_reason` STRING COMMENT 'Justification or reason for granting the waiver (e.g., force majeure, regulatory change, operational constraints).',
    CONSTRAINT pk_compliance_obligation PRIMARY KEY(`compliance_obligation_id`)
) COMMENT 'Tracks regulatory and contractual compliance obligations embedded within contracts, including EPA reporting requirements, RCRA manifest submission obligations, diversion rate targets mandated by municipal franchises, GHG emissions reporting commitments, and OSHA safety standards for on-site service. Captures obligation type, governing regulation or clause reference, reporting frequency, responsible party, and compliance status. Bridges contract domain with the compliance domain for obligation tracking.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`party` (
    `party_id` BIGINT COMMENT 'Unique identifier for the contract party record. Primary key.',
    `contract_id` BIGINT COMMENT 'Reference to the parent contract to which this party is associated.',
    `parent_party_id` BIGINT COMMENT 'Self-referencing FK on party (parent_party_id)',
    `address_line1` STRING COMMENT 'Primary street address line for the partys legal or administrative office. Used for official correspondence and legal notices.',
    `address_line2` STRING COMMENT 'Secondary address line for suite, floor, building, or department information.',
    `amendment_reference` STRING COMMENT 'Reference number of the contract amendment that added or modified this partys role. Links party changes to formal contract amendments.',
    `authority_level` STRING COMMENT 'The level of authority this party holds in contract execution and administration. Signatory can execute amendments; approver can authorize changes; administrator manages day-to-day operations; observer receives notifications only; beneficiary receives services or payments.. Valid values are `signatory|approver|administrator|observer|beneficiary`',
    `city` STRING COMMENT 'City or municipality name for the partys address.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the partys address. Waste Management primarily operates in USA, CAN (Canada), and MEX (Mexico).. Valid values are `USA|CAN|MEX`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract party record was first created in the system. Used for audit trail and data lineage.',
    `dba_name` STRING COMMENT 'The trade name or doing-business-as name if different from the legal name. Common for franchises and subsidiaries.',
    `effective_end_date` DATE COMMENT 'Date on which this partys role in the contract ends. Null for ongoing participation; populated when party is removed or contract terminates.',
    `effective_start_date` DATE COMMENT 'Date on which this partys role in the contract becomes active and binding. May differ from contract effective date for parties added via amendment.',
    `guarantee_amount` DECIMAL(18,2) COMMENT 'Maximum financial liability or guarantee amount this party has committed to under the contract. Applicable when guarantor_flag is true.',
    `guarantee_currency_code` STRING COMMENT 'Three-letter ISO currency code for the guarantee amount. Typically USD for US operations, CAD for Canada, MXN for Mexico.. Valid values are `USD|CAD|MXN`',
    `guarantor_flag` BOOLEAN COMMENT 'Indicates whether this party serves as a financial or performance guarantor for the contract. True for guarantors who assume liability; false otherwise.',
    `insurance_certificate_number` STRING COMMENT 'Certificate number for insurance coverage provided by or required from this party. Applicable for insurer parties or parties required to maintain insurance.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Total coverage amount of insurance policy associated with this partys role in the contract. Used for risk assessment and compliance verification.',
    `insurance_expiration_date` DATE COMMENT 'Expiration date of the insurance certificate. Triggers renewal notifications and compliance monitoring.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this contract party record. Used for change tracking and audit purposes.',
    `legal_name` STRING COMMENT 'The full legal name of the party as it appears on official documents and contracts. Used for contract execution and legal correspondence.',
    `notes` STRING COMMENT 'Free-form text field for additional information about this partys role, special requirements, or administrative notes.',
    `party_status` STRING COMMENT 'Current lifecycle status of the partys participation in the contract. Active indicates the party is currently engaged; inactive indicates the party role has ended; suspended indicates temporary hold; pending_approval indicates awaiting authorization; terminated indicates formal removal from contract.. Valid values are `active|inactive|suspended|pending_approval|terminated`',
    `party_type` STRING COMMENT 'Legal classification of the party entity. Distinguishes between individual persons, corporations, partnerships, government entities, nonprofit organizations, trusts, and joint ventures. [ENUM-REF-CANDIDATE: individual|corporation|partnership|government|nonprofit|trust|joint_venture — 7 candidates stripped; promote to reference product]',
    `postal_code` STRING COMMENT 'ZIP code or postal code for the partys address. Used for mail delivery and geographic analysis.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact for contract-related correspondence, notices, and amendments.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person for contract administration and communication at this party organization.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for reaching the contract contact. Includes country code, area code, and extension if applicable.',
    `primary_contact_title` STRING COMMENT 'Job title or position of the primary contact person (e.g., Procurement Manager, City Administrator, Operations Director).',
    `reference_code` BIGINT COMMENT 'Foreign key reference to the master data record for this party. The target table is determined by party_reference_type (e.g., customer_id, vendor_id, municipality_id).',
    `reference_type` STRING COMMENT 'Indicates which master data domain this party references. Determines whether the party_reference_id points to customer master, vendor master, employee master, municipality registry, regulatory agency registry, or internal WM entity.. Valid values are `customer|vendor|employee|municipality|regulatory_agency|internal_entity`',
    `role_code` STRING COMMENT 'The role this party plays in the contract relationship. Common roles include customer (service recipient), provider (WM contracting entity), guarantor (financial guarantor), regulator (municipal or environmental authority), subcontractor (third-party hauler or processor), insurer (insurance provider), municipal_authority (local government entity), franchise_authority (franchising body), hauler (transportation provider), disposal_facility (landfill or processing facility operator), broker (intermediary), consultant (advisory party). [ENUM-REF-CANDIDATE: customer|provider|guarantor|regulator|subcontractor|insurer|municipal_authority|franchise_authority|hauler|disposal_facility|broker|consultant — 12 candidates stripped; promote to reference product]',
    `secondary_contact_email` STRING COMMENT 'Email address of the secondary contact for escalation and backup communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `secondary_contact_name` STRING COMMENT 'Full name of the secondary or backup contact person for contract administration.',
    `secondary_contact_phone` STRING COMMENT 'Telephone number for the secondary contact person.',
    `sequence_number` STRING COMMENT 'Sequential ordering of parties within the contract for multi-party agreements.',
    `signatory_name` STRING COMMENT 'Full name of the individual who signed on behalf of this party. May differ from primary contact if an officer or authorized representative signed.',
    `signatory_title` STRING COMMENT 'Official title of the signatory (e.g., Chief Executive Officer, City Manager, Authorized Representative). Establishes legal authority to bind the party.',
    `signature_date` DATE COMMENT 'Date on which this party signed the contract or amendment. Used to establish binding agreement and effective dates.',
    `signature_required_flag` BOOLEAN COMMENT 'Indicates whether this partys signature is required for contract execution and amendments. True for signatories and guarantors; false for observers and administrators.',
    `state_province` STRING COMMENT 'State, province, or region code for the partys address. Uses standard two-letter state abbreviations for US addresses.',
    `tax_identification_number` STRING COMMENT 'Federal tax identification number (EIN for entities, SSN for individuals) used for tax reporting and compliance. Required for payment processing and 1099 reporting.',
    `termination_reason_code` STRING COMMENT 'Reason code for why this partys participation ended. Applicable when effective_end_date is populated. Used for churn analysis and risk assessment. [ENUM-REF-CANDIDATE: contract_expiration|mutual_agreement|breach|bankruptcy|merger_acquisition|regulatory_change|non_performance — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_party PRIMARY KEY(`party_id`)
) COMMENT 'Identifies all parties and their roles associated with a contract including the customer legal entity, WM contracting entity, guarantors, municipal authorities, subcontractors, and insurance providers. Captures party role (customer, provider, guarantor, regulator), party reference (link to customer or vendor master), contact information for contract administration, and authority level. Supports multi-party contracts common in municipal franchise agreements and subcontracted hauling arrangements.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`service_area` (
    `service_area_id` BIGINT COMMENT 'Unique identifier for this contract-service area coverage record. Primary key.',
    `area_id` BIGINT COMMENT 'Foreign key linking to the geographic service territory covered by this contract',
    `contract_id` BIGINT COMMENT 'Foreign key linking to the service agreement that authorizes service in this territory',
    `effective_end_date` DATE COMMENT 'Date when this contracts authorization to serve this specific service area expires or is terminated. Nullable if coverage continues through contract expiration.',
    `effective_start_date` DATE COMMENT 'Date when this contracts authorization to serve this specific service area becomes effective. May differ from the overall contract effective date if coverage is phased or amended.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this contract grants exclusive rights to provide waste management services in this service area, prohibiting competitors from operating in the territory.',
    `franchise_fee_rate` DECIMAL(18,2) COMMENT 'Percentage of gross revenues from this service area that must be paid to the municipality or franchise authority as a franchise fee. Expressed as decimal (e.g., 0.0750 for 7.5%).',
    `service_level_commitment` STRING COMMENT 'Description of the service performance obligations specific to this service area under this contract. May include collection frequency guarantees, response time commitments, or service quality standards that vary by territory.',
    CONSTRAINT pk_service_area PRIMARY KEY(`service_area_id`)
) COMMENT 'This association product represents the franchise coverage relationship between contract and service_area. It captures the geographic scope of service agreements, tracking which contracts authorize service delivery in which territories. Each record links one contract to one service_area with franchise-specific terms, exclusivity provisions, and service commitments that exist only in the context of this geographic coverage relationship. Critical for franchise compliance validation, service eligibility determination, and territory-based billing.. Existence Justification: In waste management operations, municipal and commercial service contracts routinely authorize service delivery across multiple geographic territories (service areas), and each service area is typically covered by multiple contracts serving different customer segments (residential MSW, commercial, hazardous waste). The franchise coverage relationship is an operational business entity that contract administrators actively manage, with territory-specific terms including franchise fees, exclusivity provisions, and service commitments that vary by geography even within the same master contract.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`franchise_requirement_compliance` (
    `franchise_requirement_compliance_id` BIGINT COMMENT 'Unique identifier for this franchise-requirement compliance record. Primary key.',
    `franchise_agreement_id` BIGINT COMMENT 'Foreign key linking to the franchise agreement that is subject to this regulatory requirement',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to the regulatory requirement that applies to this franchise agreement',
    `compliance_deadline` DATE COMMENT 'The specific deadline by which this franchise agreement must demonstrate compliance with this regulatory requirement. May differ from the general requirement effective date based on franchise-specific terms.',
    `compliance_status` STRING COMMENT 'The current compliance status of this franchise agreement with respect to this specific regulatory requirement.',
    `effective_date` DATE COMMENT 'The date on which this regulatory requirement became applicable to this specific franchise agreement. May differ from the general requirement effective date if the franchise was executed later or had a phase-in period.',
    `expiration_date` DATE COMMENT 'The date on which this regulatory requirement ceases to apply to this franchise agreement, typically aligned with franchise expiration or requirement supersession.',
    `last_inspection_date` DATE COMMENT 'The date of the most recent inspection or audit of this franchise agreements compliance with this regulatory requirement.',
    `measurement_methodology` STRING COMMENT 'The specific methodology, calculation formula, or measurement protocol used to assess compliance with this requirement for this franchise agreement. May be customized based on franchise territory characteristics or municipal preferences.',
    `next_inspection_date` DATE COMMENT 'The scheduled date for the next inspection or audit of compliance with this requirement.',
    `notes` STRING COMMENT 'Free-text notes capturing franchise-specific compliance considerations, historical context, or special circumstances related to this requirement.',
    `penalty_provision` STRING COMMENT 'The specific penalty, fine structure, or enforcement action that applies if this franchise agreement fails to meet this regulatory requirement. May include franchise-specific liquidated damages or termination clauses.',
    `performance_target` STRING COMMENT 'The specific performance target or threshold that this franchise agreement must achieve for this regulatory requirement (e.g., 75% diversion rate, zero spills, 95% on-time service). Contextualizes the general requirement to this specific franchise.',
    `reporting_frequency` STRING COMMENT 'The frequency at which this franchise agreement must report compliance with this specific regulatory requirement to the municipality or regulatory body. May be more stringent than the general requirement.',
    `responsible_party` STRING COMMENT 'The internal department, role, or individual responsible for ensuring compliance with this requirement for this franchise agreement (e.g., Regional Compliance Manager, Operations Director - Northern Region).',
    `waiver_expiration_date` DATE COMMENT 'The date on which any granted waiver expires and full compliance is required.',
    `waiver_granted` BOOLEAN COMMENT 'Indicates whether a waiver or variance has been granted exempting this franchise agreement from full compliance with this regulatory requirement.',
    CONSTRAINT pk_franchise_requirement_compliance PRIMARY KEY(`franchise_requirement_compliance_id`)
) COMMENT 'This association product represents the compliance obligation between franchise_agreement and regulatory_requirement. It captures the specific performance targets, deadlines, and penalty provisions that apply when a particular regulatory requirement governs a specific franchise agreement. Each record links one franchise_agreement to one regulatory_requirement with attributes that exist only in the context of this compliance relationship.. Existence Justification: In waste management operations, each franchise agreement with a municipality is subject to multiple regulatory requirements (EPA RCRA rules, state solid waste codes, local ordinances, diversion mandates), and each regulatory requirement applies across multiple franchise agreements in different jurisdictions. The compliance team actively manages these relationships by tracking franchise-specific performance targets, deadlines, measurement methodologies, and penalty provisions that vary by municipality even when the underlying regulation is the same.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`municipality` (
    `municipality_id` BIGINT COMMENT 'Primary key for municipality',
    `parent_municipality_id` BIGINT COMMENT 'Self-referencing FK on municipality (parent_municipality_id)',
    `address_line_1` STRING COMMENT 'Primary street address of the municipality administrative office or city hall.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, floor, or building number for the municipality office.',
    `area_square_miles` DECIMAL(18,2) COMMENT 'Total geographic area of the municipality in square miles, used for route planning and service coverage analysis.',
    `city` STRING COMMENT 'City name for the municipality administrative office address.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the municipality location.',
    `county_name` STRING COMMENT 'Name of the county in which the municipality is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the municipality record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when the municipality record became active and valid in the system.',
    `environmental_compliance_tier` STRING COMMENT 'Classification tier indicating the level of environmental compliance requirements and reporting obligations for the municipality.',
    `expiration_date` DATE COMMENT 'Date when the municipality record is no longer valid or active, used for historical tracking.',
    `fips_code` STRING COMMENT 'Five-digit FIPS code uniquely identifying the municipality for federal reporting and data integration.',
    `fiscal_year_end_month` STRING COMMENT 'Month number (1-12) representing the end of the municipalitys fiscal year, used for contract renewal and budget alignment.',
    `franchise_agreement_flag` BOOLEAN COMMENT 'Indicates whether the municipality operates under an exclusive franchise agreement with Waste Management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the municipality record was last updated or modified.',
    `municipality_code` STRING COMMENT 'Standardized alphanumeric code assigned to the municipality for identification in contracts and billing systems.',
    `municipality_name` STRING COMMENT 'Official legal name of the municipality or local government entity.',
    `municipality_type` STRING COMMENT 'Classification of the municipality based on its governmental structure and jurisdiction level.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special instructions, or historical context about the municipality.',
    `population` STRING COMMENT 'Total population count of the municipality used for service capacity planning and pricing calculations.',
    `postal_code` STRING COMMENT 'Primary postal code or ZIP code for the municipality administrative office.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact person for official communications and contract notifications.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the municipality for contract and service coordination.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the municipality contact person.',
    `primary_contact_title` STRING COMMENT 'Job title or position of the primary contact person at the municipality.',
    `recycling_participation_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of households or businesses participating in recycling programs within the municipality.',
    `regulatory_authority` STRING COMMENT 'Name of the state or regional environmental regulatory body governing waste management operations in this municipality.',
    `secondary_contact_email` STRING COMMENT 'Email address of the secondary contact person for backup communications.',
    `secondary_contact_name` STRING COMMENT 'Full name of the secondary or backup contact person at the municipality.',
    `secondary_contact_phone` STRING COMMENT 'Telephone number for the secondary municipality contact person.',
    `service_area_description` STRING COMMENT 'Textual description of the geographic service area boundaries and coverage zones within the municipality.',
    `state_code` STRING COMMENT 'Two-letter US state abbreviation where the municipality is located.',
    `municipality_status` STRING COMMENT 'Current operational status of the municipality in the contract management system.',
    `tax_identifier` STRING COMMENT 'Federal Employer Identification Number (EIN) or Tax ID for the municipality used in billing and tax reporting.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the municipality location, used for scheduling and service coordination.',
    `waste_generation_rate_tons_per_year` DECIMAL(18,2) COMMENT 'Estimated annual waste generation volume in tons for the municipality, used for capacity planning and pricing.',
    `website_url` STRING COMMENT 'Official website URL of the municipality for public information and reference.',
    CONSTRAINT pk_municipality PRIMARY KEY(`municipality_id`)
) COMMENT 'Master reference table for municipality. Referenced by municipality_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ADD CONSTRAINT `fk_contract_contract_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `waste_management_ecm`.`contract`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ADD CONSTRAINT `fk_contract_contract_parent_agreement_contract_id` FOREIGN KEY (`parent_agreement_contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ADD CONSTRAINT `fk_contract_contract_service_commitment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ADD CONSTRAINT `fk_contract_pricing_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ADD CONSTRAINT `fk_contract_escalation_clause_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ADD CONSTRAINT `fk_contract_sla_term_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_document_id` FOREIGN KEY (`document_id`) REFERENCES `waste_management_ecm`.`contract`.`document`(`document_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_superseded_by_amendment_id` FOREIGN KEY (`superseded_by_amendment_id`) REFERENCES `waste_management_ecm`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `waste_management_ecm`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ADD CONSTRAINT `fk_contract_franchise_agreement_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `waste_management_ecm`.`contract`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ADD CONSTRAINT `fk_contract_franchise_agreement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ADD CONSTRAINT `fk_contract_franchise_agreement_municipality_id` FOREIGN KEY (`municipality_id`) REFERENCES `waste_management_ecm`.`contract`.`municipality`(`municipality_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ADD CONSTRAINT `fk_contract_disposal_agreement_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `waste_management_ecm`.`contract`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ADD CONSTRAINT `fk_contract_disposal_agreement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ADD CONSTRAINT `fk_contract_hauling_agreement_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `waste_management_ecm`.`contract`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ADD CONSTRAINT `fk_contract_hauling_agreement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ADD CONSTRAINT `fk_contract_performance_obligation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ADD CONSTRAINT `fk_contract_lifecycle_event_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ADD CONSTRAINT `fk_contract_lifecycle_event_document_id` FOREIGN KEY (`document_id`) REFERENCES `waste_management_ecm`.`contract`.`document`(`document_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`document` ADD CONSTRAINT `fk_contract_document_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`document` ADD CONSTRAINT `fk_contract_document_superseded_by_document_id` FOREIGN KEY (`superseded_by_document_id`) REFERENCES `waste_management_ecm`.`contract`.`document`(`document_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ADD CONSTRAINT `fk_contract_billing_term_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ADD CONSTRAINT `fk_contract_volume_commitment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ADD CONSTRAINT `fk_contract_compliance_obligation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_parent_party_id` FOREIGN KEY (`parent_party_id`) REFERENCES `waste_management_ecm`.`contract`.`party`(`party_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`service_area` ADD CONSTRAINT `fk_contract_service_area_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_requirement_compliance` ADD CONSTRAINT `fk_contract_franchise_requirement_compliance_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ADD CONSTRAINT `fk_contract_municipality_parent_municipality_id` FOREIGN KEY (`parent_municipality_id`) REFERENCES `waste_management_ecm`.`contract`.`municipality`(`municipality_id`);

-- ========= TAGS =========
ALTER SCHEMA `waste_management_ecm`.`contract` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `waste_management_ecm`.`contract` SET TAGS ('dbx_domain' = 'contract');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `carbon_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Initiative Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `parent_agreement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Agreement ID');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `annual_escalation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Annual Escalation Percentage');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `base_service_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Service Rate');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'Monthly|Quarterly|Annual|Per Service');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'Draft|Pending|Active|Suspended|Amended|Terminated');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `early_termination_penalty` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Penalty');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `environmental_compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Requirement');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `force_majeure_clause` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Clause');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `governing_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Jurisdiction');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `indemnification_clause` SET TAGS ('dbx_business_glossary_term' = 'Indemnification Clause');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `insurance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirement');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `late_payment_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Penalty Rate');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `maximum_tonnage_limit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Tonnage Limit');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `minimum_tonnage_commitment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Tonnage Commitment');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Name');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `performance_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `performance_bond_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Required Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `rate_escalation_clause` SET TAGS ('dbx_business_glossary_term' = 'Rate Escalation Clause');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `salesforce_opportunity_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Opportunity ID');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `salesforce_opportunity_code` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9]{15,18}$');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `sap_contract_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Contract Number');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `sap_contract_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Salesforce|SAP|AMCS|Manual');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term Months');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `value_total` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Total');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `allows_early_termination` SET TAGS ('dbx_business_glossary_term' = 'Allows Early Termination Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `amendment_approval_level` SET TAGS ('dbx_business_glossary_term' = 'Amendment Approval Level');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `amendment_approval_level` SET TAGS ('dbx_value_regex' = 'operations_manager|regional_director|vp_commercial|legal_counsel|board_approval');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `auto_renewal_eligible` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Eligible Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `contract_duration_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Duration Type');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `contract_duration_type` SET TAGS ('dbx_value_regex' = 'short_term|long_term|evergreen|project_based|indefinite');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'municipal|commercial|industrial|residential|institutional');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `default_billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Default Billing Frequency');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `default_billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|per_service|project_milestone');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `default_term_months` SET TAGS ('dbx_business_glossary_term' = 'Default Term Duration in Months');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `hazmat_classification_required` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Classification Required Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'flat_rate|per_ton|per_pickup|tiered|cost_plus|negotiated');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Frequency');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|as_required');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `requires_franchise_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Franchise Approval Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `requires_insurance_certificate` SET TAGS ('dbx_business_glossary_term' = 'Requires Insurance Certificate Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `requires_performance_bond` SET TAGS ('dbx_business_glossary_term' = 'Requires Performance Bond Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `requires_permit` SET TAGS ('dbx_business_glossary_term' = 'Requires Operating Permit Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `service_category` SET TAGS ('dbx_value_regex' = 'residential_collection|commercial_collection|roll_off_service|disposal_service|recycling_service|hazardous_waste_service');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `sla_template_required` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Template Required Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `supports_rate_escalation` SET TAGS ('dbx_business_glossary_term' = 'Supports Rate Escalation Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period in Days');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Code');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `type_description` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Description');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `type_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Name');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `waste_stream_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Type');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `contract_service_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Commitment Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `asset_container_id` SET TAGS ('dbx_business_glossary_term' = 'Container Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `circular_economy_program_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Economy Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `container_type_id` SET TAGS ('dbx_business_glossary_term' = 'Container Type Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `frequency_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Frequency Plan Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `jha_id` SET TAGS ('dbx_business_glossary_term' = 'Jha Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Activated Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `cancellation_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Notice Period in Days');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `commitment_number` SET TAGS ('dbx_business_glossary_term' = 'Service Commitment Number');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_business_glossary_term' = 'Service Commitment Status');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired|pending_activation');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `monthly_service_charge` SET TAGS ('dbx_business_glossary_term' = 'Monthly Service Charge Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `monthly_service_charge` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `overage_charge_rate` SET TAGS ('dbx_business_glossary_term' = 'Overage Charge Rate');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `overage_charge_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `per_pickup_charge` SET TAGS ('dbx_business_glossary_term' = 'Per-Pickup Charge Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `per_pickup_charge` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Required Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period in Days');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 1');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 2');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `service_city` SET TAGS ('dbx_business_glossary_term' = 'Service City');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `service_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `service_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `service_country_code` SET TAGS ('dbx_business_glossary_term' = 'Service Country Code');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `service_country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `service_latitude` SET TAGS ('dbx_business_glossary_term' = 'Service Location Latitude');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `service_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `service_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `service_longitude` SET TAGS ('dbx_business_glossary_term' = 'Service Location Longitude');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `service_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `service_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Service Postal Code');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `service_start_time` SET TAGS ('dbx_business_glossary_term' = 'Service Start Time Window');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `service_state_province` SET TAGS ('dbx_business_glossary_term' = 'Service State or Province');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `service_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `service_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `sla_resolution_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Resolution Time in Hours');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time in Hours');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Service Instructions');
ALTER TABLE `waste_management_ecm`.`contract`.`contract_service_commitment` ALTER COLUMN `terminated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Terminated Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` SET TAGS ('dbx_subdomain' = 'financial_terms');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Pricing ID');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Rate');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|per_service|on_demand');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `environmental_fee_applicable` SET TAGS ('dbx_business_glossary_term' = 'Environmental Fee Applicable');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `escalation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Escalation Frequency');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `escalation_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|none');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `escalation_rate` SET TAGS ('dbx_business_glossary_term' = 'Escalation Rate');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `escalation_type` SET TAGS ('dbx_business_glossary_term' = 'Escalation Type');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `escalation_type` SET TAGS ('dbx_value_regex' = 'fixed_percentage|cpi_indexed|fuel_index|custom_formula|none');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `fuel_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Applicable');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `maximum_charge` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `next_escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Next Escalation Date');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Pricing Notes');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `pricing_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Code');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `pricing_status` SET TAGS ('dbx_business_glossary_term' = 'Pricing Status');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `pricing_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|suspended|superseded');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `pricing_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Type');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `proration_allowed` SET TAGS ('dbx_business_glossary_term' = 'Proration Allowed');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `regulatory_fee_applicable` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Fee Applicable');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `tier_level` SET TAGS ('dbx_business_glossary_term' = 'Tier Level');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `tier_maximum_quantity` SET TAGS ('dbx_business_glossary_term' = 'Tier Maximum Quantity');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `tier_minimum_quantity` SET TAGS ('dbx_business_glossary_term' = 'Tier Minimum Quantity');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` SET TAGS ('dbx_subdomain' = 'financial_terms');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `rate_line_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Line Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `arrears_advance_indicator` SET TAGS ('dbx_business_glossary_term' = 'Arrears or Advance Indicator');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `arrears_advance_indicator` SET TAGS ('dbx_value_regex' = 'arrears|advance');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|per_service|on_demand');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `charge_description` SET TAGS ('dbx_business_glossary_term' = 'Charge Description');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Charge Type');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `charge_type` SET TAGS ('dbx_value_regex' = 'base_collection|tipping_fee|fuel_surcharge|environmental_fee|container_rental|overage_charge');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `escalation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Escalation Frequency');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `escalation_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `escalation_method` SET TAGS ('dbx_business_glossary_term' = 'Escalation Method');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `escalation_method` SET TAGS ('dbx_value_regex' = 'none|fixed_percentage|cpi|fuel_index|custom');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `escalation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Escalation Percentage');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Charge Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring Charge Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Is Taxable Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `line_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `maximum_charge` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Line Notes');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `proration_rule` SET TAGS ('dbx_business_glossary_term' = 'Proration Rule');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `proration_rule` SET TAGS ('dbx_value_regex' = 'daily|monthly|none|custom');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `rate_basis` SET TAGS ('dbx_value_regex' = 'flat|tiered|volume|weight|frequency');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `rate_line_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Line Status');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `rate_line_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `revenue_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Category');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `revenue_category` SET TAGS ('dbx_value_regex' = 'collection|disposal|recycling|rental|surcharge|fee');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'residential_collection|commercial_collection|roll_off|recycling|hazardous_waste|special_waste');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `tier_threshold_lower` SET TAGS ('dbx_business_glossary_term' = 'Tier Threshold Lower Bound');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `tier_threshold_upper` SET TAGS ('dbx_business_glossary_term' = 'Tier Threshold Upper Bound');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` SET TAGS ('dbx_subdomain' = 'financial_terms');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `escalation_clause_id` SET TAGS ('dbx_business_glossary_term' = 'Escalation Clause ID');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `amendment_reference` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reference');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `applies_to_service_types` SET TAGS ('dbx_business_glossary_term' = 'Applies to Service Types');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `base_index_date` SET TAGS ('dbx_business_glossary_term' = 'Base Index Date');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `base_index_value` SET TAGS ('dbx_business_glossary_term' = 'Base Index Value');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `clause_number` SET TAGS ('dbx_business_glossary_term' = 'Clause Number');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `compounding_method` SET TAGS ('dbx_business_glossary_term' = 'Compounding Method');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `compounding_method` SET TAGS ('dbx_value_regex' = 'simple|compound|reset_to_base');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `customer_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Required');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `dispute_period_days` SET TAGS ('dbx_business_glossary_term' = 'Dispute Period Days');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `escalation_cap_percentage` SET TAGS ('dbx_business_glossary_term' = 'Escalation Cap Percentage');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `escalation_clause_status` SET TAGS ('dbx_business_glossary_term' = 'Escalation Clause Status');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `escalation_clause_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|superseded|pending_approval');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `escalation_floor_percentage` SET TAGS ('dbx_business_glossary_term' = 'Escalation Floor Percentage');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `escalation_type` SET TAGS ('dbx_business_glossary_term' = 'Escalation Type');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'Exclusions');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `fixed_escalation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fixed Escalation Percentage');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `index_reference` SET TAGS ('dbx_business_glossary_term' = 'Index Reference');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `last_escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Escalation Date');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `last_escalation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Last Escalation Percentage');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Escalation Clause Notes');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `notification_days_advance` SET TAGS ('dbx_business_glossary_term' = 'Notification Days Advance');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|biennial|monthly');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `supporting_documentation_required` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Required');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` SET TAGS ('dbx_subdomain' = 'performance_obligations');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `sla_term_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Term Identifier');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `reduction_target_id` SET TAGS ('dbx_business_glossary_term' = 'Reduction Target Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Definition Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `baseline_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Period End Date');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `baseline_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Period Start Date');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `escalation_procedure` SET TAGS ('dbx_business_glossary_term' = 'Escalation Procedure');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `escalation_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold Value');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `exclusion_conditions` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Conditions');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `measurement_period_days` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period in Days');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `penalty_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Penalty Calculation Method');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `penalty_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Provision Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `penalty_type` SET TAGS ('dbx_business_glossary_term' = 'Penalty Type');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `penalty_type` SET TAGS ('dbx_value_regex' = 'service_credit|financial_penalty|rate_reduction|contract_termination_right|none');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `reporting_format` SET TAGS ('dbx_business_glossary_term' = 'Reporting Format');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `reporting_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Reporting Requirement Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `responsible_party` SET TAGS ('dbx_value_regex' = 'waste_management|customer|third_party|shared');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `sla_category` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Category');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `sla_category` SET TAGS ('dbx_value_regex' = 'collection_performance|response_time|service_quality|safety_compliance|environmental_compliance|customer_satisfaction');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `sla_metric_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Metric Code');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `sla_metric_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Metric Name');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `sla_term_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Term Status');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `sla_term_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|superseded|draft|cancelled');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `target_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Target Threshold Value');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `threshold_operator` SET TAGS ('dbx_business_glossary_term' = 'Threshold Operator');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `threshold_operator` SET TAGS ('dbx_value_regex' = 'greater_than_or_equal|less_than_or_equal|equal|greater_than|less_than');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `threshold_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit of Measure');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `superseded_by_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Amendment Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Description');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Amendment Approved By');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Approval Date');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `customer_signature_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Signature Required Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `customer_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Signed Date');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `executed_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Execution Date');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Expiration Date');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `legal_review_required` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `legal_reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewed By');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `legal_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Date');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Amendment Notes');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `rate_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Change Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `rate_change_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rate Change Percentage');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason Code');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `requested_by` SET TAGS ('dbx_business_glossary_term' = 'Amendment Requested By');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Request Date');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `scope_change_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Change Description');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `service_level_change_description` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Change Description');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|sap_sd|manual_entry|data_migration|other');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `term_extension_months` SET TAGS ('dbx_business_glossary_term' = 'Term Extension Months');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Version Number');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal Owner Employee Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `amendment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Amendment Required Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `auto_renewal_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Eligible Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `churn_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Churn Risk Score');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `competitor_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor Name');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `competitor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `competitor_threat_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitor Threat Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `customer_response_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Date');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Effective Date');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `escalation_basis` SET TAGS ('dbx_business_glossary_term' = 'Escalation Basis');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `escalation_basis` SET TAGS ('dbx_value_regex' = 'cpi|fixed_percentage|market_rate|negotiated|none');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Expiration Date');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notes');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `notice_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Date');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `offer_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Offer Date');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `opt_out_date` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Date');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `opt_out_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Received Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Renewal Outcome');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'retained|lost|expanded|downsized');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `previous_annual_value` SET TAGS ('dbx_business_glossary_term' = 'Previous Annual Contract Value');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `previous_annual_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `previous_term_end_date` SET TAGS ('dbx_business_glossary_term' = 'Previous Term End Date');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `previous_term_start_date` SET TAGS ('dbx_business_glossary_term' = 'Previous Term Start Date');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `rate_change_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rate Change Percentage');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `rate_escalation_clause_applied` SET TAGS ('dbx_business_glossary_term' = 'Rate Escalation Clause Applied Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_number` SET TAGS ('dbx_business_glossary_term' = 'Renewal Number');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_number` SET TAGS ('dbx_value_regex' = '^RNW-[0-9]{8}$');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_type` SET TAGS ('dbx_business_glossary_term' = 'Renewal Type');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_type` SET TAGS ('dbx_value_regex' = 'auto_renewal|negotiated_renewal|evergreen|manual_renewal');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `renewed_annual_value` SET TAGS ('dbx_business_glossary_term' = 'Renewed Annual Contract Value');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `renewed_annual_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `retention_strategy` SET TAGS ('dbx_business_glossary_term' = 'Retention Strategy');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `retention_strategy` SET TAGS ('dbx_value_regex' = 'standard|discount_offered|service_upgrade|executive_engagement|none');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `service_change_description` SET TAGS ('dbx_business_glossary_term' = 'Service Change Description');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `service_level_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Change Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|sap_sd|manual_entry');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `term_length_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Length in Months');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `termination_id` SET TAGS ('dbx_business_glossary_term' = 'Termination ID');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `asset_container_id` SET TAGS ('dbx_business_glossary_term' = 'Container Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `churn_classification` SET TAGS ('dbx_business_glossary_term' = 'Churn Classification');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `churn_classification` SET TAGS ('dbx_value_regex' = 'voluntary_churn|involuntary_churn|natural_expiration|regulatory_churn');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `competitor_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor Name');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `competitor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `contract_value_lost` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Lost');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `early_termination_flag` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `early_termination_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Penalty Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `effective_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Termination Date');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `equipment_retrieval_date` SET TAGS ('dbx_business_glossary_term' = 'Equipment Retrieval Date');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `equipment_retrieval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Retrieval Required Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `equipment_retrieval_status` SET TAGS ('dbx_business_glossary_term' = 'Equipment Retrieval Status');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `equipment_retrieval_status` SET TAGS ('dbx_value_regex' = 'not_required|scheduled|in_progress|completed|customer_retained|lost');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `exit_feedback_summary` SET TAGS ('dbx_business_glossary_term' = 'Exit Feedback Summary');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `exit_interview_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Exit Interview Completed Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `exit_interview_date` SET TAGS ('dbx_business_glossary_term' = 'Exit Interview Date');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `final_billing_date` SET TAGS ('dbx_business_glossary_term' = 'Final Billing Date');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `final_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Final Invoice Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `final_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Final Payment Date');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `final_payment_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Final Payment Received Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `final_service_date` SET TAGS ('dbx_business_glossary_term' = 'Final Service Date');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Initiated By');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `initiated_by` SET TAGS ('dbx_value_regex' = 'customer|waste_management|mutual|regulatory_authority');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Termination Notes');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `notice_date` SET TAGS ('dbx_business_glossary_term' = 'Notice Date');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `outstanding_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `penalty_waived_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Waived Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `penalty_waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Penalty Waiver Reason');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `requested_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Termination Date');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|sap_sd|waste_logics|manual_entry');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `termination_number` SET TAGS ('dbx_business_glossary_term' = 'Termination Number');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `termination_number` SET TAGS ('dbx_value_regex' = '^TRM-[0-9]{8}$');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `termination_status` SET TAGS ('dbx_business_glossary_term' = 'Termination Status');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `termination_type` SET TAGS ('dbx_business_glossary_term' = 'Termination Type');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `termination_type` SET TAGS ('dbx_value_regex' = 'voluntary_cancellation|non_renewal_expiration|breach_termination|regulatory_termination|mutual_agreement|convenience_termination');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `win_back_campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Win-Back Campaign ID');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `win_back_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Win-Back Eligible Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `franchise_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement ID');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `esg_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Disclosure Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `municipality_id` SET TAGS ('dbx_business_glossary_term' = 'Municipality ID');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Required Safety Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `scheduled_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Obligation Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Name');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Number');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^FA-[A-Z]{2,3}-[0-9]{6,8}$');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Status');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|terminated|expired');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `annual_rate_escalation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Annual Rate Escalation Percentage');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `cpi_index_reference` SET TAGS ('dbx_business_glossary_term' = 'Consumer Price Index (CPI) Index Reference');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'litigation|arbitration|mediation|negotiation');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `diversion_rate_requirement` SET TAGS ('dbx_business_glossary_term' = 'Diversion Rate Requirement');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `environmental_compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Requirements');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `exclusivity_type` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Type');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `exclusivity_type` SET TAGS ('dbx_value_regex' = 'exclusive|non_exclusive|semi_exclusive');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `fleet_composition_requirements` SET TAGS ('dbx_business_glossary_term' = 'Fleet Composition Requirements');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `franchise_fee_fixed_amount` SET TAGS ('dbx_business_glossary_term' = 'Franchise Fee Fixed Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `franchise_fee_per_ton_rate` SET TAGS ('dbx_business_glossary_term' = 'Franchise Fee Per Ton Rate');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `franchise_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Franchise Fee Percentage');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `franchise_fee_type` SET TAGS ('dbx_business_glossary_term' = 'Franchise Fee Type');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `franchise_fee_type` SET TAGS ('dbx_value_regex' = 'percentage_of_revenue|fixed_annual|per_ton|hybrid');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `ghg_reduction_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Reduction Target Percentage');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `initial_term_years` SET TAGS ('dbx_business_glossary_term' = 'Initial Term Years');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `insurance_requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirement Description');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `lea_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Local Enforcement Agency (LEA) Reference Number');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `performance_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `performance_bond_required` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Required');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `rate_adjustment_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Rate Adjustment Mechanism');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `renewal_option_years` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Years');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `service_scope` SET TAGS ('dbx_business_glossary_term' = 'Service Scope');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `sla_missed_pickup_resolution_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Missed Pickup Resolution Hours');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time Hours');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `swis_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Solid Waste Information System (SWIS) Reporting Required');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `termination_for_cause_allowed` SET TAGS ('dbx_business_glossary_term' = 'Termination For Cause Allowed');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `territory_geojson` SET TAGS ('dbx_business_glossary_term' = 'Franchise Territory GeoJSON');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `disposal_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Agreement ID');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `cell_id` SET TAGS ('dbx_business_glossary_term' = 'Designated Cell Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Facility ID');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Safety Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `ghg_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Inventory Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `scheduled_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Obligation Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Disposal Agreement Name');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Disposal Agreement Number');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^DA-[0-9]{8}$');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Disposal Agreement Status');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired|pending_renewal');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `base_tipping_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Tipping Fee Rate');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `base_tipping_fee_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|per_load');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `contracted_annual_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Contracted Annual Tonnage');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `escalation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Escalation Percentage');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `facility_operator` SET TAGS ('dbx_business_glossary_term' = 'Facility Operator Name');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `insurance_required` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `manifest_required` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Manifest Required');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `maximum_tonnage_limit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Tonnage Limit');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `minimum_tonnage_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Minimum Tonnage Guarantee');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_15|net_30|net_45|net_60|due_on_receipt');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `performance_penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Performance Penalty Clause');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Number');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `rate_escalation_clause` SET TAGS ('dbx_business_glossary_term' = 'Rate Escalation Clause');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `rcra_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Resource Conservation and Recovery Act (RCRA) Compliance Required');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `sla_turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Turnaround Time Hours');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `tipping_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Currency Code');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `tipping_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `tpd_capacity` SET TAGS ('dbx_business_glossary_term' = 'Tons Per Day (TPD) Capacity');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Email Address');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Name');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Phone Number');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `hauling_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Hauling Agreement ID');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee ID');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility ID');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `hauler_account_id` SET TAGS ('dbx_business_glossary_term' = 'Hauler ID');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Hauler Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `origin_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility ID');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Required Safety Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Hauling Agreement Number');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^HA-[0-9]{6,10}$');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Hauling Agreement Status');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|terminated|expired');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `bol_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Requirement Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_business_glossary_term' = 'Contracted Rate');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `dot_compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Compliance Requirements');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `environmental_compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Certifications');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `fuel_surcharge_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Applicable Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `fuel_surcharge_formula` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Formula');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `insurance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Number');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiration Date');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `manifest_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Manifest Requirement Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `maximum_volume_capacity_tons` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume Capacity (Tons)');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `minimum_volume_commitment_tons` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume Commitment (Tons)');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_15|net_30|net_45|net_60|due_on_receipt|prepaid');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `performance_penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Performance Penalty Clause');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `performance_sla_on_time_pct` SET TAGS ('dbx_business_glossary_term' = 'Performance Service Level Agreement (SLA) On-Time Percentage');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `rate_escalation_clause` SET TAGS ('dbx_business_glossary_term' = 'Rate Escalation Clause');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `rate_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Structure Type');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `rate_structure_type` SET TAGS ('dbx_value_regex' = 'per_ton|per_ton_mile|per_load|per_trip|hourly|monthly_fixed');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `route_lane_description` SET TAGS ('dbx_business_glossary_term' = 'Route Lane Description');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Safety Rating');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `safety_rating` SET TAGS ('dbx_value_regex' = 'satisfactory|conditional|unsatisfactory|not_rated');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `termination_for_cause_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination for Cause Clause');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` SET TAGS ('dbx_subdomain' = 'performance_obligations');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `diversion_record_id` SET TAGS ('dbx_business_glossary_term' = 'Diversion Record Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `service_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Enrollment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `allocated_transaction_price` SET TAGS ('dbx_business_glossary_term' = 'Allocated Transaction Price');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `amendment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Amendment Indicator');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `billing_schedule` SET TAGS ('dbx_business_glossary_term' = 'Billing Schedule');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `billing_schedule` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|per_service|milestone|upfront');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `constraint_applied` SET TAGS ('dbx_business_glossary_term' = 'Constraint Applied to Variable Consideration');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `contract_asset_liability_indicator` SET TAGS ('dbx_business_glossary_term' = 'Contract Asset or Liability Indicator');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `contract_asset_liability_indicator` SET TAGS ('dbx_value_regex' = 'contract_asset|contract_liability|neither');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `cost_of_service` SET TAGS ('dbx_business_glossary_term' = 'Cost of Service (COS)');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `gl_revenue_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Revenue Account');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `gl_revenue_account` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `is_distinct` SET TAGS ('dbx_business_glossary_term' = 'Is Distinct Performance Obligation');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `is_variable_consideration` SET TAGS ('dbx_business_glossary_term' = 'Is Variable Consideration');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Notes');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Description');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `obligation_number` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Number');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `obligation_number` SET TAGS ('dbx_value_regex' = '^PO-[0-9]{6,10}$');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Status');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_value_regex' = 'draft|active|satisfied|partially_satisfied|terminated|cancelled');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `percentage_complete` SET TAGS ('dbx_business_glossary_term' = 'Percentage Complete');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `performance_milestone` SET TAGS ('dbx_business_glossary_term' = 'Performance Milestone');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `remaining_revenue` SET TAGS ('dbx_business_glossary_term' = 'Remaining Revenue');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `revenue_recognition_pattern` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Pattern');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `revenue_recognition_pattern` SET TAGS ('dbx_value_regex' = 'straight_line|usage_based|milestone_based|output_method|input_method');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `revenue_recognized_to_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognized to Date');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `satisfaction_date` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction Date');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `satisfaction_method` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction Method');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `satisfaction_method` SET TAGS ('dbx_value_regex' = 'over_time|point_in_time');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `service_frequency` SET TAGS ('dbx_business_glossary_term' = 'Service Frequency');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `service_quantity` SET TAGS ('dbx_business_glossary_term' = 'Service Quantity');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `service_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Service Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `sla_target` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `standalone_selling_price` SET TAGS ('dbx_business_glossary_term' = 'Standalone Selling Price (SSP)');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `variable_consideration_estimate` SET TAGS ('dbx_business_glossary_term' = 'Variable Consideration Estimate');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Event Identifier');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User ID');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `primary_lifecycle_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering User ID');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `primary_lifecycle_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `primary_lifecycle_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `amendment_detail` SET TAGS ('dbx_business_glossary_term' = 'Amendment Detail');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `amendment_type_code` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type Code');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `approval_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Reference Number');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `compliance_review_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Completed Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `compliance_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Required Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `customer_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `customer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `event_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Event Sequence Number');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `event_type_code` SET TAGS ('dbx_business_glossary_term' = 'Event Type Code');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `new_contract_status` SET TAGS ('dbx_business_glossary_term' = 'New Contract Status');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `new_monthly_value` SET TAGS ('dbx_business_glossary_term' = 'New Monthly Value');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `new_term_end_date` SET TAGS ('dbx_business_glossary_term' = 'New Term End Date');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `prior_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Contract Status');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `prior_monthly_value` SET TAGS ('dbx_business_glossary_term' = 'Prior Monthly Value');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `prior_term_end_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Term End Date');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `rate_escalation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rate Escalation Percentage');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `renewal_outcome_code` SET TAGS ('dbx_business_glossary_term' = 'Renewal Outcome Code');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `renewal_outcome_code` SET TAGS ('dbx_value_regex' = 'AUTO_RENEWED|NEGOTIATED_RENEWED|EVERGREEN_CONTINUED|NOT_RENEWED');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `service_level_agreement_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Change Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `termination_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Termination Penalty Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_value_regex' = 'VOLUNTARY_CANCELLATION|NON_RENEWAL|BREACH|REGULATORY|CUSTOMER_RELOCATION|SERVICE_UNAVAILABLE');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `triggering_system_code` SET TAGS ('dbx_business_glossary_term' = 'Triggering System Code');
ALTER TABLE `waste_management_ecm`.`contract`.`lifecycle_event` ALTER COLUMN `triggering_system_code` SET TAGS ('dbx_value_regex' = 'SALESFORCE_CRM|SAP_SD|WASTE_LOGICS|MANUAL_ENTRY|AUTOMATED_WORKFLOW');
ALTER TABLE `waste_management_ecm`.`contract`.`document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`contract`.`document` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Identifier');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `superseded_by_document_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Document Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `access_restriction_notes` SET TAGS ('dbx_business_glossary_term' = 'Access Restriction Notes');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `checksum_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Checksum Verified Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'PUBLIC|INTERNAL|CONFIDENTIAL|RESTRICTED');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `eligible_for_destruction_date` SET TAGS ('dbx_business_glossary_term' = 'Eligible for Destruction Date');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `extracted_text_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Extracted Text Available Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Document Format');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `hash` SET TAGS ('dbx_business_glossary_term' = 'Document Hash');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `indexed_for_search_flag` SET TAGS ('dbx_business_glossary_term' = 'Indexed for Search Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `legal_hold_case_number` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Case Number');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `ocr_processed_flag` SET TAGS ('dbx_business_glossary_term' = 'Optical Character Recognition (OCR) Processed Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `regulatory_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `related_document_ids` SET TAGS ('dbx_business_glossary_term' = 'Related Document Identifiers (IDs)');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `requires_regulatory_filing` SET TAGS ('dbx_business_glossary_term' = 'Requires Regulatory Filing Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period in Years');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `retention_trigger_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Trigger Date');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `signatory_party_names` SET TAGS ('dbx_business_glossary_term' = 'Signatory Party Names');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `source_system_document_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Document Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `storage_path` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Path');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Document Type Code');
ALTER TABLE `waste_management_ecm`.`contract`.`document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` SET TAGS ('dbx_subdomain' = 'financial_terms');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_term_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Term Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `accepted_payment_methods` SET TAGS ('dbx_business_glossary_term' = 'Accepted Payment Methods');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `auto_pay_enabled` SET TAGS ('dbx_business_glossary_term' = 'Automatic Payment (Auto-Pay) Enabled Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Email Address');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Phone Number');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_cycle_day` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Day of Month');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province Code');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_term_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Term Status');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `billing_term_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|expired|terminated');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `discount_terms` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Terms');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `dunning_procedure` SET TAGS ('dbx_business_glossary_term' = 'Dunning Procedure');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `dunning_procedure` SET TAGS ('dbx_value_regex' = 'standard|aggressive|lenient|custom|none');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `electronic_invoice_format` SET TAGS ('dbx_business_glossary_term' = 'Electronic Invoice Format');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `electronic_invoice_format` SET TAGS ('dbx_value_regex' = 'pdf|xml|edi_810|csv|json');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `invoice_consolidation` SET TAGS ('dbx_business_glossary_term' = 'Invoice Consolidation Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Invoice Delivery Method');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_value_regex' = 'paper|email|edi|portal|fax|combined');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `late_payment_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Penalty Rate');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `minimum_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Invoice Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Billing Term Notes');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `payment_due_day` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Day of Month');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `proration_allowed` SET TAGS ('dbx_business_glossary_term' = 'Proration Allowed Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `security_deposit_required` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Required Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `statement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Account Statement Frequency');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `statement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|none|on_demand');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `tax_exemption_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Certificate Number');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `tax_exemption_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Term Code');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `term_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ALTER COLUMN `term_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Term Name');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` SET TAGS ('dbx_subdomain' = 'financial_terms');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `volume_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Identifier');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `service_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Enrollment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `actual_volume_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume To Date');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `amendment_reference` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reference');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `commitment_direction` SET TAGS ('dbx_business_glossary_term' = 'Commitment Direction');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `commitment_direction` SET TAGS ('dbx_value_regex' = 'customer_to_wm|wm_to_customer|wm_to_third_party|third_party_to_wm');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `commitment_number` SET TAGS ('dbx_business_glossary_term' = 'Commitment Number');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_business_glossary_term' = 'Commitment Status');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|terminated|pending_activation|under_review');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `commitment_type` SET TAGS ('dbx_business_glossary_term' = 'Commitment Type');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `commitment_type` SET TAGS ('dbx_value_regex' = 'minimum_volume|tonnage_guarantee|take_or_pay|capacity_reservation|throughput_commitment|load_guarantee');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `committed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Committed Quantity');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `customer_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Required Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `dispute_period_days` SET TAGS ('dbx_business_glossary_term' = 'Dispute Period Days');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `excess_tonnage_rate` SET TAGS ('dbx_business_glossary_term' = 'Excess Tonnage Rate');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `excess_tonnage_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `force_majeure_applicable` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Applicable Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `last_true_up_amount` SET TAGS ('dbx_business_glossary_term' = 'Last True-Up Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `last_true_up_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `last_true_up_date` SET TAGS ('dbx_business_glossary_term' = 'Last True-Up Date');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `last_true_up_variance` SET TAGS ('dbx_business_glossary_term' = 'Last True-Up Variance');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `measurement_period` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `measurement_period` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|contract_term');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `next_true_up_date` SET TAGS ('dbx_business_glossary_term' = 'Next True-Up Date');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `notification_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Notification Threshold Percentage');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `proration_allowed` SET TAGS ('dbx_business_glossary_term' = 'Proration Allowed Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `shortfall_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Shortfall Penalty Rate');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `shortfall_penalty_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Identifier');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `supporting_documentation_required` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Required Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `true_up_frequency` SET TAGS ('dbx_business_glossary_term' = 'True-Up Frequency');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `true_up_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|contract_end');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `waste_management_ecm`.`contract`.`volume_commitment` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` SET TAGS ('dbx_subdomain' = 'performance_obligations');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Identifier');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `ghg_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Emission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `waste_generator_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Generator Profile Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|biennial|ad_hoc|none');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|in_progress|waived|not_applicable');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `contract_clause_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Clause Reference');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `documentation_required` SET TAGS ('dbx_business_glossary_term' = 'Documentation Required');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `escalation_procedure` SET TAGS ('dbx_business_glossary_term' = 'Escalation Procedure');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `governing_regulation` SET TAGS ('dbx_business_glossary_term' = 'Governing Regulation');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `last_audit_result` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Result');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `last_audit_result` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional|not_audited');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `last_compliance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Date');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `obligation_category` SET TAGS ('dbx_business_glossary_term' = 'Obligation Category');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `obligation_number` SET TAGS ('dbx_business_glossary_term' = 'Obligation Number');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `obligation_number` SET TAGS ('dbx_value_regex' = '^OBL-[0-9]{8}$');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `obligation_title` SET TAGS ('dbx_business_glossary_term' = 'Obligation Title');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'regulatory|contractual|statutory|voluntary|franchise|permit');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `penalty_for_non_compliance` SET TAGS ('dbx_business_glossary_term' = 'Penalty for Non-Compliance');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `responsible_party` SET TAGS ('dbx_value_regex' = 'waste_management|customer|third_party|joint|regulatory_agency');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|portal|email|api|in_person');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `submission_recipient` SET TAGS ('dbx_business_glossary_term' = 'Submission Recipient');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `target_metric` SET TAGS ('dbx_business_glossary_term' = 'Target Metric');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `target_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Target Unit of Measure');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `waiver_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Expiration Date');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `waiver_granted` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted');
ALTER TABLE `waste_management_ecm`.`contract`.`compliance_obligation` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `waste_management_ecm`.`contract`.`party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`contract`.`party` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Party Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `parent_party_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `amendment_reference` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reference');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `authority_level` SET TAGS ('dbx_business_glossary_term' = 'Authority Level');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `authority_level` SET TAGS ('dbx_value_regex' = 'signatory|approver|administrator|observer|beneficiary');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Party Doing Business As (DBA) Name');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `guarantee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Currency Code');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `guarantee_currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `guarantor_flag` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `insurance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Number');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiration Date');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Party Legal Name');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `legal_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `party_status` SET TAGS ('dbx_business_glossary_term' = 'Party Status');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `party_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|terminated');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `party_type` SET TAGS ('dbx_business_glossary_term' = 'Party Type');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `reference_code` SET TAGS ('dbx_business_glossary_term' = 'Party Reference Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `reference_type` SET TAGS ('dbx_business_glossary_term' = 'Party Reference Type');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `reference_type` SET TAGS ('dbx_value_regex' = 'customer|vendor|employee|municipality|regulatory_agency|internal_entity');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `role_code` SET TAGS ('dbx_business_glossary_term' = 'Party Role Code');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `secondary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Secondary Contact Email Address');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `secondary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `secondary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `secondary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `secondary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Secondary Contact Name');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `secondary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `secondary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Secondary Contact Phone Number');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `secondary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `secondary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Party Sequence Number');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Signatory Name');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Signatory Title');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `signature_date` SET TAGS ('dbx_business_glossary_term' = 'Signature Date');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `signature_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Required Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `waste_management_ecm`.`contract`.`service_area` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`contract`.`service_area` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `waste_management_ecm`.`contract`.`service_area` SET TAGS ('dbx_association_edges' = 'contract.contract,service.service_area');
ALTER TABLE `waste_management_ecm`.`contract`.`service_area` ALTER COLUMN `service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Service Area Coverage Identifier');
ALTER TABLE `waste_management_ecm`.`contract`.`service_area` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Service Area - Service Area Id');
ALTER TABLE `waste_management_ecm`.`contract`.`service_area` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Service Area - Agreement Id');
ALTER TABLE `waste_management_ecm`.`contract`.`service_area` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective End Date');
ALTER TABLE `waste_management_ecm`.`contract`.`service_area` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Start Date');
ALTER TABLE `waste_management_ecm`.`contract`.`service_area` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Service Rights Indicator');
ALTER TABLE `waste_management_ecm`.`contract`.`service_area` ALTER COLUMN `franchise_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Franchise Fee Percentage Rate');
ALTER TABLE `waste_management_ecm`.`contract`.`service_area` ALTER COLUMN `service_level_commitment` SET TAGS ('dbx_business_glossary_term' = 'Area-Specific Service Level Commitment');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_requirement_compliance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_requirement_compliance` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_requirement_compliance` SET TAGS ('dbx_association_edges' = 'contract.franchise_agreement,compliance.regulatory_requirement');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_requirement_compliance` ALTER COLUMN `franchise_requirement_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Requirement Compliance ID');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_requirement_compliance` ALTER COLUMN `franchise_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Requirement Compliance - Franchise Agreement Id');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_requirement_compliance` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Requirement Compliance - Regulatory Requirement Id');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_requirement_compliance` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_requirement_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_requirement_compliance` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_requirement_compliance` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_requirement_compliance` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_requirement_compliance` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_requirement_compliance` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Date');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_requirement_compliance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_requirement_compliance` ALTER COLUMN `penalty_provision` SET TAGS ('dbx_business_glossary_term' = 'Penalty Provision');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_requirement_compliance` ALTER COLUMN `performance_target` SET TAGS ('dbx_business_glossary_term' = 'Performance Target');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_requirement_compliance` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_requirement_compliance` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_requirement_compliance` ALTER COLUMN `waiver_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Expiration Date');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_requirement_compliance` ALTER COLUMN `waiver_granted` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `municipality_id` SET TAGS ('dbx_business_glossary_term' = 'Municipality Identifier');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `parent_municipality_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `secondary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `secondary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `secondary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `secondary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `secondary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `secondary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_financial' = 'true');
