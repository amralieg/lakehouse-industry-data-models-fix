-- Schema for Domain: risk | Business: Banking | Version: v1_ecm
-- Generated on: 2026-05-02 22:53:29

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`risk` COMMENT 'Enterprise-wide risk measurement and management covering market risk (VaR, CVA), credit risk (RWA, ECL), operational risk (SMA), and liquidity risk (LCR, NSFR). Supports CCAR, DFAST stress testing, RAROC, KRI monitoring, IRB models, PD/LGD/EAD aggregation, and risk appetite framework. Primary system of record aligned with SAS Risk Management / Moodys RiskAuthority.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`risk`.`factor` (
    `factor_id` BIGINT COMMENT 'Unique surrogate identifier for each risk factor record in the enterprise risk factor master registry. Serves as the primary key for all downstream model linkages and risk calculations.',
    `currency_id` BIGINT COMMENT 'ISO 4217 three-letter currency code associated with the risk factor (e.g., USD, EUR, GBP). For FX risk factors, this is the base currency. For interest rate factors, this is the currency of the underlying rate curve. Null for non-currency-denominated factors such as equity indices.',
    `irb_model_id` BIGINT COMMENT 'Reference to the quantitative risk model in the model inventory that primarily uses or defines this risk factor. Links the factor to its governing model for SR 11-7 model risk management, validation tracking, and regulatory approval workflows.',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Risk factors are shocked under stress scenarios. The risk_factor table has stress_period_start_date, stress_period_end_date, ccar_scenario_flag — these link to stress_scenario definitions. N:1 relatio',
    `asset_class` STRING COMMENT 'Broad asset class to which the risk factor belongs under the FRTB framework. Determines the applicable sensitivity-based method (SBM) bucket, risk weight, and correlation parameters for regulatory capital computation.. Valid values are `rates|fx|equity|commodity|credit`',
    `calibration_method` STRING COMMENT 'Statistical methodology used to calibrate the risk factors shock distribution and volatility parameters for VaR, stressed VaR, and ECL models. Governs model validation requirements and regulatory approval under IRB and IMA frameworks.. Valid values are `historical_simulation|monte_carlo|parametric|bootstrap|stress_calibration`',
    `ccar_scenario_flag` BOOLEAN COMMENT 'Indicates whether this risk factor is included in the Federal Reserves CCAR/DFAST stress testing scenario framework. True for factors that are shocked in supervisory adverse and severely adverse scenarios. Governs inclusion in stress testing data submissions to the Federal Reserve.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk factor record was first created in the enterprise risk factor registry. Provides the audit trail entry point for data lineage and regulatory examination purposes. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `credit_quality` STRING COMMENT 'Credit quality classification of the reference entity or issuer underlying a credit spread risk factor. Determines the applicable FRTB risk weight and correlation parameters. investment_grade corresponds to IG-rated issuers (BBB- and above); sub_investment_grade to HY/NR issuers.. Valid values are `investment_grade|sub_investment_grade|unrated|sovereign`',
    `effective_date` DATE COMMENT 'Date from which this risk factor definition became effective and was approved for use in production risk models. Marks the start of the factors active lifecycle in the enterprise model inventory.',
    `expiry_date` DATE COMMENT 'Date on which this risk factor definition expires or is scheduled for retirement from production models. Null for open-ended factors with no planned expiry. Used for model lifecycle management and proactive replacement planning (e.g., LIBOR cessation dates).',
    `factor_code` STRING COMMENT 'Externally-known, human-readable unique code identifying the risk factor across systems (e.g., IR_USD_SOFR_3M, FX_EURUSD, EQ_SPX). Used as the canonical business identifier in model configurations, regulatory submissions, and cross-system references.. Valid values are `^[A-Z0-9_-]{3,50}$`',
    `factor_description` STRING COMMENT 'Free-text narrative description of the risk factor, including its economic interpretation, model usage context, known limitations, and any special handling instructions. Supports model documentation requirements under SR 11-7 and provides context for risk analysts and model validators.',
    `factor_name` STRING COMMENT 'Full descriptive name of the risk factor as used in business communications, model documentation, and regulatory reports (e.g., USD SOFR 3-Month Swap Rate, EUR/USD Spot FX Rate, S&P 500 Equity Index).',
    `factor_status` STRING COMMENT 'Current lifecycle status of the risk factor in the enterprise model inventory. active factors are used in live production models; deprecated factors are retained for historical audit; under_review factors are undergoing model validation or regulatory review.. Valid values are `active|inactive|deprecated|under_review|pending_approval`',
    `factor_type` STRING COMMENT 'Primary classification of the risk factor by its economic nature. Drives model selection, regulatory capital treatment, and VaR/CVA calculation methodology. [ENUM-REF-CANDIDATE: interest_rate|fx_rate|equity|commodity|credit_spread|volatility|inflation|real_estate|pd|lgd|ead — promote to reference product]. Valid values are `interest_rate|fx_rate|equity|commodity|credit_spread|volatility`',
    `frtb_bucket` STRING COMMENT 'FRTB Sensitivity-Based Method (SBM) bucket assignment for this risk factor as defined in BCBS FRTB Article 325. Determines the applicable risk weight and intra-bucket/inter-bucket correlation parameters for regulatory capital computation (e.g., GIRR_Bucket_1, CSR_non_sec_Bucket_3, EQ_Bucket_7).',
    `geography` STRING COMMENT 'ISO 3166-1 alpha-3 country or region code indicating the geographic jurisdiction of the risk factor (e.g., USA for US rates, GBR for UK gilts, EMU for Eurozone). Used for geographic concentration analysis, country risk reporting, and regulatory capital bucketing.. Valid values are `^[A-Z]{3}$`',
    `holding_period_days` STRING COMMENT 'Regulatory or internal holding period in calendar days used for VaR and Expected Shortfall (ES) calculations for this risk factor (e.g., 10 days for market risk under Basel, 1 day for internal daily VaR). Determines the time horizon over which potential losses are measured.',
    `ifrs9_ecl_flag` BOOLEAN COMMENT 'Indicates whether this risk factor is used as a macroeconomic variable or credit parameter in IFRS 9 Expected Credit Loss (ECL) models. True for factors such as GDP growth, unemployment rate, PD term structures, and LGD curves used in forward-looking ECL projections.',
    `is_proxy_factor` BOOLEAN COMMENT 'Indicates whether this risk factor is used as a proxy for another illiquid or unobservable factor. True when the factor substitutes for a non-modellable risk factor (NMRF) in model calculations. Proxy relationships require additional model validation documentation under SR 11-7.',
    `last_observation_date` DATE COMMENT 'Most recent date on which a real market price observation was recorded for this risk factor. Used in RFET assessment to verify that the factor has sufficient recent observations to qualify as modellable under FRTB IMA. Critical for daily data quality monitoring.',
    `last_validation_date` DATE COMMENT 'Date of the most recent independent model validation review for this risk factors calibration and methodology. Required under SR 11-7 to ensure ongoing model fitness. Triggers re-validation workflow when the elapsed period exceeds the validation frequency threshold.',
    `liquidity_horizon_days` STRING COMMENT 'FRTB-prescribed liquidity horizon in days assigned to this risk factor, reflecting the time required to exit or hedge the risk position in stressed market conditions (e.g., 10, 20, 40, 60, or 120 days per FRTB asset class). Used in ES scaling for IMA capital calculations.',
    `market_data_source` STRING COMMENT 'Name of the primary market data vendor or internal source from which this risk factors time series is sourced (e.g., Bloomberg, Refinitiv, ICE Data Services, Federal Reserve H.15, Internal Pricing Model). Governs data lineage and RFEТ (Risk Factor Eligibility Test) compliance under FRTB IMA.',
    `market_data_ticker` STRING COMMENT 'Vendor-specific ticker or field identifier used to retrieve this risk factors market data from the designated source system (e.g., Bloomberg ticker USGG10YR Index, Refinitiv RIC .SPX). Enables automated data feed mapping and reconciliation.',
    `next_validation_date` DATE COMMENT 'Scheduled date for the next independent model validation review of this risk factor. Computed based on the validation frequency policy (e.g., annual for Tier 1 models, biennial for Tier 2). Drives the model validation calendar and resource planning.',
    `observation_window_days` STRING COMMENT 'Length of the historical data observation window in calendar days used for calibrating this risk factors shock distribution (e.g., 250 days for 1-year VaR, 1260 days for 5-year stressed VaR). Governs the backtesting and RFET assessment period.',
    `proxy_factor_code` STRING COMMENT 'Factor code of the observable proxy risk factor used when is_proxy_factor is True. Documents the substitution relationship for model validation, audit, and NMRF capital add-on calculations. Null when the factor is directly observable.. Valid values are `^[A-Z0-9_-]{3,50}$`',
    `regulatory_classification` STRING COMMENT 'FRTB IMA classification of the risk factor as modellable (RFET passed — sufficient real price observations) or non_modellable (NMRF — requires stressed scenario capital add-on). Directly impacts IMA capital calculation and must be reported to regulators. not_applicable for SA-only factors.. Valid values are `modellable|non_modellable|not_applicable`',
    `rfet_observation_count` STRING COMMENT 'Number of real price observations recorded for this risk factor over the RFET assessment period (typically 12 months). A minimum of 24 observations (or 100 for the alternative test) is required for the factor to be classified as modellable under FRTB IMA. Populated by the market data quality process.',
    `risk_class` STRING COMMENT 'Enterprise risk classification indicating which risk management pillar this factor belongs to: market risk (VaR, CVA), credit risk (PD/LGD/EAD, ECL, RWA), operational risk (SMA), or liquidity risk (LCR, NSFR). Governs routing to the appropriate risk engine and regulatory reporting stream.. Valid values are `market_risk|credit_risk|operational_risk|liquidity_risk`',
    `sector` STRING COMMENT 'Industry sector classification of the risk factors underlying issuer or reference entity (e.g., financials, energy, technology, sovereign, covered_bond). Applies primarily to credit spread and equity risk factors. Aligns with FRTB SBM sector buckets for correlation and risk weight assignment. [ENUM-REF-CANDIDATE: financials|energy|technology|sovereign|covered_bond|consumer_discretionary|industrials|utilities|real_estate|materials — promote to reference product]',
    `shock_type` STRING COMMENT 'Convention used to express risk factor shocks in sensitivity and scenario analyses: absolute (additive shift in units), relative (percentage change), log_return (log-normal return), or basis_point (1bp = 0.0001 shift for rates). Determines how sensitivities (delta, vega) are computed and reported.. Valid values are `absolute|relative|log_return|basis_point`',
    `stress_period_end_date` DATE COMMENT 'End date of the identified historical stress period used for stressed VaR and FRTB stressed ES calibration. Together with stress_period_start_date, defines the calibration window that produces the most adverse 12-month stressed scenario for this risk factor.',
    `stress_period_start_date` DATE COMMENT 'Start date of the identified historical stress period used for stressed VaR (sVaR) and FRTB stressed ES calibration for this risk factor. Must correspond to a period of significant financial stress relevant to the factors asset class (e.g., 2008-09-01 for the Global Financial Crisis).',
    `sub_risk_class` STRING COMMENT 'Granular sub-classification within the primary risk class (e.g., general_interest_rate_risk, specific_risk, counterparty_credit_risk, settlement_risk, concentration_risk). Used for detailed regulatory reporting and internal risk appetite segmentation. [ENUM-REF-CANDIDATE: general_interest_rate_risk|specific_risk|counterparty_credit_risk|settlement_risk|concentration_risk|basis_risk|vega_risk|curvature_risk — promote to reference product]',
    `tenor` STRING COMMENT 'Maturity or tenor of the risk factor along the yield curve or term structure (e.g., 3M, 1Y, 10Y). Applicable to interest rate, credit spread, and volatility surface factors. Null for spot FX rates and equity spot factors. Aligns with FRTB prescribed tenor vertices for delta sensitivity calculations.. Valid values are `^(ON|1W|2W|1M|2M|3M|6M|9M|1Y|2Y|3Y|5Y|7Y|10Y|15Y|20Y|30Y)$`',
    `tenor_days` STRING COMMENT 'Numeric representation of the risk factor tenor expressed in calendar days (e.g., 90 for 3M, 365 for 1Y). Enables precise interpolation between tenor vertices in risk model calculations and facilitates sorting and bucketing of term structure factors.',
    `time_series_code` BIGINT COMMENT 'Reference to the historical time series record in the market data repository that stores the daily observations for this risk factor. Enables direct linkage from the factor definition to its underlying data for backtesting, calibration, and RFET assessment.',
    `underlying_index` STRING COMMENT 'Name of the underlying benchmark index or reference rate for the risk factor (e.g., SOFR, EURIBOR, LIBOR, OIS, S&P 500, WTI Crude). Critical for IBOR transition tracking (LIBOR to SOFR/EURIBOR migration) and model calibration documentation.',
    `unit_of_measure` STRING COMMENT 'Unit in which the risk factor value is expressed (e.g., percent, basis_points, USD_per_barrel, index_points, USD_per_troy_oz). Essential for correct interpretation of factor values, shock magnitudes, and sensitivity calculations across heterogeneous risk factor types.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this risk factor record. Tracks changes to factor definitions, calibration parameters, or regulatory classifications. Essential for change management audit trails and regulatory examination readiness.',
    `var_confidence_level` DECIMAL(18,2) COMMENT 'Statistical confidence level used when computing Value at Risk (VaR) for this risk factor (e.g., 0.9900 for 99%, 0.9750 for 97.5% ES under FRTB). Stored as a decimal fraction. Governs the tail risk threshold for internal risk limits and regulatory capital calculations.',
    `var_contribution_pct` DECIMAL(18,2) COMMENT 'Percentage contribution of this risk factor to the total portfolio VaR as of the last calculation date. Expressed as a decimal (e.g., 0.0523 = 5.23%). Used for risk attribution reporting, limit monitoring, and identification of dominant risk drivers in the trading book.',
    CONSTRAINT pk_factor PRIMARY KEY(`factor_id`)
) COMMENT 'Master registry of all enterprise risk factors used in quantitative risk models. Captures market risk drivers (interest rate curves, FX rates, equity indices, commodity prices, credit spreads), credit risk parameters (PD, LGD, EAD), and operational risk indicators. Each factor has a unique identifier, factor type, asset class, tenor/maturity, data source, calibration methodology, historical time series reference, and regulatory classification under Basel III/FRTB. Serves as the canonical SSOT for risk factor definitions and model linkage.';

