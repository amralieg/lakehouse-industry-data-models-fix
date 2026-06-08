-- Schema for Domain: risk | Business: Health Insurance | Version: v1_mvm
-- Generated on: 2026-05-03 21:25:46

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `health_insurance_ecm`.`risk` COMMENT 'Manages actuarial risk assessment, underwriting, and risk adjustment programs — RAF scoring, HCC mapping, RAPS/EDPS submissions to CMS, RBC calculations, IBNR reserve estimation, and rate-setting inputs. Owns risk scores at the member level, underwriting decisions for group and individual markets, reinsurance/stop-loss arrangements, and premium rate development. Source system: Milliman MG-ALFA and actuarial models.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `health_insurance_ecm`.`risk`.`member_risk_score` (
    `member_risk_score_id` BIGINT COMMENT 'System-generated unique identifier for the member risk score record.',
    `audit_engagement_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_engagement. Business justification: CMS Risk Adjustment Data Validation (RADV) audits directly examine member risk scores. Linking member_risk_score to the audit_engagement driving the RADV review is essential for tracking which scores ',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: CMS risk adjustment operations require member risk scores to be attributed to a specific health plan for plan-level RAF calculation, CMS payment reconciliation, and HCC-based risk adjustment reporting',
    `member_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to member.member_eligibility_span. Business justification: CMS risk adjustment (RAPS/EDPS) requires anchoring each risk score to the specific eligibility span it covers for payment year reconciliation. Domain experts in risk adjustment operations consider thi',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member to whom the risk score applies.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Risk scores are calculated per policy for CMS risk adjustment submissions and premium rating. Domain experts expect member_risk_score to reference the specific policy it covers, enabling policy-level ',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: Member risk scores are calculated per plan year for CMS payment year submissions. Linking to plan.year enables year-based risk score aggregation, open enrollment period alignment, and annual CMS risk ',
    `audit_user` STRING COMMENT 'User ID of the person who performed the most recent audit action.',
    `cms_published_score` DECIMAL(18,2) COMMENT 'RAF score value as published by CMS after reconciliation.',
    `cms_submission_status` STRING COMMENT 'Current status of the scores submission to CMS.. Valid values are `submitted|accepted|rejected|pending`',
    `corrective_action` STRING COMMENT 'Description of actions taken to resolve score variance (e.g., code addendum, data correction).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk score record was first created in the data lake.',
    `demographic_factor_score` DECIMAL(18,2) COMMENT 'Score component derived from member demographics (age, gender, Medicaid status).',
    `diagnosis_count` STRING COMMENT 'Number of distinct diagnoses captured for the member in the scoring period.',
    `effective_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the risk score became effective.',
    `expiration_date` DATE COMMENT 'Date after which the risk score is no longer valid for payment.',
    `is_manual_override` BOOLEAN COMMENT 'Indicates whether the score was manually overridden.',
    `manual_override_reason` STRING COMMENT 'Reason provided for a manual override of the risk score.',
    `model_name` STRING COMMENT 'Name of the risk adjustment model (e.g., "CMS‑HCC", "RxHCC", "HHS‑HCC").',
    `model_version` STRING COMMENT 'Version identifier of the actuarial model used to generate the score (e.g., "CMS‑HCC v2023").',
    `payment_year` STRING COMMENT 'Calendar year for which the risk score is used in CMS payment calculations.',
    `plan_calculated_score` DECIMAL(18,2) COMMENT 'RAF score calculated internally by the health plan prior to CMS submission.',
    `record_status` STRING COMMENT 'Lifecycle status of the risk score record.. Valid values are `active|inactive|archived`',
    `resubmission_reference` STRING COMMENT 'Reference identifier for any resubmitted score file to CMS.',
    `risk_adjustment_factor_category` STRING COMMENT 'Category of the risk adjustment factor (e.g., "RAF", "HCC", "RxHCC").',
    `risk_score_code` STRING COMMENT 'Business identifier code for the risk score record, often composed of member ID, year, and model version.',
    `risk_score_confidence_score` DECIMAL(18,2) COMMENT 'Confidence level (0‑100) assigned by the model to the score.',
    `risk_score_label` STRING COMMENT 'Human‑readable label describing the risk score record (e.g., "2023 Medicare Advantage RAF").',
    `risk_score_notes` STRING COMMENT 'Free‑text field for any additional commentary or observations.',
    `risk_score_source` STRING COMMENT 'Data source used to generate the score.. Valid values are `encounter|claims|pharmacy|utilization`',
    `risk_score_status` STRING COMMENT 'Current processing status of the risk score.. Valid values are `pending_review|finalized`',
    `risk_score_type` STRING COMMENT 'Indicates whether the score is projected (prospective), derived from current data (concurrent), or the final CMS‑published value.. Valid values are `prospective|concurrent|final`',
    `risk_score_value` DECIMAL(18,2) COMMENT 'Numeric RAF score calculated for the member (e.g., 1.2345).',
    `score_components` STRING COMMENT 'Delimited list or JSON string of component scores (e.g., HCC contributions, demographic adjustments).',
    `score_effective_date` DATE COMMENT 'Date on which the risk score becomes effective for payment calculations.',
    `score_variance` DECIMAL(18,2) COMMENT 'Numeric difference between the plan‑calculated score and the CMS‑published score.',
    `source_system` STRING COMMENT 'Originating system for the risk score (e.g., "Milliman MG‑ALFA").',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the risk score record.',
    `variance_category` STRING COMMENT 'Root‑cause classification for any variance between plan and CMS scores.. Valid values are `missing_diagnoses|hierarchy_diff|demographic|other`',
    CONSTRAINT pk_member_risk_score PRIMARY KEY(`member_risk_score_id`)
) COMMENT 'Authoritative member-level risk score record and reconciliation tracker. Captures RAF (Risk Adjustment Factor) scores, HCC (Hierarchical Condition Category) mappings, CMS reconciliation outcomes, and plan-vs-CMS variance analysis. Stores prospective and concurrent RAF scores derived from actuarial models and encounter data, including score effective dates, payment year, model version (CMS-HCC, RxHCC, HHS-HCC, PACE), score components, CMS submission status, plan-calculated vs. CMS-published RAF variance, root cause category (missing diagnoses, HCC hierarchy differences, demographic factors), corrective actions, and resubmission references. Core SSOT for member-level risk in Medicare Advantage, ACA, and Medicaid risk adjustment programs. Subsumes RAF reconciliation tracking.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` (
    `hcc_mapping_id` BIGINT COMMENT 'Primary key for hcc_mapping',
    `age_adjustment_factor` DECIMAL(18,2) COMMENT 'Multiplier adjusting the HCC coefficient based on member age.',
    `coefficient` DECIMAL(18,2) COMMENT 'Weighting coefficient used in RAF score calculations for the HCC.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the mapping record was first loaded into the lakehouse.',
    `demographic_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor adjusting the HCC weight for demographic characteristics (age, gender, etc.).',
    `disease_interaction_group` STRING COMMENT 'Identifier for a group of diagnoses that have interaction effects.',
    `effective_date` DATE COMMENT 'Date when this mapping becomes effective.',
    `expiration_date` DATE COMMENT 'Date when this mapping expires or is superseded; null if still active.',
    `gender_adjustment_factor` DECIMAL(18,2) COMMENT 'Multiplier adjusting the HCC coefficient based on member gender.',
    `hcc_code` STRING COMMENT 'CMS-assigned HCC identifier linked to the diagnosis.',
    `hcc_description` STRING COMMENT 'Human‑readable description of the HCC.',
    `hcc_mapping_status` STRING COMMENT 'Current lifecycle status of the mapping record.. Valid values are `active|inactive|retired`',
    `hierarchy_level` STRING COMMENT 'Depth of the HCC within the hierarchical structure (0 = top level).',
    `icd10_code` STRING COMMENT 'Standard ICD-10 diagnosis code associated with the mapping.. Valid values are `^[A-TV-Z][0-9][0-9A-Z](.[0-9A-Z]{1,4})?$`',
    `icd10_description` STRING COMMENT 'Full textual description of the ICD-10 diagnosis.',
    `interaction_flag` STRING COMMENT 'Indicates whether the diagnosis interacts with other HCCs (yes) or not (no).. Valid values are `yes|no`',
    `is_excluded` BOOLEAN COMMENT 'Indicates whether the diagnosis is excluded from the current model year.',
    `is_mapped` BOOLEAN COMMENT 'True if the ICD‑10 code has a valid HCC mapping in this version.',
    `last_review_date` DATE COMMENT 'Date when the mapping was last reviewed for accuracy.',
    `last_updated_by` STRING COMMENT 'Identifier of the user or process that performed the last update.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the mapping record.',
    `mapping_source` STRING COMMENT 'Origin of the mapping data.. Valid values are `CMS|Milliman|Custom`',
    `model_year` STRING COMMENT 'Calendar year of the CMS HCC model version to which the mapping applies.',
    `notes` STRING COMMENT 'Free‑form comments or audit notes regarding the mapping.',
    `parent_hcc_code` STRING COMMENT 'Code of the immediate parent HCC in the hierarchy, if applicable.',
    `plan_type_adjustment_factor` DECIMAL(18,2) COMMENT 'Adjustment factor for the HCC based on the members health plan type (e.g., HMO, PPO).',
    `region_adjustment_factor` DECIMAL(18,2) COMMENT 'Adjustment factor reflecting geographic cost variations.',
    `review_status` STRING COMMENT 'Current status of the most recent review process.. Valid values are `pending|approved|rejected`',
    `risk_score_weight` DECIMAL(18,2) COMMENT 'Weight applied to the HCC when aggregating RAF scores.',
    `source_version` STRING COMMENT 'Version identifier of the source CMS model (e.g., V24, V28).',
    CONSTRAINT pk_hcc_mapping PRIMARY KEY(`hcc_mapping_id`)
) COMMENT 'Maps ICD-10 diagnosis codes to Hierarchical Condition Categories (HCCs) per CMS model version. Stores the ICD-to-HCC crosswalk, HCC hierarchy relationships (parent/child HCC hierarchies), coefficient values by model year, disease interaction flags, and demographic adjustment factors. Supports RAF score calculation, RAPS/EDPS submission validation, and RADV audit defense. Reference entity managed per CMS annual model updates (V24, V28 transition). Source: CMS annual HCC model release files.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`risk`.`raps_submission` (
    `raps_submission_id` BIGINT COMMENT 'System-generated unique identifier for each RAPS submission batch record.',
    `cms_submission_id` BIGINT COMMENT 'Foreign key linking to risk.risk_cms_submission. Business justification: A RAPS submission is a specific submission channel record that belongs to a broader CMS risk adjustment submission tracked in risk_cms_submission. risk_cms_submission tracks both RAPS and EDPS submiss',
    `health_plan_id` BIGINT COMMENT 'Unique identifier of the health plan (contract) associated with the RAPS submission.',
    `member_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to member.member_eligibility_span. Business justification: RAPS submissions must be reconciled against specific member eligibility spans per CMS requirements. Risk adjustment operations teams use this link for submission error correction and coverage period v',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: RAPS submissions are federally mandated ACA Section 1343 risk adjustment filings. Each batch must be traceable to its governing regulatory obligation for CMS compliance tracking, penalty management, a',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Compliance teams reconcile RAPS technical submission records against formal regulatory_submission filings for CMS reporting. This link enables the compliance-risk reconciliation process, ensuring each',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: RAPS submissions are filed per plan year for CMS risk adjustment. Linking to plan.year enables proper plan-year-based RAPS reconciliation, submission deadline tracking against cms_plan_submission_dead',
    `accepted_record_count` STRING COMMENT 'Number of records that CMS accepted without error in this submission.',
    `batch_number` STRING COMMENT 'External batch identifier assigned by the source system for the RAPS submission.',
    `cms_acknowledgment_status` STRING COMMENT 'Acknowledgment status returned by CMS for the submitted batch.. Valid values are `received|processed|accepted|rejected`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the submission record was first created in the data warehouse.',
    `error_disposition` STRING COMMENT 'Textual description of any errors or rejections returned by CMS for this batch.',
    `payment_year` STRING COMMENT 'Calendar year for which the risk adjustment payment is being calculated.',
    `plan_contract_number` STRING COMMENT 'Contract number of the plan submitted to CMS for risk adjustment.',
    `plan_type` STRING COMMENT 'Type of health plan associated with the submission (e.g., HMO, PPO).. Valid values are `hmo|ppo|epo|pos|hdhp`',
    `raps_submission_status` STRING COMMENT 'Current processing status of the RAPS submission within the CMS workflow.. Valid values are `pending|submitted|acknowledged|rejected|error`',
    `rejected_record_count` STRING COMMENT 'Number of records that CMS rejected or flagged with errors in this submission.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Aggregated HCC-derived factor used to compute the plans risk adjustment payment.',
    `risk_adjustment_year` STRING COMMENT 'Year for which the risk adjustment factors are being reported.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk Adjustment Factor (RAF) score calculated for the plan in this submission.',
    `source_system` STRING COMMENT 'Originating system that generated the RAPS submission record.. Valid values are `milliman|edi_gateway`',
    `submission_file_checksum` STRING COMMENT 'SHA-256 checksum of the transmitted file to ensure data integrity.',
    `submission_file_name` STRING COMMENT 'Name of the flat file or payload transmitted to CMS for this batch.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the RAPS batch was transmitted to the CMS gateway.',
    `submission_user_name` STRING COMMENT 'Display name of the user who submitted the batch.',
    `total_record_count` STRING COMMENT 'Total number of individual member risk adjustment records included in the batch.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the submission record.',
    CONSTRAINT pk_raps_submission PRIMARY KEY(`raps_submission_id`)
) COMMENT 'Tracks Risk Adjustment Processing System (RAPS) submissions to CMS for Medicare Advantage risk adjustment. Captures submission batch ID, submission date, plan contract number, payment year, record counts, accepted/rejected record counts, CMS acknowledgment status, and error disposition. Each record represents a RAPS batch transaction submitted via the CMS RAPS gateway. Source: Milliman MG-ALFA and EDI gateway.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`risk`.`cms_submission` (
    `cms_submission_id` BIGINT COMMENT 'Primary key for cms_submission',
    `audit_engagement_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_engagement. Business justification: CMS risk adjustment submissions are directly examined in RADV audit engagements. Linking risk_cms_submission to the specific audit_engagement allows compliance and risk teams to track which CMS submis',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan associated with the risk adjustment data.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: CMS risk‑adjustment submissions must be linked to the governing regulatory obligation; reporting dashboards require this association.',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: CMS risk adjustment submissions are bound to a specific plan year for payment year reconciliation and regulatory compliance. Linking to plan.year enables year-based submission tracking, open enrollmen',
    `accepted_record_count` BIGINT COMMENT 'Number of records that CMS accepted without error.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total monetary adjustments (e.g., discounts, penalties) applied to the claim total.',
    `cms_acknowledgment_status` STRING COMMENT 'CMSs acknowledgment of the submission batch.. Valid values are `received|processed|accepted|rejected|pending`',
    `contract_number` STRING COMMENT 'Identifier of the contract or Provider Benefit Package (PBP) associated with the submission.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the submission record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary fields.. Valid values are `USD|EUR|GBP|CAD|JPY`',
    `encounter_type` STRING COMMENT 'Category of the clinical encounter data included in the batch.. Valid values are `inpatient|outpatient|professional|pharmacy|other`',
    `error_disposition` STRING COMMENT 'Textual description of any errors returned by CMS for the batch.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net dollar amount after adjustments, representing the amount CMS will reimburse.',
    `payment_year` STRING COMMENT 'Calendar year for which CMS payment is being calculated.',
    `record_count` BIGINT COMMENT 'Total number of individual risk adjustment records submitted in the batch.',
    `rejected_record_count` BIGINT COMMENT 'Number of records that CMS rejected due to validation errors.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Aggregated Hierarchical Condition Category (HCC) factor for the batch.',
    `risk_adjustment_score` DECIMAL(18,2) COMMENT 'Risk Adjustment Factor (RAF) score calculated for the batch.',
    `service_year` STRING COMMENT 'Year of the services/encounters represented in the submission.',
    `submission_batch_number` STRING COMMENT 'Business identifier assigned to the batch of records submitted to CMS.',
    `submission_checksum` STRING COMMENT 'MD5 checksum of the submission file for integrity verification.',
    `submission_comment` STRING COMMENT 'Free‑text notes entered at submission time.',
    `submission_file_name` STRING COMMENT 'File name of the electronic submission payload.',
    `submission_file_size` BIGINT COMMENT 'Size of the submission file in bytes.',
    `submission_source_system` STRING COMMENT 'Name of the source system that generated the submission (e.g., Milliman MG‑ALFA).',
    `submission_status` STRING COMMENT 'Current lifecycle status of the CMS submission batch.. Valid values are `pending|submitted|accepted|rejected|error`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the batch was transmitted to CMS.',
    `submission_type` STRING COMMENT 'Indicates whether the batch was submitted via the Risk Adjustment Processing System (RAPS) or Encounter Data Processing System (EDPS).. Valid values are `RAPS|EDPS`',
    `submission_user_role` STRING COMMENT 'Role of the submitter (e.g., actuarial_analyst, system_process).',
    `total_claim_amount` DECIMAL(18,2) COMMENT 'Aggregate dollar amount of all claims included in the submission.',
    `transition_flag` BOOLEAN COMMENT 'Indicates whether the batch complies with the RAPS‑to‑EDPS transition requirements (true = compliant).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the submission record.',
    CONSTRAINT pk_cms_submission PRIMARY KEY(`cms_submission_id`)
) COMMENT 'Tracks CMS risk adjustment data submissions for Medicare Advantage via both RAPS (Risk Adjustment Processing System) and EDPS (Encounter Data Processing System) channels. Captures submission batch ID, submission type (RAPS/EDPS), submission date, contract/PBP number, payment year, service year, encounter type, record counts, accepted/rejected counts, CMS acknowledgment status, error disposition, and RAPS-to-EDPS transition compliance flags. Each record represents a batch transaction submitted to CMS for risk adjustment processing. Supports RADV audit readiness and CMS reconciliation. Note: This product should be renamed to cms_submission after the RAPS+EDPS merge.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` (
    `risk_underwriting_case_id` BIGINT COMMENT 'System-generated unique identifier for the underwriting case record.',
    `employer_underwriting_case_id` BIGINT COMMENT 'Foreign key linking to employer.employer_underwriting_case. Business justification: In health insurance underwriting, the employer-facing underwriting case (quote, census, rating factors) and the risk-side underwriting case (morbidity, claims PMPM, risk classification) are two facets',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Underwriting case must reference the employer group to calculate premiums and satisfy ACA/ERISA reporting requirements.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Underwriting cases evaluate risk for a specific health plan to determine premium rates and risk classification. Plan-level underwriting decisions (morbidity_factor, risk_classification, premium_rate) ',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the applicant (member or group) for which the underwriting case is created.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Underwriters explicitly factor in the assigned provider network (narrow, broad, tiered) when setting premium rates for employer groups — network type directly affects expected claims PMPM and morbidit',
    `reinsurance_arrangement_id` BIGINT COMMENT 'Foreign key linking to risk.reinsurance_arrangement. Business justification: risk_underwriting_case has a reinsurance_flag (BOOLEAN) and stop_loss_arrangement (STRING) indicating that underwriting cases with reinsurance coverage reference a specific reinsurance arrangement. Ad',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: Underwriting cases are bound to a plan year for rating period pricing and annual renewal decisions. Linking to plan.year enables year-over-year underwriting trend analysis, prior_year_claims_pmpm comp',
    `age_gender_distribution_index` DECIMAL(18,2) COMMENT 'Statistical index representing the age and gender mix of the applicant population.',
    `applicant_type` STRING COMMENT 'Classification of the applicant as individual, small group, large group, etc.. Valid values are `individual|group|small_group|large_group`',
    `chronic_condition_prevalence_rate` DECIMAL(18,2) COMMENT 'Rate of chronic conditions among the applicant population.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the underwriting case record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for premium amounts.',
    `decision_rationale` STRING COMMENT 'Narrative explanation of the underwriting decision.',
    `decision_timestamp` TIMESTAMP COMMENT 'Date and time when the underwriting decision was rendered.',
    `effective_date` DATE COMMENT 'Date when the underwriting decision becomes effective for coverage.',
    `expected_claims_pmpm` DECIMAL(18,2) COMMENT 'Projected claims cost per member per month for the upcoming period.',
    `gross_premium_amount` DECIMAL(18,2) COMMENT 'Total premium before adjustments.',
    `industry_risk_factor` DECIMAL(18,2) COMMENT 'Adjustment factor based on the applicants industry risk profile.',
    `is_self_insured` BOOLEAN COMMENT 'Indicates whether the applicant is self‑insured (ASO) or fully‑insured.',
    `large_claimant_count` STRING COMMENT 'Number of members with high-cost claims in the group.',
    `lob` STRING COMMENT 'Business line (e.g., medical, dental, vision) to which the underwriting case applies.',
    `medical_underwriting_status` STRING COMMENT 'Result of medical underwriting review.. Valid values are `cleared|pending|exempt|rejected`',
    `morbidity_factor` DECIMAL(18,2) COMMENT 'Factor reflecting expected morbidity based on health status and demographics.',
    `net_premium_amount` DECIMAL(18,2) COMMENT 'Final premium after adjustments.',
    `overall_group_risk_score` DECIMAL(18,2) COMMENT 'Composite risk score derived from all risk factors for the group.',
    `premium_adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of discounts, fees, or other adjustments applied to the gross premium.',
    `premium_rate` DECIMAL(18,2) COMMENT 'Base premium rate applied to the applicant.',
    `premium_rate_type` STRING COMMENT 'Method used to calculate the premium (fixed amount, per member, per employee).. Valid values are `fixed|per_member|per_employee`',
    `prior_year_claims_pmpm` DECIMAL(18,2) COMMENT 'Claims cost per member per month from the prior year.',
    `rate_effective_date` DATE COMMENT 'Date when the premium rate becomes effective.',
    `rate_expiration_date` DATE COMMENT 'Date when the premium rate expires (null for open‑ended).',
    `rating_period` STRING COMMENT 'Period (e.g., FY2024) used for rating calculations.',
    `reinsurance_flag` BOOLEAN COMMENT 'True if the case includes reinsurance or stop‑loss pricing.',
    `review_deadline` DATE COMMENT 'Date by which the underwriting case must be reviewed or decided.',
    `risk_classification` STRING COMMENT 'Overall risk classification assigned to the applicant.. Valid values are `low|medium|high|very_high`',
    `risk_underwriting_case_status` STRING COMMENT 'Current lifecycle status of the underwriting case.. Valid values are `pending|approved|declined|rated|withdrawn`',
    `submission_date` DATE COMMENT 'Date the underwriting case was submitted to regulators.',
    `total_member_months` STRING COMMENT 'Aggregate member-months for the group applicant during the rating period.',
    `underwriting_case_number` STRING COMMENT 'External case number assigned to the underwriting decision, used for tracking and communication.',
    `underwriting_rule_set` STRING COMMENT 'Identifier of the rule set applied during underwriting.',
    `underwriting_tier` STRING COMMENT 'Tier level used in underwriting risk segmentation.. Valid values are `tier1|tier2|tier3|tier4`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the underwriting case record.',
    CONSTRAINT pk_risk_underwriting_case PRIMARY KEY(`risk_underwriting_case_id`)
) COMMENT 'Represents an underwriting decision record for group or individual market applicants, including the group-level risk profile used in underwriting evaluation and renewal rating. Captures underwriting case number, applicant type (group/individual/small group/large group), LOB, underwriting tier, risk classification, medical underwriting status, final decision (approved/declined/rated), effective date, underwriter ID, decision rationale, and applicable underwriting rules/criteria. For group cases, includes aggregate risk profile: rating period, total member months, age/gender distribution index, morbidity factor, industry risk factor, prior year claims PMPM, expected claims PMPM, large claimant count, chronic condition prevalence rates, and overall group risk score. Supports fully-insured and self-insured (ASO) underwriting workflows, group renewal underwriting, and stop-loss pricing.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` (
    `reinsurance_arrangement_id` BIGINT COMMENT 'System-generated unique identifier for the reinsurance arrangement record.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Reinsurance arrangements are negotiated at the health plan level — a plan cedes premium to a reinsurer for stop-loss protection. Plan-level reinsurance reporting, premium_ceded allocation, and stop-lo',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: Reinsurance treaties require state regulatory filing and approval under insurance codes. Linking each arrangement to its governing regulatory obligation enables compliance tracking of treaty filings, ',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: Reinsurance arrangements are structured per plan year for annual treaty renewal, premium cession calculations, and stop-loss reporting. Linking to plan.year enables year-based reinsurance cost trackin',
    `aggregate_attachment_amount` DECIMAL(18,2) COMMENT 'Monetary threshold for aggregate stop‑loss coverage.',
    `aggregate_attachment_factor` DECIMAL(18,2) COMMENT 'Percentage of aggregate losses that must be reached before the reinsurer pays.',
    `arrangement_number` STRING COMMENT 'External contract number assigned by the insurer or reinsurer to identify the treaty.',
    `attachment_point` DECIMAL(18,2) COMMENT 'Loss amount threshold at which the reinsurer begins to pay.',
    `attachment_point_currency` STRING COMMENT 'ISO 4217 currency code for the attachment point amount.. Valid values are `^[A-Z]{3}$`',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Proportion of losses the reinsurer pays after the attachment point.',
    `corridor_percentage` DECIMAL(18,2) COMMENT 'Percentage range defining the corridor where losses are shared between insurer and reinsurer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reinsurance arrangement record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the reinsurance coverage becomes binding.',
    `effective_until` DATE COMMENT 'Date when the reinsurance coverage terminates; null for open‑ended treaties.',
    `lob_coverage` STRING COMMENT 'Business line(s) to which the reinsurance treaty applies.. Valid values are `medical|dental|vision|pharmacy|hospital|rx`',
    `maximum_liability` DECIMAL(18,2) COMMENT 'Upper limit of the reinsurers liability under the treaty.',
    `maximum_recovery_limit` DECIMAL(18,2) COMMENT 'Cap on the total amount the insurer can recover from the reinsurer.',
    `premium_ceded` DECIMAL(18,2) COMMENT 'Premium amount transferred to the reinsurer for the treaty.',
    `reinsurance_arrangement_status` STRING COMMENT 'Current lifecycle state of the reinsurance treaty.. Valid values are `draft|active|suspended|terminated|expired`',
    `reinsurer_name` STRING COMMENT 'Legal name of the reinsurer party to the arrangement.',
    `specific_deductible` DECIMAL(18,2) COMMENT 'Deductible applied to each individual claim under a specific stop‑loss treaty.',
    `stop_loss_deductible` DECIMAL(18,2) COMMENT 'Deductible applied before stop‑loss coverage becomes payable.',
    `stop_loss_limit` DECIMAL(18,2) COMMENT 'Maximum amount the reinsurer will pay under the stop‑loss arrangement.',
    `stop_loss_threshold` DECIMAL(18,2) COMMENT 'Loss amount that triggers stop‑loss coverage.',
    `stop_loss_type` STRING COMMENT 'Indicates whether the stop‑loss is specific per‑member or aggregate across a group.. Valid values are `specific|aggregate`',
    `treaty_terms` STRING COMMENT 'Narrative description of the treatys contractual terms and conditions.',
    `treaty_type` STRING COMMENT 'Type of reinsurance treaty governing the risk transfer.. Valid values are `quota_share|excess_of_loss|aggregate_stop_loss|specific_stop_loss`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reinsurance arrangement record.',
    CONSTRAINT pk_reinsurance_arrangement PRIMARY KEY(`reinsurance_arrangement_id`)
) COMMENT 'Master record for reinsurance and stop-loss arrangements protecting the health plan against catastrophic or excess losses. Captures treaty type (quota share, excess of loss, aggregate stop-loss, specific stop-loss), reinsurer name, attachment point, specific deductible amount, aggregate attachment factor and amount, corridor percentage, maximum liability, coinsurance percentage, maximum recovery limit, premium ceded, effective and expiration dates, LOB coverage, and treaty terms. Includes stop-loss threshold parameters for self-insured employer groups. Supports both individual specific stop-loss and aggregate stop-loss for self-insured groups.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` (
    `reinsurance_claim_id` BIGINT COMMENT 'System-generated unique identifier for the reinsurance claim record.',
    `member_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to member.member_eligibility_span. Business justification: Stop-loss reinsurance recovery requires validating the claims covered period against the members actual eligibility span to verify attachment point thresholds. Domain experts in reinsurance operatio',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the claimant (member or group) for whom the reinsurance claim is filed.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Reinsurance claims are filed against specific policies — the policy defines coverage terms, deductible, and out-of-pocket max used to calculate the attachment point and recoverable amount. Domain expe',
    `reinsurance_arrangement_id` BIGINT COMMENT 'Foreign key linking to risk.reinsurance_arrangement. Business justification: Reinsurance claims belong to a specific reinsurance arrangement; replace free‑text reference with FK.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Stop-loss and reinsurance recovery analysis requires identifying which facility generated the catastrophic cost event. Health plans track facility-level reinsurance claim concentration for network str',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Reinsurance recovery analysis requires identifying which provider generated the catastrophic cost triggering stop-loss. Health plans and reinsurers track treating providers on large claims for network',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Date and time when the reinsurer acknowledged receipt of the claim.',
    `attachment_point_amount` DECIMAL(18,2) COMMENT 'Attachment point amount applied to the loss before reinsurance coverage kicks in.',
    `claim_number` STRING COMMENT 'External claim number assigned by the reinsurer.',
    `claim_status` STRING COMMENT 'Current processing status of the reinsurance claim.. Valid values are `open|closed|cancelled|pending`',
    `claim_type` STRING COMMENT 'Type of reinsurance claim: stop‑loss (aggregate) or specific loss.. Valid values are `stop_loss|specific`',
    `claimant_type` STRING COMMENT 'Indicates whether the claimant is an individual member or an employer group.. Valid values are `member|group`',
    `covered_end_date` DATE COMMENT 'End date of the coverage period for which the loss occurred.',
    `covered_start_date` DATE COMMENT 'Start date of the coverage period for which the loss occurred.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the claim record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for monetary amounts.',
    `is_aggregated` BOOLEAN COMMENT 'Indicates whether this claim aggregates multiple underlying losses (true) or represents a single loss (false).',
    `loss_category` STRING COMMENT 'Category of loss underlying the claim.. Valid values are `medical|dental|vision|pharmacy|hospital|other`',
    `loss_description` STRING COMMENT 'Narrative description of the loss event leading to the reinsurance claim.',
    `notes` STRING COMMENT 'Free‑form notes entered by claims adjusters.',
    `payment_received_timestamp` TIMESTAMP COMMENT 'Date and time when payment was received from the reinsurer.',
    `recoverable_amount` DECIMAL(18,2) COMMENT 'Amount recoverable from the reinsurer after applying attachment point and limits.',
    `recovery_status` STRING COMMENT 'Status of the recovery payment from the reinsurer.. Valid values are `pending|approved|rejected|paid`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Flag indicating if the claim must be reported to regulatory bodies (e.g., CMS).',
    `reporting_period` STRING COMMENT 'Financial reporting period associated with the claim.. Valid values are `Q1|Q2|Q3|Q4|Annual`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the reinsurance claim was submitted to the reinsurer.',
    `total_incurred_amount` DECIMAL(18,2) COMMENT 'Total incurred loss amount before applying reinsurance terms.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the claim record.',
    CONSTRAINT pk_reinsurance_claim PRIMARY KEY(`reinsurance_claim_id`)
) COMMENT 'Transactional record of reinsurance recoveries and stop-loss claims submitted to reinsurers. Captures reinsurance claim number, arrangement reference, claimant (member or group), covered period, total incurred amount, attachment point applied, recoverable amount, submission date, reinsurer acknowledgment, payment received date, and recovery status. Tracks both specific and aggregate stop-loss recovery transactions.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`risk`.`score_hcc_contribution` (
    `score_hcc_contribution_id` BIGINT COMMENT 'Primary key for the risk_score_hcc_contribution association',
    `hcc_mapping_id` BIGINT COMMENT 'Foreign key linking to the specific HCC mapping record (ICD-10 to HCC crosswalk entry) that drives this contribution.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to the member risk score record to which this HCC contributes.',
    `contribution_weight` DECIMAL(18,2) COMMENT 'The weighted coefficient applied to this specific HCC for this member-score combination, reflecting any member-level demographic or plan-type adjustments applied on top of the base HCC coefficient.',
    `effective_date` DATE COMMENT 'The date on which this HCC contribution became effective for the members risk score, typically aligned to the diagnosis encounter date or CMS model effective date.',
    `hcc_codes` STRING COMMENT 'Pipe‑separated list of HCC codes contributing to the score. [Moved from member_risk_score: This pipe-separated multi-value field encodes the M:N relationship between a risk score and its contributing HCC codes in a non-relational format. With the risk_score_hcc_contribution association table in place, each HCC contribution is represented as a discrete row with proper FK linkage, making this denormalized field redundant and structurally incorrect.]',
    `is_primary_hcc` BOOLEAN COMMENT 'Indicates whether this HCC is the dominant driver of the members RAF score for this scoring period. Used in RADV audit defense to identify the highest-impact diagnosis.',
    `score_contribution_amount` DECIMAL(18,2) COMMENT 'The RAF unit amount this HCC contributes to the members total risk score for the payment year. Equals contribution_weight multiplied by applicable adjustment factors.',
    CONSTRAINT pk_score_hcc_contribution PRIMARY KEY(`score_hcc_contribution_id`)
) COMMENT 'This association product represents the actuarial contribution event between a member_risk_score and an hcc_mapping. It captures the per-HCC contribution to a members RAF score for a given payment year and model version, including the weighted coefficient amount, primary HCC designation, and effective period. Each record links one member_risk_score to one hcc_mapping and carries attributes that exist only in the context of this specific contribution — essential for RAPS/EDPS submission accuracy, CMS RADV audit defense, and RAF variance root-cause analysis.. Existence Justification: In Medicare Advantage risk adjustment, a members RAF score is mathematically computed as the sum of coefficients from ALL applicable HCC codes that map to the members diagnoses. A single member_risk_score record aggregates contributions from multiple HCC mappings (e.g., HCC 85 + HCC 96 + HCC 108), and a single HCC mapping (e.g., HCC 85 — Congestive Heart Failure) contributes to the risk scores of every member diagnosed with that condition. This is not an analytical correlation — it is an operationally managed actuarial construct that health plans actively track for RAPS/EDPS submission accuracy, CMS audit defense (RADV), and variance reconciliation. The business explicitly names this concept risk score HCC contribution and tracks per-contribution data (contribution weight, score contribution amount, effective date, primary HCC flag) that belongs to neither the score record nor the HCC mapping alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ADD CONSTRAINT `fk_risk_raps_submission_cms_submission_id` FOREIGN KEY (`cms_submission_id`) REFERENCES `health_insurance_ecm`.`risk`.`cms_submission`(`cms_submission_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ADD CONSTRAINT `fk_risk_risk_underwriting_case_reinsurance_arrangement_id` FOREIGN KEY (`reinsurance_arrangement_id`) REFERENCES `health_insurance_ecm`.`risk`.`reinsurance_arrangement`(`reinsurance_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ADD CONSTRAINT `fk_risk_reinsurance_claim_reinsurance_arrangement_id` FOREIGN KEY (`reinsurance_arrangement_id`) REFERENCES `health_insurance_ecm`.`risk`.`reinsurance_arrangement`(`reinsurance_arrangement_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`score_hcc_contribution` ADD CONSTRAINT `fk_risk_score_hcc_contribution_hcc_mapping_id` FOREIGN KEY (`hcc_mapping_id`) REFERENCES `health_insurance_ecm`.`risk`.`hcc_mapping`(`hcc_mapping_id`);
ALTER TABLE `health_insurance_ecm`.`risk`.`score_hcc_contribution` ADD CONSTRAINT `fk_risk_score_hcc_contribution_member_risk_score_id` FOREIGN KEY (`member_risk_score_id`) REFERENCES `health_insurance_ecm`.`risk`.`member_risk_score`(`member_risk_score_id`);

-- ========= TAGS =========
ALTER SCHEMA `health_insurance_ecm`.`risk` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `health_insurance_ecm`.`risk` SET TAGS ('dbx_domain' = 'risk');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` SET TAGS ('dbx_subdomain' = 'risk_adjustment');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score ID');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `audit_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `member_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Member Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `audit_user` SET TAGS ('dbx_business_glossary_term' = 'Audit User');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `cms_published_score` SET TAGS ('dbx_business_glossary_term' = 'CMS Published RAF Score');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `cms_submission_status` SET TAGS ('dbx_business_glossary_term' = 'CMS Submission Status');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `cms_submission_status` SET TAGS ('dbx_value_regex' = 'submitted|accepted|rejected|pending');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `demographic_factor_score` SET TAGS ('dbx_business_glossary_term' = 'Demographic Factor Score');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `diagnosis_count` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Count');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `diagnosis_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `diagnosis_count` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Score Effective Timestamp');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Score Expiration Date');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `is_manual_override` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Flag');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `manual_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Reason');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `payment_year` SET TAGS ('dbx_business_glossary_term' = 'Payment Year');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `plan_calculated_score` SET TAGS ('dbx_business_glossary_term' = 'Plan Calculated RAF Score');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `resubmission_reference` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Reference');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `risk_adjustment_factor_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor Category');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Code');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Confidence Score');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_label` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Label');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_notes` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Notes');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_source` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Source');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_source` SET TAGS ('dbx_value_regex' = 'encounter|claims|pharmacy|utilization');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Status');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_status` SET TAGS ('dbx_value_regex' = 'pending_review|finalized');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Type (Prospective/Concurrent/Final)');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_type` SET TAGS ('dbx_value_regex' = 'prospective|concurrent|final');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `risk_score_value` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor (RAF) Score Value');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `score_components` SET TAGS ('dbx_business_glossary_term' = 'Score Components Detail');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `score_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Score Effective Date');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `score_variance` SET TAGS ('dbx_business_glossary_term' = 'Score Variance (Plan vs CMS)');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `variance_category` SET TAGS ('dbx_business_glossary_term' = 'Variance Category');
ALTER TABLE `health_insurance_ecm`.`risk`.`member_risk_score` ALTER COLUMN `variance_category` SET TAGS ('dbx_value_regex' = 'missing_diagnoses|hierarchy_diff|demographic|other');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` SET TAGS ('dbx_subdomain' = 'risk_adjustment');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Hcc Mapping Identifier');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `age_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Age Adjustment Factor (AGE_ADJ)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `coefficient` SET TAGS ('dbx_business_glossary_term' = 'HCC Coefficient (COEF)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `demographic_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Demographic Adjustment Factor (DEMOG_ADJ)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `disease_interaction_group` SET TAGS ('dbx_business_glossary_term' = 'Disease Interaction Group (DI_GROUP)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFF_DATE)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXP_DATE)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Gender Adjustment Factor (GENDER_ADJ)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `gender_adjustment_factor` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_code` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category Code (HCC)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_description` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category Description (HCC_DESC)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_mapping_status` SET TAGS ('dbx_business_glossary_term' = 'Mapping Status (STATUS)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `hcc_mapping_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level (HIER_LEVEL)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `icd10_code` SET TAGS ('dbx_business_glossary_term' = 'ICD-10 Diagnosis Code (ICD10)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `icd10_code` SET TAGS ('dbx_value_regex' = '^[A-TV-Z][0-9][0-9A-Z](.[0-9A-Z]{1,4})?$');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `icd10_description` SET TAGS ('dbx_business_glossary_term' = 'ICD-10 Diagnosis Description (ICD10_DESC)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `interaction_flag` SET TAGS ('dbx_business_glossary_term' = 'Disease Interaction Flag (INTERACT_FLAG)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `interaction_flag` SET TAGS ('dbx_value_regex' = 'yes|no');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `is_excluded` SET TAGS ('dbx_business_glossary_term' = 'Is Excluded Flag (EXCLUDED)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `is_mapped` SET TAGS ('dbx_business_glossary_term' = 'Is Mapped Flag (MAPPED)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (REVIEW_DATE)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By (UPDATED_BY)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `mapping_source` SET TAGS ('dbx_business_glossary_term' = 'Mapping Source (MAP_SRC)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `mapping_source` SET TAGS ('dbx_value_regex' = 'CMS|Milliman|Custom');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MODEL_YEAR)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `parent_hcc_code` SET TAGS ('dbx_business_glossary_term' = 'Parent HCC Code (PARENT_HCC)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `plan_type_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Plan Type Adjustment Factor (PLAN_TYPE_ADJ)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `region_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Region Adjustment Factor (REGION_ADJ)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status (REVIEW_STATUS)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `risk_score_weight` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Weight (RS_WEIGHT)');
ALTER TABLE `health_insurance_ecm`.`risk`.`hcc_mapping` ALTER COLUMN `source_version` SET TAGS ('dbx_business_glossary_term' = 'Source Version (SRC_VER)');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` SET TAGS ('dbx_subdomain' = 'risk_adjustment');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `raps_submission_id` SET TAGS ('dbx_business_glossary_term' = 'RAPS Submission Identifier');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `cms_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Cms Submission Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Identifier');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `member_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Member Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `accepted_record_count` SET TAGS ('dbx_business_glossary_term' = 'Accepted Record Count');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `cms_acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'CMS Acknowledgment Status');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `cms_acknowledgment_status` SET TAGS ('dbx_value_regex' = 'received|processed|accepted|rejected');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `error_disposition` SET TAGS ('dbx_business_glossary_term' = 'Error Disposition');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `payment_year` SET TAGS ('dbx_business_glossary_term' = 'Payment Year');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `plan_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Contract Number');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'hmo|ppo|epo|pos|hdhp');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `raps_submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `raps_submission_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|acknowledged|rejected|error');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `rejected_record_count` SET TAGS ('dbx_business_glossary_term' = 'Rejected Record Count');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `risk_adjustment_year` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Year');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RAF)');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'milliman|edi_gateway');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `submission_file_checksum` SET TAGS ('dbx_business_glossary_term' = 'Submission File Checksum');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `submission_file_name` SET TAGS ('dbx_business_glossary_term' = 'Submission File Name');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `submission_user_name` SET TAGS ('dbx_business_glossary_term' = 'Submission User Name');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `submission_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `submission_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `total_record_count` SET TAGS ('dbx_business_glossary_term' = 'Total Record Count');
ALTER TABLE `health_insurance_ecm`.`risk`.`raps_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` SET TAGS ('dbx_subdomain' = 'risk_adjustment');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `cms_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Cms Submission Identifier');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `audit_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `accepted_record_count` SET TAGS ('dbx_business_glossary_term' = 'Accepted Record Count');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `cms_acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'CMS Acknowledgment Status');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `cms_acknowledgment_status` SET TAGS ('dbx_value_regex' = 'received|processed|accepted|rejected|pending');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract / PBP Number');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `encounter_type` SET TAGS ('dbx_business_glossary_term' = 'Encounter Type');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `encounter_type` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|professional|pharmacy|other');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `error_disposition` SET TAGS ('dbx_business_glossary_term' = 'Error Disposition');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `payment_year` SET TAGS ('dbx_business_glossary_term' = 'Payment Year');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `record_count` SET TAGS ('dbx_business_glossary_term' = 'Total Record Count');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `rejected_record_count` SET TAGS ('dbx_business_glossary_term' = 'Rejected Record Count');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor (HCC)');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `risk_adjustment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Score (RAF)');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `service_year` SET TAGS ('dbx_business_glossary_term' = 'Service Year');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `submission_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Batch Identifier');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `submission_checksum` SET TAGS ('dbx_business_glossary_term' = 'Submission Checksum (MD5)');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `submission_comment` SET TAGS ('dbx_business_glossary_term' = 'Submission Comment');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `submission_file_name` SET TAGS ('dbx_business_glossary_term' = 'Submission File Name');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `submission_file_size` SET TAGS ('dbx_business_glossary_term' = 'Submission File Size (bytes)');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `submission_source_system` SET TAGS ('dbx_business_glossary_term' = 'Submission Source System');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|accepted|rejected|error');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type (RAPS/EDPS)');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = 'RAPS|EDPS');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `submission_user_role` SET TAGS ('dbx_business_glossary_term' = 'Submission User Role');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `total_claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Claim Amount');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `transition_flag` SET TAGS ('dbx_business_glossary_term' = 'RAPS-to-EDPS Transition Flag');
ALTER TABLE `health_insurance_ecm`.`risk`.`cms_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` SET TAGS ('dbx_subdomain' = 'underwriting_reinsurance');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `risk_underwriting_case_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Underwriting Case ID');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `employer_underwriting_case_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Underwriting Case Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Identifier');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `reinsurance_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `age_gender_distribution_index` SET TAGS ('dbx_business_glossary_term' = 'Age/Gender Distribution Index');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `age_gender_distribution_index` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `age_gender_distribution_index` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `applicant_type` SET TAGS ('dbx_business_glossary_term' = 'Applicant Type');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `applicant_type` SET TAGS ('dbx_value_regex' = 'individual|group|small_group|large_group');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `chronic_condition_prevalence_rate` SET TAGS ('dbx_business_glossary_term' = 'Chronic Condition Prevalence Rate');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `expected_claims_pmpm` SET TAGS ('dbx_business_glossary_term' = 'Expected Claims PMPM');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `gross_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Premium Amount');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `industry_risk_factor` SET TAGS ('dbx_business_glossary_term' = 'Industry Risk Factor');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `is_self_insured` SET TAGS ('dbx_business_glossary_term' = 'Self-Insured Flag');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `large_claimant_count` SET TAGS ('dbx_business_glossary_term' = 'Large Claimant Count');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `medical_underwriting_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Underwriting Status');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `medical_underwriting_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|exempt|rejected');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `medical_underwriting_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `medical_underwriting_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `morbidity_factor` SET TAGS ('dbx_business_glossary_term' = 'Morbidity Factor');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `net_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Premium Amount');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `overall_group_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Group Risk Score');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `premium_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Adjustment Amount');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `premium_rate` SET TAGS ('dbx_business_glossary_term' = 'Premium Rate');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `premium_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Premium Rate Type');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `premium_rate_type` SET TAGS ('dbx_value_regex' = 'fixed|per_member|per_employee');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `prior_year_claims_pmpm` SET TAGS ('dbx_business_glossary_term' = 'Prior Year Claims PMPM');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `rate_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Effective Date');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `rate_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Expiration Date');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `rating_period` SET TAGS ('dbx_business_glossary_term' = 'Rating Period');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `reinsurance_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Flag');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `review_deadline` SET TAGS ('dbx_business_glossary_term' = 'Review Deadline');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Risk Classification');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `risk_classification` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `risk_underwriting_case_status` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Case Status');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `risk_underwriting_case_status` SET TAGS ('dbx_value_regex' = 'pending|approved|declined|rated|withdrawn');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `total_member_months` SET TAGS ('dbx_business_glossary_term' = 'Total Member Months');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `underwriting_case_number` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Case Number (UCN)');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `underwriting_rule_set` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Rule Set');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `underwriting_tier` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Tier');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `underwriting_tier` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4');
ALTER TABLE `health_insurance_ecm`.`risk`.`risk_underwriting_case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` SET TAGS ('dbx_subdomain' = 'underwriting_reinsurance');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `reinsurance_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Arrangement Identifier (RA_ID)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `aggregate_attachment_amount` SET TAGS ('dbx_business_glossary_term' = 'Aggregate Attachment Amount (AGG_ATTACH_AMT)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `aggregate_attachment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `aggregate_attachment_factor` SET TAGS ('dbx_business_glossary_term' = 'Aggregate Attachment Factor Percentage (AGG_ATTACH_FACTOR)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `aggregate_attachment_factor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Arrangement Number (RA_NUM)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `attachment_point` SET TAGS ('dbx_business_glossary_term' = 'Attachment Point Amount (ATTACHMENT_POINT)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `attachment_point` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `attachment_point_currency` SET TAGS ('dbx_business_glossary_term' = 'Attachment Point Currency Code (ATTACHMENT_CURR)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `attachment_point_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage (COINSURANCE_PCT)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `corridor_percentage` SET TAGS ('dbx_business_glossary_term' = 'Corridor Percentage (CORRIDOR_PCT)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `corridor_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFF_FROM)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXPIRY_DATE)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `lob_coverage` SET TAGS ('dbx_business_glossary_term' = 'Line of Business Coverage (LOB_COVERAGE)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `lob_coverage` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|pharmacy|hospital|rx');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `maximum_liability` SET TAGS ('dbx_business_glossary_term' = 'Maximum Liability Amount (MAX_LIAB)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `maximum_liability` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `maximum_recovery_limit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Recovery Limit (MAX_RECOVERY)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `maximum_recovery_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `premium_ceded` SET TAGS ('dbx_business_glossary_term' = 'Ceded Premium Amount (PREMIUM_CED)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `premium_ceded` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `reinsurance_arrangement_status` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Arrangement Status (STATUS)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `reinsurance_arrangement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `reinsurer_name` SET TAGS ('dbx_business_glossary_term' = 'Reinsurer Name (REINSURER_NAME)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `reinsurer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `specific_deductible` SET TAGS ('dbx_business_glossary_term' = 'Specific Deductible Amount (SPEC_DED)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `specific_deductible` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `stop_loss_deductible` SET TAGS ('dbx_business_glossary_term' = 'Stop‑Loss Deductible Amount (STOP_LOSS_DED)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `stop_loss_deductible` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `stop_loss_limit` SET TAGS ('dbx_business_glossary_term' = 'Stop‑Loss Limit Amount (STOP_LOSS_LIMIT)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `stop_loss_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `stop_loss_threshold` SET TAGS ('dbx_business_glossary_term' = 'Stop‑Loss Threshold Amount (STOP_LOSS_THRESHOLD)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `stop_loss_threshold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `stop_loss_type` SET TAGS ('dbx_business_glossary_term' = 'Stop‑Loss Type (STOP_LOSS_TYPE)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `stop_loss_type` SET TAGS ('dbx_value_regex' = 'specific|aggregate');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `treaty_terms` SET TAGS ('dbx_business_glossary_term' = 'Treaty Terms Description (TREATY_TERMS)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `treaty_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `treaty_type` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Treaty Type (TREATY_TYPE)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `treaty_type` SET TAGS ('dbx_value_regex' = 'quota_share|excess_of_loss|aggregate_stop_loss|specific_stop_loss');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_arrangement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` SET TAGS ('dbx_subdomain' = 'underwriting_reinsurance');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `reinsurance_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Claim ID');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `member_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Member Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Claimant Identifier (CLAIMANT_ID)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `reinsurance_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Treating Facility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Treating Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Timestamp (ACKNOWLEDGMENT_TS)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `attachment_point_amount` SET TAGS ('dbx_business_glossary_term' = 'Attachment Point Amount (ATTACHMENT_POINT)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Claim Number (CLAIM_NUMBER)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status (CLAIM_STATUS)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_value_regex' = 'open|closed|cancelled|pending');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type (CLAIM_TYPE)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'stop_loss|specific');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `claimant_type` SET TAGS ('dbx_business_glossary_term' = 'Claimant Type (CLAIMANT_TYPE)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `claimant_type` SET TAGS ('dbx_value_regex' = 'member|group');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `covered_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date (COVERED_END_DATE)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `covered_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date (COVERED_START_DATE)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CREATED_TS)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURRENCY_CODE)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `is_aggregated` SET TAGS ('dbx_business_glossary_term' = 'Is Aggregated (IS_AGGREGATED)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `loss_category` SET TAGS ('dbx_business_glossary_term' = 'Loss Category (LOSS_CATEGORY)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `loss_category` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|pharmacy|hospital|other');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `loss_description` SET TAGS ('dbx_business_glossary_term' = 'Loss Description (LOSS_DESCRIPTION)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adjuster Notes (NOTES)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `payment_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Timestamp (PAYMENT_RECEIVED_TS)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `recoverable_amount` SET TAGS ('dbx_business_glossary_term' = 'Recoverable Amount (RECOVERABLE_AMOUNT)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `recovery_status` SET TAGS ('dbx_business_glossary_term' = 'Recovery Status (RECOVERY_STATUS)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `recovery_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|paid');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag (REGULATORY_REPORTING)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period (REPORTING_PERIOD)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `reporting_period` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4|Annual');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp (SUBMISSION_TS)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `total_incurred_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Incurred Amount (TOTAL_INCURRED)');
ALTER TABLE `health_insurance_ecm`.`risk`.`reinsurance_claim` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UPDATED_TS)');
ALTER TABLE `health_insurance_ecm`.`risk`.`score_hcc_contribution` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `health_insurance_ecm`.`risk`.`score_hcc_contribution` SET TAGS ('dbx_subdomain' = 'risk_adjustment');
ALTER TABLE `health_insurance_ecm`.`risk`.`score_hcc_contribution` SET TAGS ('dbx_association_edges' = 'risk.member_risk_score,risk.hcc_mapping');
ALTER TABLE `health_insurance_ecm`.`risk`.`score_hcc_contribution` ALTER COLUMN `score_hcc_contribution_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Hcc Contribution - Risk Score Hcc Contribution Id');
ALTER TABLE `health_insurance_ecm`.`risk`.`score_hcc_contribution` ALTER COLUMN `hcc_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Hcc Contribution - Hcc Mapping Id');
ALTER TABLE `health_insurance_ecm`.`risk`.`score_hcc_contribution` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Hcc Contribution - Member Risk Score Id');
ALTER TABLE `health_insurance_ecm`.`risk`.`score_hcc_contribution` ALTER COLUMN `contribution_weight` SET TAGS ('dbx_business_glossary_term' = 'HCC Contribution Weight');
ALTER TABLE `health_insurance_ecm`.`risk`.`score_hcc_contribution` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contribution Effective Date');
ALTER TABLE `health_insurance_ecm`.`risk`.`score_hcc_contribution` ALTER COLUMN `hcc_codes` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category (HCC) Codes');
ALTER TABLE `health_insurance_ecm`.`risk`.`score_hcc_contribution` ALTER COLUMN `is_primary_hcc` SET TAGS ('dbx_business_glossary_term' = 'Primary HCC Flag');
ALTER TABLE `health_insurance_ecm`.`risk`.`score_hcc_contribution` ALTER COLUMN `score_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Score Contribution Amount');
