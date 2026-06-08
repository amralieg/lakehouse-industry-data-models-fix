-- Schema for Domain: billing | Business: Energy Utilities | Version: v1_mvm
-- Generated on: 2026-05-05 00:40:02

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `energy_utilities_ecm`.`billing` COMMENT 'SSOT for all revenue cycle data — rate schedules, tariff structures, invoice generation, payment processing, collections, dunning, payment arrangements, deposit management, and revenue recognition. Manages TOU, CPP, and tiered rate calculations, budget billing plans, and financial adjustments within SAP IS-U FICA and Oracle CC&B. Owns accounts receivable ledger entries, write-offs, and dispute resolution supporting SOX financial controls.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` (
    `rate_schedule_id` BIGINT COMMENT 'Unique identifier for the rate schedule. Primary key for the rate schedule master reference entity.',
    `control_area_id` BIGINT COMMENT 'Foreign key linking to grid.control_area. Business justification: Rate schedules are filed within and governed by a specific NERC balancing authority / control area (e.g., PJM, MISO, CAISO). Regulatory tariff filings, LMP-based rate design, and capacity charge appli',
    `load_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.load_zone. Business justification: TOU, interruptible-service, and demand-response rate schedules are defined for specific distribution load zones. Tariff design and regulatory rate-case filings require linking a rate schedule to the l',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Rate schedules are created to satisfy specific regulatory obligations (net metering mandates, low-income tariff requirements, renewable energy tariff obligations). Utility regulatory affairs teams mus',
    `planning_period_id` BIGINT COMMENT 'Foreign key linking to forecast.planning_period. Business justification: Rate case regulatory filings: rate schedules are approved for specific IRP planning periods. Regulators require utilities to align rate effective dates with planning horizons. Linking rate_schedule to',
    `rate_case_id` BIGINT COMMENT 'Foreign key linking to compliance.rate_case. Business justification: Rate schedules in billing are approved through regulatory rate case proceedings tracked in compliance. This is a fundamental regulatory relationship in utility operations - every tariff/rate schedule ',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to distribution.service_territory. Business justification: Rate schedules are approved by regulatory jurisdiction tied to service territory. Required for tariff management, rate case filings, and ensuring customers are billed under correct jurisdictional rate',
    `billing_cycle_type` STRING COMMENT 'Standard billing frequency applicable to customers on this rate schedule.. Valid values are `monthly|bimonthly|quarterly|annual|on_demand`',
    `budget_billing_eligible` BOOLEAN COMMENT 'Indicates whether customers on this rate schedule are eligible for budget billing or levelized payment plans.',
    `created_by_user` STRING COMMENT 'User ID or system identifier of the person or process that created this rate schedule record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate schedule record was first created in the billing system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this rate schedule.. Valid values are `^[A-Z]{3}$`',
    `customer_charge_amount` DECIMAL(18,2) COMMENT 'Fixed monthly customer charge in dollars applicable under this rate schedule. Covers meter reading, billing, and basic service costs.',
    `demand_charge_rate` DECIMAL(18,2) COMMENT 'Demand charge rate in dollars per kilowatt of peak demand. Null for rate schedules without demand charges.',
    `effective_end_date` DATE COMMENT 'Date on which this rate schedule ceases to be effective. Null for currently active rate schedules with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date from which this rate schedule becomes effective and applicable to customer billing.',
    `energy_charge_rate` DECIMAL(18,2) COMMENT 'Base energy charge rate in dollars per kilowatt-hour. Represents the primary volumetric charge component for energy consumption.',
    `fuel_adjustment_clause_applicable` BOOLEAN COMMENT 'Indicates whether a fuel adjustment clause or energy cost adjustment mechanism applies to this rate schedule.',
    `has_seasonal_rates` BOOLEAN COMMENT 'Indicates whether this rate schedule includes seasonal rate variations for summer and winter periods.',
    `has_tiered_pricing` BOOLEAN COMMENT 'Indicates whether this rate schedule includes tiered or block pricing with different rates for different usage levels.',
    `has_tou_periods` BOOLEAN COMMENT 'Indicates whether this rate schedule includes time-of-use pricing periods with different rates for peak, off-peak, and shoulder periods.',
    `interruptible_service` BOOLEAN COMMENT 'Indicates whether this rate schedule provides interruptible or curtailable service with discounted rates in exchange for load reduction rights.',
    `jurisdiction` STRING COMMENT 'State or regulatory jurisdiction code where this rate schedule is approved and applicable. Uses standard state abbreviations or jurisdiction codes.. Valid values are `^[A-Z]{2,3}$`',
    `maximum_demand_kw` DECIMAL(18,2) COMMENT 'Maximum demand threshold in kilowatts for customer eligibility under this rate schedule. Null if no maximum applies.',
    `maximum_usage_kwh` DECIMAL(18,2) COMMENT 'Maximum monthly energy usage in kilowatt-hours for customer eligibility. Null if no maximum applies.',
    `minimum_demand_kw` DECIMAL(18,2) COMMENT 'Minimum demand threshold in kilowatts required for customer eligibility under this rate schedule. Null if no minimum applies.',
    `minimum_power_factor` DECIMAL(18,2) COMMENT 'Minimum power factor threshold required to avoid penalties. Expressed as a decimal between 0 and 1. Null if power factor penalties do not apply.',
    `minimum_usage_kwh` DECIMAL(18,2) COMMENT 'Minimum monthly energy usage in kilowatt-hours required for customer eligibility. Null if no minimum applies.',
    `modified_by_user` STRING COMMENT 'User ID or system identifier of the person or process that last modified this rate schedule record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate schedule record was last modified in the billing system.',
    `net_metering_eligible` BOOLEAN COMMENT 'Indicates whether customers on this rate schedule are eligible for net energy metering programs for distributed generation.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this rate schedule for internal reference.',
    `power_factor_penalty_applicable` BOOLEAN COMMENT 'Indicates whether power factor penalties or adjustments apply to customers on this rate schedule for poor power factor performance.',
    `prepay_eligible` BOOLEAN COMMENT 'Indicates whether customers on this rate schedule are eligible for prepaid metering programs.',
    `rate_class` STRING COMMENT 'Customer class or segment to which this rate schedule applies. Defines the primary customer category for rate applicability.. Valid values are `residential|commercial|industrial|agricultural|municipal|street_lighting`',
    `rate_code` STRING COMMENT 'Business identifier for the rate schedule used in billing systems and customer communications. Externally-known unique code for this tariff rate schedule.. Valid values are `^[A-Z0-9]{3,12}$`',
    `rate_description` STRING COMMENT 'Detailed description of the rate schedule including applicability, terms, and conditions as filed with regulatory authorities.',
    `rate_name` STRING COMMENT 'Human-readable name of the rate schedule displayed on customer bills and tariff documents.',
    `rate_schedule_status` STRING COMMENT 'Current lifecycle status of the rate schedule in the billing system.. Valid values are `active|inactive|pending|superseded|suspended`',
    `rate_type` STRING COMMENT 'Type of rate structure defining the pricing methodology. TOU = Time of Use, CPP = Critical Peak Pricing. [ENUM-REF-CANDIDATE: standard|tou|cpp|tiered|demand|flat|seasonal|interruptible — 8 candidates stripped; promote to reference product]',
    `regulatory_approval_date` DATE COMMENT 'Date on which the regulatory authority approved this rate schedule for implementation.',
    `regulatory_approval_number` STRING COMMENT 'Reference number of the regulatory order or docket approving this rate schedule. Links to PUC or FERC rate case proceedings.',
    `renewable_energy_rider_applicable` BOOLEAN COMMENT 'Indicates whether renewable energy riders or RPS compliance charges apply to this rate schedule.',
    `service_type` STRING COMMENT 'Type of electrical service configuration applicable to this rate schedule.. Valid values are `single_phase|three_phase|primary_service|secondary_service`',
    `source_system` STRING COMMENT 'Identifier of the source billing system from which this rate schedule record originated.. Valid values are `SAP_IS_U|ORACLE_CCB|LEGACY_CIS`',
    `tariff_book_reference` STRING COMMENT 'Reference to the section and page number in the official tariff book where this rate schedule is published.',
    `tax_inclusive` BOOLEAN COMMENT 'Indicates whether the published rates include applicable taxes or if taxes are added separately during billing.',
    `voltage_level` STRING COMMENT 'Voltage level at which service is delivered under this rate schedule. Determines applicable transmission and distribution charges.. Valid values are `primary|secondary|transmission|sub_transmission|distribution`',
    CONSTRAINT pk_rate_schedule PRIMARY KEY(`rate_schedule_id`)
) COMMENT 'Master reference entity defining tariff rate schedules and their granular charge components applicable to customer accounts. At the schedule level: stores rate code, effective dates, rate class, voltage level, applicable customer segments, regulatory approval references, and jurisdiction. At the component level: captures individual charge elements including energy charges ($/kWh), demand charges ($/kW), customer charges, fuel adjustment clauses, distribution charges, transmission charges, and riders with component type, unit of measure, tier thresholds, seasonal applicability, time-of-use period mapping, and calculation formula. Sourced from SAP IS-U and Oracle CC&B rate configuration modules. SSOT for all rate definitions and charge component structures used in bill calculation. Supports rate case filings and regulatory tariff compliance.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`billing`.`rate_component` (
    `rate_component_id` BIGINT COMMENT 'Unique identifier for the rate component. Primary key.',
    `capacity_requirement_id` BIGINT COMMENT 'Foreign key linking to forecast.capacity_requirement. Business justification: Capacity-related rate components (demand charges, capacity riders, PJM/ISO capacity cost recovery riders) are calculated to recover costs from capacity requirement forecasts. Tariff filings must refer',
    `dr_program_id` BIGINT COMMENT 'Foreign key linking to demand.dr_program. Business justification: Specific rate components (demand charges, TOU energy charges) may be waived, modified, or have special calculation rules for DR program participants. Tariff administration, billing system configuratio',
    `fuel_contract_id` BIGINT COMMENT 'Foreign key linking to generation.fuel_contract. Business justification: Fuel Adjustment Clause (FAC) rate components are directly calculated from specific fuel contract prices and filed with the PUC for cost pass-through approval. Regulators require FAC riders to cite the',
    `incentive_program_id` BIGINT COMMENT 'Foreign key linking to renewable.incentive_program. Business justification: Incentive program riders (solar incentive adders, REC pass-through credits) are modeled as rate components tied to specific incentive programs. Linking rate_component to incentive_program enables auto',
    `lmp_price_id` BIGINT COMMENT 'Foreign key linking to trading.lmp_price. Business justification: Real-time pricing (RTP) and indexed rate components use LMP as the price basis for energy charge calculation. Regulatory tariffs for RTP customers require the rate component to reference the specific ',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Individual rate components (riders, surcharges, fuel adjustment clauses, environmental compliance charges) are mandated by specific regulatory obligations. Compliance teams must trace each charge comp',
    `path_id` BIGINT COMMENT 'Foreign key linking to transmission.path. Business justification: OATT transmission rate components (congestion cost riders, marginal loss factor charges, ATC-based capacity charges) are defined per transmission path. Tariff engineers and regulatory filings referenc',
    `pnode_id` BIGINT COMMENT 'Foreign key linking to transmission.pnode. Business justification: Nodal LMP-based rate components (energy charge, congestion component, loss component) reference a specific pricing node. RTO/ISO tariffs require rate components to identify the settlement PNode for no',
    `ppa_contract_id` BIGINT COMMENT 'Foreign key linking to renewable.ppa_contract. Business justification: Renewable energy riders and PPA pass-through rate components are directly tied to specific PPA contracts. Linking rate_component to ppa_contract enables automated rate validation and regulatory filing',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key reference to the parent rate schedule that contains this component.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Rate components must be documented in regulatory filings when utilities propose tariff changes or rate case adjustments. Links the rate component to the specific filing (rate case, tariff amendment) w',
    `adjustment_frequency` STRING COMMENT 'Frequency at which this rate component value is adjusted or recalculated. Fixed components never change, monthly adjustments are common for fuel clauses, quarterly for purchased power adjustments, annually for base rate reviews, event-driven for critical peak pricing.. Valid values are `fixed|monthly|quarterly|annually|event_driven`',
    `applicable_days` STRING COMMENT 'Indicates which days of the week or calendar this rate component applies to. TOU rates often differ between weekdays and weekends.. Valid values are `all_days|weekdays|weekends|holidays|non_holidays`',
    `approval_status` STRING COMMENT 'Current regulatory approval status of the rate component. Draft components are under development, pending_approval are submitted to PUC, approved are authorized for billing, rejected were denied, superseded were replaced by newer versions, retired are no longer in use.. Valid values are `draft|pending_approval|approved|rejected|superseded|retired`',
    `bill_print_sequence` STRING COMMENT 'Sequence number controlling the order in which rate components appear on printed customer bills. Lower numbers print first. Null if print_on_bill_flag is False.',
    `billing_determinant` STRING COMMENT 'The measured or calculated value that this rate component is applied to. Actual usage comes from meter reads, estimated usage from profiling, contracted demand from service agreements, metered demand from interval data, billing demand from demand ratchets.. Valid values are `actual_usage|estimated_usage|contracted_demand|metered_demand|billing_demand|customer_count`',
    `calculation_formula` STRING COMMENT 'Mathematical formula or expression used to calculate the charge when calculation_method is formula. May reference other rate components, meter data, or external indices.',
    `calculation_method` STRING COMMENT 'Method used to calculate charges for this component. Flat applies a single rate, tiered uses progressive rate steps, block uses declining block rates, TOU (time-of-use) varies by time period, CPP (critical peak pricing) applies premium rates during peak events, real-time uses dynamic pricing, formula uses a custom calculation expression. [ENUM-REF-CANDIDATE: flat|tiered|block|tou|cpp|real_time|formula — 7 candidates stripped; promote to reference product]',
    `charge_category` STRING COMMENT 'Billing category classification indicating whether this is a base tariff charge, a rider (supplemental charge), surcharge, credit (reduction), adjustment clause, or tax component.. Valid values are `base|rider|surcharge|credit|adjustment|tax`',
    `component_code` STRING COMMENT 'Unique business identifier code for the rate component used in billing systems and tariff filings.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `component_description` STRING COMMENT 'Detailed business description of the rate component, its purpose, and how it is calculated. Used for customer communications, tariff documentation, and internal training.',
    `component_name` STRING COMMENT 'Human-readable name of the rate component as it appears on customer bills and tariff documents.',
    `component_type` STRING COMMENT 'Classification of the rate component indicating the nature of the charge. Energy charges are based on kWh consumption, demand charges on peak kW usage, customer charges are fixed monthly fees, fuel adjustment clauses recover fuel cost variations, distribution charges cover local delivery infrastructure, and transmission charges cover high-voltage grid costs.. Valid values are `energy_charge|demand_charge|customer_charge|fuel_adjustment|distribution_charge|transmission_charge`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate component record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the rate value (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `customer_class_applicability` STRING COMMENT 'Indicates which customer classes this rate component applies to. Rate components may be specific to residential, commercial, industrial, or other customer segments.. Valid values are `residential|commercial|industrial|agricultural|street_lighting|all_classes`',
    `decimal_precision` STRING COMMENT 'Number of decimal places to retain in charge calculations for this component. Typically 2 for dollar amounts, but may be higher for per-unit rates or regulatory calculations.',
    `effective_end_date` DATE COMMENT 'Date when this rate component expires and is no longer applied to customer bills. Null indicates the component is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this rate component becomes effective and can be applied to customer bills. Aligns with PUC rate case approval dates.',
    `gl_account_code` STRING COMMENT 'General ledger account code in the ERP system (SAP S/4HANA) where revenue from this rate component is posted for financial accounting.. Valid values are `^[0-9]{4,10}$`',
    `index_reference` STRING COMMENT 'External market index or benchmark used to calculate this component if it is formula-based or indexed (e.g., Henry Hub natural gas price, PJM LMP, CPI). Null for fixed-rate components.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate component record was last updated in the system.',
    `maximum_charge` DECIMAL(18,2) COMMENT 'Maximum charge cap for this component. Used to limit exposure for certain rate components or to comply with regulatory caps.',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Minimum charge amount that must be applied for this component regardless of usage. Common for customer charges and demand charges with minimum billing requirements.',
    `print_on_bill_flag` BOOLEAN COMMENT 'Indicates whether this rate component should appear as a separate line item on customer bills. True for customer-visible charges, False for internal calculation components that roll up into other line items.',
    `proration_method` STRING COMMENT 'Method used to prorate charges for partial billing periods (e.g., when a customer starts or stops service mid-cycle). Daily proration divides by days in period, calendar uses actual calendar days, billing uses billing cycle days.. Valid values are `daily|calendar_days|billing_days|none`',
    `puc_docket_number` STRING COMMENT 'Public Utility Commission docket or case number associated with the rate case that approved this component. Used for regulatory compliance tracking and audit trails.. Valid values are `^[A-Z0-9-]{5,20}$`',
    `rate_value` DECIMAL(18,2) COMMENT 'The numeric rate or price applied per unit of measure. For example, $0.085 per kWh for energy charges, $15.00 per kW for demand charges, or $12.00 per account for customer charges.',
    `regulatory_account_code` STRING COMMENT 'FERC Uniform System of Accounts code or state regulatory accounting code used for revenue recognition and regulatory reporting of charges from this component.. Valid values are `^[0-9]{3,6}$`',
    `revenue_class` STRING COMMENT 'Classification of revenue type for financial and regulatory reporting. Aligns with FERC revenue categories and state regulatory reporting requirements.. Valid values are `base_revenue|fuel_revenue|distribution_revenue|transmission_revenue|other_revenue`',
    `rider_code` STRING COMMENT 'Short code identifying the rider or surcharge if this component is a supplemental charge (e.g., FAC for Fuel Adjustment Clause, EEC for Energy Efficiency Charge, REC for Renewable Energy Charge). Null for base rate components.. Valid values are `^[A-Z]{1,5}$`',
    `rounding_rule` STRING COMMENT 'Rounding method applied to calculated charges for this component. Round_half_up is standard commercial rounding, round_down always rounds down, round_up always rounds up, truncate drops decimals.. Valid values are `none|round_half_up|round_down|round_up|truncate`',
    `seasonal_applicability` STRING COMMENT 'Indicates which season or time period this rate component applies to. Many utilities have different rates for summer (high cooling demand) versus winter periods. [ENUM-REF-CANDIDATE: year_round|summer|winter|spring|fall|peak_season|off_peak_season — 7 candidates stripped; promote to reference product]',
    `tariff_sheet_reference` STRING COMMENT 'Reference to the specific tariff sheet number or section in the official tariff book where this rate component is documented. Used for regulatory compliance and customer inquiries.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether this rate component is exempt from sales tax or other taxes. True if exempt, False if taxable.',
    `tier_sequence` STRING COMMENT 'Sequence number for tiered or block rate structures, indicating the order of rate tiers (1 for first tier, 2 for second tier, etc.). Null for non-tiered components.',
    `tier_threshold_max` DECIMAL(18,2) COMMENT 'Maximum usage threshold for this tier in the specified unit of measure. Null indicates no upper limit (open-ended tier). Null for non-tiered components.',
    `tier_threshold_min` DECIMAL(18,2) COMMENT 'Minimum usage threshold for this tier in the specified unit of measure. For example, tier 1 might be 0 kWh, tier 2 might be 500 kWh. Null for non-tiered components.',
    `tou_end_time` TIMESTAMP COMMENT 'End time for the TOU period in HH:MM format (24-hour clock). For example, on-peak might end at 21:00. Null for non-TOU components.',
    `tou_period` STRING COMMENT 'Time-of-use period classification for TOU rate structures. On-peak represents highest demand periods, off-peak represents lowest demand periods, critical-peak represents emergency high-demand events.. Valid values are `on_peak|mid_peak|off_peak|super_off_peak|critical_peak|all_hours`',
    `tou_start_time` TIMESTAMP COMMENT 'Start time for the TOU period in HH:MM format (24-hour clock). For example, on-peak might start at 14:00. Null for non-TOU components.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for this rate component. Common values include kWh (kilowatt-hour) for energy consumption, kW (kilowatt) for demand, account for fixed customer charges, day/month for time-based charges. [ENUM-REF-CANDIDATE: kWh|kW|MWh|MW|account|day|month|therm|ccf — 9 candidates stripped; promote to reference product]',
    `voltage_level` STRING COMMENT 'Voltage level at which service is delivered, affecting rate component applicability. Secondary is typical residential (120/240V), primary is distribution (4-35kV), sub-transmission (35-138kV), transmission (>138kV).. Valid values are `secondary|primary|sub_transmission|transmission|all_levels`',
    CONSTRAINT pk_rate_component PRIMARY KEY(`rate_component_id`)
) COMMENT 'Granular rate component definitions within a rate schedule, capturing individual charge elements such as energy charges ($/kWh), demand charges ($/kW), customer charges, fuel adjustment clauses, distribution charges, transmission charges, and riders. Stores component type, unit of measure, tier thresholds, seasonal applicability, and calculation formula. Enables precise bill calculation for all rate structures including tiered and TOU.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` (
    `billing_service_agreement_id` BIGINT COMMENT 'Unique identifier for the billing service agreement. Primary key for this entity representing the contractual billing relationship between the utility and customer.',
    `account_id` BIGINT COMMENT 'Reference to the customer account that owns this billing service agreement.',
    `rate_schedule_id` BIGINT COMMENT 'FK to billing.rate_schedule',
    `contract_id` BIGINT COMMENT 'Foreign key linking to trading.contract. Business justification: Large commercial/industrial customers with special bilateral trading contracts have their billing service agreement governed by the trading contract terms. The BSA-to-contract link is required for spe',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: Transmission-level customers (large industrial, wholesale) have their billing service agreement tied to a specific transmission substation as the contractual point of delivery. This drives demand bill',
    `incentive_program_id` BIGINT COMMENT 'Foreign key linking to renewable.incentive_program. Business justification: Service agreements for solar/DER customers are directly enrolled in incentive programs, governing billing rules and credit calculations. The BSA is the enrollment vehicle in utility CIS systems; this ',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Service agreements reference the specific delivery asset (transformer, service lateral, connection point) serving the premise. Field operations use this for capacity planning, service upgrades, and ou',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to trading.counterparty. Business justification: Wholesale customers (load-serving entities, generators) have billing service agreements where the billing entity is a registered trading counterparty. Role-prefixed wholesale_ distinguishes from ret',
    `agreement_number` STRING COMMENT 'Externally visible business identifier for the service agreement, used in customer communications and billing statements.',
    `agreement_type` STRING COMMENT 'Classification of the billing service agreement based on customer class and service characteristics. Determines applicable rate structures and regulatory treatment.. Valid values are `residential|commercial|industrial|nem|municipal|agricultural`',
    `autopay_flag` BOOLEAN COMMENT 'Indicates whether the customer is enrolled in automatic payment program where invoices are paid automatically on due date.',
    `billing_agreement_uses_rate_schedule` BIGINT COMMENT 'FK to billing.rate_schedule.rate_schedule_id — Each service agreement is assigned a rate schedule that governs how the account is billed. This is a fundamental billing relationship — without it, the billing engine cannot determine which rates to a',
    `billing_cycle_code` STRING COMMENT 'Code identifying the billing cycle schedule that determines invoice generation frequency and due dates for this agreement.',
    `billing_frequency` STRING COMMENT 'Frequency at which invoices are generated for this service agreement.. Valid values are `monthly|bimonthly|quarterly|annual`',
    `billing_service_agreement_status` STRING COMMENT 'Current lifecycle status of the billing service agreement indicating whether it is actively generating invoices and accepting payments.. Valid values are `active|pending|suspended|terminated|cancelled|inactive`',
    `budget_billing_amount` DECIMAL(18,2) COMMENT 'Fixed monthly payment amount for customers enrolled in budget billing program. Recalculated periodically based on usage history.',
    `budget_billing_flag` BOOLEAN COMMENT 'Indicates whether the customer is enrolled in budget billing program that spreads annual energy costs into equal monthly payments.',
    `contract_capacity_kw` DECIMAL(18,2) COMMENT 'Contracted maximum demand capacity in kilowatts for large commercial or industrial customers. Basis for capacity charges and penalties for exceeding contracted demand.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this billing service agreement record was first created in the system.',
    `credit_hold_flag` BOOLEAN COMMENT 'Indicates whether this service agreement is on credit hold due to payment delinquency or credit risk, potentially restricting service or requiring prepayment.',
    `demand_metered_flag` BOOLEAN COMMENT 'Indicates whether this service agreement includes demand metering and demand charges based on peak kW usage.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Amount of security deposit held for this service agreement. Subject to interest accrual per state PUC regulations.',
    `deposit_date` DATE COMMENT 'Date when the security deposit was received from the customer.',
    `deposit_required_flag` BOOLEAN COMMENT 'Indicates whether a security deposit is required for this service agreement based on credit profile or regulatory requirements.',
    `disconnect_pending_flag` BOOLEAN COMMENT 'Indicates whether a service disconnection order is pending for this agreement due to non-payment or other reasons.',
    `dunning_block_flag` BOOLEAN COMMENT 'Indicates whether collections and dunning activities are blocked for this service agreement due to payment arrangement, dispute, or special circumstances.',
    `dunning_block_reason` STRING COMMENT 'Explanation for why dunning activities are blocked, such as active payment plan, billing dispute, or regulatory protection.',
    `effective_end_date` DATE COMMENT 'Date when the billing service agreement terminates and billing ceases. Nullable for open-ended agreements. Aligns with service disconnection or move-out date.',
    `effective_start_date` DATE COMMENT 'Date when the billing service agreement becomes active and billing begins. Aligns with service connection or move-in date.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this service agreement record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this billing service agreement record was last updated.',
    `life_support_flag` BOOLEAN COMMENT 'Indicates whether the premise has registered life support medical equipment requiring continuous power. Provides regulatory protection from disconnection.',
    `load_profile_type` STRING COMMENT 'Classification of the customer load profile and associated rate structure. Determines whether Time of Use, Critical Peak Pricing, or Real Time Pricing applies.. Valid values are `flat|tou|cpp|rtp|critical_peak_rebate`',
    `low_income_assistance_flag` BOOLEAN COMMENT 'Indicates whether the customer qualifies for and is enrolled in low income energy assistance programs such as LIHEAP or CARE.',
    `nem_flag` BOOLEAN COMMENT 'Indicates whether this service agreement participates in Net Energy Metering program for distributed generation customers with solar or other renewable energy systems.',
    `nem_program_type` STRING COMMENT 'Specific NEM program version and structure applicable to this agreement. Different versions have varying compensation rates and rules.. Valid values are `nem_1_0|nem_2_0|nem_3_0|vnem|aggregated_nem`',
    `paperless_billing_flag` BOOLEAN COMMENT 'Indicates whether the customer has opted for electronic invoice delivery instead of paper bills.',
    `payment_arrangement_flag` BOOLEAN COMMENT 'Indicates whether the customer has an active payment arrangement or installment plan for past due balances on this service agreement.',
    `payment_method` STRING COMMENT 'Primary payment instrument the customer uses to pay invoices for this service agreement.. Valid values are `bank_draft|credit_card|check|cash|electronic_transfer|autopay`',
    `revenue_class` STRING COMMENT 'Revenue accounting classification for financial reporting and regulatory compliance. Determines how revenue is recognized and reported to FERC and state PUCs. [ENUM-REF-CANDIDATE: residential|small_commercial|large_commercial|industrial|agricultural|street_lighting|public_authority — 7 candidates stripped; promote to reference product]',
    `service_voltage_level` STRING COMMENT 'Voltage level at which electric service is delivered to the customer. Affects rate structure and delivery charges.. Valid values are `secondary|primary|subtransmission|transmission`',
    `special_contract_flag` BOOLEAN COMMENT 'Indicates whether this service agreement operates under a special negotiated contract with non-standard rates or terms, typically for large industrial customers.',
    `special_contract_terms` STRING COMMENT 'Description of special contractual terms, pricing arrangements, or service level commitments that deviate from standard tariff schedules.',
    `termination_reason` STRING COMMENT 'Reason code or description explaining why the service agreement was terminated, such as customer move-out, non-payment disconnection, or service transfer.',
    CONSTRAINT pk_billing_service_agreement PRIMARY KEY(`billing_service_agreement_id`)
) COMMENT 'Master entity representing the contractual billing relationship between the utility and a customer account for energy delivery at a specific service point. Captures agreement type (residential, commercial, industrial, NEM), assigned rate schedule, effective and end dates, deposit requirements, budget billing enrollment status, special contract terms, and service point reference. SSOT for the active billing relationship that drives invoice generation, payment application, collections, and all downstream billing activity. Sourced from SAP IS-U contract account and Oracle CC&B service agreement modules.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`billing`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique system identifier for the utility invoice. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer account for which this invoice was generated.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to interconnection.interconnection_agreement. Business justification: Utilities generate recurring invoices for interconnection standby charges, maintenance fees, and cost recovery under a specific interconnection agreement. Billing operations and revenue reporting requ',
    `billing_run_id` BIGINT COMMENT 'Foreign key linking to billing.billing_run. Business justification: Each invoice is created by a specific billing run execution (batch job). This FK enables tracing invoices back to the exact run that generated them, critical for exception handling, reprocessing, and ',
    `billing_service_agreement_id` BIGINT COMMENT 'Foreign key linking to billing.billing_service_agreement. Business justification: An invoice is generated FOR a specific service agreement (the contractual billing relationship between utility and customer). While invoice currently has account_id and premise_id, it lacks the direct',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to trading.counterparty. Business justification: Wholesale energy invoices are issued to registered trading counterparties (LSEs, generators, marketers). The invoice recipient in wholesale billing is a trading counterparty, not a retail customer acc',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to billing.billing_cycle. Business justification: Each invoice is generated as part of a specific billing cycle execution. Currently invoice has billing_cycle_code (STRING) but no FK to the billing_cycle entity. This FK enables joining to retrieve cy',
    `energy_price_id` BIGINT COMMENT 'Foreign key linking to forecast.energy_price. Business justification: Indexed and market-rate billing: invoices for large commercial/industrial customers on indexed tariffs reference the energy price forecast used to calculate charges. Fuel adjustment clause invoices re',
    `invoice_for_service_agreement` BIGINT COMMENT 'FK to billing.billing_service_agreement.billing_service_agreement_id — Every invoice is generated for a specific service agreement. This is the core billing relationship — without it, invoices cannot be tied to the customers contractual billing arrangement, rate schedul',
    `market_settlement_id` BIGINT COMMENT 'Foreign key linking to trading.market_settlement. Business justification: Wholesale billing invoices for ISO/RTO market participants are generated directly from market settlement records. The settlement-to-invoice traceability is required for FERC EQR reporting and counterp',
    `meter_point_id` BIGINT COMMENT 'Foreign key linking to metering.meter_point. Business justification: Invoices bill specific service points (meter_point). This link is fundamental for rate application, network cost allocation, and regulatory reporting by service location. Every invoice must identify w',
    `nem_account_id` BIGINT COMMENT 'Foreign key linking to renewable.nem_account. Business justification: Invoices apply NEM credits from specific NEM accounts, track cumulative credit balances, and perform annual true-up settlements. Critical for accurate billing of net metering customers, ensuring prope',
    `nem_agreement_id` BIGINT COMMENT 'Foreign key linking to interconnection.nem_agreement. Business justification: NEM annual true-up invoices are generated under a specific NEM agreement that defines export compensation rates and banking policies. Direct traceability from invoice to NEM agreement is required for ',
    `peak_demand_id` BIGINT COMMENT 'Foreign key linking to forecast.peak_demand. Business justification: Demand charge billing validation: large C&I customer invoices include demand charges based on peak_demand_kw. Linking to forecast.peak_demand supports billing dispute resolution and rate design valida',
    `ppa_contract_id` BIGINT COMMENT 'Foreign key linking to renewable.ppa_contract. Business justification: Invoices for renewable PPA energy services must reference the underlying PPA contract to support PPA cost pass-through reporting and regulatory cost recovery filings. Billing analysts trace invoices t',
    `ppa_id` BIGINT COMMENT 'Foreign key linking to trading.ppa. Business justification: PPA offtake invoices are issued to the PPA counterparty for energy delivered under the contract. Wholesale PPA billing requires direct invoice-to-PPA linkage for contract performance tracking, payment',
    `ppa_settlement_id` BIGINT COMMENT 'Foreign key linking to renewable.ppa_settlement. Business justification: Utilities generate invoices that directly correspond to a PPA settlement period for generator-side billing and community solar subscriber billing. Direct invoice-to-settlement traceability is required',
    `premise_id` BIGINT COMMENT 'Reference to the service premise where energy was consumed during this billing period.',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to distribution.service_territory. Business justification: Invoices require service territory reference for revenue allocation by jurisdiction, regulatory reporting (PUC filings), jurisdictional tax calculation, and franchise fee assessment. Critical for mult',
    `settlement_statement_id` BIGINT COMMENT 'Foreign key linking to trading.settlement_statement. Business justification: ISO/RTO settlement statements are the authoritative source documents that drive wholesale invoice generation. Linking invoice to settlement_statement enables statement-to-invoice audit trail required ',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Customer-requested work (service connections, meter sets, line extensions) generates invoices directly from work orders. Utilities bill customers for work order labor and materials; the invoice must r',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total adjustments applied to the invoice including credits, refunds, billing corrections, and dispute resolutions. Positive for credits, negative for additional charges.',
    `auto_pay_flag` BOOLEAN COMMENT 'Indicates whether this invoice is enrolled in automatic payment processing from a bank account or credit card.',
    `bill_message_code` STRING COMMENT 'Code identifying special messages or notices printed on the invoice (e.g., disconnection warning, rate change notice, energy efficiency tips).',
    `billing_cycle` BIGINT COMMENT 'FK to billing.billing_cycle.billing_cycle_id — Every invoice is generated within a billing cycle run. Critical for billing operations monitoring and batch reconciliation.',
    `billing_cycle_code` STRING COMMENT 'Code identifying the billing cycle schedule to which this invoice belongs (e.g., monthly cycle 01, cycle 15).',
    `billing_days` STRING COMMENT 'Number of days in the billing period, used for prorating charges and calculating daily averages.',
    `billing_period_end_date` DATE COMMENT 'Last date of the billing period for which energy consumption and charges are calculated.',
    `billing_period_start_date` DATE COMMENT 'First date of the billing period for which energy consumption and charges are calculated.',
    `budget_billing_flag` BOOLEAN COMMENT 'Indicates whether this invoice is part of a budget billing plan where monthly charges are levelized based on annual consumption estimates.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this invoice record was first created in the billing system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this invoice (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `current_charges_amount` DECIMAL(18,2) COMMENT 'Total charges for the current billing period including energy, demand, customer charges, riders, and fees before taxes.',
    `delivery_method` STRING COMMENT 'Method by which the invoice was delivered to the customer.. Valid values are `postal_mail|email|customer_portal|sms`',
    `deposit_applied_amount` DECIMAL(18,2) COMMENT 'Customer security deposit amount applied to this invoice, typically at service termination or account closure.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this invoice is currently under dispute by the customer, requiring resolution before collections action.',
    `due_date` DATE COMMENT 'Date by which payment must be received to avoid late fees or service disconnection.',
    `energy_consumption_kwh` DECIMAL(18,2) COMMENT 'Total electric energy consumed during the billing period measured in kilowatt-hours (kWh). Calculated from meter readings or AMI interval data.',
    `from_billing_cycle` BIGINT COMMENT 'FK to billing.billing_cycle.billing_cycle_id — Invoices are generated as part of a billing cycle run. This FK supports billing operations monitoring, cycle-level revenue reconciliation, and workload management.',
    `gl_posting_date` DATE COMMENT 'Date when this invoice was posted to the general ledger accounts receivable.',
    `invoice_date` DATE COMMENT 'Date the invoice was generated and issued to the customer. Principal business event timestamp for the transaction.',
    `invoice_number` STRING COMMENT 'Externally visible, customer-facing invoice number printed on the bill. Unique business identifier for the invoice.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the billing and collections workflow. [ENUM-REF-CANDIDATE: draft|issued|sent|paid|partially_paid|overdue|cancelled|disputed|adjusted|written_off — 10 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice based on billing purpose: regular cycle bill, final bill at move-out, interim bill, adjustment bill, credit memo, or debit memo.. Valid values are `regular|final|interim|adjustment|credit|debit`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this invoice record was last updated, capturing adjustments, payment applications, or status changes.',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'Late payment fee assessed on this invoice for overdue balances from prior billing periods.',
    `meter_read_end_date` DATE COMMENT 'Date of the meter reading at the end of the billing period.',
    `meter_read_start_date` DATE COMMENT 'Date of the meter reading at the beginning of the billing period.',
    `outstanding_balance_amount` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on this invoice after payments have been applied.',
    `paperless_billing_flag` BOOLEAN COMMENT 'Indicates whether the customer has opted for electronic delivery of this invoice instead of paper mail.',
    `payment_arrangement_flag` BOOLEAN COMMENT 'Indicates whether this invoice is subject to a payment arrangement or installment plan for past-due balances.',
    `payment_received_amount` DECIMAL(18,2) COMMENT 'Total payments received against this invoice to date.',
    `peak_demand_kw` DECIMAL(18,2) COMMENT 'Maximum electric demand recorded during the billing period measured in kilowatts (kW). Used for demand-based rate calculations.',
    `previous_balance_amount` DECIMAL(18,2) COMMENT 'Outstanding balance carried forward from prior billing periods before current charges are applied.',
    `print_date` DATE COMMENT 'Date when the physical or electronic invoice document was generated and prepared for delivery to the customer.',
    `rate_class` STRING COMMENT 'Customer rate classification determining applicable tariff structures and regulatory treatment.. Valid values are `residential|commercial|industrial|agricultural|municipal|street_lighting`',
    `rate_schedule_code` STRING COMMENT 'Tariff rate schedule code applied to this invoice, defining the pricing structure for energy and demand charges.',
    `revenue_recognition_date` DATE COMMENT 'Date when revenue from this invoice is recognized in the general ledger for financial reporting purposes.',
    `service_agreement` BIGINT COMMENT 'FK to billing.service_agreement.service_agreement_id — Every invoice is generated for a specific service agreement. This is the core billing transaction-to-master relationship.',
    `service_end_date` DATE COMMENT 'Date when utility service ended for this billing period, relevant for disconnections or final bills.',
    `service_start_date` DATE COMMENT 'Date when utility service began for this billing period, relevant for new connections or service resumptions.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total taxes applied to the invoice including sales tax, utility tax, and other regulatory taxes.',
    `to_cycle` BIGINT COMMENT 'FK to billing.billing_cycle.billing_cycle_id — Every invoice is generated within a billing cycle run. This FK supports billing operations monitoring and revenue cycle timing.',
    `to_sa` BIGINT COMMENT 'FK to billing.service_agreement.service_agreement_id — Every invoice is generated for a specific service agreement. This FK is essential for tracing billed amounts back to the contractual billing relationship.',
    `total_amount_due` DECIMAL(18,2) COMMENT 'Net total amount the customer must pay, calculated as previous balance plus current charges plus taxes plus adjustments.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Amount of this invoice written off as uncollectible bad debt, subject to SOX financial controls and regulatory reporting.',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Core transactional entity representing a utility bill issued to a customer for a billing period, including header-level totals and granular line-item charge detail. At the header level: captures invoice number, billing period dates, due date, total amount due, energy consumed (kWh/MWh), demand (kW), prior balance, current charges, taxes, adjustments, and payment status. At the line level: captures individual charge components including energy charges, demand charges, customer charges, fuel adjustment clauses, distribution riders, taxes, and credits with rate component reference, quantity, unit rate, calculated amount, and applicable billing determinant. Generated from Oracle CC&B and SAP IS-U billing engine. SSOT for all customer-facing billing documents and their charge detail. Supports SOX AR controls, granular revenue recognition, rate component-level analysis, and regulatory rate case evidence.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`billing`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'Unique identifier for the invoice line item. Primary key for the invoice line detail record.',
    `curtailment_event_id` BIGINT COMMENT 'Foreign key linking to renewable.curtailment_event. Business justification: Curtailment credit line items on customer invoices must reference the curtailment event for regulatory reporting and customer dispute resolution. This is distinct from adjustment → curtailment_event: ',
    `dr_incentive_payment_id` BIGINT COMMENT 'Foreign key linking to demand.dr_incentive_payment. Business justification: Individual invoice line items represent specific DR incentive credits at granular level. Detailed billing reconciliation, audit trails, dispute resolution, and regulatory reporting require line-level ',
    `rate_component_id` BIGINT COMMENT 'FK to billing.rate_component.rate_component_id — Each invoice line item is calculated from a specific rate component. This FK enables rate-component-level revenue analysis and bill audit trails. Critical for regulatory rate case support.',
    `generation_meter_read_id` BIGINT COMMENT 'Foreign key linking to renewable.generation_meter_read. Business justification: Invoice line items for renewable generation charges are derived from generation meter reads. Direct traceability from billed line amounts to metered generation data is required for billing dispute res',
    `original_line_invoice_line_id` BIGINT COMMENT 'Reference to the original invoice line item being reversed or corrected. Null for original charges. Maintains audit trail for billing adjustments.',
    `ppa_settlement_id` BIGINT COMMENT 'Foreign key linking to renewable.ppa_settlement. Business justification: Invoice line items for renewable energy charges are derived from PPA settlement quantities and prices. Line-level reconciliation between customer bills and wholesale settlement is required for PPA cos',
    `invoice_id` BIGINT COMMENT 'Reference to the parent invoice header. Links this line item to the billing document.',
    `primary_invoice_rate_component_id` BIGINT COMMENT 'Foreign key linking to billing.rate_component. Business justification: Each invoice line item is calculated using a specific rate component definition from the rate schedule. Currently invoice_line has rate_component_code (STRING) which is a denormalized reference. Addin',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Specific invoice line items (regulatory surcharges, riders, environmental compliance charges) are authorized by specific regulatory filings. Utility billing systems must link these line items to their',
    `vpp_configuration_id` BIGINT COMMENT 'Foreign key linking to renewable.vpp_configuration. Business justification: VPP dispatch credit and penalty line items on customer invoices must reference the VPP configuration for program-level reporting and regulatory compliance. ISO/RTO VPP settlement reporting requires li',
    `adjustment_description` STRING COMMENT 'Human-readable description of the adjustment reason for customer communication and audit trail. Null for standard charges.',
    `adjustment_reason_code` STRING COMMENT 'Code identifying the reason for any adjustment applied to this line item (e.g., REBILL, CREDIT, DISPUTE, CORRECTION). Null for standard charges.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `billing_determinant_quantity` DECIMAL(18,2) COMMENT 'Quantity of the billing determinant used in the rate calculation (e.g., kWh consumed, peak kW demand, number of days). Precision supports interval meter data.',
    `billing_determinant_type` STRING COMMENT 'Type of billing determinant used to calculate this charge (e.g., kWh for energy consumption, kW for demand, days for fixed charges, percentage for adjustments). [ENUM-REF-CANDIDATE: kwh|kw|mwh|mw|days|units|flat|percentage — 8 candidates stripped; promote to reference product]',
    `charge_category` STRING COMMENT 'High-level classification of the charge type for revenue recognition and financial reporting. Groups rate components into standard categories. [ENUM-REF-CANDIDATE: energy|demand|customer|distribution|transmission|generation|tax|fee|adjustment|credit|rebate|penalty — 12 candidates stripped; promote to reference product]',
    `consumption_kwh` DECIMAL(18,2) COMMENT 'Energy consumption in kilowatt-hours for this line item. Primary billing determinant for energy charges. Null for non-energy charges.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice line item record was first created in the billing system. Supports audit trail and data lineage for SOX compliance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the line item amounts. Supports multi-currency billing for international operations.. Valid values are `USD|CAD|MXN|EUR|GBP`',
    `demand_kw` DECIMAL(18,2) COMMENT 'Peak demand in kilowatts for this line item. Primary billing determinant for demand charges. Null for non-demand charges.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this line item is under customer dispute. True if disputed, false otherwise. Supports dispute resolution and collections workflows.',
    `gl_account_code` STRING COMMENT 'General ledger account code for revenue recognition posting. Maps line item to chart of accounts for financial reporting and SOX compliance.. Valid values are `^[0-9]{4,10}$`',
    `line_amount` DECIMAL(18,2) COMMENT 'Calculated charge amount for this line item before taxes and adjustments. Result of billing determinant quantity multiplied by unit rate, or flat charge amount.',
    `line_sequence_number` STRING COMMENT 'Sequential ordering of line items within the invoice. Determines display order on customer bill.',
    `meter_read_end_date` DATE COMMENT 'Date of the ending meter read used to calculate consumption for this charge. May differ from service period end for estimated or prorated bills.',
    `meter_read_start_date` DATE COMMENT 'Date of the beginning meter read used to calculate consumption for this charge. May differ from service period start for estimated or prorated bills.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice line item record was last modified. Supports audit trail and change tracking for SOX compliance.',
    `print_sequence` STRING COMMENT 'Display order for this line item on the printed or electronic customer bill. Controls presentation layout for customer readability.',
    `print_suppress_flag` BOOLEAN COMMENT 'Indicates whether this line item should be suppressed from customer bill presentation. True if suppressed (internal accounting only), false if displayed to customer.',
    `proration_factor` DECIMAL(18,2) COMMENT 'Proration multiplier applied to this charge for partial billing periods (e.g., 0.5 for half-month service). Value of 1.0 indicates full period charge.',
    `rate_component_description` STRING COMMENT 'Human-readable description of the rate component or charge type for customer bill presentation (e.g., Energy Charge, Demand Charge, Customer Charge, Fuel Adjustment Clause).',
    `rate_schedule_code` STRING COMMENT 'Code identifying the tariff rate schedule applied to this line item (e.g., RES-1, COM-2, IND-3). Links to approved tariff structure.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `rate_version` STRING COMMENT 'Effective date version of the rate schedule applied to this line item. Supports rate change tracking and historical billing accuracy.. Valid values are `^[0-9]{4}-[0-9]{2}-[0-9]{2}$`',
    `revenue_class` STRING COMMENT 'Customer class for revenue reporting and regulatory compliance. Aligns with FERC and state PUC revenue classification requirements.. Valid values are `residential|commercial|industrial|agricultural|public_authority|street_lighting`',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this line item is a reversal of a previous charge. True for reversal entries, false for original charges. Supports rebilling and correction workflows.',
    `service_period_end_date` DATE COMMENT 'End date of the service period covered by this line item charge. Defines the end of the consumption or service window.',
    `service_period_start_date` DATE COMMENT 'Start date of the service period covered by this line item charge. Defines the beginning of the consumption or service window.',
    `source_line_reference` STRING COMMENT 'Original line item identifier from the source billing system. Maintains traceability to operational system of record for reconciliation and troubleshooting.',
    `source_system_code` STRING COMMENT 'Code identifying the source billing system that generated this invoice line item. Supports multi-system integration and data lineage tracking.. Valid values are `SAP_ISU|ORACLE_CCB|LEGACY_CIS`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount applied to this line item. May include sales tax, utility tax, franchise fees, or other jurisdiction-specific taxes.',
    `tax_jurisdiction_code` STRING COMMENT 'Code identifying the tax jurisdiction for this line item. Determines applicable tax rates and rules. Null for non-taxable items.. Valid values are `^[A-Z0-9_-]{2,10}$`',
    `taxable_flag` BOOLEAN COMMENT 'Indicates whether this line item is subject to sales tax or utility tax. True if taxable, false if exempt.',
    `tier_level` STRING COMMENT 'Tier number for tiered rate structures (e.g., 1 for baseline, 2 for tier 2, 3 for tier 3). Null for non-tiered charges. Supports inclining block and declining block rate designs.',
    `total_line_amount` DECIMAL(18,2) COMMENT 'Total amount for this line item including taxes and adjustments. Sum of line amount and tax amount.',
    `tou_period_code` STRING COMMENT 'Time-of-use period classification for this charge. Identifies whether consumption occurred during on-peak, off-peak, or other TOU periods. Null for non-TOU charges.. Valid values are `on_peak|off_peak|mid_peak|super_off_peak|critical_peak|standard`',
    `unit_rate` DECIMAL(18,2) COMMENT 'Rate per unit applied to the billing determinant (e.g., dollars per kWh, dollars per kW, daily charge). High precision supports complex tariff calculations including TOU and CPP rates.',
    `write_off_flag` BOOLEAN COMMENT 'Indicates whether this line item has been written off as uncollectible. True if written off, false otherwise. Supports bad debt accounting and SOX controls.',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Line-item detail for each charge component on a utility invoice, including energy charges, demand charges, customer charges, fuel adjustment clauses, distribution riders, taxes, and credits. Stores rate component reference, quantity, unit rate, calculated amount, and applicable billing determinant. Enables granular revenue recognition and rate component-level analysis. Sourced from SAP IS-U FICA and Oracle CC&B billing line detail.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`billing`.`payment` (
    `payment_id` BIGINT COMMENT 'Unique identifier for the payment transaction record. Primary key for the payment entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer account against which this payment or refund is applied. Links to the customer account master record in the billing system.',
    `billing_service_agreement_id` BIGINT COMMENT 'FK to billing.service_agreement.service_agreement_id — Payments may be applied at the account/service agreement level when not tied to a specific invoice (e.g., prepayments, deposits).',
    `payment_arrangement_id` BIGINT COMMENT 'Reference to the payment arrangement or installment plan if this payment is part of a structured payment agreement. Null for standard payments.',
    `invoice_id` BIGINT COMMENT 'FK to billing.invoice.invoice_id — Payments are applied against invoices (or account balances). This FK is essential for AR clearing, cash application, and payment status tracking. Note: in open-item accounting (SAP FICA), payments may',
    `settlement_statement_id` BIGINT COMMENT 'Foreign key linking to trading.settlement_statement. Business justification: Wholesale counterparty payments are applied against ISO/RTO settlement statements. Direct payment-to-settlement-statement linkage is required for settlement payment reconciliation, cash application, a',
    `to_invoice_id` BIGINT COMMENT 'FK to billing.invoice.invoice_id — Payments are applied against specific invoices (or account balances). This FK is critical for cash application and AR reconciliation.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value of the payment or refund transaction in the billing currency. Positive values for inbound payments, may be positive or negative depending on system convention for refunds.',
    `application_status` STRING COMMENT 'Status indicating whether and how the payment has been applied to outstanding invoices or account balance. Tracks cash application workflow completion.. Valid values are `unapplied|partially_applied|fully_applied|suspended|reversed`',
    `applied_amount` DECIMAL(18,2) COMMENT 'Portion of the payment amount that has been successfully applied to invoices or account balance. May differ from payment_amount if payment is partially applied or includes unapplied credit.',
    `authorization_code` STRING COMMENT 'Authorization or approval code returned by the payment processor or card network confirming the transaction was approved. Used for reconciliation and dispute resolution.',
    `auto_pay_enrollment_flag` BOOLEAN COMMENT 'Indicates whether this payment was processed as part of an automatic payment enrollment. True for auto-pay transactions, false for manual payments.',
    `bank_account_number_masked` STRING COMMENT 'Masked or tokenized bank account number for ACH payments. Only last 4 digits visible for PCI compliance and fraud prevention. Full account number stored in secure vault.',
    `bank_routing_number` STRING COMMENT 'Nine-digit American Bankers Association routing transit number identifying the financial institution for ACH or check payments. Confidential financial data.. Valid values are `^[0-9]{9}$`',
    `batch_reference` STRING COMMENT 'Identifier for the payment processing batch if this payment was processed as part of a batch run. Used for lockbox processing, bulk ACH imports, and batch reconciliation.',
    `card_expiration_month` STRING COMMENT 'Month component of the payment card expiration date (1-12). Used for recurring payment validation and auto-pay processing.',
    `card_expiration_year` STRING COMMENT 'Four-digit year component of the payment card expiration date. Used for recurring payment validation and auto-pay processing.',
    `card_last_four_digits` STRING COMMENT 'Last four digits of the payment card number for customer reference and dispute resolution. Full card number never stored per PCI DSS requirements.. Valid values are `^[0-9]{4}$`',
    `card_type` STRING COMMENT 'Credit or debit card network brand for card-based payments. Null for non-card payment methods.. Valid values are `visa|mastercard|amex|discover|other`',
    `channel` STRING COMMENT 'Customer interface or channel through which the payment was submitted. Distinguishes self-service digital channels from assisted or physical channels. [ENUM-REF-CANDIDATE: web_portal|mobile_app|ivr|walk_in|mail|bank_draft|third_party_agent — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this payment record was first created in the billing system. Part of the audit trail for data lineage and SOX compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment transaction. Typically USD for US-based utilities but may vary for international operations.. Valid values are `^[A-Z]{3}$`',
    `disbursement_confirmation_number` STRING COMMENT 'Confirmation or tracking number for the refund disbursement. May be check number, ACH trace number, or wire transfer confirmation. Null for inbound payments.',
    `disbursement_date` DATE COMMENT 'Date when the refund check was issued or electronic refund was transmitted. Null for inbound payments or pending refunds.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this payment transaction is posted. Typically a cash or accounts receivable account per the utility chart of accounts.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier that last modified this payment record. Part of the audit trail for SOX compliance and change management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this payment record was last updated. Tracks all modifications for audit trail and change tracking.',
    `lockbox_number` STRING COMMENT 'Bank lockbox identifier for payments received via lockbox processing service. Null for non-lockbox payments.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the payment transaction. May include customer instructions, dispute details, or special handling notes entered by customer service representatives.',
    `nsf_fee_assessed` DECIMAL(18,2) COMMENT 'Fee amount charged to the customer account for returned payment due to insufficient funds. Null if no NSF fee applies.',
    `payment_date` DATE COMMENT 'Business date when the payment was received or the refund was issued. For inbound payments, this is the date the payment was tendered by the customer. For outbound refunds, this is the disbursement date.',
    `payment_method` STRING COMMENT 'Financial instrument or mechanism used to tender the payment. Identifies whether payment was made via check, electronic funds transfer, card payment, or cash. [ENUM-REF-CANDIDATE: check|ach|credit_card|debit_card|cash|money_order|wire_transfer|online|auto_pay — 9 candidates stripped; promote to reference product]',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment transaction. Tracks progression from initial receipt through clearing and application to customer account balance.. Valid values are `pending|applied|cleared|reversed|failed|cancelled`',
    `payment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the payment transaction was recorded in the billing system. Used for audit trail and transaction sequencing.',
    `payment_type` STRING COMMENT 'Classification of the payment transaction direction and purpose. Inbound payments represent cash receipts from customers; outbound refunds represent disbursements to customers.. Valid values are `inbound_payment|outbound_refund|credit_memo|debit_memo|adjustment`',
    `posting_date` DATE COMMENT 'Accounting date when the payment transaction was posted to the general ledger. May differ from payment_date due to batch processing timing or period-end cutoffs.',
    `reference_number` STRING COMMENT 'External reference number or confirmation code for the payment transaction. May include check number, ACH trace number, credit card authorization code, or online payment confirmation ID.',
    `refund_approval_status` STRING COMMENT 'Workflow status for refund approval process. Tracks management review and authorization for outbound refund disbursements. Null for inbound payments.. Valid values are `pending_approval|approved|rejected|disbursed`',
    `refund_approval_timestamp` TIMESTAMP COMMENT 'Date and time when the refund was approved for disbursement. Part of the audit trail for financial controls. Null for inbound payments.',
    `refund_approved_by` STRING COMMENT 'User ID or name of the employee who authorized the refund disbursement. Required for SOX compliance and audit trail. Null for inbound payments.',
    `refund_method` STRING COMMENT 'Method by which the refund is disbursed to the customer. May be check, ACH transfer, account credit, or reversal to original payment method. Null for inbound payments.. Valid values are `check|ach|account_credit|original_payment_method`',
    `refund_reason_code` STRING COMMENT 'Standardized code indicating the business reason for issuing a refund to the customer. Null for inbound payments. Used for refund analytics and regulatory reporting.. Valid values are `overpayment|deposit_return|credit_balance|billing_error|service_cancellation|duplicate_payment`',
    `reversal_date` DATE COMMENT 'Date when the payment was reversed. Null if payment has not been reversed.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this payment transaction has been reversed due to NSF (non-sufficient funds), chargeback, or administrative correction. True if reversed, false otherwise.',
    `reversal_reason_code` STRING COMMENT 'Standardized code indicating the reason for payment reversal. Includes NSF returns, chargebacks, disputes, and administrative corrections. Null if payment has not been reversed.. Valid values are `nsf|chargeback|customer_dispute|bank_return|administrative_error|fraud`',
    `source_system` STRING COMMENT 'Identifier of the source system or module that originated the payment transaction record. Examples include SAP IS-U FICA, Oracle CC&B, payment gateway integration, or third-party payment processor.',
    `transaction_reference` STRING COMMENT 'Unique transaction identifier assigned by the payment gateway or processor. Used for reconciliation, chargebacks, and technical support inquiries.',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'Portion of the payment amount that remains unapplied and held as account credit. Occurs when payment exceeds outstanding balance or when application is suspended pending dispute resolution.',
    `created_by` STRING COMMENT 'User ID or system identifier that created this payment record. May be a customer service representative, automated batch process, or payment gateway integration.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Transactional record of all customer payment activity including inbound payments received and outbound refunds disbursed against outstanding invoices or account balances. For inbound payments: captures payment date, amount, method (check, ACH, credit card, cash, online, auto-pay), channel (IVR, web, walk-in, mail), reference number, bank routing details, and application status. For outbound refunds: captures refund date, amount, disbursement method (check, ACH, account credit), reason code (overpayment, deposit return, credit balance, billing error), originating credit source, approval status, and disbursement confirmation. Sourced from SAP IS-U FICA and Oracle CC&B payment processing. SSOT for all cash receipts and disbursements in the revenue cycle. Supports cash application controls and SOX compliance.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` (
    `payment_arrangement_id` BIGINT COMMENT 'Unique identifier for the payment arrangement. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer account for which this payment arrangement was established.',
    `billing_service_agreement_id` BIGINT COMMENT 'FK to billing.service_agreement.service_agreement_id — Payment arrangements are established for a specific service agreement with past-due balances.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to trading.counterparty. Business justification: Payment arrangements with wholesale trading counterparties for deferred settlement payments reference the counterparty entity. Required for credit risk management, ISDA/CSA compliance, and counterpart',
    `approval_date` DATE COMMENT 'Date when the payment arrangement was formally approved and became binding.',
    `arrangement_end_date` DATE COMMENT 'Scheduled date when the final installment is due and the arrangement is expected to be completed. Nullable for open-ended arrangements.',
    `arrangement_for_collections_case` BIGINT COMMENT 'FK to billing.collections_case.collections_case_id — Payment arrangements are negotiated to resolve a collections case. This FK links the installment plan to the delinquent balance being resolved.',
    `arrangement_number` STRING COMMENT 'Business-facing unique identifier for the payment arrangement, typically displayed on customer correspondence and used in collections workflows.. Valid values are `^PA[0-9]{10}$`',
    `arrangement_start_date` DATE COMMENT 'Effective date when the payment arrangement becomes binding and the first installment schedule begins.',
    `arrangement_status` STRING COMMENT 'Current lifecycle state of the payment arrangement. Draft indicates pending approval; active means in effect and customer is making payments; completed when all obligations fulfilled; breached when customer missed payment(s) per terms; cancelled when voided before completion; suspended when temporarily paused by mutual agreement.. Valid values are `draft|active|completed|breached|cancelled|suspended`',
    `arrangement_type` STRING COMMENT 'Classification of the payment arrangement structure. Installment plan spreads balance over fixed payments; deferred payment postpones full payment to future date; settlement agreement resolves disputed balance; budget billing equalizes monthly payments; hardship plan offers reduced terms for financial distress; promise to pay is short-term commitment.. Valid values are `installment_plan|deferred_payment|settlement_agreement|budget_billing|hardship_plan|promise_to_pay`',
    `auto_pay_enrolled_flag` BOOLEAN COMMENT 'Indicates whether customer enrolled in automatic payment processing for installments, reducing risk of missed payments.',
    `breach_date` DATE COMMENT 'Date when the payment arrangement was breached due to missed payments exceeding the threshold. Nullable if arrangement has not been breached.',
    `breach_reason` STRING COMMENT 'Explanation of why the arrangement was breached, typically referencing specific missed payments or violation of terms. Nullable if not breached.',
    `breach_threshold` STRING COMMENT 'Maximum number of missed installments allowed before the arrangement is automatically breached and collections actions resume. Typically 1 or 2 missed payments.',
    `cancellation_date` DATE COMMENT 'Date when the payment arrangement was cancelled before completion. Nullable if arrangement was not cancelled.',
    `cancellation_reason` STRING COMMENT 'Explanation of why the arrangement was cancelled, such as customer request, account closure, or administrative error. Nullable if not cancelled.',
    `completion_date` DATE COMMENT 'Date when all installment obligations were fulfilled and the arrangement was successfully completed. Nullable if not yet completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment arrangement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this arrangement. Typically USD for US utilities.. Valid values are `^[A-Z]{3}$`',
    `customer_signature_received_flag` BOOLEAN COMMENT 'Indicates whether customer signature or electronic acceptance was obtained for the arrangement terms, required for enforceability.',
    `down_payment_amount` DECIMAL(18,2) COMMENT 'Initial payment required at arrangement establishment to demonstrate good faith and reduce the principal balance before installments begin. Zero if no down payment required.',
    `down_payment_received_date` DATE COMMENT 'Date when the down payment was actually received and posted to the account. Nullable if down payment not yet received or not required.',
    `first_installment_due_date` DATE COMMENT 'Date when the first scheduled installment payment is due, typically 30 days after arrangement start date or aligned with customer billing cycle.',
    `installment_amount` DECIMAL(18,2) COMMENT 'Fixed amount due for each regular installment payment. Calculated by dividing remaining balance after down payment by number of installments.',
    `installment_frequency` STRING COMMENT 'Cadence at which installment payments are scheduled. Monthly is most common for utility payment arrangements.. Valid values are `weekly|biweekly|monthly|quarterly`',
    `installments_missed_count` STRING COMMENT 'Number of scheduled installment payments that were not received by their due date. Exceeding the allowed threshold triggers breach status.',
    `installments_paid_count` STRING COMMENT 'Number of installment payments successfully received and posted to date. Used to track customer compliance with arrangement terms.',
    `interest_accrued_amount` DECIMAL(18,2) COMMENT 'Total interest charges accumulated on the outstanding balance since arrangement start. Updated periodically based on interest calculation schedule.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate applied to the outstanding balance, expressed as a percentage. Zero if arrangement is interest-free per utility policy or regulatory requirement.',
    `last_installment_due_date` DATE COMMENT 'Date when the final installment payment is due, marking the scheduled completion of the arrangement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment arrangement record was most recently updated, reflecting status changes, payment postings, or term modifications.',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'Total late payment fees assessed for missed or delayed installments. May be waived under hardship arrangements.',
    `notes` STRING COMMENT 'Free-text field for customer service representatives to document special circumstances, negotiation details, or customer commitments related to the arrangement.',
    `notification_preference` STRING COMMENT 'Customer preferred channel for receiving payment reminders and arrangement status updates.. Valid values are `email|sms|mail|phone|none`',
    `number_of_installments` STRING COMMENT 'Total count of scheduled installment payments in the arrangement. Typically ranges from 3 to 24 months depending on utility policy and customer circumstances.',
    `payment_method_code` STRING COMMENT 'Primary payment instrument the customer will use for installment payments.. Valid values are `bank_draft|credit_card|debit_card|check|cash|electronic_funds_transfer`',
    `remaining_balance` DECIMAL(18,2) COMMENT 'Current outstanding balance under the payment arrangement after subtracting down payment and any installments paid to date. Updated as payments are received.',
    `total_amount_owed` DECIMAL(18,2) COMMENT 'Total outstanding balance at the time the payment arrangement was established, representing the principal amount to be repaid through the arrangement.',
    `waived_fees_amount` DECIMAL(18,2) COMMENT 'Total amount of late fees, interest, or other charges waived as part of the arrangement negotiation or hardship consideration.',
    CONSTRAINT pk_payment_arrangement PRIMARY KEY(`payment_arrangement_id`)
) COMMENT 'Master entity representing a formal installment or deferred payment plan negotiated with a customer to resolve past-due balances. Captures arrangement type, total amount owed, number of installments, installment amounts, scheduled payment dates, down payment, arrangement status, breach conditions, and associated collections case. Managed within SAP IS-U FICA and Oracle CC&B collections modules.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`billing`.`determinant` (
    `determinant_id` BIGINT COMMENT 'Unique identifier for the billing determinant record. Primary key for this entity.',
    `billing_service_agreement_id` BIGINT COMMENT 'Reference to the service agreement for which this billing determinant was calculated. Links to the customer service agreement that defines the rate schedule and billing terms.',
    `curtailment_event_id` BIGINT COMMENT 'Foreign key linking to renewable.curtailment_event. Business justification: Billing determinants for renewable generators and NEM customers are adjusted during curtailment events — curtailed kWh must be excluded from or credited in billing calculations. Linking determinant to',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to billing.billing_cycle. Business justification: Billing determinants are calculated for a specific billing cycle execution. Currently billing_determinant has billing_cycle_code (STRING) but no FK to billing_cycle. This FK enables joining to retriev',
    `der_registry_id` BIGINT COMMENT 'Foreign key linking to renewable.der_registry. Business justification: Billing determinants calculate net metering export/import quantities from specific DER installations. Required to attribute generation, apply correct export rates, calculate demand charges with DER of',
    `der_system_id` BIGINT COMMENT 'Foreign key linking to interconnection.der_system. Business justification: Billing determinants for DER customers must account for system-specific characteristics (nameplate capacity, export capability, inverter type) to calculate net metering correctly. Business process: Mo',
    `dr_enrollment_id` BIGINT COMMENT 'Foreign key linking to demand.demand_dr_enrollment. Business justification: Billing determinants for DR-enrolled customers must reference the specific enrollment to apply the correct baseline methodology, enrolled capacity, and TOU adjustments during determinant calculation. ',
    `dr_event_id` BIGINT COMMENT 'Foreign key linking to demand.dr_event. Business justification: Billing determinants (peak demand, TOU consumption) may be affected by DR events that alter normal consumption patterns. Baseline calculations, billing validation, and dispute resolution require under',
    `energy_schedule_id` BIGINT COMMENT 'Foreign key linking to trading.energy_schedule. Business justification: Billing determinants for scheduled energy customers are reconciled against ISO/RTO energy schedules. Schedule-vs-actual imbalance determinants require direct reference to the submitted energy schedule',
    `feeder_id` BIGINT COMMENT 'Foreign key linking to distribution.feeder. Business justification: Advanced metering analytics aggregate consumption by feeder for load forecasting, capacity planning, demand response program design, and feeder-level revenue analysis. Supports distribution planning a',
    `generation_meter_read_id` BIGINT COMMENT 'Foreign key linking to renewable.generation_meter_read. Business justification: Billing determinants for renewable generation customers are calculated from generation meter reads. Linking determinant to generation_meter_read enables direct source data traceability for billing val',
    `grid_reliability_event_id` BIGINT COMMENT 'Foreign key linking to grid.grid_reliability_event. Business justification: Grid reliability events (outages, frequency excursions) directly trigger billing determinant adjustments — demand ratchet waivers, outage credits, and TOU period corrections. Linking determinant to th',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Billing determinants are consumed during invoice generation to calculate charges. This FK links determinants to the invoice they contributed to, enabling traceability from invoice back to source deter',
    `lmp_price_id` BIGINT COMMENT 'Foreign key linking to trading.lmp_price. Business justification: Real-time pricing tariffs calculate interval-specific charges using LMP data matched to customer consumption intervals; critical for TOU programs, dynamic pricing pilots, and regulatory cost-of-servic',
    `load_id` BIGINT COMMENT 'Foreign key linking to forecast.load. Business justification: Actual-vs-forecast variance analysis: comparing billed determinant quantities (actual consumption/demand) against load forecasts is a core IRP validation and regulatory reporting process. Utilities mu',
    `market_settlement_id` BIGINT COMMENT 'Foreign key linking to trading.market_settlement. Business justification: Billing determinants for wholesale market participants are calculated from market settlement quantities. The settlement record is the authoritative source for billed MWh/MW quantities used in determin',
    `meter_id` BIGINT COMMENT 'Reference to the meter from which the interval data was sourced. Links to the physical or virtual meter device in the Advanced Metering Infrastructure (AMI).',
    `meter_point_id` BIGINT COMMENT 'Foreign key linking to metering.meter_point. Business justification: Billing determinants calculate usage for service points, incorporating network topology (feeder, transformer) and rate schedule context. Service point is the fundamental unit for TOU period assignment',
    `nem_account_id` BIGINT COMMENT 'Foreign key linking to renewable.nem_account. Business justification: Billing determinants for NEM customers (net export kWh, net import kWh, cumulative credit balance) are calculated at the NEM account level. Direct NEM account reference enables accurate true-up determ',
    `nem_agreement_id` BIGINT COMMENT 'Foreign key linking to interconnection.nem_agreement. Business justification: Billing determinants for NEM customers (net_metering_export_kwh, net_metering_import_kwh, net_metering_credit columns present) are calculated under a specific NEM agreement. Linking determinant to NEM',
    `outage_event_id` BIGINT COMMENT 'Foreign key linking to generation.outage_event. Business justification: Billing determinants for outage interruption credits (lost kWh, outage duration) must reference the specific generation outage event causing the service interruption. PUC-mandated reliability credit c',
    `peak_demand_id` BIGINT COMMENT 'Foreign key linking to forecast.peak_demand. Business justification: IRP capacity planning validation: comparing actual billed peak demand (determinant.peak_demand_kw) against forecasted peak demand is a mandatory regulatory process for resource adequacy filings. Utili',
    `pnode_id` BIGINT COMMENT 'Foreign key linking to transmission.pnode. Business justification: Billing determinants for nodal-priced transmission customers (large industrials, wholesale loads) must reference the settlement PNode to apply correct LMP. determinant already has lmp_price_id but lac',
    `ppa_contract_id` BIGINT COMMENT 'Foreign key linking to renewable.ppa_contract. Business justification: Billing determinants for PPA customers are calculated using contracted PPA rates and delivery volumes. Linking determinant to ppa_contract enables automated rate validation against contracted terms du',
    `ppa_delivery_id` BIGINT COMMENT 'Foreign key linking to trading.ppa_delivery. Business justification: Billing determinants for PPA-based customers (net metering, virtual PPA) are derived from PPA delivery records. The delivered MWh quantity from the PPA delivery record becomes the billing determinant ',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.rate_schedule. Business justification: Billing determinants are calculated according to a specific rate schedules rules and structure. Currently billing_determinant has rate_schedule_code (STRING) but no FK to the rate_schedule master ent',
    `event_id` BIGINT COMMENT 'Foreign key linking to outage.event. Business justification: Billing determinants during outage periods require estimated reads or special calculation methods. Linking determinant to outage.event identifies which consumption calculations were affected by an out',
    `vpp_configuration_id` BIGINT COMMENT 'Foreign key linking to renewable.vpp_configuration. Business justification: Billing determinants for VPP-enrolled customers include dispatch quantities and performance metrics tied to specific VPP configurations. Direct VPP configuration reference enables accurate VPP-specifi',
    `adjustment_reason_code` STRING COMMENT 'Code indicating why the billing determinants were manually adjusted after initial calculation. Used for audit trail and to track common data quality issues requiring manual intervention. Examples include meter malfunction, CT/PT ratio correction, or billing dispute resolution.',
    `billing_cycle_code` STRING COMMENT 'Code identifying the billing cycle schedule to which this service agreement belongs. Used to group customers for batch billing processing and to coordinate meter reading, determinant calculation, and invoice generation schedules.',
    `billing_days` STRING COMMENT 'Number of calendar days in the billing period. Used for pro-ration calculations, average daily usage metrics, and normalization of consumption data for year-over-year comparisons.',
    `billing_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to meter readings to account for Current Transformer (CT) and Potential Transformer (PT) ratios in high-voltage metering installations. Converts secondary meter readings to primary consumption values. Typically greater than 1 for commercial and industrial customers.',
    `calculation_method` STRING COMMENT 'Method used to derive the billing determinants from meter data. Indicates whether values were calculated from actual interval data, estimated due to missing data, or derived using special algorithms for net metering or demand windowing.. Valid values are `interval_sum|demand_window|tou_allocation|net_metering|estimated`',
    `calculation_timestamp` TIMESTAMP COMMENT 'The date and time when the billing determinants were calculated from validated meter interval data. Represents the business event time when MDM output was transformed into billing inputs.',
    `comments` STRING COMMENT 'Free-text field for billing analysts to document special circumstances, data quality issues, manual adjustments, or other notes relevant to this billing determinant record. Used for audit trail and knowledge transfer.',
    `contract_demand_kw` DECIMAL(18,2) COMMENT 'The contracted maximum demand level agreed upon between the utility and customer. Used for rate schedules where customers commit to a minimum demand level in exchange for favorable pricing. Excess demand above this level may incur penalty charges.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this billing determinant record was first created in the system. Used for audit trail and data lineage tracking.',
    `critical_peak_kwh` DECIMAL(18,2) COMMENT 'Energy consumption during Critical Peak Pricing (CPP) event hours. Used for CPP rate schedules where utilities invoke premium pricing during grid stress events (typically 10-15 days per year).',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Composite score (0-100) representing the quality of the underlying meter interval data used to calculate these determinants. Considers factors such as percentage of actual vs estimated readings, validation rule pass rate, and data completeness. Used to flag determinants requiring manual review.',
    `estimated_interval_count` STRING COMMENT 'Number of meter intervals that were estimated rather than actual readings. Used for data quality assessment and to flag billing determinants that may require review due to missing or invalid meter data.',
    `interval_count` STRING COMMENT 'Number of meter interval readings used to calculate these billing determinants. Typically 2,880 intervals for 15-minute data over a 30-day period, or 1,440 intervals for 30-minute data. Used for data quality validation.',
    `is_final_determinant` BOOLEAN COMMENT 'Flag indicating whether this is the final, validated billing determinant record for the billing period (true) or a preliminary/estimated version (false). Used to prevent duplicate billing and ensure only validated determinants are passed to the billing engine.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this billing determinant record was last updated. Used for audit trail, change tracking, and identifying records that have been manually adjusted after initial calculation.',
    `load_factor` DECIMAL(18,2) COMMENT 'Ratio of average load to peak load during the billing period, calculated as (total_kwh / (peak_demand_kw * billing_hours)). Indicates how efficiently the customer uses their peak capacity. Values range from 0 to 1, with higher values indicating more consistent usage patterns.',
    `mid_peak_kwh` DECIMAL(18,2) COMMENT 'Energy consumption during mid-peak TOU periods (shoulder hours between on-peak and off-peak). Used for TOU rate schedules with three-tier time-based pricing.',
    `modified_by_user` STRING COMMENT 'User ID or system identifier of the person or process that last modified this billing determinant record. Used for audit trail and accountability in SOX compliance reporting.',
    `net_metering_export_kwh` DECIMAL(18,2) COMMENT 'Energy exported to the grid from customer-owned Distributed Energy Resources (DER) such as rooftop solar. Used for Net Energy Metering (NEM) rate schedules where exported energy is credited against consumption or compensated at a specified rate.',
    `net_metering_import_kwh` DECIMAL(18,2) COMMENT 'Energy imported from the grid by customers with Distributed Energy Resources (DER). Used for Net Energy Metering (NEM) rate schedules to calculate net consumption after accounting for on-site generation.',
    `off_peak_demand_kw` DECIMAL(18,2) COMMENT 'Maximum power demand during off-peak TOU periods. Used for rate schedules that apply separate demand charges for off-peak periods.',
    `off_peak_kwh` DECIMAL(18,2) COMMENT 'Energy consumption during off-peak TOU periods (typically nights and weekends when grid demand is lower). Used for TOU rate calculations with discounted pricing.',
    `on_peak_demand_kw` DECIMAL(18,2) COMMENT 'Maximum power demand during on-peak TOU periods. Used for rate schedules that apply separate demand charges for on-peak versus off-peak periods.',
    `on_peak_kwh` DECIMAL(18,2) COMMENT 'Energy consumption during on-peak TOU periods (typically weekday afternoons when grid demand is highest). Used for TOU and CPP rate calculations with premium pricing.',
    `peak_demand_kw` DECIMAL(18,2) COMMENT 'Maximum instantaneous power demand in kilowatts recorded during the billing period. Used for demand-based rate schedules common in commercial and industrial tariffs. Typically measured as the highest 15-minute or 30-minute interval average.',
    `peak_demand_timestamp` TIMESTAMP COMMENT 'Date and time when the peak demand (kW) occurred during the billing period. Used for demand response analysis, load profiling, and customer engagement regarding demand management opportunities.',
    `power_factor` DECIMAL(18,2) COMMENT 'Ratio of real power (kW) to apparent power (kVA) during the billing period, typically calculated at the time of peak demand. Used to assess power quality and apply power factor adjustment charges. Values range from 0 to 1, with 1.0 representing ideal unity power factor.',
    `ratchet_demand_kw` DECIMAL(18,2) COMMENT 'Demand value used for ratchet clause billing, typically a percentage (e.g., 80%) of the highest demand recorded in the previous 11 months. Used in commercial and industrial rate schedules to ensure minimum demand charges even during low-usage months.',
    `reactive_demand_kvar` DECIMAL(18,2) COMMENT 'Maximum reactive power demand in kilovolt-amperes reactive during the billing period. Used for power factor penalties or reactive power charges in industrial and large commercial rate schedules.',
    `source_system` STRING COMMENT 'System of record from which the meter interval data originated. Indicates whether data came from Meter Data Management (MDM), Advanced Metering Infrastructure (AMI), manual meter reading, estimation algorithms, or SCADA systems.. Valid values are `mdm|ami|manual_entry|estimated|scada`',
    `temperature_normalized_kwh` DECIMAL(18,2) COMMENT 'Energy consumption adjusted for weather variations using heating degree days (HDD) and cooling degree days (CDD). Used for load forecasting, energy efficiency program evaluation, and customer usage comparisons across different weather conditions.',
    `total_kwh` DECIMAL(18,2) COMMENT 'Total energy consumption in kilowatt-hours for the billing period. Sum of all interval data across all Time-of-Use (TOU) periods. Primary determinant for energy charges.',
    `tou_period_1_kwh` DECIMAL(18,2) COMMENT 'Energy consumption for TOU period 1 as defined in the rate schedule. Supports rate schedules with custom TOU period definitions beyond standard on-peak/off-peak/mid-peak classifications.',
    `tou_period_2_kwh` DECIMAL(18,2) COMMENT 'Energy consumption for TOU period 2 as defined in the rate schedule. Supports rate schedules with custom TOU period definitions beyond standard on-peak/off-peak/mid-peak classifications.',
    `tou_period_3_kwh` DECIMAL(18,2) COMMENT 'Energy consumption for TOU period 3 as defined in the rate schedule. Supports rate schedules with custom TOU period definitions beyond standard on-peak/off-peak/mid-peak classifications.',
    `tou_period_4_kwh` DECIMAL(18,2) COMMENT 'Energy consumption for TOU period 4 as defined in the rate schedule. Supports rate schedules with custom TOU period definitions beyond standard on-peak/off-peak/mid-peak classifications.',
    `validation_status` STRING COMMENT 'Current validation state of the billing determinants. Indicates whether the calculated values have passed automated validation rules, require manual review, or have been adjusted by billing analysts.. Valid values are `validated|pending_review|failed_validation|manually_adjusted|estimated`',
    CONSTRAINT pk_determinant PRIMARY KEY(`determinant_id`)
) COMMENT 'Calculated billing determinant records derived from validated meter interval data for a specific service agreement and billing period. Stores total kWh, on-peak/off-peak kWh, peak demand (kW), reactive demand (kVAR), power factor, billing multiplier, and TOU period breakdowns. Bridges metering domain MDM output to the billing engine for rate calculation. Critical for TOU, CPP, and demand-based rate schedules.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`billing`.`adjustment` (
    `adjustment_id` BIGINT COMMENT 'Unique identifier for the financial adjustment transaction. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer account to which this adjustment is applied.',
    `invoice_id` BIGINT COMMENT 'FK to billing.invoice.invoice_id — Adjustments are typically applied against a specific invoice or billing period. This FK enables audit trail from adjustment back to the original billed amount. Critical for SOX controls.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to interconnection.interconnection_agreement. Business justification: Billing adjustments for interconnection charges (standby charge corrections, network upgrade cost true-ups) must reference the governing interconnection agreement. The existing adjustment.interconnect',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Billing adjustments frequently result from audit findings requiring correction of billing errors, rate misapplication, or compliance violations. Links adjustment to the specific finding that triggered',
    `billing_service_agreement_id` BIGINT COMMENT 'FK to billing.service_agreement.service_agreement_id — Adjustments are posted to a service agreement. Required for account-level balance tracking.',
    `curtailment_event_id` BIGINT COMMENT 'Foreign key linking to renewable.curtailment_event. Business justification: Curtailment events trigger billing adjustments (curtailment credits, lost revenue credits) to generators and customers. Linking adjustment to curtailment_event supports regulatory reporting of curtail',
    `der_registry_id` BIGINT COMMENT 'Foreign key linking to renewable.der_registry. Business justification: DER-related billing adjustments (interconnection cost adjustments, DER performance credits, commissioning adjustments) must reference the specific DER asset for regulatory reporting and asset-level bi',
    `enforcement_action_id` BIGINT COMMENT 'Foreign key linking to compliance.enforcement_action. Business justification: Billing adjustments are frequently mandated by PUC enforcement action orders (refund orders, penalty pass-through orders). Linking adjustment to enforcement_action enables tracking of financial remedi',
    `failure_event_id` BIGINT COMMENT 'Foreign key linking to asset.failure_event. Business justification: Asset equipment failures (transformer failures, cable faults) causing extended outages trigger service credit adjustments per tariff or regulatory mandate. Linking the billing adjustment to the specif',
    `feeder_id` BIGINT COMMENT 'Foreign key linking to distribution.feeder. Business justification: PUC-mandated outage credit adjustments are issued to all customers on an affected feeder. Feeder-level adjustment reporting is required for reliability-based billing credits (SAIDI/SAIFI) and regulato',
    `grid_reliability_event_id` BIGINT COMMENT 'Foreign key linking to grid.grid_reliability_event. Business justification: When grid reliability events (outages, voltage issues) impact customers, utilities issue billing adjustments as service credits. Real business process: customer compensation for reliability events. Ad',
    `incentive_application_id` BIGINT COMMENT 'Foreign key linking to renewable.incentive_application. Business justification: Incentive application clawbacks and recalculation adjustments after post-installation audits must reference the specific incentive application. Regulatory compliance requires traceability from billing',
    `incentive_program_id` BIGINT COMMENT 'Foreign key linking to renewable.incentive_program. Business justification: Incentive program clawbacks and recalculation adjustments on customer bills must reference the specific incentive program for program compliance tracking and regulatory reporting of program cost adjus',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to asset.inspection. Business justification: Meter tampering, diversion, or unauthorized use discovered during asset inspections triggers back-billing adjustments. Utilities must link the billing adjustment to the inspection finding for regulato',
    `application_id` BIGINT COMMENT 'Foreign key linking to interconnection.application. Business justification: Billing adjustments frequently result from interconnection process errors: wrong meter configuration during commissioning, delayed PTO affecting rate effective dates, or disputed export credit calcula',
    `interruption_id` BIGINT COMMENT 'Foreign key linking to outage.interruption. Business justification: Individual service interruption records drive per-customer outage credit calculations (duration-based SLA credits, regulatory outage compensation). Linking billing.adjustment to outage.interruption en',
    `market_settlement_id` BIGINT COMMENT 'Foreign key linking to trading.market_settlement. Business justification: ISO settlement re-runs and true-ups trigger billing adjustments for retail customers on pass-through rates; direct settlement linkage enables automated correction posting, variance analysis, and regul',
    `meter_point_id` BIGINT COMMENT 'Foreign key linking to metering.meter_point. Business justification: Adjustments frequently result from meter test failures, VEE corrections, or service point configuration errors. This link identifies which service point triggered the adjustment, supports regulatory a',
    `nem_account_id` BIGINT COMMENT 'Foreign key linking to renewable.nem_account. Business justification: NEM true-up adjustments are a specific billing adjustment type requiring direct reference to the NEM account for accurate credit calculation, annual true-up processing, and state PUC regulatory report',
    `nem_agreement_id` BIGINT COMMENT 'Foreign key linking to interconnection.nem_agreement. Business justification: NEM billing adjustments (export credit true-ups, compensation rate corrections) must reference the NEM agreement governing the credit terms. adjustment already has nem_credit_amount and nem_exported_k',
    `outage_event_id` BIGINT COMMENT 'Foreign key linking to generation.generation_outage_event. Business justification: Utilities issue billing adjustments (credits/refunds) to customers affected by generation outages. Regulatory and audit requirements mandate traceability from customer billing adjustment to the causal',
    `planned_outage_window_id` BIGINT COMMENT 'Foreign key linking to outage.planned_outage_window. Business justification: Planned outage windows trigger proactive billing adjustments and regulatory-mandated advance-notice credits for affected customers. Linking adjustment to planned_outage_window supports planned outage ',
    `ppa_settlement_id` BIGINT COMMENT 'Foreign key linking to renewable.ppa_settlement. Business justification: Billing adjustments for curtailment credits and imbalance charges are triggered by PPA settlement quantity variances. Direct traceability from customer-facing adjustment to the wholesale settlement ev',
    `reversed_adjustment_id` BIGINT COMMENT 'Reference to the original adjustment_id that this transaction reverses. Null if this is not a reversal. Used to maintain audit trail of adjustment corrections.',
    `rps_obligation_id` BIGINT COMMENT 'Foreign key linking to renewable.rps_obligation. Business justification: ACP (Alternative Compliance Payment) adjustments and REC retirement adjustments on customer bills must reference the RPS obligation period for state PUC regulatory reporting. This is a real compliance',
    `event_id` BIGINT COMMENT 'Foreign key linking to outage.event. Business justification: Utilities issue regulatory-mandated and SLA-driven bill credits for service interruptions. The billing adjustment must reference the specific OMS outage event that triggered the credit. Role prefix s',
    `settlement_statement_id` BIGINT COMMENT 'Foreign key linking to trading.settlement_statement. Business justification: ISO/RTO resettlement statements trigger billing adjustments when corrected settlement quantities differ from original billing. The settlement_statement is the source document for the adjustment, requi',
    `storm_event_id` BIGINT COMMENT 'Foreign key linking to outage.storm_event. Business justification: Major storm events trigger mass billing adjustments and regulatory storm credits for affected customers. Linking billing.adjustment to outage.storm_event supports storm credit processing, PUC reportin',
    `to_invoice_id` BIGINT COMMENT 'FK to billing.invoice.invoice_id — Adjustments are frequently applied against a specific invoice (rate correction, estimated-to-actual true-up). This FK supports audit trail and SOX controls.',
    `trade_id` BIGINT COMMENT 'Foreign key linking to trading.trade. Business justification: Billing adjustments for wholesale trade settlement discrepancies require trade reference for complete audit trail, dispute resolution with counterparties, and regulatory compliance documentation when ',
    `transmission_outage_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_outage. Business justification: Transmission outages trigger service interruption credits and reliability-based billing adjustments (OATT curtailment compensation). billing.adjustment already links to generation outages; a separate ',
    `vpp_configuration_id` BIGINT COMMENT 'Foreign key linking to renewable.vpp_configuration. Business justification: VPP performance penalty and bonus adjustments on customer bills must reference the VPP configuration for regulatory reporting and incentive reconciliation. State PUC VPP program cost reporting require',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Billing adjustments frequently result from field work: meter test failures, equipment malfunctions, service quality issues. Customer service representatives and auditors require traceability from adju',
    `adjustment_date` DATE COMMENT 'The business date when the adjustment transaction was created and recorded in the billing system. This is the principal business event timestamp for the adjustment.',
    `adjustment_number` STRING COMMENT 'Human-readable business identifier for the adjustment transaction, often displayed on customer correspondence and used for customer service reference.',
    `adjustment_type` STRING COMMENT 'Classification of the adjustment transaction indicating the nature of the financial change applied to the account or invoice. [ENUM-REF-CANDIDATE: credit|debit|rebate|rate_correction|estimated_to_actual_trueup|regulatory_surcharge|nem_credit|write_off|late_fee_reversal|deposit_refund|billing_error_correction — 11 candidates stripped; promote to reference product]',
    `affected_billing_period_end` DATE COMMENT 'End date of the billing period to which this adjustment applies. Used for period-specific rate corrections and estimated-to-actual true-ups.',
    `affected_billing_period_start` DATE COMMENT 'Start date of the billing period to which this adjustment applies. Used for period-specific rate corrections and estimated-to-actual true-ups.',
    `amount` DECIMAL(18,2) COMMENT 'The monetary value of the adjustment. Positive values represent debits (charges to customer), negative values represent credits (refunds or reductions). Expressed in the accounts billing currency.',
    `approval_date` DATE COMMENT 'Date when the adjustment was approved by an authorized user or system process. Null if still pending approval.',
    `approval_status` STRING COMMENT 'Current approval state of the adjustment in the workflow. Supports SOX financial controls requiring segregation of duties for material adjustments.. Valid values are `pending|approved|rejected|auto_approved|escalated|cancelled`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which the adjustment amount is denominated.. Valid values are `^[A-Z]{3}$`',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this adjustment is related to a customer dispute or complaint resolution. True if dispute-related, False otherwise.',
    `effective_date` DATE COMMENT 'The date from which the adjustment becomes effective for accounting and revenue recognition purposes. May differ from adjustment_date for backdated corrections.',
    `gl_posting_date` DATE COMMENT 'The date when this adjustment was posted to the general ledger. Null if not yet posted. Used for financial period reconciliation and revenue recognition.',
    `invoice` BIGINT COMMENT 'FK to billing.invoice.invoice_id — Adjustments are applied against specific invoices or billing periods. Critical for AR reconciliation and SOX controls.',
    `nem_credit_amount` DECIMAL(18,2) COMMENT 'For NEM credit adjustments: the total monetary credit amount calculated as nem_exported_kwh multiplied by nem_credit_rate. This amount is applied as a credit to the customer account. Null for non-NEM adjustments.',
    `nem_credit_expiration_date` DATE COMMENT 'For NEM credit adjustments: the date when unused NEM credits expire per the applicable NEM tariff rules (typically 12 months from generation). Null for non-NEM adjustments or jurisdictions without credit expiration.',
    `nem_credit_rate` DECIMAL(18,2) COMMENT 'For NEM credit adjustments: the per-kWh credit rate applied to exported energy, expressed in currency per kWh. Rate is determined by the applicable NEM tariff and may vary by time-of-use period. Null for non-NEM adjustments.',
    `nem_cumulative_credit_balance` DECIMAL(18,2) COMMENT 'For NEM credit adjustments: the cumulative balance of NEM credits on the customer account after this adjustment is applied. Used to track credit carryover across billing periods. Null for non-NEM adjustments.',
    `nem_exported_kwh` DECIMAL(18,2) COMMENT 'For NEM credit adjustments: the quantity of energy in kilowatt-hours exported by the customers behind-the-meter generation system to the grid during the billing period. Null for non-NEM adjustments.',
    `nem_tariff_version` STRING COMMENT 'For NEM credit adjustments: the version identifier of the NEM tariff applied to this adjustment (e.g., NEM 1.0, NEM 2.0, NEM 3.0). Different tariff versions have different credit calculation rules. Null for non-NEM adjustments.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or context about the adjustment. Used by customer service representatives and billing analysts for documentation.',
    `posted_to_gl_flag` BOOLEAN COMMENT 'Indicates whether this adjustment has been posted to the general ledger for financial reporting. True if posted, False if pending. Supports SOX financial controls and month-end close processes.',
    `reason_code` STRING COMMENT 'Standardized code indicating the business reason for the adjustment (e.g., meter read correction, customer complaint resolution, regulatory mandate, billing system error).',
    `reason_description` STRING COMMENT 'Free-text explanation providing additional context and details about why the adjustment was made, often used for audit trails and customer communication.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this adjustment record was first created in the source system. Used for audit trails and data lineage.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this adjustment record was last modified in the source system. Used for audit trails and change tracking.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this adjustment must be included in regulatory compliance reporting to state PUC, FERC, or other governing bodies. True if reportable, False otherwise.',
    `revenue_class` STRING COMMENT 'Classification of the adjustment by revenue category for regulatory reporting and financial analysis. Aligns with FERC Uniform System of Accounts and state PUC reporting requirements. [ENUM-REF-CANDIDATE: energy_sales|distribution_charges|transmission_charges|regulatory_surcharges|ancillary_services|nem_credits|other — 7 candidates stripped; promote to reference product]',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this adjustment is a reversal of a previous adjustment transaction. True if this is a reversal, False otherwise.',
    `source_document_reference` STRING COMMENT 'Reference identifier to the originating document or transaction in the source system (e.g., work order number, service request ID, regulatory filing reference). Used for audit trails and root cause analysis.',
    `source_system` STRING COMMENT 'The operational system or process that originated this adjustment transaction. Used for data lineage and reconciliation.. Valid values are `SAP_ISU|Oracle_CCB|MDM|Manual_Entry|Automated_Process|Customer_Portal`',
    `tariff_code` STRING COMMENT 'Rate schedule or tariff code applicable to this adjustment, particularly for rate corrections and regulatory surcharge adjustments. References the approved tariff on file with the regulatory authority.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax component of the adjustment amount, if applicable. Null for non-taxable adjustments. Used for sales tax, utility tax, and other applicable taxes.',
    `tax_jurisdiction_code` STRING COMMENT 'Code identifying the tax jurisdiction applicable to this adjustment. Used for multi-jurisdictional tax compliance and reporting.',
    `write_off_flag` BOOLEAN COMMENT 'Indicates whether this adjustment represents a bad debt write-off. True if this is a write-off, False otherwise. Used for accounts receivable aging and collections reporting.',
    `write_off_reason_code` STRING COMMENT 'Standardized code indicating the reason for write-off (e.g., bankruptcy, uncollectible, deceased customer, small balance). Null for non-write-off adjustments.',
    CONSTRAINT pk_adjustment PRIMARY KEY(`adjustment_id`)
) COMMENT 'Transactional record of a financial adjustment applied to a customer account or invoice, including credits, debits, rebates, rate corrections, estimated-to-actual true-ups, regulatory surcharge adjustments, and NEM (Net Energy Metering) credits for behind-the-meter generation. Captures adjustment type, reason code, amount, affected billing period, approval status, authorizing user, and source invoice reference. For NEM credit adjustments: stores exported kWh, credit rate ($/kWh), credit amount, cumulative credit balance, credit expiration date, and applicable NEM tariff version. Sourced from SAP IS-U FICA, Oracle CC&B adjustment processing, and NEM billing modules. SSOT for all financial adjustments including NEM credits. Supports SOX financial controls, revenue recognition, and state NEM/RPS regulatory compliance reporting.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`billing`.`deposit` (
    `deposit_id` BIGINT COMMENT 'Unique identifier for the customer security deposit record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer account for which this deposit is held. Links to the customer billing account in CIS.',
    `billing_service_agreement_id` BIGINT COMMENT 'FK to billing.billing_service_agreement.billing_service_agreement_id — Security deposits are collected against a specific service agreement. This FK enables deposit tracking, refund eligibility, and regulatory compliance for deposit rules.',
    `accrued_interest_amount` DECIMAL(18,2) COMMENT 'Total interest earned on the deposit from collection date to current date, calculated per regulatory interest rate requirements. Many PUCs mandate interest payment on customer deposits held beyond specified periods.',
    `amount` DECIMAL(18,2) COMMENT 'Original principal amount of the deposit collected from or guaranteed by the customer, in the utilitys functional currency. Does not include accrued interest.',
    `collection_date` DATE COMMENT 'Date the deposit was collected from the customer or the guarantee instrument became effective. Serves as the start date for interest accrual and regulatory holding period calculations.',
    `collection_method` STRING COMMENT 'Payment method or mechanism used to collect the cash deposit from the customer. Does not apply to surety bonds or letters of credit which are third-party guarantees.. Valid values are `cash|check|credit_card|bank_transfer|payroll_deduction|installment_plan`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the deposit record was first created in the CIS or FICA system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the deposit amount. Supports multi-currency operations for utilities operating across jurisdictions.. Valid values are `^[A-Z]{3}$`',
    `deposit_number` STRING COMMENT 'Business-facing unique identifier for the deposit, used in customer communications and financial reporting. Externally visible deposit reference number.. Valid values are `^DEP-[0-9]{8,12}$`',
    `deposit_status` STRING COMMENT 'Current lifecycle state of the deposit. Active deposits are held and earning interest, refunded deposits have been returned to customer, forfeited deposits applied to outstanding balances, transferred deposits moved to new account, expired deposits past regulatory holding period, and pending refund deposits awaiting disbursement approval.. Valid values are `active|refunded|forfeited|transferred|expired|pending_refund`',
    `deposit_type` STRING COMMENT 'Classification of the deposit instrument held by the utility. Cash deposits are held in utility accounts, surety bonds and letters of credit are third-party guarantees, bank guarantees are financial institution commitments, and escrow deposits are held by third-party trustees.. Valid values are `cash|surety_bond|letter_of_credit|bank_guarantee|escrow`',
    `forfeiture_amount` DECIMAL(18,2) COMMENT 'Amount of deposit (including accrued interest) applied to customer account balance upon forfeiture. May be partial if deposit exceeds outstanding balance. Null for deposits not forfeited.',
    `forfeiture_date` DATE COMMENT 'Date the deposit was forfeited and applied to outstanding customer account balance due to payment default, service disconnection, or final bill settlement. Null for deposits not forfeited.',
    `forfeiture_reason` STRING COMMENT 'Business reason for forfeiting the deposit and applying it to customer account balance. Payment default and service disconnection are most common triggers per PUC tariff rules.. Valid values are `payment_default|service_disconnection|final_bill_settlement|account_closure|regulatory_violation`',
    `guarantee_expiration_date` DATE COMMENT 'Expiration date of the surety bond, letter of credit, or bank guarantee. Utility must ensure renewal or replacement before expiration to maintain deposit coverage. Null for cash deposits and perpetual guarantees.',
    `guarantee_instrument_number` STRING COMMENT 'Reference number or policy number of the surety bond, letter of credit, or bank guarantee instrument. Used for verification and claim processing. Null for cash deposits.',
    `guarantee_provider_name` STRING COMMENT 'Name of the financial institution or surety company providing the letter of credit, surety bond, or bank guarantee. Applicable only for non-cash deposit types. Null for cash deposits.',
    `interest_calculation_method` STRING COMMENT 'Method used to calculate interest accrual on the deposit. Simple interest calculates on principal only, compound methods add accrued interest to principal at specified intervals. Method is typically mandated by PUC tariff rules.. Valid values are `simple|compound_monthly|compound_quarterly|compound_annually|none`',
    `interest_rate_percent` DECIMAL(18,2) COMMENT 'Annual interest rate applied to the deposit balance, expressed as a percentage. Rate is typically set by state PUC regulations and may be tied to treasury rates or fixed by tariff.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the deposit record was last updated. Tracks changes to deposit status, interest accrual, or refund processing for audit and compliance purposes.',
    `last_review_date` DATE COMMENT 'Date the deposit record was last reviewed for refund eligibility, interest accrual accuracy, or regulatory compliance. Utilities typically perform periodic deposit reviews per PUC requirements.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next deposit review cycle. Used for workflow management and compliance tracking to ensure timely refund processing and interest payment.',
    `notes` STRING COMMENT 'Free-text field for recording special circumstances, customer disputes, regulatory exceptions, or other relevant information about the deposit. Used for audit trail and customer service reference.',
    `reason_code` STRING COMMENT 'Business reason for requiring or collecting the deposit. Regulatory requirements mandate deposits for certain customer risk profiles, payment defaults trigger deposit collection, and voluntary deposits may be offered for budget management.. Valid values are `new_service|poor_credit|payment_default|high_usage|regulatory_requirement|voluntary`',
    `refund_amount` DECIMAL(18,2) COMMENT 'Total amount refunded to customer, including original deposit principal plus accrued interest, minus any forfeitures or adjustments. Null for deposits not yet refunded.',
    `refund_date` DATE COMMENT 'Actual date the deposit (plus accrued interest) was refunded to the customer or applied to their account balance. Null for deposits not yet refunded.',
    `refund_eligibility_date` DATE COMMENT 'Date on which the deposit becomes eligible for refund to the customer, calculated based on PUC-mandated holding periods and customer payment history criteria. Typically 12-24 months of on-time payment history.',
    `refund_method` STRING COMMENT 'Method used to return the deposit to the customer. Account credit applies deposit to outstanding balance, check and direct deposit return funds directly to customer, wire transfer used for large amounts.. Valid values are `check|direct_deposit|account_credit|wire_transfer`',
    `regulatory_holding_period_months` STRING COMMENT 'Minimum number of months the utility must hold the deposit before refund eligibility, as mandated by state PUC regulations. Typically 12 or 24 months depending on jurisdiction and customer class.',
    `service_agreement` BIGINT COMMENT 'FK to billing.service_agreement.service_agreement_id — Security deposits are held against a specific service agreement. Required for deposit refund eligibility tracking.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this deposit record is subject to SOX financial controls and audit requirements. True for publicly traded utilities with material deposit balances requiring internal control documentation.',
    `to_sa` BIGINT COMMENT 'FK to billing.service_agreement.service_agreement_id — Security deposits are collected for a specific service agreement, often at service initiation or after credit events.',
    CONSTRAINT pk_deposit PRIMARY KEY(`deposit_id`)
) COMMENT 'Master entity tracking customer security deposits held by the utility, including deposit amount, deposit type (cash, surety bond, letter of credit), collection date, interest accrual, refund eligibility date, refund status, and regulatory basis for deposit requirement. Managed within SAP IS-U FICA and Oracle CC&B deposit management. Supports PUC-mandated deposit rules and customer financial risk management.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` (
    `dunning_notice_id` BIGINT COMMENT 'Unique identifier for the dunning or collections notice record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer account that received this dunning notice.',
    `billing_service_agreement_id` BIGINT COMMENT 'Reference to the active service agreement or utility contract under which the past due charges were incurred.',
    `collections_id` BIGINT COMMENT 'FK to billing.collections_case.collections_case_id — Dunning notices are issued within the context of a collections case. This FK tracks the escalation lifecycle from first notice through disconnect warning. Note: if merge recommendation is accepted, th',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Dunning notices must comply with specific regulatory obligations governing mandatory notice periods, protected customer rules, and disconnection moratorium requirements. dunning_notice has regulatory_',
    `payment_arrangement_id` BIGINT COMMENT 'Reference to a payment arrangement or installment plan established in response to this dunning notice, if applicable.',
    `premise_id` BIGINT COMMENT 'Reference to the service premise or property associated with the delinquent account.',
    `action_date` DATE COMMENT 'Date on which the resulting action was taken or the dunning case was resolved.',
    `action_taken` STRING COMMENT 'Resulting action or outcome following the dunning notice. Tracks how the collections case was resolved or escalated. [ENUM-REF-CANDIDATE: none|payment_received|payment_arrangement|service_disconnected|account_written_off|legal_action|dispute_opened — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time this dunning notice record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the past due amount (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `customer_contact_name` STRING COMMENT 'Name of the customer or authorized contact person to whom the dunning notice was addressed.',
    `days_past_due` STRING COMMENT 'Number of days the oldest invoice has been overdue at the time of dunning notice issuance.',
    `delivery_address` STRING COMMENT 'Physical or electronic address to which the dunning notice was sent (mailing address, email address, or phone number).',
    `delivery_channel` STRING COMMENT 'Method by which the dunning notice was delivered to the customer.. Valid values are `mail|email|sms|door_hanger|phone_call|customer_portal`',
    `delivery_status` STRING COMMENT 'Confirmation status of the delivery attempt. Indicates whether the notice successfully reached the customer.. Valid values are `sent|delivered|bounced|failed|pending`',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date and time the dunning notice was successfully delivered or sent to the customer.',
    `due_date` DATE COMMENT 'Deadline by which the customer must respond or make payment to avoid further escalation.',
    `dunning_block_code` STRING COMMENT 'Code indicating if dunning was blocked or suppressed for this account due to special circumstances (e.g., hardship, bankruptcy, medical emergency).',
    `dunning_block_reason` STRING COMMENT 'Explanation or justification for why dunning was blocked or why this notice was cancelled.',
    `dunning_fee` DECIMAL(18,2) COMMENT 'Administrative fee charged for issuing the dunning notice, as permitted by regulatory tariff.',
    `dunning_level` STRING COMMENT 'Escalation stage of the collections process. Indicates severity and urgency of the notice.. Valid values are `first_notice|second_notice|final_notice|disconnect_warning|disconnect_order|legal_referral`',
    `dunning_notice_number` STRING COMMENT 'Externally-visible business identifier for the dunning notice, used in customer correspondence and payment references.',
    `dunning_status` STRING COMMENT 'Current lifecycle status of the dunning notice. Tracks whether the notice is active, resolved, or superseded. [ENUM-REF-CANDIDATE: issued|acknowledged|paid|disputed|cancelled|expired|escalated — 7 candidates stripped; promote to reference product]',
    `issue_date` DATE COMMENT 'Date the dunning notice was generated and issued to the customer. Principal business event timestamp for this transaction.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language in which the dunning notice was issued (e.g., en, es, fr).. Valid values are `^[a-z]{2}$`',
    `late_payment_fee` DECIMAL(18,2) COMMENT 'Additional fee or penalty assessed for late payment, included in the total amount due.',
    `modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this dunning notice record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time this dunning notice record was last updated in the system.',
    `notes` STRING COMMENT 'Free-text notes or comments recorded by collections staff regarding this dunning notice or customer interaction.',
    `oldest_invoice_date` DATE COMMENT 'Date of the oldest unpaid invoice included in the past due balance. Indicates how long the debt has been outstanding.',
    `past_due_amount` DECIMAL(18,2) COMMENT 'Total outstanding balance that triggered this dunning notice, in the accounts billing currency.',
    `print_suppression_flag` BOOLEAN COMMENT 'Indicates whether physical printing and mailing of this notice was suppressed in favor of electronic delivery only.',
    `protected_customer_flag` BOOLEAN COMMENT 'Indicates whether the customer is classified as a protected or vulnerable customer (e.g., medical baseline, low-income, elderly) subject to special collections rules.',
    `regulatory_notice_days` STRING COMMENT 'Minimum number of days required by regulation between dunning notice issuance and service disconnection.',
    `regulatory_notice_required` BOOLEAN COMMENT 'Flag indicating whether this dunning notice is subject to regulatory notification requirements (e.g., PUC-mandated disconnect notice periods).',
    `template_code` STRING COMMENT 'Identifier for the dunning notice template or form used to generate the customer communication.',
    `total_amount_due` DECIMAL(18,2) COMMENT 'Total amount the customer must pay to resolve the dunning notice, including past due balance, late fees, and dunning fees.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or automated process that created this dunning notice record.',
    CONSTRAINT pk_dunning_notice PRIMARY KEY(`dunning_notice_id`)
) COMMENT 'Transactional record of a dunning or collections notice issued to a customer with a past-due balance. Captures dunning level (first notice, final notice, disconnect warning, disconnect order), issue date, past-due amount, response deadline, delivery channel (mail, email, SMS, door hanger), and resulting action taken. Sourced from SAP IS-U FICA dunning program and Oracle CC&B collections workflow. Tracks the full collections escalation lifecycle.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`billing`.`collections` (
    `collections_id` BIGINT COMMENT 'Primary key for collections',
    `account_id` BIGINT COMMENT 'Reference to the customer account associated with this collections case.',
    `billing_service_agreement_id` BIGINT COMMENT 'FK to billing.service_agreement.service_agreement_id — Collections cases are opened against a delinquent service agreement/account. Critical for collections workflow and disconnect processing.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to trading.counterparty. Business justification: Collections cases against wholesale trading counterparties for unpaid energy settlements reference the counterparty entity. Energy market collections require counterparty-level tracking for ISDA defau',
    `payment_arrangement_id` BIGINT COMMENT 'Reference to the payment arrangement or installment plan established to resolve this collections case.',
    `bankruptcy_filing_date` DATE COMMENT 'Date when the customer filed for bankruptcy protection.',
    `bankruptcy_flag` BOOLEAN COMMENT 'Indicates whether the customer has filed for bankruptcy, which may halt collections activity per legal requirements.',
    `case_close_date` DATE COMMENT 'Date when the collections case was closed, either through payment, payment arrangement, write-off, or other resolution.',
    `case_number` STRING COMMENT 'Business identifier for the collections case, externally visible and used for tracking and correspondence.',
    `case_open_date` DATE COMMENT 'Date when the collections case was opened due to delinquent balance exceeding threshold or aging criteria.',
    `case_resolution_outcome` STRING COMMENT 'Final outcome classification for how the collections case was resolved. [ENUM-REF-CANDIDATE: paid_in_full|payment_arrangement|partial_payment|written_off|bankruptcy|disputed|transferred — 7 candidates stripped; promote to reference product]',
    `case_status` STRING COMMENT 'Current lifecycle status of the collections case indicating its stage in the collections workflow. [ENUM-REF-CANDIDATE: open|in_progress|pending_payment|payment_arrangement|escalated|closed|written_off — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this collections case record was first created in the system.',
    `delinquent_amount` DECIMAL(18,2) COMMENT 'Total outstanding delinquent balance in USD that triggered or is associated with this collections case.',
    `disconnect_executed_date` DATE COMMENT 'Date when service disconnection was actually executed in the field.',
    `disconnect_scheduled_date` DATE COMMENT 'Date when service disconnection is scheduled to occur if payment is not received.',
    `disconnect_status` STRING COMMENT 'Current status of service disconnection action for this collections case.. Valid values are `not_applicable|pending|scheduled|executed|cancelled|reconnected`',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the customer has disputed the charges associated with this collections case.',
    `dispute_reason` STRING COMMENT 'Customer-provided reason for disputing the delinquent charges in this collections case.',
    `dunning_level` STRING COMMENT 'Numeric dunning level indicating the escalation tier of collection notices sent (1=first notice, 2=second notice, etc.).',
    `escalation_count` STRING COMMENT 'Number of times this collections case has been escalated to higher dunning levels or collection stages.',
    `external_agency_code` STRING COMMENT 'Identifier for the external collections agency to which this case has been referred.',
    `last_contact_date` DATE COMMENT 'Date of the most recent contact attempt or interaction with the customer regarding this collections case.',
    `last_contact_method` STRING COMMENT 'Communication channel used for the most recent customer contact regarding this collections case.. Valid values are `phone|email|sms|mail|door_hanger|in_person`',
    `last_escalation_date` DATE COMMENT 'Date when the collections case was last escalated to a higher dunning level or collections stage.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this collections case record was last updated in the system.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount in USD of the most recent payment received against this collections case.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received against the delinquent balance in this collections case.',
    `legal_referral_date` DATE COMMENT 'Date when the collections case was referred to legal counsel or external collections agency.',
    `legal_referral_flag` BOOLEAN COMMENT 'Indicates whether this collections case has been referred to legal counsel or external collections agency.',
    `next_action_date` DATE COMMENT 'Scheduled date for the next collections action or follow-up activity.',
    `next_action_type` STRING COMMENT 'Type of next scheduled collections action (e.g., send notice, phone call, disconnect order, legal referral).',
    `notes` STRING COMMENT 'Free-text notes and comments from collectors documenting interactions, customer circumstances, and case-specific details.',
    `original_delinquent_amount` DECIMAL(18,2) COMMENT 'Initial delinquent balance in USD at the time the collections case was opened, used for tracking payment progress.',
    `past_due_days` STRING COMMENT 'Number of days the oldest invoice in the case has been past due, used for aging analysis and escalation triggers.',
    `promise_kept_flag` BOOLEAN COMMENT 'Indicates whether the customer honored their promise to pay commitment.',
    `promise_to_pay_amount` DECIMAL(18,2) COMMENT 'Amount in USD that the customer committed to pay by the promise to pay date.',
    `promise_to_pay_date` DATE COMMENT 'Date when the customer committed to making payment on the delinquent balance.',
    `reconnect_condition` STRING COMMENT 'Business conditions that must be met for service reconnection, such as payment in full, payment arrangement, or deposit.',
    `reconnect_date` DATE COMMENT 'Date when service was reconnected after disconnection.',
    `stage` STRING COMMENT 'Current stage in the collections escalation process indicating severity and next actions.. Valid values are `early_stage|mid_stage|late_stage|pre_disconnect|disconnect|legal`',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Amount in USD written off as bad debt for this collections case.',
    `write_off_date` DATE COMMENT 'Date when the delinquent balance was written off as uncollectible bad debt.',
    `write_off_eligible_flag` BOOLEAN COMMENT 'Indicates whether this collections case meets business criteria for bad debt write-off consideration.',
    `write_off_reason_code` STRING COMMENT 'Code indicating the business reason for write-off (e.g., bankruptcy, deceased, uncollectible, small balance).',
    CONSTRAINT pk_collections PRIMARY KEY(`collections_id`)
) COMMENT 'Master and transactional entity representing collections cases and their associated dunning notices for customer accounts with delinquent balances. At the case level: captures case open date, delinquent amount, collections stage, assigned collector, escalation history, disconnect status, reconnect conditions, write-off eligibility, and case resolution outcome. At the notice level: captures dunning level (first notice, final notice, disconnect warning, disconnect order), issue date, past-due amount, response deadline, delivery channel (mail, email, SMS, door hanger), and resulting action taken. Managed within SAP IS-U FICA dunning program and Oracle CC&B collections workflow. SSOT for all collections activity and dunning communications supporting SOX AR aging and bad debt controls.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`billing`.`write_off` (
    `write_off_id` BIGINT COMMENT 'Unique identifier for the accounts receivable write-off transaction. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer account for which the balance is being written off.',
    `collections_id` BIGINT COMMENT 'Reference to the collections case that led to this write-off decision, if applicable.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to trading.counterparty. Business justification: Write-offs of uncollectable amounts from defaulting trading counterparties require counterparty identification for credit loss reporting, FERC regulatory reporting, and credit risk model updates. Ener',
    `enforcement_action_id` BIGINT COMMENT 'Foreign key linking to compliance.enforcement_action. Business justification: PUC enforcement action orders can prohibit or mandate write-offs of disputed amounts during proceedings. Linking write_off to enforcement_action enables compliance tracking of write-off restrictions a',
    `market_settlement_id` BIGINT COMMENT 'Foreign key linking to trading.market_settlement. Business justification: Write-offs of disputed or uncollectable market settlement amounts reference the specific settlement record. Required for settlement dispute resolution tracking, credit loss attribution to specific mar',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to distribution.service_territory. Business justification: PUC bad-debt reporting and rate-case cost-of-service studies require write-off totals by service territory. The existing denormalized service_territory_code must be replaced with a proper FK to suppor',
    `aging_bucket` STRING COMMENT 'The accounts receivable aging category at the time of write-off: 0-30 days, 31-60 days, 61-90 days, 91-120 days, 121-180 days, over_180 days.. Valid values are `0-30|31-60|61-90|91-120|121-180|over_180`',
    `amount` DECIMAL(18,2) COMMENT 'The total dollar amount of the accounts receivable balance being written off as uncollectable.',
    `approval_authority` STRING COMMENT 'Name or identifier of the manager, director, or executive who authorized the write-off transaction per SOX approval hierarchy.',
    `approval_date` DATE COMMENT 'The date on which the write-off was formally approved by the designated authority.',
    `approval_level` STRING COMMENT 'Hierarchical approval level required for this write-off based on dollar threshold: supervisor (under $500), manager ($500-$2,500), director ($2,500-$10,000), vp ($10,000-$50,000), cfo (over $50,000).. Valid values are `supervisor|manager|director|vp|cfo`',
    `bankruptcy_case_number` STRING COMMENT 'The court-assigned bankruptcy case number if the write-off reason is bankruptcy, used for tracking potential distributions.',
    `bankruptcy_chapter` STRING COMMENT 'The chapter of bankruptcy filed by the customer: chapter_7 (liquidation), chapter_11 (reorganization), chapter_13 (individual debt adjustment).. Valid values are `chapter_7|chapter_11|chapter_13`',
    `collection_agency_referral_date` DATE COMMENT 'The date on which the account was referred to an external collection agency for recovery efforts.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this write-off record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the write-off amount (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `days_past_due` STRING COMMENT 'The number of days the account balance was past due at the time of write-off, calculated from the original due date to the write-off date.',
    `external_collection_agency` STRING COMMENT 'Name of the third-party collection agency to which the account was referred before write-off, if applicable.',
    `fiscal_period` STRING COMMENT 'The fiscal year and period (YYYY-MM format) in which the write-off was recognized for financial reporting purposes.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `from_collections_case` BIGINT COMMENT 'FK to billing.collections_case.collections_case_id — Write-offs are the terminal outcome of a collections case. This FK is required for bad debt tracking, recovery management, and SOX AR aging controls.',
    `interest_amount` DECIMAL(18,2) COMMENT 'The portion of the write-off amount representing accrued interest or late payment charges.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'The dollar amount of the last payment received from the customer before the account was written off.',
    `last_payment_date` DATE COMMENT 'The date of the last payment received from the customer before the account was written off.',
    `modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified the write-off record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this write-off record was last modified.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The portion of the write-off amount representing penalties, fees, or other charges assessed to the account.',
    `posting_date` DATE COMMENT 'The date on which the write-off transaction was posted to the general ledger and accounts receivable subledger.',
    `principal_amount` DECIMAL(18,2) COMMENT 'The portion of the write-off amount representing the original principal balance owed by the customer.',
    `puc_reporting_category` STRING COMMENT 'The regulatory reporting category for this write-off as required by state Public Utility Commission uncollectable expense reporting.. Valid values are `residential_uncollectable|commercial_uncollectable|industrial_uncollectable|other_uncollectable`',
    `rate_class` STRING COMMENT 'The customer rate classification for the account at the time of write-off: residential, commercial, industrial, municipal, or agricultural.. Valid values are `residential|commercial|industrial|municipal|agricultural`',
    `reason_code` STRING COMMENT 'Categorical code indicating the primary reason for the write-off: bankruptcy (customer filed for bankruptcy protection), deceased (customer is deceased with no estate recovery), skip (customer location unknown), hardship (financial hardship waiver), uncollectable (exhausted collection efforts), fraud (fraudulent account).. Valid values are `bankruptcy|deceased|skip|hardship|uncollectable|fraud`',
    `reason_description` STRING COMMENT 'Detailed narrative explanation of the circumstances leading to the write-off decision, including supporting documentation references.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'The cumulative dollar amount recovered from this write-off through subsequent collection efforts, bankruptcy distributions, or estate settlements.',
    `recovery_date` DATE COMMENT 'The date of the most recent recovery payment or distribution applied against this written-off balance.',
    `recovery_eligible_flag` BOOLEAN COMMENT 'Indicates whether the written-off balance is eligible for future recovery efforts (true) or permanently closed (false).',
    `reversal_date` DATE COMMENT 'The date on which the write-off was reversed, if applicable (e.g., due to error correction or subsequent payment arrangement).',
    `reversal_reason` STRING COMMENT 'Explanation of why the write-off was reversed, including reference to correcting documentation or payment arrangement.',
    `service_type` STRING COMMENT 'The type of utility service for which the written-off balance was incurred: electric, gas, water, steam, or combined services.. Valid values are `electric|gas|water|steam|combined`',
    `tax_reporting_year` STRING COMMENT 'The calendar year in which the write-off is reported for income tax purposes (may differ from fiscal period for tax accounting).',
    `write_off_date` DATE COMMENT 'The date on which the accounts receivable balance was officially written off. This is the principal business event timestamp for the transaction.',
    `write_off_number` STRING COMMENT 'Business-facing unique identifier for the write-off transaction, used in financial reporting and audit trails.. Valid values are `^WO-[0-9]{8,12}$`',
    `write_off_status` STRING COMMENT 'Current lifecycle status of the write-off transaction: pending (awaiting approval), approved (authorized but not yet posted), posted (recorded to GL), reversed (write-off reversed), recovered (partial or full recovery after write-off).. Valid values are `pending|approved|posted|reversed|recovered`',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created the write-off record.',
    CONSTRAINT pk_write_off PRIMARY KEY(`write_off_id`)
) COMMENT 'Transactional record of an accounts receivable write-off for an uncollectable customer balance. Captures write-off date, amount, reason (bankruptcy, skip, hardship, deceased), approval authority, associated collections case, bad debt GL account, and recovery tracking. Sourced from SAP IS-U FICA and Oracle CC&B. Critical for SOX bad debt reserve management and PUC uncollectable expense reporting.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`billing`.`budget_plan` (
    `budget_plan_id` BIGINT COMMENT 'Primary key for budget_plan',
    `account_id` BIGINT COMMENT 'Reference to the customer account enrolled in this budget billing plan.',
    `billing_service_agreement_id` BIGINT COMMENT 'Foreign key linking to billing.billing_service_agreement. Business justification: Budget billing plans are configured at the service agreement level, not just the account level. A customer account may have multiple service agreements (e.g., residential and commercial), each with di',
    `energy_price_id` BIGINT COMMENT 'Foreign key linking to forecast.energy_price. Business justification: Budget billing installment calculation: monthly_installment_amount in budget plans is computed from projected annual energy costs driven by energy price forecasts. Linking budget_plan to energy_price ',
    `payment_arrangement_id` BIGINT COMMENT 'Reference to an associated payment arrangement if the budget plan is part of a broader affordability or collections program.',
    `affordability_program_code` STRING COMMENT 'Code identifying the customer affordability or assistance program under which this budget plan is offered (low-income, senior, medical baseline, etc.).',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'Total estimated annual energy cost used as the basis for calculating monthly installments, typically based on historical usage and current rates.',
    `auto_renew_flag` BOOLEAN COMMENT 'Indicates whether the budget billing plan automatically renews at the end of the term or requires customer re-enrollment.',
    `budget_plan_status` STRING COMMENT 'Current lifecycle status of the budget billing plan enrollment.. Valid values are `active|pending|suspended|cancelled|completed|true_up_pending`',
    `budget_to_sa` BIGINT COMMENT 'FK to billing.service_agreement.service_agreement_id — Budget billing plans are enrolled for a specific service agreement to smooth seasonal bill variability.',
    `cancellation_date` DATE COMMENT 'Date when the budget billing plan was cancelled by the customer or utility. Null if plan is active or completed normally.',
    `cancellation_reason_code` STRING COMMENT 'Code indicating the reason for plan cancellation (customer request, payment default, account closure, service disconnection, etc.).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget billing plan record was first created in the system.',
    `cumulative_actual_amount` DECIMAL(18,2) COMMENT 'Total actual energy charges incurred by the customer since enrollment, based on actual consumption and applicable rates.',
    `cumulative_billed_amount` DECIMAL(18,2) COMMENT 'Total amount billed to the customer under the budget plan since enrollment, representing the sum of all monthly installments charged.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this budget plan.. Valid values are `USD|CAD|EUR|GBP|AUD|MXN`',
    `effective_end_date` DATE COMMENT 'Date when the budget billing plan ends or is scheduled to end. Null for open-ended plans.',
    `effective_start_date` DATE COMMENT 'Date when the budget billing plan becomes effective and monthly installment billing begins.',
    `eligibility_verified_date` DATE COMMENT 'Date when customer eligibility for the budget billing plan or associated affordability program was last verified.',
    `enrollment_channel` STRING COMMENT 'Channel through which the customer enrolled in the budget billing plan.. Valid values are `web|mobile_app|call_center|in_person|mail|auto_enrolled`',
    `enrollment_date` DATE COMMENT 'Date when the customer was enrolled into the budget billing plan.',
    `historical_usage_kwh` DECIMAL(18,2) COMMENT 'Total historical annual energy consumption in kilowatt-hours used as the basis for calculating the budget amount, typically from the prior 12-month period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget billing plan record was last updated.',
    `last_true_up_amount` DECIMAL(18,2) COMMENT 'Amount settled at the most recent true-up. Positive values represent credits issued to customer; negative values represent additional charges.',
    `last_true_up_date` DATE COMMENT 'Date of the most recent annual true-up reconciliation when variance was settled and plan was recalculated.',
    `modified_by_user` STRING COMMENT 'User ID or system identifier of the person or process that last modified this budget billing plan record.',
    `monthly_installment_amount` DECIMAL(18,2) COMMENT 'Fixed monthly payment amount charged to the customer under the budget billing plan, calculated to smooth seasonal bill variability.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next plan review or recalculation, typically mid-cycle or at true-up to adjust installments based on actual usage trends.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the budget billing plan, including special arrangements, customer requests, or operational remarks.',
    `plan_number` STRING COMMENT 'Externally visible unique identifier for the budget billing plan, used in customer communications and billing statements.',
    `plan_term_months` STRING COMMENT 'Duration of the budget billing plan cycle in months, typically 12 months for annual levelized billing.',
    `plan_type` STRING COMMENT 'Classification of the budget billing methodology used to calculate monthly installments (levelized over 12 months, rolling average, fixed amount, seasonal adjustment, or custom calculation).. Valid values are `levelized|equal_payment|rolling_average|fixed_amount|seasonal_adjustment|custom`',
    `rate_schedule_code` STRING COMMENT 'Tariff rate schedule code applied to calculate the budget amount and actual charges for this plan.',
    `recalculation_frequency` STRING COMMENT 'Frequency at which the monthly installment amount is recalculated based on updated usage patterns and rate changes.. Valid values are `annual|semi_annual|quarterly|monthly|on_demand`',
    `service_agreement` BIGINT COMMENT 'FK to billing.service_agreement.service_agreement_id — Budget billing plans are enrolled for a specific service agreement. Required for levelized billing calculation.',
    `true_up_month` STRING COMMENT 'Month number (1-12) when the annual true-up reconciliation occurs, settling the variance between budget installments and actual charges.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Current difference between cumulative billed amount and cumulative actual amount. Positive variance indicates customer has been overbilled (credit due at true-up); negative variance indicates underbilled (balance due at true-up).',
    CONSTRAINT pk_budget_plan PRIMARY KEY(`budget_plan_id`)
) COMMENT 'Master entity representing a customer enrollment in a budget billing (levelized billing) program, where monthly charges are averaged over a 12-month period to smooth seasonal bill variability. Captures enrolled amount, plan start date, true-up month, cumulative actual vs. budget variance, annual true-up amount, and plan status. Managed within Oracle CC&B and SAP IS-U. Supports customer affordability programs and revenue smoothing.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`billing`.`cycle` (
    `cycle_id` BIGINT COMMENT 'Unique identifier for the billing cycle configuration and execution record. Primary key.',
    `billing_run_id` BIGINT COMMENT 'Unique identifier for the specific batch billing run execution instance (e.g., BR2024011501). Generated when billing engine executes the cycle.',
    `market_run_id` BIGINT COMMENT 'Foreign key linking to trading.market_run. Business justification: Wholesale billing cycles are triggered by and aligned with ISO/RTO market settlement runs. The billing cycle for market participants must reference the market run to ensure billing uses the correct se',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to distribution.service_territory. Business justification: Billing cycles are organized by service territory to align meter-reading routes, billing calendar, and regulatory reporting periods with franchise boundaries. The existing denormalized service_territo',
    `accounts_processed_count` STRING COMMENT 'Total number of customer accounts successfully processed during this billing run execution.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this billing cycle run requires supervisory approval before invoice release (True) or can be automatically released (False). Typically True for high-value commercial/industrial cycles.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the billing run was approved for invoice release. Null if approval not required or not yet approved.',
    `assigned_account_count` STRING COMMENT 'Total number of customer accounts assigned to this billing cycle for workload distribution and capacity planning.',
    `bill_due_date_offset_days` STRING COMMENT 'Number of days after bill generation date to set the payment due date (e.g., 21 days for residential, 30 days for commercial).',
    `billing_period_end_date` DATE COMMENT 'The last date of the consumption period covered by this billing cycle run (inclusive).',
    `billing_period_start_date` DATE COMMENT 'The first date of the consumption period covered by this billing cycle run (inclusive).',
    `billing_run_date` DATE COMMENT 'The actual date when the billing batch processing was executed for this cycle. May differ from scheduled date due to operational adjustments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this billing cycle record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this billing cycle (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `cycle_code` STRING COMMENT 'Business identifier for the billing cycle configuration (e.g., RES01, COM15, IND30). Used for scheduling and grouping accounts into billing batches.. Valid values are `^[A-Z0-9]{2,10}$`',
    `cycle_name` STRING COMMENT 'Human-readable name describing the billing cycle (e.g., Residential Monthly Cycle 1, Commercial Bi-Monthly East).',
    `cycle_status` STRING COMMENT 'Current lifecycle status of the billing cycle configuration. Active: in use for billing operations. Inactive: temporarily disabled. Suspended: on hold pending review. Archived: retired from active use.. Valid values are `active|inactive|suspended|archived`',
    `cycle_type` STRING COMMENT 'Classification of the billing cycle frequency and purpose. Monthly for standard monthly billing, bi-monthly for every-other-month, quarterly for seasonal, on-demand for ad-hoc billing, final for account closure billing.. Valid values are `monthly|bi-monthly|quarterly|on-demand|final`',
    `effective_end_date` DATE COMMENT 'The date when this billing cycle configuration was retired or superseded. Null for currently active cycles.',
    `effective_start_date` DATE COMMENT 'The date when this billing cycle configuration became active and available for use in billing operations.',
    `exception_count` STRING COMMENT 'Number of accounts that encountered errors or exceptions during billing run processing (e.g., missing meter reads, rate errors, validation failures). Requires manual review.',
    `exception_summary` STRING COMMENT 'Brief summary of the types of exceptions encountered during the billing run (e.g., 15 missing reads, 3 rate lookup failures, 2 validation errors).',
    `invoice_delivery_method` STRING COMMENT 'Primary method used to deliver invoices to customers in this billing cycle. Paper: postal mail. Email: electronic delivery. Portal: customer self-service. SMS: text message notification. Suppressed: no delivery (e.g., zero-balance accounts).. Valid values are `paper|email|portal|sms|suppressed`',
    `invoice_print_date` DATE COMMENT 'The date when physical invoices were printed or electronic bills were released to customers. May differ from billing run date due to approval workflows.',
    `invoices_generated_count` STRING COMMENT 'Total number of invoices (bills) generated during this billing run execution. May differ from accounts processed if some accounts had zero consumption or credits.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this billing cycle record was last updated. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, or comments about this billing cycle or run (e.g., holiday adjustments, system issues, rate changes).',
    `rate_class` STRING COMMENT 'Customer rate classification this billing cycle primarily serves. Determines applicable tariff schedules and rate structures.. Valid values are `residential|commercial|industrial|agricultural|municipal`',
    `read_frequency_days` STRING COMMENT 'Number of days between scheduled meter reads for this billing cycle (e.g., 30 for monthly, 60 for bi-monthly).',
    `run_duration_minutes` STRING COMMENT 'Total elapsed time in minutes for the billing run execution. Used for capacity planning and performance optimization.',
    `run_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the billing batch processing completed or terminated. Used for performance monitoring and SLA tracking.',
    `run_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the billing batch processing began execution. Used for performance monitoring and SLA tracking.',
    `run_status` STRING COMMENT 'Current execution status of the billing run. Pending: scheduled but not started. In-progress: actively processing. Completed: finished successfully. Completed-with-exceptions: finished but some accounts had errors. Error: run failed. Cancelled: run was aborted.. Valid values are `pending|in-progress|completed|completed-with-exceptions|error|cancelled`',
    `scheduled_bill_generation_date` DATE COMMENT 'The date when invoice generation batch processing is scheduled to execute for this billing cycle.',
    `scheduled_read_end_date` DATE COMMENT 'The date by which all meter reading activities should be completed for this billing cycle period.',
    `scheduled_read_start_date` DATE COMMENT 'The date when meter reading activities are scheduled to begin for this billing cycle period.',
    `total_billed_amount` DECIMAL(18,2) COMMENT 'Sum of all invoice amounts generated during this billing run execution, before payments and adjustments. Represents gross revenue for the cycle.',
    `total_kwh_billed` DECIMAL(18,2) COMMENT 'Sum of all energy consumption in kilowatt-hours billed across all accounts in this billing run. Key operational metric for load forecasting and revenue analysis.',
    CONSTRAINT pk_cycle PRIMARY KEY(`cycle_id`)
) COMMENT 'Reference and operational entity defining billing cycle configurations and their execution history. At the cycle level: stores cycle code, read frequency (monthly, bi-monthly), scheduled read and bill generation dates, due date offset, and assigned account count. At the run level: captures batch billing run execution records including run date, billing cycle reference, accounts processed, invoices generated, total billed amount, run status (pending, in-progress, completed, error), exception count, and operator. Drives billing run scheduling, workload distribution, and revenue cycle timing. Sourced from SAP IS-U and Oracle CC&B billing engine. SSOT for billing cycle definitions and all batch billing run execution records.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`billing`.`billing_run` (
    `billing_run_id` BIGINT COMMENT 'Unique identifier for the billing run execution. Primary key for the billing run entity.',
    `reversed_run_billing_run_id` BIGINT COMMENT 'Reference to the original billing run that is being reversed by this run, establishing audit trail for billing corrections and dispute resolution.',
    `accounts_failed` STRING COMMENT 'Number of customer accounts or service agreements that failed to complete billing due to data errors, validation failures, or system exceptions.',
    `accounts_processed` STRING COMMENT 'Number of customer accounts or service agreements that were successfully processed and completed billing calculations without errors.',
    `accounts_targeted` STRING COMMENT 'Total number of customer accounts or service agreements that were selected and targeted for billing in this run based on billing cycle criteria.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the billing run execution completed or terminated, used to calculate run duration and identify performance issues.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the billing run execution began, capturing the real-world event time for performance monitoring and audit purposes.',
    `approval_status` STRING COMMENT 'Approval state of the billing run results, indicating whether the run output has been reviewed and approved for invoice release and accounts receivable posting.. Valid values are `pending_approval|approved|rejected|not_required`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the billing run was approved for invoice release, establishing the audit trail for revenue recognition timing.',
    `approved_by` STRING COMMENT 'User identifier of the supervisor or manager who approved the billing run results for release, supporting SOX segregation of duties requirements.',
    `batch_job_reference` STRING COMMENT 'Technical identifier of the underlying batch job or process execution in the billing system, used for technical troubleshooting and system integration.',
    `billing_period_end_date` DATE COMMENT 'End date of the billing period covered by this run, defining the conclusion of the consumption or service period being invoiced.',
    `billing_period_start_date` DATE COMMENT 'Start date of the billing period covered by this run, defining the beginning of the consumption or service period being invoiced.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this billing run record was first created in the system, establishing the audit trail for billing operations tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this billing run, typically USD for US-based energy utilities.. Valid values are `^[A-Z]{3}$`',
    `duration_seconds` STRING COMMENT 'Total elapsed time in seconds from actual start to actual end of the billing run, used for performance analysis and capacity planning.',
    `error_count` STRING COMMENT 'Total number of critical errors encountered during billing run execution that prevented successful processing of accounts or invoice generation.',
    `exception_count` STRING COMMENT 'Total number of billing exceptions, warnings, or validation issues encountered during the run that require manual review or correction.',
    `execution_mode` STRING COMMENT 'Method by which the billing run was triggered, indicating whether it was automatically scheduled, manually initiated, or executed on-demand.. Valid values are `automatic|manual|scheduled|on_demand`',
    `gl_posting_date` DATE COMMENT 'Accounting date when the billing run results were posted to the general ledger for revenue recognition and accounts receivable booking.',
    `gl_posting_status` STRING COMMENT 'Status of the financial posting to the general ledger, indicating whether accounts receivable and revenue entries have been successfully recorded.. Valid values are `not_posted|posted|posting_failed|reversed`',
    `invoice_due_date` DATE COMMENT 'Standard payment due date applied to invoices generated in this billing run, used for accounts receivable management and collections planning.',
    `invoices_generated` STRING COMMENT 'Total number of billing invoices or statements successfully generated and created during this billing run execution.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this billing run record was last updated, supporting change tracking and audit compliance for billing operations.',
    `notes` STRING COMMENT 'Free-text operational notes or comments about the billing run execution, capturing special circumstances, manual interventions, or issues requiring follow-up.',
    `print_batch_reference` STRING COMMENT 'Identifier of the print or output batch associated with this billing run, linking invoices to physical or electronic delivery processes.',
    `rate_schedule_version` STRING COMMENT 'Version identifier of the rate schedules and tariff structures applied during this billing run, ensuring regulatory compliance and audit traceability.',
    `reversal_flag` BOOLEAN COMMENT 'Indicator of whether this billing run is a reversal run intended to cancel or reverse invoices from a previous billing run due to errors or corrections.',
    `run_number` STRING COMMENT 'Business-facing identifier for the billing run, typically formatted as a sequential or date-based code used for operational tracking and reference in billing operations.',
    `run_status` STRING COMMENT 'Current lifecycle status of the billing run execution indicating whether the batch process is pending, actively running, successfully completed, completed with exceptions, failed, or cancelled.. Valid values are `pending|in_progress|completed|completed_with_errors|failed|cancelled`',
    `run_type` STRING COMMENT 'Classification of the billing run indicating whether it is a regular scheduled run, interim billing, final billing, correction run, reversal run, or special ad-hoc billing event.. Valid values are `regular|interim|final|correction|reversal|special`',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned date and time when the billing run was scheduled to begin execution, used for operational planning and SLA tracking.',
    `total_adjustment_amount` DECIMAL(18,2) COMMENT 'Aggregate sum of all billing adjustments, credits, and corrections applied during this billing run, including late fees, discounts, and dispute resolutions.',
    `total_billed_amount` DECIMAL(18,2) COMMENT 'Aggregate sum of all invoice amounts generated in this billing run before adjustments, representing the gross revenue recognized for the billing period.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Final aggregate net amount due across all invoices after applying taxes and adjustments, representing the total accounts receivable created by this billing run.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Aggregate sum of all tax charges calculated and applied across invoices in this billing run, supporting tax reporting and remittance.',
    CONSTRAINT pk_billing_run PRIMARY KEY(`billing_run_id`)
) COMMENT 'Transactional record of a batch billing run execution that generates invoices for a set of service agreements within a billing cycle. Captures run date, billing cycle, number of accounts processed, number of invoices generated, total billed amount, run status (pending, in-progress, completed, error), exception count, and operator. Sourced from SAP IS-U and Oracle CC&B billing engine execution logs. Supports billing operations monitoring and revenue cycle management.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` (
    `revenue_recognition_id` BIGINT COMMENT 'Primary key for revenue_recognition',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to interconnection.interconnection_agreement. Business justification: ASC 606 revenue recognition for interconnection-related revenues (standby charges, network upgrade cost recovery) requires linking each recognition entry to the governing interconnection agreement to ',
    `account_id` BIGINT COMMENT 'Reference to the billing account associated with this revenue recognition entry. Supports multi-account revenue tracking.',
    `billing_service_agreement_id` BIGINT COMMENT 'Reference to the customer service agreement for which revenue is being recognized. Links this revenue recognition entry to the underlying customer contract.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to asset.capital_project. Business justification: CIAC revenue recognition entries must be linked to the capital project receiving the contribution. GAAP ASC 980 and FERC accounting require utilities to recognize CIAC as a reduction to plant cost; th',
    `curtailment_event_id` BIGINT COMMENT 'Foreign key linking to renewable.curtailment_event. Business justification: Revenue recognition for curtailment compensation payments must reference the curtailment event for accurate period recognition and regulatory reporting. FERC and state PUC filings require traceability',
    `der_registry_id` BIGINT COMMENT 'Foreign key linking to renewable.der_registry. Business justification: Revenue recognition for DER-related services (NEM credits, VPP incentive payments, DER performance bonuses) requires tracing recognized revenue to the specific DER asset. Supports regulatory cost-of-s',
    `dr_incentive_payment_id` BIGINT COMMENT 'Foreign key linking to demand.dr_incentive_payment. Business justification: DR incentive payment disbursements require revenue recognition entries for proper utility accounting treatment under ASC 606 and FERC cost recovery reporting. Utility accountants must trace each reven',
    `energy_price_id` BIGINT COMMENT 'Foreign key linking to forecast.energy_price. Business justification: ASC 606/IFRS 15 unbilled revenue accrual: utilities estimate unbilled_revenue_amount using forecasted energy prices for market-rate and indexed contracts. Revenue recognition entries must reference th',
    `energy_schedule_id` BIGINT COMMENT 'Foreign key linking to trading.energy_schedule. Business justification: Revenue is recognized when energy is delivered per the energy schedule. Linking revenue recognition to the energy schedule supports performance obligation satisfaction tracking under ASC 606 for sched',
    `generation_meter_read_id` BIGINT COMMENT 'Foreign key linking to renewable.generation_meter_read. Business justification: Revenue recognition for renewable generation must reference the generation meter read substantiating the recognized revenue amount. Regulatory cost-of-service accounting and FERC audit trails require ',
    `incentive_application_id` BIGINT COMMENT 'Foreign key linking to renewable.incentive_application. Business justification: Revenue recognition for incentive application payments must reference the specific application for ASC 606 performance obligation identification. Each approved incentive application represents a disti',
    `incentive_program_id` BIGINT COMMENT 'Foreign key linking to renewable.incentive_program. Business justification: Revenue recognition for incentive program payments (rebates, performance incentives) must reference the specific incentive program for ASC 606 performance obligation identification and regulatory repo',
    `load_id` BIGINT COMMENT 'Foreign key linking to forecast.load. Business justification: Unbilled revenue accrual process: unbilled_revenue_amount is estimated using load forecasts for consumption not yet metered at period close. ASC 606 requires utilities to document the load forecast us',
    `market_settlement_id` BIGINT COMMENT 'Foreign key linking to trading.market_settlement. Business justification: ASC 606 revenue recognition for wholesale energy sales requires linking recognized revenue entries to the market settlement event that triggered recognition. Settlement-to-revenue traceability is requ',
    `nem_account_id` BIGINT COMMENT 'Foreign key linking to renewable.nem_account. Business justification: Revenue recognition for NEM credit monetization and annual true-up payments must reference the NEM account for accurate period recognition. State PUC NEM program cost reporting requires traceability f',
    `nem_agreement_id` BIGINT COMMENT 'Foreign key linking to interconnection.nem_agreement. Business justification: Revenue recognition entries for NEM export compensation credits require reference to the NEM agreement to correctly classify the revenue category, apply the correct export compensation rate, and satis',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Revenue recognition methods for regulated utilities are governed by specific regulatory obligations (ASC 980 regulatory accounting, revenue decoupling mandates, performance-based ratemaking obligation',
    `original_entry_revenue_recognition_id` BIGINT COMMENT 'Reference to the original revenue recognition entry being reversed. Populated only when reversal_flag is True. Maintains audit trail for reversals.',
    `output_telemetry_id` BIGINT COMMENT 'Foreign key linking to generation.output_telemetry. Business justification: ASC 606/IFRS 15 energy revenue recognition requires reconciliation of recognized revenue against actual generation output telemetry (MWh delivered). Auditors and regulators require this traceability t',
    `ppa_contract_id` BIGINT COMMENT 'Foreign key linking to renewable.ppa_contract. Business justification: ASC 606 revenue recognition for renewable PPA energy sales requires contract-level traceability for multi-period revenue deferral and contract amendment tracking. Existing link is to ppa_settlement (p',
    `ppa_id` BIGINT COMMENT 'Foreign key linking to trading.ppa. Business justification: PPA revenue recognition requires contract-specific treatment for bundled energy and RECs under GAAP; direct PPA reference enables proper allocation between energy and environmental attribute revenue s',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice document from which this revenue recognition entry was derived. Null for unbilled revenue accruals.',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.rate_schedule. Business justification: Revenue recognition entries are calculated according to rate schedule rules and must be traceable to the rate schedule version in effect. Currently revenue_recognition has rate_schedule_code (STRING) ',
    `ppa_settlement_id` BIGINT COMMENT 'Foreign key linking to renewable.ppa_settlement. Business justification: Revenue from PPA settlements must be recognized in correct accounting periods per ASC 606. Financial reporting requires linking settlement amounts to revenue recognition entries for matching generatio',
    `revenue_invoice_id` BIGINT COMMENT 'FK to billing.invoice.invoice_id — Revenue recognition entries may reference the source invoice for billed revenue. Supports ASC 606 compliance and audit trail.',
    `rps_obligation_id` BIGINT COMMENT 'Foreign key linking to renewable.rps_obligation. Business justification: Revenue recognition for RPS compliance instruments (RECs, ACP payments) must be tied to the specific RPS obligation period for regulatory reporting and ASC 606 performance obligation identification. S',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to distribution.service_territory. Business justification: ASC 606 and FERC regulatory accounting require revenue to be recognized and reported by service territory jurisdiction. Rate-case revenue requirement filings and jurisdictional unbundling reports depe',
    `trade_id` BIGINT COMMENT 'Foreign key linking to trading.trade. Business justification: Revenue from wholesale bilateral trades must be recognized per ASC 606 performance obligations; direct trade linkage enables proper revenue timing, contract modification tracking, and GAAP-compliant f',
    `vpp_configuration_id` BIGINT COMMENT 'Foreign key linking to renewable.vpp_configuration. Business justification: Revenue recognition for VPP capacity payments and dispatch incentives must reference the VPP configuration for ASC 606 performance obligation identification. Regulatory reporting of VPP program costs ',
    `accounting_period` STRING COMMENT 'The fiscal accounting period (YYYY-MM format) for which revenue is being recognized. Aligns with financial close calendar and regulatory reporting periods.. Valid values are `^d{4}-(0[1-9]|1[0-2])$`',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Any adjustments applied to revenue recognition for corrections, disputes, write-offs, or regulatory true-ups. Positive or negative value.',
    `approval_status` STRING COMMENT 'The approval workflow status of this revenue recognition entry. Ensures SOX-compliant segregation of duties for revenue posting.. Valid values are `draft|pending_approval|approved|rejected|posted`',
    `approved_by` STRING COMMENT 'The user ID or name of the person who approved this revenue recognition entry for posting to the general ledger.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this revenue recognition entry was approved for posting. Part of SOX audit trail.',
    `billed_revenue_amount` DECIMAL(18,2) COMMENT 'The portion of recognized revenue that has been invoiced to the customer. Sourced from SAP IS-U billing documents.',
    `business_area` STRING COMMENT 'The business area classification for this revenue (e.g., generation, transmission, distribution, retail). Supports segment reporting under GAAP.',
    `consumption_kwh` DECIMAL(18,2) COMMENT 'The kilowatt-hours of energy consumption for which revenue is being recognized. Sourced from meter data management system.',
    `cost_center` STRING COMMENT 'The organizational cost center responsible for this revenue stream. Supports internal management accounting and profitability analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this revenue recognition entry record was first created in the system. Part of audit trail for record lifecycle.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this revenue recognition entry. Typically USD for US utilities.. Valid values are `^[A-Z]{3}$`',
    `deferred_revenue_amount` DECIMAL(18,2) COMMENT 'The portion of billed revenue that has been collected but not yet earned. Represents liability for future service delivery under ASC 606.',
    `demand_kw` DECIMAL(18,2) COMMENT 'The peak kilowatt demand for which demand charges are being recognized. Applicable to commercial and industrial rate schedules.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this revenue recognition entry is posted in SAP S/4HANA FI. Maps to FERC account structure.',
    `last_modified_by` STRING COMMENT 'The user ID or name of the person or system process that last modified this revenue recognition entry record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this revenue recognition entry record was last modified. Supports change tracking and audit compliance.',
    `meter_read_date` DATE COMMENT 'The date of the meter reading that forms the basis for billed revenue in this entry. Null for unbilled accruals or non-metered charges.',
    `notes` STRING COMMENT 'Free-text notes providing additional context for this revenue recognition entry, including explanations for adjustments or special circumstances.',
    `performance_obligation` STRING COMMENT 'Description of the performance obligation satisfied by this revenue recognition entry under ASC 606 (e.g., electricity delivery, capacity reservation).',
    `posting_date` DATE COMMENT 'The date this revenue recognition entry was posted to the general ledger in SAP S/4HANA FI. May differ from recognition_date due to period-end adjustments.',
    `profit_center` STRING COMMENT 'The profit center to which this revenue is allocated for segment reporting and profitability analysis.',
    `recognition_date` DATE COMMENT 'The specific date on which revenue was recognized in the general ledger. Represents the business event timestamp for this revenue recognition transaction.',
    `recognition_method` STRING COMMENT 'The accounting method used to recognize this revenue under ASC 606. Indicates whether revenue is recognized at a point in time or over time.. Valid values are `point_in_time|over_time|accrual|deferral|straight_line`',
    `recognized_revenue_amount` DECIMAL(18,2) COMMENT 'The total revenue amount recognized in this accounting period for this service agreement and revenue category. Represents earned revenue under ASC 606.',
    `regulatory_account_code` STRING COMMENT 'The regulatory accounting code as defined by FERC or state PUC for revenue classification and reporting. Supports regulatory financial statements.',
    `revenue_category` STRING COMMENT 'Classification of the revenue type being recognized. Distinguishes between energy consumption charges, demand charges, fixed customer charges, regulatory riders, and ancillary services.. Valid values are `energy|demand|customer_charge|rider|ancillary_service|late_fee`',
    `revenue_class` STRING COMMENT 'Customer class for which revenue is being recognized. Aligns with rate class segmentation and regulatory reporting requirements.. Valid values are `residential|commercial|industrial|wholesale|municipal|agricultural`',
    `revenue_invoice` BIGINT COMMENT 'FK to billing.invoice.invoice_id — Revenue recognition entries may reference specific invoices for billed revenue. Supports GL reconciliation.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this revenue recognition entry is a reversal of a previous entry. True for reversals, False for original entries.',
    `reversal_reason` STRING COMMENT 'The business reason for reversing this revenue recognition entry (e.g., billing error, customer dispute, regulatory adjustment). Populated only when reversal_flag is True.',
    `revrec_to_sa` BIGINT COMMENT 'FK to billing.service_agreement.service_agreement_id — Revenue recognition entries are derived from billed/unbilled revenue for a specific service agreement and accounting period.',
    `rider_code` STRING COMMENT 'The regulatory rider or surcharge code applied to this revenue recognition entry (e.g., fuel adjustment clause, renewable energy surcharge).',
    `service_agreement` BIGINT COMMENT 'FK to billing.service_agreement.service_agreement_id — Revenue recognition entries are derived from billed/unbilled revenue for a specific service agreement. Required for ASC 606 compliance.',
    `service_period_end_date` DATE COMMENT 'The end date of the service period for which revenue is being recognized. Defines the end of the consumption or service delivery window.',
    `service_period_start_date` DATE COMMENT 'The start date of the service period for which revenue is being recognized. Defines the beginning of the consumption or service delivery window.',
    `source_document_number` STRING COMMENT 'The document number in the source system that originated this revenue recognition entry (e.g., SAP IS-U billing document number, FI document number).',
    `source_system` STRING COMMENT 'The operational system from which this revenue recognition entry was sourced (SAP IS-U FICA, Oracle CC&B, SAP S/4HANA FI, or manual entry).. Valid values are `SAP_IS-U|Oracle_CC&B|SAP_S4HANA|Manual_Entry`',
    `tariff_version` STRING COMMENT 'The version of the tariff rate schedule applied for this revenue recognition entry. Ensures auditability of rate changes.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount included in recognized revenue (sales tax, utility tax, franchise fees). Excluded from net revenue for regulatory reporting.',
    `unbilled_revenue_amount` DECIMAL(18,2) COMMENT 'The portion of recognized revenue that has been earned but not yet invoiced. Represents accrued revenue for consumption between last meter read and period end.',
    `created_by` STRING COMMENT 'The user ID or name of the person or system process that created this revenue recognition entry record.',
    CONSTRAINT pk_revenue_recognition PRIMARY KEY(`revenue_recognition_id`)
) COMMENT 'Transactional record capturing revenue recognition entries derived from billed and unbilled revenue for a service agreement and accounting period. Stores recognized revenue amount, deferred revenue amount, unbilled revenue accrual, revenue category (energy, demand, customer charge, rider), accounting period, GL account code, and recognition method. Supports SOX-compliant revenue recognition under ASC 606 and regulatory accounting requirements. Sourced from SAP IS-U FICA and SAP S/4HANA FI integration.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`billing`.`assistance_program` (
    `assistance_program_id` BIGINT COMMENT 'Primary key for assistance_program',
    `billing_service_agreement_id` BIGINT COMMENT 'Reference to the service agreement receiving the assistance program benefit.',
    `energy_price_id` BIGINT COMMENT 'Foreign key linking to forecast.energy_price. Business justification: Low-income assistance benefit sizing: maximum_benefit_amount in assistance programs (LIHEAP, CARE, FERA) is calculated using forecasted energy prices to project customer bill burden. Regulators requir',
    `irp_scenario_id` BIGINT COMMENT 'Foreign key linking to forecast.irp_scenario. Business justification: Low-income assistance programs are designed and funded based on rate impact projections from IRP scenarios. Program budgets and eligibility thresholds reference specific IRP scenarios to ensure afford',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Customer assistance programs (CARE, LIHEAP, medical baseline) are mandated by specific regulatory obligations. Linking assistance_program to its governing obligation enables compliance teams to verify',
    `incentive_program_id` BIGINT COMMENT 'Foreign key linking to renewable.incentive_program. Business justification: Low-income assistance programs often stack with renewable incentives for solar installations, energy efficiency, and green tariffs. Regulatory coordination required to ensure customers receive combine',
    `application_date` DATE COMMENT 'Date the customer submitted the application for the assistance program.',
    `application_method` STRING COMMENT 'Method by which the customer applied for the assistance program.. Valid values are `online|phone|mail|in_person|agency_referral|auto_enrollment`',
    `approval_date` DATE COMMENT 'Date the customer application was approved for enrollment in the assistance program.',
    `approved_by_user` STRING COMMENT 'User ID or name of the representative who approved the assistance program enrollment.',
    `assistance_to_sa` BIGINT COMMENT 'FK to billing.service_agreement.service_agreement_id — After merging program_enrollment, the assistance_program entity needs a link to service_agreement to track which accounts are enrolled in which programs.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the enrollment is eligible for automatic renewal without re-application.',
    `benefit_type` STRING COMMENT 'Type of financial benefit provided by the assistance program.. Valid values are `percentage_discount|fixed_credit|tiered_discount|arrearage_forgiveness|rate_reduction`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this assistance program enrollment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this record (e.g., USD).. Valid values are `^[A-Z]{3}$`',
    `disenrollment_date` DATE COMMENT 'Date the customer was disenrolled or removed from the assistance program.',
    `disenrollment_reason` STRING COMMENT 'Reason for customer disenrollment from the assistance program (e.g., income exceeded threshold, failed recertification, customer request, account closed, moved out of service territory).',
    `effective_end_date` DATE COMMENT 'Date when the assistance program benefits cease applying to the customer account. Null for open-ended enrollments.',
    `effective_start_date` DATE COMMENT 'Date when the assistance program benefits begin applying to the customer account.',
    `eligibility_criteria` STRING COMMENT 'Description of the eligibility requirements for the assistance program (e.g., income threshold, household size, participation in other programs).',
    `enrollment_date` DATE COMMENT 'Date the customer was enrolled in the financial assistance program.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the customer enrollment in the assistance program.. Valid values are `pending|active|suspended|expired|terminated|denied`',
    `funding_source` STRING COMMENT 'Primary source of funding for the assistance program benefits.. Valid values are `federal|state|utility|ratepayer|grant|other`',
    `income_threshold_amount` DECIMAL(18,2) COMMENT 'Maximum annual household income threshold for program eligibility.',
    `income_threshold_percentage_fpl` DECIMAL(18,2) COMMENT 'Income threshold expressed as a percentage of the Federal Poverty Level (e.g., 200.00 for 200% of FPL).',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the representative who last modified this assistance program enrollment record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this assistance program enrollment record was last updated in the system.',
    `maximum_benefit_amount` DECIMAL(18,2) COMMENT 'Maximum total benefit amount the customer can receive under the assistance program during the enrollment period.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the assistance program enrollment, eligibility determination, or special circumstances.',
    `program_code` STRING COMMENT 'Unique code identifying the assistance program type (e.g., LIHEAP, CARE, FERA, AMP).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `program_name` STRING COMMENT 'Full name of the financial assistance program (e.g., Low Income Home Energy Assistance Program, California Alternate Rates for Energy, Family Electric Rate Assistance).',
    `program_period_end_date` DATE COMMENT 'End date of the program period or program year for which this enrollment is valid.',
    `program_period_start_date` DATE COMMENT 'Start date of the program period or program year for which this enrollment is valid.',
    `program_type` STRING COMMENT 'Classification of the assistance program benefit structure.. Valid values are `discount|credit|arrearage_forgiveness|payment_plan|energy_efficiency`',
    `puc_docket_number` STRING COMMENT 'PUC docket or proceeding number under which the assistance program was approved.. Valid values are `^[A-Z0-9-.]{5,30}$`',
    `regulatory_mandate` STRING COMMENT 'Regulatory requirement or mandate authorizing the assistance program (e.g., PUC decision number, state statute reference).',
    `service_agreement` BIGINT COMMENT 'FK to billing.service_agreement.service_agreement_id — Program enrollments (now within assistance_program) are linked to a specific service agreement. Required for benefit application and eligibility tracking.',
    CONSTRAINT pk_assistance_program PRIMARY KEY(`assistance_program_id`)
) COMMENT 'Reference and transactional entity defining utility-administered financial assistance programs and tracking individual customer enrollments. At the program level: captures program name (LIHEAP, CARE, FERA, arrearage management), eligibility criteria, benefit type (discount rate, bill credit, arrearage forgiveness), maximum benefit amount, funding source, regulatory mandate, and program period. At the enrollment level: captures enrollment date, enrolled service agreement, program type, eligibility verification status, benefit amount, enrollment expiration date, re-certification due date, disenrollment reason, and enrollment status. Sourced from Oracle CC&B program management and SAP IS-U. SSOT for all financial assistance program definitions and customer enrollment records. Supports PUC low-income program compliance reporting and customer affordability tracking.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `energy_utilities_ecm`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ADD CONSTRAINT `fk_billing_billing_service_agreement_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `energy_utilities_ecm`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_billing_run_id` FOREIGN KEY (`billing_run_id`) REFERENCES `energy_utilities_ecm`.`billing`.`billing_run`(`billing_run_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_billing_service_agreement_id` FOREIGN KEY (`billing_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`billing`.`billing_service_agreement`(`billing_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `energy_utilities_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_invoice_for_service_agreement` FOREIGN KEY (`invoice_for_service_agreement`) REFERENCES `energy_utilities_ecm`.`billing`.`billing_service_agreement`(`billing_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_rate_component_id` FOREIGN KEY (`rate_component_id`) REFERENCES `energy_utilities_ecm`.`billing`.`rate_component`(`rate_component_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_original_line_invoice_line_id` FOREIGN KEY (`original_line_invoice_line_id`) REFERENCES `energy_utilities_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `energy_utilities_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_primary_invoice_rate_component_id` FOREIGN KEY (`primary_invoice_rate_component_id`) REFERENCES `energy_utilities_ecm`.`billing`.`rate_component`(`rate_component_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_billing_service_agreement_id` FOREIGN KEY (`billing_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`billing`.`billing_service_agreement`(`billing_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_arrangement_id` FOREIGN KEY (`payment_arrangement_id`) REFERENCES `energy_utilities_ecm`.`billing`.`payment_arrangement`(`payment_arrangement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `energy_utilities_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_to_invoice_id` FOREIGN KEY (`to_invoice_id`) REFERENCES `energy_utilities_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ADD CONSTRAINT `fk_billing_payment_arrangement_billing_service_agreement_id` FOREIGN KEY (`billing_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`billing`.`billing_service_agreement`(`billing_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_billing_service_agreement_id` FOREIGN KEY (`billing_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`billing`.`billing_service_agreement`(`billing_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `energy_utilities_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `energy_utilities_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `energy_utilities_ecm`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `energy_utilities_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_billing_service_agreement_id` FOREIGN KEY (`billing_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`billing`.`billing_service_agreement`(`billing_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_reversed_adjustment_id` FOREIGN KEY (`reversed_adjustment_id`) REFERENCES `energy_utilities_ecm`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_to_invoice_id` FOREIGN KEY (`to_invoice_id`) REFERENCES `energy_utilities_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ADD CONSTRAINT `fk_billing_deposit_billing_service_agreement_id` FOREIGN KEY (`billing_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`billing`.`billing_service_agreement`(`billing_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ADD CONSTRAINT `fk_billing_dunning_notice_billing_service_agreement_id` FOREIGN KEY (`billing_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`billing`.`billing_service_agreement`(`billing_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ADD CONSTRAINT `fk_billing_dunning_notice_collections_id` FOREIGN KEY (`collections_id`) REFERENCES `energy_utilities_ecm`.`billing`.`collections`(`collections_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ADD CONSTRAINT `fk_billing_dunning_notice_payment_arrangement_id` FOREIGN KEY (`payment_arrangement_id`) REFERENCES `energy_utilities_ecm`.`billing`.`payment_arrangement`(`payment_arrangement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ADD CONSTRAINT `fk_billing_collections_billing_service_agreement_id` FOREIGN KEY (`billing_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`billing`.`billing_service_agreement`(`billing_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ADD CONSTRAINT `fk_billing_collections_payment_arrangement_id` FOREIGN KEY (`payment_arrangement_id`) REFERENCES `energy_utilities_ecm`.`billing`.`payment_arrangement`(`payment_arrangement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_collections_id` FOREIGN KEY (`collections_id`) REFERENCES `energy_utilities_ecm`.`billing`.`collections`(`collections_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ADD CONSTRAINT `fk_billing_budget_plan_billing_service_agreement_id` FOREIGN KEY (`billing_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`billing`.`billing_service_agreement`(`billing_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ADD CONSTRAINT `fk_billing_budget_plan_payment_arrangement_id` FOREIGN KEY (`payment_arrangement_id`) REFERENCES `energy_utilities_ecm`.`billing`.`payment_arrangement`(`payment_arrangement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_billing_run_id` FOREIGN KEY (`billing_run_id`) REFERENCES `energy_utilities_ecm`.`billing`.`billing_run`(`billing_run_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ADD CONSTRAINT `fk_billing_billing_run_reversed_run_billing_run_id` FOREIGN KEY (`reversed_run_billing_run_id`) REFERENCES `energy_utilities_ecm`.`billing`.`billing_run`(`billing_run_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_billing_service_agreement_id` FOREIGN KEY (`billing_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`billing`.`billing_service_agreement`(`billing_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_original_entry_revenue_recognition_id` FOREIGN KEY (`original_entry_revenue_recognition_id`) REFERENCES `energy_utilities_ecm`.`billing`.`revenue_recognition`(`revenue_recognition_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `energy_utilities_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `energy_utilities_ecm`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_revenue_invoice_id` FOREIGN KEY (`revenue_invoice_id`) REFERENCES `energy_utilities_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ADD CONSTRAINT `fk_billing_assistance_program_billing_service_agreement_id` FOREIGN KEY (`billing_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`billing`.`billing_service_agreement`(`billing_service_agreement_id`);

