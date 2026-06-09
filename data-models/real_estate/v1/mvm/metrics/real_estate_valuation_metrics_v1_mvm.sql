-- Metric views for domain: valuation | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 04:45:11

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`valuation_appraisal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core appraisal KPIs tracking concluded market values, cap rates, IRR, NOI, and engagement economics across the appraisal portfolio. Used by valuation leadership to monitor portfolio value, appraiser performance, and methodology mix."
  source: "`real_estate_ecm`.`valuation`.`appraisal`"
  dimensions:
    - name: "appraisal_status"
      expr: appraisal_status
      comment: "Current workflow status of the appraisal (e.g. Draft, In Review, Completed, Cancelled) — used to filter active vs. closed engagements."
    - name: "appraisal_type"
      expr: appraisal_type
      comment: "Type of appraisal engagement (e.g. Full Appraisal, Desk Review, Update) — drives methodology and fee benchmarking."
    - name: "methodology"
      expr: methodology
      comment: "Valuation methodology applied (e.g. Income Approach, Sales Comparison, Cost Approach) — key for methodology mix analysis."
    - name: "value_type"
      expr: value_type
      comment: "Type of value concluded (e.g. Market Value, Investment Value, Liquidation Value) — critical for regulatory and investment reporting."
    - name: "report_type"
      expr: report_type
      comment: "Format of the appraisal report (e.g. Narrative, Restricted, Summary) — used for compliance and client segmentation."
    - name: "firm_name"
      expr: firm_name
      comment: "Name of the appraisal firm — enables vendor performance and concentration analysis."
    - name: "appraiser_credential"
      expr: appraiser_credential
      comment: "Professional credential of the appraiser (e.g. MAI, SRA, AI-GRS) — used for quality and compliance tracking."
    - name: "ivsc_compliant"
      expr: ivsc_compliant
      comment: "Flag indicating whether the appraisal conforms to IVSC standards — used for international regulatory reporting."
    - name: "uspap_compliant"
      expr: uspap_compliant
      comment: "Flag indicating whether the appraisal conforms to USPAP standards — required for US lending and regulatory compliance."
    - name: "value_date"
      expr: DATE_TRUNC('month', value_date)
      comment: "Month of the effective value date — used for time-series trending of portfolio valuations."
    - name: "engagement_date"
      expr: DATE_TRUNC('quarter', engagement_date)
      comment: "Quarter in which the appraisal engagement was initiated — used for pipeline and workload analysis."
    - name: "review_outcome"
      expr: review_outcome
      comment: "Outcome of the appraisal review process (e.g. Approved, Revised, Rejected) — used for quality control monitoring."
    - name: "purpose"
      expr: purpose
      comment: "Business purpose of the appraisal (e.g. Financing, Acquisition, Disposition, Financial Reporting) — drives use-case segmentation."
  measures:
    - name: "total_appraisals"
      expr: COUNT(1)
      comment: "Total number of appraisal engagements — baseline volume metric for workload and pipeline management."
    - name: "total_concluded_market_value"
      expr: SUM(CAST(concluded_market_value AS DOUBLE))
      comment: "Sum of all concluded market values across appraisals — represents total appraised portfolio value under management."
    - name: "avg_concluded_market_value"
      expr: AVG(CAST(concluded_market_value AS DOUBLE))
      comment: "Average concluded market value per appraisal — used to benchmark asset size and detect outliers."
    - name: "avg_cap_rate"
      expr: AVG(CAST(cap_rate AS DOUBLE))
      comment: "Average capitalization rate across appraisals — key investment yield indicator used by portfolio managers and investors."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate applied in DCF-based appraisals — reflects market risk assumptions and cost of capital benchmarks."
    - name: "avg_irr"
      expr: AVG(CAST(irr AS DOUBLE))
      comment: "Average internal rate of return across appraisals — used by investment committees to evaluate return expectations."
    - name: "avg_terminal_cap_rate"
      expr: AVG(CAST(terminal_cap_rate AS DOUBLE))
      comment: "Average terminal capitalization rate — reflects exit yield assumptions and long-term market sentiment."
    - name: "total_noi"
      expr: SUM(CAST(noi AS DOUBLE))
      comment: "Total net operating income across appraised assets — core income metric linking valuations to cash flow performance."
    - name: "avg_noi"
      expr: AVG(CAST(noi AS DOUBLE))
      comment: "Average NOI per appraisal — used to benchmark income productivity across the portfolio."
    - name: "total_npv"
      expr: SUM(CAST(npv AS DOUBLE))
      comment: "Total net present value across all appraisals — aggregate measure of discounted investment value."
    - name: "total_engagement_fees"
      expr: SUM(CAST(engagement_fee AS DOUBLE))
      comment: "Total appraisal engagement fees incurred — used for vendor cost management and budget tracking."
    - name: "avg_engagement_fee"
      expr: AVG(CAST(engagement_fee AS DOUBLE))
      comment: "Average engagement fee per appraisal — used to benchmark appraisal costs and negotiate vendor contracts."
    - name: "total_value_range_high"
      expr: SUM(CAST(value_range_high AS DOUBLE))
      comment: "Sum of upper-bound value estimates — represents the optimistic ceiling of total portfolio value."
    - name: "total_value_range_low"
      expr: SUM(CAST(value_range_low AS DOUBLE))
      comment: "Sum of lower-bound value estimates — represents the conservative floor of total portfolio value."
    - name: "distinct_appraisers"
      expr: COUNT(DISTINCT appraiser_license_number)
      comment: "Number of distinct licensed appraisers engaged — used for vendor diversity and concentration risk monitoring."
    - name: "distinct_firms"
      expr: COUNT(DISTINCT firm_name)
      comment: "Number of distinct appraisal firms engaged — used for panel management and vendor concentration analysis."
    - name: "uspap_compliant_count"
      expr: SUM(CASE WHEN uspap_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of USPAP-compliant appraisals — used for regulatory compliance reporting and lender requirements."
    - name: "ivsc_compliant_count"
      expr: SUM(CASE WHEN ivsc_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of IVSC-compliant appraisals — used for international reporting and cross-border investment compliance."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`valuation_appraisal_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appraisal report-level KPIs covering concluded values, income metrics, physical characteristics, and report quality. Used by valuation managers and compliance teams to monitor report quality, value conclusions, and methodology application."
  source: "`real_estate_ecm`.`valuation`.`appraisal_report`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Current status of the appraisal report (e.g. Draft, Final, Superseded) — used to filter active vs. archived reports."
    - name: "review_status"
      expr: review_status
      comment: "Review status of the report (e.g. Pending, Approved, Rejected) — used for quality control workflow tracking."
    - name: "valuation_approach"
      expr: valuation_approach
      comment: "Primary valuation approach used in the report (e.g. Income, Sales Comparison, Cost) — drives methodology mix analysis."
    - name: "value_type"
      expr: value_type
      comment: "Type of value concluded in the report (e.g. Market Value, As-Is, As-Stabilized) — critical for investment and lending decisions."
    - name: "report_format"
      expr: report_format
      comment: "Format of the report (e.g. Narrative, Restricted Use, Summary) — used for compliance and client segmentation."
    - name: "report_scenario"
      expr: report_scenario
      comment: "Scenario modeled in the report (e.g. Base Case, Upside, Downside) — used for sensitivity and scenario analysis."
    - name: "uspap_compliant"
      expr: uspap_compliant
      comment: "Flag indicating USPAP compliance of the report — required for US lending and regulatory compliance."
    - name: "effective_date"
      expr: DATE_TRUNC('quarter', effective_date)
      comment: "Quarter of the report effective date — used for time-series trending of portfolio valuations."
    - name: "report_date"
      expr: DATE_TRUNC('month', report_date)
      comment: "Month the report was issued — used for production volume and turnaround analysis."
    - name: "intended_use"
      expr: intended_use
      comment: "Intended use of the appraisal report (e.g. Financing, Acquisition, Financial Reporting) — drives use-case segmentation."
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of appraisal reports — baseline volume metric for production tracking."
    - name: "total_concluded_market_value"
      expr: SUM(CAST(concluded_market_value AS DOUBLE))
      comment: "Sum of concluded market values across all reports — represents total appraised portfolio value."
    - name: "avg_concluded_market_value"
      expr: AVG(CAST(concluded_market_value AS DOUBLE))
      comment: "Average concluded market value per report — used to benchmark asset size and detect valuation outliers."
    - name: "total_as_is_value"
      expr: SUM(CAST(as_is_value AS DOUBLE))
      comment: "Total as-is market value across reports — represents current-state portfolio value before any stabilization."
    - name: "total_as_stabilized_value"
      expr: SUM(CAST(as_stabilized_value AS DOUBLE))
      comment: "Total as-stabilized value across reports — represents projected portfolio value upon full stabilization, used for development and lease-up underwriting."
    - name: "avg_value_psf"
      expr: AVG(CAST(value_psf AS DOUBLE))
      comment: "Average value per square foot across reports — key per-unit pricing metric for market comparison and underwriting."
    - name: "avg_cap_rate_applied"
      expr: AVG(CAST(cap_rate_applied AS DOUBLE))
      comment: "Average capitalization rate applied in reports — reflects market yield assumptions used in income approach valuations."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate applied in DCF analyses — reflects cost of capital assumptions across the portfolio."
    - name: "avg_irr"
      expr: AVG(CAST(irr AS DOUBLE))
      comment: "Average IRR concluded in reports — used by investment committees to evaluate return expectations."
    - name: "avg_terminal_cap_rate"
      expr: AVG(CAST(terminal_cap_rate AS DOUBLE))
      comment: "Average terminal cap rate applied — reflects exit yield assumptions and long-term market sentiment."
    - name: "total_gross_building_area_sqf"
      expr: SUM(CAST(gross_building_area_sqf AS DOUBLE))
      comment: "Total gross building area across appraised properties — used for portfolio scale and density analysis."
    - name: "avg_gross_building_area_sqf"
      expr: AVG(CAST(gross_building_area_sqf AS DOUBLE))
      comment: "Average gross building area per report — used to benchmark asset size and compare value-per-sqft metrics."
    - name: "total_npv"
      expr: SUM(CAST(npv AS DOUBLE))
      comment: "Total net present value across all reports — aggregate measure of discounted investment value."
    - name: "uspap_compliant_count"
      expr: SUM(CASE WHEN uspap_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of USPAP-compliant reports — used for regulatory compliance and lender panel requirements."
    - name: "approved_reports_count"
      expr: SUM(CASE WHEN review_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Count of reports with approved review status — used to track quality gate pass rates."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`valuation_approach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Valuation approach-level KPIs covering concluded values, income metrics, cost components, and methodology weights. Used by valuation analysts and portfolio managers to evaluate approach-level accuracy, methodology mix, and income assumptions."
  source: "`real_estate_ecm`.`valuation`.`approach`"
  dimensions:
    - name: "approach_type"
      expr: approach_type
      comment: "Type of valuation approach (e.g. Income, Sales Comparison, Cost) — primary methodology classification for mix analysis."
    - name: "approach_status"
      expr: approach_status
      comment: "Current status of the approach (e.g. Draft, Approved, Superseded) — used to filter active vs. historical approaches."
    - name: "rent_basis"
      expr: rent_basis
      comment: "Rent basis used in income approach (e.g. NNN, Gross, Modified Gross) — drives income normalization and comparability."
    - name: "ivsc_methodology_code"
      expr: ivsc_methodology_code
      comment: "IVSC methodology code applied — used for international standards compliance and cross-border reporting."
    - name: "approach_date"
      expr: DATE_TRUNC('quarter', approach_date)
      comment: "Quarter the approach was performed — used for time-series trending of valuation assumptions."
    - name: "approved_date"
      expr: DATE_TRUNC('month', approved_date)
      comment: "Month the approach was approved — used for approval cycle time and workflow analysis."
  measures:
    - name: "total_approaches"
      expr: COUNT(1)
      comment: "Total number of valuation approaches — baseline volume metric for methodology mix analysis."
    - name: "total_concluded_value"
      expr: SUM(CAST(concluded_value AS DOUBLE))
      comment: "Sum of concluded values across all approaches — represents aggregate appraised value by methodology."
    - name: "avg_concluded_value"
      expr: AVG(CAST(concluded_value AS DOUBLE))
      comment: "Average concluded value per approach — used to benchmark approach-level value conclusions."
    - name: "avg_cap_rate"
      expr: AVG(CAST(cap_rate AS DOUBLE))
      comment: "Average capitalization rate applied in income approaches — key yield metric for portfolio benchmarking."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate applied in DCF approaches — reflects cost of capital assumptions."
    - name: "avg_irr"
      expr: AVG(CAST(irr AS DOUBLE))
      comment: "Average IRR across approaches — used by investment committees to evaluate return expectations."
    - name: "avg_terminal_cap_rate"
      expr: AVG(CAST(terminal_cap_rate AS DOUBLE))
      comment: "Average terminal cap rate — reflects exit yield assumptions used in DCF models."
    - name: "total_noi"
      expr: SUM(CAST(noi AS DOUBLE))
      comment: "Total net operating income across income approaches — core income metric linking valuations to cash flow."
    - name: "avg_noi"
      expr: AVG(CAST(noi AS DOUBLE))
      comment: "Average NOI per approach — used to benchmark income productivity across the portfolio."
    - name: "avg_vacancy_credit_loss_rate"
      expr: AVG(CAST(vacancy_credit_loss_rate AS DOUBLE))
      comment: "Average vacancy and credit loss rate applied — reflects market occupancy assumptions and credit risk in income models."
    - name: "avg_weight_pct"
      expr: AVG(CAST(weight_pct AS DOUBLE))
      comment: "Average weight assigned to each approach in the final value reconciliation — used to monitor methodology reliance."
    - name: "total_land_value"
      expr: SUM(CAST(land_value AS DOUBLE))
      comment: "Total land value across cost approaches — used for land allocation and development feasibility analysis."
    - name: "total_replacement_cost_new"
      expr: SUM(CAST(replacement_cost_new AS DOUBLE))
      comment: "Total replacement cost new across cost approaches — used for insurance valuation and capital planning."
    - name: "avg_physical_depreciation"
      expr: AVG(CAST(physical_depreciation AS DOUBLE))
      comment: "Average physical depreciation applied in cost approaches — reflects asset age and condition across the portfolio."
    - name: "avg_direct_cap_value"
      expr: AVG(CAST(direct_cap_value AS DOUBLE))
      comment: "Average direct capitalization value — used to compare direct cap vs. DCF value conclusions."
    - name: "avg_concluded_market_rent_psf"
      expr: AVG(CAST(concluded_market_rent_psf AS DOUBLE))
      comment: "Average concluded market rent per square foot — key leasing and income underwriting benchmark."
    - name: "avg_egi"
      expr: AVG(CAST(egi AS DOUBLE))
      comment: "Average effective gross income per approach — used to benchmark income after vacancy and credit loss adjustments."
    - name: "avg_total_opex"
      expr: AVG(CAST(total_opex AS DOUBLE))
      comment: "Average total operating expenses per approach — used to benchmark expense ratios and NOI margins."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`valuation_dcf_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DCF model KPIs covering investment returns, leverage metrics, cash flow projections, and sensitivity analysis. Used by investment committees, portfolio managers, and capital markets teams to evaluate deal economics and underwriting assumptions."
  source: "`real_estate_ecm`.`valuation`.`dcf_model`"
  dimensions:
    - name: "model_status"
      expr: model_status
      comment: "Current status of the DCF model (e.g. Draft, Approved, Archived) — used to filter active vs. historical models."
    - name: "model_purpose"
      expr: model_purpose
      comment: "Business purpose of the DCF model (e.g. Acquisition, Disposition, Refinancing, Annual Review) — drives use-case segmentation."
    - name: "methodology_standard"
      expr: methodology_standard
      comment: "Methodology standard applied (e.g. ARGUS, IVSC, USPAP) — used for compliance and cross-portfolio comparability."
    - name: "is_levered"
      expr: is_levered
      comment: "Flag indicating whether the model uses levered (debt-financed) returns — used to segment levered vs. unlevered analysis."
    - name: "hold_period_years"
      expr: hold_period_years
      comment: "Assumed holding period in years — used to segment models by investment horizon."
    - name: "hold_period_start_date"
      expr: DATE_TRUNC('year', hold_period_start_date)
      comment: "Year the hold period begins — used for vintage analysis and investment cycle tracking."
    - name: "valuation_date"
      expr: DATE_TRUNC('quarter', valuation_date)
      comment: "Quarter of the DCF valuation date — used for time-series trending of investment assumptions."
    - name: "argus_model_version"
      expr: argus_model_version
      comment: "Version of the ARGUS model used — used for model governance and audit trail management."
  measures:
    - name: "total_dcf_models"
      expr: COUNT(1)
      comment: "Total number of DCF models — baseline volume metric for underwriting pipeline tracking."
    - name: "avg_unlevered_irr"
      expr: AVG(CAST(unlevered_irr AS DOUBLE))
      comment: "Average unlevered IRR across DCF models — primary return metric for investment committee decisions on an all-equity basis."
    - name: "avg_levered_irr"
      expr: AVG(CAST(levered_irr AS DOUBLE))
      comment: "Average levered IRR across DCF models — measures equity return after debt service, used for leveraged investment decisions."
    - name: "avg_equity_multiple"
      expr: AVG(CAST(equity_multiple AS DOUBLE))
      comment: "Average equity multiple across models — measures total return on equity invested, a key LP and fund performance metric."
    - name: "avg_going_in_cap_rate"
      expr: AVG(CAST(going_in_cap_rate AS DOUBLE))
      comment: "Average going-in capitalization rate — reflects initial yield on acquisition price, used for deal pricing benchmarking."
    - name: "avg_terminal_cap_rate"
      expr: AVG(CAST(terminal_cap_rate AS DOUBLE))
      comment: "Average terminal cap rate — reflects exit yield assumptions, used to assess reversion risk."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate applied — reflects weighted average cost of capital assumptions across the portfolio."
    - name: "total_npv_at_discount_rate"
      expr: SUM(CAST(npv_at_discount_rate AS DOUBLE))
      comment: "Total NPV at the applied discount rate — aggregate measure of discounted investment value across the portfolio."
    - name: "avg_npv_at_discount_rate"
      expr: AVG(CAST(npv_at_discount_rate AS DOUBLE))
      comment: "Average NPV per DCF model — used to benchmark deal-level value creation."
    - name: "total_stabilized_noi"
      expr: SUM(CAST(stabilized_noi AS DOUBLE))
      comment: "Total stabilized NOI across models — represents aggregate income at full occupancy, used for portfolio income planning."
    - name: "avg_stabilized_noi"
      expr: AVG(CAST(stabilized_noi AS DOUBLE))
      comment: "Average stabilized NOI per model — used to benchmark income productivity across underwritten assets."
    - name: "total_year1_noi"
      expr: SUM(CAST(year1_noi AS DOUBLE))
      comment: "Total Year 1 NOI across models — represents near-term income expectations for the portfolio."
    - name: "avg_ltv_ratio"
      expr: AVG(CAST(ltv_ratio AS DOUBLE))
      comment: "Average loan-to-value ratio across levered models — key leverage metric for lender and risk management decisions."
    - name: "avg_min_dscr"
      expr: AVG(CAST(min_dscr AS DOUBLE))
      comment: "Average minimum debt service coverage ratio — critical lender covenant metric indicating debt repayment capacity."
    - name: "avg_avg_dscr"
      expr: AVG(CAST(avg_dscr AS DOUBLE))
      comment: "Average DSCR across the hold period — used to assess overall debt serviceability of the investment."
    - name: "avg_vacancy_rate_assumption"
      expr: AVG(CAST(vacancy_rate_assumption AS DOUBLE))
      comment: "Average vacancy rate assumption applied — reflects market occupancy expectations used in income projections."
    - name: "avg_rent_growth_rate"
      expr: AVG(CAST(rent_growth_rate AS DOUBLE))
      comment: "Average rent growth rate assumption — reflects market rental growth expectations used in cash flow projections."
    - name: "avg_expense_growth_rate"
      expr: AVG(CAST(expense_growth_rate AS DOUBLE))
      comment: "Average expense growth rate assumption — used to benchmark operating cost inflation assumptions across models."
    - name: "total_equity_investment"
      expr: SUM(CAST(equity_investment AS DOUBLE))
      comment: "Total equity capital deployed across modeled investments — used for capital allocation and fund deployment tracking."
    - name: "total_debt_amount"
      expr: SUM(CAST(debt_amount AS DOUBLE))
      comment: "Total debt capital across modeled investments — used for leverage and balance sheet exposure monitoring."
    - name: "avg_sensitivity_irr_high"
      expr: AVG(CAST(sensitivity_irr_high AS DOUBLE))
      comment: "Average upside IRR from sensitivity analysis — used to quantify return upside under favorable market conditions."
    - name: "avg_sensitivity_irr_low"
      expr: AVG(CAST(sensitivity_irr_low AS DOUBLE))
      comment: "Average downside IRR from sensitivity analysis — used to quantify return risk under adverse market conditions."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`valuation_cap_rate_benchmark`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cap rate benchmark KPIs tracking market yield levels, trends, and transaction volumes by property type, geography, and market segment. Used by investment strategists, portfolio managers, and research teams to monitor market pricing and inform acquisition/disposition decisions."
  source: "`real_estate_ecm`.`valuation`.`cap_rate_benchmark`"
  dimensions:
    - name: "benchmark_status"
      expr: benchmark_status
      comment: "Current status of the benchmark record (e.g. Active, Expired, Superseded) — used to filter current vs. historical benchmarks."
    - name: "source_organization"
      expr: source_organization
      comment: "Organization providing the benchmark data (e.g. CBRE, JLL, NCREIF, CoStar) — used for data source quality and provenance analysis."
    - name: "survey_frequency"
      expr: survey_frequency
      comment: "Frequency of the benchmark survey (e.g. Quarterly, Annual) — used for data freshness and temporal analysis."
    - name: "trend_direction"
      expr: trend_direction
      comment: "Direction of cap rate trend (e.g. Compressing, Expanding, Stable) — key market sentiment indicator for investment strategy."
    - name: "investor_sentiment"
      expr: investor_sentiment
      comment: "Investor sentiment classification (e.g. Bullish, Neutral, Bearish) — used for market cycle positioning."
    - name: "market_liquidity_rating"
      expr: market_liquidity_rating
      comment: "Liquidity rating of the market (e.g. High, Medium, Low) — used for risk assessment and exit strategy planning."
    - name: "is_institutional_grade"
      expr: is_institutional_grade
      comment: "Flag indicating whether the benchmark applies to institutional-grade assets — used to segment core vs. value-add markets."
    - name: "is_primary_benchmark"
      expr: is_primary_benchmark
      comment: "Flag indicating whether this is the primary benchmark for the market — used to filter authoritative benchmarks."
    - name: "effective_date"
      expr: DATE_TRUNC('quarter', effective_date)
      comment: "Quarter the benchmark became effective — used for time-series trending of market cap rates."
    - name: "survey_date"
      expr: DATE_TRUNC('quarter', survey_date)
      comment: "Quarter the survey was conducted — used for temporal alignment of benchmark data."
    - name: "survey_methodology"
      expr: survey_methodology
      comment: "Methodology used to derive the benchmark (e.g. Transaction-Based, Survey-Based) — used for data quality assessment."
  measures:
    - name: "total_benchmarks"
      expr: COUNT(1)
      comment: "Total number of cap rate benchmark records — baseline volume metric for market coverage analysis."
    - name: "avg_cap_rate_mid"
      expr: AVG(CAST(cap_rate_mid AS DOUBLE))
      comment: "Average mid-point cap rate across benchmarks — primary market yield indicator used for portfolio pricing and acquisition underwriting."
    - name: "avg_cap_rate_low"
      expr: AVG(CAST(cap_rate_low AS DOUBLE))
      comment: "Average low-end cap rate — represents the compressed (premium asset) end of the market yield range."
    - name: "avg_cap_rate_high"
      expr: AVG(CAST(cap_rate_high AS DOUBLE))
      comment: "Average high-end cap rate — represents the expanded (value-add/secondary) end of the market yield range."
    - name: "avg_cap_rate_prior_mid"
      expr: AVG(CAST(cap_rate_prior_mid AS DOUBLE))
      comment: "Average prior-period mid cap rate — used as baseline for period-over-period cap rate movement analysis."
    - name: "total_transaction_volume"
      expr: SUM(CAST(total_transaction_volume AS DOUBLE))
      comment: "Total transaction volume underlying the benchmarks — measures market liquidity and depth of evidence."
    - name: "avg_implied_value_psf_high"
      expr: AVG(CAST(implied_value_psf_high AS DOUBLE))
      comment: "Average implied value per square foot at the high end of the cap rate range — used for market pricing benchmarking."
    - name: "avg_implied_value_psf_low"
      expr: AVG(CAST(implied_value_psf_low AS DOUBLE))
      comment: "Average implied value per square foot at the low end of the cap rate range — used for market pricing benchmarking."
    - name: "avg_noi_psf_high"
      expr: AVG(CAST(noi_psf_high AS DOUBLE))
      comment: "Average NOI per square foot at the high end — used to benchmark income productivity across markets."
    - name: "avg_noi_psf_low"
      expr: AVG(CAST(noi_psf_low AS DOUBLE))
      comment: "Average NOI per square foot at the low end — used to benchmark income productivity across markets."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across benchmarks — used to assess reliability of market data for underwriting decisions."
    - name: "institutional_grade_benchmark_count"
      expr: SUM(CASE WHEN is_institutional_grade = TRUE THEN 1 ELSE 0 END)
      comment: "Count of institutional-grade benchmarks — used to assess coverage of core investment-grade markets."
    - name: "compressing_market_count"
      expr: SUM(CASE WHEN trend_direction = 'Compressing' THEN 1 ELSE 0 END)
      comment: "Count of markets with compressing cap rates — indicates markets with rising asset values and strong investor demand."
    - name: "expanding_market_count"
      expr: SUM(CASE WHEN trend_direction = 'Expanding' THEN 1 ELSE 0 END)
      comment: "Count of markets with expanding cap rates — indicates markets with declining asset values or reduced investor demand."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`valuation_comparable_sale`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Comparable sale KPIs tracking transaction prices, per-unit metrics, adjustments, and market conditions. Used by appraisers, brokers, and investment analysts to benchmark asset pricing, validate valuations, and monitor market transaction activity."
  source: "`real_estate_ecm`.`valuation`.`comparable_sale`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the comparable sale (e.g. Verified, Unverified, Rejected) — used to filter reliable comps."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify the sale (e.g. Deed Records, Broker Confirmation, CoStar) — used for data quality assessment."
    - name: "data_source"
      expr: data_source
      comment: "Source of the comparable sale data (e.g. CoStar, MLS, Public Records) — used for data provenance and quality analysis."
    - name: "financing_type"
      expr: financing_type
      comment: "Type of financing used in the transaction (e.g. Conventional, All-Cash, Seller-Financed) — used to assess market conditions adjustments."
    - name: "condition_rating"
      expr: condition_rating
      comment: "Physical condition rating of the comparable property — used for condition adjustment analysis."
    - name: "quality_rating"
      expr: quality_rating
      comment: "Quality rating of the comparable property — used for quality adjustment analysis."
    - name: "property_subtype"
      expr: property_subtype
      comment: "Property subtype of the comparable (e.g. Class A Office, Garden Apartment) — used for granular market segmentation."
    - name: "arms_length_flag"
      expr: arms_length_flag
      comment: "Flag indicating whether the transaction was at arm's length — used to filter market-representative transactions."
    - name: "distressed_sale_flag"
      expr: distressed_sale_flag
      comment: "Flag indicating whether the sale was distressed — used to exclude or separately analyze non-market transactions."
    - name: "sale_date"
      expr: DATE_TRUNC('quarter', sale_date)
      comment: "Quarter of the sale date — used for time-series trending of market transaction prices."
    - name: "state_province"
      expr: postal_code
      comment: "Postal code of the comparable property — used for geographic market segmentation."
  measures:
    - name: "total_comparable_sales"
      expr: COUNT(1)
      comment: "Total number of comparable sales — baseline volume metric for market transaction activity."
    - name: "total_sale_price"
      expr: SUM(CAST(sale_price AS DOUBLE))
      comment: "Total sale price across all comparable transactions — measures aggregate market transaction volume."
    - name: "avg_sale_price"
      expr: AVG(CAST(sale_price AS DOUBLE))
      comment: "Average sale price per comparable transaction — key market pricing benchmark for valuation support."
    - name: "avg_price_psf"
      expr: AVG(CAST(price_psf AS DOUBLE))
      comment: "Average price per square foot — primary per-unit pricing metric for market comparison and appraisal support."
    - name: "avg_adjusted_price_psf"
      expr: AVG(CAST(adjusted_price_psf AS DOUBLE))
      comment: "Average adjusted price per square foot after all comparability adjustments — used as the refined benchmark for subject property valuation."
    - name: "avg_adjusted_sale_price"
      expr: AVG(CAST(adjusted_sale_price AS DOUBLE))
      comment: "Average adjusted sale price after all comparability adjustments — used as the refined value indicator for subject property."
    - name: "avg_cap_rate_at_sale"
      expr: AVG(CAST(cap_rate_at_sale AS DOUBLE))
      comment: "Average cap rate at time of sale — reflects market yield at transaction, used for investment pricing benchmarking."
    - name: "avg_noi_at_sale"
      expr: AVG(CAST(noi_at_sale AS DOUBLE))
      comment: "Average NOI at time of sale — used to validate income assumptions in income approach valuations."
    - name: "avg_occupancy_rate_pct"
      expr: AVG(CAST(occupancy_rate_pct AS DOUBLE))
      comment: "Average occupancy rate at time of sale — used to assess stabilization status of comparable transactions."
    - name: "avg_gla_sqft"
      expr: AVG(CAST(gla_sqft AS DOUBLE))
      comment: "Average gross leasable area of comparable properties — used for size-based market segmentation."
    - name: "arms_length_transaction_count"
      expr: SUM(CASE WHEN arms_length_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of arm's-length transactions — used to assess the volume of market-representative evidence."
    - name: "distressed_sale_count"
      expr: SUM(CASE WHEN distressed_sale_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of distressed sales — used to monitor market stress and exclude non-representative transactions from valuation."
    - name: "avg_location_adjustment_pct"
      expr: AVG(CAST(location_adjustment_pct AS DOUBLE))
      comment: "Average location adjustment percentage applied — used to assess the magnitude of location-based comparability adjustments."
    - name: "avg_time_adjustment_pct"
      expr: AVG(CAST(time_adjustment_pct AS DOUBLE))
      comment: "Average time adjustment percentage applied — reflects market appreciation/depreciation trends used in sales comparison."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`valuation_comparable_lease`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Comparable lease KPIs tracking market rent levels, lease economics, and tenant improvement allowances. Used by appraisers, leasing teams, and portfolio managers to benchmark market rents, validate income assumptions, and support lease negotiations."
  source: "`real_estate_ecm`.`valuation`.`comparable_lease`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the comparable lease (e.g. Verified, Unverified) — used to filter reliable market evidence."
    - name: "data_source"
      expr: data_source
      comment: "Source of the comparable lease data (e.g. CoStar, Broker, Public Filing) — used for data quality and provenance analysis."
    - name: "rent_escalation_type"
      expr: rent_escalation_type
      comment: "Type of rent escalation (e.g. Fixed, CPI, Percentage) — used for income growth assumption benchmarking."
    - name: "city"
      expr: city
      comment: "City of the comparable lease property — used for geographic market segmentation."
    - name: "state_province"
      expr: state_province
      comment: "State or province of the comparable lease property — used for regional market analysis."
    - name: "expansion_option_flag"
      expr: expansion_option_flag
      comment: "Flag indicating whether the lease includes an expansion option — used to assess tenant flexibility and space demand."
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Flag indicating whether the lease includes a renewal option — used to assess lease rollover risk."
    - name: "lease_commencement_date"
      expr: DATE_TRUNC('quarter', lease_commencement_date)
      comment: "Quarter the lease commenced — used for time-series trending of market rent levels."
    - name: "lease_execution_date"
      expr: DATE_TRUNC('year', lease_execution_date)
      comment: "Year the lease was executed — used for vintage analysis of market rent trends."
  measures:
    - name: "total_comparable_leases"
      expr: COUNT(1)
      comment: "Total number of comparable lease records — baseline volume metric for market evidence coverage."
    - name: "avg_base_rent_psf"
      expr: AVG(CAST(base_rent_psf AS DOUBLE))
      comment: "Average base rent per square foot — primary market rent benchmark used in income approach valuations."
    - name: "avg_effective_rent_psf"
      expr: AVG(CAST(effective_rent_psf AS DOUBLE))
      comment: "Average effective rent per square foot after concessions — reflects true economic rent used for NOI underwriting."
    - name: "avg_adjusted_rent_psf"
      expr: AVG(CAST(adjusted_rent_psf AS DOUBLE))
      comment: "Average adjusted rent per square foot after all comparability adjustments — used as the refined market rent benchmark."
    - name: "avg_ti_allowance_psf"
      expr: AVG(CAST(ti_allowance_psf AS DOUBLE))
      comment: "Average tenant improvement allowance per square foot — key leasing cost metric for landlord economics and deal structuring."
    - name: "avg_free_rent_months"
      expr: AVG(CAST(free_rent_months AS DOUBLE))
      comment: "Average free rent concession in months — used to assess market concession levels and effective rent calculations."
    - name: "avg_cam_charges_psf"
      expr: AVG(CAST(cam_charges_psf AS DOUBLE))
      comment: "Average CAM charges per square foot — used to benchmark operating expense recovery and gross-up adjustments."
    - name: "avg_rent_escalation_rate"
      expr: AVG(CAST(rent_escalation_rate AS DOUBLE))
      comment: "Average rent escalation rate — reflects market rental growth assumptions used in income projections."
    - name: "avg_lease_size_sqf"
      expr: AVG(CAST(lease_size_sqf AS DOUBLE))
      comment: "Average lease size in square feet — used to benchmark deal size and tenant demand patterns."
    - name: "total_lease_size_sqf"
      expr: SUM(CAST(lease_size_sqf AS DOUBLE))
      comment: "Total leased square footage across comparable transactions — measures aggregate market absorption."
    - name: "avg_location_adjustment_pct"
      expr: AVG(CAST(location_adjustment_pct AS DOUBLE))
      comment: "Average location adjustment applied to comparable leases — used to assess location-based rent differentials."
    - name: "avg_time_adjustment_pct"
      expr: AVG(CAST(time_adjustment_pct AS DOUBLE))
      comment: "Average time adjustment applied — reflects market rent growth trends used in lease comparability analysis."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`valuation_nav_calculation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Net Asset Value (NAV) KPIs for real estate funds and portfolios covering gross asset value, net asset value, leverage, income metrics, and per-unit performance. Used by fund managers, investors, and boards to monitor fund performance, NAV per unit, and portfolio-level returns."
  source: "`real_estate_ecm`.`valuation`.`nav_calculation`"
  dimensions:
    - name: "calculation_status"
      expr: calculation_status
      comment: "Status of the NAV calculation (e.g. Draft, Final, Published) — used to filter authoritative vs. preliminary calculations."
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period label (e.g. Q1 2024, FY 2023) — used for period-over-period NAV comparison."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year — used for annual NAV trending and year-over-year performance analysis."
    - name: "valuation_methodology"
      expr: valuation_methodology
      comment: "Methodology used for NAV calculation (e.g. Appraisal-Based, DCF, Market Comparable) — used for methodology consistency monitoring."
    - name: "fair_value_hierarchy_level"
      expr: fair_value_hierarchy_level
      comment: "Fair value hierarchy level (Level 1, 2, or 3) per ASC 820/IFRS 13 — critical for financial reporting and audit compliance."
    - name: "is_audited"
      expr: is_audited
      comment: "Flag indicating whether the NAV calculation has been audited — used for investor reporting and regulatory compliance."
    - name: "is_published"
      expr: is_published
      comment: "Flag indicating whether the NAV has been published to investors — used for investor relations and disclosure tracking."
    - name: "calculation_date"
      expr: DATE_TRUNC('quarter', calculation_date)
      comment: "Quarter of the NAV calculation — used for time-series trending of fund NAV."
    - name: "third_party_appraiser"
      expr: third_party_appraiser
      comment: "Name of the third-party appraiser used — used for appraiser independence and governance monitoring."
  measures:
    - name: "total_nav_calculations"
      expr: COUNT(1)
      comment: "Total number of NAV calculations — baseline volume metric for reporting cycle tracking."
    - name: "total_net_asset_value"
      expr: SUM(CAST(net_asset_value AS DOUBLE))
      comment: "Total net asset value across all calculations — primary fund size metric used by investors and fund managers."
    - name: "avg_net_asset_value"
      expr: AVG(CAST(net_asset_value AS DOUBLE))
      comment: "Average NAV per calculation — used to benchmark fund size across reporting periods."
    - name: "total_gross_asset_value"
      expr: SUM(CAST(gross_asset_value AS DOUBLE))
      comment: "Total gross asset value across all calculations — represents total portfolio value before debt deduction."
    - name: "avg_nav_per_unit"
      expr: AVG(CAST(nav_per_unit AS DOUBLE))
      comment: "Average NAV per unit/share — primary investor performance metric used for fund pricing and redemption calculations."
    - name: "total_nav_change"
      expr: SUM(CAST(nav_change AS DOUBLE))
      comment: "Total NAV change across reporting periods — measures aggregate value creation or destruction in the portfolio."
    - name: "total_aum"
      expr: SUM(CAST(aum AS DOUBLE))
      comment: "Total assets under management — primary fund scale metric used for fee calculation and investor reporting."
    - name: "total_noi"
      expr: SUM(CAST(noi_total AS DOUBLE))
      comment: "Total NOI across all NAV calculations — measures aggregate income generation of the portfolio."
    - name: "total_ffo"
      expr: SUM(CAST(ffo AS DOUBLE))
      comment: "Total Funds From Operations — primary REIT and real estate fund performance metric used by investors and analysts."
    - name: "avg_ffo"
      expr: AVG(CAST(ffo AS DOUBLE))
      comment: "Average FFO per calculation — used to benchmark fund income performance across periods."
    - name: "total_affo"
      expr: SUM(CAST(affo AS DOUBLE))
      comment: "Total Adjusted Funds From Operations — refined income metric accounting for recurring capex, used for dividend sustainability analysis."
    - name: "avg_weighted_avg_cap_rate"
      expr: AVG(CAST(weighted_avg_cap_rate AS DOUBLE))
      comment: "Average weighted average cap rate across NAV calculations — reflects portfolio-level yield used for pricing and benchmarking."
    - name: "avg_ltv_ratio"
      expr: AVG(CAST(ltv_ratio AS DOUBLE))
      comment: "Average loan-to-value ratio — key leverage metric used by lenders, investors, and risk managers."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate applied in NAV calculations — reflects cost of capital assumptions used in fund valuation."
    - name: "total_total_debt_outstanding"
      expr: SUM(CAST(total_debt_outstanding AS DOUBLE))
      comment: "Total debt outstanding across all NAV calculations — used for leverage monitoring and covenant compliance."
    - name: "total_cash_and_equivalents"
      expr: SUM(CAST(cash_and_equivalents AS DOUBLE))
      comment: "Total cash and equivalents held — used for liquidity management and redemption capacity analysis."
    - name: "audited_calculation_count"
      expr: SUM(CASE WHEN is_audited = TRUE THEN 1 ELSE 0 END)
      comment: "Count of audited NAV calculations — used for governance and investor confidence monitoring."
    - name: "published_calculation_count"
      expr: SUM(CASE WHEN is_published = TRUE THEN 1 ELSE 0 END)
      comment: "Count of published NAV calculations — used for investor disclosure and reporting cycle tracking."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`valuation_tax_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property tax assessment KPIs tracking assessed values, tax liabilities, appeal outcomes, and abatements. Used by asset managers, finance teams, and tax counsel to monitor tax exposure, manage appeals, and optimize tax recovery strategies."
  source: "`real_estate_ecm`.`valuation`.`tax_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the tax assessment (e.g. Preliminary, Final, Under Appeal) — used to filter active vs. resolved assessments."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any filed appeal (e.g. Filed, Pending, Settled, Withdrawn) — used to track appeal pipeline and outcomes."
    - name: "assessment_year"
      expr: assessment_year
      comment: "Tax assessment year — used for year-over-year tax liability trending."
    - name: "jurisdiction_type"
      expr: jurisdiction_type
      comment: "Type of taxing jurisdiction (e.g. County, Municipal, State) — used for multi-jurisdictional tax analysis."
    - name: "exemption_type"
      expr: exemption_type
      comment: "Type of tax exemption applied (e.g. Homestead, Non-Profit, PILOT) — used for exemption program monitoring."
    - name: "property_class_code"
      expr: property_class_code
      comment: "Assessor property class code — used for tax classification and rate analysis."
    - name: "is_nnn_tenant_recoverable"
      expr: is_nnn_tenant_recoverable
      comment: "Flag indicating whether the tax is recoverable from NNN tenants — used for net lease income analysis."
    - name: "notice_date"
      expr: DATE_TRUNC('year', notice_date)
      comment: "Year the assessment notice was issued — used for assessment cycle tracking."
  measures:
    - name: "total_tax_assessments"
      expr: COUNT(1)
      comment: "Total number of tax assessment records — baseline volume metric for portfolio tax exposure tracking."
    - name: "total_assessed_value"
      expr: SUM(CAST(total_assessed_value AS DOUBLE))
      comment: "Total assessed value across all properties — represents the aggregate tax base of the portfolio."
    - name: "avg_assessed_value"
      expr: AVG(CAST(total_assessed_value AS DOUBLE))
      comment: "Average assessed value per property — used to benchmark assessment levels and identify over-assessed assets."
    - name: "total_gross_annual_tax"
      expr: SUM(CAST(gross_annual_tax AS DOUBLE))
      comment: "Total gross annual property tax liability — primary tax cost metric for budget planning and NOI calculation."
    - name: "total_net_annual_tax"
      expr: SUM(CAST(net_annual_tax AS DOUBLE))
      comment: "Total net annual property tax after abatements and exemptions — represents actual tax cash outflow for the portfolio."
    - name: "avg_effective_tax_rate"
      expr: AVG(CAST(effective_tax_rate AS DOUBLE))
      comment: "Average effective tax rate across assessments — used to benchmark tax burden and identify high-tax jurisdictions."
    - name: "avg_millage_rate"
      expr: AVG(CAST(millage_rate AS DOUBLE))
      comment: "Average millage rate across jurisdictions — used to compare tax rates and assess jurisdictional tax competitiveness."
    - name: "total_abatement_amount"
      expr: SUM(CAST(abatement_amount AS DOUBLE))
      comment: "Total tax abatement value across the portfolio — measures the economic benefit of tax incentive programs."
    - name: "total_exemption_amount"
      expr: SUM(CAST(exemption_amount AS DOUBLE))
      comment: "Total tax exemption value across the portfolio — measures the economic benefit of exemption programs."
    - name: "total_implied_market_value"
      expr: SUM(CAST(implied_market_value AS DOUBLE))
      comment: "Total implied market value derived from tax assessments — used to compare assessor-implied values against appraised values."
    - name: "avg_assessment_ratio"
      expr: AVG(CAST(assessment_ratio AS DOUBLE))
      comment: "Average assessment ratio (assessed value / market value) — used to identify under- or over-assessed properties for appeal targeting."
    - name: "total_appeal_settled_value"
      expr: SUM(CAST(appeal_settled_value AS DOUBLE))
      comment: "Total settled value from successful tax appeals — measures the financial benefit of the tax appeal program."
    - name: "total_appeal_target_value"
      expr: SUM(CAST(appeal_target_value AS DOUBLE))
      comment: "Total target value sought in pending appeals — represents the potential tax savings pipeline."
    - name: "avg_tax_psf"
      expr: AVG(CAST(tax_psf AS DOUBLE))
      comment: "Average tax per square foot — used to benchmark tax burden on a per-unit basis for lease expense recovery analysis."
    - name: "properties_under_appeal_count"
      expr: SUM(CASE WHEN appeal_status IN ('Filed', 'Pending') THEN 1 ELSE 0 END)
      comment: "Count of properties with active tax appeals — used to monitor the appeal pipeline and resource allocation."
    - name: "nnn_recoverable_count"
      expr: SUM(CASE WHEN is_nnn_tenant_recoverable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assessments where tax is NNN tenant-recoverable — used to assess tax recovery exposure in net lease portfolios."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`valuation_bpo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broker Price Opinion (BPO) KPIs tracking opinion values, repair costs, market conditions, and engagement economics. Used by asset managers, lenders, and servicers to monitor portfolio valuations, repair exposure, and BPO vendor performance."
  source: "`real_estate_ecm`.`valuation`.`bpo`"
  dimensions:
    - name: "bpo_status"
      expr: bpo_status
      comment: "Current status of the BPO (e.g. Ordered, Completed, Cancelled) — used to filter active vs. closed engagements."
    - name: "bpo_type"
      expr: bpo_type
      comment: "Type of BPO (e.g. Drive-By, Interior, Desk Review) — used for methodology and cost benchmarking."
    - name: "review_status"
      expr: review_status
      comment: "Review status of the BPO (e.g. Pending, Approved, Rejected) — used for quality control workflow tracking."
    - name: "market_trend"
      expr: market_trend
      comment: "Market trend observed by the broker (e.g. Improving, Stable, Declining) — used for market condition monitoring."
    - name: "occupancy_status"
      expr: occupancy_status
      comment: "Occupancy status of the subject property (e.g. Occupied, Vacant, REO) — used for asset condition segmentation."
    - name: "property_condition"
      expr: property_condition
      comment: "Physical condition of the property (e.g. Good, Fair, Poor) — used for repair cost and value adjustment analysis."
    - name: "is_rush_order"
      expr: is_rush_order
      comment: "Flag indicating whether the BPO was a rush order — used for SLA and cost premium analysis."
    - name: "effective_date"
      expr: DATE_TRUNC('quarter', effective_date)
      comment: "Quarter the BPO became effective — used for time-series trending of broker opinion values."
    - name: "broker_company_name"
      expr: broker_company_name
      comment: "Name of the broker company providing the BPO — used for vendor performance and concentration analysis."
    - name: "broker_license_state"
      expr: broker_license_state
      comment: "State where the broker is licensed — used for geographic coverage and compliance monitoring."
  measures:
    - name: "total_bpos"
      expr: COUNT(1)
      comment: "Total number of BPO engagements — baseline volume metric for valuation pipeline tracking."
    - name: "total_opinion_value"
      expr: SUM(CAST(opinion_value AS DOUBLE))
      comment: "Total broker opinion value across all BPOs — represents aggregate portfolio value as estimated by brokers."
    - name: "avg_opinion_value"
      expr: AVG(CAST(opinion_value AS DOUBLE))
      comment: "Average broker opinion value per BPO — used to benchmark asset values and detect outliers."
    - name: "avg_quick_sale_value"
      expr: AVG(CAST(quick_sale_value AS DOUBLE))
      comment: "Average quick sale value — represents liquidation value used for distressed asset and REO portfolio management."
    - name: "avg_as_repaired_value"
      expr: AVG(CAST(as_repaired_value AS DOUBLE))
      comment: "Average as-repaired value — represents post-renovation value used for rehab investment decisions."
    - name: "avg_recommended_list_price"
      expr: AVG(CAST(recommended_list_price AS DOUBLE))
      comment: "Average recommended list price — used to benchmark broker pricing recommendations against opinion values."
    - name: "total_repair_cost_estimate"
      expr: SUM(CAST(repair_cost_estimate AS DOUBLE))
      comment: "Total estimated repair costs across all BPOs — used for capital planning and rehab budget forecasting."
    - name: "avg_repair_cost_estimate"
      expr: AVG(CAST(repair_cost_estimate AS DOUBLE))
      comment: "Average repair cost estimate per BPO — used to benchmark property condition and maintenance exposure."
    - name: "total_engagement_fees"
      expr: SUM(CAST(engagement_fee AS DOUBLE))
      comment: "Total BPO engagement fees — used for vendor cost management and budget tracking."
    - name: "avg_engagement_fee"
      expr: AVG(CAST(engagement_fee AS DOUBLE))
      comment: "Average BPO engagement fee — used to benchmark BPO costs and negotiate vendor contracts."
    - name: "total_value_range_high"
      expr: SUM(CAST(value_range_high AS DOUBLE))
      comment: "Sum of upper-bound value estimates — represents the optimistic ceiling of total BPO portfolio value."
    - name: "total_value_range_low"
      expr: SUM(CAST(value_range_low AS DOUBLE))
      comment: "Sum of lower-bound value estimates — represents the conservative floor of total BPO portfolio value."
    - name: "rush_order_count"
      expr: SUM(CASE WHEN is_rush_order = TRUE THEN 1 ELSE 0 END)
      comment: "Count of rush BPO orders — used to monitor expedited engagement volume and associated cost premiums."
    - name: "distinct_broker_companies"
      expr: COUNT(DISTINCT broker_company_name)
      comment: "Number of distinct broker companies engaged — used for vendor diversity and concentration risk monitoring."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`valuation_cma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Comparative Market Analysis (CMA) KPIs tracking market conditions, pricing recommendations, absorption rates, and comparable evidence. Used by brokers, listing agents, and asset managers to support pricing decisions, monitor market conditions, and evaluate listing strategies."
  source: "`real_estate_ecm`.`valuation`.`cma`"
  dimensions:
    - name: "cma_status"
      expr: cma_status
      comment: "Current status of the CMA (e.g. Draft, Delivered, Expired) — used to filter active vs. historical analyses."
    - name: "market_condition"
      expr: market_condition
      comment: "Market condition classification (e.g. Seller's Market, Buyer's Market, Balanced) — used for market cycle analysis."
    - name: "market_trend"
      expr: market_trend
      comment: "Market trend direction (e.g. Appreciating, Stable, Declining) — used for pricing strategy and investment timing decisions."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Recommended pricing strategy (e.g. Aggressive, Market, Conservative) — used for listing strategy analysis."
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of CMA engagement (e.g. Listing, Acquisition, Portfolio Review) — used for use-case segmentation."
    - name: "is_uspap_compliant"
      expr: is_uspap_compliant
      comment: "Flag indicating USPAP compliance of the CMA — used for regulatory and lender compliance tracking."
    - name: "analysis_date"
      expr: DATE_TRUNC('quarter', analysis_date)
      comment: "Quarter the CMA was performed — used for time-series trending of market conditions."
    - name: "mls_area_code"
      expr: mls_area_code
      comment: "MLS area code — used for geographic market segmentation aligned with MLS reporting."
  measures:
    - name: "total_cmas"
      expr: COUNT(1)
      comment: "Total number of CMAs performed — baseline volume metric for market analysis activity."
    - name: "avg_recommended_list_price"
      expr: AVG(CAST(recommended_list_price AS DOUBLE))
      comment: "Average recommended list price — primary pricing output metric used by listing agents and asset managers."
    - name: "avg_concluded_value_high"
      expr: AVG(CAST(concluded_value_high AS DOUBLE))
      comment: "Average upper-bound concluded value — represents the optimistic pricing ceiling used in listing strategy."
    - name: "avg_concluded_value_low"
      expr: AVG(CAST(concluded_value_low AS DOUBLE))
      comment: "Average lower-bound concluded value — represents the conservative pricing floor used in listing strategy."
    - name: "avg_absorption_rate"
      expr: AVG(CAST(absorption_rate AS DOUBLE))
      comment: "Average market absorption rate — measures how quickly properties are selling, used for market timing and pricing decisions."
    - name: "avg_months_of_supply"
      expr: AVG(CAST(months_of_supply AS DOUBLE))
      comment: "Average months of supply — key market balance indicator used to classify buyer vs. seller market conditions."
    - name: "avg_list_to_sale_ratio"
      expr: AVG(CAST(list_to_sale_ratio AS DOUBLE))
      comment: "Average list-to-sale price ratio — measures pricing accuracy and negotiation dynamics in the market."
    - name: "avg_comparable_search_radius_miles"
      expr: AVG(CAST(comparable_search_radius_miles AS DOUBLE))
      comment: "Average comparable search radius in miles — used to assess market depth and comparable evidence availability."
    - name: "avg_avg_comparable_psf"
      expr: AVG(CAST(avg_comparable_psf AS DOUBLE))
      comment: "Average comparable price per square foot — used to benchmark market pricing levels across geographies."
    - name: "uspap_compliant_count"
      expr: SUM(CASE WHEN is_uspap_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of USPAP-compliant CMAs — used for regulatory compliance and lender panel requirements."
$$;