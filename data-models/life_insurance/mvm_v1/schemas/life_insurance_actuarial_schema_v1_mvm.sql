-- Schema for Domain: actuarial | Business: Life Insurance | Version: v1_mvm
-- Generated on: 2026-05-04 07:01:16

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `life_insurance_ecm`.`actuarial` COMMENT 'Owns all actuarial valuation, reserving, and experience study data. Manages GAAP/SAP/IFRS reserve calculations, PBR (Principle-Based Reserving) per VM-20, cash flow projections, mortality and lapse assumption tables, DAC amortization schedules, LDTI transition adjustments, ALM analysis, and ORSA inputs. Supports Prophet/AXIS/MoSes model outputs, EOY/BOY reserve snapshots, pricing, product development, and ERM frameworks.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` (
    `reserve_calculation_id` BIGINT COMMENT 'Unique identifier for the reserve calculation record. Primary key for this entity.',
    `annuitant_id` BIGINT COMMENT 'Foreign key linking to policyholder.annuitant. Business justification: Annuity reserve calculations require the annuitants age, payout option, benefit base, and GMWB/GMIB indicators to compute longevity reserves. The existing annuity_contract_id does not provide direct ',
    `assumption_set_id` BIGINT COMMENT 'Reference to the actuarial assumption set (mortality, lapse, expense, interest) applied in this reserve calculation.',
    `cohort_definition_id` BIGINT COMMENT 'Reference to the policy cohort definition used for grouped reserve calculations. Cohorts typically group policies by issue year, product type, and underwriting class.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: Statutory and GAAP reserves are calculated at the individual annuity contract level. Essential for financial reporting, regulatory filings (Annual Statement), PBR compliance, and reconciliation of agg',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the individual policy or contract for which reserves are calculated. May be null for cohort-level or model-segment-level calculations.',
    `insured_id` BIGINT COMMENT 'Foreign key linking to policyholder.insured. Business justification: Reserve calculations require individual insured characteristics (issue age, attained age, gender, tobacco status, risk class) for accurate mortality and lapse assumptions. Actuaries calculate reserves',
    `mortality_table_id` BIGINT COMMENT 'Foreign key linking to actuarial.mortality_table. Business justification: reserve_calculation.mortality_assumption_table is a STRING column holding a denormalized reference to the mortality table used in the calculation. Replacing it with a FK mortality_table_id → actuarial',
    `pbr_model_segment_id` BIGINT COMMENT 'Reference to the PBR model segment used for VM-20 deterministic and stochastic reserve calculations. Segments group policies by similar risk characteristics.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Reserve calculations require direct product plan reference for applying product-specific reserve basis rules (statutory/GAAP/IFRS17), PBR model segment assignment, and assumption set selection. Critic',
    `plan_version_id` BIGINT COMMENT 'Foreign key linking to product.plan_version. Business justification: Reserves are calculated against a specific plan version — PBR applicability, benefit structures, and reserve basis change with plan version. Statutory reserve reporting and actuarial opinion require v',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: PBR (VM-20) and asset adequacy testing require identifying the investment portfolio backing each reserve calculation to apply correct earned rate assumptions and RBC C-3 interest rate risk charges. Ac',
    `premium_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.premium_schedule. Business justification: Net premium reserve calculations under SAP/GAAP require the gross premium, limited pay years, and premium paying period from the billing premium_schedule. Actuarial reserve systems must reference the ',
    `scenario_set_id` BIGINT COMMENT 'Foreign key linking to actuarial.scenario_set. Business justification: reserve_calculation captures stochastic_reserve_amount and stochastic_scenario_count, indicating it is computed against a set of stochastic scenarios. Adding scenario_set_id normalizes the reference t',
    `valuation_run_id` BIGINT COMMENT 'Reference to the parent actuarial valuation run that produced this reserve calculation. Links to the valuation cycle execution (e.g., Q4 2023 year-end valuation).',
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
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Valuation runs are scheduled and mandated by specific regulatory obligations (e.g., annual statutory valuation, quarterly LDTI). Compliance tracks which regulatory_obligation triggers each valuation_r',
    `scenario_set_id` BIGINT COMMENT 'Foreign key linking to actuarial.scenario_set. Business justification: valuation_run.scenario_count (INT) is an aggregate count of scenarios used in the run, but there is no FK to the scenario_set that defines those scenarios. Adding scenario_set_id → actuarial.scenario_',
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
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Assumption sets require formal peer review documentation and actuarial sign-off per ASOP standards. The existing documentation_url is a denormalized text reference; replacing it with a proper FK to do',
    `experience_study_id` BIGINT COMMENT 'Reference to the experience study from which this assumption set was derived or updated. Null if not based on a formal experience study.',
    `parent_assumption_set_id` BIGINT COMMENT 'Reference to the prior version or parent assumption set from which this set was derived. Null if this is the initial version.',
    `approval_date` DATE COMMENT 'The date on which the assumption set was formally approved by the appointed actuary or governance committee.',
    `assumption_basis` STRING COMMENT 'The basis or philosophy underlying the assumption set: best estimate (unbiased), prudent estimate (conservative), prescribed (regulatory mandate), pricing (product development), experience adjusted (updated from studies), or regulatory minimum.. Valid values are `best_estimate|prudent_estimate|prescribed|pricing|experience_adjusted|regulatory_minimum`',
    `assumption_set_description` STRING COMMENT 'Detailed narrative description of the assumption set, including its purpose, key assumptions, data sources, and any special considerations or limitations.',
    `assumption_set_status` STRING COMMENT 'Current lifecycle status of the assumption set: draft (in development), under review (pending approval), approved (ready for use), active (currently in use), superseded (replaced by newer set), or archived (historical reference only).. Valid values are `draft|under_review|approved|active|superseded|archived`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this assumption set record was first created in the system.',
    `credibility_factor` DECIMAL(18,2) COMMENT 'Statistical credibility factor (0.00 to 1.00) applied to experience data when blending company-specific experience with industry tables. 1.00 indicates full credibility; lower values indicate partial credibility requiring industry benchmarks.',
    `data_source_reference` STRING COMMENT 'Reference to the data sources used to calibrate this assumption set (e.g., Company Experience 2020-2023, SOA 2017 CSO, Industry Benchmark Study Q3 2023).',
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
    `annuitant_id` BIGINT COMMENT 'Foreign key linking to policyholder.annuitant. Business justification: Annuity cash flow projections depend on annuitant age, joint survivor percentage, payout option, and GMWB/GMIB flags to model benefit outflows and longevity risk. Direct annuitant_id linkage is requir',
    `assumption_set_id` BIGINT COMMENT 'Foreign key linking to actuarial.assumption_set. Business justification: cash_flow_projection drives projected benefit outflows, premium inflows, and lapse rates from actuarial assumptions, yet has no FK to assumption_set. Adding assumption_set_id → actuarial.assumption_se',
    `cession_id` BIGINT COMMENT 'Foreign key linking to reinsurance.cession. Business justification: Cash flow projections model reinsurance cash flows (ceded premiums, recoverables) at cession level for ALM analysis, capital planning, and asset adequacy testing.',
    `cohort_definition_id` BIGINT COMMENT 'Foreign key linking to actuarial.cohort_definition. Business justification: Under LDTI (ASU 2018-12) and IFRS 17, cash flow projections are organized by cohort. cash_flow_projection has no FK to cohort_definition despite cohort_definition being the master record for LDTI annu',
    `contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: Cash flow projections model future premiums, benefits, and expenses for specific annuity contracts. Required for asset-liability management, ORSA stress testing, and PBR stochastic reserve calculation',
    `crediting_strategy_id` BIGINT COMMENT 'Foreign key linking to product.crediting_strategy. Business justification: For IUL/FIA/annuity products, cash flow projections explicitly model crediting strategy scenarios (cap rates, participation rates, floor rates). Asset-liability management projections and LDTI loss re',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the specific policy or policy cohort for which cash flows are projected.',
    `insured_id` BIGINT COMMENT 'Foreign key linking to policyholder.insured. Business justification: Cash flow projections model mortality, lapse, and benefit payments by individual insured attributes (age, gender, underwriting class, tobacco status). Actuarial models require insured-level detail for',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Cash flow projections model product-specific premium inflows, benefit outflows, and expense patterns for pricing validation, profitability analysis, embedded value calculations, and ALM duration match',
    `plan_version_id` BIGINT COMMENT 'Foreign key linking to product.plan_version. Business justification: Cash flow projections use version-specific benefit structures, charge schedules, and crediting strategies. Asset-liability management and LDTI loss recognition testing require projections tied to the ',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: ALM cash flow testing requires projecting liability cash flows against the specific backing investment portfolio to compute duration gap, reinvestment rates, and asset adequacy. NAIC cash flow testing',
    `premium_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.premium_schedule. Business justification: Actuarial cash flow projections model future premium inflows for LDTI/IFRS17 reporting. The premium_schedule is the authoritative source of modal premium amounts, billing frequency, and payment period',
    `separate_account_fund_id` BIGINT COMMENT 'Foreign key linking to product.separate_account_fund. Business justification: For variable life/annuity products, cash flow projections are fund-specific — separate account fund performance (expense ratio, asset class) drives projection assumptions. Variable product actuarial m',
    `separate_account_id` BIGINT COMMENT 'Foreign key linking to investment.separate_account. Business justification: Variable annuity and variable life cash flow projections must reference the specific separate account to apply fund-level return paths, unit values, and M&E charges. GMDB/GMWB stochastic reserve model',
    `stochastic_scenario_id` BIGINT COMMENT 'Reference to the stochastic or deterministic scenario under which this projection was calculated.',
    `valuation_run_id` BIGINT COMMENT 'Reference to the parent actuarial valuation run that generated this projection.',
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
    `benefit_structure_id` BIGINT COMMENT 'Foreign key linking to product.benefit_structure. Business justification: DI and LTC experience studies are segmented by benefit structure parameters (elimination period, benefit period, disability definition). Morbidity experience studies require benefit_structure linkage ',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Experience studies analyze actual vs expected mortality, lapse, and expense by product to set product-specific assumptions, determine credibility weighting, and recommend assumption updates. Required ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Experience studies are conducted to fulfill specific regulatory obligations (NAIC PBR credibility requirements, VM-20/VM-21 mandates). Linking experience_study to the regulatory_obligation it satisfie',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Experience studies produce formal reports with peer review documentation and assumption change justifications required for regulatory examinations, internal governance, and assumption governance proce',
    `underwriting_class_id` BIGINT COMMENT 'Foreign key linking to product.underwriting_class. Business justification: Experience studies are segmented by underwriting class to validate class-specific mortality/lapse assumptions. The underwriting_class.experience_study_mortality_ratio field confirms this dependency. A',
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
    `assumption_detail_id` BIGINT COMMENT 'Foreign key linking to actuarial.assumption_detail. Business justification: experience_study_result.assumption_table_reference (STRING) and assumption_version (STRING) are denormalized references to the specific assumption detail record against which actual experience was com',
    `benefit_structure_id` BIGINT COMMENT 'Foreign key linking to product.benefit_structure. Business justification: DI/LTC experience study results are segmented by benefit structure (elimination period, benefit period, disability definition). Morbidity A/E ratios by benefit design are required for product repricin',
    `experience_study_id` BIGINT COMMENT 'Reference to the parent experience study that generated this result cell.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Granular A/E ratios by product segment drive product-specific assumption updates, mortality table selection, and lapse rate adjustments. Critical for pricing adequacy reviews and competitive positioni',
    `risk_class_id` BIGINT COMMENT 'Foreign key linking to underwriting.risk_class. Business justification: Experience studies segment actual-to-expected mortality and lapse results by underwriting class, a core actuarial requirement for PBR credibility and assumption updates. Linking to the canonical risk_',
    `underwriting_class_id` BIGINT COMMENT 'Foreign key linking to product.underwriting_class. Business justification: experience_study_result.underwriting_class is a plain denormalized attribute. Results are segmented by underwriting class for A/E ratio analysis. Actuaries use these results to update underwriting_cla',
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
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this experience study result record was last modified.',
    `variance` DECIMAL(18,2) COMMENT 'The statistical variance of the observed experience for this cohort, used in credibility and margin calculations.',
    CONSTRAINT pk_experience_study_result PRIMARY KEY(`experience_study_result_id`)
) COMMENT 'Detailed transactional results from actuarial experience studies at the cell or cohort level. Stores actual claims/lapses/expenses, expected values under current assumptions, A/E ratios, exposure amounts, and credibility factors by age band, duration, gender, and product segment. Feeds assumption refinement and pricing model calibration.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` (
    `pbr_model_segment_id` BIGINT COMMENT 'Unique identifier for the PBR model segment. Primary key for the table.',
    `assumption_set_id` BIGINT COMMENT 'Foreign key linking to actuarial.assumption_set. Business justification: pbr_model_segment defines VM-20 model segments with segment-specific assumption parameters (base_lapse_rate, expense_assumption_basis, lapse_assumption_basis, company_experience_adjustment) but has no',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: VM-20 PBR requires an actuarial memorandum documenting each model segments assumptions, credibility, and methodology. Actuaries and examiners must link each PBR model segment to its supporting VM-20 ',
    `mortality_table_id` BIGINT COMMENT 'Foreign key linking to actuarial.mortality_table. Business justification: PBR model segment references a prescribed mortality table per VM-20 requirements. The pbr_model_segment.prescribed_mortality_table attribute (STRING) should be replaced with a FK to mortality_table.mo',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: PBR model segments are product-specific groupings for VM-20 principle-based reserve calculations. Each product requires defined segments by underwriting class, distribution channel, and credibility th',
    `plan_version_id` BIGINT COMMENT 'Foreign key linking to product.plan_version. Business justification: PBR model segments are version-specific — plan_version.pbr_applicable flag determines PBR applicability. NAIC VM-20 compliance requires model segments to be traceable to the specific plan version, as ',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: VM-20 PBR requires each model segment to be associated with its supporting asset portfolio for deterministic and stochastic reserve calculations. The investment portfolio drives earned rate assumption',
    `risk_class_id` BIGINT COMMENT 'Foreign key linking to underwriting.risk_class. Business justification: VM-20 PBR regulations require reserve model segments to be defined by underwriting classification. Direct FK from pbr_model_segment to the canonical risk_class ensures reserve segmentation boundaries ',
    `scenario_set_id` BIGINT COMMENT 'Foreign key linking to actuarial.scenario_set. Business justification: pbr_model_segment.stochastic_scenario_count (INT) indicates the segment uses stochastic scenarios for PBR CTE calculations, but there is no FK to the scenario_set defining those scenarios. Adding scen',
    `state_regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.state_regulation. Business justification: PBR model segment definitions are driven by state-specific regulatory requirements (VM-20 segmentation rules vary by state). pbr_model_segment has reserve_basis and distribution_channel but no FK to t',
    `treaty_id` BIGINT COMMENT 'Foreign key linking to reinsurance.treaty. Business justification: PBR model segments align with treaty coverage for reserve credit calculations and RBC reporting. Required for VM-20 compliance, deterministic/stochastic reserve calculation, and Schedule S disclosure.',
    `underwriting_class_id` BIGINT COMMENT 'Foreign key linking to product.underwriting_class. Business justification: pbr_model_segment.underwriting_class is a plain denormalized attribute. PBR model segments are defined by underwriting class per NAIC VM-20 requirements. Regulatory PBR compliance requires tracing mod',
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
    `valuation_system` STRING COMMENT 'Actuarial modeling system used to calculate reserves for this model segment (e.g., Prophet, AXIS, MoSes).. Valid values are `prophet|axis|moses|other`',
    CONSTRAINT pk_pbr_model_segment PRIMARY KEY(`pbr_model_segment_id`)
) COMMENT 'Master table defining PBR (Principle-Based Reserving) model segments per VM-20 requirements. Captures segment definition criteria (product type, issue age band, underwriting class, distribution channel), credibility threshold, prescribed vs. company experience blend, and segment-level reserve basis. Required for VM-20 deterministic and stochastic reserve calculations.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` (
    `stochastic_scenario_id` BIGINT COMMENT 'Unique identifier for the stochastic scenario record. Primary key.',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: ORSA stress testing and PBR stochastic reserve calculations require applying interest rate and equity return scenarios to specific investment portfolios to measure capital adequacy and reserve impacts',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: ORSA filings and capital adequacy regulatory submissions reference specific stochastic scenarios used in stress testing. stochastic_scenario has orsa_filing_year and regulatory_submission_date confirm',
    `scenario_set_id` BIGINT COMMENT 'Identifier for the scenario set to which this scenario belongs (e.g., NAIC_2024_VM20_10K, ALM_Q1_2024, ORSA_2024_BASE). Groups scenarios generated together for a specific purpose and valuation date.',
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
    `annuitant_id` BIGINT COMMENT 'Foreign key linking to policyholder.annuitant. Business justification: Point-in-time reserve snapshots for annuity contracts require the annuitants current age, benefit base, and payout option for LDTI/IFRS17 reporting. Direct annuitant_id linkage enables per-annuitant ',
    `assumption_set_id` BIGINT COMMENT 'Foreign key linking to actuarial.assumption_set. Business justification: reserve_snapshot.mortality_assumption_table is a STRING denormalized reference. Adding assumption_set_id → actuarial.assumption_set.assumption_set_id links each snapshot to the governing assumption se',
    `cession_id` BIGINT COMMENT 'Foreign key linking to reinsurance.cession. Business justification: Reserve snapshots track ceded reserves at individual cession level for quarterly reserve reporting, reconciliation with bordereaux, and statutory filing (Schedule S).',
    `cohort_definition_id` BIGINT COMMENT 'Foreign key linking to actuarial.cohort_definition. Business justification: Reserve snapshot has cohort_identifier attribute, clearly referencing a cohort_definition for LDTI/IFRS17 cohort-level reserve tracking. Adding cohort_definition_id FK allows joining to the full cohor',
    `contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: Reserve snapshots capture point-in-time reserve balances for individual annuity contracts. Critical for reserve roll-forward analysis, variance investigation, and regulatory examination support. Curre',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy for which reserves are being calculated and snapshotted.',
    `insured_id` BIGINT COMMENT 'Foreign key linking to policyholder.insured. Business justification: Reserve snapshots capture point-in-time reserve positions by individual insured life for regulatory reporting (statutory annual statements) and financial close. Insurers track reserves at insured-leve',
    `pbr_model_segment_id` BIGINT COMMENT 'Foreign key linking to actuarial.pbr_model_segment. Business justification: reserve_snapshot contains pbr_deterministic_reserve, pbr_net_premium_reserve, and pbr_stochastic_reserve — three PBR-specific reserve fields — yet has no FK to pbr_model_segment. Adding pbr_model_segm',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Reserve snapshots track product-level reserve adequacy for quarterly statutory reporting, GAAP financial statements, and regulatory examinations. Required for product profitability monitoring and rese',
    `plan_version_id` BIGINT COMMENT 'Foreign key linking to product.plan_version. Business justification: Reserve snapshots for closed blocks and retired plan versions require version-specific tracking. Financial close reporting and actuarial opinion documentation require reserve snapshots linked to the e',
    `scenario_set_id` BIGINT COMMENT 'Foreign key linking to actuarial.scenario_set. Business justification: reserve_snapshot captures pbr_stochastic_reserve, which is computed under a set of stochastic economic scenarios. Adding scenario_set_id → actuarial.scenario_set.scenario_set_id links the snapshot to ',
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
    `benefit_structure_id` BIGINT COMMENT 'Foreign key linking to product.benefit_structure. Business justification: Actuarial pricing sign-off process: pricing basis is constructed per benefit structure (death benefit type, COI structure, nonforfeiture options). Actuaries price each benefit structure variant separa',
    `coi_rate_schedule_id` BIGINT COMMENT 'Foreign key linking to product.coi_rate_schedule. Business justification: For UL/VUL products, the pricing basis drives COI rate schedule design. Actuarial pricing sign-off on COI schedules requires tracing each schedule to its pricing basis for IRC 7702 compliance certific',
    `crediting_strategy_id` BIGINT COMMENT 'Foreign key linking to product.crediting_strategy. Business justification: For IUL/FIA/annuity products, pricing basis sets cap rates, participation rates, and spread rates that define the crediting strategy. Actuarial pricing sign-off on crediting strategies is a named proc',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: State DOI rate filings and actuarial memoranda require formal pricing basis documentation. Actuaries and compliance teams must link each pricing basis to its supporting regulatory document for rate fi',
    `irc7702_parameter_id` BIGINT COMMENT 'Foreign key linking to product.irc7702_parameter. Business justification: IRC 7702 parameters (guideline premium, corridor factors, seven-pay limits) directly constrain actuarial pricing for life insurance products. Pricing actuaries must reference irc7702_parameter when se',
    `mortality_table_id` BIGINT COMMENT 'Foreign key linking to actuarial.mortality_table. Business justification: Pricing basis directly references a specific mortality table for pricing calculations. The pricing_basis.mortality_table_code attribute should be replaced with a FK to mortality_table.mortality_table_',
    `plan_id` BIGINT COMMENT 'Reference to the life insurance or annuity product for which this pricing basis applies.',
    `plan_version_id` BIGINT COMMENT 'Foreign key linking to product.plan_version. Business justification: Pricing bases are version-specific; rate changes, assumption updates, or filing amendments require new plan versions per state insurance department requirements. Essential for tracking rate action his',
    `policy_form_approval_id` BIGINT COMMENT 'Foreign key linking to compliance.policy_form_approval. Business justification: Policy form approvals require actuarial pricing basis for DOI review of rates, benefits, and reserves. Form and rate filings are often submitted together. Links pricing assumptions to approved policy ',
    `premium_rate_table_id` BIGINT COMMENT 'Foreign key linking to product.premium_rate_table. Business justification: Actuarial pricing process: the pricing basis is the actuarial justification document that produces the premium rate table. Actuaries must trace rate tables back to their pricing basis for state rate f',
    `rate_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.rate_filing. Business justification: Rate filings submitted to DOI require actuarial pricing basis documentation (mortality tables, expense assumptions, profit margins). Pricing basis is the actuarial foundation for rate filing approval.',
    `risk_class_id` BIGINT COMMENT 'Foreign key linking to underwriting.risk_class. Business justification: Pricing bases are constructed per underwriting risk class (preferred, standard, substandard) for rate filings and regulatory submissions. Actuaries must trace which canonical risk_class definition dro',
    `underwriting_class_id` BIGINT COMMENT 'Foreign key linking to product.underwriting_class. Business justification: Pricing bases are constructed per underwriting class (smoker_status_pricing_flag, gender_distinct_pricing_flag confirm this segmentation). Actuarial pricing sign-off requires linking each pricing basi',
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
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this pricing basis record was last modified.',
    CONSTRAINT pk_pricing_basis PRIMARY KEY(`pricing_basis_id`)
) COMMENT 'Master table defining actuarial pricing bases for life insurance and annuity products. Captures pricing mortality table, lapse assumption set, expense loading, investment return assumption, profit margin target (ROI/NBV), and regulatory compliance basis (GPT/CVAT for 7702). Links to product definitions and supports new product development, rate filings, and repricing reviews.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` (
    `cohort_definition_id` BIGINT COMMENT 'Unique identifier for the cohort definition record. Primary key for the cohort definition entity.',
    `assumption_set_id` BIGINT COMMENT 'Foreign key linking to actuarial.assumption_set. Business justification: cohort_definition.mortality_assumption_table (STRING) is a denormalized reference to the mortality assumption used for the cohort. Under LDTI, each cohort has locked-in discount rates and assumptions ',
    `benefit_structure_id` BIGINT COMMENT 'Foreign key linking to product.benefit_structure. Business justification: LDTI cohorts group contracts with similar risk characteristics including benefit structure (death benefit type, nonforfeiture options). ASC 944-40 cohort grouping methodology and IFRS17 group definiti',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: LDTI and IFRS17 cohorts are product-specific groupings by issue year and profitability classification. Each product requires separate cohort tracking for locked-in discount rates, CSM amortization, an',
    `plan_version_id` BIGINT COMMENT 'Foreign key linking to product.plan_version. Business justification: LDTI cohorts are established at initial recognition tied to a specific plan version. ASC 944-40 requires cohorts to reflect contracts issued under the same product terms — plan_version captures these ',
    `risk_class_id` BIGINT COMMENT 'Foreign key linking to underwriting.risk_class. Business justification: LDTI and IFRS17 cohort groupings are defined at initial recognition using underwriting class as a key segmentation dimension. Linking cohort_definition to the canonical risk_class ensures cohort bound',
    `underwriting_class_id` BIGINT COMMENT 'Foreign key linking to product.underwriting_class. Business justification: cohort_definition.underwriting_class is a plain denormalized attribute. LDTI/IFRS17 cohorts are grouped by similar risk characteristics including underwriting class. ASC 944 cohort grouping methodolog',
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
    `next_valuation_date` DATE COMMENT 'The scheduled date for the next actuarial valuation of this cohort, typically quarterly or annually depending on reporting requirements.',
    `pbr_method` STRING COMMENT 'The Principle-Based Reserving methodology applied to this cohort under NAIC Valuation Manual VM-20 or VM-21: deterministic reserve, stochastic reserve, net premium reserve, or not applicable for products not subject to PBR.. Valid values are `deterministic|stochastic|net_premium|not_applicable`',
    `policy_count` STRING COMMENT 'The current number of active policies or contracts included in this cohort. Used for coverage unit calculations and experience monitoring.',
    `profitability_classification` STRING COMMENT 'IFRS 17 classification of the cohort at initial recognition: onerous (expected to be loss-making), profitable (expected to generate profit), or neither (break-even). Determines initial measurement and subsequent CSM (Contractual Service Margin) treatment.. Valid values are `onerous|profitable|neither`',
    `reinsurance_treaty_applicable` BOOLEAN COMMENT 'Indicates whether policies in this cohort are subject to reinsurance treaties. True if reinsurance applies, False if the cohort is retained 100% by the direct writer.',
    `termination_date` DATE COMMENT 'The date when this cohort definition was terminated or superseded, if applicable. Null for active cohorts.',
    `total_account_value` DECIMAL(18,2) COMMENT 'The aggregate account value across all contracts in this cohort. Primary metric for annuity and universal life cohorts.',
    `total_face_amount` DECIMAL(18,2) COMMENT 'The aggregate face amount or death benefit across all policies in this cohort. Key metric for life insurance cohorts and risk exposure monitoring.',
    `updated_by_user` STRING COMMENT 'The user identifier or system account that last modified this cohort definition record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this cohort definition record was last modified.',
    CONSTRAINT pk_cohort_definition PRIMARY KEY(`cohort_definition_id`)
) COMMENT 'Master table defining policy cohorts for LDTI (ASU 2018-12) annual cohort grouping and IFRS 17 group of insurance contracts. Captures cohort grouping criteria (product type, issue year, profitability classification — onerous, profitable, or neither), LDTI transition date, locked-in discount rate, initial LFPB measurement, and IFRS 17 portfolio/group hierarchy. Required for LDTI annual cohort remeasurement, IFRS 17 CSM unit of account, and DAC amortization grouping under ASC 944.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` (
    `assumption_detail_id` BIGINT COMMENT 'Unique identifier for each assumption detail record. Primary key for the assumption detail product.',
    `assumption_set_id` BIGINT COMMENT 'Foreign key reference to the parent assumption set that governs this detail record. Links this detail to its controlling assumption set for valuation runs and experience studies.',
    `mortality_table_id` BIGINT COMMENT 'Foreign key linking to actuarial.mortality_table. Business justification: assumption_detail.mortality_table_reference (STRING) is a denormalized reference to the mortality table underlying a mortality-type assumption detail record. Adding mortality_table_id → actuarial.mort',
    `prior_assumption_detail_id` BIGINT COMMENT 'Self-referencing FK on assumption_detail (prior_assumption_detail_id)',
    `risk_class_id` BIGINT COMMENT 'Foreign key linking to underwriting.risk_class. Business justification: Actuarial assumption details (mortality rates, lapse rates) are segmented by underwriting risk class per PBR/VM-20 requirements. Direct FK to the canonical risk_class definition ensures assumption seg',
    `underwriting_class_id` BIGINT COMMENT 'Foreign key linking to product.underwriting_class. Business justification: assumption_detail.underwriting_class is a plain denormalized attribute. Actuarial assumptions (mortality rates, lapse rates) are set at the underwriting class level. Linking to underwriting_class enab',
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
    `policy_duration` STRING COMMENT 'The policy duration (years since issue) for which this assumption rate applies. Used for duration-based segmentation in lapse and mortality assumptions. Null if assumption is not duration-dependent.',
    `product_segment_code` STRING COMMENT 'Product segment or product type code for which this assumption rate applies. Examples: term, whole_life, universal_life, indexed_universal_life, variable_universal_life. Enables product-specific assumption calibration. Null if assumption applies across all products.',
    `rate_unit` STRING COMMENT 'Unit of measure for the rate_value. Clarifies whether the value is a percentage, decimal fraction, currency amount, per-thousand rate, per-policy amount, or per-unit cost.. Valid values are `percentage|decimal|currency|per_thousand|per_policy|per_unit`',
    `rate_value` DECIMAL(18,2) COMMENT 'The numeric assumption value for this detail record. Interpretation depends on assumption_type: mortality qx, lapse percentage, expense dollar amount, interest rate percentage, credibility factor. Supports high precision for actuarial calculations.',
    `regulatory_basis` STRING COMMENT 'The regulatory or accounting framework for which this assumption detail is intended. Examples: GAAP, SAP (Statutory Accounting Principles), IFRS17, PBR (Principle-Based Reserving), VM-20, tax compliance.. Valid values are `GAAP|SAP|IFRS17|PBR|VM20|tax`',
    `smoker_status` STRING COMMENT 'Smoking status classification for which this assumption rate applies. Used for risk-class segmentation in mortality assumptions. Null if assumption is not smoker-status-dependent.. Valid values are `smoker|non_smoker|preferred|standard|unisex`',
    `valuation_date` DATE COMMENT 'The valuation date for which this assumption detail is calibrated or applicable. Typically aligns with the valuation run date or experience study period end date.',
    CONSTRAINT pk_assumption_detail PRIMARY KEY(`assumption_detail_id`)
) COMMENT 'Typed detail records under an assumption set capturing individual assumption values by assumption type (mortality, lapse, morbidity, expense, interest rate, credibility). Stores rate values by age, duration, gender, risk class, and other segmentation dimensions. Each row is typed (mortality qx, lapse rate, expense per-policy, credited rate, etc.) and linked to its parent assumption_set. Replaces the need for separate mortality_table, lapse_assumption, disability_assumption, expense_assumption, interest_rate_assumption, and credibility_factor products while preserving full granularity. Supports PBR credibility blending, experience study updates, and pricing model calibration.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` (
    `mortality_table_id` BIGINT COMMENT 'Unique identifier for the mortality table record. Primary key for the mortality table reference catalog.',
    `base_mortality_table_id` BIGINT COMMENT 'Self-referencing FK on mortality_table (base_mortality_table_id)',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Mortality tables require regulatory approval documentation filed with state DOIs and actuarial standards bodies. The existing documentation_url is denormalized; a proper FK to document enables retriev',
    `experience_study_id` BIGINT COMMENT 'Foreign key reference to the experience study that provided the empirical data foundation for this mortality table. Applicable for company-specific or industry experience-based tables. Null for prescribed regulatory tables.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Mortality tables are approved for specific product types per state insurance department filings. Each product filing specifies approved mortality tables for pricing, reserving, and nonforfeiture value',
    `risk_class_id` BIGINT COMMENT 'Foreign key linking to underwriting.risk_class. Business justification: Mortality tables are constructed, approved, and applied for specific underwriting risk classes (e.g., preferred non-smoker, standard smoker). Direct FK from mortality_table to risk_class enables actua',
    `state_regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.state_regulation. Business justification: State regulations mandate permissible mortality tables (e.g., CSO 2017 required by state law). mortality_table has regulatory_basis as a text field but no FK to the specific state_regulation that mand',
    `underwriting_class_id` BIGINT COMMENT 'Foreign key linking to product.underwriting_class. Business justification: mortality_table.underwriting_class is a plain denormalized attribute. Mortality tables are constructed per underwriting class (preferred, standard, substandard). Actuarial table construction and PBR c',
    `approval_date` DATE COMMENT 'Date on which the mortality table was formally approved for use by the appointed actuary or governance committee. Null for externally prescribed tables that do not require internal approval.',
    `approved_by_actuary_name` STRING COMMENT 'Full name of the appointed actuary or qualified actuary who approved the mortality table for use in the company. Required for company-specific tables; may be null for externally prescribed tables.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the mortality table record was first created in the system. Represents the audit trail for data lineage and governance.',
    `credibility_factor` DECIMAL(18,2) COMMENT 'Statistical credibility weight (0.0000 to 1.0000) assigned to company-specific experience data when blending with industry standard tables. Higher values indicate greater reliance on company experience. Null for fully prescribed tables.',
    `data_source_reference` STRING COMMENT 'Reference to the underlying data source or experience study that informed the mortality table construction (e.g., SOA 2008 VBT Study, Company Experience 2015-2020, Industry Aggregate Data). Provides traceability to empirical foundation.',
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
    `version_number` STRING COMMENT 'Version identifier for the mortality table (e.g., 1.0, 2.1, 3.0.1). Used to track revisions and updates to company-specific or custom tables. Null for static regulatory tables.. Valid values are `^[0-9]{1,3}(.[0-9]{1,3}){0,2}$`',
    CONSTRAINT pk_mortality_table PRIMARY KEY(`mortality_table_id`)
) COMMENT 'Reference catalog of mortality tables used in actuarial valuations, pricing, and underwriting — CSO 2001, CSO 2017, VBT 2015, select and ultimate tables, smoker/non-smoker variants, and company-specific experience tables. Captures table name, table type (valuation/pricing/underwriting), gender basis, smoking class, select period, ultimate age, regulatory basis (NAIC-prescribed vs company), effective date, and superseded-by reference.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`actuarial`.`scenario_set` (
    `scenario_set_id` BIGINT COMMENT 'Primary key for scenario_set',
    `base_scenario_set_id` BIGINT COMMENT 'Self-referencing FK on scenario_set (base_scenario_set_id)',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: ORSA and VM-20 regulatory submissions require formal ESG documentation for each scenario set. The existing documentation_reference is a denormalized text field; a proper FK to document enables retriev',
    `approval_date` DATE COMMENT 'Date on which the scenario set was formally approved for use by the appropriate governance authority.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or committee who approved this scenario set for production use.',
    `calibration_date` DATE COMMENT 'Date as of which the scenario set was calibrated to market conditions and economic data.',
    `confidence_level` DECIMAL(18,2) COMMENT 'Statistical confidence level for scenario set results, expressed as a decimal (e.g., 0.9500 for 95% confidence). Used in CTE (Conditional Tail Expectation) calculations.',
    `created_by_user` STRING COMMENT 'User identifier or name of the individual who created this scenario set record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this scenario set record was first created in the system.',
    `credit_spread_model` STRING COMMENT 'Name of the credit spread model used for corporate bond scenarios in the set.',
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
    `scenario_set_status` STRING COMMENT 'Current lifecycle status of the scenario set: draft (under development), approved (validated but not yet active), active (in production use), archived (historical reference), deprecated (no longer recommended), or under review (validation in progress).',
    `scenario_type` STRING COMMENT 'Classification of the scenario set by modeling approach: deterministic (single outcome), stochastic (probabilistic), stress test, sensitivity analysis, baseline, or adverse.',
    `seed_value` BIGINT COMMENT 'Random number generator seed value used to produce stochastic scenarios, enabling reproducibility of results.',
    `stochastic_trial_count` STRING COMMENT 'Number of stochastic trials or paths generated for stochastic scenario sets. Null for deterministic scenarios.',
    `tail_percentile` DECIMAL(18,2) COMMENT 'Percentile threshold for tail risk analysis (e.g., 0.9000 for 90th percentile), used in CTE and stress testing.',
    `time_step_frequency` STRING COMMENT 'Frequency of time steps within scenario projections: monthly, quarterly, annual, or daily intervals.',
    `validation_date` DATE COMMENT 'Date on which the most recent independent validation of this scenario set was completed.',
    `validation_status` STRING COMMENT 'Current status of independent model validation for this scenario set.',
    `valuation_date` DATE COMMENT 'Effective date for which this scenario set is intended to be used in actuarial valuations or projections.',
    `volatility_assumption` DECIMAL(18,2) COMMENT 'Base volatility assumption used in stochastic modeling, expressed as a decimal (e.g., 0.1500 for 15% volatility).',
    CONSTRAINT pk_scenario_set PRIMARY KEY(`scenario_set_id`)
) COMMENT 'Master reference table for scenario_set. Referenced by scenario_set_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_pbr_model_segment_id` FOREIGN KEY (`pbr_model_segment_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pbr_model_segment`(`pbr_model_segment_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_scenario_set_id` FOREIGN KEY (`scenario_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`scenario_set`(`scenario_set_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ADD CONSTRAINT `fk_actuarial_reserve_calculation_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ADD CONSTRAINT `fk_actuarial_valuation_run_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ADD CONSTRAINT `fk_actuarial_valuation_run_scenario_set_id` FOREIGN KEY (`scenario_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`scenario_set`(`scenario_set_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ADD CONSTRAINT `fk_actuarial_assumption_set_experience_study_id` FOREIGN KEY (`experience_study_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`experience_study`(`experience_study_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ADD CONSTRAINT `fk_actuarial_assumption_set_parent_assumption_set_id` FOREIGN KEY (`parent_assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ADD CONSTRAINT `fk_actuarial_cash_flow_projection_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ADD CONSTRAINT `fk_actuarial_cash_flow_projection_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ADD CONSTRAINT `fk_actuarial_cash_flow_projection_stochastic_scenario_id` FOREIGN KEY (`stochastic_scenario_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`stochastic_scenario`(`stochastic_scenario_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ADD CONSTRAINT `fk_actuarial_cash_flow_projection_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ADD CONSTRAINT `fk_actuarial_experience_study_result_assumption_detail_id` FOREIGN KEY (`assumption_detail_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_detail`(`assumption_detail_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ADD CONSTRAINT `fk_actuarial_experience_study_result_experience_study_id` FOREIGN KEY (`experience_study_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`experience_study`(`experience_study_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ADD CONSTRAINT `fk_actuarial_pbr_model_segment_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ADD CONSTRAINT `fk_actuarial_pbr_model_segment_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ADD CONSTRAINT `fk_actuarial_pbr_model_segment_scenario_set_id` FOREIGN KEY (`scenario_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`scenario_set`(`scenario_set_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ADD CONSTRAINT `fk_actuarial_stochastic_scenario_scenario_set_id` FOREIGN KEY (`scenario_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`scenario_set`(`scenario_set_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ADD CONSTRAINT `fk_actuarial_reserve_snapshot_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ADD CONSTRAINT `fk_actuarial_reserve_snapshot_cohort_definition_id` FOREIGN KEY (`cohort_definition_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`cohort_definition`(`cohort_definition_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ADD CONSTRAINT `fk_actuarial_reserve_snapshot_pbr_model_segment_id` FOREIGN KEY (`pbr_model_segment_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`pbr_model_segment`(`pbr_model_segment_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ADD CONSTRAINT `fk_actuarial_reserve_snapshot_scenario_set_id` FOREIGN KEY (`scenario_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`scenario_set`(`scenario_set_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ADD CONSTRAINT `fk_actuarial_reserve_snapshot_valuation_run_id` FOREIGN KEY (`valuation_run_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`valuation_run`(`valuation_run_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ADD CONSTRAINT `fk_actuarial_pricing_basis_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ADD CONSTRAINT `fk_actuarial_pricing_basis_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ADD CONSTRAINT `fk_actuarial_cohort_definition_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ADD CONSTRAINT `fk_actuarial_assumption_detail_assumption_set_id` FOREIGN KEY (`assumption_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_set`(`assumption_set_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ADD CONSTRAINT `fk_actuarial_assumption_detail_mortality_table_id` FOREIGN KEY (`mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ADD CONSTRAINT `fk_actuarial_assumption_detail_prior_assumption_detail_id` FOREIGN KEY (`prior_assumption_detail_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`assumption_detail`(`assumption_detail_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ADD CONSTRAINT `fk_actuarial_mortality_table_base_mortality_table_id` FOREIGN KEY (`base_mortality_table_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`mortality_table`(`mortality_table_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ADD CONSTRAINT `fk_actuarial_mortality_table_experience_study_id` FOREIGN KEY (`experience_study_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`experience_study`(`experience_study_id`);
ALTER TABLE `life_insurance_ecm`.`actuarial`.`scenario_set` ADD CONSTRAINT `fk_actuarial_scenario_set_base_scenario_set_id` FOREIGN KEY (`base_scenario_set_id`) REFERENCES `life_insurance_ecm`.`actuarial`.`scenario_set`(`scenario_set_id`);

-- ========= TAGS =========
ALTER SCHEMA `life_insurance_ecm`.`actuarial` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `life_insurance_ecm`.`actuarial` SET TAGS ('dbx_domain' = 'actuarial');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` SET TAGS ('dbx_subdomain' = 'reserve_valuation');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `reserve_calculation_id` SET TAGS ('dbx_business_glossary_term' = 'Reserve Calculation Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `annuitant_id` SET TAGS ('dbx_business_glossary_term' = 'Annuitant Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `assumption_set_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `insured_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `mortality_table_id` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `pbr_model_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Principle-Based Reserving (PBR) Model Segment Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `premium_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Schedule Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `scenario_set_id` SET TAGS ('dbx_business_glossary_term' = 'Scenario Set Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_calculation` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run Identifier (ID)');
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
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` SET TAGS ('dbx_subdomain' = 'reserve_valuation');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Opinion Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `assumption_set_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`valuation_run` ALTER COLUMN `scenario_set_id` SET TAGS ('dbx_business_glossary_term' = 'Scenario Set Id (Foreign Key)');
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
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` SET TAGS ('dbx_subdomain' = 'actuarial_assumptions');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `assumption_set_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `experience_study_id` SET TAGS ('dbx_business_glossary_term' = 'Experience Study Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `parent_assumption_set_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Assumption Set Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Approval Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `assumption_basis` SET TAGS ('dbx_business_glossary_term' = 'Assumption Basis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `assumption_basis` SET TAGS ('dbx_value_regex' = 'best_estimate|prudent_estimate|prescribed|pricing|experience_adjusted|regulatory_minimum');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `assumption_set_description` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Description');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `assumption_set_status` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `assumption_set_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|superseded|archived');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `credibility_factor` SET TAGS ('dbx_business_glossary_term' = 'Credibility Factor');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_set` ALTER COLUMN `data_source_reference` SET TAGS ('dbx_business_glossary_term' = 'Data Source Reference');
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
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` SET TAGS ('dbx_subdomain' = 'reserve_valuation');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `cash_flow_projection_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Projection ID');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `annuitant_id` SET TAGS ('dbx_business_glossary_term' = 'Annuitant Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `assumption_set_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `cession_id` SET TAGS ('dbx_business_glossary_term' = 'Cession Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `crediting_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Crediting Strategy Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `insured_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `premium_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Schedule Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `separate_account_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Fund Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `separate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `stochastic_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Scenario ID');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cash_flow_projection` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run ID');
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
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `benefit_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Structure Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Study Report Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study` ALTER COLUMN `underwriting_class_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Id (Foreign Key)');
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
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `assumption_detail_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Detail Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `benefit_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Structure Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `experience_study_id` SET TAGS ('dbx_business_glossary_term' = 'Experience Study Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `risk_class_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Class Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `underwriting_class_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Id (Foreign Key)');
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
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`experience_study_result` ALTER COLUMN `variance` SET TAGS ('dbx_business_glossary_term' = 'Variance');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` SET TAGS ('dbx_subdomain' = 'reserve_valuation');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `pbr_model_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Principle-Based Reserving (PBR) Model Segment Identifier');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `assumption_set_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Pbr Model Segment Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `mortality_table_id` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `risk_class_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Class Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `scenario_set_id` SET TAGS ('dbx_business_glossary_term' = 'Scenario Set Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `state_regulation_id` SET TAGS ('dbx_business_glossary_term' = 'State Regulation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `treaty_id` SET TAGS ('dbx_business_glossary_term' = 'Treaty Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `underwriting_class_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Id (Foreign Key)');
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
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `valuation_system` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Valuation System');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pbr_model_segment` ALTER COLUMN `valuation_system` SET TAGS ('dbx_value_regex' = 'prophet|axis|moses|other');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` SET TAGS ('dbx_subdomain' = 'reserve_valuation');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `stochastic_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stochastic Scenario Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`stochastic_scenario` ALTER COLUMN `scenario_set_id` SET TAGS ('dbx_business_glossary_term' = 'Scenario Set Identifier (ID)');
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
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` SET TAGS ('dbx_subdomain' = 'reserve_valuation');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `reserve_snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'Reserve Snapshot Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `annuitant_id` SET TAGS ('dbx_business_glossary_term' = 'Annuitant Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `assumption_set_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `cession_id` SET TAGS ('dbx_business_glossary_term' = 'Cession Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `insured_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `pbr_model_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pbr Model Segment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`reserve_snapshot` ALTER COLUMN `scenario_set_id` SET TAGS ('dbx_business_glossary_term' = 'Scenario Set Id (Foreign Key)');
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
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` SET TAGS ('dbx_subdomain' = 'actuarial_assumptions');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `pricing_basis_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `assumption_set_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `benefit_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Structure Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `coi_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Coi Rate Schedule Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `crediting_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Crediting Strategy Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `irc7702_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Irc7702 Parameter Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `mortality_table_id` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `policy_form_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Form Approval Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `premium_rate_table_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Rate Table Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `rate_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Filing Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `risk_class_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Class Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `underwriting_class_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Id (Foreign Key)');
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
ALTER TABLE `life_insurance_ecm`.`actuarial`.`pricing_basis` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` SET TAGS ('dbx_subdomain' = 'reserve_valuation');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Definition Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `assumption_set_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `benefit_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Structure Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `risk_class_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Class Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `underwriting_class_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Id (Foreign Key)');
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
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`cohort_definition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` SET TAGS ('dbx_subdomain' = 'actuarial_assumptions');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `assumption_detail_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Detail Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `assumption_set_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `mortality_table_id` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `prior_assumption_detail_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `risk_class_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Class Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `underwriting_class_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Id (Foreign Key)');
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
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `policy_duration` SET TAGS ('dbx_business_glossary_term' = 'Policy Duration');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `product_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Product Segment Code');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit of Measure');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `rate_unit` SET TAGS ('dbx_value_regex' = 'percentage|decimal|currency|per_thousand|per_policy|per_unit');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `rate_value` SET TAGS ('dbx_business_glossary_term' = 'Rate Value');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_value_regex' = 'GAAP|SAP|IFRS17|PBR|VM20|tax');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `smoker_status` SET TAGS ('dbx_business_glossary_term' = 'Smoker Status');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `smoker_status` SET TAGS ('dbx_value_regex' = 'smoker|non_smoker|preferred|standard|unisex');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`assumption_detail` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` SET TAGS ('dbx_subdomain' = 'actuarial_assumptions');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `mortality_table_id` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `base_mortality_table_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `experience_study_id` SET TAGS ('dbx_business_glossary_term' = 'Experience Study Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `risk_class_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Class Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `state_regulation_id` SET TAGS ('dbx_business_glossary_term' = 'State Regulation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `underwriting_class_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `approved_by_actuary_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Actuary Name');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `credibility_factor` SET TAGS ('dbx_business_glossary_term' = 'Credibility Factor');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `data_source_reference` SET TAGS ('dbx_business_glossary_term' = 'Data Source Reference');
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
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`mortality_table` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}(.[0-9]{1,3}){0,2}$');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`scenario_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`scenario_set` SET TAGS ('dbx_subdomain' = 'actuarial_assumptions');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`scenario_set` ALTER COLUMN `scenario_set_id` SET TAGS ('dbx_business_glossary_term' = 'Scenario Set Identifier');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`scenario_set` ALTER COLUMN `base_scenario_set_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`scenario_set` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Scenario Set Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`scenario_set` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`scenario_set` ALTER COLUMN `created_by_user` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`actuarial`.`scenario_set` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_confidential' = 'true');