-- ========= TAGS =========
ALTER SCHEMA `energy_utilities_ecm`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `energy_utilities_ecm`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `control_area_id` SET TAGS ('dbx_business_glossary_term' = 'Control Area Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `load_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Load Zone Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `planning_period_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `billing_cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Type');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `billing_cycle_type` SET TAGS ('dbx_value_regex' = 'monthly|bimonthly|quarterly|annual|on_demand');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `budget_billing_eligible` SET TAGS ('dbx_business_glossary_term' = 'Budget Billing Eligible');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `customer_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Customer Charge Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `demand_charge_rate` SET TAGS ('dbx_business_glossary_term' = 'Demand Charge Rate ($/kW)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `energy_charge_rate` SET TAGS ('dbx_business_glossary_term' = 'Energy Charge Rate ($/kWh)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `fuel_adjustment_clause_applicable` SET TAGS ('dbx_business_glossary_term' = 'Fuel Adjustment Clause Applicable');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `has_seasonal_rates` SET TAGS ('dbx_business_glossary_term' = 'Has Seasonal Rates');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `has_tiered_pricing` SET TAGS ('dbx_business_glossary_term' = 'Has Tiered Pricing');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `has_tou_periods` SET TAGS ('dbx_business_glossary_term' = 'Has Time-of-Use (TOU) Periods');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `interruptible_service` SET TAGS ('dbx_business_glossary_term' = 'Interruptible Service');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `maximum_demand_kw` SET TAGS ('dbx_business_glossary_term' = 'Maximum Demand (kW)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `maximum_usage_kwh` SET TAGS ('dbx_business_glossary_term' = 'Maximum Usage (kWh)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `minimum_demand_kw` SET TAGS ('dbx_business_glossary_term' = 'Minimum Demand (kW)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `minimum_power_factor` SET TAGS ('dbx_business_glossary_term' = 'Minimum Power Factor');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `minimum_usage_kwh` SET TAGS ('dbx_business_glossary_term' = 'Minimum Usage (kWh)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `net_metering_eligible` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Eligible');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Notes');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `power_factor_penalty_applicable` SET TAGS ('dbx_business_glossary_term' = 'Power Factor Penalty Applicable');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `prepay_eligible` SET TAGS ('dbx_business_glossary_term' = 'Prepay Eligible');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `rate_class` SET TAGS ('dbx_business_glossary_term' = 'Rate Class');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `rate_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|agricultural|municipal|street_lighting');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `rate_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `rate_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `rate_description` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Description');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `rate_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Name');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `rate_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Status');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `rate_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded|suspended');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Number');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `renewable_energy_rider_applicable` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Rider Applicable');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'single_phase|three_phase|primary_service|secondary_service');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_IS_U|ORACLE_CCB|LEGACY_CIS');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `tariff_book_reference` SET TAGS ('dbx_business_glossary_term' = 'Tariff Book Reference');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `tax_inclusive` SET TAGS ('dbx_business_glossary_term' = 'Tax Inclusive');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `voltage_level` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ALTER COLUMN `voltage_level` SET TAGS ('dbx_value_regex' = 'primary|secondary|transmission|sub_transmission|distribution');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `rate_component_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Component ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `capacity_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Requirement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `dr_program_id` SET TAGS ('dbx_business_glossary_term' = 'Dr Program Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `fuel_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Contract Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `incentive_program_id` SET TAGS ('dbx_business_glossary_term' = 'Incentive Program Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `lmp_price_id` SET TAGS ('dbx_business_glossary_term' = 'Indexed Lmp Price Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `path_id` SET TAGS ('dbx_business_glossary_term' = 'Path Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `pnode_id` SET TAGS ('dbx_business_glossary_term' = 'Pnode Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Contract Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `adjustment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Frequency');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `adjustment_frequency` SET TAGS ('dbx_value_regex' = 'fixed|monthly|quarterly|annually|event_driven');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `applicable_days` SET TAGS ('dbx_business_glossary_term' = 'Applicable Days');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `applicable_days` SET TAGS ('dbx_value_regex' = 'all_days|weekdays|weekends|holidays|non_holidays');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|superseded|retired');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `bill_print_sequence` SET TAGS ('dbx_business_glossary_term' = 'Bill Print Sequence');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `billing_determinant` SET TAGS ('dbx_business_glossary_term' = 'Billing Determinant');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `billing_determinant` SET TAGS ('dbx_value_regex' = 'actual_usage|estimated_usage|contracted_demand|metered_demand|billing_demand|customer_count');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `calculation_formula` SET TAGS ('dbx_business_glossary_term' = 'Calculation Formula');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `charge_category` SET TAGS ('dbx_business_glossary_term' = 'Charge Category');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `charge_category` SET TAGS ('dbx_value_regex' = 'base|rider|surcharge|credit|adjustment|tax');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `component_code` SET TAGS ('dbx_business_glossary_term' = 'Component Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `component_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `component_description` SET TAGS ('dbx_business_glossary_term' = 'Component Description');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `component_name` SET TAGS ('dbx_business_glossary_term' = 'Component Name');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Component Type');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `component_type` SET TAGS ('dbx_value_regex' = 'energy_charge|demand_charge|customer_charge|fuel_adjustment|distribution_charge|transmission_charge');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `customer_class_applicability` SET TAGS ('dbx_business_glossary_term' = 'Customer Class Applicability');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `customer_class_applicability` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|agricultural|street_lighting|all_classes');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `decimal_precision` SET TAGS ('dbx_business_glossary_term' = 'Decimal Precision');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `index_reference` SET TAGS ('dbx_business_glossary_term' = 'Index Reference');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `maximum_charge` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `print_on_bill_flag` SET TAGS ('dbx_business_glossary_term' = 'Print on Bill Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `proration_method` SET TAGS ('dbx_business_glossary_term' = 'Proration Method');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `proration_method` SET TAGS ('dbx_value_regex' = 'daily|calendar_days|billing_days|none');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `puc_docket_number` SET TAGS ('dbx_business_glossary_term' = 'Public Utility Commission (PUC) Docket Number');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `puc_docket_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,20}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `rate_value` SET TAGS ('dbx_business_glossary_term' = 'Rate Value');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `regulatory_account_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Account Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `regulatory_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3,6}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `revenue_class` SET TAGS ('dbx_business_glossary_term' = 'Revenue Class');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `revenue_class` SET TAGS ('dbx_value_regex' = 'base_revenue|fuel_revenue|distribution_revenue|transmission_revenue|other_revenue');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `rider_code` SET TAGS ('dbx_business_glossary_term' = 'Rider Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `rider_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,5}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `rounding_rule` SET TAGS ('dbx_business_glossary_term' = 'Rounding Rule');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `rounding_rule` SET TAGS ('dbx_value_regex' = 'none|round_half_up|round_down|round_up|truncate');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `seasonal_applicability` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Applicability');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `tariff_sheet_reference` SET TAGS ('dbx_business_glossary_term' = 'Tariff Sheet Reference');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `tier_sequence` SET TAGS ('dbx_business_glossary_term' = 'Tier Sequence Number');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `tier_threshold_max` SET TAGS ('dbx_business_glossary_term' = 'Tier Threshold Maximum');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `tier_threshold_min` SET TAGS ('dbx_business_glossary_term' = 'Tier Threshold Minimum');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `tou_end_time` SET TAGS ('dbx_business_glossary_term' = 'Time-of-Use (TOU) End Time');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `tou_period` SET TAGS ('dbx_business_glossary_term' = 'Time-of-Use (TOU) Period');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `tou_period` SET TAGS ('dbx_value_regex' = 'on_peak|mid_peak|off_peak|super_off_peak|critical_peak|all_hours');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `tou_start_time` SET TAGS ('dbx_business_glossary_term' = 'Time-of-Use (TOU) Start Time');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `voltage_level` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level');
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ALTER COLUMN `voltage_level` SET TAGS ('dbx_value_regex' = 'secondary|primary|sub_transmission|transmission|all_levels');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` SET TAGS ('dbx_subdomain' = 'billing_operations');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `billing_service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Service Agreement ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Transmission Substation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `incentive_program_id` SET TAGS ('dbx_business_glossary_term' = 'Incentive Program Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Service Connection Asset Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Counterparty Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Number');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Type');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|nem|municipal|agricultural');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `autopay_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Payment Enrollment Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `billing_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|bimonthly|quarterly|annual');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `billing_service_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `billing_service_agreement_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|terminated|cancelled|inactive');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `budget_billing_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Billing Monthly Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `budget_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Billing Enrollment Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `contract_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Contract Capacity Kilowatts (kW)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `credit_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `demand_metered_flag` SET TAGS ('dbx_business_glossary_term' = 'Demand Metered Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Received Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `deposit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Deposit Required Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `disconnect_pending_flag` SET TAGS ('dbx_business_glossary_term' = 'Disconnect Pending Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `dunning_block_flag` SET TAGS ('dbx_business_glossary_term' = 'Dunning Block Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `dunning_block_reason` SET TAGS ('dbx_business_glossary_term' = 'Dunning Block Reason');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective End Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Start Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `life_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Life Support Equipment Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `life_support_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `load_profile_type` SET TAGS ('dbx_business_glossary_term' = 'Load Profile Type');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `load_profile_type` SET TAGS ('dbx_value_regex' = 'flat|tou|cpp|rtp|critical_peak_rebate');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `low_income_assistance_flag` SET TAGS ('dbx_business_glossary_term' = 'Low Income Assistance Program Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `low_income_assistance_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `nem_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `nem_program_type` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Program Type');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `nem_program_type` SET TAGS ('dbx_value_regex' = 'nem_1_0|nem_2_0|nem_3_0|vnem|aggregated_nem');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `paperless_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Paperless Billing Enrollment Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `payment_arrangement_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement Active Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Default Payment Method');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_draft|credit_card|check|cash|electronic_transfer|autopay');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `revenue_class` SET TAGS ('dbx_business_glossary_term' = 'Revenue Class');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `service_voltage_level` SET TAGS ('dbx_business_glossary_term' = 'Service Voltage Level');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `service_voltage_level` SET TAGS ('dbx_value_regex' = 'secondary|primary|subtransmission|transmission');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `special_contract_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Contract Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `special_contract_terms` SET TAGS ('dbx_business_glossary_term' = 'Special Contract Terms');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `special_contract_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Agreement Termination Reason');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` SET TAGS ('dbx_subdomain' = 'billing_operations');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Agreement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `billing_run_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Run Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `billing_service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Service Agreement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `energy_price_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Price Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `market_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Market Settlement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `meter_point_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Point Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `nem_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nem Account Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `nem_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Nem Agreement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `peak_demand_id` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Contract Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `ppa_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `ppa_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Settlement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Identifier');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `settlement_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Statement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `auto_pay_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Pay Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `bill_message_code` SET TAGS ('dbx_business_glossary_term' = 'Bill Message Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `billing_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `billing_days` SET TAGS ('dbx_business_glossary_term' = 'Billing Days');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `budget_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Billing Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `current_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Charges Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'postal_mail|email|customer_portal|sms');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `deposit_applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Applied Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `energy_consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Kilowatt-Hours (kWh)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'regular|final|interim|adjustment|credit|debit');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `meter_read_end_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Read End Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `meter_read_start_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Read Start Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `outstanding_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `paperless_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Paperless Billing Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `payment_arrangement_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `payment_received_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `peak_demand_kw` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand Kilowatts (kW)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `previous_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Previous Balance Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `print_date` SET TAGS ('dbx_business_glossary_term' = 'Print Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `rate_class` SET TAGS ('dbx_business_glossary_term' = 'Rate Class');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `rate_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|agricultural|municipal|street_lighting');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `total_amount_due` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Due');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` SET TAGS ('dbx_subdomain' = 'billing_operations');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `curtailment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `dr_incentive_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Dr Incentive Payment Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `generation_meter_read_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Meter Read Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `original_line_invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Original Line ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `ppa_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Settlement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `primary_invoice_rate_component_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Component Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `vpp_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Vpp Configuration Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `adjustment_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Description');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `billing_determinant_quantity` SET TAGS ('dbx_business_glossary_term' = 'Billing Determinant Quantity');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `billing_determinant_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Determinant Type');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `charge_category` SET TAGS ('dbx_business_glossary_term' = 'Charge Category');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Consumption Kilowatt-Hours (kWh)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN|EUR|GBP');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `demand_kw` SET TAGS ('dbx_business_glossary_term' = 'Demand Kilowatts (kW)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `meter_read_end_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Read End Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `meter_read_start_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Read Start Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `print_sequence` SET TAGS ('dbx_business_glossary_term' = 'Print Sequence');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `print_suppress_flag` SET TAGS ('dbx_business_glossary_term' = 'Print Suppress Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `proration_factor` SET TAGS ('dbx_business_glossary_term' = 'Proration Factor');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `rate_component_description` SET TAGS ('dbx_business_glossary_term' = 'Rate Component Description');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `rate_version` SET TAGS ('dbx_business_glossary_term' = 'Rate Version');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `rate_version` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{2}-[0-9]{2}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `revenue_class` SET TAGS ('dbx_business_glossary_term' = 'Revenue Class');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `revenue_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|agricultural|public_authority|street_lighting');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `service_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service Period End Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `service_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Period Start Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `source_line_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Line Reference');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_ISU|ORACLE_CCB|LEGACY_CIS');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,10}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `taxable_flag` SET TAGS ('dbx_business_glossary_term' = 'Taxable Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `tier_level` SET TAGS ('dbx_business_glossary_term' = 'Tier Level');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `total_line_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Line Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `tou_period_code` SET TAGS ('dbx_business_glossary_term' = 'Time of Use (TOU) Period Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `tou_period_code` SET TAGS ('dbx_value_regex' = 'on_peak|off_peak|mid_peak|super_off_peak|critical_peak|standard');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ALTER COLUMN `write_off_flag` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` SET TAGS ('dbx_subdomain' = 'payment_collections');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `payment_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `settlement_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Statement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Application Status');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `application_status` SET TAGS ('dbx_value_regex' = 'unapplied|partially_applied|fully_applied|suspended|reversed');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Payment Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Authorization Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `auto_pay_enrollment_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Pay Enrollment Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_number_masked` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number (Masked)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_number_masked` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_number_masked` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number (ABA RTN)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Batch Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `card_expiration_month` SET TAGS ('dbx_business_glossary_term' = 'Payment Card Expiration Month');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `card_expiration_year` SET TAGS ('dbx_business_glossary_term' = 'Payment Card Expiration Year');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `card_last_four_digits` SET TAGS ('dbx_business_glossary_term' = 'Payment Card Last Four Digits');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `card_last_four_digits` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `card_last_four_digits` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `card_last_four_digits` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Card Type');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|other');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `disbursement_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Refund Disbursement Confirmation Number');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Disbursement Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `lockbox_number` SET TAGS ('dbx_business_glossary_term' = 'Lockbox Number');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Notes');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `nsf_fee_assessed` SET TAGS ('dbx_business_glossary_term' = 'Non-Sufficient Funds (NSF) Fee Assessed');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Processing Status');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|applied|cleared|reversed|failed|cancelled');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `payment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Type');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'inbound_payment|outbound_refund|credit_memo|debit_memo|adjustment');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `refund_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Refund Approval Status');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `refund_approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected|disbursed');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `refund_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Approval Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `refund_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Refund Approved By User');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `refund_method` SET TAGS ('dbx_business_glossary_term' = 'Refund Disbursement Method');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `refund_method` SET TAGS ('dbx_value_regex' = 'check|ach|account_credit|original_payment_method');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `refund_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `refund_reason_code` SET TAGS ('dbx_value_regex' = 'overpayment|deposit_return|credit_balance|billing_error|service_cancellation|duplicate_payment');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Reversal Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Reversal Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Reversal Reason Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_value_regex' = 'nsf|chargeback|customer_dispute|bank_return|administrative_error|fraud');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Payment Source System');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor Transaction Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Payment Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` SET TAGS ('dbx_subdomain' = 'payment_collections');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `payment_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `arrangement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement End Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement Number');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('dbx_value_regex' = '^PA[0-9]{10}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `arrangement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement Start Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `arrangement_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement Status');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `arrangement_status` SET TAGS ('dbx_value_regex' = 'draft|active|completed|breached|cancelled|suspended');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement Type');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `arrangement_type` SET TAGS ('dbx_value_regex' = 'installment_plan|deferred_payment|settlement_agreement|budget_billing|hardship_plan|promise_to_pay');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `auto_pay_enrolled_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Pay Enrolled Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `breach_date` SET TAGS ('dbx_business_glossary_term' = 'Breach Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `breach_reason` SET TAGS ('dbx_business_glossary_term' = 'Breach Reason');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `breach_threshold` SET TAGS ('dbx_business_glossary_term' = 'Breach Threshold');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `customer_signature_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Signature Received Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `down_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Down Payment Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `down_payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Down Payment Received Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `first_installment_due_date` SET TAGS ('dbx_business_glossary_term' = 'First Installment Due Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `installment_amount` SET TAGS ('dbx_business_glossary_term' = 'Installment Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `installment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Installment Frequency');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `installment_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `installments_missed_count` SET TAGS ('dbx_business_glossary_term' = 'Installments Missed Count');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `installments_paid_count` SET TAGS ('dbx_business_glossary_term' = 'Installments Paid Count');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `interest_accrued_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrued Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Percentage');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `last_installment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Last Installment Due Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Notes');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `notification_preference` SET TAGS ('dbx_business_glossary_term' = 'Notification Preference');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `notification_preference` SET TAGS ('dbx_value_regex' = 'email|sms|mail|phone|none');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `number_of_installments` SET TAGS ('dbx_business_glossary_term' = 'Number of Installments');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `payment_method_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `payment_method_code` SET TAGS ('dbx_value_regex' = 'bank_draft|credit_card|debit_card|check|cash|electronic_funds_transfer');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `total_amount_owed` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Owed');
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `waived_fees_amount` SET TAGS ('dbx_business_glossary_term' = 'Waived Fees Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` SET TAGS ('dbx_subdomain' = 'billing_operations');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `determinant_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Determinant ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `billing_service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `curtailment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `der_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Der Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `der_system_id` SET TAGS ('dbx_business_glossary_term' = 'Der System Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `dr_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Dr Enrollment Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `dr_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dr Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `energy_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Schedule Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `generation_meter_read_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Meter Read Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `grid_reliability_event_id` SET TAGS ('dbx_business_glossary_term' = 'Grid Reliability Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `lmp_price_id` SET TAGS ('dbx_business_glossary_term' = 'Lmp Price Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `load_id` SET TAGS ('dbx_business_glossary_term' = 'Load Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `market_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Market Settlement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `meter_point_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Point Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `nem_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nem Account Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `nem_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Nem Agreement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `outage_event_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `peak_demand_id` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `pnode_id` SET TAGS ('dbx_business_glossary_term' = 'Pnode Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Contract Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `ppa_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Delivery Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Service Interruption Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `vpp_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Vpp Configuration Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `billing_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `billing_days` SET TAGS ('dbx_business_glossary_term' = 'Billing Days');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `billing_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Billing Multiplier');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'interval_sum|demand_window|tou_allocation|net_metering|estimated');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Determinant Calculation Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `contract_demand_kw` SET TAGS ('dbx_business_glossary_term' = 'Contract Demand Kilowatt (kW)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `critical_peak_kwh` SET TAGS ('dbx_business_glossary_term' = 'Critical Peak Kilowatt-Hour (kWh) Consumption');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `estimated_interval_count` SET TAGS ('dbx_business_glossary_term' = 'Estimated Interval Count');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `interval_count` SET TAGS ('dbx_business_glossary_term' = 'Interval Count');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `is_final_determinant` SET TAGS ('dbx_business_glossary_term' = 'Is Final Determinant');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `load_factor` SET TAGS ('dbx_business_glossary_term' = 'Load Factor');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `mid_peak_kwh` SET TAGS ('dbx_business_glossary_term' = 'Mid-Peak Kilowatt-Hour (kWh) Consumption');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `net_metering_export_kwh` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Export Kilowatt-Hour (kWh)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `net_metering_import_kwh` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Import Kilowatt-Hour (kWh)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `off_peak_demand_kw` SET TAGS ('dbx_business_glossary_term' = 'Off-Peak Demand Kilowatt (kW)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `off_peak_kwh` SET TAGS ('dbx_business_glossary_term' = 'Off-Peak Kilowatt-Hour (kWh) Consumption');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `on_peak_demand_kw` SET TAGS ('dbx_business_glossary_term' = 'On-Peak Demand Kilowatt (kW)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `on_peak_kwh` SET TAGS ('dbx_business_glossary_term' = 'On-Peak Kilowatt-Hour (kWh) Consumption');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `peak_demand_kw` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand Kilowatt (kW)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `peak_demand_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `power_factor` SET TAGS ('dbx_business_glossary_term' = 'Power Factor');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `ratchet_demand_kw` SET TAGS ('dbx_business_glossary_term' = 'Ratchet Demand Kilowatt (kW)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `reactive_demand_kvar` SET TAGS ('dbx_business_glossary_term' = 'Reactive Demand Kilovolt-Ampere Reactive (kVAR)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'mdm|ami|manual_entry|estimated|scada');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `temperature_normalized_kwh` SET TAGS ('dbx_business_glossary_term' = 'Temperature Normalized Kilowatt-Hour (kWh)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `total_kwh` SET TAGS ('dbx_business_glossary_term' = 'Total Kilowatt-Hour (kWh) Consumption');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `tou_period_1_kwh` SET TAGS ('dbx_business_glossary_term' = 'Time-of-Use (TOU) Period 1 Kilowatt-Hour (kWh)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `tou_period_2_kwh` SET TAGS ('dbx_business_glossary_term' = 'Time-of-Use (TOU) Period 2 Kilowatt-Hour (kWh)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `tou_period_3_kwh` SET TAGS ('dbx_business_glossary_term' = 'Time-of-Use (TOU) Period 3 Kilowatt-Hour (kWh)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `tou_period_4_kwh` SET TAGS ('dbx_business_glossary_term' = 'Time-of-Use (TOU) Period 4 Kilowatt-Hour (kWh)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|pending_review|failed_validation|manually_adjusted|estimated');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` SET TAGS ('dbx_subdomain' = 'payment_collections');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Agreement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `curtailment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `der_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Der Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `failure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `grid_reliability_event_id` SET TAGS ('dbx_business_glossary_term' = 'Grid Reliability Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `incentive_application_id` SET TAGS ('dbx_business_glossary_term' = 'Incentive Application Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `incentive_program_id` SET TAGS ('dbx_business_glossary_term' = 'Incentive Program Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Application Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `interruption_id` SET TAGS ('dbx_business_glossary_term' = 'Interruption Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `market_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Market Settlement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `meter_point_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Point Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `nem_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nem Account Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `nem_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Nem Agreement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `outage_event_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Outage Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `planned_outage_window_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Outage Window Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `ppa_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Settlement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `reversed_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Adjustment Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `rps_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Rps Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Service Interruption Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `settlement_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Statement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `storm_event_id` SET TAGS ('dbx_business_glossary_term' = 'Storm Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `trade_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `transmission_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Outage Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `vpp_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Vpp Configuration Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Transaction Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Number');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `affected_billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Affected Billing Period End Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `affected_billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Affected Billing Period Start Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Approval Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Approval Status');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|auto_approved|escalated|cancelled');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Effective Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `nem_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Credit Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `nem_credit_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Credit Expiration Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `nem_credit_rate` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Credit Rate');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `nem_cumulative_credit_balance` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Cumulative Credit Balance');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `nem_exported_kwh` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Exported Kilowatt-Hours (kWh)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `nem_tariff_version` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Tariff Version');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `posted_to_gl_flag` SET TAGS ('dbx_business_glossary_term' = 'Posted to General Ledger (GL) Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Description');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `revenue_class` SET TAGS ('dbx_business_glossary_term' = 'Revenue Class');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `source_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Document Reference');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_ISU|Oracle_CCB|MDM|Manual_Entry|Automated_Process|Customer_Portal');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Tariff Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `write_off_flag` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ALTER COLUMN `write_off_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` SET TAGS ('dbx_subdomain' = 'payment_collections');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `deposit_id` SET TAGS ('dbx_business_glossary_term' = 'Deposit Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `accrued_interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `collection_method` SET TAGS ('dbx_value_regex' = 'cash|check|credit_card|bank_transfer|payroll_deduction|installment_plan');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `deposit_number` SET TAGS ('dbx_business_glossary_term' = 'Deposit Number');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `deposit_number` SET TAGS ('dbx_value_regex' = '^DEP-[0-9]{8,12}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `deposit_status` SET TAGS ('dbx_business_glossary_term' = 'Deposit Status');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `deposit_status` SET TAGS ('dbx_value_regex' = 'active|refunded|forfeited|transferred|expired|pending_refund');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `deposit_type` SET TAGS ('dbx_business_glossary_term' = 'Deposit Type');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `deposit_type` SET TAGS ('dbx_value_regex' = 'cash|surety_bond|letter_of_credit|bank_guarantee|escrow');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `forfeiture_amount` SET TAGS ('dbx_business_glossary_term' = 'Forfeiture Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `forfeiture_date` SET TAGS ('dbx_business_glossary_term' = 'Forfeiture Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `forfeiture_reason` SET TAGS ('dbx_business_glossary_term' = 'Forfeiture Reason');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `forfeiture_reason` SET TAGS ('dbx_value_regex' = 'payment_default|service_disconnection|final_bill_settlement|account_closure|regulatory_violation');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `guarantee_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Expiration Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `guarantee_instrument_number` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Instrument Number');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `guarantee_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Provider Name');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `interest_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Interest Calculation Method');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `interest_calculation_method` SET TAGS ('dbx_value_regex' = 'simple|compound_monthly|compound_quarterly|compound_annually|none');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `interest_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Percentage');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Deposit Notes');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Deposit Reason Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'new_service|poor_credit|payment_default|high_usage|regulatory_requirement|voluntary');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `refund_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `refund_eligibility_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Eligibility Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `refund_method` SET TAGS ('dbx_business_glossary_term' = 'Refund Method');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `refund_method` SET TAGS ('dbx_value_regex' = 'check|direct_deposit|account_credit|wire_transfer');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `regulatory_holding_period_months` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Holding Period (Months)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` SET TAGS ('dbx_subdomain' = 'payment_collections');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `dunning_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Dunning Notice ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `billing_service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `payment_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `action_date` SET TAGS ('dbx_business_glossary_term' = 'Action Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `action_taken` SET TAGS ('dbx_business_glossary_term' = 'Action Taken');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Name');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `delivery_address` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `delivery_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `delivery_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_value_regex' = 'mail|email|sms|door_hanger|phone_call|customer_portal');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'sent|delivered|bounced|failed|pending');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `dunning_block_code` SET TAGS ('dbx_business_glossary_term' = 'Dunning Block Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `dunning_block_reason` SET TAGS ('dbx_business_glossary_term' = 'Dunning Block Reason');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `dunning_fee` SET TAGS ('dbx_business_glossary_term' = 'Dunning Fee');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `dunning_level` SET TAGS ('dbx_value_regex' = 'first_notice|second_notice|final_notice|disconnect_warning|disconnect_order|legal_referral');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `dunning_notice_number` SET TAGS ('dbx_business_glossary_term' = 'Dunning Notice Number');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `dunning_status` SET TAGS ('dbx_business_glossary_term' = 'Dunning Status');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `late_payment_fee` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Fee');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `oldest_invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Oldest Invoice Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `past_due_amount` SET TAGS ('dbx_business_glossary_term' = 'Past Due Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `print_suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'Print Suppression Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `protected_customer_flag` SET TAGS ('dbx_business_glossary_term' = 'Protected Customer Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `regulatory_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notice Days');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `regulatory_notice_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notice Required');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `total_amount_due` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Due');
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` SET TAGS ('dbx_subdomain' = 'payment_collections');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `collections_id` SET TAGS ('dbx_business_glossary_term' = 'Collections Identifier');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `payment_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `bankruptcy_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Bankruptcy Filing Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `bankruptcy_flag` SET TAGS ('dbx_business_glossary_term' = 'Bankruptcy Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `case_close_date` SET TAGS ('dbx_business_glossary_term' = 'Collections Case Close Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Collections Case Number');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `case_open_date` SET TAGS ('dbx_business_glossary_term' = 'Collections Case Open Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `case_resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Collections Case Resolution Outcome');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Collections Case Status');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `delinquent_amount` SET TAGS ('dbx_business_glossary_term' = 'Delinquent Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `disconnect_executed_date` SET TAGS ('dbx_business_glossary_term' = 'Disconnect Executed Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `disconnect_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Disconnect Scheduled Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `disconnect_status` SET TAGS ('dbx_business_glossary_term' = 'Disconnect Status');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `disconnect_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|scheduled|executed|cancelled|reconnected');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `escalation_count` SET TAGS ('dbx_business_glossary_term' = 'Escalation Count');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `external_agency_code` SET TAGS ('dbx_business_glossary_term' = 'External Collections Agency ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `last_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Method');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `last_contact_method` SET TAGS ('dbx_value_regex' = 'phone|email|sms|mail|door_hanger|in_person');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `last_escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Escalation Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `legal_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Referral Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `legal_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Referral Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `next_action_date` SET TAGS ('dbx_business_glossary_term' = 'Next Action Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `next_action_type` SET TAGS ('dbx_business_glossary_term' = 'Next Action Type');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Collections Case Notes');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `original_delinquent_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Delinquent Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `past_due_days` SET TAGS ('dbx_business_glossary_term' = 'Past Due Days');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `promise_kept_flag` SET TAGS ('dbx_business_glossary_term' = 'Promise Kept Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `promise_to_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Promise to Pay Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `promise_to_pay_date` SET TAGS ('dbx_business_glossary_term' = 'Promise to Pay Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `reconnect_condition` SET TAGS ('dbx_business_glossary_term' = 'Reconnect Condition');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `reconnect_date` SET TAGS ('dbx_business_glossary_term' = 'Reconnect Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Collections Stage');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `stage` SET TAGS ('dbx_value_regex' = 'early_stage|mid_stage|late_stage|pre_disconnect|disconnect|legal');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `write_off_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Eligible Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ALTER COLUMN `write_off_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` SET TAGS ('dbx_subdomain' = 'payment_collections');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_id` SET TAGS ('dbx_business_glossary_term' = 'Write-Off ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `collections_id` SET TAGS ('dbx_business_glossary_term' = 'Collections Case ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `market_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Market Settlement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = '0-30|31-60|61-90|91-120|121-180|over_180');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `approval_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Level');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `approval_level` SET TAGS ('dbx_value_regex' = 'supervisor|manager|director|vp|cfo');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `bankruptcy_case_number` SET TAGS ('dbx_business_glossary_term' = 'Bankruptcy Case Number');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `bankruptcy_chapter` SET TAGS ('dbx_business_glossary_term' = 'Bankruptcy Chapter');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `bankruptcy_chapter` SET TAGS ('dbx_value_regex' = 'chapter_7|chapter_11|chapter_13');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `collection_agency_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Agency Referral Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `external_collection_agency` SET TAGS ('dbx_business_glossary_term' = 'External Collection Agency');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `principal_amount` SET TAGS ('dbx_business_glossary_term' = 'Principal Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `puc_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Public Utility Commission (PUC) Reporting Category');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `puc_reporting_category` SET TAGS ('dbx_value_regex' = 'residential_uncollectable|commercial_uncollectable|industrial_uncollectable|other_uncollectable');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `rate_class` SET TAGS ('dbx_business_glossary_term' = 'Rate Class');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `rate_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|agricultural');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'bankruptcy|deceased|skip|hardship|uncollectable|fraud');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason Description');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `recovery_date` SET TAGS ('dbx_business_glossary_term' = 'Recovery Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `recovery_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Recovery Eligible Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'electric|gas|water|steam|combined');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `tax_reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Year');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_number` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Number');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_number` SET TAGS ('dbx_value_regex' = '^WO-[0-9]{8,12}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_status` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Status');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_status` SET TAGS ('dbx_value_regex' = 'pending|approved|posted|reversed|recovered');
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Identifier');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `billing_service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Service Agreement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `energy_price_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Price Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `payment_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `affordability_program_code` SET TAGS ('dbx_business_glossary_term' = 'Affordability Program Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renew Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `budget_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Status');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `budget_plan_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|cancelled|completed|true_up_pending');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `cumulative_actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Actual Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `cumulative_billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Billed Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|AUD|MXN');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `eligibility_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verified Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|call_center|in_person|mail|auto_enrolled');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `historical_usage_kwh` SET TAGS ('dbx_business_glossary_term' = 'Historical Usage Kilowatt-Hours (kWh)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `last_true_up_amount` SET TAGS ('dbx_business_glossary_term' = 'Last True-Up Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `last_true_up_date` SET TAGS ('dbx_business_glossary_term' = 'Last True-Up Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `monthly_installment_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Installment Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Notes');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Number');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `plan_term_months` SET TAGS ('dbx_business_glossary_term' = 'Plan Term Months');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Type');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'levelized|equal_payment|rolling_average|fixed_amount|seasonal_adjustment|custom');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `recalculation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Recalculation Frequency');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `recalculation_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|on_demand');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `true_up_month` SET TAGS ('dbx_business_glossary_term' = 'True-Up Month');
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` SET TAGS ('dbx_subdomain' = 'billing_operations');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `billing_run_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Run Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `market_run_id` SET TAGS ('dbx_business_glossary_term' = 'Market Run Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `accounts_processed_count` SET TAGS ('dbx_business_glossary_term' = 'Accounts Processed Count');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `assigned_account_count` SET TAGS ('dbx_business_glossary_term' = 'Assigned Account Count');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `bill_due_date_offset_days` SET TAGS ('dbx_business_glossary_term' = 'Bill Due Date Offset in Days');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `billing_run_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Run Execution Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Name');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Configuration Status');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|archived');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Type');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_type` SET TAGS ('dbx_value_regex' = 'monthly|bi-monthly|quarterly|on-demand|final');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Effective End Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Effective Start Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `exception_count` SET TAGS ('dbx_business_glossary_term' = 'Exception Count');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `exception_summary` SET TAGS ('dbx_business_glossary_term' = 'Exception Summary');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Invoice Delivery Method');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_value_regex' = 'paper|email|portal|sms|suppressed');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `invoice_print_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Print Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `invoices_generated_count` SET TAGS ('dbx_business_glossary_term' = 'Invoices Generated Count');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Notes');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `rate_class` SET TAGS ('dbx_business_glossary_term' = 'Rate Class');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `rate_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|agricultural|municipal');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `read_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Meter Read Frequency in Days');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `run_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Billing Run Duration in Minutes');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `run_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Billing Run End Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `run_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Billing Run Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Run Status');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'pending|in-progress|completed|completed-with-exceptions|error|cancelled');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `scheduled_bill_generation_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Bill Generation Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `scheduled_read_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Meter Read End Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `scheduled_read_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Meter Read Start Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `total_billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Billed Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ALTER COLUMN `total_kwh_billed` SET TAGS ('dbx_business_glossary_term' = 'Total Kilowatt-Hours (kWh) Billed');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` SET TAGS ('dbx_subdomain' = 'billing_operations');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `billing_run_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Run Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `reversed_run_billing_run_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Billing Run Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `accounts_failed` SET TAGS ('dbx_business_glossary_term' = 'Accounts Failed Processing');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `accounts_processed` SET TAGS ('dbx_business_glossary_term' = 'Accounts Successfully Processed');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `accounts_targeted` SET TAGS ('dbx_business_glossary_term' = 'Accounts Targeted for Billing');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected|not_required');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `batch_job_reference` SET TAGS ('dbx_business_glossary_term' = 'Batch Job Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Run Duration in Seconds');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `error_count` SET TAGS ('dbx_business_glossary_term' = 'Error Count');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `exception_count` SET TAGS ('dbx_business_glossary_term' = 'Exception Count');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `execution_mode` SET TAGS ('dbx_business_glossary_term' = 'Execution Mode');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `execution_mode` SET TAGS ('dbx_value_regex' = 'automatic|manual|scheduled|on_demand');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `gl_posting_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Status');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `gl_posting_status` SET TAGS ('dbx_value_regex' = 'not_posted|posted|posting_failed|reversed');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `invoice_due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `invoices_generated` SET TAGS ('dbx_business_glossary_term' = 'Invoices Generated Count');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Billing Run Notes');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `print_batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Print Batch Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `rate_schedule_version` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Version');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Billing Run Number');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Run Status');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|completed_with_errors|failed|cancelled');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Run Type');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `run_type` SET TAGS ('dbx_value_regex' = 'regular|interim|final|correction|reversal|special');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `total_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Adjustment Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `total_billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Billed Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `total_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Net Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_run` ALTER COLUMN `total_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` SET TAGS ('dbx_subdomain' = 'billing_operations');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Identifier');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Agreement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `billing_service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `curtailment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `der_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Der Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `dr_incentive_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Dr Incentive Payment Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `energy_price_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Price Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `energy_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Schedule Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `generation_meter_read_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Meter Read Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `incentive_application_id` SET TAGS ('dbx_business_glossary_term' = 'Incentive Application Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `incentive_program_id` SET TAGS ('dbx_business_glossary_term' = 'Incentive Program Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `load_id` SET TAGS ('dbx_business_glossary_term' = 'Load Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `market_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Market Settlement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `nem_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nem Account Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `nem_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Nem Agreement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `original_entry_revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Original Revenue Recognition Entry ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `output_telemetry_id` SET TAGS ('dbx_business_glossary_term' = 'Output Telemetry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Contract Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `ppa_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `ppa_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Ppa Settlement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `rps_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Rps Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `trade_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `vpp_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Vpp Configuration Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `accounting_period` SET TAGS ('dbx_value_regex' = '^d{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Adjustment Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|posted');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `billed_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Billed Revenue Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption (kWh)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `deferred_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `demand_kw` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand (kW)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `meter_read_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Read Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Notes');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `performance_obligation` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `recognition_method` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time|accrual|deferral|straight_line');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `recognized_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Recognized Revenue Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `regulatory_account_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Account Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `revenue_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Category');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `revenue_category` SET TAGS ('dbx_value_regex' = 'energy|demand|customer_charge|rider|ancillary_service|late_fee');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `revenue_class` SET TAGS ('dbx_business_glossary_term' = 'Revenue Class');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `revenue_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|wholesale|municipal|agricultural');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `rider_code` SET TAGS ('dbx_business_glossary_term' = 'Rider Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `service_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service Period End Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `service_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Period Start Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `source_document_number` SET TAGS ('dbx_business_glossary_term' = 'Source Document Number');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_IS-U|Oracle_CC&B|SAP_S4HANA|Manual_Entry');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `tariff_version` SET TAGS ('dbx_business_glossary_term' = 'Tariff Version');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `unbilled_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Unbilled Revenue Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `assistance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Assistance Program Identifier');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `billing_service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Service Agreement ID');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `energy_price_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Price Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `irp_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Irp Scenario Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `incentive_program_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Incentive Program Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `application_method` SET TAGS ('dbx_business_glossary_term' = 'Application Method');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `application_method` SET TAGS ('dbx_value_regex' = 'online|phone|mail|in_person|agency_referral|auto_enrollment');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `benefit_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Type');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `benefit_type` SET TAGS ('dbx_value_regex' = 'percentage_discount|fixed_credit|tiered_discount|arrearage_forgiveness|rate_reduction');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `disenrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `disenrollment_reason` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Reason');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'pending|active|suspended|expired|terminated|denied');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'federal|state|utility|ratepayer|grant|other');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `income_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Income Threshold Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `income_threshold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `income_threshold_percentage_fpl` SET TAGS ('dbx_business_glossary_term' = 'Income Threshold Percentage Federal Poverty Level (FPL)');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `maximum_benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Benefit Amount');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `program_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program Period End Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `program_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Period Start Date');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'discount|credit|arrearage_forgiveness|payment_plan|energy_efficiency');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `puc_docket_number` SET TAGS ('dbx_business_glossary_term' = 'Public Utility Commission (PUC) Docket Number');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `puc_docket_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-.]{5,30}$');
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ALTER COLUMN `regulatory_mandate` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate');