CREATE OR REPLACE TABLE `banking_ecm`.`risk`.`appetite` (
    `appetite_id` BIGINT COMMENT 'Unique surrogate identifier for each risk appetite statement or threshold record within the enterprise risk appetite framework.',
    `superseded_by_appetite_id` BIGINT COMMENT 'Reference to the risk_appetite_id of the newer version that supersedes this record when approval_status is superseded. Enables forward-chaining of the version history for audit and regulatory review purposes.',
    `appetite_level` STRING COMMENT 'Qualitative board-approved appetite level indicating the degree of risk the institution is willing to accept in pursuit of its strategic objectives. Ranges from low (minimal risk tolerance) to high (aggressive risk-taking within regulatory bounds).. Valid values are `low|moderate|elevated|high`',
    `approval_date` DATE COMMENT 'Date on which the governing body formally approved this risk appetite statement. Critical for audit trail, SOX compliance, and regulatory examination documentation.',
    `approval_status` STRING COMMENT 'Current lifecycle status of the risk appetite statement within the governance approval workflow. Tracks progression from initial drafting through board approval to eventual supersession or retirement.. Valid values are `draft|pending_approval|approved|superseded|retired`',
    `breach_escalation_level` STRING COMMENT 'Defines the escalation tier that must be notified upon breach of this appetite threshold. Establishes the governance response chain from management-level notification through CRO to Board Risk Committee escalation.. Valid values are `management|senior_management|cro|board_risk_committee|board`',
    `breach_response_timeframe_days` STRING COMMENT 'Maximum number of calendar days within which a formal remediation plan must be submitted to the designated escalation body following a breach of this appetite threshold.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk appetite record was first created in the data platform. Supports audit trail requirements under SOX, BCBS 239 data lineage standards, and regulatory examination documentation.',
    `direction` STRING COMMENT 'Indicates whether the appetite threshold represents a minimum floor (e.g., CET1 ratio must be at least X%), a maximum ceiling (e.g., NPL ratio must not exceed Y%), a target value, or a permissible range.. Valid values are `minimum|maximum|target|range`',
    `effective_date` DATE COMMENT 'Date from which this risk appetite statement becomes binding and operative across the institution. Aligns with the board approval cycle, typically annual or triggered by material risk profile changes.',
    `expiry_date` DATE COMMENT 'Date on which this risk appetite statement ceases to be operative and must be reviewed, renewed, or superseded. Null for open-ended statements that remain in force until explicitly retired.',
    `governance_body` STRING COMMENT 'The governing body that approved this risk appetite statement (e.g., Board of Directors, Board Risk Committee, ALCO, Executive Risk Committee). Establishes the authority level and escalation chain for breach management. [ENUM-REF-CANDIDATE: board|board_risk_committee|alco|executive_risk_committee|credit_committee|audit_committee|cro_office — promote to reference product]. Valid values are `board|board_risk_committee|alco|executive_risk_committee|credit_committee|audit_committee`',
    `is_board_approved` BOOLEAN COMMENT 'Indicates whether this risk appetite statement has received formal Board of Directors or Board Risk Committee approval (True) or is still in draft/management-approved status (False). Required for regulatory examination and SOX attestation.',
    `is_quantitative` BOOLEAN COMMENT 'Indicates whether this risk appetite statement is expressed as a quantitative metric with a numeric threshold (True) or as a qualitative statement without a numeric bound (False). Qualitative statements include zero-tolerance policies for regulatory violations or reputational risk.',
    `is_regulatory_minimum` BOOLEAN COMMENT 'Indicates whether this appetite threshold is set at or derived from a regulatory minimum requirement (True) or represents an internally-set management buffer above the regulatory floor (False). Critical for distinguishing regulatory compliance floors from internal risk management buffers.',
    `kri_code` STRING COMMENT 'Reference code linking this risk appetite statement to the corresponding Key Risk Indicator (KRI) in the enterprise GRC system. Enables automated monitoring of appetite utilization against real-time KRI readings from SAS Risk Management / Moodys RiskAuthority.. Valid values are `^KRI-[A-Z]{2,10}-[0-9]{3}$`',
    `last_review_date` DATE COMMENT 'Date on which this risk appetite statement was most recently reviewed and reaffirmed or amended by the governing body. Provides audit evidence of ongoing governance oversight.',
    `legal_entity` STRING COMMENT 'Legal entity or subsidiary to which this risk appetite statement applies. Supports multi-entity banking groups where appetite thresholds may differ by regulated entity (e.g., bank holding company vs. broker-dealer subsidiary).',
    `limit_value` DECIMAL(18,2) COMMENT 'Hard operational limit assigned to a specific business line, desk, or portfolio that must not be exceeded. Derived from and subordinate to the enterprise-level appetite threshold. Used in daily risk limit monitoring within the Trading and Order Management System (Murex/Calypso).',
    `line_of_business` STRING COMMENT 'The specific Line of Business (LOB) to which this appetite statement applies (e.g., Commercial Lending, Investment Banking, Retail Banking, Securities Trading, Wealth Management). Null if the statement applies enterprise-wide.',
    `metric_definition` STRING COMMENT 'Formal definition of how the risk metric is calculated or assessed, including the numerator, denominator, observation period, and data sources. Ensures consistent measurement across business lines and regulatory submissions.',
    `metric_name` STRING COMMENT 'Name of the quantitative or qualitative metric used to measure risk against this appetite statement (e.g., CET1 Ratio, VaR 99% 10-day, LCR, NSFR, NPL Ratio, ECL Coverage Ratio).',
    `metric_unit` STRING COMMENT 'Unit in which the risk metric is expressed (e.g., percentage for CET1 ratio, currency_usd for VaR dollar amount, basis_points for credit spread limits, days for LCR horizon). [ENUM-REF-CANDIDATE: percentage|ratio|currency_usd|currency_local|basis_points|count|score|days — 8 candidates stripped; promote to reference product]',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of this risk appetite statement by the designated governance body. Derived from the last review date and review frequency; used to drive governance workflow alerts.',
    `qualitative_statement` STRING COMMENT 'Full text of the board-approved qualitative risk appetite statement for non-quantifiable risk types (e.g., The Bank has zero tolerance for breaches of AML/BSA regulations or The Bank will not engage in activities that materially damage its reputation). Populated when is_quantitative is False.',
    `range_lower_bound` DECIMAL(18,2) COMMENT 'Lower boundary of the acceptable risk range when direction is range. Applicable for metrics such as NIM targets or LCR operating ranges where both a floor and ceiling are defined.',
    `range_upper_bound` DECIMAL(18,2) COMMENT 'Upper boundary of the acceptable risk range when direction is range. Used alongside range_lower_bound to define the full operating corridor for metrics managed within a band.',
    `raroc_hurdle_rate` DECIMAL(18,2) COMMENT 'Minimum Risk-Adjusted Return on Capital (RAROC) threshold that business activities must meet to be consistent with this risk appetite statement. Used in capital allocation decisions and new product approval processes.',
    `regulatory_framework` STRING COMMENT 'Regulatory or supervisory framework that mandates or informs this risk appetite statement (e.g., Basel III CET1, CCAR, DFAST, LCR, NSFR, IFRS 9 ECL, CECL, FRTB). Links appetite management to regulatory compliance obligations.',
    `review_frequency` STRING COMMENT 'Mandated frequency at which this risk appetite statement must be formally reviewed and reaffirmed by the governing body. Drives the governance calendar for ALCO and Board Risk Committee scheduling.. Valid values are `monthly|quarterly|semi_annual|annual|ad_hoc`',
    `risk_category` STRING COMMENT 'Primary risk category to which this appetite statement applies. Aligns with the enterprise risk taxonomy: credit, market, liquidity, operational, reputational, or strategic. [ENUM-REF-CANDIDATE: credit|market|liquidity|operational|reputational|strategic|compliance|model|concentration — promote to reference product if taxonomy expands]. Valid values are `credit|market|liquidity|operational|reputational|strategic`',
    `risk_sub_category` STRING COMMENT 'Granular sub-classification within the primary risk category (e.g., Counterparty Credit Risk, Interest Rate Risk in the Banking Book (IRRBB), Intraday Liquidity Risk, Cyber Operational Risk). Supports drill-down analytics in CCAR and DFAST reporting.',
    `rwa_limit` DECIMAL(18,2) COMMENT 'Maximum Risk-Weighted Assets (RWA) allocated to the applicable business line or portfolio under this appetite statement. Expressed in the institutions reporting currency. Supports capital adequacy management under Basel III Standardized Approach (SA) and Internal Ratings-Based (IRB) Approach.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this risk appetite record originates or is maintained (e.g., SAS_RM for SAS Risk Management, MOODYS_RA for Moodys RiskAuthority, AXIOMSL for AxiomSL regulatory reporting platform, MANUAL for board-documented statements).. Valid values are `SAS_RM|MOODYS_RA|AXIOMSL|ONESUMX|MANUAL`',
    `statement_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the risk appetite statement, used in board documentation, ALCO packs, and regulatory submissions (e.g., RA-CREDIT-2024-001).. Valid values are `^RA-[A-Z]{2,10}-[0-9]{4}-[0-9]{3}$`',
    `statement_name` STRING COMMENT 'Human-readable name of the risk appetite statement as approved by the Board Risk Committee (e.g., Maximum Credit Risk Concentration — Single Obligor).',
    `stress_scenario_applicability` STRING COMMENT 'Indicates which stress testing scenario(s) this appetite threshold applies to: baseline (normal conditions), adverse (moderate stress), severely adverse (severe stress), or all scenarios. Directly maps to CCAR/DFAST scenario definitions.. Valid values are `baseline|adverse|severely_adverse|all_scenarios`',
    `threshold` DECIMAL(18,2) COMMENT 'Board-approved quantitative value representing the maximum level of risk the institution is willing to accept under normal operating conditions. For example, a CET1 ratio floor of 11.5% or a VaR limit of USD 50 million.',
    `tolerance_threshold` DECIMAL(18,2) COMMENT 'Maximum acceptable deviation from the risk appetite threshold before mandatory escalation is triggered. Represents the outer boundary of acceptable risk exposure (e.g., CET1 floor of 10.5% as the tolerance boundary below the 11.5% appetite).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this risk appetite record in the data platform. Used for change data capture, incremental ETL processing, and audit trail maintenance per BCBS 239 data governance standards.',
    `version_number` STRING COMMENT 'Sequential version number of this risk appetite statement, incremented each time the statement is formally amended and re-approved. Enables version history tracking and audit trail for regulatory examination.',
    `warning_threshold` DECIMAL(18,2) COMMENT 'Early-warning trigger level set between the appetite threshold and tolerance threshold. Breaching this level initiates management-level monitoring and pre-emptive action before the tolerance boundary is reached. Supports KRI monitoring frameworks.',
    CONSTRAINT pk_appetite PRIMARY KEY(`appetite_id`)
) COMMENT 'Enterprise risk appetite framework defining quantitative and qualitative thresholds, tolerances, and limits across all risk categories (credit, market, liquidity, operational). Captures board-approved risk appetite statements, metric definitions, breach escalation rules, and linkage to ALCO/CCAR governance. Serves as the authoritative source for enterprise-wide risk tolerance boundaries.';

CREATE OR REPLACE TABLE `banking_ecm`.`risk`.`risk_limit` (
    `risk_limit_id` BIGINT COMMENT 'Unique surrogate identifier for each risk limit record in the operational risk limit registry. Primary key for the risk_limit data product. Entity role: MASTER_AGREEMENT — represents a binding, approved exposure constraint with its own lifecycle, approval authority, and utilization tracking.',
    `alco_resolution_id` BIGINT COMMENT 'Foreign key linking to treasury.alco_resolution. Business justification: Risk limits are established, revised, or suspended via ALCO resolutions as part of governance framework. ALCO resolutions document approval authority for material risk limit changes, linking risk appe',
    `appetite_id` BIGINT COMMENT 'Foreign key linking to risk.risk_appetite. Business justification: Risk limits operationalize the risk appetite framework. The risk_limit table defines operational thresholds that enforce the strategic risk_appetite statements. N:1 relationship (many operational limi',
    `channel_id` BIGINT COMMENT 'Surrogate identifier of the specific entity (counterparty, portfolio, desk, LOB, geography, sector) to which this limit applies. Resolved against the appropriate master data domain based on scope_entity_type. Enables precise limit-to-entity linkage for utilization aggregation.',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Risk limits are set at account level for concentration monitoring and transaction limits. Treasury and ALCO teams track account-level exposure limits for liquidity risk management and regulatory compl',
    `irb_model_id` BIGINT COMMENT 'Surrogate identifier of the Internal Ratings-Based (IRB) model used to calculate PD/LGD/EAD inputs for credit risk limits. Links to the model registry in the risk management platform. Applicable only for credit risk limit types.',
    `netting_set_id` BIGINT COMMENT 'Foreign key linking to collateral.netting_set. Business justification: Counterparty credit limits set at netting set level for derivatives portfolios. Monitors net exposure post-collateral against approved limits. Essential for pre-trade credit checks and limit utilizati',
    `employee_id` BIGINT COMMENT 'Surrogate identifier of the business user (risk manager or desk head) who owns and is accountable for this risk limit. The limit owner is responsible for monitoring utilization and initiating breach remediation actions.',
    `primary_risk_employee_id` BIGINT COMMENT 'Surrogate identifier of the individual user who formally approved this risk limit in the risk management platform. Supports four-eyes principle validation and SOX audit trail requirements.',
    `amount` DECIMAL(18,2) COMMENT 'The approved maximum exposure threshold expressed as an absolute monetary or notional amount in the limit currency. Represents the binding constraint against which utilization is measured. For VaR limits this is the maximum permissible loss; for credit limits this is the maximum Exposure at Default (EAD).',
    `approval_authority` STRING COMMENT 'Name or title of the governance body or individual who approved this risk limit (e.g., ALCO, Board Risk Committee, CRO, Head of Market Risk). Required for governance audit trail and escalation chain documentation.',
    `approval_date` DATE COMMENT 'Date on which the risk limit was formally approved by the designated approval authority. Establishes the governance record for regulatory examination and internal audit purposes.',
    `breach_action_rule` STRING COMMENT 'Prescribed remediation action protocol to be executed upon a breach event (e.g., Immediate escalation to CRO and ALCO; position reduction within 24 hours; SAR filing if AML threshold exceeded). Codifies the breach governance framework for operational consistency.',
    `breach_count` STRING COMMENT 'Cumulative number of breach events recorded against this limit since its effective date. Used for trend analysis, KRI monitoring, and regulatory reporting on limit governance effectiveness.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk limit record was first created in the data platform. Supports audit trail, data lineage, and regulatory record-keeping requirements. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the limit amount is denominated (e.g., USD, EUR, GBP). Required for multi-currency limit consolidation and FX-adjusted utilization calculations.. Valid values are `^[A-Z]{3}$`',
    `current_utilization_amount` DECIMAL(18,2) COMMENT 'The most recently calculated utilization of the limit expressed in the limit currency. Represents the current exposure measured on the utilization_basis (e.g., current VaR, current EAD, current RWA). Updated by the risk management platform on the monitoring frequency cycle.',
    `desk_code` STRING COMMENT 'Identifier of the trading desk or business unit responsible for the positions subject to this limit. Aligns with desk hierarchy in Murex/Calypso trading and order management systems. Required for FRTB desk-level capital attribution.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `effective_date` DATE COMMENT 'Calendar date on which the risk limit becomes binding and active for utilization monitoring. Aligns with the approval date or the start of the applicable risk period (e.g., fiscal quarter, regulatory reporting period).',
    `escalation_level_1` STRING COMMENT 'Name or role title of the first-level escalation contact notified upon a limit warning or breach event (e.g., Head of Market Risk, Senior Credit Officer). Defines the escalation chain for breach governance.',
    `escalation_level_2` STRING COMMENT 'Name or role title of the second-level escalation contact notified if the breach is not remediated within the prescribed timeframe (e.g., Chief Risk Officer, Board Risk Committee Chair). Supports multi-tier breach governance.',
    `expiry_date` DATE COMMENT 'Calendar date on which the risk limit ceases to be binding. Null for open-ended standing limits. Limits approaching expiry trigger renewal workflows in the governance framework. Supports regulatory capital constraint management under Basel III/FRTB.',
    `geography_code` STRING COMMENT 'ISO 3166-1 alpha-3 country or region code identifying the geographic scope of the limit (e.g., USA, GBR, DEU). Used for country risk concentration limits and cross-border exposure management.. Valid values are `^[A-Z]{3}$`',
    `hard_stop_flag` BOOLEAN COMMENT 'Indicates whether the limit enforces a hard stop (True) that prevents new transactions from being booked once the limit is reached, or a soft limit (False) that triggers alerts and escalation but does not block transactions. Critical for real-time limit monitoring integration with trading and order management systems.',
    `last_breach_date` DATE COMMENT 'Date of the most recent breach event recorded against this limit. Null if no breach has occurred. Used for recency analysis in KRI dashboards and regulatory examination responses.',
    `limit_code` STRING COMMENT 'Externally-known, human-readable business identifier for the risk limit (e.g., CRED-CORP-001, MKT-VAR-DESK-FX-002). Used in regulatory submissions, audit trails, and cross-system references. Aligns with the limit reference code maintained in SAS Risk Management / Moodys RiskAuthority.. Valid values are `^[A-Z0-9_-]{4,30}$`',
    `limit_description` STRING COMMENT 'Free-text narrative describing the business rationale, scope, and any special conditions or exclusions applicable to this risk limit. Provides context for governance reviews, regulatory examinations, and audit inquiries.',
    `limit_name` STRING COMMENT 'Descriptive business name of the risk limit (e.g., FX Trading Desk Daily VaR Limit, Corporate Credit Concentration Limit — Technology Sector). Used in dashboards, governance reports, and ALCO presentations.',
    `limit_status` STRING COMMENT 'Current lifecycle state of the risk limit record. active indicates the limit is in force and being monitored; suspended indicates temporary hold pending review; breached indicates the limit is currently in excess; pending_approval indicates awaiting governance sign-off.. Valid values are `active|suspended|expired|pending_approval|cancelled|breached`',
    `limit_type` STRING COMMENT 'Classification of the risk limit by risk category. Drives applicable measurement methodology and regulatory capital treatment. [ENUM-REF-CANDIDATE: credit|market|liquidity|concentration|operational|counterparty|country|sector|settlement|intraday — promote to reference product]',
    `lob_code` STRING COMMENT 'Standardized code identifying the Line of Business (LOB) responsible for managing and consuming this risk limit (e.g., IB-EQUITIES, RETAIL-LENDING, CORP-CREDIT, TREASURY). Used for LOB-level risk appetite reporting and CCAR/DFAST segmentation.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `monitoring_frequency` STRING COMMENT 'Frequency at which utilization is recalculated and compared against the limit threshold (e.g., real_time for trading desk VaR limits, daily for credit concentration limits, monthly for LCR/NSFR limits). Drives the monitoring schedule in the risk management platform.. Valid values are `real_time|intraday|daily|weekly|monthly`',
    `regulatory_capital_flag` BOOLEAN COMMENT 'Indicates whether this limit is directly tied to a regulatory capital constraint (True) under Basel III/FRTB (e.g., RWA limit, CET1 buffer limit, LCR minimum). Flags limits that require regulatory reporting upon breach.',
    `review_frequency` STRING COMMENT 'Scheduled frequency at which the risk limit is formally reviewed and reaffirmed by the approving authority. Drives governance calendar and ALCO agenda scheduling.. Valid values are `daily|weekly|monthly|quarterly|annually|ad_hoc`',
    `scope_entity_name` STRING COMMENT 'Human-readable name of the entity to which this limit applies (e.g., counterparty legal name, desk name, LOB name, country name). Retained for reporting and audit purposes independent of master data joins.',
    `scope_entity_type` STRING COMMENT 'The type of business entity to which this limit applies. Determines the dimension of risk aggregation (e.g., counterparty for single-name credit limits, desk for trading desk VaR limits, lob for Line of Business concentration limits, geography for country risk limits). [ENUM-REF-CANDIDATE: counterparty|portfolio|desk|lob|geography|sector|instrument|legal_entity — 8 candidates stripped; promote to reference product]',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this limit record originates (e.g., SAS-RISK, MOODYS-RA, MUREX, AXIOMSL). Supports data lineage tracking and reconciliation in the Databricks Silver Layer.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `stress_test_limit_flag` BOOLEAN COMMENT 'Indicates whether this limit is a stress-scenario limit (True) applied under CCAR/DFAST stress testing frameworks, as opposed to a business-as-usual (BAU) limit. Stress limits typically have higher thresholds and different breach protocols.',
    `subtype` STRING COMMENT 'Further granular classification within the limit type (e.g., VaR, CVA, PV01, DV01, ECL, RWA, LCR, NSFR, Single-Name Concentration, Sector Concentration). Enables drill-down analytics and precise regulatory mapping.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk limit record was last modified in the data platform. Tracks limit amendments, utilization updates, and status changes. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `utilization_as_of_timestamp` TIMESTAMP COMMENT 'The precise date and time at which the current utilization amount was calculated or sourced from the risk management platform. Critical for intraday limit monitoring and audit trail integrity. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `utilization_basis` STRING COMMENT 'The measurement methodology used to calculate current utilization against the limit. Determines which risk metric is compared to the limit amount (e.g., var for Value at Risk limits, ead for Exposure at Default credit limits, rwa for Risk-Weighted Asset limits, lcr_outflow for liquidity limits). [ENUM-REF-CANDIDATE: notional|mtm|ead|var|rwa|ecl|nii_impact|lcr_outflow|cva|pv01|dv01 — promote to reference product]',
    `utilization_pct` DECIMAL(18,2) COMMENT 'Current utilization expressed as a percentage of the approved limit amount (current_utilization_amount / limit_amount × 100). Enables threshold-based alerting and trend analysis. Values above 100 indicate a breach condition.',
    `var_confidence_level` DECIMAL(18,2) COMMENT 'Statistical confidence level used in the VaR calculation for market risk limits (e.g., 99.00 for 99th percentile, 97.50 for 97.5th percentile as required under FRTB Expected Shortfall). Applicable only for market risk limit types with VaR/ES utilization basis.',
    `var_holding_period_days` STRING COMMENT 'The holding period in calendar days used in the VaR calculation for market risk limits (e.g., 1 for daily VaR, 10 for 10-day regulatory VaR under Basel III). Applicable only for market risk limit types.',
    `warning_threshold_pct` DECIMAL(18,2) COMMENT 'Percentage of the limit amount at which an early-warning alert is triggered (e.g., 80.00 for 80%). Enables proactive escalation before a formal breach occurs. Expressed as a percentage (0–100). Configured per limit in SAS Risk Management / Moodys RiskAuthority.',
    CONSTRAINT pk_risk_limit PRIMARY KEY(`risk_limit_id`)
) COMMENT 'Operational risk limit registry, utilization tracking, and breach management record. Captures approved exposure limits by risk type (credit, market, liquidity, concentration), counterparty, portfolio, desk, LOB, and geography. Includes limit amount, currency, effective/expiry dates, approval authority, utilization basis, and breach action rules. Records limit breach events including breach date/time, limit type, breached threshold, actual value, excess amount, severity classification, responsible desk/LOB, escalation chain, remediation actions, and resolution status. Supports real-time limit monitoring, breach governance, and regulatory capital constraint management under Basel III/FRTB.';

CREATE OR REPLACE TABLE `banking_ecm`.`risk`.`credit_exposure` (
    `credit_exposure_id` BIGINT COMMENT 'Unique surrogate identifier for each credit exposure measurement record in the silver layer lakehouse. Primary key for the credit_exposure data product.',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Credit exposures use counterparty ratings for RWA calculation. The credit_exposure table has internal_rating field which duplicates counterparty_rating.rating_code. N:1 relationship (many exposures us',
    `country_id` BIGINT COMMENT 'ISO 3166-1 alpha-3 country code of the counterpartys country of domicile or incorporation. Used for geographic concentration risk analysis and sovereign risk weighting under CRR2 Article 395.',
    `currency_id` BIGINT COMMENT 'ISO 4217 three-letter currency code of the exposures original denomination (e.g., USD, EUR, GBP). Used for FX translation to reporting currency and for FX concentration risk analysis.',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Credit exposure calculations include deposit account balances for ISDA netting agreements and collateral offset. Treasury operations use deposit accounts as collateral sources for derivatives exposure',
    `irb_model_id` BIGINT COMMENT 'Foreign key linking to risk.irb_model. Business justification: Credit exposure calculations use IRB model parameters for PD, LGD, EAD, and RWA computation. The credit_exposure table has pd, lgd, ead, and rwa_credit attributes that are derived from IRB model outpu',
    `netting_set_id` BIGINT COMMENT 'Reference to the ISDA/CSA netting set under which this exposure is netted for counterparty credit risk purposes. Drives netting benefit calculations for EAD and CVA.',
    `party_id` BIGINT COMMENT 'Reference to the obligor or counterparty entity whose credit exposure is being measured. Links to the customer or counterparty master record.',
    `repo_position_id` BIGINT COMMENT 'Foreign key linking to treasury.repo_position. Business justification: Credit exposure calculations incorporate repo positions for counterparty credit risk measurement and CVA calculation under Basel III SA-CCR. Repo positions are collateralized exposures requiring speci',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to risk.risk_limit. Business justification: Credit exposures are monitored against counterparty limits, country limits, and portfolio limits. The credit_exposure table has large_exposure_flag but no reference to the specific limit being monitor',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Credit exposures to sanctioned entities must be blocked or reported per OFAC regulations. Banks link exposures to sanctions screening events to track blocked transactions, regulatory holds, and exposu',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Credit exposures are stressed under CCAR/DFAST scenarios. The credit_exposure table has stress_scenario field (STRING) which should be replaced by FK to stress_scenario. N:1 relationship (many exposur',
    `collateral_value` DECIMAL(18,2) COMMENT 'Current market value of eligible financial collateral posted against this exposure after applicable haircuts under the Financial Collateral Comprehensive Method (FCCM). Reduces EAD and RWA.',
    `concentration_hhi` DECIMAL(18,2) COMMENT 'Herfindahl-Hirschman Index score measuring the degree of concentration of this exposure within its sector, geography, or single-name bucket. Used for concentration risk monitoring and regulatory large exposure limit compliance.',
    `counterparty_type` STRING COMMENT 'Classification of the counterparty for regulatory capital and large exposure reporting purposes. Determines applicable risk weight under SA and eligibility for IRB treatment. [ENUM-REF-CANDIDATE: corporate|financial_institution|sovereign|central_bank|retail|sme|fund — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit exposure record was first created in the data platform. Supports audit trail and data lineage requirements under SOX and Basel Pillar 3.',
    `current_exposure` DECIMAL(18,2) COMMENT 'Current mark-to-market (MTM) replacement cost of the exposure as of the measurement date, before netting and collateral. For derivatives, represents the positive MTM value. For loans, represents the outstanding principal balance.',
    `cva` DECIMAL(18,2) COMMENT 'Market value of counterparty credit risk embedded in OTC derivative positions, representing the expected loss due to counterparty default. Calculated under SA-CVA or BA-CVA regulatory framework. Impacts P&L and regulatory capital.',
    `cva_approach` STRING COMMENT 'Regulatory methodology used to calculate the CVA capital charge: Standardised Approach for CVA (SA-CVA), Basic Approach for CVA (BA-CVA), or exempted (for transactions with non-financial counterparties below threshold).. Valid values are `SA-CVA|BA-CVA|exempted`',
    `cva_capital_charge` DECIMAL(18,2) COMMENT 'Regulatory capital requirement for CVA risk calculated under SA-CVA or BA-CVA methodology as prescribed by BCBS CRE51. Represents the RWA equivalent for counterparty credit valuation adjustment risk.',
    `dva` DECIMAL(18,2) COMMENT 'Adjustment to derivative fair value reflecting the banks own credit risk, representing the benefit to the bank from its own potential default. Reported under IFRS 13 but excluded from regulatory CVA capital charge.',
    `ead` DECIMAL(18,2) COMMENT 'Estimated total exposure amount outstanding at the time of default, expressed in the reporting currency. Incorporates credit conversion factors (CCF) for off-balance-sheet items and SA-CCR replacement cost for derivatives. Core input to RWA and ECL calculation.',
    `ecl_provision` DECIMAL(18,2) COMMENT 'Calculated expected credit loss provision amount for this exposure under IFRS 9 or CECL, representing the probability-weighted estimate of credit losses over the applicable horizon (12-month or lifetime). Feeds the allowance for loan and lease losses (ALLL).',
    `ecl_stage` STRING COMMENT 'IFRS 9 impairment stage classification: Stage 1 (12-month ECL, no significant credit deterioration), Stage 2 (lifetime ECL, significant increase in credit risk), Stage 3 (lifetime ECL, credit-impaired/defaulted). Drives provisioning and income recognition.. Valid values are `stage_1|stage_2|stage_3`',
    `effective_maturity_years` DECIMAL(18,2) COMMENT 'Effective maturity parameter (M) in years as defined under the IRB Advanced approach, capped at 5 years and floored at 1 year. Adjusts the IRB capital formula for longer-dated exposures via the maturity adjustment factor.',
    `expected_exposure` DECIMAL(18,2) COMMENT 'Average exposure across all simulation paths at a future time horizon, used as the basis for CVA calculation and expected credit loss (ECL) provisioning under IFRS 9.',
    `exposure_class` STRING COMMENT 'Regulatory asset class of the exposure under Basel III/CRR2 framework, determining the applicable risk weight and capital treatment. [ENUM-REF-CANDIDATE: corporate|sovereign|institution|retail|equity|securitisation|other — promote to reference product]',
    `exposure_reference` STRING COMMENT 'Externally-known business reference number for this credit exposure record, as assigned by the risk management platform (SAS Risk Management / Moodys RiskAuthority) or trading system (Murex/Calypso). Used for reconciliation and regulatory reporting.',
    `exposure_status` STRING COMMENT 'Current lifecycle status of the credit exposure. Drives provisioning, regulatory classification, and workout processes. [ENUM-REF-CANDIDATE: active|closed|defaulted|restructured|watch_list|written_off — promote to reference product if additional states required]. Valid values are `active|closed|defaulted|restructured|watch_list|written_off`',
    `fva` DECIMAL(18,2) COMMENT 'Adjustment to derivative fair value reflecting the cost or benefit of funding uncollateralised derivative positions. Captures the funding spread between the banks borrowing cost and the risk-free rate.',
    `fx_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to translate the exposure from its original currency to the reporting currency as of the measurement date. Sourced from the banks official FX rate feed.',
    `industry_sector` STRING COMMENT 'Industry sector classification of the counterparty using GICS or NACE codes. Drives sector concentration risk measurement, HHI calculation, and sectoral capital buffer requirements.',
    `large_exposure_flag` BOOLEAN COMMENT 'Indicates whether this exposure meets or exceeds the large exposure threshold (10% of eligible capital) requiring regulatory reporting under CRR2 Article 395. Triggers enhanced monitoring and reporting obligations.',
    `lgd` DECIMAL(18,2) COMMENT 'Estimated fraction of the Exposure at Default (EAD) that would be lost in the event of default, expressed as a decimal (e.g., 0.45 = 45%). Reflects collateral, seniority, and recovery assumptions under IRB Advanced approach.',
    `maturity_date` DATE COMMENT 'Contractual maturity date of the underlying credit facility or instrument. Used to calculate effective maturity (M) for IRB capital calculation and to determine the exposures remaining tenor for PFE and CVA profiles.',
    `measurement_date` DATE COMMENT 'The as-of date on which the credit exposure was measured and calculated. Represents the principal business event date for this record. Used for point-in-time regulatory reporting (CCAR, DFAST, Pillar 3).',
    `net_exposure` DECIMAL(18,2) COMMENT 'Credit exposure after applying netting agreements and eligible collateral offsets (EAD minus collateral value). Represents the banks actual economic risk position used for limit monitoring and large exposure reporting.',
    `pd` DECIMAL(18,2) COMMENT 'Estimated probability that the obligor will default within a one-year horizon, expressed as a decimal (e.g., 0.00250 = 0.25%). Core IRB parameter used in RWA and ECL calculation under IFRS 9 and CECL.',
    `pillar3_disclosure_flag` BOOLEAN COMMENT 'Indicates whether this exposure record is included in the banks Pillar 3 public disclosure reporting under Basel III. Drives the regulatory reporting extract for AxiomSL/Wolters Kluwer OneSumX.',
    `potential_future_exposure` DECIMAL(18,2) COMMENT 'Estimated maximum exposure at a specified confidence level (typically 95%) over the remaining life of the transaction, capturing future market movements. Used in counterparty credit limit monitoring and CVA calculation.',
    `product_type` STRING COMMENT 'Type of financial instrument or credit product giving rise to the exposure. Determines applicable credit conversion factor (CCF) and exposure calculation methodology. [ENUM-REF-CANDIDATE: loan|revolving_credit|bond|otc_derivative|repo|securities_lending|letter_of_credit|guarantee — promote to reference product]',
    `regulatory_approach` STRING COMMENT 'Regulatory methodology applied to calculate risk-weighted assets (RWA) for this exposure: Standardised Approach (SA), Foundation Internal Ratings-Based (F-IRB), Advanced IRB (A-IRB), Standardised Approach for Counterparty Credit Risk (SA-CCR), or Internal Model Method (IMM).. Valid values are `SA|IRB_Foundation|IRB_Advanced|SA-CCR|IMM`',
    `reporting_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code of the banks reporting currency into which all exposure amounts are translated for regulatory capital and Pillar 3 reporting (typically USD or EUR).. Valid values are `^[A-Z]{3}$`',
    `risk_weight` DECIMAL(18,2) COMMENT 'Risk weight percentage applied to the exposure to derive credit RWA, expressed as a decimal (e.g., 1.00 = 100%). Determined by exposure class, counterparty rating, and regulatory approach (SA or IRB).',
    `rwa_credit` DECIMAL(18,2) COMMENT 'Risk-weighted asset amount for credit risk calculated for this exposure under the applicable regulatory approach (SA or IRB). Primary input to CET1 capital ratio calculation and Pillar 3 disclosure.',
    `source_system` STRING COMMENT 'Operational system of record from which this credit exposure record was sourced (e.g., Murex/Calypso for derivatives, Finastra Loan IQ for loans, SAS Risk Management for aggregated risk). Supports data lineage and BCBS 239 compliance.. Valid values are `Murex|Calypso|SAS_Risk|Moodys_RiskAuthority|LoanIQ|CoreBanking`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit exposure record was last modified or recalculated. Tracks recalibration events, model updates, and data corrections.',
    CONSTRAINT pk_credit_exposure PRIMARY KEY(`credit_exposure_id`)
) COMMENT 'Transactional record of credit exposure measurement, risk-weighted asset (RWA) calculation, and counterparty credit valuation adjustment (CVA) for obligors, counterparties, and portfolios. For exposure measurement: captures current exposure, potential future exposure (PFE), expected exposure (EE), EAD, netting set identifiers, collateral offsets, and exposure by regulatory approach (SA and IRB). For RWA: captures credit, market, and operational RWA by portfolio, asset class, and regulatory framework (Basel III/CRR2), with capital ratios (CET1, Tier 1, Total Capital) and Pillar 3 disclosure metadata. For CVA: captures CVA, DVA, FVA for OTC derivative counterparty credit risk including counterparty PD, LGD, expected exposure profile, netting set, CSA terms, hedging instruments, and regulatory CVA capital charge under SA-CVA/BA-CVA. Includes concentration risk metrics: single-name, sector, geographic, and product concentration exposures, HHI, and regulatory large exposure reporting under CRR Article 395. Primary input to CCAR/DFAST stress testing, ECL provisioning, and concentration limit monitoring. Sourced from Murex/Calypso and SAS Risk Management.';

CREATE OR REPLACE TABLE `banking_ecm`.`risk`.`market_risk_position` (
    `market_risk_position_id` BIGINT COMMENT 'Unique surrogate identifier for each daily mark-to-market risk position record in the trading book or banking book. Primary key for this entity.',
    `alm_hedge_id` BIGINT COMMENT 'Foreign key linking to treasury.alm_hedge. Business justification: Market risk positions identify hedged items for ALM hedge effectiveness testing under IAS 39/IFRS 9 hedge accounting. Treasury ALM hedges reference specific market risk positions as hedged items for p',
    `collateral_asset_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_asset. Business justification: Derivatives and securities positions require collateral posting under CSA/margin agreements. Links position to posted collateral for margin call calculations, regulatory capital (SA-CCR), and collater',
    `currency_id` BIGINT COMMENT 'ISO 4217 three-letter currency code of the positions native denomination. Used for FX translation to reporting currency and FX risk sensitivity calculation.',
    `factor_id` BIGINT COMMENT 'Foreign key linking to risk.risk_factor. Business justification: Each market risk position is exposed to specific risk factors (interest rate, FX, equity, credit spread). The market_risk_position table has risk_factor_code field which should be replaced by FK to ri',
    `instrument_id` BIGINT COMMENT 'Reference to the financial instrument (security, derivative, loan, deposit) underlying this risk position. Links to the instrument master in the trading or risk system.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Market risk positions must be attributed to legal entities for FRTB regulatory capital calculations, consolidated trading book reporting, and financial statement fair value disclosures. Essential for ',
    `party_id` BIGINT COMMENT 'Reference to the counterparty or issuer associated with this risk position. Used for counterparty credit risk aggregation, CVA computation, and large exposure reporting.',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to risk.risk_limit. Business justification: Market risk positions are monitored against VaR limits, position limits, and concentration limits. The market_risk_position table has var_1d_99, var_10d_99, and notional_amount but no reference to the',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Market risk positions are stressed under defined scenarios for FRTB and IRRBB (Interest Rate Risk in Banking Book). The market_risk_position table has irrbb_scenario field which should be replaced by ',
    `trading_book_id` BIGINT COMMENT 'Reference to the trading desk or business unit responsible for this position. Under FRTB, trading desks are the primary unit for IMA approval and P&L attribution testing.',
    `valuation_model_id` BIGINT COMMENT 'Foreign key linking to risk.valuation_model. Business justification: Market risk positions require valuation models to calculate mark-to-market (MTM) values. The market_risk_position table has mtm_value, which is produced by applying a valuation model to the instrument',
    `asset_class` STRING COMMENT 'Broad asset class classification of the instrument (e.g., equity, interest_rate, credit, fx, commodity, securitisation). Drives risk factor assignment, sensitivity bucketing, and capital charge calculation under FRTB SA and IMA. [ENUM-REF-CANDIDATE: equity|interest_rate|credit|fx|commodity|securitisation|other — promote to reference product]',
    `book_type` STRING COMMENT 'Regulatory classification of the position as either trading book (subject to market risk capital under FRTB) or banking book (subject to IRRBB framework). Determines applicable capital treatment and risk measurement methodology.. Valid values are `trading_book|banking_book`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk position record was first captured in the data platform. Used for audit trail and data lineage tracking.',
    `cs01` DECIMAL(18,2) COMMENT 'Credit Spread sensitivity — the change in MTM value for a 1 basis point widening in the credit spread of the underlying issuer or reference entity. Key measure for credit risk management and FRTB CSR (Credit Spread Risk) capital charge.',
    `cva_charge` DECIMAL(18,2) COMMENT 'Credit Valuation Adjustment representing the market value of counterparty default risk embedded in OTC derivative positions. Reflects the expected loss due to counterparty credit deterioration or default. Required under Basel III CVA framework.',
    `delta` DECIMAL(18,2) COMMENT 'First-order sensitivity of the positions MTM value to a unit change in the underlying risk factor price (e.g., equity price, FX spot rate, commodity price). Used for delta hedging and FRTB SA delta risk charge calculation.',
    `dv01` DECIMAL(18,2) COMMENT 'Dollar Value of a 01 (one basis point) shift in interest rates — the change in MTM value for a 1 basis point (0.01%) parallel upward shift in the yield curve. Primary interest rate sensitivity measure used for hedging and risk limit monitoring.',
    `eve_sensitivity` DECIMAL(18,2) COMMENT 'Sensitivity of the Economic Value of Equity to standardised interest rate shock scenarios under IRRBB. Measures the long-term impact of rate changes on the present value of banking book assets and liabilities. Used in IRRBB supervisory outlier test.',
    `expected_shortfall` DECIMAL(18,2) COMMENT 'Expected Shortfall (Conditional VaR) at 97.5% confidence level as required under FRTB IMA. Measures the average loss in the worst 2.5% of scenarios, replacing VaR as the primary IMA risk measure under FRTB.',
    `frtb_approach` STRING COMMENT 'Indicates whether the FRTB capital charge for this position is computed under the Internal Models Approach (IMA), Standardised Approach (SA), or IMA with SA fallback for non-modellable risk factors (NMRFs).. Valid values are `IMA|SA|IMA_fallback`',
    `frtb_capital_charge` DECIMAL(18,2) COMMENT 'Total FRTB market risk capital charge for this position, representing the higher of the IMA (Internal Models Approach) or SA (Standardised Approach) capital requirement as applicable. Reported to regulators under FRTB framework.',
    `gamma` DECIMAL(18,2) COMMENT 'Second-order (curvature) sensitivity of the positions MTM value to changes in the underlying risk factor. Captures non-linear risk for options and structured products. Used in FRTB SA curvature risk charge calculation.',
    `hedge_designation` STRING COMMENT 'Accounting hedge designation for the position under IFRS 9 or ASC 815. Determines whether hedge accounting is applied and the treatment of fair value changes in OCI vs P&L. Relevant for banking book hedges of interest rate and FX risk.. Valid values are `fair_value_hedge|cash_flow_hedge|net_investment_hedge|not_designated`',
    `hypothetical_pnl` DECIMAL(18,2) COMMENT 'Hypothetical P&L computed by revaluing the prior days portfolio using current days market prices, holding positions constant. Used in VaR backtesting and FRTB IMA P&L attribution test to validate risk model accuracy.',
    `instrument_type` STRING COMMENT 'Specific instrument type classification (e.g., bond, equity, interest_rate_swap, fx_forward, credit_default_swap, option, futures, mortgage_backed_security). Used for product-level risk aggregation and regulatory reporting. [ENUM-REF-CANDIDATE: bond|equity|interest_rate_swap|fx_forward|credit_default_swap|option|futures|mortgage_backed_security|other — promote to reference product]',
    `irc_charge` DECIMAL(18,2) COMMENT 'Incremental Risk Charge capturing default and migration risk for credit-sensitive positions in the trading book over a one-year capital horizon at 99.9% confidence. Applicable to non-securitisation credit positions under Basel 2.5.',
    `is_modellable_risk_factor` BOOLEAN COMMENT 'Indicates whether the primary risk factor for this position passes the FRTB Risk Factor Eligibility Test (RFET) and is classified as modellable. Non-modellable risk factors (NMRFs) attract a separate stress scenario capital add-on under FRTB IMA.',
    `maturity_date` DATE COMMENT 'The contractual maturity or expiry date of the instrument underlying this position. Used for repricing gap bucketing, duration calculation, and IRRBB cash flow mapping.',
    `mtm_value` DECIMAL(18,2) COMMENT 'Current mark-to-market fair value of the position in the reporting currency as of the position date. Represents the present value of future cash flows discounted at current market rates. Core input for P&L attribution and capital calculations.',
    `nii_sensitivity` DECIMAL(18,2) COMMENT 'Sensitivity of Net Interest Income to a standardised interest rate shock scenario (e.g., +200bps parallel shift). Applicable to banking book positions under IRRBB framework. Measures short-term earnings impact of rate changes.',
    `notional_amount` DECIMAL(18,2) COMMENT 'The face value or contractual notional amount of the position in the instruments native currency. For derivatives, this is the reference principal used to compute cash flows and risk sensitivities.',
    `pnl_daily` DECIMAL(18,2) COMMENT 'Daily P&L for the position representing the change in MTM value from the prior business day. Used for P&L attribution analysis, backtesting of VaR models, and FRTB IMA P&L attribution test (PLAT) compliance.',
    `position_date` DATE COMMENT 'The business date (valuation date) for which this risk position snapshot is captured. Represents the as-of date for all MTM values, sensitivities, and risk measures on this record.',
    `position_reference` STRING COMMENT 'Externally-known business identifier for the risk position as assigned by the source trading or risk system (e.g., Murex position ID or Calypso deal reference). Used for reconciliation with the system of record.',
    `position_status` STRING COMMENT 'Current lifecycle state of the risk position indicating whether it is actively open, closed out, suspended pending review, awaiting settlement, or cancelled.. Valid values are `open|closed|suspended|pending_settlement|cancelled`',
    `reporting_currency_code` STRING COMMENT 'ISO 4217 three-letter code for the base reporting currency (typically USD or EUR) into which all MTM values and risk measures are translated for regulatory and management reporting.. Valid values are `^[A-Z]{3}$`',
    `repricing_bucket` STRING COMMENT 'Time bucket classification for the repricing gap analysis (e.g., overnight, 1M, 3M, 6M, 1Y, 2Y, 5Y, 10Y+). Indicates when the positions interest rate resets or matures, driving IRRBB gap analysis and NII sensitivity computation. [ENUM-REF-CANDIDATE: overnight|1M|3M|6M|1Y|2Y|5Y|10Y_plus — promote to reference product]',
    `repricing_gap` DECIMAL(18,2) COMMENT 'The net difference between rate-sensitive assets and rate-sensitive liabilities repricing within a given time bucket. Used in IRRBB repricing gap analysis to identify mismatches that create NII at risk. Applicable to banking book positions.',
    `rwa_market_risk` DECIMAL(18,2) COMMENT 'Risk-Weighted Assets attributable to market risk for this position, computed as the capital charge multiplied by 12.5 (reciprocal of the 8% minimum capital ratio). Used in CET1 ratio and CCAR/DFAST capital adequacy reporting.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this risk position was sourced (e.g., MUREX for trading book positions, SAS_RISK for risk aggregations, AXIOMSL for regulatory submissions). Supports data lineage and reconciliation.. Valid values are `MUREX|CALYPSO|SAS_RISK|MOODYS_RA|AXIOMSL`',
    `stressed_var` DECIMAL(18,2) COMMENT 'Stressed VaR computed using a continuous 12-month historical stress period calibrated to significant financial stress (e.g., 2008 financial crisis). Required under Basel 2.5 and used as a multiplier component in market risk capital calculation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this risk position record, supporting audit trail and change tracking requirements.',
    `var_10d_99` DECIMAL(18,2) COMMENT 'Ten-day Value at Risk at 99% confidence level, scaled from the 1-day VaR using the square-root-of-time rule or direct simulation. Used for regulatory capital calculation under Basel 2.5 market risk framework.',
    `var_1d_99` DECIMAL(18,2) COMMENT 'One-day Value at Risk at 99% confidence level computed using historical simulation methodology. Represents the maximum expected loss over a one-day horizon with 99% probability. Primary regulatory VaR metric under Basel 2.5 and FRTB IMA.',
    `vega` DECIMAL(18,2) COMMENT 'Sensitivity of the positions MTM value to a 1% change in implied volatility of the underlying. Applicable to options and volatility-sensitive instruments. Used in FRTB SA vega risk charge calculation.',
    CONSTRAINT pk_market_risk_position PRIMARY KEY(`market_risk_position_id`)
) COMMENT 'Daily mark-to-market risk position record for trading book and banking book instruments. For trading book: captures MTM value, VaR (historical simulation, Monte Carlo, parametric), stressed VaR, IRC, sensitivity measures (DV01, CS01, delta, gamma, vega), P&L attribution, and FRTB IMA/SA capital charges. For banking book (IRRBB): captures repricing gap analysis, NII sensitivity, EVE sensitivity, basis risk, optionality risk, yield curve shock scenarios (parallel shift, twist, steepener, flattener), NII at risk, EVE at risk, and BCBS IRRBB standard compliance metrics. Sourced from Murex/Calypso trading system and SAS Risk Management. Supports ALCO reporting, treasury ALM coordination, FRTB regulatory submissions, and IRRBB supervisory outlier test compliance.';

CREATE OR REPLACE TABLE `banking_ecm`.`risk`.`risk_ecl_provision` (
    `risk_ecl_provision_id` BIGINT COMMENT 'Unique surrogate identifier for each ECL provisioning and credit quality classification record in the risk domain. Primary key for the risk_ecl_provision data product.',
    `aml_case_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_case. Business justification: AML investigations uncover fraud patterns or credit deterioration requiring ECL provision adjustments. Banks provision for losses identified through AML case investigations, supporting IFRS 9/CECL com',
    `collateral_pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.pledge. Business justification: IFRS9/CECL ECL calculations require collateral coverage assessment. LGD estimates depend on pledged collateral value, haircuts, and enforceability. Essential for Stage 2/3 provision calculations and r',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: ECL provisions use PD/LGD estimates from counterparty ratings. The risk_ecl_provision table has internal_credit_rating, external_credit_rating, rating_agency fields which duplicate data from counterpa',
    `currency_id` BIGINT COMMENT 'ISO 4217 three-letter currency code in which the provision amount, EAD, and ECL figures are denominated. Supports multi-currency provisioning and FX translation for consolidated reporting.',
    `ftp_allocation_id` BIGINT COMMENT 'Foreign key linking to treasury.ftp_allocation. Business justification: ECL provisions adjust FTP allocations for credit risk pricing in RAROC framework. Treasury FTP rates incorporate expected credit loss adjustments from risk ECL calculations to ensure risk-adjusted pro',
    `irb_model_id` BIGINT COMMENT 'Foreign key linking to risk.irb_model. Business justification: ECL provisions calculate PD, LGD, and EAD estimates using IRB model parameters. The risk_ecl_provision table has pd_12month, pd_lifetime, and lgd_estimate attributes that are derived from IRB model ou',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: IFRS 9/CECL ECL provisions must be posted to the general ledger via journal entries to recognize credit loss provisions in financial statements. Critical for financial reporting accuracy and audit tra',
    `loan_account_id` BIGINT COMMENT 'Reference to the underlying loan or credit facility for which the ECL provision is calculated. Links to the loan master record in the Core Banking System (Temenos T24 / FIS Profile) or Loan Origination System (Finastra Fusion Loan IQ).',
    `party_id` BIGINT COMMENT 'Reference to the borrower or counterparty customer record associated with this ECL provision. Enables customer-level aggregation of credit risk exposure and provision balances.',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: ECL provisions are calculated under multiple macroeconomic scenarios (base, upside, downside) per IFRS 9 requirements. The risk_ecl_provision table has macro_scenario_type field which should be replac',
    `cecl_pool_classification` STRING COMMENT 'FASB ASC 326 (CECL) pool or segment classification used for collective assessment of expected credit losses. Identifies the homogeneous risk pool to which the instrument is assigned for CECL measurement purposes. [ENUM-REF-CANDIDATE: commercial_real_estate|commercial_industrial|consumer_mortgage|consumer_auto|consumer_unsecured|credit_card|other — promote to reference product]',
    `collateral_value` DECIMAL(18,2) COMMENT 'Current market or appraised value of collateral securing the credit exposure as of the reporting date. Used in LGD estimation and LTV calculation. Relevant for secured lending provisions and NPL recovery analysis.',
    `collective_assessment_flag` BOOLEAN COMMENT 'Indicates whether the ECL provision was calculated on a collective (pooled) basis rather than an individual (specific) basis. Collective assessment is applied when individual assessment is not practicable, typically for homogeneous retail portfolios.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ECL provision record was first created in the data platform. Supports audit trail, data lineage, and SOX compliance requirements.',
    `cure_status` STRING COMMENT 'Indicates the cure or exit status of a previously defaulted or forborne exposure. Tracks whether the borrower has exited NPL/forbearance status, is in the probation period, has been fully cured, or has re-defaulted.. Valid values are `not_applicable|probation|cured|re_defaulted`',
    `days_past_due` STRING COMMENT 'Number of calendar days the credit obligation is past its contractual due date as of the reporting date. Key trigger for stage migration (>30 DPD for Stage 2, >90 DPD for Stage 3 / NPL under EBA definition) and NPL classification.',
    `default_flag` BOOLEAN COMMENT 'Indicates whether the obligor is in default as defined under Basel III IRB framework (>90 DPD or unlikely-to-pay criteria). Triggers Stage 3 classification under IFRS 9 and NPL status under EBA definition.',
    `discount_rate` DECIMAL(18,2) COMMENT 'The effective interest rate used to discount future expected credit loss cash flows to present value as of the reporting date. Per IFRS 9, this is the original effective interest rate (or credit-adjusted EIR for POCI assets).',
    `ead_amount` DECIMAL(18,2) COMMENT 'Estimated gross exposure of the credit facility at the point of default, expressed in the instrument currency. Represents the outstanding balance plus expected drawdowns on undrawn commitments used as the base for ECL calculation.',
    `ecl_12month_amount` DECIMAL(18,2) COMMENT 'Calculated 12-month ECL provision amount representing the probability-weighted credit loss from default events expected within 12 months of the reporting date. Applied to Stage 1 exposures. Computed as PD_12month × LGD × EAD discounted at the effective interest rate.',
    `ecl_lifetime_amount` DECIMAL(18,2) COMMENT 'Calculated lifetime ECL provision amount representing the probability-weighted credit loss over the remaining life of the instrument. Applied to Stage 2 and Stage 3 exposures under IFRS 9 and all exposures under CECL.',
    `forbearance_flag` BOOLEAN COMMENT 'Indicates whether the credit exposure has been subject to forbearance measures (concessions granted to a borrower experiencing financial difficulty). Forbearance status affects stage classification and NPL reporting under EBA guidelines.',
    `ifrs9_stage` STRING COMMENT 'IFRS 9 credit impairment stage classification: Stage 1 (performing, 12-month ECL), Stage 2 (significant increase in credit risk, lifetime ECL), Stage 3 (credit-impaired, lifetime ECL). Drives the ECL measurement horizon and provision methodology.. Valid values are `stage_1|stage_2|stage_3`',
    `lgd_estimate` DECIMAL(18,2) COMMENT 'Estimated proportion of the EAD that would be lost in the event of default, expressed as a decimal (e.g., 0.45 = 45%). Reflects collateral coverage, seniority, and recovery expectations. Key input to ECL and IRB RWA calculation.',
    `ltv_ratio` DECIMAL(18,2) COMMENT 'Ratio of the outstanding loan balance to the current collateral value, expressed as a decimal (e.g., 0.75 = 75% LTV). Key risk indicator for secured lending provisions, particularly mortgage portfolios. Influences LGD and stage classification.',
    `macro_overlay_factor` DECIMAL(18,2) COMMENT 'Forward-looking macroeconomic adjustment factor applied to the base ECL model output to incorporate point-in-time economic conditions (e.g., GDP growth, unemployment rate, house price index scenarios). Reflects IFRS 9 requirement for unbiased, probability-weighted forward-looking information.',
    `macro_scenario_weight` DECIMAL(18,2) COMMENT 'Probability weight assigned to the macroeconomic scenario (base, upside, downside) used in the probability-weighted ECL calculation. The sum of scenario weights across all scenarios for a given exposure must equal 1.0.',
    `maturity_date` DATE COMMENT 'Contractual maturity date of the credit instrument. Determines the remaining life used in lifetime ECL calculation and the PD term structure horizon for Stage 2 and Stage 3 provisions.',
    `npl_classification` STRING COMMENT 'Regulatory asset quality classification of the credit exposure per OCC and EBA NPL frameworks: performing, watch list, substandard, doubtful, or loss. Drives regulatory capital and provisioning requirements under the standardized approach.. Valid values are `performing|watch|substandard|doubtful|loss`',
    `npl_entry_date` DATE COMMENT 'Date on which the credit exposure was first classified as non-performing under the EBA NPL definition. Used for NPL vintage analysis, cure period tracking, and EBA NPL ratio reporting.',
    `origination_date` DATE COMMENT 'Date on which the credit facility was originally originated or the financial instrument was initially recognized. Used to determine the initial recognition PD for SICR assessment and POCI identification under IFRS 9.',
    `pd_12month` DECIMAL(18,2) COMMENT 'Estimated probability that the obligor will default within the next 12 months, expressed as a decimal (e.g., 0.00250 = 0.25%). Used for Stage 1 ECL calculation and IRB capital requirement computation.',
    `pd_lifetime` DECIMAL(18,2) COMMENT 'Estimated probability that the obligor will default over the remaining contractual life of the instrument. Used for Stage 2 and Stage 3 lifetime ECL calculation under IFRS 9.',
    `poci_flag` BOOLEAN COMMENT 'Indicates whether the financial instrument was purchased or originated as credit-impaired (POCI). POCI assets use a credit-adjusted effective interest rate and lifetime ECL from initial recognition under IFRS 9.',
    `portfolio_segment` STRING COMMENT 'High-level portfolio segment classification of the credit exposure for ECL modeling and regulatory reporting purposes. Determines the applicable IRB sub-model (retail, corporate, sovereign, etc.) and CECL pool assignment.. Valid values are `retail|corporate|sme|sovereign|financial_institution|other`',
    `product_type` STRING COMMENT 'Type of credit product or financial instrument to which the ECL provision relates (e.g., term loan, revolving credit facility, mortgage, trade finance, overdraft, bond). Determines the applicable ECL methodology and regulatory treatment. [ENUM-REF-CANDIDATE: term_loan|revolving_credit|mortgage|trade_finance|overdraft|bond|guarantee|other — promote to reference product]',
    `provision_amount` DECIMAL(18,2) COMMENT 'The recognized ECL provision balance recorded on the balance sheet as of the reporting date. Equals ecl_12month_amount for Stage 1 or ecl_lifetime_amount for Stage 2/3. This is the gross provision before any write-offs.',
    `provision_movement_amount` DECIMAL(18,2) COMMENT 'Net change in the provision balance during the reporting period (current period provision minus prior period provision). Positive values indicate an increase (charge to P&L); negative values indicate a release (credit to P&L). Used for income statement impairment charge reporting.',
    `provision_reference_number` STRING COMMENT 'Externally-known business identifier for the ECL provision record, used for cross-system reconciliation and regulatory reporting. Typically sourced from the Risk Management Platform (SAS Risk Management / Moodys RiskAuthority).',
    `provision_status` STRING COMMENT 'Current lifecycle status of the ECL provision record. Indicates whether the provision is active, has been reversed upon cure, transferred to another stage, written off, or is under review.. Valid values are `active|reversed|written_off|transferred|under_review`',
    `recovery_expectation_amount` DECIMAL(18,2) COMMENT 'Estimated amount expected to be recovered from a written-off or defaulted exposure through collateral realization, guarantees, or workout proceedings. Informs the net LGD estimate and provision adequacy assessment.',
    `reporting_date` DATE COMMENT 'The balance sheet or reporting reference date as of which the ECL provision is measured and staged. Represents the principal business event date for this record, used for period-end regulatory and financial reporting.',
    `sicr_flag` BOOLEAN COMMENT 'Indicates whether a significant increase in credit risk has been identified for this exposure since initial recognition, triggering migration from Stage 1 to Stage 2 under IFRS 9. Based on quantitative and qualitative SICR criteria.',
    `stage_migration_date` DATE COMMENT 'Date on which the most recent IFRS 9 stage migration occurred (e.g., Stage 1 to Stage 2, Stage 2 to Stage 3, or back-migration). Supports stage migration analysis, provision volatility monitoring, and audit trail requirements.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this ECL provision record was last modified in the data platform. Supports change tracking, reconciliation, and audit trail requirements for regulatory reporting.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of the credit exposure that has been written off against the provision balance, reducing both the gross loan balance and the provision. Triggered when there is no reasonable expectation of recovery.',
    CONSTRAINT pk_risk_ecl_provision PRIMARY KEY(`risk_ecl_provision_id`)
) COMMENT 'Expected Credit Loss (ECL) provisioning and credit quality classification record under IFRS 9 and CECL frameworks. For ECL calculation: captures stage classification (Stage 1/2/3), 12-month ECL, lifetime ECL, PD term structure, LGD estimates, EAD, discount rate, forward-looking macroeconomic overlays, and provision movement. For NPL classification: captures NPL stage (substandard, doubtful, loss), days past due, forbearance flag, cure status, write-off amount, recovery expectation, EBA NPL definition compliance, and NPL ratio reporting. Supports regulatory reporting to FASB, IASB, OCC, EBA, and prudential regulators. Primary output for credit risk provisioning and impairment reporting.';

