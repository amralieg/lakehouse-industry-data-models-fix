-- Schema for Domain: service | Business: Water Utilities | Version: v1_mvm
-- Generated on: 2026-05-06 01:37:21

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `water_utilities_ecm`.`service` COMMENT 'Defines the catalog of water and wastewater services, rate structures, service tiers, contractual terms, service level agreements (SLAs), and service delivery configurations. Manages the relationship between service offerings and customer accounts, supporting rate case modeling and regulatory tariff compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `water_utilities_ecm`.`service`.`offering` (
    `offering_id` BIGINT COMMENT 'Unique identifier for the service offering. Primary key for the offering product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Service offerings (potable water, recycled water, wastewater) map to specific cost centers for revenue allocation and cost-of-service studies. Rate case cost allocation methodology requires each offer',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Each service offering generates revenue credited to a specific enterprise fund (water fund, wastewater fund, recycled water fund). This is standard utility fund accounting — revenue from each offering',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to service.tariff. Business justification: A service offering is governed by a regulatory tariff filing. In regulated water utilities, every service offering must be approved under a specific tariff. Adding tariff_id to offering establishes th',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Service offerings in regulated water utilities are scoped to specific franchise territories. An offering is authorized and available within a defined geographic territory. Adding territory_id to offer',
    `treatment_permit_id` BIGINT COMMENT 'Foreign key linking to treatment.treatment_permit. Business justification: Service offerings (potable, recycled water) are directly constrained by treatment permit conditions — permitted flow limits, water quality standards, and turbidity/CT requirements. Regulators and rate',
    `ami_enabled_flag` BOOLEAN COMMENT 'Indicates whether this offering requires or supports Advanced Metering Infrastructure (AMI) for automated meter reading and real-time consumption monitoring. True = AMI required or available; False = manual or Automatic Meter Reading (AMR) only.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the service contract automatically renews at the end of the contract term. True = auto-renews unless customer cancels; False = requires explicit renewal. Null if not applicable.',
    `backflow_prevention_required_flag` BOOLEAN COMMENT 'Indicates whether backflow prevention devices are required for this offering to protect the public water supply from contamination. True = backflow prevention required (common for commercial, industrial, and recycled water services); False = not required.',
    `base_rate_amount` DECIMAL(18,2) COMMENT 'Fixed monthly or periodic base charge for the service offering, independent of consumption. Covers fixed costs such as meter maintenance, billing, and infrastructure access. Expressed in local currency (USD for U.S. utilities).',
    `billing_cycle_code` STRING COMMENT 'Code identifying the billing cycle or schedule applicable to this offering. Examples: MNTH (monthly), QRTR (quarterly), BIMON (bi-monthly). Aligns with Oracle Utilities Customer Care and Billing (CC&B) billing cycle configuration.. Valid values are `^[A-Z0-9]{2,6}$`',
    `capacity_charge` DECIMAL(18,2) COMMENT 'Fee for reserving system capacity or infrastructure access, common in industrial and municipal bulk water agreements. May be based on meter size, peak demand, or contracted volume. Also known as a demand charge or readiness-to-serve charge.',
    `connection_fee` DECIMAL(18,2) COMMENT 'One-time fee charged to establish a new service connection, including meter installation, service line connection, and administrative setup. May vary by customer class and service type.',
    `conservation_program_eligible_flag` BOOLEAN COMMENT 'Indicates whether customers enrolled in this offering are eligible for water conservation programs, rebates, or incentives (e.g., low-flow fixture rebates, landscape conversion incentives). True = eligible; False = not eligible.',
    `contract_term_months` STRING COMMENT 'Standard contract duration in months for this offering. Common for commercial, industrial, and municipal agreements. Null for month-to-month residential service.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this offering record was first created in the system. Used for audit trail and data lineage tracking.',
    `customer_class` STRING COMMENT 'Customer segment or class to which this offering applies. Determines rate structure, service level expectations, and regulatory treatment. Residential = single-family and multi-family homes; Commercial = businesses and offices; Industrial = manufacturing and heavy water users; Municipal = government facilities; Agricultural = farms and irrigation; Institutional = schools, hospitals, non-profits.. Valid values are `residential|commercial|industrial|municipal|agricultural|institutional`',
    `delivery_mode` STRING COMMENT 'Method by which the service is delivered and billed. Metered = consumption-based billing via Advanced Metering Infrastructure (AMI) or Automatic Meter Reading (AMR); Unmetered = fixed-rate service without consumption measurement; Flat rate = fixed periodic charge regardless of usage; Seasonal = service active only during specific periods; Temporary = short-term service for construction or events; Emergency = contingency supply during outages or disasters.. Valid values are `metered|unmetered|flat_rate|seasonal|temporary|emergency`',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Standard security deposit amount required for new customers. May vary based on estimated usage, customer class, or credit assessment. Null if no deposit is required.',
    `deposit_required_flag` BOOLEAN COMMENT 'Indicates whether a security deposit is required for new customers enrolling in this offering. True = deposit required; False = no deposit. Deposit policies vary by customer class and credit history.',
    `effective_end_date` DATE COMMENT 'Date on which the offering is no longer available for new customer enrollment. Null for open-ended offerings. Existing customers may continue under grandfathered terms.',
    `effective_start_date` DATE COMMENT 'Date on which the offering becomes available for customer enrollment and billing. Aligns with regulatory approval and operational readiness.',
    `fire_protection_service_flag` BOOLEAN COMMENT 'Indicates whether this offering includes dedicated fire protection service (e.g., fire hydrant access, private fire line). True = fire protection included; False = potable water or wastewater service only.',
    `flow_capacity_gpm` DECIMAL(18,2) COMMENT 'Maximum sustained flow rate in Gallons per Minute (GPM) that the utility can deliver for this offering under normal conditions. Relevant for fire protection, industrial, and bulk water services. Null for standard residential metered service.',
    `late_payment_penalty_percent` DECIMAL(18,2) COMMENT 'Percentage penalty applied to overdue balances after the payment due date. Subject to Public Utilities Commission regulations. Null if no late fee applies.',
    `lifecycle_status` STRING COMMENT 'Current state of the offering in its lifecycle. Active = available for new customer enrollment; Inactive = temporarily unavailable; Pending approval = awaiting regulatory or internal approval; Suspended = on hold due to operational or regulatory issues; Retired = no longer offered to new customers; Grandfathered = legacy offering maintained only for existing customers under prior tariff terms.. Valid values are `active|inactive|pending_approval|suspended|retired|grandfathered`',
    `meter_size_required_inches` DECIMAL(18,2) COMMENT 'Standard meter size in inches required or recommended for this offering based on expected flow and customer class. Common sizes: 0.625 (5/8 inch), 0.75 (3/4 inch), 1.0, 1.5, 2.0, 3.0, 4.0, 6.0, 8.0 inches. Null for unmetered service.',
    `minimum_monthly_charge` DECIMAL(18,2) COMMENT 'Minimum amount a customer will be billed each billing period, regardless of consumption. Ensures cost recovery for fixed infrastructure and service availability. Null if no minimum applies.',
    `modified_by_user` STRING COMMENT 'User ID or system account that last modified this offering record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this offering record was last modified. Used for audit trail, change tracking, and data synchronization.',
    `offering_code` STRING COMMENT 'Externally-known unique code for the service offering used in billing systems, tariff schedules, and customer communications. Examples: WTR-RES-01, WWC-COM-02, RCW-IND-01.. Valid values are `^[A-Z0-9]{6,12}$`',
    `offering_description` STRING COMMENT 'Detailed description of the service offering including scope, delivery specifications, and any special conditions or limitations. Used in customer agreements and regulatory filings.',
    `offering_name` STRING COMMENT 'Human-readable name of the service offering as presented to customers and in regulatory tariff filings. Examples: Residential Potable Water Service, Commercial Wastewater Collection, Industrial Recycled Water Supply.',
    `pressure_range_psi_max` STRING COMMENT 'Maximum water pressure in PSI at the customer service connection under normal operating conditions. Excessive pressure may require Pressure Reducing Valve (PRV) installation. Null for wastewater or non-pressurized services.',
    `pressure_range_psi_min` STRING COMMENT 'Minimum water pressure in PSI guaranteed at the customer service connection under normal operating conditions. Part of service delivery specifications. Null for wastewater or non-pressurized services.',
    `rate_structure_type` STRING COMMENT 'Pricing model applied to the offering. Uniform = single rate for all consumption; Tiered = increasing or decreasing rates by consumption block (e.g., conservation pricing); Seasonal = rates vary by season (summer vs. winter); Time of use = rates vary by time of day or peak demand periods; Demand-based = charges based on peak flow or capacity reservation.. Valid values are `uniform|tiered|seasonal|time_of_use|demand_based`',
    `regulatory_approval_date` DATE COMMENT 'Date on which the offering and its associated rate structure received regulatory approval from the Public Utilities Commission or other governing authority. Required for compliance with rate case documentation and audit trails.',
    `service_type` STRING COMMENT 'Primary category of water or wastewater service provided. Potable water = treated drinking water supply; Wastewater collection = sanitary sewer service; Recycled water = reclaimed water for non-potable uses; Fire protection = dedicated fire suppression service; Bulk water = wholesale or large-volume supply; Stormwater = stormwater management and drainage.. Valid values are `potable_water|wastewater_collection|recycled_water|fire_protection|bulk_water|stormwater`',
    `sla_response_time_hours` STRING COMMENT 'Maximum time in hours within which the utility commits to respond to service requests, outages, or quality complaints for this offering. Part of the contractual Service Level Agreement (SLA). Null if no formal SLA applies.',
    `sla_restoration_time_hours` STRING COMMENT 'Maximum time in hours within which the utility commits to restore service following an outage or interruption for this offering. Part of the contractual Service Level Agreement (SLA). Null if no formal SLA applies.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required for customer to terminate or discontinue service. Common for commercial and industrial contracts. Null for standard residential service.',
    `volumetric_rate_amount` DECIMAL(18,2) COMMENT 'Per-unit charge for water or wastewater service based on consumption volume. Typically expressed in dollars per thousand gallons ($/kgal) or dollars per hundred cubic feet ($/CCF). Null for unmetered or flat-rate offerings.',
    `volumetric_rate_unit` STRING COMMENT 'Unit of measure for volumetric billing. kgal = thousand gallons; CCF = hundred cubic feet; gallon = individual gallon; cubic meter = m³ (common in international contexts); acre-foot = volume unit for large agricultural or municipal contracts.. Valid values are `kgal|ccf|gallon|cubic_meter|acre_foot`',
    CONSTRAINT pk_offering PRIMARY KEY(`offering_id`)
) COMMENT 'Master catalog of all water and wastewater service offerings available to customers, including potable water supply, wastewater collection, recycled water, fire protection, irrigation, and bulk water services. Defines the canonical service type, delivery mode, applicable customer classes (residential, commercial, industrial, municipal), regulatory tariff reference, connection fee schedule, service tier options, and lifecycle status. This is the SSOT for what Water Utilities offers in the market and the anchor entity for rate schedules, SLAs, and service agreements.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`service`.`service_rate_schedule` (
    `service_rate_schedule_id` BIGINT COMMENT 'Unique identifier for the service_rate_schedule data product (auto-inserted pre-linking).',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Service rate schedules define approved tariff rate structures for specific service offerings. Currently has rate_case_id but missing the offering link. Rate schedules must be tied to the offerings the',
    `rate_case_id` BIGINT COMMENT 'Foreign key linking to finance.rate_case. Business justification: Rate schedules are approved through rate case proceedings. Essential for tracking regulatory approval, effective dates, and revenue requirement allocation across customer classes. Required for PUC com',
    `service_class_id` BIGINT COMMENT 'Foreign key linking to service.service_class. Business justification: Rate schedules are applied by customer service class (residential, commercial, industrial, etc.). Each rate schedule should specify which service class it applies to. This is a standard water utility ',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to service.tariff. Business justification: Rate schedules implement approved regulatory tariffs. In water utilities, tariffs are filed with and approved by the Public Utilities Commission, then rate schedules operationalize those tariffs. serv',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Rate schedules can vary by geographic territory due to different franchise agreements, cost structures, or regulatory jurisdictions. Water utilities often have territory-specific rate schedules. This ',
    CONSTRAINT pk_service_rate_schedule PRIMARY KEY(`service_rate_schedule_id`)
) COMMENT 'Defines the approved tariff rate structures for each service offering, including tiered volumetric rates (with tier thresholds, unit prices, and tier sequences), flat fees, demand charges, seasonal rate adjustments, and minimum charges. Captures the rate case approval date, effective and expiration dates, regulatory authority, rate code, applicable customer class, and billing unit of measure. Tier definitions (inclining block, declining block, uniform) are maintained as structured components within each schedule. Supports rate case modeling and regulatory tariff compliance. Aligned with Oracle CC&B rate schedule configuration.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`service`.`territory` (
    `territory_id` BIGINT COMMENT 'Unique identifier for the service territory. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Service territories map to cost centers for financial reporting by operating division. The plain-text operating_division_code is a denormalization of cost_center. Territory-level budget-to-actual repo',
    `regulatory_agency_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_agency. Business justification: Each service territory in water utilities is overseen by a specific primacy regulatory agency (state drinking water program or EPA region). This is a fundamental operational relationship for regulator',
    `water_source_id` BIGINT COMMENT 'Foreign key linking to treatment.water_source. Business justification: Source water protection planning, drought response, and UCMR monitoring require knowing which water source supplies each service territory. Utilities must link territory to its primary water source fo',
    `acquisition_date` DATE COMMENT 'Date when the utility acquired this service territory through purchase, merger, or regulatory transfer from another provider.',
    `area_square_miles` DECIMAL(18,2) COMMENT 'Total geographic area of the service territory measured in square miles.',
    `average_daily_demand_mgd` DECIMAL(18,2) COMMENT 'Average daily water demand for the territory measured in million gallons per day, used for capacity planning and regulatory reporting.',
    `boundary_description` STRING COMMENT 'Textual description of the territory boundary using legal descriptions, street names, or geographic landmarks.',
    `commercial_customer_count` STRING COMMENT 'Number of commercial customer accounts within the territory.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the territory is located (e.g., USA).. Valid values are `^[A-Z]{3}$`',
    `county_name` STRING COMMENT 'Primary county in which the service territory is located, used for regulatory reporting and jurisdictional analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service territory record was first created in the system.',
    `customer_count` STRING COMMENT 'Total number of active customer accounts (service connections) within the territory.',
    `effective_end_date` DATE COMMENT 'Date when the utilitys authorization to serve this territory expires or was terminated. Null for active territories with no expiration.',
    `effective_start_date` DATE COMMENT 'Date when the utility began providing service in this territory or when the current franchise agreement became effective.',
    `emergency_contact_phone` STRING COMMENT 'Primary emergency contact phone number for service issues or outages in this territory, published to customers and regulatory agencies.',
    `franchise_agreement_number` STRING COMMENT 'Identifier of the regulatory franchise agreement or certificate of public convenience and necessity (CPCN) authorizing service in this territory.',
    `franchise_expiration_date` DATE COMMENT 'Date when the current franchise agreement or certificate expires and requires renewal or renegotiation.',
    `gis_boundary_reference` STRING COMMENT 'Reference identifier or feature class name in Esri ArcGIS for the polygon geometry defining the territory boundary.',
    `industrial_customer_count` STRING COMMENT 'Number of industrial customer accounts within the territory.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service territory record was last updated in the system.',
    `notes` STRING COMMENT 'Free-form notes capturing special conditions, historical context, or operational considerations for this service territory.',
    `npdes_permit_jurisdiction` STRING COMMENT 'Regulatory authority responsible for wastewater discharge permits under the Clean Water Act (CWA) in this territory.',
    `peak_daily_demand_mgd` DECIMAL(18,2) COMMENT 'Peak daily water demand for the territory measured in million gallons per day, used for infrastructure sizing and emergency planning.',
    `population_served` STRING COMMENT 'Estimated total population residing within the service territory, used for regulatory reporting and capacity planning.',
    `potable_water_service_flag` BOOLEAN COMMENT 'Indicates whether the utility provides potable (drinking) water service within this territory.',
    `predecessor_utility_name` STRING COMMENT 'Name of the previous utility that served this territory before acquisition or transfer, used for historical data lineage.',
    `rate_zone_code` STRING COMMENT 'Code identifying the rate zone or pricing district applicable to customers in this territory.',
    `recycled_water_service_flag` BOOLEAN COMMENT 'Indicates whether the utility provides recycled (reclaimed) water service for non-potable uses within this territory.',
    `residential_customer_count` STRING COMMENT 'Number of residential customer accounts within the territory.',
    `service_center_location` STRING COMMENT 'Name or identifier of the primary service center or operations facility serving this territory.',
    `service_classification` STRING COMMENT 'Geographic and demographic classification of the territory, used for rate design and infrastructure planning.. Valid values are `urban|suburban|rural|mixed`',
    `state_code` STRING COMMENT 'Two-letter U.S. state code where the territory is located (e.g., CA, TX, NY).. Valid values are `^[A-Z]{2}$`',
    `stormwater_service_flag` BOOLEAN COMMENT 'Indicates whether the utility provides stormwater management service within this territory.',
    `tariff_schedule_reference` STRING COMMENT 'Reference to the applicable rate tariff schedule approved by the regulatory authority for this territory.',
    `territory_code` STRING COMMENT 'Externally-known unique code identifying the service territory, used in regulatory filings and franchise agreements.. Valid values are `^[A-Z0-9]{4,12}$`',
    `territory_name` STRING COMMENT 'Human-readable name of the service territory (e.g., Downtown District, North County Service Area).',
    `territory_status` STRING COMMENT 'Current operational status of the service territory in the utilitys service portfolio.. Valid values are `active|inactive|pending|suspended|retired|transferred`',
    `territory_type` STRING COMMENT 'Classification of the service territory based on regulatory authorization and service delivery model.. Valid values are `franchise|certificated|contract|wholesale|retail|combined`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the territory (e.g., America/Los_Angeles), used for operational scheduling and SCADA data timestamping.',
    `wastewater_service_flag` BOOLEAN COMMENT 'Indicates whether the utility provides wastewater collection and treatment service within this territory.',
    CONSTRAINT pk_territory PRIMARY KEY(`territory_id`)
) COMMENT 'Defines the geographic service territories and franchise areas within which Water Utilities is authorized to provide water and wastewater services. Includes territory boundaries (GIS polygon references via Esri ArcGIS), regulatory franchise agreement identifiers, applicable state primacy agency jurisdiction, service type coverage (potable, wastewater, recycled), and territory classification (urban, suburban, rural). Supports tariff applicability and regulatory reporting.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`service`.`service_class` (
    `service_class_id` BIGINT COMMENT 'Unique identifier for the service class record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Service classes (residential, commercial, industrial, irrigation) map to cost centers for cost-of-service allocation studies — a mandatory component of rate case filings. Utility rate analysts allocat',
    `average_monthly_consumption_gallons` DECIMAL(18,2) COMMENT 'Typical average monthly water consumption in gallons for accounts in this service class. Used for rate modeling and demand forecasting.',
    `awwa_classification_code` STRING COMMENT 'Standard classification code from AWWA M1 Manual used for industry benchmarking and best practice alignment.',
    `backflow_prevention_required` BOOLEAN COMMENT 'Indicates whether backflow prevention devices are required for accounts in this service class to protect the public water supply from contamination.',
    `billing_cycle_type` STRING COMMENT 'Standard billing frequency for accounts in this service class (e.g., monthly, bimonthly, quarterly). Determines meter reading and invoice generation schedules.. Valid values are `monthly|bimonthly|quarterly|annual|on_demand`',
    `class_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the service class (e.g., RSF for Residential Single-Family, COM for Commercial, IND for Industrial). Used in billing systems and regulatory reports.. Valid values are `^[A-Z0-9]{2,10}$`',
    `class_description` STRING COMMENT 'Detailed description of the service class, including eligibility criteria, typical usage characteristics, and any special conditions or restrictions.',
    `class_name` STRING COMMENT 'Full descriptive name of the service class (e.g., Residential Single-Family, Commercial, Industrial, Irrigation, Fire Protection, Municipal, Wholesale).',
    `class_type` STRING COMMENT 'High-level category of the service class used for grouping and analysis. Aligns with regulatory reporting categories. [ENUM-REF-CANDIDATE: residential|commercial|industrial|irrigation|fire_protection|municipal|wholesale|other — 8 candidates stripped; promote to reference product]',
    `conservation_program_eligible` BOOLEAN COMMENT 'Indicates whether accounts in this service class are eligible for water conservation programs, rebates, or incentives.',
    `consumption_tier_structure` STRING COMMENT 'Type of rate structure applied to consumption for this class (e.g., flat rate, tiered/block rates, seasonal rates, time-of-use rates).. Valid values are `flat|tiered|seasonal|time_of_use`',
    `contract_term_months` STRING COMMENT 'Standard contract term length in months for accounts in this service class. Applicable primarily to wholesale and large industrial customers.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service class record was first created in the system.',
    `deposit_requirement_amount` DECIMAL(18,2) COMMENT 'Standard security deposit amount required for new accounts in this service class. May vary based on credit risk and consumption history.',
    `disconnection_policy` STRING COMMENT 'Policy governing service disconnection for non-payment for this class (e.g., standard, protected for vulnerable populations, restricted for essential services).. Valid values are `standard|protected|restricted`',
    `drought_surcharge_applicable` BOOLEAN COMMENT 'Indicates whether drought surcharges or emergency water use restrictions apply to this service class during water shortage conditions.',
    `effective_end_date` DATE COMMENT 'Date when this service class definition expires or was superseded. Null for currently active classes.',
    `effective_start_date` DATE COMMENT 'Date when this service class definition became or will become effective for billing and account assignment.',
    `fire_flow_requirement_gpm` STRING COMMENT 'Minimum fire flow capacity requirement in gallons per minute (GPM) for properties served under this class. Applicable primarily to commercial, industrial, and fire protection classes.',
    `late_payment_penalty_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied to overdue balances for accounts in this service class. Subject to regulatory limits.',
    `meter_size_range` STRING COMMENT 'Typical or allowable range of meter sizes (in inches) for accounts in this service class (e.g., 5/8-inch to 1-inch for residential, 2-inch to 6-inch for commercial).',
    `minimum_charge_applicable` BOOLEAN COMMENT 'Indicates whether a minimum monthly or periodic charge applies to accounts in this service class, regardless of consumption.',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified this service class record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service class record was last modified.',
    `notes` STRING COMMENT 'Additional notes, special conditions, or administrative comments regarding this service class.',
    `peak_demand_factor` DECIMAL(18,2) COMMENT 'Multiplier representing the ratio of peak demand to average demand for this service class. Used in capacity planning and infrastructure sizing.',
    `pressure_requirement_psi` STRING COMMENT 'Minimum service pressure requirement in pounds per square inch (PSI) for accounts in this service class. Ensures adequate pressure for intended use.',
    `puc_approval_date` DATE COMMENT 'Date when the Public Utilities Commission approved this service class and its associated rate structure. Required for regulated utilities.',
    `puc_filing_reference` STRING COMMENT 'Reference number or identifier of the PUC rate case filing or tariff document that established or modified this service class.',
    `rate_schedule_group` STRING COMMENT 'Identifier of the rate schedule group applicable to this service class. Links the class to specific rate structures and tariff schedules for billing purposes.',
    `regulatory_reporting_category` STRING COMMENT 'Classification code used for regulatory compliance reporting to state and federal agencies (e.g., EPA, PUC). Maps service class to required reporting categories.',
    `renewal_notification_days` STRING COMMENT 'Number of days advance notice required before contract renewal or rate changes for this service class.',
    `seasonal_rate_applicable` BOOLEAN COMMENT 'Indicates whether seasonal rate variations (e.g., higher summer rates for irrigation) apply to this service class.',
    `service_class_status` STRING COMMENT 'Current lifecycle status of the service class. Active classes are available for new account assignments; deprecated classes are phased out but may have existing accounts.. Valid values are `active|inactive|pending_approval|deprecated|suspended`',
    `service_level_agreement_tier` STRING COMMENT 'Service level tier defining response times, service restoration priorities, and quality commitments for this class (e.g., standard, priority, premium, critical).. Valid values are `standard|priority|premium|critical`',
    `tariff_classification` STRING COMMENT 'Official tariff classification as filed with and approved by the Public Utilities Commission. Used for rate case modeling and tariff compliance.',
    `water_quality_monitoring_frequency` STRING COMMENT 'Required frequency of water quality monitoring or testing for accounts in this service class. More stringent for industrial and high-risk classes.. Valid values are `daily|weekly|monthly|quarterly|annual|as_needed`',
    `created_by` STRING COMMENT 'User identifier or system account that created this service class record.',
    CONSTRAINT pk_service_class PRIMARY KEY(`service_class_id`)
) COMMENT 'Reference classification of customer service classes used for rate application and regulatory reporting, such as Residential Single-Family, Residential Multi-Family, Commercial, Industrial, Irrigation, Fire Protection, Municipal, and Wholesale. Each class carries a class code, description, applicable rate schedule group, billing cycle type, and regulatory reporting category. Aligned with PUC tariff classification and AWWA customer class standards.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`service`.`agreement` (
    `agreement_id` BIGINT COMMENT 'Unique identifier for the service agreement. Primary key for this entity representing the contractual relationship between Water Utilities and a customer account.',
    `affordability_plan_id` BIGINT COMMENT 'Foreign key linking to service.affordability_plan. Business justification: A customer service agreement may be enrolled in a low-income affordability plan. agreement has low_income_assistance_eligible flag but no FK to the specific affordability_plan record. Adding affordabi',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Industrial and commercial service agreements require compliance permits (NPDES, discharge permits). Utility tracks permit governing each agreement for regulatory reporting, billing validation, and dis',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Service delivery operations are cost-accounted by department/cost center for rate-making cost-of-service studies, overhead allocation, and performance analysis. Direct operational cost tracking requir',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that holds this service agreement. Links to the customer billing account in Oracle CC&B.',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: Service agreements need DMA context for NRW cost allocation, water loss recovery charges, zone-specific service terms, and consumption baseline establishment. Enables DMA-level revenue and loss accoun',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Service agreements generate revenue to specific utility funds (water fund, wastewater fund). Essential for fund accounting, GASB reporting, and rate case revenue tracking. Water utilities require fund',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Service agreements generate recurring revenue posted to specific GL accounts (service revenue, connection revenue). Revenue recognition and rate case revenue requirement calculations require linking a',
    `metering_meter_id` BIGINT COMMENT 'Reference to the water or wastewater meter installed at the service point for consumption measurement. Links to AMI (Advanced Metering Infrastructure) or AMR (Automatic Meter Reading) systems.',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Service agreements specify pressure guarantees (sla_response_time, pressure_range_psi) that must reference actual pressure zones for SLA compliance verification, hydraulic capacity validation, and ser',
    `service_class_id` BIGINT COMMENT 'Foreign key linking to service.service_class. Business justification: Each service agreement is assigned to a specific service class which determines rate schedule applicability, billing cycle, and regulatory reporting. The service_class STRING attribute should be norma',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: A service agreement governs delivery through a specific service line. LCRR compliance reporting requires linking active agreements to service line material records to identify lead lines under active ',
    `offering_id` BIGINT COMMENT 'Reference to the specific service offering (water, wastewater, reclaimed water, stormwater) that this agreement covers. Links to the service catalog.',
    `service_rate_schedule_id` BIGINT COMMENT 'Foreign key linking to service.service_rate_schedule. Business justification: A service agreement is governed by a specific approved rate schedule. agreement currently has rate_schedule_code as a string reference, which is a denormalized pointer to the service_rate_schedule rec',
    `sla_definition_id` BIGINT COMMENT 'Foreign key linking to service.sla_definition. Business justification: A service agreement commits to specific service level standards. agreement currently has sla_response_time_hours and sla_restoration_time_hours as raw denormalized values, but no FK to the governing s',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to service.tariff. Business justification: A customer service agreement is governed by a specific tariff filing. The agreements rates, terms, and conditions are defined by the applicable tariff. agreement currently has rate_schedule_code as a',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: A service agreement is for service delivery within a specific franchise territory. Territory determines applicable rates, regulations, and service rules. agreement currently has no territory_id FK. Ad',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Service agreements must specify the source WTP facility for water quality compliance tracking, billing validation, and regulatory reporting (MOR/DMR submissions require linking customer service to tre',
    `agreement_number` STRING COMMENT 'Externally visible unique business identifier for the service agreement. Used in customer communications, billing statements, and regulatory reporting.. Valid values are `^SA-[0-9]{8,12}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the service agreement. Active agreements are billed and serviced; suspended agreements are temporarily halted; terminated agreements are closed.. Valid values are `active|pending|suspended|terminated|cancelled`',
    `auto_pay_enabled` BOOLEAN COMMENT 'Indicates whether automatic payment is enabled for this service agreement. When true, invoices are automatically paid from the customers designated payment method.',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Indicates whether the service agreement automatically renews at the end of the contract term. When false, agreement requires explicit renewal action.',
    `backflow_prevention_required` BOOLEAN COMMENT 'Indicates whether backflow prevention device installation and annual testing is required for this service agreement per SDWA (Safe Drinking Water Act) cross-connection control requirements.',
    `billing_cycle_code` STRING COMMENT 'Code identifying the billing cycle schedule for this agreement (e.g., monthly, bi-monthly, quarterly). Determines meter reading and invoice generation timing.. Valid values are `^[A-Z0-9]{2,6}$`',
    `budget_billing_enabled` BOOLEAN COMMENT 'Indicates whether the customer is enrolled in budget billing program, which averages annual usage into equal monthly payments to reduce seasonal bill variation.',
    `contract_term_months` STRING COMMENT 'Duration of the service agreement contract in months. Used for minimum commitment periods and early termination fee calculations.',
    `created_by_user` STRING COMMENT 'Identifier of the system user or process that created this service agreement record. Used for audit and accountability purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service agreement record was first created in the system. Used for audit trail and data lineage tracking.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Dollar amount of security deposit required and held for this service agreement. Based on credit assessment and service class. Refundable upon agreement termination.',
    `deposit_status` STRING COMMENT 'Current status of the security deposit for this agreement. Tracks whether deposit is required, currently held, waived based on credit, or refunded.. Valid values are `required|held|waived|refunded|forfeited`',
    `end_date` DATE COMMENT 'Date when the service agreement terminates or is scheduled to terminate. Null for open-ended agreements. Used for final billing and account closure.',
    `external_reference_code` STRING COMMENT 'External system identifier for this service agreement in legacy or third-party systems. Used for cross-system reconciliation and data migration tracking.',
    `fire_protection_service_flag` BOOLEAN COMMENT 'Indicates whether this agreement includes fire protection service (private fire lines, sprinkler systems), which typically carries fixed monthly charges regardless of usage.',
    `industrial_user_permit_required` BOOLEAN COMMENT 'Indicates whether this service agreement requires an Industrial User Permit for wastewater discharge per NPDES (National Pollutant Discharge Elimination System) pretreatment program requirements.',
    `irrigation_service_flag` BOOLEAN COMMENT 'Indicates whether this agreement includes irrigation or outdoor water service, which may be billed separately or subject to seasonal rates and wastewater exemptions.',
    `last_modified_by_user` STRING COMMENT 'Identifier of the system user or process that last modified this service agreement record. Used for change audit and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service agreement record was last updated. Used for change tracking and data synchronization across systems.',
    `low_income_assistance_eligible` BOOLEAN COMMENT 'Indicates whether this service agreement qualifies for low-income customer assistance programs, rate discounts, or payment plans per regulatory requirements.',
    `minimum_usage_commitment_gallons` DECIMAL(18,2) COMMENT 'Minimum water usage volume (in gallons) that the customer commits to consume per billing period. Common for commercial and industrial agreements. Used for minimum charge calculations.',
    `paperless_billing_enabled` BOOLEAN COMMENT 'Indicates whether the customer has opted for electronic billing instead of paper invoices. Supports environmental sustainability initiatives.',
    `renewal_date` DATE COMMENT 'Date when the service agreement is scheduled for renewal or renegotiation. Applicable for fixed-term contracts with renewal provisions.',
    `senior_citizen_discount_eligible` BOOLEAN COMMENT 'Indicates whether this service agreement qualifies for senior citizen rate discounts or special programs as defined by utility tariff.',
    `sla_response_time_hours` STRING COMMENT 'Contractually committed maximum response time in hours for service requests and emergency calls. Varies by service class and agreement type.',
    `sla_restoration_time_hours` STRING COMMENT 'Contractually committed maximum time in hours to restore service after an outage or interruption. Critical for commercial and industrial customers.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this service agreement data originated. Supports data lineage and multi-system integration scenarios.. Valid values are `CCB|CIS|ERP|LEGACY`',
    `special_conditions` STRING COMMENT 'Free-text field capturing any special contractual conditions, exceptions, or custom terms negotiated for this service agreement. Examples include seasonal rate adjustments, volume discounts, or regulatory exemptions.',
    `start_date` DATE COMMENT 'Date when the service agreement becomes effective and service delivery begins. Used for billing proration and regulatory compliance reporting.',
    `termination_date` DATE COMMENT 'Actual date when the service agreement was terminated. Used for final billing, deposit refund processing, and regulatory reporting.',
    `termination_reason_code` STRING COMMENT 'Standardized code indicating the reason for service agreement termination. Examples include customer move-out, non-payment, property demolition, or service transfer.. Valid values are `^[A-Z0-9]{2,6}$`',
    CONSTRAINT pk_agreement PRIMARY KEY(`agreement_id`)
) COMMENT 'Represents the active contractual relationship between Water Utilities and a customer account for a specific service offering at a service location. Captures agreement start and end dates, contracted service class, applicable rate schedule, minimum usage commitments, deposit requirements, special conditions, and agreement status. This is the SSOT for what service a customer account is enrolled in. Aligned with Oracle CC&B service agreement entity.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`service`.`point` (
    `point_id` BIGINT COMMENT 'Unique identifier for the service point. Primary key for the service point entity representing the physical location where utility service is delivered.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Service points (especially industrial discharge points) are directly tied to NPDES permits. Permits specify discharge locations; utility must map permit-to-service-point for DMR reporting, compliance ',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: Service points require DMA assignment for NRW analysis, consumption pattern tracking, leak detection planning, and zone-level service analytics. Replaces denormalized dma_code with proper FK enabling ',
    `metering_meter_id` BIGINT COMMENT 'Reference to the metering device currently installed at this service point for consumption measurement. Links to the asset registry meter record.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: A service delivery point is associated with a specific service offering (e.g., potable water, recycled water, wastewater). point currently has service_type as a string but no FK to the offering master',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: A service point is physically tapped off a specific pipe main. Distribution engineers need this link for main break response (identifying affected service points), pressure analysis, and LCRR lead ser',
    `premise_id` BIGINT COMMENT 'Reference to the premise (property or parcel) where this service point is located. A premise may contain multiple service points (e.g., separate water and wastewater connections).',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Service points must reference pressure zones for hydraulic design validation, pressure guarantee compliance in SLAs, and service adequacy verification. Replaces denormalized pressure_zone_code with pr',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Service points are physical infrastructure assets (service lines, curb stops, connections) requiring maintenance tracking, condition assessment, and replacement planning. Field crews need asset histor',
    `service_class_id` BIGINT COMMENT 'Foreign key linking to service.service_class. Business justification: Service points are classified by customer class (residential, commercial, industrial) which determines rate schedule, meter size requirements, and service level agreements. The customer_class STRING a',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: The service point (commercial delivery point) maps to the physical service line asset. LCRR lead service line compliance requires linking active service points to their physical service line material ',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Service points (delivery locations) are geographically located within service territories. point has latitude, longitude, and address fields, which place it within a territory boundary. This FK establ',
    `water_source_id` BIGINT COMMENT 'Foreign key linking to treatment.water_source. Business justification: Boil water advisories and source-specific quality alerts must be targeted to service points supplied by the affected source. Utilities track which water source supplies each service point for SDWA pub',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Service points receive water from specific treatment facilities - critical for water quality tracking (CT compliance, turbidity, chlorine residual), pressure zone management, and responding to custome',
    `activation_date` DATE COMMENT 'Date when service delivery was first activated at this service point, marking the beginning of billable service. May differ from installation date if there was a delay between physical installation and service turn-on.',
    `ami_enabled` BOOLEAN COMMENT 'Indicates whether this service point is equipped with Advanced Metering Infrastructure for automated remote meter reading and real-time consumption monitoring. True if AMI meter is installed; false for manual read meters.',
    `backflow_device_type` STRING COMMENT 'Type of backflow prevention device installed at this service point. RPZ is Reduced Pressure Zone; DCVA is Double Check Valve Assembly; PVB is Pressure Vacuum Breaker; AG is Air Gap; none indicates no device required; unknown indicates status not verified.. Valid values are `rpz|dcva|pvb|ag|none|unknown`',
    `backflow_prevention_required` BOOLEAN COMMENT 'Indicates whether a backflow prevention device is required at this service point based on hazard assessment and cross-connection control regulations. True if backflow prevention is mandated; false otherwise.',
    `connection_material` STRING COMMENT 'Material composition of the service line connecting the distribution main to the customer premises. Critical for Lead and Copper Rule Revisions (LCRR) compliance and service line inventory reporting. [ENUM-REF-CANDIDATE: copper|pvc|hdpe|galvanized_steel|lead|ductile_iron|pex|unknown — 8 candidates stripped; promote to reference product]',
    `connection_size_inches` DECIMAL(18,2) COMMENT 'Diameter of the service connection pipe in inches, representing the physical capacity of the service line connecting the distribution main to the customer premises. Common sizes include 0.75, 1.0, 1.5, 2.0, 3.0, 4.0, 6.0, 8.0 inches.',
    `created_by_user` STRING COMMENT 'User identifier of the person or system process that created this service point record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service point record was first created in the system. Used for audit trail and data lineage tracking.',
    `curb_stop_location` STRING COMMENT 'Description of the physical location of the curb stop valve (service shutoff valve) for this service point. Used by field crews for service disconnection and emergency shutoff.',
    `disconnection_date` DATE COMMENT 'Date when service was disconnected or terminated at this service point. Null if service is currently active.',
    `elevation_feet` DECIMAL(18,2) COMMENT 'Ground elevation of the service point location in feet above mean sea level. Used for hydraulic modeling to calculate static pressure and pressure zone assignment.',
    `estimated_daily_demand_gallons` DECIMAL(18,2) COMMENT 'Estimated average daily water demand at this service point in gallons, used for hydraulic modeling and capacity planning. Derived from historical consumption patterns or engineering estimates for new connections.',
    `fire_service_indicator` BOOLEAN COMMENT 'Indicates whether this service point includes fire protection service (fire sprinkler system or fire hydrant connection). True if fire service is provided; false for domestic-only service.',
    `gis_feature_code` STRING COMMENT 'Unique identifier linking this service point to its corresponding feature in the Esri ArcGIS utility network model. Enables spatial analysis and network tracing.',
    `installation_date` DATE COMMENT 'Date when the service point connection was physically installed and commissioned for service delivery. Used for asset age tracking and depreciation calculations.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent field inspection or verification of this service point. Used for compliance tracking and preventive maintenance scheduling.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the service point location in decimal degrees, typically captured from Esri ArcGIS spatial data. Used for GIS mapping, network modeling, and spatial analytics.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the service point location in decimal degrees, typically captured from Esri ArcGIS spatial data. Used for GIS mapping, network modeling, and spatial analytics.',
    `modified_by_user` STRING COMMENT 'User identifier of the person or system process that last modified this service point record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service point record was last modified in the system. Used for audit trail and change tracking.',
    `ownership_type` STRING COMMENT 'Ownership responsibility for the service line infrastructure. Utility-owned indicates the utility maintains the entire service line; customer-owned indicates customer responsibility; shared indicates split ownership at a defined point (typically property line or curb stop).. Valid values are `utility_owned|customer_owned|shared|unknown`',
    `peak_demand_gpm` DECIMAL(18,2) COMMENT 'Estimated peak instantaneous demand at this service point in gallons per minute, used for service line sizing and pressure analysis in hydraulic models.',
    `rate_schedule_code` STRING COMMENT 'Identifier for the tariff rate schedule applied to this service point for billing purposes. Rate schedules define the pricing structure including base charges, volumetric rates, and tier thresholds.',
    `route_code` STRING COMMENT 'Identifier for the meter reading or field service route to which this service point is assigned. Used for scheduling meter reading, field inspections, and maintenance activities.',
    `service_address_line1` STRING COMMENT 'Primary street address line of the physical location where service is delivered. Includes street number, street name, and street type.',
    `service_address_line2` STRING COMMENT 'Secondary address line for apartment number, suite, unit, building, or other location qualifier at the service point address.',
    `service_city` STRING COMMENT 'City or municipality name where the service point is located.',
    `service_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the service point is located (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `service_point_description` STRING COMMENT 'Free-text description providing additional context about the service point location, special characteristics, or access instructions for field personnel.',
    `service_point_number` STRING COMMENT 'Externally-known business identifier for the service point, typically displayed on customer bills and used in customer service interactions. Unique across the utility service territory.. Valid values are `^SP[0-9]{8,12}$`',
    `service_point_status` STRING COMMENT 'Current operational status of the service point in its lifecycle. Active indicates service is being delivered; inactive indicates no current service; suspended indicates temporary service hold; pending_activation indicates awaiting turn-on; disconnected indicates service terminated; abandoned indicates permanently retired.. Valid values are `active|inactive|suspended|pending_activation|disconnected|abandoned`',
    `service_postal_code` STRING COMMENT 'ZIP code or postal code of the service point location, supporting 5-digit or 9-digit (ZIP+4) formats.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `service_state` STRING COMMENT 'Two-letter state or province code where the service point is located, following USPS state abbreviation standards.. Valid values are `^[A-Z]{2}$`',
    `service_type` STRING COMMENT 'Type of utility service delivered at this service point. Potable water is drinking water distribution; wastewater is sanitary sewer collection; recycled water is reclaimed water for irrigation or industrial use; stormwater is surface water drainage; combined is combined sewer system.. Valid values are `potable_water|wastewater|recycled_water|stormwater|combined`',
    CONSTRAINT pk_point PRIMARY KEY(`point_id`)
) COMMENT 'Represents the physical location where a utility service is delivered to a customer, corresponding to a metered connection point on the distribution or wastewater network. Captures the service point address, GIS coordinates (Esri ArcGIS), service type (potable water, wastewater, recycled water), connection size (pipe diameter in inches), pressure zone, DMA assignment, and active status. Links the commercial service agreement to the physical network infrastructure.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`service`.`connection_application` (
    `connection_application_id` BIGINT COMMENT 'Unique identifier for the connection application record. Primary key.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Connection applications requiring infrastructure upgrades (main extensions, pump station capacity, treatment plant expansion) trigger or are bundled into CIP projects. Applicants and customer service ',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: New connection applications must be evaluated against the utilitys water supply or NPDES permit capacity limits. Permit-constrained capacity availability is a named operational gate in connection app',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Connection activities (engineering review, field inspection, installation) are cost-accounted by department for rate-making, cost recovery analysis, and connection fee justification. Essential for rat',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: New connections must be assigned to DMAs for capacity planning, NRW impact assessment, metering infrastructure planning, and zone-level demand forecasting. Essential for evaluating capacity_available ',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse_location. Business justification: Connection application fulfillment requires assigning a warehouse from which meters and fittings are staged. Field crews need the fulfillment warehouse identified on the application to pick up materia',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Connection fees collected via applications are deposited into specific funds (capital improvement fund, system development charge fund). Water utility financial policy requires tracking which fund rec',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Connection fees and application fees are posted to specific GL accounts (system development charges, capital contributions, fee revenue). GL coding of connection application fees is required for capit',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: New connection applications require infrastructure capacity assessment at specific asset locations (pump stations, pressure zones, treatment facilities). Engineering reviews check available capacity, ',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Connection applications specify required materials (meter size/type, service line diameter, backflow device model) that must be validated against material master for availability, lead time, NSF/AWWA ',
    `meter_size_type_id` BIGINT COMMENT 'Foreign key linking to metering.meter_size_type. Business justification: Connection applications specify required meter size based on estimated demand (GPM). Engineering review validates sizing against meter_size_type specifications (max flow, pressure rating, accuracy cla',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Connection applications request a specific service offering from the catalog. connection_application currently has requested_service_type as a STRING field, which should be normalized to reference the',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Connection applications require upfront fee payment (application fee, connection fee, capacity charge) before approval. New service application processing depends on verifying payment receipt and clea',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: New connection applications require engineering review of the specific pipe main where the tap will be made — capacity, pressure class, and material must be verified. This is a standard connection app',
    `point_id` BIGINT COMMENT 'Foreign key linking to service.point. Business justification: A connection application may reference an existing service point (for upgrades, transfers, or disconnections) or result in a new service point being created upon approval. Adding point_id to connectio',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: New connection applications require pressure zone assignment for hydraulic capacity verification, infrastructure adequacy assessment, and pressure guarantee feasibility before approval. Critical for c',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account associated with this connection application. Links to the customer master record.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: New connection applications must comply with regulatory requirements (backflow prevention, cross-connection control, capacity standards, water quality). Application review process validates against ap',
    `service_class_id` BIGINT COMMENT 'Foreign key linking to service.service_class. Business justification: A connection application is submitted for a specific service class (residential, commercial, industrial, etc.). The service class determines applicable rates, deposit requirements, and technical speci',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Connection applications are submitted for service within a specific franchise territory. The service_address fields are application-specific and should be retained, but a FK to service_territory is ne',
    `work_order_id` BIGINT COMMENT 'Identifier of the work order created to execute the physical connection installation. Links to the work order management system.',
    `ami_enabled` BOOLEAN COMMENT 'Indicates whether the connection will be equipped with Advanced Metering Infrastructure (AMI) for automated meter reading and real-time monitoring.',
    `applicant_email` STRING COMMENT 'Primary email address of the applicant for correspondence and notifications regarding the connection application.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `applicant_name` STRING COMMENT 'Full legal name of the individual or organization applying for the service connection.',
    `applicant_phone` STRING COMMENT 'Primary contact phone number of the applicant for communication regarding the connection application.. Valid values are `^+?[1-9]d{1,14}$`',
    `application_date` DATE COMMENT 'Date when the connection application was formally submitted by the applicant.',
    `application_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged for processing the connection application, in USD.',
    `application_number` STRING COMMENT 'Externally-visible unique application number assigned to the connection request. Format: CA-YYYYNNNN.. Valid values are `^CA-[0-9]{8}$`',
    `application_status` STRING COMMENT 'Current lifecycle status of the connection application in the approval workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|on_hold|completed|cancelled — 8 candidates stripped; promote to reference product]',
    `application_type` STRING COMMENT 'Type of service connection application: new connection, service upgrade, disconnection, transfer of service, reconnection, or temporary service.. Valid values are `new_connection|service_upgrade|disconnection|transfer|reconnection|temporary_service`',
    `approval_date` DATE COMMENT 'Date when the connection application was officially approved by the utility.',
    `capacity_available` BOOLEAN COMMENT 'Indicates whether sufficient system capacity (pressure, flow, treatment capacity) is available to serve the requested connection without infrastructure upgrades.',
    `capacity_charge_amount` DECIMAL(18,2) COMMENT 'System development or capacity charge assessed to fund infrastructure expansion to serve the new connection, in USD.',
    `completion_date` DATE COMMENT 'Date when the physical service connection was completed and the service was activated.',
    `connection_fee_amount` DECIMAL(18,2) COMMENT 'One-time connection or tap fee assessed for establishing the new service connection, in USD.',
    `connection_size_inches` DECIMAL(18,2) COMMENT 'Diameter of the requested service connection in inches (e.g., 0.75, 1.0, 1.5, 2.0). Critical for capacity planning and meter sizing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the connection application record was first created in the system.',
    `estimated_flow_demand_gpm` DECIMAL(18,2) COMMENT 'Estimated peak flow demand in gallons per minute (GPM) for the requested service connection. Used for hydraulic modeling and capacity verification.',
    `infrastructure_upgrade_required` BOOLEAN COMMENT 'Indicates whether main extensions, pump station upgrades, or other infrastructure improvements are required to serve the connection.',
    `meter_type_requested` STRING COMMENT 'Type or model of water meter requested or recommended for the connection (e.g., positive displacement, turbine, compound, electromagnetic).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the connection application record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text notes and comments regarding the connection application, including special requirements, site conditions, or coordination details.',
    `number_of_units` STRING COMMENT 'Number of dwelling units, commercial units, or service points at the property (e.g., apartments in a multi-family building).',
    `payment_status` STRING COMMENT 'Status of fee payment for the connection application: unpaid, partially paid, fully paid, waived, or refunded.. Valid values are `unpaid|partial|paid|waived|refunded`',
    `property_type` STRING COMMENT 'Classification of the property requesting service: residential, commercial, industrial, institutional, agricultural, or mixed-use.. Valid values are `residential|commercial|industrial|institutional|agricultural|mixed_use`',
    `rejection_date` DATE COMMENT 'Date when the connection application was rejected or denied by the utility.',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the connection application was rejected (e.g., insufficient capacity, incomplete documentation, non-compliance with standards).',
    `requested_service_date` DATE COMMENT 'Date by which the applicant requests the service connection to be activated or completed.',
    `service_address_line1` STRING COMMENT 'Primary street address line where the water or wastewater service connection is requested.',
    `service_address_line2` STRING COMMENT 'Secondary address line (apartment, suite, unit number) for the service location.',
    `service_city` STRING COMMENT 'City or municipality where the service connection is requested.',
    `service_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the service connection location for GIS mapping and network planning.',
    `service_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the service connection location for GIS mapping and network planning.',
    `service_postal_code` STRING COMMENT 'Postal or ZIP code for the service address.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `service_state` STRING COMMENT 'Two-letter state or province code where the service connection is requested.. Valid values are `^[A-Z]{2}$`',
    `technical_review_date` DATE COMMENT 'Date when the technical feasibility and capacity review of the connection application was completed.',
    `total_fees_assessed` DECIMAL(18,2) COMMENT 'Total of all fees assessed for the connection application (application fee, connection fee, capacity charge, and any other charges), in USD.',
    CONSTRAINT pk_connection_application PRIMARY KEY(`connection_application_id`)
) COMMENT 'Tracks customer applications for new service connections, service upgrades, disconnections, and transfers. Captures application date, requested service type, service address, applicant details, connection size requested, estimated flow demand (GPM), application status, review milestones, fees assessed, and approval or rejection details. Supports the new service onboarding workflow and capacity planning. Aligned with Microsoft Dynamics 365 field service request intake.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`service`.`order` (
    `order_id` BIGINT COMMENT 'Unique identifier for the service order. Primary key for the service order entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to service.service_agreement. Business justification: Service orders (turn-on, turn-off, meter change, maintenance) are performed in the context of a service agreement. Adding service_agreement_id FK establishes the agreement context for the service orde',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Service orders for new connections or upgrades may be contingent on CIP project completion (e.g., service available after main extension project completes). Customer service and field operations need ',
    `connection_application_id` BIGINT COMMENT 'Foreign key linking to service.connection_application. Business justification: Service orders are often generated from approved connection applications (new service installations, upgrades). Adding connection_application_id FK tracks the originating application that triggered th',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Field service operations (meter reads, turn-ons, repairs) are tracked by cost center for labor cost allocation, overhead rate calculation, and rate case cost-of-service studies. Direct operational cos',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: Service orders require DMA assignment for operational planning, NRW event correlation (service work causing leaks), zone-based work scheduling, and DMA-level service activity tracking. Essential for c',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Service orders generating fees (reconnection, meter set, service establishment) are posted to specific funds per utility financial policy. Fund-level revenue tracking for service fees is required for ',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Service orders with billable fees (service_fee_amount exists on order) are posted to specific GL accounts. Proper GL coding of service order revenue is required for financial close, budget-to-actual v',
    `main_break_id` BIGINT COMMENT 'Foreign key linking to distribution.main_break. Business justification: Main breaks generate customer service orders for service restoration, turn-off/turn-on, and damage assessment. Customer service reps and field crews need to associate restoration orders with the causa',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: A service work order is issued to fulfill a specific service offering (e.g., new potable water connection, meter installation for recycled water service). order currently links to agreement (which lin',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with this service order.',
    `order_customer_customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with this service order.',
    `metering_meter_id` BIGINT COMMENT 'Serial number or identifier of the meter removed during a meter exchange service order.',
    `order_new_meter_metering_meter_id` BIGINT COMMENT 'Serial number or identifier of the meter installed during a meter set or exchange service order.',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: Service orders for new taps, main extensions, or infrastructure work reference the specific pipe main being acted upon. Field crews and GIS need this link for work management, asset history tracking, ',
    `point_id` BIGINT COMMENT 'Reference to the physical service delivery point (meter location) where the field activity will be performed.',
    `premise_id` BIGINT COMMENT 'Reference to the premise (property/location) where the service order activity will occur.',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Service orders (connect/disconnect/repair) need pressure zone context for crew routing optimization, pressure impact assessment during isolation events, service restoration verification, and zone-base',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Service orders (meter installation, valve operation, service line repair) target specific assets requiring maintenance history, condition data, and warranty information. Field technicians need asset s',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: Service orders for turn-on, turn-off, meter set, and leak repair are executed at a specific service line. Field dispatchers and crews need to know which physical service line the order pertains to for',
    `sla_definition_id` BIGINT COMMENT 'Foreign key linking to service.sla_definition. Business justification: Service orders are executed according to defined SLA standards. order currently has sla_target_hours, sla_actual_hours, and sla_met_flag. The target hours should be derived from sla_definition rather ',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Service orders (new connections, reconnections) require verification that source facility can meet pressure/flow requirements and that water quality meets standards at time of service. Operations team',
    `actual_end_time` TIMESTAMP COMMENT 'Actual date and time when the field crew completed the service order activity.',
    `actual_start_time` TIMESTAMP COMMENT 'Actual date and time when the field crew began performing the service order activity.',
    `appointment_window_end` TIMESTAMP COMMENT 'End of the time window communicated to the customer for the service order appointment.',
    `appointment_window_start` TIMESTAMP COMMENT 'Beginning of the time window communicated to the customer for the service order appointment.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether the service order activity is billable to the customer account.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the service order was cancelled, if applicable.',
    `completion_date` DATE COMMENT 'Date when the service order was marked as completed in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the service order record was first created in the system.',
    `customer_contact_name` STRING COMMENT 'Name of the customer contact person for this service order, used for appointment confirmation and access coordination.',
    `customer_contact_phone` STRING COMMENT 'Phone number of the customer contact person for appointment confirmation and field crew communication.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the service location, used for crew dispatch and asset tracking.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the service location, used for crew dispatch and asset tracking.',
    `meter_reading_unit` STRING COMMENT 'Unit of measure for the meter reading value captured during the service order.. Valid values are `gallons|cubic_meters|cubic_feet|liters`',
    `meter_reading_value` DECIMAL(18,2) COMMENT 'Final meter reading captured during the service order activity, measured in appropriate units (gallons, cubic meters, etc.).',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the service order record was last modified in the system.',
    `order_number` STRING COMMENT 'Externally visible business identifier for the service order, used for customer communication and field crew reference.. Valid values are `^SO-[0-9]{8}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the service order in the field service workflow. [ENUM-REF-CANDIDATE: draft|scheduled|dispatched|in_progress|completed|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the service order activity. Defines the nature of field work to be performed. [ENUM-REF-CANDIDATE: turn_on|turn_off|reconnection|meter_set|meter_exchange|service_upgrade|final_read|leak_investigation — 8 candidates stripped; promote to reference product]',
    `outcome_code` STRING COMMENT 'Standardized code indicating the final outcome or result of the service order execution.. Valid values are `completed_as_planned|partial_completion|unable_to_complete|customer_not_available|access_denied|equipment_failure`',
    `priority` STRING COMMENT 'Priority level assigned to the service order, determining dispatch sequence and response time requirements.. Valid values are `emergency|urgent|standard|low`',
    `requested_date` DATE COMMENT 'Date when the customer or system requested the service order to be performed.',
    `scheduled_date` DATE COMMENT 'Date when the field crew is scheduled to perform the service order activity.',
    `scheduled_end_time` TIMESTAMP COMMENT 'Planned date and time when the field crew is expected to complete the service order activity.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Precise date and time when the field crew is scheduled to begin the service order activity.',
    `service_address` STRING COMMENT 'Full street address where the field service activity will be performed. Used for crew dispatch and navigation.',
    `service_fee_amount` DECIMAL(18,2) COMMENT 'Monetary charge assessed to the customer for the service order activity, in US dollars.',
    `sla_actual_hours` DECIMAL(18,2) COMMENT 'Actual number of hours elapsed from order creation to completion, used for SLA compliance tracking.',
    `sla_met_flag` BOOLEAN COMMENT 'Indicates whether the service order was completed within the target SLA timeframe.',
    `special_instructions` STRING COMMENT 'Additional instructions or notes for the field crew regarding access, safety, or customer requirements.',
    `work_performed_description` STRING COMMENT 'Detailed narrative description of the work actually performed by the field crew, including any findings or issues encountered.',
    CONSTRAINT pk_order PRIMARY KEY(`order_id`)
) COMMENT 'Operational work orders issued to field crews for service-related activities including new service turn-ons, turn-offs, reconnections after non-payment, meter sets, service upgrades, and final reads. Captures order type, scheduled date, completion date, assigned crew, service point reference, work performed, and outcome status. Distinct from asset maintenance work orders (owned by asset domain). Aligned with Oracle CC&B field activity and Microsoft Dynamics 365 field service.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`service`.`sla_definition` (
    `sla_definition_id` BIGINT COMMENT 'Unique identifier for the service level agreement definition record.',
    `billing_rate_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.rate_schedule. Business justification: Service level agreements define performance commitments that may be tied to premium rate schedules (guaranteed pressure, priority response). Tiered service pricing requires linking SLA definitions to ',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Water utility SLA definitions are frequently mandated by state PUC orders or EPA consent decrees. Linking to the specific regulatory_requirement formalizes the compliance mandate driving the SLA, enab',
    `service_class_id` BIGINT COMMENT 'Foreign key linking to service.service_class. Business justification: Service level agreements vary by customer service class, with different response time targets and compliance requirements for residential vs. commercial vs. industrial customers. The service_class STR',
    `offering_id` BIGINT COMMENT 'Reference to the service offering or service class to which this SLA applies.',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to service.tariff. Business justification: SLA definitions are documented in tariff filings and are subject to regulatory approval. The tariff_reference STRING attribute should be normalized to a FK to tariff, allowing JOIN to retrieve tariff_',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: SLA definitions in regulated water utilities are often territory-specific, as different franchise territories may have different regulatory authorities and SLA requirements. sla_definition currently h',
    `approval_authority` STRING COMMENT 'Regulatory body or internal authority that approved this SLA definition, such as Public Utilities Commission, State Primacy Agency, or internal executive committee.',
    `approval_date` DATE COMMENT 'Date on which this SLA definition was approved by the Public Utilities Commission or internal governance authority.',
    `compliance_percentage` DECIMAL(18,2) COMMENT 'Required percentage of time or occurrences that the SLA target must be met to maintain compliance, expressed as a percentage (e.g., 99.5% for high-availability commitments).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA definition record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date on which this SLA definition expires or is superseded by a new version. Null indicates the SLA is currently active with no defined end date.',
    `effective_start_date` DATE COMMENT 'Date on which this SLA definition becomes effective and enforceable, typically aligned with rate case approval or tariff filing effective date.',
    `escalation_procedure` STRING COMMENT 'Defined escalation path or procedure to be followed when the SLA is breached, including management notification, regulatory reporting, and customer communication steps.',
    `exclusion_conditions` STRING COMMENT 'Conditions or circumstances under which the SLA does not apply or is temporarily suspended, such as force majeure events, natural disasters, regulatory-mandated shutdowns, or customer-requested service interruptions.',
    `geographic_scope` STRING COMMENT 'Geographic area or service territory to which this SLA applies: system-wide across all service areas, specific district, pressure zone, District Metered Area (DMA), or specific customer location.. Valid values are `system_wide|district|zone|dma|specific_location`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA definition record was last updated or modified.',
    `maximum_value` DECIMAL(18,2) COMMENT 'Maximum acceptable value for the SLA metric, above which the SLA is considered breached. Applicable for metrics with upper bounds such as Maximum Contaminant Level (MCL), turbidity (NTU), or response time.',
    `measurement_frequency` STRING COMMENT 'Frequency at which the SLA metric is measured or evaluated: continuous monitoring via SCADA, periodic sampling, or event-based measurement triggered by specific conditions. [ENUM-REF-CANDIDATE: continuous|hourly|daily|weekly|monthly|quarterly|annual|event_based — 8 candidates stripped; promote to reference product]',
    `metric_name` STRING COMMENT 'Specific metric or parameter being measured for this SLA, such as Outage Response Time, Service Restoration Time, Minimum Water Pressure (PSI), Maximum Turbidity (NTU), pH Range, Maximum Contaminant Level (MCL), or Notification Time.',
    `minimum_value` DECIMAL(18,2) COMMENT 'Minimum acceptable value for the SLA metric, below which the SLA is considered breached. Applicable for metrics with lower bounds such as minimum water pressure (PSI) or minimum pH.',
    `notes` STRING COMMENT 'Additional notes, comments, or clarifications regarding the SLA definition, including historical context, implementation guidance, or special considerations.',
    `notification_method` STRING COMMENT 'Communication channels required for customer or regulatory notification, such as email, SMS, phone call, postal mail, public notice, website posting, or media announcement. Multiple methods may be specified.',
    `notification_requirement` STRING COMMENT 'Timeframe within which customers or regulatory agencies must be notified of an SLA breach or service issue, such as immediate notification for water quality violations or 24-hour notice for planned outages.. Valid values are `immediate|within_24_hours|within_48_hours|within_7_days|monthly|none`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary value of the penalty, credit, or rebate applied per SLA breach, expressed in the utilitys operating currency.',
    `penalty_calculation_method` STRING COMMENT 'Method used to calculate the penalty or credit: fixed amount per breach, per occurrence, per hour of non-compliance, per day, percentage of customer bill, or tiered based on severity or duration.. Valid values are `fixed|per_occurrence|per_hour|per_day|percentage_of_bill|tiered`',
    `penalty_type` STRING COMMENT 'Type of penalty or consequence applied when the SLA is breached: customer credit, service rebate, regulatory fine, escalation to management, or no penalty.. Valid values are `credit|rebate|fine|none|escalation`',
    `reporting_requirement` STRING COMMENT 'Frequency and type of reporting required for SLA compliance monitoring, such as monthly performance reports to the Public Utilities Commission, quarterly customer reports, or annual Consumer Confidence Report (CCR) inclusion.. Valid values are `monthly|quarterly|annual|event_based|none`',
    `sla_code` STRING COMMENT 'Business identifier code for the SLA definition, used for external reference and regulatory tariff filings.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `sla_definition_description` STRING COMMENT 'Detailed description of the SLA commitment, including the business purpose, customer benefit, and operational context.',
    `sla_definition_status` STRING COMMENT 'Current lifecycle status of the SLA definition: active and enforceable, inactive, pending regulatory approval, superseded by a newer version, or temporarily suspended.. Valid values are `active|inactive|pending_approval|superseded|suspended`',
    `sla_name` STRING COMMENT 'Human-readable name of the SLA definition, describing the commitment or guarantee.',
    `sla_type` STRING COMMENT 'Category of SLA commitment: response time for outage acknowledgment, restoration time for service recovery, water quality guarantee parameters, pressure guarantee thresholds, customer notification requirements, or system availability targets.. Valid values are `response_time|restoration_time|water_quality|pressure_guarantee|notification|availability`',
    `target_value` DECIMAL(18,2) COMMENT 'Numeric target or threshold value for the SLA metric, representing the committed performance level or guarantee.',
    `unit_of_measure` STRING COMMENT 'Unit of measurement for the SLA metric, such as minutes, hours, PSI (Pounds per Square Inch), NTU (Nephelometric Turbidity Units), mg/L, pH units, or percent.',
    CONSTRAINT pk_sla_definition PRIMARY KEY(`sla_definition_id`)
) COMMENT 'Defines the service level agreements applicable to each service offering or service class, including response time commitments for outages, restoration time targets, water quality guarantee parameters, pressure guarantee thresholds (PSI), and customer notification requirements. Captures SLA type, metric name, target value, measurement unit, regulatory basis (SDWA, state rules), and penalty or credit terms for non-compliance. Supports regulatory tariff compliance and customer service commitments.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`service`.`tariff` (
    `tariff_id` BIGINT COMMENT 'Unique identifier for the regulatory tariff filing record. Primary key.',
    `billing_rate_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.rate_schedule. Business justification: Tariffs are regulatory filings that authorize specific rate schedules. Regulatory compliance and rate case tracking require linking the approved tariff document to the rate schedules it authorizes for',
    `rate_case_id` BIGINT COMMENT 'Foreign key linking to finance.rate_case. Business justification: Tariffs are the direct regulatory output of rate case proceedings. Every tariff must reference the rate case docket that established it. Core regulatory compliance relationship for PUC/PSC reporting a',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Tariffs must comply with regulatory requirements (rate structure mandates, affordability requirements, conservation pricing rules). Tariff filings reference compliance with state/federal mandates. Lin',
    `service_class_id` BIGINT COMMENT 'Foreign key linking to service.service_class. Business justification: Tariff filings are class-specific, with separate rate schedules and regulatory approvals for each customer class. The customer_class STRING attribute should be normalized to a FK to service_class, all',
    `superseded_tariff_id` BIGINT COMMENT 'Reference to the prior tariff that this tariff replaces. Establishes the lineage of rate changes and enables historical rate analysis.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Tariffs apply to specific service territories and franchise areas. Currently service_territory is a STRING field describing where the tariff applies. Should be FK to service_territory for referential ',
    `adjustment_clause_flag` BOOLEAN COMMENT 'Indicates whether the tariff includes automatic adjustment clauses or riders that allow for rate changes without a full rate case. Common adjustment clauses include purchased water adjustment clauses (PWAC), infrastructure surcharges, and cost recovery mechanisms for specific capital programs.',
    `approval_date` DATE COMMENT 'The date on which the regulatory authority formally approved the tariff filing. This date may differ from the effective date due to statutory notice periods or phased implementation.',
    `approval_order_number` STRING COMMENT 'The official order or docket number issued by the regulatory authority approving this tariff. This reference links the tariff to the formal regulatory decision and provides traceability to the rate case proceeding.',
    `base_rate_amount` DECIMAL(18,2) COMMENT 'The foundational rate component approved by the regulatory authority, typically expressed as a fixed monthly charge or per-unit volumetric rate. This is the core revenue component before adjustments, surcharges, or riders.',
    `billing_frequency` STRING COMMENT 'The standard billing cycle for customers under this tariff. Defines how often charges are calculated and invoices are issued.. Valid values are `monthly|bimonthly|quarterly|annual`',
    `conservation_rate_flag` BOOLEAN COMMENT 'Indicates whether the tariff incorporates conservation-oriented rate design features such as increasing block rates, seasonal pricing, or water budget-based rates intended to promote efficient water use.',
    `cost_of_service_study_reference` STRING COMMENT 'Reference to the cost-of-service study or rate design analysis that supports the tariff rates. This study allocates utility costs to customer classes and justifies the rate structure to the regulatory authority.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this tariff record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which tariff rates and charges are denominated. For U.S. water utilities, this is typically USD.. Valid values are `USD`',
    `document_url` STRING COMMENT 'The web address or document management system link to the official tariff filing document, including all schedules, exhibits, and supporting materials. Provides direct access to the complete regulatory record.',
    `effective_date` DATE COMMENT 'The date on which the tariff becomes binding and enforceable. Rates and terms specified in the tariff apply to all qualifying service from this date forward.',
    `expiration_date` DATE COMMENT 'The date on which the tariff ceases to be in force, if applicable. Null for tariffs that remain active until superseded by a subsequent filing.',
    `filing_date` DATE COMMENT 'The date on which the tariff was officially filed with the Public Utilities Commission or state regulatory authority. This date triggers statutory review periods and notice requirements.',
    `hearing_date` DATE COMMENT 'The date of the public hearing or evidentiary proceeding held by the regulatory authority to review the tariff filing. Null if no hearing was required or held.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this tariff record was most recently updated. Supports change tracking and audit compliance.',
    `low_income_assistance_flag` BOOLEAN COMMENT 'Indicates whether the tariff includes provisions for low-income customer assistance programs, such as lifeline rates, bill discounts, or affordability programs mandated or approved by the regulatory authority.',
    `minimum_charge_amount` DECIMAL(18,2) COMMENT 'The minimum monthly or periodic charge that applies regardless of consumption. Ensures cost recovery for fixed infrastructure and customer service costs.',
    `notes` STRING COMMENT 'Free-form text field for additional context, clarifications, or special conditions related to the tariff. May include notes on implementation, transition provisions, or regulatory stipulations.',
    `public_notice_date` DATE COMMENT 'The date on which public notice of the tariff filing was provided to customers and stakeholders, as required by regulatory statute. Public notice periods allow for customer comment and intervention in rate proceedings.',
    `rate_base_amount` DECIMAL(18,2) COMMENT 'The net investment in utility plant and working capital upon which the utility is allowed to earn a return. Rate base is calculated as gross plant in service less accumulated depreciation plus working capital allowances.',
    `rate_of_return_percent` DECIMAL(18,2) COMMENT 'The allowed rate of return on rate base approved by the regulatory authority. Expressed as a decimal percentage (e.g., 0.0725 for 7.25%). This is the weighted average cost of capital (WACC) the utility is permitted to earn.',
    `rate_schedule_reference` STRING COMMENT 'Reference to the detailed rate schedule document or section number within the tariff filing that specifies the complete pricing structure, including block tiers, surcharges, and adjustments.',
    `rate_structure_type` STRING COMMENT 'The pricing methodology employed by the tariff. Flat rates charge a fixed amount regardless of usage, uniform rates charge a constant per-unit price, declining block rates decrease with higher usage tiers, increasing block rates increase with higher usage tiers to promote conservation, seasonal rates vary by time of year, and time-of-use rates vary by time of day or demand period.. Valid values are `flat|uniform|declining_block|increasing_block|seasonal|time_of_use`',
    `regulatory_authority` STRING COMMENT 'The name of the Public Utilities Commission, state regulatory agency, or other governing body that has jurisdiction over this tariff filing. Examples include State Public Service Commission, Public Utilities Commission, or Department of Public Utilities.',
    `revenue_requirement_amount` DECIMAL(18,2) COMMENT 'The total annual revenue requirement approved by the regulatory authority for the utility under this tariff. This is the aggregate revenue the utility is authorized to collect to cover operating expenses, capital costs, and allowed return on investment.',
    `service_rules_reference` STRING COMMENT 'Reference to the service rules, terms, and conditions document or section number within the tariff filing that governs service delivery, customer obligations, disconnection policies, and dispute resolution procedures.',
    `tariff_description` STRING COMMENT 'A detailed narrative description of the tariff, including its purpose, scope, applicability, and key terms. This field captures the regulatory intent and business context of the tariff.',
    `tariff_name` STRING COMMENT 'The official name or title of the tariff as it appears in regulatory filings and customer communications.',
    `tariff_number` STRING COMMENT 'The official regulatory tariff number assigned by the Public Utilities Commission or state regulatory authority. This is the externally-known identifier used in all regulatory filings and rate case proceedings.. Valid values are `^[A-Z0-9-]{5,20}$`',
    `tariff_status` STRING COMMENT 'Current lifecycle status of the tariff filing. Draft indicates internal preparation, filed means submitted to the regulator, pending approval is under regulatory review, approved means accepted by the commission, active is currently in force, suspended is temporarily halted, superseded is replaced by a newer tariff, and withdrawn is retracted before approval. [ENUM-REF-CANDIDATE: draft|filed|pending_approval|approved|active|suspended|superseded|withdrawn — 8 candidates stripped; promote to reference product]',
    `tariff_type` STRING COMMENT 'Classification of the tariff based on the customer segment and service arrangement it governs. General service tariffs apply to standard retail customers, special contracts cover negotiated agreements with large users, wholesale tariffs govern bulk water sales to other utilities, and industrial/municipal/residential/commercial designate specific customer classes. [ENUM-REF-CANDIDATE: general_service|special_contract|wholesale|industrial|municipal|residential|commercial — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_tariff PRIMARY KEY(`tariff_id`)
) COMMENT 'Master record of regulatory tariff filings and associated rate case proceedings with the Public Utilities Commission or state regulatory authority. Captures the full lifecycle from rate case filing (test year, requested revenue requirement, hearing dates, intervenor parties) through approval (final order, approved revenue requirement) to the effective tariff (tariff number, effective date, tariff type, incorporated rate schedules and service rules). This is the regulatory anchor for all rate and service term compliance, linking rate case proceedings to their resulting approved pricing structures. Supports financial planning, regulatory compliance, and rate modeling.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`service`.`conservation_program` (
    `conservation_program_id` BIGINT COMMENT 'Unique identifier for the water conservation program record. Primary key.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Conservation programs are funded by designated utility funds (often rate-funded conservation funds or restricted funds). Essential for budget tracking, expenditure authorization, and regulatory report',
    `grant_id` BIGINT COMMENT 'Foreign key linking to finance.grant. Business justification: Many conservation programs are grant-funded (state/federal water efficiency grants, EPA WaterSense). Grant expenditure tracking required for compliance, drawdown requests, and single audit reporting. ',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Conservation rebate programs (smart irrigation controllers, low-flow fixtures) reference specific approved materials from the material master to determine rebate eligibility. Program administrators an',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: A conservation program is typically associated with a specific service offering (e.g., a rebate program for potable water customers, a tiered pricing incentive for irrigation service). conservation_pr',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Conservation programs are often mandated by regulatory requirements (drought response orders, demand management mandates, water use efficiency standards). Program design, targets, and reporting tied t',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to service.tariff. Business justification: Conservation programs in regulated water utilities are established under tariff filings and require regulatory approval. conservation_program has tariff_reference as a string field that is a denormali',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Conservation programs are often territory-specific with territory-level water savings targets and regulatory mandates. Adding this link enables territory-based program management and reporting.',
    `actual_participant_count` STRING COMMENT 'Current count of customers or accounts enrolled and participating in the conservation program.',
    `actual_water_savings_gallons` BIGINT COMMENT 'Measured or estimated cumulative water savings achieved by the program to date, in gallons.',
    `budget_expended_to_date` DECIMAL(18,2) COMMENT 'Cumulative amount of program budget spent as of the last reporting period, in US dollars.',
    `contact_email` STRING COMMENT 'Primary email address for customer inquiries and program communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for customer inquiries and program support.. Valid values are `^+?[0-9]{10,15}$`',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created the conservation program record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the conservation program record was first created in the system.',
    `customer_class_applicability` STRING COMMENT 'Customer class segments eligible to participate in this conservation program.. Valid values are `residential|commercial|industrial|agricultural|municipal|all`',
    `eligibility_criteria` STRING COMMENT 'Detailed requirements and conditions that customers must meet to participate in the conservation program, including customer class, service type, meter size, and usage thresholds.',
    `enrollment_end_date` DATE COMMENT 'Date when customer enrollment or application for the program closes. Null for open enrollment programs.',
    `enrollment_start_date` DATE COMMENT 'Date when customer enrollment or application for the program opens.',
    `funding_source` STRING COMMENT 'Source of funds supporting the conservation program, such as operating budget, capital improvement program, state grants, or federal funding.',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Fixed monetary value of the incentive provided per qualifying customer or installation, in US dollars.',
    `incentive_type` STRING COMMENT 'Type of financial or non-financial incentive offered to customers participating in the program.. Valid values are `rebate|discount|credit|grant|free_equipment|rate_reduction`',
    `incentive_unit` STRING COMMENT 'Unit of measure for calculating and distributing the incentive to program participants.. Valid values are `per_fixture|per_device|per_audit|per_gallon_saved|per_account|lump_sum`',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified the conservation program record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the conservation program record was last updated.',
    `last_reported_date` DATE COMMENT 'Date of the most recent performance report submitted for this conservation program.',
    `marketing_campaign_code` STRING COMMENT 'Code linking the conservation program to specific marketing and outreach campaigns for tracking effectiveness.',
    `maximum_incentive_per_customer` DECIMAL(18,2) COMMENT 'Cap on the total incentive amount a single customer can receive under this program during the program period, in US dollars.',
    `performance_metric_definition` STRING COMMENT 'Description of the key performance indicators (KPIs) used to measure program success, such as gallons saved per dollar spent or participation rate.',
    `program_category` STRING COMMENT 'Target sector or application area for the conservation program.. Valid values are `indoor|outdoor|commercial|industrial|agricultural|residential`',
    `program_code` STRING COMMENT 'Unique business identifier code for the conservation program, used for external reference and reporting.. Valid values are `^[A-Z0-9]{6,12}$`',
    `program_description` STRING COMMENT 'Detailed description of the conservation program objectives, activities, and benefits to customers and the utility.',
    `program_end_date` DATE COMMENT 'Date when the conservation program concludes and no new participants are accepted. Null for ongoing programs.',
    `program_name` STRING COMMENT 'Full descriptive name of the conservation program as presented to customers and in regulatory filings.',
    `program_notes` STRING COMMENT 'Additional free-text notes, comments, or special instructions related to the conservation program administration and operations.',
    `program_start_date` DATE COMMENT 'Date when the conservation program becomes active and customers can begin participating.',
    `program_status` STRING COMMENT 'Current lifecycle status of the conservation program.. Valid values are `draft|active|suspended|completed|cancelled`',
    `program_type` STRING COMMENT 'Classification of the conservation program by delivery mechanism and approach. [ENUM-REF-CANDIDATE: rebate|tiered_pricing|water_audit|drought_surcharge|education|restriction|incentive — 7 candidates stripped; promote to reference product]',
    `program_website_url` STRING COMMENT 'Web address where customers can find detailed program information, eligibility requirements, and application forms.',
    `regulatory_approval_date` DATE COMMENT 'Date when the conservation program received regulatory approval from the governing authority.',
    `regulatory_approval_number` STRING COMMENT 'Approval or permit number issued by the state Public Utilities Commission or environmental agency authorizing the program.',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Indicates whether the conservation program is required by state or federal regulation (True) or is voluntary (False).',
    `regulatory_mandate_reference` STRING COMMENT 'Citation or reference to the specific regulation, statute, or executive order requiring or authorizing the conservation program.',
    `reporting_frequency` STRING COMMENT 'Frequency at which program performance and results are reported to regulatory agencies and utility management.. Valid values are `monthly|quarterly|annually|on_demand`',
    `target_participant_count` STRING COMMENT 'Goal for the number of customers or accounts participating in the conservation program.',
    `target_water_savings_gallons` BIGINT COMMENT 'Projected total water savings goal for the program over its duration, measured in gallons.',
    `total_program_budget` DECIMAL(18,2) COMMENT 'Total allocated budget for the conservation program over its entire duration, in US dollars.',
    CONSTRAINT pk_conservation_program PRIMARY KEY(`conservation_program_id`)
) COMMENT 'Master catalog of customer programs including water conservation programs (rebates, tiered pricing incentives, water audits, drought surcharges), demand management programs, and customer affordability/assistance programs (lifeline rates, PIPP, bill discounts, emergency assistance). Captures program name, program type, eligibility criteria (including income thresholds for affordability programs), incentive or benefit structure, funding source, program period, target outcomes, enrollment tracking, and regulatory mandate reference. Supports AWWA water efficiency goals, state conservation mandates, and regulatory affordability requirements.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`service`.`affordability_plan` (
    `affordability_plan_id` BIGINT COMMENT 'Unique identifier for the affordability plan. Primary key.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Low-income assistance programs are funded by designated funds (rate-funded assistance funds or restricted funds). Essential for subsidy accounting, budget tracking, and regulatory reporting of afforda',
    `grant_id` BIGINT COMMENT 'Foreign key linking to finance.grant. Business justification: Low-income water assistance affordability plans are frequently funded by federal or state grants (e.g., LIHWAP, EPA environmental justice grants). Tracking which grant funds an affordability plan is r',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Affordability plans in water utilities are mandated by state PUC environmental justice rules or EPA requirements. Linking to regulatory_requirement enables compliance tracking of mandated low-income a',
    `service_class_id` BIGINT COMMENT 'Foreign key linking to service.service_class. Business justification: Affordability plans apply to specific customer service classes. Currently customer_class_applicability is a STRING, but this should be a FK to service_class for referential integrity and to enable cla',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to service.tariff. Business justification: Affordability and low-income assistance plans in regulated water utilities are established through tariff filings with the Public Utilities Commission. affordability_plan has regulatory_approval_numbe',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Affordability and low-income assistance programs can be territory-specific, as different jurisdictions may have different regulatory mandates, funding sources, or eligibility criteria. This FK allows ',
    `application_process_description` STRING COMMENT 'Description of the process customers must follow to apply for enrollment in this affordability plan, including required documentation and submission channels.',
    `auto_enrollment_flag` BOOLEAN COMMENT 'Indicates whether eligible customers are automatically enrolled in this affordability plan based on participation in other assistance programs (e.g., SNAP, Medicaid, LIHEAP). True if auto-enrollment is enabled, false if customers must apply.',
    `contact_email` STRING COMMENT 'Email address customers can use to request information about this affordability plan or submit application inquiries.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Phone number customers can call for information about this affordability plan, application assistance, or enrollment status inquiries.',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user who created this affordability plan record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this affordability plan record was first created in the system.',
    `current_enrollment_count` STRING COMMENT 'Current number of customers actively enrolled in this affordability plan. Updated periodically to reflect enrollment changes.',
    `discount_fixed_amount` DECIMAL(18,2) COMMENT 'Fixed dollar credit amount applied to the customers bill per billing cycle when the discount type is fixed amount. Null if discount type is not fixed amount.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the customers water and/or wastewater bill when the discount type is percentage-based. Null if discount type is not percentage.',
    `discount_type` STRING COMMENT 'The mechanism by which the affordability benefit is applied: percentage (percent off total bill), fixed amount (dollar credit per billing cycle), rate reduction (lower volumetric or base rate), bill cap (maximum bill amount), or usage credit (free gallons or cubic meters).. Valid values are `percentage|fixed_amount|rate_reduction|bill_cap|usage_credit`',
    `effective_end_date` DATE COMMENT 'Date on which this affordability plan expires or is discontinued. Null if the plan has no scheduled end date.',
    `effective_start_date` DATE COMMENT 'Date on which this affordability plan becomes active and available for customer enrollment.',
    `eligibility_income_threshold_amount` DECIMAL(18,2) COMMENT 'Maximum annual household income amount (in local currency) that qualifies a customer for enrollment in this affordability plan. Typically expressed as a percentage of Federal Poverty Level (FPL) or Area Median Income (AMI).',
    `eligibility_income_threshold_basis` STRING COMMENT 'The reference standard used to determine income eligibility: federal poverty level (FPL percentage), area median income (AMI percentage), state median income (SMI percentage), or fixed amount (absolute dollar threshold).. Valid values are `federal_poverty_level|area_median_income|state_median_income|fixed_amount`',
    `eligibility_income_threshold_percent` DECIMAL(18,2) COMMENT 'Percentage of the income threshold basis (e.g., 150% of FPL, 80% of AMI) used to determine customer eligibility for the affordability plan.',
    `enrollment_capacity` STRING COMMENT 'Maximum number of customers who can be enrolled in this affordability plan at any given time. Null if no enrollment cap applies.',
    `funding_source` STRING COMMENT 'Primary source of funding for the affordability plan: utility revenue (general operating funds), rate surcharge (dedicated customer charge), municipal subsidy (city/county budget), state grant, federal grant, private donation, or cross subsidy (higher-income customer rates). [ENUM-REF-CANDIDATE: utility_revenue|rate_surcharge|municipal_subsidy|state_grant|federal_grant|private_donation|cross_subsidy — 7 candidates stripped; promote to reference product]',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this affordability plan record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this affordability plan record was last updated in the system.',
    `maximum_benefit_amount` DECIMAL(18,2) COMMENT 'Maximum total dollar benefit a customer can receive per billing cycle or per enrollment period under this affordability plan. Null if no cap applies.',
    `maximum_benefit_duration_months` STRING COMMENT 'Maximum number of months a customer can remain enrolled in this affordability plan before re-certification or plan expiration. Null if no duration limit applies.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this affordability plan, including program changes, temporary modifications, or administrative remarks.',
    `partner_program_name` STRING COMMENT 'Name of external assistance program(s) used for auto-enrollment eligibility verification (e.g., SNAP, Medicaid, LIHEAP, TANF). Null if auto-enrollment is not enabled.',
    `plan_code` STRING COMMENT 'Unique business identifier code for the affordability plan, used for external reference and reporting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `plan_description` STRING COMMENT 'Detailed description of the affordability plan, including objectives, benefits, and terms of assistance provided to eligible customers.',
    `plan_name` STRING COMMENT 'Full descriptive name of the affordability plan (e.g., Lifeline Rate Program, Low-Income Assistance Plan, Percentage of Income Payment Plan).',
    `plan_status` STRING COMMENT 'Current lifecycle status of the affordability plan: active (accepting enrollments), inactive (not currently offered), suspended (temporarily paused), pending approval (awaiting regulatory approval), expired (past end date), or discontinued (permanently retired).. Valid values are `active|inactive|suspended|pending_approval|expired|discontinued`',
    `plan_type` STRING COMMENT 'Classification of the affordability plan structure: lifeline rate (reduced base rate), percentage of income (PIPP - bill capped at income percentage), fixed discount (flat dollar or percentage reduction), tiered discount (graduated by income level), emergency assistance (one-time aid), or crisis voucher (short-term relief).. Valid values are `lifeline_rate|percentage_of_income|fixed_discount|tiered_discount|emergency_assistance|crisis_voucher`',
    `program_website_url` STRING COMMENT 'Web address where customers can find detailed information about this affordability plan, download application forms, and access eligibility guidelines.',
    `recertification_frequency_months` STRING COMMENT 'Number of months between required recertification events for customers enrolled in this affordability plan. Null if recertification is not required.',
    `recertification_required_flag` BOOLEAN COMMENT 'Indicates whether customers must periodically recertify their eligibility to continue receiving benefits under this affordability plan. True if recertification is required, false otherwise.',
    `regulatory_approval_date` DATE COMMENT 'Date on which the regulatory authority approved this affordability plan for implementation. Null if not applicable.',
    `regulatory_approval_number` STRING COMMENT 'Official approval or docket number issued by the regulatory authority authorizing this affordability plan. Null if not applicable.',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Indicates whether this affordability plan is mandated by state or local regulation, or is a voluntary utility program. True if mandated, false if voluntary.',
    `required_documentation` STRING COMMENT 'List of documents customers must provide to verify eligibility for this affordability plan (e.g., proof of income, tax returns, benefit award letters, utility bills).',
    `service_type_applicability` STRING COMMENT 'Specifies which utility services are covered by this affordability plan: water only, wastewater only, water and wastewater combined, stormwater, or all services.. Valid values are `water_only|wastewater_only|water_and_wastewater|stormwater|all_services`',
    `waitlist_enabled_flag` BOOLEAN COMMENT 'Indicates whether a waitlist is maintained for customers when enrollment capacity is reached. True if waitlist is enabled, false otherwise.',
    CONSTRAINT pk_affordability_plan PRIMARY KEY(`affordability_plan_id`)
) COMMENT 'Defines the low-income customer assistance and affordability programs available, including lifeline rates, percentage-of-income payment plans (PIPP), bill discount programs, and emergency assistance funds. Captures plan name, eligibility income thresholds, discount percentage or fixed credit amount, maximum benefit duration, funding source, regulatory mandate, and enrollment capacity. Supports equitable access to essential water services and regulatory affordability requirements.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`service`.`program_enrollment` (
    `program_enrollment_id` BIGINT COMMENT 'Primary key for the program_enrollment association',
    `agreement_id` BIGINT COMMENT 'Foreign key linking this enrollment record to the specific service agreement (customer account + service location) participating in the program.',
    `conservation_program_id` BIGINT COMMENT 'Foreign key linking this enrollment record to the specific conservation or assistance program the agreement is enrolled in.',
    `certification_date` DATE COMMENT 'Date on which the customers eligibility for this program was certified or verified (e.g., income verification for affordability programs, device installation confirmation for rebate programs). Sourced from detection phase relationship_data.',
    `enrollment_date` DATE COMMENT 'Date on which the service agreement was officially enrolled or approved into the conservation program. Sourced from detection phase relationship_data. Cannot reside on agreement (one per program) or on conservation_program (one per customer).',
    `expiration_date` DATE COMMENT 'Date on which this specific enrollment expires and must be renewed or will automatically terminate. Distinct from the programs overall program_end_date — a customers enrollment may expire before the program ends. Sourced from detection phase relationship_data.',
    `incentive_amount_applied` DECIMAL(18,2) COMMENT 'Actual monetary incentive amount applied or credited to this specific agreement under this enrollment. May differ from the programs standard incentive_amount due to customer-specific calculations or caps. Sourced from detection phase relationship_data.',
    `program_enrollment_status` STRING COMMENT 'Current lifecycle status of this specific enrollment. Tracks the progression from application through active participation to expiration or withdrawal. Sourced from detection phase relationship_data (enrollment_status).',
    CONSTRAINT pk_program_enrollment PRIMARY KEY(`program_enrollment_id`)
) COMMENT 'This association product represents the Enrollment event between a service agreement and a conservation program. It captures the full lifecycle of a customer accounts participation in a specific conservation, demand-management, or affordability program — from application through approval, active participation, and expiration or withdrawal. Each record links one service agreement to one conservation program and carries enrollment-specific attributes (dates, status, incentive applied, certification) that exist only in the context of this pairing and cannot reside on either parent entity.. Existence Justification: In water utilities, customers (via their service agreements) actively enroll in conservation programs — rebates, audits, tiered pricing incentives, affordability assistance — and a single agreement can be enrolled in multiple programs simultaneously (e.g., a low-income customer on a lifeline rate AND a rebate program). Conversely, each conservation program tracks thousands of enrolled agreements. The business actively manages these enrollments through a defined lifecycle (application → approval → active → expired/withdrawn) with enrollment-specific data that belongs to neither the agreement nor the program alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ADD CONSTRAINT `fk_service_offering_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `water_utilities_ecm`.`service`.`tariff`(`tariff_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ADD CONSTRAINT `fk_service_offering_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `water_utilities_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `water_utilities_ecm`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `water_utilities_ecm`.`service`.`tariff`(`tariff_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_affordability_plan_id` FOREIGN KEY (`affordability_plan_id`) REFERENCES `water_utilities_ecm`.`service`.`affordability_plan`(`affordability_plan_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `water_utilities_ecm`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `water_utilities_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_service_rate_schedule_id` FOREIGN KEY (`service_rate_schedule_id`) REFERENCES `water_utilities_ecm`.`service`.`service_rate_schedule`(`service_rate_schedule_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `water_utilities_ecm`.`service`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `water_utilities_ecm`.`service`.`tariff`(`tariff_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`point` ADD CONSTRAINT `fk_service_point_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `water_utilities_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`point` ADD CONSTRAINT `fk_service_point_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `water_utilities_ecm`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`point` ADD CONSTRAINT `fk_service_point_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `water_utilities_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `water_utilities_ecm`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `water_utilities_ecm`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_connection_application_id` FOREIGN KEY (`connection_application_id`) REFERENCES `water_utilities_ecm`.`service`.`connection_application`(`connection_application_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `water_utilities_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `water_utilities_ecm`.`service`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ADD CONSTRAINT `fk_service_sla_definition_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `water_utilities_ecm`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ADD CONSTRAINT `fk_service_sla_definition_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `water_utilities_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ADD CONSTRAINT `fk_service_sla_definition_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `water_utilities_ecm`.`service`.`tariff`(`tariff_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ADD CONSTRAINT `fk_service_sla_definition_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ADD CONSTRAINT `fk_service_tariff_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `water_utilities_ecm`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ADD CONSTRAINT `fk_service_tariff_superseded_tariff_id` FOREIGN KEY (`superseded_tariff_id`) REFERENCES `water_utilities_ecm`.`service`.`tariff`(`tariff_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ADD CONSTRAINT `fk_service_tariff_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ADD CONSTRAINT `fk_service_conservation_program_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `water_utilities_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ADD CONSTRAINT `fk_service_conservation_program_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `water_utilities_ecm`.`service`.`tariff`(`tariff_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ADD CONSTRAINT `fk_service_conservation_program_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ADD CONSTRAINT `fk_service_affordability_plan_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `water_utilities_ecm`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ADD CONSTRAINT `fk_service_affordability_plan_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `water_utilities_ecm`.`service`.`tariff`(`tariff_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ADD CONSTRAINT `fk_service_affordability_plan_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`program_enrollment` ADD CONSTRAINT `fk_service_program_enrollment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `water_utilities_ecm`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`program_enrollment` ADD CONSTRAINT `fk_service_program_enrollment_conservation_program_id` FOREIGN KEY (`conservation_program_id`) REFERENCES `water_utilities_ecm`.`service`.`conservation_program`(`conservation_program_id`);

