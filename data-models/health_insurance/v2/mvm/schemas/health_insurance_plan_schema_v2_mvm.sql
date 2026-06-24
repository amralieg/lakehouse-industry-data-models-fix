-- Schema for Domain: plan | Business: Health_Insurance | Version: v2_mvm
-- Generated on: 2026-06-23 01:34:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`plan` COMMENT 'Single source of truth for all health plan products and benefit designs — HMO, PPO, EPO, POS, HDHP, QHP, and government plans (Medicare Advantage, Medicaid). Owns benefit structures, cost-sharing rules (deductibles, copays, coinsurance, OOP, MOOP), formulary tiers, SBC documents, plan-year configurations, and regulatory classifications. Supports ACA compliance, CMS plan submissions, and benefits configuration in core administration platforms (Facets, QNXT).';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` (
    `health_plan_id` BIGINT COMMENT 'Primary key',
    `formulary_id` BIGINT COMMENT 'FK to formulary',
    `benefit_design_version` STRING COMMENT 'The benefit design version attribute capturing relevant data for the health plan in the plan domain.',
    `cms_plan_code` STRING COMMENT 'A standardized code representing the cms plan classification.',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'The coinsurance percentage attribute capturing relevant data for the health plan in the plan domain.',
    `copay_primary_care` DECIMAL(18,2) COMMENT 'Primary care copay',
    `copay_specialist` DECIMAL(18,2) COMMENT 'Specialist copay',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the health plan in the plan domain.',
    `deductible_family` DECIMAL(18,2) COMMENT 'Family deductible amount',
    `deductible_individual` DECIMAL(18,2) COMMENT 'Individual deductible amount',
    `effective_date` DATE COMMENT 'The date value representing effective date for this health plan record.',
    `enrollment_end_date` DATE COMMENT 'The date value representing enrollment end date for this health plan record.',
    `enrollment_start_date` DATE COMMENT 'The date value representing enrollment start date for this health plan record.',
    `hcc_score` DECIMAL(18,2) COMMENT 'HCC risk score',
    `hios_plan_code` STRING COMMENT 'A standardized code representing the hios plan classification.',
    `is_exempt_from_mlr` BOOLEAN COMMENT 'MLR exemption flag',
    `last_review_date` DATE COMMENT 'The date value representing last review date for this health plan record.',
    `line_of_business` STRING COMMENT 'The line of business attribute capturing relevant data for the health plan in the plan domain.',
    `market_segment` STRING COMMENT 'The market segment attribute capturing relevant data for the health plan in the plan domain.',
    `network_tier` STRING COMMENT 'The network tier attribute capturing relevant data for the health plan in the plan domain.',
    `out_of_pocket_max_family` DECIMAL(18,2) COMMENT 'Family OOP max',
    `out_of_pocket_max_individual` DECIMAL(18,2) COMMENT 'Individual OOP max',
    `plan_aca_compliant` BOOLEAN COMMENT 'ACA compliant flag',
    `plan_category` STRING COMMENT 'The plan category attribute capturing relevant data for the health plan in the plan domain.',
    `plan_code` STRING COMMENT 'Plan code identifier',
    `plan_description` STRING COMMENT 'A detailed textual description of the plan.',
    `plan_marketplace_eligible` BOOLEAN COMMENT 'Marketplace eligible flag',
    `plan_name` STRING COMMENT 'The descriptive name assigned to the plan for identification purposes.',
    `plan_region` STRING COMMENT 'Region where plan is offered',
    `plan_state` STRING COMMENT 'State where plan is offered',
    `plan_status` STRING COMMENT 'The current status indicator for the plan within the workflow.',
    `plan_type` STRING COMMENT 'Plan type (HMO, PPO, etc)',
    `plan_year` STRING COMMENT 'The calendar or fiscal year associated with the plan.',
    `premium_amount` DECIMAL(18,2) COMMENT 'The numeric premium amount value associated with this health plan record.',
    `premium_currency` DECIMAL(18,2) COMMENT 'The premium currency for this record.',
    `premium_frequency` DECIMAL(18,2) COMMENT 'The premium frequency for this record.',
    `regulatory_classification` STRING COMMENT 'The regulatory classification attribute capturing relevant data for the health plan in the plan domain.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'The risk adjustment factor attribute capturing relevant data for the health plan in the plan domain.',
    `sbc_document_url` STRING COMMENT 'The sbc document url attribute capturing relevant data for the health plan in the plan domain.',
    `termination_date` DATE COMMENT 'The date value representing termination date for this health plan record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the health plan in the plan domain.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    CONSTRAINT pk_health_plan PRIMARY KEY(`health_plan_id`)
) COMMENT 'Core health plan entity containing plan design, cost sharing, and regulatory details';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` (
    `benefit_package_id` BIGINT COMMENT 'Primary key',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `network_config_id` BIGINT COMMENT 'Foreign key linking to plan.network_config. Business justification: A benefit package is associated with a specific network configuration — the network tier and designation define which provider network applies to the benefit package (e.g., HMO benefit package uses a ',
    `actuarial_value_pct` DECIMAL(18,2) COMMENT 'Actuarial value percentage',
    `benefit_package_status` STRING COMMENT 'Package status',
    `coinsurance_inpatient` DECIMAL(18,2) COMMENT 'Inpatient coinsurance',
    `coinsurance_outpatient` DECIMAL(18,2) COMMENT 'Outpatient coinsurance',
    `copay_primary_care` DECIMAL(18,2) COMMENT 'Primary care copay',
    `copay_specialist` DECIMAL(18,2) COMMENT 'Specialist copay',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the benefit package in the plan domain.',
    `deductible_type` DECIMAL(18,2) COMMENT 'The deductible type for this record.',
    `effective_end_date` DATE COMMENT 'The date value representing effective end date for this benefit package record.',
    `effective_start_date` DATE COMMENT 'The date value representing effective start date for this benefit package record.',
    `family_deductible_amount` DECIMAL(18,2) COMMENT 'Family deductible',
    `generic_substitution_required` BOOLEAN COMMENT 'Generic substitution required flag',
    `individual_deductible_amount` DECIMAL(18,2) COMMENT 'Individual deductible',
    `mail_order_copay_brand` DECIMAL(18,2) COMMENT 'Brand mail order copay',
    `mail_order_copay_generic` DECIMAL(18,2) COMMENT 'Generic mail order copay',
    `metal_tier` STRING COMMENT 'Metal tier (Bronze, Silver, Gold, Platinum)',
    `out_of_pocket_max_family` DECIMAL(18,2) COMMENT 'Family OOP max',
    `out_of_pocket_max_individual` DECIMAL(18,2) COMMENT 'Individual OOP max',
    `package_code` STRING COMMENT 'A standardized code representing the package classification.',
    `package_name` STRING COMMENT 'The descriptive name assigned to the package for identification purposes.',
    `plan_type` STRING COMMENT 'The category or classification type of the plan.',
    `prior_auth_required` BOOLEAN COMMENT 'Prior auth required flag',
    `retail_copay_brand` DECIMAL(18,2) COMMENT 'Brand retail copay',
    `retail_copay_generic` DECIMAL(18,2) COMMENT 'Generic retail copay',
    `specialty_copay` DECIMAL(18,2) COMMENT 'Specialty drug copay',
    `specialty_drug_management_program` STRING COMMENT 'The specialty drug management program for this record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the benefit package in the plan domain.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    CONSTRAINT pk_benefit_package PRIMARY KEY(`benefit_package_id`)
) COMMENT 'Benefit package grouping benefits and cost sharing rules';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`benefit` (
    `benefit_id` BIGINT COMMENT 'Primary key',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: A benefit belongs to a benefit package — benefit_package is the grouping entity that organizes individual benefits and cost-sharing rules within a health plan. This 1:N relationship (benefit_package h',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Drug-specific benefit rules (specialty drug benefits, formulary exclusions) must reference the drug master for NDC validation, therapeutic class assignment, and ACA EHB compliance reporting. Plan desi',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `accumulation_rule` STRING COMMENT 'The accumulation rule for this record.',
    `authorization_required` BOOLEAN COMMENT 'Authorization required flag',
    `authorization_type` STRING COMMENT 'The category or classification type of the authorization.',
    `benefit_group` STRING COMMENT 'The benefit group attribute capturing relevant data for the benefit in the plan domain.',
    `benefit_status` STRING COMMENT 'The current status indicator for the benefit within the workflow.',
    `benefit_category` STRING COMMENT 'The benefit category attribute capturing relevant data for the benefit in the plan domain.',
    `benefit_code` STRING COMMENT 'A standardized code representing the benefit classification.',
    `cost_sharing_amount` DECIMAL(18,2) COMMENT 'The numeric cost sharing amount value associated with this benefit record.',
    `cost_sharing_frequency` DECIMAL(18,2) COMMENT 'The cost sharing frequency for this record.',
    `cost_sharing_percent` DECIMAL(18,2) COMMENT 'Cost sharing percentage',
    `cost_sharing_type` DECIMAL(18,2) COMMENT 'The category or classification type of the cost sharing.',
    `coverage_type` STRING COMMENT 'The category or classification type of the coverage.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the benefit in the plan domain.',
    `diagnosis_code` STRING COMMENT 'The diagnosis code for this record.',
    `effective_end_date` DATE COMMENT 'The date value representing effective end date for this benefit record.',
    `effective_start_date` DATE COMMENT 'The date value representing effective start date for this benefit record.',
    `ehb_classification` STRING COMMENT 'Essential health benefit classification',
    `exclusion_code` STRING COMMENT 'The exclusion code for this record.',
    `exclusion_reason` STRING COMMENT 'The exclusion reason for this record.',
    `exclusion_type` STRING COMMENT 'The exclusion type for this record.',
    `formulary_tier` STRING COMMENT 'The formulary tier for this record.',
    `is_exempt` BOOLEAN COMMENT 'Exempt flag',
    `is_mandatory` BOOLEAN COMMENT 'Mandatory benefit flag',
    `limit_period` STRING COMMENT 'The limit period attribute capturing relevant data for the benefit in the plan domain.',
    `limit_type` STRING COMMENT 'The category or classification type of the limit.',
    `limit_value` DECIMAL(18,2) COMMENT 'The limit value attribute capturing relevant data for the benefit in the plan domain.',
    `moop_max_amount` DECIMAL(18,2) COMMENT 'The moop max amount for this record.',
    `benefit_name` STRING COMMENT 'The descriptive name assigned to the benefit for identification purposes.',
    `oop_max_amount` DECIMAL(18,2) COMMENT 'The oop max amount for this record.',
    `plan_year` STRING COMMENT 'The calendar or fiscal year associated with the plan.',
    `preventive_service_flag` BOOLEAN COMMENT 'Boolean indicator for the preventive service condition or state.',
    `prior_auth_review_level` STRING COMMENT 'The prior auth review level for this record.',
    `regulatory_classification` STRING COMMENT 'The regulatory classification attribute capturing relevant data for the benefit in the plan domain.',
    `service_code` STRING COMMENT 'A standardized code representing the service classification.',
    `tier` STRING COMMENT 'The tier for this record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the benefit in the plan domain.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    `wellness_mandate_flag` BOOLEAN COMMENT 'The wellness mandate flag for this record.',
    CONSTRAINT pk_benefit PRIMARY KEY(`benefit_id`)
) COMMENT 'Individual benefit definition within a plan';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` (
    `cost_share_rule_id` BIGINT COMMENT 'Primary key',
    `benefit_id` BIGINT COMMENT 'FK to benefit',
    `benefit_package_id` BIGINT COMMENT 'FK to benefit package',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `network_config_id` BIGINT COMMENT 'Foreign key linking to plan.network_config. Business justification: Cost sharing rules are network-tier-specific — in-network and out-of-network cost sharing rules differ based on the network configuration. cost_share_rule has network_type as a string attribute and se',
    `accumulator_threshold` DECIMAL(18,2) COMMENT 'The accumulator threshold for this record.',
    `accumulator_unit` STRING COMMENT 'The accumulator unit for this record.',
    `after_deductible` BOOLEAN COMMENT 'The after deductible for this record.',
    `applies_to_ancillary` BOOLEAN COMMENT 'The applies to ancillary for this record.',
    `applies_to_drug` BOOLEAN COMMENT 'The applies to drug for this record.',
    `applies_to_procedure` BOOLEAN COMMENT 'The applies to procedure for this record.',
    `applies_to_service_category` STRING COMMENT 'The applies to service category for this record.',
    `coinsurance_rate` DECIMAL(18,2) COMMENT 'The numeric coinsurance rate value associated with this cost share rule record.',
    `coinsurance_rate_out_of_network` DECIMAL(18,2) COMMENT 'OON coinsurance rate',
    `copay_amount` DECIMAL(18,2) COMMENT 'The numeric copay amount value associated with this cost share rule record.',
    `copay_amount_out_of_network` DECIMAL(18,2) COMMENT 'OON copay amount',
    `cost_share_category` DECIMAL(18,2) COMMENT 'The cost share category for this record.',
    `cost_share_rule_status` DECIMAL(18,2) COMMENT 'Rule status',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the cost share rule in the plan domain.',
    `deductible_aggregate_flag` BOOLEAN COMMENT 'Aggregate deductible flag',
    `deductible_amount` DECIMAL(18,2) COMMENT 'The numeric deductible amount value associated with this cost share rule record.',
    `deductible_embedded_flag` BOOLEAN COMMENT 'Embedded deductible flag',
    `cost_share_rule_description` DECIMAL(18,2) COMMENT 'The cost share rule description for this record.',
    `effective_end_date` DATE COMMENT 'The date value representing effective end date for this cost share rule record.',
    `effective_start_date` DATE COMMENT 'The date value representing effective start date for this cost share rule record.',
    `hsa_compatible` BOOLEAN COMMENT 'HSA compatible flag',
    `is_default_rule` BOOLEAN COMMENT 'Default rule flag',
    `max_benefit_amount` DECIMAL(18,2) COMMENT 'The numeric max benefit amount value associated with this cost share rule record.',
    `max_benefit_units` STRING COMMENT 'The max benefit units attribute capturing relevant data for the cost share rule in the plan domain.',
    `member_tier` STRING COMMENT 'The member tier attribute capturing relevant data for the cost share rule in the plan domain.',
    `network_type` STRING COMMENT 'The category or classification type of the network.',
    `notes` STRING COMMENT 'The notes for this record.',
    `out_of_pocket_max` DECIMAL(18,2) COMMENT 'The numeric out of pocket max value associated with this cost share rule record.',
    `out_of_pocket_max_family` DECIMAL(18,2) COMMENT 'Family OOP max',
    `prior_to_deductible` BOOLEAN COMMENT 'The prior to deductible for this record.',
    `regulatory_classification` STRING COMMENT 'The regulatory classification for this record.',
    `rule_code` STRING COMMENT 'A standardized code representing the rule classification.',
    `rule_name` STRING COMMENT 'The descriptive name assigned to the rule for identification purposes.',
    `rule_type` STRING COMMENT 'The category or classification type of the rule.',
    `rule_version` STRING COMMENT 'The rule version attribute capturing relevant data for the cost share rule in the plan domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the cost share rule in the plan domain.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    CONSTRAINT pk_cost_share_rule PRIMARY KEY(`cost_share_rule_id`)
) COMMENT 'Cost sharing rules for benefits';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` (
    `sbc_document_id` BIGINT COMMENT 'Primary key',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `approval_date` DATE COMMENT 'The date value representing approval date for this sbc document record.',
    `author` STRING COMMENT 'The author for this record.',
    `checksum_sha256` STRING COMMENT 'SHA256 checksum',
    `cost_sharing_highlights` DECIMAL(18,2) COMMENT 'The cost sharing highlights for this record.',
    `coverage_example` STRING COMMENT 'The coverage example attribute capturing relevant data for the sbc document in the plan domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the sbc document in the plan domain.',
    `document_category` STRING COMMENT 'The document category attribute capturing relevant data for the sbc document in the plan domain.',
    `document_number` STRING COMMENT 'The document number attribute capturing relevant data for the sbc document in the plan domain.',
    `document_size_bytes` BIGINT COMMENT 'Document size in bytes',
    `document_title` STRING COMMENT 'The document title attribute capturing relevant data for the sbc document in the plan domain.',
    `document_type` STRING COMMENT 'The category or classification type of the document.',
    `document_url` STRING COMMENT 'The document url attribute capturing relevant data for the sbc document in the plan domain.',
    `effective_date` DATE COMMENT 'The date value representing effective date for this sbc document record.',
    `expiration_date` DATE COMMENT 'The date value representing expiration date for this sbc document record.',
    `format` STRING COMMENT 'Document format',
    `is_current` BOOLEAN COMMENT 'Current version flag',
    `language` STRING COMMENT 'Document language',
    `plan_year` STRING COMMENT 'The calendar or fiscal year associated with the plan.',
    `regulatory_submission_status` STRING COMMENT 'The current status indicator for the regulatory submission within the workflow.',
    `revision_number` STRING COMMENT 'The revision number attribute capturing relevant data for the sbc document in the plan domain.',
    `sbc_document_status` STRING COMMENT 'Document status',
    `sbc_version` STRING COMMENT 'The sbc version attribute capturing relevant data for the sbc document in the plan domain.',
    `submission_date` DATE COMMENT 'The date value representing submission date for this sbc document record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the sbc document in the plan domain.',
    `version_number` STRING COMMENT 'The version number attribute capturing relevant data for the sbc document in the plan domain.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_sbc_document PRIMARY KEY(`sbc_document_id`)
) COMMENT 'Summary of Benefits and Coverage document';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`rate` (
    `rate_id` BIGINT COMMENT 'Primary key',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Premium rates in health insurance are often tied to specific benefit package designs — different benefit packages (e.g., bronze vs. gold metal tier packages) within the same health plan carry differen',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `service_area_id` BIGINT COMMENT 'Foreign key linking to plan.plan_service_area. Business justification: ACA-compliant premium rates are filed and applied by geographic rating area. rate currently has rating_area_code as a denormalized string. plan_service_area is the authoritative source for geographic ',
    `age_rated_premium` DECIMAL(18,2) COMMENT 'The age rated premium attribute capturing relevant data for the rate in the plan domain.',
    `base_rate` DECIMAL(18,2) COMMENT 'The numeric base rate value associated with this rate record.',
    `change_reason` STRING COMMENT 'The change reason for this record.',
    `rate_code` DECIMAL(18,2) COMMENT 'A standardized code representing the rate classification.',
    `cost_sharing_rule_code` DECIMAL(18,2) COMMENT 'The cost sharing rule code for this record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the rate in the plan domain.',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `effective_date` DATE COMMENT 'The date value representing effective date for this rate record.',
    `family_tier` STRING COMMENT 'The family tier attribute capturing relevant data for the rate in the plan domain.',
    `family_tier_premium` DECIMAL(18,2) COMMENT 'The family tier premium attribute capturing relevant data for the rate in the plan domain.',
    `filing_reference` STRING COMMENT 'The filing reference attribute capturing relevant data for the rate in the plan domain.',
    `is_tobacco_surcharge_applicable` BOOLEAN COMMENT 'The is tobacco surcharge applicable for this record.',
    `market_segment` STRING COMMENT 'The market segment attribute capturing relevant data for the rate in the plan domain.',
    `max_age` STRING COMMENT 'Maximum age',
    `min_age` STRING COMMENT 'Minimum age',
    `rate_name` DECIMAL(18,2) COMMENT 'The descriptive name assigned to the rate for identification purposes.',
    `plan_designation` STRING COMMENT 'The plan designation attribute capturing relevant data for the rate in the plan domain.',
    `plan_year` STRING COMMENT 'The calendar or fiscal year associated with the plan.',
    `premium_type` DECIMAL(18,2) COMMENT 'The premium type for this record.',
    `rate_status` DECIMAL(18,2) COMMENT 'The current status indicator for the rate within the workflow.',
    `regulatory_filing_type` STRING COMMENT 'The category or classification type of the regulatory filing.',
    `surcharge_amount` DECIMAL(18,2) COMMENT 'The numeric surcharge amount value associated with this rate record.',
    `termination_date` DATE COMMENT 'The date value representing termination date for this rate record.',
    `tobacco_use_indicator` BOOLEAN COMMENT 'The tobacco use indicator attribute capturing relevant data for the rate in the plan domain.',
    `underwriting_class_code` STRING COMMENT 'A standardized code representing the underwriting class classification.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the rate in the plan domain.',
    `version` STRING COMMENT 'The version for this record.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_rate PRIMARY KEY(`rate_id`)
) COMMENT 'Premium rate configuration';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`service_area` (
    `service_area_id` BIGINT COMMENT 'Primary key',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `sbc_document_id` BIGINT COMMENT 'FK to SBC document',
    `service_area_code` STRING COMMENT 'A standardized code representing the service area classification.',
    `county` STRING COMMENT 'The county attribute capturing relevant data for the plan service area in the plan domain.',
    `coverage_type` STRING COMMENT 'The category or classification type of the coverage.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the plan service area in the plan domain.',
    `effective_end_date` DATE COMMENT 'The date value representing effective end date for this plan service area record.',
    `effective_start_date` DATE COMMENT 'The date value representing effective start date for this plan service area record.',
    `enrollment_capacity` STRING COMMENT 'The enrollment capacity attribute capturing relevant data for the plan service area in the plan domain.',
    `exchange_market` STRING COMMENT 'The exchange market attribute capturing relevant data for the plan service area in the plan domain.',
    `exchange_market_code` STRING COMMENT 'A standardized code representing the exchange market classification.',
    `geographic_region_code` STRING COMMENT 'A standardized code representing the geographic region classification.',
    `is_exclusive` BOOLEAN COMMENT 'Exclusive flag',
    `is_federal_funded` BOOLEAN COMMENT 'The is federal funded for this record.',
    `is_medicaid_eligible` BOOLEAN COMMENT 'Medicaid eligible flag',
    `is_medicare_eligible` BOOLEAN COMMENT 'Medicare eligible flag',
    `is_regulatory_compliant` BOOLEAN COMMENT 'Regulatory compliant flag',
    `is_state_funded` BOOLEAN COMMENT 'The is state funded for this record.',
    `lifecycle_status` STRING COMMENT 'The current status indicator for the lifecycle within the workflow.',
    `service_area_name` STRING COMMENT 'The descriptive name assigned to the service area for identification purposes.',
    `network_type` STRING COMMENT 'The category or classification type of the network.',
    `notes` STRING COMMENT 'The notes for this record.',
    `plan_category` STRING COMMENT 'The plan category attribute capturing relevant data for the plan service area in the plan domain.',
    `plan_year` STRING COMMENT 'The calendar or fiscal year associated with the plan.',
    `regulatory_approval_status` STRING COMMENT 'The current status indicator for the regulatory approval within the workflow.',
    `regulatory_filing_number` STRING COMMENT 'The regulatory filing number attribute capturing relevant data for the plan service area in the plan domain.',
    `service_area_type` STRING COMMENT 'The category or classification type of the service area.',
    `state` STRING COMMENT 'The state attribute capturing relevant data for the plan service area in the plan domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the plan service area in the plan domain.',
    `version_number` STRING COMMENT 'The version number attribute capturing relevant data for the plan service area in the plan domain.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    `zip_codes_excluded` STRING COMMENT 'Excluded ZIP codes',
    `zip_codes_included` STRING COMMENT 'Included ZIP codes',
    CONSTRAINT pk_service_area PRIMARY KEY(`service_area_id`)
) COMMENT 'Geographic service area for a plan';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` (
    `rx_benefit_config_id` BIGINT COMMENT 'Primary key',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Pharmacy benefit configurations are scoped to specific benefit packages — different benefit packages within a health plan can have different formulary tiers, copay structures, and pharmacy network typ',
    `fee_schedule_id` DECIMAL(18,2) COMMENT 'Foreign key linking to contract.fee_schedule. Business justification: Pharmacy benefit configurations govern drug coverage; pharmacy fee schedules (AWP-based, MAC pricing) define allowed amounts for drug claims. Pharmacy claims adjudication requires linking rx_benefit_c',
    `formulary_id` BIGINT COMMENT 'FK to formulary',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `pbm_contract_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pbm_contract. Business justification: rx_benefit_config defines pharmacy benefit parameters administered under a PBM contract. pbm_vendor is a denormalized text field violating 3NF. Replacing it with pbm_contract_id enables contract-level',
    `coinsurance_rate` DECIMAL(18,2) COMMENT 'The numeric coinsurance rate value associated with this rx benefit config record.',
    `cost_sharing_method` DECIMAL(18,2) COMMENT 'The cost sharing method for this record.',
    `coverage_limit_per_prescription` DECIMAL(18,2) COMMENT 'Per prescription limit',
    `coverage_limit_per_year` DECIMAL(18,2) COMMENT 'Per year limit',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the rx benefit config in the plan domain.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'The numeric deductible amount value associated with this rx benefit config record.',
    `deductible_applicable` BOOLEAN COMMENT 'Deductible applicable flag',
    `drug_category_exclusions` STRING COMMENT 'The drug category exclusions attribute capturing relevant data for the rx benefit config in the plan domain.',
    `effective_end_date` DATE COMMENT 'The date value representing effective end date for this rx benefit config record.',
    `effective_start_date` DATE COMMENT 'The date value representing effective start date for this rx benefit config record.',
    `formulary_version` STRING COMMENT 'The formulary version attribute capturing relevant data for the rx benefit config in the plan domain.',
    `is_biologic_preferred` BOOLEAN COMMENT 'Biologic preferred',
    `is_biosimilar_preferred` BOOLEAN COMMENT 'Biosimilar preferred',
    `is_exempt_from_mlr` BOOLEAN COMMENT 'MLR exempt flag',
    `is_specialty_drug_excluded` BOOLEAN COMMENT 'Specialty drug excluded',
    `last_review_date` DATE COMMENT 'The date value representing last review date for this rx benefit config record.',
    `mail_order_network_type` STRING COMMENT 'The category or classification type of the mail order network.',
    `max_coverage_amount` DECIMAL(18,2) COMMENT 'The numeric max coverage amount value associated with this rx benefit config record.',
    `ninety_day_supply_allowed` BOOLEAN COMMENT '90-day supply allowed',
    `notes` STRING COMMENT 'The notes for this record.',
    `out_of_pocket_max` DECIMAL(18,2) COMMENT 'The numeric out of pocket max value associated with this rx benefit config record.',
    `prior_auth_exemption_drugs` STRING COMMENT 'The prior auth exemption drugs attribute capturing relevant data for the rx benefit config in the plan domain.',
    `regulatory_classification` STRING COMMENT 'The regulatory classification attribute capturing relevant data for the rx benefit config in the plan domain.',
    `retail_network_type` STRING COMMENT 'The category or classification type of the retail network.',
    `rx_benefit_config_status` STRING COMMENT 'Config status',
    `specialty_pharmacy_network` STRING COMMENT 'The specialty pharmacy network attribute capturing relevant data for the rx benefit config in the plan domain.',
    `step_therapy_required` BOOLEAN COMMENT 'The step therapy required attribute capturing relevant data for the rx benefit config in the plan domain.',
    `therapeutic_class_limit` STRING COMMENT 'The therapeutic class limit attribute capturing relevant data for the rx benefit config in the plan domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the rx benefit config in the plan domain.',
    `version_number` STRING COMMENT 'The version number attribute capturing relevant data for the rx benefit config in the plan domain.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_rx_benefit_config PRIMARY KEY(`rx_benefit_config_id`)
) COMMENT 'Pharmacy benefit configuration';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`network_config` (
    `network_config_id` BIGINT COMMENT 'Primary key',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `service_area_id` BIGINT COMMENT 'Foreign key linking to plan.plan_service_area. Business justification: Network configurations are geographically scoped — a network configuration applies within a specific service area (e.g., a county-level HMO network, a state-level PPO network). network_config currentl',
    `access_type` STRING COMMENT 'The category or classification type of the access.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the network config in the plan domain.',
    `effective_end_date` DATE COMMENT 'The date value representing effective end date for this network config record.',
    `effective_start_date` DATE COMMENT 'The date value representing effective start date for this network config record.',
    `network_adequacy_measure` STRING COMMENT 'Adequacy measure',
    `network_adequacy_standard_code` STRING COMMENT 'Adequacy standard code',
    `network_config_status` STRING COMMENT 'Config status',
    `network_contract_number` STRING COMMENT 'Contract number',
    `network_coverage_type` STRING COMMENT 'Coverage type',
    `network_designation` STRING COMMENT 'The network designation attribute capturing relevant data for the network config in the plan domain.',
    `network_exclusion_description` STRING COMMENT 'The network exclusion description for this record.',
    `network_exclusion_flag` BOOLEAN COMMENT 'Boolean indicator for the network exclusion condition or state.',
    `network_provider_count` STRING COMMENT 'Provider count',
    `network_tier` STRING COMMENT 'The network tier attribute capturing relevant data for the network config in the plan domain.',
    `out_of_network_benefit_type` STRING COMMENT 'OON benefit type',
    `out_of_network_coinsurance_pct` DECIMAL(18,2) COMMENT 'OON coinsurance percentage',
    `out_of_network_copay_amount` DECIMAL(18,2) COMMENT 'OON copay amount',
    `out_of_network_coverage_flag` BOOLEAN COMMENT 'OON coverage flag',
    `tier_priority` STRING COMMENT 'The tier priority attribute capturing relevant data for the network config in the plan domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the network config in the plan domain.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_network_config PRIMARY KEY(`network_config_id`)
) COMMENT 'Network configuration for a plan';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`offering` (
    `offering_id` BIGINT COMMENT 'Primary key',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: An offering presents a specific health plan product to employer groups. In practice, an offering is tied to a specific benefit package within a plan — the employer group is offered a particular benefi',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `offering_code` STRING COMMENT 'A standardized code representing the offering classification.',
    `contribution_amount` DECIMAL(18,2) COMMENT 'The numeric contribution amount value associated with this offering record.',
    `contribution_percent` DECIMAL(18,2) COMMENT 'Contribution percentage',
    `contribution_tier` STRING COMMENT 'The contribution tier attribute capturing relevant data for the offering in the plan domain.',
    `contribution_type` STRING COMMENT 'The category or classification type of the contribution.',
    `effective_from` DATE COMMENT 'Effective from date',
    `effective_until` DATE COMMENT 'Effective until date',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'The numeric employee contribution amount value associated with this offering record.',
    `family_contribution_amount` DECIMAL(18,2) COMMENT 'The numeric family contribution amount value associated with this offering record.',
    `offering_name` STRING COMMENT 'The descriptive name assigned to the offering for identification purposes.',
    `offering_status` STRING COMMENT 'The current status indicator for the offering within the workflow.',
    `offering_type` STRING COMMENT 'The category or classification type of the offering.',
    `open_enrollment_end_date` DATE COMMENT 'OE end date',
    `open_enrollment_start_date` DATE COMMENT 'OE start date',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_offering PRIMARY KEY(`offering_id`)
) COMMENT 'Plan offering to employer groups';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract` (
    `provider_contract_id` BIGINT COMMENT 'Primary key',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `network_config_id` BIGINT COMMENT 'Foreign key linking to plan.network_config. Business justification: A provider contract linkage to a health plan is associated with a specific network configuration — the contract defines the providers participation in a particular network tier (e.g., Tier 1 preferre',
    `party_id` BIGINT COMMENT 'Foreign key linking to contract.party. Business justification: A plan-provider contract is executed with a legal entity (party). Provider contracting and credentialing operations require knowing which contracting party (provider organization, NPI, TIN) is party t',
    `contract_reference` STRING COMMENT 'Contract reference number',
    `contract_status` STRING COMMENT 'The current status indicator for the contract within the workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_date` DATE COMMENT 'Contract effective date',
    `is_in_network` BOOLEAN COMMENT 'Whether provider is in network',
    `reimbursement_method` STRING COMMENT 'The reimbursement method attribute capturing relevant data for the plan provider contract in the plan domain.',
    `reimbursement_terms` STRING COMMENT 'The reimbursement terms attribute capturing relevant data for the plan provider contract in the plan domain.',
    `relationship_type` STRING COMMENT 'Type of relationship',
    `termination_date` DATE COMMENT 'Contract termination date',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_provider_contract PRIMARY KEY(`provider_contract_id`)
) COMMENT 'Provider contract linkage to health plans';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ADD CONSTRAINT `fk_plan_benefit_package_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ADD CONSTRAINT `fk_plan_benefit_package_network_config_id` FOREIGN KEY (`network_config_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`network_config`(`network_config_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ADD CONSTRAINT `fk_plan_benefit_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ADD CONSTRAINT `fk_plan_benefit_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ADD CONSTRAINT `fk_plan_cost_share_rule_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ADD CONSTRAINT `fk_plan_cost_share_rule_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ADD CONSTRAINT `fk_plan_cost_share_rule_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ADD CONSTRAINT `fk_plan_cost_share_rule_network_config_id` FOREIGN KEY (`network_config_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`network_config`(`network_config_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ADD CONSTRAINT `fk_plan_sbc_document_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ADD CONSTRAINT `fk_plan_rate_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ADD CONSTRAINT `fk_plan_rate_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ADD CONSTRAINT `fk_plan_rate_service_area_id` FOREIGN KEY (`service_area_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`service_area`(`service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`service_area` ADD CONSTRAINT `fk_plan_service_area_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`service_area` ADD CONSTRAINT `fk_plan_service_area_sbc_document_id` FOREIGN KEY (`sbc_document_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`sbc_document`(`sbc_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ADD CONSTRAINT `fk_plan_rx_benefit_config_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ADD CONSTRAINT `fk_plan_rx_benefit_config_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ADD CONSTRAINT `fk_plan_network_config_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ADD CONSTRAINT `fk_plan_network_config_service_area_id` FOREIGN KEY (`service_area_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`service_area`(`service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ADD CONSTRAINT `fk_plan_offering_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ADD CONSTRAINT `fk_plan_offering_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract` ADD CONSTRAINT `fk_plan_provider_contract_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract` ADD CONSTRAINT `fk_plan_provider_contract_network_config_id` FOREIGN KEY (`network_config_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`network_config`(`network_config_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`plan` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_health_insurance_v1`.`plan` SET TAGS ('dbx_domain' = 'plan');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_state` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `network_config_id` SET TAGS ('dbx_business_glossary_term' = 'Network Config Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `package_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `benefit_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `network_config_id` SET TAGS ('dbx_business_glossary_term' = 'Network Config Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `author` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` SET TAGS ('dbx_subdomain' = 'market_offering');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Service Area Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `age_rated_premium` SET TAGS ('dbx_pii_type' = 'demographic');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `max_age` SET TAGS ('dbx_pii_type' = 'demographic');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `min_age` SET TAGS ('dbx_pii_type' = 'demographic');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `rate_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `rate_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `underwriting_class_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`service_area` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`service_area` SET TAGS ('dbx_subdomain' = 'market_offering');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`service_area` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`service_area` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`service_area` ALTER COLUMN `is_state_funded` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`service_area` ALTER COLUMN `service_area_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`service_area` ALTER COLUMN `state` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`service_area` ALTER COLUMN `zip_codes_excluded` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`service_area` ALTER COLUMN `zip_codes_included` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` SET TAGS ('dbx_subdomain' = 'coverage_configuration');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `pbm_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Pbm Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `coverage_limit_per_prescription` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `coverage_limit_per_prescription` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` SET TAGS ('dbx_subdomain' = 'coverage_configuration');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Service Area Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` SET TAGS ('dbx_subdomain' = 'market_offering');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `offering_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract` SET TAGS ('dbx_subdomain' = 'coverage_configuration');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract` ALTER COLUMN `network_config_id` SET TAGS ('dbx_business_glossary_term' = 'Network Config Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`provider_contract` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