CREATE OR REPLACE TABLE `banking_ecm`.`risk`.`irb_model` (
    `irb_model_id` BIGINT COMMENT 'Unique surrogate identifier for the IRB model record in the risk data platform. Primary key for the irb_model entity. Role: MASTER_RESOURCE.',
    `compliance_sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: IRB models used for allowance estimation (CECL/IFRS 9) are subject to SOX controls over model governance, change management, and access controls. Banks link models to SOX controls for audit evidence a',
    `employee_id` BIGINT COMMENT 'Identifier of the team or individual who developed the IRB model. Supports model governance documentation, audit trail, and SR 11-7 accountability requirements.',
    `primary_irb_employee_id` BIGINT COMMENT 'Identifier of the business unit or individual designated as the model owner responsible for model performance, ongoing monitoring, and remediation of findings. Aligns with SR 11-7 model ownership accountability requirements.',
    `asset_class` STRING COMMENT 'Regulatory asset class to which the IRB model applies, as defined under Basel III (e.g., Corporate, Retail — Residential Mortgage, Retail — Qualifying Revolving, SME, Sovereign, Bank, Specialised Lending). Determines applicable risk-weight functions and regulatory floors. [ENUM-REF-CANDIDATE: Corporate|Retail-Mortgage|Retail-QRRE|Retail-Other|SME|Sovereign|Bank|Specialised-Lending — promote to reference product]',
    `auc_roc` DECIMAL(18,2) COMMENT 'Area Under the Receiver Operating Characteristic Curve (AUC-ROC) measuring the models discriminatory power. Ranges from 0.5 (random) to 1.0 (perfect). Complementary to the Gini coefficient (AUC = (Gini + 1) / 2). Reported in model validation and performance monitoring.',
    `backtesting_date` DATE COMMENT 'Date on which the most recent backtesting exercise was completed for this IRB model. Backtesting compares predicted PD/LGD/EAD estimates against realised outcomes over the monitoring period.',
    `backtesting_result` STRING COMMENT 'Red-Amber-Green (RAG) status from the most recent backtesting exercise comparing model-predicted default rates against observed default rates. Green: within tolerance; Amber: minor deviation requiring monitoring; Red: material deviation requiring recalibration or override. Reported to ALCO and model risk committee.. Valid values are `Green|Amber|Red`',
    `brier_score` DECIMAL(18,2) COMMENT 'Brier score measuring the mean squared error between predicted PD estimates and observed default outcomes. Lower values indicate better calibration accuracy. Used in model validation to assess PD calibration quality alongside the Hosmer-Lemeshow test.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the IRB model record was first created in the risk data platform. Supports audit trail, data lineage, and model governance documentation requirements.',
    `default_definition` STRING COMMENT 'Description of the default definition applied in the IRB model, specifying the criteria used to classify an obligor or facility as defaulted (e.g., 90 days past due, unlikeliness to pay, distressed restructuring). Must align with Basel III Article 178 and internal credit policy.',
    `downturn_lgd` DECIMAL(18,2) COMMENT 'Downturn LGD estimate (expressed as a decimal, e.g., 0.45 = 45%) reflecting loss rates observed during periods of economic stress or downturn, as required by Basel III for regulatory capital calculation. Applicable to LGD model types only.',
    `ead_ccf_estimate` DECIMAL(18,2) COMMENT 'Credit Conversion Factor (CCF) estimate (expressed as a decimal, e.g., 0.75 = 75%) used to convert off-balance-sheet commitments to credit equivalent EAD amounts. Applicable to EAD/CCF model types. Used in RWA and ECL calculation.',
    `effective_from_date` DATE COMMENT 'Date from which the IRB model version became effective for use in credit risk estimation, RWA calculation, and ECL provisioning. Marks the start of the models active deployment period.',
    `effective_until_date` DATE COMMENT 'Date on which the IRB model version ceases to be effective and is superseded or retired. Null for currently active models with no scheduled end date.',
    `gini_coefficient` DECIMAL(18,2) COMMENT 'Gini coefficient (also known as Accuracy Ratio) measuring the discriminatory power of the IRB model — its ability to rank-order defaulters from non-defaulters. Ranges from 0 (no discrimination) to 1 (perfect discrimination). Key model performance metric reported in validation reports and regulatory submissions.',
    `last_validation_date` DATE COMMENT 'Date on which the most recent independent model validation was completed. SR 11-7 requires periodic independent validation of all models used for material risk decisions. Supports model governance tracking and regulatory examination readiness.',
    `lgd_in_default` DECIMAL(18,2) COMMENT 'Best estimate of LGD for exposures currently in default, used for IFRS 9 ECL Stage 3 provisioning and workout LGD calculations. Distinct from the regulatory downturn LGD used for RWA. Applicable to LGD model types.',
    `long_run_average_pd` DECIMAL(18,2) COMMENT 'Long-run average PD (expressed as a decimal, e.g., 0.0025 = 0.25%) estimated for the models portfolio segment, representing the through-the-cycle central tendency. Used as the calibration anchor for Basel III regulatory capital. Applicable to PD model types only.',
    `macroeconomic_scenario` STRING COMMENT 'Name or identifier of the macroeconomic scenario used to condition PIT PD estimates (e.g., Base Case 2024Q4, Adverse Scenario DFAST 2024, Severely Adverse). Relevant for IFRS 9 ECL multiple scenario weighting and CCAR/DFAST stress testing.',
    `model_approach` STRING COMMENT 'Indicates whether the model operates under the Foundation Internal Ratings-Based (F-IRB) approach, where only PD is internally estimated and LGD/EAD use supervisory values, or the Advanced IRB (A-IRB) approach, where PD, LGD, and EAD are all internally estimated.. Valid values are `Foundation-IRB|Advanced-IRB`',
    `model_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the IRB model by the model governance function (e.g., PD-CORP-001, LGD-RETAIL-003). Used as the business identifier across risk systems, regulatory submissions, and model inventory.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `model_methodology` STRING COMMENT 'Description of the statistical or econometric methodology used to develop the IRB model (e.g., logistic regression, survival analysis, machine learning gradient boosting, scorecard). Supports model governance documentation and SR 11-7 compliance.',
    `model_name` STRING COMMENT 'Human-readable descriptive name of the IRB model (e.g., Corporate PD Model — North America, Retail Mortgage LGD Model). Used in model governance documentation, regulatory submissions, and reporting.',
    `model_risk_rating` STRING COMMENT 'Internal model risk rating assigned by the model risk management function reflecting the materiality and complexity of the model and the quality of its validation. Drives oversight intensity, validation frequency, and escalation thresholds under SR 11-7.. Valid values are `Low|Medium|High|Critical`',
    `model_status` STRING COMMENT 'Current lifecycle state of the IRB model within the model governance framework: Active (in production use for RWA/ECL), Under-Review (undergoing validation or recalibration), Deprecated (retired from use), Pending-Approval (awaiting regulatory or internal sign-off), Rejected (failed validation or regulatory review).. Valid values are `Active|Under-Review|Deprecated|Pending-Approval|Rejected`',
    `model_type` STRING COMMENT 'Classification of the IRB model by the credit risk parameter it estimates: PD (Probability of Default), LGD (Loss Given Default), EAD (Exposure at Default), or CCF (Credit Conversion Factor). Determines the models role in RWA and ECL calculation.. Valid values are `PD|LGD|EAD|CCF`',
    `model_version` STRING COMMENT 'Version identifier of the IRB model following semantic versioning convention (e.g., 2.1.0). Incremented upon material recalibration, redevelopment, or methodology change. Supports model change management and audit trail.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `next_validation_date` DATE COMMENT 'Date by which the next independent model validation must be completed per the model governance calendar. Supports proactive scheduling of validation resources and regulatory compliance tracking.',
    `number_of_rating_grades` STRING COMMENT 'Total number of distinct non-default rating grades in the models rating scale. Basel III requires a minimum of 7 non-default grades for corporate/bank/sovereign exposures. Used in model governance and regulatory review.',
    `observation_period_end` DATE COMMENT 'End date of the historical data observation window used to develop and calibrate the IRB model. Together with observation_period_start, defines the data history span used for model estimation.',
    `observation_period_start` DATE COMMENT 'Start date of the historical data observation window used to develop and calibrate the IRB model. Basel III requires a minimum of 5 years for PD and 7 years for LGD/EAD. Supports model documentation and regulatory review.',
    `override_count` STRING COMMENT 'Number of times model outputs have been overridden by credit officers or risk managers since the models last validation cycle. High override rates may indicate model weakness and trigger recalibration. Monitored under SR 11-7 model performance tracking.',
    `override_rate` DECIMAL(18,2) COMMENT 'Proportion of model outputs overridden (expressed as a decimal, e.g., 0.05 = 5%) during the current monitoring period. Calculated as override_count divided by total model applications. Threshold breaches trigger escalation to model risk committee.',
    `pd_estimation_approach` STRING COMMENT 'Indicates whether the PD model produces Point-in-Time (PIT) estimates reflecting current economic conditions, Through-the-Cycle (TTC) estimates reflecting long-run average conditions, or a Hybrid blend. Applicable only to PD model types. PIT is required for IFRS 9 ECL; TTC is used for Basel III regulatory capital.. Valid values are `Point-in-Time|Through-the-Cycle|Hybrid`',
    `pd_floor` DECIMAL(18,2) COMMENT 'Minimum PD floor applied to the models estimates as required by Basel III (e.g., 0.0003 = 0.03% for corporate exposures). Ensures that regulatory capital is not understated by overly optimistic PD estimates. Applicable to PD model types.',
    `rating_scale_type` STRING COMMENT 'Type of rating scale used by the IRB model to assign obligor or facility grades (e.g., Numeric 1–10, Alphanumeric AAA–D, Letter-Grade A–G). Determines how model outputs are mapped to PD/LGD/EAD estimates and reported in regulatory submissions.. Valid values are `Numeric|Alphanumeric|Letter-Grade`',
    `regulatory_approval_date` DATE COMMENT 'Date on which the prudential supervisor formally approved the IRB model for use in regulatory capital calculation. Null if approval has not yet been granted.',
    `regulatory_approval_status` STRING COMMENT 'Status of the models regulatory approval from the primary prudential supervisor (e.g., Federal Reserve, OCC, PRA, ECB). Approved models may be used for regulatory capital (RWA) calculation. Conditional approval may require remediation actions.. Valid values are `Approved|Conditional|Pending|Not-Submitted|Withdrawn`',
    `source_system_model_code` STRING COMMENT 'Native model identifier as recorded in the source risk management platform (e.g., SAS Risk Management or Moodys RiskAuthority model registry). Enables lineage tracing from the lakehouse silver layer back to the operational system of record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the IRB model record was most recently modified in the risk data platform. Supports change management, audit trail, and model governance documentation.',
    `use_in_ecl_calculation` BOOLEAN COMMENT 'Indicates whether this IRB model is currently used in the calculation of Expected Credit Loss (ECL) for IFRS 9 or CECL provisioning. True = in active ECL use; False = not currently used for provisioning.',
    `use_in_rwa_calculation` BOOLEAN COMMENT 'Indicates whether this IRB model is currently approved and actively used in the calculation of regulatory Risk-Weighted Assets (RWA) for capital adequacy reporting under Basel III. True = in active RWA use; False = not currently used for regulatory capital.',
    `validation_outcome` STRING COMMENT 'Outcome of the most recent independent model validation: Pass (model fit for purpose), Pass-with-Conditions (minor findings requiring remediation), Fail (material deficiencies identified), or In-Progress (validation underway). Drives model risk rating and remediation planning.. Valid values are `Pass|Pass-with-Conditions|Fail|In-Progress`',
    CONSTRAINT pk_irb_model PRIMARY KEY(`irb_model_id`)
) COMMENT 'Internal Ratings-Based (IRB) model master record and parameter repository for credit risk estimation. Captures model identifier, model type (PD/LGD/EAD/CCF), asset class, regulatory approval status, validation cycle, discriminatory power metrics (Gini, AUC), calibration metadata, and override history. For PD models, includes term structure data: point-in-time and through-the-cycle PD estimates by rating grade and time horizon, cumulative and marginal PDs, and macroeconomic conditioning variables. Supports Basel III IRB approval documentation, model governance under SR 11-7, and provides core inputs to ECL provisioning and RWA calculation.';

CREATE OR REPLACE TABLE `banking_ecm`.`risk`.`counterparty_rating` (
    `counterparty_rating_id` BIGINT COMMENT 'Unique surrogate identifier for the counterparty credit rating record in the risk data domain. Primary key for this entity.',
    `country_id` BIGINT COMMENT 'ISO 3166-1 alpha-3 country code representing the primary country of risk for this counterparty. Used for sovereign risk assessment, country limit management, and regulatory capital treatment under Basel III.',
    `currency_id` BIGINT COMMENT 'ISO 4217 three-letter currency code for the Exposure at Default (EAD) amount (e.g., USD, EUR, GBP).',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Counterparty credit ratings drive account opening approvals and ongoing monitoring for corporate deposit accounts. Credit risk teams assess counterparty risk for large depositors, particularly for uni',
    `employee_id` BIGINT COMMENT 'Reference to the credit analyst or rating committee member who approved or assigned this rating. Supports accountability, audit trail, and credit governance requirements.',
    `industry_code_id` BIGINT COMMENT 'Standard industry classification code for the counterpartys primary business sector (e.g., GICS, NAICS, SIC). Used for sector concentration risk analysis, portfolio segmentation, and credit policy limits.',
    `irb_model_id` BIGINT COMMENT 'Reference to the validated PD model used to derive the probability of default for this rating. Supports model risk management, model inventory tracking, and SR 11-7 compliance.',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Counterparty credit ratings are informed by KYC due diligence. KYC reviews validate counterparty information (financials, ownership, sanctions status) used in rating models. Banks link ratings to KYC ',
    `legal_entity_id` BIGINT COMMENT 'Reference to the specific legal entity within a counterparty group to which this rating applies, supporting group vs. entity-level rating differentiation.',
    `party_id` BIGINT COMMENT 'Reference to the counterparty, obligor, or issuer entity for whom this credit rating record applies. Links to the counterparty master record.',
    `analyst_override_flag` BOOLEAN COMMENT 'Indicates whether a credit analyst has manually overridden the model-generated rating. True = override applied. Overrides must be documented and approved per credit policy. Supports model performance monitoring and governance.',
    `asset_class` STRING COMMENT 'The Basel III regulatory asset class to which this counterparty is assigned for RWA calculation purposes. Determines the applicable risk weight function and capital treatment. [ENUM-REF-CANDIDATE: corporate|sovereign|bank|retail|equity|securitisation|specialised_lending|other — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this counterparty rating record was first created in the data platform. Supports audit trail, data lineage, and regulatory record-keeping requirements.',
    `default_date` DATE COMMENT 'The date on which the counterparty was classified as in default per the Basel III definition (CRR Article 178). Null if the counterparty has never defaulted. Used for LGD estimation and historical default analysis.',
    `default_flag` BOOLEAN COMMENT 'Indicates whether the counterparty is currently in a state of default as defined under Basel III (CRR Article 178). True = counterparty is in default. Triggers NPL classification, ECL Stage 3, and regulatory reporting.',
    `ead` DECIMAL(18,2) COMMENT 'The estimated Exposure at Default (EAD) for this counterparty at the time of rating, expressed in the reporting currency. Represents the total value at risk if the counterparty defaults. Used in RWA and ECL calculations.',
    `ecl_stage` STRING COMMENT 'The IFRS 9 / CECL impairment stage assigned to this counterparty: Stage 1 (performing, 12-month ECL), Stage 2 (significant increase in credit risk, lifetime ECL), Stage 3 (credit-impaired, lifetime ECL). Drives provisioning and financial reporting.. Valid values are `stage_1|stage_2|stage_3`',
    `effective_date` DATE COMMENT 'The date from which this rating record becomes effective for credit decisions, RWA calculation, and regulatory reporting purposes.',
    `expiry_date` DATE COMMENT 'The date on which this rating record expires and must be reviewed or renewed. Null for ratings with no defined expiry. Supports rating review cycle management.',
    `external_rating_date` DATE COMMENT 'The date of the most recent external agency rating action (S&P, Moodys, or Fitch). Used to assess the currency of external ratings for regulatory and credit purposes.',
    `fitch_rating` STRING COMMENT 'The most recent long-term issuer credit rating assigned by Fitch Ratings (e.g., AAA, A+, BBB-, BB). Used for external benchmark comparison, regulatory SA risk weight mapping, and credit underwriting.. Valid values are `^(AAA|AA+|AA|AA-|A+|A|A-|BBB+|BBB|BBB-|BB+|BB|BB-|B+|B|B-|CCC+|CCC|CCC-|CC|C|RD|D|NR|WR)$`',
    `lgd` DECIMAL(18,2) COMMENT 'The estimated Loss Given Default (LGD) for this counterparty or facility, expressed as a decimal (e.g., 0.45 = 45%). Represents the proportion of exposure expected to be lost if the counterparty defaults. Used in RWA and ECL calculations.',
    `moodys_rating` STRING COMMENT 'The most recent long-term issuer credit rating assigned by Moodys Investors Service (e.g., Aaa, Aa1, Baa2, Ba3). Used for external benchmark comparison, regulatory SA risk weight mapping, and credit underwriting.. Valid values are `^(Aaa|Aa1|Aa2|Aa3|A1|A2|A3|Baa1|Baa2|Baa3|Ba1|Ba2|Ba3|B1|B2|B3|Caa1|Caa2|Caa3|Ca|C|NR|WR)$`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this counterpartys credit rating. Supports credit review cycle governance and ensures ratings remain current.',
    `override_direction` STRING COMMENT 'Indicates whether the analyst override resulted in an upgrade or downgrade relative to the model-generated rating. Null if no override is in effect. Used for override tracking and model performance analysis.. Valid values are `upgrade|downgrade`',
    `override_reason` STRING COMMENT 'Free-text justification provided by the credit analyst for the rating override. Required when analyst_override_flag is True. Supports audit trail and credit governance review.',
    `pd` DECIMAL(18,2) COMMENT 'The estimated one-year Probability of Default (PD) associated with this internal rating grade, expressed as a decimal (e.g., 0.00250 = 0.25%). Core input to RWA calculation under the IRB approach and ECL computation under IFRS 9/CECL.',
    `prior_rating_code` STRING COMMENT 'The internal rating grade code assigned to this counterparty immediately prior to the current rating. Enables rating migration analysis and transition matrix construction for credit risk modelling.. Valid values are `^[A-Z0-9]{1,10}$`',
    `prior_rating_date` DATE COMMENT 'The date on which the prior internal rating grade was assigned. Used in conjunction with prior_rating_code to construct rating migration history and transition matrices.',
    `rating_approach` STRING COMMENT 'Regulatory capital approach under which this rating is used: Internal Ratings-Based (IRB), Standardized Approach (SA), Foundation IRB (FIRB), or Advanced IRB (AIRB). Determines RWA calculation methodology.. Valid values are `IRB|SA|FIRB|AIRB`',
    `rating_code` STRING COMMENT 'The internal credit rating grade code assigned to the counterparty under the banks Internal Ratings-Based (IRB) model (e.g., 1A, 2B, CG3). Represents the banks own assessment of creditworthiness.. Valid values are `^[A-Z0-9]{1,10}$`',
    `rating_committee_approval` BOOLEAN COMMENT 'Indicates whether this rating was reviewed and approved by a formal credit rating committee (as opposed to individual analyst approval). True = committee-approved. Required for large or complex exposures per credit policy.',
    `rating_date` DATE COMMENT 'The date on which the current internal credit rating was formally assigned or last affirmed by the credit analyst or rating committee. Represents the principal business event date for this rating record.',
    `rating_description` STRING COMMENT 'Human-readable description of the internal rating grade (e.g., Investment Grade — Strong, Sub-Investment Grade — Speculative). Provides qualitative context for the rating code.',
    `rating_methodology` STRING COMMENT 'The name or code of the credit rating methodology applied to derive this rating (e.g., Corporate Scorecard v3.2, Financial Institution Model v2.1, Sovereign Rating Framework). Supports model governance and audit trail.',
    `rating_model_version` STRING COMMENT 'The version identifier of the rating model or scorecard used to produce this rating (e.g., v3.2, 2024.1). Supports model lifecycle management, backtesting, and SR 11-7 model inventory compliance.. Valid values are `^[A-Za-z0-9._-]{1,30}$`',
    `rating_outlook` STRING COMMENT 'The rating outlook indicating the likely direction of the credit rating over the medium term (12–24 months). Applies to both internal and external ratings. Values: positive, stable, negative, developing.. Valid values are `positive|stable|negative|developing`',
    `rating_status` STRING COMMENT 'Current lifecycle status of the rating record. active indicates the rating is in force; under_review indicates a rating action is pending; withdrawn indicates the rating has been formally removed; override indicates an analyst override is in effect.. Valid values are `active|under_review|withdrawn|expired|override`',
    `rating_trigger_event` STRING COMMENT 'The business event that triggered this rating action or review. [ENUM-REF-CANDIDATE: annual_review|financial_update|covenant_breach|market_event|acquisition|analyst_initiated|regulatory_requirement|credit_deterioration|other — promote to reference product]',
    `rating_type` STRING COMMENT 'Classifies whether this rating applies to the obligor/counterparty as a whole, a specific facility, an issuer, or a specific debt issue. Determines the scope of the rating assignment.. Valid values are `obligor|facility|issuer|issue|counterparty`',
    `rwa_risk_weight` DECIMAL(18,2) COMMENT 'The regulatory risk weight percentage assigned to this counterparty under the applicable Basel III approach (IRB or SA), expressed as a decimal (e.g., 0.75 = 75%). Directly drives Risk-Weighted Assets (RWA) calculation for capital adequacy.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this rating record originated (e.g., MOODYS_RISKAUTH, SAS_RISK, LIQ_IQ). Supports data lineage, ETL reconciliation, and audit trail.. Valid values are `^[A-Z0-9_]{1,30}$`',
    `sp_rating` STRING COMMENT 'The most recent long-term issuer credit rating assigned by S&P Global Ratings (e.g., AAA, AA+, BBB-, BB). Used for external benchmark comparison, regulatory SA risk weight mapping, and credit underwriting.. Valid values are `^(AAA|AA+|AA|AA-|A+|A|A-|BBB+|BBB|BBB-|BB+|BB|BB-|B+|B|B-|CCC+|CCC|CCC-|CC|C|D|NR|WR)$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this counterparty rating record was last modified in the data platform. Supports change tracking, audit trail, and data quality monitoring.',
    `watch_status` STRING COMMENT 'Indicates whether the counterpartys rating is currently on a rating watch list, and the direction of the potential rating action. none indicates no active watch. Signals near-term rating change risk.. Valid values are `none|positive_watch|negative_watch|evolving_watch`',
    CONSTRAINT pk_counterparty_rating PRIMARY KEY(`counterparty_rating_id`)
) COMMENT 'Internal and external credit rating record for counterparties, obligors, and issuers. Captures internal rating grade, external agency ratings (S&P, Moodys, Fitch), rating outlook, watch status, PD mapping, rating migration history, rating methodology, analyst override flags, and regulatory risk weight mapping under CRR/Basel III. Supports credit underwriting and RWA calculation.';