-- ========= TAGS =========
ALTER SCHEMA `water_utilities_ecm`.`service` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `water_utilities_ecm`.`service` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` SET TAGS ('dbx_subdomain' = 'service_catalog');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Permit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `ami_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Enabled Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `backflow_prevention_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Backflow Prevention Required Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `base_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Rate Amount');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `billing_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Code');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `billing_cycle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `capacity_charge` SET TAGS ('dbx_business_glossary_term' = 'Capacity Charge');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `connection_fee` SET TAGS ('dbx_business_glossary_term' = 'Connection Fee');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `conservation_program_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Conservation Program Eligible Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term in Months');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `customer_class` SET TAGS ('dbx_business_glossary_term' = 'Customer Class');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `customer_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|agricultural|institutional');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Delivery Mode');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_value_regex' = 'metered|unmetered|flat_rate|seasonal|temporary|emergency');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Amount');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `deposit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Deposit Required Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `fire_protection_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Fire Protection Service Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `flow_capacity_gpm` SET TAGS ('dbx_business_glossary_term' = 'Flow Capacity in Gallons per Minute (GPM)');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `late_payment_penalty_percent` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Penalty Percentage');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|suspended|retired|grandfathered');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `meter_size_required_inches` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Required in Inches');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `minimum_monthly_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Monthly Charge');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `offering_code` SET TAGS ('dbx_business_glossary_term' = 'Offering Code');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `offering_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `offering_description` SET TAGS ('dbx_business_glossary_term' = 'Offering Description');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `offering_name` SET TAGS ('dbx_business_glossary_term' = 'Offering Name');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `pressure_range_psi_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Pressure Range in Pounds per Square Inch (PSI)');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `pressure_range_psi_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Pressure Range in Pounds per Square Inch (PSI)');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `rate_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Structure Type');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `rate_structure_type` SET TAGS ('dbx_value_regex' = 'uniform|tiered|seasonal|time_of_use|demand_based');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'potable_water|wastewater_collection|recycled_water|fire_protection|bulk_water|stormwater');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time in Hours');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `sla_restoration_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Restoration Time in Hours');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period in Days');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `volumetric_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Volumetric Rate Amount');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `volumetric_rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Volumetric Rate Unit of Measure (UOM)');
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ALTER COLUMN `volumetric_rate_unit` SET TAGS ('dbx_value_regex' = 'kgal|ccf|gallon|cubic_meter|acre_foot');
ALTER TABLE `water_utilities_ecm`.`service`.`service_rate_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `water_utilities_ecm`.`service`.`service_rate_schedule` SET TAGS ('dbx_subdomain' = 'tariff_pricing');
ALTER TABLE `water_utilities_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `service_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for service_rate_schedule');
ALTER TABLE `water_utilities_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Class Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`service_rate_schedule` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` SET TAGS ('dbx_subdomain' = 'service_catalog');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `water_source_id` SET TAGS ('dbx_business_glossary_term' = 'Water Source Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `area_square_miles` SET TAGS ('dbx_business_glossary_term' = 'Area in Square Miles');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `average_daily_demand_mgd` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Demand in Million Gallons per Day (MGD)');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `boundary_description` SET TAGS ('dbx_business_glossary_term' = 'Boundary Description');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `commercial_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Commercial Customer Count');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `county_name` SET TAGS ('dbx_business_glossary_term' = 'County Name');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `customer_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Count');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `franchise_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Number');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `franchise_agreement_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `franchise_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Franchise Expiration Date');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `gis_boundary_reference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Boundary Reference');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `industrial_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Industrial Customer Count');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Territory Notes');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `npdes_permit_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Permit Jurisdiction');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `peak_daily_demand_mgd` SET TAGS ('dbx_business_glossary_term' = 'Peak Daily Demand in Million Gallons per Day (MGD)');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `population_served` SET TAGS ('dbx_business_glossary_term' = 'Population Served');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `potable_water_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Potable Water Service Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `predecessor_utility_name` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Utility Name');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `rate_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Zone Code');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `recycled_water_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Recycled Water Service Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `residential_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Residential Customer Count');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `service_center_location` SET TAGS ('dbx_business_glossary_term' = 'Service Center Location');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `service_classification` SET TAGS ('dbx_business_glossary_term' = 'Service Classification');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `service_classification` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural|mixed');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `stormwater_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Stormwater Service Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `tariff_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'Tariff Schedule Reference');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Status');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|retired|transferred');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Type');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_value_regex' = 'franchise|certificated|contract|wholesale|retail|combined');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ALTER COLUMN `wastewater_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Wastewater Service Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` SET TAGS ('dbx_subdomain' = 'service_catalog');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Service Class Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `average_monthly_consumption_gallons` SET TAGS ('dbx_business_glossary_term' = 'Average Monthly Consumption in Gallons');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `awwa_classification_code` SET TAGS ('dbx_business_glossary_term' = 'American Water Works Association (AWWA) Classification Code');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `backflow_prevention_required` SET TAGS ('dbx_business_glossary_term' = 'Backflow Prevention Required Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `billing_cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Type');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `billing_cycle_type` SET TAGS ('dbx_value_regex' = 'monthly|bimonthly|quarterly|annual|on_demand');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `class_code` SET TAGS ('dbx_business_glossary_term' = 'Service Class Code');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `class_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `class_description` SET TAGS ('dbx_business_glossary_term' = 'Service Class Description');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `class_name` SET TAGS ('dbx_business_glossary_term' = 'Service Class Name');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `class_type` SET TAGS ('dbx_business_glossary_term' = 'Service Class Type');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `conservation_program_eligible` SET TAGS ('dbx_business_glossary_term' = 'Conservation Program Eligible Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `consumption_tier_structure` SET TAGS ('dbx_business_glossary_term' = 'Consumption Tier Structure');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `consumption_tier_structure` SET TAGS ('dbx_value_regex' = 'flat|tiered|seasonal|time_of_use');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term in Months');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `deposit_requirement_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Requirement Amount');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `disconnection_policy` SET TAGS ('dbx_business_glossary_term' = 'Disconnection Policy');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `disconnection_policy` SET TAGS ('dbx_value_regex' = 'standard|protected|restricted');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `drought_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Drought Surcharge Applicable Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `fire_flow_requirement_gpm` SET TAGS ('dbx_business_glossary_term' = 'Fire Flow Requirement in Gallons Per Minute (GPM)');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `late_payment_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Penalty Rate');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `meter_size_range` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Range');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `minimum_charge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Applicable Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Service Class Notes');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `peak_demand_factor` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand Factor');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `pressure_requirement_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure Requirement in Pounds per Square Inch (PSI)');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `puc_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Public Utilities Commission (PUC) Approval Date');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `puc_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Public Utilities Commission (PUC) Filing Reference');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `rate_schedule_group` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Group');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `regulatory_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Category');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `renewal_notification_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notification Days');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `seasonal_rate_applicable` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Rate Applicable Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `service_class_status` SET TAGS ('dbx_business_glossary_term' = 'Service Class Status');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `service_class_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|deprecated|suspended');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `service_level_agreement_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `service_level_agreement_tier` SET TAGS ('dbx_value_regex' = 'standard|priority|premium|critical');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `tariff_classification` SET TAGS ('dbx_business_glossary_term' = 'Tariff Classification');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `water_quality_monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Monitoring Frequency');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `water_quality_monitoring_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|as_needed');
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` SET TAGS ('dbx_subdomain' = 'customer_agreements');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `affordability_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Affordability Plan Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Service Class Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `service_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Service Rate Schedule Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Definition Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wtp Facility Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Number');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^SA-[0-9]{8,12}$');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Status');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|terminated|cancelled');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `auto_pay_enabled` SET TAGS ('dbx_business_glossary_term' = 'Automatic Payment Enabled Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `auto_renewal_enabled` SET TAGS ('dbx_business_glossary_term' = 'Automatic Renewal Enabled Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `backflow_prevention_required` SET TAGS ('dbx_business_glossary_term' = 'Backflow Prevention Required Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `billing_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Code');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `billing_cycle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `budget_billing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Budget Billing Enabled Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term in Months');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `deposit_status` SET TAGS ('dbx_business_glossary_term' = 'Deposit Status');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `deposit_status` SET TAGS ('dbx_value_regex' = 'required|held|waived|refunded|forfeited');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement End Date');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `fire_protection_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Fire Protection Service Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `industrial_user_permit_required` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit (IUP) Required Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `irrigation_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Irrigation Service Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `low_income_assistance_eligible` SET TAGS ('dbx_business_glossary_term' = 'Low Income Assistance Eligible Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `minimum_usage_commitment_gallons` SET TAGS ('dbx_business_glossary_term' = 'Minimum Usage Commitment in Gallons');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `paperless_billing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Paperless Billing Enabled Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `senior_citizen_discount_eligible` SET TAGS ('dbx_business_glossary_term' = 'Senior Citizen Discount Eligible Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time in Hours');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `sla_restoration_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Restoration Time in Hours');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'CCB|CIS|ERP|LEGACY');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Conditions and Terms');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Start Date');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `water_utilities_ecm`.`service`.`point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`service`.`point` SET TAGS ('dbx_subdomain' = 'service_catalog');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Service Class Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `water_source_id` SET TAGS ('dbx_business_glossary_term' = 'Water Source Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wtp Facility Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `ami_enabled` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Enabled');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `backflow_device_type` SET TAGS ('dbx_business_glossary_term' = 'Backflow Device Type');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `backflow_device_type` SET TAGS ('dbx_value_regex' = 'rpz|dcva|pvb|ag|none|unknown');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `backflow_prevention_required` SET TAGS ('dbx_business_glossary_term' = 'Backflow Prevention Required');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `connection_material` SET TAGS ('dbx_business_glossary_term' = 'Connection Material');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `connection_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Connection Size (Inches)');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `curb_stop_location` SET TAGS ('dbx_business_glossary_term' = 'Curb Stop Location');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `disconnection_date` SET TAGS ('dbx_business_glossary_term' = 'Disconnection Date');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `elevation_feet` SET TAGS ('dbx_business_glossary_term' = 'Elevation (Feet)');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `estimated_daily_demand_gallons` SET TAGS ('dbx_business_glossary_term' = 'Estimated Daily Demand (Gallons)');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `fire_service_indicator` SET TAGS ('dbx_business_glossary_term' = 'Fire Service Indicator');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'utility_owned|customer_owned|shared|unknown');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `peak_demand_gpm` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand (Gallons Per Minute - GPM)');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Route Code');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 1');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 2');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_city` SET TAGS ('dbx_business_glossary_term' = 'Service City');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_country_code` SET TAGS ('dbx_business_glossary_term' = 'Service Country Code');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_point_description` SET TAGS ('dbx_business_glossary_term' = 'Service Point Description');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_point_number` SET TAGS ('dbx_business_glossary_term' = 'Service Point Number');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_point_number` SET TAGS ('dbx_value_regex' = '^SP[0-9]{8,12}$');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_point_status` SET TAGS ('dbx_business_glossary_term' = 'Service Point Status');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_point_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_activation|disconnected|abandoned');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Service Postal Code');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_state` SET TAGS ('dbx_business_glossary_term' = 'Service State');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `water_utilities_ecm`.`service`.`point` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'potable_water|wastewater|recycled_water|stormwater|combined');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` SET TAGS ('dbx_subdomain' = 'customer_agreements');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `connection_application_id` SET TAGS ('dbx_business_glossary_term' = 'Connection Application ID');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Warehouse Location Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `meter_size_type_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Size Type Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Point Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Service Class Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `ami_enabled` SET TAGS ('dbx_business_glossary_term' = 'AMI (Advanced Metering Infrastructure) Enabled');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `applicant_email` SET TAGS ('dbx_business_glossary_term' = 'Applicant Email Address');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `applicant_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `applicant_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `applicant_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `applicant_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Name');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `applicant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `applicant_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `applicant_phone` SET TAGS ('dbx_business_glossary_term' = 'Applicant Phone Number');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `applicant_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `applicant_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `applicant_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `application_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Application Fee Amount');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `application_number` SET TAGS ('dbx_value_regex' = '^CA-[0-9]{8}$');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `application_type` SET TAGS ('dbx_business_glossary_term' = 'Application Type');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `application_type` SET TAGS ('dbx_value_regex' = 'new_connection|service_upgrade|disconnection|transfer|reconnection|temporary_service');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `capacity_available` SET TAGS ('dbx_business_glossary_term' = 'Capacity Available');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `capacity_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Capacity Charge Amount');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `connection_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Connection Fee Amount');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `connection_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Connection Size (Inches)');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `estimated_flow_demand_gpm` SET TAGS ('dbx_business_glossary_term' = 'Estimated Flow Demand (GPM - Gallons per Minute)');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `infrastructure_upgrade_required` SET TAGS ('dbx_business_glossary_term' = 'Infrastructure Upgrade Required');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `meter_type_requested` SET TAGS ('dbx_business_glossary_term' = 'Meter Type Requested');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Application Notes');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `number_of_units` SET TAGS ('dbx_business_glossary_term' = 'Number of Units');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|partial|paid|waived|refunded');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `property_type` SET TAGS ('dbx_business_glossary_term' = 'Property Type');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `property_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|institutional|agricultural|mixed_use');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `requested_service_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Service Date');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 1');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 2');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `service_city` SET TAGS ('dbx_business_glossary_term' = 'Service City');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `service_latitude` SET TAGS ('dbx_business_glossary_term' = 'Service Latitude');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `service_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `service_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `service_longitude` SET TAGS ('dbx_business_glossary_term' = 'Service Longitude');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `service_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `service_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Service Postal Code');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `service_state` SET TAGS ('dbx_business_glossary_term' = 'Service State');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `service_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `technical_review_date` SET TAGS ('dbx_business_glossary_term' = 'Technical Review Date');
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ALTER COLUMN `total_fees_assessed` SET TAGS ('dbx_business_glossary_term' = 'Total Fees Assessed');
ALTER TABLE `water_utilities_ecm`.`service`.`order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`service`.`order` SET TAGS ('dbx_subdomain' = 'customer_agreements');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Service Order Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `connection_application_id` SET TAGS ('dbx_business_glossary_term' = 'Connection Application Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `main_break_id` SET TAGS ('dbx_business_glossary_term' = 'Main Break Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `order_customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Old Meter Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `order_new_meter_metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'New Meter Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Definition Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wtp Facility Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `appointment_window_end` SET TAGS ('dbx_business_glossary_term' = 'Appointment Window End Time');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `appointment_window_start` SET TAGS ('dbx_business_glossary_term' = 'Appointment Window Start Time');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Service Order Completion Date');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Name');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Phone Number');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Latitude');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Longitude');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `meter_reading_unit` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Unit of Measure');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `meter_reading_unit` SET TAGS ('dbx_value_regex' = 'gallons|cubic_meters|cubic_feet|liters');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `meter_reading_value` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Value');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Service Order Number');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^SO-[0-9]{8}$');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Service Order Status');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Service Order Type');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `outcome_code` SET TAGS ('dbx_business_glossary_term' = 'Service Order Outcome Code');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `outcome_code` SET TAGS ('dbx_value_regex' = 'completed_as_planned|partial_completion|unable_to_complete|customer_not_available|access_denied|equipment_failure');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Service Order Priority');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'emergency|urgent|standard|low');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Service Date');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Service Date');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `service_address` SET TAGS ('dbx_business_glossary_term' = 'Service Address');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `service_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `service_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `service_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Service Fee Amount');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `sla_actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual Hours');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `water_utilities_ecm`.`service`.`order` ALTER COLUMN `work_performed_description` SET TAGS ('dbx_business_glossary_term' = 'Work Performed Description');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` SET TAGS ('dbx_subdomain' = 'tariff_pricing');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Definition Identifier');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Schedule Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Service Class Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Identifier');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `compliance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Compliance Percentage');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `escalation_procedure` SET TAGS ('dbx_business_glossary_term' = 'Escalation Procedure');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `exclusion_conditions` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Conditions');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'system_wide|district|zone|dma|specific_location');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `maximum_value` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Maximum Value');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Metric Name');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `minimum_value` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Minimum Value');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `notification_requirement` SET TAGS ('dbx_business_glossary_term' = 'Notification Requirement');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `notification_requirement` SET TAGS ('dbx_value_regex' = 'immediate|within_24_hours|within_48_hours|within_7_days|monthly|none');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `penalty_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Penalty Calculation Method');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `penalty_calculation_method` SET TAGS ('dbx_value_regex' = 'fixed|per_occurrence|per_hour|per_day|percentage_of_bill|tiered');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `penalty_type` SET TAGS ('dbx_business_glossary_term' = 'Penalty Type');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `penalty_type` SET TAGS ('dbx_value_regex' = 'credit|rebate|fine|none|escalation');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `reporting_requirement` SET TAGS ('dbx_business_glossary_term' = 'Reporting Requirement');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `reporting_requirement` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|event_based|none');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `sla_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Code');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `sla_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `sla_definition_description` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Description');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `sla_definition_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Status');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `sla_definition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|superseded|suspended');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `sla_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Name');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `sla_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Type');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `sla_type` SET TAGS ('dbx_value_regex' = 'response_time|restoration_time|water_quality|pressure_guarantee|notification|availability');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Value');
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` SET TAGS ('dbx_subdomain' = 'tariff_pricing');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Identifier');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Schedule Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Service Class Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `superseded_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Tariff Identifier');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `adjustment_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Clause Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `approval_order_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Order Number');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `base_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Rate Amount');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|bimonthly|quarterly|annual');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `conservation_rate_flag` SET TAGS ('dbx_business_glossary_term' = 'Conservation Rate Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `cost_of_service_study_reference` SET TAGS ('dbx_business_glossary_term' = 'Cost of Service Study Reference');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Tariff Document Uniform Resource Locator (URL)');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `hearing_date` SET TAGS ('dbx_business_glossary_term' = 'Hearing Date');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `low_income_assistance_flag` SET TAGS ('dbx_business_glossary_term' = 'Low Income Assistance Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `minimum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `public_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Date');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `rate_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Base Amount');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `rate_base_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `rate_of_return_percent` SET TAGS ('dbx_business_glossary_term' = 'Rate of Return Percentage');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `rate_of_return_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `rate_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Reference');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `rate_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Structure Type');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `rate_structure_type` SET TAGS ('dbx_value_regex' = 'flat|uniform|declining_block|increasing_block|seasonal|time_of_use');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `revenue_requirement_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Requirement Amount');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `revenue_requirement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `service_rules_reference` SET TAGS ('dbx_business_glossary_term' = 'Service Rules Reference');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `tariff_description` SET TAGS ('dbx_business_glossary_term' = 'Tariff Description');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `tariff_name` SET TAGS ('dbx_business_glossary_term' = 'Tariff Name');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `tariff_number` SET TAGS ('dbx_business_glossary_term' = 'Tariff Number');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `tariff_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,20}$');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `tariff_status` SET TAGS ('dbx_business_glossary_term' = 'Tariff Status');
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ALTER COLUMN `tariff_type` SET TAGS ('dbx_business_glossary_term' = 'Tariff Type');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` SET TAGS ('dbx_subdomain' = 'customer_agreements');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `conservation_program_id` SET TAGS ('dbx_business_glossary_term' = 'Conservation Program Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `actual_participant_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Participant Count');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `actual_water_savings_gallons` SET TAGS ('dbx_business_glossary_term' = 'Actual Water Savings (Gallons)');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `budget_expended_to_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Expended To Date');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `customer_class_applicability` SET TAGS ('dbx_business_glossary_term' = 'Customer Class Applicability');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `customer_class_applicability` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|agricultural|municipal|all');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment End Date');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Start Date');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `incentive_type` SET TAGS ('dbx_business_glossary_term' = 'Incentive Type');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `incentive_type` SET TAGS ('dbx_value_regex' = 'rebate|discount|credit|grant|free_equipment|rate_reduction');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `incentive_unit` SET TAGS ('dbx_business_glossary_term' = 'Incentive Unit');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `incentive_unit` SET TAGS ('dbx_value_regex' = 'per_fixture|per_device|per_audit|per_gallon_saved|per_account|lump_sum');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `last_reported_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reported Date');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `marketing_campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign Code');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `maximum_incentive_per_customer` SET TAGS ('dbx_business_glossary_term' = 'Maximum Incentive Per Customer');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `performance_metric_definition` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric Definition');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Program Category');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `program_category` SET TAGS ('dbx_value_regex' = 'indoor|outdoor|commercial|industrial|agricultural|residential');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `program_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `program_notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `program_start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|completed|cancelled');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `program_website_url` SET TAGS ('dbx_business_glossary_term' = 'Program Website Uniform Resource Locator (URL)');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Number');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `regulatory_mandate_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Reference');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|on_demand');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `target_participant_count` SET TAGS ('dbx_business_glossary_term' = 'Target Participant Count');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `target_water_savings_gallons` SET TAGS ('dbx_business_glossary_term' = 'Target Water Savings (Gallons)');
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ALTER COLUMN `total_program_budget` SET TAGS ('dbx_business_glossary_term' = 'Total Program Budget');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` SET TAGS ('dbx_subdomain' = 'tariff_pricing');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `affordability_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Affordability Plan Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `service_class_id` SET TAGS ('dbx_business_glossary_term' = 'Service Class Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `application_process_description` SET TAGS ('dbx_business_glossary_term' = 'Application Process Description');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `auto_enrollment_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Enrollment Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `current_enrollment_count` SET TAGS ('dbx_business_glossary_term' = 'Current Enrollment Count');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `discount_fixed_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Fixed Amount');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|rate_reduction|bill_cap|usage_credit');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `eligibility_income_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Income Threshold Amount');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `eligibility_income_threshold_basis` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Income Threshold Basis');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `eligibility_income_threshold_basis` SET TAGS ('dbx_value_regex' = 'federal_poverty_level|area_median_income|state_median_income|fixed_amount');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `eligibility_income_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Income Threshold Percentage');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `enrollment_capacity` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Capacity');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `maximum_benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Benefit Amount');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `maximum_benefit_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Maximum Benefit Duration in Months');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `partner_program_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Program Name');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Plan Description');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|expired|discontinued');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'lifeline_rate|percentage_of_income|fixed_discount|tiered_discount|emergency_assistance|crisis_voucher');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `program_website_url` SET TAGS ('dbx_business_glossary_term' = 'Program Website Uniform Resource Locator (URL)');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `recertification_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Recertification Frequency in Months');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `recertification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Number');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `required_documentation` SET TAGS ('dbx_business_glossary_term' = 'Required Documentation');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `service_type_applicability` SET TAGS ('dbx_business_glossary_term' = 'Service Type Applicability');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `service_type_applicability` SET TAGS ('dbx_value_regex' = 'water_only|wastewater_only|water_and_wastewater|stormwater|all_services');
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ALTER COLUMN `waitlist_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Enabled Flag');
ALTER TABLE `water_utilities_ecm`.`service`.`program_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `water_utilities_ecm`.`service`.`program_enrollment` SET TAGS ('dbx_subdomain' = 'customer_agreements');
ALTER TABLE `water_utilities_ecm`.`service`.`program_enrollment` SET TAGS ('dbx_association_edges' = 'service.agreement,service.conservation_program');
ALTER TABLE `water_utilities_ecm`.`service`.`program_enrollment` ALTER COLUMN `program_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment - Program Enrollment Id');
ALTER TABLE `water_utilities_ecm`.`service`.`program_enrollment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment - Agreement Id');
ALTER TABLE `water_utilities_ecm`.`service`.`program_enrollment` ALTER COLUMN `conservation_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment - Conservation Program Id');
ALTER TABLE `water_utilities_ecm`.`service`.`program_enrollment` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `water_utilities_ecm`.`service`.`program_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `water_utilities_ecm`.`service`.`program_enrollment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Expiration Date');
ALTER TABLE `water_utilities_ecm`.`service`.`program_enrollment` ALTER COLUMN `incentive_amount_applied` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount Applied');
ALTER TABLE `water_utilities_ecm`.`service`.`program_enrollment` ALTER COLUMN `program_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
