-- Schema for Domain: contract | Business: Waste Management | Version: v1_mvm
-- Generated on: 2026-05-07 22:44:06

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `waste_management_ecm`.`contract` COMMENT 'Service agreements and contracts with customers including municipal solid waste contracts, commercial service agreements, hauling contracts, disposal agreements, and franchise agreements. Manages contract terms, service levels (SLA), pricing structures, rate escalation clauses, renewal dates, performance obligations, contract amendments, and lifecycle events (origination, renewal, amendment, termination). Links customers to service commitments and billing terms. Integrates with Salesforce CRM and SAP SD.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`contract` (
    `contract_id` BIGINT COMMENT 'Primary key for contract',
    `agreement_type_id` BIGINT COMMENT 'Foreign key linking to contract.agreement_type. Business justification: contract has contract_type (STRING) attribute which is semantically equivalent to agreement_type in this domain context. The agreement_type reference table provides classification for all contract and',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to service.bundle. Business justification: Contracts are sold against service bundles (e.g., combined MSW+recycling+organics package). Linking contract to bundle enables bundle-level revenue reporting, renewal analytics, and sales performance ',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer party to this contract. Links to the customer master record.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Contracts specify service delivery at facilities (landfills, MRFs, transfer stations). Required for facility capacity planning, contract performance tracking, regulatory compliance reporting, and reve',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Master contracts specify primary service offering being sold (residential collection, commercial recycling, hazmat). Needed for contract template selection, pricing validation, service eligibility che',
    `parent_agreement_contract_id` BIGINT COMMENT 'Identifier of the master or umbrella agreement under which this contract is subordinated. Used for multi-site or multi-service contract hierarchies. Nullable for standalone contracts.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Waste collection/disposal contracts must reference operating permits authorizing contracted services. Contract execution requires permit verification; service scope cannot exceed permitted capacity. E',
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
    `line_id` BIGINT COMMENT 'Foreign key linking to service.line. Business justification: Agreement types map to service lines (residential collection agreement type → residential service line; hazardous waste agreement type → hazardous service line). The service_category plain text column',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Agreement types are configured per customer segment (residential, commercial, hazmat, municipal). Contract setup and eligibility validation require resolving the segment governing an agreement type. a',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Agreement types in waste management are categorized by waste stream (MSW collection agreement, recycling processing agreement, hazardous waste agreement). The waste_stream_type plain text column is a ',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this agreement type is currently active and available for new contract creation. Inactive types are retained for historical reference but not used for new agreements.',
    `allows_early_termination` BOOLEAN COMMENT 'Indicates whether agreements of this type permit early termination by either party, typically subject to notice periods and potential penalties.',
    `amendment_approval_level` STRING COMMENT 'Organizational approval authority level required to amend or modify agreements of this type. Drives contract workflow routing in Salesforce CRM.. Valid values are `operations_manager|regional_director|vp_commercial|legal_counsel|board_approval`',
    `auto_renewal_eligible` BOOLEAN COMMENT 'Indicates whether agreements of this type are eligible for automatic renewal upon expiration, subject to notice periods and customer consent.',
    `compliance_framework` STRING COMMENT 'Primary regulatory compliance framework governing agreements of this type (e.g., RCRA for hazardous waste, local franchise ordinances for MSW, CERCLA for remediation contracts).',
    `contract_duration_type` STRING COMMENT 'Typical duration classification for agreements of this type. Short-term (under 1 year), long-term (multi-year), evergreen (auto-renewing), project-based (tied to specific project completion), or indefinite (no fixed end date).. Valid values are `short_term|long_term|evergreen|project_based|indefinite`',
    `created_by_user` STRING COMMENT 'User identifier or system account that created this agreement type reference record. Supports audit and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this agreement type reference record was first created in the system. Audit trail field.',
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
    `sla_template_required` BOOLEAN COMMENT 'Indicates whether agreements of this type must include a formal Service Level Agreement (SLA) defining performance obligations, response times, and service quality metrics.',
    `supports_rate_escalation` BOOLEAN COMMENT 'Indicates whether agreements of this type typically include automatic rate escalation clauses tied to Consumer Price Index (CPI), fuel surcharges, or other economic indices.',
    `termination_notice_days` STRING COMMENT 'Standard advance notice period in days required for either party to terminate agreements of this type without cause. Null if termination is not permitted or requires cause.',
    `type_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the agreement type (e.g., MSW_FRAN, COMM_HAUL, ROLLOFF, HAZ_DISP). Used as business key in operational systems and contract workflows.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `type_description` STRING COMMENT 'Detailed business description of the agreement type, including scope of services, typical customer segments, and operational characteristics.',
    `type_name` STRING COMMENT 'Full descriptive name of the agreement type (e.g., Municipal Solid Waste Franchise Agreement, Commercial Hauling Contract, Roll-Off Disposal Agreement, Hazardous Waste Treatment Storage and Disposal Facility Agreement).',
    CONSTRAINT pk_agreement_type PRIMARY KEY(`agreement_type_id`)
) COMMENT 'Reference classification of contract and agreement types used across Waste Managements commercial and municipal operations. Includes types such as MSW Municipal Franchise, Commercial Hauling, Roll-Off Disposal, Residential Service, Hazardous Waste Disposal, and Intermodal Transfer. Drives contract workflow routing, SLA assignment, and billing rule selection.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`service_commitment` (
    `service_commitment_id` BIGINT COMMENT 'Unique identifier for the service commitment record. Primary key.',
    `area_id` BIGINT COMMENT 'Foreign key linking to service.service_area. Business justification: Service commitments must validate against franchise boundaries, permit coverage, and operational service areas. Critical for route planning, regulatory compliance, service feasibility validation, and ',
    `asset_container_id` BIGINT COMMENT 'Foreign key linking to asset.container. Business justification: Service commitments drive container deployment to customer sites. Essential for asset deployment tracking, service fulfillment verification, billing reconciliation, and container lifecycle management.',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to service.bundle. Business justification: Service commitments are created from bundle definitions (e.g., a residential bundle commitment). Linking commitment to bundle supports bundle-level service fulfillment tracking, pricing validation, an',
    `container_type_id` BIGINT COMMENT 'Foreign key linking to service.container_type. Business justification: Service commitments specify exact container equipment for delivery and billing. Direct link needed for asset allocation, delivery scheduling, capacity validation, rental billing, and maintenance track',
    `contract_id` BIGINT COMMENT 'Reference to the parent contract or service agreement under which this service commitment is defined.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer receiving the committed service.',
    `frequency_plan_id` BIGINT COMMENT 'Foreign key linking to service.frequency_plan. Business justification: Service commitments define pickup schedules (weekly, bi-weekly, on-demand). Direct link required for route optimization, driver scheduling, SLA compliance tracking, and billing verification. Removes d',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: Service commitments for disposal services specify destination landfill site for capacity reservation and routing. Required for site capacity planning, contract fulfillment tracking, and customer servi',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Service commitments in contracts should reference the service catalog offering to ensure contractual terms align with defined service offerings. This enables validation that contracted services match ',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Service commitments for hazmat/special waste must align with facility permits authorizing specific waste streams at service locations. Operations teams verify permit coverage before activating service',
    `pricing_id` BIGINT COMMENT 'Foreign key linking to contract.pricing. Business justification: contract_service_commitment defines specific service obligations with associated charges (monthly_service_charge, per_pickup_charge, overage_charge_rate). These charges are governed by a pricing recor',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Service commitments for hazardous, medical, or special waste streams must reference the regulatory requirement governing the service. This supports compliance verification during service delivery, reg',
    `route_id` BIGINT COMMENT 'Reference to the collection route assigned to fulfill this service commitment.',
    `service_rate_schedule_id` BIGINT COMMENT 'Foreign key linking to service.service_rate_schedule. Business justification: Service commitments are priced against a service rate schedule (defining base rates, fuel surcharges, environmental fees by area/container/frequency). This link enables rate schedule auditing, pricing',
    `sla_term_id` BIGINT COMMENT 'Foreign key linking to contract.sla_term. Business justification: contract_service_commitment carries sla_resolution_time_hours and sla_response_time_hours as denormalized SLA values. sla_term is the authoritative SLA record containing target thresholds, measurement',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Every service commitment is for a specific waste stream (MSW, recycling, organics, hazardous). This is a fundamental operational attribute — waste stream determines handling requirements, regulatory c',
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
    `special_instructions` STRING COMMENT 'Free-text field capturing special handling instructions, access codes, gate information, or other operational notes for service delivery.',
    `terminated_timestamp` TIMESTAMP COMMENT 'Timestamp when the service commitment was terminated or cancelled.',
    CONSTRAINT pk_service_commitment PRIMARY KEY(`service_commitment_id`)
) COMMENT 'Defines specific service obligations committed under a contract, representing distinct service lines a customer is entitled to receive. Captures service type (residential curbside, commercial FEL/ASL/REL, roll-off temporary/permanent, recycling, organics, hazmat), service frequency (1x/week, 2x/week, on-call), container specification (size, type, count), collection schedule pattern, and geographic service zone or route assignment. Each agreement may have multiple service commitments. Links customers to contracted service entitlements and drives operational scheduling in AMCS route planning. References the applicable rate schedule for billing calculation.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`pricing` (
    `pricing_id` BIGINT COMMENT 'Unique identifier for the contract pricing record. Primary key for this entity.',
    `contract_id` BIGINT COMMENT 'Reference to the parent service contract or agreement to which this pricing structure applies.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Disposal and processing pricing varies by facility (tipping fees, processing rates). Required for facility-specific rate management, revenue allocation, and cost-plus pricing models at different facil',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Regulatory fees in waste management pricing (state environmental fees, EPA fees, landfill surcharges) are mandated by specific regulatory requirements. The existing regulatory_fee_applicable flag is a',
    `service_rate_schedule_id` BIGINT COMMENT 'Foreign key linking to service.service_rate_schedule. Business justification: Contract pricing is derived from a catalog service rate schedule. This lineage link supports rate deviation analysis (contract rate vs. catalog rate), pricing approval workflows, and audit trails — a ',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Contract pricing in waste management is waste-stream-specific — tipping fees, recycling processing fees, and hazardous waste rates differ fundamentally by waste stream. Linking pricing to waste_stream',
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
    `escalation_clause_id` BIGINT COMMENT 'Foreign key linking to contract.escalation_clause. Business justification: rate_line carries escalation_frequency, escalation_method, and escalation_percentage as denormalized escalation fields on individual pricing line items. escalation_clause is the authoritative record f',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Rate lines are tied to specific service offerings (e.g., fuel surcharge line for hazardous waste collection offering). Linking rate_line to offering enables offering-level revenue analysis, billing va',
    `pricing_id` BIGINT COMMENT 'Foreign key linking to contract.pricing. Business justification: rate_line represents individual line-item pricing components within a rate schedule. pricing is the parent rate structure record for a contract. A pricing record (1) contains many rate lines (N). Addi',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Rate lines (tipping fees, processing fees, surcharges) are waste-stream-specific in waste management. The existing service_type plain text column is a denormalization of waste_stream. Normalizing via ',
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
    `pricing_id` BIGINT COMMENT 'Foreign key linking to contract.pricing. Business justification: An escalation clause governs rate increases on a specific pricing structure. While escalation_clause already references contract, linking it directly to pricing (which also references contract) allows',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Escalation clauses in waste management contracts are sometimes tied to regulatory fee schedule changes (e.g., state environmental fee escalations mandated by regulation). The existing index_reference ',
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
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: SLA metrics in waste management contracts are frequently derived directly from permit conditions (e.g., a landfill permit condition mandating 95% diversion becomes a contractual SLA). Linking enables ',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: SLA terms (response times for hazmat incidents, missed pickup resolution) are often mandated by regulatory requirements (RCRA, state codes). Links contractual service levels to regulatory drivers, ess',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.customer_segment. Business justification: SLA terms vary by customer segment (residential 48hr vs commercial 24hr vs municipal 4hr response). Segment linkage enables segment-specific SLA template application, performance benchmarking, and aut',
    `sla_definition_id` BIGINT COMMENT 'Foreign key linking to service.sla_definition. Business justification: Contract SLA terms should reference standard service-level definitions for consistency and template application. Needed for SLA performance measurement standardization, penalty calculation automation,',
    `amendment_date` DATE COMMENT 'The date when the most recent amendment to this SLA term was executed. Null if never amended.',
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
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Amendments require a designated customer contact for signature and approval. Waste management contract amendment workflows route documents to the specific authorized contact. amendment tracks customer',
    `contract_id` BIGINT COMMENT 'Reference to the parent contract being amended. Links to the original service agreement or contract.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Amendments modify contract terms for specific service offerings (e.g., adding recycling service, changing collection frequency). Linking amendment to offering enables offering-level amendment tracking',
    `pricing_id` BIGINT COMMENT 'Foreign key linking to contract.pricing. Business justification: Amendments frequently modify pricing structures (rate_change_amount, rate_change_percentage are on amendment). Adding pricing_id links the amendment to the specific pricing record it modifies, enablin',
    `superseded_by_amendment_id` BIGINT COMMENT 'Reference to a subsequent amendment that supersedes or replaces this amendment. Null if this is the current active amendment.',
    `violation_notice_id` BIGINT COMMENT 'Foreign key linking to compliance.violation_notice. Business justification: Violation notices frequently trigger contract amendments in waste management (e.g., adding remediation obligations or adjusting service scope to cure a compliance deficiency). Operators must document ',
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
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Renewal negotiations are conducted with a specific customer contact (facility manager, procurement officer). Renewal outcome tracking and retention strategy execution require knowing which contact res',
    `contract_id` BIGINT COMMENT 'Reference to the parent contract being renewed. Links to the contract master record in Salesforce CRM.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer associated with this renewal. Links to customer master data in Salesforce CRM.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Renewals are tracked per service offering to support offering-level retention analytics and churn reporting. The service_change_description plain text field denormalizes offering information. Linking ',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Contract renewals in waste management require verification that the underlying operating permits remain valid through the renewal term. Linking renewal to permit enables automated permit-validity chec',
    `pricing_id` BIGINT COMMENT 'Foreign key linking to contract.pricing. Business justification: Renewals involve rate negotiations and pricing updates. renewal carries rate_change_percentage and escalation_basis fields indicating pricing is central to the renewal process. Adding pricing_id links',
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
    `service_level_change_flag` BOOLEAN COMMENT 'Indicates whether Service Level Agreement (SLA) terms or service scope changed at renewal. True if service frequency, container count, or performance commitments were modified; False if service levels remained unchanged.',
    `source_system` STRING COMMENT 'Identifies the operational system where this renewal record originated. Salesforce CRM: renewal opportunity pipeline. SAP SD: sales and distribution module. Manual Entry: direct data entry by user.. Valid values are `salesforce_crm|sap_sd|manual_entry`',
    `term_length_months` STRING COMMENT 'Duration of the renewed contract term expressed in months. Common values: 12, 24, 36, 60 months.',
    CONSTRAINT pk_renewal PRIMARY KEY(`renewal_id`)
) COMMENT 'Tracks contract renewal events and renewal pipeline management. Captures renewal type (auto-renewal, negotiated renewal, evergreen), renewal notice date, renewal offer date, customer response date, new term start/end dates, rate changes applied at renewal, and renewal outcome (accepted, declined, renegotiated, lapsed). Supports proactive renewal management workflows and revenue retention tracking. Integrates with Salesforce CRM opportunity pipeline.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`termination` (
    `termination_id` BIGINT COMMENT 'Unique identifier for the contract termination event. Primary key.',
    `asset_container_id` BIGINT COMMENT 'Foreign key linking to asset.container. Business justification: Contract termination triggers container retrieval from customer sites. Required for asset recovery logistics, final billing reconciliation, container redeployment planning, and tracking equipment_retr',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Termination notices are issued to and acknowledged by a specific customer contact. Exit interview and win-back campaign processes require the contact who initiated or acknowledged termination. termina',
    `contract_id` BIGINT COMMENT 'Reference to the service contract being terminated. Links to the parent contract record in Salesforce CRM or SAP SD.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer whose contract is being terminated. Used for churn analysis and win-back program targeting.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Termination churn analysis by service offering is a standard business report in waste management — identifying which services have highest cancellation rates drives retention strategy. Linking termina',
    `violation_notice_id` BIGINT COMMENT 'Foreign key linking to compliance.violation_notice. Business justification: Contract terminations for cause in waste management are frequently triggered by regulatory violations (e.g., a hauler losing its permit due to an NOV). Linking termination to violation_notice document',
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
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: franchise_agreement is a specialized master record for municipal franchise agreements, which are a subtype of the general contract entity. Linking franchise_agreement to contract establishes the speci',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Franchise agreements govern municipal waste operations at specific facilities. Required for franchise fee calculation, performance bond tracking, diversion rate compliance, and regulatory reporting to',
    `municipality_id` BIGINT COMMENT 'Reference to the municipal government entity that granted this franchise agreement.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Municipal franchise agreements require underlying operating permits for the franchised territory. Franchise execution is contingent on permit issuance; franchise terms (capacity, waste streams) must a',
    `regulated_facility_id` BIGINT COMMENT 'Foreign key linking to compliance.regulated_facility. Business justification: Franchise agreements are granted for operations at or involving specific regulated facilities. The compliance-domain regulated_facility record (with EPA ID, RCRA status, regulatory programs) is distin',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Franchise agreements are governed by specific state/local solid waste regulatory requirements (e.g., CalRecycle diversion mandates). The existing environmental_compliance_requirements is denormalized ',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Franchise agreements in waste management are scoped to specific waste streams (MSW, recycling, organics). The service_scope plain text field denormalizes waste stream information. Linking franchise_ag',
    `agreement_name` STRING COMMENT 'Descriptive name of the franchise agreement, typically including municipality name and service type.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the franchise agreement, typically formatted as FA-[STATE]-[NUMBER].. Valid values are `^FA-[A-Z]{2,3}-[0-9]{6,8}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the franchise agreement.. Valid values are `draft|pending_approval|active|suspended|terminated|expired`',
    `amendment_count` STRING COMMENT 'Total number of amendments executed to date that modify the original franchise agreement terms.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the franchise agreement record was first created in the system.',
    `dispute_resolution_method` STRING COMMENT 'Primary method for resolving disputes between Waste Management and the municipality under the franchise agreement.. Valid values are `litigation|arbitration|mediation|negotiation`',
    `diversion_rate_requirement` DECIMAL(18,2) COMMENT 'Minimum percentage of waste that must be diverted from landfill through recycling, composting, or waste-to-energy programs as mandated by the municipality.',
    `effective_end_date` DATE COMMENT 'Date on which the franchise agreement expires or terminates, unless renewed or extended.',
    `effective_start_date` DATE COMMENT 'Date on which the franchise agreement becomes legally binding and service obligations commence.',
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
    `cell_id` BIGINT COMMENT 'Foreign key linking to landfill.cell. Business justification: Some disposal agreements specify designated cells for particular waste streams (e.g., industrial waste, C&D). Supports cell-specific capacity allocation, waste stream segregation requirements, and per',
    `disposal_permit_id` BIGINT COMMENT 'Foreign key linking to landfill.disposal_permit. Business justification: A disposal agreement is legally constrained by the landfills disposal permit — permitted waste types, tonnage limits, and expiration dates govern agreement terms. Permit renewal and compliance report',
    `escalation_clause_id` BIGINT COMMENT 'Foreign key linking to contract.escalation_clause. Business justification: disposal_agreement carries escalation_percentage (DECIMAL) and rate_escalation_clause (STRING) as denormalized escalation fields. escalation_clause is the authoritative record for rate escalation prov',
    `facility_id` BIGINT COMMENT 'Reference to the disposal facility (landfill, transfer station, MRF, WTE, TSDF) where waste is delivered under this agreement.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Disposal agreements with landfills/transfer stations must reference facility operating permits to verify accepted waste streams, capacity limits, and regulatory authorization. Procurement teams valida',
    `monitoring_program_id` BIGINT COMMENT 'Foreign key linking to compliance.monitoring_program. Business justification: Disposal agreements at landfills or treatment facilities are subject to specific monitoring programs (groundwater, leachate, air emissions) required by the disposal permit. Linking disposal_agreement ',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Disposal agreements for hazardous/special waste must reference the specific RCRA or state solid waste regulatory requirement governing the disposal activity. The existing rcra_compliance_required flag',
    `service_rate_schedule_id` BIGINT COMMENT 'Foreign key linking to service.service_rate_schedule. Business justification: Disposal agreements reference tipping fee rate schedules for billing and cost tracking. The service_rate_schedule contains disposal_site_id and tipping fee structures. Linking disposal_agreement to se',
    `sla_term_id` BIGINT COMMENT 'Foreign key linking to contract.sla_term. Business justification: disposal_agreement carries sla_turnaround_time_hours as a denormalized SLA value for disposal/tipping operations. sla_term is the authoritative SLA record with full governance attributes including pen',
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
    `rcra_compliance_required` BOOLEAN COMMENT 'Indicates whether this disposal agreement requires compliance with RCRA regulations for hazardous waste handling and disposal.',
    `renewal_notice_days` STRING COMMENT 'Number of days advance notice required to terminate or renegotiate the agreement before automatic renewal.',
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
    `customer_account_id` BIGINT COMMENT 'Identifier for the customer or contracting party for whom hauling services are provided. May be Waste Management internal division or external client.',
    `facility_id` BIGINT COMMENT 'Identifier for the facility where waste is delivered. May be landfill, MRF, WTE facility, or TSDF.',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: Hauling agreements designating landfill sites as destinations require direct linkage to landfill.site for permit compliance verification, daily tonnage cap enforcement, and waste stream eligibility ch',
    `escalation_clause_id` BIGINT COMMENT 'Foreign key linking to contract.escalation_clause. Business justification: hauling_agreement carries rate_escalation_clause (STRING) as a denormalized escalation description. escalation_clause is the authoritative structured record for rate escalation provisions. Adding esca',
    `origin_facility_id` BIGINT COMMENT 'Identifier for the facility or location where waste is collected or loaded for transport. May be collection point, transfer station, or customer site.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Hazardous waste hauling agreements must comply with specific DOT/EPA regulatory requirements. The existing dot_compliance_requirements is a denormalized text field; a proper FK to regulatory_requireme',
    `service_rate_schedule_id` BIGINT COMMENT 'Foreign key linking to service.service_rate_schedule. Business justification: Hauling agreements are priced against service rate schedules that define hauling rates by area, container type, and frequency. Linking hauling_agreement to service_rate_schedule normalizes the rate re',
    `sla_term_id` BIGINT COMMENT 'Foreign key linking to contract.sla_term. Business justification: hauling_agreement carries performance_sla_on_time_pct as a denormalized SLA metric for hauling/transport operations. sla_term is the authoritative SLA record. Adding sla_term_id normalizes this relati',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Hauling agreements for hazardous waste transport require DOT/EPA permits. Contract terms (waste types, routes, volumes) must align with permit conditions. Essential for third-party hauler qualificatio',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: Hauling agreements specify waste stream types being transported with DOT hazmat class and handling requirements. Essential for DOT compliance, driver CDL/endorsement validation, manifest requirements,',
    `agreement_number` STRING COMMENT 'Externally-known business identifier for the hauling agreement. Used in contracts, BOL references, and vendor communications.. Valid values are `^HA-[0-9]{6,10}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the hauling agreement indicating operational validity and contract state.. Valid values are `draft|pending_approval|active|suspended|terminated|expired`',
    `approval_date` DATE COMMENT 'Date when the hauling agreement was formally approved by authorized signatories and became legally binding.',
    `bol_requirement_flag` BOOLEAN COMMENT 'Indicates whether a BOL document is required for each haul under this agreement. True if BOL is mandatory.',
    `contracted_rate` DECIMAL(18,2) COMMENT 'Base rate amount per unit as defined by rate structure type. Expressed in USD unless otherwise specified in currency code.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hauling agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for contracted rate and financial terms.. Valid values are `^[A-Z]{3}$`',
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
    `amendment_id` BIGINT COMMENT 'Foreign key linking to contract.amendment. Business justification: performance_obligation carries amendment_date and amendment_indicator (BOOLEAN) as denormalized amendment reference fields. Under ASC 606, contract modifications (amendments) can create new performanc',
    `billing_term_id` BIGINT COMMENT 'Foreign key linking to contract.billing_term. Business justification: performance_obligation carries a billing_schedule (STRING) field that is a denormalized reference to billing terms. Under ASC 606 revenue recognition, each performance obligation has specific billing ',
    `contract_id` BIGINT COMMENT 'Reference to the parent contract that contains this performance obligation.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Performance obligations for disposal/processing services are facility-specific. Required for ASC 606 revenue recognition by facility, standalone selling price allocation, and facility-level revenue tr',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: Performance obligations for landfill disposal contracts are fulfilled at specific landfill sites. ASC 606 revenue recognition reporting and site-level performance tracking require direct linkage from ',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: ASC 606 performance obligations decompose contract deliverables into distinct service offerings for revenue recognition. Required for revenue accounting, standalone selling price allocation, contract ',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Under ASC 606, performance obligations in waste management are often defined by regulatory requirements (e.g., RCRA-mandated hazardous waste disposal). Linking supports revenue recognition documentati',
    `service_enrollment_id` BIGINT COMMENT 'Foreign key linking to customer.service_enrollment. Business justification: ASC 606 revenue recognition requires performance obligations mapped to specific service enrollments. Linking enables accurate revenue allocation, satisfaction tracking, and contract asset/liability ca',
    `sla_term_id` BIGINT COMMENT 'Foreign key linking to contract.sla_term. Business justification: performance_obligation carries sla_target (STRING) as a denormalized SLA reference. Under ASC 606, performance obligations often have associated service level commitments that determine when revenue c',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Under ASC 606 revenue recognition, performance obligations are identified per distinct service, which in waste management is waste-stream-specific (MSW collection obligation vs. recycling processing o',
    `allocated_transaction_price` DECIMAL(18,2) COMMENT 'Portion of the total contract transaction price allocated to this specific performance obligation based on relative standalone selling prices.',
    `amendment_date` DATE COMMENT 'Date when this performance obligation was amended or modified. Null if never amended.',
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
    `standalone_selling_price` DECIMAL(18,2) COMMENT 'The price at which the entity would sell the promised good or service separately to a customer, used for transaction price allocation under ASC 606.',
    `termination_reason` STRING COMMENT 'Reason for termination or cancellation of this performance obligation if applicable (e.g., customer request, contract breach, service discontinuation).',
    `variable_consideration_estimate` DECIMAL(18,2) COMMENT 'Estimated amount of variable consideration expected to be received for this obligation, subject to constraint requirements.',
    CONSTRAINT pk_performance_obligation PRIMARY KEY(`performance_obligation_id`)
) COMMENT 'Defines discrete performance obligations within a contract as required under ASC 606 revenue recognition standards. Each obligation represents a distinct service promise (e.g., weekly residential collection, monthly roll-off swap, annual container maintenance) with its standalone selling price, satisfaction method (over time vs. point in time), and revenue recognition pattern. Supports GAAP/IFRS-compliant revenue recognition and SOX financial reporting. Sourced from SAP SD revenue recognition module.';

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

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`party` (
    `party_id` BIGINT COMMENT 'Unique identifier for the contract party record. Primary key.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Contract parties are customer contacts acting as legal representatives or signatories. Linking party to the CRM contact record enables contract execution workflows, e-signature routing, and contact hi',
    `contract_id` BIGINT COMMENT 'Reference to the parent contract to which this party is associated.',
    `municipality_id` BIGINT COMMENT 'Foreign key linking to contract.municipality. Business justification: party identifies all parties to a contract including municipal entities. When a party is a municipality (party_type = MUNICIPALITY), it should reference the authoritative municipality master record.',
    `parent_party_id` BIGINT COMMENT 'Self-referencing FK on party (parent_party_id)',
    `regulated_facility_id` BIGINT COMMENT 'Foreign key linking to compliance.regulated_facility. Business justification: Contract parties (vendors, subcontractors, disposal operators) in waste management are often themselves regulated facilities under RCRA or state programs. Linking party to regulated_facility enables c',
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
    `reference_code` BIGINT COMMENT 'Foreign key reference to the master data record for this party. The target table is determined by party_reference_type (e.g., customer_id, vendor_id, municipality_id).',
    `reference_type` STRING COMMENT 'Indicates which master data domain this party references. Determines whether the party_reference_id points to customer master, vendor master, employee master, municipality registry, regulatory agency registry, or internal WM entity.. Valid values are `customer|vendor|employee|municipality|regulatory_agency|internal_entity`',
    `role_code` STRING COMMENT 'The role this party plays in the contract relationship. Common roles include customer (service recipient), provider (WM contracting entity), guarantor (financial guarantor), regulator (municipal or environmental authority), subcontractor (third-party hauler or processor), insurer (insurance provider), municipal_authority (local government entity), franchise_authority (franchising body), hauler (transportation provider), disposal_facility (landfill or processing facility operator), broker (intermediary), consultant (advisory party). [ENUM-REF-CANDIDATE: customer|provider|guarantor|regulator|subcontractor|insurer|municipal_authority|franchise_authority|hauler|disposal_facility|broker|consultant — 12 candidates stripped; promote to reference product]',
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

CREATE OR REPLACE TABLE `waste_management_ecm`.`contract`.`municipality` (
    `municipality_id` BIGINT COMMENT 'Primary key for municipality',
    `parent_municipality_id` BIGINT COMMENT 'Self-referencing FK on municipality (parent_municipality_id)',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Municipalities are the source of local solid waste regulatory requirements (franchise law, diversion mandates, recycling ordinances). Linking municipality to regulatory_requirement enables tracking of',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Municipalities are served within defined service territories — this is fundamental to franchise agreement management and service planning in waste management. Linking municipality to territory enables',
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
    `municipality_status` STRING COMMENT 'Current operational status of the municipality in the contract management system.',
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
    `service_area_description` STRING COMMENT 'Textual description of the geographic service area boundaries and coverage zones within the municipality.',
    `state_code` STRING COMMENT 'Two-letter US state abbreviation where the municipality is located.',
    `tax_identifier` STRING COMMENT 'Federal Employer Identification Number (EIN) or Tax ID for the municipality used in billing and tax reporting.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the municipality location, used for scheduling and service coordination.',
    `waste_generation_rate_tons_per_year` DECIMAL(18,2) COMMENT 'Estimated annual waste generation volume in tons for the municipality, used for capacity planning and pricing.',
    `website_url` STRING COMMENT 'Official website URL of the municipality for public information and reference.',
    CONSTRAINT pk_municipality PRIMARY KEY(`municipality_id`)
) COMMENT 'Master reference table for municipality. Referenced by municipality_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ADD CONSTRAINT `fk_contract_contract_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `waste_management_ecm`.`contract`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ADD CONSTRAINT `fk_contract_contract_parent_agreement_contract_id` FOREIGN KEY (`parent_agreement_contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ADD CONSTRAINT `fk_contract_service_commitment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ADD CONSTRAINT `fk_contract_service_commitment_pricing_id` FOREIGN KEY (`pricing_id`) REFERENCES `waste_management_ecm`.`contract`.`pricing`(`pricing_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ADD CONSTRAINT `fk_contract_service_commitment_sla_term_id` FOREIGN KEY (`sla_term_id`) REFERENCES `waste_management_ecm`.`contract`.`sla_term`(`sla_term_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ADD CONSTRAINT `fk_contract_pricing_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ADD CONSTRAINT `fk_contract_rate_line_escalation_clause_id` FOREIGN KEY (`escalation_clause_id`) REFERENCES `waste_management_ecm`.`contract`.`escalation_clause`(`escalation_clause_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ADD CONSTRAINT `fk_contract_rate_line_pricing_id` FOREIGN KEY (`pricing_id`) REFERENCES `waste_management_ecm`.`contract`.`pricing`(`pricing_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ADD CONSTRAINT `fk_contract_escalation_clause_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ADD CONSTRAINT `fk_contract_escalation_clause_pricing_id` FOREIGN KEY (`pricing_id`) REFERENCES `waste_management_ecm`.`contract`.`pricing`(`pricing_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ADD CONSTRAINT `fk_contract_sla_term_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_pricing_id` FOREIGN KEY (`pricing_id`) REFERENCES `waste_management_ecm`.`contract`.`pricing`(`pricing_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_superseded_by_amendment_id` FOREIGN KEY (`superseded_by_amendment_id`) REFERENCES `waste_management_ecm`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `waste_management_ecm`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_pricing_id` FOREIGN KEY (`pricing_id`) REFERENCES `waste_management_ecm`.`contract`.`pricing`(`pricing_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ADD CONSTRAINT `fk_contract_franchise_agreement_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `waste_management_ecm`.`contract`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ADD CONSTRAINT `fk_contract_franchise_agreement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ADD CONSTRAINT `fk_contract_franchise_agreement_municipality_id` FOREIGN KEY (`municipality_id`) REFERENCES `waste_management_ecm`.`contract`.`municipality`(`municipality_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ADD CONSTRAINT `fk_contract_disposal_agreement_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `waste_management_ecm`.`contract`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ADD CONSTRAINT `fk_contract_disposal_agreement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ADD CONSTRAINT `fk_contract_disposal_agreement_escalation_clause_id` FOREIGN KEY (`escalation_clause_id`) REFERENCES `waste_management_ecm`.`contract`.`escalation_clause`(`escalation_clause_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ADD CONSTRAINT `fk_contract_disposal_agreement_sla_term_id` FOREIGN KEY (`sla_term_id`) REFERENCES `waste_management_ecm`.`contract`.`sla_term`(`sla_term_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ADD CONSTRAINT `fk_contract_hauling_agreement_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `waste_management_ecm`.`contract`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ADD CONSTRAINT `fk_contract_hauling_agreement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ADD CONSTRAINT `fk_contract_hauling_agreement_escalation_clause_id` FOREIGN KEY (`escalation_clause_id`) REFERENCES `waste_management_ecm`.`contract`.`escalation_clause`(`escalation_clause_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ADD CONSTRAINT `fk_contract_hauling_agreement_sla_term_id` FOREIGN KEY (`sla_term_id`) REFERENCES `waste_management_ecm`.`contract`.`sla_term`(`sla_term_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ADD CONSTRAINT `fk_contract_performance_obligation_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `waste_management_ecm`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ADD CONSTRAINT `fk_contract_performance_obligation_billing_term_id` FOREIGN KEY (`billing_term_id`) REFERENCES `waste_management_ecm`.`contract`.`billing_term`(`billing_term_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ADD CONSTRAINT `fk_contract_performance_obligation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ADD CONSTRAINT `fk_contract_performance_obligation_sla_term_id` FOREIGN KEY (`sla_term_id`) REFERENCES `waste_management_ecm`.`contract`.`sla_term`(`sla_term_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` ADD CONSTRAINT `fk_contract_billing_term_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_municipality_id` FOREIGN KEY (`municipality_id`) REFERENCES `waste_management_ecm`.`contract`.`municipality`(`municipality_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_parent_party_id` FOREIGN KEY (`parent_party_id`) REFERENCES `waste_management_ecm`.`contract`.`party`(`party_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ADD CONSTRAINT `fk_contract_municipality_parent_municipality_id` FOREIGN KEY (`parent_municipality_id`) REFERENCES `waste_management_ecm`.`contract`.`municipality`(`municipality_id`);

-- ========= TAGS =========
ALTER SCHEMA `waste_management_ecm`.`contract` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `waste_management_ecm`.`contract` SET TAGS ('dbx_domain' = 'contract');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `parent_agreement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Agreement ID');
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `sla_template_required` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Template Required Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `supports_rate_escalation` SET TAGS ('dbx_business_glossary_term' = 'Supports Rate Escalation Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period in Days');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Code');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `type_description` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Description');
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ALTER COLUMN `type_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Name');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` SET TAGS ('dbx_subdomain' = 'service_terms');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Commitment Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `asset_container_id` SET TAGS ('dbx_business_glossary_term' = 'Container Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `container_type_id` SET TAGS ('dbx_business_glossary_term' = 'Container Type Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `frequency_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Frequency Plan Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Service Rate Schedule Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `sla_term_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Term Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Activated Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `cancellation_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Notice Period in Days');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `commitment_number` SET TAGS ('dbx_business_glossary_term' = 'Service Commitment Number');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_business_glossary_term' = 'Service Commitment Status');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired|pending_activation');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `monthly_service_charge` SET TAGS ('dbx_business_glossary_term' = 'Monthly Service Charge Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `monthly_service_charge` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `overage_charge_rate` SET TAGS ('dbx_business_glossary_term' = 'Overage Charge Rate');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `overage_charge_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `per_pickup_charge` SET TAGS ('dbx_business_glossary_term' = 'Per-Pickup Charge Amount');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `per_pickup_charge` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Required Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period in Days');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 1');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 2');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_city` SET TAGS ('dbx_business_glossary_term' = 'Service City');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_country_code` SET TAGS ('dbx_business_glossary_term' = 'Service Country Code');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_latitude` SET TAGS ('dbx_business_glossary_term' = 'Service Location Latitude');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_longitude` SET TAGS ('dbx_business_glossary_term' = 'Service Location Longitude');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Service Postal Code');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_start_time` SET TAGS ('dbx_business_glossary_term' = 'Service Start Time Window');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_state_province` SET TAGS ('dbx_business_glossary_term' = 'Service State or Province');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `service_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Service Instructions');
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ALTER COLUMN `terminated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Terminated Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` SET TAGS ('dbx_subdomain' = 'rate_pricing');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Pricing ID');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `service_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Service Rate Schedule Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` SET TAGS ('dbx_subdomain' = 'rate_pricing');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `rate_line_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Line Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `escalation_clause_id` SET TAGS ('dbx_business_glossary_term' = 'Escalation Clause Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `tier_threshold_lower` SET TAGS ('dbx_business_glossary_term' = 'Tier Threshold Lower Bound');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `tier_threshold_upper` SET TAGS ('dbx_business_glossary_term' = 'Tier Threshold Upper Bound');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` SET TAGS ('dbx_subdomain' = 'rate_pricing');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `escalation_clause_id` SET TAGS ('dbx_business_glossary_term' = 'Escalation Clause ID');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` SET TAGS ('dbx_subdomain' = 'service_terms');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `sla_term_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Term Identifier');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Definition Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
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
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` SET TAGS ('dbx_subdomain' = 'contract_lifecycle');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `superseded_by_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Amendment Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ALTER COLUMN `violation_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Notice Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` SET TAGS ('dbx_subdomain' = 'contract_lifecycle');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `service_level_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Change Flag');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|sap_sd|manual_entry');
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ALTER COLUMN `term_length_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Length in Months');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` SET TAGS ('dbx_subdomain' = 'contract_lifecycle');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `termination_id` SET TAGS ('dbx_business_glossary_term' = 'Termination ID');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `asset_container_id` SET TAGS ('dbx_business_glossary_term' = 'Container Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ALTER COLUMN `violation_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Notice Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `municipality_id` SET TAGS ('dbx_business_glossary_term' = 'Municipality ID');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `regulated_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Regulated Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Name');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Number');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^FA-[A-Z]{2,3}-[0-9]{6,8}$');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Status');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|terminated|expired');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'litigation|arbitration|mediation|negotiation');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `diversion_rate_requirement` SET TAGS ('dbx_business_glossary_term' = 'Diversion Rate Requirement');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
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
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `swis_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Solid Waste Information System (SWIS) Reporting Required');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `termination_for_cause_allowed` SET TAGS ('dbx_business_glossary_term' = 'Termination For Cause Allowed');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ALTER COLUMN `territory_geojson` SET TAGS ('dbx_business_glossary_term' = 'Franchise Territory GeoJSON');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `disposal_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Agreement ID');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `cell_id` SET TAGS ('dbx_business_glossary_term' = 'Designated Cell Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `disposal_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `escalation_clause_id` SET TAGS ('dbx_business_glossary_term' = 'Escalation Clause Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Facility ID');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `monitoring_program_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `service_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Service Rate Schedule Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `sla_term_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Term Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `rcra_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Resource Conservation and Recovery Act (RCRA) Compliance Required');
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
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
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility ID');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Landfill Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `escalation_clause_id` SET TAGS ('dbx_business_glossary_term' = 'Escalation Clause Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `origin_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility ID');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `service_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Service Rate Schedule Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `sla_term_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Term Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `rate_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Structure Type');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `rate_structure_type` SET TAGS ('dbx_value_regex' = 'per_ton|per_ton_mile|per_load|per_trip|hourly|monthly_fixed');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `route_lane_description` SET TAGS ('dbx_business_glossary_term' = 'Route Lane Description');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Safety Rating');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `safety_rating` SET TAGS ('dbx_value_regex' = 'satisfactory|conditional|unsatisfactory|not_rated');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `termination_for_cause_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination for Cause Clause');
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` SET TAGS ('dbx_subdomain' = 'service_terms');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `billing_term_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Term Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `service_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Enrollment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `sla_term_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Term Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `allocated_transaction_price` SET TAGS ('dbx_business_glossary_term' = 'Allocated Transaction Price');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
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
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `standalone_selling_price` SET TAGS ('dbx_business_glossary_term' = 'Standalone Selling Price (SSP)');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ALTER COLUMN `variable_consideration_estimate` SET TAGS ('dbx_business_glossary_term' = 'Variable Consideration Estimate');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`contract`.`billing_term` SET TAGS ('dbx_subdomain' = 'service_terms');
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
ALTER TABLE `waste_management_ecm`.`contract`.`party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`contract`.`party` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Party Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `municipality_id` SET TAGS ('dbx_business_glossary_term' = 'Municipality Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `parent_party_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `regulated_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Regulated Facility Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `reference_code` SET TAGS ('dbx_business_glossary_term' = 'Party Reference Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `reference_type` SET TAGS ('dbx_business_glossary_term' = 'Party Reference Type');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `reference_type` SET TAGS ('dbx_value_regex' = 'customer|vendor|employee|municipality|regulatory_agency|internal_entity');
ALTER TABLE `waste_management_ecm`.`contract`.`party` ALTER COLUMN `role_code` SET TAGS ('dbx_business_glossary_term' = 'Party Role Code');
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
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `municipality_id` SET TAGS ('dbx_business_glossary_term' = 'Municipality Identifier');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `parent_municipality_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_financial' = 'true');