CREATE OR REPLACE TABLE `banking_ecm`.`risk`.`stress_scenario` (
    `stress_scenario_id` BIGINT COMMENT 'Unique surrogate identifier for the stress testing scenario record in the risk data lakehouse. Primary key for the stress_scenario entity.',
    `primary_superseded_by_stress_scenario_id` BIGINT COMMENT 'Reference to the stress_scenario_id of the newer scenario that supersedes this record when approval_status = superseded. Enables scenario lineage tracking and version chain navigation for audit and regulatory review purposes.',
    `source_scenario_stress_scenario_id` BIGINT COMMENT 'The native identifier of this stress scenario in the originating source system (e.g., AxiomSL scenario ID, OneSumX scenario reference). Enables traceability from the lakehouse silver layer back to the operational system of record.',
    `stress_scenario_cfp_id` BIGINT COMMENT 'Foreign key linking to treasury.stress_scenario_cfp. Business justification: Risk stress scenarios reference treasury contingency funding plan stress scenarios for integrated liquidity stress testing required by CCAR/DFAST. Treasury CFP scenarios define liquidity shocks that r',
    `approval_date` DATE COMMENT 'The date on which the stress scenario was formally approved by the designated governance body (e.g., Risk Committee, ALCO, Board Risk Committee). Required for audit trail and model risk governance documentation.',
    `approval_status` STRING COMMENT 'Current lifecycle/workflow status of the stress scenario record. draft = under development; pending_review = submitted for governance review; approved = formally approved for use in stress runs; rejected = not approved; superseded = replaced by a newer version; archived = retired from active use.. Valid values are `draft|pending_review|approved|rejected|superseded|archived`',
    `approved_by` STRING COMMENT 'Name or identifier of the governance body or senior officer who formally approved the stress scenario (e.g., Board Risk Committee, ALCO, Chief Risk Officer). Supports model risk governance and regulatory audit requirements.',
    `cet1_floor_pct` DECIMAL(18,2) COMMENT 'The minimum CET1 capital ratio floor assumed or targeted under this stress scenario, expressed as a percentage. Used to assess whether the bank maintains adequate capital buffers above regulatory minimums (4.5% CET1 minimum under Basel III) throughout the stress horizon.',
    `cre_price_shock_pct` DECIMAL(18,2) COMMENT 'The peak-to-trough decline in commercial real estate prices assumed under this scenario, expressed as a percentage. Key driver for CRE loan portfolio stress testing, collateral valuation, and LTV-based ECL estimation under CECL/IFRS 9.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this stress scenario record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail, data lineage, and regulatory record-keeping requirements.',
    `credit_spread_shock_bps` DECIMAL(18,2) COMMENT 'The widening of corporate/sovereign credit spreads assumed under this scenario, expressed in basis points. Drives mark-to-market losses on bond portfolios, CVA stress, and CDS pricing in trading book stress tests under FRTB.',
    `effective_date` DATE COMMENT 'The date from which this stress scenario is effective and authorized for use in stress testing runs and regulatory submissions. Aligns with the start of the scenario projection horizon.',
    `equity_price_shock_pct` DECIMAL(18,2) COMMENT 'The percentage decline in broad equity market indices (e.g., S&P 500) assumed under this scenario (e.g., -50.00 for a 50% market decline). Drives mark-to-market losses on equity portfolios, CVA stress, and trading book VaR under FRTB.',
    `expiry_date` DATE COMMENT 'The date after which this stress scenario is no longer valid for use in new stress runs. Typically aligns with the end of the regulatory cycle or the scenario projection horizon end date. Null for open-ended internal scenarios.',
    `fx_shock_pct` DECIMAL(18,2) COMMENT 'The percentage depreciation or appreciation of the USD (or base currency) against major foreign currencies assumed under this scenario. Drives FX translation losses, cross-currency swap valuation, and international portfolio stress.',
    `gdp_growth_shock_pct` DECIMAL(18,2) COMMENT 'The peak-to-trough or annualized GDP growth rate shock applied under this scenario, expressed as a percentage (e.g., -8.50 for an 8.5% contraction). A key macroeconomic variable in CCAR/DFAST scenarios used to drive credit loss and revenue projections.',
    `geographic_scope` STRING COMMENT 'The geographic coverage of the stress scenario. global = worldwide macroeconomic shock; domestic = US-only scenario; regional = specific geographic region (e.g., Europe, Asia-Pacific); legal_entity_specific = applies to a specific legal entity or subsidiary.. Valid values are `global|domestic|regional|legal_entity_specific`',
    `hpi_shock_pct` DECIMAL(18,2) COMMENT 'The peak-to-trough decline in the House Price Index (HPI) assumed under this scenario, expressed as a percentage (e.g., -25.00 for a 25% decline). Critical for mortgage portfolio stress testing and LTV-based credit loss estimation.',
    `inflation_rate_shock_pct` DECIMAL(18,2) COMMENT 'The peak inflation rate (CPI/PCE) assumed under this scenario, expressed as a percentage. Used in real rate calculations, ALM stress testing, and cost-of-funds projections under CCAR/DFAST and ICAAP.',
    `is_board_approved` BOOLEAN COMMENT 'Indicates whether this stress scenario has been formally approved by the Board of Directors or Board Risk Committee (True). Required for CCAR capital plan submission and ICAAP documentation. Supports governance and audit trail requirements.',
    `is_regulatory_prescribed` BOOLEAN COMMENT 'Indicates whether this scenario was prescribed by a regulatory authority (True) or developed internally by the bank (False). Regulatory-prescribed scenarios (e.g., Fed CCAR scenarios) have mandatory use requirements and cannot be modified by the bank.',
    `is_reverse_stress` BOOLEAN COMMENT 'Indicates whether this scenario is a reverse stress test (True), i.e., a scenario designed to identify conditions that would cause the bank to fail or breach critical thresholds, working backwards from the outcome. Required under PRA SS3/13 and BCBS stress testing principles.',
    `lcr_floor_pct` DECIMAL(18,2) COMMENT 'The minimum Liquidity Coverage Ratio (LCR) floor assumed under this stress scenario, expressed as a percentage. Used in liquidity stress testing to assess whether the bank maintains sufficient high-quality liquid assets (HQLA) under the scenario conditions.',
    `legal_entity_scope` STRING COMMENT 'The legal entity or consolidated group to which this stress scenario applies (e.g., BHC Consolidated, Bank Subsidiary, Broker-Dealer). Supports multi-entity stress testing and regulatory reporting at the appropriate consolidation level.',
    `lgd_multiplier` DECIMAL(18,2) COMMENT 'The scalar multiplier applied to baseline Loss Given Default (LGD) estimates under this scenario to derive stressed LGD inputs for ECL/CECL and RWA stress calculations. Reflects collateral value deterioration and recovery rate compression under stress.',
    `line_of_business_scope` STRING COMMENT 'The line of business or portfolio segment to which this scenario applies (e.g., All LOBs, Commercial Lending, Trading Book, Retail Banking). Null or All LOBs indicates enterprise-wide applicability. Supports LOB-level stress attribution.',
    `long_term_rate_shock_bps` DECIMAL(18,2) COMMENT 'The shock to long-term interest rates (e.g., 10-year Treasury yield) applied under this scenario, expressed in basis points (BPS). Used in bond portfolio valuation, NII stress testing, and duration/convexity analysis under CCAR/DFAST.',
    `pd_multiplier` DECIMAL(18,2) COMMENT 'The scalar multiplier applied to baseline Probability of Default (PD) estimates under this scenario to derive stressed PD inputs for ECL/CECL calculations and RWA stress testing. A value of 2.50 means stressed PD = 2.5x baseline PD. Used in IRB model stress testing.',
    `regulatory_program` STRING COMMENT 'The regulatory or internal stress testing program under which this scenario is defined. CCAR = Comprehensive Capital Analysis and Review (Fed); DFAST = Dodd-Frank Act Stress Testing (OCC/Fed); ICAAP = Internal Capital Adequacy Assessment Process; EBA = European Banking Authority stress test; ILAAP = Internal Liquidity Adequacy Assessment Process; INTERNAL = bank-defined internal stress program; CECL = Current Expected Credit Losses scenario; IFRS9 = IFRS 9 forward-looking scenario. [ENUM-REF-CANDIDATE: CCAR|DFAST|ICAAP|EBA|ILAAP|INTERNAL|CECL|IFRS9 — 8 candidates stripped; promote to reference product]',
    `rwa_scalar` DECIMAL(18,2) COMMENT 'The scalar factor applied to baseline Risk-Weighted Assets (RWA) under this scenario to project stressed RWA for capital adequacy assessment. Used in CCAR/DFAST capital ratio projections and CET1 depletion analysis.',
    `scenario_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the stress scenario within the regulatory program or internal stress framework (e.g., CCAR-2024-SA, DFAST-2024-ADV, ICAAP-2024-BL). Used as the business key for cross-system referencing in AxiomSL/OneSumX.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `scenario_description` STRING COMMENT 'Narrative description of the macroeconomic and financial conditions assumed under the stress scenario, including the economic story, key assumptions, and the nature of the shock being modeled.',
    `scenario_horizon_quarters` STRING COMMENT 'The projection horizon of the stress scenario expressed in quarters. Standard CCAR/DFAST horizon is 9 quarters (13 quarters for certain programs). Determines the length of the macroeconomic variable path and the stress run projection period.',
    `scenario_name` STRING COMMENT 'Human-readable descriptive name of the stress scenario (e.g., 2024 CCAR Severely Adverse, 2024 DFAST Adverse, Internal Recession Scenario Q1-2024). Used in regulatory submissions, board presentations, and risk reporting.',
    `scenario_severity` STRING COMMENT 'Severity classification of the stress scenario per regulatory and internal taxonomy. baseline = expected/central economic path; adverse = moderate stress; severely_adverse = severe recession/crisis conditions; reverse_stress = scenario designed to cause failure; exploratory = ad-hoc sensitivity analysis.. Valid values are `baseline|adverse|severely_adverse|reverse_stress|exploratory`',
    `scenario_source` STRING COMMENT 'The originating authority or institution that published or defined the stress scenario. federal_reserve = Fed-prescribed CCAR/DFAST scenario; occ = OCC-prescribed scenario; eba = European Banking Authority; pra = Prudential Regulation Authority; internal = bank-developed scenario; imf = IMF FSAP scenario; bis = BIS/BCBS scenario. [ENUM-REF-CANDIDATE: federal_reserve|occ|fdic|eba|pra|internal|imf|bis — 8 candidates stripped; promote to reference product]',
    `scenario_type` STRING COMMENT 'Classification of the primary risk driver modeled in the scenario. macroeconomic = GDP/unemployment/inflation shocks; market_risk = interest rate/FX/equity shocks; credit_risk = credit spread/default rate shocks; liquidity = funding/liquidity stress; operational = operational risk events; combined = multi-risk-factor scenario; idiosyncratic = firm-specific stress. [ENUM-REF-CANDIDATE: macroeconomic|market_risk|credit_risk|liquidity|operational|combined|idiosyncratic — 7 candidates stripped; promote to reference product]',
    `scenario_vintage` STRING COMMENT 'The publication or reference vintage of the scenario, typically expressed as a year (e.g., 2024) or year-quarter (e.g., 2024Q1). Identifies the cycle in which the scenario was issued by the regulator or approved internally. Critical for tracking scenario evolution across CCAR/DFAST cycles.. Valid values are `^[0-9]{4}(Q[1-4])?$`',
    `short_term_rate_shock_bps` DECIMAL(18,2) COMMENT 'The shock to short-term interest rates (e.g., 3-month Treasury, Fed Funds Rate) applied under this scenario, expressed in basis points (BPS). Used in NII/NIM stress testing and ALM analysis. Positive = rate increase; negative = rate decrease.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this stress scenario record was sourced (e.g., AXIOMSL, ONESUMX, SAS_RISK, MOODYS_RA). Supports data lineage tracking and ETL reconciliation in the lakehouse.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `unemployment_rate_shock_pct` DECIMAL(18,2) COMMENT 'The peak unemployment rate assumed under this stress scenario, expressed as a percentage (e.g., 12.50 for 12.5% peak unemployment). A primary macroeconomic driver for consumer credit loss models in CCAR/DFAST stress testing.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this stress scenario record was most recently modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change detection, incremental ETL processing, and audit trail maintenance in the lakehouse.',
    `version_number` STRING COMMENT 'Sequential version number of the stress scenario, incremented each time the scenario parameters are materially revised. Version 1 = initial approved version. Supports scenario versioning, change management, and audit trail requirements under model risk governance.',
    CONSTRAINT pk_stress_scenario PRIMARY KEY(`stress_scenario_id`)
) COMMENT 'Stress testing scenario master record for CCAR, DFAST, ICAAP, and internal stress programs. Captures scenario name, regulatory program (CCAR/DFAST/EBA), scenario severity (baseline, adverse, severely adverse), macroeconomic variable shocks (GDP, unemployment, HPI, interest rates), scenario vintage, approval status, and linkage to stress run results. Sourced from AxiomSL/OneSumX regulatory reporting platform.';

CREATE OR REPLACE TABLE `banking_ecm`.`risk`.`stress_test_run` (
    `stress_test_run_id` BIGINT COMMENT 'Unique surrogate identifier for each stress test execution record. Primary key for the stress_test_run data product.',
    `alco_meeting_id` BIGINT COMMENT 'Foreign key linking to treasury.alco_meeting. Business justification: Stress test results are presented to ALCO meetings for capital action decisions, dividend policy, and balance sheet management. Regulatory requirement under Federal Reserve SR 12-7 and Dodd-Frank Act ',
    `currency_id` BIGINT COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this stress test run record (e.g., USD, EUR, GBP). All stressed financial metrics are expressed in this currency.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Stress test runs (CCAR/DFAST) are executed at legal entity or consolidated group level for regulatory submissions. Results must be attributed to specific legal entities for capital planning and regula',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Stress test results are reviewed during CCAR/DFAST exams. Examiners validate methodology, assumptions, and capital adequacy. Banks track which stress test runs were reviewed in each exam for documenta',
    `stress_scenario_id` BIGINT COMMENT 'Reference to the stress scenario definition applied in this run, identifying the macroeconomic or idiosyncratic shock parameters (e.g., severely adverse, adverse, baseline).',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time at which the stress test results were formally approved by the designated governance authority. Null if pending approval.',
    `approved_by` STRING COMMENT 'The name or identifier of the senior risk officer or governance body (e.g., ALCO, CRO) that approved the stress test results prior to regulatory submission or management reporting.',
    `as_of_date` DATE COMMENT 'The reference balance sheet date from which the stress test projects forward. All starting positions (exposures, capital, liquidity) are measured as of this date.',
    `capital_action_restriction_flag` BOOLEAN COMMENT 'Indicates whether this stress test result triggered restrictions on capital distributions (dividends, share buybacks) under the stress capital buffer framework or CCAR objection process.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stress test run record was first created in the system. Used for audit trail and data lineage tracking.',
    `executed_by` STRING COMMENT 'The name or system identifier of the team, user, or automated process that initiated and executed this stress test run. Used for governance and audit trail purposes.',
    `irb_approach_flag` BOOLEAN COMMENT 'Indicates whether the Internal Ratings-Based (IRB) approach was used for credit risk RWA calculation in this stress test run. If False, the Standardized Approach (SA) was applied.',
    `model_version` STRING COMMENT 'Version identifier of the risk model suite (PD/LGD/EAD, market risk, liquidity models) used to generate the stress test results. Critical for model governance, backtesting, and regulatory model validation.. Valid values are `^[A-Za-z0-9._-]{1,30}$`',
    `portfolio_scope_code` STRING COMMENT 'Code identifying the portfolio or sub-portfolio subjected to this stress test run (e.g., ENTERPRISE, COMMERCIAL_LENDING, TRADING_BOOK, RETAIL_MORTGAGE). Defines the boundary of exposure included.',
    `projection_end_date` DATE COMMENT 'The final date of the stress projection horizon, calculated as as_of_date plus the stress horizon. Defines the terminal point for all stressed capital and liquidity metrics.',
    `regulatory_outcome` STRING COMMENT 'The regulatory determination resulting from this stress test submission. no_objection and pass indicate capital plan approval; objection or fail require remediation. pending indicates awaiting regulatory response.. Valid values are `pass|conditional_pass|fail|objection|no_objection|pending`',
    `regulatory_program` STRING COMMENT 'The regulatory or internal program under which this stress test was conducted. CCAR (Comprehensive Capital Analysis and Review) and DFAST (Dodd-Frank Act Stress Testing) are US Fed programs; ICAAP/ILAAP are internal capital/liquidity adequacy processes; EBA_ST and PRA_ST are European programs. [ENUM-REF-CANDIDATE: CCAR|DFAST|ICAAP|ILAAP|EBA_ST|PRA_ST|INTERNAL — 7 candidates stripped; promote to reference product]',
    `run_code` STRING COMMENT 'Externally-known business identifier for this stress test execution, used in regulatory submissions and internal reporting (e.g., CCAR-2024-ADV-001). Unique within a submission cycle.. Valid values are `^[A-Z0-9_-]{4,50}$`',
    `run_notes` STRING COMMENT 'Free-text field for qualitative commentary on this stress test run, including methodology overrides, data quality issues, management adjustments, or explanations of material deviations from prior runs.',
    `run_status` STRING COMMENT 'Current lifecycle state of the stress test execution. draft indicates setup not finalized; in_progress indicates computation running; completed indicates results available; failed indicates execution error; submitted indicates filed with regulator; superseded indicates replaced by a rerun.. Valid values are `draft|in_progress|completed|failed|submitted|superseded`',
    `run_timestamp` TIMESTAMP COMMENT 'The date and time at which the stress test computation was initiated. This is the principal business event timestamp representing when the scenario was applied to the portfolio.',
    `run_type` STRING COMMENT 'Classification of the stress test run by its purpose. regulatory is a mandated submission run; internal is management-initiated; parallel is a shadow run alongside regulatory; ad_hoc is event-driven; restatement corrects a prior submission.. Valid values are `regulatory|internal|parallel|ad_hoc|restatement`',
    `scenario_name` STRING COMMENT 'Human-readable name of the stress scenario applied (e.g., Fed Severely Adverse 2024, Internal Adverse Scenario Q3-2024, COVID-19 Replay). Denormalized for reporting convenience.',
    `scenario_type` STRING COMMENT 'Classification of the stress scenario by severity or origin. baseline is the expected economic path; adverse and severely_adverse are Fed-prescribed CCAR/DFAST scenarios; internal is bank-designed; reverse identifies conditions that would cause failure; sensitivity tests single-factor shocks.. Valid values are `baseline|adverse|severely_adverse|internal|reverse|sensitivity`',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record that generated this stress test run (e.g., SAS_RISK_MGR, MOODYS_RISK_AUTH, AXIOMSL). Supports data lineage and reconciliation.',
    `stress_capital_buffer_pct` DECIMAL(18,2) COMMENT 'The stress capital buffer (SCB) requirement derived from this stress test run, expressed as a percentage. Calculated as the maximum decline in CET1 ratio under the severely adverse scenario, subject to a 2.5% floor.',
    `stress_horizon_quarters` STRING COMMENT 'The number of quarters over which the stress scenario is projected. Standard CCAR/DFAST horizon is 9 quarters; internal stress tests may use shorter or longer horizons.',
    `stressed_cet1_ratio` DECIMAL(18,2) COMMENT 'The minimum projected Common Equity Tier 1 (CET1) capital ratio under the stress scenario over the projection horizon, expressed as a percentage. Key regulatory output for CCAR/DFAST pass/fail determination. CET1 minimum regulatory threshold is 4.5% under Basel III.',
    `stressed_cva_amount` DECIMAL(18,2) COMMENT 'The projected Credit Valuation Adjustment (CVA) on OTC derivatives under the stress scenario, in reporting currency. Represents the market value of counterparty credit risk under stressed conditions.',
    `stressed_ecl_amount` DECIMAL(18,2) COMMENT 'Total Expected Credit Loss (ECL) projected under the stress scenario over the full horizon, in reporting currency. Represents cumulative credit impairment charges under CECL/IFRS 9 stressed conditions.',
    `stressed_lcr_ratio` DECIMAL(18,2) COMMENT 'The minimum projected Liquidity Coverage Ratio (LCR) under the stress scenario, expressed as a percentage. LCR measures the banks ability to survive a 30-day liquidity stress event. Regulatory minimum is 100% under Basel III.',
    `stressed_leverage_ratio` DECIMAL(18,2) COMMENT 'The minimum projected Tier 1 leverage ratio under the stress scenario, expressed as a percentage. Calculated as Tier 1 capital divided by average total consolidated assets. Regulatory minimum is 4% for bank holding companies.',
    `stressed_nii_impact_amount` DECIMAL(18,2) COMMENT 'The cumulative change in Net Interest Income (NII) projected under the stress scenario relative to the baseline over the horizon, in reporting currency. Negative values indicate NII compression under stress.',
    `stressed_nim_bps` DECIMAL(18,2) COMMENT 'The change in Net Interest Margin (NIM) under the stress scenario relative to baseline, expressed in basis points (BPS). Captures the spread compression effect of the stress scenario on the banks interest-earning assets.',
    `stressed_nsfr_ratio` DECIMAL(18,2) COMMENT 'The minimum projected Net Stable Funding Ratio (NSFR) under the stress scenario, expressed as a percentage. NSFR measures the banks stable funding relative to required stable funding over a one-year horizon. Regulatory minimum is 100% under Basel III.',
    `stressed_ppnr_amount` DECIMAL(18,2) COMMENT 'Cumulative Pre-Provision Net Revenue (PPNR) projected under the stress scenario over the full horizon, in reporting currency. PPNR is a key CCAR metric representing revenue before credit loss provisions.',
    `stressed_rwa_amount` DECIMAL(18,2) COMMENT 'Total Risk-Weighted Assets (RWA) projected under the stress scenario at the end of the horizon, in reporting currency. Encompasses credit RWA, market RWA, and operational RWA under stressed conditions.',
    `stressed_tier1_ratio` DECIMAL(18,2) COMMENT 'The minimum projected Tier 1 capital ratio under the stress scenario over the projection horizon, expressed as a percentage. Includes CET1 plus Additional Tier 1 instruments. Regulatory minimum is 6% under Basel III.',
    `stressed_total_capital_ratio` DECIMAL(18,2) COMMENT 'The minimum projected Total Capital ratio (Tier 1 + Tier 2) under the stress scenario over the projection horizon, expressed as a percentage. Regulatory minimum is 8% under Basel III.',
    `stressed_var_amount` DECIMAL(18,2) COMMENT 'The projected Value at Risk (VaR) for the trading book under the stress scenario, in reporting currency. Represents the maximum expected loss at a defined confidence level under stressed market conditions.',
    `submission_date` DATE COMMENT 'The date on which this stress test run was submitted to the relevant regulatory authority (e.g., Federal Reserve for CCAR/DFAST). Null if not yet submitted or if this is an internal run.',
    `submission_reference` STRING COMMENT 'The reference number or acknowledgement ID assigned by the regulatory authority upon receipt of the stress test submission (e.g., Federal Reserve submission tracking number). Null if not yet submitted.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this stress test run record was last modified, including status changes, result updates, or metadata corrections.',
    CONSTRAINT pk_stress_test_run PRIMARY KEY(`stress_test_run_id`)
) COMMENT 'Stress test execution record capturing results of a specific stress scenario applied to a portfolio or enterprise. Captures run date, scenario reference, portfolio scope, stressed capital ratios (CET1, Tier 1, Total Capital), stressed RWA, stressed ECL, stressed NII/NIM impact, LCR/NSFR impact, and regulatory submission metadata. Primary output for CCAR/DFAST regulatory submissions.';

CREATE OR REPLACE TABLE `banking_ecm`.`risk`.`liquidity_metric` (
    `liquidity_metric_id` BIGINT COMMENT 'Unique surrogate identifier for each daily liquidity risk measurement record. Primary key for the liquidity_metric data product in the risk domain.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: LCR/NSFR liquidity metrics are calculated and reported for specific accounting periods, aligned with financial close cycles and regulatory reporting calendars. Essential for period-based liquidity ris',
    `appetite_id` BIGINT COMMENT 'Foreign key linking to risk.appetite. Business justification: Liquidity metrics (LCR, NSFR) are monitored against risk appetite statements that define the banks tolerance for liquidity risk. The liquidity_metric table has regulatory minimums (lcr_regulatory_min',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Liquidity metrics measured at channel level for cash management (ATM network cash requirements, branch vault liquidity planning). Banks forecast channel-specific liquidity needs for operational effici',
    `currency_id` BIGINT COMMENT 'ISO 4217 three-letter currency code in which the liquidity metric amounts are denominated (e.g., USD, EUR, GBP). Supports multi-currency liquidity reporting.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity for which this liquidity metric record is calculated. Supports entity-level regulatory reporting to Fed, OCC, and PRA.',
    `liquidity_ratio_id` BIGINT COMMENT 'Foreign key linking to treasury.liquidity_ratio. Business justification: Risk monitoring references treasury-calculated LCR/NSFR ratios for limit monitoring, breach detection, and regulatory reporting. Risk appetite framework requires tracking actual treasury-calculated ra',
    `reporting_unit_legal_entity_id` BIGINT COMMENT 'Reference to the internal reporting unit or business line (e.g., retail banking, treasury, trading) for which the liquidity metric is computed. Supports ALCO sub-entity reporting.',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to risk.risk_limit. Business justification: Liquidity metrics (LCR, NSFR) are monitored against regulatory and internal risk limits. The liquidity_metric table has is_breach and breach_severity flags but no reference to the specific limit being',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Liquidity metrics are calculated under various stress scenarios (baseline, adverse, severely adverse). The liquidity_metric table has stress_scenario_code field which should be replaced by FK to stres',
    `alco_review_status` STRING COMMENT 'Status of the ALCO review process for this liquidity metric record. Tracks whether the metric has been reviewed, escalated for breach, or approved by the Asset-Liability Committee for regulatory submission.. Valid values are `PENDING|REVIEWED|ESCALATED|APPROVED`',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the liquidity metric record was formally approved by the ALCO or risk officer for regulatory submission or internal reporting. Supports governance and audit trail requirements.',
    `available_stable_funding_amount` DECIMAL(18,2) COMMENT 'Total Available Stable Funding (ASF) representing the portion of capital and liabilities expected to be reliable over a one-year horizon. Numerator of the NSFR ratio.',
    `breach_severity` STRING COMMENT 'Severity classification of a regulatory liquidity breach based on the magnitude of the shortfall relative to the minimum threshold. Drives escalation level and remediation response timeframe per the institutions liquidity contingency plan.. Valid values are `NONE|MINOR|MODERATE|SEVERE|CRITICAL`',
    `calculation_run_timestamp` TIMESTAMP COMMENT 'The date and time when the liquidity metric calculation was executed in the risk management platform. Supports audit trail, reprocessing identification, and T+1 regulatory submission deadlines.',
    `calculation_status` STRING COMMENT 'Current workflow status of the liquidity metric record indicating whether the calculation is preliminary, final, restated, under review, or approved for regulatory submission.. Valid values are `PRELIMINARY|FINAL|RESTATED|UNDER_REVIEW|APPROVED`',
    `central_bank_eligible_amount` DECIMAL(18,2) COMMENT 'Total value of assets eligible for central bank repo or discount window operations (e.g., Fed discount window, Bank of England repo). Represents the ultimate liquidity backstop available to the institution.',
    `comments` STRING COMMENT 'Free-text commentary provided by the risk officer or ALCO analyst explaining material movements, breaches, restatements, or methodology changes for this liquidity metric record. Supports regulatory examination and internal audit.',
    `committed_facility_outflow_amount` DECIMAL(18,2) COMMENT 'Expected cash outflows from drawdowns on committed credit and liquidity facilities extended to customers and counterparties over the 30-day LCR stress horizon. Includes undrawn revolving credit facilities.',
    `consolidation_scope` STRING COMMENT 'Indicates whether the liquidity metric is calculated on a solo (single legal entity), consolidated (group-wide), or sub-consolidated basis. Determines the perimeter of assets and liabilities included in LCR/NSFR calculations.. Valid values are `SOLO|CONSOLIDATED|SUB_CONSOLIDATED`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this liquidity metric record was first created in the data platform. Supports audit trail, data lineage, and Silver layer ingestion tracking.',
    `encumbered_assets_amount` DECIMAL(18,2) COMMENT 'Total value of assets pledged as collateral or otherwise encumbered (e.g., repo, covered bonds, central bank pledges) and therefore excluded from the HQLA buffer. Critical for accurate HQLA calculation.',
    `gross_cash_inflow_amount` DECIMAL(18,2) COMMENT 'Total expected gross cash inflows over the 30-day LCR stress horizon, capped at 75% of gross outflows per Basel III rules. Includes contractual loan repayments and securities maturities.',
    `gross_cash_outflow_amount` DECIMAL(18,2) COMMENT 'Total expected gross cash outflows over the 30-day LCR stress horizon before netting of inflows. Includes retail deposit runoff, wholesale funding outflows, and off-balance-sheet commitments.',
    `hqla_amount` DECIMAL(18,2) COMMENT 'Total stock of High Quality Liquid Assets (HQLA) after applicable haircuts, expressed in the reporting currency. Comprises Level 1, Level 2A, and Level 2B assets as defined under the Basel III LCR framework.',
    `hqla_level1_amount` DECIMAL(18,2) COMMENT 'Stock of Level 1 HQLA assets (e.g., central bank reserves, sovereign bonds with 0% risk weight) with no haircut applied. Highest quality component of the HQLA buffer.',
    `hqla_level2a_amount` DECIMAL(18,2) COMMENT 'Stock of Level 2A HQLA assets (e.g., agency MBS, covered bonds, sovereign bonds with 20% risk weight) subject to a 15% haircut. Capped at 40% of total HQLA.',
    `hqla_level2b_amount` DECIMAL(18,2) COMMENT 'Stock of Level 2B HQLA assets (e.g., non-agency RMBS, corporate bonds, equities) subject to haircuts of 25–50%. Capped at 15% of total HQLA.',
    `intraday_available_liquidity_amount` DECIMAL(18,2) COMMENT 'Total liquidity resources available intraday at the start of the business day, including central bank reserves, committed intraday credit facilities, and unencumbered liquid assets accessible within the day.',
    `intraday_peak_liquidity_amount` DECIMAL(18,2) COMMENT 'Maximum intraday liquidity requirement observed during the reporting day, representing the peak net cumulative position across all payment systems (RTGS, ACH, SWIFT). Supports intraday liquidity monitoring per BCBS monitoring tools.',
    `is_breach` BOOLEAN COMMENT 'Flag indicating whether the liquidity metric breaches the applicable regulatory minimum threshold (LCR < 100% or NSFR < 100%). Triggers escalation to ALCO and regulatory notification procedures.',
    `lcr_buffer_amount` DECIMAL(18,2) COMMENT 'Excess HQLA above the regulatory minimum LCR requirement, representing the institutions liquidity cushion. Calculated as HQLA minus (net cash outflows × regulatory minimum LCR). Used in ALCO reporting and internal liquidity stress testing.',
    `lcr_ratio` DECIMAL(18,2) COMMENT 'The Liquidity Coverage Ratio expressed as a decimal (e.g., 1.25 = 125%). Calculated as HQLA divided by total net cash outflows over a 30-day stress period. Regulatory minimum is 100% (1.00) under Basel III / Fed LCR Rule.',
    `lcr_regulatory_minimum` DECIMAL(18,2) COMMENT 'The applicable regulatory minimum LCR threshold for this entity as of the metric date (e.g., 1.00 for 100%). May vary by jurisdiction (Fed, OCC, PRA) and entity classification (GSIB, non-GSIB).',
    `liquidity_transfer_restriction` STRING COMMENT 'Indicates whether there are legal, regulatory, or operational restrictions on the transfer of liquidity between entities within the group (e.g., ring-fencing, local regulatory requirements). Affects consolidated vs. solo LCR/NSFR calculations.. Valid values are `NONE|PARTIAL|FULL`',
    `metric_date` DATE COMMENT 'The business date (as-of date) for which the liquidity metrics are calculated. Represents the daily snapshot date used for LCR, NSFR, and intraday liquidity reporting.',
    `metric_type` STRING COMMENT 'Classification of the liquidity metric record indicating which regulatory or internal liquidity measure is captured. Values: LCR (Liquidity Coverage Ratio), NSFR (Net Stable Funding Ratio), INTRADAY (intraday liquidity position), SURVIVAL_HORIZON, STRESS (internal stress test metric).. Valid values are `LCR|NSFR|INTRADAY|SURVIVAL_HORIZON|STRESS`',
    `net_cash_outflow_amount` DECIMAL(18,2) COMMENT 'Total net cash outflows over the 30-calendar-day stress period, calculated as total expected cash outflows minus the minimum of total expected cash inflows and 75% of total expected cash outflows. Denominator of the LCR ratio.',
    `nsfr_ratio` DECIMAL(18,2) COMMENT 'The Net Stable Funding Ratio expressed as a decimal (e.g., 1.10 = 110%). Calculated as Available Stable Funding (ASF) divided by Required Stable Funding (RSF). Regulatory minimum is 100% (1.00) under Basel III.',
    `nsfr_regulatory_minimum` DECIMAL(18,2) COMMENT 'The applicable regulatory minimum NSFR threshold for this entity as of the metric date (e.g., 1.00 for 100%). Supports compliance monitoring against Fed/OCC/EBA NSFR rules.',
    `regulatory_jurisdiction` STRING COMMENT 'The regulatory jurisdiction under which this liquidity metric is reported (e.g., US for Fed/OCC, UK for PRA, EU for EBA). Determines applicable minimum thresholds and reporting templates.. Valid values are `US|UK|EU|OTHER`',
    `reporting_frequency` STRING COMMENT 'Frequency at which this liquidity metric is calculated and reported. Daily for LCR/intraday; monthly or quarterly for NSFR and internal stress metrics. Drives scheduling in the regulatory reporting platform.. Valid values are `DAILY|WEEKLY|MONTHLY|QUARTERLY`',
    `required_stable_funding_amount` DECIMAL(18,2) COMMENT 'Total Required Stable Funding (RSF) representing the amount of stable funding required to support assets and off-balance-sheet exposures over a one-year horizon. Denominator of the NSFR ratio.',
    `retail_deposit_outflow_amount` DECIMAL(18,2) COMMENT 'Expected cash outflows from retail deposits (stable and less stable) over the 30-day LCR stress horizon, applying Basel III run-off rates (3–10% for stable, 10–15% for less stable deposits).',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this liquidity metric data was sourced (e.g., SAS_RISK, MOODYS_RA, AXIOMSL, ONESUMX). Supports data lineage and audit trail requirements.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `survival_horizon_days` STRING COMMENT 'The number of calendar days the institution can survive under a combined idiosyncratic and market-wide stress scenario without accessing wholesale funding markets. Key internal liquidity risk metric reported to ALCO.',
    `unencumbered_assets_amount` DECIMAL(18,2) COMMENT 'Total value of assets that are free from legal, regulatory, or contractual restrictions and available to be monetized or pledged as collateral. Supports HQLA eligibility assessment.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this liquidity metric record was last modified in the data platform. Tracks restatements, corrections, and ALCO-driven adjustments to liquidity metric values.',
    `version_number` STRING COMMENT 'Sequential version number of the liquidity metric record, incremented on each restatement or correction. Enables tracking of preliminary vs. final vs. restated submissions for regulatory audit purposes.',
    `wholesale_funding_outflow_amount` DECIMAL(18,2) COMMENT 'Expected cash outflows from wholesale funding sources (e.g., interbank deposits, commercial paper, repo) over the 30-day LCR stress horizon. Key component of gross cash outflow calculation.',
    CONSTRAINT pk_liquidity_metric PRIMARY KEY(`liquidity_metric_id`)
) COMMENT 'Daily liquidity risk measurement record capturing LCR (Liquidity Coverage Ratio), NSFR (Net Stable Funding Ratio), intraday liquidity positions, survival horizon, HQLA (High Quality Liquid Assets) buffer, net cash outflows, and available stable funding. Supports ALCO reporting, regulatory LCR/NSFR submissions to Fed/OCC/PRA, and internal liquidity stress testing.';

CREATE OR REPLACE TABLE `banking_ecm`.`risk`.`operational_risk_event` (
    `operational_risk_event_id` BIGINT COMMENT 'Unique surrogate identifier for the operational risk loss event or near-miss incident record within the enterprise internal loss database. Primary key for the silver-layer data product.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Operational risk events (outages, fraud, process failures) must track the affected channel for root cause analysis, regulatory reporting, and remediation. Banks report operational losses by channel. R',
    `employee_id` BIGINT COMMENT 'Employee identifier of the risk manager or senior officer who reviewed and approved the operational risk event record, including the loss amount, root cause classification, and corrective action plan. Required for SOX and regulatory audit trail.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to risk.risk_assessment. Business justification: Operational risk events are often identified through RCSA (Risk and Control Self-Assessment) processes. The risk_assessment table captures RCSA records; operational_risk_event captures actual loss eve',
    `breach_id` BIGINT COMMENT 'Foreign key linking to compliance.breach. Business justification: Operational losses often constitute compliance breaches (BSA/AML violations, Reg E failures). Linking supports MRA tracking, consent order remediation, and regulatory reporting where operational risk ',
    `country_id` BIGINT COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction where the operational risk event occurred. Used for geographic risk concentration analysis and cross-border regulatory reporting.',
    `currency_id` BIGINT COMMENT 'ISO 4217 three-letter currency code in which the gross loss, recovery, and net loss amounts are denominated (e.g., USD, EUR, GBP). Required for multi-currency consolidation and FX translation to reporting currency.',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Operational loss events (fraud, processing errors, unauthorized transactions) are tracked by affected account for root cause analysis and loss attribution. Operational risk reporting requires account-',
    `exam_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.exam_finding. Business justification: Regulatory exams identify operational risk events as findings requiring remediation. Banks track which operational losses were cited in exam findings to demonstrate remediation progress and prevent re',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Operational loss events are recorded against specific legal entities for Basel AMA/SMA capital calculations, regulatory loss data reporting, and financial statement loss provisions. Legal_entity_code ',
    `primary_operational_event_owner_employee_id` BIGINT COMMENT 'Employee identifier of the risk event owner responsible for managing the investigation, root cause analysis, corrective action, and closure of the operational risk event. Sourced from the Human Capital Management System (Workday/SAP SuccessFactors).',
    `accounting_date` DATE COMMENT 'The date on which the operational risk loss was recognized in the general ledger and financial statements. Used for IFRS 9 / CECL provisioning alignment and financial reporting reconciliation.',
    `affected_product_line` STRING COMMENT 'The specific banking product or service line affected by the operational risk event (e.g., Mortgage Lending, FX Trading, ACH Payments, Wealth Management, Trade Finance). Used for product-level risk attribution and LOB reporting.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the operational risk event record was formally reviewed and approved by the designated risk manager or senior officer. Supports audit trail and governance requirements.',
    `basel_event_type_category` STRING COMMENT 'Basel III Level 1 operational risk event type category classification. Values: internal_fraud (Internal Fraud), external_fraud (External Fraud), epws (Employment Practices and Workplace Safety), cpbp (Clients Products and Business Practices), edpm (Execution Delivery and Process Management), bdsf (Business Disruption and System Failures), eflf (Damage to Physical Assets). Mandatory for SMA capital charge calculation and regulatory reporting. [ENUM-REF-CANDIDATE: internal_fraud|external_fraud|epws|cpbp|edpm|bdsf|eflf — 7 candidates stripped; promote to reference product]',
    `basel_event_type_level2` STRING COMMENT 'Basel III Level 2 sub-category providing granular classification within the Level 1 event type (e.g., Unauthorized Activity under Internal Fraud, Theft and Fraud under External Fraud, Suitability Disclosure and Fiduciary under CPBP). Supports detailed root cause analysis and trend reporting. [ENUM-REF-CANDIDATE: promote to reference product aligned with BCBS Annex 9 taxonomy]',
    `business_line_code` STRING COMMENT 'Basel III-defined business line classification code for the organizational unit where the operational risk event occurred. Standard Basel business lines include Corporate Finance, Trading and Sales, Retail Banking, Commercial Banking, Payment and Settlement, Agency Services, Asset Management, and Retail Brokerage. [ENUM-REF-CANDIDATE: corporate_finance|trading_and_sales|retail_banking|commercial_banking|payment_and_settlement|agency_services|asset_management|retail_brokerage — promote to reference product]',
    `causal_factor_code` STRING COMMENT 'Standardized code from the enterprise causal factor taxonomy identifying the specific contributing factor(s) to the operational risk event (e.g., inadequate segregation of duties, system configuration error, third-party vendor failure, inadequate staff training). Used for trend analysis and KRI calibration.',
    `ccar_dfast_applicable_indicator` BOOLEAN COMMENT 'Flag indicating whether this operational risk event is included in the operational risk loss scenario library used for CCAR and DFAST stress testing submissions to the Federal Reserve. Supports capital adequacy assessment under stressed conditions.',
    `control_failure_type` STRING COMMENT 'Classification of the internal control failure that contributed to the operational risk event. design_failure indicates the control was inadequately designed; operating_failure indicates the control existed but did not operate effectively; no_control indicates absence of a required control; override indicates management override of controls; circumvention indicates deliberate bypass of controls.. Valid values are `design_failure|operating_failure|no_control|override|circumvention`',
    `corrective_action_due_date` DATE COMMENT 'Target completion date for the corrective action plan associated with this operational risk event. Used for management escalation tracking and regulatory examination readiness.',
    `corrective_action_status` STRING COMMENT 'Status of the corrective action plan (CAP) initiated in response to the operational risk event to remediate the identified control failure. not_required for near-miss events with no control gap; planned for CAP defined but not started; in_progress for active remediation; completed for fully remediated; overdue for past target completion date.. Valid values are `not_required|planned|in_progress|completed|overdue`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the operational risk event record was first captured and persisted in the GRC platform or internal loss database. Used for audit trail and data lineage tracking.',
    `discovery_date` DATE COMMENT 'The date on which the operational risk event was first identified or discovered by the bank, which may differ significantly from the event date for latent losses. Used to measure detection lag and assess control effectiveness.',
    `event_date` DATE COMMENT 'The date on which the operational risk loss event actually occurred or commenced. This is the principal real-world event date used for SMA capital charge period allocation and regulatory reporting. Distinct from discovery date and accounting date.',
    `event_description` STRING COMMENT 'Detailed narrative description of the operational risk event, including what happened, how it was identified, and the immediate impact. Supports root cause analysis, regulatory examination responses, and internal audit reviews.',
    `event_reference_number` STRING COMMENT 'Externally-known, human-readable unique reference number assigned to the operational risk event by the GRC platform or internal loss database (e.g., ORE-2024-00123). Used for cross-system reconciliation and regulatory reporting submissions to OCC/Fed/PRA.',
    `event_status` STRING COMMENT 'Current lifecycle status of the operational risk event record. open indicates active loss event under investigation; under_review indicates root cause analysis in progress; closed indicates fully resolved and signed off; near_miss indicates no financial loss but control failure identified; pending_recovery indicates awaiting insurance or third-party recovery.. Valid values are `open|under_review|closed|near_miss|pending_recovery`',
    `event_title` STRING COMMENT 'Short, descriptive title summarizing the nature of the operational risk event (e.g., Unauthorized Wire Transfer — Treasury Operations, System Outage — Payment Processing Hub). Used for management reporting and GRC dashboard display.',
    `external_loss_database_reference` STRING COMMENT 'Reference identifier linking this internal loss event to a corresponding record in an external operational risk loss data consortium (e.g., ORX — Operational Riskdata eXchange Association). Supports benchmarking of internal loss experience against industry peers.',
    `gross_loss_amount` DECIMAL(18,2) COMMENT 'Total gross financial loss incurred from the operational risk event before any recoveries, expressed in the reporting currency. This is the primary input to the SMA capital charge calculation and must meet the BCBS minimum loss threshold for regulatory reporting (typically USD 20,000 for internal data collection).',
    `insurance_recovery_amount` DECIMAL(18,2) COMMENT 'Portion of the total recovery amount attributable specifically to insurance policy payouts (e.g., fidelity bond, professional indemnity, cyber insurance). Tracked separately per BCBS guidance on insurance recognition in operational risk capital.',
    `legal_action_status` STRING COMMENT 'Status of any legal proceedings or litigation associated with the operational risk event. none indicates no legal action; threatened indicates potential litigation notified; filed indicates lawsuit filed; settled indicates out-of-court settlement reached; judgment indicates court judgment rendered; dismissed indicates case dismissed.. Valid values are `none|threatened|filed|settled|judgment|dismissed`',
    `legal_provision_amount` DECIMAL(18,2) COMMENT 'Financial provision or reserve established in the general ledger for potential legal liability arising from the operational risk event. Recognized per IFRS IAS 37 or FASB ASC 450 when outflow is probable and estimable.',
    `loss_recovery_date` DATE COMMENT 'Date on which the recovery amount was received or recognized, whether from insurance, legal settlement, or third-party reimbursement. Used for cash flow timing analysis and SMA recovery component allocation.',
    `loss_threshold_met_indicator` BOOLEAN COMMENT 'Flag indicating whether the gross loss amount meets or exceeds the minimum loss data threshold (typically USD 20,000 per BCBS guidance) required for inclusion in the SMA Loss Component calculation and external loss data consortium submissions.',
    `near_miss_indicator` BOOLEAN COMMENT 'Flag indicating whether this record represents a near-miss incident (potential loss that was averted) rather than an actual realized loss event. Near-miss events have zero gross loss but are captured for control environment assessment and KRI monitoring.',
    `net_loss_amount` DECIMAL(18,2) COMMENT 'Net financial loss after deducting all recoveries from the gross loss amount (gross_loss_amount minus recovery_amount). This is the final economic impact figure used for P&L attribution, RAROC calculation, and management reporting.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Total amount recovered from all sources (insurance, legal settlements, third-party reimbursements, collateral liquidation) following the operational risk loss event. Subtracted from gross loss to derive net loss.',
    `regulatory_report_reference` STRING COMMENT 'Reference number or identifier of the regulatory report or notification filed with the relevant supervisory authority (OCC, Fed, PRA) in connection with this operational risk event. Populated only when regulatory_reportable_indicator is true.',
    `regulatory_reportable_indicator` BOOLEAN COMMENT 'Flag indicating whether this operational risk event meets the threshold or criteria requiring mandatory regulatory reporting to OCC, Federal Reserve, PRA, or other supervisory authorities (e.g., significant operational events, cyber incidents, large losses).',
    `root_cause_category` STRING COMMENT 'High-level root cause classification of the operational risk event following root cause analysis (RCA). Standard taxonomy: people (human error, misconduct, inadequate training), process (process failure, inadequate controls, procedural breach), system (IT system failure, data quality, cybersecurity), external_event (natural disaster, third-party failure, fraud by external party).. Valid values are `people|process|system|external_event`',
    `root_cause_description` STRING COMMENT 'Detailed narrative of the root cause analysis findings, identifying the specific underlying cause(s) of the operational risk event. Supports corrective action planning, control remediation, and regulatory examination responses.',
    `sma_loss_component` STRING COMMENT 'Classification of how this event contributes to the SMA capital charge calculation under Basel III. loss_component indicates the event feeds the Loss Component (LC) of the SMA formula; recovery_component indicates a recovery adjustment; timing_adjustment indicates a multi-year loss requiring temporal allocation per BCBS guidance.. Valid values are `loss_component|recovery_component|timing_adjustment`',
    `source_system_code` STRING COMMENT 'Code identifying the originating operational system from which this loss event record was sourced (e.g., MOODYS_RISK_AUTHORITY, SAS_RISK_MGMT, GRC_PLATFORM, MANUAL_ENTRY). Used for data lineage tracking and ETL reconciliation in the Databricks lakehouse.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the operational risk event record, including updates to loss amounts, recovery amounts, root cause classification, or status changes. Supports audit trail requirements.',
    CONSTRAINT pk_operational_risk_event PRIMARY KEY(`operational_risk_event_id`)
) COMMENT 'Operational risk loss event record capturing actual losses and near-miss incidents across the enterprise. Captures event date, discovery date, Basel event type category (internal fraud, external fraud, EPWS, CPBP, EDPM, BDSF, EFLF), affected business line, gross loss amount, recovery amount, net loss, root cause analysis, causal factors, control failure classification, insurance recovery, and legal/regulatory action status. Feeds SMA capital charge calculation and supports regulatory reporting to OCC/Fed/PRA. Sourced from GRC platform and internal loss database.';

