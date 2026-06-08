-- Schema for Domain: actuarial | Business: Life Insurance | Version: v1_ecm
-- Generated on: 2026-05-04 03:46:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `life_insurance_ecm`.`actuarial` COMMENT 'Owns all actuarial valuation, reserving, and experience study data. Manages GAAP/SAP/IFRS reserve calculations, PBR (Principle-Based Reserving) per VM-20, cash flow projections, mortality and lapse assumption tables, DAC amortization schedules, LDTI transition adjustments, ALM analysis, and ORSA inputs. Supports Prophet/AXIS/MoSes model outputs, EOY/BOY reserve snapshots, pricing, product development, and ERM frameworks.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` (
    `reserve_calculation_id` BIGINT COMMENT 'Unique identifier for the reserve calculation record. Primary key for this entity.',
    `annuity_contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: Statutory and GAAP reserves are calculated at the individual annuity contract level. Essential for financial reporting, regulatory filings (Annual Statement), PBR compliance, and reconciliation of agg',
    `assumption_set_id` BIGINT COMMENT 'Reference to the actuarial assumption set (mortality, lapse, expense, interest) applied in this reserve calculation.',
    `cohort_definition_id` BIGINT COMMENT 'Reference to the policy cohort definition used for grouped reserve calculations. Cohorts typically group policies by issue year, product type, and underwriting class.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the individual policy or contract for which reserves are calculated. May be null for cohort-level or model-segment-level calculations.',
    `insured_id` BIGINT COMMENT 'Foreign key linking to policyholder.insured. Business justification: Reserve calculations require individual insured characteristics (issue age, attained age, gender, tobacco status, risk class) for accurate mortality and lapse assumptions. Actuaries calculate reserves',
    `liability_segment_id` BIGINT COMMENT 'Foreign key linking to actuarial.liability_segment. Business justification: Reserve calculations are performed and reported by liability segment in actuarial practice. The liability_segment table contains the authoritative segment definitions including reserve methodology, re',
    `pbr_model_segment_id` BIGINT COMMENT 'Reference to the PBR model segment used for VM-20 deterministic and stochastic reserve calculations. Segments group policies by similar risk characteristics.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Reserve calculations require direct product plan reference for applying product-specific reserve basis rules (statutory/GAAP/IFRS17), PBR model segment assignment, and assumption set selection. Critic',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Reserve calculations are performed for specific reporting periods (quarterly/annual statutory filings). The valuation_date and reporting_basis already exist but report_period_id provides the formal li',
    `sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: Reserve calculations are subject to SOX controls for financial statement accuracy (existence, valuation assertions). Key control for reserve adequacy testing. Links actuarial calculation to SOX contro',
    `valuation_run_id` BIGINT COMMENT 'Reference to the parent actuarial valuation run that produced this reserve calculation. Links to the valuation cycle execution (e.g., Q4 2023 year-end valuation).',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Reserve calculations use vendor-provided actuarial software or outsourced calculation services (TPA arrangements). Links calculation to vendor system/service for audit trail, vendor performance monito',
    `actuary_name` STRING COMMENT 'The name of the qualified actuary responsible for this reserve calculation. Required for statutory opinion and regulatory compliance.',
    `assumption_unlock_amount` DECIMAL(18,2) COMMENT 'The change in reserves due to updates or unlocking of actuarial assumptions (mortality, lapse, expense, interest). Required under LDTI for GAAP reporting.',
    `boy_reserve_amount` DECIMAL(18,2) COMMENT 'The reserve balance at the beginning of the valuation period (typically January 1 for annual valuations). Used for reserve rollforward analysis.',
    `calculation_method` STRING COMMENT 'The actuarial method or formula used for this reserve calculation (e.g., Commissioners Reserve Valuation Method, Gross Premium Valuation, Seriatim Projection, Model Office). Free-text field for method documentation.',
    `calculation_status` STRING COMMENT 'The current status of this reserve calculation in the valuation workflow. Tracks progression from draft through final approval.. Valid values are `draft|preliminary|final|approved|superseded`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this reserve calculation record was first created in the system. Audit trail field.',
    `cte_level` DECIMAL(18,2) COMMENT 'The CTE confidence level used for stochastic reserve calculations under VM-20 (e.g., 70 for CTE70, 98 for CTE98). Represents the average of the worst X% of scenarios.',
    `deterministic_reserve_amount` DECIMAL(18,2) COMMENT 'The deterministic reserve calculated under VM-20 using prescribed scenarios. One of the three components (DR, SR, NPR) used to determine the final PBR reserve.',
    `discount_rate` DECIMAL(18,2) COMMENT 'The interest rate used to discount future cash flows in the reserve calculation. May be a statutory rate, GAAP upper-medium grade rate, or IFRS discount curve rate depending on reporting basis.',
    `eoy_reserve_amount` DECIMAL(18,2) COMMENT 'The reserve balance at the end of the valuation period (typically December 31 for annual valuations). Represents the closing liability position.',
    `expense_assumption_amount` DECIMAL(18,2) COMMENT 'The per-policy or per-unit expense assumption used in the reserve calculation. Includes maintenance expenses and overhead allocation.',
    `experience_variance_amount` DECIMAL(18,2) COMMENT 'The change in reserves due to actual experience differing from expected (e.g., actual mortality vs. expected mortality). Component of reserve variance analysis.',
    `interest_accretion_amount` DECIMAL(18,2) COMMENT 'The increase in reserves due to interest accretion at the valuation interest rate during the period. Component of the reserve rollforward.',
    `lapse_assumption_rate` DECIMAL(18,2) COMMENT 'The annual lapse rate assumption applied in the reserve calculation. Expressed as a decimal (e.g., 0.05 for 5% lapse rate).',
    `model_change_amount` DECIMAL(18,2) COMMENT 'The change in reserves due to changes in the actuarial valuation model, methodology, or system (e.g., migration from AXIS to Prophet). Tracked separately for audit and reconciliation.',
    `model_version` STRING COMMENT 'The version identifier of the actuarial model used for this calculation. Critical for model governance, reproducibility, and audit.',
    `mortality_assumption_table` STRING COMMENT 'The mortality table used in the reserve calculation (e.g., 2017 CSO, 2001 VBT, company-specific experience table). Key assumption for life insurance reserves.',
    `net_amount_at_risk` DECIMAL(18,2) COMMENT 'The net amount at risk, calculated as death benefit minus account value or reserve. Represents the insurers exposure to mortality risk.',
    `net_premium_reserve_amount` DECIMAL(18,2) COMMENT 'The net premium reserve calculated using traditional actuarial methods. One of the three components (DR, SR, NPR) used to determine the final PBR reserve, and serves as the floor.',
    `new_business_reserve_change` DECIMAL(18,2) COMMENT 'The change in reserves attributable to new business issued during the valuation period. Component of the reserve rollforward.',
    `notes` STRING COMMENT 'Free-text field for actuarial notes, assumptions, methodology details, or special considerations for this reserve calculation. Used for documentation and audit trail.',
    `pbr_floor_applied_flag` BOOLEAN COMMENT 'Indicates whether the NPR floor was applied in the final PBR reserve calculation. True if the NPR exceeded the greater of DR and SR.',
    `reinsurance_ceded_reserve` DECIMAL(18,2) COMMENT 'The portion of the reserve that has been ceded to reinsurers under reinsurance treaties. Reduces the net reserve liability for the direct writer.',
    `reinsurance_recoverable_amount` DECIMAL(18,2) COMMENT 'The amount recoverable from reinsurers for this reserve. Represents an asset on the balance sheet offsetting the gross reserve liability.',
    `reporting_basis` STRING COMMENT 'The accounting or regulatory basis under which this reserve is calculated: GAAP (Generally Accepted Accounting Principles), SAP (Statutory Accounting Principles), IFRS 17 (International Financial Reporting Standards), PBR (Principle-Based Reserving per VM-20), or Tax basis.. Valid values are `GAAP|SAP|IFRS17|PBR|Tax`',
    `reserve_amount` DECIMAL(18,2) COMMENT 'The calculated reserve amount in the reporting currency. This is the primary liability value for the policy, cohort, or model segment as of the valuation date.',
    `reserve_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the reserve amount (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `reserve_per_unit` DECIMAL(18,2) COMMENT 'The reserve amount per unit of coverage (e.g., per $1,000 of face amount). Used for cohort-level and model-segment-level calculations.',
    `reserve_type` STRING COMMENT 'The specific type of reserve calculated: NPR (Net Premium Reserve), GPR (Gross Premium Reserve), IBNR (Incurred But Not Reported), DR (Deterministic Reserve per VM-20), SR (Stochastic Reserve per VM-20), LFPB (Liability for Future Policy Benefits under LDTI), CSV (Cash Surrender Value), DAC (Deferred Acquisition Cost), PVFB (Present Value of Future Benefits). [ENUM-REF-CANDIDATE: NPR|GPR|IBNR|DR|SR|LFPB|CSV|DAC|PVFB — 9 candidates stripped; promote to reference product]',
    `review_date` DATE COMMENT 'The date this reserve calculation was reviewed and approved by the qualified actuary or peer reviewer.',
    `stochastic_reserve_amount` DECIMAL(18,2) COMMENT 'The stochastic reserve calculated under VM-20 using CTE methodology. One of the three components (DR, SR, NPR) used to determine the final PBR reserve.',
    `stochastic_scenario_count` STRING COMMENT 'The number of stochastic scenarios run for VM-20 stochastic reserve (SR) calculations. Typically 1,000 to 10,000 scenarios depending on model complexity.',
    `termination_reserve_change` DECIMAL(18,2) COMMENT 'The change in reserves due to policy terminations (deaths, lapses, surrenders, maturities) during the valuation period. Typically a negative value.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this reserve calculation record was last modified. Audit trail field for tracking changes.',
    `valuation_date` DATE COMMENT 'The as-of date for this reserve calculation. Typically end-of-year (EOY) or end-of-quarter (EOQ) for statutory and GAAP reporting.',
    CONSTRAINT pk_reserve_calculation PRIMARY KEY(`reserve_calculation_id`)
) COMMENT 'Core actuarial reserve calculation records capturing GAAP, SAP, and IFRS 17 reserve amounts computed per policy cohort or model segment. Stores net premium reserve (NPR), gross premium reserve (GPR), IBNR, PBR deterministic reserve (DR), stochastic reserve (SR), and LDTI liability for future policy benefits (LFPB). Includes point-in-time snapshot data: BOY and EOY reserve balances, net amount at risk (NAR), reserve per unit, and reserve change components (new business, terminations, interest accretion, assumption unlocking). Each record is linked to a parent valuation_run, assumption_set, cohort_definition, and pbr_model_segment. Sourced from Prophet/AXIS/MoSes valuation runs. Represents the primary output of the actuarial valuation cycle for statutory annual statement, GAAP financial close, and IFRS 17 reporting.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` (
    `valuation_run_id` BIGINT COMMENT 'Unique identifier for each actuarial valuation model execution. Primary key for the valuation run record.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Valuation runs generate actuarial opinions, reserve certifications, and regulatory memoranda required for statutory filings and regulatory examinations. The signed opinion document is the primary deli',
    `assumption_set_id` BIGINT COMMENT 'Reference to the specific set of actuarial assumptions (mortality, lapse, expense, interest rates) applied in this valuation run.',
    `employee_id` BIGINT COMMENT 'User identifier of the actuary or system account that initiated the valuation run.',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Valuation runs produce reserve data for specific reporting periods. This is the primary bridge between actuarial calculations and statutory/GAAP reporting. Every valuation run targets a specific repor',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Actuarial valuation systems (AXIS, Prophet, MG-ALFA) are vendor-provided platforms. Links valuation run to vendor for contract management, system upgrade planning, vendor performance monitoring, and l',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the valuation run results were formally approved by the appointed actuary.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this valuation run to detailed audit logs, change control records, and regulatory filing documentation.',
    `comments` STRING COMMENT 'Free-text field for actuaries to document special considerations, assumption changes, methodology adjustments, or other relevant notes about this valuation run.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this valuation run record was first created in the actuarial data warehouse.',
    `dac_balance` DECIMAL(18,2) COMMENT 'Total Deferred Acquisition Cost asset balance calculated in this valuation run, representing unamortized acquisition expenses under GAAP.',
    `data_extract_date` DATE COMMENT 'The date when in-force policy data was extracted from the policy administration system for use in this valuation run.',
    `data_source_system` STRING COMMENT 'The policy administration or data warehouse system from which in-force policy data was sourced (e.g., FAST, Sapiens LifePro, Oracle OIPA, Enterprise Data Lake).',
    `discount_rate_method` STRING COMMENT 'The method used to determine discount rates for present value calculations (e.g., Net Portfolio Rate, Risk-Free Rate + Spread, Prescribed Statutory Rate).',
    `error_log_summary` STRING COMMENT 'Summary of errors, warnings, or data quality issues encountered during the valuation run execution, used for troubleshooting and audit trails.',
    `in_force_policy_count` BIGINT COMMENT 'Total number of in-force policies included in the valuation run as of the valuation date.',
    `ldti_compliant_flag` BOOLEAN COMMENT 'Indicates whether this GAAP valuation run follows the Long Duration Targeted Improvements standard (ASU 2018-12) effective for fiscal years beginning after December 15, 2022.',
    `model_version` STRING COMMENT 'Version identifier of the actuarial model used for this run, enabling traceability and reproducibility of valuation results.',
    `mortality_table` STRING COMMENT 'The mortality table applied in this valuation (e.g., 2017 CSO, 2012 IAM Basic, company-specific experience table).',
    `output_file_path` STRING COMMENT 'File system or cloud storage path where detailed valuation output files (cash flows, seriatim results, summary reports) are stored.',
    `pbr_compliant_flag` BOOLEAN COMMENT 'Indicates whether this valuation run follows Principle-Based Reserving methodology per NAIC Valuation Manual VM-20 and VM-21 (True) or uses formula-based reserves (False).',
    `reconciliation_status` STRING COMMENT 'Status of the reconciliation process between valuation results and general ledger or prior period reserves.. Valid values are `Not Started|In Progress|Reconciled|Variance Identified|Approved`',
    `reinsurance_included_flag` BOOLEAN COMMENT 'Indicates whether reinsurance ceded and assumed treaties are reflected in the reserve calculations (True) or if this is a gross reserve run (False).',
    `run_duration_minutes` STRING COMMENT 'Total elapsed time in minutes for the valuation model execution, used for performance monitoring and capacity planning.',
    `run_end_timestamp` TIMESTAMP COMMENT 'Date and time when the valuation model execution completed (successfully or with errors).',
    `run_name` STRING COMMENT 'Descriptive name assigned to the valuation run for identification purposes, often including valuation basis and period (e.g., Q4 2023 GAAP Statutory Reserve Calculation).',
    `run_number` STRING COMMENT 'Business-facing identifier for the valuation run, typically formatted as YYYY-MM-RUN### for external reference and audit trails.',
    `run_start_timestamp` TIMESTAMP COMMENT 'Date and time when the valuation model execution was initiated.',
    `run_status` STRING COMMENT 'Current execution and approval status of the valuation run in its lifecycle. [ENUM-REF-CANDIDATE: Initiated|Running|Completed|Failed|Cancelled|Under Review|Approved — 7 candidates stripped; promote to reference product]',
    `run_type` STRING COMMENT 'Classification of the valuation run purpose: Production (official reserves), Test (validation), Pricing (product development), Sensitivity (scenario analysis), Experience Study (assumption review), or Ad Hoc (special analysis).. Valid values are `Production|Test|Pricing|Sensitivity|Experience Study|Ad Hoc`',
    `scenario_count` STRING COMMENT 'Number of stochastic economic scenarios executed in this valuation run for PBR or IFRS calculations (typically 1 for deterministic, 1000+ for stochastic).',
    `total_account_value` DECIMAL(18,2) COMMENT 'Aggregate account value across all universal life and annuity contracts included in the valuation, representing policyholder fund balances.',
    `total_face_amount` DECIMAL(18,2) COMMENT 'Aggregate death benefit face amount across all policies included in the valuation, expressed in the reporting currency.',
    `total_reserve_amount` DECIMAL(18,2) COMMENT 'Aggregate reserve liability calculated by this valuation run, representing the present value of future policy benefits and expenses.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this valuation run record was last modified, supporting audit trails and data lineage.',
    `valuation_basis` STRING COMMENT 'The accounting or regulatory framework under which reserves are calculated: Generally Accepted Accounting Principles (GAAP), Statutory Accounting Principles (SAP), International Financial Reporting Standards (IFRS), Tax basis, Principle-Based Reserving (PBR), or Embedded Value.. Valid values are `GAAP|SAP|IFRS|Tax|PBR|Embedded Value`',
    `valuation_date` DATE COMMENT 'The financial reporting date for which reserves and liabilities are being calculated (e.g., December 31, 2023 for year-end valuation).',
    `valuation_period_type` STRING COMMENT 'The reporting period classification: Beginning of Year (BOY), End of Year (EOY), Quarterly, Monthly, or Interim valuation snapshot.. Valid values are `BOY|EOY|Quarterly|Monthly|Interim`',
    `variance_from_prior_period` DECIMAL(18,2) COMMENT 'The change in total reserve amount compared to the previous valuation period, used for reserve movement analysis and financial reporting.',
    `voba_balance` DECIMAL(18,2) COMMENT 'Total Value of Business Acquired intangible asset balance for acquired blocks of business, amortized over the life of the policies.',
    CONSTRAINT pk_valuation_run PRIMARY KEY(`valuation_run_id`)
) COMMENT 'Master record for each actuarial valuation model execution in Prophet, AXIS, or MoSes. Captures run date, valuation basis (BOY/EOY/interim), model version, assumption set used, run type (production/test/pricing), and completion status. Serves as the parent record linking all reserve calculations, cash flow projections, and experience study outputs to a specific model run.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` (
    `assumption_set_id` BIGINT COMMENT 'Unique identifier for the actuarial assumption set. Primary key.',
    `experience_study_id` BIGINT COMMENT 'Reference to the experience study from which this assumption set was derived or updated. Null if not based on a formal experience study.',
    `parent_assumption_set_id` BIGINT COMMENT 'Reference to the prior version or parent assumption set from which this set was derived. Null if this is the initial version.',
    `employee_id` BIGINT COMMENT 'Identifier of the appointed actuary or actuarial officer who approved this assumption set for use.',
    `regulatory_change_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_change. Business justification: Regulatory changes (VM-20 amendments, LDTI adoption, IFRS 17 implementation) trigger assumption set updates. Actuaries must revise assumptions to comply with new regulatory requirements. Tracks regula',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Assumption sets are locked to reporting periods for audit trail and consistency. Regulators require documentation of which assumptions were used for each reporting period. The valuation_date exists bu',
    `tertiary_assumption_last_modified_by_user_employee_id` BIGINT COMMENT 'User ID or employee ID of the actuary or analyst who last modified this assumption set record.',
    `approval_date` DATE COMMENT 'The date on which the assumption set was formally approved by the appointed actuary or governance committee.',
    `assumption_basis` STRING COMMENT 'The basis or philosophy underlying the assumption set: best estimate (unbiased), prudent estimate (conservative), prescribed (regulatory mandate), pricing (product development), experience adjusted (updated from studies), or regulatory minimum.. Valid values are `best_estimate|prudent_estimate|prescribed|pricing|experience_adjusted|regulatory_minimum`',
    `assumption_set_description` STRING COMMENT 'Detailed narrative description of the assumption set, including its purpose, key assumptions, data sources, and any special considerations or limitations.',
    `assumption_set_status` STRING COMMENT 'Current lifecycle status of the assumption set: draft (in development), under review (pending approval), approved (ready for use), active (currently in use), superseded (replaced by newer set), or archived (historical reference only).. Valid values are `draft|under_review|approved|active|superseded|archived`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this assumption set record was first created in the system.',
    `credibility_factor` DECIMAL(18,2) COMMENT 'Statistical credibility factor (0.00 to 1.00) applied to experience data when blending company-specific experience with industry tables. 1.00 indicates full credibility; lower values indicate partial credibility requiring industry benchmarks.',
    `data_source_reference` STRING COMMENT 'Reference to the data sources used to calibrate this assumption set (e.g., Company Experience 2020-2023, SOA 2017 CSO, Industry Benchmark Study Q3 2023).',
    `documentation_url` STRING COMMENT 'URL or file path to the detailed actuarial memorandum, assumption documentation, or supporting materials for this assumption set.',
    `effective_date` DATE COMMENT 'The date from which this assumption set becomes effective for use in actuarial calculations and models.',
    `expense_assumption_reference` STRING COMMENT 'Reference to the expense assumptions used in this set (e.g., Unit Expense Study 2023, Per-Policy Maintenance $50, Acquisition 100% of Premium). Links to detailed expense assumption records.',
    `expense_loading_pct` DECIMAL(18,2) COMMENT 'Percentage loading for expenses (acquisition, maintenance, overhead) applied in pricing or valuation calculations. Expressed as a percentage of premium or account value.',
    `expiration_date` DATE COMMENT 'The date on which this assumption set ceases to be valid for new calculations. Null if the set remains open-ended until superseded.',
    `interest_rate_scenario` STRING COMMENT 'Description of the interest rate scenario or yield curve used in this assumption set (e.g., Deterministic Base Scenario, Stochastic Mean, Rising Rate Scenario, NAIC Prescribed Curve). Links to detailed interest rate assumption records.',
    `investment_return_assumption_pct` DECIMAL(18,2) COMMENT 'Assumed annual investment return rate (net of investment expenses) used in cash flow projections and present value calculations for this assumption set.',
    `lapse_assumption_reference` STRING COMMENT 'Reference to the lapse rate assumptions used in this set (e.g., Dynamic Lapse Model 2024, Flat 5% Annual, Experience Study Q4 2023). Links to detailed lapse assumption records.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this assumption set record was last modified or updated.',
    `model_platform` STRING COMMENT 'The actuarial modeling platform or system in which this assumption set is used (e.g., Prophet, MoSes, AXIS, GGY, Polysystems, Excel, Custom in-house system). [ENUM-REF-CANDIDATE: Prophet|MoSes|AXIS|GGY|Polysystems|Excel|Custom — 7 candidates stripped; promote to reference product]',
    `morbidity_assumption_reference` STRING COMMENT 'Reference to morbidity (disability, critical illness, LTC) assumptions used in this set. Applicable for products with living benefits or health riders. Null if not applicable.',
    `mortality_table_reference` STRING COMMENT 'Reference to the base mortality table used in this assumption set (e.g., 2017 CSO, 2012 IAM, VBT 2015, Company Experience Table 2023). Links to detailed mortality assumption records.',
    `nbv_target_amount` DECIMAL(18,2) COMMENT 'Target new business value (present value of future profits) for pricing-purpose assumption sets. Used in product profitability analysis. Null for non-pricing sets.',
    `peer_review_completed_flag` BOOLEAN COMMENT 'Indicates whether this assumption set has undergone peer review by a second qualified actuary (True) or not (False). Required for certain regulatory filings.',
    `peer_review_date` DATE COMMENT 'The date on which peer review of this assumption set was completed. Null if peer review has not been performed.',
    `product_applicability` STRING COMMENT 'Comma-separated list or description of product lines, product codes, or product families to which this assumption set applies (e.g., Term Life, UL, IUL, SPIA, All Annuities). May reference product_id or product_code in related systems.',
    `profit_margin_target_pct` DECIMAL(18,2) COMMENT 'Target profit margin percentage for pricing-purpose assumption sets, expressed as a percentage of premium or account value. Used in product development and rate setting. Null for non-pricing sets.',
    `regulatory_basis` STRING COMMENT 'The regulatory or accounting framework this assumption set supports: GAAP (Generally Accepted Accounting Principles), SAP (Statutory Accounting Principles), IFRS (International Financial Reporting Standards), PBR (Principle-Based Reserving), VM-20, LDTI (Long Duration Targeted Improvements), or tax reserve calculations. [ENUM-REF-CANDIDATE: GAAP|SAP|IFRS|PBR|VM20|LDTI|tax_reserve — 7 candidates stripped; promote to reference product]',
    `reinsurance_assumption_flag` BOOLEAN COMMENT 'Indicates whether this assumption set includes reinsurance cession assumptions (True) or is on a gross basis (False). Used to distinguish gross vs. net reserve calculations.',
    `roi_target_pct` DECIMAL(18,2) COMMENT 'Target return on investment percentage for pricing-purpose assumption sets. Represents the expected ROI on allocated capital. Null for non-pricing sets.',
    `set_code` STRING COMMENT 'Short alphanumeric code for the assumption set used in actuarial systems (e.g., BE2024M, PRC2024Q1).',
    `set_name` STRING COMMENT 'Business-friendly name for the assumption set (e.g., 2024 Best Estimate Mortality, Q1 2024 Pricing Assumptions).',
    `set_purpose` STRING COMMENT 'Primary business purpose of the assumption set: valuation (reserve calculations), pricing (new product development), repricing (rate adjustments), experience update (assumption refresh), stress testing, or sensitivity analysis.. Valid values are `valuation|pricing|repricing|experience_update|stress_testing|sensitivity_analysis`',
    `stochastic_scenario_count` STRING COMMENT 'Number of stochastic scenarios (e.g., 1000, 10000) used in this assumption set for PBR or IFRS calculations. Null if deterministic.',
    `tax_compliance_basis` STRING COMMENT 'The IRC Section 7702 compliance test basis for pricing-purpose assumption sets: GPT (Guideline Premium Test), CVAT (Cash Value Accumulation Test), 7702 (general life insurance definition), 7702A (Modified Endowment Contract test), or none if not applicable.. Valid values are `GPT|CVAT|7702|7702A|none`',
    `valuation_date` DATE COMMENT 'The as-of date for which this assumption set is calibrated or intended to be used (e.g., EOY 2023, BOY 2024). Relevant for reserve snapshots and experience studies.',
    `version_number` STRING COMMENT 'Sequential version number for this assumption set. Increments with each revision or update to support version control and audit trails.',
    CONSTRAINT pk_assumption_set PRIMARY KEY(`assumption_set_id`)
) COMMENT 'Master table defining actuarial assumption sets used in valuation, pricing, and product development models. Captures assumption basis (best estimate, prudent estimate, prescribed, pricing), effective date, product applicability, regulatory basis (GAAP/SAP/IFRS), approval status, and set purpose (valuation, pricing, repricing, experience_update). For pricing-purpose sets, additionally stores profit margin target (ROI/NBV), investment return assumption, expense loading, and regulatory compliance basis (GPT/CVAT for 7702). Each assumption set groups typed assumption_detail records (mortality, lapse, expense, interest rate, morbidity, credibility) into a versioned, auditable package for model governance. Links to product definitions for pricing sets and supports new product development, rate filings, repricing reviews, and experience study assumption updates.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` (
    `cash_flow_projection_id` BIGINT COMMENT 'Unique identifier for the cash flow projection record.',
    `annuity_contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: Cash flow projections model future premiums, benefits, and expenses for specific annuity contracts. Required for asset-liability management, ORSA stress testing, and PBR stochastic reserve calculation',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the specific policy or policy cohort for which cash flows are projected.',
    `insured_id` BIGINT COMMENT 'Foreign key linking to policyholder.insured. Business justification: Cash flow projections model mortality, lapse, and benefit payments by individual insured attributes (age, gender, underwriting class, tobacco status). Actuarial models require insured-level detail for',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Cash flow projections model product-specific premium inflows, benefit outflows, and expense patterns for pricing validation, profitability analysis, embedded value calculations, and ALM duration match',
    `reinsurance_cession_id` BIGINT COMMENT 'Foreign key linking to reinsurance.cession. Business justification: Cash flow projections model reinsurance cash flows (ceded premiums, recoverables) at cession level for ALM analysis, capital planning, and asset adequacy testing.',
    `stochastic_scenario_id` BIGINT COMMENT 'Reference to the stochastic or deterministic scenario under which this projection was calculated.',
    `valuation_run_id` BIGINT COMMENT 'Reference to the parent actuarial valuation run that generated this projection.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Projection models run on vendor platforms or use vendor-provided economic scenario generators (Conning, Moodys). Links projection to vendor system for model governance, vendor risk management, licens',
    `account_value` DECIMAL(18,2) COMMENT 'Total account value (AV) for universal life or annuity products at the beginning of this projection period.',
    `asset_duration` DECIMAL(18,2) COMMENT 'Projected effective duration of assets backing liabilities for this product segment and period, used in ALM analysis.',
    `benefit_outflow_amount` DECIMAL(18,2) COMMENT 'Projected benefit payments for this period, including death benefits (DB), maturity benefits, annuity payments, and surrender benefits (CSV).',
    `commission_outflow_amount` DECIMAL(18,2) COMMENT 'Projected commission payments to agents and distributors for this period.',
    `convexity` DECIMAL(18,2) COMMENT 'Projected convexity measure for assets or liabilities, capturing the curvature of price sensitivity to interest rate changes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was first inserted into the data platform.',
    `csm_balance_amount` DECIMAL(18,2) COMMENT 'Projected contractual service margin (CSM) balance at the end of this projection period under IFRS 17.',
    `cte_level` STRING COMMENT 'The CTE confidence level used for stochastic reserve calculations (e.g., 70 for CTE 70 under VM-20).',
    `dac_balance_amount` DECIMAL(18,2) COMMENT 'Projected deferred acquisition cost (DAC) balance at the end of this projection period, applicable under GAAP and LDTI.',
    `discount_rate` DECIMAL(18,2) COMMENT 'The discount rate applied to this projection period for present value calculations, expressed as a decimal (e.g., 0.03500 for 3.5%).',
    `duration_gap` DECIMAL(18,2) COMMENT 'Difference between asset duration and liability duration, indicating interest rate risk exposure.',
    `expense_outflow_amount` DECIMAL(18,2) COMMENT 'Projected expense cash outflows for this period, including acquisition expenses, maintenance expenses, and overhead allocations.',
    `face_amount` DECIMAL(18,2) COMMENT 'Total face amount or death benefit (DB) in force for the cohort at the beginning of this projection period.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Assumed interest rate or investment return rate for this projection period, expressed as a decimal.',
    `investment_income_amount` DECIMAL(18,2) COMMENT 'Projected investment income earned on assets backing reserves for this period, including interest, dividends, and capital gains.',
    `key_rate_duration` DECIMAL(18,2) COMMENT 'Projected key rate duration for a specific maturity point on the yield curve, used for hedging strategy decisions.',
    `lapse_rate` DECIMAL(18,2) COMMENT 'Assumed lapse or surrender rate applied to this projection period, expressed as a decimal (e.g., 0.05000 for 5%).',
    `liability_duration` DECIMAL(18,2) COMMENT 'Projected effective duration of liabilities for this product segment and period, used in ALM analysis.',
    `model_version` STRING COMMENT 'Version identifier of the actuarial model (Prophet, AXIS, MoSes) used to generate this projection.. Valid values are `^[A-Za-z0-9._-]{1,20}$`',
    `mortality_assumption_table` STRING COMMENT 'Code identifying the mortality table used for this projection (e.g., 2017CSO, VBT2015).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `nar_amount` DECIMAL(18,2) COMMENT 'Projected net amount at risk (NAR) for this period, calculated as death benefit minus account value or reserve.',
    `net_cash_flow_amount` DECIMAL(18,2) COMMENT 'Net projected cash flow for this period, calculated as premiums plus investment income minus benefits, expenses, and commissions.',
    `policy_count` STRING COMMENT 'Number of policies or policy units in force at the beginning of this projection period.',
    `premium_inflow_amount` DECIMAL(18,2) COMMENT 'Projected premium cash inflows for this period, including renewal premiums, single premiums, and flexible premiums.',
    `present_value_amount` DECIMAL(18,2) COMMENT 'Present value of the net cash flow for this period, discounted back to the valuation date.',
    `product_segment_code` STRING COMMENT 'Code identifying the product line or segment (e.g., UL, VUL, FIA, SPIA, Term) for aggregation and reporting purposes.. Valid values are `^[A-Z0-9]{2,10}$`',
    `projection_basis` STRING COMMENT 'The accounting or regulatory basis under which the projection was calculated (GAAP, SAP, IFRS 17, PBR, ORSA, Economic).. Valid values are `GAAP|SAP|IFRS17|PBR|ORSA|Economic`',
    `projection_date` DATE COMMENT 'The calendar date corresponding to this projection period.',
    `projection_period` STRING COMMENT 'The time period number (e.g., month 1, month 2, year 1) for which this cash flow is projected, relative to the valuation date.',
    `reinsurance_ceded_premium_amount` DECIMAL(18,2) COMMENT 'Projected reinsurance premiums ceded to reinsurers for this period.',
    `reinsurance_recoverable_amount` DECIMAL(18,2) COMMENT 'Projected reinsurance recoveries from reinsurers for claims and benefits paid in this period.',
    `reserve_amount` DECIMAL(18,2) COMMENT 'Projected reserve balance at the end of this projection period under the specified accounting basis.',
    `risk_adjustment_amount` DECIMAL(18,2) COMMENT 'Projected risk adjustment for non-financial risk at the end of this projection period under IFRS 17.',
    `run_timestamp` TIMESTAMP COMMENT 'Timestamp when this projection record was generated by the actuarial model.',
    `scenario_type` STRING COMMENT 'Classification of the scenario: deterministic, stochastic, stressed, or best estimate.. Valid values are `Deterministic|Stochastic|Stressed|Best_Estimate`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was last modified in the data platform.',
    `valuation_date` DATE COMMENT 'The as-of date for the actuarial valuation run (typically EOY or BOY).',
    CONSTRAINT pk_cash_flow_projection PRIMARY KEY(`cash_flow_projection_id`)
) COMMENT 'Transactional records capturing projected cash flow streams from actuarial model runs. Stores projected premiums, benefits, expenses, and investment income by projection period, scenario, and policy cohort. Supports PBR stochastic reserve calculations (CTE 70), IFRS 17 contractual service margin (CSM) fulfilment cash flow computations, and ORSA internal model inputs. After merge with alm_position: additionally captures ALM position metrics including asset duration, liability duration, duration gap, convexity, and key rate duration profiles by product segment and reporting date for interest rate risk management and hedging strategy decisions for FIA/IUL products. Linked to a parent valuation run and stochastic scenario.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`experience_study` (
    `experience_study_id` BIGINT COMMENT 'Unique identifier for the actuarial experience study record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Experience studies require named appointed actuary for regulatory filings (state DOI, NAIC). Actuary_name is denormalized text; FK enables credential verification, licensing compliance tracking, and S',
    `group_sponsor_id` BIGINT COMMENT 'Foreign key linking to policyholder.group_sponsor. Business justification: Group insurance experience studies analyze mortality, morbidity, and lapse rates by sponsor for credibility-weighted pricing and reserving. Actuaries perform sponsor-specific experience analysis for l',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Experience studies analyze actual vs expected mortality, lapse, and expense by product to set product-specific assumptions, determine credibility weighting, and recommend assumption updates. Required ',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Experience studies analyze data over defined reporting periods and results are disclosed in financial statement footnotes. Studies are typically conducted annually or quarterly and their results must ',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Experience studies produce formal reports with peer review documentation and assumption change justifications required for regulatory examinations, internal governance, and assumption governance proce',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Experience studies often use external data providers (SOA, RGA) or consulting actuaries as vendor services. Links study to vendor who provided data/analysis for procurement tracking, invoice reconcili',
    `actual_events` BIGINT COMMENT 'Total number of observed events (deaths, lapses, disabilities, claims, surrenders) during the study period. Numerator for actual experience rate calculation.',
    `ae_ratio` DECIMAL(18,2) COMMENT 'Actual-to-expected ratio calculated as actual_events divided by expected_events. A/E ratio of 1.00 indicates experience matches assumptions; >1.00 indicates worse-than-expected experience; <1.00 indicates better-than-expected experience. Primary output metric for experience studies.',
    `approval_date` DATE COMMENT 'Date on which the experience study was formally approved by the Chief Actuary or Actuarial Committee for use in assumption setting and valuation. Marks transition from draft to approved status.',
    `assumption_locked_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) of whether the assumptions used in this study are locked for regulatory or contractual reasons and cannot be changed despite study results. True indicates assumptions are locked (e.g., PBR deterministic reserve locked assumptions); False indicates assumptions are open for update.',
    `assumption_table_used` STRING COMMENT 'Name or identifier of the assumption table (mortality, lapse, disability, expense) applied to calculate expected events. Examples: 2017 CSO Preferred, 2008 VBT, Company Lapse Table v3.2, 2013 IAM Basic.',
    `assumption_update_cycle` STRING COMMENT 'Frequency at which this experience study is conducted and assumptions are reviewed for potential updates: annual (yearly), semi-annual (twice per year), quarterly, ad-hoc (event-driven), triennial (every three years).. Valid values are `annual|semi_annual|quarterly|ad_hoc|triennial`',
    `comments` STRING COMMENT 'Free-text field for actuarial commentary, observations, caveats, data quality notes, or special considerations related to this experience study. Used to document context that does not fit structured fields.',
    `confidence_level_pct` DECIMAL(18,2) COMMENT 'Statistical confidence level (e.g., 90.00, 95.00, 99.00) used for credibility calculations and significance testing. Indicates the probability that the observed A/E ratio is not due to random variation.',
    `created_by_user` STRING COMMENT 'User ID or name of the actuary or analyst who created this experience study record. Audit trail for accountability and data lineage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this experience study record was first created in the actuarial system. Audit trail for data lineage and governance.',
    `credibility_standard` STRING COMMENT 'Qualitative classification of credibility level: full (credibility_weight >= 1.0, fully credible), partial (0.25 <= credibility_weight < 1.0, partially credible), limited (0.0 < credibility_weight < 0.25, limited credibility), none (credibility_weight = 0.0, not credible).. Valid values are `full|partial|limited|none`',
    `credibility_weight` DECIMAL(18,2) COMMENT 'Statistical credibility factor (0.0 to 1.0) assigned to this study based on exposure volume, variance, and confidence level per ASOP 25. Higher credibility indicates greater statistical reliability. Used to blend actual experience with industry tables when setting new assumptions.',
    `data_source_system` STRING COMMENT 'Name of the actuarial valuation or experience analysis system from which this study was generated (e.g., MoSes, AXIS, Prophet, Milliman Arius, Moodys ALFA). Identifies the system of record for this experience study.',
    `exclusion_criteria` STRING COMMENT 'Description of policies or data excluded from the study population (e.g., Policies in grace period, Reinsured policies, Policies with incomplete data, First-year policies). Documents scope limitations and data quality filters.',
    `expected_events` DECIMAL(18,2) COMMENT 'Total number of expected events based on current assumption tables applied to the study population exposure. Used as the benchmark for actual-to-expected (A/E) ratio calculation.',
    `exposure_amount` DECIMAL(18,2) COMMENT 'Total exposure measure for the study population, typically expressed in policy-years, life-years, or face amount-years depending on the study type. Denominator for calculating experience rates.',
    `impact_on_capital_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact (in USD) on Risk-Based Capital (RBC) or economic capital if the recommended assumption adjustments are adopted. Used for capital planning and solvency assessment.',
    `impact_on_reserves_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact (in USD) on statutory or GAAP reserves if the recommended assumption adjustments are adopted. Positive values indicate reserve increases; negative values indicate reserve decreases. Used for materiality assessment and management decision-making.',
    `materiality_threshold_met_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) of whether the experience study results exceed the companys materiality threshold for assumption changes. True indicates that the variance is material and requires formal assumption update; False indicates variance is within acceptable tolerance.',
    `modified_by_user` STRING COMMENT 'User ID or name of the actuary or analyst who last modified this experience study record. Audit trail for change tracking and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this experience study record was last updated or modified. Audit trail for change tracking and version control.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next experience study review or update based on the assumption_update_cycle. Used for assumption governance tracking and planning.',
    `peer_reviewer_name` STRING COMMENT 'Full name of the independent peer reviewer (typically a senior actuary or external consultant) who validated the study methodology and results. Required for material assumption changes.',
    `policy_count` BIGINT COMMENT 'Total number of policies included in the experience study population during the observation period. Used for credibility assessment and statistical significance.',
    `product_segment` STRING COMMENT 'Product line or segment scope for this study (e.g., Term Life, Whole Life (WL), Universal Life (UL), Indexed Universal Life (IUL), Variable Universal Life (VUL), Fixed Annuity, Fixed Indexed Annuity (FIA), Disability Income (DI)). May be aggregated or granular depending on study design.',
    `publication_date` DATE COMMENT 'Date on which the experience study results and recommendations were published and distributed to stakeholders (pricing, valuation, risk management, senior management). Marks official release.',
    `recommended_adjustment_factor` DECIMAL(18,2) COMMENT 'Actuarially recommended multiplicative adjustment factor to apply to current assumptions based on study results. Calculated using credibility-weighted blend of A/E ratio and current assumptions. Factor of 1.05 means increase assumption rates by 5%; 0.95 means decrease by 5%.',
    `recommended_assumption_change_pct` DECIMAL(18,2) COMMENT 'Percentage change recommended for assumption rates, expressed as a percentage (e.g., 5.00 for +5%, -3.50 for -3.5%). Derived from recommended_adjustment_factor. Used for management reporting and assumption governance.',
    `regulatory_framework` STRING COMMENT 'Primary regulatory or accounting framework for which this experience study is conducted: GAAP (Generally Accepted Accounting Principles), SAP (Statutory Accounting Principles), IFRS (International Financial Reporting Standards), PBR (Principle-Based Reserving), VM-20 (Valuation Manual Section 20), LDTI (Long Duration Targeted Improvements), or other. [ENUM-REF-CANDIDATE: GAAP|SAP|IFRS|PBR|VM20|LDTI|other — 7 candidates stripped; promote to reference product]',
    `segmentation_criteria` STRING COMMENT 'Business dimensions used to segment the study population (e.g., Age band, Gender, Underwriting class, Policy duration, Issue year, Face amount band, Distribution channel). Defines the granularity of the experience analysis.',
    `study_methodology` STRING COMMENT 'Description of the actuarial methodology and approach used for this experience study (e.g., Seriatim policy-level analysis, Aggregate cohort method, Duration-based segmentation, Attained age method). Documents the technical approach for reproducibility and peer review.',
    `study_name` STRING COMMENT 'Business-friendly name or title of the experience study (e.g., 2023 Mortality Study - Term Life, Q4 Lapse Analysis - UL Products).',
    `study_period_end_date` DATE COMMENT 'Ending date of the observation period for actual experience data included in this study. Defines the upper bound of the experience window.',
    `study_period_start_date` DATE COMMENT 'Beginning date of the observation period for actual experience data included in this study. Defines the lower bound of the experience window.',
    `study_status` STRING COMMENT 'Current lifecycle status of the experience study: draft (initial setup), in_progress (data collection and analysis), under_review (peer review), approved (finalized), published (released to stakeholders), archived (historical).. Valid values are `draft|in_progress|under_review|approved|published|archived`',
    `study_type` STRING COMMENT 'Category of actuarial experience being analyzed: mortality (death rates), lapse (policy termination), disability (DI claims), expense (unit costs), surrender (voluntary termination), claim incidence, persistency, or morbidity. [ENUM-REF-CANDIDATE: mortality|lapse|disability|expense|surrender|claim_incidence|persistency|morbidity — 8 candidates stripped; promote to reference product]',
    `valuation_date` DATE COMMENT 'As-of date for which the experience study results are calculated and reported, typically aligned with EOY (End of Year) or BOY (Beginning of Year) valuation cycles.',
    `variance_from_expected` DECIMAL(18,2) COMMENT 'Absolute difference between actual_events and expected_events (actual_events - expected_events). Positive values indicate adverse experience; negative values indicate favorable experience.',
    CONSTRAINT pk_experience_study PRIMARY KEY(`experience_study_id`)
) COMMENT 'Master records for actuarial experience studies comparing actual-to-expected (A/E) experience for mortality, lapse, disability, and expense. Captures study period, product segment, credibility weighting, A/E ratios, and recommended assumption adjustments. Drives assumption updates for future valuation cycles and pricing reviews. Sourced from MoSes/AXIS experience analysis modules.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` (
    `experience_study_result_id` BIGINT COMMENT 'Unique identifier for each experience study result record at the cell or cohort level.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Assumption governance requires independent actuarial review of experience study results before assumption set updates. Approved_by is text; FK enables segregation of duties verification, peer review t',
    `experience_study_id` BIGINT COMMENT 'Reference to the parent experience study that generated this result cell.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Granular A/E ratios by product segment drive product-specific assumption updates, mortality table selection, and lapse rate adjustments. Critical for pricing adequacy reviews and competitive positioni',
    `accounting_standard` STRING COMMENT 'The accounting standard framework under which this experience study result is reported (GAAP, SAP, IFRS).. Valid values are `GAAP|SAP|IFRS`',
    `actual_amount` DECIMAL(18,2) COMMENT 'The actual monetary amount associated with the observed events (e.g., total death benefits paid, total expenses incurred) for this cohort.',
    `actual_count` STRING COMMENT 'The actual number of observed events (deaths, lapses, claims, surrenders) during the study period for this cohort.',
    `ae_ratio_amount` DECIMAL(18,2) COMMENT 'The ratio of actual amount to expected amount (A/E ratio) for this cohort, used for financial impact assessment.',
    `ae_ratio_count` DECIMAL(18,2) COMMENT 'The ratio of actual count to expected count (A/E ratio) for this cohort, a key metric for assumption validation and pricing calibration.',
    `age_band` STRING COMMENT 'The age grouping or band for this experience result (e.g., 30-34, 45-49, 60-64).',
    `approved_date` DATE COMMENT 'The date on which this experience study result was formally approved for use in assumption setting or pricing.',
    `assumption_table_reference` STRING COMMENT 'Reference to the actuarial assumption table or model used to calculate expected values (e.g., 2017 CSO, 2001 VBT, company-specific lapse table).',
    `assumption_version` STRING COMMENT 'The version or effective date of the assumption table used for this study result.',
    `attained_age` STRING COMMENT 'The specific attained age of the insured at the time of observation, if the study is conducted at single-age granularity.',
    `cohort_definition` STRING COMMENT 'Textual description of the cohort or cell definition for this result (e.g., Male, Age 45-49, Duration 5-9, Preferred Non-Smoker).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this experience study result record was first created in the system.',
    `credibility_factor` DECIMAL(18,2) COMMENT 'The statistical credibility weight assigned to this cohort result, ranging from 0 to 1, based on the volume of exposure and observed events.',
    `credibility_method` STRING COMMENT 'The credibility methodology applied to calculate the credibility factor (e.g., Limited Fluctuation, Buhlmann, Classical).',
    `distribution_channel` STRING COMMENT 'The sales or distribution channel through which the policies in this cohort were sold (e.g., Career Agent, Independent Agent, Broker, Direct, Worksite).',
    `expected_amount` DECIMAL(18,2) COMMENT 'The expected monetary amount under the current actuarial assumptions for this cohort.',
    `expected_count` DECIMAL(18,2) COMMENT 'The expected number of events under the current actuarial assumptions for this cohort, calculated using the exposure and assumption rates.',
    `experience_type` STRING COMMENT 'The type of actuarial experience being studied (mortality, lapse, expense, morbidity, surrender, claim frequency, claim severity, premium persistency). [ENUM-REF-CANDIDATE: mortality|lapse|expense|morbidity|surrender|claim_frequency|claim_severity|premium_persistency — 8 candidates stripped; promote to reference product]',
    `exposure_amount` DECIMAL(18,2) COMMENT 'The total exposure measure for this cohort, typically expressed in policy-years, life-years, or face amount-years depending on the study basis.',
    `exposure_unit` STRING COMMENT 'The unit of measure for the exposure amount (policy-years, life-years, face amount-years, account value-years).. Valid values are `policy_years|life_years|face_amount_years|account_value_years`',
    `gender` STRING COMMENT 'The gender classification for this experience cohort (male, female, unisex, unknown).. Valid values are `male|female|unisex|unknown`',
    `geographic_region` STRING COMMENT 'The geographic region or state grouping for this experience cohort (e.g., Northeast, Southeast, Midwest, West, or specific state codes).',
    `model_source_system` STRING COMMENT 'The actuarial modeling system that produced this experience study result (e.g., Prophet, MoSes, AXIS, internal calculation engine).',
    `notes` STRING COMMENT 'Free-text notes or commentary from the actuary regarding this specific cohort result, including any data quality issues, outliers, or special considerations.',
    `policy_duration` STRING COMMENT 'The specific policy duration (in years) at the time of observation, if the study is conducted at single-duration granularity.',
    `policy_duration_band` STRING COMMENT 'The policy duration grouping for this experience result (e.g., 0-2, 3-5, 6-10, 11-15, 16+).',
    `product_code` STRING COMMENT 'The insurance product code or identifier for which this experience result applies (e.g., UL, WL, Term, SPIA, FIA).',
    `product_segment` STRING COMMENT 'Business segment or grouping of the product (e.g., Individual Life, Group Life, Annuities, Long-Term Care).',
    `result_status` STRING COMMENT 'The approval and finalization status of this experience study result (draft, preliminary, final, approved, superseded).. Valid values are `draft|preliminary|final|approved|superseded`',
    `smoker_status` STRING COMMENT 'The smoking status classification for this cohort (smoker, non-smoker, unknown).. Valid values are `smoker|non_smoker|unknown`',
    `standard_deviation` DECIMAL(18,2) COMMENT 'The standard deviation of the observed experience for this cohort, a measure of variability around the expected value.',
    `statistical_confidence_level` DECIMAL(18,2) COMMENT 'The confidence level for statistical testing of this result (e.g., 0.95 for 95% confidence), used in hypothesis testing and margin calculations.',
    `study_basis` STRING COMMENT 'The calculation basis for the study (seriatim for policy-level, grouped for cohort-level, aggregate for portfolio-level).. Valid values are `seriatim|grouped|aggregate`',
    `underwriting_class` STRING COMMENT 'The underwriting risk class for this cohort (e.g., Preferred Plus, Preferred, Standard, Substandard, Rated).',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this experience study result record was last modified.',
    `variance` DECIMAL(18,2) COMMENT 'The statistical variance of the observed experience for this cohort, used in credibility and margin calculations.',
    CONSTRAINT pk_experience_study_result PRIMARY KEY(`experience_study_result_id`)
) COMMENT 'Detailed transactional results from actuarial experience studies at the cell or cohort level. Stores actual claims/lapses/expenses, expected values under current assumptions, A/E ratios, exposure amounts, and credibility factors by age band, duration, gender, and product segment. Feeds assumption refinement and pricing model calibration.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` (
    `pbr_model_segment_id` BIGINT COMMENT 'Unique identifier for the PBR model segment. Primary key for the table.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: VM-20 PBR requires appointed actuary approval of model segments for reserve adequacy opinion. Approved_by is text; FK enables credential verification (FSA/MAAA), authority validation, and regulatory e',
    `liability_segment_id` BIGINT COMMENT 'Foreign key linking to actuarial.liability_segment. Business justification: PBR (Principle-Based Reserving) model segments under VM-20 are typically aligned with liability segments for regulatory reporting and reserve adequacy testing. The liability_segment table contains the',
    `mortality_table_id` BIGINT COMMENT 'Foreign key linking to actuarial.mortality_table. Business justification: PBR model segment references a prescribed mortality table per VM-20 requirements. The pbr_model_segment.prescribed_mortality_table attribute (STRING) should be replaced with a FK to mortality_table.mo',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: PBR model segments are product-specific groupings for VM-20 principle-based reserve calculations. Each product requires defined segments by underwriting class, distribution channel, and credibility th',
    `reinsurance_treaty_id` BIGINT COMMENT 'Foreign key linking to reinsurance.treaty. Business justification: PBR model segments align with treaty coverage for reserve credit calculations and RBC reporting. Required for VM-20 compliance, deterministic/stochastic reserve calculation, and Schedule S disclosure.',
    `approval_date` DATE COMMENT 'Date when this model segment definition was formally approved by the qualified actuary for statutory reserve use.',
    `approval_status` STRING COMMENT 'Approval workflow status for this model segment definition. Only approved segments are used in statutory reserve calculations.. Valid values are `draft|pending_review|approved|rejected`',
    `assumption_update_date` DATE COMMENT 'Date when mortality, lapse, or expense assumptions for this segment were last reviewed and updated per experience study results.',
    `base_lapse_rate` DECIMAL(18,2) COMMENT 'Annual base lapse rate assumption (expressed as decimal, e.g., 0.0500 for 5%) applied to policies in this model segment.',
    `company_experience_adjustment` DECIMAL(18,2) COMMENT 'Multiplicative adjustment factor applied to prescribed mortality based on credible company experience. Value of 1.0 indicates no adjustment.',
    `credibility_percentage` DECIMAL(18,2) COMMENT 'Percentage weight (0-100) assigned to company experience versus prescribed tables based on credibility analysis per VM-20.',
    `credibility_threshold_met` BOOLEAN COMMENT 'Indicates whether this model segment has sufficient policy count and exposure to meet VM-20 credibility standards for company experience.',
    `cte_level` STRING COMMENT 'CTE confidence level (typically 70 or 98) used for stochastic reserve calculation per VM-20 requirements.',
    `distribution_channel` STRING COMMENT 'Sales distribution channel through which policies in this segment were sold. May impact lapse and persistency assumptions.. Valid values are `career_agent|independent_agent|broker|bank|direct|worksite`',
    `dynamic_lapse_formula` STRING COMMENT 'Formula or reference to dynamic lapse function that adjusts lapse rates based on policy value, surrender charge, and economic conditions per VM-20.',
    `effective_date` DATE COMMENT 'Date when this model segment definition became effective for reserve calculations. Supports historical segment tracking.',
    `exclusion_test_result` STRING COMMENT 'Result of VM-20 exclusion test indicating whether this segment qualifies for simplified valuation or requires full PBR treatment.. Valid values are `excluded|included|not_applicable`',
    `expense_assumption_basis` STRING COMMENT 'Methodology used to allocate maintenance expenses to this model segment: fully allocated company experience, marginal cost, or prescribed.. Valid values are `fully_allocated|marginal|prescribed`',
    `face_amount_total` DECIMAL(18,2) COMMENT 'Total death benefit face amount (in USD) for all policies in this model segment. Key exposure measure for reserve adequacy.',
    `gender` STRING COMMENT 'Gender classification for policies in this model segment. Impacts mortality and lapse assumptions per actuarial experience.. Valid values are `male|female|unisex`',
    `issue_age_band_max` STRING COMMENT 'Maximum issue age (in years) for policies included in this model segment. Part of the age band segmentation criterion.',
    `issue_age_band_min` STRING COMMENT 'Minimum issue age (in years) for policies included in this model segment. Part of the age band segmentation criterion.',
    `lapse_assumption_basis` STRING COMMENT 'Source of lapse rate assumptions for this model segment: company experience, industry tables, prescribed rates, or credibility-weighted blend.. Valid values are `company_experience|industry_table|prescribed|blended`',
    `model_version` STRING COMMENT 'Version identifier for the actuarial model configuration used for this segment (e.g., 2024Q1_v3). Supports model change tracking.. Valid values are `^[0-9]{4}Q[1-4]_v[0-9]+$`',
    `mortality_improvement_scale` STRING COMMENT 'Mortality improvement scale applied for projection (e.g., Scale G2, Scale AA). Used in stochastic and deterministic reserve calculations.',
    `net_amount_at_risk_total` DECIMAL(18,2) COMMENT 'Total net amount at risk (death benefit minus account value, in USD) for all policies in this segment. Critical for mortality risk assessment.',
    `notes` STRING COMMENT 'Free-form notes documenting special considerations, assumption rationale, or segment-specific modeling decisions for actuarial reference.',
    `per_policy_expense_annual` DECIMAL(18,2) COMMENT 'Annual per-policy maintenance expense assumption (in USD) for policies in this model segment. Used in cash flow projections.',
    `percent_of_premium_expense` DECIMAL(18,2) COMMENT 'Expense assumption as percentage of premium (expressed as decimal, e.g., 0.0250 for 2.5%) for premium-related expenses.',
    `policy_count` STRING COMMENT 'Number of in-force policies currently assigned to this model segment. Used for credibility analysis and segment monitoring.',
    `product_type` STRING COMMENT 'Type of life insurance product included in this model segment. Key segmentation criterion per VM-20 requirements.. Valid values are `term|whole_life|universal_life|indexed_universal_life|variable_universal_life|survivorship`',
    `reinsurance_treatment` STRING COMMENT 'Indicates how reinsurance is reflected in reserve calculations for this segment: gross reserves, net of reinsurance, or by treaty type.. Valid values are `gross|net_of_reinsurance|coinsurance|yrt`',
    `reserve_basis` STRING COMMENT 'Primary reserve calculation method for this model segment: deterministic reserve, stochastic reserve, or net premium reserve per VM-20.. Valid values are `deterministic|stochastic|net_premium`',
    `segment_description` STRING COMMENT 'Detailed description of the model segment definition criteria, including product characteristics, risk factors, and segmentation rationale.',
    `segment_status` STRING COMMENT 'Current lifecycle status of the model segment definition. Active segments are used in current valuation runs.. Valid values are `active|inactive|under_review|superseded`',
    `smoker_status` STRING COMMENT 'Tobacco use status for policies in this model segment. Critical factor in mortality assumption development.. Valid values are `smoker|non_smoker|not_applicable`',
    `stochastic_scenario_count` STRING COMMENT 'Number of economic scenarios used in stochastic reserve calculation for this model segment. Typically 1,000 or 10,000 per VM-20 requirements.',
    `termination_date` DATE COMMENT 'Date when this model segment definition was retired or superseded. Null for currently active segments.',
    `underwriting_class` STRING COMMENT 'Risk classification assigned during underwriting that defines mortality expectations for this model segment. [ENUM-REF-CANDIDATE: preferred_plus|preferred|standard_plus|standard|substandard|simplified_issue|guaranteed_issue — 7 candidates stripped; promote to reference product]',
    `valuation_system` STRING COMMENT 'Actuarial modeling system used to calculate reserves for this model segment (e.g., Prophet, AXIS, MoSes).. Valid values are `prophet|axis|moses|other`',
    CONSTRAINT pk_pbr_model_segment PRIMARY KEY(`pbr_model_segment_id`)
) COMMENT 'Master table defining PBR (Principle-Based Reserving) model segments per VM-20 requirements. Captures segment definition criteria (product type, issue age band, underwriting class, distribution channel), credibility threshold, prescribed vs. company experience blend, and segment-level reserve basis. Required for VM-20 deterministic and stochastic reserve calculations.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` (
    `stochastic_scenario_id` BIGINT COMMENT 'Unique identifier for the stochastic scenario record. Primary key.',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: ORSA stress testing and PBR stochastic reserve calculations require applying interest rate and equity return scenarios to specific investment portfolios to measure capital adequacy and reserve impacts',
    `scenario_set_id` BIGINT COMMENT 'Identifier for the scenario set to which this scenario belongs (e.g., NAIC_2024_VM20_10K, ALM_Q1_2024, ORSA_2024_BASE). Groups scenarios generated together for a specific purpose and valuation date.. Valid values are `^[A-Z0-9_-]{1,50}$`',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: ORSA stress testing and VM-20 stochastic reserves require independent scenario validation per model risk management. Validation_performed_by is text; FK enables validator independence verification, cr',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Economic scenario generators are vendor products (Conning ESG, Moodys GEMS). Links scenario set to vendor for license tracking, model validation, vendor performance assessment, and regulatory complia',
    `actuarial_system_source` STRING COMMENT 'The actuarial valuation system that consumed or generated this scenario for reserve calculations or cash flow projections (e.g., MoSes, AXIS, Prophet). Ensures traceability between scenario generation and reserve calculation systems. [ENUM-REF-CANDIDATE: MoSes|AXIS|Prophet|GGY AXIS|Milliman Integrate|FIS Sunrise|Other — 7 candidates stripped; promote to reference product]',
    `board_approval_date` DATE COMMENT 'The date on which the board of directors approved this stress scenario analysis and capital adequacy conclusions. Required for ORSA regulatory filing and corporate governance documentation.',
    `board_approval_status` STRING COMMENT 'Status of board of directors approval for this stress scenario and its conclusions. ORSA requires board oversight and approval of stress testing results and capital adequacy assessments. Pending indicates awaiting board review. Approved indicates board acceptance. Rejected or Requires Revision indicate the board has requested changes.. Valid values are `Pending|Approved|Rejected|Requires Revision`',
    `calibration_date` DATE COMMENT 'The date to which the scenario generator parameters were calibrated (typically the valuation date or a recent market observation date). Ensures scenarios reflect current market conditions.',
    `capital_adequacy_conclusion` STRING COMMENT 'Managements conclusion regarding capital adequacy under this stress scenario. Adequate indicates the company remains well-capitalized. Marginal indicates the company approaches action levels. Inadequate indicates the company falls below minimum thresholds. Requires Management Action or Requires Capital Raise indicate remediation is needed. Used in ORSA reporting to the board and regulators.. Valid values are `Adequate|Marginal|Inadequate|Requires Management Action|Requires Capital Raise`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this scenario record was first created in the data platform. Used for audit trail and data lineage tracking.',
    `cte_level` DECIMAL(18,2) COMMENT 'The CTE confidence level for which this scenario is used in reserve calculations (e.g., 70.00 for CTE 70 per VM-20, 98.00 for CTE 98 for Variable Annuity reserves per VM-21). Represents the average of the worst X% of scenarios.',
    `equity_return_path` STRING COMMENT 'Serialized representation of the equity index return path for this scenario across all projection periods. Typically stored as a comma-separated or JSON array of monthly or annual returns (e.g., 0.08,-0.02,0.12...). Used for Variable Universal Life (VUL), Variable Annuity (VA), and Fixed Indexed Annuity (FIA) crediting calculations.',
    `interest_rate_path` STRING COMMENT 'Serialized representation of the interest rate path for this scenario across all projection periods. Typically stored as a comma-separated or JSON array of monthly or annual spot rates (e.g., 0.0325,0.0340,0.0355...). Used in discounting cash flows and crediting rates for universal life and annuity products.',
    `orsa_filing_year` STRING COMMENT 'The calendar year for which this scenario was used in the ORSA filing (e.g., 2024). ORSA filings are required annually by NAIC for insurers meeting size thresholds. Links scenarios to specific regulatory submissions.',
    `projection_period_months` STRING COMMENT 'The total number of months for which economic paths are projected in this scenario (e.g., 360 months for 30-year projection horizon). Defines the length of the cash flow projection period.',
    `random_seed` BIGINT COMMENT 'The random number generator seed used to produce this scenario. Ensures reproducibility of scenario generation for audit and validation purposes. Critical for demonstrating compliance with VM-20 requirements that scenarios be reproducible.',
    `rbc_ratio_under_stress` DECIMAL(18,2) COMMENT 'The companys Risk-Based Capital (RBC) ratio (Total Adjusted Capital / Authorized Control Level RBC) after applying this stress scenario. Expressed as a percentage (e.g., 350.00 means 350% RBC ratio). Used to assess whether the company remains above regulatory action levels (200% Company Action Level, 150% Regulatory Action Level, 100% Authorized Control Level, 70% Mandatory Control Level) under stress.',
    `regulatory_submission_date` DATE COMMENT 'The date on which scenarios and stress testing results were submitted to state insurance regulators as part of ORSA or other regulatory filings. Tracks compliance with annual ORSA filing deadlines.',
    `scenario_description` STRING COMMENT 'Free-text description of this scenario, including any special characteristics, stress assumptions, or business context. Used for documentation and communication with management, board, and regulators.',
    `scenario_generation_date` DATE COMMENT 'The date on which this scenario was generated by the economic scenario generator. Distinct from valuation_date (the as-of date for reserves) and calibration_date (the market data date). Used for audit trail and version control.',
    `scenario_generator_version` STRING COMMENT 'Version number of the scenario generator software used (e.g., 8.1.2). Ensures traceability and reproducibility of scenario generation for regulatory audit.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `scenario_number` STRING COMMENT 'Sequential number of this scenario within the scenario set (e.g., 1 to 10,000 for VM-20 stochastic reserve calculations). Used for ordering and referencing individual paths.',
    `scenario_purpose` STRING COMMENT 'Business purpose for which this scenario was generated. Discriminates between Principle-Based Reserving (PBR) stochastic reserve calculations, Asset Liability Management (ALM) stress testing, Own Risk and Solvency Assessment (ORSA) stress scenarios, hedging analysis for Fixed Indexed Annuity (FIA) and Indexed Universal Life (IUL) products, pricing, and product development.. Valid values are `PBR|ALM|ORSA|Hedging|Pricing|Product Development`',
    `scenario_status` STRING COMMENT 'Current lifecycle status of this scenario. Draft indicates initial generation. Validated indicates actuarial review completed. Approved indicates ready for use in reserve calculations. In Use indicates actively used in current valuation. Archived indicates retained for historical reference. Rejected indicates failed validation and should not be used.. Valid values are `Draft|Validated|Approved|In Use|Archived|Rejected`',
    `scenario_weight` DECIMAL(18,2) COMMENT 'Statistical weight assigned to this scenario for aggregation purposes. For equally weighted scenarios (e.g., NAIC 10,000 scenarios), this is typically 0.0001 (1/10,000). For importance sampling or stratified scenarios, weights may vary. Sum of all weights in a scenario set equals 1.0.',
    `stress_severity` STRING COMMENT 'Severity level of the stress applied to this scenario. None for baseline scenarios. Severity can be qualitative (Moderate, Severe, Extreme) or quantitative (1-in-X year event). Used in ORSA and Enterprise Risk Management (ERM) frameworks to assess capital adequacy under adverse conditions. [ENUM-REF-CANDIDATE: None|Moderate|Severe|Extreme|1-in-10|1-in-20|1-in-50|1-in-100|1-in-200 — 9 candidates stripped; promote to reference product]',
    `stress_type` STRING COMMENT 'Type of stress applied to this scenario for ORSA or ALM stress testing. None indicates a baseline scenario. Stress types include mortality shock (increased death claims), lapse shock (mass surrenders or persistency changes), interest rate shock (parallel shift or twist), equity shock (market crash), pandemic (extreme mortality), credit spread shock, longevity shock (reduced mortality for annuities), expense shock, or combined multi-factor stress. [ENUM-REF-CANDIDATE: None|Mortality Shock|Lapse Shock|Interest Rate Shock|Equity Shock|Pandemic|Credit Spread Shock|Longevity Shock|Expense Shock|Combined Stress — 10 candidates stripped; promote to reference product]',
    `stressed_reserve_impact_amount` DECIMAL(18,2) COMMENT 'The incremental reserve impact (in dollars) resulting from this stress scenario compared to the baseline scenario. Positive values indicate reserve increases; negative values indicate reserve decreases. Used in ORSA stress testing to quantify capital needs under adverse conditions.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this scenario record was last updated in the data platform. Used for audit trail and change tracking.',
    `validation_date` DATE COMMENT 'The date on which this scenario was validated by an actuary. Part of the actuarial control cycle ensuring scenarios meet quality standards before use in reserve calculations.',
    `validation_notes` STRING COMMENT 'Free-text notes documenting the validation process, any issues identified, adjustments made, or special considerations for this scenario. Supports actuarial documentation and regulatory audit requirements.',
    `valuation_date` DATE COMMENT 'The as-of date for which this scenario set was generated and will be applied in reserve calculations or stress testing. Typically End of Year (EOY) or Beginning of Year (BOY) for statutory reporting.',
    CONSTRAINT pk_stochastic_scenario PRIMARY KEY(`stochastic_scenario_id`)
) COMMENT 'Reference and transactional records for economic scenarios used in PBR stochastic reserve calculations, ALM stress testing, and ORSA stress test analysis. Stores scenario set identifier (e.g., NAIC prescribed 10,000 scenarios for VM-20), interest rate paths, equity return paths, scenario weights, and scenario generator version. For ORSA stress test scenarios: additionally captures stress type (mortality shock, lapse shock, interest rate shock, pandemic), stressed reserve impact, RBC ratio under stress, capital adequacy conclusion, and board approval status. Discriminated by scenario_purpose (PBR, ALM, ORSA). Supports VM-20 stochastic reserve (CTE 70), ORSA annual filing per NAIC requirements, ERM framework stress testing, and FIA/IUL hedging analysis.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` (
    `reserve_snapshot_id` BIGINT COMMENT 'Unique identifier for the reserve snapshot record. Primary key.',
    `annuity_contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: Reserve snapshots capture point-in-time reserve balances for individual annuity contracts. Critical for reserve roll-forward analysis, variance investigation, and regulatory examination support. Curre',
    `cohort_definition_id` BIGINT COMMENT 'Foreign key linking to actuarial.cohort_definition. Business justification: Reserve snapshot has cohort_identifier attribute, clearly referencing a cohort_definition for LDTI/IFRS17 cohort-level reserve tracking. Adding cohort_definition_id FK allows joining to the full cohor',
    `employee_id` BIGINT COMMENT 'Reference to the qualified actuary who reviewed and approved this reserve snapshot calculation.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy for which reserves are being calculated and snapshotted.',
    `insured_id` BIGINT COMMENT 'Foreign key linking to policyholder.insured. Business justification: Reserve snapshots capture point-in-time reserve positions by individual insured life for regulatory reporting (statutory annual statements) and financial close. Insurers track reserves at insured-leve',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Reserve snapshots track product-level reserve adequacy for quarterly statutory reporting, GAAP financial statements, and regulatory examinations. Required for product profitability monitoring and rese',
    `reinsurance_cession_id` BIGINT COMMENT 'Foreign key linking to reinsurance.cession. Business justification: Reserve snapshots track ceded reserves at individual cession level for quarterly reserve reporting, reconciliation with bordereaux, and statutory filing (Schedule S).',
    `valuation_run_id` BIGINT COMMENT 'Foreign key linking to actuarial.valuation_run. Business justification: Reserve snapshot captures point-in-time reserve balances from a specific valuation run. The reserve_snapshot.model_run_identifier attribute suggests it references a valuation_run. Adding valuation_run',
    `approval_date` DATE COMMENT 'The date on which the reserve snapshot was reviewed and approved by the qualified actuary.',
    `av` DECIMAL(18,2) COMMENT 'The account value of the policy at the snapshot date. Represents the policyholders accumulated value in universal life and variable products.',
    `calculation_timestamp` TIMESTAMP COMMENT 'The timestamp when the reserve calculation was executed by the actuarial valuation system.',
    `csv` DECIMAL(18,2) COMMENT 'The cash surrender value available to the policyholder if the policy were surrendered at the snapshot date. Relevant for permanent life insurance and annuity products.',
    `dac_balance` DECIMAL(18,2) COMMENT 'The unamortized deferred acquisition cost balance at the snapshot date. This actuarial calculation feeds into finance.dac_amortization for GAAP booking. This is the actuarial calculation output; finance.dac_amortization is the SSOT for the accounting entry.',
    `expense_assumption` DECIMAL(18,2) COMMENT 'The per-policy or aggregate expense assumption used in the reserve calculation. May represent maintenance expenses, claim processing costs, or other operational expenses.',
    `interest_rate_assumption` DECIMAL(18,2) COMMENT 'The discount rate or interest rate assumption used in the reserve calculation. Expressed as a decimal (e.g., 0.0350 for 3.50%).',
    `lapse_rate_assumption` DECIMAL(18,2) COMMENT 'The assumed annual lapse or surrender rate used in the reserve calculation. Expressed as a decimal (e.g., 0.0500 for 5.00%).',
    `ldti_transition_adjustment` DECIMAL(18,2) COMMENT 'The cumulative adjustment to reserves resulting from the adoption of LDTI (Long Duration Targeted Improvements) under FASB ASC 944. Captures the impact of transitioning to updated GAAP reserve methodologies.',
    `mortality_assumption_table` STRING COMMENT 'The mortality table used in the reserve calculation. Examples include 2017 CSO, 2001 VBT, or company-specific experience tables.',
    `nar` DECIMAL(18,2) COMMENT 'The net amount at risk for the insurer, calculated as the death benefit minus the account value or reserve. Key metric for mortality risk exposure.',
    `net_reserve` DECIMAL(18,2) COMMENT 'The net reserve after reinsurance cessions. Calculated as reserve_balance minus reinsurance_ceded_reserve.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this reserve snapshot. May include explanations of unusual variances, assumption changes, or special considerations.',
    `pbr_deterministic_reserve` DECIMAL(18,2) COMMENT 'The deterministic reserve calculated under PBR (Principle-Based Reserving) per VM-20. One component of the PBR reserve calculation.',
    `pbr_net_premium_reserve` DECIMAL(18,2) COMMENT 'The net premium reserve calculated under PBR (Principle-Based Reserving) per VM-20. Serves as a floor for the PBR reserve.',
    `pbr_stochastic_reserve` DECIMAL(18,2) COMMENT 'The stochastic reserve calculated under PBR (Principle-Based Reserving) per VM-20 using scenario modeling. One component of the PBR reserve calculation.',
    `product_code` STRING COMMENT 'The insurance product code for which reserves are being held. Examples include WL (Whole Life), UL (Universal Life), IUL (Indexed Universal Life), VUL (Variable Universal Life), Term, SPIA (Single Premium Immediate Annuity), FIA (Fixed Indexed Annuity).',
    `reinsurance_ceded_reserve` DECIMAL(18,2) COMMENT 'The portion of the reserve that has been ceded to reinsurers under reinsurance treaties. Reduces the net reserve liability for the ceding company.',
    `reporting_period` STRING COMMENT 'The reporting period this snapshot represents. BOY (Beginning of Year), EOY (End of Year), quarterly (Q1-Q4), or monthly. [ENUM-REF-CANDIDATE: BOY|EOY|Q1|Q2|Q3|Q4|Monthly — 7 candidates stripped; promote to reference product]',
    `reserve_adequacy_status` STRING COMMENT 'The assessment of whether the reserve is adequate to cover expected future obligations. Adequate indicates sufficiency, Deficient indicates shortfall requiring premium deficiency reserve, Redundant indicates excess, Under Review indicates pending actuarial analysis.. Valid values are `Adequate|Deficient|Redundant|Under Review`',
    `reserve_balance` DECIMAL(18,2) COMMENT 'The total reserve amount held for this policy or cohort at the snapshot date. Represents the actuarial liability under the specified valuation basis.',
    `reserve_type` STRING COMMENT 'Classification of the reserve being captured. Policy Reserve for contract liabilities, Claim Reserve for known claims, Premium Deficiency Reserve for loss recognition, IBNR (Incurred But Not Reported) for estimated unreported claims, Unearned Premium Reserve for prepaid premiums, or Additional Reserve for supplemental reserves.. Valid values are `Policy Reserve|Claim Reserve|Premium Deficiency Reserve|IBNR|Unearned Premium Reserve|Additional Reserve`',
    `snapshot_date` DATE COMMENT 'The valuation date for which this reserve snapshot was calculated. Typically BOY (Beginning of Year) or EOY (End of Year) reporting date.',
    `valuation_basis` STRING COMMENT 'The accounting or regulatory basis under which the reserve was calculated. GAAP (Generally Accepted Accounting Principles), SAP (Statutory Accounting Principles), IFRS (International Financial Reporting Standards), PBR (Principle-Based Reserving per VM-20), or Tax basis.. Valid values are `GAAP|SAP|IFRS|PBR|Tax`',
    CONSTRAINT pk_reserve_snapshot PRIMARY KEY(`reserve_snapshot_id`)
) COMMENT 'Point-in-time reserve balance snapshots capturing BOY and EOY reserve positions by product, valuation basis, and reporting period. Includes DAC-related actuarial calculation inputs that feed into finance.dac_amortization for GAAP booking. This is the actuarial calculation output; finance.dac_amortization is the SSOT for the accounting entry.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` (
    `pricing_basis_id` BIGINT COMMENT 'Unique identifier for the actuarial pricing basis record.',
    `assumption_set_id` BIGINT COMMENT 'Foreign key linking to actuarial.assumption_set. Business justification: Pricing basis references a specific assumption set used for pricing calculations. The pricing_basis table has mortality_table_code, lapse_assumption_set_code, investment_return_assumption, discount_ra',
    `mortality_table_id` BIGINT COMMENT 'Foreign key linking to actuarial.mortality_table. Business justification: Pricing basis directly references a specific mortality table for pricing calculations. The pricing_basis.mortality_table_code attribute should be replaced with a FK to mortality_table.mortality_table_',
    `plan_id` BIGINT COMMENT 'Reference to the life insurance or annuity product for which this pricing basis applies.',
    `plan_version_id` BIGINT COMMENT 'Foreign key linking to product.plan_version. Business justification: Pricing bases are version-specific; rate changes, assumption updates, or filing amendments require new plan versions per state insurance department requirements. Essential for tracking rate action his',
    `policy_form_approval_id` BIGINT COMMENT 'Foreign key linking to compliance.policy_form_approval. Business justification: Policy form approvals require actuarial pricing basis for DOI review of rates, benefits, and reserves. Form and rate filings are often submitted together. Links pricing assumptions to approved policy ',
    `rate_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.rate_filing. Business justification: Rate filings submitted to DOI require actuarial pricing basis documentation (mortality tables, expense assumptions, profit margins). Pricing basis is the actuarial foundation for rate filing approval.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Pricing models use vendor-provided actuarial software (Milliman Integrate, AXIS) or reinsurance pricing tools. Links pricing basis to vendor for license management, system dependency tracking, vendor ',
    `acquisition_expense_rate` DECIMAL(18,2) COMMENT 'Rate or percentage applied to cover first-year acquisition expenses including commissions, underwriting, and policy issuance costs. Expressed as percentage of premium or per-policy amount depending on loading method.',
    `age_basis` STRING COMMENT 'Method used to calculate insured age for pricing: ANB (Age Nearest Birthday), ALB (Age Last Birthday), actual (exact age in years and months).. Valid values are `anb|alb|actual`',
    `approval_date` DATE COMMENT 'Date on which the pricing basis was formally approved by the appointed actuary or pricing committee.',
    `approved_by_actuary_name` STRING COMMENT 'Name of the qualified actuary (FSA, MAAA) who approved this pricing basis for use.',
    `basis_code` STRING COMMENT 'Unique business code identifying this pricing basis configuration (e.g., STD_2024_UL, PREF_2023_WL).. Valid values are `^[A-Z0-9_]{3,20}$`',
    `basis_name` STRING COMMENT 'Descriptive name of the pricing basis (e.g., Standard Universal Life 2024, Preferred Whole Life 2023).',
    `basis_type` STRING COMMENT 'Classification of the pricing basis purpose: new product launch, repricing of existing product, rate revision, competitive market adjustment, regulatory compliance update, or experience study adjustment.. Valid values are `new_business|repricing|rate_revision|competitive_adjustment|regulatory_update|experience_adjustment`',
    `competitive_position_target` STRING COMMENT 'Intended competitive positioning of rates under this pricing basis: market_leader (lowest rates), top_quartile, median (middle of market), competitive (within range), value (higher rates, richer benefits).. Valid values are `market_leader|top_quartile|median|competitive|value`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pricing basis record was first created in the system.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Rate used to discount future cash flows to present value for profit metric calculations (ROI, NBV). May differ from investment return assumption. Expressed as decimal.',
    `effective_date` DATE COMMENT 'Date from which this pricing basis becomes applicable for new business or repricing.',
    `expense_loading_method` STRING COMMENT 'Method used to load expenses into premium rates: per_policy (flat amount per policy), percent_of_premium (percentage of premium), per_thousand_face_amount (per $1000 of coverage), tiered (varies by band), composite (combination of methods).. Valid values are `per_policy|percent_of_premium|per_thousand_face_amount|tiered|composite`',
    `expiration_date` DATE COMMENT 'Date after which this pricing basis is no longer valid for new business. Null indicates open-ended applicability.',
    `filing_jurisdiction` STRING COMMENT 'State or jurisdiction code (2-letter abbreviation) where this pricing basis was filed for regulatory approval. May be multi-state or nationwide.',
    `gender_distinct_pricing_flag` BOOLEAN COMMENT 'Indicates whether this pricing basis uses gender-distinct mortality and pricing (True) or unisex rates (False). Some jurisdictions prohibit gender-based pricing.',
    `investment_return_assumption` DECIMAL(18,2) COMMENT 'Assumed annual investment return rate (net of investment expenses) used in pricing cash flow projections. Expressed as decimal (e.g., 0.0450 for 4.50%).',
    `maintenance_expense_rate` DECIMAL(18,2) COMMENT 'Rate or percentage applied to cover ongoing policy maintenance and administration expenses in renewal years. Expressed as percentage of premium or per-policy amount depending on loading method.',
    `maximum_face_amount` DECIMAL(18,2) COMMENT 'Maximum death benefit or face amount (in currency) for which this pricing basis applies. Null indicates no upper limit.',
    `maximum_issue_age` STRING COMMENT 'Maximum age (in years) at which a policy can be issued under this pricing basis.',
    `minimum_face_amount` DECIMAL(18,2) COMMENT 'Minimum death benefit or face amount (in currency) for which this pricing basis applies.',
    `minimum_issue_age` STRING COMMENT 'Minimum age (in years) at which a policy can be issued under this pricing basis.',
    `mortality_improvement_scale` STRING COMMENT 'Mortality improvement projection scale applied to base mortality table (e.g., Scale G2, Scale AA, MP-2021). Used to adjust mortality rates for future improvements.',
    `notes` STRING COMMENT 'Free-text notes documenting special considerations, assumptions, limitations, or context for this pricing basis. Used for actuarial documentation and knowledge transfer.',
    `pricing_basis_status` STRING COMMENT 'Current lifecycle status of the pricing basis: draft (in development), under_review (actuarial review), approved (ready for use), active (currently in use), superseded (replaced by newer basis), retired (no longer applicable).. Valid values are `draft|under_review|approved|active|superseded|retired`',
    `pricing_model_version` STRING COMMENT 'Version identifier of the pricing model or software used to generate this basis. Supports model governance and reproducibility.',
    `profit_margin_target_pct` DECIMAL(18,2) COMMENT 'Target profit margin as percentage of premium or present value of profits. Used to calibrate pricing to achieve desired profitability. Expressed as decimal (e.g., 0.0800 for 8.00%).',
    `regulatory_filing_number` STRING COMMENT 'State insurance department filing number or SERFF tracking number associated with the rate filing for this pricing basis. Null if not filed or filed under product filing.',
    `reinsurance_assumption` STRING COMMENT 'Type of reinsurance arrangement assumed in pricing: none (no reinsurance), YRT (Yearly Renewable Term), coinsurance, mod_co (modified coinsurance), facultative (case-by-case reinsurance).. Valid values are `none|yrt|coinsurance|mod_co|facultative`',
    `reinsurance_cession_rate` DECIMAL(18,2) COMMENT 'Percentage of risk or premium ceded to reinsurers under the assumed reinsurance arrangement. Expressed as decimal (e.g., 0.9000 for 90% quota share). Null if no reinsurance.',
    `reserve_basis` STRING COMMENT 'Accounting or regulatory basis for reserve calculations associated with this pricing: statutory (SAP), GAAP (US GAAP ASC 944), IFRS (IFRS 17), PBR per VM-20 (Principle-Based Reserving), or tax reserves.. Valid values are `statutory|gaap|ifrs|pbr_vm20|tax`',
    `smoker_status_pricing_flag` BOOLEAN COMMENT 'Indicates whether this pricing basis differentiates rates by tobacco/smoker status (True) or uses blended rates (False).',
    `target_nbv` DECIMAL(18,2) COMMENT 'Target new business value per policy or per unit of premium. Represents present value of future profits at issue. Used as profitability benchmark in pricing.',
    `target_roi` DECIMAL(18,2) COMMENT 'Target return on investment metric used in pricing. Represents expected return on allocated capital. Expressed as decimal (e.g., 0.1200 for 12.00% ROI).',
    `tax_basis` STRING COMMENT 'IRC Section 7702 tax qualification basis for life insurance: GPT (Guideline Premium Test), CVAT (Cash Value Accumulation Test), MEC_compliant (Modified Endowment Contract compliant), non_qualified (not tax-qualified).. Valid values are `gpt|cvat|mec_compliant|non_qualified`',
    `underwriting_class` STRING COMMENT 'Target underwriting risk class for which this pricing basis applies: preferred_plus (super-preferred), preferred, standard_plus, standard, substandard, rated (table-rated), declined (uninsurable). [ENUM-REF-CANDIDATE: preferred_plus|preferred|standard_plus|standard|substandard|rated|declined — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this pricing basis record was last modified.',
    CONSTRAINT pk_pricing_basis PRIMARY KEY(`pricing_basis_id`)
) COMMENT 'Master table defining actuarial pricing bases for life insurance and annuity products. Captures pricing mortality table, lapse assumption set, expense loading, investment return assumption, profit margin target (ROI/NBV), and regulatory compliance basis (GPT/CVAT for 7702). Links to product definitions and supports new product development, rate filings, and repricing reviews.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` (
    `cohort_definition_id` BIGINT COMMENT 'Unique identifier for the cohort definition record. Primary key for the cohort definition entity.',
    `liability_segment_id` BIGINT COMMENT 'Foreign key linking to actuarial.liability_segment. Business justification: LDTI (ASU 2018-12) and IFRS 17 cohort definitions are typically established within liability segments for financial reporting. The liability_segment table contains the segment-level accounting standar',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: LDTI and IFRS17 cohorts are product-specific groupings by issue year and profitability classification. Each product requires separate cohort tracking for locked-in discount rates, CSM amortization, an',
    `accounting_standard` STRING COMMENT 'The accounting framework under which this cohort is defined: GAAP (Generally Accepted Accounting Principles), SAP (Statutory Accounting Principles), IFRS17 (International Financial Reporting Standards 17), or LDTI (Long Duration Targeted Improvements under ASU 2018-12).. Valid values are `GAAP|SAP|IFRS17|LDTI`',
    `assumption_update_frequency` STRING COMMENT 'The frequency at which actuarial assumptions (mortality, lapse, expense) are reviewed and updated for this cohort under LDTI or IFRS 17.. Valid values are `annual|quarterly|semi_annual|as_needed`',
    `cohort_code` STRING COMMENT 'Business-assigned unique code identifying the cohort for reporting and reference purposes. Used in actuarial systems and financial statements.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `cohort_name` STRING COMMENT 'Human-readable descriptive name of the cohort for business user identification and reporting.',
    `cohort_status` STRING COMMENT 'The current lifecycle status of the cohort: active (still issuing new policies), closed (no new issues but policies in force), runoff (winding down), or fully_matured (all policies terminated or matured).. Valid values are `active|closed|runoff|fully_matured`',
    `cohort_type` STRING COMMENT 'Classification of the cohort grouping methodology: annual (LDTI annual cohort), portfolio (IFRS 17 portfolio), group (IFRS 17 group of insurance contracts), or contract (individual contract level).. Valid values are `annual|portfolio|group|contract`',
    `coverage_unit_definition` STRING COMMENT 'The definition of the coverage unit used for CSM amortization under IFRS 17 or DAC amortization under LDTI. Describes the quantity of benefits or services provided (e.g., sum assured, account value, number of policies in force).',
    `created_by_user` STRING COMMENT 'The user identifier or system account that created this cohort definition record.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cohort definition record was first created in the system.',
    `current_discount_rate` DECIMAL(18,2) COMMENT 'The current period discount rate used for remeasurement of the liability under LDTI. Changes in this rate relative to the locked-in rate flow through Other Comprehensive Income (OCI). Expressed as a decimal.',
    `dac_amortization_method` STRING COMMENT 'The method used to amortize Deferred Acquisition Costs for this cohort under ASC 944. LDTI requires amortization on a constant level basis over the expected life of the contracts, or in proportion to premiums, profits, or gross margins depending on product type.. Valid values are `constant_level|in_proportion_to_premiums|in_proportion_to_profits|in_proportion_to_gross_margins`',
    `distribution_channel` STRING COMMENT 'The primary distribution channel through which policies in this cohort were sold. Used for experience studies, profitability analysis, and commission structure alignment. [ENUM-REF-CANDIDATE: career_agent|independent_agent|broker|bank|direct|worksite|online — 7 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'The date when this cohort definition became effective for financial reporting and actuarial valuation purposes.',
    `expected_contract_life_years` DECIMAL(18,2) COMMENT 'The expected duration of contracts in this cohort from issue to maturity or termination, used for DAC amortization, reserve calculations, and cash flow projections. Expressed in years with decimal precision.',
    `expense_assumption_rate` DECIMAL(18,2) COMMENT 'The assumed per-policy or per-unit expense rate for ongoing policy maintenance and administration, used in liability calculations. May be expressed as annual cost per policy or as percentage of premium.',
    `geographic_market` STRING COMMENT 'The primary geographic market or jurisdiction where policies in this cohort were issued. Used for regulatory reporting, experience studies, and market segmentation analysis.',
    `ifrs17_group_code` STRING COMMENT 'The IFRS 17 group of insurance contracts identifier. Groups are subsets of portfolios divided by issue year and profitability classification (onerous, profitable, neither).',
    `ifrs17_initial_recognition_date` DATE COMMENT 'The date when the group of insurance contracts was initially recognized under IFRS 17, establishing the cohort and locking in the initial CSM and discount rate.',
    `ifrs17_portfolio_code` STRING COMMENT 'The IFRS 17 portfolio identifier to which this cohort belongs. Portfolios group insurance contracts subject to similar risks and managed together.',
    `initial_csm_amount` DECIMAL(18,2) COMMENT 'The initial Contractual Service Margin calculated at initial recognition under IFRS 17. Represents the unearned profit that will be recognized as services are provided over the coverage period. Set to zero for onerous contracts.',
    `initial_lfpb_amount` DECIMAL(18,2) COMMENT 'The initial measurement of the Liability for Future Policy Benefits at cohort inception under LDTI. Represents the present value of expected future benefit payments less the present value of expected future net premiums, using the locked-in discount rate.',
    `issue_quarter` STRING COMMENT 'The calendar quarter (1-4) within the issue year for more granular cohort segmentation when required by company policy or product characteristics.',
    `issue_year` STRING COMMENT 'The calendar year in which policies or contracts in this cohort were issued. LDTI requires annual cohort grouping based on issue year to lock in discount rates and assumptions.',
    `lapse_assumption_rate` DECIMAL(18,2) COMMENT 'The assumed annual lapse or surrender rate for policies in this cohort, used in cash flow projections and reserve calculations. Expressed as a decimal (e.g., 0.0350 for 3.50% annual lapse rate).',
    `last_assumption_update_date` DATE COMMENT 'The date when actuarial assumptions for this cohort were last reviewed and updated. LDTI requires annual assumption updates at a minimum.',
    `last_valuation_date` DATE COMMENT 'The most recent date on which actuarial valuation was performed for this cohort. Used to track valuation currency and identify cohorts requiring remeasurement.',
    `ldti_transition_date` DATE COMMENT 'The effective date of LDTI adoption for this cohort, typically January 1, 2023 for calendar-year public companies. Used to determine transition adjustments and opening balances under the new standard.',
    `locked_in_discount_rate` DECIMAL(18,2) COMMENT 'The discount rate locked in at cohort inception for LDTI liability for future policy benefits (LFPB) measurement. This rate remains constant for the cohort and is used to discount expected future cash flows. Expressed as a decimal (e.g., 0.0425 for 4.25%).',
    `mortality_assumption_table` STRING COMMENT 'The mortality table used for reserve calculations and cash flow projections for this cohort (e.g., 2017 CSO, 2012 IAM, company-specific experience table). Critical for life insurance and annuity valuation.',
    `next_valuation_date` DATE COMMENT 'The scheduled date for the next actuarial valuation of this cohort, typically quarterly or annually depending on reporting requirements.',
    `pbr_method` STRING COMMENT 'The Principle-Based Reserving methodology applied to this cohort under NAIC Valuation Manual VM-20 or VM-21: deterministic reserve, stochastic reserve, net premium reserve, or not applicable for products not subject to PBR.. Valid values are `deterministic|stochastic|net_premium|not_applicable`',
    `policy_count` STRING COMMENT 'The current number of active policies or contracts included in this cohort. Used for coverage unit calculations and experience monitoring.',
    `profitability_classification` STRING COMMENT 'IFRS 17 classification of the cohort at initial recognition: onerous (expected to be loss-making), profitable (expected to generate profit), or neither (break-even). Determines initial measurement and subsequent CSM (Contractual Service Margin) treatment.. Valid values are `onerous|profitable|neither`',
    `reinsurance_treaty_applicable` BOOLEAN COMMENT 'Indicates whether policies in this cohort are subject to reinsurance treaties. True if reinsurance applies, False if the cohort is retained 100% by the direct writer.',
    `termination_date` DATE COMMENT 'The date when this cohort definition was terminated or superseded, if applicable. Null for active cohorts.',
    `total_account_value` DECIMAL(18,2) COMMENT 'The aggregate account value across all contracts in this cohort. Primary metric for annuity and universal life cohorts.',
    `total_face_amount` DECIMAL(18,2) COMMENT 'The aggregate face amount or death benefit across all policies in this cohort. Key metric for life insurance cohorts and risk exposure monitoring.',
    `underwriting_class` STRING COMMENT 'The predominant underwriting risk class for policies in this cohort. Cohorts may be segmented by underwriting class to reflect different mortality or morbidity assumptions. [ENUM-REF-CANDIDATE: preferred_plus|preferred|standard_plus|standard|substandard|guaranteed_issue|simplified_issue — 7 candidates stripped; promote to reference product]',
    `updated_by_user` STRING COMMENT 'The user identifier or system account that last modified this cohort definition record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this cohort definition record was last modified.',
    CONSTRAINT pk_cohort_definition PRIMARY KEY(`cohort_definition_id`)
) COMMENT 'Master table defining policy cohorts for LDTI (ASU 2018-12) annual cohort grouping and IFRS 17 group of insurance contracts. Captures cohort grouping criteria (product type, issue year, profitability classification — onerous, profitable, or neither), LDTI transition date, locked-in discount rate, initial LFPB measurement, and IFRS 17 portfolio/group hierarchy. Required for LDTI annual cohort remeasurement, IFRS 17 CSM unit of account, and DAC amortization grouping under ASC 944.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`alm_position` (
    `alm_position_id` BIGINT COMMENT 'Unique identifier for the ALM position record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: ALM positions require ALCO (Asset Liability Committee) approval by CIO/Treasurer for duration gap management and hedge strategy. Approved_by is text; FK enables authority validation, meeting attendanc',
    `orsa_report_id` BIGINT COMMENT 'Foreign key linking to compliance.orsa_report. Business justification: ALM positions (duration gap, convexity) are disclosed in ORSA reports for interest rate risk assessment. ORSA requires market risk analysis including ALM. Links ALM measurement to ORSA filing.',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: ALM (Asset-Liability Management) positions must reference specific investment portfolios to track duration matching and gap analysis. The alm_position product currently has product_segment_code/name a',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: ALM analytics use vendor platforms (BlackRock Aladdin, Bloomberg PORT). Links ALM calculation to vendor system for system dependency tracking, vendor risk assessment, contract management, and business',
    `approval_status` STRING COMMENT 'Current approval status of this ALM position record in the governance workflow.. Valid values are `draft|pending_review|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this ALM position record was approved.',
    `asset_convexity` DECIMAL(18,2) COMMENT 'Convexity measure of the asset portfolio, representing the curvature of the price-yield relationship. Used to assess second-order interest rate risk exposure.',
    `asset_duration_years` DECIMAL(18,2) COMMENT 'Macaulay or modified duration of the asset portfolio backing this product segment, measured in years. Represents the weighted average time to receive cash flows from assets.',
    `asset_market_value` DECIMAL(18,2) COMMENT 'Total market value of the asset portfolio backing this product segment as of the valuation date.',
    `calculation_timestamp` TIMESTAMP COMMENT 'The date and time when this ALM position was calculated by the actuarial valuation system.',
    `comments` STRING COMMENT 'Free-text field for actuarial or risk management commentary on this ALM position, including assumptions, limitations, or special considerations.',
    `convexity_gap` DECIMAL(18,2) COMMENT 'The difference between asset convexity and liability convexity. Indicates the mismatch in second-order interest rate sensitivity between assets and liabilities.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this ALM position record was first created in the system.',
    `duration_gap_years` DECIMAL(18,2) COMMENT 'The difference between asset duration and liability duration (asset_duration_years minus liability_duration_years). A positive gap indicates assets are longer-duration than liabilities; negative indicates the opposite. Critical for interest rate risk management.',
    `effective_duration_years` DECIMAL(18,2) COMMENT 'Effective duration of the combined asset-liability position, accounting for embedded options and policyholder behavior assumptions. Used for hedging strategy decisions.',
    `hedge_effectiveness_percentage` DECIMAL(18,2) COMMENT 'Percentage measure of how effectively the hedging strategy offsets changes in the fair value or cash flows of the hedged item, typically measured over the reporting period.',
    `hedge_ratio` DECIMAL(18,2) COMMENT 'The ratio of hedging instruments to the underlying exposure, indicating the proportion of interest rate risk that is hedged. A value of 1.0 indicates full hedge; 0.0 indicates no hedge.',
    `interest_rate_scenario_code` STRING COMMENT 'Code identifying the interest rate scenario applied for this ALM position measurement (e.g., BASE for baseline, UP100 for +100 basis points, DOWN100 for -100 basis points, TWIST for yield curve twist).. Valid values are `BASE|UP100|UP200|DOWN100|DOWN200|TWIST`',
    `key_rate_duration_10yr` DECIMAL(18,2) COMMENT 'Sensitivity of the portfolio value to a 1 basis point change in the 10-year key rate on the yield curve, holding all other rates constant.',
    `key_rate_duration_1yr` DECIMAL(18,2) COMMENT 'Sensitivity of the portfolio value to a 1 basis point change in the 1-year key rate on the yield curve, holding all other rates constant.',
    `key_rate_duration_20yr` DECIMAL(18,2) COMMENT 'Sensitivity of the portfolio value to a 1 basis point change in the 20-year key rate on the yield curve, holding all other rates constant.',
    `key_rate_duration_30yr` DECIMAL(18,2) COMMENT 'Sensitivity of the portfolio value to a 1 basis point change in the 30-year key rate on the yield curve, holding all other rates constant.',
    `key_rate_duration_5yr` DECIMAL(18,2) COMMENT 'Sensitivity of the portfolio value to a 1 basis point change in the 5-year key rate on the yield curve, holding all other rates constant.',
    `liability_convexity` DECIMAL(18,2) COMMENT 'Convexity measure of the liability portfolio, representing the curvature of the liability value-yield relationship. Critical for FIA and IUL products with embedded options.',
    `liability_duration_years` DECIMAL(18,2) COMMENT 'Macaulay or modified duration of the liability portfolio for this product segment, measured in years. Represents the weighted average time to pay cash flows to policyholders.',
    `liability_market_value` DECIMAL(18,2) COMMENT 'Total market value of the liability portfolio for this product segment as of the valuation date, calculated using current discount rates.',
    `model_version` STRING COMMENT 'Version identifier of the actuarial model (e.g., Prophet, AXIS, MoSes) used to generate this ALM position data, enabling traceability and reproducibility.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this ALM position record was last modified.',
    `reporting_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all monetary amounts in this ALM position are denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `surplus_deficit_amount` DECIMAL(18,2) COMMENT 'The difference between asset market value and liability market value. A positive value indicates surplus; a negative value indicates deficit.',
    `valuation_date` DATE COMMENT 'The date on which the ALM position was measured and recorded, typically aligned with EOY (End of Year) or BOY (Beginning of Year) reporting cycles.',
    CONSTRAINT pk_alm_position PRIMARY KEY(`alm_position_id`)
) COMMENT 'Transactional records capturing Asset Liability Management (ALM) position data including asset duration, liability duration, duration gap, convexity, and key rate duration profiles by product segment and reporting date. Supports interest rate risk management, hedging strategy decisions for FIA/IUL products, and ORSA internal model inputs.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` (
    `tax_qualification_test_id` BIGINT COMMENT 'Primary key for tax_qualification_test',
    `annuity_contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: GPT/CVAT tests determine if annuity contracts qualify as life insurance for tax purposes (IRC Section 7702). Required for MEC determination, tax compliance, and IRS audit defense. Currently policy_id ',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: GPT/CVAT testing enforces IRS Section 7702 compliance policy for life insurance tax qualification. Testing process implements compliance policy requirements. Links test execution to governing policy.',
    `insured_id` BIGINT COMMENT 'Foreign key linking to policyholder.insured. Business justification: GPT and CVAT tax qualification tests require insured age at issue and attained age to calculate guideline premiums and corridor percentages per IRC Section 7702. Tests are performed per insured life, ',
    `mortality_table_id` BIGINT COMMENT 'Foreign key linking to actuarial.mortality_table. Business justification: Tax qualification testing (IRC 7702/7702A GPT/CVAT) uses a specific mortality table for calculating guideline premiums and cash value accumulation tests. The tax_qualification_test.mortality_table_cod',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: GPT and CVAT tests are product-specific; corridor factors, guideline premium limits, and seven-pay premium calculations vary by plan design. Required for IRC Section 7702 compliance testing and MEC st',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: GPT/CVAT testing requires qualified actuary or tax specialist for IRS compliance (IRC 7702/7702A). Test_performed_by is text; FK enables credential verification, authority validation, and IRS audit de',
    `cash_value_amount` DECIMAL(18,2) COMMENT 'Cash surrender value of the policy at the time of the test. Used in CVAT calculations and MEC testing per IRC 7702 and 7702A.',
    `compliance_status` STRING COMMENT 'Overall tax compliance status of the policy based on test results. Compliant = policy meets all IRC requirements, Non-Compliant = policy violates IRC rules, Remediated = non-compliance corrected through policy adjustment, Under Review = compliance determination pending actuarial or legal review.. Valid values are `compliant|non_compliant|remediated|under_review`',
    `corridor_percentage` DECIMAL(18,2) COMMENT 'Minimum death benefit to cash value ratio required under IRC 7702 to maintain life insurance tax qualification. Varies by insured age per IRC 7702(d)(2).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tax qualification test record was first created in the system. Used for audit trail and data lineage.',
    `cvat_limit` DECIMAL(18,2) COMMENT 'Maximum cash value allowed under the Cash Value Accumulation Test per IRC 7702(b). Cash value must not exceed the net single premium for future benefits at any time.',
    `death_benefit_amount` DECIMAL(18,2) COMMENT 'Face amount or death benefit of the policy at the time of the test. Critical input for GPT and CVAT calculations under IRC 7702.',
    `guideline_level_premium` DECIMAL(18,2) COMMENT 'Level annual premium that would fund the policy death benefit over the insureds lifetime under IRC 7702(c)(4) assumptions. One component of the GPT limit calculation.',
    `guideline_premium_limit` DECIMAL(18,2) COMMENT 'Maximum premium allowed under the Guideline Premium Test (GPT) per IRC 7702(c). Calculated as the greater of guideline single premium or guideline level premium.',
    `guideline_single_premium` DECIMAL(18,2) COMMENT 'Single premium amount that would fund the policy death benefit under IRC 7702(c)(3) assumptions. One component of the GPT limit calculation.',
    `insured_age_at_test` STRING COMMENT 'Age of the insured individual at the time of the tax qualification test. Used in mortality assumptions and guideline premium calculations per IRC 7702.',
    `interest_rate_assumption` DECIMAL(18,2) COMMENT 'Interest rate used in tax qualification test calculations. IRC 7702 specifies rates between 4% and 6% depending on test type and policy characteristics.',
    `mec_status` STRING COMMENT 'Indicates whether the policy is classified as a Modified Endowment Contract under IRC 7702A. Non-MEC = policy passes seven-pay test, MEC = policy failed seven-pay test, MEC Pending = test in progress or under review.. Valid values are `non_mec|mec|mec_pending`',
    `net_single_premium` DECIMAL(18,2) COMMENT 'Single premium required to fund future benefits under IRC 7702(b) assumptions. Used as the CVAT limit for cash value accumulation.',
    `next_test_due_date` DATE COMMENT 'Scheduled date for the next required tax qualification test. Used for periodic compliance monitoring and annual review scheduling.',
    `override_approved_by` STRING COMMENT 'Name or identifier of the authorized individual who approved the test result override. Required for compliance and audit purposes when override_indicator is True.',
    `override_date` DATE COMMENT 'Date on which the test result override was approved and applied. Used for audit trail when override_indicator is True.',
    `override_indicator` BOOLEAN COMMENT 'Flag indicating whether the test result was manually overridden by an actuary or compliance officer. True = result overridden, False = system-calculated result stands.',
    `override_reason` STRING COMMENT 'Business justification for overriding the system-calculated test result. Required when override_indicator is True. Documents actuarial judgment or regulatory interpretation.',
    `policy_issue_date` DATE COMMENT 'Original issue date of the policy being tested. Used as baseline for IRC 7702A seven-pay test and other time-dependent calculations.',
    `premium_paid_to_date` DECIMAL(18,2) COMMENT 'Cumulative premiums paid on the policy from issue date through the test date. Used in MEC seven-pay test calculations per IRC 7702A.',
    `remediation_action` STRING COMMENT 'Description of corrective action taken to bring a non-compliant policy back into IRC 7702 or 7702A compliance. Examples include premium refund, death benefit increase, policy restructuring.',
    `remediation_date` DATE COMMENT 'Date on which remediation action was completed to restore policy tax compliance. Used when compliance_status is Remediated.',
    `seven_pay_premium_limit` DECIMAL(18,2) COMMENT 'Maximum cumulative premium allowed over the first seven policy years under IRC 7702A MEC test. Exceeding this limit causes the policy to become a Modified Endowment Contract.',
    `test_calculation_method` STRING COMMENT 'Actuarial methodology used to perform the tax qualification test calculations. Must comply with IRC 7702 computational rules and assumptions.. Valid values are `actuarial_present_value|net_level_premium|commissioner_standard|custom`',
    `test_date` DATE COMMENT 'Date on which the tax qualification test was performed. Represents the business event date for the test calculation.',
    `test_notes` STRING COMMENT 'Free-form notes and comments regarding the tax qualification test. Used to document special circumstances, assumptions, or actuarial judgments.',
    `test_number` STRING COMMENT 'Business identifier for the tax qualification test. Human-readable reference number used for tracking and audit purposes.',
    `test_reason` STRING COMMENT 'Business reason or trigger for performing the tax qualification test. New Business = initial policy issue, Policy Change = endorsement or modification, Annual Review = periodic compliance check, Premium Increase = additional premium paid, Benefit Increase = death benefit or cash value increase, Rider Addition = new rider attached, Regulatory Audit = external examination, System Migration = data conversion validation. [ENUM-REF-CANDIDATE: new_business|policy_change|annual_review|premium_increase|benefit_increase|rider_addition|regulatory_audit|system_migration — 8 candidates stripped; promote to reference product]',
    `test_result` STRING COMMENT 'Outcome of the tax qualification test. Pass = policy meets IRC requirements, Fail = policy violates IRC limits, Conditional Pass = policy passes with conditions or adjustments, Not Applicable = test not required for this policy type or scenario.. Valid values are `pass|fail|conditional_pass|not_applicable`',
    `test_status` STRING COMMENT 'Current lifecycle status of the tax qualification test. Pending = test scheduled but not started, In Progress = test calculation underway, Completed = test finished successfully, Failed = test execution error, Overridden = test result manually adjusted by actuarial or compliance.. Valid values are `pending|in_progress|completed|failed|overridden`',
    `test_system_source` STRING COMMENT 'Source system or platform that generated the tax qualification test results (e.g., Policy Administration System, Actuarial Valuation System, Prophet, AXIS, MoSes).',
    `test_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the tax qualification test calculation was executed. Used for audit trail and sequencing of multiple tests on the same date.',
    `test_type` STRING COMMENT 'Type of tax qualification test performed. GPT = Guideline Premium Test per IRC 7702(c), CVAT = Cash Value Accumulation Test per IRC 7702(b), MEC = Modified Endowment Contract test per IRC 7702A, 7702_COMPLIANCE = general IRC 7702 life insurance qualification, 7702A_COMPLIANCE = general IRC 7702A MEC testing.. Valid values are `GPT|CVAT|MEC|7702_COMPLIANCE|7702A_COMPLIANCE`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this tax qualification test record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_tax_qualification_test PRIMARY KEY(`tax_qualification_test_id`)
) COMMENT 'Consolidated transactional records for all IRC tax qualification testing — IRC Section 7702 life insurance qualification (GPT/CVAT), IRC Section 7702A Modified Endowment Contract (MEC) testing, and related tax compliance calculations. Captures test type, test date, policy reference, test parameters, test result, and compliance status.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` (
    `ifrs17_csm_id` BIGINT COMMENT 'Primary key for ifrs17_csm',
    `annuity_contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: IFRS 17 Contractual Service Margin is measured at individual annuity contract level for financial reporting. Essential for IFRS 17 compliance, CSM roll-forward, and cohort-level aggregation. Currently',
    `cohort_definition_id` BIGINT COMMENT 'Foreign key linking to actuarial.cohort_definition. Business justification: IFRS 17 CSM records track Contractual Service Margin by contract group and cohort per IFRS 17 requirements. The ifrs17_csm table has cohort_year and contract_group_code attributes that map to cohort_d',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the underlying insurance policy or annuity contract within this group of contracts.',
    `insured_id` BIGINT COMMENT 'Foreign key linking to policyholder.insured. Business justification: IFRS 17 CSM measurement requires insured-level coverage units (typically based on sum assured per insured life) for CSM release calculations. Experience adjustments for mortality and lapse are tracked',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: IFRS17 CSM tracking requires product-level grouping for measurement model application (VFA vs general model), coverage unit definition, and onerous contract testing. Essential for IFRS17 financial rep',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: IFRS 17 CSM disclosures are filed in financial statements for jurisdictions requiring IFRS reporting (international subsidiaries, cross-border operations). CSM roll-forward is a regulatory disclosure ',
    `reinsurance_cession_id` BIGINT COMMENT 'Foreign key linking to reinsurance.cession. Business justification: IFRS17 CSM calculations track reinsurance impact at cession level for financial reporting. Reinsurance held adjustments affect CSM balance and must be disclosed separately.',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: IFRS 17 CSM movements (opening balance, accretion, release, closing balance) are tracked by reporting period for financial statement disclosure. The valuation_date exists but report_period_id formaliz',
    `valuation_run_id` BIGINT COMMENT 'Unique identifier for the actuarial calculation run that produced this record, enabling traceability and audit.',
    `actuarial_system_source` STRING COMMENT 'The actuarial valuation system that produced this CSM calculation (e.g., Prophet, AXIS, MoSes).. Valid values are `prophet|axis|moses|other`',
    `coverage_period_end_date` DATE COMMENT 'The date when insurance coverage ends for this group of contracts. May be null for open-ended or lifetime coverage.',
    `coverage_period_start_date` DATE COMMENT 'The date when insurance coverage begins for this group of contracts.',
    `coverage_units_closing` DECIMAL(18,2) COMMENT 'The quantity of coverage units remaining at the end of the period.',
    `coverage_units_opening` DECIMAL(18,2) COMMENT 'The quantity of coverage units at the beginning of the period used to allocate CSM release. Coverage units reflect the quantity of benefits and expected coverage duration.',
    `coverage_units_provided` DECIMAL(18,2) COMMENT 'The quantity of coverage units provided during the reporting period, used to calculate CSM release.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this CSM record was first created in the system.',
    `csm_accretion_amount` DECIMAL(18,2) COMMENT 'Interest accreted on the CSM balance during the period using discount rates locked in at initial recognition. Increases the CSM balance.',
    `csm_assumption_change_adjustment` DECIMAL(18,2) COMMENT 'Adjustments to CSM for changes in estimates of future cash flows related to future service, excluding financial assumption changes and experience adjustments.',
    `csm_closing_balance` DECIMAL(18,2) COMMENT 'The CSM balance at the end of the reporting period after all movements. Represents remaining unearned profit.',
    `csm_experience_adjustment` DECIMAL(18,2) COMMENT 'Adjustments to CSM for differences between expected and actual cash flows related to future service. Does not include changes in financial assumptions.',
    `csm_fx_adjustment` DECIMAL(18,2) COMMENT 'Foreign exchange translation adjustments applied to the CSM balance for contracts denominated in foreign currencies.',
    `csm_initial_recognition_amount` DECIMAL(18,2) COMMENT 'The CSM calculated at initial recognition, equal to the present value of future cash inflows minus outflows and risk adjustment, ensuring no gain at inception for non-onerous contracts.',
    `csm_opening_balance` DECIMAL(18,2) COMMENT 'The CSM balance at the beginning of the reporting period. Represents unearned profit to be recognized over the coverage period.',
    `csm_release_amount` DECIMAL(18,2) COMMENT 'The amount of CSM released to profit or loss during the period as insurance services are provided. Recognized as insurance revenue.',
    `currency_code` STRING COMMENT 'The functional currency for this group of contracts, expressed as ISO 4217 three-letter code (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `discount_rate_current` DECIMAL(18,2) COMMENT 'The current discount rate used for measuring fulfilment cash flows at the reporting date. Expressed as a decimal (e.g., 0.04250 for 4.25%).',
    `discount_rate_locked_in` DECIMAL(18,2) COMMENT 'The discount rate locked in at initial recognition for CSM accretion calculations. Expressed as a decimal (e.g., 0.03500 for 3.5%).',
    `fulfilment_cash_flows_pv` DECIMAL(18,2) COMMENT 'The present value of estimated future cash flows (premiums, claims, expenses) for this group of contracts at the reporting date.',
    `initial_recognition_date` DATE COMMENT 'The date when the group of contracts was first recognized on the balance sheet under IFRS 17, typically the earliest of coverage start, first payment due, or contract becoming onerous.',
    `loss_component_closing_balance` DECIMAL(18,2) COMMENT 'The loss component balance at the end of the reporting period. Zero for profitable contract groups.',
    `loss_component_initial_recognition` DECIMAL(18,2) COMMENT 'The loss component established at initial recognition for onerous contracts, equal to the excess of fulfilment cash flows over premiums.',
    `loss_component_opening_balance` DECIMAL(18,2) COMMENT 'The loss component balance at the beginning of the reporting period for onerous contract groups. Tracks expected losses separately from CSM.',
    `loss_component_reversal` DECIMAL(18,2) COMMENT 'Reduction in the loss component during the period due to favorable changes in estimates or release as services are provided.',
    `measurement_model` STRING COMMENT 'The IFRS 17 measurement approach applied to this group: General Measurement Model (GMM), Premium Allocation Approach (PAA), or Variable Fee Approach (VFA) for direct participation contracts.. Valid values are `general_measurement_model|premium_allocation_approach|variable_fee_approach`',
    `onerous_contract_flag` BOOLEAN COMMENT 'Indicates whether the group of contracts is onerous at initial recognition (expected to generate a loss). True if onerous, False if profitable or break-even.',
    `product_line` STRING COMMENT 'The insurance product line for this group of contracts. [ENUM-REF-CANDIDATE: term_life|whole_life|universal_life|variable_universal_life|indexed_universal_life|fixed_annuity|variable_annuity|fixed_indexed_annuity|group_life|disability_income|long_term_care — promote to reference product]. Valid values are `term_life|whole_life|universal_life|variable_universal_life|indexed_universal_life|fixed_annuity`',
    `record_status` STRING COMMENT 'Current lifecycle status of this CSM record. Active records represent the current measurement; superseded records are historical versions.. Valid values are `active|superseded|archived|under_review`',
    `reinsurance_flag` BOOLEAN COMMENT 'Indicates whether this group represents reinsurance contracts held (True) or direct insurance contracts issued (False).',
    `reporting_segment` STRING COMMENT 'The business segment for financial reporting and disclosure purposes under IFRS 17.. Valid values are `individual_life|group_life|individual_annuity|group_annuity|accident_health|other`',
    `risk_adjustment_change` DECIMAL(18,2) COMMENT 'Net change in risk adjustment during the period due to release, new estimates, and experience adjustments.',
    `risk_adjustment_closing_balance` DECIMAL(18,2) COMMENT 'The risk adjustment for non-financial risk at the end of the reporting period.',
    `risk_adjustment_opening_balance` DECIMAL(18,2) COMMENT 'The risk adjustment for non-financial risk at the beginning of the reporting period. Represents compensation required for bearing uncertainty about cash flow timing and amount.',
    `transition_approach` STRING COMMENT 'The IFRS 17 transition approach applied to this group: full retrospective, modified retrospective, or fair value approach.. Valid values are `full_retrospective|modified_retrospective|fair_value`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this CSM record was last modified.',
    `valuation_date` DATE COMMENT 'The reporting date as of which this CSM measurement was performed (typically quarter-end or year-end).',
    CONSTRAINT pk_ifrs17_csm PRIMARY KEY(`ifrs17_csm_id`)
) COMMENT 'Master records for IFRS 17 Contractual Service Margin (CSM) and Loss Component tracking by group of contracts. Captures initial CSM at recognition, CSM accretion, CSM release to profit, onerous contract loss component, risk adjustment, and fulfilment cash flow changes. Required for IFRS 17 insurance contract liability measurement and P&L presentation.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` (
    `orsa_stress_test_id` BIGINT COMMENT 'Unique identifier for the ORSA stress test scenario execution record.',
    `assumption_set_id` BIGINT COMMENT 'Reference to the set of actuarial assumptions (mortality, lapse, interest rates, expenses) used in this stress test execution.',
    `orsa_report_id` BIGINT COMMENT 'Reference to the parent ORSA annual filing submission to which this stress test belongs.',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: ORSA stress tests must measure impact on specific investment portfolios (equity crashes, credit downgrades, interest rate shocks) to demonstrate capital adequacy under adverse scenarios. Regulatory OR',
    `employee_id` BIGINT COMMENT 'The user identifier of the actuary or analyst who created this stress test record.',
    `reinsurance_treaty_id` BIGINT COMMENT 'Foreign key linking to reinsurance.treaty. Business justification: ORSA stress tests model treaty impacts under stress scenarios (reinsurer default, recapture) for capital adequacy assessment and ORSA filing. Required for risk management and regulatory reporting.',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: ORSA stress tests are performed for specific reporting periods and results are disclosed in regulatory filings. The valuation_date exists but report_period_id links the stress test to the formal repor',
    `stochastic_scenario_id` BIGINT COMMENT 'Reference to the stress scenario definition applied in this test execution.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: ORSA stress tests produce board presentation materials, regulatory submission packages, and management action documentation required for annual ORSA filings. The board_review_date and regulatory_filin',
    `valuation_run_id` BIGINT COMMENT 'Reference to the actuarial valuation run that produced the baseline reserves and capital metrics for this stress test.',
    `action_plan_description` STRING COMMENT 'Description of the management actions or capital contingency plans identified to address capital inadequacy revealed by this stress test (e.g., Increase reinsurance cession, Reduce new business volume, Raise additional capital).',
    `action_plan_required_flag` BOOLEAN COMMENT 'Indicates whether management action or capital contingency plans are required in response to this stress test result (True if action required, False otherwise).',
    `actuarial_model_version` STRING COMMENT 'The version identifier of the actuarial valuation model (Prophet, AXIS, MoSes) used to execute this stress test.',
    `baseline_acl_amount` DECIMAL(18,2) COMMENT 'The Authorized Control Level RBC amount before applying the stress scenario, used as the denominator in RBC ratio calculations.',
    `baseline_rbc_ratio` DECIMAL(18,2) COMMENT 'The companys RBC ratio before applying the stress scenario, calculated as (baseline_tac_amount / baseline_acl_amount) * 100.',
    `baseline_reserve_amount` DECIMAL(18,2) COMMENT 'The total statutory reserve amount before applying the stress scenario, serving as the starting point for impact measurement.',
    `baseline_tac_amount` DECIMAL(18,2) COMMENT 'The companys Total Adjusted Capital before applying the stress scenario, used as the numerator in RBC ratio calculations.',
    `board_approval_status` STRING COMMENT 'The Board of Directors approval status for this stress test and its conclusions (pending, approved, approved_with_conditions, rejected).. Valid values are `pending|approved|approved_with_conditions|rejected`',
    `board_comments` STRING COMMENT 'Comments or directives provided by the Board of Directors regarding this stress test result and recommended actions.',
    `board_review_date` DATE COMMENT 'The date on which the Board of Directors reviewed this stress test result as part of the ORSA process.',
    `capital_adequacy_conclusion` STRING COMMENT 'The actuarial teams assessment of whether the company maintains adequate capital under this stress scenario (adequate, marginal, inadequate, requires_action).. Valid values are `adequate|marginal|inadequate|requires_action`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this stress test record was first created in the system.',
    `geographic_scope` STRING COMMENT 'The geographic scope of the stress test (e.g., USA, CAN, ALL for enterprise-wide, or specific state codes for state-level analysis).',
    `management_action_assumption` STRING COMMENT 'Description of any management actions assumed in the stress scenario (e.g., No management action, Dynamic hedging activated, Dividend suspension).',
    `peer_comparison_percentile` DECIMAL(18,2) COMMENT 'The companys stressed RBC ratio percentile ranking relative to industry peer group, if available from industry benchmarking studies.',
    `product_segment_code` STRING COMMENT 'The product line or segment to which this stress test applies (e.g., TERM, UL, WL, ANNUITY, ALL for enterprise-wide tests).',
    `rbc_ratio_impact` DECIMAL(18,2) COMMENT 'The change in RBC ratio due to the stress scenario (stressed_rbc_ratio minus baseline_rbc_ratio), expressed in percentage points.',
    `regulatory_action_level` STRING COMMENT 'The NAIC RBC action level that would be triggered under the stressed RBC ratio (no_action, company_action, regulatory_action, authorized_control, mandatory_control).. Valid values are `no_action|company_action|regulatory_action|authorized_control|mandatory_control`',
    `regulatory_filing_flag` BOOLEAN COMMENT 'Indicates whether this stress test result is included in the annual ORSA Summary Report filed with state insurance regulators (True if included, False otherwise).',
    `reinsurance_treatment` STRING COMMENT 'Indicates whether the stress test results reflect gross reserves and capital (before reinsurance), net of reinsurance, or ceded amounts only.. Valid values are `gross|net_of_reinsurance|ceded_only`',
    `reporting_basis` STRING COMMENT 'The accounting basis used for reserve and capital calculations in this stress test (statutory, GAAP, IFRS, economic).. Valid values are `statutory|gaap|ifrs|economic`',
    `reserve_impact_amount` DECIMAL(18,2) COMMENT 'The incremental change in reserves due to the stress scenario (stressed_reserve_amount minus baseline_reserve_amount).',
    `reserve_impact_percentage` DECIMAL(18,2) COMMENT 'The percentage increase or decrease in reserves due to the stress scenario, calculated as (reserve_impact_amount / baseline_reserve_amount) * 100.',
    `scenario_name` STRING COMMENT 'Business-friendly name of the stress scenario (e.g., Pandemic Mortality Shock 2024, Interest Rate Down 200bps).',
    `stress_parameter_description` STRING COMMENT 'Detailed description of the stress parameters applied (e.g., 15% increase in mortality rates across all ages, Immediate 200 basis point parallel shift down in yield curve).',
    `stress_severity_level` STRING COMMENT 'The intensity classification of the stress scenario (mild, moderate, severe, extreme) as defined by the companys ERM framework.. Valid values are `mild|moderate|severe|extreme`',
    `stress_type` STRING COMMENT 'The primary risk category being stressed in this scenario (e.g., mortality shock, lapse shock, interest rate shock, pandemic, equity market shock, credit default shock, expense shock, longevity shock, catastrophe, or combined multi-risk scenario). [ENUM-REF-CANDIDATE: mortality_shock|lapse_shock|interest_rate_shock|pandemic|equity_market_shock|credit_default_shock|expense_shock|longevity_shock|catastrophe|combined_scenario — 10 candidates stripped; promote to reference product]',
    `stressed_acl_amount` DECIMAL(18,2) COMMENT 'The Authorized Control Level RBC amount after applying the stress scenario, reflecting changes in required capital under stress.',
    `stressed_rbc_ratio` DECIMAL(18,2) COMMENT 'The companys RBC ratio after applying the stress scenario, calculated as (stressed_tac_amount / stressed_acl_amount) * 100.',
    `stressed_reserve_amount` DECIMAL(18,2) COMMENT 'The total statutory reserve amount after applying the stress scenario, reflecting the increased liability under stress.',
    `stressed_tac_amount` DECIMAL(18,2) COMMENT 'The companys Total Adjusted Capital after applying the stress scenario, reflecting capital depletion or enhancement under stress.',
    `test_execution_date` DATE COMMENT 'The date on which this stress test scenario was executed by the actuarial team.',
    `time_horizon_years` STRING COMMENT 'The projection time horizon in years over which the stress scenario impact is measured (e.g., 1, 3, 5, 10 years).',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this stress test record was last modified.',
    `valuation_date` DATE COMMENT 'The as-of date for the baseline reserves and capital position being stressed (typically year-end or quarter-end).',
    CONSTRAINT pk_orsa_stress_test PRIMARY KEY(`orsa_stress_test_id`)
) COMMENT 'Transactional records for Own Risk and Solvency Assessment (ORSA) stress test scenarios and results. Captures scenario name, stress type (mortality shock, lapse shock, interest rate shock, pandemic), stressed reserve impact, RBC ratio under stress, capital adequacy conclusion, and board approval status. Supports NAIC ORSA annual filing and ERM framework.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`opinion` (
    `opinion_id` BIGINT COMMENT 'Unique identifier for the actuarial opinion record. Primary key.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: The actuarial opinion IS a document - the signed statement of actuarial opinion with supporting memoranda and asset adequacy testing results. This is the primary regulatory filing artifact required by',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Appointed actuary opinions reference specific products covered in asset adequacy testing scope, reserve adequacy conclusions, and VM-20 stochastic reserve certifications. Required for state regulatory',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Actuarial opinions (Statement of Actuarial Opinion, Asset Adequacy Testing) are filed as regulatory submissions to state DOIs annually. Opinion is a formal regulatory filing with specific due dates an',
    `reinsurance_treaty_id` BIGINT COMMENT 'Foreign key linking to reinsurance.treaty. Business justification: Actuarial opinions disclose material reinsurance treaties and their reserve impact for statutory opinion filing. Required for reserve adequacy certification and regulatory compliance.',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Actuarial opinions are issued for specific reporting periods (typically year-end). The opinion_date and valuation_date exist but report_period_id formally links the opinion to the reporting calendar f',
    `statutory_filing_id` BIGINT COMMENT 'Foreign key linking to reporting.statutory_filing. Business justification: Actuarial opinions are required attachments to statutory filings per NAIC requirements. The Appointed Actuarys Opinion must accompany the Annual Statement filing. This is a mandatory regulatory relat',
    `valuation_run_id` BIGINT COMMENT 'Reference to the actuarial valuation run that this opinion supports. Links to the specific reserve calculation and cash flow projection exercise.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Appointed actuaries may be external consultants (Milliman, Deloitte, PwC). Links opinion to vendor firm for regulatory compliance tracking, credential verification, invoice reconciliation, and vendor ',
    `actuary_credentials` STRING COMMENT 'Professional credentials of the appointed actuary, typically including MAAA (Member of the American Academy of Actuaries), FSA (Fellow of the Society of Actuaries), or equivalent designations required for regulatory opinion work.',
    `additional_reserve_amount` DECIMAL(18,2) COMMENT 'Amount of additional reserves recommended or required by the appointed actuary if reserves are deemed deficient. Zero if reserves are adequate or redundant.',
    `appointed_actuary_name` STRING COMMENT 'Full legal name of the appointed actuary who issued the opinion. Must be an actuary appointed by the Board of Directors per state insurance law.',
    `asset_adequacy_conclusion` STRING COMMENT 'Appointed actuarys conclusion regarding whether reserves and associated assets make adequate provision for the companys obligations under moderately adverse conditions. Core finding of the AOMR.. Valid values are `Adequate|Deficient|Qualified|Not Applicable`',
    `asset_adequacy_testing_scope` STRING COMMENT 'Description of the scope of asset adequacy analysis performed, including product lines covered, testing methodology (cash flow testing, gross premium valuation), and scenarios analyzed.',
    `assumption_changes_disclosed_flag` BOOLEAN COMMENT 'Indicates whether the opinion discloses material changes in actuarial assumptions (mortality, lapse, interest rates) from the prior valuation period.',
    `comments` STRING COMMENT 'Free-form comments or notes regarding the actuarial opinion, including internal review notes, follow-up items, or special considerations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this actuarial opinion record was first created in the system.',
    `document_file_path` STRING COMMENT 'File system or document management system path to the stored actuarial opinion and memorandum documents.',
    `memorandum_included_flag` BOOLEAN COMMENT 'Indicates whether a supporting actuarial memorandum was filed with the opinion. Required for AOMR opinions; optional for SAO-only opinions depending on state requirements.',
    `memorandum_page_count` STRING COMMENT 'Number of pages in the supporting actuarial memorandum document. Provides indication of analysis depth and complexity.',
    `opinion_date` DATE COMMENT 'Date the appointed actuary signed and issued the actuarial opinion. Must be after the valuation date and before the regulatory filing deadline.',
    `opinion_number` STRING COMMENT 'Business identifier for the actuarial opinion, typically assigned by the appointed actuary or actuarial department for tracking and filing purposes.',
    `opinion_status` STRING COMMENT 'Current lifecycle status of the actuarial opinion document. Tracks progression from draft through regulatory filing.. Valid values are `Draft|Under Review|Approved|Filed|Superseded|Withdrawn`',
    `opinion_type` STRING COMMENT 'Type of actuarial opinion: SAO (Statement of Actuarial Opinion per NAIC Annual Statement instructions for reserve adequacy), AOMR (Actuarial Opinion and Memorandum Regulation for asset adequacy analysis), or Combined (both SAO and AOMR in a single filing).. Valid values are `SAO|AOMR|Combined`',
    `pbr_compliant_flag` BOOLEAN COMMENT 'Indicates whether the reserves and opinion comply with Principle-Based Reserving requirements under VM-20 (Valuation Manual Section 20) for life insurance products.',
    `peer_review_performed_flag` BOOLEAN COMMENT 'Indicates whether the actuarial opinion and supporting analysis underwent independent peer review by another qualified actuary before filing.',
    `peer_reviewer_name` STRING COMMENT 'Name of the qualified actuary who performed independent peer review of the opinion and supporting analysis, if applicable.',
    `qualification_reason` STRING COMMENT 'Detailed explanation of any qualifications, limitations, or exceptions noted in the actuarial opinion. Required when qualified_opinion_flag is true.',
    `qualified_opinion_flag` BOOLEAN COMMENT 'Indicates whether the actuarial opinion contains qualifications, limitations, or exceptions to the standard unqualified opinion language. Triggers regulatory scrutiny.',
    `regulatory_action_description` STRING COMMENT 'Description of any regulatory action taken by the state Department of Insurance in response to this actuarial opinion, if applicable.',
    `regulatory_action_flag` BOOLEAN COMMENT 'Indicates whether the state Department of Insurance took any regulatory action in response to this opinion (e.g., requested additional information, required reserve strengthening, initiated examination).',
    `reinsurance_impact_disclosed_flag` BOOLEAN COMMENT 'Indicates whether the opinion explicitly addresses the impact of reinsurance treaties on reserve adequacy and asset adequacy conclusions.',
    `reserve_adequacy_conclusion` STRING COMMENT 'Appointed actuarys professional conclusion regarding whether statutory reserves make good and sufficient provision for all unmatured obligations of the company. Core finding of the SAO.. Valid values are `Adequate|Deficient|Redundant|Qualified`',
    `scenario_count` STRING COMMENT 'Number of economic and business scenarios tested in the asset adequacy analysis, including baseline, moderately adverse, and severely adverse scenarios.',
    `testing_methodology` STRING COMMENT 'Primary actuarial methodology used for asset adequacy analysis. Cash flow testing projects future cash flows under various scenarios; gross premium valuation compares reserves to present value of future obligations.. Valid values are `Cash Flow Testing|Gross Premium Valuation|Stochastic Modeling|Deterministic Scenarios|Combined`',
    `total_reserve_amount` DECIMAL(18,2) COMMENT 'Total statutory reserves subject to the actuarial opinion as of the valuation date, including policy reserves, claim reserves, and other actuarial liabilities.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this actuarial opinion record was last modified in the system.',
    `valuation_date` DATE COMMENT 'As-of date for the reserves and asset adequacy analysis covered by this opinion, typically December 31 for annual statement filings.',
    `vm20_deterministic_reserve_amount` DECIMAL(18,2) COMMENT 'Deterministic reserve component calculated under VM-20 PBR requirements using prescribed deterministic scenarios. Applicable only for PBR-compliant products.',
    `vm20_net_premium_reserve_amount` DECIMAL(18,2) COMMENT 'Net premium reserve floor calculated under VM-20 PBR requirements. The final PBR reserve is the greater of stochastic, deterministic, and net premium reserve.',
    `vm20_stochastic_reserve_amount` DECIMAL(18,2) COMMENT 'Stochastic reserve component calculated under VM-20 PBR requirements using prescribed stochastic scenarios. Applicable only for PBR-compliant products.',
    CONSTRAINT pk_opinion PRIMARY KEY(`opinion_id`)
) COMMENT 'Master records for appointed actuary opinions and supporting memoranda filed with state insurance regulators per NAIC Model Regulation 822. Captures opinion type (SAO — Statement of Actuarial Opinion per NAIC Annual Statement instructions, AOMR — Actuarial Opinion and Memorandum Regulation for asset adequacy analysis), appointed actuary name, MAAA/FSA credentials, opinion date, reserve adequacy conclusion (reserves are adequate/deficient/redundant), asset adequacy testing scope, and state DOI filing reference. Required for NAIC annual statement blank filing and state regulatory compliance.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` (
    `assumption_detail_id` BIGINT COMMENT 'Unique identifier for each assumption detail record. Primary key for the assumption detail product.',
    `assumption_set_id` BIGINT COMMENT 'Foreign key reference to the parent assumption set that governs this detail record. Links this detail to its controlling assumption set for valuation runs and experience studies.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the actuary who approved this assumption detail record. Supports regulatory compliance and audit requirements for assumption governance.',
    `prior_assumption_detail_id` BIGINT COMMENT 'Self-referencing FK on assumption_detail (prior_assumption_detail_id)',
    `approval_date` DATE COMMENT 'The date on which this assumption detail record was formally approved by the appointed actuary or assumption governance committee.',
    `assumption_basis` STRING COMMENT 'The basis or philosophy underlying this assumption detail. Indicates whether the assumption is best-estimate, conservative, prescribed by regulation, based on company experience, industry table, or a blended approach.. Valid values are `best_estimate|conservative|prescribed|company_experience|industry_table|blended`',
    `assumption_detail_status` STRING COMMENT 'Current lifecycle status of this assumption detail record. Indicates whether the assumption is in draft, actively used in valuations, superseded by a newer version, retired, or under review.. Valid values are `draft|active|superseded|retired|under_review`',
    `assumption_subtype` STRING COMMENT 'Granular subtype within the assumption type. Examples: qx (mortality rate), lapse_rate, disability_incidence, per_policy_expense, credited_rate, credibility_weight. Provides additional specificity for the assumption being modeled.',
    `assumption_type` STRING COMMENT 'Type discriminator indicating the category of assumption this detail record represents. Determines which dimensional attributes are applicable and how the rate value should be interpreted.. Valid values are `mortality|lapse|morbidity|expense|interest_rate|credibility`',
    `assumption_version` STRING COMMENT 'Version identifier for this assumption detail record. Supports assumption change tracking and audit trails. Examples: v1.0, v2.1, 2024Q1.',
    `attained_age` STRING COMMENT 'The attained age of the insured for which this assumption rate applies. Used for age-based segmentation in mortality, lapse, and morbidity assumptions. Null if assumption is not age-dependent.',
    `comments` STRING COMMENT 'Free-text comments or notes regarding this assumption detail record. Used for documenting rationale, special considerations, or assumptions about the assumption.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this assumption detail record was first created in the system. Supports audit trail and data lineage requirements.',
    `credibility_factor` DECIMAL(18,2) COMMENT 'Credibility weight applied to company experience versus industry tables. Value between 0 and 1, where 1 represents full credibility to company experience. Used in PBR credibility blending calculations.',
    `data_source_reference` STRING COMMENT 'Reference to the data source or experience study that supports this assumption detail. Examples: experience_study_2023_Q4, SOA_2017CSO, company_mortality_study_2022, industry_lapse_benchmark.',
    `distribution_channel` STRING COMMENT 'Distribution channel for which this assumption rate applies. Examples: career_agent, independent_broker, direct, worksite, bank. Used for channel-based lapse and expense segmentation. Null if assumption is channel-neutral.',
    `effective_date` DATE COMMENT 'The date from which this assumption detail record becomes effective. Used for assumption versioning and time-based assumption changes.',
    `experience_adjustment_factor` DECIMAL(18,2) COMMENT 'Multiplicative adjustment factor applied to base assumption rates based on company experience studies. Values greater than 1 increase the base rate; values less than 1 decrease it. Null if no experience adjustment is applied.',
    `expiration_date` DATE COMMENT 'The date on which this assumption detail record expires or is superseded. Null for currently active assumptions with no planned expiration.',
    `face_amount_band` STRING COMMENT 'Face amount band or size category for which this assumption rate applies. Examples: 0-50k, 50k-100k, 100k-250k, 250k-500k, 500k+. Used for size-based lapse and expense segmentation. Null if assumption is size-neutral.',
    `gender` STRING COMMENT 'Gender classification for which this assumption rate applies. M=Male, F=Female, U=Unisex or Unknown. Used for gender-based segmentation in mortality and morbidity assumptions. Null if assumption is gender-neutral.. Valid values are `M|F|U`',
    `geographic_region` STRING COMMENT 'Geographic region or state code for which this assumption rate applies. Used for regional mortality and lapse segmentation. Null if assumption is geography-neutral.',
    `issue_age_band` STRING COMMENT 'Issue age band for which this assumption rate applies. Examples: 18-30, 31-40, 41-50, 51-60, 61-70, 71+. Used for issue-age-based segmentation in lapse and mortality assumptions. Null if assumption is issue-age-neutral.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this assumption detail record was last modified. Supports change tracking and audit trail requirements.',
    `margin_percentage` DECIMAL(18,2) COMMENT 'Margin percentage added to the base assumption for conservatism or profit loading. Expressed as a percentage. Used in pricing and reserve calculations to provide cushion above best-estimate assumptions.',
    `model_platform` STRING COMMENT 'The actuarial modeling platform or system that uses or generated this assumption detail. Examples: Prophet, AXIS, MoSes, GGY, internal_model. Supports traceability to modeling systems.',
    `mortality_improvement_scale` STRING COMMENT 'Mortality improvement scale applied to the base mortality table. Examples: Scale_G2, Scale_AA, Scale_BB, none. Applicable for mortality assumption types with projected improvements.',
    `mortality_table_reference` STRING COMMENT 'Reference to the base mortality table used for this assumption detail. Examples: 2017CSO, 2001VBT, 2008VBT, 2015VBT, company_experience_table. Applicable for mortality assumption types.',
    `policy_duration` STRING COMMENT 'The policy duration (years since issue) for which this assumption rate applies. Used for duration-based segmentation in lapse and mortality assumptions. Null if assumption is not duration-dependent.',
    `product_segment_code` STRING COMMENT 'Product segment or product type code for which this assumption rate applies. Examples: term, whole_life, universal_life, indexed_universal_life, variable_universal_life. Enables product-specific assumption calibration. Null if assumption applies across all products.',
    `rate_unit` STRING COMMENT 'Unit of measure for the rate_value. Clarifies whether the value is a percentage, decimal fraction, currency amount, per-thousand rate, per-policy amount, or per-unit cost.. Valid values are `percentage|decimal|currency|per_thousand|per_policy|per_unit`',
    `rate_value` DECIMAL(18,2) COMMENT 'The numeric assumption value for this detail record. Interpretation depends on assumption_type: mortality qx, lapse percentage, expense dollar amount, interest rate percentage, credibility factor. Supports high precision for actuarial calculations.',
    `regulatory_basis` STRING COMMENT 'The regulatory or accounting framework for which this assumption detail is intended. Examples: GAAP, SAP (Statutory Accounting Principles), IFRS17, PBR (Principle-Based Reserving), VM-20, tax compliance.. Valid values are `GAAP|SAP|IFRS17|PBR|VM20|tax`',
    `smoker_status` STRING COMMENT 'Smoking status classification for which this assumption rate applies. Used for risk-class segmentation in mortality assumptions. Null if assumption is not smoker-status-dependent.. Valid values are `smoker|non_smoker|preferred|standard|unisex`',
    `underwriting_class` STRING COMMENT 'Underwriting risk class for which this assumption rate applies. Examples: preferred_plus, preferred, standard, substandard, rated. Used for risk-based segmentation in mortality and lapse assumptions. Null if assumption is class-neutral.',
    `valuation_date` DATE COMMENT 'The valuation date for which this assumption detail is calibrated or applicable. Typically aligns with the valuation run date or experience study period end date.',
    CONSTRAINT pk_assumption_detail PRIMARY KEY(`assumption_detail_id`)
) COMMENT 'Typed detail records under an assumption set capturing individual assumption values by assumption type (mortality, lapse, morbidity, expense, interest rate, credibility). Stores rate values by age, duration, gender, risk class, and other segmentation dimensions. Each row is typed (mortality qx, lapse rate, expense per-policy, credited rate, etc.) and linked to its parent assumption_set. Replaces the need for separate mortality_table, lapse_assumption, disability_assumption, expense_assumption, interest_rate_assumption, and credibility_factor products while preserving full granularity. Supports PBR credibility blending, experience study updates, and pricing model calibration.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`model_governance` (
    `model_governance_id` BIGINT COMMENT 'Unique identifier for the actuarial model governance record. Primary key for tracking model validation, change control, and regulatory compliance per ASOP (Actuarial Standards of Practice) No. 56.',
    `sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: Actuarial model governance (validation, change control, peer review) is a key SOX ITGC control for financial reporting. Model risk management is audited under SOX. Links governance process to SOX cont',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Model validation requires formal documentation including validation reports, change control records, peer review documentation, and SOX control testing evidence. The documentation_url attribute sugges',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Model risk management (SR 11-7 principles) requires independent validator with documented credentials. Validator_name is text; FK enables independence verification (not model developer), credential va',
    `valuation_run_id` BIGINT COMMENT 'Reference to the valuation run that this model governance record applies to. Links model governance oversight to specific actuarial valuation executions.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Model validation often performed by external vendors (consulting firms, independent validation specialists). Links governance record to vendor who performed validation for audit trail, vendor credenti',
    `prior_version_model_governance_id` BIGINT COMMENT 'Self-referencing FK on model_governance (prior_version_model_governance_id)',
    `approval_date` DATE COMMENT 'Date when the model or model change was formally approved for production use. Establishes the effective date for governance compliance.',
    `approval_status` STRING COMMENT 'Final approval status for the model or model change. Indicates whether the model is authorized for production use by management and compliance.. Valid values are `approved|rejected|pending|conditional|withdrawn`',
    `approved_by_actuary_name` STRING COMMENT 'Name of the appointed actuary or chief actuary who provided final approval for the model. Critical for regulatory accountability.',
    `change_control_number` STRING COMMENT 'Unique identifier for the change control request associated with model modifications. Links model governance to formal change management processes.',
    `change_description` STRING COMMENT 'Detailed description of changes made to the actuarial model. Documents modifications to assumptions, logic, formulas, or data inputs for audit and regulatory review.',
    `change_effective_date` DATE COMMENT 'Date when the model change becomes effective for production use. Ensures alignment between model versions and reporting periods.',
    `change_type` STRING COMMENT 'Classification of the model change by its nature. Helps prioritize validation efforts and assess risk impact.. Valid values are `assumption_update|logic_change|data_source_change|platform_upgrade|regulatory_compliance|defect_fix`',
    `comments` STRING COMMENT 'Additional notes, observations, or context related to model governance, validation, or regulatory compliance. Supports audit trail and knowledge transfer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this model governance record was first created in the system. Supports audit trail and data lineage tracking.',
    `documentation_url` STRING COMMENT 'URL or file path to the comprehensive model documentation. Provides access to detailed specifications, assumptions, validation reports, and user guides.',
    `impact_on_capital_amount` DECIMAL(18,2) COMMENT 'Estimated dollar impact of the model change on Risk-Based Capital (RBC) or Total Adjusted Capital (TAC). Supports capital adequacy analysis and regulatory reporting.',
    `impact_on_reserves_amount` DECIMAL(18,2) COMMENT 'Estimated dollar impact of the model change on total reserves. Critical for assessing financial statement implications and regulatory capital requirements.',
    `materiality_assessment` STRING COMMENT 'Assessment of whether the model change has a material impact on reserves, capital, or financial reporting. Determines the level of validation and approval required.. Valid values are `material|immaterial|significant|minor`',
    `materiality_threshold_amount` DECIMAL(18,2) COMMENT 'Quantitative threshold in dollars used to determine whether a model change is considered material. Aligns with company-specific materiality policies.',
    `model_name` STRING COMMENT 'Name of the actuarial model platform or system used for valuation and reserving calculations. Examples include Prophet, AXIS, MoSes, or custom internal models.',
    `model_risk_rating` STRING COMMENT 'Overall risk rating assigned to the actuarial model based on complexity, materiality, and potential impact on financial reporting. Drives governance intensity.. Valid values are `high|medium|low`',
    `model_status` STRING COMMENT 'Current lifecycle status of the actuarial model. Indicates whether the model is approved for production use or undergoing validation and testing.. Valid values are `development|testing|validated|production|retired|suspended`',
    `model_type` STRING COMMENT 'Classification of the actuarial model by its primary business purpose. Determines the scope of validation and governance requirements. [ENUM-REF-CANDIDATE: cash_flow_projection|reserve_calculation|pricing|experience_study|stochastic_scenario|alm_analysis|pbr_valuation|other — 8 candidates stripped; promote to reference product]',
    `model_version` STRING COMMENT 'Version identifier for the actuarial model. Tracks model evolution and ensures traceability of changes for audit and regulatory examination purposes.',
    `next_validation_due_date` DATE COMMENT 'Scheduled date for the next periodic model validation. Ensures ongoing compliance with model risk management frameworks and regulatory requirements.',
    `peer_review_date` DATE COMMENT 'Date when the peer review was completed. Documents timeline for model validation and approval processes.',
    `peer_review_required_flag` BOOLEAN COMMENT 'Indicates whether an independent peer review is required for this model change. Typically true for material changes or regulatory-driven modifications.',
    `peer_review_status` STRING COMMENT 'Current status of the peer review process. Tracks whether independent validation by a qualified actuary has been completed and approved.. Valid values are `completed|pending|not_required|in_progress|failed`',
    `peer_reviewer_name` STRING COMMENT 'Name of the independent actuary who conducted the peer review. Ensures accountability and supports audit trail for model governance.',
    `regulatory_action_required_flag` BOOLEAN COMMENT 'Indicates whether regulatory findings require corrective action or model remediation. Triggers follow-up governance processes.',
    `regulatory_examination_date` DATE COMMENT 'Date when the regulatory examination of the model was conducted. Documents timeline for regulatory oversight and compliance verification.',
    `regulatory_examination_flag` BOOLEAN COMMENT 'Indicates whether this model has been subject to regulatory examination by state Department of Insurance (DOI) or other governing bodies. Tracks regulatory scrutiny.',
    `regulatory_findings` STRING COMMENT 'Summary of findings from regulatory examination of the actuarial model. Documents any deficiencies, recommendations, or required corrective actions.',
    `sox_control_applicable_flag` BOOLEAN COMMENT 'Indicates whether this model is subject to SOX internal controls over financial reporting. Determines audit and documentation requirements.',
    `sox_control_test_date` DATE COMMENT 'Date when SOX controls over the actuarial model were last tested. Supports annual SOX compliance certification and audit readiness.',
    `sox_control_test_result` STRING COMMENT 'Outcome of SOX control testing for the actuarial model. Documents whether controls are operating effectively to prevent material misstatement.. Valid values are `effective|ineffective|not_tested|remediation_required`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this model governance record was last modified. Tracks changes to governance status, validation results, or approval decisions.',
    `validation_date` DATE COMMENT 'Date when the model validation was completed. Critical for demonstrating compliance with regulatory model risk management frameworks and SOX (Sarbanes-Oxley Act) controls.',
    `validation_frequency` STRING COMMENT 'Required frequency for periodic model validation. Determined by model materiality, complexity, and regulatory requirements.. Valid values are `annual|semi_annual|quarterly|ad_hoc|as_needed`',
    `validation_status` STRING COMMENT 'Outcome of the model validation process. Indicates whether the model meets accuracy, reliability, and regulatory compliance standards.. Valid values are `passed|failed|conditional|pending|not_required`',
    CONSTRAINT pk_model_governance PRIMARY KEY(`model_governance_id`)
) COMMENT 'Master records for actuarial model governance tracking model validation, change control, and regulatory compliance per ASOP No. 56 (Modeling). Captures model name (Prophet, AXIS, MoSes), model version, validation date, validator credentials, change description, materiality assessment, peer review status, and regulatory examination findings. Supports SOX controls over actuarial models, state DOI model audit responses, and internal model risk management frameworks.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` (
    `mortality_table_id` BIGINT COMMENT 'Unique identifier for the mortality table record. Primary key for the mortality table reference catalog.',
    `experience_study_id` BIGINT COMMENT 'Foreign key reference to the experience study that provided the empirical data foundation for this mortality table. Applicable for company-specific or industry experience-based tables. Null for prescribed regulatory tables.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Mortality tables are approved for specific product types per state insurance department filings. Each product filing specifies approved mortality tables for pricing, reserving, and nonforfeiture value',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that created the mortality table record. Supports audit trail and accountability for data governance.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Mortality tables are licensed from external vendors (SOA, RGA, Munich Re). Critical for tracking data source, license compliance, renewal management, and vendor credential verification. Required for r',
    `base_mortality_table_id` BIGINT COMMENT 'Self-referencing FK on mortality_table (base_mortality_table_id)',
    `approval_date` DATE COMMENT 'Date on which the mortality table was formally approved for use by the appointed actuary or governance committee. Null for externally prescribed tables that do not require internal approval.',
    `approved_by_actuary_name` STRING COMMENT 'Full name of the appointed actuary or qualified actuary who approved the mortality table for use in the company. Required for company-specific tables; may be null for externally prescribed tables.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the mortality table record was first created in the system. Represents the audit trail for data lineage and governance.',
    `credibility_factor` DECIMAL(18,2) COMMENT 'Statistical credibility weight (0.0000 to 1.0000) assigned to company-specific experience data when blending with industry standard tables. Higher values indicate greater reliance on company experience. Null for fully prescribed tables.',
    `data_source_reference` STRING COMMENT 'Reference to the underlying data source or experience study that informed the mortality table construction (e.g., SOA 2008 VBT Study, Company Experience 2015-2020, Industry Aggregate Data). Provides traceability to empirical foundation.',
    `documentation_url` STRING COMMENT 'URL or file path to the detailed documentation, technical specifications, or actuarial memorandum describing the mortality table construction, assumptions, and usage guidelines.',
    `effective_date` DATE COMMENT 'Date on which the mortality table becomes effective for use in actuarial calculations, pricing, or valuation. Policies issued or valued on or after this date use this table.',
    `expiration_date` DATE COMMENT 'Date on which the mortality table is no longer valid for new use. Null if the table remains active indefinitely. Policies issued before this date may continue to use the table per their original terms.',
    `gaap_compliant_flag` BOOLEAN COMMENT 'Indicates whether the mortality table is acceptable for use under US GAAP accounting, including Long Duration Targeted Improvements (LDTI) under ASC 944. True if compliant, False otherwise.',
    `gender_basis` STRING COMMENT 'Gender segmentation approach used in the mortality table: male (male-only rates), female (female-only rates), unisex (blended rates), gender_distinct (separate male/female rates within same table), or composite (weighted average).. Valid values are `male|female|unisex|gender_distinct|composite`',
    `ifrs17_compliant_flag` BOOLEAN COMMENT 'Indicates whether the mortality table is suitable for use under IFRS 17 insurance contract accounting standards. True if compliant, False otherwise.',
    `issue_age_max` STRING COMMENT 'Maximum issue age for which the mortality table is applicable. Defines the oldest age at policy issuance for which the table provides rates.',
    `issue_age_min` STRING COMMENT 'Minimum issue age for which the mortality table is applicable. Defines the youngest age at policy issuance for which the table provides rates.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the mortality table record was most recently updated. Tracks changes for audit and version control purposes.',
    `margin_percentage` DECIMAL(18,2) COMMENT 'Percentage margin (expressed as decimal, e.g., 0.0500 for 5%) added to best-estimate mortality rates for conservatism in valuation or pricing. Represents the prudence adjustment for adverse deviation. Null if no explicit margin is applied.',
    `mortality_improvement_scale` STRING COMMENT 'Reference to the mortality improvement scale applied to the base table to project future mortality improvements (e.g., Scale G2, Scale AA, MP-2021). Null if no improvement scale is applied (static table).',
    `notes` STRING COMMENT 'Free-form text field for additional comments, usage restrictions, special considerations, or actuarial notes regarding the mortality table. May include guidance on appropriate application contexts or known limitations.',
    `pbr_compliant_flag` BOOLEAN COMMENT 'Indicates whether the mortality table meets the requirements for Principle-Based Reserving (PBR) under NAIC Valuation Manual VM-20. True if compliant, False otherwise.',
    `predecessor_table_code` STRING COMMENT 'Code of the mortality table that this table supersedes or replaces. Null if this is an original table with no predecessor. Provides backward lineage tracking.',
    `product_applicability` STRING COMMENT 'Comma-separated list or description of product types for which this mortality table is applicable (e.g., Term Life, Whole Life, Universal Life (UL), Indexed Universal Life (IUL), Variable Universal Life (VUL), Single Premium Immediate Annuity (SPIA), Deferred Annuity).',
    `publication_date` DATE COMMENT 'Date on which the mortality table was officially published or released by the issuing organization (NAIC, SOA, or company). May differ from the effective date.',
    `regulatory_basis` STRING COMMENT 'Indicates whether the mortality table is prescribed by a regulatory body (NAIC-prescribed for statutory compliance), published by the Society of Actuaries (SOA), company-specific (based on internal experience studies), international (IFRS/IAS compliant), or custom (proprietary development).. Valid values are `naic_prescribed|company_specific|soa_published|international|custom`',
    `sap_compliant_flag` BOOLEAN COMMENT 'Indicates whether the mortality table is prescribed or permitted for use under Statutory Accounting Principles (SAP) for regulatory financial reporting. True if compliant, False otherwise.',
    `select_period_years` STRING COMMENT 'Number of years in the select period during which mortality rates reflect the impact of recent underwriting. After the select period, rates transition to ultimate rates. Null if the table has no select period (ultimate-only table).',
    `smoker_class` STRING COMMENT 'Smoking status segmentation in the mortality table: smoker (tobacco users), non_smoker (non-tobacco users), aggregate (blended rates), preferred_non_smoker (best non-smoker class), standard_non_smoker (standard non-smoker class), or tobacco_user (broader tobacco definition).. Valid values are `smoker|non_smoker|aggregate|preferred_non_smoker|standard_non_smoker|tobacco_user`',
    `superseded_by_table_code` STRING COMMENT 'Code of the mortality table that replaces this table. Null if the table has not been superseded. Used to track table version lineage and ensure proper transition to updated tables.',
    `table_code` STRING COMMENT 'Standardized code identifier for the mortality table (e.g., CSO2017, VBT2015, 2001CSO). Used as the business key for referencing the table in actuarial systems.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `table_name` STRING COMMENT 'Full descriptive name of the mortality table (e.g., 2017 Commissioners Standard Ordinary Mortality Table, 2015 Valuation Basic Table).',
    `table_status` STRING COMMENT 'Current lifecycle status of the mortality table: active (currently in use), superseded (replaced by newer table), archived (historical reference only), pending_approval (awaiting regulatory or actuarial approval), or withdrawn (no longer valid).. Valid values are `active|superseded|archived|pending_approval|withdrawn`',
    `table_type` STRING COMMENT 'Classification of the mortality table by its intended actuarial use: valuation (statutory reserve calculations), pricing (product development), underwriting (risk assessment), experience (company-specific studies), reinsurance (treaty pricing), or illustration (sales projections).. Valid values are `valuation|pricing|underwriting|experience|reinsurance|illustration`',
    `ultimate_age_max` STRING COMMENT 'Maximum attained age covered by the ultimate mortality rates in the table. Represents the oldest age for which mortality rates are defined, typically 100, 110, or 120.',
    `ultimate_age_min` STRING COMMENT 'Minimum attained age covered by the ultimate mortality rates in the table. Typically the age at which select period ends or the youngest age in an ultimate-only table.',
    `underwriting_class` STRING COMMENT 'Risk classification tier for which the mortality table applies: preferred_plus (super-preferred), preferred, standard_plus, standard, substandard (rated), aggregate (all classes combined), simplified_issue (limited underwriting), or guaranteed_issue (no medical underwriting). [ENUM-REF-CANDIDATE: preferred_plus|preferred|standard_plus|standard|substandard|aggregate|simplified_issue|guaranteed_issue — 8 candidates stripped; promote to reference product]',
    `version_number` STRING COMMENT 'Version identifier for the mortality table (e.g., 1.0, 2.1, 3.0.1). Used to track revisions and updates to company-specific or custom tables. Null for static regulatory tables.. Valid values are `^[0-9]{1,3}(.[0-9]{1,3}){0,2}$`',
    CONSTRAINT pk_mortality_table PRIMARY KEY(`mortality_table_id`)
) COMMENT 'Reference catalog of mortality tables used in actuarial valuations, pricing, and underwriting — CSO 2001, CSO 2017, VBT 2015, select and ultimate tables, smoker/non-smoker variants, and company-specific experience tables. Captures table name, table type (valuation/pricing/underwriting), gender basis, smoking class, select period, ultimate age, regulatory basis (NAIC-prescribed vs company), effective date, and superseded-by reference.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`alm_strategy` (
    `alm_strategy_id` BIGINT COMMENT 'Unique surrogate identifier for each cohort-portfolio ALM strategy pairing. Primary key.',
    `cohort_definition_id` BIGINT COMMENT 'Foreign key linking to the liability cohort being backed by this ALM strategy',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to the investment portfolio backing this cohort under this ALM strategy',
    `alm_strategy_type` STRING COMMENT 'The type of ALM strategy employed for this cohort-portfolio pairing: cash_flow_matching (match liability cash flows), duration_matching (match modified duration), immunization (match duration and convexity), dynamic_hedging (active derivative overlay), liability_driven_investment (LDI approach).',
    `effective_date` DATE COMMENT 'The date on which this ALM strategy pairing became effective. Supports historical tracking of ALM strategy changes over time.',
    `investment_committee_approval_date` DATE COMMENT 'The date on which the investment committee formally approved this ALM strategy pairing. Required for governance and audit trail.',
    `last_rebalancing_date` DATE COMMENT 'The date on which this cohort-portfolio pairing was last rebalanced to target allocation. Used to track rebalancing frequency and compliance.',
    `notes` STRING COMMENT 'Free-text notes documenting the rationale, constraints, or special considerations for this specific cohort-portfolio ALM strategy pairing.',
    `rebalancing_threshold_pct` DECIMAL(18,2) COMMENT 'The maximum allowable percentage drift from the target allocation before rebalancing is triggered for this cohort-portfolio pairing. Specific to this ALM strategy.',
    `strategy_status` STRING COMMENT 'Current lifecycle status of this ALM strategy pairing: active (currently in force), pending_approval (awaiting investment committee approval), suspended (temporarily inactive), terminated (no longer in use).',
    `target_allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the cohorts liabilities that should be backed by this specific portfolio. Multiple portfolios may back a single cohort, with allocation percentages summing to 100%.',
    `target_duration_years` DECIMAL(18,2) COMMENT 'The target modified duration in years for the portfolio to match the liability duration of the cohort. This is the core ALM matching metric to manage interest rate risk.',
    `termination_date` DATE COMMENT 'The date on which this ALM strategy pairing was terminated or superseded. Null if currently active. Supports historical tracking.',
    CONSTRAINT pk_alm_strategy PRIMARY KEY(`alm_strategy_id`)
) COMMENT 'This association product represents the operational Asset-Liability Management (ALM) strategy linking liability cohorts to investment portfolios. Each record captures the strategic pairing of a cohort_definition (representing insurance liabilities under LDTI/IFRS 17) to a portfolio (representing backing assets), including target duration matching, allocation weights, rebalancing rules, and effective dates. This is the core operational mechanism by which life insurers match liability cash flows to asset portfolios to manage interest rate risk, liquidity risk, and regulatory capital requirements.. Existence Justification: Life insurers operationally manage Asset-Liability Management (ALM) by strategically pairing liability cohorts (LDTI/IFRS 17 groups) to investment portfolios with matching duration and risk profiles. A single cohort is routinely backed by multiple portfolios for diversification across asset classes (e.g., fixed income, equity, alternatives), and a single portfolio commonly backs multiple cohorts for operational efficiency and scale. The ALM function actively creates, monitors, and rebalances these pairings with specific target durations, allocation weights, rebalancing thresholds, and effective dates.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`assumption_application` (
    `assumption_application_id` BIGINT COMMENT 'Unique identifier for this assumption application record. Primary key.',
    `assumption_set_id` BIGINT COMMENT 'Foreign key linking to the actuarial assumption set being applied',
    `employee_id` BIGINT COMMENT 'Identifier of the appointed actuary or actuarial officer who approved this specific assumption application to this product plan.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to the product plan to which the assumption set is applied',
    `application_status` STRING COMMENT 'Current lifecycle status of this assumption application: active (in use for this product), pending_approval (awaiting actuarial sign-off), superseded (replaced by newer assumption set), retired (no longer applicable).',
    `approval_date` DATE COMMENT 'The date on which this specific assumption set application to this product plan was formally approved by the appointed actuary or actuarial committee. Tracks product-specific approval rather than global assumption set approval.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this assumption application record was created in the system.',
    `effective_date` DATE COMMENT 'The date from which this assumption set becomes effective for use with this specific product plan. Moved from assumption_set because effective dates vary by product application.',
    `expiration_date` DATE COMMENT 'The date on which this assumption set ceases to be valid for this specific product plan. Null indicates ongoing applicability. Moved from assumption_set because expiration dates vary by product application.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this assumption application record was last modified.',
    `override_flag` BOOLEAN COMMENT 'Indicates whether this assumption application includes product-specific overrides or adjustments to the base assumption set parameters.',
    `override_notes` STRING COMMENT 'Free-text description of any product-specific assumption overrides or adjustments applied in this assumption application.',
    `regulatory_basis` STRING COMMENT 'The regulatory or accounting framework this assumption application supports for this product: GAAP, SAP (Statutory Accounting Principles), IFRS17, Tax, or Solvency II. Moved from assumption_set because regulatory basis varies by product and jurisdiction.',
    `usage_purpose` STRING COMMENT 'The specific purpose for which this assumption set is applied to this product plan: valuation (reserve calculations), pricing (new product development), illustration (sales support), experience_study (assumption review), repricing (rate adjustment), regulatory_filing (compliance reporting).',
    CONSTRAINT pk_assumption_application PRIMARY KEY(`assumption_application_id`)
) COMMENT 'This association product represents the application of actuarial assumption sets to specific product plans. It captures the effective period, regulatory basis, usage purpose, and approval status for each assumption set applied to each product plan. Each record links one assumption_set to one product_plan with attributes that exist only in the context of this relationship, enabling assumption governance, regulatory compliance tracking, and product-specific assumption management across valuation, pricing, and illustration purposes.. Existence Justification: In life insurance actuarial operations, assumption sets are applied to multiple products across different purposes (pricing, valuation, illustration), and each product uses multiple assumption sets for different regulatory bases (GAAP, SAP, IFRS17) and business purposes. Actuaries actively manage these applications with product-specific effective dates, approval workflows, and override parameters. This is a core operational relationship in assumption governance.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` (
    `assumption_data_source_id` BIGINT COMMENT 'Unique identifier for this assumption-vendor data sourcing relationship. Primary key.',
    `assumption_set_id` BIGINT COMMENT 'Foreign key linking to the actuarial assumption set that incorporates vendor-supplied data',
    `employee_id` BIGINT COMMENT 'Identifier of the actuary or data governance officer responsible for managing this vendor data source relationship and ensuring compliance with license terms',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor providing the data source (mortality tables, lapse studies, benchmarks)',
    `assumption_data_source_status` STRING COMMENT 'Current status of this vendor data source usage relationship (active, expired, superseded by newer data, under review)',
    `cost_allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the vendor data source license cost allocated to this specific assumption set, used for cost accounting and expense attribution across multiple assumption sets using the same vendor data',
    `data_source_type` STRING COMMENT 'The type of actuarial data provided by the vendor and incorporated into this assumption set (e.g., mortality table from SOA, lapse study from RGA, expense benchmark from LIMRA)',
    `data_version` STRING COMMENT 'The specific version or edition of the vendor data source used in this assumption set (e.g., 2017 CSO, Q3 2024 Lapse Study, LIMRA 2023 Expense Benchmark)',
    `incorporation_date` DATE COMMENT 'The date when this vendor data source was incorporated into the assumption set',
    `license_cost_amount` DECIMAL(18,2) COMMENT 'The total annual or one-time license cost for this vendor data source, used in conjunction with cost_allocation_percentage for expense tracking',
    `license_end_date` DATE COMMENT 'The expiration date of the license to use this vendor data source, after which usage must cease or be renewed',
    `license_start_date` DATE COMMENT 'The effective date from which the insurer is licensed to use this vendor data source in actuarial calculations',
    `notes` STRING COMMENT 'Free-text notes documenting special considerations, restrictions, or context for this vendor data source usage (e.g., approved for term products only, requires annual recalibration)',
    `usage_scope` STRING COMMENT 'Description of the permitted usage scope for this vendor data source (e.g., valuation only, pricing and valuation, internal use only, regulatory filing permitted)',
    `vendor_contact_name` STRING COMMENT 'The name of the vendor representative or account manager responsible for this data source licensing relationship',
    CONSTRAINT pk_assumption_data_source PRIMARY KEY(`assumption_data_source_id`)
) COMMENT 'This association product represents the data sourcing relationship between actuarial assumption sets and external vendor data providers. It captures the licensing, usage scope, and cost allocation for vendor-supplied data (mortality tables, lapse studies, expense benchmarks) incorporated into assumption sets. Each record links one assumption set to one vendor data source with attributes governing the terms of use, effective periods, and financial arrangements specific to that data usage relationship.. Existence Justification: In life insurance actuarial operations, assumption sets routinely incorporate data from multiple external vendors (SOA mortality tables, RGA lapse studies, LIMRA expense benchmarks, reinsurer assumptions), and each vendors data products are used across multiple assumption sets for different product lines, valuation dates, and regulatory bases. The business actively manages these data sourcing relationships with specific license terms, usage restrictions, cost allocations, and version tracking that belong to neither the assumption set nor the vendor alone.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`scenario_set` (
    `scenario_set_id` BIGINT COMMENT 'Primary key for scenario_set',
    `base_scenario_set_id` BIGINT COMMENT 'Self-referencing FK on scenario_set (base_scenario_set_id)',
    `approval_date` DATE COMMENT 'Date on which the scenario set was formally approved for use by the appropriate governance authority.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or committee who approved this scenario set for production use.',
    `calibration_date` DATE COMMENT 'Date as of which the scenario set was calibrated to market conditions and economic data.',
    `confidence_level` DECIMAL(18,2) COMMENT 'Statistical confidence level for scenario set results, expressed as a decimal (e.g., 0.9500 for 95% confidence). Used in CTE (Conditional Tail Expectation) calculations.',
    `created_by_user` STRING COMMENT 'User identifier or name of the individual who created this scenario set record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this scenario set record was first created in the system.',
    `credit_spread_model` STRING COMMENT 'Name of the credit spread model used for corporate bond scenarios in the set.',
    `documentation_reference` STRING COMMENT 'Reference to detailed documentation, methodology papers, or model validation reports for this scenario set.',
    `economic_scenario_generator` STRING COMMENT 'Name or identifier of the economic scenario generator software or model used to produce this scenario set (e.g., Conning, Milliman GEMS, Moodys RiskIntegrity).',
    `effective_end_date` DATE COMMENT 'Date after which this scenario set is no longer valid or approved for use. Null for open-ended scenario sets.',
    `effective_start_date` DATE COMMENT 'Date from which this scenario set becomes effective and available for use in actuarial models.',
    `equity_model` STRING COMMENT 'Name of the equity return model used in the scenario set (e.g., Geometric Brownian Motion, Regime-Switching).',
    `esg_version` STRING COMMENT 'Version number or release identifier of the economic scenario generator used.',
    `geographic_scope` STRING COMMENT 'Geographic market or region for which the scenario set is calibrated, using 3-letter country codes or scope descriptors.',
    `interest_rate_model` STRING COMMENT 'Name of the interest rate model used in the scenario set (e.g., Cox-Ingersoll-Ross, Hull-White, Black-Karasinski).',
    `mean_reversion_parameter` DECIMAL(18,2) COMMENT 'Mean reversion speed parameter used in interest rate or economic models, if applicable.',
    `modeling_purpose` STRING COMMENT 'Primary business purpose for which this scenario set is designed: valuation, pricing, forecasting, capital planning, risk management, or regulatory reporting.',
    `modified_by_user` STRING COMMENT 'User identifier or name of the individual who last modified this scenario set record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this scenario set record was last modified or updated.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or recalibration of this scenario set.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special considerations regarding this scenario set.',
    `product_line_applicability` STRING COMMENT 'Insurance product lines for which this scenario set is designed or approved (e.g., term life, universal life, variable annuities, fixed annuities).',
    `projection_horizon_years` STRING COMMENT 'Number of years into the future that scenarios in this set project, representing the modeling time horizon.',
    `regulatory_framework` STRING COMMENT 'Regulatory or accounting framework this scenario set supports: GAAP (Generally Accepted Accounting Principles), Statutory (SAP), IFRS 17, VM-20 (Valuation Manual), C-3 Phase I/II, ORSA (Own Risk and Solvency Assessment), Solvency II, or none.',
    `risk_neutral_flag` BOOLEAN COMMENT 'Indicates whether the scenario set uses risk-neutral (market-consistent) assumptions (True) or real-world assumptions (False).',
    `scenario_count` STRING COMMENT 'Total number of individual scenarios included in this scenario set.',
    `scenario_set_code` STRING COMMENT 'Business identifier code for the scenario set, used for external reference and reporting.',
    `scenario_set_description` STRING COMMENT 'Detailed description of the scenario set including its purpose, assumptions, and intended use cases.',
    `scenario_set_name` STRING COMMENT 'Human-readable name of the scenario set describing its purpose or use case.',
    `scenario_type` STRING COMMENT 'Classification of the scenario set by modeling approach: deterministic (single outcome), stochastic (probabilistic), stress test, sensitivity analysis, baseline, or adverse.',
    `seed_value` BIGINT COMMENT 'Random number generator seed value used to produce stochastic scenarios, enabling reproducibility of results.',
    `scenario_set_status` STRING COMMENT 'Current lifecycle status of the scenario set: draft (under development), approved (validated but not yet active), active (in production use), archived (historical reference), deprecated (no longer recommended), or under review (validation in progress).',
    `stochastic_trial_count` STRING COMMENT 'Number of stochastic trials or paths generated for stochastic scenario sets. Null for deterministic scenarios.',
    `tail_percentile` DECIMAL(18,2) COMMENT 'Percentile threshold for tail risk analysis (e.g., 0.9000 for 90th percentile), used in CTE and stress testing.',
    `time_step_frequency` STRING COMMENT 'Frequency of time steps within scenario projections: monthly, quarterly, annual, or daily intervals.',
    `validation_date` DATE COMMENT 'Date on which the most recent independent validation of this scenario set was completed.',
    `validation_status` STRING COMMENT 'Current status of independent model validation for this scenario set.',
    `valuation_date` DATE COMMENT 'Effective date for which this scenario set is intended to be used in actuarial valuations or projections.',
    `volatility_assumption` DECIMAL(18,2) COMMENT 'Base volatility assumption used in stochastic modeling, expressed as a decimal (e.g., 0.1500 for 15% volatility).',
    CONSTRAINT pk_scenario_set PRIMARY KEY(`scenario_set_id`)
) COMMENT 'Master reference table for scenario_set. Referenced by scenario_set_id.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`liability_segment` (
    `liability_segment_id` BIGINT COMMENT 'Primary key for liability_segment',
    `parent_liability_segment_id` BIGINT COMMENT 'Self-referencing FK on liability_segment (parent_liability_segment_id)',
    `alm_analysis_flag` BOOLEAN COMMENT 'Indicates whether this liability segment is included in Asset Liability Management analysis and duration matching studies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this liability segment record was first created in the system.',
    `dac_amortization_method` STRING COMMENT 'Method used for amortizing deferred acquisition costs for this liability segment under GAAP accounting.',
    `liability_segment_description` STRING COMMENT 'Detailed business description of the liability segment including scope, purpose, and key characteristics for actuarial and financial reporting.',
    `distribution_channel` STRING COMMENT 'Primary distribution channel through which policies in this liability segment are sold, affecting commission and expense assumptions.',
    `effective_date` DATE COMMENT 'Date when this liability segment became effective and available for use in actuarial valuations and reserve calculations.',
    `experience_study_frequency` STRING COMMENT 'Frequency at which actuarial experience studies are performed for this liability segment to update assumptions.',
    `gaap_reporting_flag` BOOLEAN COMMENT 'Indicates whether this liability segment is included in GAAP financial reporting and reserve calculations.',
    `geographic_market` STRING COMMENT 'Primary geographic market or country code where policies in this liability segment are issued, affecting regulatory and tax treatment.',
    `ifrs_reporting_flag` BOOLEAN COMMENT 'Indicates whether this liability segment is included in IFRS 17 financial reporting and reserve calculations.',
    `interest_rate_scenario` STRING COMMENT 'Type of interest rate scenario applied to this liability segment for cash flow projections and reserve calculations under PBR.',
    `lapse_assumption_table_code` STRING COMMENT 'Standard lapse assumption table code used for cash flow projections and reserve calculations for this liability segment.',
    `last_modified_by` STRING COMMENT 'User identifier or system account that last modified this liability segment record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this liability segment record was last modified or updated in the system.',
    `ldti_applicable_flag` BOOLEAN COMMENT 'Indicates whether GAAP LDTI accounting standards apply to this liability segment for financial reporting.',
    `mortality_table_code` STRING COMMENT 'Standard mortality table code used for reserve calculations and experience studies for this liability segment (e.g., 2017 CSO, 2012 IAM).',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this liability segment for actuarial valuation and reserve calculation purposes.',
    `orsa_reporting_flag` BOOLEAN COMMENT 'Indicates whether this liability segment is included in ORSA regulatory reporting and risk capital calculations.',
    `pbr_applicable_flag` BOOLEAN COMMENT 'Indicates whether Principle-Based Reserving under VM-20 applies to this liability segment for reserve calculations.',
    `pricing_basis` STRING COMMENT 'Pricing basis used for policies in this liability segment affecting reserve calculations and profitability analysis.',
    `product_line_code` STRING COMMENT 'Business product line code grouping this liability segment for management reporting and profitability analysis.',
    `regulatory_jurisdiction` STRING COMMENT 'Primary regulatory jurisdiction or state insurance department governing this liability segment for compliance and reporting purposes. [ENUM-REF-CANDIDATE: state codes — promote to reference product]',
    `reinsurance_treaty_applicable_flag` BOOLEAN COMMENT 'Indicates whether this liability segment is subject to reinsurance treaty arrangements affecting reserve calculations.',
    `reserve_margin_percentage` DECIMAL(18,2) COMMENT 'Standard reserve margin percentage applied to this liability segment for conservatism in reserve calculations, expressed as a percentage.',
    `reserve_methodology` STRING COMMENT 'Primary reserve calculation methodology applied to this liability segment for statutory and regulatory reserve requirements.',
    `risk_based_capital_category` STRING COMMENT 'Primary Risk-Based Capital category classification for this liability segment used in regulatory capital calculations.',
    `sap_reporting_flag` BOOLEAN COMMENT 'Indicates whether this liability segment is included in SAP statutory financial reporting and reserve calculations.',
    `segment_category` STRING COMMENT 'High-level business category grouping for the liability segment used in financial statement aggregation and regulatory reporting.',
    `segment_code` STRING COMMENT 'Business identifier code for the liability segment used in actuarial reporting and reserve calculations. Externally-known unique code used across GAAP, SAP, and IFRS reporting.',
    `segment_name` STRING COMMENT 'Full descriptive name of the liability segment for business user identification and reporting purposes.',
    `segment_type` STRING COMMENT 'Classification of the liability segment by product line. Determines applicable reserve methodologies and regulatory requirements.',
    `liability_segment_status` STRING COMMENT 'Current lifecycle status of the liability segment indicating whether it is actively used in reserve calculations and financial reporting.',
    `tax_treatment_code` STRING COMMENT 'Tax treatment classification for policies in this liability segment affecting reserve calculations and financial reporting.',
    `termination_date` DATE COMMENT 'Date when this liability segment was terminated or closed for new business. Null for open-ended segments still in use.',
    `valuation_system_code` STRING COMMENT 'Primary actuarial valuation system used for reserve calculations and cash flow projections for this liability segment (e.g., Prophet, AXIS, MoSes).',
    `created_by` STRING COMMENT 'User identifier or system account that created this liability segment record.',
    CONSTRAINT pk_liability_segment PRIMARY KEY(`liability_segment_id`)
) COMMENT 'Master reference table for liability_segment. Referenced by liability_segment_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_liability_segment_id` FOREIGN KEY (`liability_segment_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`liability_segment`(`liability_segment_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_pbr_model_segment_id` FOREIGN KEY (`pbr_model_segment_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pbr_model_segment`(`pbr_model_segment_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ADD CONSTRAINT `fk_actuarial_valuation_run_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ADD CONSTRAINT `fk_actuarial_assumption_set_experience_study_id` FOREIGN KEY (`experience_study_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`experience_study`(`experience_study_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ADD CONSTRAINT `fk_actuarial_assumption_set_parent_assumption_set_id` FOREIGN KEY (`parent_assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ADD CONSTRAINT `fk_actuarial_cash_flow_projection_stochastic_scenario_id` FOREIGN KEY (`stochastic_scenario_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`stochastic_scenario`(`stochastic_scenario_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ADD CONSTRAINT `fk_actuarial_cash_flow_projection_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ADD CONSTRAINT `fk_actuarial_experience_study_result_experience_study_id` FOREIGN KEY (`experience_study_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`experience_study`(`experience_study_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ADD CONSTRAINT `fk_actuarial_pbr_model_segment_liability_segment_id` FOREIGN KEY (`liability_segment_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`liability_segment`(`liability_segment_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ADD CONSTRAINT `fk_actuarial_pbr_model_segment_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ADD CONSTRAINT `fk_actuarial_stochastic_scenario_scenario_set_id` FOREIGN KEY (`scenario_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`scenario_set`(`scenario_set_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ADD CONSTRAINT `fk_actuarial_reserve_snapshot_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ADD CONSTRAINT `fk_actuarial_reserve_snapshot_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ADD CONSTRAINT `fk_actuarial_pricing_basis_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ADD CONSTRAINT `fk_actuarial_pricing_basis_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ADD CONSTRAINT `fk_actuarial_cohort_definition_liability_segment_id` FOREIGN KEY (`liability_segment_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`liability_segment`(`liability_segment_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ADD CONSTRAINT `fk_actuarial_tax_qualification_test_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ADD CONSTRAINT `fk_actuarial_ifrs17_csm_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ADD CONSTRAINT `fk_actuarial_ifrs17_csm_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ADD CONSTRAINT `fk_actuarial_orsa_stress_test_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ADD CONSTRAINT `fk_actuarial_orsa_stress_test_stochastic_scenario_id` FOREIGN KEY (`stochastic_scenario_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`stochastic_scenario`(`stochastic_scenario_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ADD CONSTRAINT `fk_actuarial_orsa_stress_test_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ADD CONSTRAINT `fk_actuarial_opinion_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ADD CONSTRAINT `fk_actuarial_assumption_detail_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ADD CONSTRAINT `fk_actuarial_assumption_detail_prior_assumption_detail_id` FOREIGN KEY (`prior_assumption_detail_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_detail`(`assumption_detail_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ADD CONSTRAINT `fk_actuarial_model_governance_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ADD CONSTRAINT `fk_actuarial_model_governance_prior_version_model_governance_id` FOREIGN KEY (`prior_version_model_governance_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`model_governance`(`model_governance_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ADD CONSTRAINT `fk_actuarial_mortality_table_experience_study_id` FOREIGN KEY (`experience_study_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`experience_study`(`experience_study_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ADD CONSTRAINT `fk_actuarial_mortality_table_base_mortality_table_id` FOREIGN KEY (`base_mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_strategy` ADD CONSTRAINT `fk_actuarial_alm_strategy_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_application` ADD CONSTRAINT `fk_actuarial_assumption_application_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` ADD CONSTRAINT `fk_actuarial_assumption_data_source_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`scenario_set` ADD CONSTRAINT `fk_actuarial_scenario_set_base_scenario_set_id` FOREIGN KEY (`base_scenario_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`scenario_set`(`scenario_set_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`liability_segment` ADD CONSTRAINT `fk_actuarial_liability_segment_parent_liability_segment_id` FOREIGN KEY (`parent_liability_segment_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`liability_segment`(`liability_segment_id`);

-- ========= TAGS =========
ALTER SCHEMA `life_insurance_ecm`.`actuarial` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `life_insurance_ecm`.`actuarial` SET TAGS ('dbx_domain' = 'actuarial');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` SET TAGS ('dbx_subdomain' = 'reserve_management');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `reserve_calculation_id` SET TAGS ('dbx_business_glossary_term' = 'Reserve Calculation Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `assumption_set_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `insured_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `liability_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Liability Segment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `pbr_model_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Principle-Based Reserving (PBR) Model Segment Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `actuary_name` SET TAGS ('dbx_business_glossary_term' = 'Actuary Name');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `assumption_unlock_amount` SET TAGS ('dbx_business_glossary_term' = 'Assumption Unlock Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `boy_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Beginning of Year (BOY) Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `calculation_status` SET TAGS ('dbx_business_glossary_term' = 'Calculation Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `calculation_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|approved|superseded');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `cte_level` SET TAGS ('dbx_business_glossary_term' = 'Conditional Tail Expectation (CTE) Level');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `deterministic_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Deterministic Reserve (DR) Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `eoy_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'End of Year (EOY) Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `expense_assumption_amount` SET TAGS ('dbx_business_glossary_term' = 'Expense Assumption Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `experience_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Experience Variance Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `interest_accretion_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Accretion Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `lapse_assumption_rate` SET TAGS ('dbx_business_glossary_term' = 'Lapse Assumption Rate');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `model_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Model Change Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `mortality_assumption_table` SET TAGS ('dbx_business_glossary_term' = 'Mortality Assumption Table');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `net_amount_at_risk` SET TAGS ('dbx_business_glossary_term' = 'Net Amount at Risk (NAR)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `net_premium_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Premium Reserve (NPR) Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `new_business_reserve_change` SET TAGS ('dbx_business_glossary_term' = 'New Business (NB) Reserve Change');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Calculation Notes');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `pbr_floor_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Principle-Based Reserving (PBR) Floor Applied Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `reinsurance_ceded_reserve` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Ceded Reserve');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `reinsurance_recoverable_amount` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Recoverable Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `reporting_basis` SET TAGS ('dbx_business_glossary_term' = 'Reporting Basis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `reporting_basis` SET TAGS ('dbx_value_regex' = 'GAAP|SAP|IFRS17|PBR|Tax');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `reserve_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reserve Currency Code');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `reserve_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `reserve_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Reserve Per Unit');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `reserve_type` SET TAGS ('dbx_business_glossary_term' = 'Reserve Type');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `stochastic_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Stochastic Reserve (SR) Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `stochastic_scenario_count` SET TAGS ('dbx_business_glossary_term' = 'Stochastic Scenario Count');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `termination_reserve_change` SET TAGS ('dbx_business_glossary_term' = 'Termination Reserve Change');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` SET TAGS ('dbx_subdomain' = 'reserve_management');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Opinion Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `assumption_set_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Executed By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run Comments');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `dac_balance` SET TAGS ('dbx_business_glossary_term' = 'Deferred Acquisition Cost (DAC) Balance');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `data_extract_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Data Extract Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `discount_rate_method` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Methodology');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `error_log_summary` SET TAGS ('dbx_business_glossary_term' = 'Error Log Summary');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `in_force_policy_count` SET TAGS ('dbx_business_glossary_term' = 'In-Force Policy Count');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `ldti_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Long Duration Targeted Improvements (LDTI) Compliant Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Model Version');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `mortality_table` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Reference');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `output_file_path` SET TAGS ('dbx_business_glossary_term' = 'Valuation Output File Path');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `output_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `pbr_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Principle-Based Reserving (PBR) Compliant Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Reconciled|Variance Identified|Approved');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `reinsurance_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Included Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `run_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Run Duration in Minutes');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `run_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run End Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `run_name` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run Name');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run Number');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `run_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Start Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run Type');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `run_type` SET TAGS ('dbx_value_regex' = 'Production|Test|Pricing|Sensitivity|Experience Study|Ad Hoc');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `scenario_count` SET TAGS ('dbx_business_glossary_term' = 'Economic Scenario Count');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `total_account_value` SET TAGS ('dbx_business_glossary_term' = 'Total Account Value (AV)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `total_face_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Face Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `total_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `valuation_basis` SET TAGS ('dbx_business_glossary_term' = 'Valuation Accounting Basis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `valuation_basis` SET TAGS ('dbx_value_regex' = 'GAAP|SAP|IFRS|Tax|PBR|Embedded Value');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation As-Of Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `valuation_period_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Period Type');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `valuation_period_type` SET TAGS ('dbx_value_regex' = 'BOY|EOY|Quarterly|Monthly|Interim');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `variance_from_prior_period` SET TAGS ('dbx_business_glossary_term' = 'Variance from Prior Period');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `voba_balance` SET TAGS ('dbx_business_glossary_term' = 'Value of Business Acquired (VOBA) Balance');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` SET TAGS ('dbx_subdomain' = 'assumption_governance');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `assumption_set_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `experience_study_id` SET TAGS ('dbx_business_glossary_term' = 'Experience Study Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `parent_assumption_set_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Assumption Set Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Actuary Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `tertiary_assumption_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `tertiary_assumption_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `tertiary_assumption_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Approval Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `assumption_basis` SET TAGS ('dbx_business_glossary_term' = 'Assumption Basis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `assumption_basis` SET TAGS ('dbx_value_regex' = 'best_estimate|prudent_estimate|prescribed|pricing|experience_adjusted|regulatory_minimum');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `assumption_set_description` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Description');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `assumption_set_status` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `assumption_set_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|superseded|archived');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `credibility_factor` SET TAGS ('dbx_business_glossary_term' = 'Credibility Factor');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `data_source_reference` SET TAGS ('dbx_business_glossary_term' = 'Data Source Reference');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Documentation URL');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Effective Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `expense_assumption_reference` SET TAGS ('dbx_business_glossary_term' = 'Expense Assumption Reference');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `expense_loading_pct` SET TAGS ('dbx_business_glossary_term' = 'Expense Loading Percentage (Pct)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Expiration Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `interest_rate_scenario` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Scenario');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `investment_return_assumption_pct` SET TAGS ('dbx_business_glossary_term' = 'Investment Return Assumption Percentage (Pct)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `lapse_assumption_reference` SET TAGS ('dbx_business_glossary_term' = 'Lapse Assumption Reference');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `model_platform` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Model Platform');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `morbidity_assumption_reference` SET TAGS ('dbx_business_glossary_term' = 'Morbidity Assumption Reference');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `mortality_table_reference` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Reference');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `nbv_target_amount` SET TAGS ('dbx_business_glossary_term' = 'New Business Value (NBV) Target Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `nbv_target_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `peer_review_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Completed Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `peer_review_date` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `product_applicability` SET TAGS ('dbx_business_glossary_term' = 'Product Applicability Scope');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `profit_margin_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Profit Margin Target Percentage (Pct)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `profit_margin_target_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Accounting Basis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `reinsurance_assumption_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Assumption Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `roi_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Target Percentage (Pct)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `roi_target_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `set_code` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Code');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `set_name` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Name');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `set_purpose` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Purpose');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `set_purpose` SET TAGS ('dbx_value_regex' = 'valuation|pricing|repricing|experience_update|stress_testing|sensitivity_analysis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `stochastic_scenario_count` SET TAGS ('dbx_business_glossary_term' = 'Stochastic Scenario Count');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `tax_compliance_basis` SET TAGS ('dbx_business_glossary_term' = 'Tax Compliance Basis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `tax_compliance_basis` SET TAGS ('dbx_value_regex' = 'GPT|CVAT|7702|7702A|none');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Version Number');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` SET TAGS ('dbx_subdomain' = 'reserve_management');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `cash_flow_projection_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Projection ID');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `insured_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `reinsurance_cession_id` SET TAGS ('dbx_business_glossary_term' = 'Cession Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `stochastic_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Scenario ID');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run ID');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `account_value` SET TAGS ('dbx_business_glossary_term' = 'Account Value (AV)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `asset_duration` SET TAGS ('dbx_business_glossary_term' = 'Asset Duration');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `benefit_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Benefit Outflow Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `commission_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Outflow Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `convexity` SET TAGS ('dbx_business_glossary_term' = 'Convexity');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `csm_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Contractual Service Margin (CSM) Balance Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `cte_level` SET TAGS ('dbx_business_glossary_term' = 'Conditional Tail Expectation (CTE) Level');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `dac_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Acquisition Cost (DAC) Balance Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `duration_gap` SET TAGS ('dbx_business_glossary_term' = 'Duration Gap');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `expense_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Expense Outflow Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `face_amount` SET TAGS ('dbx_business_glossary_term' = 'Face Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `investment_income_amount` SET TAGS ('dbx_business_glossary_term' = 'Investment Income Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `key_rate_duration` SET TAGS ('dbx_business_glossary_term' = 'Key Rate Duration');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `lapse_rate` SET TAGS ('dbx_business_glossary_term' = 'Lapse Rate');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `liability_duration` SET TAGS ('dbx_business_glossary_term' = 'Liability Duration');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `model_version` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._-]{1,20}$');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `mortality_assumption_table` SET TAGS ('dbx_business_glossary_term' = 'Mortality Assumption Table');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `mortality_assumption_table` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `nar_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount at Risk (NAR) Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `net_cash_flow_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Cash Flow Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `policy_count` SET TAGS ('dbx_business_glossary_term' = 'Policy Count');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `premium_inflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Inflow Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `present_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Present Value Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `product_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Product Segment Code');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `product_segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `projection_basis` SET TAGS ('dbx_business_glossary_term' = 'Projection Basis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `projection_basis` SET TAGS ('dbx_value_regex' = 'GAAP|SAP|IFRS17|PBR|ORSA|Economic');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `projection_date` SET TAGS ('dbx_business_glossary_term' = 'Projection Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `projection_period` SET TAGS ('dbx_business_glossary_term' = 'Projection Period');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `reinsurance_ceded_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Ceded Premium Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `reinsurance_recoverable_amount` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Recoverable Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `risk_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `scenario_type` SET TAGS ('dbx_business_glossary_term' = 'Scenario Type');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `scenario_type` SET TAGS ('dbx_value_regex' = 'Deterministic|Stochastic|Stressed|Best_Estimate');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` SET TAGS ('dbx_subdomain' = 'experience_analysis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `experience_study_id` SET TAGS ('dbx_business_glossary_term' = 'Experience Study Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Actuary Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `group_sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Group Sponsor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Study Report Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `actual_events` SET TAGS ('dbx_business_glossary_term' = 'Actual Events Count');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `ae_ratio` SET TAGS ('dbx_business_glossary_term' = 'Actual-to-Expected (A/E) Ratio');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Study Approval Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `assumption_locked_flag` SET TAGS ('dbx_business_glossary_term' = 'Assumption Locked Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `assumption_table_used` SET TAGS ('dbx_business_glossary_term' = 'Assumption Table Used');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `assumption_update_cycle` SET TAGS ('dbx_business_glossary_term' = 'Assumption Update Cycle');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `assumption_update_cycle` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|ad_hoc|triennial');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Study Comments and Notes');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `confidence_level_pct` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Percentage');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `credibility_standard` SET TAGS ('dbx_business_glossary_term' = 'Credibility Standard Classification');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `credibility_standard` SET TAGS ('dbx_value_regex' = 'full|partial|limited|none');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `credibility_weight` SET TAGS ('dbx_business_glossary_term' = 'Credibility Weight');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `exclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `expected_events` SET TAGS ('dbx_business_glossary_term' = 'Expected Events Count');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Exposure Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `impact_on_capital_amount` SET TAGS ('dbx_business_glossary_term' = 'Impact on Capital Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `impact_on_capital_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `impact_on_reserves_amount` SET TAGS ('dbx_business_glossary_term' = 'Impact on Reserves Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `impact_on_reserves_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `materiality_threshold_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Materiality Threshold Met Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `peer_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Peer Reviewer Name');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `peer_reviewer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `policy_count` SET TAGS ('dbx_business_glossary_term' = 'Policy Count');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `product_segment` SET TAGS ('dbx_business_glossary_term' = 'Product Segment');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Study Publication Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `recommended_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Recommended Adjustment Factor');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `recommended_assumption_change_pct` SET TAGS ('dbx_business_glossary_term' = 'Recommended Assumption Change Percentage');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `segmentation_criteria` SET TAGS ('dbx_business_glossary_term' = 'Segmentation Criteria');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `study_methodology` SET TAGS ('dbx_business_glossary_term' = 'Study Methodology');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `study_name` SET TAGS ('dbx_business_glossary_term' = 'Experience Study Name');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `study_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Study Period End Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `study_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Study Period Start Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'Experience Study Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `study_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|under_review|approved|published|archived');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Experience Study Type');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `variance_from_expected` SET TAGS ('dbx_business_glossary_term' = 'Variance from Expected');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` SET TAGS ('dbx_subdomain' = 'experience_analysis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `experience_study_result_id` SET TAGS ('dbx_business_glossary_term' = 'Experience Study Result Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `experience_study_id` SET TAGS ('dbx_business_glossary_term' = 'Experience Study Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_value_regex' = 'GAAP|SAP|IFRS');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `actual_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Count');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `ae_ratio_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual-to-Expected (A/E) Ratio Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `ae_ratio_count` SET TAGS ('dbx_business_glossary_term' = 'Actual-to-Expected (A/E) Ratio Count');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `age_band` SET TAGS ('dbx_business_glossary_term' = 'Age Band');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `assumption_table_reference` SET TAGS ('dbx_business_glossary_term' = 'Assumption Table Reference');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `assumption_version` SET TAGS ('dbx_business_glossary_term' = 'Assumption Version');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `attained_age` SET TAGS ('dbx_business_glossary_term' = 'Attained Age');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `cohort_definition` SET TAGS ('dbx_business_glossary_term' = 'Cohort Definition');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `credibility_factor` SET TAGS ('dbx_business_glossary_term' = 'Credibility Factor');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `credibility_method` SET TAGS ('dbx_business_glossary_term' = 'Credibility Method');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `expected_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `expected_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Count');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `experience_type` SET TAGS ('dbx_business_glossary_term' = 'Experience Type');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Exposure Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `exposure_unit` SET TAGS ('dbx_business_glossary_term' = 'Exposure Unit');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `exposure_unit` SET TAGS ('dbx_value_regex' = 'policy_years|life_years|face_amount_years|account_value_years');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|unisex|unknown');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `model_source_system` SET TAGS ('dbx_business_glossary_term' = 'Model Source System');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `policy_duration` SET TAGS ('dbx_business_glossary_term' = 'Policy Duration');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `policy_duration_band` SET TAGS ('dbx_business_glossary_term' = 'Policy Duration Band');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `product_segment` SET TAGS ('dbx_business_glossary_term' = 'Product Segment');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|approved|superseded');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `smoker_status` SET TAGS ('dbx_business_glossary_term' = 'Smoker Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `smoker_status` SET TAGS ('dbx_value_regex' = 'smoker|non_smoker|unknown');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `standard_deviation` SET TAGS ('dbx_business_glossary_term' = 'Standard Deviation');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `statistical_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Statistical Confidence Level');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `study_basis` SET TAGS ('dbx_business_glossary_term' = 'Study Basis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `study_basis` SET TAGS ('dbx_value_regex' = 'seriatim|grouped|aggregate');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `underwriting_class` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `variance` SET TAGS ('dbx_business_glossary_term' = 'Variance');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` SET TAGS ('dbx_subdomain' = 'reserve_management');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `pbr_model_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Principle-Based Reserving (PBR) Model Segment Identifier');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `liability_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Liability Segment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `mortality_table_id` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `reinsurance_treaty_id` SET TAGS ('dbx_business_glossary_term' = 'Treaty Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Approval Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Approval Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `assumption_update_date` SET TAGS ('dbx_business_glossary_term' = 'Assumption Update Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `base_lapse_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Lapse Rate');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `company_experience_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Company Experience Adjustment Factor');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `credibility_percentage` SET TAGS ('dbx_business_glossary_term' = 'Credibility Percentage');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `credibility_threshold_met` SET TAGS ('dbx_business_glossary_term' = 'Credibility Threshold Met Indicator');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `cte_level` SET TAGS ('dbx_business_glossary_term' = 'Conditional Tail Expectation (CTE) Level');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = 'career_agent|independent_agent|broker|bank|direct|worksite');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `dynamic_lapse_formula` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Lapse Formula');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Effective Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `exclusion_test_result` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Test Result');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `exclusion_test_result` SET TAGS ('dbx_value_regex' = 'excluded|included|not_applicable');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `expense_assumption_basis` SET TAGS ('dbx_business_glossary_term' = 'Expense Assumption Basis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `expense_assumption_basis` SET TAGS ('dbx_value_regex' = 'fully_allocated|marginal|prescribed');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `face_amount_total` SET TAGS ('dbx_business_glossary_term' = 'Total Face Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|unisex');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `issue_age_band_max` SET TAGS ('dbx_business_glossary_term' = 'Issue Age Band Maximum');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `issue_age_band_min` SET TAGS ('dbx_business_glossary_term' = 'Issue Age Band Minimum');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `lapse_assumption_basis` SET TAGS ('dbx_business_glossary_term' = 'Lapse Assumption Basis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `lapse_assumption_basis` SET TAGS ('dbx_value_regex' = 'company_experience|industry_table|prescribed|blended');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version Identifier');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `model_version` SET TAGS ('dbx_value_regex' = '^[0-9]{4}Q[1-4]_v[0-9]+$');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `mortality_improvement_scale` SET TAGS ('dbx_business_glossary_term' = 'Mortality Improvement Scale');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `net_amount_at_risk_total` SET TAGS ('dbx_business_glossary_term' = 'Total Net Amount at Risk (NAR)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Model Segment Notes');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `per_policy_expense_annual` SET TAGS ('dbx_business_glossary_term' = 'Per Policy Annual Expense');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `percent_of_premium_expense` SET TAGS ('dbx_business_glossary_term' = 'Percent of Premium Expense');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `policy_count` SET TAGS ('dbx_business_glossary_term' = 'Policy Count');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'term|whole_life|universal_life|indexed_universal_life|variable_universal_life|survivorship');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `reinsurance_treatment` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Treatment');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `reinsurance_treatment` SET TAGS ('dbx_value_regex' = 'gross|net_of_reinsurance|coinsurance|yrt');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `reinsurance_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `reinsurance_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `reserve_basis` SET TAGS ('dbx_business_glossary_term' = 'Reserve Basis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `reserve_basis` SET TAGS ('dbx_value_regex' = 'deterministic|stochastic|net_premium');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Model Segment Description');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Model Segment Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|superseded');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `smoker_status` SET TAGS ('dbx_business_glossary_term' = 'Smoker Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `smoker_status` SET TAGS ('dbx_value_regex' = 'smoker|non_smoker|not_applicable');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `stochastic_scenario_count` SET TAGS ('dbx_business_glossary_term' = 'Stochastic Scenario Count');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Termination Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `underwriting_class` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `valuation_system` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Valuation System');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `valuation_system` SET TAGS ('dbx_value_regex' = 'prophet|axis|moses|other');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` SET TAGS ('dbx_subdomain' = 'reserve_management');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `stochastic_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stochastic Scenario Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `scenario_set_id` SET TAGS ('dbx_business_glossary_term' = 'Scenario Set Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `scenario_set_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,50}$');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Performed By Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `actuarial_system_source` SET TAGS ('dbx_business_glossary_term' = 'Actuarial System Source');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `board_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Board Approval Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `board_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Board Approval Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `board_approval_status` SET TAGS ('dbx_value_regex' = 'Pending|Approved|Rejected|Requires Revision');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `capital_adequacy_conclusion` SET TAGS ('dbx_business_glossary_term' = 'Capital Adequacy Conclusion');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `capital_adequacy_conclusion` SET TAGS ('dbx_value_regex' = 'Adequate|Marginal|Inadequate|Requires Management Action|Requires Capital Raise');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `cte_level` SET TAGS ('dbx_business_glossary_term' = 'Conditional Tail Expectation (CTE) Level');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `equity_return_path` SET TAGS ('dbx_business_glossary_term' = 'Equity Return Path');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `interest_rate_path` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Path');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `orsa_filing_year` SET TAGS ('dbx_business_glossary_term' = 'Own Risk and Solvency Assessment (ORSA) Filing Year');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `projection_period_months` SET TAGS ('dbx_business_glossary_term' = 'Projection Period in Months');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `random_seed` SET TAGS ('dbx_business_glossary_term' = 'Random Seed');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `rbc_ratio_under_stress` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Ratio Under Stress');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `rbc_ratio_under_stress` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `regulatory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `scenario_description` SET TAGS ('dbx_business_glossary_term' = 'Scenario Description');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `scenario_generation_date` SET TAGS ('dbx_business_glossary_term' = 'Scenario Generation Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `scenario_generator_version` SET TAGS ('dbx_business_glossary_term' = 'Scenario Generator Version');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `scenario_generator_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `scenario_number` SET TAGS ('dbx_business_glossary_term' = 'Scenario Number');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `scenario_purpose` SET TAGS ('dbx_business_glossary_term' = 'Scenario Purpose');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `scenario_purpose` SET TAGS ('dbx_value_regex' = 'PBR|ALM|ORSA|Hedging|Pricing|Product Development');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `scenario_status` SET TAGS ('dbx_business_glossary_term' = 'Scenario Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `scenario_status` SET TAGS ('dbx_value_regex' = 'Draft|Validated|Approved|In Use|Archived|Rejected');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `scenario_weight` SET TAGS ('dbx_business_glossary_term' = 'Scenario Weight');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `stress_severity` SET TAGS ('dbx_business_glossary_term' = 'Stress Severity');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `stress_type` SET TAGS ('dbx_business_glossary_term' = 'Stress Type');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `stressed_reserve_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Stressed Reserve Impact Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `stressed_reserve_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `validation_notes` SET TAGS ('dbx_business_glossary_term' = 'Validation Notes');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` SET TAGS ('dbx_subdomain' = 'reserve_management');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `reserve_snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'Reserve Snapshot Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Actuary Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `insured_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `reinsurance_cession_id` SET TAGS ('dbx_business_glossary_term' = 'Cession Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `av` SET TAGS ('dbx_business_glossary_term' = 'Account Value (AV)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `csv` SET TAGS ('dbx_business_glossary_term' = 'Cash Surrender Value (CSV)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `dac_balance` SET TAGS ('dbx_business_glossary_term' = 'Deferred Acquisition Cost (DAC) Balance');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `expense_assumption` SET TAGS ('dbx_business_glossary_term' = 'Expense Assumption');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `interest_rate_assumption` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Assumption');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `lapse_rate_assumption` SET TAGS ('dbx_business_glossary_term' = 'Lapse Rate Assumption');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `ldti_transition_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Long Duration Targeted Improvements (LDTI) Transition Adjustment');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `mortality_assumption_table` SET TAGS ('dbx_business_glossary_term' = 'Mortality Assumption Table');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `nar` SET TAGS ('dbx_business_glossary_term' = 'Net Amount at Risk (NAR)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `net_reserve` SET TAGS ('dbx_business_glossary_term' = 'Net Reserve');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reserve Snapshot Notes');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `pbr_deterministic_reserve` SET TAGS ('dbx_business_glossary_term' = 'Principle-Based Reserving (PBR) Deterministic Reserve');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `pbr_net_premium_reserve` SET TAGS ('dbx_business_glossary_term' = 'Principle-Based Reserving (PBR) Net Premium Reserve');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `pbr_stochastic_reserve` SET TAGS ('dbx_business_glossary_term' = 'Principle-Based Reserving (PBR) Stochastic Reserve');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `reinsurance_ceded_reserve` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Ceded Reserve');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `reserve_adequacy_status` SET TAGS ('dbx_business_glossary_term' = 'Reserve Adequacy Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `reserve_adequacy_status` SET TAGS ('dbx_value_regex' = 'Adequate|Deficient|Redundant|Under Review');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `reserve_balance` SET TAGS ('dbx_business_glossary_term' = 'Reserve Balance');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `reserve_type` SET TAGS ('dbx_business_glossary_term' = 'Reserve Type');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `reserve_type` SET TAGS ('dbx_value_regex' = 'Policy Reserve|Claim Reserve|Premium Deficiency Reserve|IBNR|Unearned Premium Reserve|Additional Reserve');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `valuation_basis` SET TAGS ('dbx_business_glossary_term' = 'Valuation Basis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `valuation_basis` SET TAGS ('dbx_value_regex' = 'GAAP|SAP|IFRS|PBR|Tax');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` SET TAGS ('dbx_subdomain' = 'assumption_governance');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `pricing_basis_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `assumption_set_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `mortality_table_id` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `policy_form_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Form Approval Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `rate_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Filing Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `acquisition_expense_rate` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Expense Rate');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `age_basis` SET TAGS ('dbx_business_glossary_term' = 'Age Calculation Basis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `age_basis` SET TAGS ('dbx_value_regex' = 'anb|alb|actual');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis Approval Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `approved_by_actuary_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Actuary Name');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `basis_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis Code');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `basis_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `basis_name` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis Name');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `basis_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis Type');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `basis_type` SET TAGS ('dbx_value_regex' = 'new_business|repricing|rate_revision|competitive_adjustment|regulatory_update|experience_adjustment');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `competitive_position_target` SET TAGS ('dbx_business_glossary_term' = 'Competitive Position Target');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `competitive_position_target` SET TAGS ('dbx_value_regex' = 'market_leader|top_quartile|median|competitive|value');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `competitive_position_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis Effective Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `expense_loading_method` SET TAGS ('dbx_business_glossary_term' = 'Expense Loading Method');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `expense_loading_method` SET TAGS ('dbx_value_regex' = 'per_policy|percent_of_premium|per_thousand_face_amount|tiered|composite');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis Expiration Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `filing_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Filing Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `gender_distinct_pricing_flag` SET TAGS ('dbx_business_glossary_term' = 'Gender Distinct Pricing Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `gender_distinct_pricing_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `gender_distinct_pricing_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `investment_return_assumption` SET TAGS ('dbx_business_glossary_term' = 'Investment Return Assumption');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `maintenance_expense_rate` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Expense Rate');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `maximum_face_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Face Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `maximum_issue_age` SET TAGS ('dbx_business_glossary_term' = 'Maximum Issue Age');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `minimum_face_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Face Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `minimum_issue_age` SET TAGS ('dbx_business_glossary_term' = 'Minimum Issue Age');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `mortality_improvement_scale` SET TAGS ('dbx_business_glossary_term' = 'Mortality Improvement Scale');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis Notes');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `pricing_basis_status` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `pricing_basis_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|superseded|retired');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `pricing_model_version` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Version');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `profit_margin_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Profit Margin Target Percentage (PCT)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `profit_margin_target_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `regulatory_filing_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Number');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `reinsurance_assumption` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Assumption');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `reinsurance_assumption` SET TAGS ('dbx_value_regex' = 'none|yrt|coinsurance|mod_co|facultative');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `reinsurance_cession_rate` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Cession Rate');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `reserve_basis` SET TAGS ('dbx_business_glossary_term' = 'Reserve Calculation Basis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `reserve_basis` SET TAGS ('dbx_value_regex' = 'statutory|gaap|ifrs|pbr_vm20|tax');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `smoker_status_pricing_flag` SET TAGS ('dbx_business_glossary_term' = 'Smoker Status Pricing Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `target_nbv` SET TAGS ('dbx_business_glossary_term' = 'Target New Business Value (NBV)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `target_nbv` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `target_roi` SET TAGS ('dbx_business_glossary_term' = 'Target Return on Investment (ROI)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `target_roi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `tax_basis` SET TAGS ('dbx_business_glossary_term' = 'Tax Qualification Basis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `tax_basis` SET TAGS ('dbx_value_regex' = 'gpt|cvat|mec_compliant|non_qualified');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `underwriting_class` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Risk Class');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` SET TAGS ('dbx_subdomain' = 'reserve_management');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Definition Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `liability_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Liability Segment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_value_regex' = 'GAAP|SAP|IFRS17|LDTI');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `assumption_update_frequency` SET TAGS ('dbx_business_glossary_term' = 'Assumption Update Frequency');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `assumption_update_frequency` SET TAGS ('dbx_value_regex' = 'annual|quarterly|semi_annual|as_needed');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `cohort_code` SET TAGS ('dbx_business_glossary_term' = 'Cohort Code');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `cohort_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `cohort_name` SET TAGS ('dbx_business_glossary_term' = 'Cohort Name');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `cohort_status` SET TAGS ('dbx_business_glossary_term' = 'Cohort Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `cohort_status` SET TAGS ('dbx_value_regex' = 'active|closed|runoff|fully_matured');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `cohort_type` SET TAGS ('dbx_business_glossary_term' = 'Cohort Type');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `cohort_type` SET TAGS ('dbx_value_regex' = 'annual|portfolio|group|contract');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `coverage_unit_definition` SET TAGS ('dbx_business_glossary_term' = 'Coverage Unit Definition');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `current_discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Current Discount Rate');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `dac_amortization_method` SET TAGS ('dbx_business_glossary_term' = 'Deferred Acquisition Cost (DAC) Amortization Method');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `dac_amortization_method` SET TAGS ('dbx_value_regex' = 'constant_level|in_proportion_to_premiums|in_proportion_to_profits|in_proportion_to_gross_margins');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `expected_contract_life_years` SET TAGS ('dbx_business_glossary_term' = 'Expected Contract Life in Years');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `expense_assumption_rate` SET TAGS ('dbx_business_glossary_term' = 'Expense Assumption Rate');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `ifrs17_group_code` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards 17 (IFRS 17) Group Code');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `ifrs17_initial_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards 17 (IFRS 17) Initial Recognition Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `ifrs17_portfolio_code` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards 17 (IFRS 17) Portfolio Code');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `initial_csm_amount` SET TAGS ('dbx_business_glossary_term' = 'Initial Contractual Service Margin (CSM) Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `initial_csm_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `initial_lfpb_amount` SET TAGS ('dbx_business_glossary_term' = 'Initial Liability for Future Policy Benefits (LFPB) Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `initial_lfpb_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `issue_quarter` SET TAGS ('dbx_business_glossary_term' = 'Issue Quarter');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `issue_year` SET TAGS ('dbx_business_glossary_term' = 'Issue Year');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `lapse_assumption_rate` SET TAGS ('dbx_business_glossary_term' = 'Lapse Assumption Rate');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `last_assumption_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assumption Update Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `last_valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Valuation Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `ldti_transition_date` SET TAGS ('dbx_business_glossary_term' = 'Long Duration Targeted Improvements (LDTI) Transition Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `locked_in_discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Locked-In Discount Rate');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `mortality_assumption_table` SET TAGS ('dbx_business_glossary_term' = 'Mortality Assumption Table');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `next_valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Next Valuation Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `pbr_method` SET TAGS ('dbx_business_glossary_term' = 'Principle-Based Reserving (PBR) Method');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `pbr_method` SET TAGS ('dbx_value_regex' = 'deterministic|stochastic|net_premium|not_applicable');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `policy_count` SET TAGS ('dbx_business_glossary_term' = 'Policy Count');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `profitability_classification` SET TAGS ('dbx_business_glossary_term' = 'Profitability Classification');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `profitability_classification` SET TAGS ('dbx_value_regex' = 'onerous|profitable|neither');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `reinsurance_treaty_applicable` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Treaty Applicable');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `total_account_value` SET TAGS ('dbx_business_glossary_term' = 'Total Account Value');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `total_account_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `total_face_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Face Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `total_face_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `underwriting_class` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` SET TAGS ('dbx_subdomain' = 'investment_strategy');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `alm_position_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Liability Management (ALM) Position Identifier');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `orsa_report_id` SET TAGS ('dbx_business_glossary_term' = 'Orsa Report Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `asset_convexity` SET TAGS ('dbx_business_glossary_term' = 'Asset Convexity');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `asset_duration_years` SET TAGS ('dbx_business_glossary_term' = 'Asset Duration (Years)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `asset_market_value` SET TAGS ('dbx_business_glossary_term' = 'Asset Market Value');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `asset_market_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `convexity_gap` SET TAGS ('dbx_business_glossary_term' = 'Convexity Gap');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `duration_gap_years` SET TAGS ('dbx_business_glossary_term' = 'Duration Gap (Years)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `effective_duration_years` SET TAGS ('dbx_business_glossary_term' = 'Effective Duration (Years)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `hedge_effectiveness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Hedge Effectiveness Percentage');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `hedge_ratio` SET TAGS ('dbx_business_glossary_term' = 'Hedge Ratio');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `interest_rate_scenario_code` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Scenario Code');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `interest_rate_scenario_code` SET TAGS ('dbx_value_regex' = 'BASE|UP100|UP200|DOWN100|DOWN200|TWIST');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `key_rate_duration_10yr` SET TAGS ('dbx_business_glossary_term' = 'Key Rate Duration 10-Year');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `key_rate_duration_1yr` SET TAGS ('dbx_business_glossary_term' = 'Key Rate Duration 1-Year');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `key_rate_duration_20yr` SET TAGS ('dbx_business_glossary_term' = 'Key Rate Duration 20-Year');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `key_rate_duration_30yr` SET TAGS ('dbx_business_glossary_term' = 'Key Rate Duration 30-Year');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `key_rate_duration_5yr` SET TAGS ('dbx_business_glossary_term' = 'Key Rate Duration 5-Year');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `liability_convexity` SET TAGS ('dbx_business_glossary_term' = 'Liability Convexity');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `liability_duration_years` SET TAGS ('dbx_business_glossary_term' = 'Liability Duration (Years)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `liability_market_value` SET TAGS ('dbx_business_glossary_term' = 'Liability Market Value');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `liability_market_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `surplus_deficit_amount` SET TAGS ('dbx_business_glossary_term' = 'Surplus (Deficit) Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `surplus_deficit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_position` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` SET TAGS ('dbx_subdomain' = 'reserve_management');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `tax_qualification_test_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Qualification Test Identifier');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `insured_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `mortality_table_id` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Test Performed By Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `cash_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Surrender Value (CSV) Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|remediated|under_review');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `corridor_percentage` SET TAGS ('dbx_business_glossary_term' = 'Corridor Percentage');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `cvat_limit` SET TAGS ('dbx_business_glossary_term' = 'Cash Value Accumulation Test (CVAT) Limit');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `death_benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Death Benefit (DB) Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `guideline_level_premium` SET TAGS ('dbx_business_glossary_term' = 'Guideline Level Premium (GLP)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `guideline_premium_limit` SET TAGS ('dbx_business_glossary_term' = 'Guideline Premium Limit');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `guideline_single_premium` SET TAGS ('dbx_business_glossary_term' = 'Guideline Single Premium (GSP)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `insured_age_at_test` SET TAGS ('dbx_business_glossary_term' = 'Insured Age at Test');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `interest_rate_assumption` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Assumption');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `mec_status` SET TAGS ('dbx_business_glossary_term' = 'Modified Endowment Contract (MEC) Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `mec_status` SET TAGS ('dbx_value_regex' = 'non_mec|mec|mec_pending');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `net_single_premium` SET TAGS ('dbx_business_glossary_term' = 'Net Single Premium (NSP)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `next_test_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Test Due Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `override_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Override Approved By');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `override_date` SET TAGS ('dbx_business_glossary_term' = 'Override Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `override_indicator` SET TAGS ('dbx_business_glossary_term' = 'Override Indicator');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `policy_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Issue Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `premium_paid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Premium Paid to Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `remediation_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `seven_pay_premium_limit` SET TAGS ('dbx_business_glossary_term' = 'Seven-Pay Premium Limit');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `test_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Test Calculation Method');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `test_calculation_method` SET TAGS ('dbx_value_regex' = 'actuarial_present_value|net_level_premium|commissioner_standard|custom');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `test_notes` SET TAGS ('dbx_business_glossary_term' = 'Test Notes');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `test_number` SET TAGS ('dbx_business_glossary_term' = 'Test Number');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `test_reason` SET TAGS ('dbx_business_glossary_term' = 'Test Reason');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|not_applicable');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed|overridden');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `test_system_source` SET TAGS ('dbx_business_glossary_term' = 'Test System Source');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `test_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'GPT|CVAT|MEC|7702_COMPLIANCE|7702A_COMPLIANCE');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`tax_qualification_test` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` SET TAGS ('dbx_subdomain' = 'reserve_management');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `ifrs17_csm_id` SET TAGS ('dbx_business_glossary_term' = 'Ifrs17 Csm Identifier');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `insured_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `reinsurance_cession_id` SET TAGS ('dbx_business_glossary_term' = 'Cession Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Calculation Run ID');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `actuarial_system_source` SET TAGS ('dbx_business_glossary_term' = 'Actuarial System Source');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `actuarial_system_source` SET TAGS ('dbx_value_regex' = 'prophet|axis|moses|other');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `coverage_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Period End Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `coverage_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Period Start Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `coverage_units_closing` SET TAGS ('dbx_business_glossary_term' = 'Coverage Units Closing');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `coverage_units_opening` SET TAGS ('dbx_business_glossary_term' = 'Coverage Units Opening');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `coverage_units_provided` SET TAGS ('dbx_business_glossary_term' = 'Coverage Units Provided');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `csm_accretion_amount` SET TAGS ('dbx_business_glossary_term' = 'Contractual Service Margin (CSM) Accretion Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `csm_assumption_change_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Contractual Service Margin (CSM) Assumption Change Adjustment');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `csm_closing_balance` SET TAGS ('dbx_business_glossary_term' = 'Contractual Service Margin (CSM) Closing Balance');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `csm_experience_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Contractual Service Margin (CSM) Experience Adjustment');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `csm_fx_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Contractual Service Margin (CSM) Foreign Exchange (FX) Adjustment');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `csm_initial_recognition_amount` SET TAGS ('dbx_business_glossary_term' = 'Contractual Service Margin (CSM) Initial Recognition Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `csm_opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Contractual Service Margin (CSM) Opening Balance');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `csm_release_amount` SET TAGS ('dbx_business_glossary_term' = 'Contractual Service Margin (CSM) Release Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `discount_rate_current` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Current');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `discount_rate_locked_in` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Locked In');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `fulfilment_cash_flows_pv` SET TAGS ('dbx_business_glossary_term' = 'Fulfilment Cash Flows Present Value (PV)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `initial_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Recognition Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `loss_component_closing_balance` SET TAGS ('dbx_business_glossary_term' = 'Loss Component Closing Balance');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `loss_component_initial_recognition` SET TAGS ('dbx_business_glossary_term' = 'Loss Component Initial Recognition');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `loss_component_opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Loss Component Opening Balance');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `loss_component_reversal` SET TAGS ('dbx_business_glossary_term' = 'Loss Component Reversal');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `measurement_model` SET TAGS ('dbx_business_glossary_term' = 'Measurement Model');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `measurement_model` SET TAGS ('dbx_value_regex' = 'general_measurement_model|premium_allocation_approach|variable_fee_approach');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `onerous_contract_flag` SET TAGS ('dbx_business_glossary_term' = 'Onerous Contract Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `product_line` SET TAGS ('dbx_value_regex' = 'term_life|whole_life|universal_life|variable_universal_life|indexed_universal_life|fixed_annuity');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|superseded|archived|under_review');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `reinsurance_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `reporting_segment` SET TAGS ('dbx_business_glossary_term' = 'Reporting Segment');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `reporting_segment` SET TAGS ('dbx_value_regex' = 'individual_life|group_life|individual_annuity|group_annuity|accident_health|other');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `risk_adjustment_change` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Change');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `risk_adjustment_closing_balance` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Closing Balance');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `risk_adjustment_opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Opening Balance');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `transition_approach` SET TAGS ('dbx_business_glossary_term' = 'Transition Approach');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `transition_approach` SET TAGS ('dbx_value_regex' = 'full_retrospective|modified_retrospective|fair_value');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`ifrs17_csm` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` SET TAGS ('dbx_subdomain' = 'investment_strategy');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `orsa_stress_test_id` SET TAGS ('dbx_business_glossary_term' = 'Own Risk and Solvency Assessment (ORSA) Stress Test Identifier');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `assumption_set_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Identifier');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `orsa_report_id` SET TAGS ('dbx_business_glossary_term' = 'Own Risk and Solvency Assessment (ORSA) Filing Identifier');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `reinsurance_treaty_id` SET TAGS ('dbx_business_glossary_term' = 'Treaty Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `stochastic_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Scenario Identifier');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Report Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run Identifier');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `action_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Description');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `action_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Required Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `actuarial_model_version` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Model Version');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `baseline_acl_amount` SET TAGS ('dbx_business_glossary_term' = 'Baseline Authorized Control Level (ACL) Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `baseline_rbc_ratio` SET TAGS ('dbx_business_glossary_term' = 'Baseline Risk-Based Capital (RBC) Ratio');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `baseline_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Baseline Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `baseline_tac_amount` SET TAGS ('dbx_business_glossary_term' = 'Baseline Total Adjusted Capital (TAC) Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `board_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Board Approval Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `board_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|approved_with_conditions|rejected');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `board_comments` SET TAGS ('dbx_business_glossary_term' = 'Board Comments');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `board_review_date` SET TAGS ('dbx_business_glossary_term' = 'Board Review Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `capital_adequacy_conclusion` SET TAGS ('dbx_business_glossary_term' = 'Capital Adequacy Conclusion');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `capital_adequacy_conclusion` SET TAGS ('dbx_value_regex' = 'adequate|marginal|inadequate|requires_action');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `management_action_assumption` SET TAGS ('dbx_business_glossary_term' = 'Management Action Assumption');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `peer_comparison_percentile` SET TAGS ('dbx_business_glossary_term' = 'Peer Comparison Percentile');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `product_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Product Segment Code');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `rbc_ratio_impact` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Ratio Impact');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `regulatory_action_level` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Action Level');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `regulatory_action_level` SET TAGS ('dbx_value_regex' = 'no_action|company_action|regulatory_action|authorized_control|mandatory_control');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `regulatory_filing_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `reinsurance_treatment` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Treatment');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `reinsurance_treatment` SET TAGS ('dbx_value_regex' = 'gross|net_of_reinsurance|ceded_only');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `reinsurance_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `reinsurance_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `reporting_basis` SET TAGS ('dbx_business_glossary_term' = 'Reporting Basis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `reporting_basis` SET TAGS ('dbx_value_regex' = 'statutory|gaap|ifrs|economic');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `reserve_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Impact Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `reserve_impact_percentage` SET TAGS ('dbx_business_glossary_term' = 'Reserve Impact Percentage');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Scenario Name');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `stress_parameter_description` SET TAGS ('dbx_business_glossary_term' = 'Stress Parameter Description');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `stress_severity_level` SET TAGS ('dbx_business_glossary_term' = 'Stress Severity Level');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `stress_severity_level` SET TAGS ('dbx_value_regex' = 'mild|moderate|severe|extreme');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `stress_type` SET TAGS ('dbx_business_glossary_term' = 'Stress Type');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `stressed_acl_amount` SET TAGS ('dbx_business_glossary_term' = 'Stressed Authorized Control Level (ACL) Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `stressed_rbc_ratio` SET TAGS ('dbx_business_glossary_term' = 'Stressed Risk-Based Capital (RBC) Ratio');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `stressed_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Stressed Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `stressed_tac_amount` SET TAGS ('dbx_business_glossary_term' = 'Stressed Total Adjusted Capital (TAC) Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `test_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Test Execution Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `time_horizon_years` SET TAGS ('dbx_business_glossary_term' = 'Time Horizon Years');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`orsa_stress_test` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` SET TAGS ('dbx_subdomain' = 'experience_analysis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `opinion_id` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Opinion ID');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Opinion Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `reinsurance_treaty_id` SET TAGS ('dbx_business_glossary_term' = 'Treaty Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `statutory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Statutory Filing Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run ID');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `actuary_credentials` SET TAGS ('dbx_business_glossary_term' = 'Actuary Credentials');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `additional_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Additional Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `additional_reserve_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `appointed_actuary_name` SET TAGS ('dbx_business_glossary_term' = 'Appointed Actuary Name');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `appointed_actuary_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `asset_adequacy_conclusion` SET TAGS ('dbx_business_glossary_term' = 'Asset Adequacy Conclusion');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `asset_adequacy_conclusion` SET TAGS ('dbx_value_regex' = 'Adequate|Deficient|Qualified|Not Applicable');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `asset_adequacy_testing_scope` SET TAGS ('dbx_business_glossary_term' = 'Asset Adequacy Testing Scope');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `assumption_changes_disclosed_flag` SET TAGS ('dbx_business_glossary_term' = 'Assumption Changes Disclosed Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `document_file_path` SET TAGS ('dbx_business_glossary_term' = 'Document File Path');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `memorandum_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Memorandum Included Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `memorandum_page_count` SET TAGS ('dbx_business_glossary_term' = 'Memorandum Page Count');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `opinion_date` SET TAGS ('dbx_business_glossary_term' = 'Opinion Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `opinion_number` SET TAGS ('dbx_business_glossary_term' = 'Opinion Number');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `opinion_status` SET TAGS ('dbx_business_glossary_term' = 'Opinion Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `opinion_status` SET TAGS ('dbx_value_regex' = 'Draft|Under Review|Approved|Filed|Superseded|Withdrawn');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `opinion_type` SET TAGS ('dbx_business_glossary_term' = 'Opinion Type');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `opinion_type` SET TAGS ('dbx_value_regex' = 'SAO|AOMR|Combined');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `pbr_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Principle-Based Reserving (PBR) Compliant Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `peer_review_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Performed Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `peer_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Peer Reviewer Name');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `peer_reviewer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `qualification_reason` SET TAGS ('dbx_business_glossary_term' = 'Qualification Reason');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `qualified_opinion_flag` SET TAGS ('dbx_business_glossary_term' = 'Qualified Opinion Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `regulatory_action_description` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Action Description');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `regulatory_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Action Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `reinsurance_impact_disclosed_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Impact Disclosed Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `reserve_adequacy_conclusion` SET TAGS ('dbx_business_glossary_term' = 'Reserve Adequacy Conclusion');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `reserve_adequacy_conclusion` SET TAGS ('dbx_value_regex' = 'Adequate|Deficient|Redundant|Qualified');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `scenario_count` SET TAGS ('dbx_business_glossary_term' = 'Scenario Count');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `testing_methodology` SET TAGS ('dbx_business_glossary_term' = 'Testing Methodology');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `testing_methodology` SET TAGS ('dbx_value_regex' = 'Cash Flow Testing|Gross Premium Valuation|Stochastic Modeling|Deterministic Scenarios|Combined');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `total_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `total_reserve_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `vm20_deterministic_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'VM-20 Deterministic Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `vm20_deterministic_reserve_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `vm20_net_premium_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'VM-20 Net Premium Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `vm20_net_premium_reserve_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `vm20_stochastic_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'VM-20 Stochastic Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`opinion` ALTER COLUMN `vm20_stochastic_reserve_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` SET TAGS ('dbx_subdomain' = 'assumption_governance');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `assumption_detail_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Detail Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `assumption_set_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Actuary Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `prior_assumption_detail_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `assumption_basis` SET TAGS ('dbx_business_glossary_term' = 'Assumption Basis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `assumption_basis` SET TAGS ('dbx_value_regex' = 'best_estimate|conservative|prescribed|company_experience|industry_table|blended');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `assumption_detail_status` SET TAGS ('dbx_business_glossary_term' = 'Assumption Detail Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `assumption_detail_status` SET TAGS ('dbx_value_regex' = 'draft|active|superseded|retired|under_review');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `assumption_subtype` SET TAGS ('dbx_business_glossary_term' = 'Assumption Subtype');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `assumption_type` SET TAGS ('dbx_business_glossary_term' = 'Assumption Type');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `assumption_type` SET TAGS ('dbx_value_regex' = 'mortality|lapse|morbidity|expense|interest_rate|credibility');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `assumption_version` SET TAGS ('dbx_business_glossary_term' = 'Assumption Version');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `attained_age` SET TAGS ('dbx_business_glossary_term' = 'Attained Age');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `credibility_factor` SET TAGS ('dbx_business_glossary_term' = 'Credibility Factor');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `data_source_reference` SET TAGS ('dbx_business_glossary_term' = 'Data Source Reference');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `experience_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Experience Adjustment Factor');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `face_amount_band` SET TAGS ('dbx_business_glossary_term' = 'Face Amount Band');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'M|F|U');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `issue_age_band` SET TAGS ('dbx_business_glossary_term' = 'Issue Age Band');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Margin Percentage');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `model_platform` SET TAGS ('dbx_business_glossary_term' = 'Model Platform');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `mortality_improvement_scale` SET TAGS ('dbx_business_glossary_term' = 'Mortality Improvement Scale');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `mortality_table_reference` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Reference');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `policy_duration` SET TAGS ('dbx_business_glossary_term' = 'Policy Duration');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `product_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Product Segment Code');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit of Measure');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `rate_unit` SET TAGS ('dbx_value_regex' = 'percentage|decimal|currency|per_thousand|per_policy|per_unit');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `rate_value` SET TAGS ('dbx_business_glossary_term' = 'Rate Value');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_value_regex' = 'GAAP|SAP|IFRS17|PBR|VM20|tax');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `smoker_status` SET TAGS ('dbx_business_glossary_term' = 'Smoker Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `smoker_status` SET TAGS ('dbx_value_regex' = 'smoker|non_smoker|preferred|standard|unisex');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `underwriting_class` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` SET TAGS ('dbx_subdomain' = 'assumption_governance');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `model_governance_id` SET TAGS ('dbx_business_glossary_term' = 'Model Governance ID');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Report Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validator Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run ID');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `prior_version_model_governance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Model Approval Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Model Approval Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending|conditional|withdrawn');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `approved_by_actuary_name` SET TAGS ('dbx_business_glossary_term' = 'Approving Actuary Name');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Model Change Description');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `change_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Change Effective Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'assumption_update|logic_change|data_source_change|platform_upgrade|regulatory_compliance|defect_fix');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Governance Comments');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Model Documentation URL');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `impact_on_capital_amount` SET TAGS ('dbx_business_glossary_term' = 'Impact on Capital Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `impact_on_reserves_amount` SET TAGS ('dbx_business_glossary_term' = 'Impact on Reserves Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `materiality_assessment` SET TAGS ('dbx_business_glossary_term' = 'Materiality Assessment');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `materiality_assessment` SET TAGS ('dbx_value_regex' = 'material|immaterial|significant|minor');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `materiality_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Materiality Threshold Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Model Name');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `model_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Model Risk Rating');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `model_risk_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `model_status` SET TAGS ('dbx_business_glossary_term' = 'Model Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `model_status` SET TAGS ('dbx_value_regex' = 'development|testing|validated|production|retired|suspended');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Model Type');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version Number');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `next_validation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Validation Due Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `peer_review_date` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Completion Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `peer_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Required Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `peer_review_status` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `peer_review_status` SET TAGS ('dbx_value_regex' = 'completed|pending|not_required|in_progress|failed');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `peer_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Peer Reviewer Name');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `regulatory_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Action Required Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `regulatory_examination_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Examination Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `regulatory_examination_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Examination Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `regulatory_findings` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Examination Findings');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `sox_control_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'SOX (Sarbanes-Oxley Act) Control Applicable Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `sox_control_test_date` SET TAGS ('dbx_business_glossary_term' = 'SOX (Sarbanes-Oxley Act) Control Test Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `sox_control_test_result` SET TAGS ('dbx_business_glossary_term' = 'SOX (Sarbanes-Oxley Act) Control Test Result');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `sox_control_test_result` SET TAGS ('dbx_value_regex' = 'effective|ineffective|not_tested|remediation_required');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Model Validation Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `validation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Validation Frequency');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `validation_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|ad_hoc|as_needed');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`model_governance` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional|pending|not_required');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` SET TAGS ('dbx_subdomain' = 'assumption_governance');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `mortality_table_id` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `experience_study_id` SET TAGS ('dbx_business_glossary_term' = 'Experience Study Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `base_mortality_table_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `approved_by_actuary_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Actuary Name');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `credibility_factor` SET TAGS ('dbx_business_glossary_term' = 'Credibility Factor');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `data_source_reference` SET TAGS ('dbx_business_glossary_term' = 'Data Source Reference');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation Uniform Resource Locator (URL)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `gaap_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Compliant Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `gender_basis` SET TAGS ('dbx_business_glossary_term' = 'Gender Basis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `gender_basis` SET TAGS ('dbx_value_regex' = 'male|female|unisex|gender_distinct|composite');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `gender_basis` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `gender_basis` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `ifrs17_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standard 17 (IFRS 17) Compliant Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `issue_age_max` SET TAGS ('dbx_business_glossary_term' = 'Issue Age Maximum');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `issue_age_min` SET TAGS ('dbx_business_glossary_term' = 'Issue Age Minimum');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Margin Percentage');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `mortality_improvement_scale` SET TAGS ('dbx_business_glossary_term' = 'Mortality Improvement Scale');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `pbr_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Principle-Based Reserving (PBR) Compliant Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `predecessor_table_code` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Table Code');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `product_applicability` SET TAGS ('dbx_business_glossary_term' = 'Product Applicability');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_value_regex' = 'naic_prescribed|company_specific|soa_published|international|custom');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `sap_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Statutory Accounting Principles (SAP) Compliant Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `select_period_years` SET TAGS ('dbx_business_glossary_term' = 'Select Period Duration (Years)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `smoker_class` SET TAGS ('dbx_business_glossary_term' = 'Smoker Classification');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `smoker_class` SET TAGS ('dbx_value_regex' = 'smoker|non_smoker|aggregate|preferred_non_smoker|standard_non_smoker|tobacco_user');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `superseded_by_table_code` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Table Code');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `table_code` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Code');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `table_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `table_name` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Name');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `table_status` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `table_status` SET TAGS ('dbx_value_regex' = 'active|superseded|archived|pending_approval|withdrawn');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `table_type` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Type');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `table_type` SET TAGS ('dbx_value_regex' = 'valuation|pricing|underwriting|experience|reinsurance|illustration');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `ultimate_age_max` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Age Maximum');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `ultimate_age_min` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Age Minimum');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `underwriting_class` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Classification');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}(.[0-9]{1,3}){0,2}$');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_strategy` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_strategy` SET TAGS ('dbx_subdomain' = 'investment_strategy');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_strategy` SET TAGS ('dbx_association_edges' = 'actuarial.cohort_definition,investment.portfolio');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_strategy` ALTER COLUMN `alm_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'ALM Strategy Identifier');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_strategy` ALTER COLUMN `cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Alm Strategy - Cohort Definition Id');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_strategy` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Alm Strategy - Portfolio Id');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_strategy` ALTER COLUMN `alm_strategy_type` SET TAGS ('dbx_business_glossary_term' = 'ALM Strategy Type');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_strategy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Strategy Effective Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_strategy` ALTER COLUMN `investment_committee_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Committee Approval Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_strategy` ALTER COLUMN `last_rebalancing_date` SET TAGS ('dbx_business_glossary_term' = 'Last Rebalancing Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_strategy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Strategy Notes');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_strategy` ALTER COLUMN `rebalancing_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Trigger Threshold');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_strategy` ALTER COLUMN `strategy_status` SET TAGS ('dbx_business_glossary_term' = 'Strategy Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_strategy` ALTER COLUMN `target_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Allocation Weight');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_strategy` ALTER COLUMN `target_duration_years` SET TAGS ('dbx_business_glossary_term' = 'Target Duration Match');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`alm_strategy` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Strategy Termination Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_application` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_application` SET TAGS ('dbx_subdomain' = 'assumption_governance');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_application` SET TAGS ('dbx_association_edges' = 'actuarial.assumption_set,product.product_plan');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_application` ALTER COLUMN `assumption_application_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Application ID');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_application` ALTER COLUMN `assumption_set_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Application - Assumption Set Id');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Actuary ID');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_application` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Application - Plan Id');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_application` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Application Approval Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_application` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Application Effective Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_application` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Application Expiration Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_application` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_application` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Flag');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_application` ALTER COLUMN `override_notes` SET TAGS ('dbx_business_glossary_term' = 'Override Notes');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_application` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_application` ALTER COLUMN `usage_purpose` SET TAGS ('dbx_business_glossary_term' = 'Usage Purpose');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` SET TAGS ('dbx_subdomain' = 'assumption_governance');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` SET TAGS ('dbx_association_edges' = 'actuarial.assumption_set,vendor.vendor');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` ALTER COLUMN `assumption_data_source_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Data Source ID');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` ALTER COLUMN `assumption_set_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Data Source - Assumption Set Id');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Owner Employee ID');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Data Source - Vendor Id');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` ALTER COLUMN `assumption_data_source_status` SET TAGS ('dbx_business_glossary_term' = 'Data Source Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` ALTER COLUMN `cost_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Percentage');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` ALTER COLUMN `data_source_type` SET TAGS ('dbx_business_glossary_term' = 'Data Source Type');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` ALTER COLUMN `data_version` SET TAGS ('dbx_business_glossary_term' = 'Data Version');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` ALTER COLUMN `license_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'License Cost Amount');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` ALTER COLUMN `license_end_date` SET TAGS ('dbx_business_glossary_term' = 'License End Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` ALTER COLUMN `license_start_date` SET TAGS ('dbx_business_glossary_term' = 'License Start Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Data Source Notes');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` ALTER COLUMN `usage_scope` SET TAGS ('dbx_business_glossary_term' = 'Usage Scope');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Name');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_data_source` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`scenario_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`scenario_set` SET TAGS ('dbx_subdomain' = 'reserve_management');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`scenario_set` ALTER COLUMN `scenario_set_id` SET TAGS ('dbx_business_glossary_term' = 'Scenario Set Identifier');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`scenario_set` ALTER COLUMN `base_scenario_set_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`scenario_set` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`scenario_set` ALTER COLUMN `created_by_user` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`scenario_set` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`liability_segment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`liability_segment` SET TAGS ('dbx_subdomain' = 'reserve_management');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`liability_segment` ALTER COLUMN `liability_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Liability Segment Identifier');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`liability_segment` ALTER COLUMN `parent_liability_segment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
