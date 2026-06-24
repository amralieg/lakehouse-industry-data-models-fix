-- Schema for Domain: plan | Business:  | Version: v2_ecm
-- Generated on: 2026-06-22 23:51:45

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`plan` COMMENT 'Single source of truth for all health plan products and benefit designs — HMO, PPO, EPO, POS, HDHP, QHP, and government plans (Medicare Advantage, Medicaid). Owns benefit structures, cost-sharing rules (deductibles, copays, coinsurance, OOP, MOOP), formulary tiers, SBC documents, plan-year configurations, and regulatory classifications. Supports ACA compliance, CMS plan submissions, and benefits configuration in core administration platforms (Facets, QNXT).';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` (
    `health_plan_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `pbm_contract_id` BIGINT COMMENT 'FK to PBM contract',
    `formulary_id` BIGINT COMMENT 'FK to formulary',
    `provider_network_id` BIGINT COMMENT 'FK to provider network',
    `pool_id` BIGINT COMMENT 'FK to risk pool',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
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
    `cost_center_id` BIGINT COMMENT 'The cost center id for this record.',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `formulary_id` BIGINT COMMENT 'FK to formulary',
    `vendor_id` BIGINT COMMENT 'The pharmacy vendor id for this record.',
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
    `network_designation` STRING COMMENT 'The network designation attribute capturing relevant data for the benefit package in the plan domain.',
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
    `drug_ndc` STRING COMMENT 'The drug ndc for this record.',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`year` (
    `year_id` BIGINT COMMENT 'Primary key',
    `budget_id` BIGINT COMMENT 'FK to budget',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `aca_compliance_indicator` BOOLEAN COMMENT 'The aca compliance indicator attribute capturing relevant data for the year in the plan domain.',
    `accumulator_reset_date` DATE COMMENT 'The date value representing accumulator reset date for this year record.',
    `cms_plan_submission_deadline` DATE COMMENT 'CMS submission deadline',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the year in the plan domain.',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `effective_from` DATE COMMENT 'The effective from attribute capturing relevant data for the year in the plan domain.',
    `effective_until` DATE COMMENT 'The effective until attribute capturing relevant data for the year in the plan domain.',
    `end_date` DATE COMMENT 'The date value representing end date for this year record.',
    `grace_period_days` STRING COMMENT 'The grace period days attribute capturing relevant data for the year in the plan domain.',
    `open_enrollment_end_date` DATE COMMENT 'OE end date',
    `open_enrollment_start_date` DATE COMMENT 'OE start date',
    `plan_year_budget_amount` DECIMAL(18,2) COMMENT 'Budget amount',
    `plan_year_code` STRING COMMENT 'A standardized code representing the plan year classification.',
    `plan_year_coverage_type` STRING COMMENT 'Coverage type',
    `plan_year_description` STRING COMMENT 'A detailed textual description of the plan year.',
    `plan_year_market_segment` STRING COMMENT 'Market segment',
    `plan_year_notes` STRING COMMENT 'The plan year notes for this record.',
    `plan_year_premium_rate` DECIMAL(18,2) COMMENT 'Premium rate',
    `plan_year_regulatory_classification` STRING COMMENT 'The plan year regulatory classification for this record.',
    `plan_year_state` STRING COMMENT 'The plan year state attribute capturing relevant data for the year in the plan domain.',
    `plan_year_type` STRING COMMENT 'The category or classification type of the plan year.',
    `premium_effective_date` DATE COMMENT 'The date value representing premium effective date for this year record.',
    `regulatory_filing_required` BOOLEAN COMMENT 'The regulatory filing required attribute capturing relevant data for the year in the plan domain.',
    `revision_number` STRING COMMENT 'The revision number attribute capturing relevant data for the year in the plan domain.',
    `run_out_period_days` STRING COMMENT 'The run out period days attribute capturing relevant data for the year in the plan domain.',
    `special_enrollment_period_rules` STRING COMMENT 'The special enrollment period rules for this record.',
    `start_date` DATE COMMENT 'The date value representing start date for this year record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the year in the plan domain.',
    `version_number` STRING COMMENT 'The version number attribute capturing relevant data for the year in the plan domain.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    `year_status` STRING COMMENT 'The current status indicator for the year within the workflow.',
    CONSTRAINT pk_year PRIMARY KEY(`year_id`)
) COMMENT 'Plan year configuration';

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
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
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
    `rating_area_code` STRING COMMENT 'A standardized code representing the rating area classification.',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` (
    `plan_service_area_id` BIGINT COMMENT 'Primary key',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `sbc_document_id` BIGINT COMMENT 'FK to SBC document',
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
    `network_type` STRING COMMENT 'The category or classification type of the network.',
    `notes` STRING COMMENT 'The notes for this record.',
    `plan_category` STRING COMMENT 'The plan category attribute capturing relevant data for the plan service area in the plan domain.',
    `plan_year` STRING COMMENT 'The calendar or fiscal year associated with the plan.',
    `regulatory_approval_status` STRING COMMENT 'The current status indicator for the regulatory approval within the workflow.',
    `regulatory_filing_number` STRING COMMENT 'The regulatory filing number attribute capturing relevant data for the plan service area in the plan domain.',
    `service_area_code` STRING COMMENT 'A standardized code representing the service area classification.',
    `service_area_name` STRING COMMENT 'The descriptive name assigned to the service area for identification purposes.',
    `service_area_type` STRING COMMENT 'The category or classification type of the service area.',
    `state` STRING COMMENT 'The state attribute capturing relevant data for the plan service area in the plan domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the plan service area in the plan domain.',
    `version_number` STRING COMMENT 'The version number attribute capturing relevant data for the plan service area in the plan domain.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    `zip_codes_excluded` STRING COMMENT 'Excluded ZIP codes',
    `zip_codes_included` STRING COMMENT 'Included ZIP codes',
    CONSTRAINT pk_plan_service_area PRIMARY KEY(`plan_service_area_id`)
) COMMENT 'Geographic service area for a plan';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`submission` (
    `submission_id` BIGINT COMMENT 'Primary key',
    `ap_invoice_id` BIGINT COMMENT 'FK to AP invoice',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `employee_id` BIGINT COMMENT 'FK to submitter employee',
    `reviewer_employee_id` BIGINT COMMENT 'FK to reviewer employee',
    `approval_date` DATE COMMENT 'The date value representing approval date for this submission record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the submission in the plan domain.',
    `effective_date` DATE COMMENT 'The date value representing effective date for this submission record.',
    `expiration_date` DATE COMMENT 'The date value representing expiration date for this submission record.',
    `fee_currency_code` DECIMAL(18,2) COMMENT 'The fee currency code for this record.',
    `filing_fee_adjustment` DECIMAL(18,2) COMMENT 'The filing fee adjustment attribute capturing relevant data for the submission in the plan domain.',
    `filing_fee_gross` DECIMAL(18,2) COMMENT 'Gross filing fee',
    `filing_fee_net` DECIMAL(18,2) COMMENT 'Net filing fee',
    `filing_reference_number` STRING COMMENT 'The filing reference number attribute capturing relevant data for the submission in the plan domain.',
    `hpms_plan_code` STRING COMMENT 'A standardized code representing the hpms plan classification.',
    `is_annual_filing` BOOLEAN COMMENT 'Annual filing flag',
    `notes` STRING COMMENT 'The notes for this record.',
    `plan_type` STRING COMMENT 'The category or classification type of the plan.',
    `plan_year` STRING COMMENT 'The calendar or fiscal year associated with the plan.',
    `regulatory_body` STRING COMMENT 'The regulatory body attribute capturing relevant data for the submission in the plan domain.',
    `regulatory_submission_deadline` DATE COMMENT 'Regulatory deadline',
    `rejection_date` DATE COMMENT 'The date value representing rejection date for this submission record.',
    `rejection_reason` STRING COMMENT 'The rejection reason attribute capturing relevant data for the submission in the plan domain.',
    `reviewer_comments` STRING COMMENT 'The reviewer comments attribute capturing relevant data for the submission in the plan domain.',
    `submission_date` DATE COMMENT 'The date value representing submission date for this submission record.',
    `submission_number` STRING COMMENT 'The submission number attribute capturing relevant data for the submission in the plan domain.',
    `submission_status` STRING COMMENT 'The current status indicator for the submission within the workflow.',
    `submission_type` STRING COMMENT 'The category or classification type of the submission.',
    `submitter_role` STRING COMMENT 'The submitter role for this record.',
    `updated_by` STRING COMMENT 'The updated by for this record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the submission in the plan domain.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    `withdrawal_date` DATE COMMENT 'The withdrawal date for this record.',
    `withdrawal_reason` STRING COMMENT 'The withdrawal reason for this record.',
    `created_by` STRING COMMENT 'The created by for this record.',
    CONSTRAINT pk_submission PRIMARY KEY(`submission_id`)
) COMMENT 'Regulatory submission for plan approval';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment` (
    `plan_amendment_id` BIGINT COMMENT 'Primary key',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `amendment_id` BIGINT COMMENT 'The contract amendment id for this record.',
    `employee_id` BIGINT COMMENT 'The created by user employee id for this record.',
    `plan_employee_id` BIGINT COMMENT 'FK to employee',
    `plan_ssot_amendment_ref_id` BIGINT COMMENT 'FK to SSOT amendment',
    `plan_updated_by_user_employee_id` BIGINT COMMENT 'The updated by user employee id for this record.',
    `sbc_document_id` BIGINT COMMENT 'FK to SBC document',
    `amendment_type` STRING COMMENT 'The category or classification type of the amendment.',
    `approval_comment` STRING COMMENT 'The approval comment for this record.',
    `change_summary` STRING COMMENT 'The change summary attribute capturing relevant data for the plan amendment in the plan domain.',
    `cms_filing_reference` STRING COMMENT 'The cms filing reference attribute capturing relevant data for the plan amendment in the plan domain.',
    `compliance_flag` BOOLEAN COMMENT 'Boolean indicator for the compliance condition or state.',
    `cost_share_change_details` DECIMAL(18,2) COMMENT 'The cost share change details for this record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the plan amendment in the plan domain.',
    `plan_amendment_description` STRING COMMENT 'Amendment description',
    `doi_filing_reference` STRING COMMENT 'The doi filing reference attribute capturing relevant data for the plan amendment in the plan domain.',
    `effective_date` DATE COMMENT 'The date value representing effective date for this plan amendment record.',
    `effective_end_date` DATE COMMENT 'The date value representing effective end date for this plan amendment record.',
    `effective_year` STRING COMMENT 'The calendar or fiscal year associated with the effective.',
    `formulary_change_details` STRING COMMENT 'The formulary change details attribute capturing relevant data for the plan amendment in the plan domain.',
    `impact_estimated_cost` DECIMAL(18,2) COMMENT 'Estimated cost impact',
    `impact_estimated_member_cost` DECIMAL(18,2) COMMENT 'Estimated member cost impact',
    `impact_estimated_provider_cost` DECIMAL(18,2) COMMENT 'Estimated provider cost impact',
    `impacted_benefit_package_ids` STRING COMMENT 'The impacted benefit package ids attribute capturing relevant data for the plan amendment in the plan domain.',
    `member_notification_date` DATE COMMENT 'The date value representing member notification date for this plan amendment record.',
    `member_notification_required` BOOLEAN COMMENT 'The member notification required attribute capturing relevant data for the plan amendment in the plan domain.',
    `network_change_details` STRING COMMENT 'The network change details attribute capturing relevant data for the plan amendment in the plan domain.',
    `plan_amendment_status` STRING COMMENT 'Amendment status',
    `reason_code` STRING COMMENT 'A standardized code representing the reason classification.',
    `reason_description` STRING COMMENT 'A detailed textual description of the reason.',
    `regulatory_approval_date` DATE COMMENT 'The date value representing regulatory approval date for this plan amendment record.',
    `regulatory_approval_status` STRING COMMENT 'The current status indicator for the regulatory approval within the workflow.',
    `review_deadline` DATE COMMENT 'The review deadline attribute capturing relevant data for the plan amendment in the plan domain.',
    `service_area_change_details` STRING COMMENT 'The service area change details attribute capturing relevant data for the plan amendment in the plan domain.',
    `status_reason` STRING COMMENT 'The status reason for this record.',
    `triggers_sbc_generation` BOOLEAN COMMENT 'The triggers sbc generation attribute capturing relevant data for the plan amendment in the plan domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the plan amendment in the plan domain.',
    `version` STRING COMMENT 'The version attribute capturing relevant data for the plan amendment in the plan domain.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_plan_amendment PRIMARY KEY(`plan_amendment_id`)
) COMMENT 'Amendment to a health plan';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` (
    `hsa_hra_config_id` BIGINT COMMENT 'Primary key',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `account_type` STRING COMMENT 'Account type (HSA/HRA)',
    `catch_up_contribution_amount` DECIMAL(18,2) COMMENT 'Catch-up contribution amount',
    `catch_up_contribution_eligible` BOOLEAN COMMENT 'Catch-up eligible flag',
    `contribution_frequency` STRING COMMENT 'The contribution frequency attribute capturing relevant data for the hsa hra config in the plan domain.',
    `contribution_limit_amount` DECIMAL(18,2) COMMENT 'The numeric contribution limit amount value associated with this hsa hra config record.',
    `contribution_limit_type` STRING COMMENT 'The category or classification type of the contribution limit.',
    `contribution_method` STRING COMMENT 'The contribution method attribute capturing relevant data for the hsa hra config in the plan domain.',
    `contribution_source` STRING COMMENT 'The contribution source attribute capturing relevant data for the hsa hra config in the plan domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the hsa hra config in the plan domain.',
    `hsa_hra_config_description` STRING COMMENT 'Config description',
    `effective_end_date` DATE COMMENT 'The date value representing effective end date for this hsa hra config record.',
    `effective_start_date` DATE COMMENT 'The date value representing effective start date for this hsa hra config record.',
    `eligibility_hdpp` BOOLEAN COMMENT 'HDHP eligibility flag',
    `employee_contribution_limit` DECIMAL(18,2) COMMENT 'The employee contribution limit attribute capturing relevant data for the hsa hra config in the plan domain.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'The numeric employer contribution amount value associated with this hsa hra config record.',
    `grace_period_option` BOOLEAN COMMENT 'The grace period option attribute capturing relevant data for the hsa hra config in the plan domain.',
    `hsa_hra_config_status` STRING COMMENT 'Config status',
    `irs_minimum_deductible` DECIMAL(18,2) COMMENT 'The irs minimum deductible attribute capturing relevant data for the hsa hra config in the plan domain.',
    `irs_out_of_pocket_max` DECIMAL(18,2) COMMENT 'IRS OOP max',
    `plan_year_end_date` DATE COMMENT 'The date value representing plan year end date for this hsa hra config record.',
    `plan_year_start_date` DATE COMMENT 'The date value representing plan year start date for this hsa hra config record.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Boolean indicator for the regulatory compliance condition or state.',
    `rollover_allowed` BOOLEAN COMMENT 'Rollover allowed flag',
    `rollover_limit_amount` DECIMAL(18,2) COMMENT 'The numeric rollover limit amount value associated with this hsa hra config record.',
    `trustee_custodian_name` STRING COMMENT 'Trustee/custodian name',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the hsa hra config in the plan domain.',
    `use_it_or_lose_it_flag` BOOLEAN COMMENT 'Boolean indicator for the use it or lose it condition or state.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_hsa_hra_config PRIMARY KEY(`hsa_hra_config_id`)
) COMMENT 'HSA/HRA account configuration';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` (
    `rx_benefit_config_id` BIGINT COMMENT 'Primary key',
    `formulary_id` BIGINT COMMENT 'FK to formulary',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
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
    `pbm_vendor` STRING COMMENT 'The pbm vendor attribute capturing relevant data for the rx benefit config in the plan domain.',
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
    `provider_network_id` BIGINT COMMENT 'FK to provider network',
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
    `network_geography_region` STRING COMMENT 'Geographic region',
    `network_provider_count` STRING COMMENT 'Provider count',
    `network_state` STRING COMMENT 'The network state attribute capturing relevant data for the network config in the plan domain.',
    `network_tier` STRING COMMENT 'The network tier attribute capturing relevant data for the network config in the plan domain.',
    `network_zip_code` STRING COMMENT 'A standardized code representing the network zip classification.',
    `out_of_network_benefit_type` STRING COMMENT 'OON benefit type',
    `out_of_network_coinsurance_pct` DECIMAL(18,2) COMMENT 'OON coinsurance percentage',
    `out_of_network_copay_amount` DECIMAL(18,2) COMMENT 'OON copay amount',
    `out_of_network_coverage_flag` BOOLEAN COMMENT 'OON coverage flag',
    `tier_priority` STRING COMMENT 'The tier priority attribute capturing relevant data for the network config in the plan domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the network config in the plan domain.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_network_config PRIMARY KEY(`network_config_id`)
) COMMENT 'Network configuration for a plan';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` (
    `crosswalk_id` BIGINT COMMENT 'Primary key',
    `health_plan_id` BIGINT COMMENT 'FK to source health plan',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the crosswalk in the plan domain.',
    `crosswalk_status` STRING COMMENT 'The current status indicator for the crosswalk within the workflow.',
    `crosswalk_type` STRING COMMENT 'The category or classification type of the crosswalk.',
    `effective_end_date` DATE COMMENT 'The date value representing effective end date for this crosswalk record.',
    `effective_start_date` DATE COMMENT 'The date value representing effective start date for this crosswalk record.',
    `is_mandatory` BOOLEAN COMMENT 'Mandatory flag',
    `member_notification_required` BOOLEAN COMMENT 'The member notification required attribute capturing relevant data for the crosswalk in the plan domain.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the crosswalk in the plan domain.',
    `notification_method` STRING COMMENT 'The notification method attribute capturing relevant data for the crosswalk in the plan domain.',
    `notification_sent_date` DATE COMMENT 'The date value representing notification sent date for this crosswalk record.',
    `plan_year` STRING COMMENT 'The calendar or fiscal year associated with the plan.',
    `reason` STRING COMMENT 'Crosswalk reason',
    `region` STRING COMMENT 'The region attribute capturing relevant data for the crosswalk in the plan domain.',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Boolean indicator for the regulatory submission condition or state.',
    `sequence` STRING COMMENT 'The sequence attribute capturing relevant data for the crosswalk in the plan domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the crosswalk in the plan domain.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    CONSTRAINT pk_crosswalk PRIMARY KEY(`crosswalk_id`)
) COMMENT 'Plan crosswalk mapping between plan years';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`status_history` (
    `status_history_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `audit_created_by` STRING COMMENT 'The audit created by attribute capturing relevant data for the status history in the plan domain.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'The audit created timestamp attribute capturing relevant data for the status history in the plan domain.',
    `audit_source_system` STRING COMMENT 'The audit source system attribute capturing relevant data for the status history in the plan domain.',
    `comments` STRING COMMENT 'The comments attribute capturing relevant data for the status history in the plan domain.',
    `compliance_flag` BOOLEAN COMMENT 'Boolean indicator for the compliance condition or state.',
    `is_legacy` BOOLEAN COMMENT 'Legacy flag',
    `market_segment` STRING COMMENT 'The market segment attribute capturing relevant data for the status history in the plan domain.',
    `new_status` STRING COMMENT 'The current status indicator for the new within the workflow.',
    `plan_type` STRING COMMENT 'The category or classification type of the plan.',
    `plan_year` STRING COMMENT 'The calendar or fiscal year associated with the plan.',
    `prior_status` STRING COMMENT 'The current status indicator for the prior within the workflow.',
    `reason_code` STRING COMMENT 'A standardized code representing the reason classification.',
    `reason_description` STRING COMMENT 'A detailed textual description of the reason.',
    `region` STRING COMMENT 'The region attribute capturing relevant data for the status history in the plan domain.',
    `regulatory_action_reference` STRING COMMENT 'The regulatory action reference attribute capturing relevant data for the status history in the plan domain.',
    `state_code` STRING COMMENT 'A standardized code representing the state classification.',
    `transition_effective_date` DATE COMMENT 'The date value representing transition effective date for this status history record.',
    `transition_timestamp` TIMESTAMP COMMENT 'The transition timestamp attribute capturing relevant data for the status history in the plan domain.',
    `triggered_by` STRING COMMENT 'The triggered by attribute capturing relevant data for the status history in the plan domain.',
    `triggered_by_system_name` STRING COMMENT 'Triggered by system',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_status_history PRIMARY KEY(`status_history_id`)
) COMMENT 'Plan status change history';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`offering` (
    `offering_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to employer group',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` (
    `program_coverage_id` BIGINT COMMENT 'Primary key for program coverage',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `program_id` BIGINT COMMENT 'FK to care program',
    `coinsurance_rate` DECIMAL(18,2) COMMENT 'Coinsurance rate percentage',
    `copay_amount` DECIMAL(18,2) COMMENT 'Copay amount for service',
    `coverage_category` STRING COMMENT 'Category of coverage',
    `coverage_description` STRING COMMENT 'Description of coverage',
    `coverage_level` STRING COMMENT 'Level of coverage',
    `coverage_limit_amount` DECIMAL(18,2) COMMENT 'Maximum coverage limit',
    `coverage_scope` STRING COMMENT 'Scope of coverage',
    `coverage_status` STRING COMMENT 'Current status of coverage',
    `coverage_type` STRING COMMENT 'Type of coverage',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_date` DATE COMMENT 'Effective date of coverage',
    `effective_end_date` DATE COMMENT 'Coverage effective end date',
    `effective_start_date` DATE COMMENT 'Coverage effective start date',
    `is_covered` BOOLEAN COMMENT 'Whether service is covered',
    `prior_auth_required` BOOLEAN COMMENT 'Whether prior authorization is required',
    `termination_date` DATE COMMENT 'Termination date of coverage',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_program_coverage PRIMARY KEY(`program_coverage_id`)
) COMMENT 'Coverage of care programs by health plans';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`plan_regulatory_obligation` (
    `plan_regulatory_obligation_id` BIGINT COMMENT 'Primary key',
    `obligation_id` BIGINT COMMENT 'FK to regulatory obligation',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `compliance_status` STRING COMMENT 'Current compliance status',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `due_date` DATE COMMENT 'Obligation due date',
    `filing_reference` STRING COMMENT 'Filing reference number',
    `is_compliant` BOOLEAN COMMENT 'Whether plan is compliant',
    `last_assessment_date` DATE COMMENT 'The date value representing last assessment date for this plan regulatory obligation record.',
    `next_due_date` DATE COMMENT 'The date value representing next due date for this plan regulatory obligation record.',
    `obligation_description` STRING COMMENT 'Description of obligation',
    `obligation_summary` STRING COMMENT 'Summary of obligation',
    `obligation_type` STRING COMMENT 'Type of regulatory obligation',
    `regulatory_body` STRING COMMENT 'Regulatory body name',
    `responsible_party` STRING COMMENT 'Party responsible for compliance',
    `satisfied_date` DATE COMMENT 'Date obligation was satisfied',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_plan_regulatory_obligation PRIMARY KEY(`plan_regulatory_obligation_id`)
) COMMENT 'Regulatory obligations for health plans';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`plan`.`plan_provider_contract` (
    `plan_provider_contract_id` BIGINT COMMENT 'Primary key',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `provider_network_participation_id` BIGINT COMMENT 'FK to provider network participation',
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
    CONSTRAINT pk_plan_provider_contract PRIMARY KEY(`plan_provider_contract_id`)
) COMMENT 'Provider contract linkage to health plans';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ADD CONSTRAINT `fk_plan_benefit_package_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ADD CONSTRAINT `fk_plan_benefit_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ADD CONSTRAINT `fk_plan_cost_share_rule_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ADD CONSTRAINT `fk_plan_cost_share_rule_benefit_package_id` FOREIGN KEY (`benefit_package_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`benefit_package`(`benefit_package_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ADD CONSTRAINT `fk_plan_cost_share_rule_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ADD CONSTRAINT `fk_plan_year_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ADD CONSTRAINT `fk_plan_sbc_document_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ADD CONSTRAINT `fk_plan_rate_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ADD CONSTRAINT `fk_plan_plan_service_area_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ADD CONSTRAINT `fk_plan_plan_service_area_sbc_document_id` FOREIGN KEY (`sbc_document_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`sbc_document`(`sbc_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ADD CONSTRAINT `fk_plan_submission_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment` ADD CONSTRAINT `fk_plan_plan_amendment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment` ADD CONSTRAINT `fk_plan_plan_amendment_sbc_document_id` FOREIGN KEY (`sbc_document_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`sbc_document`(`sbc_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ADD CONSTRAINT `fk_plan_hsa_hra_config_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ADD CONSTRAINT `fk_plan_rx_benefit_config_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ADD CONSTRAINT `fk_plan_network_config_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ADD CONSTRAINT `fk_plan_crosswalk_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ADD CONSTRAINT `fk_plan_status_history_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ADD CONSTRAINT `fk_plan_offering_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` ADD CONSTRAINT `fk_plan_program_coverage_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_regulatory_obligation` ADD CONSTRAINT `fk_plan_plan_regulatory_obligation_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_provider_contract` ADD CONSTRAINT `fk_plan_plan_provider_contract_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_health_insurance_v1`.`plan`.`health_plan`(`health_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`plan` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_health_insurance_v1`.`plan` SET TAGS ('dbx_domain' = 'plan');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` SET TAGS ('dbx_fhir_resource' = 'InsurancePlan');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`health_plan` ALTER COLUMN `plan_state` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit_package` ALTER COLUMN `package_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`benefit` ALTER COLUMN `benefit_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`cost_share_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_sensitivity' = 'special_category');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`year` ALTER COLUMN `plan_year_state` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`sbc_document` ALTER COLUMN `author` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` SET TAGS ('dbx_subdomain' = 'pricing_configuration');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `age_rated_premium` SET TAGS ('dbx_pii_type' = 'demographic');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `max_age` SET TAGS ('dbx_pii_type' = 'demographic');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `min_age` SET TAGS ('dbx_pii_type' = 'demographic');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `rate_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `rate_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `rating_area_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rate` ALTER COLUMN `underwriting_class_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` SET TAGS ('dbx_subdomain' = 'pricing_configuration');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `is_state_funded` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `service_area_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `state` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `zip_codes_excluded` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_service_area` ALTER COLUMN `zip_codes_included` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`submission` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment` ALTER COLUMN `plan_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment` ALTER COLUMN `plan_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment` ALTER COLUMN `plan_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_amendment` ALTER COLUMN `plan_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `grace_period_option` SET TAGS ('dbx_sensitivity' = 'special_category');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `trustee_custodian_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`hsa_hra_config` ALTER COLUMN `trustee_custodian_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `coverage_limit_per_prescription` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`rx_benefit_config` ALTER COLUMN `coverage_limit_per_prescription` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_state` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`network_config` ALTER COLUMN `network_zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` SET TAGS ('dbx_subdomain' = 'pricing_configuration');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`crosswalk` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` SET TAGS ('dbx_subdomain' = 'pricing_configuration');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`status_history` ALTER COLUMN `triggered_by_system_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`offering` ALTER COLUMN `offering_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`program_coverage` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_regulatory_obligation` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_regulatory_obligation` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_regulatory_obligation` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_regulatory_obligation` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_regulatory_obligation` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_regulatory_obligation` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_provider_contract` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_provider_contract` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_provider_contract` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_provider_contract` SET TAGS ('dbx_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_provider_contract` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`plan`.`plan_provider_contract` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