CREATE OR REPLACE TABLE `banking_ecm`.`risk`.`kri_measurement` (
    `kri_measurement_id` BIGINT COMMENT 'Unique surrogate identifier for each KRI measurement record in the enterprise risk monitoring registry. Primary key for the kri_measurement data product.',
    `appetite_id` BIGINT COMMENT 'Reference to the risk appetite statement from which the KRI thresholds (green/amber/red) were derived. Links this measurement to the governing risk appetite framework entry for threshold lineage and governance audit.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Key Risk Indicators are measured per channel (ATM downtime %, digital fraud rate, branch error rate). Channel-level KRI monitoring is standard in banking risk management for operational risk oversight',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: KRIs track account-level risk metrics (dormancy rates, fraud incident rates, AML alert rates by account type). Risk dashboard reporting aggregates metrics by account segment for board reporting and ea',
    `liquidity_position_id` BIGINT COMMENT 'Foreign key linking to treasury.liquidity_position. Business justification: KRIs monitor specific liquidity position metrics for early warning indicators in risk appetite framework. Liquidity KRIs track intraday positions, tenor gaps, and scenario-based positions for breach d',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to risk.risk_limit. Business justification: KRI measurements track against defined thresholds and limits. The kri_measurement table has green/amber/red thresholds and breach_status — these are operationally linked to risk_limit definitions for ',
    `actual_value` DECIMAL(18,2) COMMENT 'The observed or calculated numeric value of the KRI for the measurement period. Represents the raw measurement result before threshold comparison (e.g., NPL ratio of 0.0325, LCR of 1.42, VaR of 15000000). Unit of measure is defined in the unit_of_measure field.',
    `amber_threshold` DECIMAL(18,2) COMMENT 'The boundary defining the warning (amber) zone for the KRI. Values breaching this threshold trigger heightened monitoring and management attention but do not yet require board-level escalation. Derived from the risk appetite framework.',
    `approval_status` STRING COMMENT 'Workflow status of the KRI measurement record through the review and approval process. draft indicates initial capture, submitted indicates pending review, approved indicates sign-off by risk governance, rejected indicates the measurement requires correction and resubmission.. Valid values are `draft|submitted|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time at which the KRI measurement record was formally approved by the risk governance officer. Provides the audit timestamp for SOX and regulatory compliance purposes.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the risk governance officer who approved this KRI measurement record. Required for SOX and regulatory audit trail. Classified confidential as it identifies internal personnel.',
    `breach_status` STRING COMMENT 'The RAG (Red-Amber-Green) status of the KRI measurement relative to defined thresholds. green indicates within appetite, amber indicates warning zone, red indicates limit breach. Drives escalation workflows and board risk committee reporting.. Valid values are `green|amber|red`',
    `calculation_methodology` STRING COMMENT 'Description of the methodology or formula used to calculate the KRI value (e.g., HQLA / Net Cash Outflows over 30 days, NPL balance / Total Gross Loans, 99th percentile 10-day VaR using historical simulation). Supports model governance and audit requirements.',
    `commentary` STRING COMMENT 'Free-text narrative commentary provided by the KRI owner explaining the measurement result, contextualising any threshold breaches, or noting exceptional circumstances affecting the value (e.g., market dislocation, one-off events, methodology changes).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this KRI measurement record was first created in the system. Provides the audit creation timestamp for data lineage, BCBS 239 compliance, and silver layer ingestion tracking.',
    `data_quality_flag` STRING COMMENT 'Categorical data quality assessment for this KRI measurement record. passed indicates data meets quality standards, warning indicates minor data issues that do not invalidate the measurement, failed indicates the measurement should not be used, under_review indicates quality assessment is pending.. Valid values are `passed|warning|failed|under_review`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'A numeric score (0.00 to 100.00) representing the assessed quality of the underlying data used to compute this KRI measurement. Supports BCBS 239 data quality attestation requirements and flags measurements with low data confidence for review.',
    `data_source_system` STRING COMMENT 'The operational system of record from which the KRI measurement data was sourced (e.g., SAS Risk Management, Moodys RiskAuthority, Murex, Core Banking T24, AxiomSL). Critical for data lineage and BCBS 239 data quality attestation.',
    `escalation_authority` STRING COMMENT 'The governance body or individual to whom the KRI breach has been escalated (e.g., ALCO, Board Risk Committee, CRO, Risk Management Committee). Defines the escalation path for each breach severity level.',
    `escalation_date` DATE COMMENT 'The date on which the KRI breach was formally escalated to the designated escalation authority. Null if no escalation was required. Used to measure escalation timeliness against SLA targets.',
    `escalation_status` STRING COMMENT 'Current status of the escalation workflow triggered by a KRI breach. not_required for green-status KRIs, pending when escalation has been initiated but not yet actioned, in_progress when remediation is underway, resolved when breach is remediated, overdue when SLA has been breached.. Valid values are `not_required|pending|in_progress|resolved|overdue`',
    `green_threshold` DECIMAL(18,2) COMMENT 'The upper or lower boundary defining the acceptable (green) zone for the KRI. Values within this threshold indicate normal operating conditions and no escalation is required. Derived from the risk appetite framework.',
    `is_board_reported` BOOLEAN COMMENT 'Indicates whether this KRI is included in board risk committee reporting packs (True) or is management-level only (False). Board-reported KRIs require higher data quality standards and formal sign-off per governance policy.',
    `is_regulatory_kri` BOOLEAN COMMENT 'Indicates whether this KRI is mandated by a regulatory body (True) or is an internally-defined management KRI (False). Regulatory KRIs (e.g., LCR, CET1, NSFR) require formal regulatory reporting and have prescribed minimum thresholds.',
    `kri_code` STRING COMMENT 'Unique business identifier for the KRI definition in the enterprise KRI taxonomy. Follows the format KRI-<CATEGORY>-<SEQUENCE> (e.g., KRI-CREDIT-0001). Links the measurement to the KRI master registry entry.. Valid values are `^KRI-[A-Z]{2,10}-[0-9]{4}$`',
    `kri_name` STRING COMMENT 'Human-readable name of the KRI being measured (e.g., Non-Performing Loan Ratio, Liquidity Coverage Ratio, Value at Risk Utilisation). Sourced from the KRI master registry.',
    `kri_owner_name` STRING COMMENT 'Full name of the individual accountable for the KRI measurement, remediation, and escalation. Typically a senior risk officer or business unit head. Classified confidential as it identifies internal accountability assignments.',
    `kri_owner_role` STRING COMMENT 'The job title or role designation of the KRI owner (e.g., Chief Risk Officer, Head of Credit Risk, Treasury Risk Manager). Supports role-based escalation routing and governance reporting.',
    `legal_entity` STRING COMMENT 'The legal entity or subsidiary to which this KRI measurement applies. Supports legal-entity-level risk aggregation required for CCAR, DFAST, and regulatory reporting submissions (e.g., Banking Corp USA, Banking Corp UK Branch).',
    `measurement_date` DATE COMMENT 'The business date on which the KRI value was observed or calculated. Represents the as-of date for the measurement, distinct from the record creation timestamp. Critical for time-series trend analysis and regulatory reporting periods.',
    `measurement_frequency` STRING COMMENT 'The prescribed frequency at which this KRI is measured and reported. Determines the cadence of data collection and dashboard refresh cycles (e.g., LCR is measured daily, NSFR monthly, ICAAP KRIs quarterly).. Valid values are `daily|weekly|monthly|quarterly|annually`',
    `measurement_period_end` DATE COMMENT 'The end date of the measurement period over which the KRI value was calculated. For point-in-time KRIs this equals measurement_date; for flow-based KRIs this defines the close of the accumulation window.',
    `measurement_period_start` DATE COMMENT 'The start date of the measurement period over which the KRI value was calculated. For point-in-time KRIs this equals measurement_date; for flow-based KRIs (e.g., monthly loss events) this defines the beginning of the accumulation window.',
    `owning_business_unit` STRING COMMENT 'The line of business (LOB) or organisational unit responsible for managing and remediating this KRI (e.g., Commercial Lending, Treasury, Retail Banking, Trading). Used for accountability assignment in GRC reporting and board risk committee packs.',
    `prior_period_value` DECIMAL(18,2) COMMENT 'The KRI actual value from the immediately preceding measurement period. Stored on the record to support period-over-period variance analysis and trend computation without requiring a self-join. Expressed in the same unit_of_measure as actual_value.',
    `red_threshold` DECIMAL(18,2) COMMENT 'The boundary defining the breach (red) zone for the KRI. Values exceeding this threshold indicate a material risk limit breach requiring immediate escalation to senior management or the board risk committee.',
    `regulatory_framework` STRING COMMENT 'The regulatory framework or standard to which this KRI is aligned (e.g., Basel III, CCAR, DFAST, IFRS 9, FRTB, Dodd-Frank). Enables regulatory-specific filtering and reporting in AxiomSL / OneSumX submissions.',
    `remediation_action` STRING COMMENT 'Free-text description of the management action plan or remediation steps being taken to address a KRI breach or amber warning. Captured for audit trail and board risk committee reporting purposes.',
    `remediation_due_date` DATE COMMENT 'The target date by which the remediation action for a KRI breach must be completed. Used to track SLA compliance and flag overdue escalations in GRC dashboards.',
    `risk_category` STRING COMMENT 'High-level risk taxonomy category to which this KRI belongs. Aligns with the enterprise risk taxonomy and Basel III risk classification framework. [ENUM-REF-CANDIDATE: credit|market|liquidity|operational|compliance|reputational|strategic — promote to reference product]',
    `risk_sub_category` STRING COMMENT 'Granular risk sub-classification within the risk category (e.g., counterparty credit risk, interest rate risk in the banking book, settlement risk, conduct risk). Supports drill-down analysis in GRC reporting.',
    `stress_scenario_flag` BOOLEAN COMMENT 'Indicates whether this measurement record represents a stress scenario value (True) rather than a base-case actual measurement (False). Stress scenario KRI readings are used in CCAR, DFAST, and ICAAP submissions.',
    `stress_scenario_name` STRING COMMENT 'Name of the stress scenario applied when stress_scenario_flag is True (e.g., Fed Severely Adverse, Fed Adverse, Internal Baseline, COVID-19 Stress). Null for base-case actual measurements.',
    `threshold_direction` STRING COMMENT 'Indicates the directionality of the KRI thresholds. higher_is_worse means increasing values are adverse (e.g., NPL ratio, VaR). lower_is_worse means decreasing values are adverse (e.g., LCR, CET1 ratio). range_bound means both extremes are adverse.. Valid values are `higher_is_worse|lower_is_worse|range_bound`',
    `trend_direction` STRING COMMENT 'The directional trend of the KRI value relative to the prior measurement period. improving indicates movement toward lower risk, deteriorating indicates movement toward higher risk, stable indicates no material change. Used for forward-looking risk dashboard indicators.. Valid values are `improving|stable|deteriorating`',
    `unit_of_measure` STRING COMMENT 'The unit in which the KRI actual value is expressed (e.g., percentage, basis_points, USD, ratio, count, days). Ensures correct interpretation of the actual_value field across heterogeneous KRI types.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this KRI measurement record was most recently modified. Supports change tracking, data lineage audits, and incremental ETL processing in the Databricks Lakehouse silver layer.',
    CONSTRAINT pk_kri_measurement PRIMARY KEY(`kri_measurement_id`)
) COMMENT 'Key Risk Indicator (KRI) master registry and periodic measurement record. Captures KRI definitions (name, risk category, calculation methodology, measurement frequency, data source, green/amber/red thresholds, owner, escalation path) and periodic readings (measurement date, actual value, threshold breach status, trend direction, owning business unit, escalation status). Links to risk appetite framework for threshold derivation. Provides the authoritative KRI taxonomy and monitoring data for enterprise risk dashboards, GRC reporting, and board risk committee oversight.';

CREATE OR REPLACE TABLE `banking_ecm`.`risk`.`model_validation` (
    `model_validation_id` BIGINT COMMENT 'Unique surrogate identifier for each model validation record in the risk domain. Primary key for the model_validation data product.',
    `employee_id` BIGINT COMMENT 'Reference to the lead independent model validator (employee or third-party specialist) responsible for conducting and signing off the validation. Must be independent of model development per SR 11-7.',
    `irb_model_id` BIGINT COMMENT 'Reference to the risk model under validation (e.g., IRB PD model, VaR model, ECL model, CVA model). Links to the model inventory record.',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Model validations are reviewed during regulatory exams per SR 11-7 and OCC guidance. Examiners assess validation independence, frequency, and findings. Banks track which validations were reviewed in e',
    `valuation_model_id` BIGINT COMMENT 'Foreign key linking to risk.valuation_model. Business justification: Model validation applies to all risk models, including valuation models used for fair value measurement. Currently model_validation only links to irb_model, but valuation models also require independe',
    `asset_class` STRING COMMENT 'Asset class to which the model under validation applies. Determines applicable regulatory capital framework and validation benchmarks. [ENUM-REF-CANDIDATE: corporate|retail|sovereign|financial_institution|securitisation|equity|commodity|fx|rates|structured_credit|other — promote to reference product]',
    `backtesting_exceptions_count` STRING COMMENT 'Number of days (for VaR) or observations (for IRB/ECL) where actual losses or outcomes exceeded model predictions during the backtesting observation window. Directly drives the traffic light classification.',
    `backtesting_result` STRING COMMENT 'Traffic light outcome of backtesting under the Basel/FRTB framework: green (0–4 exceptions, model acceptable), amber (5–9 exceptions, supervisory scrutiny), red (10+ exceptions, model presumed inadequate). Applicable primarily to VaR and IRB models.. Valid values are `green|amber|red`',
    `benchmarking_outcome` STRING COMMENT 'Outcome of benchmarking the models outputs against alternative models, industry benchmarks, or regulatory reference models. Indicates whether the model is consistent with, more conservative than, or more aggressive than benchmarks.. Valid values are `consistent|conservative|aggressive|inconclusive`',
    `conceptual_soundness_rating` STRING COMMENT 'Rating for the conceptual soundness component of the validation, assessing whether the models theoretical basis, assumptions, and mathematical framework are appropriate for its intended use.. Valid values are `satisfactory|needs_improvement|unsatisfactory`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this model validation record was first created in the system. Supports audit trail and data lineage requirements under BCBS 239 and SOX.',
    `data_quality_rating` STRING COMMENT 'Rating for the data quality and integrity component of the validation, assessing whether input data is accurate, complete, representative, and appropriate for the models intended use.. Valid values are `satisfactory|needs_improvement|unsatisfactory`',
    `is_regulatory_capital_model` BOOLEAN COMMENT 'Indicates whether the model is used in the calculation of regulatory capital requirements (RWA, CET1). Models flagged true are subject to heightened validation standards and mandatory regulatory approval under Basel III IRB.',
    `kupiec_test_result` STRING COMMENT 'Result of the Kupiec Proportion of Failures (POF) statistical test for VaR model accuracy. Tests whether the observed exception rate is statistically consistent with the models confidence level (e.g., 99% VaR).. Valid values are `pass|fail|inconclusive`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this model validation record. Used for change tracking, data lineage, and ensuring currency of validation status in regulatory reporting.',
    `legal_entity` STRING COMMENT 'Legal entity within the banking group for which the model is approved and validated. Relevant for cross-border regulatory compliance (e.g., Fed approval for US entity, PRA approval for UK subsidiary).',
    `line_of_business` STRING COMMENT 'Line of Business (LOB) for which the model is used (e.g., Retail Mortgage, Corporate Lending, Trading — Rates, Wealth Management). Supports LOB-level model risk aggregation and RAROC attribution.',
    `materiality_assessment` STRING COMMENT 'Assessment of whether identified model limitations and findings are material to the banks financial position, capital adequacy, or regulatory compliance. Drives escalation to ALCO, Board Risk Committee, and regulators.. Valid values are `material|non_material|potentially_material`',
    `model_limitations_summary` STRING COMMENT 'Narrative summary of key model limitations identified during validation, including known weaknesses in assumptions, data gaps, out-of-sample performance concerns, and boundary conditions where the model should not be applied.',
    `model_version` STRING COMMENT 'Version identifier of the model under validation at the time of this validation engagement (e.g., 3.2.1). Critical for change management and ensuring validation findings are tied to the correct model version.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `mra_count` STRING COMMENT 'Number of Matters Requiring Attention (MRAs) identified during the validation. MRAs are significant findings that require corrective action but do not immediately impair model use. Key metric for regulatory examination readiness.',
    `mria_count` STRING COMMENT 'Number of Matters Requiring Immediate Attention (MRIAs) identified during the validation. MRIAs are critical findings that may require immediate suspension or restriction of model use pending remediation.',
    `next_validation_due_date` DATE COMMENT 'Scheduled date for the next periodic validation of this model, determined by the models risk tier, regulatory requirements, and any conditions imposed in this validation cycle.',
    `observation_window_end_date` DATE COMMENT 'End date of the historical data observation window used for backtesting and performance testing. Defines the data cut-off for performance metrics reported in this validation.',
    `observation_window_start_date` DATE COMMENT 'Start date of the historical data observation window used for backtesting and performance testing in this validation. For VaR models, typically 250 trading days; for IRB models, minimum 5–7 years per Basel III.',
    `overall_outcome` STRING COMMENT 'Final determination of the validation engagement: approved (model fit for purpose), approved_with_conditions (model usable subject to remediation), rejected (model not approved for use), or deferred (decision pending additional information).. Valid values are `approved|approved_with_conditions|rejected|deferred`',
    `overall_rating` STRING COMMENT 'Qualitative rating assigned to the model following validation, reflecting aggregate assessment of conceptual soundness, data quality, and performance. Aligns with supervisory rating scales used in Fed/OCC examinations.. Valid values are `satisfactory|needs_improvement|unsatisfactory`',
    `performance_rating` STRING COMMENT 'Rating for the ongoing performance monitoring component, assessing whether the model produces accurate and stable outputs relative to observed outcomes (backtesting, benchmarking, sensitivity analysis).. Valid values are `satisfactory|needs_improvement|unsatisfactory`',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory approval for models requiring supervisory sign-off (e.g., IRB models under Basel III, CCAR/DFAST models under Fed supervision). Tracks whether the regulator has approved, conditionally approved, or rejected the model.. Valid values are `not_required|pending|approved|rejected|conditional`',
    `regulatory_framework` STRING COMMENT 'Primary regulatory framework governing the model under validation. Determines mandatory validation requirements, documentation standards, and supervisory expectations. [ENUM-REF-CANDIDATE: Basel_III_IRB|FRTB|IFRS9|CECL|CCAR|DFAST|SA_CCR|SMA|ICAAP|IRRBB|other — promote to reference product]',
    `regulatory_submission_date` DATE COMMENT 'Date on which the model validation report or model approval application was submitted to the relevant regulator (Fed, OCC, PRA, EBA). Null if regulatory submission is not required.',
    `remediation_deadline` DATE COMMENT 'Agreed deadline by which all MRA/MRIA findings must be remediated and evidence of closure submitted to the independent validation function. Monitored by model risk governance and reported to the Board Risk Committee.',
    `remediation_status` STRING COMMENT 'Current status of remediation activities for findings identified in this validation. Overdue status triggers escalation to senior management and regulatory notification where required.. Valid values are `not_started|in_progress|completed|overdue`',
    `report_issued_date` DATE COMMENT 'Date the final model validation report was formally issued to model owners, senior management, and risk governance committees. May differ from validation_end_date if report drafting extends beyond fieldwork.',
    `scope_description` STRING COMMENT 'Narrative description of the validation scope, including model components reviewed (conceptual soundness, data quality, performance testing, implementation), portfolios covered, and any explicit out-of-scope items.',
    `sensitivity_analysis_outcome` STRING COMMENT 'Summary outcome of sensitivity and stress testing of model inputs and assumptions. Indicates whether model outputs are stable under parameter perturbations or exhibit material sensitivity to key assumptions.. Valid values are `stable|moderately_sensitive|highly_sensitive`',
    `total_findings_count` STRING COMMENT 'Total number of findings (MRAs, MRIAs, observations, and recommendations) identified across all validation components. Used for trend analysis and model risk appetite monitoring.',
    `use_approval_status` STRING COMMENT 'Current approval status for model use following validation: approved (unrestricted use), restricted (use permitted within defined constraints), suspended (use temporarily halted pending remediation), prohibited (model must not be used).. Valid values are `approved|restricted|suspended|prohibited`',
    `use_restrictions` STRING COMMENT 'Narrative description of any restrictions placed on model use as a condition of approval (e.g., Apply conservative overlay of +15 bps to PD estimates, Limit use to portfolios with LTV < 80%, Not approved for CCAR submission without additional benchmarking).',
    `validation_code` STRING COMMENT 'Externally-known business identifier for the validation engagement, used in regulatory submissions, audit trails, and correspondence with examiners (e.g., MV-IRBPD-2024). Unique across all validation cycles.. Valid values are `^MV-[A-Z0-9]{4,12}-[0-9]{4}$`',
    `validation_end_date` DATE COMMENT 'Date on which the validation engagement was formally completed and the validation report issued. Null if still in progress.',
    `validation_start_date` DATE COMMENT 'Date on which the independent model validation engagement formally commenced. Used to measure validation cycle duration and SLA compliance.',
    `validation_status` STRING COMMENT 'Current lifecycle state of the validation engagement. Drives workflow routing, escalation, and regulatory reporting readiness.. Valid values are `planned|in_progress|completed|suspended|cancelled`',
    `validation_team` STRING COMMENT 'Name or identifier of the independent model validation team or unit conducting the review (e.g., Model Risk Management — Credit Risk Team, External Validator: Moodys Analytics).',
    `validation_type` STRING COMMENT 'Nature of the validation engagement: initial (first-time validation of a new model), periodic (scheduled annual/biennial review), triggered (event-driven review due to material change, performance deterioration, or regulatory finding), pre-implementation, or post-implementation.. Valid values are `initial|periodic|triggered|pre_implementation|post_implementation`',
    CONSTRAINT pk_model_validation PRIMARY KEY(`model_validation_id`)
) COMMENT 'Independent model validation record for all risk models including IRB (PD/LGD/EAD), VaR, CVA, ECL, stress testing, and pricing models. Captures validation date, model under review, validation type (initial/periodic/triggered), scope, backtesting results (traffic light approach, Kupiec test), benchmarking outcomes, sensitivity analysis, identified model limitations, materiality assessment, MRA/MRIA findings, remediation requirements and deadlines, and regulatory approval status. Core artifact for SR 11-7 / SS1/23 model risk governance and OCC/Fed examination readiness.';

