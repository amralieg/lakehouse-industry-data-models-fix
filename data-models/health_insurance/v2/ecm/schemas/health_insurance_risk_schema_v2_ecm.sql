-- Schema for Domain: risk | Business:  | Version: v2_ecm
-- Generated on: 2026-06-22 23:51:46

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`risk` COMMENT 'Manages actuarial risk assessment, underwriting, and risk adjustment programs — RAF scoring, HCC mapping, RAPS/EDPS submissions to CMS, RBC calculations, IBNR reserve estimation, and rate-setting inputs. Owns risk scores at the member level, underwriting decisions for group and individual markets, reinsurance/stop-loss arrangements, and premium rate development. Source system: Milliman MG-ALFA and actuarial models.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` (
    `member_risk_score_id` BIGINT COMMENT 'Primary key for member risk score record.',
    `identity_id` BIGINT COMMENT 'FK to member identity.',
    `pool_id` BIGINT COMMENT 'FK to risk pool.',
    `audit_user` STRING COMMENT 'User who last audited the score.',
    `cms_published_score` DECIMAL(18,2) COMMENT 'CMS-published risk adjustment score.',
    `cms_submission_status` STRING COMMENT 'Status of CMS submission for this score.',
    `corrective_action` STRING COMMENT 'Corrective action taken if score variance detected.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `demographic_factor_score` DECIMAL(18,2) COMMENT 'Demographic component of risk score.',
    `diagnosis_count` STRING COMMENT 'Number of diagnoses contributing to score.',
    `effective_timestamp` TIMESTAMP COMMENT 'When the score became effective.',
    `expiration_date` DATE COMMENT 'Date the score expires.',
    `hcc_codes` STRING COMMENT 'Comma-separated HCC codes contributing to score.',
    `is_manual_override` BOOLEAN COMMENT 'Whether score was manually overridden.',
    `manual_override_reason` STRING COMMENT 'Reason for manual override.',
    `model_name` STRING COMMENT 'Name of the risk model used.',
    `model_version` STRING COMMENT 'Version of the risk model.',
    `payment_year` DECIMAL(18,2) COMMENT 'CMS payment year for risk adjustment.',
    `plan_calculated_score` DECIMAL(18,2) COMMENT 'Plan-calculated risk score before CMS reconciliation.',
    `record_status` STRING COMMENT 'Status of the risk score record.',
    `resubmission_reference` STRING COMMENT 'Reference ID for resubmitted scores.',
    `risk_adjustment_factor_category` DOUBLE COMMENT 'Category of risk adjustment factor.',
    `risk_score_code` DOUBLE COMMENT 'Coded risk score value.',
    `risk_score_confidence_score` DECIMAL(18,2) COMMENT 'Confidence level of the risk score.',
    `risk_score_label` DOUBLE COMMENT 'Label for the risk score tier.',
    `risk_score_notes` DOUBLE COMMENT 'Notes associated with risk score.',
    `risk_score_source` DOUBLE COMMENT 'Source system of the risk score.',
    `risk_score_status` DOUBLE COMMENT 'Current status of the risk score.',
    `risk_score_type` DOUBLE COMMENT 'Type classification of risk score.',
    `risk_score_value` DECIMAL(18,2) COMMENT 'Numeric risk score value.',
    `score_components` DOUBLE COMMENT 'Breakdown of score components.',
    `score_effective_date` DATE COMMENT 'Date the score becomes effective.',
    `score_variance` DECIMAL(18,2) COMMENT 'Variance between plan and CMS scores.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `variance_category` STRING COMMENT 'Category of score variance.',
    CONSTRAINT pk_member_risk_score PRIMARY KEY(`member_risk_score_id`)
) COMMENT 'Stores individual member risk scores calculated via CMS-HCC or prospective models for risk adjustment and payment reconciliation.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` (
    `hcc_mapping_id` BIGINT COMMENT 'Primary key.',
    `pool_id` BIGINT COMMENT 'FK to risk pool.',
    `age_adjustment_factor` DECIMAL(18,2) COMMENT 'Age-based adjustment factor.',
    `coefficient` DECIMAL(18,2) COMMENT 'HCC coefficient for risk score calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `demographic_adjustment_factor` DECIMAL(18,2) COMMENT 'Demographic-based adjustment.',
    `disease_interaction_group` STRING COMMENT 'Disease interaction group code.',
    `effective_date` DATE COMMENT 'Mapping effective date.',
    `expiration_date` DATE COMMENT 'Mapping expiration date.',
    `gender_adjustment_factor` DECIMAL(18,2) COMMENT 'Gender-based adjustment factor.',
    `hcc_code` STRING COMMENT 'Hierarchical Condition Category code.',
    `hcc_description` STRING COMMENT 'Description of the HCC.',
    `hcc_mapping_status` STRING COMMENT 'Status of the mapping record.',
    `hierarchy_level` STRING COMMENT 'Level in the HCC hierarchy.',
    `icd10_code` STRING COMMENT 'ICD-10 diagnosis code.',
    `icd10_description` STRING COMMENT 'Description of the ICD-10 code.',
    `interaction_flag` BOOLEAN COMMENT 'Whether this HCC participates in disease interactions.',
    `is_excluded` BOOLEAN COMMENT 'Whether this mapping is excluded from scoring.',
    `is_mapped` BOOLEAN COMMENT 'Whether the ICD-10 code is mapped to an HCC.',
    `last_review_date` DATE COMMENT 'Date of last clinical review.',
    `last_updated_by` STRING COMMENT 'User who last updated the mapping.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `mapping_source` STRING COMMENT 'Source of the mapping (CMS, internal).',
    `model_year` STRING COMMENT 'CMS model year for the mapping.',
    `notes` STRING COMMENT 'Additional notes.',
    `parent_hcc_code` STRING COMMENT 'Parent HCC in the hierarchy.',
    `plan_type_adjustment_factor` DECIMAL(18,2) COMMENT 'Plan type adjustment factor.',
    `region_adjustment_factor` DECIMAL(18,2) COMMENT 'Regional adjustment factor.',
    `review_status` STRING COMMENT 'Clinical review status.',
    `risk_score_weight` DECIMAL(18,2) COMMENT 'Weight contribution to risk score.',
    `source_version` STRING COMMENT 'Version of the source mapping file.',
    CONSTRAINT pk_hcc_mapping PRIMARY KEY(`hcc_mapping_id`)
) COMMENT 'Maps ICD-10 diagnosis codes to CMS Hierarchical Condition Categories (HCCs) for risk adjustment scoring.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` (
    `raps_submission_id` BIGINT COMMENT 'Primary key.',
    `employee_id` BIGINT COMMENT 'FK to submitting employee.',
    `health_plan_id` BIGINT COMMENT 'FK to health plan.',
    `pool_id` BIGINT COMMENT 'FK to risk pool.',
    `accepted_record_count` STRING COMMENT 'Number of records accepted by CMS.',
    `batch_number` STRING COMMENT 'Submission batch identifier.',
    `cms_acknowledgment_status` STRING COMMENT 'CMS acknowledgment status.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `error_disposition` STRING COMMENT 'Disposition of submission errors.',
    `payment_year` DECIMAL(18,2) COMMENT 'CMS payment year.',
    `plan_contract_number` STRING COMMENT 'CMS contract number.',
    `plan_type` STRING COMMENT 'Type of plan submitted.',
    `raps_submission_status` STRING COMMENT 'Overall submission status.',
    `rejected_record_count` STRING COMMENT 'Number of records rejected.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Calculated risk adjustment factor.',
    `risk_adjustment_year` STRING COMMENT 'Year of risk adjustment.',
    `risk_score` DECIMAL(18,2) COMMENT 'Aggregate risk score for submission.',
    `submission_file_checksum` STRING COMMENT 'File integrity checksum.',
    `submission_file_name` STRING COMMENT 'Name of submitted file.',
    `submission_timestamp` TIMESTAMP COMMENT 'When submission was sent.',
    `submission_user_name` STRING COMMENT 'User who submitted.',
    `total_record_count` DECIMAL(18,2) COMMENT 'Total records in submission.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    CONSTRAINT pk_raps_submission PRIMARY KEY(`raps_submission_id`)
) COMMENT 'Tracks Risk Adjustment Processing System (RAPS) submissions to CMS for Medicare Advantage risk adjustment.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` (
    `risk_cms_submission_id` BIGINT COMMENT 'Primary key.',
    `employee_id` BIGINT COMMENT 'FK to submitting employee.',
    `health_plan_id` BIGINT COMMENT 'FK to health plan.',
    `pool_id` BIGINT COMMENT 'FK to risk pool.',
    `accepted_record_count` BIGINT COMMENT 'Records accepted by CMS.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Risk adjustment payment amount.',
    `cms_acknowledgment_status` STRING COMMENT 'CMS acknowledgment status.',
    `contract_number` STRING COMMENT 'CMS contract number.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency of monetary amounts.',
    `encounter_type` STRING COMMENT 'Type of encounter submitted.',
    `error_disposition` STRING COMMENT 'Disposition of errors.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net payment amount.',
    `payment_year` DECIMAL(18,2) COMMENT 'CMS payment year.',
    `record_count` BIGINT COMMENT 'Total record count.',
    `rejected_record_count` BIGINT COMMENT 'Records rejected by CMS.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Calculated RAF.',
    `risk_adjustment_score` DECIMAL(18,2) COMMENT 'Aggregate risk adjustment score.',
    `service_year` STRING COMMENT 'Year of service.',
    `submission_batch_number` STRING COMMENT 'Batch number.',
    `submission_checksum` STRING COMMENT 'File checksum.',
    `submission_comment` STRING COMMENT 'Comments on submission.',
    `submission_file_name` STRING COMMENT 'File name.',
    `submission_file_size` BIGINT COMMENT 'File size in bytes.',
    `submission_source_system` STRING COMMENT 'Source system.',
    `submission_status` STRING COMMENT 'Overall status.',
    `submission_timestamp` TIMESTAMP COMMENT 'When submitted.',
    `submission_type` STRING COMMENT 'Type of submission (RAPS, EDS).',
    `submission_user_role` STRING COMMENT 'Role of submitting user.',
    `total_claim_amount` DECIMAL(18,2) COMMENT 'Total claim amount in submission.',
    `transition_flag` BOOLEAN COMMENT 'Whether this is a transition year submission.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    CONSTRAINT pk_risk_cms_submission PRIMARY KEY(`risk_cms_submission_id`)
) COMMENT 'Tracks CMS encounter and risk adjustment data submissions including EDS and RAPS for payment reconciliation.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` (
    `risk_underwriting_case_id` BIGINT COMMENT 'Primary key.',
    `employee_id` BIGINT COMMENT 'FK to underwriting employee.',
    `group_id` BIGINT COMMENT 'FK to employer group.',
    `subscriber_id` BIGINT COMMENT 'FK to subscriber.',
    `record_id` BIGINT COMMENT 'FK to credential record.',
    `pool_id` BIGINT COMMENT 'FK to risk pool.',
    `vendor_id` BIGINT COMMENT 'FK to vendor.',
    `age_gender_distribution_index` DECIMAL(18,2) COMMENT 'Index of age/gender distribution.',
    `applicant_type` STRING COMMENT 'Type of applicant (group, individual).',
    `chronic_condition_prevalence_rate` DECIMAL(18,2) COMMENT 'Prevalence rate of chronic conditions.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `decision_rationale` DECIMAL(18,2) COMMENT 'Rationale score for underwriting decision.',
    `decision_timestamp` TIMESTAMP COMMENT 'When decision was made.',
    `effective_date` DATE COMMENT 'Coverage effective date.',
    `expected_claims_pmpm` DECIMAL(18,2) COMMENT 'Expected claims per member per month.',
    `gross_premium_amount` DECIMAL(18,2) COMMENT 'Gross premium amount.',
    `industry_risk_factor` DECIMAL(18,2) COMMENT 'Industry-based risk factor.',
    `is_self_insured` BOOLEAN COMMENT 'Whether the group is self-insured.',
    `large_claimant_count` STRING COMMENT 'Number of large claimants.',
    `lob` STRING COMMENT 'Line of business.',
    `medical_underwriting_status` STRING COMMENT 'Status of medical underwriting.',
    `morbidity_factor` DECIMAL(18,2) COMMENT 'Morbidity adjustment factor.',
    `net_premium_amount` DECIMAL(18,2) COMMENT 'Net premium after adjustments.',
    `overall_group_risk_score` DECIMAL(18,2) COMMENT 'Composite group risk score.',
    `premium_adjustment_amount` DECIMAL(18,2) COMMENT 'Premium adjustment amount.',
    `premium_rate` DECIMAL(18,2) COMMENT 'Calculated premium rate.',
    `premium_rate_type` DECIMAL(18,2) COMMENT 'Type of premium rate.',
    `prior_year_claims_pmpm` DECIMAL(18,2) COMMENT 'Prior year claims PMPM.',
    `rate_effective_date` DATE COMMENT 'Rate effective date.',
    `rate_expiration_date` DATE COMMENT 'Rate expiration date.',
    `rating_period` STRING COMMENT 'Rating period.',
    `regulatory_submission_status` STRING COMMENT 'Regulatory filing status.',
    `reinsurance_flag` BOOLEAN COMMENT 'Whether reinsurance applies.',
    `review_deadline` DATE COMMENT 'Deadline for underwriting review.',
    `risk_classification` STRING COMMENT 'Risk classification tier.',
    `risk_underwriting_case_status` STRING COMMENT 'Case status.',
    `stop_loss_arrangement` STRING COMMENT 'Stop loss arrangement details.',
    `submission_date` DATE COMMENT 'Date case was submitted.',
    `total_member_months` DECIMAL(18,2) COMMENT 'Total member months.',
    `underwriting_case_number` STRING COMMENT 'Case number.',
    `underwriting_rule_set` STRING COMMENT 'Rule set applied.',
    `underwriting_tier` STRING COMMENT 'Underwriting tier.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    CONSTRAINT pk_risk_underwriting_case PRIMARY KEY(`risk_underwriting_case_id`)
) COMMENT 'Captures underwriting case details for group and individual risk assessment including medical underwriting factors and premium rate development.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` (
    `rate_development_id` BIGINT COMMENT 'Primary key.',
    `pool_id` BIGINT COMMENT 'FK to risk pool.',
    `administrative_loading` DECIMAL(18,2) COMMENT 'Administrative expense loading factor.',
    `age_factor` DECIMAL(18,2) COMMENT 'Age-based rating factor.',
    `approved_timestamp` TIMESTAMP COMMENT 'When rate was approved.',
    `base_rate` DECIMAL(18,2) COMMENT 'Base premium rate.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `credibility_factor` DECIMAL(18,2) COMMENT 'Statistical credibility factor.',
    `development_number` STRING COMMENT 'Rate development identifier.',
    `effective_date` DATE COMMENT 'Rate effective date.',
    `expiration_date` DATE COMMENT 'Rate expiration date.',
    `final_approved_rate` DECIMAL(18,2) COMMENT 'Final approved premium rate.',
    `gender_factor` DECIMAL(18,2) COMMENT 'Gender-based rating factor.',
    `geographic_factor` DECIMAL(18,2) COMMENT 'Geographic area rating factor.',
    `group_size_factor` DECIMAL(18,2) COMMENT 'Group size rating factor.',
    `industry_factor` DECIMAL(18,2) COMMENT 'Industry-based rating factor.',
    `line_of_business` STRING COMMENT 'Line of business.',
    `mlr_target` DECIMAL(18,2) COMMENT 'Medical loss ratio target.',
    `notes` STRING COMMENT 'Additional notes.',
    `plan_type` STRING COMMENT 'Plan type.',
    `plan_type_loading` DECIMAL(18,2) COMMENT 'Plan type loading factor.',
    `profit_margin` DECIMAL(18,2) COMMENT 'Target profit margin.',
    `rate_development_status` DOUBLE COMMENT 'Status of rate development.',
    `rate_methodology` DOUBLE COMMENT 'Methodology used for rate development.',
    `rating_area` STRING COMMENT 'Geographic rating area.',
    `rating_period_end` DATE COMMENT 'End of rating period.',
    `rating_period_start` DATE COMMENT 'Start of rating period.',
    `regulatory_filing_reference` STRING COMMENT 'Reference to regulatory filing.',
    `tobacco_factor` DECIMAL(18,2) COMMENT 'Tobacco use rating factor.',
    `trend_factor` DECIMAL(18,2) COMMENT 'Medical cost trend factor.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `version_number` STRING COMMENT 'Version of rate development.',
    CONSTRAINT pk_rate_development PRIMARY KEY(`rate_development_id`)
) COMMENT 'Captures actuarial rate development calculations including base rates, trend factors, and loading factors for premium rate setting.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` (
    `ibnr_reserve_id` DECIMAL(18,2) COMMENT 'Primary key.',
    `pool_id` BIGINT COMMENT 'FK to risk pool.',
    `actuarial_confidence_level` DECIMAL(18,2) COMMENT 'Confidence level of the estimate.',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'Lower bound of confidence interval.',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'Upper bound of confidence interval.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Quality score of input data.',
    `development_factor` DECIMAL(18,2) COMMENT 'Loss development factor.',
    `expected_loss_ratio` DECIMAL(18,2) COMMENT 'Expected loss ratio.',
    `external_reserve_code` DECIMAL(18,2) COMMENT 'External reserve code.',
    `forecast_horizon_months` STRING COMMENT 'Forecast horizon in months.',
    `hcc_weighted_amount` DECIMAL(18,2) COMMENT 'HCC-weighted reserve amount.',
    `ibnr_amount` DECIMAL(18,2) COMMENT 'Estimated IBNR amount.',
    `ibnr_pmpm` DECIMAL(18,2) COMMENT 'IBNR per member per month.',
    `ibnr_reserve_status` DECIMAL(18,2) COMMENT 'Status of the reserve.',
    `lob_code` STRING COMMENT 'Line of business code.',
    `notes` STRING COMMENT 'Additional notes.',
    `plan_type` STRING COMMENT 'Plan type.',
    `raps_submission_flag` BOOLEAN COMMENT 'Whether linked to RAPS submission.',
    `rbc_impact_amount` DECIMAL(18,2) COMMENT 'Impact on risk-based capital.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Whether required for regulatory reporting.',
    `reserve_adequacy_flag` BOOLEAN COMMENT 'Whether reserve is adequate.',
    `reserve_methodology` DECIMAL(18,2) COMMENT 'Methodology used.',
    `reserve_name` DECIMAL(18,2) COMMENT 'Name of the reserve.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Risk adjustment factor applied.',
    `service_month` DATE COMMENT 'Service month for the reserve.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `valuation_date` DATE COMMENT 'Date of valuation.',
    `version_number` STRING COMMENT 'Version number.',
    CONSTRAINT pk_ibnr_reserve PRIMARY KEY(`ibnr_reserve_id`)
) COMMENT 'Tracks Incurred But Not Reported (IBNR) reserve estimates for actuarial liability management and financial reporting.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` (
    `reinsurance_arrangement_id` BIGINT COMMENT 'Primary key.',
    `vendor_id` BIGINT COMMENT 'FK to reinsurer vendor.',
    `aggregate_attachment_amount` DECIMAL(18,2) COMMENT 'Aggregate attachment point amount.',
    `aggregate_attachment_factor` DECIMAL(18,2) COMMENT 'Aggregate attachment factor.',
    `arrangement_number` STRING COMMENT 'Arrangement identifier.',
    `attachment_point` DECIMAL(18,2) COMMENT 'Specific attachment point.',
    `attachment_point_currency` STRING COMMENT 'Currency of attachment point.',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Coinsurance percentage.',
    `corridor_percentage` DECIMAL(18,2) COMMENT 'Risk corridor percentage.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `effective_from` DATE COMMENT 'Arrangement start date.',
    `effective_until` DATE COMMENT 'Arrangement end date.',
    `lob_coverage` STRING COMMENT 'Lines of business covered.',
    `maximum_liability` DECIMAL(18,2) COMMENT 'Maximum liability amount.',
    `maximum_recovery_limit` DECIMAL(18,2) COMMENT 'Maximum recovery limit.',
    `premium_ceded` DECIMAL(18,2) COMMENT 'Premium ceded to reinsurer.',
    `reinsurance_arrangement_status` STRING COMMENT 'Status of arrangement.',
    `reinsurer_name` STRING COMMENT 'Name of reinsurer.',
    `specific_deductible` DECIMAL(18,2) COMMENT 'Specific deductible amount.',
    `stop_loss_deductible` DECIMAL(18,2) COMMENT 'Stop loss deductible.',
    `stop_loss_limit` DECIMAL(18,2) COMMENT 'Stop loss limit.',
    `stop_loss_threshold` DECIMAL(18,2) COMMENT 'Stop loss threshold.',
    `stop_loss_type` STRING COMMENT 'Type of stop loss.',
    `treaty_terms` STRING COMMENT 'Treaty terms description.',
    `treaty_type` STRING COMMENT 'Type of treaty (quota share, excess of loss).',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    CONSTRAINT pk_reinsurance_arrangement PRIMARY KEY(`reinsurance_arrangement_id`)
) COMMENT 'Defines reinsurance treaty and arrangement details including attachment points, limits, and ceded premiums for risk transfer.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` (
    `reinsurance_claim_id` BIGINT COMMENT 'Primary key.',
    `subscriber_id` BIGINT COMMENT 'FK to subscriber.',
    `reinsurance_arrangement_id` BIGINT COMMENT 'FK to reinsurance arrangement.',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'When reinsurer acknowledged claim.',
    `attachment_point_amount` DECIMAL(18,2) COMMENT 'Attachment point for this claim.',
    `claim_number` STRING COMMENT 'Reinsurance claim number.',
    `claim_status` STRING COMMENT 'Status of the claim.',
    `claim_type` STRING COMMENT 'Type of reinsurance claim.',
    `claimant_type` STRING COMMENT 'Type of claimant.',
    `covered_end_date` DATE COMMENT 'End of covered period.',
    `covered_start_date` DATE COMMENT 'Start of covered period.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `is_aggregated` BOOLEAN COMMENT 'Whether claim is aggregated.',
    `loss_category` STRING COMMENT 'Category of loss.',
    `loss_description` STRING COMMENT 'Description of loss.',
    `notes` STRING COMMENT 'Additional notes.',
    `payment_received_timestamp` TIMESTAMP COMMENT 'When payment was received.',
    `recoverable_amount` DECIMAL(18,2) COMMENT 'Amount recoverable from reinsurer.',
    `recovery_status` STRING COMMENT 'Status of recovery.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Whether required for regulatory reporting.',
    `reporting_period` STRING COMMENT 'Reporting period.',
    `submission_timestamp` TIMESTAMP COMMENT 'When claim was submitted.',
    `total_incurred_amount` DECIMAL(18,2) COMMENT 'Total incurred amount.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    CONSTRAINT pk_reinsurance_claim PRIMARY KEY(`reinsurance_claim_id`)
) COMMENT 'Tracks individual reinsurance claims and recoveries against reinsurance arrangements for large loss events.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` (
    `rbc_calculation_id` BIGINT COMMENT 'Primary key.',
    `pool_id` BIGINT COMMENT 'FK to risk pool.',
    `action_threshold_status` STRING COMMENT 'Regulatory action threshold status.',
    `authorized_control_level_rbc` DECIMAL(18,2) COMMENT 'Authorized control level RBC.',
    `calculation_method` STRING COMMENT 'Method used for calculation.',
    `calculation_number` STRING COMMENT 'Calculation identifier.',
    `calculation_period_end_date` DATE COMMENT 'End of calculation period.',
    `calculation_period_start_date` DATE COMMENT 'Start of calculation period.',
    `calculation_timestamp` TIMESTAMP COMMENT 'When calculation was performed.',
    `company_action_level_rbc` DECIMAL(18,2) COMMENT 'Company action level RBC.',
    `company_code` BIGINT COMMENT 'NAIC company code.',
    `covariance_adjustment` DECIMAL(18,2) COMMENT 'Covariance adjustment amount.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `h0_asset_risk` DECIMAL(18,2) COMMENT 'H0 asset risk component.',
    `h1_underwriting_risk` DECIMAL(18,2) COMMENT 'H1 underwriting risk component.',
    `h2_credit_risk` DECIMAL(18,2) COMMENT 'H2 credit risk component.',
    `h3_business_risk` DECIMAL(18,2) COMMENT 'H3 business risk component.',
    `h4_admin_expense_risk` DECIMAL(18,2) COMMENT 'H4 administrative expense risk.',
    `notes` STRING COMMENT 'Additional notes.',
    `rbc_ratio` DECIMAL(18,2) COMMENT 'Risk-based capital ratio.',
    `rbc_status` STRING COMMENT 'RBC status.',
    `total_adjusted_capital` DECIMAL(18,2) COMMENT 'Total adjusted capital.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    CONSTRAINT pk_rbc_calculation PRIMARY KEY(`rbc_calculation_id`)
) COMMENT 'Stores Risk-Based Capital (RBC) calculations per NAIC requirements including component risks and capital adequacy ratios.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` (
    `adjustment_payment_id` DECIMAL(18,2) COMMENT 'Primary key.',
    `employee_id` BIGINT COMMENT 'FK to approving employee.',
    `health_plan_id` BIGINT COMMENT 'FK to health plan.',
    `subscriber_id` BIGINT COMMENT 'FK to subscriber.',
    `pool_id` BIGINT COMMENT 'FK to risk pool.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Risk adjustment payment amount.',
    `adjustment_reason_code` STRING COMMENT 'Reason code for adjustment.',
    `adjustment_reason_description` STRING COMMENT 'Description of adjustment reason.',
    `business_event_timestamp` TIMESTAMP COMMENT 'Timestamp of business event.',
    `cms_notification_date` DATE COMMENT 'Date CMS notified of adjustment.',
    `currency_code` STRING COMMENT 'Currency code.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Gross payment amount.',
    `lifecycle_status` STRING COMMENT 'Payment lifecycle status.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net payment amount.',
    `payment_effective_date` DATE COMMENT 'Effective date of payment.',
    `payment_method` DECIMAL(18,2) COMMENT 'Method of payment.',
    `payment_source` DECIMAL(18,2) COMMENT 'Source of payment.',
    `payment_status` DECIMAL(18,2) COMMENT 'Status of payment.',
    `payment_type` DECIMAL(18,2) COMMENT 'Type of payment.',
    `payment_year` DECIMAL(18,2) COMMENT 'CMS payment year.',
    `processing_date` DATE COMMENT 'Date payment was processed.',
    `program_type` STRING COMMENT 'Program type (MA, ACA).',
    `reconciliation_flag` BOOLEAN COMMENT 'Whether this is a reconciliation payment.',
    `record_audit_created` TIMESTAMP COMMENT 'Audit creation timestamp.',
    `record_audit_updated` TIMESTAMP COMMENT 'Audit update timestamp.',
    `risk_score` DECIMAL(18,2) COMMENT 'Associated risk score.',
    CONSTRAINT pk_adjustment_payment PRIMARY KEY(`adjustment_payment_id`)
) COMMENT 'Records risk adjustment payments and reconciliation amounts between CMS and health plans for Medicare Advantage and ACA programs.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` (
    `prospective_risk_model_id` BIGINT COMMENT 'Primary key.',
    `employee_id` BIGINT COMMENT 'FK to model owner employee.',
    `pool_id` BIGINT COMMENT 'FK to risk pool.',
    `cms_model_year` STRING COMMENT 'CMS model year.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `prospective_risk_model_description` STRING COMMENT 'Description of the model.',
    `effective_from` DATE COMMENT 'Model effective start date.',
    `effective_until` DATE COMMENT 'Model effective end date.',
    `input_period_end` DATE COMMENT 'End of input data period.',
    `input_period_start` DATE COMMENT 'Start of input data period.',
    `is_production` BOOLEAN COMMENT 'Whether model is in production.',
    `last_run_timestamp` TIMESTAMP COMMENT 'Last execution timestamp.',
    `model_category` STRING COMMENT 'Category of model.',
    `model_code` STRING COMMENT 'Model code identifier.',
    `model_name` STRING COMMENT 'Name of the model.',
    `model_status` STRING COMMENT 'Status of the model.',
    `normalization_factor` DECIMAL(18,2) COMMENT 'Score normalization factor.',
    `population_segment` STRING COMMENT 'Target population segment.',
    `risk_model_type` STRING COMMENT 'Type of risk model.',
    `risk_score_max` DECIMAL(18,2) COMMENT 'Maximum possible score.',
    `risk_score_min` DECIMAL(18,2) COMMENT 'Minimum possible score.',
    `run_date` DATE COMMENT 'Date of last run.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `version_number` STRING COMMENT 'Model version number.',
    CONSTRAINT pk_prospective_risk_model PRIMARY KEY(`prospective_risk_model_id`)
) COMMENT 'Defines prospective risk models used for population health prediction and care management stratification.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`score_run` (
    `score_run_id` BIGINT COMMENT 'Primary key.',
    `employee_id` BIGINT COMMENT 'FK to executing employee.',
    `pool_id` BIGINT COMMENT 'FK to risk pool.',
    `actuarial_signoff_date` DATE COMMENT 'Date of actuarial signoff.',
    `average_raf_score` DECIMAL(18,2) COMMENT 'Average risk adjustment factor score.',
    `cms_model_year` STRING COMMENT 'CMS model year.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `data_quality_flag` BOOLEAN COMMENT 'Whether data quality issues were detected.',
    `data_snapshot_date` DATE COMMENT 'Date of data snapshot used.',
    `input_data_period_end` DATE COMMENT 'End of input data period.',
    `input_data_period_start` DATE COMMENT 'Start of input data period.',
    `member_population_count` BIGINT COMMENT 'Number of members scored.',
    `model_name` STRING COMMENT 'Name of model used.',
    `model_status` STRING COMMENT 'Status of model at run time.',
    `model_version` STRING COMMENT 'Version of model used.',
    `normalization_factor` DECIMAL(18,2) COMMENT 'Normalization factor applied.',
    `population_segment` STRING COMMENT 'Population segment scored.',
    `risk_model_type` STRING COMMENT 'Type of risk model.',
    `run_code` STRING COMMENT 'Run identifier code.',
    `run_date` DATE COMMENT 'Date of run.',
    `run_description` STRING COMMENT 'Description of the run.',
    `run_status` STRING COMMENT 'Status of the run.',
    `run_type` STRING COMMENT 'Type of run (production, test).',
    `score_distribution_summary` DOUBLE COMMENT 'Summary of score distribution.',
    `total_raf_score` DECIMAL(18,2) COMMENT 'Total RAF score for population.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    CONSTRAINT pk_score_run PRIMARY KEY(`score_run_id`)
) COMMENT 'Records individual risk score calculation runs including parameters, population counts, and aggregate results.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` (
    `radv_audit_id` BIGINT COMMENT 'Primary key.',
    `employee_id` BIGINT COMMENT 'FK to audit lead employee.',
    `subscriber_id` BIGINT COMMENT 'FK to audited subscriber.',
    `pool_id` BIGINT COMMENT 'FK to risk pool.',
    `appeal_status` STRING COMMENT 'Status of any appeal.',
    `audit_end_timestamp` TIMESTAMP COMMENT 'When audit ended.',
    `audit_error_description` STRING COMMENT 'Description of audit errors.',
    `audit_error_flag` BOOLEAN COMMENT 'Whether errors were found.',
    `audit_notes` STRING COMMENT 'Audit notes.',
    `audit_source` STRING COMMENT 'Source of audit.',
    `audit_start_timestamp` TIMESTAMP COMMENT 'When audit started.',
    `audit_status` STRING COMMENT 'Current audit status.',
    `audit_type` STRING COMMENT 'Type of RADV audit.',
    `audit_updated_by` STRING COMMENT 'User who last updated.',
    `audit_year` STRING COMMENT 'Year of audit.',
    `cms_findings` STRING COMMENT 'CMS audit findings.',
    `contract_number` STRING COMMENT 'CMS contract number.',
    `currency_code` STRING COMMENT 'Currency code.',
    `extrapolated_payment_error` DECIMAL(18,2) COMMENT 'Extrapolated payment error amount.',
    `final_settlement_amount` DECIMAL(18,2) COMMENT 'Final settlement amount.',
    `hcc_mapping_version` STRING COMMENT 'HCC mapping version used.',
    `medical_record_receipt_date` DATE COMMENT 'Date medical records received.',
    `medical_record_request_status` STRING COMMENT 'Status of medical record request.',
    `record_created` TIMESTAMP COMMENT 'Record creation timestamp.',
    `record_updated` TIMESTAMP COMMENT 'Record update timestamp.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Risk adjustment factor.',
    `sampled_member_count` STRING COMMENT 'Number of members sampled.',
    `validated_hcc_count` STRING COMMENT 'Number of validated HCCs.',
    CONSTRAINT pk_radv_audit PRIMARY KEY(`radv_audit_id`)
) COMMENT 'Tracks CMS Risk Adjustment Data Validation (RADV) audits including medical record reviews and payment error calculations.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`pool` (
    `pool_id` BIGINT COMMENT 'Primary key.',
    `reinsurance_arrangement_id` BIGINT COMMENT 'FK to reinsurance arrangement.',
    `aca_compliance_flag` BOOLEAN COMMENT 'Whether pool is ACA compliant.',
    `average_risk_score` DECIMAL(18,2) COMMENT 'Average risk score of pool.',
    `pool_code` STRING COMMENT 'Pool code identifier.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `data_source_timestamp` TIMESTAMP COMMENT 'Timestamp of source data.',
    `effective_date` DATE COMMENT 'Pool effective date.',
    `geographic_scope` STRING COMMENT 'Geographic scope of pool.',
    `is_excluded_from_mlr` BOOLEAN COMMENT 'Whether excluded from MLR calculation.',
    `last_review_date` DATE COMMENT 'Date of last review.',
    `line_of_business` STRING COMMENT 'Line of business.',
    `market_segment` STRING COMMENT 'Market segment.',
    `member_months` BIGINT COMMENT 'Total member months in pool.',
    `pool_name` STRING COMMENT 'Name of the pool.',
    `notes` STRING COMMENT 'Additional notes.',
    `pmpm` DECIMAL(18,2) COMMENT 'Per member per month cost.',
    `pool_status` STRING COMMENT 'Status of the pool.',
    `pool_type` STRING COMMENT 'Type of pool.',
    `regulatory_basis` STRING COMMENT 'Regulatory basis for pool.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Pool-level risk adjustment factor.',
    `risk_pool_version` STRING COMMENT 'Version of pool definition.',
    `risk_score_stddev` DECIMAL(18,2) COMMENT 'Standard deviation of risk scores.',
    `state_code` STRING COMMENT 'State code.',
    `termination_date` DATE COMMENT 'Pool termination date.',
    `total_incurred_claims` DECIMAL(18,2) COMMENT 'Total incurred claims.',
    `total_paid_claims` DECIMAL(18,2) COMMENT 'Total paid claims.',
    `total_reserve_amount` DECIMAL(18,2) COMMENT 'Total reserve amount.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `created_by` STRING COMMENT 'User who created the record.',
    CONSTRAINT pk_pool PRIMARY KEY(`pool_id`)
) COMMENT 'Defines risk pools for grouping members by market segment, line of business, and geographic area for risk adjustment and rating purposes.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` (
    `actuarial_assumption_set_id` BIGINT COMMENT 'Primary key.',
    `pool_id` BIGINT COMMENT 'FK to risk pool.',
    `actuarial_assumption_set_status` STRING COMMENT 'The current status indicator for the actuarial assumption set within the workflow.',
    `actuarial_assumption_set_type` STRING COMMENT 'Type of assumption set.',
    `actuarial_signoff_date` DATE COMMENT 'Date of actuarial signoff.',
    `actuarial_signoff_name` STRING COMMENT 'Name of signing actuary.',
    `approval_date` DATE COMMENT 'Date approved.',
    `actuarial_assumption_set_code` STRING COMMENT 'Code identifier.',
    `compound_trend_factor` DECIMAL(18,2) COMMENT 'Compound trend factor.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `credibility_weight` DECIMAL(18,2) COMMENT 'Credibility weight.',
    `data_source` STRING COMMENT 'Source of assumption data.',
    `effective_date` DATE COMMENT 'Effective date.',
    `expiration_date` DATE COMMENT 'Expiration date.',
    `is_peer_reviewed` BOOLEAN COMMENT 'Whether peer reviewed.',
    `is_regulatory_compliant` BOOLEAN COMMENT 'Whether regulatory compliant.',
    `lapse_rate` DECIMAL(18,2) COMMENT 'Assumed lapse rate.',
    `loss_development_factor_age_to_age` DECIMAL(18,2) COMMENT 'Age-to-age loss development factor.',
    `loss_development_factor_cumulative` DECIMAL(18,2) COMMENT 'Cumulative loss development factor.',
    `methodology_description` STRING COMMENT 'Description of methodology.',
    `mortality_rate` DECIMAL(18,2) COMMENT 'Assumed mortality rate.',
    `actuarial_assumption_set_name` STRING COMMENT 'Name of assumption set.',
    `notes` STRING COMMENT 'Additional notes.',
    `peer_review_status` STRING COMMENT 'Peer review status.',
    `purpose` STRING COMMENT 'Purpose of assumption set.',
    `trend_rate_medical_cost` DECIMAL(18,2) COMMENT 'Medical cost trend rate.',
    `trend_rate_pharmacy` DECIMAL(18,2) COMMENT 'Pharmacy trend rate.',
    `trend_rate_utilization` DECIMAL(18,2) COMMENT 'Utilization trend rate.',
    `updated_by` STRING COMMENT 'User who last updated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `version_number` STRING COMMENT 'Version number.',
    `created_by` STRING COMMENT 'User who created the record.',
    CONSTRAINT pk_actuarial_assumption_set PRIMARY KEY(`actuarial_assumption_set_id`)
) COMMENT 'Stores actuarial assumption sets including trend rates, development factors, and mortality/lapse assumptions for reserving and pricing.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ADD CONSTRAINT `fk_risk_member_risk_score_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ADD CONSTRAINT `fk_risk_hcc_mapping_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ADD CONSTRAINT `fk_risk_raps_submission_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ADD CONSTRAINT `fk_risk_risk_cms_submission_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ADD CONSTRAINT `fk_risk_risk_underwriting_case_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ADD CONSTRAINT `fk_risk_rate_development_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ADD CONSTRAINT `fk_risk_ibnr_reserve_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ADD CONSTRAINT `fk_risk_reinsurance_claim_reinsurance_arrangement_id` FOREIGN KEY (`reinsurance_arrangement_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement`(`reinsurance_arrangement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ADD CONSTRAINT `fk_risk_rbc_calculation_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ADD CONSTRAINT `fk_risk_adjustment_payment_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ADD CONSTRAINT `fk_risk_prospective_risk_model_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ADD CONSTRAINT `fk_risk_score_run_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ADD CONSTRAINT `fk_risk_radv_audit_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ADD CONSTRAINT `fk_risk_pool_reinsurance_arrangement_id` FOREIGN KEY (`reinsurance_arrangement_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement`(`reinsurance_arrangement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ADD CONSTRAINT `fk_risk_actuarial_assumption_set_pool_id` FOREIGN KEY (`pool_id`) REFERENCES `vibe_health_insurance_v1`.`risk`.`pool`(`pool_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`risk` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_health_insurance_v1`.`risk` SET TAGS ('dbx_domain' = 'risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` SET TAGS ('dbx_subdomain' = 'score_adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` SET TAGS ('dbx_domain' = 'risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` SET TAGS ('dbx_fhir_resource' = 'RiskAssessment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identity ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `pool_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Pool ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `audit_user` SET TAGS ('dbx_business_glossary_term' = 'Audit User');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `cms_published_score` SET TAGS ('dbx_business_glossary_term' = 'CMS Published Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `cms_submission_status` SET TAGS ('dbx_business_glossary_term' = 'CMS Submission Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `demographic_factor_score` SET TAGS ('dbx_business_glossary_term' = 'Demographic Factor Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `diagnosis_count` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `diagnosis_count` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `diagnosis_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `diagnosis_count` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `hcc_codes` SET TAGS ('dbx_business_glossary_term' = 'HCC Codes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `is_manual_override` SET TAGS ('dbx_business_glossary_term' = 'Is Manual Override');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `manual_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Reason');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `model_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `payment_year` SET TAGS ('dbx_business_glossary_term' = 'Payment Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `plan_calculated_score` SET TAGS ('dbx_business_glossary_term' = 'Plan Calculated Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `resubmission_reference` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Reference');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_adjustment_factor_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor Category');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Confidence');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_label` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Label');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_notes` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Notes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_source` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Source');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_value` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Value');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `score_components` SET TAGS ('dbx_business_glossary_term' = 'Score Components');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `score_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Score Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `score_variance` SET TAGS ('dbx_business_glossary_term' = 'Score Variance');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`member_risk_score` ALTER COLUMN `variance_category` SET TAGS ('dbx_business_glossary_term' = 'Variance Category');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` SET TAGS ('dbx_subdomain' = 'score_adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` SET TAGS ('dbx_domain' = 'risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` SET TAGS ('dbx_fhir_resource' = 'ConceptMap');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'HCC Mapping ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `pool_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Pool ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `age_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Age Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `age_adjustment_factor` SET TAGS ('dbx_pii_type' = 'demographic');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `coefficient` SET TAGS ('dbx_business_glossary_term' = 'Coefficient');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `demographic_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Demographic Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `disease_interaction_group` SET TAGS ('dbx_business_glossary_term' = 'Disease Interaction Group');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Gender Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('dbx_sensitivity' = 'special_category');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('dbx_pii_type' = 'demographic');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_code` SET TAGS ('dbx_business_glossary_term' = 'HCC Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_description` SET TAGS ('dbx_business_glossary_term' = 'HCC Description');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_mapping_status` SET TAGS ('dbx_business_glossary_term' = 'HCC Mapping Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `icd10_code` SET TAGS ('dbx_business_glossary_term' = 'ICD-10 Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `icd10_description` SET TAGS ('dbx_business_glossary_term' = 'ICD-10 Description');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `interaction_flag` SET TAGS ('dbx_business_glossary_term' = 'Interaction Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `is_excluded` SET TAGS ('dbx_business_glossary_term' = 'Is Excluded');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `is_mapped` SET TAGS ('dbx_business_glossary_term' = 'Is Mapped');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `mapping_source` SET TAGS ('dbx_business_glossary_term' = 'Mapping Source');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `parent_hcc_code` SET TAGS ('dbx_business_glossary_term' = 'Parent HCC Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `plan_type_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Plan Type Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `region_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Region Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `risk_score_weight` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Weight');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`hcc_mapping` ALTER COLUMN `source_version` SET TAGS ('dbx_business_glossary_term' = 'Source Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` SET TAGS ('dbx_subdomain' = 'score_adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` SET TAGS ('dbx_domain' = 'risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` SET TAGS ('dbx_fhir_resource' = 'Bundle');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `raps_submission_id` SET TAGS ('dbx_business_glossary_term' = 'RAPS Submission ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `pool_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Pool ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `accepted_record_count` SET TAGS ('dbx_business_glossary_term' = 'Accepted Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `cms_acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'CMS Acknowledgment Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `error_disposition` SET TAGS ('dbx_business_glossary_term' = 'Error Disposition');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `payment_year` SET TAGS ('dbx_business_glossary_term' = 'Payment Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `plan_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `raps_submission_status` SET TAGS ('dbx_business_glossary_term' = 'RAPS Submission Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `rejected_record_count` SET TAGS ('dbx_business_glossary_term' = 'Rejected Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `risk_adjustment_year` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_file_checksum` SET TAGS ('dbx_business_glossary_term' = 'Submission File Checksum');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_file_name` SET TAGS ('dbx_business_glossary_term' = 'Submission File Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_file_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_user_name` SET TAGS ('dbx_business_glossary_term' = 'Submission User Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `submission_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `total_record_count` SET TAGS ('dbx_business_glossary_term' = 'Total Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`raps_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` SET TAGS ('dbx_subdomain' = 'score_adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` SET TAGS ('dbx_domain' = 'risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` SET TAGS ('dbx_fhir_resource' = 'Bundle');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `risk_cms_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Risk CMS Submission ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `pool_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Pool ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `accepted_record_count` SET TAGS ('dbx_business_glossary_term' = 'Accepted Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `cms_acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'CMS Acknowledgment Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `encounter_type` SET TAGS ('dbx_business_glossary_term' = 'Encounter Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `error_disposition` SET TAGS ('dbx_business_glossary_term' = 'Error Disposition');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `payment_year` SET TAGS ('dbx_business_glossary_term' = 'Payment Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `record_count` SET TAGS ('dbx_business_glossary_term' = 'Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `rejected_record_count` SET TAGS ('dbx_business_glossary_term' = 'Rejected Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `risk_adjustment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `service_year` SET TAGS ('dbx_business_glossary_term' = 'Service Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `submission_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Batch Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `submission_checksum` SET TAGS ('dbx_business_glossary_term' = 'Submission Checksum');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `submission_comment` SET TAGS ('dbx_business_glossary_term' = 'Submission Comment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `submission_file_name` SET TAGS ('dbx_business_glossary_term' = 'Submission File Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `submission_file_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `submission_file_size` SET TAGS ('dbx_business_glossary_term' = 'Submission File Size');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `submission_source_system` SET TAGS ('dbx_business_glossary_term' = 'Submission Source System');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `submission_user_role` SET TAGS ('dbx_business_glossary_term' = 'Submission User Role');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `total_claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Claim Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `transition_flag` SET TAGS ('dbx_business_glossary_term' = 'Transition Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_cms_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` SET TAGS ('dbx_subdomain' = 'actuarial_reserving');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` SET TAGS ('dbx_domain' = 'risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `risk_underwriting_case_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Underwriting Case ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Subscriber ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Credential Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `pool_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Pool ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `age_gender_distribution_index` SET TAGS ('dbx_business_glossary_term' = 'Age Gender Distribution Index');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `age_gender_distribution_index` SET TAGS ('dbx_sensitivity' = 'special_category');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `age_gender_distribution_index` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `age_gender_distribution_index` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `age_gender_distribution_index` SET TAGS ('dbx_pii_type' = 'demographic');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `applicant_type` SET TAGS ('dbx_business_glossary_term' = 'Applicant Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `chronic_condition_prevalence_rate` SET TAGS ('dbx_business_glossary_term' = 'Chronic Condition Prevalence Rate');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `expected_claims_pmpm` SET TAGS ('dbx_business_glossary_term' = 'Expected Claims PMPM');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `gross_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `industry_risk_factor` SET TAGS ('dbx_business_glossary_term' = 'Industry Risk Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `is_self_insured` SET TAGS ('dbx_business_glossary_term' = 'Is Self Insured');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `large_claimant_count` SET TAGS ('dbx_business_glossary_term' = 'Large Claimant Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `medical_underwriting_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Underwriting Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `medical_underwriting_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `medical_underwriting_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `morbidity_factor` SET TAGS ('dbx_business_glossary_term' = 'Morbidity Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `net_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Premium Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `overall_group_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Group Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `premium_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `premium_rate` SET TAGS ('dbx_business_glossary_term' = 'Premium Rate');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `premium_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Premium Rate Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `prior_year_claims_pmpm` SET TAGS ('dbx_business_glossary_term' = 'Prior Year Claims PMPM');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `rate_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `rate_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `rating_period` SET TAGS ('dbx_business_glossary_term' = 'Rating Period');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `regulatory_submission_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `reinsurance_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `review_deadline` SET TAGS ('dbx_business_glossary_term' = 'Review Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Risk Classification');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `risk_underwriting_case_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Underwriting Case Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `stop_loss_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Stop Loss Arrangement');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `total_member_months` SET TAGS ('dbx_business_glossary_term' = 'Total Member Months');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `underwriting_case_number` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Case Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `underwriting_rule_set` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Rule Set');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `underwriting_tier` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Tier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`risk_underwriting_case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` SET TAGS ('dbx_subdomain' = 'actuarial_reserving');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` SET TAGS ('dbx_domain' = 'risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `rate_development_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Development ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `pool_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Pool ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `administrative_loading` SET TAGS ('dbx_business_glossary_term' = 'Administrative Loading');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `age_factor` SET TAGS ('dbx_business_glossary_term' = 'Age Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `age_factor` SET TAGS ('dbx_pii_type' = 'demographic');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Rate');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `credibility_factor` SET TAGS ('dbx_business_glossary_term' = 'Credibility Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `development_number` SET TAGS ('dbx_business_glossary_term' = 'Development Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `final_approved_rate` SET TAGS ('dbx_business_glossary_term' = 'Final Approved Rate');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `gender_factor` SET TAGS ('dbx_business_glossary_term' = 'Gender Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `gender_factor` SET TAGS ('dbx_sensitivity' = 'special_category');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `gender_factor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `gender_factor` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `gender_factor` SET TAGS ('dbx_pii_type' = 'demographic');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `geographic_factor` SET TAGS ('dbx_business_glossary_term' = 'Geographic Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `group_size_factor` SET TAGS ('dbx_business_glossary_term' = 'Group Size Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `industry_factor` SET TAGS ('dbx_business_glossary_term' = 'Industry Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `mlr_target` SET TAGS ('dbx_business_glossary_term' = 'MLR Target');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `plan_type_loading` SET TAGS ('dbx_business_glossary_term' = 'Plan Type Loading');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `profit_margin` SET TAGS ('dbx_business_glossary_term' = 'Profit Margin');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `rate_development_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Development Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `rate_methodology` SET TAGS ('dbx_business_glossary_term' = 'Rate Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `rating_area` SET TAGS ('dbx_business_glossary_term' = 'Rating Area');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `rating_period_end` SET TAGS ('dbx_business_glossary_term' = 'Rating Period End');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `rating_period_start` SET TAGS ('dbx_business_glossary_term' = 'Rating Period Start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `tobacco_factor` SET TAGS ('dbx_business_glossary_term' = 'Tobacco Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `trend_factor` SET TAGS ('dbx_business_glossary_term' = 'Trend Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rate_development` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` SET TAGS ('dbx_subdomain' = 'actuarial_reserving');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` SET TAGS ('dbx_domain' = 'risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` SET TAGS ('dbx_mvm_scope' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` SET TAGS ('dbx_scope' = 'mvm');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `ibnr_reserve_id` SET TAGS ('dbx_business_glossary_term' = 'IBNR Reserve ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `pool_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Pool ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `actuarial_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Confidence Level');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `confidence_interval_lower` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Lower');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `confidence_interval_upper` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Upper');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `development_factor` SET TAGS ('dbx_business_glossary_term' = 'Development Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `expected_loss_ratio` SET TAGS ('dbx_business_glossary_term' = 'Expected Loss Ratio');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `external_reserve_code` SET TAGS ('dbx_business_glossary_term' = 'External Reserve Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `forecast_horizon_months` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon Months');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `hcc_weighted_amount` SET TAGS ('dbx_business_glossary_term' = 'HCC Weighted Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `ibnr_amount` SET TAGS ('dbx_business_glossary_term' = 'IBNR Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `ibnr_pmpm` SET TAGS ('dbx_business_glossary_term' = 'IBNR PMPM');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `ibnr_reserve_status` SET TAGS ('dbx_business_glossary_term' = 'IBNR Reserve Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `lob_code` SET TAGS ('dbx_business_glossary_term' = 'LOB Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `raps_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'RAPS Submission Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `rbc_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'RBC Impact Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `reserve_adequacy_flag` SET TAGS ('dbx_business_glossary_term' = 'Reserve Adequacy Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `reserve_methodology` SET TAGS ('dbx_business_glossary_term' = 'Reserve Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `reserve_name` SET TAGS ('dbx_business_glossary_term' = 'Reserve Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `reserve_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `service_month` SET TAGS ('dbx_business_glossary_term' = 'Service Month');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`ibnr_reserve` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` SET TAGS ('dbx_subdomain' = 'reinsurance_transfer');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` SET TAGS ('dbx_domain' = 'risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `reinsurance_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Arrangement ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `aggregate_attachment_amount` SET TAGS ('dbx_business_glossary_term' = 'Aggregate Attachment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `aggregate_attachment_factor` SET TAGS ('dbx_business_glossary_term' = 'Aggregate Attachment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `attachment_point` SET TAGS ('dbx_business_glossary_term' = 'Attachment Point');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `attachment_point_currency` SET TAGS ('dbx_business_glossary_term' = 'Attachment Point Currency');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `corridor_percentage` SET TAGS ('dbx_business_glossary_term' = 'Corridor Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `lob_coverage` SET TAGS ('dbx_business_glossary_term' = 'LOB Coverage');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `maximum_liability` SET TAGS ('dbx_business_glossary_term' = 'Maximum Liability');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `maximum_recovery_limit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Recovery Limit');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `premium_ceded` SET TAGS ('dbx_business_glossary_term' = 'Premium Ceded');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `reinsurance_arrangement_status` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Arrangement Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `reinsurer_name` SET TAGS ('dbx_business_glossary_term' = 'Reinsurer Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `reinsurer_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `specific_deductible` SET TAGS ('dbx_business_glossary_term' = 'Specific Deductible');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `stop_loss_deductible` SET TAGS ('dbx_business_glossary_term' = 'Stop Loss Deductible');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `stop_loss_limit` SET TAGS ('dbx_business_glossary_term' = 'Stop Loss Limit');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `stop_loss_threshold` SET TAGS ('dbx_business_glossary_term' = 'Stop Loss Threshold');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `stop_loss_type` SET TAGS ('dbx_business_glossary_term' = 'Stop Loss Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `treaty_terms` SET TAGS ('dbx_business_glossary_term' = 'Treaty Terms');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `treaty_type` SET TAGS ('dbx_business_glossary_term' = 'Treaty Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` SET TAGS ('dbx_subdomain' = 'reinsurance_transfer');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` SET TAGS ('dbx_domain' = 'risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `reinsurance_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Claim ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Subscriber ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `reinsurance_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Arrangement ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `attachment_point_amount` SET TAGS ('dbx_business_glossary_term' = 'Attachment Point Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `claimant_type` SET TAGS ('dbx_business_glossary_term' = 'Claimant Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `covered_end_date` SET TAGS ('dbx_business_glossary_term' = 'Covered End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `covered_start_date` SET TAGS ('dbx_business_glossary_term' = 'Covered Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `is_aggregated` SET TAGS ('dbx_business_glossary_term' = 'Is Aggregated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `loss_category` SET TAGS ('dbx_business_glossary_term' = 'Loss Category');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `loss_description` SET TAGS ('dbx_business_glossary_term' = 'Loss Description');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `payment_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `recoverable_amount` SET TAGS ('dbx_business_glossary_term' = 'Recoverable Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `recovery_status` SET TAGS ('dbx_business_glossary_term' = 'Recovery Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `total_incurred_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Incurred Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`reinsurance_claim` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` SET TAGS ('dbx_subdomain' = 'actuarial_reserving');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` SET TAGS ('dbx_domain' = 'risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `rbc_calculation_id` SET TAGS ('dbx_business_glossary_term' = 'RBC Calculation ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `pool_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Pool ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `action_threshold_status` SET TAGS ('dbx_business_glossary_term' = 'Action Threshold Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `authorized_control_level_rbc` SET TAGS ('dbx_business_glossary_term' = 'Authorized Control Level RBC');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `calculation_number` SET TAGS ('dbx_business_glossary_term' = 'Calculation Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `calculation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Calculation Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `calculation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Calculation Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `company_action_level_rbc` SET TAGS ('dbx_business_glossary_term' = 'Company Action Level RBC');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `covariance_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Covariance Adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `h0_asset_risk` SET TAGS ('dbx_business_glossary_term' = 'H0 Asset Risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `h1_underwriting_risk` SET TAGS ('dbx_business_glossary_term' = 'H1 Underwriting Risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `h2_credit_risk` SET TAGS ('dbx_business_glossary_term' = 'H2 Credit Risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `h3_business_risk` SET TAGS ('dbx_business_glossary_term' = 'H3 Business Risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `h4_admin_expense_risk` SET TAGS ('dbx_business_glossary_term' = 'H4 Admin Expense Risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `rbc_ratio` SET TAGS ('dbx_business_glossary_term' = 'RBC Ratio');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `rbc_status` SET TAGS ('dbx_business_glossary_term' = 'RBC Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `total_adjusted_capital` SET TAGS ('dbx_business_glossary_term' = 'Total Adjusted Capital');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`rbc_calculation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` SET TAGS ('dbx_subdomain' = 'score_adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` SET TAGS ('dbx_domain' = 'risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `adjustment_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Payment ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Subscriber ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `pool_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Pool ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `adjustment_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `business_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Business Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `cms_notification_date` SET TAGS ('dbx_business_glossary_term' = 'CMS Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `payment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `payment_source` SET TAGS ('dbx_business_glossary_term' = 'Payment Source');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `payment_year` SET TAGS ('dbx_business_glossary_term' = 'Payment Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `processing_date` SET TAGS ('dbx_business_glossary_term' = 'Processing Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `reconciliation_flag` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`adjustment_payment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` SET TAGS ('dbx_subdomain' = 'score_adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` SET TAGS ('dbx_domain' = 'risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `prospective_risk_model_id` SET TAGS ('dbx_business_glossary_term' = 'Prospective Risk Model ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `pool_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Pool ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `cms_model_year` SET TAGS ('dbx_business_glossary_term' = 'CMS Model Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `prospective_risk_model_description` SET TAGS ('dbx_business_glossary_term' = 'Prospective Risk Model Description');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `input_period_end` SET TAGS ('dbx_business_glossary_term' = 'Input Period End');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `input_period_start` SET TAGS ('dbx_business_glossary_term' = 'Input Period Start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `is_production` SET TAGS ('dbx_business_glossary_term' = 'Is Production');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `last_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Run Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `model_category` SET TAGS ('dbx_business_glossary_term' = 'Model Category');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `model_code` SET TAGS ('dbx_business_glossary_term' = 'Model Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `model_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `model_status` SET TAGS ('dbx_business_glossary_term' = 'Model Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `normalization_factor` SET TAGS ('dbx_business_glossary_term' = 'Normalization Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `population_segment` SET TAGS ('dbx_business_glossary_term' = 'Population Segment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `risk_model_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `risk_score_max` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Max');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `risk_score_min` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Min');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `run_date` SET TAGS ('dbx_business_glossary_term' = 'Run Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`prospective_risk_model` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` SET TAGS ('dbx_subdomain' = 'score_adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` SET TAGS ('dbx_domain' = 'risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `score_run_id` SET TAGS ('dbx_business_glossary_term' = 'Score Run ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `pool_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Pool ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `actuarial_signoff_date` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Signoff Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `average_raf_score` SET TAGS ('dbx_business_glossary_term' = 'Average RAF Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `cms_model_year` SET TAGS ('dbx_business_glossary_term' = 'CMS Model Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `data_snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Data Snapshot Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `input_data_period_end` SET TAGS ('dbx_business_glossary_term' = 'Input Data Period End');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `input_data_period_start` SET TAGS ('dbx_business_glossary_term' = 'Input Data Period Start');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `member_population_count` SET TAGS ('dbx_business_glossary_term' = 'Member Population Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `model_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `model_status` SET TAGS ('dbx_business_glossary_term' = 'Model Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `normalization_factor` SET TAGS ('dbx_business_glossary_term' = 'Normalization Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `population_segment` SET TAGS ('dbx_business_glossary_term' = 'Population Segment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `risk_model_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `run_code` SET TAGS ('dbx_business_glossary_term' = 'Run Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `run_date` SET TAGS ('dbx_business_glossary_term' = 'Run Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `run_description` SET TAGS ('dbx_business_glossary_term' = 'Run Description');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Run Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `score_distribution_summary` SET TAGS ('dbx_business_glossary_term' = 'Score Distribution Summary');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `total_raf_score` SET TAGS ('dbx_business_glossary_term' = 'Total RAF Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`score_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` SET TAGS ('dbx_subdomain' = 'score_adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` SET TAGS ('dbx_domain' = 'risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `radv_audit_id` SET TAGS ('dbx_business_glossary_term' = 'RADV Audit ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Subscriber ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `pool_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Pool ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit End Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_error_description` SET TAGS ('dbx_business_glossary_term' = 'Audit Error Description');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_error_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Error Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_source` SET TAGS ('dbx_business_glossary_term' = 'Audit Source');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Start Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Audit Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `audit_year` SET TAGS ('dbx_business_glossary_term' = 'Audit Year');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `cms_findings` SET TAGS ('dbx_business_glossary_term' = 'CMS Findings');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `extrapolated_payment_error` SET TAGS ('dbx_business_glossary_term' = 'Extrapolated Payment Error');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `final_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Final Settlement Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `hcc_mapping_version` SET TAGS ('dbx_business_glossary_term' = 'HCC Mapping Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Receipt Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_receipt_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_receipt_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_request_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Request Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_request_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `medical_record_request_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `record_created` SET TAGS ('dbx_business_glossary_term' = 'Record Created');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `record_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Updated');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `sampled_member_count` SET TAGS ('dbx_business_glossary_term' = 'Sampled Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`radv_audit` ALTER COLUMN `validated_hcc_count` SET TAGS ('dbx_business_glossary_term' = 'Validated HCC Count');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` SET TAGS ('dbx_subdomain' = 'score_adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` SET TAGS ('dbx_domain' = 'risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `pool_id` SET TAGS ('dbx_business_glossary_term' = 'Pool ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `reinsurance_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Arrangement ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `aca_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'ACA Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `average_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Average Risk Score');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `pool_code` SET TAGS ('dbx_business_glossary_term' = 'Pool Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `data_source_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Source Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `is_excluded_from_mlr` SET TAGS ('dbx_business_glossary_term' = 'Is Excluded From MLR');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `member_months` SET TAGS ('dbx_business_glossary_term' = 'Member Months');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `pool_name` SET TAGS ('dbx_business_glossary_term' = 'Pool Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `pool_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `pmpm` SET TAGS ('dbx_business_glossary_term' = 'PMPM');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `pool_status` SET TAGS ('dbx_business_glossary_term' = 'Pool Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `pool_type` SET TAGS ('dbx_business_glossary_term' = 'Pool Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `risk_pool_version` SET TAGS ('dbx_business_glossary_term' = 'Risk Pool Version');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `risk_score_stddev` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Std Dev');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `total_incurred_claims` SET TAGS ('dbx_business_glossary_term' = 'Total Incurred Claims');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `total_paid_claims` SET TAGS ('dbx_business_glossary_term' = 'Total Paid Claims');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `total_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Reserve Amount');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`pool` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` SET TAGS ('dbx_subdomain' = 'actuarial_reserving');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` SET TAGS ('dbx_domain' = 'risk');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `actuarial_assumption_set_id` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Assumption Set ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `pool_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Pool ID');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `actuarial_assumption_set_status` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Assumption Set Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `actuarial_assumption_set_type` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Assumption Set Type');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `actuarial_signoff_date` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Signoff Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `actuarial_signoff_name` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Signoff Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `actuarial_signoff_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `actuarial_assumption_set_code` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Assumption Set Code');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `compound_trend_factor` SET TAGS ('dbx_business_glossary_term' = 'Compound Trend Factor');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `credibility_weight` SET TAGS ('dbx_business_glossary_term' = 'Credibility Weight');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `is_peer_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Is Peer Reviewed');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `is_regulatory_compliant` SET TAGS ('dbx_business_glossary_term' = 'Is Regulatory Compliant');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `lapse_rate` SET TAGS ('dbx_business_glossary_term' = 'Lapse Rate');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `loss_development_factor_age_to_age` SET TAGS ('dbx_business_glossary_term' = 'Loss Development Factor Age to Age');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `loss_development_factor_age_to_age` SET TAGS ('dbx_pii_type' = 'demographic');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `loss_development_factor_cumulative` SET TAGS ('dbx_business_glossary_term' = 'Loss Development Factor Cumulative');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `methodology_description` SET TAGS ('dbx_business_glossary_term' = 'Methodology Description');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `mortality_rate` SET TAGS ('dbx_business_glossary_term' = 'Mortality Rate');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `actuarial_assumption_set_name` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Assumption Set Name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `actuarial_assumption_set_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `peer_review_status` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Purpose');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `trend_rate_medical_cost` SET TAGS ('dbx_business_glossary_term' = 'Trend Rate Medical Cost');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `trend_rate_medical_cost` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `trend_rate_medical_cost` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `trend_rate_pharmacy` SET TAGS ('dbx_business_glossary_term' = 'Trend Rate Pharmacy');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `trend_rate_utilization` SET TAGS ('dbx_business_glossary_term' = 'Trend Rate Utilization');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