CREATE OR REPLACE TABLE `banking_ecm`.`risk`.`assessment` (
    `assessment_id` BIGINT COMMENT 'Unique surrogate identifier for the risk assessment record. Primary key for the risk_assessment data product in the enterprise risk management lakehouse.',
    `appetite_id` BIGINT COMMENT 'Foreign key linking to risk.risk_appetite. Business justification: Risk assessments evaluate residual risk against the enterprise risk appetite framework. The risk_assessment table has residual_risk_rating and residual_risk_score — these are compared to risk_appetite',
    `employee_id` BIGINT COMMENT 'Identifier of the senior risk officer or governance body representative who formally approved the risk assessment findings and ratings. Required for ICAAP, ORSA, and board risk committee reporting.',
    `assessment_assessor_employee_id` BIGINT COMMENT 'Identifier of the individual who performed or facilitated the risk assessment. Supports accountability tracking, assessor independence validation, and audit trail requirements.',
    `assessment_employee_id` BIGINT COMMENT 'Identifier of the individual or role designated as the accountable risk owner responsible for managing and monitoring the assessed risk. Supports escalation routing and risk ownership reporting to the board risk committee.',
    `exam_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.exam_finding. Business justification: Risk assessments are performed in response to exam findings to evaluate control effectiveness and residual risk. Banks document which risk assessments address specific exam findings to demonstrate rem',
    `action_plan` STRING COMMENT 'Documented plan of remediation actions to address identified control gaps or elevated risk ratings. Includes action steps, responsible parties, and target completion dates. Tracked in the GRC platform for management information reporting.',
    `approval_date` DATE COMMENT 'Date on which the risk assessment was formally approved by the designated approver. Marks the transition from under_review to approved status and triggers downstream reporting and action plan activation.',
    `assessment_code` STRING COMMENT 'Externally-known business identifier for the assessment, used in GRC platform references, board risk committee reports, and regulatory submissions. Format: RA-{CATEGORY}-{YEAR}-{SEQUENCE}.. Valid values are `^RA-[A-Z]{2,10}-[0-9]{4}-[0-9]{6}$`',
    `assessment_date` DATE COMMENT 'The principal business event date on which the risk assessment was conducted or formally initiated. Used as the reference date for inherent risk and control effectiveness ratings.',
    `assessment_status` STRING COMMENT 'Current lifecycle state of the risk assessment record within the GRC workflow. Drives escalation, approval routing, and reporting eligibility.. Valid values are `draft|in_progress|under_review|approved|closed|cancelled`',
    `assessment_type` STRING COMMENT 'Discriminator identifying the methodology and scope of the assessment. enterprise_risk_assessment covers holistic enterprise-wide evaluations; rcsa denotes Risk and Control Self-Assessment; thematic_review covers targeted deep-dives; icaap aligns with Internal Capital Adequacy Assessment Process; orsa aligns with Own Risk and Solvency Assessment.. Valid values are `enterprise_risk_assessment|rcsa|thematic_review|icaap|orsa`',
    `control_description` STRING COMMENT 'Narrative description of the key control(s) in place to mitigate the identified risk. Captures control design, automation level, and frequency of operation. Used in RCSA documentation and internal audit evidence packages.',
    `control_effectiveness_rating` STRING COMMENT 'Assessment of how effectively the existing controls mitigate the identified inherent risk. Derived from control design adequacy and operating effectiveness testing. Drives residual risk calculation and remediation prioritization.. Valid values are `strong|adequate|needs_improvement|inadequate`',
    `control_type` STRING COMMENT 'Classification of the primary control mechanism associated with the assessed risk. preventive controls stop risk events from occurring; detective controls identify events after occurrence; corrective controls remediate impact; directive controls establish required behaviors.. Valid values are `preventive|detective|corrective|directive`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk assessment record was first captured in the GRC platform or risk management system. Supports audit trail and data lineage requirements.',
    `findings_summary` STRING COMMENT 'Narrative summary of key findings identified during the risk assessment, including control gaps, risk drivers, and significant observations. Used in board risk committee packs, ICAAP documentation, and regulatory examination responses.',
    `impact_rating` STRING COMMENT 'Qualitative assessment of the severity of financial, operational, reputational, or regulatory impact if the risk event materializes. Combined with likelihood to derive the inherent risk score.. Valid values are `negligible|minor|moderate|major|catastrophic`',
    `inherent_risk_rating` STRING COMMENT 'Risk rating reflecting the gross level of risk before considering the effect of controls. Assessed based on likelihood and impact of the risk materializing in the absence of mitigating controls. Core input to the risk appetite framework and ICAAP capital assessment.. Valid values are `low|medium|high|critical`',
    `is_material_risk` BOOLEAN COMMENT 'Flag indicating whether the assessed risk has been classified as material under the enterprise risk appetite framework or ICAAP materiality assessment. Material risks receive enhanced monitoring, board-level reporting, and dedicated capital allocation consideration.',
    `is_regulatory_finding` BOOLEAN COMMENT 'Flag indicating whether this risk assessment was initiated or escalated as a result of a regulatory examination finding, Matters Requiring Attention (MRA), or supervisory letter. Drives priority handling and regulatory response tracking.',
    `kri_code` STRING COMMENT 'Code referencing the Key Risk Indicator (KRI) associated with this risk assessment. Links the assessment to the quantitative KRI monitoring framework for threshold breach tracking and early warning signal generation.. Valid values are `^KRI-[A-Z0-9]{2,15}$`',
    `last_test_date` DATE COMMENT 'Date on which the most recent formal test of the associated control was completed. Used to assess control currency, identify overdue testing, and support internal audit scheduling.',
    `legal_entity_code` STRING COMMENT 'Code identifying the legal entity within the banking group to which this risk assessment applies. Supports legal entity-level risk aggregation, regulatory reporting (CCAR, DFAST, ICAAP), and resolution planning.. Valid values are `^[A-Z0-9]{1,20}$`',
    `likelihood_rating` STRING COMMENT 'Qualitative assessment of the probability that the identified risk event will materialize within the assessment horizon. Combined with impact rating to derive the inherent risk score on the risk heat map.. Valid values are `rare|unlikely|possible|likely|almost_certain`',
    `line_of_business` STRING COMMENT 'The business line or division to which the assessed risk is attributed (e.g., retail_banking, commercial_lending, investment_banking, wealth_management, treasury). Used for LOB-level risk aggregation and CCAR/DFAST capital allocation. [ENUM-REF-CANDIDATE: retail_banking|commercial_lending|investment_banking|wealth_management|treasury|asset_management|payments|corporate_trust — promote to reference product]',
    `methodology` STRING COMMENT 'Methodology applied to conduct the risk assessment. qualitative relies on expert judgment; quantitative uses statistical models (e.g., VaR, ECL); hybrid combines both; scenario_analysis applies stress scenarios; loss_data_analysis uses historical loss event data.. Valid values are `qualitative|quantitative|hybrid|scenario_analysis|loss_data_analysis`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or reassessment of this risk assessment record. Ensures timely refresh of risk ratings and control effectiveness in line with the risk appetite framework review cycle.',
    `process_name` STRING COMMENT 'Name of the business process or activity being assessed, primarily used in RCSA assessments (e.g., Loan Origination, Trade Settlement, AML Transaction Monitoring). Provides process-level granularity for operational risk management.',
    `regulatory_framework` STRING COMMENT 'Regulatory or supervisory framework under which this assessment is conducted or reported (e.g., Basel_III, CCAR, DFAST, ICAAP, ORSA, SOX, FATCA). Enables regulatory-specific filtering and submission mapping. [ENUM-REF-CANDIDATE: Basel_III|CCAR|DFAST|ICAAP|ORSA|SOX|FATCA|CRS|FRTB|CECL — promote to reference product]',
    `remediation_due_date` DATE COMMENT 'Target date by which all remediation actions in the action plan must be completed. Used for tracking overdue items, escalation triggers, and regulatory commitment management.',
    `remediation_status` STRING COMMENT 'Current status of the remediation action plan associated with this risk assessment. Drives escalation workflows, management reporting, and regulatory commitment tracking in the GRC platform.. Valid values are `not_started|in_progress|completed|overdue|deferred`',
    `residual_risk_rating` STRING COMMENT 'Net risk rating after accounting for the effectiveness of existing controls. Represents the remaining risk exposure and is the primary metric for risk appetite comparison and escalation decisions.. Valid values are `low|medium|high|critical`',
    `residual_risk_score` DECIMAL(18,2) COMMENT 'Quantitative residual risk score (typically on a 1–25 or 1–100 scale) derived from the product of likelihood and impact ratings after control adjustment. Used for risk heat map positioning and quantitative risk aggregation in the GRC platform.',
    `risk_category` STRING COMMENT 'Primary risk taxonomy classification for the assessment. Aligns with the enterprise risk appetite framework and Basel III/IV risk category definitions. Drives routing to the appropriate risk owner and regulatory capital treatment.. Valid values are `credit_risk|market_risk|operational_risk|liquidity_risk|compliance_risk|reputational_risk`',
    `risk_event_type` STRING COMMENT 'Basel II/III operational risk event type classification applicable primarily to RCSA assessments. Maps to the seven Basel operational risk event categories used in Standardized Measurement Approach (SMA) capital calculations. [ENUM-REF-CANDIDATE: internal_fraud|external_fraud|employment_practices|clients_products_business|damage_physical_assets|business_disruption|execution_delivery — 7 candidates stripped; promote to reference product]',
    `risk_owner_name` STRING COMMENT 'Full name of the designated risk owner accountable for the assessed risk. Retained as a denormalized field for reporting and audit trail purposes independent of HR system changes.',
    `risk_sub_category` STRING COMMENT 'Granular risk classification within the primary risk category (e.g., fraud_risk, model_risk, settlement_risk, concentration_risk, interest_rate_risk_in_banking_book). Supports detailed risk taxonomy reporting and KRI alignment. [ENUM-REF-CANDIDATE: fraud_risk|model_risk|settlement_risk|concentration_risk|irrbb|cyber_risk|third_party_risk|conduct_risk — promote to reference product]',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this risk assessment record originated (e.g., SAS_RISK_MGMT, MOODYS_RISK_AUTH, AXIOMSL, MANUAL_GRC). Supports data lineage, ETL reconciliation, and BCBS239 data quality reporting.. Valid values are `^[A-Z0-9_]{2,30}$`',
    `testing_frequency` STRING COMMENT 'Frequency at which the effectiveness of the identified control is formally tested. Drives the control testing schedule in the GRC platform and informs the assurance calendar for internal audit and compliance functions.. Valid values are `continuous|daily|weekly|monthly|quarterly|annually`',
    `three_lines_defence_layer` STRING COMMENT 'Identifies which line of defence conducted or is responsible for this risk assessment. first_line is the business unit; second_line is risk management or compliance; third_line is internal audit. Supports governance framework reporting and assurance mapping.. Valid values are `first_line|second_line|third_line`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the risk assessment record. Used for change tracking, version control, and audit compliance.',
    `version_number` STRING COMMENT 'Sequential version number of the risk assessment record, incremented each time the assessment is formally revised and re-approved. Supports version history tracking, audit trail, and supersession management in the GRC platform.',
    CONSTRAINT pk_assessment PRIMARY KEY(`assessment_id`)
) COMMENT 'Enterprise risk assessment and Risk and Control Self-Assessment (RCSA) record capturing periodic and event-driven evaluations across all risk categories. Assessment type (enterprise_risk_assessment, rcsa, thematic_review) distinguishes evaluation methodology. For enterprise assessments: captures assessment date, risk category, inherent risk rating, control effectiveness, residual risk rating, risk owner, methodology, findings, and action plan. For RCSAs: captures process name, risk event type, control description, control type (preventive/detective), control effectiveness rating, residual risk score, testing frequency, last test date, and remediation plan. Supports ICAAP, ORSA, board risk committee reporting, operational risk management framework, and GRC platform integration.';

CREATE OR REPLACE TABLE `banking_ecm`.`risk`.`scenario_result` (
    `scenario_result_id` BIGINT COMMENT 'Unique identifier for the scenario result record. Primary key.',
    `currency_id` BIGINT COMMENT 'Three-letter ISO currency code for all monetary amounts in this result.',
    `employee_id` BIGINT COMMENT 'User identifier of the individual who approved this scenario result for submission or reporting.',
    `factor_id` BIGINT COMMENT 'Foreign key linking to risk.risk_factor. Business justification: Stress test results are decomposed by risk factor to show which factors drive capital impact. The scenario_result table has risk_factor_code field which should be replaced by FK to risk_factor. N:1 re',
    `irb_model_id` BIGINT COMMENT 'Foreign key linking to risk.irb_model. Business justification: Stress scenario results for credit portfolios use IRB models to project stressed PD, LGD, EAD, and RWA under scenario conditions. The scenario_result table has stressed_rwa_amount, stressed_ecl_amount',
    `stress_scenario_id` BIGINT COMMENT 'Reference to the stress scenario applied in this result.',
    `stress_test_run_id` BIGINT COMMENT 'Reference to the parent stress test run that generated this result.',
    `previous_scenario_result_id` BIGINT COMMENT 'Self-referencing FK on scenario_result (previous_scenario_result_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this scenario result was approved.',
    `asset_class` STRING COMMENT 'The asset class category to which this scenario result applies. [ENUM-REF-CANDIDATE: equity|fixed_income|credit|commodity|fx|real_estate|loan|derivative|other — 9 candidates stripped; promote to reference product]',
    `breach_flag` BOOLEAN COMMENT 'Indicates whether this scenario result breaches a regulatory minimum or internal risk appetite threshold.',
    `breach_severity` STRING COMMENT 'Severity classification of any threshold breach identified in this result.. Valid values are `none|minor|moderate|major|critical`',
    `calculation_methodology` STRING COMMENT 'Description of the calculation methodology or approach used to derive this result (e.g., Monte Carlo, historical simulation, parametric).',
    `calculation_timestamp` TIMESTAMP COMMENT 'Date and time when the scenario result was calculated by the risk engine.',
    `capital_impact_amount` DECIMAL(18,2) COMMENT 'The net impact on regulatory capital resulting from this scenario result.',
    `confidence_level_pct` DECIMAL(18,2) COMMENT 'The statistical confidence level used in the calculation, expressed as a percentage (e.g., 99.0 for 99% confidence).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this scenario result record was first created in the system.',
    `legal_entity_code` STRING COMMENT 'Code identifying the legal entity to which this scenario result applies.',
    `line_of_business` STRING COMMENT 'The line of business segment (e.g., retail banking, investment banking, wealth management) to which this result applies.',
    `model_version` STRING COMMENT 'Version identifier of the risk model used to calculate this scenario result.',
    `portfolio_scope_code` STRING COMMENT 'Code identifying the portfolio segment or scope to which this result applies (e.g., retail lending, trading book, corporate loan portfolio).',
    `projection_date` DATE COMMENT 'The specific date within the stress test horizon to which this result applies.',
    `projection_quarter` STRING COMMENT 'The quarter number within the stress test horizon to which this result applies (e.g., 1 for Q1, 9 for nine-quarter horizon).',
    `regulatory_program` STRING COMMENT 'The regulatory stress testing program under which this result was generated (e.g., CCAR, DFAST, EBA, ICAAP).',
    `result_reference_number` STRING COMMENT 'Business identifier for the scenario result, used for external reporting and audit trails.',
    `result_status` STRING COMMENT 'Current lifecycle status of the scenario result record.. Valid values are `draft|calculated|validated|approved|submitted|rejected`',
    `source_system_code` STRING COMMENT 'Code identifying the source risk management system that generated this scenario result (e.g., SAS, Moodys RiskAuthority).',
    `stressed_cet1_ratio` DECIMAL(18,2) COMMENT 'The projected Common Equity Tier 1 capital ratio under the stress scenario, expressed as a percentage.',
    `stressed_cva_amount` DECIMAL(18,2) COMMENT 'The projected Credit Valuation Adjustment under the stress scenario.',
    `stressed_ecl_amount` DECIMAL(18,2) COMMENT 'The projected Expected Credit Loss under the stress scenario.',
    `stressed_lcr_ratio` DECIMAL(18,2) COMMENT 'The projected Liquidity Coverage Ratio under the stress scenario, expressed as a percentage.',
    `stressed_leverage_ratio` DECIMAL(18,2) COMMENT 'The projected leverage ratio under the stress scenario, expressed as a percentage.',
    `stressed_loss_amount` DECIMAL(18,2) COMMENT 'The projected loss amount under the stress scenario for this portfolio or risk factor.',
    `stressed_nii_amount` DECIMAL(18,2) COMMENT 'The projected Net Interest Income under the stress scenario.',
    `stressed_nim_bps` STRING COMMENT 'The projected Net Interest Margin under the stress scenario, expressed in basis points.',
    `stressed_nsfr_ratio` DECIMAL(18,2) COMMENT 'The projected Net Stable Funding Ratio under the stress scenario, expressed as a percentage.',
    `stressed_ppnr_amount` DECIMAL(18,2) COMMENT 'The projected Pre-Provision Net Revenue under the stress scenario.',
    `stressed_provision_amount` DECIMAL(18,2) COMMENT 'The projected credit loss provision amount under the stress scenario.',
    `stressed_revenue_amount` DECIMAL(18,2) COMMENT 'The projected revenue amount under the stress scenario.',
    `stressed_rwa_amount` DECIMAL(18,2) COMMENT 'The projected risk-weighted assets amount under the stress scenario.',
    `stressed_tier1_ratio` DECIMAL(18,2) COMMENT 'The projected Tier 1 capital ratio under the stress scenario, expressed as a percentage.',
    `stressed_total_capital_ratio` DECIMAL(18,2) COMMENT 'The projected total capital ratio under the stress scenario, expressed as a percentage.',
    `stressed_var_amount` DECIMAL(18,2) COMMENT 'The projected Value at Risk under the stress scenario.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this scenario result record was last modified.',
    `validation_status` STRING COMMENT 'Status of the validation checks performed on this scenario result.. Valid values are `pending|passed|failed|override`',
    CONSTRAINT pk_scenario_result PRIMARY KEY(`scenario_result_id`)
) COMMENT 'Granular stress test result record at the portfolio, asset class, or risk factor level within a stress test run. Captures projected losses, capital impact, and risk metric movements under the scenario.';

CREATE OR REPLACE TABLE `banking_ecm`.`risk`.`concentration_risk` (
    `concentration_risk_id` BIGINT COMMENT 'Unique identifier for the concentration risk measurement record.',
    `appetite_id` BIGINT COMMENT 'Foreign key reference to the risk appetite statement that defines the concentration risk threshold and tolerance for this measurement.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee who approved this concentration risk measurement or any threshold breach exception.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Banks monitor concentration risk by distribution channel (over-reliance on digital, geographic branch concentration). Regulatory frameworks require channel diversification analysis for operational res',
    `collateral_asset_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_asset. Business justification: Concentration risk monitoring includes collateral concentrations: single issuer, asset class, geography. Regulatory large exposure rules (CRR Article 395) require collateral concentration limits. Link',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Concentration risk measurements by counterparty should reference the counterpartys credit rating to assess credit quality concentration. The concentration_risk table has party_id but lacks the rating',
    `country_id` BIGINT COMMENT 'Three-letter ISO 3166-1 alpha-3 country code when concentration type is geography-based, representing the country of risk exposure.',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code in which the exposure amount is denominated.',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Concentration risk metrics track large deposit accounts for single-name concentration limits. ALCO reviews top depositor concentrations monthly for liquidity risk management, requiring direct account ',
    `industry_code_id` BIGINT COMMENT 'Industry sector classification code when concentration type is industry-based (e.g., NAICS, GICS, or internal sector taxonomy code).',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Concentration risk measurements and large exposure limits are tracked at legal entity level for regulatory reporting (CRR Article 392-403) and internal risk appetite monitoring. Legal_entity_code is d',
    `owner_employee_id` BIGINT COMMENT 'FK to hr.employee',
    `party_id` BIGINT COMMENT 'Foreign key reference to the counterparty entity when concentration type is counterparty-specific. Null for non-counterparty concentration types.',
    `primary_concentration_employee_id` BIGINT COMMENT 'Foreign key reference to the employee who is designated as the risk owner responsible for monitoring and managing this concentration risk.',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Concentration risk metrics (large exposures, HHI, single-name concentration) are reviewed during regulatory exams for Reg F and prudential standards compliance. Banks track which concentration measure',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to risk.risk_limit. Business justification: Concentration risk measurements track breaches against defined risk limits. The concentration_risk table has threshold_type, warning_threshold, limit_threshold, breach_status, breach_date — these are ',
    `parent_concentration_risk_id` BIGINT COMMENT 'Self-referencing FK on concentration_risk (parent_concentration_risk_id)',
    `alco_review_date` DATE COMMENT 'Date on which the ALCO reviewed this concentration risk measurement and any associated breach or remediation plan.',
    `alco_review_status` STRING COMMENT 'Status of ALCO review and approval for this concentration risk measurement, particularly for breaches requiring committee oversight.. Valid values are `pending|reviewed|approved|escalated`',
    `approval_date` DATE COMMENT 'Date on which the concentration risk measurement or breach exception was formally approved by the designated authority.',
    `breach_date` DATE COMMENT 'Date on which the concentration metric first breached the applicable threshold, if currently in breach status.',
    `breach_severity` STRING COMMENT 'Severity classification of the threshold breach based on magnitude of excess and potential impact on capital and risk profile.. Valid values are `low|medium|high|critical`',
    `breach_status` STRING COMMENT 'Current breach status of the concentration metric relative to defined thresholds: within limit, warning threshold breached, limit threshold breached, or regulatory threshold breached.. Valid values are `within_limit|warning_breach|limit_breach|regulatory_breach`',
    `cet1_capital_percentage` DECIMAL(18,2) COMMENT 'Concentration exposure expressed as a percentage of the banks Common Equity Tier 1 capital, used for large exposure monitoring.',
    `collateral_type_code` STRING COMMENT 'Collateral type classification code when concentration type is collateral-based (e.g., real estate, securities, cash, guarantees).',
    `commentary` STRING COMMENT 'Free-text commentary providing additional context, analysis, or explanation regarding the concentration risk measurement, breach circumstances, or remediation plan.',
    `concentration_dimension` STRING COMMENT 'Specific dimension or segment being measured within the concentration type (e.g., specific counterparty name, industry sector code, country code, product category, collateral class).',
    `concentration_metric_name` STRING COMMENT 'Name of the concentration risk metric being measured (e.g., Single-Name Exposure, Sector Concentration Index, Geographic HHI, Product Type Exposure).',
    `concentration_percentage` DECIMAL(18,2) COMMENT 'Concentration exposure expressed as a percentage of total portfolio exposure, total capital, or other relevant denominator.',
    `concentration_type` STRING COMMENT 'Type of concentration risk being measured: counterparty (single-name), industry sector, geographic region, product type, collateral type, or currency concentration.. Valid values are `counterparty|industry|geography|product|collateral|currency`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this concentration risk measurement record was first created in the risk management platform.',
    `current_exposure_amount` DECIMAL(18,2) COMMENT 'Current exposure amount for the specified concentration dimension, representing the total credit or market risk exposure to that dimension.',
    `excess_amount` DECIMAL(18,2) COMMENT 'Amount by which the current exposure exceeds the applicable threshold, expressed in reporting currency. Null if no breach exists.',
    `exposure_reporting_currency` DECIMAL(18,2) COMMENT 'Current exposure amount converted to the reporting currency for consolidated risk reporting and limit monitoring.',
    `fx_rate` DECIMAL(18,2) COMMENT 'Exchange rate used to convert exposure currency to reporting currency for the measurement date.',
    `hhi_index_value` DECIMAL(18,2) COMMENT 'Herfindahl-Hirschman Index value measuring portfolio concentration, calculated as the sum of squared market shares. Higher values indicate greater concentration risk.',
    `is_large_exposure` BOOLEAN COMMENT 'Boolean flag indicating whether this concentration meets the regulatory definition of a large exposure (typically exceeding 10% of Tier 1 capital).',
    `is_regulatory_reportable` BOOLEAN COMMENT 'Boolean flag indicating whether this concentration risk measurement must be reported to banking supervisors under regulatory reporting requirements.',
    `limit_threshold` DECIMAL(18,2) COMMENT 'Hard limit threshold value for the concentration metric. Breaching this level requires immediate remediation action and senior management approval for any further exposure increase.',
    `line_of_business` STRING COMMENT 'Business line or division to which the concentration exposure is attributed (e.g., Commercial Lending, Investment Banking, Wealth Management).',
    `measurement_date` DATE COMMENT 'Business date on which the concentration risk exposure was measured and assessed.',
    `measurement_reference` STRING COMMENT 'Business reference code for the concentration risk measurement, used for tracking and reporting purposes.',
    `measurement_status` STRING COMMENT 'Current lifecycle status of the concentration risk measurement record.. Valid values are `draft|active|breached|remediated|expired`',
    `metric_calculation_method` STRING COMMENT 'Methodology or formula used to calculate the concentration metric (e.g., Herfindahl-Hirschman Index (HHI), percentage of total exposure, absolute exposure amount).',
    `portfolio_segment` STRING COMMENT 'Portfolio classification or segment within which the concentration is being measured (e.g., Corporate Loan Portfolio, Trading Book, Retail Mortgage Portfolio).',
    `product_type_code` STRING COMMENT 'Product type classification code when concentration type is product-based (e.g., corporate loans, mortgages, derivatives, securities).',
    `regulatory_report_reference` STRING COMMENT 'Reference number or identifier of the regulatory report submission in which this concentration risk measurement was included (e.g., FFIEC 031 schedule reference, EBA COREP reference).',
    `regulatory_threshold` DECIMAL(18,2) COMMENT 'Regulatory threshold or large exposure limit prescribed by banking supervisors (e.g., 25% of Tier 1 capital for single counterparty exposure under Basel large exposure framework).',
    `remediation_action` STRING COMMENT 'Description of remediation actions planned or taken to reduce concentration exposure and bring it within approved thresholds.',
    `remediation_due_date` DATE COMMENT 'Target date by which remediation actions must be completed to bring concentration exposure back within approved limits.',
    `remediation_status` STRING COMMENT 'Current status of remediation efforts to address concentration risk breach or warning threshold exceedance.. Valid values are `not_required|planned|in_progress|completed|overdue`',
    `reporting_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code used for regulatory and management reporting of concentration risk.. Valid values are `^[A-Z]{3}$`',
    `rwa_amount` DECIMAL(18,2) COMMENT 'Risk-weighted assets amount associated with the concentration exposure, calculated per Basel III regulatory capital framework.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this concentration risk measurement was extracted (e.g., SAS Risk Management, Moodys RiskAuthority, internal risk data mart).',
    `threshold_direction` STRING COMMENT 'Direction of threshold breach: above indicates risk when metric exceeds threshold, below indicates risk when metric falls below threshold.. Valid values are `above|below`',
    `threshold_type` STRING COMMENT 'Type of threshold applied to the concentration metric: absolute amount, percentage of capital/portfolio, index value, or ratio.. Valid values are `absolute|percentage|index|ratio`',
    `tier1_capital_percentage` DECIMAL(18,2) COMMENT 'Concentration exposure expressed as a percentage of the banks Tier 1 capital, used for regulatory large exposure reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this concentration risk measurement record was last modified.',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'Current exposure expressed as a percentage of the limit threshold, indicating how much of the concentration limit has been utilized.',
    `warning_threshold` DECIMAL(18,2) COMMENT 'Warning threshold value for the concentration metric. Breaching this level triggers management attention and monitoring escalation.',
    CONSTRAINT pk_concentration_risk PRIMARY KEY(`concentration_risk_id`)
) COMMENT 'Concentration risk measurement record tracking exposure concentrations by counterparty, industry, geography, product type, and collateral type. Captures concentration metric, threshold, current exposure, and breach status.';

CREATE OR REPLACE TABLE `banking_ecm`.`risk`.`risk_report` (
    `risk_report_id` BIGINT COMMENT 'Unique identifier for the risk report record. Primary key.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Risk reports are produced for specific accounting periods to align with financial reporting cycles, board governance calendars, and regulatory submission deadlines. Essential for integrated risk-finan',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Risk reports are often scoped to specific channels for management review (ATM network risk report, digital banking risk dashboard, branch operational risk summary). Channel-specific risk reporting sup',
    `consent_order_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_order. Business justification: Risk reports track remediation progress for consent order requirements (capital adequacy, stress testing, risk governance). Banks submit periodic risk reports to regulators demonstrating compliance wi',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code in which monetary amounts in this risk report are denominated.',
    `employee_id` BIGINT COMMENT 'User identifier of the individual who approved this risk report.',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Risk reports (capital adequacy, stress testing, risk appetite) are submitted to examiners during regulatory exams as evidence of risk management practices. Banks track which reports were provided for ',
    `stress_test_run_id` BIGINT COMMENT 'Foreign key linking to risk.stress_test_run. Business justification: Risk reports may be generated to document specific stress test run results for board reporting, regulatory submission (CCAR, DFAST), or internal management. The risk_report table has stressed_var_amou',
    `tertiary_risk_reviewed_by_user_employee_id` BIGINT COMMENT 'User identifier of the individual who reviewed this risk report prior to approval.',
    `previous_risk_report_id` BIGINT COMMENT 'Self-referencing FK on risk_report (previous_risk_report_id)',
    `approval_status` STRING COMMENT 'Approval status of the risk report by the designated authority or governance body.. Valid values are `pending|approved|rejected|conditional`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this risk report was approved by the designated authority.',
    `audience_type` STRING COMMENT 'Primary audience or governance body for whom this risk report is prepared. [ENUM-REF-CANDIDATE: board|executive_management|risk_committee|alco|regulator|internal_audit|business_unit — 7 candidates stripped; promote to reference product]',
    `cet1_ratio` DECIMAL(18,2) COMMENT 'Common Equity Tier 1 capital ratio reported, expressed as a percentage of risk-weighted assets.',
    `confidentiality_level` STRING COMMENT 'Data classification level indicating the sensitivity and access restrictions for this risk report.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this risk report record was first created in the system.',
    `distribution_list` STRING COMMENT 'Comma-separated list of recipients or distribution groups authorized to receive this risk report.',
    `ecl_provision_amount` DECIMAL(18,2) COMMENT 'Total expected credit loss provision amount reported under IFRS 9 or CECL accounting standards.',
    `executive_summary` STRING COMMENT 'High-level executive summary text providing key findings and insights from the risk report.',
    `frequency` STRING COMMENT 'Frequency at which this type of risk report is generated and distributed. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|semi_annual|annual|ad_hoc — 7 candidates stripped; promote to reference product]',
    `generation_timestamp` TIMESTAMP COMMENT 'Date and time when the risk report was generated by the risk management system.',
    `key_findings` STRING COMMENT 'Detailed narrative of key findings, trends, and risk observations identified in this report.',
    `lcr_ratio` DECIMAL(18,2) COMMENT 'Liquidity Coverage Ratio reported, measuring the sufficiency of high-quality liquid assets to meet short-term obligations.',
    `legal_entity_code` STRING COMMENT 'Code identifying the legal entity for which this risk report is prepared.',
    `leverage_ratio` DECIMAL(18,2) COMMENT 'Leverage ratio reported, calculated as Tier 1 capital divided by total exposure measure.',
    `line_of_business` STRING COMMENT 'Line of business segment covered by this risk report (e.g., retail banking, investment banking, wealth management).',
    `npl_ratio` DECIMAL(18,2) COMMENT 'Non-performing loan ratio reported, calculated as non-performing loans divided by total loan portfolio.',
    `nsfr_ratio` DECIMAL(18,2) COMMENT 'Net Stable Funding Ratio reported, measuring the stability of funding sources relative to asset liquidity profiles.',
    `period_end_date` DATE COMMENT 'End date of the reporting period covered by this risk report.',
    `period_start_date` DATE COMMENT 'Start date of the reporting period covered by this risk report.',
    `regulatory_framework` STRING COMMENT 'Regulatory framework or standard under which this risk report is prepared (e.g., Basel III, CCAR, DFAST, IFRS 9).',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Indicates whether this risk report is intended for submission to regulatory authorities.',
    `report_code` STRING COMMENT 'Business identifier code for the risk report, used for external reference and tracking.',
    `report_name` STRING COMMENT 'Descriptive name of the risk report identifying its purpose and content.',
    `report_status` STRING COMMENT 'Current lifecycle status of the risk report in the approval and submission workflow.. Valid values are `draft|pending_review|approved|submitted|rejected|archived`',
    `report_type` STRING COMMENT 'Classification of the risk report by primary risk category or reporting purpose. [ENUM-REF-CANDIDATE: market_risk|credit_risk|operational_risk|liquidity_risk|capital_adequacy|stress_test|comprehensive_risk|regulatory_submission|board_report|management_report — promote to reference product]',
    `reporting_date` DATE COMMENT 'The as-of date for which the risk metrics and positions in this report are measured and reported.',
    `reporting_unit_code` STRING COMMENT 'Code identifying the business unit or division responsible for this risk report.',
    `source_system_code` STRING COMMENT 'Code identifying the source risk management system or platform from which this report was generated (e.g., SAS Risk Management, Moodys RiskAuthority).',
    `stressed_var_amount` DECIMAL(18,2) COMMENT 'Stressed Value at Risk amount reported, calculated using a historical period of significant financial stress.',
    `submission_date` DATE COMMENT 'Date when this risk report was submitted to regulatory authorities or internal governance bodies.',
    `submission_reference_number` STRING COMMENT 'External reference number assigned by the regulatory authority upon submission of this report.',
    `tier1_ratio` DECIMAL(18,2) COMMENT 'Tier 1 capital ratio reported, expressed as a percentage of risk-weighted assets.',
    `total_capital_ratio` DECIMAL(18,2) COMMENT 'Total capital ratio reported, expressed as a percentage of risk-weighted assets.',
    `total_rwa_amount` DECIMAL(18,2) COMMENT 'Total risk-weighted assets amount reported in this risk report, used for capital adequacy calculations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this risk report record was last modified.',
    `var_amount` DECIMAL(18,2) COMMENT 'Value at Risk amount reported, representing the maximum potential loss over a specified time horizon at a given confidence level.',
    `version` STRING COMMENT 'Version number or identifier of this risk report, used to track revisions and updates.',
    CONSTRAINT pk_risk_report PRIMARY KEY(`risk_report_id`)
) COMMENT 'Risk reporting record capturing periodic risk reports generated for management, board, and regulators. Tracks report type, reporting date, key metrics, distribution list, and approval status.';

CREATE OR REPLACE TABLE `banking_ecm`.`risk`.`stress_test_factor_result` (
    `stress_test_factor_result_id` BIGINT COMMENT 'Unique surrogate identifier for each stress test factor result record. Primary key for this association.',
    `factor_id` BIGINT COMMENT 'Foreign key linking to the specific risk factor whose contribution to this stress test run is being measured',
    `stress_test_run_id` BIGINT COMMENT 'Foreign key linking to the stress test execution record whose results are being decomposed by risk factor',
    `calculation_timestamp` TIMESTAMP COMMENT 'Timestamp when this factor-level result was computed and recorded. Used for audit trail and to track calculation lineage for regulatory validation.',
    `contribution_to_capital_impact` DECIMAL(18,2) COMMENT 'The marginal contribution of this risk factor to the overall change in capital ratios (CET1, Tier 1, Total Capital) under this stress scenario. Expressed in the same currency as the stress test run. Used for factor attribution analysis.',
    `contribution_to_ecl_impact` DECIMAL(18,2) COMMENT 'The marginal contribution of this risk factor to the change in Expected Credit Loss (ECL) under this stress scenario. Expressed in the same currency as the stress test run. Critical for CECL and IFRS 9 stress testing.',
    `contribution_to_rwa_impact` DECIMAL(18,2) COMMENT 'The marginal contribution of this risk factor to the change in Risk-Weighted Assets (RWA) under this stress scenario. Expressed in the same currency as the stress test run. Required for Basel III regulatory attribution.',
    `factor_loading` DECIMAL(18,2) COMMENT 'The portfolio exposure or loading to this risk factor at the as-of date of the stress test. Represents the dollar exposure, duration, or beta depending on the risk factor type. Used to calculate the factor contribution from sensitivity and shock size.',
    `model_version_used` STRING COMMENT 'Version identifier of the risk model that produced this factor-level result. May differ from the overall stress test run model version if factor-level models are versioned independently. Required for model risk management and validation.',
    `sensitivity_coefficient` DECIMAL(18,2) COMMENT 'The partial derivative or sensitivity coefficient measuring the rate of change in the stress test output (capital, RWA, ECL) with respect to a unit change in this risk factor. Used for marginal sensitivity analysis and model validation.',
    `shock_direction` STRING COMMENT 'The direction of the shock applied to this risk factor in this stress scenario. Values: up (factor increased), down (factor decreased), neutral (no shock applied to this factor in this scenario).',
    `shock_magnitude` DECIMAL(18,2) COMMENT 'The magnitude of the shock applied to this risk factor in this stress scenario, expressed in the units appropriate to the factor (basis points for rates, percentage for equity indices, etc.). Derived from the scenario definition but stored here for attribution transparency.',
    `stressed_value` DECIMAL(18,2) COMMENT 'The shocked or stressed value of this risk factor applied in this specific stress test run (e.g., shocked interest rate level, stressed credit spread, shocked equity index value). Unit depends on the risk factor type.',
    CONSTRAINT pk_stress_test_factor_result PRIMARY KEY(`stress_test_factor_result_id`)
) COMMENT 'This association product represents the decomposition of stress test results by individual risk factors. It captures the contribution of each risk factor to the overall stressed capital ratios, RWA, ECL, and other stress test outputs. Each record links one stress test run to one risk factor with quantitative attribution metrics required for regulatory reporting (FR Y-14 Schedule A), model validation, and risk factor sensitivity analysis.. Existence Justification: In regulatory stress testing, each stress test run applies shocks to hundreds or thousands of risk factors simultaneously, and each risk factor is used across multiple stress test runs (different scenarios, different time periods, different portfolios). The business actively manages and reports on the decomposition of stress test results by risk factor—this is not an analytical correlation but an operational requirement. Regulatory submissions (FR Y-14 Schedule A) explicitly require factor-level attribution showing how each risk factor contributed to the stressed capital ratios.';

CREATE OR REPLACE TABLE `banking_ecm`.`risk`.`model_deployment` (
    `model_deployment_id` BIGINT COMMENT 'Unique surrogate identifier for this model deployment record',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the user (model owner or risk officer) responsible for this model deployment within the legal entity',
    `irb_model_id` BIGINT COMMENT 'Foreign key linking to the IRB model being deployed',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to the legal entity where the model is deployed',
    `deployment_date` DATE COMMENT 'Date on which the IRB model was deployed to this legal entity for production use in credit risk estimation and capital calculation',
    `deployment_status` STRING COMMENT 'Current operational status of this model deployment. ACTIVE = in production use, INACTIVE = approved but not yet implemented, SUSPENDED = temporarily disabled pending review, DECOMMISSIONED = permanently retired',
    `effective_from_date` DATE COMMENT 'Date from which this model deployment became effective for regulatory capital calculation and financial reporting for this legal entity',
    `effective_until_date` DATE COMMENT 'Date on which this model deployment ceases to be effective, typically when superseded by a new model version or when the entity exits the portfolio',
    `exposure_at_deployment` DECIMAL(18,2) COMMENT 'Total credit exposure (EAD) in this legal entity covered by this model deployment at the time of initial deployment, used for tracking model coverage and materiality',
    `last_validation_date` DATE COMMENT 'Date of the most recent independent validation of this model deployment for this specific legal entity. Validation may be performed at entity level when portfolios differ significantly across the group',
    `override_count` STRING COMMENT 'Number of manual overrides applied to model outputs for exposures within this legal entity during the current reporting period. High override rates may indicate model performance issues or portfolio drift',
    `portfolio_scope` STRING COMMENT 'Description of the credit portfolio scope within this legal entity to which the IRB model applies (e.g., North American Corporate Lending, Retail Mortgages - Prime, SME Commercial Real Estate)',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory approval for this specific model-entity deployment. Supervisors may approve a model for use in certain entities but not others based on portfolio characteristics and data quality',
    `regulatory_comments` STRING COMMENT 'Free-text field capturing any conditions, limitations, or comments from the prudential supervisor regarding this specific model-entity deployment',
    `rwa_impact_amount` DECIMAL(18,2) COMMENT 'Total risk-weighted assets (RWA) calculated using this model deployment for exposures in this legal entity, expressed in the entitys reporting currency',
    CONSTRAINT pk_model_deployment PRIMARY KEY(`model_deployment_id`)
) COMMENT 'This association product represents the deployment of an IRB model to a specific legal entity within the banking group. It captures regulatory approval status, portfolio scope, validation outcomes, and override activity for each model-entity combination. Each record links one IRB model to one legal entity with attributes that exist only in the context of this deployment relationship. Essential for capital adequacy reporting, regulatory compliance tracking, and model governance across the consolidated banking group.. Existence Justification: IRB models in banking groups are deployed across multiple legal entities, and each legal entity uses multiple IRB models for different asset classes and portfolios. Banks actively manage these deployments as distinct operational records, tracking entity-specific regulatory approvals, portfolio scope, validation outcomes, override activity, and RWA impacts. Model deployment is a recognized business process in model governance and regulatory capital management.';

CREATE OR REPLACE TABLE `banking_ecm`.`risk`.`valuation_model` (
    `valuation_model_id` BIGINT COMMENT 'Primary key for valuation_model',
    `previous_valuation_model_id` BIGINT COMMENT 'Self-referencing FK on valuation_model (previous_valuation_model_id)',
    `applicable_products` STRING COMMENT 'Comma-separated list of financial products or instruments for which this model is applicable.',
    `approval_date` DATE COMMENT 'The date when the model received formal approval from the model governance committee or regulatory authority.',
    `approval_status` STRING COMMENT 'Regulatory and internal approval status of the valuation model.',
    `approved_by` STRING COMMENT 'The name or identifier of the authority (committee, regulator, or individual) who approved the model.',
    `asset_class` STRING COMMENT 'The asset class for which this valuation model is designed and approved.',
    `backtesting_frequency` STRING COMMENT 'The frequency at which the model undergoes backtesting to validate its predictive accuracy.',
    `benchmark_model` STRING COMMENT 'The industry-standard or alternative model used as a benchmark for comparison and validation purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this valuation model record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the valuation output.',
    `data_source` STRING COMMENT 'The primary data source(s) feeding input parameters into the valuation model (e.g., Bloomberg, Reuters, internal market data).',
    `valuation_model_description` STRING COMMENT 'Detailed description of the valuation model, including its purpose, methodology, and use cases.',
    `documentation_reference` STRING COMMENT 'Reference identifier or URL to the comprehensive model documentation, including methodology, validation reports, and user guides.',
    `effective_date` DATE COMMENT 'The date from which this valuation model version became effective and approved for use.',
    `expiry_date` DATE COMMENT 'The date when this valuation model version is scheduled to be retired or replaced. Null if no expiry is planned.',
    `fair_value_hierarchy_level` STRING COMMENT 'IFRS 13 fair value hierarchy classification: Level 1 (quoted prices), Level 2 (observable inputs), or Level 3 (unobservable inputs).',
    `frequency` STRING COMMENT 'The frequency at which this valuation model is executed for pricing and risk measurement.',
    `input_parameters` STRING COMMENT 'Comma-separated list of required input parameters for the valuation model (e.g., spot price, strike price, volatility, risk-free rate).',
    `is_regulatory_approved` BOOLEAN COMMENT 'Indicates whether the model has received formal regulatory approval for use in capital calculations and regulatory reporting.',
    `is_stress_test_approved` BOOLEAN COMMENT 'Indicates whether the model is approved for use in regulatory stress testing scenarios such as CCAR or DFAST.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this valuation model record was last updated.',
    `last_validation_date` DATE COMMENT 'The date when the model last underwent independent validation.',
    `mathematical_formula` STRING COMMENT 'The core mathematical formula or algorithm used by the valuation model.',
    `model_code` STRING COMMENT 'Unique business identifier code for the valuation model used in risk systems and reporting.',
    `model_complexity_score` DECIMAL(18,2) COMMENT 'Quantitative score representing the complexity of the model, used for risk assessment and validation prioritization.',
    `model_developer` STRING COMMENT 'The team or individual who developed the valuation model.',
    `model_limitations` STRING COMMENT 'Known limitations, assumptions, and constraints of the valuation model that users must be aware of.',
    `model_name` STRING COMMENT 'Human-readable name of the valuation model.',
    `model_owner` STRING COMMENT 'The business unit or department responsible for the ownership and governance of this valuation model.',
    `model_risk_rating` STRING COMMENT 'The assessed risk rating of the model based on materiality, complexity, and potential impact on financial reporting and capital.',
    `model_status` STRING COMMENT 'Current lifecycle status of the valuation model within the risk management framework.',
    `model_type` STRING COMMENT 'Classification of the valuation methodology employed by the model.',
    `model_version` STRING COMMENT 'Version number of the valuation model, following semantic versioning convention.',
    `next_validation_due_date` DATE COMMENT 'The scheduled date for the next independent model validation.',
    `output_measure` STRING COMMENT 'The primary output measure produced by the model (e.g., fair value, present value, option price, credit valuation adjustment).',
    `regulatory_framework` STRING COMMENT 'The regulatory framework(s) under which this model is approved and used (e.g., Basel III, IFRS 13, Dodd-Frank, CCAR).',
    `use_case` STRING COMMENT 'The primary business use case for the model (e.g., mark-to-market valuation, CVA calculation, stress testing, regulatory capital).',
    `validation_outcome` STRING COMMENT 'The outcome of the most recent independent model validation.',
    `valuation_approach` STRING COMMENT 'The primary valuation approach as defined by IFRS 13: market approach, income approach, or cost approach.',
    `vendor_name` STRING COMMENT 'Name of the third-party vendor if the model is externally sourced (e.g., Bloomberg, Moodys, SAS).',
    CONSTRAINT pk_valuation_model PRIMARY KEY(`valuation_model_id`)
) COMMENT 'Master reference table for valuation_model. Referenced by valuation_model_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`risk`.`factor` ADD CONSTRAINT `fk_risk_factor_irb_model_id` FOREIGN KEY (`irb_model_id`) REFERENCES `banking_ecm`.`risk`.`irb_model`(`irb_model_id`);
ALTER TABLE `banking_ecm`.`risk`.`factor` ADD CONSTRAINT `fk_risk_factor_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`risk`.`appetite` ADD CONSTRAINT `fk_risk_appetite_superseded_by_appetite_id` FOREIGN KEY (`superseded_by_appetite_id`) REFERENCES `banking_ecm`.`risk`.`appetite`(`appetite_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ADD CONSTRAINT `fk_risk_risk_limit_appetite_id` FOREIGN KEY (`appetite_id`) REFERENCES `banking_ecm`.`risk`.`appetite`(`appetite_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ADD CONSTRAINT `fk_risk_risk_limit_irb_model_id` FOREIGN KEY (`irb_model_id`) REFERENCES `banking_ecm`.`risk`.`irb_model`(`irb_model_id`);
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ADD CONSTRAINT `fk_risk_credit_exposure_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ADD CONSTRAINT `fk_risk_credit_exposure_irb_model_id` FOREIGN KEY (`irb_model_id`) REFERENCES `banking_ecm`.`risk`.`irb_model`(`irb_model_id`);
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ADD CONSTRAINT `fk_risk_credit_exposure_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ADD CONSTRAINT `fk_risk_credit_exposure_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ADD CONSTRAINT `fk_risk_market_risk_position_factor_id` FOREIGN KEY (`factor_id`) REFERENCES `banking_ecm`.`risk`.`factor`(`factor_id`);
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ADD CONSTRAINT `fk_risk_market_risk_position_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ADD CONSTRAINT `fk_risk_market_risk_position_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ADD CONSTRAINT `fk_risk_market_risk_position_valuation_model_id` FOREIGN KEY (`valuation_model_id`) REFERENCES `banking_ecm`.`risk`.`valuation_model`(`valuation_model_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ADD CONSTRAINT `fk_risk_risk_ecl_provision_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ADD CONSTRAINT `fk_risk_risk_ecl_provision_irb_model_id` FOREIGN KEY (`irb_model_id`) REFERENCES `banking_ecm`.`risk`.`irb_model`(`irb_model_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ADD CONSTRAINT `fk_risk_risk_ecl_provision_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ADD CONSTRAINT `fk_risk_counterparty_rating_irb_model_id` FOREIGN KEY (`irb_model_id`) REFERENCES `banking_ecm`.`risk`.`irb_model`(`irb_model_id`);
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ADD CONSTRAINT `fk_risk_stress_scenario_primary_superseded_by_stress_scenario_id` FOREIGN KEY (`primary_superseded_by_stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ADD CONSTRAINT `fk_risk_stress_scenario_source_scenario_stress_scenario_id` FOREIGN KEY (`source_scenario_stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ADD CONSTRAINT `fk_risk_stress_test_run_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ADD CONSTRAINT `fk_risk_liquidity_metric_appetite_id` FOREIGN KEY (`appetite_id`) REFERENCES `banking_ecm`.`risk`.`appetite`(`appetite_id`);
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ADD CONSTRAINT `fk_risk_liquidity_metric_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ADD CONSTRAINT `fk_risk_liquidity_metric_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ADD CONSTRAINT `fk_risk_operational_risk_event_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `banking_ecm`.`risk`.`assessment`(`assessment_id`);
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ADD CONSTRAINT `fk_risk_kri_measurement_appetite_id` FOREIGN KEY (`appetite_id`) REFERENCES `banking_ecm`.`risk`.`appetite`(`appetite_id`);
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ADD CONSTRAINT `fk_risk_kri_measurement_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ADD CONSTRAINT `fk_risk_model_validation_irb_model_id` FOREIGN KEY (`irb_model_id`) REFERENCES `banking_ecm`.`risk`.`irb_model`(`irb_model_id`);
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ADD CONSTRAINT `fk_risk_model_validation_valuation_model_id` FOREIGN KEY (`valuation_model_id`) REFERENCES `banking_ecm`.`risk`.`valuation_model`(`valuation_model_id`);
ALTER TABLE `banking_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_appetite_id` FOREIGN KEY (`appetite_id`) REFERENCES `banking_ecm`.`risk`.`appetite`(`appetite_id`);
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ADD CONSTRAINT `fk_risk_scenario_result_factor_id` FOREIGN KEY (`factor_id`) REFERENCES `banking_ecm`.`risk`.`factor`(`factor_id`);
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ADD CONSTRAINT `fk_risk_scenario_result_irb_model_id` FOREIGN KEY (`irb_model_id`) REFERENCES `banking_ecm`.`risk`.`irb_model`(`irb_model_id`);
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ADD CONSTRAINT `fk_risk_scenario_result_stress_scenario_id` FOREIGN KEY (`stress_scenario_id`) REFERENCES `banking_ecm`.`risk`.`stress_scenario`(`stress_scenario_id`);
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ADD CONSTRAINT `fk_risk_scenario_result_stress_test_run_id` FOREIGN KEY (`stress_test_run_id`) REFERENCES `banking_ecm`.`risk`.`stress_test_run`(`stress_test_run_id`);
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ADD CONSTRAINT `fk_risk_scenario_result_previous_scenario_result_id` FOREIGN KEY (`previous_scenario_result_id`) REFERENCES `banking_ecm`.`risk`.`scenario_result`(`scenario_result_id`);
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ADD CONSTRAINT `fk_risk_concentration_risk_appetite_id` FOREIGN KEY (`appetite_id`) REFERENCES `banking_ecm`.`risk`.`appetite`(`appetite_id`);
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ADD CONSTRAINT `fk_risk_concentration_risk_counterparty_rating_id` FOREIGN KEY (`counterparty_rating_id`) REFERENCES `banking_ecm`.`risk`.`counterparty_rating`(`counterparty_rating_id`);
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ADD CONSTRAINT `fk_risk_concentration_risk_risk_limit_id` FOREIGN KEY (`risk_limit_id`) REFERENCES `banking_ecm`.`risk`.`risk_limit`(`risk_limit_id`);
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ADD CONSTRAINT `fk_risk_concentration_risk_parent_concentration_risk_id` FOREIGN KEY (`parent_concentration_risk_id`) REFERENCES `banking_ecm`.`risk`.`concentration_risk`(`concentration_risk_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ADD CONSTRAINT `fk_risk_risk_report_stress_test_run_id` FOREIGN KEY (`stress_test_run_id`) REFERENCES `banking_ecm`.`risk`.`stress_test_run`(`stress_test_run_id`);
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ADD CONSTRAINT `fk_risk_risk_report_previous_risk_report_id` FOREIGN KEY (`previous_risk_report_id`) REFERENCES `banking_ecm`.`risk`.`risk_report`(`risk_report_id`);
ALTER TABLE `banking_ecm`.`risk`.`stress_test_factor_result` ADD CONSTRAINT `fk_risk_stress_test_factor_result_factor_id` FOREIGN KEY (`factor_id`) REFERENCES `banking_ecm`.`risk`.`factor`(`factor_id`);
ALTER TABLE `banking_ecm`.`risk`.`stress_test_factor_result` ADD CONSTRAINT `fk_risk_stress_test_factor_result_stress_test_run_id` FOREIGN KEY (`stress_test_run_id`) REFERENCES `banking_ecm`.`risk`.`stress_test_run`(`stress_test_run_id`);
ALTER TABLE `banking_ecm`.`risk`.`model_deployment` ADD CONSTRAINT `fk_risk_model_deployment_irb_model_id` FOREIGN KEY (`irb_model_id`) REFERENCES `banking_ecm`.`risk`.`irb_model`(`irb_model_id`);
ALTER TABLE `banking_ecm`.`risk`.`valuation_model` ADD CONSTRAINT `fk_risk_valuation_model_previous_valuation_model_id` FOREIGN KEY (`previous_valuation_model_id`) REFERENCES `banking_ecm`.`risk`.`valuation_model`(`valuation_model_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`risk` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `banking_ecm`.`risk` SET TAGS ('dbx_domain' = 'risk');
ALTER TABLE `banking_ecm`.`risk`.`factor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`risk`.`factor` SET TAGS ('dbx_subdomain' = 'market_analysis');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `factor_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor Identifier');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `irb_model_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Identifier');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'rates|fx|equity|commodity|credit');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `calibration_method` SET TAGS ('dbx_business_glossary_term' = 'Calibration Methodology');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `calibration_method` SET TAGS ('dbx_value_regex' = 'historical_simulation|monte_carlo|parametric|bootstrap|stress_calibration');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `ccar_scenario_flag` SET TAGS ('dbx_business_glossary_term' = 'Comprehensive Capital Analysis and Review (CCAR) Scenario Flag');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `credit_quality` SET TAGS ('dbx_business_glossary_term' = 'Credit Quality');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `credit_quality` SET TAGS ('dbx_value_regex' = 'investment_grade|sub_investment_grade|unrated|sovereign');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `factor_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor Code');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `factor_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,50}$');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `factor_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor Description');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `factor_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor Name');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `factor_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor Status');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `factor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|under_review|pending_approval');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `factor_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor Type');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `factor_type` SET TAGS ('dbx_value_regex' = 'interest_rate|fx_rate|equity|commodity|credit_spread|volatility');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `frtb_bucket` SET TAGS ('dbx_business_glossary_term' = 'Fundamental Review of the Trading Book (FRTB) Bucket');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `geography` SET TAGS ('dbx_business_glossary_term' = 'Geography');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `geography` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `holding_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holding Period (Days)');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `ifrs9_ecl_flag` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standard 9 (IFRS 9) Expected Credit Loss (ECL) Flag');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `is_proxy_factor` SET TAGS ('dbx_business_glossary_term' = 'Proxy Factor Indicator');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `last_observation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Market Data Observation Date');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `last_validation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Model Validation Date');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `liquidity_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Horizon (Days)');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `market_data_source` SET TAGS ('dbx_business_glossary_term' = 'Market Data Source');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `market_data_ticker` SET TAGS ('dbx_business_glossary_term' = 'Market Data Ticker');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `next_validation_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Validation Date');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `observation_window_days` SET TAGS ('dbx_business_glossary_term' = 'Observation Window (Days)');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `proxy_factor_code` SET TAGS ('dbx_business_glossary_term' = 'Proxy Factor Code');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `proxy_factor_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,50}$');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Modellability Classification');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'modellable|non_modellable|not_applicable');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `rfet_observation_count` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor Eligibility Test (RFET) Observation Count');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `risk_class` SET TAGS ('dbx_business_glossary_term' = 'Risk Class');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `risk_class` SET TAGS ('dbx_value_regex' = 'market_risk|credit_risk|operational_risk|liquidity_risk');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `sector` SET TAGS ('dbx_business_glossary_term' = 'Sector');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `shock_type` SET TAGS ('dbx_business_glossary_term' = 'Shock Type');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `shock_type` SET TAGS ('dbx_value_regex' = 'absolute|relative|log_return|basis_point');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `stress_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Stress Period End Date');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `stress_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Stress Period Start Date');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `sub_risk_class` SET TAGS ('dbx_business_glossary_term' = 'Sub-Risk Class');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `tenor` SET TAGS ('dbx_business_glossary_term' = 'Tenor');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `tenor` SET TAGS ('dbx_value_regex' = '^(ON|1W|2W|1M|2M|3M|6M|9M|1Y|2Y|3Y|5Y|7Y|10Y|15Y|20Y|30Y)$');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `tenor_days` SET TAGS ('dbx_business_glossary_term' = 'Tenor in Days');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `time_series_code` SET TAGS ('dbx_business_glossary_term' = 'Time Series Identifier');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `underlying_index` SET TAGS ('dbx_business_glossary_term' = 'Underlying Index or Benchmark');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `var_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Confidence Level');
ALTER TABLE `banking_ecm`.`risk`.`factor` ALTER COLUMN `var_contribution_pct` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Contribution Percentage');
ALTER TABLE `banking_ecm`.`risk`.`appetite` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`risk`.`appetite` SET TAGS ('dbx_subdomain' = 'operational_oversight');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `appetite_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite ID');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `superseded_by_appetite_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Risk Appetite ID');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `appetite_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Level');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `appetite_level` SET TAGS ('dbx_value_regex' = 'low|moderate|elevated|high');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Board Approval Date');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|superseded|retired');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `breach_escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Breach Escalation Level');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `breach_escalation_level` SET TAGS ('dbx_value_regex' = 'management|senior_management|cro|board_risk_committee|board');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `breach_response_timeframe_days` SET TAGS ('dbx_business_glossary_term' = 'Breach Response Timeframe (Days)');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Threshold Direction');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'minimum|maximum|target|range');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `governance_body` SET TAGS ('dbx_business_glossary_term' = 'Governance Body');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `governance_body` SET TAGS ('dbx_value_regex' = 'board|board_risk_committee|alco|executive_risk_committee|credit_committee|audit_committee');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `is_board_approved` SET TAGS ('dbx_business_glossary_term' = 'Board Approved Indicator');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `is_quantitative` SET TAGS ('dbx_business_glossary_term' = 'Quantitative Indicator');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `is_regulatory_minimum` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Minimum Indicator');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `kri_code` SET TAGS ('dbx_business_glossary_term' = 'Key Risk Indicator (KRI) Code');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `kri_code` SET TAGS ('dbx_value_regex' = '^KRI-[A-Z]{2,10}-[0-9]{3}$');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `legal_entity` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `limit_value` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Value');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `metric_definition` SET TAGS ('dbx_business_glossary_term' = 'Risk Metric Definition');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Metric Name');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `metric_unit` SET TAGS ('dbx_business_glossary_term' = 'Risk Metric Unit of Measure');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `qualitative_statement` SET TAGS ('dbx_business_glossary_term' = 'Qualitative Risk Appetite Statement');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `range_lower_bound` SET TAGS ('dbx_business_glossary_term' = 'Appetite Range Lower Bound');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `range_upper_bound` SET TAGS ('dbx_business_glossary_term' = 'Appetite Range Upper Bound');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `raroc_hurdle_rate` SET TAGS ('dbx_business_glossary_term' = 'Risk-Adjusted Return on Capital (RAROC) Hurdle Rate');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|ad_hoc');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'credit|market|liquidity|operational|reputational|strategic');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `risk_sub_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Sub-Category');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `rwa_limit` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) Limit');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAS_RM|MOODYS_RA|AXIOMSL|ONESUMX|MANUAL');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `statement_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Statement Code');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `statement_code` SET TAGS ('dbx_value_regex' = '^RA-[A-Z]{2,10}-[0-9]{4}-[0-9]{3}$');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `statement_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Statement Name');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `stress_scenario_applicability` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Applicability');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `stress_scenario_applicability` SET TAGS ('dbx_value_regex' = 'baseline|adverse|severely_adverse|all_scenarios');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `threshold` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Threshold');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `tolerance_threshold` SET TAGS ('dbx_business_glossary_term' = 'Risk Tolerance Threshold');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `banking_ecm`.`risk`.`appetite` ALTER COLUMN `warning_threshold` SET TAGS ('dbx_business_glossary_term' = 'Risk Warning Threshold');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` SET TAGS ('dbx_subdomain' = 'operational_oversight');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit ID');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `alco_resolution_id` SET TAGS ('dbx_business_glossary_term' = 'Alco Resolution Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `appetite_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Limit Scope Entity ID');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `irb_model_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Ratings-Based (IRB) Model ID');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `netting_set_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Set Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Limit Owner User ID');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `primary_risk_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `primary_risk_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `primary_risk_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Amount');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Limit Approval Authority');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Limit Approval Date');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `breach_action_rule` SET TAGS ('dbx_business_glossary_term' = 'Breach Action Rule');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `breach_count` SET TAGS ('dbx_business_glossary_term' = 'Limit Breach Count');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Currency');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `current_utilization_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Limit Utilization Amount');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `current_utilization_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `desk_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Desk Code');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `desk_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Limit Effective Date');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `escalation_level_1` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level 1 Contact');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `escalation_level_2` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level 2 Contact');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Limit Expiry Date');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `geography_code` SET TAGS ('dbx_business_glossary_term' = 'Geography Code');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `geography_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `hard_stop_flag` SET TAGS ('dbx_business_glossary_term' = 'Hard Stop Flag');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `last_breach_date` SET TAGS ('dbx_business_glossary_term' = 'Last Breach Date');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `limit_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Code');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `limit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,30}$');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `limit_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Description');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `limit_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Name');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `limit_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Status');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `limit_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|pending_approval|cancelled|breached');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Type');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `lob_code` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `lob_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Limit Monitoring Frequency');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'real_time|intraday|daily|weekly|monthly');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `regulatory_capital_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Capital Constraint Flag');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Limit Review Frequency');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually|ad_hoc');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `scope_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Limit Scope Entity Name');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `scope_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Limit Scope Entity Type');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `stress_test_limit_flag` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Limit Flag');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Sub-Type');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `utilization_as_of_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Utilization As-Of Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `utilization_basis` SET TAGS ('dbx_business_glossary_term' = 'Limit Utilization Basis');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `utilization_pct` SET TAGS ('dbx_business_glossary_term' = 'Limit Utilization Percentage');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `var_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Confidence Level');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `var_holding_period_days` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Holding Period Days');
ALTER TABLE `banking_ecm`.`risk`.`risk_limit` ALTER COLUMN `warning_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Warning Threshold Percentage');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` SET TAGS ('dbx_subdomain' = 'credit_management');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `credit_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure ID');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Country of Domicile');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Exposure Currency Code (ISO 4217)');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `irb_model_id` SET TAGS ('dbx_business_glossary_term' = 'Irb Model Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `netting_set_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Set ID');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Obligor ID');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `repo_position_id` SET TAGS ('dbx_business_glossary_term' = 'Repo Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `collateral_value` SET TAGS ('dbx_business_glossary_term' = 'Eligible Collateral Value');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `collateral_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `collateral_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `concentration_hhi` SET TAGS ('dbx_business_glossary_term' = 'Herfindahl-Hirschman Index (HHI) Concentration Score');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Type');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `current_exposure` SET TAGS ('dbx_business_glossary_term' = 'Current Exposure (CE)');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `current_exposure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `current_exposure` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `cva` SET TAGS ('dbx_business_glossary_term' = 'Credit Valuation Adjustment (CVA)');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `cva` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `cva` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `cva_approach` SET TAGS ('dbx_business_glossary_term' = 'CVA Capital Approach');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `cva_approach` SET TAGS ('dbx_value_regex' = 'SA-CVA|BA-CVA|exempted');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `cva_capital_charge` SET TAGS ('dbx_business_glossary_term' = 'CVA Regulatory Capital Charge');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `cva_capital_charge` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `cva_capital_charge` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `dva` SET TAGS ('dbx_business_glossary_term' = 'Debit Valuation Adjustment (DVA)');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `dva` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `dva` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `ead` SET TAGS ('dbx_business_glossary_term' = 'Exposure at Default (EAD)');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `ead` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `ead` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `ecl_provision` SET TAGS ('dbx_business_glossary_term' = 'Expected Credit Loss (ECL) Provision');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `ecl_provision` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `ecl_provision` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `ecl_stage` SET TAGS ('dbx_business_glossary_term' = 'Expected Credit Loss (ECL) IFRS 9 Stage');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `ecl_stage` SET TAGS ('dbx_value_regex' = 'stage_1|stage_2|stage_3');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `effective_maturity_years` SET TAGS ('dbx_business_glossary_term' = 'Effective Maturity (M) in Years');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `expected_exposure` SET TAGS ('dbx_business_glossary_term' = 'Expected Exposure (EE)');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `expected_exposure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `expected_exposure` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `exposure_class` SET TAGS ('dbx_business_glossary_term' = 'Basel Exposure Class');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `exposure_reference` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure Reference Number');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `exposure_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure Status');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `exposure_status` SET TAGS ('dbx_value_regex' = 'active|closed|defaulted|restructured|watch_list|written_off');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `fva` SET TAGS ('dbx_business_glossary_term' = 'Funding Valuation Adjustment (FVA)');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `fva` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `fva` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `fx_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `industry_sector` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Industry Sector (GICS/NACE)');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `large_exposure_flag` SET TAGS ('dbx_business_glossary_term' = 'Large Exposure Regulatory Flag');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `lgd` SET TAGS ('dbx_business_glossary_term' = 'Loss Given Default (LGD)');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Exposure Maturity Date');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Exposure Measurement Date');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `net_exposure` SET TAGS ('dbx_business_glossary_term' = 'Net Credit Exposure');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `net_exposure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `net_exposure` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `pd` SET TAGS ('dbx_business_glossary_term' = 'Probability of Default (PD)');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `pillar3_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Pillar 3 Disclosure Eligible Flag');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `potential_future_exposure` SET TAGS ('dbx_business_glossary_term' = 'Potential Future Exposure (PFE)');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `potential_future_exposure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `potential_future_exposure` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Product Type');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `regulatory_approach` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Capital Approach');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `regulatory_approach` SET TAGS ('dbx_value_regex' = 'SA|IRB_Foundation|IRB_Advanced|SA-CCR|IMM');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code (ISO 4217)');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `risk_weight` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Risk Weight');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `rwa_credit` SET TAGS ('dbx_business_glossary_term' = 'Credit Risk-Weighted Assets (RWA)');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `rwa_credit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `rwa_credit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Record');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Murex|Calypso|SAS_Risk|Moodys_RiskAuthority|LoanIQ|CoreBanking');
ALTER TABLE `banking_ecm`.`risk`.`credit_exposure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` SET TAGS ('dbx_subdomain' = 'market_analysis');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `market_risk_position_id` SET TAGS ('dbx_business_glossary_term' = 'Market Risk Position ID');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `alm_hedge_id` SET TAGS ('dbx_business_glossary_term' = 'Alm Hedge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `factor_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Desk ID');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `valuation_model_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Model Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `book_type` SET TAGS ('dbx_business_glossary_term' = 'Book Type');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `book_type` SET TAGS ('dbx_value_regex' = 'trading_book|banking_book');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `cs01` SET TAGS ('dbx_business_glossary_term' = 'Credit Spread 01 (CS01)');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `cva_charge` SET TAGS ('dbx_business_glossary_term' = 'Credit Valuation Adjustment (CVA) Charge');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `delta` SET TAGS ('dbx_business_glossary_term' = 'Delta Sensitivity');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `dv01` SET TAGS ('dbx_business_glossary_term' = 'Dollar Value of 01 (DV01)');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `eve_sensitivity` SET TAGS ('dbx_business_glossary_term' = 'Economic Value of Equity (EVE) Sensitivity');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `expected_shortfall` SET TAGS ('dbx_business_glossary_term' = 'Expected Shortfall (ES)');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `frtb_approach` SET TAGS ('dbx_business_glossary_term' = 'Fundamental Review of the Trading Book (FRTB) Approach');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `frtb_approach` SET TAGS ('dbx_value_regex' = 'IMA|SA|IMA_fallback');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `frtb_capital_charge` SET TAGS ('dbx_business_glossary_term' = 'Fundamental Review of the Trading Book (FRTB) Capital Charge');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `gamma` SET TAGS ('dbx_business_glossary_term' = 'Gamma Sensitivity');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_business_glossary_term' = 'Hedge Designation');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_value_regex' = 'fair_value_hedge|cash_flow_hedge|net_investment_hedge|not_designated');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `hypothetical_pnl` SET TAGS ('dbx_business_glossary_term' = 'Hypothetical Profit and Loss (P&L)');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `hypothetical_pnl` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `hypothetical_pnl` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `irc_charge` SET TAGS ('dbx_business_glossary_term' = 'Incremental Risk Charge (IRC)');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `is_modellable_risk_factor` SET TAGS ('dbx_business_glossary_term' = 'Is Modellable Risk Factor Flag');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `mtm_value` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Value');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `mtm_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `mtm_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `nii_sensitivity` SET TAGS ('dbx_business_glossary_term' = 'Net Interest Income (NII) Sensitivity');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `notional_amount` SET TAGS ('dbx_business_glossary_term' = 'Notional Amount');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `notional_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `notional_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `pnl_daily` SET TAGS ('dbx_business_glossary_term' = 'Daily Profit and Loss (P&L)');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `pnl_daily` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `pnl_daily` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `position_date` SET TAGS ('dbx_business_glossary_term' = 'Position Date');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `position_reference` SET TAGS ('dbx_business_glossary_term' = 'Position Reference Number');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'open|closed|suspended|pending_settlement|cancelled');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `repricing_bucket` SET TAGS ('dbx_business_glossary_term' = 'Repricing Time Bucket');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `repricing_gap` SET TAGS ('dbx_business_glossary_term' = 'Repricing Gap');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `rwa_market_risk` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) — Market Risk');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'MUREX|CALYPSO|SAS_RISK|MOODYS_RA|AXIOMSL');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `stressed_var` SET TAGS ('dbx_business_glossary_term' = 'Stressed Value at Risk (SVaR)');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `var_10d_99` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) 10-Day 99% Confidence');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `var_1d_99` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) 1-Day 99% Confidence');
ALTER TABLE `banking_ecm`.`risk`.`market_risk_position` ALTER COLUMN `vega` SET TAGS ('dbx_business_glossary_term' = 'Vega Sensitivity');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` SET TAGS ('dbx_subdomain' = 'credit_management');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `risk_ecl_provision_id` SET TAGS ('dbx_business_glossary_term' = 'Expected Credit Loss (ECL) Provision Record ID');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `aml_case_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `collateral_pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Provision Currency Code');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `ftp_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Ftp Allocation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `irb_model_id` SET TAGS ('dbx_business_glossary_term' = 'Irb Model Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan ID');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `cecl_pool_classification` SET TAGS ('dbx_business_glossary_term' = 'Current Expected Credit Loss (CECL) Pool Classification');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `collateral_value` SET TAGS ('dbx_business_glossary_term' = 'Collateral Value');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `collateral_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `collateral_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `collective_assessment_flag` SET TAGS ('dbx_business_glossary_term' = 'Collective Assessment Flag');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `cure_status` SET TAGS ('dbx_business_glossary_term' = 'Cure Status');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `cure_status` SET TAGS ('dbx_value_regex' = 'not_applicable|probation|cured|re_defaulted');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due (DPD)');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `default_flag` SET TAGS ('dbx_business_glossary_term' = 'Default Flag');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Effective Interest Rate (EIR) Discount Rate');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `ead_amount` SET TAGS ('dbx_business_glossary_term' = 'Exposure at Default (EAD) Amount');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `ead_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `ead_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `ecl_12month_amount` SET TAGS ('dbx_business_glossary_term' = '12-Month Expected Credit Loss (ECL) Amount');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `ecl_12month_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `ecl_12month_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `ecl_lifetime_amount` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Expected Credit Loss (ECL) Amount');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `ecl_lifetime_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `ecl_lifetime_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `forbearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Forbearance Flag');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `ifrs9_stage` SET TAGS ('dbx_business_glossary_term' = 'IFRS 9 Impairment Stage');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `ifrs9_stage` SET TAGS ('dbx_value_regex' = 'stage_1|stage_2|stage_3');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `lgd_estimate` SET TAGS ('dbx_business_glossary_term' = 'Loss Given Default (LGD) Estimate');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Value (LTV) Ratio');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `macro_overlay_factor` SET TAGS ('dbx_business_glossary_term' = 'Macroeconomic Overlay Factor');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `macro_scenario_weight` SET TAGS ('dbx_business_glossary_term' = 'Macroeconomic Scenario Probability Weight');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `npl_classification` SET TAGS ('dbx_business_glossary_term' = 'Non-Performing Loan (NPL) Classification');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `npl_classification` SET TAGS ('dbx_value_regex' = 'performing|watch|substandard|doubtful|loss');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `npl_entry_date` SET TAGS ('dbx_business_glossary_term' = 'Non-Performing Loan (NPL) Entry Date');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `origination_date` SET TAGS ('dbx_business_glossary_term' = 'Origination Date');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `pd_12month` SET TAGS ('dbx_business_glossary_term' = '12-Month Probability of Default (PD)');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `pd_lifetime` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Probability of Default (PD)');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `poci_flag` SET TAGS ('dbx_business_glossary_term' = 'Purchased or Originated Credit-Impaired (POCI) Flag');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `portfolio_segment` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Segment');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `portfolio_segment` SET TAGS ('dbx_value_regex' = 'retail|corporate|sme|sovereign|financial_institution|other');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Product Type');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `provision_amount` SET TAGS ('dbx_business_glossary_term' = 'Provision Amount');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `provision_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `provision_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `provision_movement_amount` SET TAGS ('dbx_business_glossary_term' = 'Provision Movement Amount');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `provision_movement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `provision_movement_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `provision_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Provision Reference Number');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `provision_status` SET TAGS ('dbx_business_glossary_term' = 'Provision Status');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `provision_status` SET TAGS ('dbx_value_regex' = 'active|reversed|written_off|transferred|under_review');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `recovery_expectation_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Expectation Amount');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `recovery_expectation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `recovery_expectation_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `reporting_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Date');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `sicr_flag` SET TAGS ('dbx_business_glossary_term' = 'Significant Increase in Credit Risk (SICR) Flag');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `stage_migration_date` SET TAGS ('dbx_business_glossary_term' = 'Stage Migration Date');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_ecl_provision` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` SET TAGS ('dbx_subdomain' = 'credit_management');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `irb_model_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Ratings-Based (IRB) Model ID');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `compliance_sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Sox Control Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Model Developer ID');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `primary_irb_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Model Owner ID');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `primary_irb_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `primary_irb_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'IRB Asset Class');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `auc_roc` SET TAGS ('dbx_business_glossary_term' = 'Area Under the ROC Curve (AUC-ROC)');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `backtesting_date` SET TAGS ('dbx_business_glossary_term' = 'Most Recent Backtesting Date');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `backtesting_result` SET TAGS ('dbx_business_glossary_term' = 'Model Backtesting Result (RAG Status)');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `backtesting_result` SET TAGS ('dbx_value_regex' = 'Green|Amber|Red');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `brier_score` SET TAGS ('dbx_business_glossary_term' = 'Brier Score (Calibration Accuracy)');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `default_definition` SET TAGS ('dbx_business_glossary_term' = 'Default Definition');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `downturn_lgd` SET TAGS ('dbx_business_glossary_term' = 'Downturn Loss Given Default (LGD)');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `ead_ccf_estimate` SET TAGS ('dbx_business_glossary_term' = 'Exposure at Default (EAD) Credit Conversion Factor (CCF) Estimate');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Model Effective From Date');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Model Effective Until Date');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `gini_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Gini Coefficient (Discriminatory Power)');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `last_validation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Model Validation Date');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `lgd_in_default` SET TAGS ('dbx_business_glossary_term' = 'Loss Given Default (LGD) In-Default Estimate');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `long_run_average_pd` SET TAGS ('dbx_business_glossary_term' = 'Long-Run Average Probability of Default (PD)');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `macroeconomic_scenario` SET TAGS ('dbx_business_glossary_term' = 'Macroeconomic Conditioning Scenario');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `model_approach` SET TAGS ('dbx_business_glossary_term' = 'IRB Approach (F-IRB / A-IRB)');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `model_approach` SET TAGS ('dbx_value_regex' = 'Foundation-IRB|Advanced-IRB');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `model_code` SET TAGS ('dbx_business_glossary_term' = 'IRB Model Code');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `model_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `model_methodology` SET TAGS ('dbx_business_glossary_term' = 'Model Methodology Description');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'IRB Model Name');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `model_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Model Risk Rating');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `model_risk_rating` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `model_status` SET TAGS ('dbx_business_glossary_term' = 'IRB Model Lifecycle Status');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `model_status` SET TAGS ('dbx_value_regex' = 'Active|Under-Review|Deprecated|Pending-Approval|Rejected');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'IRB Model Type (PD/LGD/EAD/CCF)');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'PD|LGD|EAD|CCF');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'IRB Model Version');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `model_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `next_validation_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Model Validation Date');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `number_of_rating_grades` SET TAGS ('dbx_business_glossary_term' = 'Number of Rating Grades');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `observation_period_end` SET TAGS ('dbx_business_glossary_term' = 'Model Observation Period End Date');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `observation_period_start` SET TAGS ('dbx_business_glossary_term' = 'Model Observation Period Start Date');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `override_count` SET TAGS ('dbx_business_glossary_term' = 'Model Override Count');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `override_rate` SET TAGS ('dbx_business_glossary_term' = 'Model Override Rate');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `pd_estimation_approach` SET TAGS ('dbx_business_glossary_term' = 'Probability of Default (PD) Estimation Approach');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `pd_estimation_approach` SET TAGS ('dbx_value_regex' = 'Point-in-Time|Through-the-Cycle|Hybrid');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `pd_floor` SET TAGS ('dbx_business_glossary_term' = 'Probability of Default (PD) Regulatory Floor');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `rating_scale_type` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale Type');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `rating_scale_type` SET TAGS ('dbx_value_regex' = 'Numeric|Alphanumeric|Letter-Grade');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'Approved|Conditional|Pending|Not-Submitted|Withdrawn');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `source_system_model_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Model Identifier');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `use_in_ecl_calculation` SET TAGS ('dbx_business_glossary_term' = 'Used in Expected Credit Loss (ECL) Calculation Flag');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `use_in_rwa_calculation` SET TAGS ('dbx_business_glossary_term' = 'Used in Risk-Weighted Assets (RWA) Calculation Flag');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `validation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Model Validation Outcome');
ALTER TABLE `banking_ecm`.`risk`.`irb_model` ALTER COLUMN `validation_outcome` SET TAGS ('dbx_value_regex' = 'Pass|Pass-with-Conditions|Fail|In-Progress');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` SET TAGS ('dbx_subdomain' = 'credit_management');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating ID');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country of Risk');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Exposure at Default (EAD) Currency');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Analyst ID');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector Code');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `irb_model_id` SET TAGS ('dbx_business_glossary_term' = 'Probability of Default (PD) Model ID');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `analyst_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Analyst Override Flag');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Basel III Asset Class');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `default_date` SET TAGS ('dbx_business_glossary_term' = 'Default Date');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `default_flag` SET TAGS ('dbx_business_glossary_term' = 'Default Flag');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `ead` SET TAGS ('dbx_business_glossary_term' = 'Exposure at Default (EAD)');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `ead` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `ecl_stage` SET TAGS ('dbx_business_glossary_term' = 'Expected Credit Loss (ECL) Stage');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `ecl_stage` SET TAGS ('dbx_value_regex' = 'stage_1|stage_2|stage_3');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Effective Date');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Expiry Date');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `external_rating_date` SET TAGS ('dbx_business_glossary_term' = 'External Rating Date');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `fitch_rating` SET TAGS ('dbx_business_glossary_term' = 'Fitch Credit Rating');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `fitch_rating` SET TAGS ('dbx_value_regex' = '^(AAA|AA+|AA|AA-|A+|A|A-|BBB+|BBB|BBB-|BB+|BB|BB-|B+|B|B-|CCC+|CCC|CCC-|CC|C|RD|D|NR|WR)$');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `lgd` SET TAGS ('dbx_business_glossary_term' = 'Loss Given Default (LGD)');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `lgd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `moodys_rating` SET TAGS ('dbx_business_glossary_term' = 'Moodys Credit Rating');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `moodys_rating` SET TAGS ('dbx_value_regex' = '^(Aaa|Aa1|Aa2|Aa3|A1|A2|A3|Baa1|Baa2|Baa3|Ba1|Ba2|Ba3|B1|B2|B3|Caa1|Caa2|Caa3|Ca|C|NR|WR)$');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Rating Review Date');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `override_direction` SET TAGS ('dbx_business_glossary_term' = 'Override Direction');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `override_direction` SET TAGS ('dbx_value_regex' = 'upgrade|downgrade');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `pd` SET TAGS ('dbx_business_glossary_term' = 'Probability of Default (PD)');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `pd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `prior_rating_code` SET TAGS ('dbx_business_glossary_term' = 'Prior Internal Rating Grade Code');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `prior_rating_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `prior_rating_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Rating Date');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `rating_approach` SET TAGS ('dbx_business_glossary_term' = 'Rating Approach');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `rating_approach` SET TAGS ('dbx_value_regex' = 'IRB|SA|FIRB|AIRB');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `rating_code` SET TAGS ('dbx_business_glossary_term' = 'Internal Rating Grade Code');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `rating_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `rating_committee_approval` SET TAGS ('dbx_business_glossary_term' = 'Rating Committee Approval Flag');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `rating_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Assignment Date');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `rating_description` SET TAGS ('dbx_business_glossary_term' = 'Internal Rating Grade Description');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `rating_methodology` SET TAGS ('dbx_business_glossary_term' = 'Rating Methodology');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `rating_model_version` SET TAGS ('dbx_business_glossary_term' = 'Rating Model Version');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `rating_model_version` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._-]{1,30}$');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `rating_outlook` SET TAGS ('dbx_business_glossary_term' = 'Rating Outlook');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `rating_outlook` SET TAGS ('dbx_value_regex' = 'positive|stable|negative|developing');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `rating_status` SET TAGS ('dbx_business_glossary_term' = 'Rating Status');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `rating_status` SET TAGS ('dbx_value_regex' = 'active|under_review|withdrawn|expired|override');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `rating_trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Rating Trigger Event');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `rating_type` SET TAGS ('dbx_business_glossary_term' = 'Rating Type');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `rating_type` SET TAGS ('dbx_value_regex' = 'obligor|facility|issuer|issue|counterparty');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `rwa_risk_weight` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) Risk Weight');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,30}$');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `sp_rating` SET TAGS ('dbx_business_glossary_term' = 'S&P Credit Rating');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `sp_rating` SET TAGS ('dbx_value_regex' = '^(AAA|AA+|AA|AA-|A+|A|A-|BBB+|BBB|BBB-|BB+|BB|BB-|B+|B|B-|CCC+|CCC|CCC-|CC|C|D|NR|WR)$');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `watch_status` SET TAGS ('dbx_business_glossary_term' = 'Rating Watch Status');
ALTER TABLE `banking_ecm`.`risk`.`counterparty_rating` ALTER COLUMN `watch_status` SET TAGS ('dbx_value_regex' = 'none|positive_watch|negative_watch|evolving_watch');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` SET TAGS ('dbx_subdomain' = 'market_analysis');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario ID');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `primary_superseded_by_stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Scenario ID');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `source_scenario_stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Source System Scenario Identifier');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `stress_scenario_cfp_id` SET TAGS ('dbx_business_glossary_term' = 'Treasury Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Scenario Approval Date');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Scenario Approval Status');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|superseded|archived');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Scenario Approving Authority');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `cet1_floor_pct` SET TAGS ('dbx_business_glossary_term' = 'Common Equity Tier 1 (CET1) Minimum Floor Percentage');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `cre_price_shock_pct` SET TAGS ('dbx_business_glossary_term' = 'Commercial Real Estate (CRE) Price Shock Percentage');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `credit_spread_shock_bps` SET TAGS ('dbx_business_glossary_term' = 'Credit Spread Shock (Basis Points)');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Scenario Effective Date');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `equity_price_shock_pct` SET TAGS ('dbx_business_glossary_term' = 'Equity Price Shock Percentage');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Scenario Expiry Date');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `fx_shock_pct` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Shock Percentage');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `gdp_growth_shock_pct` SET TAGS ('dbx_business_glossary_term' = 'Gross Domestic Product (GDP) Growth Shock Percentage');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Geographic Scope');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|domestic|regional|legal_entity_specific');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `hpi_shock_pct` SET TAGS ('dbx_business_glossary_term' = 'House Price Index (HPI) Shock Percentage');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `inflation_rate_shock_pct` SET TAGS ('dbx_business_glossary_term' = 'Inflation Rate Shock Percentage');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `is_board_approved` SET TAGS ('dbx_business_glossary_term' = 'Board Approved Scenario Indicator');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `is_regulatory_prescribed` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Prescribed Scenario Indicator');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `is_reverse_stress` SET TAGS ('dbx_business_glossary_term' = 'Reverse Stress Test Indicator');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `lcr_floor_pct` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Coverage Ratio (LCR) Floor Percentage');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `legal_entity_scope` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Scope');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `lgd_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Loss Given Default (LGD) Stress Multiplier');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `line_of_business_scope` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB) Scope');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `long_term_rate_shock_bps` SET TAGS ('dbx_business_glossary_term' = 'Long-Term Interest Rate Shock (Basis Points)');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `pd_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Probability of Default (PD) Stress Multiplier');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Stress Testing Program');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `rwa_scalar` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) Stress Scalar');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `scenario_code` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Code');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `scenario_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `scenario_description` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Description');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `scenario_horizon_quarters` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Horizon (Quarters)');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Name');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `scenario_severity` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Severity Level');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `scenario_severity` SET TAGS ('dbx_value_regex' = 'baseline|adverse|severely_adverse|reverse_stress|exploratory');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `scenario_source` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Source Authority');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `scenario_type` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Type');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `scenario_vintage` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Vintage');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `scenario_vintage` SET TAGS ('dbx_value_regex' = '^[0-9]{4}(Q[1-4])?$');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `short_term_rate_shock_bps` SET TAGS ('dbx_business_glossary_term' = 'Short-Term Interest Rate Shock (Basis Points)');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `unemployment_rate_shock_pct` SET TAGS ('dbx_business_glossary_term' = 'Unemployment Rate Shock Percentage');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`stress_scenario` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Scenario Version Number');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` SET TAGS ('dbx_subdomain' = 'market_analysis');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stress_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Run ID');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `alco_meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Alco Meeting Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario ID');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Approval Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Approved By');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `as_of_date` SET TAGS ('dbx_business_glossary_term' = 'Stress Test As-Of Date');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `capital_action_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Capital Action Restriction Flag');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `executed_by` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Executed By');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `irb_approach_flag` SET TAGS ('dbx_business_glossary_term' = 'Internal Ratings-Based (IRB) Approach Flag');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Version');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `model_version` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._-]{1,30}$');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `portfolio_scope_code` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Scope Code');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `projection_end_date` SET TAGS ('dbx_business_glossary_term' = 'Stress Projection End Date');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `regulatory_outcome` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Stress Test Outcome');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `regulatory_outcome` SET TAGS ('dbx_value_regex' = 'pass|conditional_pass|fail|objection|no_objection|pending');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Stress Testing Program');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `run_code` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Run Code');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `run_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,50}$');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `run_notes` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Run Notes');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Run Status');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|completed|failed|submitted|superseded');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Run Execution Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Run Type');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `run_type` SET TAGS ('dbx_value_regex' = 'regulatory|internal|parallel|ad_hoc|restatement');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Name');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `scenario_type` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Type');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `scenario_type` SET TAGS ('dbx_value_regex' = 'baseline|adverse|severely_adverse|internal|reverse|sensitivity');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stress_capital_buffer_pct` SET TAGS ('dbx_business_glossary_term' = 'Stress Capital Buffer Percentage');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stress_capital_buffer_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stress_horizon_quarters` SET TAGS ('dbx_business_glossary_term' = 'Stress Horizon (Quarters)');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_cet1_ratio` SET TAGS ('dbx_business_glossary_term' = 'Stressed Common Equity Tier 1 (CET1) Capital Ratio');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_cet1_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_cva_amount` SET TAGS ('dbx_business_glossary_term' = 'Stressed Credit Valuation Adjustment (CVA) Amount');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_cva_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_ecl_amount` SET TAGS ('dbx_business_glossary_term' = 'Stressed Expected Credit Loss (ECL) Amount');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_ecl_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_lcr_ratio` SET TAGS ('dbx_business_glossary_term' = 'Stressed Liquidity Coverage Ratio (LCR)');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_lcr_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_leverage_ratio` SET TAGS ('dbx_business_glossary_term' = 'Stressed Tier 1 Leverage Ratio');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_leverage_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_nii_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Stressed Net Interest Income (NII) Impact Amount');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_nii_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_nim_bps` SET TAGS ('dbx_business_glossary_term' = 'Stressed Net Interest Margin (NIM) Impact (Basis Points)');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_nim_bps` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_nsfr_ratio` SET TAGS ('dbx_business_glossary_term' = 'Stressed Net Stable Funding Ratio (NSFR)');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_nsfr_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_ppnr_amount` SET TAGS ('dbx_business_glossary_term' = 'Stressed Pre-Provision Net Revenue (PPNR) Amount');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_ppnr_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_rwa_amount` SET TAGS ('dbx_business_glossary_term' = 'Stressed Risk-Weighted Assets (RWA) Amount');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_rwa_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_tier1_ratio` SET TAGS ('dbx_business_glossary_term' = 'Stressed Tier 1 Capital Ratio');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_tier1_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_total_capital_ratio` SET TAGS ('dbx_business_glossary_term' = 'Stressed Total Capital Ratio');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_total_capital_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_var_amount` SET TAGS ('dbx_business_glossary_term' = 'Stressed Value at Risk (VaR) Amount');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `stressed_var_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Reference Number');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` SET TAGS ('dbx_subdomain' = 'liquidity_governance');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `liquidity_metric_id` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Metric ID');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `appetite_id` SET TAGS ('dbx_business_glossary_term' = 'Appetite Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `liquidity_ratio_id` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Ratio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `reporting_unit_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Unit ID');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `alco_review_status` SET TAGS ('dbx_business_glossary_term' = 'Asset-Liability Committee (ALCO) Review Status');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `alco_review_status` SET TAGS ('dbx_value_regex' = 'PENDING|REVIEWED|ESCALATED|APPROVED');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `available_stable_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Available Stable Funding (ASF) Amount');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `available_stable_funding_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `breach_severity` SET TAGS ('dbx_business_glossary_term' = 'Breach Severity');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `breach_severity` SET TAGS ('dbx_value_regex' = 'NONE|MINOR|MODERATE|SEVERE|CRITICAL');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `calculation_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Run Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `calculation_status` SET TAGS ('dbx_business_glossary_term' = 'Calculation Status');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `calculation_status` SET TAGS ('dbx_value_regex' = 'PRELIMINARY|FINAL|RESTATED|UNDER_REVIEW|APPROVED');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `central_bank_eligible_amount` SET TAGS ('dbx_business_glossary_term' = 'Central Bank Eligible Assets Amount');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `central_bank_eligible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Metric Comments');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `committed_facility_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Facility Outflow Amount');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `committed_facility_outflow_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `consolidation_scope` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Scope');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `consolidation_scope` SET TAGS ('dbx_value_regex' = 'SOLO|CONSOLIDATED|SUB_CONSOLIDATED');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `encumbered_assets_amount` SET TAGS ('dbx_business_glossary_term' = 'Encumbered Assets Amount');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `encumbered_assets_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `gross_cash_inflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Cash Inflow Amount');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `gross_cash_inflow_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `gross_cash_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Cash Outflow Amount');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `gross_cash_outflow_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `hqla_amount` SET TAGS ('dbx_business_glossary_term' = 'High Quality Liquid Assets (HQLA) Amount');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `hqla_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `hqla_level1_amount` SET TAGS ('dbx_business_glossary_term' = 'High Quality Liquid Assets (HQLA) Level 1 Amount');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `hqla_level1_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `hqla_level2a_amount` SET TAGS ('dbx_business_glossary_term' = 'High Quality Liquid Assets (HQLA) Level 2A Amount');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `hqla_level2a_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `hqla_level2b_amount` SET TAGS ('dbx_business_glossary_term' = 'High Quality Liquid Assets (HQLA) Level 2B Amount');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `hqla_level2b_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `intraday_available_liquidity_amount` SET TAGS ('dbx_business_glossary_term' = 'Intraday Available Liquidity Amount');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `intraday_available_liquidity_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `intraday_peak_liquidity_amount` SET TAGS ('dbx_business_glossary_term' = 'Intraday Peak Liquidity Amount');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `intraday_peak_liquidity_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `is_breach` SET TAGS ('dbx_business_glossary_term' = 'Is Regulatory Breach Indicator');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `lcr_buffer_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Coverage Ratio (LCR) Buffer Amount');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `lcr_buffer_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `lcr_ratio` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Coverage Ratio (LCR)');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `lcr_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `lcr_regulatory_minimum` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Coverage Ratio (LCR) Regulatory Minimum');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `liquidity_transfer_restriction` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Transfer Restriction');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `liquidity_transfer_restriction` SET TAGS ('dbx_value_regex' = 'NONE|PARTIAL|FULL');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `metric_date` SET TAGS ('dbx_business_glossary_term' = 'Metric Date');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `metric_type` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Metric Type');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `metric_type` SET TAGS ('dbx_value_regex' = 'LCR|NSFR|INTRADAY|SURVIVAL_HORIZON|STRESS');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `net_cash_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Cash Outflow Amount');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `net_cash_outflow_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `nsfr_ratio` SET TAGS ('dbx_business_glossary_term' = 'Net Stable Funding Ratio (NSFR)');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `nsfr_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `nsfr_regulatory_minimum` SET TAGS ('dbx_business_glossary_term' = 'Net Stable Funding Ratio (NSFR) Regulatory Minimum');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_value_regex' = 'US|UK|EU|OTHER');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'DAILY|WEEKLY|MONTHLY|QUARTERLY');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `required_stable_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Required Stable Funding (RSF) Amount');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `required_stable_funding_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `retail_deposit_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Retail Deposit Outflow Amount');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `retail_deposit_outflow_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `survival_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Survival Horizon (Days)');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `survival_horizon_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `unencumbered_assets_amount` SET TAGS ('dbx_business_glossary_term' = 'Unencumbered Assets Amount');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `unencumbered_assets_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `wholesale_funding_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Funding Outflow Amount');
ALTER TABLE `banking_ecm`.`risk`.`liquidity_metric` ALTER COLUMN `wholesale_funding_outflow_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` SET TAGS ('dbx_subdomain' = 'operational_oversight');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `operational_risk_event_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event ID');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Breach Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Loss Currency Code');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `exam_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Exam Finding Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `primary_operational_event_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Event Owner Employee ID');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `primary_operational_event_owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `primary_operational_event_owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `accounting_date` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event Accounting Date');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `affected_product_line` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Line');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `basel_event_type_category` SET TAGS ('dbx_business_glossary_term' = 'Basel Event Type Category');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `basel_event_type_level2` SET TAGS ('dbx_business_glossary_term' = 'Basel Event Type Level 2 Sub-Category');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `business_line_code` SET TAGS ('dbx_business_glossary_term' = 'Basel Business Line Code');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `causal_factor_code` SET TAGS ('dbx_business_glossary_term' = 'Causal Factor Code');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `ccar_dfast_applicable_indicator` SET TAGS ('dbx_business_glossary_term' = 'Comprehensive Capital Analysis and Review / Dodd-Frank Act Stress Testing (CCAR/DFAST) Applicable Indicator');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `control_failure_type` SET TAGS ('dbx_business_glossary_term' = 'Control Failure Type');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `control_failure_type` SET TAGS ('dbx_value_regex' = 'design_failure|operating_failure|no_control|override|circumvention');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_required|planned|in_progress|completed|overdue');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event Discovery Date');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event Date');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event Description');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `event_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `event_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event Reference Number');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event Status');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'open|under_review|closed|near_miss|pending_recovery');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `event_title` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event Title');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `event_title` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `external_loss_database_reference` SET TAGS ('dbx_business_glossary_term' = 'External Loss Database Reference');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `gross_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Loss Amount');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `gross_loss_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `gross_loss_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `insurance_recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Recovery Amount');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `insurance_recovery_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `insurance_recovery_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `legal_action_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Action Status');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `legal_action_status` SET TAGS ('dbx_value_regex' = 'none|threatened|filed|settled|judgment|dismissed');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `legal_provision_amount` SET TAGS ('dbx_business_glossary_term' = 'Legal Provision Amount');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `legal_provision_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `legal_provision_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `loss_recovery_date` SET TAGS ('dbx_business_glossary_term' = 'Loss Recovery Date');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `loss_threshold_met_indicator` SET TAGS ('dbx_business_glossary_term' = 'Loss Threshold Met Indicator');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `near_miss_indicator` SET TAGS ('dbx_business_glossary_term' = 'Near-Miss Indicator');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `net_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Loss Amount');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `net_loss_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `net_loss_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `regulatory_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Reference');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `regulatory_reportable_indicator` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Indicator');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'people|process|system|external_event');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `sma_loss_component` SET TAGS ('dbx_business_glossary_term' = 'Standardized Measurement Approach (SMA) Loss Component');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `sma_loss_component` SET TAGS ('dbx_value_regex' = 'loss_component|recovery_component|timing_adjustment');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`risk`.`operational_risk_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` SET TAGS ('dbx_subdomain' = 'liquidity_governance');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `kri_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Key Risk Indicator (KRI) Measurement ID');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `appetite_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Statement ID');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `liquidity_position_id` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'KRI Actual Measured Value');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `amber_threshold` SET TAGS ('dbx_business_glossary_term' = 'Amber (Warning) Threshold');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Approval Status');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `breach_status` SET TAGS ('dbx_business_glossary_term' = 'KRI Breach Status');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `breach_status` SET TAGS ('dbx_value_regex' = 'green|amber|red');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'KRI Calculation Methodology');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `commentary` SET TAGS ('dbx_business_glossary_term' = 'KRI Measurement Commentary');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'passed|warning|failed|under_review');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `escalation_authority` SET TAGS ('dbx_business_glossary_term' = 'Escalation Authority');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `escalation_status` SET TAGS ('dbx_business_glossary_term' = 'Escalation Status');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `escalation_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|resolved|overdue');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `green_threshold` SET TAGS ('dbx_business_glossary_term' = 'Green (Acceptable) Threshold');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `is_board_reported` SET TAGS ('dbx_business_glossary_term' = 'Is Board Reported Flag');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `is_regulatory_kri` SET TAGS ('dbx_business_glossary_term' = 'Is Regulatory KRI Flag');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `kri_code` SET TAGS ('dbx_business_glossary_term' = 'Key Risk Indicator (KRI) Code');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `kri_code` SET TAGS ('dbx_value_regex' = '^KRI-[A-Z]{2,10}-[0-9]{4}$');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `kri_name` SET TAGS ('dbx_business_glossary_term' = 'Key Risk Indicator (KRI) Name');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `kri_owner_name` SET TAGS ('dbx_business_glossary_term' = 'KRI Owner Name');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `kri_owner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `kri_owner_role` SET TAGS ('dbx_business_glossary_term' = 'KRI Owner Role');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `legal_entity` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'KRI Measurement Date');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'KRI Measurement Frequency');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `measurement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `measurement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `owning_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Owning Business Unit');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `prior_period_value` SET TAGS ('dbx_business_glossary_term' = 'Prior Period KRI Value');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `red_threshold` SET TAGS ('dbx_business_glossary_term' = 'Red (Breach) Threshold');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Description');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `risk_sub_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Sub-Category');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `stress_scenario_flag` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Flag');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `stress_scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Name');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `threshold_direction` SET TAGS ('dbx_business_glossary_term' = 'Threshold Direction');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `threshold_direction` SET TAGS ('dbx_value_regex' = 'higher_is_worse|lower_is_worse|range_bound');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `trend_direction` SET TAGS ('dbx_business_glossary_term' = 'KRI Trend Direction');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `trend_direction` SET TAGS ('dbx_value_regex' = 'improving|stable|deteriorating');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `banking_ecm`.`risk`.`kri_measurement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` SET TAGS ('dbx_subdomain' = 'credit_management');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `model_validation_id` SET TAGS ('dbx_business_glossary_term' = 'Model Validation ID');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Validator ID');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `irb_model_id` SET TAGS ('dbx_business_glossary_term' = 'Model ID');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `valuation_model_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Model Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `backtesting_exceptions_count` SET TAGS ('dbx_business_glossary_term' = 'Backtesting Exceptions Count');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `backtesting_result` SET TAGS ('dbx_business_glossary_term' = 'Backtesting Result (Traffic Light)');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `backtesting_result` SET TAGS ('dbx_value_regex' = 'green|amber|red');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `benchmarking_outcome` SET TAGS ('dbx_business_glossary_term' = 'Benchmarking Outcome');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `benchmarking_outcome` SET TAGS ('dbx_value_regex' = 'consistent|conservative|aggressive|inconclusive');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `conceptual_soundness_rating` SET TAGS ('dbx_business_glossary_term' = 'Conceptual Soundness Rating');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `conceptual_soundness_rating` SET TAGS ('dbx_value_regex' = 'satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `data_quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Rating');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `data_quality_rating` SET TAGS ('dbx_value_regex' = 'satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `is_regulatory_capital_model` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Capital Model Flag');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `kupiec_test_result` SET TAGS ('dbx_business_glossary_term' = 'Kupiec Proportion of Failures (POF) Test Result');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `kupiec_test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|inconclusive');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `legal_entity` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `materiality_assessment` SET TAGS ('dbx_business_glossary_term' = 'Model Risk Materiality Assessment');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `materiality_assessment` SET TAGS ('dbx_value_regex' = 'material|non_material|potentially_material');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `model_limitations_summary` SET TAGS ('dbx_business_glossary_term' = 'Model Limitations Summary');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `model_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `mra_count` SET TAGS ('dbx_business_glossary_term' = 'Matters Requiring Attention (MRA) Count');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `mria_count` SET TAGS ('dbx_business_glossary_term' = 'Matters Requiring Immediate Attention (MRIA) Count');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `next_validation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Validation Due Date');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `observation_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Observation Window End Date');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `observation_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Observation Window Start Date');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `overall_outcome` SET TAGS ('dbx_business_glossary_term' = 'Overall Validation Outcome');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `overall_outcome` SET TAGS ('dbx_value_regex' = 'approved|approved_with_conditions|rejected|deferred');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Model Validation Rating');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Model Performance Rating');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected|conditional');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `regulatory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `remediation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Remediation Deadline');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|overdue');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `report_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Report Issued Date');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Validation Scope Description');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `sensitivity_analysis_outcome` SET TAGS ('dbx_business_glossary_term' = 'Sensitivity Analysis Outcome');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `sensitivity_analysis_outcome` SET TAGS ('dbx_value_regex' = 'stable|moderately_sensitive|highly_sensitive');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `total_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Total Validation Findings Count');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `use_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Model Use Approval Status');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `use_approval_status` SET TAGS ('dbx_value_regex' = 'approved|restricted|suspended|prohibited');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `use_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Model Use Restrictions');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `validation_code` SET TAGS ('dbx_business_glossary_term' = 'Model Validation Code');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `validation_code` SET TAGS ('dbx_value_regex' = '^MV-[A-Z0-9]{4,12}-[0-9]{4}$');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `validation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validation End Date');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `validation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Start Date');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|suspended|cancelled');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `validation_team` SET TAGS ('dbx_business_glossary_term' = 'Validation Team Name');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `validation_type` SET TAGS ('dbx_business_glossary_term' = 'Validation Type');
ALTER TABLE `banking_ecm`.`risk`.`model_validation` ALTER COLUMN `validation_type` SET TAGS ('dbx_value_regex' = 'initial|periodic|triggered|pre_implementation|post_implementation');
ALTER TABLE `banking_ecm`.`risk`.`assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`risk`.`assessment` SET TAGS ('dbx_subdomain' = 'credit_management');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment ID');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `appetite_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `assessment_assessor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor ID');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `assessment_assessor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `assessment_assessor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `assessment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner ID');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `assessment_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `assessment_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `exam_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Exam Finding Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `action_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Plan');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `assessment_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Code');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `assessment_code` SET TAGS ('dbx_value_regex' = '^RA-[A-Z]{2,10}-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Date');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Status');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|under_review|approved|closed|cancelled');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Type');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'enterprise_risk_assessment|rcsa|thematic_review|icaap|orsa');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `control_description` SET TAGS ('dbx_business_glossary_term' = 'Control Description');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Control Effectiveness Rating');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_value_regex' = 'strong|adequate|needs_improvement|inadequate');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'preventive|detective|corrective|directive');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Assessment Findings Summary');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Impact Rating');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `impact_rating` SET TAGS ('dbx_value_regex' = 'negligible|minor|moderate|major|catastrophic');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `inherent_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Rating');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `inherent_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `is_material_risk` SET TAGS ('dbx_business_glossary_term' = 'Material Risk Indicator');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `is_regulatory_finding` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Finding Indicator');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `kri_code` SET TAGS ('dbx_business_glossary_term' = 'Key Risk Indicator (KRI) Code');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `kri_code` SET TAGS ('dbx_value_regex' = '^KRI-[A-Z0-9]{2,15}$');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `last_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Control Test Date');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Code');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `likelihood_rating` SET TAGS ('dbx_business_glossary_term' = 'Likelihood Rating');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `likelihood_rating` SET TAGS ('dbx_value_regex' = 'rare|unlikely|possible|likely|almost_certain');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Assessment Methodology');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `methodology` SET TAGS ('dbx_value_regex' = 'qualitative|quantitative|hybrid|scenario_analysis|loss_data_analysis');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `process_name` SET TAGS ('dbx_business_glossary_term' = 'Business Process Name');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|overdue|deferred');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Rating');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'credit_risk|market_risk|operational_risk|liquidity_risk|compliance_risk|reputational_risk');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `risk_event_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Event Type');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `risk_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner Name');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `risk_owner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `risk_sub_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Sub-Category');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,30}$');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `testing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Control Testing Frequency');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `testing_frequency` SET TAGS ('dbx_value_regex' = 'continuous|daily|weekly|monthly|quarterly|annually');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `three_lines_defence_layer` SET TAGS ('dbx_business_glossary_term' = 'Three Lines of Defence Layer');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `three_lines_defence_layer` SET TAGS ('dbx_value_regex' = 'first_line|second_line|third_line');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`assessment` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Version Number');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` SET TAGS ('dbx_subdomain' = 'market_analysis');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `scenario_result_id` SET TAGS ('dbx_business_glossary_term' = 'Scenario Result ID');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User ID');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `factor_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `irb_model_id` SET TAGS ('dbx_business_glossary_term' = 'Irb Model Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario ID');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `stress_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Run ID');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `previous_scenario_result_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Breach Flag');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `breach_severity` SET TAGS ('dbx_business_glossary_term' = 'Breach Severity');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `breach_severity` SET TAGS ('dbx_value_regex' = 'none|minor|moderate|major|critical');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `capital_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Impact Amount');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `confidence_level_pct` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Percentage');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Code');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `portfolio_scope_code` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Scope Code');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `projection_date` SET TAGS ('dbx_business_glossary_term' = 'Projection Date');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `projection_quarter` SET TAGS ('dbx_business_glossary_term' = 'Projection Quarter');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `result_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Result Reference Number');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'draft|calculated|validated|approved|submitted|rejected');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `stressed_cet1_ratio` SET TAGS ('dbx_business_glossary_term' = 'Stressed Common Equity Tier 1 (CET1) Ratio');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `stressed_cva_amount` SET TAGS ('dbx_business_glossary_term' = 'Stressed Credit Valuation Adjustment (CVA) Amount');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `stressed_ecl_amount` SET TAGS ('dbx_business_glossary_term' = 'Stressed Expected Credit Loss (ECL) Amount');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `stressed_lcr_ratio` SET TAGS ('dbx_business_glossary_term' = 'Stressed Liquidity Coverage Ratio (LCR)');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `stressed_leverage_ratio` SET TAGS ('dbx_business_glossary_term' = 'Stressed Leverage Ratio');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `stressed_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Stressed Loss Amount');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `stressed_nii_amount` SET TAGS ('dbx_business_glossary_term' = 'Stressed Net Interest Income (NII) Amount');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `stressed_nim_bps` SET TAGS ('dbx_business_glossary_term' = 'Stressed Net Interest Margin (NIM) Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `stressed_nsfr_ratio` SET TAGS ('dbx_business_glossary_term' = 'Stressed Net Stable Funding Ratio (NSFR)');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `stressed_ppnr_amount` SET TAGS ('dbx_business_glossary_term' = 'Stressed Pre-Provision Net Revenue (PPNR) Amount');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `stressed_provision_amount` SET TAGS ('dbx_business_glossary_term' = 'Stressed Provision Amount');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `stressed_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Stressed Revenue Amount');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `stressed_rwa_amount` SET TAGS ('dbx_business_glossary_term' = 'Stressed Risk-Weighted Assets (RWA) Amount');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `stressed_tier1_ratio` SET TAGS ('dbx_business_glossary_term' = 'Stressed Tier 1 Capital Ratio');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `stressed_total_capital_ratio` SET TAGS ('dbx_business_glossary_term' = 'Stressed Total Capital Ratio');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `stressed_var_amount` SET TAGS ('dbx_business_glossary_term' = 'Stressed Value at Risk (VaR) Amount');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `banking_ecm`.`risk`.`scenario_result` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|override');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` SET TAGS ('dbx_subdomain' = 'credit_management');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `concentration_risk_id` SET TAGS ('dbx_business_glossary_term' = 'Concentration Risk ID');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `appetite_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Statement ID');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Exposure Currency Code');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector Code');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `primary_concentration_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner Employee ID');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `primary_concentration_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `primary_concentration_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `parent_concentration_risk_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `alco_review_date` SET TAGS ('dbx_business_glossary_term' = 'Asset-Liability Committee (ALCO) Review Date');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `alco_review_status` SET TAGS ('dbx_business_glossary_term' = 'Asset-Liability Committee (ALCO) Review Status');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `alco_review_status` SET TAGS ('dbx_value_regex' = 'pending|reviewed|approved|escalated');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `breach_date` SET TAGS ('dbx_business_glossary_term' = 'Breach Date');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `breach_severity` SET TAGS ('dbx_business_glossary_term' = 'Breach Severity');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `breach_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `breach_status` SET TAGS ('dbx_business_glossary_term' = 'Breach Status');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `breach_status` SET TAGS ('dbx_value_regex' = 'within_limit|warning_breach|limit_breach|regulatory_breach');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `cet1_capital_percentage` SET TAGS ('dbx_business_glossary_term' = 'Common Equity Tier 1 (CET1) Capital Percentage');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `collateral_type_code` SET TAGS ('dbx_business_glossary_term' = 'Collateral Type Code');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `commentary` SET TAGS ('dbx_business_glossary_term' = 'Risk Commentary');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `concentration_dimension` SET TAGS ('dbx_business_glossary_term' = 'Concentration Dimension');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `concentration_metric_name` SET TAGS ('dbx_business_glossary_term' = 'Concentration Metric Name');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `concentration_percentage` SET TAGS ('dbx_business_glossary_term' = 'Concentration Percentage');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `concentration_type` SET TAGS ('dbx_business_glossary_term' = 'Concentration Type');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `concentration_type` SET TAGS ('dbx_value_regex' = 'counterparty|industry|geography|product|collateral|currency');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `current_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Exposure Amount');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `excess_amount` SET TAGS ('dbx_business_glossary_term' = 'Excess Amount');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `exposure_reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Exposure Amount in Reporting Currency');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `fx_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `hhi_index_value` SET TAGS ('dbx_business_glossary_term' = 'Herfindahl-Hirschman Index (HHI) Value');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `is_large_exposure` SET TAGS ('dbx_business_glossary_term' = 'Is Large Exposure Flag');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `is_regulatory_reportable` SET TAGS ('dbx_business_glossary_term' = 'Is Regulatory Reportable Flag');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `limit_threshold` SET TAGS ('dbx_business_glossary_term' = 'Limit Threshold');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `measurement_reference` SET TAGS ('dbx_business_glossary_term' = 'Measurement Reference Number');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'draft|active|breached|remediated|expired');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `metric_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Metric Calculation Method');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `portfolio_segment` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Segment');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `product_type_code` SET TAGS ('dbx_business_glossary_term' = 'Product Type Code');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `regulatory_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Reference');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `regulatory_threshold` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Threshold');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_required|planned|in_progress|completed|overdue');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `rwa_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) Amount');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `threshold_direction` SET TAGS ('dbx_business_glossary_term' = 'Threshold Direction');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `threshold_direction` SET TAGS ('dbx_value_regex' = 'above|below');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `threshold_type` SET TAGS ('dbx_business_glossary_term' = 'Threshold Type');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `threshold_type` SET TAGS ('dbx_value_regex' = 'absolute|percentage|index|ratio');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `tier1_capital_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 Capital Percentage');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Utilization Percentage');
ALTER TABLE `banking_ecm`.`risk`.`concentration_risk` ALTER COLUMN `warning_threshold` SET TAGS ('dbx_business_glossary_term' = 'Warning Threshold');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` SET TAGS ('dbx_subdomain' = 'operational_oversight');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `risk_report_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Report ID');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `consent_order_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Order Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `stress_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Run Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `tertiary_risk_reviewed_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By User ID');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `tertiary_risk_reviewed_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `tertiary_risk_reviewed_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `previous_risk_report_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `audience_type` SET TAGS ('dbx_business_glossary_term' = 'Audience Type');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `cet1_ratio` SET TAGS ('dbx_business_glossary_term' = 'Common Equity Tier 1 (CET1) Ratio');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Distribution List');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `distribution_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `ecl_provision_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Credit Loss (ECL) Provision Amount');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `executive_summary` SET TAGS ('dbx_business_glossary_term' = 'Executive Summary');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Report Frequency');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `generation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Generation Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `key_findings` SET TAGS ('dbx_business_glossary_term' = 'Key Findings');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `lcr_ratio` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Coverage Ratio (LCR)');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Code');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `leverage_ratio` SET TAGS ('dbx_business_glossary_term' = 'Leverage Ratio');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `npl_ratio` SET TAGS ('dbx_business_glossary_term' = 'Non-Performing Loan (NPL) Ratio');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `nsfr_ratio` SET TAGS ('dbx_business_glossary_term' = 'Net Stable Funding Ratio (NSFR)');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Report Period End Date');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Report Period Start Date');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Flag');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `report_code` SET TAGS ('dbx_business_glossary_term' = 'Report Code');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `report_name` SET TAGS ('dbx_business_glossary_term' = 'Report Name');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|submitted|rejected|archived');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `reporting_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Date');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `reporting_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Unit Code');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `stressed_var_amount` SET TAGS ('dbx_business_glossary_term' = 'Stressed Value at Risk (Stressed VaR) Amount');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `submission_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Reference Number');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `tier1_ratio` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 Capital Ratio');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `total_capital_ratio` SET TAGS ('dbx_business_glossary_term' = 'Total Capital Ratio');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `total_rwa_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Risk-Weighted Assets (RWA) Amount');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `var_amount` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Amount');
ALTER TABLE `banking_ecm`.`risk`.`risk_report` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Report Version');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_factor_result` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_factor_result` SET TAGS ('dbx_subdomain' = 'market_analysis');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_factor_result` SET TAGS ('dbx_association_edges' = 'risk.stress_test_run,risk.risk_factor');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_factor_result` ALTER COLUMN `stress_test_factor_result_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Factor Result Identifier');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_factor_result` ALTER COLUMN `factor_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Factor Result - Risk Factor Id');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_factor_result` ALTER COLUMN `stress_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Factor Result - Stress Test Run Id');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_factor_result` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Factor Result Calculation Timestamp');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_factor_result` ALTER COLUMN `contribution_to_capital_impact` SET TAGS ('dbx_business_glossary_term' = 'Factor Contribution to Capital Impact');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_factor_result` ALTER COLUMN `contribution_to_ecl_impact` SET TAGS ('dbx_business_glossary_term' = 'Factor Contribution to ECL Impact');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_factor_result` ALTER COLUMN `contribution_to_rwa_impact` SET TAGS ('dbx_business_glossary_term' = 'Factor Contribution to RWA Impact');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_factor_result` ALTER COLUMN `factor_loading` SET TAGS ('dbx_business_glossary_term' = 'Factor Loading');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_factor_result` ALTER COLUMN `model_version_used` SET TAGS ('dbx_business_glossary_term' = 'Model Version Used for Factor Result');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_factor_result` ALTER COLUMN `sensitivity_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Factor Sensitivity Coefficient');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_factor_result` ALTER COLUMN `shock_direction` SET TAGS ('dbx_business_glossary_term' = 'Factor Shock Direction');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_factor_result` ALTER COLUMN `shock_magnitude` SET TAGS ('dbx_business_glossary_term' = 'Factor Shock Magnitude');
ALTER TABLE `banking_ecm`.`risk`.`stress_test_factor_result` ALTER COLUMN `stressed_value` SET TAGS ('dbx_business_glossary_term' = 'Stressed Factor Value');
ALTER TABLE `banking_ecm`.`risk`.`model_deployment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`risk`.`model_deployment` SET TAGS ('dbx_subdomain' = 'credit_management');
ALTER TABLE `banking_ecm`.`risk`.`model_deployment` SET TAGS ('dbx_association_edges' = 'risk.irb_model,ledger.legal_entity');
ALTER TABLE `banking_ecm`.`risk`.`model_deployment` ALTER COLUMN `model_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Model Deployment Identifier');
ALTER TABLE `banking_ecm`.`risk`.`model_deployment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Model Contact');
ALTER TABLE `banking_ecm`.`risk`.`model_deployment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`model_deployment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`risk`.`model_deployment` ALTER COLUMN `irb_model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Deployment - Irb Model Id');
ALTER TABLE `banking_ecm`.`risk`.`model_deployment` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Model Deployment - Legal Entity Id');
ALTER TABLE `banking_ecm`.`risk`.`model_deployment` ALTER COLUMN `deployment_date` SET TAGS ('dbx_business_glossary_term' = 'Model Deployment Date');
ALTER TABLE `banking_ecm`.`risk`.`model_deployment` ALTER COLUMN `deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status');
ALTER TABLE `banking_ecm`.`risk`.`model_deployment` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment Effective From Date');
ALTER TABLE `banking_ecm`.`risk`.`model_deployment` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment Effective Until Date');
ALTER TABLE `banking_ecm`.`risk`.`model_deployment` ALTER COLUMN `exposure_at_deployment` SET TAGS ('dbx_business_glossary_term' = 'Exposure at Deployment');
ALTER TABLE `banking_ecm`.`risk`.`model_deployment` ALTER COLUMN `last_validation_date` SET TAGS ('dbx_business_glossary_term' = 'Entity-Specific Validation Date');
ALTER TABLE `banking_ecm`.`risk`.`model_deployment` ALTER COLUMN `override_count` SET TAGS ('dbx_business_glossary_term' = 'Model Override Count');
ALTER TABLE `banking_ecm`.`risk`.`model_deployment` ALTER COLUMN `portfolio_scope` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Scope');
ALTER TABLE `banking_ecm`.`risk`.`model_deployment` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Entity-Specific Regulatory Approval Status');
ALTER TABLE `banking_ecm`.`risk`.`model_deployment` ALTER COLUMN `regulatory_comments` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Comments');
ALTER TABLE `banking_ecm`.`risk`.`model_deployment` ALTER COLUMN `rwa_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Asset Impact');
ALTER TABLE `banking_ecm`.`risk`.`valuation_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`risk`.`valuation_model` SET TAGS ('dbx_subdomain' = 'market_analysis');
ALTER TABLE `banking_ecm`.`risk`.`valuation_model` ALTER COLUMN `valuation_model_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Model Identifier');
ALTER TABLE `banking_ecm`.`risk`.`valuation_model` ALTER COLUMN `previous_valuation_model_id` SET TAGS ('dbx_self_ref_fk' = 'true');
